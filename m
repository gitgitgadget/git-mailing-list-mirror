Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B961F516
	for <e@80x24.org>; Fri, 22 Jun 2018 15:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933884AbeFVPtc (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 11:49:32 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45554 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933762AbeFVPtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 11:49:31 -0400
Received: by mail-ot0-f193.google.com with SMTP id a5-v6so7964632otf.12
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=plDoTFN5IGyxlZss10HqAnI63cf/oEijHTHmGn9NPDo=;
        b=X0AaH1BKmOju9EPEwmifOxyvtlgAPTQhnB8tQ56NwmyyAbUy7tCEt3Ke2e9+vhhMdr
         xqudytHK5W876FVsYJLDXYXSea2gUrjPdghIh3KeoFxp4fbgZFCUKNkK+vsiqdH6Q2ch
         vxzE/7Y0y3M3K1hGJJD2/Bj6/8Tar+942ktzxSSMrwZkG+yKTqqUYWS2in/RZa+AshOt
         2PzAkYf9QTBRGwNDVU/JrqXuy48tWDTQyDwSmuzV6oghUN7k3hi1zuG+MexQg7l+VD8J
         Bt63ZzLf7BaGQ9asKrUROme98elm0Ldx5w0x6wf/niFll0b8cf3Y8ZulmgvU3EMw0LI8
         k0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=plDoTFN5IGyxlZss10HqAnI63cf/oEijHTHmGn9NPDo=;
        b=oZAIPVswG1I/kh4B4y3m7TMzvAwigCAVlwAXZRIceDGnsJbxik8eP8KSAaA/JD2tMo
         EYt48+KrrtGfoCqQPCbv90tP5TmWRzVP8CZawSl1BQ1XbuAwf4rNyCPAdl3/uoeJwglY
         8+X3pF4TDvXRIi7HpqI6tN0aRx4ZfDLotTOVkVnFrnfRenKuUJ/Y1XofrR3EDXJrt/Mo
         LJcPU1j3cWaIY2sAw2GG9B8LUnxABKGXt3ru75HzVH4FqINTXkgqUt0CBNaibGKLdgrG
         j97yJ07TsTDpwDQSEJfr2vR1sFHcbKNs9J7ISeeNkYAeOKFIJqX4sXZLHnwwJgP+1ozA
         GvTw==
X-Gm-Message-State: APt69E1UiP1VDQ6XmUGTjRbBY72mY3MAI03d1D1wC/HkZAFx7omlj9ke
        hnea+KR7WefYX/tA77WqWnwAfKFTS5s=
X-Google-Smtp-Source: ADUXVKIU8nJ6bcr15R6gpd4/5dc50iQ1E0IX2MxZRhsfDDkvSx6TPvnSQDp7SXrSZfVynQ8vfvWYXQ==
X-Received: by 2002:a9d:215c:: with SMTP id l28-v6mr1342089otd.195.1529682570046;
        Fri, 22 Jun 2018 08:49:30 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id h20-v6sm4264089oib.33.2018.06.22.08.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 08:49:28 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:49:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <cover.1529682173.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is my third--anticipate the final--re-roll of my series to
teach 'git grep --column'.

Since the last time, only a couple of things have changed at Peff's
suggestions in [1]. The changes are summarized here, and an inter-diff
is available below:

  - Change "%zu" to PRIuMAX (and an appropriate cast into uintmax_t). I
    plan to send a follow-up patch to convert this back to "%zu" to see
    how people feel about it, but I wanted to keep that out of the
    present series in order to not hold things up.

  - Don't short-circuit AND when given --column, since an earlier NOT
    higher in the tree may cause an AND to be converted into an OR via
    de Morgan's Law, in which case the problem is reduced to the OR case
    (and should not have been short-circuited in the first place).

  - Add a test in t7810 to cover this behavior (i.e., '--not \( -e x
    --and -e y \)').

Thanks,
Taylor

[1]: https://public-inbox.org/git/20180621115302.GB15293@sigill.intra.peff.net/

Taylor Blau (7):
  Documentation/config.txt: camel-case lineNumber for consistency
  grep.c: expose {,inverted} match column in match_line()
  grep.[ch]: extend grep_opt to allow showing matched column
  grep.c: display column number of first match
  builtin/grep.c: add '--column' option to 'git-grep(1)'
  grep.c: add configuration variables to show matched option
  contrib/git-jump/git-jump: jump to exact location

 Documentation/config.txt   |   7 +-
 Documentation/git-grep.txt |   9 ++-
 builtin/grep.c             |   1 +
 contrib/git-jump/README    |  12 +++-
 contrib/git-jump/git-jump  |   2 +-
 grep.c                     | 134 +++++++++++++++++++++++++++++--------
 grep.h                     |   2 +
 t/t7810-grep.sh            |  95 ++++++++++++++++++++++++++
 8 files changed, 228 insertions(+), 34 deletions(-)

Inter-diff (since: v2)

diff --git a/grep.c b/grep.c
index 08d3df2855..992673fe7e 100644
--- a/grep.c
+++ b/grep.c
@@ -1286,11 +1286,17 @@ static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x, char *bol,
 				     0);
 		break;
 	case GREP_NODE_AND:
-		if (!match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
-				     icol, 0))
-			return 0;
-		h = match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
+		h = match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
 				    icol, 0);
+		if (h || opt->columnnum) {
+			/*
+			 * Don't short-circuit AND when given --column, since a
+			 * NOT earlier in the tree may turn this into an OR. In
+			 * this case, see the below comment.
+			 */
+			h &= match_expr_eval(opt, x->u.binary.right, bol, eol,
+					     ctx, col, icol, 0);
+		}
 		break;
 	case GREP_NODE_OR:
 		if (!(collect_hits || opt->columnnum)) {
@@ -1447,7 +1453,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	 */
 	if (opt->columnnum && cno) {
 		char buf[32];
-		xsnprintf(buf, sizeof(buf), "%zu", cno);
+		xsnprintf(buf, sizeof(buf), "%"PRIuMAX, (uintmax_t)cno);
 		output_color(opt, buf, strlen(buf), opt->color_columnno);
 		output_sep(opt, sign);
 	}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index bf0b572dab..9312c8daf5 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -110,7 +110,7 @@ do
 		test_cmp expected actual
 	'

-	test_expect_success "grep -w $L (with --column, extended)" '
+	test_expect_success "grep -w $L (with --column, extended OR)" '
 		{
 			echo ${HC}file:14:foo_mmap bar mmap
 			echo ${HC}file:19:foo_mmap bar mmap baz
@@ -130,7 +130,7 @@ do
 		test_cmp expected actual
 	'

-	test_expect_success "grep $L (with --column, --invert, extended)" '
+	test_expect_success "grep $L (with --column, --invert, extended OR)" '
 		{
 			echo ${HC}hello_world:6:HeLLo_world
 		} >expected &&
@@ -139,6 +139,17 @@ do
 		test_cmp expected actual
 	'

+	test_expect_success "grep $L (with --column, --invert, extended AND)" '
+		{
+			echo ${HC}hello_world:3:Hello world
+			echo ${HC}hello_world:3:Hello_world
+			echo ${HC}hello_world:6:HeLLo_world
+		} >expected &&
+		git grep --column --invert --not -e _ --and --not -e ll $H -- hello_world \
+			>actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L (with --column, double-negation)" '
 		{
 			echo ${HC}file:1:foo_mmap bar mmap baz

--
2.18.0
