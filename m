From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/5] fix whitespace violations in test scripts
Date: Sat, 14 Jun 2008 03:25:56 -0400
Message-ID: <20080614072556.GA17536@sigill.intra.peff.net>
References: <20080614072214.GA9975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:26:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7QA1-0007ln-Vf
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYFNHZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbYFNHZ7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:25:59 -0400
Received: from peff.net ([208.65.91.99]:2063 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbYFNHZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:25:58 -0400
Received: (qmail 30816 invoked by uid 111); 14 Jun 2008 07:25:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 03:25:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 03:25:56 -0400
Content-Disposition: inline
In-Reply-To: <20080614072214.GA9975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84979>

These violations are simply wrong, but were never caught
because whitespace policy checking is turned off in the test
scripts.

Signed-off-by: Jeff King <peff@peff.net>
---
The original was total crap. t1502 didn't pass (which is now fixed in
3/4), and t3800 didn't pass (which is fixed correctly and lumped into
2/4 now).

 t/t3903-stash.sh        |    2 +-
 t/t4014-format-patch.sh |    6 +++---
 t/t4150-am.sh           |    2 +-
 t/t5540-http-push.sh    |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2d3ee3b..54d99ed 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -41,7 +41,7 @@ test_expect_success 'apply needs clean working directory' '
 	echo 4 > other-file &&
 	git add other-file &&
 	echo 5 > other-file &&
- 	test_must_fail git stash apply
+	test_must_fail git stash apply
 '
 
 test_expect_success 'apply stashed changes' '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3583e68..7fe853c 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -98,7 +98,7 @@ test_expect_success 'extra headers' '
 	sed -e "/^$/q" patch2 > hdrs2 &&
 	grep "^To: R. E. Cipient <rcipient@example.com>$" hdrs2 &&
 	grep "^Cc: S. E. Cipient <scipient@example.com>$" hdrs2
-	
+
 '
 
 test_expect_success 'extra headers without newlines' '
@@ -109,7 +109,7 @@ test_expect_success 'extra headers without newlines' '
 	sed -e "/^$/q" patch3 > hdrs3 &&
 	grep "^To: R. E. Cipient <rcipient@example.com>$" hdrs3 &&
 	grep "^Cc: S. E. Cipient <scipient@example.com>$" hdrs3
-	
+
 '
 
 test_expect_success 'extra headers with multiple To:s' '
@@ -170,7 +170,7 @@ test_expect_success 'thread cover-letter' '
 	git checkout side &&
 	git format-patch --cover-letter --thread -o patches/ master &&
 	FIRST_MID=$(grep "Message-Id:" patches/0000-* | sed "s/^[^<]*\(<[^>]*>\).*$/\1/") &&
-	for i in patches/0001-* patches/0002-* patches/0003-* 
+	for i in patches/0001-* patches/0002-* patches/0003-*
 	do
 	  grep "References: $FIRST_MID" $i &&
 	  grep "In-Reply-To: $FIRST_MID" $i || break
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 722ae96..bc98260 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -110,7 +110,7 @@ test_expect_success 'am applies patch correctly' '
 
 GIT_AUTHOR_NAME="Another Thor"
 GIT_AUTHOR_EMAIL="a.thor@example.com"
-GIT_COMMITTER_NAME="Co M Miter" 
+GIT_COMMITTER_NAME="Co M Miter"
 GIT_COMMITTER_EMAIL="c.miter@example.com"
 export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
 
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 7372439..f15dd03 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -38,7 +38,7 @@ test_expect_success 'setup remote repository' '
 	cd - &&
 	mv test_repo.git $HTTPD_DOCUMENT_ROOT_PATH
 '
-	
+
 test_expect_success 'clone remote repository' '
 	cd "$ROOT_PATH" &&
 	git clone $HTTPD_URL/test_repo.git test_repo_clone
-- 
1.5.6.rc2.183.g04614
