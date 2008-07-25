From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/9] Document some common commands with the new Command annotation
Date: Fri, 25 Jul 2008 12:46:04 -0700
Message-ID: <1217015167-4680-7-git-send-email-spearce@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
 <1217015167-4680-2-git-send-email-spearce@spearce.org>
 <1217015167-4680-3-git-send-email-spearce@spearce.org>
 <1217015167-4680-4-git-send-email-spearce@spearce.org>
 <1217015167-4680-5-git-send-email-spearce@spearce.org>
 <1217015167-4680-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:48:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTGg-0005n2-9b
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbYGYTq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbYGYTqZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:25 -0400
Received: from george.spearce.org ([209.20.77.23]:45941 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYGYTqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:12 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 98E5238421; Fri, 25 Jul 2008 19:46:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 93656383A8;
	Fri, 25 Jul 2008 19:46:10 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217015167-4680-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90104>

This way they are known to be common at runtime, by looking at
the annotation associated with the class instance.  Right now
we do not use these annotations but they will be useful soon.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Fetch.java            |    1 +
 .../src/org/spearce/jgit/pgm/Log.java              |    1 +
 .../src/org/spearce/jgit/pgm/Push.java             |    1 +
 .../src/org/spearce/jgit/pgm/Tag.java              |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index 194f669..dcad972 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -47,6 +47,7 @@ import org.spearce.jgit.transport.RefSpec;
 import org.spearce.jgit.transport.TrackingRefUpdate;
 import org.spearce.jgit.transport.Transport;
 
+@Command(common = true, usage = "Update remote refs from another repository")
 class Fetch extends TextBuiltin {
 	@Argument(index = 0, metaVar = "uri-ish")
 	private String remote = "origin";
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
index 780a63b..e16387b 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
@@ -45,6 +45,7 @@ import java.util.TimeZone;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.revwalk.RevCommit;
 
+@Command(common = true, usage = "View commit history")
 class Log extends RevWalkTextBuiltin {
 	private final TimeZone myTZ = TimeZone.getDefault();
 
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index df6c664..6b35ab8 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -51,6 +51,7 @@ import org.spearce.jgit.transport.RemoteRefUpdate;
 import org.spearce.jgit.transport.Transport;
 import org.spearce.jgit.transport.RemoteRefUpdate.Status;
 
+@Command(common = true, usage = "Update remote repository from local refs")
 class Push extends TextBuiltin {
 	@Argument(index = 0, metaVar = "uri-ish")
 	private String remote = "origin";
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
index a7bd037..6c73552 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
@@ -45,6 +45,7 @@ import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.PersonIdent;
 
+@Command(common = true, usage = "Create a tag")
 class Tag extends TextBuiltin {
 	@Option(name = "-f", usage = "force replacing an existing tag")
 	private boolean force;
-- 
1.6.0.rc0.182.gb96c7
