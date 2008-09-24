From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/3] Include a print command line usage string utility
Date: Wed, 24 Sep 2008 23:56:21 +0200
Message-ID: <1222293383-26016-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 24 23:59:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KicO8-0000DW-5N
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 23:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbYIXV5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 17:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYIXV5h
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 17:57:37 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:34422 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbYIXV5g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 17:57:36 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id E6A3138F3B; Wed, 24 Sep 2008 23:57:23 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 9A3B7389BC; Wed, 24 Sep 2008 23:57:23 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 64F1337E44;
	Wed, 24 Sep 2008 23:57:23 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96697>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   40 +++++++++++++++-----
 1 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index 0746eb3..d0fe4af 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -127,22 +127,42 @@ protected void parseArguments(final String[] args) {
 		}
 
 		if (help) {
-			System.err.print("jgit ");
-			System.err.print(commandName);
-			clp.printSingleLineUsage(System.err);
-			System.err.println();
-
-			System.err.println();
-			clp.printUsage(System.err);
-			System.err.println();
-
-			System.exit(1);
+			printUsageAndExit(clp);
 		}
 
 		argWalk = clp.getRevWalkGently();
 	}
 
 	/**
+	 * Print the usage line
+	 *
+	 * @param clp
+	 */
+	public void printUsageAndExit(final CmdLineParser clp) {
+		printUsageAndExit("", clp);
+	}
+
+	/**
+	 * Print an error message and the usage line
+	 *
+	 * @param message
+	 * @param clp
+	 */
+	public void printUsageAndExit(final String message, final CmdLineParser clp) {
+		System.err.println(message);
+		System.err.print("jgit ");
+		System.err.print(commandName);
+		clp.printSingleLineUsage(System.err);
+		System.err.println();
+
+		System.err.println();
+		clp.printUsage(System.err);
+		System.err.println();
+
+		System.exit(1);
+	}
+
+	/**
 	 * Perform the actions of this command.
 	 * <p>
 	 * This method should only be invoked by {@link #execute(String[])}.
-- 
1.6.0.1.310.gf789d0.dirty
