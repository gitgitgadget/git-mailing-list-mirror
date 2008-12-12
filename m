From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/12] Assert the ChunkHeader.OldImage.getId uses FileHeader.getOldImage
Date: Fri, 12 Dec 2008 14:05:52 -0800
Message-ID: <1229119558-1293-7-git-send-email-spearce@spearce.org>
References: <1229119558-1293-1-git-send-email-spearce@spearce.org>
 <1229119558-1293-2-git-send-email-spearce@spearce.org>
 <1229119558-1293-3-git-send-email-spearce@spearce.org>
 <1229119558-1293-4-git-send-email-spearce@spearce.org>
 <1229119558-1293-5-git-send-email-spearce@spearce.org>
 <1229119558-1293-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGBH-0004x0-I4
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbYLLWGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbYLLWG3
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:29 -0500
Received: from george.spearce.org ([209.20.77.23]:50677 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbYLLWGD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:03 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id A476538222; Fri, 12 Dec 2008 22:06:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 517BF38211;
	Fri, 12 Dec 2008 22:06:00 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102956>

These should always produce the same AbbreviatedObjectId.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/PatchTest.java      |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index 4eceeb5..c81356b 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -90,6 +90,8 @@ assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfigTest
 			assertEquals(4, h.getLinesContext());
 			assertEquals(7, h.getOldImage().getLinesAdded());
 			assertEquals(0, h.getOldImage().getLinesDeleted());
+			assertSame(fRepositoryConfigTest.getOldId(), h.getOldImage()
+					.getId());
 
 			assertEquals(1490, h.endOffset);
 		}
@@ -113,6 +115,7 @@ assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfig
 			assertEquals(7, h.getLinesContext());
 			assertEquals(2, h.getOldImage().getLinesAdded());
 			assertEquals(2, h.getOldImage().getLinesDeleted());
+			assertSame(fRepositoryConfig.getOldId(), h.getOldImage().getId());
 
 			assertEquals(2434, h.endOffset);
 		}
-- 
1.6.1.rc2.306.ge5d5e
