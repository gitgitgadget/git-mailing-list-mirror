Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8101F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfGAVVZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52562 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfGAVVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so892735wms.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBT2tIPVN7eZKTg9IYDlb3i5h0eYIWulMAz9iB0EOgk=;
        b=mhjajJa9+qoa0m29HLavyNdhwOQOKQkXi1/tiJED9GUkqDSevXDMMQGoPzxLJ7i6WP
         g3oqRLio1ajs00wWI4o2oKkwu1C4ZPSE1sPS2yfROIislNJUvIFut6df5V1xf3sx5Mtd
         U7PzPWNnC9cSkq0bQMUYTxodyk/ly5/eHkSjPUpWwvdcSbJ/XEuQU0q5aPMgb6Mgp+Zg
         42nP70hoI9FuyeJjDBYQ4wxZC8nMIze7tBPYYozXXy3LI7E4B4Sbv8LPRAYNqQliusVN
         RDpFyBmv/acpUSLiuQzpj/yzteD0tvhez1O47U0CZVZ2bewg/X8HHRTk9nBC4F6IVb9z
         YluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBT2tIPVN7eZKTg9IYDlb3i5h0eYIWulMAz9iB0EOgk=;
        b=fKjP9fxEkt6IRBgtiXoTM5H4e8qhFSsHhEtxWXgl6TwyKodyevnHXVjoMFzayTYLc4
         Bl+DVniMeeeM52ZQ07LbsbJ5ipY9IdoLDY2FCVh8+KFjJTJ5p7UZQh4EzWrDdSp+igfJ
         iR/W3qTQ7NIsT2dCHjTUieJZ9q9kxi22C3naXqAMHjTnd9wwNPXTVmXPdKL9x5qdOuCL
         bY300ram0Xg4F5mSQg8tzWLQdZiFXoRfNhwWfZ3ba2z2sJOjpZs4iVd2aiRnoEOf8QPt
         RJBnH/qXznfwRKFDRyZpzx7F0Scg2r+KGs82ALll0AsHsZhhTpkB/qVqP9i+8UN2t1pr
         lyGA==
X-Gm-Message-State: APjAAAXjFPxU08hrFrgvVWWDoYSmtzHxiHUO4dRQywyu71Jth1UL01yz
        5b5V11BhKv/r4KoTPdc2XXwbeCb2eEc=
X-Google-Smtp-Source: APXvYqwmd7vxyj906G/swhhyHRR5HFs0B25Co8GcmM0psTX3PKj1Vn3p1fUmtoDAmMir/qeRk3ILLQ==
X-Received: by 2002:a1c:eb16:: with SMTP id j22mr655878wmh.140.1562016081288;
        Mon, 01 Jul 2019 14:21:21 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/10] grep: remove the kwset optimization
Date:   Mon,  1 Jul 2019 23:20:59 +0200
Message-Id: <20190701212100.27850-10-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190627233912.7117-1-avarab@gmail.com>
References: <20190627233912.7117-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A later change will replace this optimization with optimistic use of
PCRE v2. I'm completely removing it as an intermediate step, as
opposed to replacing it with PCRE v2, to demonstrate that no grep
semantics depend on this (or any other) optimization for the fixed
backend anymore.

For now this is mostly (but not entirely) a performance regression, as
shown by this hacky one-liner:

    for opt in '' ' -i'
        do
        GIT_PERF_7821_GREP_OPTS=$opt GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS='-j8 CFLAGS=-O3 USE_LIBPCRE=YesPlease' ./run origin/master HEAD -- p7821-grep-engines-fixed.sh
    done &&
    for opt in '' ' -i'
        do GIT_PERF_4221_LOG_OPTS=$opt GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS='-j8 CFLAGS=-O3 USE_LIBPCRE=YesPlease' ./run origin/master HEAD -- p4221-log-grep-engines-fixed.sh
    done

Which produces:

plain grep:

    Test                             origin/master     HEAD
    -------------------------------------------------------------------------
    7821.1: fixed grep int           0.55(1.60+0.63)   0.82(3.11+0.51) +49.1%
    7821.2: basic grep int           0.62(1.68+0.49)   0.85(3.02+0.52) +37.1%
    7821.3: extended grep int        0.61(1.63+0.53)   0.91(3.09+0.44) +49.2%
    7821.4: perl grep int            0.55(1.60+0.57)   0.41(0.93+0.57) -25.5%
    7821.6: fixed grep uncommon      0.20(0.50+0.44)   0.35(1.27+0.42) +75.0%
    7821.7: basic grep uncommon      0.20(0.49+0.45)   0.35(1.29+0.41) +75.0%
    7821.8: extended grep uncommon   0.20(0.45+0.48)   0.35(1.25+0.44) +75.0%
    7821.9: perl grep uncommon       0.20(0.53+0.41)   0.16(0.24+0.49) -20.0%
    7821.11: fixed grep æ            0.35(1.27+0.40)   0.25(0.82+0.39) -28.6%
    7821.12: basic grep æ            0.35(1.28+0.38)   0.25(0.75+0.44) -28.6%
    7821.13: extended grep æ         0.36(1.21+0.46)   0.25(0.86+0.35) -30.6%
    7821.14: perl grep æ             0.35(1.33+0.34)   0.16(0.26+0.47) -54.3%

