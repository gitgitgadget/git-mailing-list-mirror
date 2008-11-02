From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/1] Respect background when drawing history in SWT.
Date: Mon, 3 Nov 2008 00:38:59 +0100
Message-ID: <200811030039.00218.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 00:40:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwmYO-0005HA-F2
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 00:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYKBXjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 18:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbYKBXjG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 18:39:06 -0500
Received: from mail.dewire.com ([83.140.172.130]:8622 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbYKBXjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 18:39:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E69C28026D1;
	Mon,  3 Nov 2008 00:39:01 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Weud5xfsbnTF; Mon,  3 Nov 2008 00:39:01 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 4B3A1800254;
	Mon,  3 Nov 2008 00:39:01 +0100 (CET)
User-Agent: KMail/1.10.1 (Linux/2.6.27-7-generic; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99888>

Use transparent text background for drawing text to make the history
look nice when there is a background pattern or effects like alternating
background colors for each row.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/history/SWTPlotRenderer.java  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
