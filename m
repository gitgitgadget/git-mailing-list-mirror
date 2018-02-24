Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68EFE1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 14:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeBXOFa (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 09:05:30 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:38870 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeBXOF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 09:05:28 -0500
Received: by mail-pg0-f41.google.com with SMTP id l24so4476634pgc.5
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNdL2n2ETul7AxUqS5Q6i5rW2TaOXs5wa1SAv5JTjH4=;
        b=cWZte+C0SxoCe02f5a1wdYaBxp73hWKhksxgbxdjmvF934/9ROVF63heGVp2J9ypdZ
         Vwp6DrW6yu9idCfEj2bToZ4WlukYVqZ06kwgdmQN27b112hbmXy6uLtAfWhTkVBYXiAt
         6OQljGV4CYWoH64h0R5oo+WxoSQhDghI8fDaU4BjvJKinD1t2RpxNS/7XuTWKDTRWBX4
         ALW7TldYNv0odqXuNvnizTnMPMERJBRlU8+XBokU/ZnvggCtQ5apWsS4gi3/2V9fZBxN
         qoxjeMrnQVaAEiYbWk2iZX/EnRF12WAJ602zZnC1dL/pC2DIrezsyP0W6vTSco+4s4fG
         rF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNdL2n2ETul7AxUqS5Q6i5rW2TaOXs5wa1SAv5JTjH4=;
        b=S8+lqiv/DnDTFjp3ei/AzKQ1bvqUgdDryaocqbzKZ2TF9AvMzvhGUZXQ30Da++uavS
         hBhfHAIEydQt5lPvvS3hyrksHUA8KfS2u8MWeZMOVLxi8yJHPadJ5zUiXm8iQTRw++SX
         JtmqzYoQeI7EzuZq+Gf/cV6Yq672WDbbOFEHrSq13gt/67tbhLE6tguvvTNJ5he+LgU5
         O0NOCH6QANRKQAxvP+kMAxfUYO+wiDqEwYdMomuS2PwEH8qUtrvQTmegtzH7+oTLmLW7
         ztSrkH0c8+sn6cQubSwIsDKwkxQLnSS5PTpFkgAqIaNc5mmyb3SkM5CJy0yyvMF8WYcM
         /RXA==
X-Gm-Message-State: APf1xPDQKx3rM8eUUezV0yrSY0rvFQ/WL2Zd+LDEbBbyqXrXMyWqjwPg
        nP2K0d8Fxmj2gtL0eq1XspJe+Q==
X-Google-Smtp-Source: AG47ELukme1sB6FF1lDb+M6/HPJRHGQCBT6w1LIhAgGnkC7+caINmqdFBZat1427MFqkTBDh+R+4Hw==
X-Received: by 10.98.141.205 with SMTP id p74mr335863pfk.211.1519481127880;
        Sat, 24 Feb 2018 06:05:27 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id t87sm11346622pfi.37.2018.02.24.06.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Feb 2018 06:05:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 21:05:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 0/2] diff: add --compact-summary (aka nd/diff-stat-with-summary)
Date:   Sat, 24 Feb 2018 21:05:07 +0700
Message-Id: <20180224140509.25061-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180201130221.15563-1-pclouds@gmail.com>
References: <20180201130221.15563-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 renames the option back to --compact-summary. I can't think of any
better name.

Interdiff

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 595e4cd548..e3a44f03cd 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -128,7 +128,7 @@ have to use `--diff-algorithm=default` option.
 These parameters can also be set individually with `--stat-width=<width>`,
 `--stat-name-width=<name-width>` and `--stat-count=<count>`.
 
---stat-with-summary::
+--compact-summary::
 	Output a condensed summary of extended header information such
 	as file creations or deletions ("new" or "gone", optionally "+l"
 	if it's a symlink) and mode changes ("+x" or "-x" for adding
diff --git a/diff.c b/diff.c
index e7ff7dceb7..62e413a80f 100644
--- a/diff.c
+++ b/diff.c
@@ -4332,7 +4332,6 @@ static int stat_opt(struct diff_options *options, const char **av)
 	int graph_width = options->stat_graph_width;
 	int count = options->stat_count;
 	int argcount = 1;
-	unsigned with_summary = options->flags.stat_with_summary;
 
 	if (!skip_prefix(arg, "--stat", &arg))
 		die("BUG: stat option does not begin with --stat: %s", arg);
@@ -4376,9 +4375,6 @@ static int stat_opt(struct diff_options *options, const char **av)
 				count = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
-		} else if (skip_prefix(arg, "-with-summary", &arg)) {
-			with_summary = 1;
-			end = (char*)arg;
 		}
 		break;
 	case '=':
