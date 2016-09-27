Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7175D20986
	for <e@80x24.org>; Tue, 27 Sep 2016 16:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934361AbcI0QW3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 12:22:29 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33378 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934311AbcI0QW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 12:22:28 -0400
Received: by mail-io0-f172.google.com with SMTP id r145so21040593ior.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qFSxOq7MhptL8P1sgxdOObS5OgVF2HL9vfVj+Q7j/Yk=;
        b=lxAp7D3dF4C0S0BNLm4vR76lv8o8Dm1yeCezy4RAExMUl7hB8kigBPGdmcVsY61utb
         3lVmSgwZFYqPxUM4XnX7Qo/IGMvapuvQMY4zjZyLmEYNjJyERmboUQHrx/TtcskSOJHg
         RvIuXoAD3Nvn53trbHNW0RQ1hAbF5zFjdHRDrNgVuT65j4MQGi3iv4nnWlZzeNfiDaVH
         9onaGqVB0GJbskHCkWxzLN8NbbY+DLnll4kj/vi2tDomvUTuBD+IkvU6CaONZcgZcjXm
         KkuYciDeLoQJi49OaHnFKor/41jyruKfWiayTkIwS+fwwboIXl+REnbqwZblNgOFEG/w
         l7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qFSxOq7MhptL8P1sgxdOObS5OgVF2HL9vfVj+Q7j/Yk=;
        b=M7g1e0hAfHjC8YjOK7ps7CoZEeNtLamiLz1Lbja9ffHgnQcOJ+UNavmxe69eI5w3yo
         m336ytD3IbQht7H3o71tdNwaTFpORIxk+3bfbn7gYozc4gB2LbRYm8viyHc1mIdpxvDo
         1axhuXV3IrLtHk1WAWajQBeKx291LuVVWmjI5gB55a4Ud07EwTV74OPKm1jNGwUOg7Pb
         0zU8ZiNzeSMF5ksD1MCh7GUKJKdPIFa+7P505+hTVfAdppzCUft23Kwnrtq7CBZpNcZz
         Vms/++Rhh3gwh9PmMQtyQbYg5WkmQfnwE9R14QkCT75CGlr73egYqwmFOWTYSquQN5iH
         iKiw==
X-Gm-Message-State: AE9vXwNbFNiuj7U0xVNqjExabNlGR1x0mF5sPg1pYUnE+la90FGP4/KR/uK5zGha3wAUnowJSl2Q6lJeXWjPQlPM
X-Received: by 10.107.59.199 with SMTP id i190mr29714623ioa.18.1474993347450;
 Tue, 27 Sep 2016 09:22:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 27 Sep 2016 09:22:27 -0700 (PDT)
In-Reply-To: <20160927043733.u3emlanbipu2cn5h@sigill.intra.peff.net>
References: <20160927043733.u3emlanbipu2cn5h@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Sep 2016 09:22:27 -0700
Message-ID: <CAGZ79kaeFWUAZ=oxxY2tqUMYL1NF8WBYk69AN1ncyuHyJh5HKg@mail.gmail.com>
Subject: Re: [PATCH] xdiff: rename "struct group" to "struct xdlgroup"
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 9:37 PM, Jeff King <peff@peff.net> wrote:
> Commit e8adf23 (xdl_change_compact(): introduce the concept
> of a change group, 2016-08-22) added a "struct group" type
> to xdiff/xdiffi.c. But the POSIX system header "grp.h"
> already defines "struct group" (it is part of the getgrnam
> interface). This happens to work because the new type is
> local to xdiffi.c, and the xdiff code includes a relatively
> small set of system headers. But it will break compilation
> if xdiff ever switches to using git-compat-util.h.  It can
> also probably cause confusion with tools that look at the
> whole code base, like coccinelle or ctags.
>
> Let's resolve by giving the xdiff variant a scoped name,
> which is closer to other xdiff types anyway (e.g.,
> xdlfile_t, though note that xdiff is fond if typedefs when
> Git usually is not).

Makes sense!

Thanks,
Stefan

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I didn't rename the functions, which have no conflict, but that would
> also be closer to xdiff's usual style. I don't know how far it is worth
> going; maybe this patch is even already too far.
>
> I noticed because I have a patch series which switches xdiff
> to git-compat-util, to try to use the st_* macros there.
>
>  xdiff/xdiffi.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 67c1ccc..760fbb6 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -708,7 +708,7 @@ static int score_cmp(struct split_score *s1, struct split_score *s2)
>   * Note that loops that are testing for changed lines in xdf->rchg do not need
>   * index bounding since the array is prepared with a zero at position -1 and N.
>   */
> -struct group {
> +struct xdlgroup {
>         /*
>          * The index of the first changed line in the group, or the index of
>          * the unchanged line above which the (empty) group is located.
> @@ -725,7 +725,7 @@ struct group {
>  /*
>   * Initialize g to point at the first group in xdf.
>   */
> -static void group_init(xdfile_t *xdf, struct group *g)
> +static void group_init(xdfile_t *xdf, struct xdlgroup *g)
>  {
>         g->start = g->end = 0;
>         while (xdf->rchg[g->end])
> @@ -736,7 +736,7 @@ static void group_init(xdfile_t *xdf, struct group *g)
>   * Move g to describe the next (possibly empty) group in xdf and return 0. If g
>   * is already at the end of the file, do nothing and return -1.
>   */
> -static inline int group_next(xdfile_t *xdf, struct group *g)
> +static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
>  {
>         if (g->end == xdf->nrec)
>                 return -1;
> @@ -752,7 +752,7 @@ static inline int group_next(xdfile_t *xdf, struct group *g)
>   * Move g to describe the previous (possibly empty) group in xdf and return 0.
>   * If g is already at the beginning of the file, do nothing and return -1.
>   */
> -static inline int group_previous(xdfile_t *xdf, struct group *g)
> +static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
>  {
>         if (g->start == 0)
>                 return -1;
> @@ -769,7 +769,7 @@ static inline int group_previous(xdfile_t *xdf, struct group *g)
>   * following group, expand this group to include it. Return 0 on success or -1
>   * if g cannot be slid down.
>   */
> -static int group_slide_down(xdfile_t *xdf, struct group *g, long flags)
> +static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g, long flags)
>  {
>         if (g->end < xdf->nrec &&
>             recs_match(xdf->recs[g->start], xdf->recs[g->end], flags)) {
> @@ -790,7 +790,7 @@ static int group_slide_down(xdfile_t *xdf, struct group *g, long flags)
>   * into a previous group, expand this group to include it. Return 0 on success
>   * or -1 if g cannot be slid up.
>   */
> -static int group_slide_up(xdfile_t *xdf, struct group *g, long flags)
> +static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g, long flags)
>  {
>         if (g->start > 0 &&
>             recs_match(xdf->recs[g->start - 1], xdf->recs[g->end - 1], flags)) {
> @@ -818,7 +818,7 @@ static void xdl_bug(const char *msg)
>   * size.
>   */
>  int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
> -       struct group g, go;
> +       struct xdlgroup g, go;
>         long earliest_end, end_matching_other;
>         long groupsize;
>         unsigned int blank_lines;
> --
> 2.10.0.492.g14f803f
