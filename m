Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844C01F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030242AbeFSRpB (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:45:01 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36382 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeFSRpA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:45:00 -0400
Received: by mail-ot0-f194.google.com with SMTP id c15-v6so638471otl.3
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7m2v0Afk5bzxLm8EKHSF/jh22MLfEVJX+PmyZdySFCE=;
        b=N2I1s4LVt6RHZhuDaNxvW3SQoUyhIMJy9I6pFWHvhgmwLLJ0ajmd8RWD6BVhxxjn8x
         wkLwSwLjUgOnZfGPjBCUtOL8uTJ5VDuWYRZ3oE7/O8htVsKz30NAYh0deC88DCKdK8kF
         G1ewDvSveN65q+CAQZZleHT+Xn05Fx2QSkT/ox/aqoJxzncRhdJp7EmKCj7ZD1C33lDR
         uF81x/c9qCytPZSShIUgwvoA8tprJBB1UwSnBfXVsjigTqhMkjSiN7CHDFI/yqjRGOK4
         YvopmLw7wLShjMLwdH7pXSI4wxEhl94ZT/QRFOEcMhK5lModnWhI6fiuDUYAvDqJIqhR
         Mnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7m2v0Afk5bzxLm8EKHSF/jh22MLfEVJX+PmyZdySFCE=;
        b=SXpThLA0yhLFJLlIocc8Yy8rLTHbf4XN54flCO5dUsrL69JksgpaLA+bMLDWQZ463k
         Ulhs84RVtmQMVwFLTu3Z9sMbPsExfAdn55lgVqJlwGQt140+dCoWZog8PWmOlYNLCHNu
         wDk9eRo4bVKMpC+XJVK5gxnkBF2n2qGM+ioGEcIZTR8cTds2bLgWgF6tYVhHrPF/tXdk
         N6C7IzOnr3p2eKDAfdF/1cLeVTWFByiMjPGZtimHRlguf1RpGe9oQCC66sTnNMsg5UEu
         2kZE77gWWvMAbeQYNiMsJbeYP9mjx/mLaqBf+hr3sKo7YarDo03g4ZCQBR9eFneSE0dt
         hvtw==
X-Gm-Message-State: APt69E2ogItpEGPufVCTmPme8ykeZathNS4AsIONP/JSIBJIYLqYmVR6
        YxqFrPHYN8dN/I3jraiu2aZaOw==
X-Google-Smtp-Source: ADUXVKI2bLwSesENiuRj8ipWyWrGf8YXsVyKe+/AtmkwRaaqxJwB/QSGfUPa3Lw4eWpekuBOf8PWeg==
X-Received: by 2002:a9d:4609:: with SMTP id y9-v6mr10036648ote.259.1529430294836;
        Tue, 19 Jun 2018 10:44:54 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id h25-v6sm106952otj.37.2018.06.19.10.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:44:53 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 19 Jun 2018 12:44:52 -0500
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180619174452.GA47272@syl.attlocal.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 07:33:39PM +0200, René Scharfe wrote:
> Am 19.06.2018 um 18:35 schrieb Jeff King:
> > On Mon, Jun 18, 2018 at 06:43:01PM -0500, Taylor Blau wrote:
> >> The notable case that it does _not_ cover is matching the following
> >> line:
> >>
> >>    a ... b
> >>
> >> with the following expression
> >>
> >>    git grep --column -e b --or -e a
> >>
> >> This will produce the column for 'b' rather than the column for 'a',
> >> since we short-circuit an --or when the left child finds a match, in
> >> this case 'b'. So, we break the semantics for this case, at the benefit
> >> of not having to do twice the work.
> >>
> >> In the future, I'd like to revisit this, since any performance gains
> >> that we _do_ make in this area are moot when we rescan all lines in
> >> show_line() with --color. A path forward, I imagine, would look like a
> >> list of regmatch_t's, or a set of locations in the expression tree, such
> >> that we could either enumerate the list or walk the tree in order to
> >> colorize the line. But, I think for now that is #leftoverbits.
> >
> > The key thing about this iteration is that it doesn't regress
> > performance, because we always short-circuit where we used to. The other
> > obvious route is to stop short-circuiting only when "--column" is in
> > effect, which would have the same property (at the expense of a little
> > extra code in match_expr_eval()).
>
> The performance impact of the exhaustive search for --color scales with
> the number of shown lines, while it would scale with the total number of
> lines for --column.  Coloring the results of highly selective patterns
> is relatively cheap, short-circuiting them still helps significantly.

Sure. I was pointing out that we are repeating work in cases where it is
unnecessary to do so. It seems natural to me to take one of the two
above approaches, and optimize where we can.

> Disabling that optimization for --column wouldn't be a regression since
> it's a new option..  Picking a random result (based on the order of
> evaluation) seems sloppy and is probably going to surprise users.

