From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Expose the advertised refs to ReceivePack hooks
Date: Fri, 26 Dec 2008 19:47:01 -0800
Message-ID: <20081227034701.GA23268@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 04:51:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGQD1-0003Z7-Lo
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 04:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbYL0DrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 22:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbYL0DrE
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 22:47:04 -0500
Received: from george.spearce.org ([209.20.77.23]:46707 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbYL0DrD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 22:47:03 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 579E938200; Sat, 27 Dec 2008 03:47:01 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103984>

Hooks may want to be able to consider what the client was shown, so
they can make decisions based on that information.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/ReceivePack.java    |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index 95519b8..76d11c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -155,6 +155,11 @@ public final RevWalk getRevWalk() {
 		return walk;
 	}
 
+	/** @return all refs which were advertised to the client. */
+	public final Map<String, Ref> getAdvertisedRefs() {
+		return refs;
+	}
+
 	/**
 	 * @return true if this instance will verify received objects are formatted
 	 *         correctly. Validating objects requires more CPU time on this side
-- 
1.6.1.302.gccd4d
