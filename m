Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677FA1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeEMCZM (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45208 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751851AbeEMCZL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AF17060739;
        Sun, 13 May 2018 02:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178301;
        bh=91XDLYhuKbvJDvM6vIIzp7utlxVf0msVtjxKITvIIfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=M7s/9r3a8/Sk8b4Ja+6vb17FkVKCzA9HRKQ/M3DD/VXDIFHhq2cOX0z8lSQDWcC0U
         GLFT2/ZwDd3KX/CZnrp3HYvAMICi1FhZ8ICXuOt6EW6Gmm6Wq+glDWXvt3nVh/RKHT
         kRvNvKWCmMcEStpL78fB1X0SvscFs4NdAcJ2F2CZU0jh1pE6CtyTk6y7rI03zqmuCu
         HEm/Vc3jqgoztgkdkp0G2uL/JGisRvWAvh7aJXwfLnTdMwG18bxrD3v2KQnCWNPS6I
         jliFzDJI1KbteLTHtLimSgmdHQGREqqDt54oUqPmAAQGNPEQ9XhkiC0YBN9xdWMBsh
         2xHXH/Oguqc+86PTes6bTodzf2FmVRW6Be4R21UqaKhGcgjzCAKwXsPA8k5eJ6cVhZ
         Yp5sglkDH58NhipGHrbIVGjJztWbD2xr71DfOv+ozhceJrbyKGjgrWkZDJRuBJGe1h
         uVtXPSMi1EttdTOQkfSDFyp8qC7VVqQj8VpzdllITEBk75GjqRA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/28] t: switch $_z40 to $ZERO_OID
Date:   Sun, 13 May 2018 02:24:13 +0000
Message-Id: <20180513022438.60003-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch all uses of $_z40 to $ZERO_OID so that they work correctly with
larger hashes.  This commit was created by using the following sed
command to modify all files in the t directory except t/test-lib.sh:

  sed -i 's/\$_z40/$ZERO_OID/g'

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1006-cat-file.sh                |  8 ++---
 t/t1400-update-ref.sh              |  2 +-
 t/t1407-worktree-ref-store.sh      |  8 ++---
 t/t1450-fsck.sh                    |  4 +--
 t/t1501-work-tree.sh               |  6 ++--
 t/t1601-index-bogus.sh             |  2 +-
 t/t1700-split-index.sh             |  2 +-
 t/t2011-checkout-invalid-head.sh   |  2 +-
 t/t2025-worktree-add.sh            |  8 ++---
 t/t2027-worktree-list.sh           |  2 +-
 t/t2107-update-index-basic.sh      |  4 +--
 t/t2201-add-update-typechange.sh   | 16 ++++-----
 t/t2203-add-intent.sh              |  6 ++--
 t/t3200-branch.sh                  |  4 +--
 t/t4002-diff-basic.sh              |  2 +-
 t/t4014-format-patch.sh            |  2 +-
 t/t4020-diff-external.sh           | 10 +++---
 t/t4027-diff-submodule.sh          |  6 ++--
 t/t4046-diff-unmerged.sh           | 14 ++++----
 t/t4054-diff-bogus-tree.sh         | 12 +++----
 t/t4058-diff-duplicates.sh         | 12 +++----
 t/t4150-am.sh                      |  4 +--
 t/t4200-rerere.sh                  |  2 +-
 t/t5516-fetch-push.sh              | 22 ++++++------
 t/t5527-fetch-odd-refs.sh          |  2 +-
 t/t5571-pre-push-hook.sh           |  8 ++---
 t/t6120-describe.sh                |  2 +-
 t/t6300-for-each-ref.sh            |  2 +-
 t/t6301-for-each-ref-errors.sh     |  2 +-
 t/t7009-filter-branch-null-sha1.sh |  2 +-
 t/t7011-skip-worktree-reading.sh   |  2 +-
 t/t7064-wtstatus-pv2.sh            | 58 +++++++++++++++---------------
 32 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 2ac3b940c6..13dd510b2e 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -236,8 +236,8 @@ test_expect_success "--batch-check for an empty line" '
 '
 
 test_expect_success 'empty --batch-check notices missing object' '
-	echo "$_z40 missing" >expect &&
-	echo "$_z40" | git cat-file --batch-check="" >actual &&
+	echo "$ZERO_OID missing" >expect &&
+	echo "$ZERO_OID" | git cat-file --batch-check="" >actual &&
 	test_cmp expect actual
 '
 
@@ -294,8 +294,8 @@ test_expect_success 'setup blobs which are likely to delta' '
 
 test_expect_success 'confirm that neither loose blob is a delta' '
 	cat >expect <<-EOF &&
-	$_z40
-	$_z40
+	$ZERO_OID
+	$ZERO_OID
 	EOF
 	git cat-file --batch-check="%(deltabase)" <blobs >actual &&
 	test_cmp expect actual
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 664a3a4e4e..f6dc05654e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -6,7 +6,7 @@
 test_description='Test git update-ref and basic ref logging'
 . ./test-lib.sh
 
