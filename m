From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use test-tr in the test suite
Date: Tue, 18 Mar 2008 23:24:59 +0100
Message-ID: <20080318222459.GC3450@steel.home>
References: <cover.1205356737.git.peff@peff.net> <20080312213106.GD26286@coredump.intra.peff.net> <20080318222302.GA3450@steel.home> <20080318222428.GB3450@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:46:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc73E-0003Wr-Qt
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936414AbYCSWpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936433AbYCSWpW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:45:22 -0400
Received: from mo-p07-fb.rzone.de ([81.169.146.191]:34783 "EHLO
	mo-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936414AbYCSWpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:45:18 -0400
Received: from mo-p07-ob.rzone.de (mrclete-mo-p07-ob.mail [192.168.63.176])
	by charnel-fb-06.store (RZmta 16.11) with ESMTP id P04a0bk2IHYSAf
	for <git@vger.kernel.org>; Tue, 18 Mar 2008 23:44:53 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTG+sg==
Received: from tigra.home (Fa830.f.strato-dslnet.de [195.4.168.48])
	by post.webmailer.de (mrclete mo64) (RZmta 16.13)
	with ESMTP id t049a6k2ILAUjh ; Tue, 18 Mar 2008 23:24:59 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 851AC277BD;
	Tue, 18 Mar 2008 23:24:59 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 83CC456D28; Tue, 18 Mar 2008 23:24:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080318222428.GB3450@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77581>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/annotate-tests.sh            |    4 ++--
 t/diff-lib.sh                  |    4 ++--
 t/t0000-basic.sh               |    2 +-
 t/t0020-crlf.sh                |   10 +++++-----
 t/t0021-conversion.sh          |    2 +-
 t/t1300-repo-config.sh         |    4 ++--
 t/t3300-funny-names.sh         |    6 +++---
 t/t3402-rebase-merge.sh        |    4 ++--
 t/t4004-diff-rename-symlink.sh |    2 +-
 t/t4015-diff-whitespace.sh     |    6 +++---
 t/t4019-diff-wserror.sh        |    2 +-
 t/t4020-diff-external.sh       |    2 +-
 t/t4022-diff-rewrite.sh        |    2 +-
 t/t4101-apply-nonl.sh          |    4 ++--
 t/t4103-apply-binary.sh        |    4 ++--
 t/t4116-apply-reverse.sh       |    4 ++--
 t/t4118-apply-empty-context.sh |    4 ++--
 t/t4200-rerere.sh              |    2 +-
 t/t4201-shortlog.sh            |    4 ++--
 t/t5300-pack-object.sh         |    2 +-
 t/t5500-fetch-pack.sh          |    2 +-
 t/t5505-remote.sh              |    4 ++--
 t/t6003-rev-list-topo-order.sh |    2 +-
 t/t7003-filter-branch.sh       |    2 +-
 t/t9200-git-cvsexportcommit.sh |    2 +-
 t/test-lib.sh                  |   12 +++++++-----
 26 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index cacb273..8e10323 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -104,7 +104,7 @@ test_expect_success \
 
 test_expect_success \
     'an incomplete line added' \
-    'echo "incomplete" | tr -d "\\012" >>file &&
+    'echo "incomplete" | test-tr -d "\\012" >>file &&
     GIT_AUTHOR_NAME="C" git commit -a -m "Incomplete"'
 
 test_expect_success \
@@ -115,7 +115,7 @@ test_expect_success \
     'some edit' \
     'mv file file.orig &&
     sed -e "s/^3A/99/" -e "/^1A/d" -e "/^incomplete/d" < file.orig > file &&
-    echo "incomplete" | tr -d "\\012" >>file &&
+    echo "incomplete" | test-tr -d "\\012" >>file &&
     GIT_AUTHOR_NAME="D" git commit -a -m "edit"'
 
 test_expect_success \
diff --git a/t/diff-lib.sh b/t/diff-lib.sh
index 28b941c..257e123 100644
--- a/t/diff-lib.sh
+++ b/t/diff-lib.sh
@@ -21,8 +21,8 @@ compare_diff_raw_z () {
     # Also we do not check SHA1 hash generation in this test, which
     # is a job for t0000-basic.sh
 
-    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
-    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
+    test-tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
+    test-tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
     git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 27b54cb..a1f60eb 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -324,7 +324,7 @@ test_expect_success 'very long name in the index handled sanely' '
 	(
 		git ls-files -s path4 |
 		sed -e "s/	.*/	/" |
-		tr -d "\012"
+		test-tr -d "\012"
 		echo "$a"
 	) | git update-index --index-info &&
 	len=$(git ls-files "a*" | wc -c) &&
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 2bfeac9..7427d59 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -5,20 +5,20 @@ test_description='CRLF conversion'
 . ./test-lib.sh
 
 q_to_nul () {
-	perl -pe 'y/Q/\000/'
+	test-tr Q '\000'
 }
 
 q_to_cr () {
-	tr Q '\015'
+	test-tr Q '\015'
 }
 
 append_cr () {
-	sed -e 's/$/Q/' | tr Q '\015'
+	sed -e 's/$/Q/' | test-tr Q '\015'
 }
 
 remove_cr () {
-	tr '\015' Q <"$1" | grep Q >/dev/null &&
-	tr '\015' Q <"$1" | sed -ne 's/Q$//p'
+	test-tr '\015' Q <"$1" | grep Q >/dev/null &&
+	test-tr '\015' Q <"$1" | sed -ne 's/Q$//p'
 }
 
 test_expect_success setup '
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 8fc39d7..d146db4 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -5,7 +5,7 @@ test_description='blob conversion via gitattributes'
 . ./test-lib.sh
 
 cat <<\EOF >rot13.sh
-tr \
+test-tr \
   'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
 EOF
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index b36a901..42c3f15 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -657,12 +657,12 @@ Qsection.sub=section.val4
 Qsection.sub=section.val5Q
 EOF
 
-git config --null --list | perl -pe 'y/\000/Q/' > result
+git config --null --list | test-tr '\000' Q > result
 echo >>result
 
 test_expect_success '--null --list' 'cmp result expect'
 
-git config --null --get-regexp 'val[0-9]' | perl -pe 'y/\000/Q/' > result
+git config --null --get-regexp 'val[0-9]' | test-tr '\000' Q > result
 echo >>result
 
 test_expect_success '--null --get-regexp' 'cmp result expect'
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 24a00a9..10c5217 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -54,7 +54,7 @@ echo 'just space
 no-funny
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git ls-files -z with-funny' \
-	'git ls-files -z | perl -pe y/\\000/\\012/ >current &&
+	'git ls-files -z | test-tr "\000" "\012" >current &&
 	git diff expected current'
 
 t1=`git write-tree`
@@ -83,11 +83,11 @@ test_expect_success 'git diff-tree with-funny' \
 echo 'A
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git diff-index -z with-funny' \
-	'git diff-index -z --name-status $t0 | perl -pe y/\\000/\\012/ >current &&
+	'git diff-index -z --name-status $t0 | test-tr "\000" "\012" >current &&
 	git diff expected current'
 
 test_expect_success 'git diff-tree -z with-funny' \
-	'git diff-tree -z --name-status $t0 $t1 | perl -pe y/\\000/\\012/ >current &&
+	'git diff-tree -z --name-status $t0 $t1 | test-tr "\000" "\012" >current &&
 	git diff expected current'
 
 cat > expected <<\EOF
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 7b7d072..704f9a3 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -30,11 +30,11 @@ test_expect_success setup '
 	git update-index --force-remove original &&
 	git commit -a -m"side renames and edits." &&
 
-	tr "[a-z]" "[A-Z]" <original >newfile &&
+	test-tr a-z A-Z <original >newfile &&
 	git add newfile &&
 	git commit -a -m"side edits further." &&
 
-	tr "[a-m]" "[A-M]" <original >newfile &&
+	test-tr a-m A-M <original >newfile &&
 	rm -f original &&
 	git commit -a -m"side edits once again." &&
 
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index 3d25be7..b49efa4 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -14,7 +14,7 @@ by an edit for them.
 
 test_expect_success \
     'prepare reference tree' \
-    'echo xyzzy | tr -d '\\\\'012 >yomin &&
+    'echo xyzzy | test-tr -d "\012" >yomin &&
      ln -s xyzzy frotz &&
     git update-index --add frotz yomin &&
     tree=$(git write-tree) &&
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 83c54b7..595c5e2 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -51,7 +51,7 @@ test_expect_success "Ray's example with -w" 'git diff expect out'
 git diff -b > out
 test_expect_success "Ray's example with -b" 'git diff expect out'
 
-tr 'Q' '\015' << EOF > x
+test-tr 'Q' '\015' << EOF > x
 whitespace at beginning
 whitespace change
 whitespace in the middle
@@ -71,7 +71,7 @@ unchanged line
 CR at end
 EOF
 
-tr 'Q' '\015' << EOF > expect
+test-tr 'Q' '\015' << EOF > expect
 diff --git a/x b/x
 index d99af23..8b32fb5 100644
 --- a/x
@@ -99,7 +99,7 @@ EOF
 git diff -w > out
 test_expect_success 'another test, with -w' 'git diff expect out'
 
-tr 'Q' '\015' << EOF > expect
+test-tr 'Q' '\015' << EOF > expect
 diff --git a/x b/x
 index d99af23..8b32fb5 100644
 --- a/x
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 0d9cbb6..4967026 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -12,7 +12,7 @@ test_expect_success setup '
 	echo "         Eight SP indent" >>F &&
 	echo " 	HT and SP indent" >>F &&
 	echo "With trailing SP " >>F &&
-	echo "Carriage ReturnQ" | tr Q "\015" >>F &&
+	echo "Carriage ReturnQ" | test-tr Q "\015" >>F &&
 	echo "No problem" >>F
 
 '
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 637b4e1..3ae3165 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -99,7 +99,7 @@ test_expect_success 'no diff with -diff' '
 	git diff | grep Binary
 '
 
-echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
+echo NULZbetweenZwords | test-tr 'Z' '\000' > file
 
 test_expect_success 'force diff with "diff"' '
 	echo >.gitattributes "file diff" &&
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index bf996fc..01d221b 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -8,7 +8,7 @@ test_expect_success setup '
 
 	cat ../../COPYING >test &&
 	git add test &&
-	tr \
+	test-tr \
 	  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" \
 	  "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM" \
 	  <../../COPYING >test
diff --git a/t/t4101-apply-nonl.sh b/t/t4101-apply-nonl.sh
index da8abcf..53277e6 100755
--- a/t/t4101-apply-nonl.sh
+++ b/t/t4101-apply-nonl.sh
@@ -12,8 +12,8 @@ test_description='git apply should handle files with incomplete lines.
 
 (echo a; echo b) >frotz.0
 (echo a; echo b; echo c) >frotz.1
-(echo a; echo b | tr -d '\012') >frotz.2
-(echo a; echo c; echo b | tr -d '\012') >frotz.3
+(echo a; echo b | test-tr -d '\012') >frotz.2
+(echo a; echo c; echo b | test-tr -d '\012') >frotz.3
 
 for i in 0 1 2 3
 do
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 1b58233..f7542a0 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -24,10 +24,10 @@ git update-index --add --remove file1 file2 file4
 git-commit -m 'Initial Version' 2>/dev/null
 
 git-checkout -b binary
-perl -pe 'y/x/\000/' <file1 >file3
+test-tr x '\000' <file1 >file3
 cat file3 >file4
 git add file2
-perl -pe 'y/\000/v/' <file3 >file1
+test-tr '\000' v <file3 >file1
 rm -f file2
 git update-index --add --remove file1 file2 file3 file4
 git-commit -m 'Second Version'
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index c3f4579..bf01619 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -12,14 +12,14 @@ test_description='git apply in reverse
 test_expect_success setup '
 
 	for i in a b c d e f g h i j k l m n; do echo $i; done >file1 &&
-	perl -pe "y/ijk/\\000\\001\\002/" <file1 >file2 &&
+	test-tr "ijk" "\000\001\002" <file1 >file2 &&
 
 	git add file1 file2 &&
 	git commit -m initial &&
 	git tag initial &&
 
 	for i in a b c g h i J K L m o n p q; do echo $i; done >file1 &&
-	perl -pe "y/mon/\\000\\001\\002/" <file1 >file2 &&
+	test-tr "mon" "\000\001\002" <file1 >file2 &&
 
 	git commit -a -m second &&
 	git tag second &&
diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index 1d531ca..5083100 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -18,13 +18,13 @@ test_expect_success setup '
 	cat file1 >file1.orig &&
 	{
 		cat file1 &&
-		echo Q | tr -d "\\012"
+		echo Q | test-tr -d "\012"
 	} >file2 &&
 	cat file2 >file2.orig
 	git add file1 file2 &&
 	sed -e "/^B/d" <file1.orig >file1 &&
 	sed -e "/^[BQ]/d" <file2.orig >file2 &&
-	echo Q | tr -d "\\012" >>file2 &&
+	echo Q | test-tr -d "\012" >>file2 &&
 	cat file1 >file1.mods &&
 	cat file2 >file2.mods &&
 	git diff |
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 3cbfee7..58fc740 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -129,7 +129,7 @@ test_expect_success 'rerere kicked in' "! grep ======= a1"
 test_expect_success 'rerere prefers first change' 'git diff a1 expect'
 
 rm $rr/postimage
-echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/rr-cache/MERGE_RR
+echo "$sha1	a1" | test-tr '\012' '\000' > .git/rr-cache/MERGE_RR
 
 test_expect_success 'rerere clear' 'git rerere clear'
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 405b971..1a4b88d 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -19,12 +19,12 @@ git commit --quiet -m "This is a very, very long first line for the commit messa
 
 # test if the wrapping is still valid when replacing all i's by treble clefs.
 echo 3 > a1
-git commit --quiet -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\360\235\204\236')" a1
+git commit --quiet -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | test-tr 1234 '\360\235\204\236')" a1
 
 # now fsck up the utf8
 git config i18n.commitencoding non-utf-8
 echo 4 > a1
-git commit --quiet -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\370\235\204\236')" a1
+git commit --quiet -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | test-tr 1234 '\370\235\204\236')" a1
 
 echo 5 > a1
 git commit --quiet -m "a								12	34	56	78" a1
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index c955fe4..ba49742 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -15,7 +15,7 @@ test_expect_success \
     'rm -f .git/index*
      for i in a b c
      do
