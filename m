From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 8/9] Remove yet another legacy StGit utility function
Date: Wed, 11 Feb 2009 18:36:58 -0800
Message-ID: <1234406219-19547-9-git-send-email-spearce@spearce.org>
References: <1234406219-19547-1-git-send-email-spearce@spearce.org>
 <1234406219-19547-2-git-send-email-spearce@spearce.org>
 <1234406219-19547-3-git-send-email-spearce@spearce.org>
 <1234406219-19547-4-git-send-email-spearce@spearce.org>
 <1234406219-19547-5-git-send-email-spearce@spearce.org>
 <1234406219-19547-6-git-send-email-spearce@spearce.org>
 <1234406219-19547-7-git-send-email-spearce@spearce.org>
 <1234406219-19547-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRTf-0002tJ-0F
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758316AbZBLCh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758284AbZBLChZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:25 -0500
Received: from george.spearce.org ([209.20.77.23]:39183 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721AbZBLChF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:05 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 267B738211; Thu, 12 Feb 2009 02:37:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AD8BC38215;
	Thu, 12 Feb 2009 02:37:02 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
In-Reply-To: <1234406219-19547-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109566>

We have long since ripped out any StGit support from JGit or EGit.
There is no current caller for this function, and it should have
been removed much sooner.  Take it out now anyway.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 96c62df..30bd4a3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -878,25 +878,6 @@ public String toString() {
 	}
 
 	/**
-	 * @return name of topmost Stacked Git patch.
-	 * @throws IOException
-	 */
-	public String getPatch() throws IOException {
-		final File ptr = new File(getDirectory(),"patches/"+getBranch()+"/applied");
-		final BufferedReader br = new BufferedReader(new FileReader(ptr));
-		String last=null;
-		try {
-			String line;
-			while ((line=br.readLine())!=null) {
-				last = line;
-			}
-		} finally {
-			br.close();
-		}
-		return last;
-	}
-
-	/**
 	 * @return name of current branch
 	 * @throws IOException
 	 */
-- 
1.6.2.rc0.204.gf6b427