-Z=$_z40
+Z=$ZERO_OID
 
 m=refs/heads/master
 n_dir=refs/heads/gu
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 2211f9831f..4623ae15c4 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -50,13 +50,13 @@ test_expect_success 'create_symref(FOO, refs/heads/master)' '
 '
 
 test_expect_success 'for_each_reflog()' '
-	echo $_z40 > .git/logs/PSEUDO-MAIN &&
+	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
 	mkdir -p     .git/logs/refs/bisect &&
-	echo $_z40 > .git/logs/refs/bisect/random &&
+	echo $ZERO_OID > .git/logs/refs/bisect/random &&
 
-	echo $_z40 > .git/worktrees/wt/logs/PSEUDO-WT &&
+	echo $ZERO_OID > .git/worktrees/wt/logs/PSEUDO-WT &&
 	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
-	echo $_z40 > .git/worktrees/wt/logs/refs/bisect/wt-random &&
+	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
 
 	$RWT for-each-reflog | cut -c 42- | sort >actual &&
 	cat >expected <<-\EOF &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index cb4b66e29d..91fd71444d 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -713,7 +713,7 @@ test_expect_success 'fsck notices dangling objects' '
 
 test_expect_success 'fsck $name notices bogus $name' '
 	test_must_fail git fsck bogus &&
-	test_must_fail git fsck $_z40
+	test_must_fail git fsck $ZERO_OID
 '
 
 test_expect_success 'bogus head does not fallback to all heads' '
@@ -723,7 +723,7 @@ test_expect_success 'bogus head does not fallback to all heads' '
 	blob=$(git rev-parse :foo) &&
 	test_when_finished "git rm --cached foo" &&
 	remove_object $blob &&
-	test_must_fail git fsck $_z40 >out 2>&1 &&
+	test_must_fail git fsck $ZERO_OID >out 2>&1 &&
 	! grep $blob out
 '
 
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index 9c0bc65250..afcdfafe45 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -238,10 +238,10 @@ test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE' '
 
 test_expect_success 'diff-index respects work tree under .git dir' '
 	cat >diff-index-cached.expected <<-EOF &&
-	:000000 100644 $_z40 $EMPTY_BLOB A	sub/dir/tracked
+	:000000 100644 $ZERO_OID $EMPTY_BLOB A	sub/dir/tracked
 	EOF
 	cat >diff-index.expected <<-EOF &&
