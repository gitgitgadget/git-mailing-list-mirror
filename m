From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/8] Align commit text properly in jgit glog
Date: Wed,  1 Oct 2008 01:53:43 +0200
Message-ID: <1222818823-22780-4-git-send-email-robin.rosenberg@dewire.com>
References: <1222818823-22780-1-git-send-email-robin.rosenberg@dewire.com>
 <1222818823-22780-2-git-send-email-robin.rosenberg@dewire.com>
 <1222818823-22780-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 01:56:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkp4V-00040Q-OL
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbYI3Xy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYI3Xy4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:54:56 -0400
Received: from av7-1-sn3.vrr.skanova.net ([81.228.9.181]:37734 "EHLO
	av7-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbYI3Xyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:54:51 -0400
Received: by av7-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 5D54A382FF; Wed,  1 Oct 2008 01:54:50 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av7-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 2704037F5F; Wed,  1 Oct 2008 01:54:50 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 0976937E43;
	Wed,  1 Oct 2008 01:54:50 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1222818823-22780-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97175>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/history/SWTPlotRenderer.java  |    3 ---
 .../org/spearce/jgit/awtui/AWTPlotRenderer.java    |    7 +++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
index a58b3bf..7c286a4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
@@ -51,9 +51,6 @@ protected void finalize() throws Throwable {
 		sys_blue.dispose();
 		sys_gray.dispose();
 		sys_darkblue.dispose();
-		sys_yellow.dispose();
-		sys_green.dispose();
-		sys_white.dispose();
 	}
 	
 	void paint(final Event event) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
index a9933a4..5090ec9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
@@ -10,7 +10,6 @@
 
 import org.spearce.jgit.awtui.CommitGraphPane.GraphCellRender;
 import org.spearce.jgit.awtui.SwingCommitList.SwingLane;
-import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revplot.AbstractPlotRenderer;
 import org.spearce.jgit.revplot.PlotCommit;
 
@@ -76,10 +75,10 @@ protected void drawBoundaryDot(final int x, final int y, final int w,
 
 	@Override
 	protected void drawText(final String msg, final int x, final int y) {
-		final int texty = g.getFontMetrics().getHeight()
-				- g.getFontMetrics().getDescent();
+		final int texth = g.getFontMetrics().getHeight();
+		final int y0 = y - texth/2 + (cell.getHeight() - texth)/2;
 		g.setColor(cell.getForeground());
-		g.drawString(msg, x, texty - (cell.getHeight() - y * 2));
+		g.drawString(msg, x, y0 + texth - g.getFontMetrics().getDescent());
 	}
 
 	@Override
-- 
1.6.0.1.310.gf789d0.dirty
