#' Identify intersecting intervals within a specified distance
#' 
#' @param ... params for bed_slop and bed_intersect
#' @inheritParams bed_slop
#' @inheritParams bed_intersect
#' 
#' @examples
#' x <- tibble::frame_data(
#'   ~chrom, ~start, ~end,
#'   "chr1", 10,    100,
#'   "chr2", 200,    400,
#'   "chr2", 300,    500,
#'   "chr2", 800,    900
#' )
#' 
#' y <- tibble::frame_data(
#'   ~chrom, ~start, ~end,
#'   "chr1", 150,    400,
#'   "chr2", 230,    430,
#'   "chr2", 350,    430
#' )
#' 
#' genome <- tibble::frame_data(
#'   ~chrom, ~size,
#'   "chr1", 500,
#'   "chr2", 1000
#' )
#' 
#' bed_window(x, y, genome, both = 100)
#' 
#' @seealso \url{http://bedtools.readthedocs.org/en/latest/content/tools/window.html}
#'  
#' @export
bed_window <- function(x, y, genome, ...) {

  x <- dplyr::mutate(x, .start = start, .end = end)
  
  slop_x <- bed_slop(x, genome, ...)
  
  res <- bed_intersect(slop_x, y, ...)
  
  res <- dplyr::mutate(res, start.x = .start.x, end.x = .end.x)
  
  res <- dplyr::ungroup(res)
  
  res <- dplyr::select(res, -.start.x, -.end.x)
  
  res
}