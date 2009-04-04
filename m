From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Select and show a newly created branch in the checkout dialog
Date: Sat,  4 Apr 2009 13:55:25 +0200
Message-ID: <1238846125-30149-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Apr 04 14:00:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq4Us-0007dC-PR
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 13:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbZDDLzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 07:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbZDDLzi
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 07:55:38 -0400
Received: from mail.dewire.com ([83.140.172.130]:19323 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbZDDLzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 07:55:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 005EB148898A;
	Sat,  4 Apr 2009 13:55:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OFVIRmWrNd5W; Sat,  4 Apr 2009 13:55:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2216B1488989;
	Sat,  4 Apr 2009 13:55:29 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.1.345.g89fb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115582>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../ui/internal/dialogs/BranchSelectionDialog.java |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index cbbc384..1866086 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -150,6 +150,7 @@ private void fillTreeWithBranches(String select) throws IOException {
 		TreeItem curSubItem = null;
 		String curPrefix = null;
 		String curSubPrefix = null;
+		TreeItem itemToSelect = null;
 
 		for (String ref : branches) {
 			String shortName = ref;
@@ -217,7 +218,12 @@ public void widgetDisposed(DisposeEvent e) {
 			}
 			else item.setText(shortName);
 			if (ref.equals(select))
-				branchTree.select(item);
+				itemToSelect = item;
+			branchTree.setLinesVisible(true);
+		}
+		if (itemToSelect != null) {
+			branchTree.select(itemToSelect);
+			branchTree.showItem(itemToSelect);
 		}
 	}
 
-- 
1.6.2.1.345.g89fb
