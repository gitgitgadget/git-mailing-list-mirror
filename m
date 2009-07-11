From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/11] Expose the Repository's ObjectDatabase object
Date: Sat, 11 Jul 2009 13:19:24 -0700
Message-ID: <1247343566-19025-10-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
 <1247343566-19025-2-git-send-email-spearce@spearce.org>
 <1247343566-19025-3-git-send-email-spearce@spearce.org>
 <1247343566-19025-4-git-send-email-spearce@spearce.org>
 <1247343566-19025-5-git-send-email-spearce@spearce.org>
 <1247343566-19025-6-git-send-email-spearce@spearce.org>
 <1247343566-19025-7-git-send-email-spearce@spearce.org>
 <1247343566-19025-8-git-send-email-spearce@spearce.org>
 <1247343566-19025-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj30-0003MO-9O
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbZGKUTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbZGKUTl
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:41 -0400
Received: from george.spearce.org ([209.20.77.23]:39716 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbZGKUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C381838215; Sat, 11 Jul 2009 20:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D7A6438222;
	Sat, 11 Jul 2009 20:19:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123122>

Some code may need direct access to the database reference; this
actually should be preferred over direct access to the objects
directory as the database is a much more abstract concept.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index e3ac01b..1076fe1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -187,6 +187,13 @@ public File getObjectsDirectory() {
 	}
 
 	/**
+	 * @return the object database which stores this repository's data.
+	 */
+	public ObjectDatabase getObjectDatabase() {
+		return objectDatabase;
+	}
+
+	/**
 	 * @return the configuration of this repository
 	 */
 	public RepositoryConfig getConfig() {
-- 
1.6.4.rc0.117.g28cb
