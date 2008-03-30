From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 4/4] Draw Strings in the history page table with transparent background.
Date: Sun, 30 Mar 2008 11:19:12 -0400
Message-ID: <1206890352-3773-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com, spearce@spearce.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 16:21:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfyPc-0007EI-K0
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 16:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbYC3OUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 10:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbYC3OUr
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 10:20:47 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1944 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752463AbYC3OUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 10:20:46 -0400
Received: (qmail 37748 invoked by uid 0); 30 Mar 2008 11:22:42 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 2.771655 secs); 30 Mar 2008 14:22:42 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.211.226)
  by cvxbsd.convex.com.br with SMTP; 30 Mar 2008 14:22:39 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78506>

To avoid the highlight effect when the table row is selected.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../egit/ui/internal/history/CommitGraphTable.java |    2 +-
 .../egit/ui/internal/history/SWTPlotRenderer.java  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
index d20db77..e2bdb13 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
@@ -232,7 +232,7 @@ class CommitGraphTable {
 
 		final Point textsz = event.gc.textExtent(txt);
 		final int texty = (event.height - textsz.y) / 2;
-		event.gc.drawString(txt, event.x, event.y + texty);
+		event.gc.drawString(txt, event.x, event.y + texty, true);
 	}
 
 	/**
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
index 45660be..1a14719 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
@@ -77,7 +77,7 @@ class SWTPlotRenderer extends AbstractPlotRenderer<SWTLane, Color> {
 		final int texty = (y * 2 - textsz.y) / 2;
 		g.setForeground(cellFG);
 		g.setBackground(cellBG);
-		g.drawString(msg, cellX + x, cellY + texty);
+		g.drawString(msg, cellX + x, cellY + texty, true);
 	}
 
 	protected Color laneColor(final SWTLane myLane) {
-- 
1.5.4.1
