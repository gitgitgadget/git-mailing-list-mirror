From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 07/10] GitIndex: Get access to raw name and file mode
Date: Sun, 24 Feb 2008 00:50:40 +0100
Message-ID: <1203810643-28819-8-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-4-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-5-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-6-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-7-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:52:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4AR-0001IU-Ts
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbYBWXv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbYBWXv2
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:51:28 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11218 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754066AbYBWXu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:50:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0608180069D;
	Sun, 24 Feb 2008 00:50:57 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBY3U5qeO4nd; Sun, 24 Feb 2008 00:50:56 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A9038802819;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 0EB3A293EE; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-7-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74887>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/GitIndex.java         |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 69ed270..d73866a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -598,6 +598,13 @@ public class GitIndex {
 		}
 
 		/**
+		 * @return path name for this entry as byte array, hopefully UTF-8 encoded
+		 */
+		public byte[] getNameUTF8() {
+			return name;
+		}
+
+		/**
 		 * @return SHA-1 of the entry managed by this index
 		 */
 		public ObjectId getObjectId() {
@@ -655,6 +662,14 @@ public class GitIndex {
 			else
 				flags &= ~0x4000;
 		}
+
+		/**
+		 * Return raw file mode bits. See {@link FileMode}
+		 * @return file mode bits
+		 */
+		public int getModeBits() {
+			return mode;
+		}
 	}
 
 	static class Header {
-- 
1.5.4.2
