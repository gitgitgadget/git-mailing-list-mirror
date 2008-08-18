From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/14] Fix usage of assertEquals in DirCacheIteratorTest
Date: Mon, 18 Aug 2008 16:53:13 -0700
Message-ID: <1219103602-32222-6-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
 <1219103602-32222-3-git-send-email-spearce@spearce.org>
 <1219103602-32222-4-git-send-email-spearce@spearce.org>
 <1219103602-32222-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZ3-0006i3-Mk
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbYHRXxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753779AbYHRXxc
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:32 -0400
Received: from george.spearce.org ([209.20.77.23]:45146 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbYHRXx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8929938375; Mon, 18 Aug 2008 23:53:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 408173837A;
	Mon, 18 Aug 2008 23:53:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92770>

I had the expected/actual values reversed so error messages from
JUnit were a bit difficult to read.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/dircache/DirCacheIteratorTest.java        |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
index 7d4e6bb..62a162f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
@@ -87,7 +87,7 @@ public void testNoSubtree_NoTreeWalk() throws Exception {
 			assertSame(ents[pathIdx], i.getDirCacheEntry());
 			pathIdx++;
 		}
-		assertEquals(pathIdx, paths.length);
+		assertEquals(paths.length, pathIdx);
 	}
 
 	public void testNoSubtree_WithTreeWalk() throws Exception {
@@ -120,7 +120,7 @@ public void testNoSubtree_WithTreeWalk() throws Exception {
 			assertSame(modes[pathIdx], tw.getFileMode(0));
 			pathIdx++;
 		}
-		assertEquals(pathIdx, paths.length);
+		assertEquals(paths.length, pathIdx);
 	}
 
 	public void testSingleSubtree_NoRecursion() throws Exception {
@@ -164,7 +164,7 @@ public void testSingleSubtree_NoRecursion() throws Exception {
 
 			pathIdx++;
 		}
-		assertEquals(pathIdx, expPaths.length);
+		assertEquals(expPaths.length, pathIdx);
 	}
 
 	public void testSingleSubtree_Recursive() throws Exception {
@@ -199,7 +199,7 @@ public void testSingleSubtree_Recursive() throws Exception {
 			assertSame(mode, tw.getFileMode(0));
 			pathIdx++;
 		}
-		assertEquals(pathIdx, paths.length);
+		assertEquals(paths.length, pathIdx);
 	}
 
 	public void testTwoLevelSubtree_Recursive() throws Exception {
@@ -233,7 +233,7 @@ public void testTwoLevelSubtree_Recursive() throws Exception {
 			assertSame(mode, tw.getFileMode(0));
 			pathIdx++;
 		}
-		assertEquals(pathIdx, paths.length);
+		assertEquals(paths.length, pathIdx);
 	}
 
 	public void testTwoLevelSubtree_FilterPath() throws Exception {
-- 
1.6.0.87.g2858d
