From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 03/10] Rename variables that hides others with different content in FetchProcess
Date: Mon, 16 Mar 2009 21:14:36 +0100
Message-ID: <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:16:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJEV-0007a9-1p
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758100AbZCPUOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756939AbZCPUOw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:14:52 -0400
Received: from mail.dewire.com ([83.140.172.130]:5255 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825AbZCPUOu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:14:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 95954138AD64;
	Mon, 16 Mar 2009 21:14:47 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IF8WkqLeJ8-7; Mon, 16 Mar 2009 21:14:46 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id DB203138AD59;
	Mon, 16 Mar 2009 21:14:44 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113366>

---
 .../org/spearce/jgit/transport/FetchProcess.java   |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index df64817..f216cba 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -298,7 +298,7 @@ private void expandSingle(final RefSpec spec, final Set<Ref> matched)
 
 	private Collection<Ref> expandAutoFollowTags() throws TransportException {
 		final Collection<Ref> additionalTags = new ArrayList<Ref>();
-		final Map<String, Ref> have = transport.local.getAllRefs();
+		final Map<String, Ref> haveRefs = transport.local.getAllRefs();
 		for (final Ref r : conn.getRefs()) {
 			if (!isTag(r))
 				continue;
@@ -307,7 +307,7 @@ private void expandSingle(final RefSpec spec, final Set<Ref> matched)
 				continue;
 			}
 
-			final Ref local = have.get(r.getName());
+			final Ref local = haveRefs.get(r.getName());
 			if (local != null) {
 				if (!r.getObjectId().equals(local.getObjectId()))
 					wantTag(r);
@@ -321,11 +321,11 @@ private void expandSingle(final RefSpec spec, final Set<Ref> matched)
 	}
 
 	private void expandFetchTags() throws TransportException {
-		final Map<String, Ref> have = transport.local.getAllRefs();
+		final Map<String, Ref> haveRefs = transport.local.getAllRefs();
 		for (final Ref r : conn.getRefs()) {
 			if (!isTag(r))
 				continue;
-			final Ref local = have.get(r.getName());
+			final Ref local = haveRefs.get(r.getName());
 			if (local == null || !r.getObjectId().equals(local.getObjectId()))
 				wantTag(r);
 		}
-- 
1.6.1.285.g35d8b
