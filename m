From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH] Update Index (refresh) doesn't do anything obvious
Date: Mon, 22 Jun 2009 21:27:09 +0200
Message-ID: <1245698829-28347-1-git-send-email-robin.rosenberg@dewire.com>
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 21:27:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIpAp-0004cw-Tk
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 21:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbZFVT1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 15:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbZFVT1K
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 15:27:10 -0400
Received: from mail.dewire.com ([83.140.172.130]:29061 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbZFVT1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 15:27:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B0FCD147E978;
	Mon, 22 Jun 2009 21:27:11 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Yo2W+f6QzRX; Mon, 22 Jun 2009 21:27:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C3D18147E8DA;
	Mon, 22 Jun 2009 21:27:10 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122057>

The bug reported against EGit is reall an JGit bug and
is quite easy to fix, which is why I do it rather than drop
the GitIndex usage and replace with DirCache.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/GitIndex.java         |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 21b495a..6484535 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -468,7 +468,7 @@ public boolean update(File f) throws IOException {
 			if (modified) {
 				size = (int) f.length();
 				ObjectWriter writer = new ObjectWriter(db);
-				ObjectId newsha1 = sha1 = writer.writeBlob(f);
+				ObjectId newsha1 = writer.writeBlob(f);
 				if (!newsha1.equals(sha1))
 					modified = true;
 				sha1 = newsha1;
@@ -491,7 +491,7 @@ public boolean update(File f, byte[] newContent) throws IOException {
 			boolean modified = false;
 			size = newContent.length;
 			ObjectWriter writer = new ObjectWriter(db);
-			ObjectId newsha1 = sha1 = writer.writeBlob(newContent);
+			ObjectId newsha1 = writer.writeBlob(newContent);
 			if (!newsha1.equals(sha1))
 				modified = true;
 			sha1 = newsha1;
-- 
1.6.3.2.199.g7340d
