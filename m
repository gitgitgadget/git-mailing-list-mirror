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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E79E1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfGAVVP (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38613 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVVO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so1005226wmj.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHxDvc+/06Sn8DHuRS+mgUCZrNHULKEzqugU8V1/wIE=;
        b=KiU95tO+8p11zMzIAv3xbsxArVMubBZv7tA9RF9MrwdpCqbL42ocAZ3H/wDQg8R23v
         olv4gr99tv0yM4USSXxwLvl+3fTqzMaQUhRckZbtglYCXIpVT2lAGIDI/MuoRB+9J5ix
         Ym6auRNdSLHk9M3CPCk3MTBsqyKz7q7/R+RAcVOO3z2iuq1P2+Ehqn6f5pmFvVvVGkUr
         mDVM3eOruRhPbE2jJGzIieNNzKvzC+cTrqJwqPIdM0mEELIDtAfbxCM3aEoAk/JqLSI8
         KtVH9upEtoWOEnk5+A7saepg7sIhQhhOZaPyagWFbDQ7ycGthMVnu5GutFrTvFMkY+jG
         Ui9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHxDvc+/06Sn8DHuRS+mgUCZrNHULKEzqugU8V1/wIE=;
        b=j7fB935QSR9VkJPcbhSN5EcqOgZE2+z6e6IKTq57rGjhNFj5jgnfHxuOCjaeAhmmnb
         +UY8VzaRTaOdesJ+HTui1M5q6RRmfl8GfaDo0m8tq1H/29GmkOB3WageMKs27tPiTxWi
         2Qlo/JFNgMuJH3BLDAuCgF9t/7M3hykpgvFAAUVb0eO/8EuAidoJiIaRNcAT6FENqUm2
         CutDEmOkY6bj254Z9p8tBLHh1vUvx5SbjzTY+g1rbep5SppOqpaRTL6vMOawClKM993A
         pPzrX6yeqpISAX6WMtVpGPe9Jzcouf1w8MDF4yk0j40z7ZXwQOjorHNLsJ+uGv3nn2kl
         atCw==
X-Gm-Message-State: APjAAAU2bbEFUmagC9qDI00Lvzgd8fYOZUteTTqqRWO7/Xynhvou6fKv
        Y573Dk/u8ydT5j/x6fwGArrYT9wDYH4=
X-Google-Smtp-Source: APXvYqyrCrw2a1cmYrQ8hp9APUqpoM/wb9WJ8bNISN7I0KWIDLOwEIuGJsCDH5LYQ7/a774DBOfYEw==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr747167wmh.76.1562016072794;
        Mon, 01 Jul 2019 14:21:12 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/10] grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
Date:   Mon,  1 Jul 2019 23:20:52 +0200
Message-Id: <20190701212100.27850-3-avarab@gmail.com>
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

Fix a bug introduced in 18547aacf5 ("grep/pcre: support utf-8",
2016-06-25) that was missed due to a blindspot in our tests, as
discussed in the previous commit. I then blindly copied the same bug
in 94da9193a6 ("grep: add support for PCRE v2", 2017-06-01) when
adding the PCRE v2 code.

We should not tell PCRE that we're processing UTF-8 just because we're
dealing with non-ASCII. In the case of e.g. "log --encoding=<...>"
under is_utf8_locale() the haystack might be in ISO-8859-1, and the
needle might be in a non-UTF-8 encoding.

Maybe we should be more strict here and die earlier? Should we also be
converting the needle to the encoding in question, and failing if it's
not a string that's valid in that encoding? Maybe.

But for now matching this as non-UTF8 at least has some hope of
producing sensible results, since we know that our default heuristic
of assuming the text to be matched is in the user locale encoding
isn't true when we've explicitly encoded it to be in a different
encoding.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c              | 8 ++++----
 grep.h              | 1 +
 revision.c          | 3 +++
 t/t4210-log-i18n.sh | 6 ++----
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/grep.c b/grep.c
index f7c3a5803e..1de4ab49c0 100644
--- a/grep.c
+++ b/grep.c
@@ -388,11 +388,11 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	int options = PCRE_MULTILINE;
 
 	if (opt->ignore_case) {
-		if (has_non_ascii(p->pattern))
+		if (!opt->ignore_locale && has_non_ascii(p->pattern))
 			p->pcre1_tables = pcre_maketables();
 		options |= PCRE_CASELESS;
 	}
-	if (is_utf8_locale() && has_non_ascii(p->pattern))
+	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern))
 		options |= PCRE_UTF8;
 
 	p->pcre1_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
@@ -498,14 +498,14 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	p->pcre2_compile_context = NULL;
 
 	if (opt->ignore_case) {
-		if (has_non_ascii(p->pattern)) {
+		if (!opt->ignore_locale && has_non_ascii(p->pattern)) {
 			character_tables = pcre2_maketables(NULL);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
 			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
 		}
 		options |= PCRE2_CASELESS;
 	}
-	if (is_utf8_locale() && has_non_ascii(p->pattern))
+	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern))
 		options |= PCRE2_UTF;
 
 	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
diff --git a/grep.h b/grep.h
index 1875880f37..4bb8a79d93 100644
--- a/grep.h
+++ b/grep.h
@@ -173,6 +173,7 @@ struct grep_opt {
 	int funcbody;
 	int extended_regexp_option;
 	int pattern_type_option;
+	int ignore_locale;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
 	unsigned post_context;
diff --git a/revision.c b/revision.c
index 621feb9df7..a842fb158a 100644
--- a/revision.c
+++ b/revision.c
@@ -28,6 +28,7 @@
 #include "commit-graph.h"
 #include "prio-queue.h"
 #include "hashmap.h"
+#include "utf8.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2655,6 +2656,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
 				 &revs->grep_filter);
+	if (!is_encoding_utf8(get_log_output_encoding()))
+		revs->grep_filter.ignore_locale = 1;
 	compile_grep_patterns(&revs->grep_filter);
 
 	if (revs->reverse && revs->reflog_info)
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 86d22c1d4c..515bcb7ce1 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -59,10 +59,8 @@ test_expect_success 'log --grep does not find non-reencoded values (latin1)' '
 for engine in fixed basic extended perl
 do
 	prereq=
-	result=success
 	if test $engine = "perl"
 	then
-		result=failure
 		prereq="PCRE"
 	else
 		prereq=""
@@ -72,7 +70,7 @@ do
 	then
 	    force_regex=.*
 	fi
-	test_expect_$result GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
+	test_expect_success GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
 		cat >expect <<-\EOF &&
 		latin1
 		utf8
@@ -86,7 +84,7 @@ do
 		test_must_be_empty actual
 	"
 
-	test_expect_$result GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
+	test_expect_success GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
 		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
 		test_must_be_empty actual
 	"
-- 
2.22.0.455.g172b71a6c5

