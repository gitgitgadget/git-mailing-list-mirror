Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE320203C2
	for <e@80x24.org>; Sat, 16 Jul 2016 05:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbcGPFGu (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 01:06:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34047 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcGPFGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 01:06:46 -0400
Received: by mail-lf0-f66.google.com with SMTP id l69so3567322lfg.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 22:06:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBW/cCmBA6wNhbnkkDKDBLAU+iM1HWA8KJTCA5FMmsM=;
        b=P16BfCw+DugRKGcdEPxSFzAGZxyJr5I9183mRaR/Jon1zvCx8jtyUImmUfwavmiaG0
         /TcJ+iKXvnZNs8YtqrHKYg65MDePd4/+FSlHmv1SvZIRkuJsRt66+sgBTy9p6DgchEzP
         Gis8FWjw9gQcz3tU6HdwvadXU4bUToJ7IsY4kt8VVzL/jxxlNH3yYXB0h7H2ZeMRF/mr
         NA+5nKM0dT3BxsZkmdzrDZ42wvqRmxZ3FX29VOO/K1z10VitLkXBlRITAFAvTFPQq9dJ
         BuG5MTqkve59NhWoA0MRt2/mXuF27XTJlqZKFvO0613GCpUyAP/7m0zica6eIvist+eM
         UtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBW/cCmBA6wNhbnkkDKDBLAU+iM1HWA8KJTCA5FMmsM=;
        b=dOXuN/ebs1iaNoP0MivtcDKfFGZ9UAmS+ne7uISHYsglLxc6o3JzdaUVnqFOOy7dV+
         vmvQZspDybRcgpgI3SiADKlinB8PucYitXEeBV1r9yTiUpO+JVf5e5xr8mbGmoHlcIL+
         PvXDt45O50V+W77NMae0Gk+0pQ5H4jDY7pqB00CWb9CCbI56/GIOKdvGMy9JP5N+p2U0
         m+lfA1o3qPy1TdVtpKW1yUWhlU4SsfSlU7qPsVKthjyf6juyKfBF3KlQigbx+TJMaSNR
         jwKEtHHfmIesVYC/18bZ6gnUVkdJVwe9xCasu2W1PXXmaDmnNchiQO7YcjxV0rxGd0qX
         eYiw==
X-Gm-Message-State: ALyK8tKGd6TaOd+Y2vftQgc7Wh0FUBDARt+h4dFx03UazkYw+lE8mfS3SU54Gf4lmHtJvA==
X-Received: by 10.46.32.198 with SMTP id g67mr11181654lji.31.1468645604287;
        Fri, 15 Jul 2016 22:06:44 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g40sm634654ljg.22.2016.07.15.22.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jul 2016 22:06:43 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/4] test-lib.sh: introduce and use $EMPTY_TREE
Date:	Sat, 16 Jul 2016 07:06:24 +0200
Message-Id: <20160716050627.9416-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160716050627.9416-1-pclouds@gmail.com>
References: <20160709052356.30570-1-pclouds@gmail.com>
 <20160716050627.9416-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is a special SHA1. Let's keep it at one place, easier to replace
later when the hash change comes, easier to recognize.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t0000-basic.sh                |  2 +-
 t/t1100-commit-tree-options.sh  |  2 +-
 t/t4010-diff-pathspec.sh        |  2 --
 t/t4054-diff-bogus-tree.sh      | 10 ++++------
 t/t5504-fetch-receive-strict.sh |  4 ++--
 t/test-lib.sh                   |  4 +++-
 6 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 60811a3..1aa5093 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -834,7 +834,7 @@ test_expect_success 'git write-tree should be able to write an empty tree' '
 '
 
 test_expect_success 'validate object ID of a known tree' '
-	test "$tree" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	test "$tree" = $EMPTY_TREE
 '
 
 # Various types of objects
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index b7e9b4fc..ae66ba5 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -15,7 +15,7 @@ Also make sure that command line parser understands the normal
 . ./test-lib.sh
 
 cat >expected <<EOF
-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+tree $EMPTY_TREE
 author Author Name <author@email> 1117148400 +0000
 committer Committer Name <committer@email> 1117150200 +0000
 
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 43c488b..35b35a8 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -78,8 +78,6 @@ test_expect_success 'diff-tree pathspec' '
 	test_cmp expected current
 '
 
-EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-
 test_expect_success 'diff-tree with wildcard shows dir also matches' '
 	git diff-tree --name-only $EMPTY_TREE $tree -- "f*" >result &&
 	echo file0 >expected &&
diff --git a/t/t4054-diff-bogus-tree.sh b/t/t4054-diff-bogus-tree.sh
index 1d6efab..18f42c5 100755
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
+	git diff-tree $EMPTY_TREE $bogus_tree >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'raw diff shows null sha1 (removal)' '
 	echo ":100644 000000 $_z40 $_z40 D	foo" >expect &&
-	git diff-tree $bogus_tree $empty_tree >actual &&
+	git diff-tree $bogus_tree $EMPTY_TREE >actual &&
 	test_cmp expect actual
 '
 
@@ -57,11 +55,11 @@ test_expect_success 'raw diff shows null sha1 (index)' '
 '
 
 test_expect_success 'patch fails due to bogus sha1 (addition)' '
-	test_must_fail git diff-tree -p $empty_tree $bogus_tree
+	test_must_fail git diff-tree -p $EMPTY_TREE $bogus_tree
 '
 
 test_expect_success 'patch fails due to bogus sha1 (removal)' '
-	test_must_fail git diff-tree -p $bogus_tree $empty_tree
+	test_must_fail git diff-tree -p $bogus_tree $EMPTY_TREE
 '
 
 test_expect_success 'patch fails due to bogus sha1 (modification)' '
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 44f3d5f..9b19cff 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,8 +115,8 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
-cat >bogus-commit <<\EOF
-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+cat >bogus-commit <<EOF
+tree $EMPTY_TREE
 author Bugs Bunny 1234567890 +0000
 committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..85f4c6d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -162,6 +162,8 @@ _x40="$_x05$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
 # Zero SHA-1
 _z40=0000000000000000000000000000000000000000
 
+EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+
 # Line feed
 LF='
 '
@@ -170,7 +172,7 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x40 _z40 LF u200c
+export _x05 _x40 _z40 LF u200c EMPTY_TREE
 
 # Each test should start with something like this, after copyright notices:
 #
-- 
2.9.1.566.gbd532d4

