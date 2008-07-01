From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/8] Shorten progress message text from PackWriter
Date: Mon, 30 Jun 2008 23:04:01 -0400
Message-ID: <1214881445-3931-5-git-send-email-spearce@spearce.org>
References: <1214881445-3931-1-git-send-email-spearce@spearce.org>
 <1214881445-3931-2-git-send-email-spearce@spearce.org>
 <1214881445-3931-3-git-send-email-spearce@spearce.org>
 <1214881445-3931-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 05:14:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDWKB-0003pl-9S
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 05:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbYGADNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 23:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbYGADN3
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 23:13:29 -0400
Received: from george.spearce.org ([209.20.77.23]:58265 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYGADMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 23:12:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 014953821F; Tue,  1 Jul 2008 03:04:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=4.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8D9A338153;
	Tue,  1 Jul 2008 03:04:29 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214881445-3931-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86999>

There are traditionally three phases to a pack algorithm:

 the enumeration phase, commonly called "Counting objects"
 the delta search phase, commonly called "Compressing objects"
 the output phase, commonly called "Writing objects"

Our prior messages were too long for the text progress display
and caused the progress meters to not line up vertically on the
console.  The shorter (and more traditional) text does fit into
the column structure used by the text progress display.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 9a427da..0439656 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -102,7 +102,7 @@ public class PackWriter {
 	 *
 	 * @see #preparePack(Collection, Collection, boolean, boolean)
 	 */
-	public static final String COUNTING_OBJECTS_PROGRESS = "Counting objects to pack";
+	public static final String COUNTING_OBJECTS_PROGRESS = "Counting objects";
 
 	/**
 	 * Title of {@link ProgressMonitor} task used during searching for objects
@@ -110,7 +110,7 @@ public class PackWriter {
 	 *
 	 * @see #writePack(OutputStream)
 	 */
-	public static final String SEARCHING_REUSE_PROGRESS = "Searching for delta and object reuse";
+	public static final String SEARCHING_REUSE_PROGRESS = "Compressing objects";
 
 	/**
 	 * Title of {@link ProgressMonitor} task used during writing out pack
-- 
1.5.6.74.g8a5e
