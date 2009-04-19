From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 2/3] Simulate breakpoints
Date: Sun, 19 Apr 2009 20:30:08 +0200
Message-ID: <1240165809-16703-3-git-send-email-robin.rosenberg@dewire.com>
References: <200904181905.55119.robin.rosenberg.lists@dewire.com>
 <1240165809-16703-1-git-send-email-robin.rosenberg@dewire.com>
 <1240165809-16703-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 19 20:32:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvbo8-0000re-99
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 20:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbZDSSaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 14:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbZDSSaR
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 14:30:17 -0400
Received: from mail.dewire.com ([83.140.172.130]:19119 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278AbZDSSaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 14:30:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D7E3E8026F8;
	Sun, 19 Apr 2009 20:30:13 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GLkj5ED-wDAg; Sun, 19 Apr 2009 20:30:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id DCE3F149164F;
	Sun, 19 Apr 2009 20:30:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240165809-16703-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116910>

---
 .../tst/org/spearce/jgit/lib/WindowCacheTest.java  |    7 +++++++
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    7 +++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
index 0cd55c9..eba1aed 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
@@ -98,6 +98,13 @@ public void testObjectMovedToNewPack() throws IncorrectObjectTypeException,
 
 		// Now here is the interesting thing. Will git figure the new
 		// object exists in the new pack, and not the old one.
+		try {
+			Thread.sleep(2000);
+		} catch (InterruptedException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		}
+		System.gc();
 		assertEquals(o1.name(), new RevWalk(db).parseAny(o1).name());
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 938f44c..f7377d1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -280,6 +280,13 @@ public void close() {
 	}
 
 	void cacheOpen() throws IOException {
+		try {
+			Thread.sleep(2000);
+		} catch (InterruptedException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		}
+		System.gc();
 		fd = new RandomAccessFile(fPath, "r");
 		length = fd.length();
 		try {
-- 
1.6.2.2.446.gfbdc0
