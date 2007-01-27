From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/2] Show 'StGit/Git' as project decoration
Date: Sun, 28 Jan 2007 00:57:24 +0100
Message-ID: <20070127235724.26097.38563.stgit@lathund.dewire.com>
References: <20070127235718.26097.74542.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 11:15:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB74C-0000tV-7j
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 11:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbXA1KPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 05:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbXA1KPL
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 05:15:11 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11921 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932515AbXA1KPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 05:15:10 -0500
X-Greylist: delayed 1298 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jan 2007 05:15:09 EST
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B0B7F800199;
	Sun, 28 Jan 2007 10:48:53 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21553-10; Sun, 28 Jan 2007 10:48:53 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id DBD60803394;
	Sun, 28 Jan 2007 10:48:50 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 73D542939E;
	Sun, 28 Jan 2007 00:57:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 7hxln9bOxPQm; Sun, 28 Jan 2007 00:57:25 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 69030293A7;
	Sun, 28 Jan 2007 00:57:24 +0100 (CET)
In-Reply-To: <20070127235718.26097.74542.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38029>

Git is spelled like this as is StGit. Since we have some support for 
Stacked Git in the quickdiff code, we should also tell the user if we
are in StGit mode or plain Git mode.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../internal/decorators/GitResourceDecorator.java  |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 60ebd2d..45563da 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -62,7 +62,10 @@ public class GitResourceDecorator extends LabelProvider implements
 
 	RepositoryMapping mapped = d.getRepositoryMapping(rsrc);
 	if (mapped != null) {
-	    decoration.addSuffix(" [GIT]");
+	    if (mapped.getRepository().isStGitMode())
+		decoration.addSuffix(" [StGit]");
+	    else
+		decoration.addSuffix(" [Git]");
 	    decoration.addOverlay(UIIcons.OVR_SHARED);
 	    return;
 	}
