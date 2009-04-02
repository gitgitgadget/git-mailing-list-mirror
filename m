From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/5] Make the equals method work for AnyObjectId, not just ObjectId
Date: Thu,  2 Apr 2009 20:46:27 +0200
Message-ID: <1238697991-12990-2-git-send-email-robin.rosenberg@dewire.com>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 02 20:51:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpRxi-00078a-7I
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 20:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831AbZDBSqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 14:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756492AbZDBSqs
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 14:46:48 -0400
Received: from mail.dewire.com ([83.140.172.130]:5490 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbZDBSqs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 14:46:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B01DA148898C;
	Thu,  2 Apr 2009 20:46:45 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vzRCjBgSy8MW; Thu,  2 Apr 2009 20:46:45 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id E82561484141;
	Thu,  2 Apr 2009 20:46:44 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.1.345.g89fb
In-Reply-To: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115481>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

This has nothing to do with the series, just trying to squeeze it in... The
quickdiff fixes works fine with our without this patch, but it seems reasonable.

 .../src/org/spearce/jgit/lib/AnyObjectId.java      |    4 ++--
 .../src/org/spearce/jgit/revwalk/RevObject.java    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index e2f70ca..2e3a43e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -248,12 +248,12 @@ public int hashCode() {
 	 *            the other id to compare to. May be null.
 	 * @return true only if both ObjectIds have identical bits.
 	 */
-	public boolean equals(final ObjectId other) {
+	public boolean equals(final AnyObjectId other) {
 		return other != null ? equals(this, other) : false;
 	}
 
 	public boolean equals(final Object o) {
-		return equals((ObjectId) o);
+		return equals((AnyObjectId) o);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
index e8fb29f..1a13d0a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
@@ -75,7 +75,7 @@ public final ObjectId getId() {
 	}
 
 	@Override
-	public final boolean equals(final ObjectId o) {
+	public final boolean equals(final AnyObjectId o) {
 		return this == o;
 	}
 
-- 
1.6.2.1.345.g89fb
