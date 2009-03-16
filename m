From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 05/10] Rename fields to avoid hiding of field names in ReadTreeTest
Date: Mon, 16 Mar 2009 21:14:38 +0100
Message-ID: <1237234483-3405-6-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-5-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJFW-0007z8-J7
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758669AbZCPUP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758609AbZCPUP0
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:15:26 -0400
Received: from mail.dewire.com ([83.140.172.130]:5282 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757881AbZCPUPY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:15:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 48ED4138AD6F;
	Mon, 16 Mar 2009 21:15:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZISYjrMGPvD; Mon, 16 Mar 2009 21:15:08 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 46EAE138AD5C;
	Mon, 16 Mar 2009 21:14:45 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113373>

---
 .../tst/org/spearce/jgit/lib/ReadTreeTest.java     |  118 ++++++++++----------
 1 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
index 6318633..c9d0565 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
@@ -49,10 +49,10 @@
 
 public class ReadTreeTest extends RepositoryTestCase {
 	
-	private Tree head;
-	private Tree merge;
-	private GitIndex index;
-	private WorkDirCheckout readTree;
+	private Tree theHead;
+	private Tree theMerge;
+	private GitIndex theIndex;
+	private WorkDirCheckout theReadTree;
 	// Each of these rules are from the read-tree manpage
 	// go there to see what they mean.
 	// Rule 0 is left out for obvious reasons :)
@@ -87,9 +87,9 @@ public void testRules1thru3_NoIndexEntry() throws IOException {
 	void setupCase(HashMap<String, String> headEntries, 
 			HashMap<String, String> mergeEntries, 
 			HashMap<String, String> indexEntries) throws IOException {
-		head = buildTree(headEntries);
-		merge = buildTree(mergeEntries);
-		index = buildIndex(indexEntries);
+		theHead = buildTree(headEntries);
+		theMerge = buildTree(mergeEntries);
+		theIndex = buildIndex(indexEntries);
 	}
 	
 	private GitIndex buildIndex(HashMap<String, String> indexEntries) throws IOException {
@@ -129,9 +129,9 @@ ObjectId genSha1(String data) {
 	}
 	
 	private WorkDirCheckout go() throws IOException {
-		readTree = new WorkDirCheckout(db, trash, head, index, merge);
-		readTree.prescanTwoTrees();
-		return readTree;
+		theReadTree = new WorkDirCheckout(db, trash, theHead, theIndex, theMerge);
+		theReadTree.prescanTwoTrees();
+		return theReadTree;
 	}
 
     // for these rules, they all have clean yes/no options
@@ -144,17 +144,17 @@ public void testRules4thru13_IndexEntryNotInHead() throws IOException {
 		idxMap = new HashMap<String, String>();
 		idxMap.put("foo", "foo");
 		setupCase(null, null, idxMap);
-		readTree = go();
+		theReadTree = go();
 		
-		assertTrue(readTree.updated.isEmpty());
-		assertTrue(readTree.removed.isEmpty());
-		assertTrue(readTree.conflicts.isEmpty());
+		assertTrue(theReadTree.updated.isEmpty());
+		assertTrue(theReadTree.removed.isEmpty());
+		assertTrue(theReadTree.conflicts.isEmpty());
 		
 		// rules 6 and 7
 		idxMap = new HashMap<String, String>();
 		idxMap.put("foo", "foo");
 		setupCase(null, idxMap, idxMap);
-		readTree = go();
+		theReadTree = go();
 
 		assertAllEmpty();
 		
@@ -166,9 +166,9 @@ public void testRules4thru13_IndexEntryNotInHead() throws IOException {
 		setupCase(null, mergeMap, idxMap);
 		go();
 		
-		assertTrue(readTree.updated.isEmpty());
-		assertTrue(readTree.removed.isEmpty());
-		assertTrue(readTree.conflicts.contains("foo"));
+		assertTrue(theReadTree.updated.isEmpty());
+		assertTrue(theReadTree.removed.isEmpty());
+		assertTrue(theReadTree.conflicts.contains("foo"));
 		
 		// rule 10
 		
@@ -177,29 +177,29 @@ public void testRules4thru13_IndexEntryNotInHead() throws IOException {
 		setupCase(headMap, null, idxMap);
 		go();
 		
-		assertTrue(readTree.removed.contains("foo"));
-		assertTrue(readTree.updated.isEmpty());
-		assertTrue(readTree.conflicts.isEmpty());
+		assertTrue(theReadTree.removed.contains("foo"));
+		assertTrue(theReadTree.updated.isEmpty());
+		assertTrue(theReadTree.conflicts.isEmpty());
 		
 		// rule 11
 		setupCase(headMap, null, idxMap);
 		new File(trash, "foo").delete();
 		writeTrashFile("foo", "bar");
-		index.getMembers()[0].forceRecheck();
+		theIndex.getMembers()[0].forceRecheck();
 		go();
 		
-		assertTrue(readTree.removed.isEmpty());
-		assertTrue(readTree.updated.isEmpty());
-		assertTrue(readTree.conflicts.contains("foo"));
+		assertTrue(theReadTree.removed.isEmpty());
+		assertTrue(theReadTree.updated.isEmpty());
+		assertTrue(theReadTree.conflicts.contains("foo"));
 		
 		// rule 12 & 13
 		headMap.put("foo", "head");
 		setupCase(headMap, null, idxMap);
 		go();
 		
-		assertTrue(readTree.removed.isEmpty());
-		assertTrue(readTree.updated.isEmpty());
-		assertTrue(readTree.conflicts.contains("foo"));
+		assertTrue(theReadTree.removed.isEmpty());
+		assertTrue(theReadTree.updated.isEmpty());
+		assertTrue(theReadTree.conflicts.contains("foo"));
 		
 		// rules 14 & 15
 		setupCase(headMap, headMap, idxMap);
@@ -209,7 +209,7 @@ public void testRules4thru13_IndexEntryNotInHead() throws IOException {
 		
 		// rules 16 & 17
 		setupCase(headMap, mergeMap, idxMap); go();
-		assertTrue(readTree.conflicts.contains("foo"));
+		assertTrue(theReadTree.conflicts.contains("foo"));
 		
 		// rules 18 & 19
 		setupCase(headMap, idxMap, idxMap); go();
@@ -217,51 +217,51 @@ public void testRules4thru13_IndexEntryNotInHead() throws IOException {
 		
 		// rule 20
 		setupCase(idxMap, mergeMap, idxMap); go();
-		assertTrue(readTree.updated.containsKey("foo"));
+		assertTrue(theReadTree.updated.containsKey("foo"));
 		
 		// rules 21
 		setupCase(idxMap, mergeMap, idxMap); 
 		new File(trash, "foo").delete();
 		writeTrashFile("foo", "bar");
-		index.getMembers()[0].forceRecheck();
+		theIndex.getMembers()[0].forceRecheck();
 		go();
-		assertTrue(readTree.conflicts.contains("foo"));
+		assertTrue(theReadTree.conflicts.contains("foo"));
 	}
 
 	private void assertAllEmpty() {
-		assertTrue(readTree.removed.isEmpty());
-		assertTrue(readTree.updated.isEmpty());
-		assertTrue(readTree.conflicts.isEmpty());
+		assertTrue(theReadTree.removed.isEmpty());
+		assertTrue(theReadTree.updated.isEmpty());
+		assertTrue(theReadTree.conflicts.isEmpty());
 	}
 	
 	public void testDirectoryFileSimple() throws IOException {
-		index = new GitIndex(db);
-		index.add(trash, writeTrashFile("DF", "DF"));
-		Tree treeDF = db.mapTree(index.writeTree());
+		theIndex = new GitIndex(db);
+		theIndex.add(trash, writeTrashFile("DF", "DF"));
+		Tree treeDF = db.mapTree(theIndex.writeTree());
 		
 		recursiveDelete(new File(trash, "DF"));
-		index = new GitIndex(db);
-		index.add(trash, writeTrashFile("DF/DF", "DF/DF"));
-		Tree treeDFDF = db.mapTree(index.writeTree());
+		theIndex = new GitIndex(db);
+		theIndex.add(trash, writeTrashFile("DF/DF", "DF/DF"));
+		Tree treeDFDF = db.mapTree(theIndex.writeTree());
 		
-		index = new GitIndex(db);
+		theIndex = new GitIndex(db);
 		recursiveDelete(new File(trash, "DF"));
 		
-		index.add(trash, writeTrashFile("DF", "DF"));
-		readTree = new WorkDirCheckout(db, trash, treeDF, index, treeDFDF);
-		readTree.prescanTwoTrees();
+		theIndex.add(trash, writeTrashFile("DF", "DF"));
+		theReadTree = new WorkDirCheckout(db, trash, treeDF, theIndex, treeDFDF);
+		theReadTree.prescanTwoTrees();
 		
-		assertTrue(readTree.removed.contains("DF"));
-		assertTrue(readTree.updated.containsKey("DF/DF"));
+		assertTrue(theReadTree.removed.contains("DF"));
+		assertTrue(theReadTree.updated.containsKey("DF/DF"));
 		
 		recursiveDelete(new File(trash, "DF"));
-		index = new GitIndex(db);
-		index.add(trash, writeTrashFile("DF/DF", "DF/DF"));
+		theIndex = new GitIndex(db);
+		theIndex.add(trash, writeTrashFile("DF/DF", "DF/DF"));
 		
-		readTree = new WorkDirCheckout(db, trash, treeDFDF, index, treeDF);
-		readTree.prescanTwoTrees();
-		assertTrue(readTree.removed.contains("DF/DF"));
-		assertTrue(readTree.updated.containsKey("DF"));
+		theReadTree = new WorkDirCheckout(db, trash, treeDFDF, theIndex, treeDF);
+		theReadTree.prescanTwoTrees();
+		assertTrue(theReadTree.removed.contains("DF/DF"));
+		assertTrue(theReadTree.updated.containsKey("DF"));
 	}
 	
 	/*
@@ -467,19 +467,19 @@ private void cleanUpDF() throws Exception {
 	}
 	
 	private void assertConflict(String s) {
-		assertTrue(readTree.conflicts.contains(s));
+		assertTrue(theReadTree.conflicts.contains(s));
 	}
 	
 	private void assertUpdated(String s) {
-		assertTrue(readTree.updated.containsKey(s));
+		assertTrue(theReadTree.updated.containsKey(s));
 	}
 	
 	private void assertRemoved(String s) {
-		assertTrue(readTree.removed.contains(s));
+		assertTrue(theReadTree.removed.contains(s));
 	}
 	
 	private void assertNoConflicts() {
-		assertTrue(readTree.conflicts.isEmpty());
+		assertTrue(theReadTree.conflicts.isEmpty());
 	}
 
 	private void doit(HashMap<String, String> h, HashMap<String, String>m,
@@ -545,8 +545,8 @@ public void testCloseNameConflicts1() throws IOException {
 	}
 
 	private void checkout() throws IOException {
-		readTree = new WorkDirCheckout(db, trash, head, index, merge);
-		readTree.checkout();
+		theReadTree = new WorkDirCheckout(db, trash, theHead, theIndex, theMerge);
+		theReadTree.checkout();
 	}
 	
 	public void testCheckoutOutChanges() throws IOException {
-- 
1.6.1.285.g35d8b
