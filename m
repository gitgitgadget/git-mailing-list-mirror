From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Respect background when drawing history in SWT.
Date: Wed,  5 Nov 2008 01:40:43 +0100
Message-ID: <1225845643-28736-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Nov 05 01:42:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxWTH-00044r-RW
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 01:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbYKEAks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 19:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754595AbYKEAks
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 19:40:48 -0500
Received: from mail.dewire.com ([83.140.172.130]:28099 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484AbYKEAkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 19:40:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4B354147CF91;
	Wed,  5 Nov 2008 01:40:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5YGC-MjetwFg; Wed,  5 Nov 2008 01:40:44 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.16])
	by dewire.com (Postfix) with ESMTP id 8D7DC147EACF;
	Wed,  5 Nov 2008 01:40:44 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.578.g6a50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100133>

Use transparent text background for drawing text to make the history
look nice when there is a background pattern or effects like alternating
background colors for each row.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/history/CommitGraphTable.java |    2 +-
 .../egit/ui/internal/history/SWTPlotRenderer.java  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
index a28e3c4..2bccf99 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
@@ -224,7 +224,7 @@ void doPaint(final Event event) {
 
 		final Point textsz = event.gc.textExtent(txt);
 		final int texty = (event.height - textsz.y) / 2;
-		event.gc.drawString(txt, event.x, event.y + texty);
+		event.gc.drawString(txt, event.x, event.y + texty, true);
 	}
 
 	/**
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
index 23ec255..c4ee282 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
@@ -89,7 +89,7 @@ protected void drawText(final String msg, final int x, final int y) {
 		final int texty = (y * 2 - textsz.y) / 2;
 		g.setForeground(cellFG);
 		g.setBackground(cellBG);
-		g.drawString(msg, cellX + x, cellY + texty);
+		g.drawString(msg, cellX + x, cellY + texty, true);
 	}
 
 	protected Color laneColor(final SWTLane myLane) {
-- 
1.6.0.3.578.g6a50
