From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] gitk: allow diff view without context lines
Date: Sat, 23 May 2009 19:31:37 +0200
Message-ID: <1243099897-5530-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat May 23 19:32:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7v5U-0003ft-RQ
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 19:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbZEWRbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 13:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbZEWRbu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 13:31:50 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52508 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbZEWRbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 13:31:50 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 301E9FE11BDA;
	Sat, 23 May 2009 19:31:51 +0200 (CEST)
Received: from [89.59.125.192] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M7v4Z-0006GY-00; Sat, 23 May 2009 19:31:51 +0200
X-Mailer: git-send-email 1.6.3.1.160.g45b30
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/FSMEMTTyKt2Bqe51iUCmSscwuoVVYzxg4Ucpp
	/C7ifVuv9rEBA1T2i/l4zgxMU4eVJ/5qFuSPFIdAimdpOvJ6xU
	NTQ8JTdD758AaQefiuyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119780>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 1855390..322a442 100755
--- a/gitk
+++ b/gitk
@@ -2145,7 +2145,7 @@ proc makewindow {} {
     label .bleft.mid.labeldiffcontext -text "      [mc "Lines of context"]: "
     pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
     spinbox .bleft.mid.diffcontext -width 5 -font textfont \
-	-from 1 -increment 1 -to 10000000 \
+	-from 0 -increment 1 -to 10000000 \
 	-validate all -validatecommand "diffcontextvalidate %P" \
 	-textvariable diffcontextstring
     .bleft.mid.diffcontext set $diffcontext
@@ -7306,7 +7306,7 @@ proc diffcontextchange {n1 n2 op} {
     global diffcontextstring diffcontext
 
     if {[string is integer -strict $diffcontextstring]} {
-	if {$diffcontextstring > 0} {
+	if {$diffcontextstring >= 0} {
 	    set diffcontext $diffcontextstring
 	    reselectline
 	}
-- 
1.6.3.1.160.g45b30
