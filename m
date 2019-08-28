Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F521F461
	for <e@80x24.org>; Wed, 28 Aug 2019 00:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfH1AWV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 20:22:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42416 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfH1AWU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 20:22:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so328039plp.9
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 17:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knOWXvX48crTaVXh1iU+8jUxBOjbjlRmU7dftFMK9HY=;
        b=YAtYBmaGB5uV8rI64wiZO04jCw2x+SnAquPtgS1yUhyyZMxVlIjDMsTwi5ZpNBEmNK
         USN8y47RIYwnDjpFkT8z36ovaVfqnmRhSUh1Zzg2epiaNwlCu2MjGJMPxsLblbjH9aXy
         lkcmdvJ7nd1aQK+4RqUb0IIakKg2UgDi64bW73GQ82oTtZ25ZSqg7Efa3FkLJW5atdZ/
         w8gtvOeZMgMG7aJvZ5YB188BJDhwlBC4mv310pWIXcFtCCpdhC/HxHcmsPHMc3TPUOg6
         8YU3FBDsiEg6AosCIV7ZU0AitROZqj6sGV8BJhySel2lrVoFTxtSeWgY0AvNgl0qG5MW
         9u/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knOWXvX48crTaVXh1iU+8jUxBOjbjlRmU7dftFMK9HY=;
        b=uGHsjd2mZoxVAvvaQmloyS1OC1QLcyzlbT8jhDjuNk0e5m494/nJVs/97JMHAwBIyR
         k/e3aHdvXoHRpr3n6NqUX74fVkxqotffvGEXB5CnUNU9O0RmJM4kjJ4RYm+g0bL38nok
         vTihQElJg9NxOLWNVNsdpFdCI+50Oq8ase5KM0PGyUHBijtGiTJYaugJVUtB0Q5JsL0Z
         otqbgeZNQ5nTLTe4WOGyTkO8bgVbS5ksBmkbW7tA+Fw7h624b3O+XB30E0yh+i1PAEj5
         5AegNYeecL9E03mQppwa4zsHoU6+X3Z8ueU18H9oKzvoMSaGwSQe201LrSuvgfAlL0wW
         Tjkg==
X-Gm-Message-State: APjAAAV60ekQVsjV8NAz+a1ndCc8sgdo3EN9zMqjk/2Hy0lSJZh8sZ1z
        LKxocRem0/BcMHaFn0kSZqOr+MYU
X-Google-Smtp-Source: APXvYqxLHYuHAM++V4+M+MzZ6bpXG55Jbh60chpsFZa3Y4o45UAqFJL+hyL2fCVfNIIUyZa3ugspNQ==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr1670523plr.6.1566951739483;
        Tue, 27 Aug 2019 17:22:19 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h17sm495682pfo.24.2019.08.27.17.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Aug 2019 17:22:18 -0700 (PDT)
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
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/4] t3427: accelerate this test by using fast-export and fast-import
Date:   Tue, 27 Aug 2019 17:22:08 -0700
Message-Id: <20190828002210.8862-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.38.gfc6987be7e
In-Reply-To: <20190828002210.8862-1-newren@gmail.com>
References: <20190826235226.15386-1-newren@gmail.com>
 <20190828002210.8862-1-newren@gmail.com>
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
 t/t3427-rebase-subtree.sh | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index d8640522a0..943ae92226 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -11,6 +11,12 @@ commit_message() {
 	git log --pretty=format:%s -1 "$1"
 }
 
+extract_files_subtree() {
+	git fast-export --no-data HEAD -- files_subtree/ \
+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
+		| git fast-import --force --quiet
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
2.23.0.3.gcc10030edf.dirty

