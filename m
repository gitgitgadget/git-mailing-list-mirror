From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 10/10] Drop an effectively unused parameter in IndexTreeWalker.
Date: Mon, 16 Mar 2009 21:14:43 +0100
Message-ID: <1237234483-3405-11-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-5-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-6-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-7-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-8-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-9-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-10-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJFY-0007z8-Kk
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759017AbZCPUPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758970AbZCPUPb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:15:31 -0400
Received: from mail.dewire.com ([83.140.172.130]:5294 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758819AbZCPUP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:15:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7F70F138AD63;
	Mon, 16 Mar 2009 21:15:26 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aADII4D+ofTP; Mon, 16 Mar 2009 21:15:26 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 7EBF3138AD58;
	Mon, 16 Mar 2009 21:14:46 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-10-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113374>

The value was always the same as the field it shadowed
---
 .../src/org/spearce/jgit/lib/IndexTreeWalker.java  |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
index e2078e1..0f1aef4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
@@ -126,7 +126,7 @@ private void walk(Tree tree, Tree auxTree) throws IOException {
 			if (pi != null)
 				visitEntry(pm, pa, pi);
 			else
-				finishVisitTree(pm, pa, curIndexPos, root);
+				finishVisitTree(pm, pa, curIndexPos);
 
 			if (pm != null) m = mi.hasNext() ? mi.next() : null;
 			if (pa != null) a = ai.hasNext() ? ai.next() : null;
@@ -160,7 +160,7 @@ else if (t2 != null)
 				visitor.visitEntry(t1, i, f);
 	}
 
-	private void finishVisitTree(TreeEntry t1, TreeEntry t2, int curIndexPos, File root)
+	private void finishVisitTree(TreeEntry t1, TreeEntry t2, int curIndexPos)
 			throws IOException {
 
 		assert t1 != null || t2 != null : "Needs at least one entry";
-- 
1.6.1.285.g35d8b
