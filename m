From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/2] Fixed an old failed EGit unit test.
Date: Wed, 17 Dec 2008 01:07:19 +0100
Message-ID: <1229472439-24104-3-git-send-email-robin.rosenberg@dewire.com>
References: <1229472439-24104-1-git-send-email-robin.rosenberg@dewire.com>
 <1229472439-24104-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Dec 17 01:10:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCjzy-0002Ha-BE
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 01:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759852AbYLQAH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 19:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759916AbYLQAH2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 19:07:28 -0500
Received: from mail.dewire.com ([83.140.172.130]:4316 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759852AbYLQAH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 19:07:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F1475147E525;
	Wed, 17 Dec 2008 01:07:23 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xm9JUO4PRXyQ; Wed, 17 Dec 2008 01:07:21 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 2F7AC147E527;
	Wed, 17 Dec 2008 01:07:20 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1229472439-24104-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103300>

The index was dropped from the history with Shawns revision walker.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/core/internal/mapping/T0002_history.java  |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java
index b540e10..71f5cc5 100644
--- a/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java
@@ -98,8 +98,7 @@ public void testShallowHistory() {
 		IFileHistoryProvider fileHistoryProvider = provider.getFileHistoryProvider();
 		IFileHistory fileHistory = fileHistoryProvider.getFileHistoryFor(project.getProject().getWorkspace().getRoot().findMember("Project-1/A.txt"), IFileHistoryProvider.SINGLE_LINE_OF_DESCENT, new NullProgressMonitor());
 		IFileRevision[] fileRevisions = fileHistory.getFileRevisions();
-		assertEquals(2, fileRevisions.length);
-		assertEquals("Index", fileRevisions[0].getContentIdentifier());
-		assertEquals("6dd8f0b51204fa24a01734971947847549ec4ba8", fileRevisions[1].getContentIdentifier());
+		assertEquals(1, fileRevisions.length);
+		assertEquals("6dd8f0b51204fa24a01734971947847549ec4ba8", fileRevisions[0].getContentIdentifier());
 	}
 }
-- 
1.6.0.3.640.g6331a