-	:000000 100644 $_z40 $_z40 A	sub/dir/tracked
+	:000000 100644 $ZERO_OID $ZERO_OID A	sub/dir/tracked
 	EOF
 
 	(
@@ -257,7 +257,7 @@ test_expect_success 'diff-index respects work tree under .git dir' '
 
 test_expect_success 'diff-files respects work tree under .git dir' '
 	cat >diff-files.expected <<-EOF &&
-	:100644 100644 $EMPTY_BLOB $_z40 M	sub/dir/tracked
+	:100644 100644 $EMPTY_BLOB $ZERO_OID M	sub/dir/tracked
 	EOF
 
 	(
diff --git a/t/t1601-index-bogus.sh b/t/t1601-index-bogus.sh
index 73cc9323cd..4171f1e141 100755
--- a/t/t1601-index-bogus.sh
+++ b/t/t1601-index-bogus.sh
@@ -4,7 +4,7 @@ test_description='test handling of bogus index entries'
 . ./test-lib.sh
 
 test_expect_success 'create tree with null sha1' '
-	tree=$(printf "160000 commit $_z40\\tbroken\\n" | git mktree)
+	tree=$(printf "160000 commit $ZERO_OID\\tbroken\\n" | git mktree)
 '
 
 test_expect_success 'read-tree refuses to read null sha1' '
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index e4f4c4df4e..1e81b33b2e 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -426,7 +426,7 @@ test_expect_success 'writing split index with null sha1 does not write cache tre
 	git commit -m "commit" &&
 	{
 		git ls-tree HEAD &&
-		printf "160000 commit $_z40\\tbroken\\n"
+		printf "160000 commit $ZERO_OID\\tbroken\\n"
 	} >broken-tree &&
 	echo "add broken entry" >msg &&
 
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index c5501b008c..0e8d56aa76 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -15,7 +15,7 @@ test_expect_success 'checkout should not start branch from a tree' '
 '
 
 test_expect_success 'checkout master from invalid HEAD' '
-	echo $_z40 >.git/HEAD &&
+	echo $ZERO_OID >.git/HEAD &&
 	git checkout master --
 '
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index d0d2e4f7ec..beaed5e7a1 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -465,7 +465,7 @@ post_checkout_hook () {
 test_expect_success '"add" invokes post-checkout hook (branch)' '
 	post_checkout_hook &&
 	{
-		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $ZERO_OID $(git rev-parse HEAD) 1 &&
 		echo $(pwd)/.git/worktrees/gumby &&
 		echo $(pwd)/gumby
 	} >hook.expect &&
@@ -476,7 +476,7 @@ test_expect_success '"add" invokes post-checkout hook (branch)' '
 test_expect_success '"add" invokes post-checkout hook (detached)' '
 	post_checkout_hook &&
 	{
-		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $ZERO_OID $(git rev-parse HEAD) 1 &&
 		echo $(pwd)/.git/worktrees/grumpy &&
 		echo $(pwd)/grumpy
 	} >hook.expect &&
@@ -494,7 +494,7 @@ test_expect_success '"add --no-checkout" suppresses post-checkout hook' '
 test_expect_success '"add" in other worktree invokes post-checkout hook' '
 	post_checkout_hook &&
 	{
-		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $ZERO_OID $(git rev-parse HEAD) 1 &&
 		echo $(pwd)/.git/worktrees/guppy &&
 		echo $(pwd)/guppy
 	} >hook.expect &&
@@ -506,7 +506,7 @@ test_expect_success '"add" in bare repo invokes post-checkout hook' '
 	rm -rf bare &&
 	git clone --bare . bare &&
 	{
-		echo $_z40 $(git --git-dir=bare rev-parse HEAD) 1 &&
+		echo $ZERO_OID $(git --git-dir=bare rev-parse HEAD) 1 &&
 		echo $(pwd)/bare/worktrees/goozy &&
 		echo $(pwd)/goozy
 	} >hook.expect &&
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 720063bf0d..bb6fb9b12c 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -116,7 +116,7 @@ test_expect_success 'broken main worktree still at the top' '
 		git worktree add linked &&
 		cat >expected <<-EOF &&
 		worktree $(pwd)
-		HEAD $_z40
+		HEAD $ZERO_OID
 
 		EOF
 		cd linked &&
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 1db7e6a1ab..2242cd098e 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -37,7 +37,7 @@ test_expect_success '--cacheinfo does not accept blob null sha1' '
 	echo content >file &&
 	git add file &&
 	git rev-parse :file >expect &&
-	test_must_fail git update-index --cacheinfo 100644 $_z40 file &&
+	test_must_fail git update-index --cacheinfo 100644 $ZERO_OID file &&
 	git rev-parse :file >actual &&
 	test_cmp expect actual
 '
@@ -47,7 +47,7 @@ test_expect_success '--cacheinfo does not accept gitlink null sha1' '
 	(cd submodule && test_commit foo) &&
 	git add submodule &&
 	git rev-parse :submodule >expect &&
-	test_must_fail git update-index --cacheinfo 160000 $_z40 submodule &&
+	test_must_fail git update-index --cacheinfo 160000 $ZERO_OID submodule &&
 	git rev-parse :submodule >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index 954fc51e5b..a4eec0a346 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -75,35 +75,35 @@ test_expect_success modify '
 		git ls-tree -r HEAD |
 		sed -e "s/^/:/" -e "
 			/	caskly/{
-				s/	caskly/ $_z40 D&/
+				s/	caskly/ $ZERO_OID D&/
 				s/blob/000000/
 			}
 			/	nitfol/{
-				s/	nitfol/ $_z40 $T_letter&/
+				s/	nitfol/ $ZERO_OID $T_letter&/
 				s/blob/100644/
 			}
 			/	rezrov.bozbar/{
-				s/	rezrov.bozbar/ $_z40 D&/
+				s/	rezrov.bozbar/ $ZERO_OID D&/
 				s/blob/000000/
 			}
 			/	xyzzy/{
-				s/	xyzzy/ $_z40 D&/
+				s/	xyzzy/ $ZERO_OID D&/
 				s/blob/000000/
 			}
 			/	yomin/{
-			    s/	yomin/ $_z40 T&/
+			    s/	yomin/ $ZERO_OID T&/
 				s/blob/160000/
 			}
 		"
 	} >expect &&
 	{
 		cat expect
-		echo ":100644 160000 $_empty $_z40 T	yonk"
-		echo ":100644 000000 $_empty $_z40 D	zifmia"
+		echo ":100644 160000 $_empty $ZERO_OID T	yonk"
+		echo ":100644 000000 $_empty $ZERO_OID D	zifmia"
 	} >expect-files &&
 	{
 		cat expect
-		echo ":000000 160000 $_z40 $_z40 A	yonk"
+		echo ":000000 160000 $ZERO_OID $ZERO_OID A	yonk"
 	} >expect-index &&
 	{
 		echo "100644 $_empty 0	nitfol"
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 78236dc7d8..1797f946b9 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -30,9 +30,9 @@ test_expect_success 'git status with porcelain v2' '
 	nam1=d00491fd7e5bb6fa28c517a0bb32b8b506539d4d &&
 	nam2=ce013625030ba8dba906f756967f9e9ca394464a &&
 	cat >expect <<-EOF &&
-	1 DA N... 100644 000000 100644 $nam1 $_z40 1.t
-	1 A. N... 000000 100644 100644 $_z40 $nam2 elif
-	1 .A N... 000000 000000 100644 $_z40 $_z40 file
+	1 DA N... 100644 000000 100644 $nam1 $ZERO_OID 1.t
+	1 A. N... 000000 100644 100644 $ZERO_OID $nam2 elif
+	1 .A N... 000000 000000 100644 $ZERO_OID $ZERO_OID file
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c0ef946811..b52c655c37 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -47,7 +47,7 @@ test_expect_success 'git branch HEAD should fail' '
 '
 
 cat >expect <<EOF
-$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
 test_expect_success 'git branch -l d/e/f should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
@@ -901,7 +901,7 @@ test_expect_success '--set-upstream-to notices an error to set branch as own ups
 
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
-$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index a5e8b83083..5af773d6f7 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -131,7 +131,7 @@ cmp_diff_files_output () {
     # object ID for the changed files because it wants you to look at the
     # filesystem.
     sed <"$2" >.test-tmp \
-	-e '/^:000000 /d;s/'$_x40'\( [MCRNDU][0-9]*\)	/'$_z40'\1	/' &&
+	-e '/^:000000 /d;s/'$_x40'\( [MCRNDU][0-9]*\)	/'$ZERO_OID'\1	/' &&
     test_cmp "$1" .test-tmp
 }
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 482112ca33..0dbf7d5b4b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1523,7 +1523,7 @@ test_expect_success 'cover letter auto user override' '
 test_expect_success 'format-patch --zero-commit' '
 	git format-patch --zero-commit --stdout v2..v1 >patch2 &&
 	grep "^From " patch2 | sort | uniq >actual &&
-	echo "From $_z40 Mon Sep 17 00:00:00 2001" >expect &&
+	echo "From $ZERO_OID Mon Sep 17 00:00:00 2001" >expect &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 044620186d..49d3f54b29 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -26,7 +26,7 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment' '
 		read path oldfile oldhex oldmode newfile newhex newmode &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$_z40" &&
+		test "z$newhex" = "z$ZERO_OID" &&
 		test "z$newmode" = z100644 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
@@ -55,7 +55,7 @@ test_expect_success SYMLINKS 'typechange diff' '
 		read path oldfile oldhex oldmode newfile newhex newmode &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$_z40" &&
+		test "z$newhex" = "z$ZERO_OID" &&
 		test "z$newmode" = z120000 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
@@ -73,7 +73,7 @@ test_expect_success 'diff.external' '
 		read path oldfile oldhex oldmode newfile newhex newmode &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$_z40" &&
+		test "z$newhex" = "z$ZERO_OID" &&
 		test "z$newmode" = z100644 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
@@ -104,7 +104,7 @@ test_expect_success 'diff attribute' '
 		read path oldfile oldhex oldmode newfile newhex newmode &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$_z40" &&
+		test "z$newhex" = "z$ZERO_OID" &&
 		test "z$newmode" = z100644 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
@@ -137,7 +137,7 @@ test_expect_success 'diff attribute' '
 		read path oldfile oldhex oldmode newfile newhex newmode &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$_z40" &&
+		test "z$newhex" = "z$ZERO_OID" &&
 		test "z$newmode" = z100644 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 2ffd11a142..6304130ad4 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -31,7 +31,7 @@ test_expect_success setup '
 		cd sub &&
 		git rev-list HEAD
 	) &&
-	echo ":160000 160000 $3 $_z40 M	sub" >expect &&
+	echo ":160000 160000 $3 $ZERO_OID M	sub" >expect &&
 	subtip=$3 subprev=$2
 '
 
@@ -250,7 +250,7 @@ test_expect_success 'conflicted submodule setup' '
 	# 39 efs
 	c=fffffffffffffffffffffffffffffffffffffff &&
 	(
-		echo "000000 $_z40 0	sub" &&
+		echo "000000 $ZERO_OID 0	sub" &&
 		echo "160000 1$c 1	sub" &&
 		echo "160000 2$c 2	sub" &&
 		echo "160000 3$c 3	sub"
@@ -265,7 +265,7 @@ index 2ffffff,3ffffff..0000000
 ++Subproject commit 0000000000000000000000000000000000000000'\'' &&
 
 	hh=$(git rev-parse HEAD) &&
-	sed -e "s/$_z40/$hh/" expect.nosub >expect.withsub
+	sed -e "s/$ZERO_OID/$hh/" expect.nosub >expect.withsub
 
 '
 
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index d0f14475ca..ff7cfd884a 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -37,7 +37,7 @@ test_expect_success 'diff-files -0' '
 	for path in $paths
 	do
 		>"$path" &&
-		echo ":000000 100644 $_z40 $_z40 U	$path"
+		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path"
 	done >diff-files-0.expect &&
 	git diff-files -0 >diff-files-0.actual &&
 	test_cmp diff-files-0.expect diff-files-0.actual
@@ -47,9 +47,9 @@ test_expect_success 'diff-files -1' '
 	for path in $paths
 	do
 		>"$path" &&
-		echo ":000000 100644 $_z40 $_z40 U	$path" &&
+		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" &&
 		case "$path" in
-		x??) echo ":100644 100644 $blob1 $_z40 M	$path"
+		x??) echo ":100644 100644 $blob1 $ZERO_OID M	$path"
 		esac
 	done >diff-files-1.expect &&
 	git diff-files -1 >diff-files-1.actual &&
@@ -60,9 +60,9 @@ test_expect_success 'diff-files -2' '
 	for path in $paths
 	do
 		>"$path" &&
-		echo ":000000 100644 $_z40 $_z40 U	$path" &&
+		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" &&
 		case "$path" in
-		?x?) echo ":100644 100644 $blob2 $_z40 M	$path"
+		?x?) echo ":100644 100644 $blob2 $ZERO_OID M	$path"
 		esac
 	done >diff-files-2.expect &&
 	git diff-files -2 >diff-files-2.actual &&
