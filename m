From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t4014: fix for whitespace from "wc -l"
Date: Tue, 27 Jun 2006 10:12:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606271011500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 27 10:12:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv8gI-00080i-Ve
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 10:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030752AbWF0IMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 04:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030750AbWF0IMQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 04:12:16 -0400
Received: from mail.gmx.net ([213.165.64.21]:41858 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030752AbWF0IMO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 04:12:14 -0400
Received: (qmail invoked by alias); 27 Jun 2006 08:12:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 27 Jun 2006 10:12:13 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22711>


Some "wc" insist on putting a TAB in front of the number.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/t4014-format-patch.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c044044..ac2fde7 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -37,7 +37,7 @@ test_expect_success "format-patch --igno
 
 	git format-patch --stdout master..side >patch0 &&
 	cnt=`grep "^From " patch0 | wc -l` &&
-	test "$cnt" = 3
+	test $cnt = 3
 
 '
 
@@ -46,7 +46,7 @@ test_expect_success "format-patch --igno
 	git format-patch --stdout \
 		--ignore-if-in-upstream master..side >patch1 &&
 	cnt=`grep "^From " patch1 | wc -l` &&
-	test "$cnt" = 2
+	test $cnt = 2
 
 '
 
@@ -55,7 +55,7 @@ test_expect_success "format-patch result
 	git checkout -b rebuild-0 master &&
 	git am -3 patch0 &&
 	cnt=`git rev-list master.. | wc -l` &&
-	test "$cnt" = 2
+	test $cnt = 2
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream result applies" '
@@ -63,7 +63,7 @@ test_expect_success "format-patch --igno
 	git checkout -b rebuild-1 master &&
 	git am -3 patch1 &&
 	cnt=`git rev-list master.. | wc -l` &&
-	test "$cnt" = 2
+	test $cnt = 2
 '
 
 test_done
-- 
1.4.1.rc1.ga1a38
