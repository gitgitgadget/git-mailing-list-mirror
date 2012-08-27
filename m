From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 7/7] Fix tests under GETTEXT_POISON on parseopt
Date: Mon, 27 Aug 2012 13:36:55 +0800
Message-ID: <8aeb40680c05380fb3d49198434842c231af3b78.1346045253.git.worldhello.net@gmail.com>
References: <cover.1346045253.git.worldhello.net@gmail.com>
 <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
 <08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com>
 <7398781c6d647557954f4a0c7df29fc98aad842b.1346045253.git.worldhello.net@gmail.com>
 <d20c47e9618f998b84934c0310f3de51d791e83f.1346045253.git.worldhello.net@gmail.com>
 <a2e20a1e1ae4be42b763904177cf634a6e291f15.1346045253.git.worldhello.net@gmail.com>
 <f56c058cfd76d02ed42b0c5b7161bde6bd51ddd0.1346045253.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:37:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5s1G-00034k-8c
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 07:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab2H0Fhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 01:37:41 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57439 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2H0Fhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 01:37:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6802416pbb.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 22:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=YGfQCXNZcfCFjeJbN6mCFr/8fquhdueuwmxri0JnM4s=;
        b=Vndtik8XraJvMMIbNaUVXGXWeYFAsEwHHaFk1PqIFezcZN1MRnv8RCOsdzquAMg85K
         rLFVp1BpqrlfWZAEis53P/Upz1t1d0iFWYC8tPfNCUz/e5tMbyDgaUvTucETzNE+pf5r
         S6W7FPwlmCVbylRnGuQy3XkskflwbxqMETklspeaqTV+eQjkwRSCV//aPKmK6SOPRhuV
         XQ+TcID/ufdS15QOUBJSCJQgIZ2101s8acomyRz9lfC+2iGJ0UukEEsU/wZbcD5srgQv
         x8j11sTZZtCxMKbgA1Jo403d5EXlM3kuKIcKMOql9QQoH7nlF26yC36sfsnYew4F97Nq
         riYw==
Received: by 10.66.74.196 with SMTP id w4mr17005729pav.32.1346045859890;
        Sun, 26 Aug 2012 22:37:39 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.231.150])
        by mx.google.com with ESMTPS id gf3sm13924207pbc.74.2012.08.26.22.37.35
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 22:37:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.gaa91cb5
In-Reply-To: <f56c058cfd76d02ed42b0c5b7161bde6bd51ddd0.1346045253.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346045253.git.worldhello.net@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com> <cover.1346045253.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204326>

Use i18n-specific test functions in test scripts for parseopt tests.
This issue was was introduced in v1.7.10.1-488-g54e6d:

    54e6d i18n: parseopt: lookup help and argument translations when sh=
owing usage

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0040-parse-options.sh        | 34 +++++++++++++++++++++++++++++----=
-
 t/t1300-repo-config.sh          |  2 +-
 t/t1502-rev-parse-parseopt.sh   |  2 +-
 t/t2006-checkout-index-basic.sh |  4 ++--
 t/t2107-update-index-basic.sh   |  4 ++--
 t/t3004-ls-files-basic.sh       |  4 ++--
 t/t3200-branch.sh               |  4 ++--
 t/t3501-revert-cherry-pick.sh   |  4 ++--
 t/t4200-rerere.sh               |  4 ++--
 t/t6500-gc.sh                   |  4 ++--
 t/t7600-merge.sh                |  2 +-
 11 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index e3f35..244a4 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -51,7 +51,7 @@ EOF
 test_expect_success 'test help' '
 	test_must_fail test-parse-options -h > output 2> output.err &&
 	test ! -s output.err &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
=20
 mv expect expect.err
@@ -79,6 +79,17 @@ check() {
 	test_cmp expect output
 }
=20
+check_i18n() {
+	what=3D"$1" &&
+	shift &&
+	expect=3D"$1" &&
+	shift &&
+	sed "s/^$what .*/$what $expect/" <expect.template >expect &&
+	test-parse-options $* >output 2>output.err &&
+	test ! -s output.err &&
+	test_i18ncmp expect output
+}
+
 check_unknown() {
 	case "$1" in
 	--*)
