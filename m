From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Make RevTag getObject(), getName() final to prevent overrides
Date: Fri, 12 Jun 2009 16:00:15 -0700
Message-ID: <1244847619-7364-2-git-send-email-spearce@spearce.org>
References: <1244847619-7364-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFjl-000336-FL
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbZFLXAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbZFLXAY
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:00:24 -0400
Received: from george.spearce.org ([209.20.77.23]:40048 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbZFLXAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:00:22 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5C9993821F; Fri, 12 Jun 2009 23:00:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 20F9B381FD;
	Fri, 12 Jun 2009 23:00:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
In-Reply-To: <1244847619-7364-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121461>

These methods exist solely to export the object headers from the
tag buffer.  Overriding them may create confusion by trying to
replace the value with something other than what was parsed from
the tag headers.  Other methods like getShortMessage() and the
getTaggerIdent() are likewise already marked final.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index cace82d..83fd873 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -189,7 +189,7 @@ public Tag asTag(final RevWalk walk) {
 	 * 
 	 * @return object this tag refers to.
 	 */
-	public RevObject getObject() {
+	public final RevObject getObject() {
 		return object;
 	}
 
@@ -198,7 +198,7 @@ public RevObject getObject() {
 	 * 
 	 * @return name of the tag, according to the tag header.
 	 */
-	public String getName() {
+	public final String getName() {
 		return name;
 	}
 
-- 
1.6.3.2.367.gf0de
