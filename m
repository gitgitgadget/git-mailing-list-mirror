From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] t5403-post-checkout-hook.sh: make test operands posix
Date: Tue, 9 Oct 2007 12:51:30 +0000
Message-ID: <20071009125130.1343.qmail@bcafc83cd51c05.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 14:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEYo-000438-TO
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbXJIMvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbXJIMvM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:51:12 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:56388 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753080AbXJIMvK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:51:10 -0400
Received: (qmail 1344 invoked by uid 1000); 9 Oct 2007 12:51:30 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60399>

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 t/t5403-post-checkout-hook.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 487abf3..823239a 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -39,7 +39,7 @@ test_expect_success 'post-checkout receives the right arguments with HEAD unchan
         old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old = $new -a $flag == 1
+        test $old = $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout runs as expected ' '
@@ -52,7 +52,7 @@ test_expect_success 'post-checkout args are correct with git checkout -b ' '
         old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old = $new -a $flag == 1
+        test $old = $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
@@ -60,7 +60,7 @@ test_expect_success 'post-checkout receives the right args with HEAD changed ' '
         old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old != $new -a $flag == 1
+        test $old != $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
@@ -68,7 +68,7 @@ test_expect_success 'post-checkout receives the right args when not switching br
         old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old == $new -a $flag == 0
+        test $old = $new -a $flag = 0
 '
 
 test_done
-- 
1.5.3.4