@@ -75,9 +75,9 @@ test_expect_success 'diff-files -3' '
 	for path in $paths
 	do
 		>"$path" &&
-		echo ":000000 100644 $_z40 $_z40 U	$path" &&
+		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" &&
 		case "$path" in
-		??x) echo ":100644 100644 $blob3 $_z40 M	$path"
+		??x) echo ":100644 100644 $blob3 $ZERO_OID M	$path"
 		esac
 	done >diff-files-3.expect &&
 	git diff-files -3 >diff-files-3.actual &&
diff --git a/t/t4054-diff-bogus-tree.sh b/t/t4054-diff-bogus-tree.sh
index 18f42c5fff..fcae82fffa 100755
--- a/t/t4054-diff-bogus-tree.sh
+++ b/t/t4054-diff-bogus-tree.sh
@@ -19,37 +19,37 @@ test_expect_success 'create tree with matching file' '
 '
 
 test_expect_success 'raw diff shows null sha1 (addition)' '
-	echo ":000000 100644 $_z40 $_z40 A	foo" >expect &&
+	echo ":000000 100644 $ZERO_OID $ZERO_OID A	foo" >expect &&
 	git diff-tree $EMPTY_TREE $bogus_tree >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'raw diff shows null sha1 (removal)' '
-	echo ":100644 000000 $_z40 $_z40 D	foo" >expect &&
+	echo ":100644 000000 $ZERO_OID $ZERO_OID D	foo" >expect &&
 	git diff-tree $bogus_tree $EMPTY_TREE >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'raw diff shows null sha1 (modification)' '
