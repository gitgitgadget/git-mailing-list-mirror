From: imyousuf@gmail.com
Subject: [JGIT PATCH 2/3] Relocate test resources to classpath and load from there
Date: Mon,  8 Sep 2008 09:07:35 +0600
Message-ID: <1220843256-1243-2-git-send-email-imyousuf@gmail.com>
References: <1220843256-1243-1-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 05:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcX7w-0000Bt-TG
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 05:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbYIHDIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 23:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYIHDID
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 23:08:03 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:64143 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbYIHDIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 23:08:01 -0400
Received: by ey-out-2122.google.com with SMTP id 6so611523eyi.37
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 20:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GVF6Vya7XOxiYSkXviPoA7wlVuhZXG5eW7AnAAaQg/k=;
        b=G8C5AGfTiw17FNmYLoB9ngTiwkmVU4OpVqAfr9hZB63oqx4tgd8sRC+ShROvyH0txH
         Bq+H4b0IUEqW3K8QXqTA6iSsaqUKoFf6emP00Z0ycVYF3d0+kfBI4we2FlGLbBMm/yyx
         q4dASxa7TsKRtb5MAp80VudweTq/WEszVbtoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VLrT4sZzchFqiGBPQ0N9GPeKv8nyxRoDHjk98oq54S1fxoOl80qX8wvOZ52Mi21Nfa
         K6yQK7C0iwxdU1JIX4qAxRtL9v1Fj9r3ZBw14JHYvVYarU3MVnufYJ6L5VvvW68ne/mc
         uZj3EvbV0BtiwOnCYrGycAbQ5Cyh9Vj4ppwZQ=
Received: by 10.210.113.16 with SMTP id l16mr18030778ebc.108.1220843278998;
        Sun, 07 Sep 2008 20:07:58 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id d2sm3020976nfc.20.2008.09.07.20.07.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Sep 2008 20:07:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1220843256-1243-1-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95210>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Previously test case resources were located in the root directory, this
change relocates them to a classpath location and loads the resources from
there.

If there is request for any test resource that is not present in classpath
then util method will return the same value as it would in previous state.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 org.spearce.jgit.test/.classpath                   |    1 +
 .../jgit/test/resources}/create-second-pack        |    0 
 .../org/spearce/jgit/test/resources}/gitgit.index  |  Bin 134799 -> 134799 bytes
 .../spearce/jgit/test/resources}/gitgit.lsfiles    |    0 
 .../org/spearce/jgit/test/resources}/gitgit.lstree |    0 
 ...ck-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx |  Bin 1256 -> 1256 bytes
 ...-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 |  Bin 1296 -> 1296 bytes
 ...k-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack |  Bin 7811 -> 7811 bytes
 ...ck-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx |  Bin 1088 -> 1088 bytes
 ...k-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack |  Bin 164 -> 164 bytes
 ...ck-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx |  Bin 2696 -> 2696 bytes
 ...-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 |  Bin 2976 -> 2976 bytes
 ...k-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack |  Bin 5956 -> 5956 bytes
 ...ck-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx |  Bin 1112 -> 1112 bytes
 ...k-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack |  Bin 1643 -> 1643 bytes
 .../org/spearce/jgit/test/resources}/pack-huge.idx |  Bin 2368 -> 2368 bytes
 .../org/spearce/jgit/test/resources}/packed-refs   |    0 
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   15 ++++++++++++++-
 18 files changed, 15 insertions(+), 1 deletions(-)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/create-second-pack (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/gitgit.index (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/gitgit.lsfiles (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/gitgit.lstree (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-huge.idx (100%)
 rename org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/packed-refs (100%)

diff --git a/org.spearce.jgit.test/.classpath b/org.spearce.jgit.test/.classpath
index 592fa17..a276507 100644
--- a/org.spearce.jgit.test/.classpath
+++ b/org.spearce.jgit.test/.classpath
@@ -1,6 +1,7 @@
 <?xml version="1.0" encoding="UTF-8"?>
 <classpath>
 	<classpathentry excluding="**/*.idx|**/*.pack" kind="src" path="tst"/>
+	<classpathentry kind="src" path="tst-rsrc"/>
 	<classpathentry kind="src" path="exttst"/>
 	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/J2SE-1.5"/>
 	<classpathentry combineaccessrules="false" kind="src" path="/org.spearce.jgit"/>
diff --git a/org.spearce.jgit.test/tst/create-second-pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
similarity index 100%
rename from org.spearce.jgit.test/tst/create-second-pack
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
diff --git a/org.spearce.jgit.test/tst/gitgit.index b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.index
similarity index 100%
rename from org.spearce.jgit.test/tst/gitgit.index
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.index
diff --git a/org.spearce.jgit.test/tst/gitgit.lsfiles b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.lsfiles
similarity index 100%
rename from org.spearce.jgit.test/tst/gitgit.lsfiles
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.lsfiles
diff --git a/org.spearce.jgit.test/tst/gitgit.lstree b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.lstree
similarity index 100%
rename from org.spearce.jgit.test/tst/gitgit.lstree
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.lstree
diff --git a/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx
diff --git a/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
diff --git a/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack
diff --git a/org.spearce.jgit.test/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx
diff --git a/org.spearce.jgit.test/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack
diff --git a/org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx
diff --git a/org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2
diff --git a/org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack
diff --git a/org.spearce.jgit.test/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx
diff --git a/org.spearce.jgit.test/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack
diff --git a/org.spearce.jgit.test/tst/pack-huge.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-huge.idx
similarity index 100%
rename from org.spearce.jgit.test/tst/pack-huge.idx
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-huge.idx
diff --git a/org.spearce.jgit.test/tst/packed-refs b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
similarity index 100%
rename from org.spearce.jgit.test/tst/packed-refs
rename to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index bfeb2a0..121b929 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -38,8 +38,13 @@
 package org.spearce.jgit.util;
 
 import java.io.File;
+import java.net.URL;
 
 public abstract class JGitTestUtil {
+	
+	public static final String CLASSPATH_TO_RESOURCES =
+		"/org/spearce/jgit/test/resources/";
+	
     private JGitTestUtil() {
         throw new AssertionError();
     }
@@ -48,6 +53,14 @@ public static File getTestResourceFile(String fileName) {
         if (fileName == null || fileName.length() <= 0) {
             return null;
         }
-        return new File("tst", fileName);
+        URL url = JGitTestUtil.class.getResource(
+    		new StringBuilder(CLASSPATH_TO_RESOURCES)
+    		.append(fileName).toString());
+        //If URL is null then try to load it as it was being
+        //loaded previously
+        if (url == null) {
+        	return new File("tst", fileName);
+        }
+		return new File(url.getPath());
     }
 }
-- 
1.5.6
