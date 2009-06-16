From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Remove System.out.println from RevWalkFilterTest
Date: Tue, 16 Jun 2009 16:35:25 -0700
Message-ID: <1245195326-9226-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, Mark Struberg <struberg@yahoo.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 01:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGiBl-0004y6-CV
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 01:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbZFPXfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 19:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbZFPXfY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 19:35:24 -0400
Received: from george.spearce.org ([209.20.77.23]:35181 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbZFPXfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 19:35:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D5D79381FE; Tue, 16 Jun 2009 23:35:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 571B538196;
	Tue, 16 Jun 2009 23:35:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.406.gd6a466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121724>

JUnit tests shouldn't (in general) print to System.out, we already
have too much flooding the console when running a full test suite.
Instead assertions should be relied upon, which these tests
already have.

CC: Mark Struberg <struberg@yahoo.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/revwalk/RevWalkFilterTest.java    |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
index e2c813a..5aa648a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
@@ -241,7 +241,6 @@ public void testCommitTimeRevFilter() throws Exception {
 		{
 			RevFilter after = CommitTimeRevFilter.after(since);
 			assertNotNull(after);
-			System.out.println(after.toString());
 			rw.setRevFilter(after);
 			markStart(e);
 			assertCommit(e, rw.next());
@@ -254,7 +253,6 @@ public void testCommitTimeRevFilter() throws Exception {
 		{
 			RevFilter before = CommitTimeRevFilter.before(until);
 			assertNotNull(before);
-			System.out.println(before.toString());
 			rw.reset();
 			rw.setRevFilter(before);
 			markStart(e);
@@ -268,7 +266,6 @@ public void testCommitTimeRevFilter() throws Exception {
 		{
 			RevFilter between = CommitTimeRevFilter.between(since, until);
 			assertNotNull(between);
-			System.out.println(between.toString());
 			rw.reset();
 			rw.setRevFilter(between);
 			markStart(e);
-- 
1.6.3.2.406.gd6a466
