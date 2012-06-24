From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] Add C_LOCALE_OUTPUT prereq to test cases that require English text matching
Date: Sun, 24 Jun 2012 19:41:32 +0700
Message-ID: <1340541692-10834-2-git-send-email-pclouds@gmail.com>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 14:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SimCx-0004R7-F6
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 14:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab2FXMqX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jun 2012 08:46:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43553 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab2FXMqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 08:46:21 -0400
Received: by pbbrp8 with SMTP id rp8so5413174pbb.19
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=T3KbtdBRlUdwe019JMYrm7u/p8/F0Av0Pmlxbe0Ee2U=;
        b=xqz046H+Hjvwggr2IXrfWxXen8z8glgm1RqcXYODKPp5l3RZwGlVfSM4vzgYLvt4bF
         A6rAZWxldxLHuDFZUCwTHjNuVbk8ItOEaAhNLDkYsjPw2UICPNAk3zJYBROJJtYrqeI/
         ZcGmE4E0SulZPgIBV38otV6UPbQZymiDlRqtWOZiwQ28khbgunoPIljThXEa0Qc1M9Il
         qs81TSyhvdZ1iv8Xt9ifNw2UlTksRst1abB7HeAE6XijIjaP4lTgfCBr+ytVgJAZD+1F
         iI8Snu0QulRfMiiSZgR5hPSzM/FF+x39v99BPibOWeA5YhP8x7xjns8kgZC7aAOjXhIM
         G/Qg==
Received: by 10.68.116.203 with SMTP id jy11mr29326774pbb.129.1340541981328;
        Sun, 24 Jun 2012 05:46:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.50.32])
        by mx.google.com with ESMTPS id ka5sm5261917pbb.37.2012.06.24.05.46.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 05:46:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Jun 2012 19:41:39 +0700
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200527>

This fixes all GETTEXT_POISON breakages caused by recent i18n changes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0006-date.sh                 |    6 +++---
 t/t0040-parse-options.sh        |    8 ++++----
 t/t1300-repo-config.sh          |    2 +-
 t/t1502-rev-parse-parseopt.sh   |    2 +-
 t/t2006-checkout-index-basic.sh |    4 ++--
 t/t2107-update-index-basic.sh   |    4 ++--
 t/t3004-ls-files-basic.sh       |    4 ++--
 t/t3200-branch.sh               |    4 ++--
 t/t3501-revert-cherry-pick.sh   |    4 ++--
 t/t4006-diff-mode.sh            |    8 ++++----
 t/t4012-diff-binary.sh          |    4 ++--
 t/t4120-apply-popt.sh           |    4 ++--
 t/t4133-apply-filenames.sh      |    2 +-
 t/t4200-rerere.sh               |    4 ++--
 t/t4202-log.sh                  |    2 +-
 t/t5300-pack-object.sh          |    2 +-
 t/t5505-remote.sh               |   16 ++++++++--------
 t/t6500-gc.sh                   |    4 ++--
 t/t7508-status.sh               |    2 +-
 t/t7600-merge.sh                |    2 +-
 20 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 1d29810..3de3c8f 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -9,7 +9,7 @@ TEST_DATE_NOW=3D1251660000; export TEST_DATE_NOW
 check_show() {
 	t=3D$(($TEST_DATE_NOW - $1))
 	echo "$t -> $2" >expect
-	test_expect_${3:-success} "relative date ($2)" "
+	test_expect_${3:-success} C_LOCALE_OUTPUT "relative date ($2)" "
 	test-date show $t >actual &&
 	test_cmp expect actual
 	"
@@ -29,7 +29,7 @@ check_show 62985600 '2 years ago'
=20
 check_parse() {
 	echo "$1 -> $2" >expect
-	test_expect_${4:-success} "parse date ($1${3:+ TZ=3D$3})" "
+	test_expect_${4:-success} C_LOCALE_OUTPUT "parse date ($1${3:+ TZ=3D$=
3})" "
 	TZ=3D${3:-$TZ} test-date parse '$1' >actual &&
 	test_cmp expect actual
 	"
@@ -50,7 +50,7 @@ check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:4=
5 -0500' EST5
=20
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect
-	test_expect_${3:-success} "parse approxidate ($1)" "
+	test_expect_${3:-success} C_LOCALE_OUTPUT "parse approxidate ($1)" "
 	test-date approxidate '$1' >actual &&
 	test_cmp expect actual
 	"
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index e3f354a..790428d 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -48,7 +48,7 @@ Standard options
=20
 EOF
=20
-test_expect_success 'test help' '
+test_expect_success C_LOCALE_OUTPUT 'test help' '
 	test_must_fail test-parse-options -h > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
@@ -104,8 +104,8 @@ test_expect_success 'OPT_BOOL() is idempotent #2' '=
check boolean: 1 -DB'
 test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --no=
