From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/12] Rename Config.unsetString to just unset()
Date: Tue, 21 Jul 2009 13:19:23 -0700
Message-ID: <1248207570-13880-6-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
 <1248207570-13880-3-git-send-email-spearce@spearce.org>
 <1248207570-13880-4-git-send-email-spearce@spearce.org>
 <1248207570-13880-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLpz-0001jT-Qk
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbZGUUTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756139AbZGUUTh
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:37 -0400
Received: from george.spearce.org ([209.20.77.23]:59251 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117AbZGUUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C309E38221; Tue, 21 Jul 2009 20:19:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9078A3821F;
	Tue, 21 Jul 2009 20:19:32 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123704>

Removing a configuration option means deleting it from the file,
implying a value type during the deletion makes no sense.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |    2 +-
 .../org/spearce/jgit/transport/RemoteConfig.java   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 20f42c4..4a60199 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -547,7 +547,7 @@ public void setString(final String section, final String subsection,
 	 * @param name
 	 *            parameter name, e.g. "filemode"
 	 */
-	public void unsetString(final String section, final String subsection,
+	public void unset(final String section, final String subsection,
 			final String name) {
 		setStringList(section, subsection, name, Collections
 				.<String> emptyList());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index fac04f6..93a5873 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -247,7 +247,7 @@ private void set(final RepositoryConfig rc, final String key,
 	}
 
 	private void unset(final RepositoryConfig rc, final String key) {
-		rc.unsetString(SECTION, getName(), key);
+		rc.unset(SECTION, getName(), key);
 	}
 
 	/**
-- 
1.6.4.rc1.186.g60aa0c
