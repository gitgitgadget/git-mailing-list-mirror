From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/9] Remove unnecessary duplicate if (help) test inside TextBuiltin
Date: Fri, 25 Jul 2008 12:46:00 -0700
Message-ID: <1217015167-4680-3-git-send-email-spearce@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
 <1217015167-4680-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTFy-0005XG-AB
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbYGYTqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbYGYTqO
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:14 -0400
Received: from george.spearce.org ([209.20.77.23]:45928 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYGYTqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:09 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 43CB33841F; Fri, 25 Jul 2008 19:46:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B5834383A8;
	Fri, 25 Jul 2008 19:46:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217015167-4680-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90100>

This was caused by a copy-and-paste error as I borrowed the
global argument handling code in Main to help start writing
the command specific argument handling in TextBuiltin.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index d02a0a2..e2eef84 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -145,11 +145,10 @@ public abstract class TextBuiltin {
 			clp.printSingleLineUsage(System.err);
 			System.err.println();
 
-			if (help) {
-				System.err.println();
-				clp.printUsage(System.err);
-				System.err.println();
-			}
+			System.err.println();
+			clp.printUsage(System.err);
+			System.err.println();
+
 			System.exit(1);
 		}
 
-- 
1.6.0.rc0.182.gb96c7
