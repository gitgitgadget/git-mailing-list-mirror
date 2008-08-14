From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Move C git compatability test vectors to tst directory
Date: Thu, 14 Aug 2008 15:06:27 -0700
Message-ID: <1218751587-22843-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:07:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkyk-0005mE-HE
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYHNWGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbYHNWG3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:06:29 -0400
Received: from george.spearce.org ([209.20.77.23]:47828 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbYHNWG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:06:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9D98D38376; Thu, 14 Aug 2008 22:06:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2BCFB38265;
	Thu, 14 Aug 2008 22:06:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc3.250.g8dd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92412>

We don't want to read the data from the classpath as this can cause
a problem for Maven based builds.  Instead we read the data from the
top level tst directory, where our other test vectors are located.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

Or you could squash this into the patch which introduced it.

 .../{org/spearce/jgit/dircache => }/gitgit.index   |  Bin 134799 -> 134799 bytes
 .../{org/spearce/jgit/dircache => }/gitgit.lsfiles |    0
 .../{org/spearce/jgit/dircache => }/gitgit.lstree  |    0
 .../dircache/DirCacheCGitCompatabilityTest.java    |    2 +-
 4 files changed, 1 insertions(+), 1 deletions(-)
 rename org.spearce.jgit.test/tst/{org/spearce/jgit/dircache => }/gitgit.index (100%)
 rename org.spearce.jgit.test/tst/{org/spearce/jgit/dircache => }/gitgit.lsfiles (100%)
 rename org.spearce.jgit.test/tst/{org/spearce/jgit/dircache => }/gitgit.lstree (100%)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/gitgit.index b/org.spearce.jgit.test/tst/gitgit.index
similarity index 100%
rename from org.spearce.jgit.test/tst/org/spearce/jgit/dircache/gitgit.index
rename to org.spearce.jgit.test/tst/gitgit.index
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/gitgit.lsfiles b/org.spearce.jgit.test/tst/gitgit.lsfiles
similarity index 100%
rename from org.spearce.jgit.test/tst/org/spearce/jgit/dircache/gitgit.lsfiles
rename to org.spearce.jgit.test/tst/gitgit.lsfiles
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/gitgit.lstree b/org.spearce.jgit.test/tst/gitgit.lstree
similarity index 100%
rename from org.spearce.jgit.test/tst/org/spearce/jgit/dircache/gitgit.lstree
rename to org.spearce.jgit.test/tst/gitgit.lstree
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
index 8f182a3..43b23f6 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
@@ -138,7 +138,7 @@ public class DirCacheCGitCompatabilityTest extends RepositoryTestCase {
 	}
 
 	private File pathOf(final String name) {
-		return new File(getClass().getResource(name).getPath());
+		return new File("tst", name);
 	}
 
 	private Map<String, CGitIndexRecord> readLsFiles() throws Exception {
-- 
1.6.0.rc3.250.g8dd0
