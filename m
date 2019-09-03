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
	by dcvr.yhbt.net (Postfix) with ESMTP id 220381F4B7
	for <e@80x24.org>; Tue,  3 Sep 2019 18:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfICSze (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:55:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40690 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfICSzc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:55:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id w16so11342185pfn.7
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yoNcLAwLZMvWqhAHBTIM0Mtr8k6SzClCqF8HvmzTSo=;
        b=FfqP4OC+fxC35/zz32EhhqAlNaM+yGZCZgI++HbMP3j9CXsopKWyYjTBaImfr1IP2S
         0VNugDeMINzGs2+D3mwK5MnVpZw3fH+NgzKM0bzlfvuFOQxY58lnSvIinTW5rg/VdVoO
         49biQCN2Yuh3i0wqqpLN9Ug03MuowO1au5l6SeRnQh6VUoSH++M2SRjTL5f2imfQWNke
         tglnKYlpsDaLFZmi1DA83Ni5fZCgoMGbbO16HXECzRpRWHkfQEc9WG8ST9fHqC8cUeu3
         E1fgD18iZqueARoIRBDsufYiw15OdKnb3ClaCizlWJYrmSpXUMkdCjHnrAjAKaP3b+4Y
         85Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yoNcLAwLZMvWqhAHBTIM0Mtr8k6SzClCqF8HvmzTSo=;
        b=o6BiO31Zo9SNJ+DWbSVr+n0vALS/EKzH3yzCf2q7ZJGonUm5Qq8nJg67hE3j/8kXlj
         dX8qfS54vRLbP5JVu6z5ypyHA+YZFCcS2FlD1+UZouApYY7wKVk2gMsTOVURdhVzY5OS
         LJRqP8wLiuoKE8xu9Im9kSNicncXYQYxTf7QMtM2TWxIimNSfgMj55PGK0ZWGRbUbWuo
         0sSV/Me3BumJU13pcBQH4HC2wgRGtQJXV0Xy8xSGnCyTXMPD8auNHGESVYNviH0VXKnx
         atREo7XPpmuUJbD4MqaK2WDqfZ0Tn0XCKlDb6PYOyZP8B7om5o4neYmK5kqGB2vV1Jz8
         +3Xg==
X-Gm-Message-State: APjAAAV8fFZxjAA4j8frgdDW0N6B+FyfI37cb0jMQgzOFfpCm1Zl6lKc
        EQE82P8PQG7+q9wI0eRiycc=
X-Google-Smtp-Source: APXvYqy1R0Vt2hsdiAAOGU3GIurY67FrFo1M+hEmwCZ2/Uq/CmyagH2Ct/D1xpyE9FZeju4xJyYaMg==
X-Received: by 2002:a17:90a:e654:: with SMTP id ep20mr779860pjb.65.1567536931907;
        Tue, 03 Sep 2019 11:55:31 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 136sm21283855pfz.123.2019.09.03.11.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 11:55:31 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 2/4] t3427: accelerate this test by using fast-export and fast-import
Date:   Tue,  3 Sep 2019 11:55:22 -0700
Message-Id: <20190903185524.13467-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.39.gf92d9de5c3
In-Reply-To: <20190903185524.13467-1-newren@gmail.com>
References: <20190828002210.8862-1-newren@gmail.com>
 <20190903185524.13467-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-export and fast-import can easily handle the simple rewrite that
was being done by filter-branch, and should be significantly faster on
systems with a slow fork.  Timings from before and after on a few
laptops that I or others measured on (measured via `time
./t3427-rebase-subtree.sh`, i.e. including everything in this test --
not just the filter-branch or fast-export/fast-import pair):

   Linux:    4.305s -> 3.684s (~17% speedup)
   Mac:     10.128s -> 7.038s (~30% speedup)
   Windows:  1m 37s -> 1m 17s (~26% speedup)

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
2.23.0.39.gf92d9de5c3

