From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/7] Test the origName part of the key vs the ref itself
Date: Fri,  7 Nov 2008 23:07:38 +0100
Message-ID: <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:09:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZVp-0008DU-QK
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbYKGWHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbYKGWHv
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:07:51 -0500
Received: from mail.dewire.com ([83.140.172.130]:11950 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbYKGWHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:07:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9A456147CF61;
	Fri,  7 Nov 2008 23:07:47 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l84E2uBaQoNq; Fri,  7 Nov 2008 23:07:45 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 9DF63147EACF;
	Fri,  7 Nov 2008 23:07:45 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.578.g6a50
In-Reply-To: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100341>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 6e2cfa8..12f9ada 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -39,6 +39,8 @@
 
 import java.io.File;
 import java.io.IOException;
+import java.util.Map;
+import java.util.Map.Entry;
 
 import org.spearce.jgit.lib.RefUpdate.Result;
 
@@ -127,4 +129,12 @@ public void testDeleteEmptyDirs() throws IOException {
 	private void assertExists(final boolean expected, final String name) {
 		assertEquals(expected, new File(db.getDirectory(), name).exists());
 	}
+
+	public void testRefKeySameAsOrigName() {
+		Map<String, Ref> allRefs = db.getAllRefs();
+		for (Entry<String, Ref> e : allRefs.entrySet()) {
+			assertEquals(e.getKey(), e.getValue().getOrigName());
+
+		}
+	}
 }
-- 
1.6.0.3.578.g6a50
