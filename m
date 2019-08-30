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
	by dcvr.yhbt.net (Postfix) with ESMTP id C70141F4BB
	for <e@80x24.org>; Fri, 30 Aug 2019 05:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfH3F5S (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 01:57:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33711 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfH3F5R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 01:57:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id go14so2831924plb.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJteDotPuSl/9TxRHkj651DOmLTjYJf8YKRPYNQhLu0=;
        b=g0CSKiVsvZrPXi8gehhNgIV8ODuOPnjF6igzTVrIkcJuHGOME8qFnw7HnLSTDC4P2c
         dfsTBC4OtnxiKMXW+F1FC4VN9gogUfLjMqJaPkiN5LLkORapo8Igmbr8AOcmPOxyn85m
         Zvn3T91XMa2JnXL+DOnSXtS7e/whr5OC6Jk60yjJNbunGFPHftRUk4p9wmbiWAZNc71x
         zkdY7hZINc99Y4w8iXsOC4OLzRXEa9e5T7xTquYu1lluD+u0YmFvAhRAIdgAS2wuELEH
         PzsELonjU9jOTRcq9TPU9WkMMlUO+eXrQ5YbalLD+BkNDFUhWgioOnWP3c7T1qDJa4dO
         kCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJteDotPuSl/9TxRHkj651DOmLTjYJf8YKRPYNQhLu0=;
        b=giAgosN8t5jvkKFgUTot8/LEogtFaEPg0td74WgDh56BZKexaWv6PRellBgapAwkPy
         GZB9xFbiDNOit+2OrxP2YSpZrU0GlkUf+hJUzYIM6xjgC1tidvm1a6DYD5ni3Cl568LJ
         kEr7SjILWJIGSSFdxdimu6XDLDEdjuW8LOKPm9YrVxIln6g/QOApMvNq8UUhM7zdcvoH
         kZn2ClGpcAxlYrEH+laYwNEBTdi3diNIlFjs9tc8tHngAHkePmN/5T0d+LTFU2vdiQcF
         WJLNhpDY+mDhCkPEevEa3yAONXKPDpyj4EfR5Vb3m2GOuHIbYRVLv0jYC8+gFeyNmpA+
         Vghw==
X-Gm-Message-State: APjAAAU9qJrdKhDEvFzuNps4a1fFtRG2bq69bgIUMR64ZavLipswE1aq
        6b8GtJjj+1YgWi5q8sL3Uya1sRLI0QQ=
X-Google-Smtp-Source: APXvYqxFKufdD5kty5ddBPASTycPUP2A+Q8vVADdDtRUWE1OPYvvP3e/vTkzWy2fkNiYXhnYTpjxJg==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr14568799plq.166.1567144636285;
        Thu, 29 Aug 2019 22:57:16 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id b136sm5771139pfb.73.2019.08.29.22.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Aug 2019 22:57:15 -0700 (PDT)
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
Subject: [PATCH v4 2/4] t3427: accelerate this test by using fast-export and fast-import
Date:   Thu, 29 Aug 2019 22:57:05 -0700
Message-Id: <20190830055707.7785-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.38.g892688c90e
In-Reply-To: <20190830055707.7785-1-newren@gmail.com>
References: <20190829000657.26415-1-newren@gmail.com>
 <20190830055707.7785-1-newren@gmail.com>
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
2.23.0.38.g892688c90e

