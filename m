From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/3] Use Constants.R_* in Branch dialog
Date: Thu,  7 May 2009 01:33:00 +0200
Message-ID: <1241652781-16873-3-git-send-email-robin.rosenberg@dewire.com>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
 <1241652781-16873-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 07 01:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qbx-0002pO-FG
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbZEFXdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 19:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbZEFXdH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:33:07 -0400
Received: from mail.dewire.com ([83.140.172.130]:27513 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbZEFXdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 19:33:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 25BB114A8B5E;
	Thu,  7 May 2009 01:33:05 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ve6xbQswrQ4n; Thu,  7 May 2009 01:33:04 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id B151B14A8B5A;
	Thu,  7 May 2009 01:33:03 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.1.g868b6
In-Reply-To: <1241652781-16873-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118411>

There were a few places that didn't use these constants

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../ui/internal/dialogs/BranchSelectionDialog.java |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index 1866086..9aad95b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -154,19 +154,19 @@ private void fillTreeWithBranches(String select) throws IOException {
 
 		for (String ref : branches) {
 			String shortName = ref;
-			if (ref.startsWith("refs/heads/")) {
+			if (ref.startsWith(Constants.R_HEADS)) {
 				shortName = ref.substring(11);
-				if (!"refs/heads/".equals(curPrefix)) {
-					curPrefix = "refs/heads/";
+				if (!Constants.R_HEADS.equals(curPrefix)) {
+					curPrefix = Constants.R_HEADS;
 					curSubPrefix = null;
 					curSubItem = null;
 					curItem = new TreeItem(branchTree, SWT.NONE);
 					curItem.setText(UIText.BranchSelectionDialog_LocalBranches);
 				}
-			} else if (ref.startsWith("refs/remotes/")) {
+			} else if (ref.startsWith(Constants.R_REMOTES)) {
 				shortName = ref.substring(13);
-				if (!"refs/remotes/".equals(curPrefix)) {
-					curPrefix = "refs/remotes/";
+				if (!Constants.R_REMOTES.equals(curPrefix)) {
+					curPrefix = Constants.R_REMOTES;
 					curItem = new TreeItem(branchTree, SWT.NONE);
 					curItem.setText(UIText.BranchSelectionDialog_RemoteBranches);
 					curSubItem = null;
@@ -186,10 +186,10 @@ private void fillTreeWithBranches(String select) throws IOException {
 					curSubItem = null;
 					curSubPrefix = null;
 				}
-			} else if (ref.startsWith("refs/tags/")) {
+			} else if (ref.startsWith(Constants.R_TAGS)) {
 				shortName = ref.substring(10);
-				if (!"refs/tags/".equals(curPrefix)) {
-					curPrefix = "refs/tags/";
+				if (!Constants.R_HEADS.equals(curPrefix)) {
+					curPrefix = Constants.R_TAGS;
 					curSubPrefix = null;
 					curSubItem = null;
 					curItem = new TreeItem(branchTree, SWT.NONE);
-- 
1.6.3.rc2.1.g868b6
