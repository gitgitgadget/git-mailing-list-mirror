From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/13] Expose RepositoryConfig.getBoolean so applications can use it
Date: Mon, 22 Dec 2008 16:27:18 -0800
Message-ID: <1229992043-1053-9-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
 <1229992043-1053-4-git-send-email-spearce@spearce.org>
 <1229992043-1053-5-git-send-email-spearce@spearce.org>
 <1229992043-1053-6-git-send-email-spearce@spearce.org>
 <1229992043-1053-7-git-send-email-spearce@spearce.org>
 <1229992043-1053-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9x-0005lu-Qf
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbYLWA1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbYLWA1o
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:44 -0500
Received: from george.spearce.org ([209.20.77.23]:54486 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbYLWA13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:29 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4AFA338265; Tue, 23 Dec 2008 00:27:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DA2EB38197;
	Tue, 23 Dec 2008 00:27:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103790>

There's no reason for these to be hidden from application level code.
We expose getInt because it is a popular type; getBoolean should also
be exposed because it is also a popular type.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 3291bba..7df90cd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -210,7 +210,7 @@ public int getInt(final String section, String subsection,
 	 * @return true if any value or defaultValue is true, false for missing or
 	 *         explicit false
 	 */
-	protected boolean getBoolean(final String section, final String name,
+	public boolean getBoolean(final String section, final String name,
 			final boolean defaultValue) {
 		return getBoolean(section, null, name, defaultValue);
 	}
@@ -229,7 +229,7 @@ protected boolean getBoolean(final String section, final String name,
 	 * @return true if any value or defaultValue is true, false for missing or
 	 *         explicit false
 	 */
-	protected boolean getBoolean(final String section, String subsection,
+	public boolean getBoolean(final String section, String subsection,
 			final String name, final boolean defaultValue) {
 		String n = getRawString(section, subsection, name);
 		if (n == null)
-- 
1.6.1.rc4.301.g5497a
