From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] test-lib: separate individual test better in verbose mode.
Date: Sat, 7 Oct 2006 21:27:46 +0200
Message-ID: <20061007192746.GZ2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 07 21:28:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWHqH-0007rd-BQ
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 21:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbWJGT1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 15:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbWJGT1s
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 15:27:48 -0400
Received: from agent.admingilde.org ([213.95.21.5]:23199 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932783AbWJGT1r
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 15:27:47 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GWHpq-0003l9-Nk
	for git@vger.kernel.org; Sat, 07 Oct 2006 21:27:46 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28501>

When running tests with --verbose it is difficult to see where
one test starts and where it ends because everything is printed
in one big lump.
Fix that by printing one single newline between each test.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 t/test-lib.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b523fef..2488e6e 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -135,6 +135,7 @@ test_expect_failure () {
 	else
 		test_failure_ "$@"
 	fi
+	echo >&3 ""
 }
 
 test_expect_success () {
@@ -148,6 +149,7 @@ test_expect_success () {
 	else
 		test_failure_ "$@"
 	fi
+	echo >&3 ""
 }
 
 test_expect_code () {
@@ -161,6 +163,7 @@ test_expect_code () {
 	else
 		test_failure_ "$@"
 	fi
+	echo >&3 ""
 }
 
 # Most tests can use the created repository, but some amy need to create more.
-- 
1.4.2.3

-- 
Martin Waitz
