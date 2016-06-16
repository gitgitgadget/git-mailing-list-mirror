Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529471FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 21:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbcFPVLM (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 17:11:12 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58226 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754006AbcFPVLJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2016 17:11:09 -0400
X-AuditID: 1207440f-8a7ff700000008e4-b7-576315e44f95
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 6C.19.02276.4E513675; Thu, 16 Jun 2016 17:11:00 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFDE.dip0.t-ipconnect.de [80.142.175.222])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5GLAvQl003271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 16 Jun 2016 17:10:59 -0400
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
To:	Stefan Beller <sbeller@google.com>, peff@peff.net
References: <20160616174620.1011-1-sbeller@google.com>
Cc:	git@vger.kernel.org, jacob.keller@gmail.com
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <576315E1.2050405@alum.mit.edu>
Date:	Thu, 16 Jun 2016 23:10:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160616174620.1011-1-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqPtENDnc4OgkOYuuK91MFrsX9zNb
	/GjpYbbYvLmdxYHFY+esu+weCzaVejzr3cPo8XmTXABLFLdNUmJJWXBmep6+XQJ3xrrvzewF
	E3Qqjr7ewtLAuEq+i5GTQ0LAROLS4f3MXYxcHEICWxklLt38xw7hXGCS+DPzJwtIlbBAhMSV
	o48YQWwRAVOJk33NzCC2kICZRMerJ2BxZgF9iUlHn7OC2GwCuhKLepqZQGxeAW2JHWv7geIc
	HCwCqhIrd+SBhEUFQiTOr9vKClEiKHFy5hOwVZwC5hK/ZnawQ4zUk9hx/RcrhC0vsf3tHOYJ
	jPyzkLTMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxghYcu/
	g7FrvcwhRgEORiUe3hXAcBZiTSwrrsw9xCjJwaQkyvvza1K4EF9SfkplRmJxRnxRaU5q8SFG
	CQ5mJRHeBcJA5bwpiZVVqUX5MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4lCd6XIkCN
	gkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aCIjC8GxiRIigdo7z2Qdt7igsRcoChE
	6ylGY45li66vZeI4sv/eWiYhlrz8vFQpcd50kFIBkNKM0jy4RbCE9YpRHOhvYV51kL95gMkO
	bt4roFVMQKtspseDrCpJREhJNTD6n7z+74bkjmp/a6a/32bH65gxv2xVKGa0z7U+UvvIx7l3
	XYgz2+ZWtmhDxYp+kZlNRteDzedYvYz4o5LHe5RFVj9+unmuXjVf9hTPMKX6oD3Mh54tXKXy
	wOxIx8y3F3NuSVy5Xl6qdFs24+1vZR5pazvvN7/miJSUlBwVUL2c+cvolfUdFSWW4oxEQy3m
	ouJEABGRi68zAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/16/2016 07:46 PM, Stefan Beller wrote:
> The compaction heuristic for diffs was deemed quite good, but in 5580b27
> we have an example demonstrates a common case, that fails with the existing
> heuristic. That is why we disabled the heuristic in the v2.9.0 release.
> 
> With this patch a diff looks like:
> 
>          def bar
>                  do_bar_stuff()
> 
>                  common_ending()
>          end
> 
> +        def bal
> +                do_bal_stuff()
> +
> +                common_ending()
> +        end
> +
>          def baz
>                  do_baz_stuff()
> 
>                  common_ending()
>          end
> 
> whereas before we had:
> 
>   WIP (TODO: ask peff to provide an example that actually triggers, I seem to be
>        unable to write one, though I thought the above was one)
> 
> 
> The way we do it, is by inspecting the neighboring lines and see how
> much indent there is and we choose the line that has the shortest amount
> of blanks in the neighboring lines.
> 
> (TODO: update comments in the file)
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Hi Jeff, hi Michael,
> 
> thanks for pointing out the flaw in this ruby code base before the 2.9 release.
> I think this patch would fix your finding, though I cannot reproduce it.
> Can you provide an example repo/patch that looks ugly on current origin/master,
> so I can be sure this fixes the issue?
> 
> This can also be a start of a discussion if this is a too short-sighted enhancement
> of the heuristic. Essentially we'd want to prefer 
> 
> +        end
> +
> +        def bal
> 
> over:
> 
> +                do_bal_stuff()
> +
> +                common_ending()
> 
> because there is less space between line start and {end, def bal}
> than for {do_bal_stuff, common_ending}.

It's really cool that you are trying to implement the indentation
heuristic. I'm curious how it works in practice (something we can
probably only determine by applying it to a corpus of diffs to see how
often it outperforms/underperforms the other possible approaches).

The heuristic I proposed was

* Prefer to start and end hunks *following* lines with the least
  indentation.

* Define the "indentation" of a blank line to be the indentation of
  the previous non-blank line minus epsilon.

* In the case of a tie, prefer to slide the hunk down as far as
  possible.

If that's what you are trying to implement, then notice that the first
rule says that the hunk should start *following* the line with the least
indentation. So the "score" for

> +        end
> +
> +        def bal

would be the indentation of the line preceding "end", which is larger
than the indentation of "end". And the score for

> +                do_bal_stuff()
> +
> +                common_ending()

would come from the line preceding "do_bal_stuff()", namely "def bal()",
which is indented the same as "end". So the latter would be preferred.

But actually, I don't understand how your example is meaningful. I think
this heuristic is only used to slide hunks around; i.e., when the line
following the hunk is the same as the first lines of the hunk, or when
the line preceding the hunk is the same as the last line of the hunk.
Right? So your snippets would never compete against each other. Let's
take the full example. The five possible placements for the `+`
characters are marked with the digits 1 through 5 here:

>              def bar
>                      do_bar_stuff()
> 1
> 12                   common_ending()
> 123          end
> 1234
> 12345        def bal
> 12345                do_bal_stuff()
>  2345
>   345                common_ending()
>    45        end
>     5
>              def baz
>                      do_baz_stuff()
>
>                      common_ending()
>              end

Of the lines preceding the candidate hunks, the blank line preceding the
hunk marked "5" has the smallest indent, namely "epsilon" less than the
indentation of the "end" line preceding it. So placement "5" would be
chosen.

I don't know enough about this area of the code to review your patch in
detail, but I did note below a typo that jumped out at me.

Michael

>  xdiff/xdiffi.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index b3c6848..58adc74 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> [...]
> @@ -485,7 +515,13 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  			 * the group.
>  			 */
>  			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
> -				blank_lines += is_blank_line(recs, ix, flags);
> +				if (is_blank_line(recs, ix, flags)) {
> +					unsigned int bl_neigh_indent =
> +						surrounding_leading_blank(recs, ix, flags, nrec);
> +					if (min_bl_neigh_indent > bl_neigh_indent)
> +						min_bl_neigh_indent = min_bl_neigh_indent;

The line above has no effect (same variable on both sides of the =).

> +					blank_lines++;
> +				}
>  
>  				rchg[ixs++] = 0;
>  				rchg[ix++] = 1;
> @@ -525,6 +561,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
>  			while (ixs > 0 &&
>  			       !is_blank_line(recs, ix - 1, flags) &&
> +			       surrounding_leading_blank(recs, ix - 1, flags, nrec) > min_bl_neigh_indent &&
>  			       recs_match(recs, ixs - 1, ix - 1, flags)) {
>  				rchg[--ixs] = 1;
>  				rchg[--ix] = 0;
> 

