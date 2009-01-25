From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/4] Cleanup ui plugin.xml, replace deprecated elements and attributes
Date: Sun, 25 Jan 2009 19:52:16 +0100
Message-ID: <1232909538-3279-2-git-send-email-robin.rosenberg@dewire.com>
References: <1232909538-3279-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jan 25 19:53:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRA7B-0004Gp-Le
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbZAYSwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbZAYSwY
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:52:24 -0500
Received: from mail.dewire.com ([83.140.172.130]:1476 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbZAYSwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:52:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1086B147E516;
	Sun, 25 Jan 2009 19:52:22 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sUp8h4gMSZzt; Sun, 25 Jan 2009 19:52:19 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 8AC5F1434D2C;
	Sun, 25 Jan 2009 19:52:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1232909538-3279-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107080>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.xml |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 0b18f15..e5c81e5 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -196,11 +196,16 @@
 
    <extension point="org.eclipse.ui.propertyPages">
       <page
-            objectClass="org.eclipse.core.resources.IProject"
-            adaptable="true"
             name="%Git"
             class="org.spearce.egit.ui.internal.preferences.GitProjectPropertyPage"
             id="org.spearce.egit.ui.preferences.GitProjectPropertyPage">
+	    <enabledWhen>
+		<adapt type="org.eclipse.core.resources.IProject">
+			<test
+		    property="projectPersistentProperty org.eclipse.team.core.repository" value="org.spearce.egit.core.GitProvider">
+			</test>
+		</adapt>
+	    </enabledWhen>
          <filter
                name="projectPersistentProperty"
                value="org.eclipse.team.core.repository=org.spearce.egit.core.GitProvider">
-- 
1.6.1.285.g35d8b