@@ -92,6 +103,19 @@ check_unknown() {
 	test_cmp expect output.err
 }
=20
+check_unknown_i18n() {
+	case "$1" in
+	--*)
+		echo error: unknown option \`${1#--}\' >expect ;;
+	-*)
+		echo error: unknown switch \`${1#-}\' >expect ;;
+	esac &&
+	cat expect.err >>expect &&
+	test_must_fail test-parse-options $* >output 2>output.err &&
+	test ! -s output &&
+	test_i18ncmp expect output.err
+}
+
 test_expect_success 'OPT_BOOL() #1' 'check boolean: 1 --yes'
 test_expect_success 'OPT_BOOL() #2' 'check boolean: 1 --no-doubt'
 test_expect_success 'OPT_BOOL() #3' 'check boolean: 1 -D'
@@ -104,8 +128,8 @@ test_expect_success 'OPT_BOOL() is idempotent #2' '=
check boolean: 1 -DB'
 test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --no=
-yes'
 test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no=
-no-doubt'
=20
-test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown --fear'
-test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown --no-no=
-fear'
+test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown_i18n --=
fear'
+test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown_i18n --=
no-no-fear'
=20
 test_expect_success 'OPT_BOOL() positivation' 'check boolean: 0 -D --d=
oubt'
=20
@@ -310,8 +334,8 @@ EOF
=20
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
 	test_must_fail test-parse-options --no-length > output 2> output.err =
&&
-	test_cmp expect output &&
-	test_cmp expect.err output.err
+	test_i18ncmp expect output &&
+	test_i18ncmp expect.err output.err
 '
=20
 cat > expect <<EOF
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index a477..e127f 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -391,7 +391,7 @@ test_expect_success 'get bool variable with empty v=
alue' \
=20
 test_expect_success 'no arguments, but no crash' '
 	test_must_fail git config >output 2>&1 &&
-	grep usage output
+	test_i18ngrep usage output
 '
=20
 cat > .git/config << EOF
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
=2Esh
index 1efd7..13c88 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -41,7 +41,7 @@ EOF
=20
 test_expect_success 'test --parseopt help output' '
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < option=
spec &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
=20
 cat > expect <<EOF
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-b=
asic.sh
index b855..57cbd 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -7,7 +7,7 @@ test_description=3D'basic checkout-index tests
=20
 test_expect_success 'checkout-index --gobbledegook' '
 	test_expect_code 129 git checkout-index --gobbledegook 2>err &&
-	grep "[Uu]sage" err
+	test_i18ngrep "[Uu]sage" err
 '
=20
 test_expect_success 'checkout-index -h in broken repository' '
@@ -18,7 +18,7 @@ test_expect_success 'checkout-index -h in broken repo=
sitory' '
 		>.git/index &&
 		test_expect_code 129 git checkout-index -h >usage 2>&1
 	) &&
-	grep "[Uu]sage" broken/usage
+	test_i18ngrep "[Uu]sage" broken/usage
 '
=20
 test_done
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic=
=2Esh
index 809fa..17d69 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -15,7 +15,7 @@ test_expect_success 'update-index --nonsense fails' '
=20
 test_expect_success 'update-index --nonsense dumps usage' '
 	test_expect_code 129 git update-index --nonsense 2>err &&
-	grep "[Uu]sage: git update-index" err
+	test_i18ngrep "[Uu]sage: git update-index" err
 '
=20
 test_expect_success 'update-index -h with corrupt index' '
@@ -26,7 +26,7 @@ test_expect_success 'update-index -h with corrupt ind=
ex' '
 		>.git/index &&
 		test_expect_code 129 git update-index -h >usage 2>&1
 	) &&
-	grep "[Uu]sage: git update-index" broken/usage
+	test_i18ngrep "[Uu]sage: git update-index" broken/usage
 '
=20
 test_done
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 490e05..8d9bc 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -22,7 +22,7 @@ test_expect_success 'ls-files with nonexistent path' =
'
=20
 test_expect_success 'ls-files with nonsense option' '
 	test_expect_code 129 git ls-files --nonsense 2>actual &&
-	grep "[Uu]sage: git ls-files" actual
+	test_i18ngrep "[Uu]sage: git ls-files" actual
 '
=20
 test_expect_success 'ls-files -h in corrupt repository' '
@@ -33,7 +33,7 @@ test_expect_success 'ls-files -h in corrupt repositor=
y' '
 		>.git/index &&
 		test_expect_code 129 git ls-files -h >usage 2>&1
 	) &&
-	grep "[Uu]sage: git ls-files " broken/usage
+	test_i18ngrep "[Uu]sage: git ls-files " broken/usage
 '
=20
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a17f8..1ffce 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -31,7 +31,7 @@ test_expect_success 'branch -h in broken repository' =
'
 		>.git/refs/heads/master &&
 		test_expect_code 129 git branch -h >usage 2>&1
 	) &&
-	grep "[Uu]sage" broken/usage
+	test_i18ngrep "[Uu]sage" broken/usage
 '
=20
 test_expect_success \
@@ -74,7 +74,7 @@ test_expect_success \
 test_expect_success \
     'git branch -m dumps usage' \
        'test_expect_code 129 git branch -m 2>err &&
-	grep "[Uu]sage: git branch" err'
+	test_i18ngrep "[Uu]sage: git branch" err'
=20
 test_expect_success \
     'git branch -m m m/m should work' \
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick=
=2Esh
index 595d2..34c86e 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -47,7 +47,7 @@ test_expect_success 'cherry-pick --nonsense' '
 	git diff --exit-code HEAD &&
 	test_must_fail git cherry-pick --nonsense 2>msg &&
 	git diff --exit-code HEAD "$pos" &&
-	grep '[Uu]sage:' msg
+	test_i18ngrep '[Uu]sage:' msg
 '
=20
 test_expect_success 'revert --nonsense' '
@@ -56,7 +56,7 @@ test_expect_success 'revert --nonsense' '
 	git diff --exit-code HEAD &&
 	test_must_fail git revert --nonsense 2>msg &&
 	git diff --exit-code HEAD "$pos" &&
-	grep '[Uu]sage:' msg
+	test_i18ngrep '[Uu]sage:' msg
 '
=20
 test_expect_success 'cherry-pick after renaming branch' '
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 3ab67..7f666 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -382,13 +382,13 @@ test_expect_success 'rerere --no-no-rerere-autoup=
date' '
 	git update-index --index-info <failedmerge &&
 	cp file3.conflict file3 &&
 	test_must_fail git rerere --no-no-rerere-autoupdate 2>err &&
-	grep [Uu]sage err &&
+	test_i18ngrep [Uu]sage err &&
 	test_must_fail git update-index --refresh
 '
=20
 test_expect_success 'rerere -h' '
 	test_must_fail git rerere -h >help &&
-	grep [Uu]sage help
+	test_i18ngrep [Uu]sage help
 '
=20
 test_done
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 82f36..b1a63 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -11,7 +11,7 @@ test_expect_success 'gc empty repository' '
=20
 test_expect_success 'gc --gobbledegook' '
 	test_expect_code 129 git gc --nonsense 2>err &&
-	grep "[Uu]sage: git gc" err
+	test_i18ngrep "[Uu]sage: git gc" err
 '
=20
 test_expect_success 'gc -h with invalid configuration' '
@@ -22,7 +22,7 @@ test_expect_success 'gc -h with invalid configuration=
' '
 		echo "[gc] pruneexpire =3D CORRUPT" >>.git/config &&
 		test_expect_code 129 git gc -h >usage 2>&1
 	) &&
-	grep "[Uu]sage" broken/usage
+	test_i18ngrep "[Uu]sage" broken/usage
 '
=20
 test_done
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9e27b..5e195 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -157,7 +157,7 @@ test_expect_success 'merge -h with invalid index' '
 		>.git/index &&
 		test_expect_code 129 git merge -h 2>usage
 	) &&
-	grep "[Uu]sage: git merge" broken/usage
+	test_i18ngrep "[Uu]sage: git merge" broken/usage
 '
=20
 test_expect_success 'reject non-strategy with a git-merge-foo name' '
--=20
1.7.12.92.gaa91cb5
