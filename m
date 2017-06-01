Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA80C20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdFASVT (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:21:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35856 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFASVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:21:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so13356223wmh.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2y8laFzXb3XLgBxGUYO0V/iTICPAlMrJdPjNxPgrAE=;
        b=e8t0Jxk5u/z6p8SnHgp5QZuksonUzU5p+fQYzbzoG3dnM4jOou4r7UI0XI9m9kKswV
         GdCZu2e6hjROIvefsFsIp1gIf7in0vYJCtCfJ0RgAt3yLKk256uW490VAtfSKDW6MXM3
         lqD6N7Gw4XO9CGPHgVOdYSJ+fWi5cphcxSf6mD26vV2kXj4Fui0aL+cEByeX57i1qwSt
         qfT9xh6yFizp48xDOzuZh0DIlbiuurbfSqUO8oW7piDVp4FEBLhaltvOIWvScvBZABhh
         LlqytsYVilxO2CY1Ewq+7IYlsIGCkyoQA3U0ekTXXE24NQ6XV+diBJs1YmwUeT/g6/37
         selA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2y8laFzXb3XLgBxGUYO0V/iTICPAlMrJdPjNxPgrAE=;
        b=rOIGG/MdBeomNuHgPMunJccbkF7XR3NpJQDvzw2vNTqIygLlwAoWw01kTuma9VUhQU
         1og7SAIexpB+FhjXWr0XBEGkCdLwOV81HQXLmIcgBXNiXPrnmDrIxKzIoLHKb1tGXZ8g
         +z+PgwvaZ4Muf+EcuNzge/3IsZQwINK8bXD5LyY4uQUTL9GQzucZZGbfqXocqSf+1xe8
         ijbR/SoHvkKG4dPiejIzgh1pk6oHaWMiuC5YWWxmBazSurSxHJaRu3u2K/paGlA9uLpi
         3on63WkgOWa+orh4iS5WclY5R9u2mUhdV7RZ0vNxeB/1AHgXteR+/3QJlqbL+vm2+p8u
         CdTw==
X-Gm-Message-State: AODbwcBgJCfGmt9gevFsHlPml7aJbnihgQNMIlaeuN05iRTGVtQ8G9JF
        slCRqLiS3aSKk7OdLyx5mA==
X-Received: by 10.223.152.18 with SMTP id v18mr2672000wrb.8.1496341276331;
        Thu, 01 Jun 2017 11:21:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 140sm151065wmu.23.2017.06.01.11.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 11:21:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/8] log: add -P as a synonym for --perl-regexp
Date:   Thu,  1 Jun 2017 18:20:51 +0000
Message-Id: <20170601182056.31142-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170601182056.31142-1-avarab@gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a short -P option as a synonym for the longer --perl-regexp, for
consistency with the options the corresponding grep invocations
accept.

This was intentionally omitted in commit 727b6fc3ed ("log --grep:
accept --basic-regexp and --perl-regexp", 2012-10-03) for unspecified
future use.

Make it consistent with "grep" rather than to keep it open for future
use, and to avoid the confusion of -P meaning different things for
grep & log, as is the case with the -G option.

As noted in the aforementioned commit the --basic-regexp option can't
have a corresponding -G argument, as the log command already uses that
for -G<regex>.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/rev-list-options.txt |  1 +
 revision.c                         |  2 +-
 t/t4202-log.sh                     | 12 ++++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a46f70c2b1..9c44eae55d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -91,6 +91,7 @@ endif::git-rev-list[]
 	Consider the limiting patterns to be fixed strings (don't interpret
 	pattern as a regular expression).
 
+-P::
 --perl-regexp::
 	Consider the limiting patterns to be Perl-compatible regular
 	expressions.
diff --git a/revision.c b/revision.c
index eb87dce316..14b598644c 100644
--- a/revision.c
+++ b/revision.c
@@ -1996,7 +1996,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
-	} else if (!strcmp(arg, "--perl-regexp")) {
+	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 703da5a116..a4049ad678 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -404,8 +404,20 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			--grep="(1|2)" >actual.fixed.short-arg &&
 		git log --pretty=tformat:%s -E \
 			--grep="\|2" >actual.extended.short-arg &&
+		if test_have_prereq PCRE
+		then
+			git log --pretty=tformat:%s -P \
+				--grep="[\d]\|" >actual.perl.short-arg
+		else
+			test_must_fail git log -P \
+				--grep="[\d]\|"
+		fi &&
 		test_cmp expect.fixed actual.fixed.short-arg &&
 		test_cmp expect.extended actual.extended.short-arg &&
+		if test_have_prereq PCRE
+		then
+			test_cmp expect.perl actual.perl.short-arg
+		fi &&
 
 		git log --pretty=tformat:%s --fixed-strings \
 			--grep="(1|2)" >actual.fixed.long-arg &&
-- 
2.13.0.303.g4ebf302169

