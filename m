Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC90206FB
	for <e@80x24.org>; Sat,  9 Jul 2016 05:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572AbcGIFYU (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 01:24:20 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34116 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcGIFYR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 01:24:17 -0400
Received: by mail-lf0-f65.google.com with SMTP id a10so7022393lfb.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 22:24:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEOv4L7VbnVf6Np2LjrAHT9DkwlER7Nh78Skxv437kg=;
        b=Q6vSsILUz9wnxJ0DoGRGi71iWs7W2fYbqdLPmJv6vqSC6XUR/1H94NWg0YM6D9zWEQ
         JFvjjO0w1BUV3+SwLlB6aWzEfwrV5AA037biBlhgslFEBXxBYBBV+u1xhAYsU8k355VL
         OGQY4jV/sjoGyTafo1yKybPolsm28FU+W0zr2dj3DtvlXU+K7haFHMjwpcr0Qyh+7xgK
         X88sn0x2T+VGwv22ZCKagvmzoxKsgjLnM1/vWnuB4t3p88dVF8Oi7MMwCMiWNcFz8hQJ
         3dWQLVJsnqPsoZ0T84dMGAm9vq++C2KpHKQ0s71nbMcBSPtM3+vWqOMQ8r+LHl0BC7ZT
         eOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEOv4L7VbnVf6Np2LjrAHT9DkwlER7Nh78Skxv437kg=;
        b=Mum5W5RqioW6vK5DItgekXv1HkuSW34JPF07F7xkoKu8ZSkvJBRrqNJucH66h18D+Z
         vAu3papbc9ot82JTWW+wh0/2mUZ2A4m5OsUekdAi+hf9UL3yCGcYGhxDqse1RIRYC96m
         mdXs/JlRJphSIFaX8oom6b150NnGO5CUUmACyxvvFunttcYoS7orhrr8lbecuVMPGQVe
         wt6jDssPhfVNvVOUV0zdnwJ5b9Fqpt9Omby8Kd244SXWdRGZ+mDnSsTY2CAAIAKDkAT5
         6SsRvC5FmUdUFyZTO9swzXN2S2ON9f1nEkHWkm1/YPqxh5MP+PUGIl5k9iRpVImTi0qF
         uIvA==
X-Gm-Message-State: ALyK8tL1H18C55o3Wa54zo6L0l9KyZN1XpXmUQciXZmH8LwiSubZwDg/Df2OQwyFrS22PA==
X-Received: by 10.25.162.196 with SMTP id l187mr1956941lfe.137.1468041856053;
        Fri, 08 Jul 2016 22:24:16 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id f66sm1450237lji.13.2016.07.08.22.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 22:24:14 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/4] test-lib.sh: introduce and use $_EMPTY_BLOB
Date:	Sat,  9 Jul 2016 07:23:54 +0200
Message-Id: <20160709052356.30570-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160709052356.30570-1-pclouds@gmail.com>
References: <20160706184829.31825-1-pclouds@gmail.com>
 <20160709052356.30570-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Similar to $_EMPTY_TREE this makes it easier to recognize this special
SHA-1 and change hash later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh |  8 ++++----
 t/t1700-split-index.sh               | 24 ++++++++++++------------
 t/t3102-ls-tree-wildcards.sh         |  8 ++++----
 t/t7011-skip-worktree-reading.sh     | 12 +++++-------
 t/t7012-skip-worktree-writing.sh     | 10 ++++------
 t/t7063-status-untracked-cache.sh    |  6 +++---
 t/t7508-status.sh                    |  2 +-
 t/test-lib.sh                        |  3 ++-
 8 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 0c74bee..21cfa2e 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -15,11 +15,11 @@ test_description='sparse checkout tests
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
 test_expect_success 'setup' '
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/added
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/addedtoo
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	subsub/added
+	100644 $_EMPTY_BLOB 0	sub/added
+	100644 $_EMPTY_BLOB 0	sub/addedtoo
+	100644 $_EMPTY_BLOB 0	subsub/added
 	EOF
 	cat >expected.swt <<-\EOF &&
 	H init.t
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 8aef49f..305f210 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -33,14 +33,14 @@ test_expect_success 'add one file' '
 	git update-index --add one &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<EOF &&
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 $_EMPTY_BLOB 0	one
 EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<EOF &&
 base $base
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 $_EMPTY_BLOB 0	one
 replacements:
 deletions:
 EOF
@@ -51,7 +51,7 @@ test_expect_success 'disable split index' '
 	git update-index --no-split-index &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<EOF &&
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 $_EMPTY_BLOB 0	one
 EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
@@ -67,7 +67,7 @@ test_expect_success 'enable split index again, "one" now belongs to base index"'
 	git update-index --split-index &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<EOF &&
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 $_EMPTY_BLOB 0	one
 EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
@@ -105,7 +105,7 @@ test_expect_success 'add another file, which stays index' '
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<EOF &&
 100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+100644 $_EMPTY_BLOB 0	two
 EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
@@ -113,7 +113,7 @@ EOF
 	q_to_tab >expect <<EOF &&
 $BASE
 100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+100644 $_EMPTY_BLOB 0	two
 replacements: 0
 deletions:
 EOF
@@ -159,14 +159,14 @@ test_expect_success 'add original file back' '
 	git update-index --add one &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<EOF &&
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 $_EMPTY_BLOB 0	one
 EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<EOF &&
 $BASE
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 $_EMPTY_BLOB 0	one
 replacements:
 deletions: 0
 EOF
@@ -178,8 +178,8 @@ test_expect_success 'add new file' '
 	git update-index --add two &&
 	git ls-files --stage >actual &&
 	cat >expect <<EOF &&
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+100644 $_EMPTY_BLOB 0	one
+100644 $_EMPTY_BLOB 0	two
 EOF
 	test_cmp expect actual
 '
