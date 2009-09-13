From: mr.gaffo@gmail.com
Subject: [PATCH JGit 16/19] added tests for the file based info cache update and made pass
Date: Sun, 13 Sep 2009 13:44:32 -0500
Message-ID: <1252867475-858-17-git-send-email-mr.gaffo@gmail.com>
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
 <1252867475-858-15-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-16-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4m-0003Gw-W1
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbZIMSpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbZIMSpJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:45:09 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:47904 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbZIMSo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:57 -0400
Received: by mail-yw0-f174.google.com with SMTP id 4so3391282ywh.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FMQZV0kDGGojsl1KsZotrF0HQn0yNQ9yh+A8EbtGOBE=;
        b=IDl+Mv1ztaZZtobNw/5vJc2YL1neWq5yLTtShDSh5odKR0huyLsRHNTBheaLeqNdZM
         Wb/6csGbm48dyaoG32mvC2FGmfMlg5Il+JPCSloA+EFO8u+GYc/CkrhmwqeJcIAIBLH6
         Ld8AXtwYTmL0GUrwvxzHJXay1X/Gs0ugXwm7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D4ywacpiLOMY2JSF40UmVj4Eu2UvZgHXEAEAwhzd18otgfBGmRV4DQxfvsLxQ4Ne9k
         vbI8UXwWSYlp//dEfxUV+tM6nqsVSlaySMl6kHRr0OF1LmZRoiAkyGJWjs1CKZZQ1ZJk
         Bt4ntlkcGl4Eme1sMaCcZgky7AyMSN7pXQ0js=
Received: by 10.101.193.25 with SMTP id v25mr5407331anp.132.1252867500901;
        Sun, 13 Sep 2009 11:45:00 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:45:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-16-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128394>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../jgit/lib/InfoDirectoryDatabaseTest.java        |   30 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/InfoDatabase.java     |   15 ++++++++++
 .../spearce/jgit/lib/InfoDirectoryDatabase.java    |   15 ++++++++++
 3 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
index 2b7fb5b..22972fa 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
@@ -1,6 +1,10 @@
 package org.spearce.jgit.lib;
 
 import java.io.File;
+import java.io.IOException;
+import java.io.StringWriter;
+import java.util.ArrayList;
+import java.util.Collection;
 
 import org.spearce.jgit.util.JGitTestUtil;
 
@@ -27,4 +31,30 @@ public void testCreateCreatesDirectory() throws Exception {
 		new InfoDirectoryDatabase(testDir).create();
 		assertTrue(testDir.exists());
 	}
+	
+	public void testUpdateInfoCache() throws Exception {
+		Collection<Ref> refs = new ArrayList<Ref>();
+		refs.add(new Ref(Ref.Storage.LOOSE, "refs/heads/master", ObjectId.fromString("32aae7aef7a412d62192f710f2130302997ec883")));
+		refs.add(new Ref(Ref.Storage.LOOSE, "refs/heads/development", ObjectId.fromString("184063c9b594f8968d61a686b2f6052779551613")));
+
+		File expectedFile = new File(testDir, "refs");
+		assertFalse(expectedFile.exists());
+		
+		
+		final StringWriter expectedString = new StringWriter();
+		new RefWriter(refs) {
+			@Override
+			protected void writeFile(String file, byte[] content) throws IOException {
+				expectedString.write(new String(content));
+			}
+		}.writeInfoRefs();
+		
+		InfoDirectoryDatabase out = new InfoDirectoryDatabase(testDir);
+		out.create();
+		out.updateInfoCache(refs);
+		assertTrue(expectedFile.exists());
+		
+		String actual = JGitTestUtil.readFileAsString(expectedFile);
+		assertEquals(expectedString.toString(), actual);
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
index 2f1f398..26f8f22 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
@@ -1,8 +1,23 @@
 package org.spearce.jgit.lib;
 
+import java.io.IOException;
+import java.util.Collection;
+
 public abstract class InfoDatabase {
 
+	/**
+	 * Create the info database
+	 */
 	public void create() {
 	}
 
+	/**
+	 * Updates the info cache typically done by update-server-info command.
+	 * This writes THIS repository's refs out to the info/refs file.
+	 * @param collection the collections of refs to update the info cache with
+	 * @throws IOException for any type of failure on the local or remote 
+	 * 					   data store
+	 */
+	public abstract void updateInfoCache(Collection<Ref> collection) throws IOException;
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
index 20d8a70..f95be2f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
@@ -1,6 +1,9 @@
 package org.spearce.jgit.lib;
 
 import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+import java.util.Collection;
 
 public class InfoDirectoryDatabase extends InfoDatabase {
 
@@ -15,4 +18,16 @@ public void create() {
 		info.mkdirs();
 	}
 
+	@Override
+	public void updateInfoCache(Collection<Ref> refs) throws IOException {
+		new RefWriter(refs) {
+			@Override
+			protected void writeFile(String file, byte[] content) throws IOException {
+				FileOutputStream fos = new FileOutputStream(new File(info, "refs"));
+				fos.write(content);
+				fos.close();
+			}
+		}.writeInfoRefs();
+	}
+
 }
-- 
1.6.4.2
