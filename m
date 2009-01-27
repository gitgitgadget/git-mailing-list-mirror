From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Throw created exception
Date: Tue, 27 Jan 2009 23:11:21 +0100
Message-ID: <1233094281-21621-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Jan 27 23:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwAv-0003i6-HL
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbZA0WL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZA0WL1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:11:27 -0500
Received: from mail.dewire.com ([83.140.172.130]:3549 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbZA0WL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:11:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D8598147E6F4;
	Tue, 27 Jan 2009 23:11:22 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JDLGGYyELSr7; Tue, 27 Jan 2009 23:11:22 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 15C3F802AB3;
	Tue, 27 Jan 2009 23:11:21 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107397>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
index 0560c3a..f2cae87 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
@@ -89,7 +89,7 @@ public UnpackedObjectLoader(final Repository db, final AnyObjectId id)
 
 	/**
 	 * Construct an ObjectLoader from a loose object's compressed form.
-	 * 
+	 *
 	 * @param compressed
 	 *            entire content of the loose object file.
 	 * @throws CorruptObjectException
@@ -187,7 +187,7 @@ private void decompress(final AnyObjectId id, final Inflater inf, int p)
 			throw coe;
 		}
 		if (p != objectSize)
-			new CorruptObjectException(id, "incorrect length");
+			throw new CorruptObjectException(id, "incorrect length");
 	}
 
 	public int getType() {
-- 
1.6.1.285.g35d8b
