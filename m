From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 28/28] Remove support for legacy style TextBuiltins
Date: Thu, 17 Jul 2008 21:44:21 -0400
Message-ID: <1216345461-59382-29-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
 <1216345461-59382-8-git-send-email-spearce@spearce.org>
 <1216345461-59382-9-git-send-email-spearce@spearce.org>
 <1216345461-59382-10-git-send-email-spearce@spearce.org>
 <1216345461-59382-11-git-send-email-spearce@spearce.org>
 <1216345461-59382-12-git-send-email-spearce@spearce.org>
 <1216345461-59382-13-git-send-email-spearce@spearce.org>
 <1216345461-59382-14-git-send-email-spearce@spearce.org>
 <1216345461-59382-15-git-send-email-spearce@spearce.org>
 <1216345461-59382-16-git-send-email-spearce@spearce.org>
 <1216345461-59382-17-git-send-email-spearce@spearce.org>
 <1216345461-59382-18-git-send-email-spearce@spearce.org>
 <1216345461-59382-19-git-send-email-spearce@spearce.org>
 <1216345461-59382-20-git-send-email-spearce@spearce.org>
 <1216345461-59382-21-git-send-email-spearce@spearce.org>
 <1216345461-59382-22-git-send-email-spearce@spearce.org>
 <1216345461-59382-23-git-send-email-spearce@spearce.org>
 <1216345461-59382-24-git-send-email-spearce@spearce.org>
 <1216345461-59382-25-git-send-email-spearce@spearce.org>
 <1216345461-59382-26-git-send-email-spearce@spearce.org>
 <1216345461-59382-27-git-send-email-spearce@spearce.org>
 <1216345461-59382-28-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4N-0006LD-5e
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbYGRBqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758868AbYGRBqD
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:46:03 -0400
Received: from george.spearce.org ([209.20.77.23]:47012 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758907AbYGRBpV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:45:21 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 14056383A8; Fri, 18 Jul 2008 01:44:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5CCA0383A3;
	Fri, 18 Jul 2008 01:44:34 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-28-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88971>

Now that all builtins use the new automatic parsing support
we want to require that they override run() and do not try
to override execute().

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index c4a55f4..9f90c16 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -113,7 +113,7 @@ public abstract class TextBuiltin {
 	 *             framework will catch the exception and print a message on
 	 *             standard error.
 	 */
-	public void execute(String[] args) throws Exception {
+	public final void execute(String[] args) throws Exception {
 		parseArguments(args);
 		run();
 	}
@@ -166,9 +166,7 @@ public abstract class TextBuiltin {
 	 *             framework will catch the exception and print a message on
 	 *             standard error.
 	 */
-	protected void run() throws Exception {
-		throw die("Override either execute (legacy) or run (new style).");
-	}
+	protected abstract void run() throws Exception;
 
 	/**
 	 * @return the repository this command accesses.
-- 
1.5.6.3.569.ga9185
