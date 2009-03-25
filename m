From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Set a title that includes the repository path for checkout/reset dialogs
Date: Wed, 25 Mar 2009 22:52:34 +0100
Message-ID: <1238017954-29396-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmb3c-0003RD-Rq
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbZCYVxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbZCYVxP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:53:15 -0400
Received: from mail.dewire.com ([83.140.172.130]:12944 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367AbZCYVxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:53:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DD113147EAAC;
	Wed, 25 Mar 2009 22:53:06 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7SA0YJsG-fx2; Wed, 25 Mar 2009 22:53:06 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id D53F3147CF73;
	Wed, 25 Mar 2009 22:53:05 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114681>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    6 ++++++
 .../ui/internal/dialogs/BranchSelectionDialog.java |    5 +++++
 .../src/org/spearce/egit/ui/uitext.properties      |    2 ++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 8e3a40f..918cce1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -851,6 +851,12 @@
 	public static String WindowCachePreferencePage_packedGitMMAP;
 
 	/** */
+	public static String BranchSelectionDialog_TitleCheckout;
+
+	/** */
+	public static String BranchSelectionDialog_TitleReset;
+
+	/** */
 	public static String BranchSelectionDialog_OkReset;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index f0a8d69..cbbc384 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -94,6 +94,11 @@ protected Composite createDialogArea(Composite base) {
 			buildResetGroup();
 		}
 
+		String rawTitle = showResetType ? UIText.BranchSelectionDialog_TitleReset
+				: UIText.BranchSelectionDialog_TitleCheckout;
+		getShell().setText(
+				NLS.bind(rawTitle, new Object[] { repo.getDirectory() }));
+
 		try {
 			fillTreeWithBranches(null);
 		} catch (IOException e) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index e2e6bd3..35627ce 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -323,6 +323,8 @@ WindowCachePreferencePage_packedGitLimit=Window cache limit:
 WindowCachePreferencePage_deltaBaseCacheLimit=Delta base cache limit:
 WindowCachePreferencePage_packedGitMMAP=Use virtual memory mapping
 
+BranchSelectionDialog_TitleCheckout=Checkout: {0}
+BranchSelectionDialog_TitleReset=Reset: {0}
 BranchSelectionDialog_BranchSuffix_Current=\ (current)
 BranchSelectionDialog_ErrorAlreadyExists=Already exists
 BranchSelectionDialog_ErrorCouldNotCreateNewRef=Could not create new ref {0}
-- 
1.6.2.1.214.ge986c