grep with -i:

    Test                                origin/master     HEAD
    -----------------------------------------------------------------------------
    7821.1: fixed grep -i int           0.61(1.84+0.64)   1.11(4.12+0.64) +82.0%
    7821.2: basic grep -i int           0.72(1.86+0.57)   1.15(4.48+0.49) +59.7%
    7821.3: extended grep -i int        0.94(1.83+0.60)   1.53(4.12+0.58) +62.8%
    7821.4: perl grep -i int            0.66(1.82+0.59)   0.55(1.08+0.58) -16.7%
    7821.6: fixed grep -i uncommon      0.21(0.51+0.44)   0.44(1.74+0.34) +109.5%
    7821.7: basic grep -i uncommon      0.21(0.55+0.41)   0.44(1.72+0.40) +109.5%
    7821.8: extended grep -i uncommon   0.21(0.57+0.39)   0.42(1.64+0.45) +100.0%
    7821.9: perl grep -i uncommon       0.21(0.48+0.48)   0.17(0.30+0.45) -19.0%
    7821.11: fixed grep -i æ            0.25(0.73+0.45)   0.25(0.75+0.45) +0.0%
    7821.12: basic grep -i æ            0.25(0.71+0.49)   0.26(0.77+0.44) +4.0%
    7821.13: extended grep -i æ         0.25(0.75+0.44)   0.25(0.74+0.46) +0.0%
    7821.14: perl grep -i æ             0.17(0.26+0.48)   0.16(0.20+0.52) -5.9%

plain log:

    Test                                     origin/master     HEAD
    ---------------------------------------------------------------------------------
    4221.1: fixed log --grep='int'           7.31(7.06+0.21)   8.11(7.85+0.20) +10.9%
    4221.2: basic log --grep='int'           7.30(6.94+0.27)   8.16(7.89+0.19) +11.8%
    4221.3: extended log --grep='int'        7.34(7.05+0.21)   8.08(7.76+0.25) +10.1%
    4221.4: perl log --grep='int'            7.27(6.94+0.24)   7.05(6.76+0.25) -3.0%
    4221.6: fixed log --grep='uncommon'      6.97(6.62+0.32)   7.86(7.51+0.30) +12.8%
    4221.7: basic log --grep='uncommon'      7.05(6.69+0.29)   7.89(7.60+0.28) +11.9%
    4221.8: extended log --grep='uncommon'   6.89(6.56+0.32)   7.99(7.66+0.24) +16.0%
    4221.9: perl log --grep='uncommon'       7.02(6.66+0.33)   6.97(6.54+0.36) -0.7%
    4221.11: fixed log --grep='æ'            7.37(7.03+0.33)   7.67(7.30+0.31) +4.1%
    4221.12: basic log --grep='æ'            7.41(7.00+0.31)   7.60(7.28+0.26) +2.6%
    4221.13: extended log --grep='æ'         7.35(6.96+0.38)   7.73(7.31+0.34) +5.2%
    4221.14: perl log --grep='æ'             7.43(7.10+0.32)   6.95(6.61+0.27) -6.5%

log with -i:

    Test                                        origin/master     HEAD
    ------------------------------------------------------------------------------------
    4221.1: fixed log -i --grep='int'           7.40(7.05+0.23)   8.66(8.38+0.20) +17.0%
    4221.2: basic log -i --grep='int'           7.39(7.09+0.23)   8.67(8.39+0.20) +17.3%
    4221.3: extended log -i --grep='int'        7.29(6.99+0.26)   8.69(8.31+0.26) +19.2%
    4221.4: perl log -i --grep='int'            7.42(7.16+0.21)   7.14(6.80+0.24) -3.8%
    4221.6: fixed log -i --grep='uncommon'      6.94(6.58+0.35)   8.43(8.04+0.30) +21.5%
    4221.7: basic log -i --grep='uncommon'      6.95(6.62+0.31)   8.34(7.93+0.32) +20.0%
    4221.8: extended log -i --grep='uncommon'   7.06(6.75+0.25)   8.32(7.98+0.31) +17.8%
    4221.9: perl log -i --grep='uncommon'       6.96(6.69+0.26)   7.04(6.64+0.32) +1.1%
    4221.11: fixed log -i --grep='æ'            7.92(7.55+0.33)   7.86(7.44+0.34) -0.8%
    4221.12: basic log -i --grep='æ'            7.88(7.49+0.32)   7.84(7.46+0.34) -0.5%
    4221.13: extended log -i --grep='æ'         7.91(7.51+0.32)   7.87(7.48+0.32) -0.5%
    4221.14: perl log -i --grep='æ'             7.01(6.59+0.35)   6.99(6.64+0.28) -0.3%

