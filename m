From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/12] Assert the HunkHeader.getFileHeader returns the right file
Date: Fri, 12 Dec 2008 14:05:47 -0800
Message-ID: <1229119558-1293-2-git-send-email-spearce@spearce.org>
References: <1229119558-1293-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:07:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGAK-0004ah-Q4
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbYLLWGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbYLLWGB
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:01 -0500
Received: from george.spearce.org ([209.20.77.23]:50662 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbYLLWGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:00 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6E73D3821F; Fri, 12 Dec 2008 22:05:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C095D38200;
	Fri, 12 Dec 2008 22:05:58 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102947>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/PatchTest.java      |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index 7c69fff..5850364 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -80,6 +80,7 @@ assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfigTest
 		assertEquals(1, fRepositoryConfigTest.getHunks().size());
 		{
 			final HunkHeader h = fRepositoryConfigTest.getHunks().get(0);
+			assertSame(fRepositoryConfigTest, h.getFileHeader());
 			assertEquals(921, h.startOffset);
 			assertEquals(109, h.getOldStartLine());
 			assertEquals(4, h.getOldLineCount());
@@ -102,6 +103,7 @@ assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfig
 		assertEquals(3, fRepositoryConfig.getHunks().size());
 		{
 			final HunkHeader h = fRepositoryConfig.getHunks().get(0);
+			assertSame(fRepositoryConfig, h.getFileHeader());
 			assertEquals(1803, h.startOffset);
 			assertEquals(236, h.getOldStartLine());
 			assertEquals(9, h.getOldLineCount());
-- 
1.6.1.rc2.306.ge5d5e
