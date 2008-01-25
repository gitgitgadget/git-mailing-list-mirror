From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Fri, 25 Jan 2008 18:25:07 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251824010.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 26 00:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIXw7-0006nZ-EJ
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 00:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbYAYXZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 18:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbYAYXZL
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 18:25:11 -0500
Received: from iabervon.org ([66.92.72.58]:45119 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbYAYXZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 18:25:09 -0500
Received: (qmail 4478 invoked by uid 1000); 25 Jan 2008 23:25:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2008 23:25:07 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71752>

If the test failed, it was giving really unclear ed script
output. Instead, give a diff that sort of suggests the problem.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 t/t7201-co.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 73d8a00..c6f93a9 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -143,7 +143,7 @@ test_expect_success "checkout -m with dirty tree, renamed" '
 
 	git checkout -m renamer &&
 	fill 1 3 4 5 7 8 >expect &&
-	diff expect uno &&
+	git diff expect uno &&
 	! test -f one &&
 	git diff --cached >current &&
 	! test -s current
@@ -168,7 +168,7 @@ test_expect_success 'checkout -m with merge conflict' '
 	git diff master:one :3:uno |
 	sed -e "1,/^@@/d" -e "/^ /d" -e "s/^-/d/" -e "s/^+/a/" >current &&
 	fill d2 aT d7 aS >expect &&
-	diff current expect &&
+	git diff current expect &&
 	git diff --cached two >current &&
 	! test -s current
 '
-- 
1.5.4.rc3.4.g16335