-	echo ":100644 100644 $blob $_z40 M	foo" >expect &&
+	echo ":100644 100644 $blob $ZERO_OID M	foo" >expect &&
 	git diff-tree $good_tree $bogus_tree >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'raw diff shows null sha1 (other direction)' '
-	echo ":100644 100644 $_z40 $blob M	foo" >expect &&
+	echo ":100644 100644 $ZERO_OID $blob M	foo" >expect &&
 	git diff-tree $bogus_tree $good_tree >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'raw diff shows null sha1 (reverse)' '
-	echo ":100644 100644 $_z40 $blob M	foo" >expect &&
+	echo ":100644 100644 $ZERO_OID $blob M	foo" >expect &&
 	git diff-tree -R $good_tree $bogus_tree >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'raw diff shows null sha1 (index)' '
-	echo ":100644 100644 $_z40 $blob M	foo" >expect &&
+	echo ":100644 100644 $ZERO_OID $blob M	foo" >expect &&
 	git diff-index $bogus_tree >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index 0a23242cb6..c24ee175ef 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -59,12 +59,12 @@ test_expect_success 'create trees with duplicate entries' '
 
 test_expect_success 'diff-tree between trees' '
 	{
-		printf ":000000 100644 $_z40 $blob_two A\touter/inner\n" &&
-		printf ":000000 100644 $_z40 $blob_two A\touter/inner\n" &&
-		printf ":000000 100644 $_z40 $blob_two A\touter/inner\n" &&
-		printf ":100644 000000 $blob_two $_z40 D\touter/inner\n" &&
-		printf ":100644 000000 $blob_two $_z40 D\touter/inner\n" &&
-		printf ":100644 000000 $blob_two $_z40 D\touter/inner\n"
+		printf ":000000 100644 $ZERO_OID $blob_two A\touter/inner\n" &&
+		printf ":000000 100644 $ZERO_OID $blob_two A\touter/inner\n" &&
+		printf ":000000 100644 $ZERO_OID $blob_two A\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $ZERO_OID D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $ZERO_OID D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $ZERO_OID D\touter/inner\n"
 	} >expect &&
 	git diff-tree -r --no-abbrev one two >actual &&
 	test_cmp expect actual
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 1eccfb71d0..1ebc587f8f 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -140,8 +140,8 @@ test_expect_success setup '
 		echo "# User $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" &&
 		echo "# Date $test_tick 25200" &&
 		echo "#      $(git show --pretty="%aD" -s second)" &&