@@ -188,8 +188,8 @@ test_expect_success 'unify index, two files remain' '
 	git update-index --no-split-index &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<EOF &&
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+100644 $_EMPTY_BLOB 0	one
+100644 $_EMPTY_BLOB 0	two
 EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
index 4d4b02e..5cf84fa 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -12,16 +12,16 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'ls-tree a[a] matches literally' '
-	cat >expect <<-\EOF &&
-	100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	a[a]/three
+	cat >expect <<-EOF &&
+	100644 blob $_EMPTY_BLOB	a[a]/three
 	EOF
 	git ls-tree -r HEAD "a[a]" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'ls-tree outside prefix' '
-	cat >expect <<-\EOF &&
-	100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	../a[a]/three
+	cat >expect <<-EOF &&
+	100644 blob $_EMPTY_BLOB	../a[a]/three
 	EOF
 	( cd aa && git ls-tree -r HEAD "../a[a]"; ) >actual &&
 	test_cmp expect actual
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 88d60c1..7fe0c9f 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -23,17 +23,15 @@ S sub/1
 H sub/2
 EOF
 
-NULL_SHA1=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
-
 setup_absent() {
 	test -f 1 && rm 1
 	git update-index --remove 1 &&
-	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --add --cacheinfo 100644 $_EMPTY_BLOB 1 &&
 	git update-index --skip-worktree 1
 }
 
 test_absent() {
-	echo "100644 $NULL_SHA1 0	1" > expected &&
+	echo "100644 $_EMPTY_BLOB 0	1" > expected &&
 	git ls-files --stage 1 > result &&
 	test_cmp expected result &&
 	test ! -f 1
@@ -42,12 +40,12 @@ test_absent() {
 setup_dirty() {
 	git update-index --force-remove 1 &&
 	echo dirty > 1 &&
-	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --add --cacheinfo 100644 $_EMPTY_BLOB 1 &&
 	git update-index --skip-worktree 1
 }
 
 test_dirty() {
-	echo "100644 $NULL_SHA1 0	1" > expected &&
+	echo "100644 $_EMPTY_BLOB 0	1" > expected &&
 	git ls-files --stage 1 > result &&
 	test_cmp expected result &&
 	echo dirty > expected
@@ -120,7 +118,7 @@ test_expect_success 'grep with skip-worktree file' '
 	test "$(git grep --no-ext-grep test)" = "1:test"
 '
 
-echo ":000000 100644 $_z40 $NULL_SHA1 A	1" > expected
+echo ":000000 100644 $_z40 $_EMPTY_BLOB A	1" > expected
 test_expect_success 'diff-index does not examine skip-worktree absent entries' '
 	setup_absent &&
 	git diff-index HEAD -- 1 > result &&
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index 9ceaa40..003e36f 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -53,17 +53,15 @@ test_expect_success 'read-tree removes worktree, dirty case' '
 	git update-index --no-skip-worktree added
 '
 
-NULL_SHA1=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
-
 setup_absent() {
 	test -f 1 && rm 1
 	git update-index --remove 1 &&
-	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --add --cacheinfo 100644 $_EMPTY_BLOB 1 &&
 	git update-index --skip-worktree 1
 }
 
 test_absent() {
-	echo "100644 $NULL_SHA1 0	1" > expected &&
+	echo "100644 $_EMPTY_BLOB 0	1" > expected &&
 	git ls-files --stage 1 > result &&
 	test_cmp expected result &&
 	test ! -f 1
@@ -72,12 +70,12 @@ test_absent() {
 setup_dirty() {
 	git update-index --force-remove 1 &&
 	echo dirty > 1 &&
-	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --add --cacheinfo 100644 $_EMPTY_BLOB 1 &&
 	git update-index --skip-worktree 1
 }
 
 test_dirty() {
-	echo "100644 $NULL_SHA1 0	1" > expected &&
+	echo "100644 $_EMPTY_BLOB 0	1" > expected &&
 	git ls-files --stage 1 > result &&
 	test_cmp expected result &&
 	echo dirty > expected
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a971884..8d23259 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -53,7 +53,7 @@ A  two
 EOF
 
 cat >../dump.expect <<EOF &&
-info/exclude e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+info/exclude $_EMPTY_BLOB
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
 flags 00000006
@@ -137,7 +137,7 @@ EOF
 test_expect_success 'verify untracked cache dump' '
 	test-dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
-info/exclude e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+info/exclude $_EMPTY_BLOB
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
 flags 00000006
@@ -184,7 +184,7 @@ EOF
 test_expect_success 'verify untracked cache dump' '
 	test-dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
-info/exclude e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+info/exclude $_EMPTY_BLOB
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
 flags 00000006
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c3ed7cb..2b534ec 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -803,7 +803,7 @@ EOF
 '
 
 cat >expect <<EOF
-:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 M	dir1/modified
+:100644 100644 $_EMPTY_BLOB 0000000000000000000000000000000000000000 M	dir1/modified
 EOF
 test_expect_success 'status refreshes the index' '
 	touch dir2/added &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 327caa5..e1785a2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -163,6 +163,7 @@ _x40="$_x05$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
 _z40=0000000000000000000000000000000000000000
 
 _EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+_EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
 
 # Line feed
 LF='
@@ -172,7 +173,7 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x40 _z40 LF u200c _EMPTY_TREE
+export _x05 _x40 _z40 LF u200c _EMPTY_TREE _EMPTY_BLOB
 
 # Each test should start with something like this, after copyright notices:
 #
-- 
2.8.2.537.g0965dd9

