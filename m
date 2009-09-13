From: mr.gaffo@gmail.com
Subject: [PATCH JGit 10/19] moved test up to a higher level to test actual functionality
Date: Sun, 13 Sep 2009 13:44:26 -0500
Message-ID: <1252867475-858-11-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-9-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-10-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4l-0003Gw-DZ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbZIMSo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753647AbZIMSo6
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:44:58 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:47904 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbZIMSov (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:51 -0400
Received: by ywh4 with SMTP id 4so3391282ywh.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=97sAcLifS/vKZ3uLbL/hMPaiLe6ujyEyw5BOAZt3wu4=;
        b=IiHZVRq/l+onJa4pCNq1TogHTkfh2v8lA1myNybfirNadrIFLRZ6MoUMIcc27Y2nQ/
         gjcNdTkEhIa4dApWlPFG3H42PAy7hLTF3D0qjOOfcoo70TbMJSvHbGv0rQugBvVZ2QGs
         ifwvdBJknmQYesKfNLk8YZ4yd2Wmn/X0ny7ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K2KbjMput3PythefJH2YPYLg5vEbKdo5z8Y7byk+aPNPJ8qp69M/f7XbK2VC6USRad
         st26l549b4OpukoUuPb1tVGqRqTSZP2OkU9UJXuvnk5EZdrDcg/QR4TZA9eTKWva+gY+
         /2dS41kQKjccDc+TbrcGu7wDBClh4OdyIP/BU=
Received: by 10.101.174.36 with SMTP id b36mr5519041anp.91.1252867494111;
        Sun, 13 Sep 2009 11:44:54 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-10-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128390>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |   32 ++++++++++++++++----
 .../UpdateDirectoryBasedPacksInfoCacheTest.java    |   30 ------------------
 2 files changed, 26 insertions(+), 36 deletions(-)
 delete mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCacheTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
index 8e4d8e5..4ac62fa 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -1,6 +1,8 @@
 package org.spearce.jgit.lib;
 
 import java.io.File;
+import java.io.IOException;
+import java.util.ArrayList;
 import java.util.List;
 import java.util.UUID;
 
@@ -69,12 +71,7 @@ public void testListLocalPacksNotCreated() throws Exception {
 	}
 	
 	public void testListLocalPacksWhenThereIsAPack() throws Exception {
-		createTestDir();
-		File packsDir = new File(testDir, "pack");
-		packsDir.mkdirs();
-		
-		JGitTestUtil.copyFile(TEST_PACK, new File(packsDir, TEST_PACK.getName()));
-		JGitTestUtil.copyFile(TEST_IDX, new File(packsDir, TEST_IDX.getName()));
+		createSamplePacksDir();
 
 		ObjectDirectory od = new ObjectDirectory(testDir);
 		List<PackFile> localPacks = od.listLocalPacks();
@@ -82,6 +79,20 @@ public void testListLocalPacksWhenThereIsAPack() throws Exception {
 		assertEquals(TEST_PACK.getName(), localPacks.get(0).getPackFile().getName());
 	}
 	
+	public void testUpdateInfoCacheCreatesPacksFile() throws Exception {
+		createSamplePacksDir();
+
+		ObjectDirectory od = new ObjectDirectory(testDir);
+		od.create();
+		od.updateInfoCache();
+		
+		String expectedContents = new PacksFileContentsCreator(od.listLocalPacks()).toString();
+		File packsFile = new File(od.getDirectory(), "info/packs");
+
+		assertTrue(packsFile.exists());
+		assertEquals(expectedContents, JGitTestUtil.readFileAsString(packsFile));
+	}
+	
 	public boolean deleteDir(File dir) {
         if (dir.isDirectory()) {
             String[] children = dir.list();
@@ -100,5 +111,14 @@ public boolean deleteDir(File dir) {
 	private void createTestDir(){
 		testDir.mkdir();
 	}
+
+	private void createSamplePacksDir() throws IOException {
+		createTestDir();
+		File packsDir = new File(testDir, "pack");
+		packsDir.mkdirs();
+		
+		JGitTestUtil.copyFile(TEST_PACK, new File(packsDir, TEST_PACK.getName()));
+		JGitTestUtil.copyFile(TEST_IDX, new File(packsDir, TEST_IDX.getName()));
+	}
 	
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCacheTest.java
deleted file mode 100644
index f5163e4..0000000
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCacheTest.java
+++ /dev/null
@@ -1,30 +0,0 @@
-package org.spearce.jgit.lib;
-
-import java.io.File;
-import java.util.ArrayList;
-import java.util.List;
-
-import junit.framework.TestCase;
-
-import org.spearce.jgit.util.JGitTestUtil;
-
-public class UpdateDirectoryBasedPacksInfoCacheTest extends TestCase {
-	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
-	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
-	private static final File TEST_IDX = JGitTestUtil.getTestResourceFile(PACK_NAME + ".idx");
-	
-	public void testCreatesTheFileAndPutsTheContentsIn() throws Exception {
-		List<PackFile> packs = new ArrayList<PackFile>();
-		packs.add(new PackFile(TEST_IDX, TEST_PACK));
-		
-		File packsFile = File.createTempFile(UpdateDirectoryBasedPacksInfoCacheTest.class.getSimpleName(), "tstdata");
-		packsFile.deleteOnExit();
-		
-		String expectedContents = new PacksFileContentsCreator(packs).toString();
-		
-		new UpdateDirectoryBasedPacksInfoCache(packs, packsFile).execute();
-		
-		assertEquals(expectedContents, JGitTestUtil.readFileAsString(packsFile));
-	}
-
-}
-- 
1.6.4.2
