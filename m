From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Avoid NPE in QuickDiffProvider
Date: Tue, 28 Apr 2009 00:52:14 +0200
Message-ID: <1240872734-15261-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Apr 28 00:52:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZgw-00086L-Bd
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 00:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493AbZD0WwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 18:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756959AbZD0WwT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 18:52:19 -0400
Received: from mail.dewire.com ([83.140.172.130]:17875 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151AbZD0WwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 18:52:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6ED4414A8B37;
	Tue, 28 Apr 2009 00:52:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vldbh0TQjPQl; Tue, 28 Apr 2009 00:52:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B864A147E51A;
	Tue, 28 Apr 2009 00:52:14 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.9.gc9550
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117724>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/decorators/GitQuickDiffProvider.java  |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
index 91efb56..b2d48cd 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
@@ -59,6 +59,8 @@ public String getId() {
 	public IDocument getReference(IProgressMonitor monitor)
 			throws CoreException {
 		Activator.trace("(GitQuickDiffProvider) file: " + resource);
+		if (resource == null)
+			return null;
 		RepositoryProvider provider = RepositoryProvider.getProvider(resource
 				.getProject());
 		if (provider != null) {
-- 
1.6.3.rc2.9.gc9550
