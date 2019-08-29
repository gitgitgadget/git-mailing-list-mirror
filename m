Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D8D1F4B9
	for <e@80x24.org>; Thu, 29 Aug 2019 00:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfH2AHJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 20:07:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41772 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfH2AHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 20:07:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so563768pgg.8
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSJCQaYzUa9J42DQDIUEp1jNhHxP57DndIbtPKfl6PQ=;
        b=jyJBoSG9fYAlO1iTWw4ufT3yg9L1xXMCwwok982V0BJQygE5NX10W8huon54FV3Kay
         OHVFBOj3T5wvhWXEfFB9kAAOPC7XgGYZajTDspnLeaCD/OeY2/tU9IWzAPk6WKv4Junb
         bPCRKb0o5xEnDWGrS9LVAEQ75o/MpYUGBgvmMQjGhzW2odqaSlfdkXxa5/1RQWTTFj4K
         MHxL8Rivx/PmX7Dkw1r0ajcJm8wIfKMjbjE7fKIAPrB3/eQXCSfjtlZGNEyMJ4mMqleJ
         nVcSMH5Aklgm60ik6naTp75o46Xit+X0pU42OE9wZCGOWp6i/KlHzgpNE0sOgCLgc8QX
         Xw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSJCQaYzUa9J42DQDIUEp1jNhHxP57DndIbtPKfl6PQ=;
        b=d+/bVitUy+NMu3Mkknj5TotRCnMjAiS7PLmK2zwHP5bbe4aUfwbUMxo1cPh39obEZ5
         F1xYFeYTfZ4YvKGS7J9SunDuM3YZaSF4/yi/talu9T0rK23tEXrfzInhZ8t+l7uuDhoV
         PXnhnJZx1GwKpdDVfKfhPzJekLqyARrrIYYRk0+xSATQplxVGXgKGEgDe7vErkt6zb8B
         6/r2WDkGeL0tyNKNMBmKklaLtR9g7/psSCBPYZbvAtvtiAbWH4gJcccuKcUGYQbMkhNm
         Q4oNK/4ntVcn3sv483EKtzt5JqhVhybd+vKKc8kX6edS4nm1bkvf7L4u4Ev5JqgeMqvM
         /hSQ==
X-Gm-Message-State: APjAAAXNSpDtYm+35ezhHGwPm+XBzCtPIIOVriLRT9SGVFT5CPwQIofx
        6HlccI5dxciwhR5CLXG3a1rHTT8w
X-Google-Smtp-Source: APXvYqx3/VJ0y4pb9/XX3mzPFmeBXvX7LJ3tzWzt4X1K+9jbqLQfVFkKRsqEB+I7T7w3WjBl9GeuhA==
X-Received: by 2002:a63:f357:: with SMTP id t23mr5851935pgj.421.1567037225419;
        Wed, 28 Aug 2019 17:07:05 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id m4sm305531pgs.71.2019.08.28.17.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 17:07:04 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 2/4] t3427: accelerate this test by using fast-export and fast-import
Date:   Wed, 28 Aug 2019 17:06:55 -0700
Message-Id: <20190829000657.26415-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g59c7446927.dirty
In-Reply-To: <20190829000657.26415-1-newren@gmail.com>
References: <20190828002210.8862-1-newren@gmail.com>
 <20190829000657.26415-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-export and fast-import can easily handle the simple rewrite that
was being done by filter-branch, and should be significantly faster on
systems with a slow fork.  Timings from before and after on two laptops
that I have access to (measured via `time ./t3427-rebase-subtree.sh`,
i.e. including everything in this test -- not just the filter-branch or
fast-export/fast-import pair):

   Linux:  4.305s -> 3.684s (~17% speedup)
   Mac:   10.128s -> 7.038s (~30% speedup)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3427-rebase-subtree.sh | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index d8640522a0..c1f6102921 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -7,10 +7,16 @@ This test runs git rebase and tests the subtree strategy.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-commit_message() {
+commit_message () {
 	git log --pretty=format:%s -1 "$1"
 }
 
+extract_files_subtree () {
+	git fast-export --no-data HEAD -- files_subtree/ |
+		sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" |
+		git fast-import --force --quiet
+}
+
 test_expect_success 'setup' '
 	test_commit README &&
 	mkdir files &&
@@ -42,7 +48,7 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --preserve-merges --onto commit 4' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	extract_files_subtree &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master4"
@@ -53,7 +59,7 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --preserve-merges --onto commit 5' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	extract_files_subtree &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
@@ -64,7 +70,7 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	extract_files_subtree &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
@@ -75,7 +81,7 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	extract_files_subtree &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
@@ -86,7 +92,7 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty-empty master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	extract_files_subtree &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
@@ -96,7 +102,7 @@ test_expect_failure REBASE_P \
 test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
 	reset_rebase &&
 	git checkout -b rebase-onto-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	extract_files_subtree &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
 	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
@@ -106,7 +112,7 @@ test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
 test_expect_failure 'Rebase -Xsubtree --onto commit 5' '
 	reset_rebase &&
 	git checkout -b rebase-onto-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	extract_files_subtree &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
@@ -115,7 +121,7 @@ test_expect_failure 'Rebase -Xsubtree --onto commit 5' '
 test_expect_failure 'Rebase -Xsubtree --onto empty commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto-empty master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	extract_files_subtree &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
-- 
2.23.0.3.g59c7446927.dirty