@@ -4397,7 +4393,6 @@ static int stat_opt(struct diff_options *options, const char **av)
 	options->stat_graph_width = graph_width;
 	options->stat_width = width;
 	options->stat_count = count;
-	options->flags.stat_with_summary = with_summary;
 	return argcount;
 }
 
@@ -4579,11 +4574,13 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (starts_with(arg, "--stat"))
-		/*
-		 * --stat, --stat-width, --stat-name-width,
-		 * --stat-count or --stat-with-summary.
-		 */
+		/* --stat, --stat-width, --stat-name-width, or --stat-count */
 		return stat_opt(options, av);
+	else if (!strcmp(arg, "--compact-summary")) {
+		 options->flags.stat_with_summary = 1;
+		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	} else if (!strcmp(arg, "--no-compact-summary"))
+		 options->flags.stat_with_summary = 0;
 
 	/* renames options */
 	else if (starts_with(arg, "-B") ||
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index aa6f5da21c..3f9a24fd56 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -362,10 +362,10 @@ diff --no-index --raw --abbrev=4 dir2 dir
 :noellipses diff --no-index --raw --abbrev=4 dir2 dir
 diff --no-index --raw --no-abbrev dir2 dir
 
-diff-tree --pretty --root --stat-with-summary initial
-diff-tree --pretty -R --root --stat-with-summary initial
-diff-tree --stat-with-summary initial mode
-diff-tree -R --stat-with-summary initial mode
+diff-tree --pretty --root --stat --compact-summary initial
+diff-tree --pretty -R --root --stat --compact-summary initial
+diff-tree --stat --compact-summary initial mode
+diff-tree -R --stat --compact-summary initial mode
 EOF
 
 test_expect_success 'log -S requires an argument' '
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat-with-summary_initial b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
similarity index 78%
rename from t/t4013/diff.diff-tree_--pretty_--root_--stat-with-summary_initial
rename to t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
index 105f29a92d..d6451ff7cc 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--stat-with-summary_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
@@ -1,4 +1,4 @@
-$ git diff-tree --pretty --root --stat-with-summary initial
+$ git diff-tree --pretty --root --stat --compact-summary initial
 commit 444ac553ac7612cc88969031b02b3767fb8a353a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:00:00 2006 +0000
diff --git a/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat-with-summary_initial b/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
similarity index 78%
rename from t/t4013/diff.diff-tree_--pretty_-R_--root_--stat-with-summary_initial
rename to t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
index 45008d09fc..1989e55cd0 100644
--- a/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat-with-summary_initial
+++ b/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
@@ -1,4 +1,4 @@
-$ git diff-tree --pretty -R --root --stat-with-summary initial
+$ git diff-tree --pretty -R --root --stat --compact-summary initial
 commit 444ac553ac7612cc88969031b02b3767fb8a353a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:00:00 2006 +0000
diff --git a/t/t4013/diff.diff-tree_--stat-with-summary_initial_mode b/t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
similarity index 57%
rename from t/t4013/diff.diff-tree_--stat-with-summary_initial_mode
rename to t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
index f99fcdc101..9c7c8f63af 100644
--- a/t/t4013/diff.diff-tree_--stat-with-summary_initial_mode
+++ b/t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
@@ -1,4 +1,4 @@
-$ git diff-tree --stat-with-summary initial mode
+$ git diff-tree --stat --compact-summary initial mode
  file0 (mode +x) | 0
  1 file changed, 0 insertions(+), 0 deletions(-)
 $
diff --git a/t/t4013/diff.diff-tree_-R_--stat-with-summary_initial_mode b/t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode
similarity index 55%
rename from t/t4013/diff.diff-tree_-R_--stat-with-summary_initial_mode
rename to t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode
index 8dc8f3fe95..e38f3d3bfb 100644
--- a/t/t4013/diff.diff-tree_-R_--stat-with-summary_initial_mode
+++ b/t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode
@@ -1,4 +1,4 @@
-$ git diff-tree -R --stat-with-summary initial mode
+$ git diff-tree -R --stat --compact-summary initial mode
  file0 (mode -x) | 0
  1 file changed, 0 insertions(+), 0 deletions(-)
 $
-- 
2.16.1.435.g8f24da2e1a

