From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 6/7] Treat null scheme as file: in git import wizard
Date: Thu,  8 Jan 2009 17:56:30 +0100
Message-ID: <1231433791-9267-7-git-send-email-robin.rosenberg@dewire.com>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-2-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-3-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-4-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-5-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-6-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:58:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyDO-0001ZY-WC
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704AbZAHQ4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbZAHQ4q
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:56:46 -0500
Received: from mail.dewire.com ([83.140.172.130]:25791 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755704AbZAHQ4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:56:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0AF001484F6F;
	Thu,  8 Jan 2009 17:56:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zPcBxVxhiGRE; Thu,  8 Jan 2009 17:56:37 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B802A1484F48;
	Thu,  8 Jan 2009 17:56:33 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231433791-9267-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104941>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../components/RepositorySelectionPage.java        |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
index 95df71e..db177ec 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
@@ -429,7 +429,7 @@ private static boolean isGIT(final URIish uri) {
 	}
 
 	private static boolean isFile(final URIish uri) {
-		if ("file".equals(uri.getScheme()))
+		if ("file".equals(uri.getScheme()) || uri.getScheme() == null)
 			return true;
 		if (uri.getHost() != null || uri.getPort() > 0 || uri.getUser() != null
 				|| uri.getPass() != null || uri.getPath() == null)
-- 
1.6.1.rc3.56.gd0306