-yes'
 test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no=
-no-doubt'
=20
-test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown --fear'
-test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown --no-no=
-fear'
+test_expect_success C_LOCALE_OUTPUT 'OPT_BOOL() no negation #1' 'check=
_unknown --fear'
+test_expect_success C_LOCALE_OUTPUT 'OPT_BOOL() no negation #2' 'check=
_unknown --no-no-fear'
=20
 test_expect_success 'OPT_BOOL() positivation' 'check boolean: 0 -D --d=
oubt'
=20
@@ -308,7 +308,7 @@ cat > expect <<EOF
 Callback: "not set", 1
 EOF
=20
-test_expect_success 'OPT_CALLBACK() and callback errors work' '
+test_expect_success C_LOCALE_OUTPUT 'OPT_CALLBACK() and callback error=
s work' '
 	test_must_fail test-parse-options --no-length > output 2> output.err =
&&
 	test_cmp expect output &&
 	test_cmp expect.err output.err
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index a477453..13953dc 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -389,7 +389,7 @@ test_expect_success 'get bool variable with empty v=
alue' \
 	'git config --bool emptyvalue.variable > output &&
 	 cmp output expect'
=20
-test_expect_success 'no arguments, but no crash' '
+test_expect_success C_LOCALE_OUTPUT 'no arguments, but no crash' '
 	test_must_fail git config >output 2>&1 &&
 	grep usage output
 '
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
=2Esh
index 1efd7f7..2b283ba 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -39,7 +39,7 @@ Extras
 extra1    line above used to cause a segfault but no longer does
 EOF
=20
-test_expect_success 'test --parseopt help output' '
+test_expect_success C_LOCALE_OUTPUT 'test --parseopt help output' '
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < option=
spec &&
 	test_cmp expect output
 '
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-b=
asic.sh
index b855983..3f75462 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -5,12 +5,12 @@ test_description=3D'basic checkout-index tests
=20
 . ./test-lib.sh
=20
-test_expect_success 'checkout-index --gobbledegook' '
+test_expect_success C_LOCALE_OUTPUT 'checkout-index --gobbledegook' '
 	test_expect_code 129 git checkout-index --gobbledegook 2>err &&
 	grep "[Uu]sage" err
 '
