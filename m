From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/3] Assert the name and origName properties of Ref objects
Date: Sun,  7 Jun 2009 22:19:09 +0200
Message-ID: <1244405951-21808-2-git-send-email-robin.rosenberg@dewire.com>
References: <y>
 <1244405951-21808-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 07 22:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDOqG-0003R9-J3
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbZFGUTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbZFGUTQ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:19:16 -0400
Received: from mail.dewire.com ([83.140.172.130]:18039 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbZFGUTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:19:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2ACA2146D031;
	Sun,  7 Jun 2009 22:19:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nr7POK9mCNqJ; Sun,  7 Jun 2009 22:19:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 09193146D038;
	Sun,  7 Jun 2009 22:19:14 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <1244405951-21808-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120998>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefTest.java          |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
index 440686d..fabbe7e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefTest.java
@@ -144,4 +144,15 @@ public void testReadSimplePackedRefSameRepo() throws IOException {
 		assertEquals(Storage.LOOSE_PACKED, ref.getStorage());
 	}
 
+	public void testOrigResolvedNamesBranch() throws IOException {
+		Ref ref = db.getRef("a");
+		assertEquals("refs/heads/a", ref.getName());
+		assertEquals("refs/heads/a", ref.getOrigName());
+	}
+
+	public void testOrigResolvedNamesSymRef() throws IOException {
+		Ref ref = db.getRef("HEAD");
+		assertEquals("refs/heads/master", ref.getName());
+		assertEquals("HEAD", ref.getOrigName());
+	}
 }
-- 
1.6.3.2.199.g7340d