That's fair, and something I'm happy to do if others feel OK about it.
Here is a patch to that effect:

diff --git a/grep.c b/grep.c
index f3329d82ed..a09935d8c5 100644
--- a/grep.c
+++ b/grep.c
@@ -1257,8 +1257,8 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	return hit;
 }

-static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
-			   enum grep_context ctx, ssize_t *col,
+static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x, char *bol,
+			   char *eol, enum grep_context ctx, ssize_t *col,
 			   ssize_t *icol, int collect_hits)
 {
 	int h = 0;
@@ -1282,26 +1282,27 @@ static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
 		/*
 		 * Upon visiting a GREP_NODE_NOT, col and icol become swapped.
 		 */
-		h = !match_expr_eval(x->u.unary, bol, eol, ctx, icol, col, 0);
+		h = !match_expr_eval(opt, x->u.unary, bol, eol, ctx, icol, col, 0);
 		break;
 	case GREP_NODE_AND:
-		if (!match_expr_eval(x->u.binary.left, bol, eol, ctx, col,
+		if (!match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
 				     icol, 0))
 			return 0;
-		h = match_expr_eval(x->u.binary.right, bol, eol, ctx, col,
+		h = match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
 				    icol, 0);
 		break;
 	case GREP_NODE_OR:
-		if (!collect_hits)
-			return (match_expr_eval(x->u.binary.left, bol, eol, ctx,
+		if (!(collect_hits || opt->columnnum))
+			return (match_expr_eval(opt, x->u.binary.left, bol, eol, ctx,
 						col, icol, 0) ||
-				match_expr_eval(x->u.binary.right, bol, eol,
+				match_expr_eval(opt, x->u.binary.right, bol, eol,
 						ctx, col, icol, 0));
-		h = match_expr_eval(x->u.binary.left, bol, eol, ctx, col,
+		h = match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
 				    icol, 0);
-		x->u.binary.left->hit |= h;
-		h |= match_expr_eval(x->u.binary.right, bol, eol, ctx, col,
-				     icol, 1);
+		if (collect_hits)
+			x->u.binary.left->hit |= h;
+		h |= match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
+				     icol, collect_hits);
 		break;
 	default:
 		die("Unexpected node type (internal error) %d", x->node);
@@ -1316,7 +1317,7 @@ static int match_expr(struct grep_opt *opt, char *bol, char *eol,
 		      ssize_t *icol, int collect_hits)
 {
 	struct grep_expr *x = opt->pattern_expression;
-	return match_expr_eval(x, bol, eol, ctx, col, icol, collect_hits);
+	return match_expr_eval(opt, x, bol, eol, ctx, col, icol, collect_hits);
 }

 static int match_line(struct grep_opt *opt, char *bol, char *eol,

> We could add an optimizer pass to reduce the number of regular
> expressions in certain cases if that is really too slow.  E.g. this:
>
> 	$ git grep -e b -e a
>
> ... is equivalent to:
>
> 	$ git grep -e '\(b\)\|\(a\)'
>
> In that example the optimizer should use a single kwset instead of a
> regex, but you get the idea, namely to leave the short-circuiting to the
> regex engine or kwset, which probably do a good job of it.

I think that--while this pushes that decision to the appropriate level
of indirection--that it is out of scope for this series, and that the
above patch should do a sufficient job at not surprising users.

> René

Thanks,
Taylor
