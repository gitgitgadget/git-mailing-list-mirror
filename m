From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] Restore IContainer.INCLUDE_HIDDEN within ContainerTreeIterator
Date: Thu, 28 Aug 2008 08:27:46 -0700
Message-ID: <1219937266-24903-5-git-send-email-spearce@spearce.org>
References: <1219937266-24903-1-git-send-email-spearce@spearce.org>
 <1219937266-24903-2-git-send-email-spearce@spearce.org>
 <1219937266-24903-3-git-send-email-spearce@spearce.org>
 <1219937266-24903-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:29:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjQu-0003Pm-I0
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbYH1P16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 11:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbYH1P14
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:27:56 -0400
Received: from george.spearce.org ([209.20.77.23]:51105 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbYH1P1u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:27:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 25D3B38375; Thu, 28 Aug 2008 15:27:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1EC4538378;
	Thu, 28 Aug 2008 15:27:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
In-Reply-To: <1219937266-24903-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94073>

Now that we support only Eclipse 3.4 we might as well use this
flag to pick up hidden resources which may be part of the Git
repository, but hidden from view from Eclipse.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/core/ContainerTreeIterator.java   |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java
index 2b7ff3b..61717f5 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java
@@ -91,8 +91,7 @@ public AbstractTreeIterator createSubtreeIterator(final Repository db)
 	private Entry[] entries() {
 		final IResource[] all;
 		try {
-//			all = node.members(IContainer.INCLUDE_HIDDEN); 3.4 flag
-			all = node.members(0);
+			all = node.members(IContainer.INCLUDE_HIDDEN);
 		} catch (CoreException err) {
 			return EOF;
 		}
-- 
1.6.0.174.gd789c
