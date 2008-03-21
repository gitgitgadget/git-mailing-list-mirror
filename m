From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 1/4] Fix for the revision detail viewer losing it's proportion in the history page.
Date: Fri, 21 Mar 2008 18:07:21 -0400
Message-ID: <1206137241-4035-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 22:09:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcoU4-0007Jv-GE
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 22:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762015AbYCUVIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761995AbYCUVIU
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 17:08:20 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1063 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761892AbYCUVIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 17:08:19 -0400
Received: (qmail 91646 invoked by uid 0); 21 Mar 2008 18:10:56 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.775741 secs); 21 Mar 2008 21:10:56 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.226.196)
  by cvxbsd.convex.com.br with SMTP; 21 Mar 2008 21:10:55 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77767>

The layout of the viewer is managed by the SashForm, so there's no need
anymore to set the layout data in every history refresh.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 268a6ba..ae1dfbf 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -1072,7 +1072,6 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 						table.removeAll();
 						table.setItemCount(fileRevisions.size());
 						table.setData("X");
-						table.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,true));
 						System.out.println("inputchanged, invoking refresh");
 						appliedPatches = fnewappliedPatches;
 						tags = ftags;
-- 
1.5.4.1
