Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97E6200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeEFXSg (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41068 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751906AbeEFXSf (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5ACDC60762;
        Sun,  6 May 2018 23:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648704;
        bh=y0pB2AKqfPgme31pYKAAO8jnXNBw1Y0QeH8WQk0Zu1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sWdAX2/VCpI01vL+OTm8UnLzEAte9DqTIxu3PRYVQemfagPrpfrkQ3agt4F3hVqJT
         TeZ4b76KU/pqKzKceoQU5ox6wAlJqjnjGjdMHC8hpKQNXVh4YyYNXH6CDW4zXWgSte
         oA354UK6G7iZLY9ElK0hs6RfUjrvppMLjW5esqQHdiyE34zaT+D4oV9kMUDnXdZ01+
         RcFA1Z1lgtahBVUAF3CzjmgAHfmYLIVnbi12MBlTTpZAG+4Qs08W4SIBDco6AT6pQL
         pCSSJMMMazdzxB5aKxHuBZRfsDNNH+Tja35nK5EpOdbg8dq2Hf2OXQw5+KGpEBcVac
         AHjRxkAz1a+ZOeodM5zsajsFb7XYx8XAjY7hq8yM3h/81bsPRGkjJ3+mR4UURBQj40
         WiUyTheiZHcEJEvXV9+yw75x/FozjRCVkp0N8VHIrEoutv1KrMst9zsu1mPN0iDP6O
         AN4vclwM96rJB9z8HiexZ1ab4ajTpyun5FdOlMs6KorptodNUZH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 05/28] t: switch $_x40 to $FULL_HEX
Date:   Sun,  6 May 2018 23:17:29 +0000
Message-Id: <20180506231752.975110-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch all uses of $_x40 to $FULL_HEX so that they work correctly with
larger hashes.  This commit was created by using the following sed
command to modify all files in the t directory except t/test-lib.sh:

  sed -i 's/\$_x40/$FULL_HEX/g'

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/diff-lib.sh                   |  4 ++--
 t/t0090-cache-tree.sh           |  2 +-
 t/t1000-read-tree-m-3way.sh     |  2 +-
 t/t1001-read-tree-m-2way.sh     |  2 +-
 t/t1002-read-tree-m-u-2way.sh   |  2 +-
 t/t1012-read-tree-df.sh         |  2 +-
 t/t3100-ls-tree-restrict.sh     |  2 +-
 t/t3101-ls-tree-dirname.sh      |  2 +-
 t/t3510-cherry-pick-sequence.sh |  8 ++++----
 t/t4002-diff-basic.sh           |  2 +-
 t/t4006-diff-mode.sh            |  2 +-
 t/t4014-format-patch.sh         |  2 +-
 t/t4201-shortlog.sh             |  2 +-
 t/t5150-request-pull.sh         |  2 +-
 t/t6006-rev-list-format.sh      |  4 ++--
 t/t6012-rev-list-simplify.sh    |  2 +-
 t/t6111-rev-list-treesame.sh    |  2 +-
 t/t7506-status-submodule.sh     |  2 +-
 t/t9010-svn-fe.sh               | 14 +++++++-------
 t/t9300-fast-import.sh          |  6 +++---
 20 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/t/diff-lib.sh b/t/diff-lib.sh
index c211dc40ee..506ef4c289 100644
--- a/t/diff-lib.sh
+++ b/t/diff-lib.sh
@@ -1,6 +1,6 @@
 :
 
-sanitize_diff_raw='/^:/s/ '"\($_x40\)"' '"\($_x40\)"' \([A-Z]\)[0-9]*	/ \1 \2 \3#	/'
+sanitize_diff_raw='/^:/s/ '"\($FULL_HEX\)"' '"\($FULL_HEX\)"' \([A-Z]\)[0-9]*	/ \1 \2 \3#	/'
 compare_diff_raw () {
     # When heuristics are improved, the score numbers would change.
     # Ignore them while comparing.
@@ -12,7 +12,7 @@ compare_diff_raw () {
     test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
-sanitize_diff_raw_z='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*$/ X X \1#/'
+sanitize_diff_raw_z='/^:/s/ '"$FULL_HEX"' '"$FULL_HEX"' \([A-Z]\)[0-9]*$/ X X \1#/'
 compare_diff_raw_z () {
     # When heuristics are improved, the score numbers would change.
     # Ignore them while comparing.
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 4ae0995cd9..26f12facf0 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -9,7 +9,7 @@ cache-tree extension.
 
 cmp_cache_tree () {
 	test-tool dump-cache-tree | sed -e '/#(ref)/d' >actual &&
-	sed "s/$_x40/SHA/" <actual >filtered &&
+	sed "s/$FULL_HEX/SHA/" <actual >filtered &&
 	test_cmp "$1" filtered
 }
 
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index 3c4d2d6045..d85056238e 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -128,7 +128,7 @@ cat >expected <<\EOF
 EOF
 
 check_result () {
-	git ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
+	git ls-files --stage | sed -e 's/ '"$FULL_HEX"' / X /' >current &&
 	test_cmp expected current
 }
 
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 5ededd8e40..01378f7bcd 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -30,7 +30,7 @@ read_tree_twoway () {
 compare_change () {
 	sed -n >current \
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
-	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /p' \
+	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$FULL_HEX"' /\1 X /p' \
 	    "$1"
 	test_cmp expected current
 }
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index 7ca2e65d10..bafbe49971 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -16,7 +16,7 @@ compare_change () {
 	    -e '1{/^diff --git /d;}' \
 	    -e '2{/^index /d;}' \
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
-	    -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /' "$1"
+	    -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$FULL_HEX"' /\1 X /' "$1"
 	test_cmp expected current
 }
 
diff --git a/t/t1012-read-tree-df.sh b/t/t1012-read-tree-df.sh
index a6a04b6b90..26a4089f1e 100755
--- a/t/t1012-read-tree-df.sh
+++ b/t/t1012-read-tree-df.sh
@@ -32,7 +32,7 @@ settree () {
 
 checkindex () {
 	git ls-files -s |
-	sed "s|^[0-7][0-7]* $_x40 \([0-3]\)	|\1 |" >current &&
+	sed "s|^[0-7][0-7]* $FULL_HEX \([0-3]\)	|\1 |" >current &&
 	cat >expect &&
 	test_cmp expect current
 }
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 325114f8fe..f7b0ad774e 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -32,7 +32,7 @@ test_expect_success \
      echo $tree'
 
 test_output () {
-    sed -e "s/ $_x40	/ X	/" <current >check
+    sed -e "s/ $FULL_HEX	/ X	/" <current >check
     test_cmp expected check
 }
 
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 327ded4000..316efabbae 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -40,7 +40,7 @@ test_expect_success 'setup' '
 '
 
 test_output () {
-	sed -e "s/ $_x40	/ X	/" <current >check &&
+	sed -e "s/ $FULL_HEX	/ X	/" <current >check &&
 	test_cmp expected check
 }
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 21b4f194a2..1ff7527fae 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -122,7 +122,7 @@ test_expect_success '--quit keeps HEAD and conflicted index intact' '
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	test_cmp expect actual
 '
@@ -220,7 +220,7 @@ test_expect_success 'cherry-pick still writes sequencer state when one commit is
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -317,7 +317,7 @@ test_expect_success '--continue after resolving conflicts' '
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual.log &&
 	test_cmp expect foo &&
 	test_cmp expect.log actual.log
@@ -334,7 +334,7 @@ test_expect_success '--continue after resolving conflicts and committing' '
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	cat >expect <<-\EOF &&
 	OBJID
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 5af773d6f7..bcd8f22dd1 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -131,7 +131,7 @@ cmp_diff_files_output () {
     # object ID for the changed files because it wants you to look at the
     # filesystem.
     sed <"$2" >.test-tmp \
-	-e '/^:000000 /d;s/'$_x40'\( [MCRNDU][0-9]*\)	/'$ZERO_OID'\1	/' &&
+	-e '/^:000000 /d;s/'$FULL_HEX'\( [MCRNDU][0-9]*\)	/'$ZERO_OID'\1	/' &&
     test_cmp "$1" .test-tmp
 }
 
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 76f643b2c2..2612537255 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -8,7 +8,7 @@ test_description='Test mode change diffs.
 '
 . ./test-lib.sh
 
-sed_script='s/\(:100644 100755\) \('"$_x40"'\) \2 /\1 X X /'
+sed_script='s/\(:100644 100755\) \('"$FULL_HEX"'\) \2 /\1 X X /'
 
 test_expect_success 'setup' '
 	echo frotz >rezrov &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 0dbf7d5b4b..163d64fc32 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1530,7 +1530,7 @@ test_expect_success 'format-patch --zero-commit' '
 test_expect_success 'From line has expected format' '
 	git format-patch --stdout v2..v1 >patch2 &&
 	grep "^From " patch2 >from &&
-	grep "^From $_x40 Mon Sep 17 00:00:00 2001$" patch2 >filtered &&
+	grep "^From $FULL_HEX Mon Sep 17 00:00:00 2001$" patch2 >filtered &&
 	test_cmp from filtered
 '
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index ff6649ed9a..0f28ef5c6c 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -59,7 +59,7 @@ test_expect_success 'setup' '
 fuzz() {
 	file=$1 &&
 	sed "
-			s/$_x40/OBJECT_NAME/g
+			s/$FULL_HEX/OBJECT_NAME/g
 			s/$_x35/OBJID/g
 			s/^ \{6\}[CTa].*/      SUBJECT/g
 			s/^ \{8\}[^ ].*/        CONTINUATION/g
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 08c210f035..99ed055d00 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -81,7 +81,7 @@ test_expect_success 'setup: two scripts for reading pull requests' '
 	cat <<-EOT >fuzz.sed
 	#!/bin/sed -nf
 	s/$downstream_url_for_sed/URL/g
-	s/$_x40/OBJECT_NAME/g
+	s/$FULL_HEX/OBJECT_NAME/g
 	s/A U Thor/AUTHOR/g
 	s/[-0-9]\{10\} [:0-9]\{8\} [-+][0-9]\{4\}/DATE/g
 	s/        [^ ].*/        SUBJECT/g
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 98be78b4a2..d3b1bf375b 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -447,8 +447,8 @@ test_expect_success '--abbrev' '
 	git log -1 --format="%h %h %h" HEAD >actual1 &&
 	git log -1 --abbrev=5 --format="%h %h %h" HEAD >actual2 &&
 	git log -1 --abbrev=5 --format="%H %H %H" HEAD >actual3 &&
-	sed -e "s/$_x40/LONG/g" -e "s/$_x05/SHORT/g" <actual2 >fuzzy2 &&
-	sed -e "s/$_x40/LONG/g" -e "s/$_x05/SHORT/g" <actual3 >fuzzy3 &&
+	sed -e "s/$FULL_HEX/LONG/g" -e "s/$_x05/SHORT/g" <actual2 >fuzzy2 &&
+	sed -e "s/$FULL_HEX/LONG/g" -e "s/$_x05/SHORT/g" <actual3 >fuzzy3 &&
 	test_cmp expect2 fuzzy2 &&
 	test_cmp expect3 fuzzy3 &&
 	! test_cmp actual1 actual2
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 2a0fbb87b1..8c252d14b0 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -9,7 +9,7 @@ note () {
 }
 
 unnote () {
-	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\)) |\1 |g"
+	git name-rev --tags --stdin | sed -e "s|$FULL_HEX (tags/\([^)]*\)) |\1 |g"
 }
 
 test_expect_success setup '
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 32474c23d3..b5082a381d 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -20,7 +20,7 @@ note () {
 }
 
 unnote () {
-	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\))\([ 	]\)|\1\2|g"
+	git name-rev --tags --stdin | sed -e "s|$FULL_HEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
 }
 
 test_expect_success setup '
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 9edf6572ed..42e134f5ae 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -18,7 +18,7 @@ test_create_repo_with_commit () {
 }
 
 sanitize_output () {
-	sed -e "s/$_x40/HASH/" -e "s/$_x40/HASH/" output >output2 &&
+	sed -e "s/$FULL_HEX/HASH/" -e "s/$FULL_HEX/HASH/" output >output2 &&
 	mv output2 output
 }
 
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 8eaaca6f99..980da5da59 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -473,7 +473,7 @@ test_expect_failure 'change file mode but keep old content' '
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	git show HEAD:greeting >actual.blob &&
 	git show HEAD^:greeting >actual.target &&
@@ -573,7 +573,7 @@ test_expect_success 'NUL in log message, file content, and property name' '
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	{
 		git cat-file commit HEAD | nul_to_q &&
@@ -659,7 +659,7 @@ test_expect_success 'change file mode and reiterate content' '
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	git show HEAD:greeting >actual.blob &&
 	git show HEAD^:greeting >actual.target &&
@@ -792,7 +792,7 @@ test_expect_success 'property deltas supported' '
 	{
 		git rev-list HEAD |
 		git diff-tree --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	test_cmp expect actual
 '
@@ -846,7 +846,7 @@ test_expect_success 'properties on /' '
 	{
 		git rev-list HEAD |
 		git diff-tree --root --always --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	test_cmp expect actual
 '
@@ -931,7 +931,7 @@ test_expect_success 'deltas for typechange' '
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	test_cmp expect actual
 '
@@ -1030,7 +1030,7 @@ test_expect_success 'deltas need not consume the whole preimage' '
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
+		sed "s/$FULL_HEX/OBJID/g"
 	} >actual &&
 	test_cmp expect actual &&
 	git show HEAD:postimage >actual.3 &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index dc79df7b04..aac7ae2f6f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1185,7 +1185,7 @@ test_expect_success PIPE 'N: empty directory reads as missing' '
 	test_cmp expect.response response &&
 	git rev-list read-empty |
 	git diff-tree -r --root --stdin |
-	sed "s/$_x40/OBJNAME/g" >actual &&
+	sed "s/$FULL_HEX/OBJNAME/g" >actual &&
 	test_cmp expect actual
 '
 
@@ -1271,7 +1271,7 @@ test_expect_success 'N: delete directory by copying' '
 	git fast-import <input &&
 	git rev-list N-delete |
 		git diff-tree -r --stdin --root --always |
-		sed -e "s/$_x40/OBJID/g" >actual &&
+		sed -e "s/$FULL_HEX/OBJID/g" >actual &&
 	test_cmp expect actual
 '
 
@@ -2602,7 +2602,7 @@ test_expect_success 'R: terminating "done" within commit' '
 	EOF
 	git rev-list done-ends |
 	git diff-tree -r --stdin --root --always |
-	sed -e "s/$_x40/OBJID/g" >actual &&
+	sed -e "s/$FULL_HEX/OBJID/g" >actual &&
 	test_cmp expect actual
 '
 