-		echo "# Node ID $_z40" &&
-		echo "# Parent  $_z40" &&
+		echo "# Node ID $ZERO_OID" &&
+		echo "# Parent  $ZERO_OID" &&
 		cat msg &&
 		echo &&
 		git diff-tree --no-commit-id -p second
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index eaf18c81cb..8417e5a4b1 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -243,7 +243,7 @@ rerere_gc_custom_expiry_test () {
 	five_days="$1" right_now="$2"
 	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
 		rm -fr .git/rr-cache &&
-		rr=.git/rr-cache/$_z40 &&
+		rr=.git/rr-cache/$ZERO_OID &&
 		mkdir -p "$rr" &&
 		>"$rr/preimage" &&
 		>"$rr/postimage" &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 82239138d5..d9c90f2ba5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -634,7 +634,7 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
-	newnext=$_z40 &&
+	newnext=$ZERO_OID &&
 	git push testrepo refs/heads/master:refs/heads/master :refs/heads/next &&
 	(
 		cd testrepo/.git &&
@@ -672,15 +672,15 @@ test_expect_success 'deleting dangling ref triggers hooks with correct args' '
 	(
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
-		$_z40 $_z40 refs/heads/master
+		$ZERO_OID $ZERO_OID refs/heads/master
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/master $_z40 $_z40
+		refs/heads/master $ZERO_OID $ZERO_OID
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
-		$_z40 $_z40 refs/heads/master
+		$ZERO_OID $ZERO_OID refs/heads/master
 		EOF
 
 		cat >post-update.expect <<-EOF &&
@@ -703,12 +703,12 @@ test_expect_success 'deletion of a non-existent ref is not fed to post-receive a
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
 		$orgmaster $newmaster refs/heads/master
-		$_z40 $_z40 refs/heads/nonexistent
+		$ZERO_OID $ZERO_OID refs/heads/nonexistent
 		EOF
 
 		cat >update.expect <<-EOF &&
 		refs/heads/master $orgmaster $newmaster
-		refs/heads/nonexistent $_z40 $_z40
+		refs/heads/nonexistent $ZERO_OID $ZERO_OID
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -732,11 +732,11 @@ test_expect_success 'deletion of a non-existent ref alone does trigger post-rece
 	(
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
-		$_z40 $_z40 refs/heads/nonexistent
+		$ZERO_OID $ZERO_OID refs/heads/nonexistent
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/nonexistent $_z40 $_z40
+		refs/heads/nonexistent $ZERO_OID $ZERO_OID
 		EOF
 
 		test_cmp pre-receive.expect pre-receive.actual &&
@@ -751,7 +751,7 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
-	newnext=$_z40 &&
+	newnext=$ZERO_OID &&
 	orgpu=$(cd testrepo && git show-ref -s --verify refs/heads/pu) &&
 	newpu=$(git show-ref -s --verify refs/heads/master) &&
 	git push testrepo refs/heads/master:refs/heads/master \
@@ -763,14 +763,14 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
 		$orgmaster $newmaster refs/heads/master
 		$orgnext $newnext refs/heads/next
 		$orgpu $newpu refs/heads/pu
-		$_z40 $_z40 refs/heads/nonexistent
+		$ZERO_OID $ZERO_OID refs/heads/nonexistent
 		EOF
 
 		cat >update.expect <<-EOF &&
 		refs/heads/master $orgmaster $newmaster
 		refs/heads/next $orgnext $newnext
 		refs/heads/pu $orgpu $newpu
-		refs/heads/nonexistent $_z40 $_z40
+		refs/heads/nonexistent $ZERO_OID $ZERO_OID
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index 207899a99f..3b0cb98422 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -27,7 +27,7 @@ test_expect_success 'suffix ref is ignored during fetch' '
 '
 
 test_expect_success 'try to create repo with absurdly long refname' '
-	ref240=$_z40/$_z40/$_z40/$_z40/$_z40/$_z40 &&
+	ref240=$ZERO_OID/$ZERO_OID/$ZERO_OID/$ZERO_OID/$ZERO_OID/$ZERO_OID &&
 	ref1440=$ref240/$ref240/$ref240/$ref240/$ref240/$ref240 &&
 	git init long &&
 	(
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index ba975bb355..ac53d63869 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -78,8 +78,8 @@ test_expect_success 'push to default' '
 cat >expected <<EOF
 parent1
 repo1
-refs/tags/one $COMMIT1 refs/tags/tag1 $_z40
-HEAD~ $COMMIT2 refs/heads/prev $_z40
+refs/tags/one $COMMIT1 refs/tags/tag1 $ZERO_OID
+HEAD~ $COMMIT2 refs/heads/prev $ZERO_OID
 EOF
 
 test_expect_success 'push non-branches' '
@@ -90,7 +90,7 @@ test_expect_success 'push non-branches' '
 cat >expected <<EOF
 parent1
 repo1
-(delete) $_z40 refs/heads/prev $COMMIT2
+(delete) $ZERO_OID refs/heads/prev $COMMIT2
 EOF
 
 test_expect_success 'push delete' '
@@ -101,7 +101,7 @@ test_expect_success 'push delete' '
 cat >expected <<EOF
 repo1
 repo1
-HEAD $COMMIT3 refs/heads/other $_z40
+HEAD $COMMIT3 refs/heads/other $ZERO_OID
 EOF
 
 test_expect_success 'push to URL' '
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index bae78c4e89..84dd1cb690 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -383,7 +383,7 @@ test_expect_success 'describe complains about tree object' '
 '
 
 test_expect_success 'describe complains about missing object' '
-	test_must_fail git describe $_z40
+	test_must_fail git describe $ZERO_OID
 '
 
 test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 295d1475bd..48379aa0ee 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -310,7 +310,7 @@ test_expect_success 'exercise strftime with odd fields' '
 	echo >expected &&
 	git for-each-ref --format="%(authordate:format:)" refs/heads >actual &&
 	test_cmp expected actual &&
-	long="long format -- $_z40$_z40$_z40$_z40$_z40$_z40$_z40" &&
+	long="long format -- $ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID" &&
 	echo $long >expected &&
 	git for-each-ref --format="%(authordate:format:$long)" refs/heads >actual &&
 	test_cmp expected actual
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index c734ce2388..49cc65bb58 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -4,7 +4,7 @@ test_description='for-each-ref errors for broken refs'
 
 . ./test-lib.sh
 
-ZEROS=$_z40
+ZEROS=$ZERO_OID
 MISSING=abababababababababababababababababababab
 
 test_expect_success setup '
diff --git a/t/t7009-filter-branch-null-sha1.sh b/t/t7009-filter-branch-null-sha1.sh
index a8d9ec4987..9ba9f24ad2 100755
--- a/t/t7009-filter-branch-null-sha1.sh
+++ b/t/t7009-filter-branch-null-sha1.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup: base commits' '
 test_expect_success 'setup: a commit with a bogus null sha1 in the tree' '
 	{
 		git ls-tree HEAD &&
-		printf "160000 commit $_z40\\tbroken\\n"
+		printf "160000 commit $ZERO_OID\\tbroken\\n"
 	} >broken-tree &&
 	echo "add broken entry" >msg &&
 
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 84f41451ec..37525cae3a 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -118,7 +118,7 @@ test_expect_success 'grep with skip-worktree file' '
 	test "$(git grep --no-ext-grep test)" = "1:test"
 '
 
-echo ":000000 100644 $_z40 $EMPTY_BLOB A	1" > expected
+echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A	1" > expected
 test_expect_success 'diff-index does not examine skip-worktree absent entries' '
 	setup_absent &&
 	git diff-index HEAD -- 1 > result &&
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 8f795327a0..b9a86d3347 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -46,11 +46,11 @@ test_expect_success 'before initial commit, things added' '
 	cat >expect <<-EOF &&
 	# branch.oid (initial)
 	# branch.head master
-	1 A. N... 000000 100644 100644 $_z40 $OID_A dir1/file_a
-	1 A. N... 000000 100644 100644 $_z40 $OID_B dir1/file_b
-	1 A. N... 000000 100644 100644 $_z40 $OID_X file_x
-	1 A. N... 000000 100644 100644 $_z40 $OID_Y file_y
-	1 A. N... 000000 100644 100644 $_z40 $OID_Z file_z
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_A dir1/file_a
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_B dir1/file_b
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_X file_x
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_Y file_y
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_Z file_z
 	? actual
 	? expect
 	EOF
@@ -63,11 +63,11 @@ test_expect_success 'before initial commit, things added (-z)' '
 	lf_to_nul >expect <<-EOF &&
 	# branch.oid (initial)
 	# branch.head master
-	1 A. N... 000000 100644 100644 $_z40 $OID_A dir1/file_a
-	1 A. N... 000000 100644 100644 $_z40 $OID_B dir1/file_b
-	1 A. N... 000000 100644 100644 $_z40 $OID_X file_x
-	1 A. N... 000000 100644 100644 $_z40 $OID_Y file_y
-	1 A. N... 000000 100644 100644 $_z40 $OID_Z file_z
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_A dir1/file_a
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_B dir1/file_b
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_X file_x
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_Y file_y
+	1 A. N... 000000 100644 100644 $ZERO_OID $OID_Z file_z
 	? actual
 	? expect
 	EOF
@@ -128,7 +128,7 @@ test_expect_success 'after first commit, stage existing changes' '
 	# branch.oid $H0
 	# branch.head master
 	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
-	1 D. N... 100644 000000 000000 $OID_Z $_z40 file_z
+	1 D. N... 100644 000000 000000 $OID_Z $ZERO_OID file_z
 	? actual
 	? expect
 	EOF
@@ -145,7 +145,7 @@ test_expect_success 'rename causes 2 path lines' '
 	# branch.oid $H0
 	# branch.head master
 	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
-	1 D. N... 100644 000000 000000 $OID_Z $_z40 file_z
+	1 D. N... 100644 000000 000000 $OID_Z $ZERO_OID file_z
 	2 R. N... 100644 100644 100644 $OID_Y $OID_Y R100 renamed_yQfile_y
 	? actual
 	? expect
@@ -163,7 +163,7 @@ test_expect_success 'rename causes 2 path lines (-z)' '
 	# branch.oid $H0
 	# branch.head master
 	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
-	1 D. N... 100644 000000 000000 $OID_Z $_z40 file_z
+	1 D. N... 100644 000000 000000 $OID_Z $ZERO_OID file_z
 	2 R. N... 100644 100644 100644 $OID_Y $OID_Y R100 renamed_yQfile_y
 	? actual
 	? expect
@@ -246,8 +246,8 @@ test_expect_success 'verify --intent-to-add output' '
 	git add --intent-to-add intent1.add intent2.add &&
 
 	cat >expect <<-EOF &&
-	1 .A N... 000000 000000 100644 $_z40 $_z40 intent1.add
-	1 .A N... 000000 000000 100644 $_z40 $_z40 intent2.add
+	1 .A N... 000000 000000 100644 $ZERO_OID $ZERO_OID intent1.add
+	1 .A N... 000000 000000 100644 $ZERO_OID $ZERO_OID intent2.add
 	EOF
 
 	git status --porcelain=v2 >actual &&
@@ -280,7 +280,7 @@ test_expect_success 'verify AA (add-add) conflict' '
 	cat >expect <<-EOF &&
 	# branch.oid $HM
 	# branch.head AA_M
-	u AA N... 000000 100644 100644 100644 $_z40 $OID_AA_B $OID_AA_A conflict.txt
+	u AA N... 000000 100644 100644 100644 $ZERO_OID $OID_AA_B $OID_AA_A conflict.txt
 	EOF
 
 	git status --porcelain=v2 --branch --untracked-files=all >actual &&
@@ -373,7 +373,7 @@ test_expect_success 'verify upstream fields in branch header' '
 		## Test upstream-gone case. Fake this by pointing origin/master at
 		## a non-existing commit.
 		OLD=$(git rev-parse origin/master) &&
-		NEW=$_z40 &&
+		NEW=$ZERO_OID &&
 		mv .git/packed-refs .git/old-packed-refs &&
 		sed "s/$OLD/$NEW/g" <.git/old-packed-refs >.git/packed-refs &&
 
@@ -469,8 +469,8 @@ test_expect_success 'create and add submodule, submodule appears clean (A. S...)
 		# branch.head master
 		# branch.upstream origin/master
 		# branch.ab +0 -0
-		1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
-		1 A. S... 000000 160000 160000 $_z40 $HSUB sub1
+		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
+		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
@@ -494,8 +494,8 @@ test_expect_success 'untracked changes in added submodule (AM S..U)' '
 		# branch.head master
 		# branch.upstream origin/master
 		# branch.ab +0 -0
-		1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
-		1 AM S..U 000000 160000 160000 $_z40 $HSUB sub1
+		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
+		1 AM S..U 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
@@ -519,8 +519,8 @@ test_expect_success 'staged changes in added submodule (AM S.M.)' '
 		# branch.head master
 		# branch.upstream origin/master
 		# branch.ab +0 -0
-		1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
-		1 AM S.M. 000000 160000 160000 $_z40 $HSUB sub1
+		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
+		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
@@ -546,8 +546,8 @@ test_expect_success 'staged and unstaged changes in added (AM S.M.)' '
 		# branch.head master
 		# branch.upstream origin/master
 		# branch.ab +0 -0
-		1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
-		1 AM S.M. 000000 160000 160000 $_z40 $HSUB sub1
+		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
+		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
@@ -573,8 +573,8 @@ test_expect_success 'staged and untracked changes in added submodule (AM S.MU)'
 		# branch.head master
 		# branch.upstream origin/master
 		# branch.ab +0 -0
-		1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
-		1 AM S.MU 000000 160000 160000 $_z40 $HSUB sub1
+		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
+		1 AM S.MU 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
@@ -600,8 +600,8 @@ test_expect_success 'commit within the submodule appears as new commit in super
 		# branch.head master
 		# branch.upstream origin/master
 		# branch.ab +0 -0
-		1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
-		1 AM SC.. 000000 160000 160000 $_z40 $HSUB sub1
+		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
+		1 AM SC.. 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
