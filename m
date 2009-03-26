From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Remove dead/unused reset method from CountingOutputStream
Date: Wed, 25 Mar 2009 18:21:51 -0700
Message-ID: <1238030515-31768-1-git-send-email-spearce@spearce.org>
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 02:23:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmeJi-0001u1-7B
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 02:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbZCZBWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 21:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbZCZBV7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 21:21:59 -0400
Received: from george.spearce.org ([209.20.77.23]:40171 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbZCZBV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 21:21:58 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4141F3821F; Thu, 26 Mar 2009 01:21:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B19E8381D2;
	Thu, 26 Mar 2009 01:21:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.471.g682837
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114698>

We never reset the stream, so just remove that as a valid option.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/util/CountingOutputStream.java    |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
index b0b5f7d..5f333f5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
@@ -72,17 +72,9 @@ public void write(byte[] b, int off, int len) throws IOException {
 	/**
 	 * Return number of already written bytes.
 	 *
-	 * @return number of written bytes since last reset (object is reset upon
-	 *         creation)
+	 * @return number of written bytes since stream start.
 	 */
 	public long getCount() {
 		return count;
 	}
-
-	/**
-	 * Reset counter to zero value.
-	 */
-	public void reset() {
-		count = 0;
-	}
 }
-- 
1.6.2.1.471.g682837
