From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/4] Add a method to RepositoryMapping to get the directory for not-yet-mapped projects
Date: Wed,  8 Apr 2009 17:51:29 +0200
Message-ID: <1239205891-28236-2-git-send-email-robin.rosenberg@dewire.com>
References: <1239205891-28236-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:54:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lra67-0003ue-6W
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbZDHPvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755246AbZDHPvm
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:51:42 -0400
Received: from mail.dewire.com ([83.140.172.130]:6925 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092AbZDHPvl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 11:51:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 288C514915DE;
	Wed,  8 Apr 2009 17:51:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KdqeqIjSV-tx; Wed,  8 Apr 2009 17:51:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 90D8A14915D6;
	Wed,  8 Apr 2009 17:51:39 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1239205891-28236-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116092>

Usually a RepositoryMapping has an associated Repository. Not so when it is returned
from the RepositoryFinded.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/core/project/RepositoryMapping.java       |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index e9df630..b49f380 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -234,4 +234,11 @@ public static RepositoryMapping getMapping(final IResource resource) {
 
 		return ((GitProvider)rp).getData().getRepositoryMapping(resource);
 	}
+
+	/**
+	 * @return the name of the .git directory
+	 */
+	public String getGitDir() {
+		return gitdirPath;
+	}
 }
-- 
1.6.2.2.446.gfbdc0