-	     dd if=/dev/zero bs=4k count=1 | perl -pe "y/\\000/$i/" >$i &&
+	     dd if=/dev/zero bs=4k count=1 | test-tr "\000" "$i" >$i &&
 	     git update-index --add $i || return 1
      done &&
      cat c >d && echo foo >>d && git update-index --add d &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 788b4a5..cda09b5 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -37,7 +37,7 @@ add () {
 }
 
 count_objects () {
-	ls .git/objects/??/* 2>>log2.txt | wc -l | tr -d " "
+	ls .git/objects/??/* 2>>log2.txt | wc -l | test-tr -d " "
 }
 
 test_expect_object_count () {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ecfc999..89f06b2 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -22,8 +22,8 @@ setup_repository () {
 }
 
 tokens_match () {
-	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
-	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
+	echo "$1" | test-tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
+	echo "$2" | test-tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
 	test_cmp expect actual
 }
 
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 5daa0be..5dbc6a7 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -79,7 +79,7 @@ save_tag g4 unique_commit g6 tree -p g3 -p h2
 
 git update-ref HEAD $(tag l5)
 
-test_output_expect_success 'rev-list has correct number of entries' 'git rev-list HEAD | wc -l | tr -d \" \"' <<EOF
+test_output_expect_success 'rev-list has correct number of entries' 'git rev-list HEAD | wc -l | test-tr -d \" \"' <<EOF
 19
 EOF
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 553131f..5c9bd2b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -4,7 +4,7 @@ test_description='git-filter-branch'
 . ./test-lib.sh
 
 make_commit () {
-	lower=$(echo $1 | tr '[A-Z]' '[a-z]')
+	lower=$(echo $1 | test-tr 'A-Z' 'a-z')
 	echo $lower > $lower
 	git add $lower
 	test_tick
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 42b144b..6b4358c 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -35,7 +35,7 @@ check_entries () {
 	then
 		>expected
 	else
-		printf '%s\n' "$2" | tr '|' '\012' >expected
+		printf '%s\n' "$2" | test-tr '|' '\012' >expected
 	fi
 	test_cmp expected actual
 }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 268b26c..4c7bf9a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -44,11 +44,16 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR VISUAL
 GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
 
+# Test the binaries we have just built.  The tests are kept in
+# t/ subdirectory and are run in trash subdirectory.
+PATH=$(pwd)/..:$PATH
+export PATH
+
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
 
-case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+case $(echo $GIT_TRACE |test-tr A-Z a-z) in
 	1|2|true)
 		echo "* warning: Some tests will not work if GIT_TRACE" \
 			"is set as to trace on STDERR ! *"
@@ -369,16 +374,13 @@ test_done () {
 	esac
 }
 
-# Test the binaries we have just built.  The tests are kept in
-# t/ subdirectory and are run in trash subdirectory.
-PATH=$(pwd)/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
 unset GIT_CONFIG_LOCAL
 GIT_CONFIG_NOSYSTEM=1
 GIT_CONFIG_NOGLOBAL=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
+export GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
 
 GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
 export GITPERLLIB
-- 
1.5.5.rc0.53.g97734
