From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/4] Add actual test for success to ConnectOperationTest
Date: Wed,  8 Apr 2009 17:51:28 +0200
Message-ID: <1239205891-28236-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:54:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lra66-0003ue-El
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZDHPvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755220AbZDHPvi
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:51:38 -0400
Received: from mail.dewire.com ([83.140.172.130]:6919 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbZDHPvi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 11:51:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A0E0C14915DB;
	Wed,  8 Apr 2009 17:51:36 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Rgm4REGFh0P; Wed,  8 Apr 2009 17:51:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 0D42214915D6;
	Wed,  8 Apr 2009 17:51:36 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116094>

Also remove a few obsolete lines (irrelevant asserts)

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../op/T0001_ConnectProviderOperationTest.java     |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
index 092c048..1d332a3 100644
--- a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
@@ -89,19 +89,6 @@ public void testNewUnsharedFile() throws CoreException, IOException,
 		lck.setNewObjectId(id);
 		assertEquals(RefUpdate.Result.NEW, lck.forceUpdate());
 
-		// helper asserts, this is not what we are really testing
-		assertTrue("blob missing", new File(gitDir,
-				"objects/2e/2439c32d01f0ef39644d561945e8f4b2239489").exists());
-
-		assertTrue("tree missing", new File(gitDir,
-				"objects/87/a105cc4bc0a79885d07ec560c3eee49438acf0").exists());
-		assertTrue("tree missing", new File(gitDir,
-				"objects/08/ccc3d91a14d337a45f355d3d63bd97fd5e4db9").exists());
-		assertTrue("tree missing", new File(gitDir,
-				"objects/9d/aeec817090098f05eeca858e3a552d78b0a346").exists());
-		assertTrue("commit missing", new File(gitDir,
-				"objects/09/6f1a84091b90b6d9fb12f95848da69496305c1").exists());
-
 		ConnectProviderOperation operation = new ConnectProviderOperation(
 				project.getProject(), null);
 		operation.run(null);
@@ -125,5 +112,8 @@ protected IStatus run(IProgressMonitor monitor) {
 			Thread.sleep(1000);
 		}
 		System.out.println("DONE");
+
+		assertNotNull(RepositoryProvider.getProvider(project.getProject()));
+
 	}
 }
-- 
1.6.2.2.446.gfbdc0