=20
-test_expect_success 'checkout-index -h in broken repository' '
+test_expect_success C_LOCALE_OUTPUT 'checkout-index -h in broken repos=
itory' '
 	mkdir broken &&
 	(
 		cd broken &&
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic=
=2Esh
index 809fafe..36f2ebf 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -13,12 +13,12 @@ test_expect_success 'update-index --nonsense fails'=
 '
 	test -s msg
 '
=20
-test_expect_success 'update-index --nonsense dumps usage' '
+test_expect_success C_LOCALE_OUTPUT 'update-index --nonsense dumps usa=
ge' '
 	test_expect_code 129 git update-index --nonsense 2>err &&
 	grep "[Uu]sage: git update-index" err
 '
=20
-test_expect_success 'update-index -h with corrupt index' '
+test_expect_success C_LOCALE_OUTPUT 'update-index -h with corrupt inde=
x' '
 	mkdir broken &&
 	(
 		cd broken &&
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 490e052..2feeb60 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -20,12 +20,12 @@ test_expect_success 'ls-files with nonexistent path=
' '
 	test_cmp empty actual
 '
=20
-test_expect_success 'ls-files with nonsense option' '
+test_expect_success C_LOCALE_OUTPUT 'ls-files with nonsense option' '
 	test_expect_code 129 git ls-files --nonsense 2>actual &&
 	grep "[Uu]sage: git ls-files" actual
 '
=20
-test_expect_success 'ls-files -h in corrupt repository' '
+test_expect_success C_LOCALE_OUTPUT 'ls-files -h in corrupt repository=
' '
 	mkdir broken &&
 	(
 		cd broken &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a17f8b2..4b24cf8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -23,7 +23,7 @@ test_expect_success \
      test_path_is_missing .git/refs/heads/--help
 '
=20
-test_expect_success 'branch -h in broken repository' '
+test_expect_success C_LOCALE_OUTPUT 'branch -h in broken repository' '
 	mkdir broken &&
 	(
 		cd broken &&
@@ -71,7 +71,7 @@ test_expect_success \
         git branch -d l/m &&
         git branch l'
=20
-test_expect_success \
+test_expect_success C_LOCALE_OUTPUT \
     'git branch -m dumps usage' \
        'test_expect_code 129 git branch -m 2>err &&
 	grep "[Uu]sage: git branch" err'
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick=
=2Esh
index 595d2ff..9b4b860 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -41,7 +41,7 @@ test_expect_success setup '
 	git tag rename2
 '
=20
-test_expect_success 'cherry-pick --nonsense' '
+test_expect_success C_LOCALE_OUTPUT 'cherry-pick --nonsense' '
=20
 	pos=3D$(git rev-parse HEAD) &&
 	git diff --exit-code HEAD &&
@@ -50,7 +50,7 @@ test_expect_success 'cherry-pick --nonsense' '
 	grep '[Uu]sage:' msg
 '
=20
-test_expect_success 'revert --nonsense' '
+test_expect_success C_LOCALE_OUTPUT 'revert --nonsense' '
=20
 	pos=3D$(git rev-parse HEAD) &&
 	git diff --exit-code HEAD &&
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 7a3e1f9..135327e 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -32,26 +32,26 @@ test_expect_success 'prepare binary file' '
 	git commit -m binbin
 '
=20
-test_expect_success '--stat output after text chmod' '
+test_expect_success C_LOCALE_OUTPUT '--stat output after text chmod' '
 	test_chmod -x rezrov &&
 	echo " 0 files changed" >expect &&
 	git diff HEAD --stat >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success '--shortstat output after text chmod' '
+test_expect_success C_LOCALE_OUTPUT '--shortstat output after text chm=
od' '
 	git diff HEAD --shortstat >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success '--stat output after binary chmod' '
+test_expect_success C_LOCALE_OUTPUT '--stat output after binary chmod'=
 '
 	test_chmod +x binbin &&
 	echo " 0 files changed" >expect &&
 	git diff HEAD --stat >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success '--shortstat output after binary chmod' '
+test_expect_success C_LOCALE_OUTPUT '--shortstat output after binary c=
hmod' '
 	git diff HEAD --shortstat >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 6cebb39..6764a7c 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -62,7 +62,7 @@ test_expect_success 'apply --numstat understands diff=
 --binary format' '
=20
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
-test_expect_success 'apply detecting corrupt patch correctly' \
+test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch cor=
rectly' \
 	'git diff | sed -e 's/-CIT/xCIT/' >broken &&
 	 if git apply --stat --summary broken 2>detected
 	 then
@@ -76,7 +76,7 @@ test_expect_success 'apply detecting corrupt patch co=
rrectly' \
 	 detected=3D`sed -ne "${detected}p" broken` &&
 	 test "$detected" =3D xCIT'
=20
-test_expect_success 'apply detecting corrupt patch correctly' \
+test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch cor=
rectly' \
 	'git diff --binary | sed -e 's/-CIT/xCIT/' >broken &&
 	 if git apply --stat --summary broken 2>detected
 	 then
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index a33d510..90d5313 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -29,7 +29,7 @@ test_expect_success 'apply git diff with -p2' '
 	git apply -p2 patch.file
 '
=20
-test_expect_success 'apply with too large -p' '
+test_expect_success C_LOCALE_OUTPUT 'apply with too large -p' '
 	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.file 2>err &&
 	grep "removing 3 leading" err
@@ -51,7 +51,7 @@ test_expect_success 'apply (-p2) traditional diff wit=
h funny filenames' '
 	test_cmp expected file1
 '
=20
-test_expect_success 'apply with too large -p and fancy filename' '
+test_expect_success C_LOCALE_OUTPUT 'apply with too large -p and fancy=
 filename' '
 	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.escaped 2>err &&
 	grep "removing 3 leading" err
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 94da990..94b0233 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -28,7 +28,7 @@ index d00491f..0000000
 EOF
 '
=20
-test_expect_success 'apply diff with inconsistent filenames in headers=
' '
+test_expect_success C_LOCALE_OUTPUT 'apply diff with inconsistent file=
names in headers' '
 	test_must_fail git apply bad1.patch 2>err &&
 	grep "inconsistent new filename" err &&
 	test_must_fail git apply bad2.patch 2>err &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 36255d6..937b217 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -377,7 +377,7 @@ test_expect_success 'explicit rerere --rerere-autou=
pdate overrides' '
 	test_cmp expected.unresolved actual2
 '
=20
-test_expect_success 'rerere --no-no-rerere-autoupdate' '
+test_expect_success C_LOCALE_OUTPUT 'rerere --no-no-rerere-autoupdate'=
 '
 	git rm -fr --cached . &&
 	git update-index --index-info <failedmerge &&
 	cp file3.conflict file3 &&
@@ -386,7 +386,7 @@ test_expect_success 'rerere --no-no-rerere-autoupda=
te' '
 	test_must_fail git update-index --refresh
 '
=20
-test_expect_success 'rerere -h' '
+test_expect_success C_LOCALE_OUTPUT 'rerere -h' '
 	test_must_fail git rerere -h >help &&
 	grep [Uu]sage help
 '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 71be59d..dc7d2e1 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -800,7 +800,7 @@ sanitize_output () {
 	    -e 's/, 1 insertions(+)/, 1 insertion(+)/'
 }
=20
-test_expect_success 'log --graph with diff and stats' '
+test_expect_success C_LOCALE_OUTPUT 'log --graph with diff and stats' =
'
 	git log --graph --pretty=3Dshort --stat -p >actual &&
 	sanitize_output >actual.sanitized <actual &&
 	test_cmp expect actual.sanitized
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d9d856b..da54924 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -413,7 +413,7 @@ test_expect_success \
      cp -f	.git/objects/9d/235ed07cd19811a6ceb342de82f190e49c9f68 \
 		.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67'
=20
-test_expect_success \
+test_expect_success C_LOCALE_OUTPUT \
     'make sure index-pack detects the SHA1 collision' \
     'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
      grep "SHA1 COLLISION FOUND" msg'
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e8af615..f632262 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -24,7 +24,7 @@ setup_repository () {
 tokens_match () {
 	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
 	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 }
=20
 check_remote_track () {
@@ -131,8 +131,8 @@ EOF
 	git remote rm oops 2>actual2 &&
 	git branch -d foobranch &&
 	git tag -d footag &&
-	test_cmp expect1 actual1 &&
-	test_cmp expect2 actual2
+	test_i18ncmp expect1 actual1 &&
+	test_i18ncmp expect2 actual2
 )
 '
=20
@@ -192,7 +192,7 @@ test_expect_success 'show' '
 	 git config --add remote.two.push refs/heads/master:refs/heads/anothe=
r &&
 	 git remote show origin two > output &&
 	 git branch -d rebase octopus &&
-	 test_cmp expect output)
+	 test_i18ncmp expect output)
 '
=20
 cat > test/expect << EOF
@@ -217,7 +217,7 @@ test_expect_success 'show -n' '
 	 cd test &&
 	 git remote show -n origin > output &&
 	 mv ../one.unreachable ../one &&
-	 test_cmp expect output)
+	 test_i18ncmp expect output)
 '
