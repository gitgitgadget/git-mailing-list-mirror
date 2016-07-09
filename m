Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685A91F744
	for <e@80x24.org>; Sat,  9 Jul 2016 05:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583AbcGIFY3 (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 01:24:29 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34113 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbcGIFYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 01:24:25 -0400
Received: by mail-lf0-f65.google.com with SMTP id a10so7022372lfb.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 22:24:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcVAg6of6qvn2vPspDAsWGIBKjtaM6DmGozak5ctM48=;
        b=WGbVopy0eRx03WYDZj6SSvE8/2s9ZaBmbkZRUdrbwyRRIHWJmeiBwi48hqLyHNECYg
         ILCDVnNt89+9GYgu4/JZoX/EqEEN6yLDhnhRmSsJfOrFbZZy4iaL4JTpIHGt2+AAl53N
         ZpS3jNV/2OuKNS4KfqcN2NY6N31wnOFfVHAuVGem59FNE3ess9vcvYjn0yGigP+ZrAcY
         UB5+IAVheMkSaT3P8IOeVEsauP2aZe0trwzg60lYzXu1KQh0No3OVqHtyT03AnqHQ6NG
         GEF+E3gykLJ8S9Ys03dFf6KDP+thWsS/coMEHmL8syHg0P4iiw9vIOHi7sWPyDsdFef/
         xQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcVAg6of6qvn2vPspDAsWGIBKjtaM6DmGozak5ctM48=;
        b=VNgYQRZKX4Rx2/hud++i0nVZYNIvsv1bCvc0XCHfKGbfR3T4L0Vq4b0qLWyIJd2u/3
         EQKunkDg9orAFxKN+uRCHVjWCkx4wG+1idgIslyhkxsZjaFmPMIBxpb8qCmfwCcr6FFh
         uAH9sD+0OP2U9i3epCLkF34QvWZ2LYiFX1W0fyXeOT6x50v3vxFTN6Ft9tMH2M+/wKQZ
         uKDP2FUlkaT/EQNCbh6DVW1p8Xtnneo2J+KZteJHb4r6fGrl5AyuO+LAiP/kZ9C2ye+U
         Gci2SM5knwVfLZA7t3pZ4udeLAEFYcbI1pPeqM8KrWdA2YS//ZvTQvJLi4rQkxv56MIl
         mMJQ==
X-Gm-Message-State: ALyK8tLCB6e5HbTv6Y6HxLfoC/y7fyvX18GLJKOU+HSgSkM8c76wUHGX5nnHBHdHRqPrTA==
X-Received: by 10.46.5.71 with SMTP id 68mr2211105ljf.7.1468041853183;
        Fri, 08 Jul 2016 22:24:13 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id f66sm1450237lji.13.2016.07.08.22.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 22:24:12 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/4] test-lib.sh: introduce and use $_EMPTY_TREE
Date:	Sat,  9 Jul 2016 07:23:53 +0200
Message-Id: <20160709052356.30570-2-pclouds@gmail.com>
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

This is a special SHA1. Let's keep it at one place, easier to replace
later when the hash change comes, easier to recognize. Start with an
underscore to reduce the chances somebody may override it without
realizing it's predefined.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t0000-basic.sh                |  2 +-
 t/t1100-commit-tree-options.sh  |  2 +-
 t/t4010-diff-pathspec.sh        |  6 ++----
 t/t4054-diff-bogus-tree.sh      | 10 ++++------
 t/t5504-fetch-receive-strict.sh |  4 ++--
 t/test-lib.sh                   |  4 +++-
 6 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 60811a3..48214e9 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -834,7 +834,7 @@ test_expect_success 'git write-tree should be able to write an empty tree' '
 '
 
 test_expect_success 'validate object ID of a known tree' '
-	test "$tree" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	test "$tree" = $_EMPTY_TREE
 '
 
 # Various types of objects
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index b7e9b4fc..2adb123 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -15,7 +15,7 @@ Also make sure that command line parser understands the normal
 . ./test-lib.sh
 
 cat >expected <<EOF
-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+tree $_EMPTY_TREE
 author Author Name <author@email> 1117148400 +0000
 committer Committer Name <committer@email> 1117150200 +0000
 
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 43c488b..7c98912 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -78,16 +78,14 @@ test_expect_success 'diff-tree pathspec' '
 	test_cmp expected current
 '
 
-EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-
 test_expect_success 'diff-tree with wildcard shows dir also matches' '
-	git diff-tree --name-only $EMPTY_TREE $tree -- "f*" >result &&
+	git diff-tree --name-only $_EMPTY_TREE $tree -- "f*" >result &&
 	echo file0 >expected &&
 	test_cmp expected result
 '
 
 test_expect_success 'diff-tree -r with wildcard' '
-	git diff-tree -r --name-only $EMPTY_TREE $tree -- "*file1" >result &&
+	git diff-tree -r --name-only $_EMPTY_TREE $tree -- "*file1" >result &&
 	echo path1/file1 >expected &&
 	test_cmp expected result
 '
diff --git a/t/t4054-diff-bogus-tree.sh b/t/t4054-diff-bogus-tree.sh
index 1d6efab..6b48512 100755
--- a/t/t4054-diff-bogus-tree.sh
+++ b/t/t4054-diff-bogus-tree.sh
@@ -3,8 +3,6 @@
 test_description='test diff with a bogus tree containing the null sha1'
 . ./test-lib.sh
 
-empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-
 test_expect_success 'create bogus tree' '
 	bogus_tree=$(
 		printf "100644 fooQQQQQQQQQQQQQQQQQQQQQ" |
@@ -22,13 +20,13 @@ test_expect_success 'create tree with matching file' '
 
 test_expect_success 'raw diff shows null sha1 (addition)' '
 	echo ":000000 100644 $_z40 $_z40 A	foo" >expect &&
-	git diff-tree $empty_tree $bogus_tree >actual &&
+	git diff-tree $_EMPTY_TREE $bogus_tree >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'raw diff shows null sha1 (removal)' '
 	echo ":100644 000000 $_z40 $_z40 D	foo" >expect &&
-	git diff-tree $bogus_tree $empty_tree >actual &&
+	git diff-tree $bogus_tree $_EMPTY_TREE >actual &&
 	test_cmp expect actual
 '
 
@@ -57,11 +55,11 @@ test_expect_success 'raw diff shows null sha1 (index)' '
 '
 
 test_expect_success 'patch fails due to bogus sha1 (addition)' '
-	test_must_fail git diff-tree -p $empty_tree $bogus_tree
+	test_must_fail git diff-tree -p $_EMPTY_TREE $bogus_tree
 '
 
 test_expect_success 'patch fails due to bogus sha1 (removal)' '
-	test_must_fail git diff-tree -p $bogus_tree $empty_tree
+	test_must_fail git diff-tree -p $bogus_tree $_EMPTY_TREE
 '
 
 test_expect_success 'patch fails due to bogus sha1 (modification)' '
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 44f3d5f..39cc971 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,8 +115,8 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
-cat >bogus-commit <<\EOF
-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+cat >bogus-commit <<EOF
+tree $_EMPTY_TREE
 author Bugs Bunny 1234567890 +0000
 committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..327caa5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -162,6 +162,8 @@ _x40="$_x05$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
 # Zero SHA-1
 _z40=0000000000000000000000000000000000000000
 
+_EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+
 # Line feed
 LF='
 '
@@ -170,7 +172,7 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x40 _z40 LF u200c
+export _x05 _x40 _z40 LF u200c _EMPTY_TREE
 
 # Each test should start with something like this, after copyright notices:
 #
-- 
2.8.2.537.g0965dd9