Some of those, as noted in [1] are because PCRE is faster at finding
fixed strings. This looks bad for some engines, but in the next change
we'll optimistically use PCRE v2 for all of these, so it'll look
better.

1. https://public-inbox.org/git/87v9x793qi.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 63 +++-------------------------------------------------------
 grep.h |  2 --
 2 files changed, 3 insertions(+), 62 deletions(-)

diff --git a/grep.c b/grep.c
index 8d0fff316c..4468519d5c 100644
--- a/grep.c
+++ b/grep.c
@@ -356,18 +356,6 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
 
-static int is_fixed(const char *s, size_t len)
-{
-	size_t i;
-
-	for (i = 0; i < len; i++) {
-		if (is_regex_special(s[i]))
-			return 0;
-	}
-
-	return 1;
-}
-
 #ifdef USE_LIBPCRE1
 static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -643,38 +631,12 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
+	p->fixed = opt->fixed;
 
 	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
-	/*
-	 * Even when -F (fixed) asks us to do a non-regexp search, we
-	 * may not be able to correctly case-fold when -i
-	 * (ignore-case) is asked (in which case, we'll synthesize a
-	 * regexp to match the pattern that matches regexp special
-	 * characters literally, while ignoring case differences).  On
-	 * the other hand, even without -F, if the pattern does not
-	 * have any regexp special characters and there is no need for
-	 * case-folding search, we can internally turn it into a
-	 * simple string match using kws.  p->fixed tells us if we
-	 * want to use kws.
-	 */
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
-		p->fixed = !p->ignore_case || !has_non_ascii(p->pattern);
-
-	if (p->fixed) {
-		p->kws = kwsalloc(p->ignore_case ? tolower_trans_tbl : NULL);
-		kwsincr(p->kws, p->pattern, p->patternlen);
-		kwsprep(p->kws);
-		return;
-	}
-
 	if (opt->fixed) {
-		/*
-		 * We come here when the pattern has the non-ascii
-		 * characters we cannot case-fold, and asked to
-		 * ignore-case.
-		 */
 		compile_fixed_regexp(p, opt);
 		return;
 	}
@@ -1042,9 +1004,7 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
-			if (p->kws)
-				kwsfree(p->kws);
-			else if (p->pcre1_regexp)
+			if (p->pcre1_regexp)
 				free_pcre1_regexp(p);
 			else if (p->pcre2_pattern)
 				free_pcre2_pattern(p);
@@ -1104,29 +1064,12 @@ static void show_name(struct grep_opt *opt, const char *name)
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
-static int fixmatch(struct grep_pat *p, char *line, char *eol,
-		    regmatch_t *match)
-{
-	struct kwsmatch kwsm;
-	size_t offset = kwsexec(p->kws, line, eol - line, &kwsm);
-	if (offset == -1) {
-		match->rm_so = match->rm_eo = -1;
-		return REG_NOMATCH;
-	} else {
-		match->rm_so = offset;
-		match->rm_eo = match->rm_so + kwsm.size[0];
-		return 0;
-	}
-}
-
 static int patmatch(struct grep_pat *p, char *line, char *eol,
 		    regmatch_t *match, int eflags)
 {
 	int hit;
 
-	if (p->fixed)
-		hit = !fixmatch(p, line, eol, match);
-	else if (p->pcre1_regexp)
+	if (p->pcre1_regexp)
 		hit = !pcre1match(p, line, eol, match, eflags);
 	else if (p->pcre2_pattern)
 		hit = !pcre2match(p, line, eol, match, eflags);
diff --git a/grep.h b/grep.h
index 4bb8a79d93..d35a137fcb 100644
--- a/grep.h
+++ b/grep.h
@@ -32,7 +32,6 @@ typedef int pcre2_compile_context;
 typedef int pcre2_match_context;
 typedef int pcre2_jit_stack;
 #endif
-#include "kwset.h"
 #include "thread-utils.h"
 #include "userdiff.h"
 
@@ -97,7 +96,6 @@ struct grep_pat {
 	pcre2_match_context *pcre2_match_context;
 	pcre2_jit_stack *pcre2_jit_stack;
 	uint32_t pcre2_jit_on;
-	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
 	unsigned word_regexp:1;
-- 
2.22.0.455.g172b71a6c5

