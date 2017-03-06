Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82B61FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbdCFJw1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:52:27 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34997 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754034AbdCFJvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:46 -0500
Received: by mail-wr0-f195.google.com with SMTP id u108so17018140wrb.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JpUqoNye+/AAcYaRLrThXx80XYbH7wQ9trmMBDekjs0=;
        b=ZqaRKh8YJQAPIBDXILebLkpYZMmDxQ0bDENGJ1W5D0nSz+CLlJ3AP87/hawHqzAVyL
         hIuVUcOoW0UVfN43dbqOZ6SadxCOQ3GGhSwxCQ1Z6cH4MpoLQPam9xk1zBrjJrX0cdek
         +rGE3lOth71dT69LsGQ/5MjxGVgaORJY4FKTO/roGD8aWW+I1CBNceGkmPXc1lm1aW+o
         SkXHS0br8k39oHX1dCOxQP/jDrwBHp/Shmmg5ygni/1o2Za9DqLDgblNLewprRXVkWvt
         S32x4z5r4O6Cd2iF5cnmZ2enluZTSmbNBf+FD0KTOO/NN806Zj+QOtv4YPTly0U78vL4
         u2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JpUqoNye+/AAcYaRLrThXx80XYbH7wQ9trmMBDekjs0=;
        b=BGzaJvbSABPlNdG+EDH/BuTaaNn9n+ViyZyv8MJhnW6GmJmsHPC6q1bKm9jeCsHYV7
         kHFrnsp05ioYqknyU7EjkGSshuQaTwnvwrQzOVxE2ad0EI+xwUX+ou0ckqscT6wwnkpM
         gxfaeK6kKj9vGS5CnuAoEmWSptHYs4Tv+MxteOIAPKB0om3muPqqO9h3KdxRqkmR+EnO
         pKuUEy+mCCuP44JVJrwVPZ4YUt+qWfjVyXi5q80sQuFlAD3d/ASm+8vhsnchsH1nuPzB
         idLdOCBNUj2u6lhzC7hkkheE248FnFPCGmvG4GKe8ZVd1/PkTV6eOX83EpK9J1SqK+hu
         M9rA==
X-Gm-Message-State: AMke39k95PH9spaSlLBCPrFvTQFK0My+ebKS5v+E5vCtkLBzUztAp6kApgZyx3h15PmsuQ==
X-Received: by 10.223.170.70 with SMTP id q6mr5494378wrd.162.1488793339995;
        Mon, 06 Mar 2017 01:42:19 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:19 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 02/22] t1700: change here document style
Date:   Mon,  6 Mar 2017 10:41:43 +0100
Message-Id: <20170306094203.28250-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
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
index 6096f2c630..5ea227e6a1 100755
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
2.12.0.206.g74921e51d6.dirty

