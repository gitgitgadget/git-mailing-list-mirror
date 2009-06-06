From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit 1/4] Don't count the submenu entries for checking if it is empty
Date: Sat,  6 Jun 2009 13:57:48 +0200
Message-ID: <1244289471-698-2-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 13:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCuXy-0007Qq-0O
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 13:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbZFFL6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 07:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbZFFL6S
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 07:58:18 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59863 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbZFFL6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 07:58:17 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9334A1049C9F3;
	Sat,  6 Jun 2009 13:58:19 +0200 (CEST)
Received: from [89.59.108.98] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MCuXT-0006b6-00; Sat, 06 Jun 2009 13:58:19 +0200
X-Mailer: git-send-email 1.6.3.2.213.g30b07
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/ggrLvWI8l6u4sJ4kYJgcYvnrJgdkh/nfWeoud
	JmeEVp7CrniCSxv2QFLojQ91VU6lerLYbkbep9FPthY6mCJx3E
	AvdPFXtSgS8+BNX3QFhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120912>

Checking with isEmpty() is more effective.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/mainimpl.cpp |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index 8c7b19e..60414ab 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -1179,7 +1179,7 @@ void MainImpl::doContexPopup(SCRef sha) {
 			act = contextRmtMenu.addAction(*it);
 			act->setData("Ref");
 		}
-		if (contextRmtMenu.actions().count() > 0)
+		if (!contextRmtMenu.isEmpty())
 			contextMenu.addMenu(&contextRmtMenu);
 
 		if (!bn.empty())
@@ -1194,7 +1194,7 @@ void MainImpl::doContexPopup(SCRef sha) {
 			act->setData("Ref");
 		}
 		if (!tn.empty())
-			if (contextSubMenu.actions().count() > 0)
+			if (!contextSubMenu.isEmpty())
 				contextSubMenu.addSeparator();
 			else
 				contextMenu.addSeparator();
@@ -1207,7 +1207,7 @@ void MainImpl::doContexPopup(SCRef sha) {
 
 			act->setData("Ref");
 		}
-		if (contextSubMenu.actions().count() > 0)
+		if (!contextSubMenu.isEmpty())
 			contextMenu.addMenu(&contextSubMenu);
 	}
 	contextMenu.exec(QCursor::pos());
-- 
1.6.3.2.213.g30b07
