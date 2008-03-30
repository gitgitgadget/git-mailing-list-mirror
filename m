From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 1/4] Change history page table to SWT.VIRTUAL.
Date: Sun, 30 Mar 2008 11:18:34 -0400
Message-ID: <1206890314-3712-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com, spearce@spearce.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 16:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfyOx-00070m-Q4
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 16:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbYC3OUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 10:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYC3OUI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 10:20:08 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1919 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752257AbYC3OUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 10:20:07 -0400
Received: (qmail 37155 invoked by uid 0); 30 Mar 2008 11:22:03 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.789239 secs); 30 Mar 2008 14:22:03 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.211.226)
  by cvxbsd.convex.com.br with SMTP; 30 Mar 2008 14:22:02 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78503>

It makes the history page show about the same speed as gitk on my
eclipse.

>From the eclipse API:

"Style VIRTUAL is used to create a Table whose TableItems are to be
populated by the client on an on-demand basis instead of up-front.
This can provide significant performance improvements for tables
that are very large or for which TableItem population is expensive
(for example, retrieving values from an external source)."

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
Hi Shawn, Robin,

This patch series is currently on top of 2392caa5a495f72ab25dee10709d98bb21a45ab9
from Shawn's repo.

I didn't apply the find in references patch because it depends on branch
information that is not available yet.

[]s,
Roger.


 .../egit/ui/internal/history/CommitGraphTable.java |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
index fffe7e0..6559d64 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
@@ -88,7 +88,7 @@ class CommitGraphTable {
 		hFont = highlightFont();
 
 		final Table rawTable = new Table(parent, SWT.MULTI | SWT.H_SCROLL
-				| SWT.V_SCROLL | SWT.BORDER | SWT.FULL_SELECTION);
+				| SWT.V_SCROLL | SWT.BORDER | SWT.FULL_SELECTION | SWT.VIRTUAL);
 		rawTable.setHeaderVisible(true);
 		rawTable.setLinesVisible(false);
 		rawTable.setFont(nFont);
-- 
1.5.4.1