=20
 test_expect_success 'prune' '
@@ -255,7 +255,7 @@ EOF
 test_expect_success 'set-head --auto fails w/multiple HEADs' '
 	(cd test &&
 	 test_must_fail git remote set-head --auto two >output 2>&1 &&
-	test_cmp expect output)
+	test_i18ncmp expect output)
 '
=20
 cat >test/expect <<EOF
@@ -285,7 +285,7 @@ test_expect_success 'prune --dry-run' '
 	 test_must_fail git rev-parse refs/remotes/origin/side &&
 	(cd ../one &&
 	 git branch -m side side2) &&
-	 test_cmp expect output)
+	 test_i18ncmp expect output)
 '
=20
 test_expect_success 'add --mirror && prune' '
@@ -694,7 +694,7 @@ test_expect_success 'migrate a remote from named fi=
le in $GIT_DIR/branches' '
 	 test "$(git config remote.origin.fetch)" =3D "refs/heads/master:refs=
/heads/origin")
 '
=20
-test_expect_success 'remote prune to cause a dangling symref' '
+test_expect_success C_LOCALE_OUTPUT 'remote prune to cause a dangling =
symref' '
 	git clone one seven &&
 	(
 		cd one &&
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 82f3639..00a7a5b 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -9,12 +9,12 @@ test_expect_success 'gc empty repository' '
 	git gc
 '
=20
-test_expect_success 'gc --gobbledegook' '
+test_expect_success C_LOCALE_OUTPUT 'gc --gobbledegook' '
 	test_expect_code 129 git gc --nonsense 2>err &&
 	grep "[Uu]sage: git gc" err
 '
=20
-test_expect_success 'gc -h with invalid configuration' '
+test_expect_success C_LOCALE_OUTPUT 'gc -h with invalid configuration'=
 '
 	mkdir broken &&
 	(
 		cd broken &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 28e1848..c3ca2ef 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -59,7 +59,7 @@ test_expect_success 'status (1)' '
 	test_i18ngrep "use \"git rm --cached <file>\.\.\.\" to unstage" outpu=
t
 '
=20
-test_expect_success 'status --column' '
+test_expect_success C_LOCALE_OUTPUT 'status --column' '
 	COLUMNS=3D50 git status --column=3D"column dense" >output &&
 	cat >expect <<\EOF &&
 # On branch master
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9e27bbf..eebab61 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -149,7 +149,7 @@ test_expect_success 'test option parsing' '
 	test_must_fail git merge
 '
=20
-test_expect_success 'merge -h with invalid index' '
+test_expect_success C_LOCALE_OUTPUT 'merge -h with invalid index' '
 	mkdir broken &&
 	(
 		cd broken &&
--=20
1.7.8
