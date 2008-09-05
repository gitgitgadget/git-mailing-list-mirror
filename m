From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Expose the raw timezone offset from PersonIdent
Date: Thu,  4 Sep 2008 18:37:19 -0700
Message-ID: <1220578639-11723-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 03:38:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbQHM-0007BU-GU
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 03:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYIEBhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 21:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbYIEBhV
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 21:37:21 -0400
Received: from george.spearce.org ([209.20.77.23]:32903 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbYIEBhU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 21:37:20 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1F0A33835F; Fri,  5 Sep 2008 01:37:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AE89F38269;
	Fri,  5 Sep 2008 01:37:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94986>

Applications may wish to have this value, much as they
can get the raw seconds-since-epoch and reformat it
for their own uses.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PersonIdent.java      |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
index 5e524d3..bc5479a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
@@ -260,6 +260,14 @@ public TimeZone getTimeZone() {
 		return TimeZone.getTimeZone(ids[0]);
 	}
 
+	/**
+	 * @return this person's preferred time zone as minutes east of UTC. If the
+	 *         timezone is to the west of UTC it is negative.
+	 */
+	public int getTimeZoneOffset() {
+		return tzOffset;
+	}
+
 	public int hashCode() {
 		return getEmailAddress().hashCode() ^ (int) when;
 	}
-- 
1.6.0.1.319.g9f32b
