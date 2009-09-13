From: mr.gaffo@gmail.com
Subject: [PATCH JGit 14/19] pulled out some helper functions that will be useful for other tests
Date: Sun, 13 Sep 2009 13:44:30 -0500
Message-ID: <1252867475-858-15-git-send-email-mr.gaffo@gmail.com>
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
 <1252867475-858-11-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-12-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-13-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-14-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4l-0003Gw-Tz
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbZIMSpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbZIMSpB
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:45:01 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:20766 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbZIMSoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:55 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549088and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=s3PMjgGwJrR3EFbkS81qipqilX+bArx02QLp8RJncho=;
        b=sAa09Do6L7X5r/iFJZMAZeNECJrLOOIQCJMYfbZaI5zNniZe9Pdz8tEw3tY1AEK8un
         2e0tp9RwGy3oKAKIve2pXwnPJIzGJUB5l11lUtPuFGR6U7Sr9hLsBJKc8PDG7tjtWT5i
         PMasRCaSlJAt3A6/BvNdLohsAzIB3SY5/7/CA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wRBO5SiUEQDjXsxJ89NvtntnDNjyu35kN/Bzmn450Tde6UXxyim2H1MWOpztzensWM
         GtVfxSR1n2T9S9KVws2g2Gp6LUVl2TZkS4q06J+28YrrbZdxODAmT3Q0DE63qPsS6v0w
         4/h44RAnvCkhI7Nrwj4xzpRJpGCxZ7pnEBcYI=
Received: by 10.101.154.5 with SMTP id g5mr5430294ano.178.1252867498745;
        Sun, 13 Sep 2009 11:44:58 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-14-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128395>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |   21 ++-----------------
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   20 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
index b27f2f8..4fecce7 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -4,7 +4,6 @@
 import java.io.IOException;
 import java.util.ArrayList;
 import java.util.List;
-import java.util.UUID;
 
 import org.spearce.jgit.util.JGitTestUtil;
 
@@ -19,13 +18,13 @@
 
 	@Override
 	protected void setUp() throws Exception {
-		testDir = new File(new File(System.getProperty("java.io.tmpdir")), UUID.randomUUID().toString());
+		testDir = JGitTestUtil.generateTempDirectoryFileObject();
 	}
-	
+
 	@Override
 	protected void tearDown() throws Exception {
 		if (testDir.exists()){
-			deleteDir(testDir);
+			JGitTestUtil.deleteDir(testDir);
 		}
 	}
 
@@ -93,20 +92,6 @@ public void testUpdateInfoCacheCreatesPacksAndRefsFile() throws Exception {
 		assertEquals(expectedContents, JGitTestUtil.readFileAsString(packsFile));
 	}
 	
-	public boolean deleteDir(File dir) {
-        if (dir.isDirectory()) {
-            String[] children = dir.list();
-            for (int i=0; i<children.length; i++) {
-                boolean success = deleteDir(new File(dir, children[i]));
-                if (!success) {
-                    return false;
-                }
-            }
-        }
-        // The directory is now empty so delete it
-        return dir.delete();
-    }
-
 	private void createTestDir(){
 		testDir.mkdir();
 	}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index b958282..7506553 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -40,7 +40,6 @@
 import java.io.BufferedReader;
 import java.io.File;
 import java.io.FileInputStream;
-import java.io.FileNotFoundException;
 import java.io.FileOutputStream;
 import java.io.FileReader;
 import java.io.IOException;
@@ -48,6 +47,7 @@
 import java.io.OutputStream;
 import java.net.URISyntaxException;
 import java.net.URL;
+import java.util.UUID;
 
 public abstract class JGitTestUtil {
 	public static final String CLASSPATH_TO_RESOURCES = "org/spearce/jgit/test/resources/";
@@ -105,4 +105,22 @@ public static String readFileAsString(final File file)
 	private static ClassLoader cl() {
 		return JGitTestUtil.class.getClassLoader();
 	}
+
+	public static boolean deleteDir(File dir) {
+	    if (dir.isDirectory()) {
+	        String[] children = dir.list();
+	        for (int i=0; i<children.length; i++) {
+	            boolean success = deleteDir(new File(dir, children[i]));
+	            if (!success) {
+	                return false;
+	            }
+	        }
+	    }
+	    // The directory is now empty so delete it
+	    return dir.delete();
+	}
+
+	public static File generateTempDirectoryFileObject() {
+		return new File(new File(System.getProperty("java.io.tmpdir")), UUID.randomUUID().toString());
+	}
 }
-- 
1.6.4.2
