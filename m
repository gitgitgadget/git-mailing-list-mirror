From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Style fixes for pre-commit hook tests
Date: Mon, 10 Dec 2007 08:42:45 +0100
Message-ID: <1197272565-5588-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 08:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1dIH-0006x0-5l
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 08:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbXLJHmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 02:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXLJHmw
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 02:42:52 -0500
Received: from wincent.com ([72.3.236.74]:38308 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbXLJHmw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 02:42:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBA7gk9D019604;
	Mon, 10 Dec 2007 01:42:47 -0600
X-Mailer: git-send-email 1.5.3.7.1116.gf11de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67690>

As pointed out by Junio on the mailing list, surrounding tests in
double quotes can lead to bugs wherein variables get substituted away,
so this isn't just style churn but important to prevent others from
looking at these tests in the future and thinking that this is "the
way" that Git tests should be written.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 t/t7503-pre-commit-hook.sh |   90 ++++++++++++++++++++++++++++----------------
 1 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index c8097a7..d787cac 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -4,15 +4,21 @@ test_description='pre-commit hook'
 
 . ./test-lib.sh
 
-test_expect_success "with no hook" \
-	"echo 'foo' > file &&
-	 git add file &&
-	 git commit -m 'first'"
+test_expect_success 'with no hook' '
 
-test_expect_success "--no-verify with no hook" \
-	"echo 'bar' > file &&
-	 git add file &&
-	 git commit --no-verify -m 'bar'"
+	echo "foo" > file &&
+	git add file &&
+	git commit -m "first"
+
+'
+
+test_expect_success '--no-verify with no hook' '
+
+	echo "bar" > file &&
+	git add file &&
+	git commit --no-verify -m "bar"
+
+'
 
 # now install hook that always succeeds
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
@@ -24,15 +30,21 @@ exit 0
 EOF
 chmod +x "$HOOK"
 
-test_expect_success "with succeeding hook" \
-	"echo 'more' >> file &&
-	 git add file &&
-	 git commit -m 'more'"
+test_expect_success 'with succeeding hook' '
+
+	echo "more" >> file &&
+	git add file &&
+	git commit -m "more"
 
-test_expect_success "--no-verify with succeeding hook" \
-	"echo 'even more' >> file &&
-	 git add file &&
-	 git commit --no-verify -m 'even more'"
+'
+
+test_expect_success '--no-verify with succeeding hook' '
+
+	echo "even more" >> file &&
+	git add file &&
+	git commit --no-verify -m "even more"
+
+'
 
 # now a hook that fails
 cat > "$HOOK" <<EOF
@@ -40,25 +52,37 @@ cat > "$HOOK" <<EOF
 exit 1
 EOF
 
-test_expect_failure "with failing hook" \
-	"echo 'another' >> file &&
-	 git add file &&
-	 git commit -m 'another'"
+test_expect_failure 'with failing hook' '
+
+	echo "another" >> file &&
+	git add file &&
+	git commit -m "another"
 
-test_expect_success "--no-verify with failing hook" \
-	"echo 'stuff' >> file &&
-	 git add file &&
-	 git commit --no-verify -m 'stuff'"
+'
+
+test_expect_success '--no-verify with failing hook' '
+
+	echo "stuff" >> file &&
+	git add file &&
+	git commit --no-verify -m "stuff"
+
+'
 
 chmod -x "$HOOK"
-test_expect_success "with non-executable hook" \
-	"echo 'content' >> file &&
-	 git add file &&
-	 git commit -m 'content'"
-
-test_expect_success "--no-verify with non-executable hook" \
-	"echo 'more content' >> file &&
-	 git add file &&
-	 git commit --no-verify -m 'more content'"
+test_expect_success 'with non-executable hook' '
+
+	echo "content" >> file &&
+	git add file &&
+	git commit -m "content"
+
+'
+
+test_expect_success '--no-verify with non-executable hook' '
+
+	echo "more content" >> file &&
+	git add file &&
+	git commit --no-verify -m "more content"
+
+'
 
 test_done
-- 
1.5.3.7.1116.gf11de
