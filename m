Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120B11F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdB0SCL (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33878 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id m70so14622062wma.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iG929IqIvE9lJ297MZb7Je33b3x7S7s4KiDIgmLlHqI=;
        b=qoPR95Fn4f6wbpgj7Fn6yF54H9eTZgQw39Tx9X5z9OkYilDFSnIzs4gjrX6AZlNPdR
         86LucpC+nWpiPl0SrA2TY3PLg5HcOTKy2AomC6XEkqZaN+WNt635pSRjKaVK8nLuW3aN
         alvXEkooan1E48rzekjJh76c44z/F16apRukkEjenh0EEdj8DamExOMDOX0l1VSC4yVt
         +bqD3lP4jyPv1EK+Kt7uVpPUsceZhm/omvarwL+ROtfVglJxRN8mMZBB2LzrHptZoGeY
         zFUmJ6WJZ0DdtOjGNk5gM4nYJVR6eM/A2KvG65Nw6XZmFG6wLLaalNtrPd3Ps+MbdVDZ
         11Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iG929IqIvE9lJ297MZb7Je33b3x7S7s4KiDIgmLlHqI=;
        b=ZJTTr1ALZZocNtGis7F1deoPZmSuDn95yiuVnc6eqIc5HaP1E1GP4yVBWbQ8wY5t3W
         BTkD0eRDnh93wDRTyK+bw2rpaK+CD9fX5987EAI1BbRYlRn7+mpwNPXiB2ZJU91cNE3N
         reMlSxauzbibq5YMie8gGM9BXt8PcWmVOKu+Si5vdzxgIUExA9hyKOV8mzNWG/8N7cpF
         xYene67vFZ9rGYBpNahy5B1eXVIKbxl+b/71imJmHDg5WAZVocU0Nd04u7TVSTMjvNM+
         qR6IywS7oxGK2XR9t/EH6KBKvHJcIlcDqOREpdsVbdfVW7b5grU/CW3EWNE2Sgfatnho
         qZWQ==
X-Gm-Message-State: AMke39k/tf4vCk8Q+rwXdtBc96I+LIJlmOkhCa5YQm66mFRv4bORJSbAPs+8JrsTH54EeA==
X-Received: by 10.28.5.70 with SMTP id 67mr14704157wmf.32.1488218439091;
        Mon, 27 Feb 2017 10:00:39 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:38 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 02/22] t1700: change here document style
Date:   Mon, 27 Feb 2017 18:59:59 +0100
Message-Id: <20170227180019.18666-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves test indentation by getting rid of the outdated
here document style.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 170 ++++++++++++++++++++++++-------------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 292a0720fc..cb68b8dc1e 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -19,12 +19,12 @@ test_expect_success 'enable split index' '
 		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
 		base=39d890139ee5356c7ef572216cebcd27aa41f9df
 	fi &&
-	cat >expect <<EOF &&
-own $own
-base $base
-replacements:
-deletions:
-EOF
+	cat >expect <<-EOF &&
+	own $own
+	base $base
+	replacements:
+	deletions:
+	EOF
 	test_cmp expect actual
 '
 
@@ -32,51 +32,51 @@ test_expect_success 'add one file' '
 	: >one &&
 	git update-index --add one &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<EOF &&
-100644 $EMPTY_BLOB 0	one
-EOF
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
-	cat >expect <<EOF &&
-base $base
-100644 $EMPTY_BLOB 0	one
-replacements:
-deletions:
-EOF
+	cat >expect <<-EOF &&
+	base $base
+	100644 $EMPTY_BLOB 0	one
+	replacements:
+	deletions:
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'disable split index' '
 	git update-index --no-split-index &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<EOF &&
-100644 $EMPTY_BLOB 0	one
-EOF
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	BASE=$(test-dump-split-index .git/index | grep "^own" | sed "s/own/base/") &&
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
-	cat >expect <<EOF &&
-not a split index
-EOF
+	cat >expect <<-EOF &&
+	not a split index
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'enable split index again, "one" now belongs to base index"' '
 	git update-index --split-index &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<EOF &&
-100644 $EMPTY_BLOB 0	one
-EOF
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
-	cat >expect <<EOF &&
-$BASE
-replacements:
-deletions:
-EOF
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
 	test_cmp expect actual
 '
 
@@ -84,18 +84,18 @@ test_expect_success 'modify original file, base index untouched' '
 	echo modified >one &&
 	git update-index one &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<EOF &&
-100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
-EOF
+	cat >ls-files.expect <<-EOF &&
+	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
+	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
-	q_to_tab >expect <<EOF &&
-$BASE
-100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
-replacements: 0
-deletions:
-EOF
+	q_to_tab >expect <<-EOF &&
+	$BASE
+	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
+	replacements: 0
+	deletions:
+	EOF
 	test_cmp expect actual
 '
 
@@ -103,54 +103,54 @@ test_expect_success 'add another file, which stays index' '
 	: >two &&
 	git update-index --add two &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<EOF &&
-100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
-100644 $EMPTY_BLOB 0	two
-EOF
+	cat >ls-files.expect <<-EOF &&
+	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
+	100644 $EMPTY_BLOB 0	two
+	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
-	q_to_tab >expect <<EOF &&
-$BASE
-100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
-100644 $EMPTY_BLOB 0	two
-replacements: 0
-deletions:
-EOF
+	q_to_tab >expect <<-EOF &&
+	$BASE
+	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
+	100644 $EMPTY_BLOB 0	two
+	replacements: 0
+	deletions:
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'remove file not in base index' '
 	git update-index --force-remove two &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<EOF &&
-100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
-EOF
+	cat >ls-files.expect <<-EOF &&
+	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
+	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
-	q_to_tab >expect <<EOF &&
-$BASE
-100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
-replacements: 0
-deletions:
-EOF
+	q_to_tab >expect <<-EOF &&
+	$BASE
+	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
+	replacements: 0
+	deletions:
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'remove file in base index' '
 	git update-index --force-remove one &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<EOF &&
-EOF
+	cat >ls-files.expect <<-EOF &&
+	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
-	cat >expect <<EOF &&
-$BASE
-replacements:
-deletions: 0
-EOF
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions: 0
+	EOF
 	test_cmp expect actual
 '
 
@@ -158,18 +158,18 @@ test_expect_success 'add original file back' '
 	: >one &&
 	git update-index --add one &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<EOF &&
-100644 $EMPTY_BLOB 0	one
-EOF
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
-	cat >expect <<EOF &&
-$BASE
-100644 $EMPTY_BLOB 0	one
-replacements:
-deletions: 0
-EOF
+	cat >expect <<-EOF &&
+	$BASE
+	100644 $EMPTY_BLOB 0	one
+	replacements:
+	deletions: 0
+	EOF
 	test_cmp expect actual
 '
 
@@ -177,26 +177,26 @@ test_expect_success 'add new file' '
 	: >two &&
 	git update-index --add two &&
 	git ls-files --stage >actual &&
-	cat >expect <<EOF &&
-100644 $EMPTY_BLOB 0	one
-100644 $EMPTY_BLOB 0	two
-EOF
+	cat >expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	100644 $EMPTY_BLOB 0	two
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'unify index, two files remain' '
 	git update-index --no-split-index &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<EOF &&
-100644 $EMPTY_BLOB 0	one
-100644 $EMPTY_BLOB 0	two
-EOF
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	100644 $EMPTY_BLOB 0	two
+	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
-	cat >expect <<EOF &&
-not a split index
-EOF
+	cat >expect <<-EOF &&
+	not a split index
+	EOF
 	test_cmp expect actual
 '
 
-- 
2.12.0.22.g0672473d40

