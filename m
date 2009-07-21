From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/12] Use a Java 5 style iteration over the Config entries list
Date: Tue, 21 Jul 2009 13:19:27 -0700
Message-ID: <1248207570-13880-10-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
 <1248207570-13880-3-git-send-email-spearce@spearce.org>
 <1248207570-13880-4-git-send-email-spearce@spearce.org>
 <1248207570-13880-5-git-send-email-spearce@spearce.org>
 <1248207570-13880-6-git-send-email-spearce@spearce.org>
 <1248207570-13880-7-git-send-email-spearce@spearce.org>
 <1248207570-13880-8-git-send-email-spearce@spearce.org>
 <1248207570-13880-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLq3-0001jT-Lr
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbZGUUUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756130AbZGUUT7
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:59 -0400
Received: from george.spearce.org ([209.20.77.23]:59248 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127AbZGUUTf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8D3F038200; Tue, 21 Jul 2009 20:19:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D490438215;
	Tue, 21 Jul 2009 20:19:33 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123701>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 8eb2e2a..e379c37 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -50,7 +50,6 @@
 import java.util.Collections;
 import java.util.HashMap;
 import java.util.HashSet;
-import java.util.Iterator;
 import java.util.List;
 import java.util.Map;
 import java.util.Set;
@@ -680,9 +679,7 @@ private int findSectionEnd(final String section, final String subsection) {
 	 *             stream to write the configuration to.
 	 */
 	protected void printConfig(final PrintWriter r) {
-		final Iterator<Entry> i = entries.iterator();
-		while (i.hasNext()) {
-			final Entry e = i.next();
+		for (final Entry e : entries) {
 			if (e.prefix != null) {
 				r.print(e.prefix);
 			}
-- 
1.6.4.rc1.186.g60aa0c
