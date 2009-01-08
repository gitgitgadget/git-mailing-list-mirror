From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/7] Add UNC test case to URIish test
Date: Thu,  8 Jan 2009 17:56:29 +0100
Message-ID: <1231433791-9267-6-git-send-email-robin.rosenberg@dewire.com>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-2-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-3-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-4-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-5-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyDN-0001ZY-IL
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368AbZAHQ4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756143AbZAHQ4n
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:56:43 -0500
Received: from mail.dewire.com ([83.140.172.130]:25787 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753906AbZAHQ4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:56:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8257A1484F72;
	Thu,  8 Jan 2009 17:56:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W0VPszP+TZV3; Thu,  8 Jan 2009 17:56:36 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6B0071484F74;
	Thu,  8 Jan 2009 17:56:33 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231433791-9267-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104940>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/transport/URIishTest.java |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
index 8462dfc..2ea9d60 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
@@ -72,6 +72,16 @@ public void testWindowsFile2() throws Exception {
 		assertEquals(u, new URIish(str));
 	}
 
+	public void testUNC() throws Exception {
+		final String str = "\\\\some\\place";
+		URIish u = new URIish(str);
+		assertNull(u.getScheme());
+		assertFalse(u.isRemote());
+		assertEquals("//some/place", u.getPath());
+		assertEquals("//some/place", u.toString());
+		assertEquals(u, new URIish(str));
+	}
+
 	public void testFileProtoUnix() throws Exception {
 		final String str = "file:///home/m y";
 		URIish u = new URIish(str);
-- 
1.6.1.rc3.56.gd0306
