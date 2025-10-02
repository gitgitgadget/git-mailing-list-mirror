Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436311CAF
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443206; cv=none; b=Xw/zrBeYtUBcfcWzhhErHlhhNg7vSt8OtKR9UDLW6aYP2mwU6cYSEvI1PPIooalEc9qvyYuVVi8Chp4+Jc9MP7R7UF+HrTs16/dCsiLEef3fLNVIRvyKNwIIKAzcfBvOmct1Lk5W+cYBUdXggqVDcVGo7fIqwRlyZ0WZDqugSSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443206; c=relaxed/simple;
	bh=qGGG2lQsomE1vB370WTOGgIUlmgkFWqF9gYJqDLMCr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh8ZilQwDzluY1NXVSwxFXu9KZ4mD3se0i4jr+uxo+hUPuikxwLY+4kWXi8P3o0f4tNdx7m8W3Xl4aa0eK41wy+oYvJ/cnaIEcVo3WCH7p+mnfhOP5RQLtXl7tN7Und6pfUHCf+ziWS4G3D4h3C1pegsOb+ueJ8HrTiYd5A2sVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=jnplkAg3; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jnplkAg3"
Received: from inspiron-LM22 ([80.189.83.109])
	by smtp with ESMTPA
	id 4RXivYtrc2D8r4RYAvkVy5; Thu, 02 Oct 2025 23:13:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759443202; bh=H9WgaBH0yBXOkHSrlFy0dVq6Xcre3HXuQTmIqjf+Yv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnplkAg3sDvv3mm/F1O1iaaLgQSD0qgPe+UMojKoWr93/+C4rp5o5d4qetGT1kDc5
	 UnsfhopLarzZYk9iJmfMDTbEk60xGRWR8EkhmwUjk7TjdF3yI4rdYEY4ATBymG93+6
	 ZSxDrXzxEpUEnHGGwkQVDLAAzo6AkwQ2aLdPy2yDAUHxjrDSwgxAjgpyKynw8M/HGI
	 U3QqUXgAGvLbh7UALvbAz6zVh76S7aYQmsKJhZ+Hq80y6ashXjx+Hvo88FztzlaDNG
	 w9QgrnaSzweguAa+P2/0fywa3EPPxzI1AP5Z/QUy+JtgNfySFS7Nd110bje8YUvT1P
	 H370tbhB+VQCg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=beTIU/PB c=1 sm=1 tr=0 ts=68def902
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=JsNdFBV1oH68kOVJ20EA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 2/4] doc: remembering-renames.adoc: fix asciidoc warnings
Date: Thu,  2 Oct 2025 23:12:14 +0100
Message-ID: <20251002221233.541844-3-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
 <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfExWWtff24yNlJYiWJ42ce0FmT3fRu+Q1UU1p1BCzwSikaM8s7dYgwmZ4VcLpJzwvUW2WQmwZCfa+bnG6KrJsrY4Lv++Iuws7f+sa2NGKeBD6xWIeunJ
 6BXkeClETeUDv2EWBcpXEeHMuhfTD4OGcwj0LBaGt2ceWx/7M0SrD39yQtPB7JBOjIrpk+HY6QG4BSxzfq/Lc2UYWyXMmiIINdI=

Both asciidoc and ascidoctor issue warnings about 'list item index:
expected n got n-1' for n=1->9 on lines 13, 15, 17, 20, 23, 25, 29,
31 and 33. In asciidoc, numbered lists must start at one, whereas this
file has a list starting at zero. Also, asciidoc and asciidoctor warn
about 'section title out of sequence: expected level 1, got level 2'
on line 38. (asciidoc only complains about the first instance of this,
while asciidoctor complains about them all, on lines 94, 141, 142,
184, 185, 257, 288, 289, 290, 397, 424, 485, 486 and 487). These
warnings stem from the section titles not being correctly nested within
a document/chapter title.

In order to address the first set of warnings, simply renumber the list
from one to nine, rather than zero to eight. This also requires altering
the text which refers to the section numbers, including other section
titles.

In order to address the second set of warnings, change the section title
syntax from '=== title ===' to '== title ==', effectively reducing the
nesting level of the title by one. Also, some of the titles are given
over multiple lines (they are very long), with an title '===' prefix
on each line. This leads to them being treated as separate sections
with no body text (as you can see from the line numbers given for the
asciidoctor warnings, above). So, for these titles, turn them into a
single (long) line of text.

In addition to the warnings, address some other formatting issues:

  - the ascii branch diagrams didn't format correctly on asciidoctor
    so include them in a literal block.
  - several blocks of text were intended to be formatted 'as is' but
    were not included in a literal block.
  - in section 8, format the (A)->(D) in the text description as a
    literal with `` marks, since (C) is rendered as a copyright
    symbol in html otherwise.
  - in section 9, a sub-list of two items is not formatted as such.
    change the '*' introducer to '**' to correct the sub-list format.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 .../technical/remembering-renames.adoc        | 120 ++++++++++++------
 1 file changed, 78 insertions(+), 42 deletions(-)

diff --git a/Documentation/technical/remembering-renames.adoc b/Documentation/technical/remembering-renames.adoc
index 73f41761e2..6155f36c72 100644
--- a/Documentation/technical/remembering-renames.adoc
+++ b/Documentation/technical/remembering-renames.adoc
@@ -10,32 +10,32 @@ history as an optimization, assuming all merges are automatic and clean
 
 Outline:
 
-  0. Assumptions
+  1. Assumptions
 
-  1. How rebasing and cherry-picking work
+  2. How rebasing and cherry-picking work
 
-  2. Why the renames on MERGE_SIDE1 in any given pick are *always* a
+  3. Why the renames on MERGE_SIDE1 in any given pick are *always* a
      superset of the renames on MERGE_SIDE1 for the next pick.
 
-  3. Why any rename on MERGE_SIDE1 in any given pick is _almost_ always also
+  4. Why any rename on MERGE_SIDE1 in any given pick is _almost_ always also
      a rename on MERGE_SIDE1 for the next pick
 
-  4. A detailed description of the counter-examples to #3.
+  5. A detailed description of the counter-examples to #4.
 
-  5. Why the special cases in #4 are still fully reasonable to use to pair
+  6. Why the special cases in #5 are still fully reasonable to use to pair
      up files for three-way content merging in the merge machinery, and why
      they do not affect the correctness of the merge.
 
-  6. Interaction with skipping of "irrelevant" renames
+  7. Interaction with skipping of "irrelevant" renames
 
-  7. Additional items that need to be cached
+  8. Additional items that need to be cached
 
-  8. How directory rename detection interacts with the above and why this
+  9. How directory rename detection interacts with the above and why this
      optimization is still safe even if merge.directoryRenames is set to
      "true".
 
 
-=== 0. Assumptions ===
+== 1. Assumptions ==
 
 There are two assumptions that will hold throughout this document:
 
@@ -44,8 +44,8 @@ There are two assumptions that will hold throughout this document:
 
   * All merges are fully automatic
 
-and a third that will hold in sections 2-5 for simplicity, that I'll later
-address in section 8:
+and a third that will hold in sections 3-6 for simplicity, that I'll later
+address in section 9:
 
   * No directory renames occur
 
@@ -77,9 +77,9 @@ conflicts that the user needs to resolve), the cache of renames is not
 stored on disk, and thus is thrown away as soon as the rebase or cherry
 pick stops for the user to resolve the operation.
 
-The third assumption makes sections 2-5 simpler, and allows people to
+The third assumption makes sections 3-6 simpler, and allows people to
 understand the basics of why this optimization is safe and effective, and
-then I can go back and address the specifics in section 8.  It is probably
+then I can go back and address the specifics in section 9.  It is probably
 also worth noting that if directory renames do occur, then the default of
 merge.directoryRenames being set to "conflict" means that the operation
 will stop for users to resolve the conflicts and the cache will be thrown
@@ -88,22 +88,26 @@ reason we need to address directory renames specifically, is that some
 users will have set merge.directoryRenames to "true" to allow the merges to
 continue to proceed automatically.  The optimization is still safe with
 this config setting, but we have to discuss a few more cases to show why;
-this discussion is deferred until section 8.
+this discussion is deferred until section 9.
 
 
-=== 1. How rebasing and cherry-picking work ===
+== 2. How rebasing and cherry-picking work ==
 
 Consider the following setup (from the git-rebase manpage):
 
+------------
 		     A---B---C topic
 		    /
 	       D---E---F---G main
+------------
 
 After rebasing or cherry-picking topic onto main, this will appear as:
 
+------------
 			     A'--B'--C' topic
 			    /
 	       D---E---F---G main
+------------
 
 The way the commits A', B', and C' are created is through a series of
 merges, where rebase or cherry-pick sequentially uses each of the three
@@ -111,6 +115,7 @@ A-B-C commits in a special merge operation.  Let's label the three commits
 in the merge operation as MERGE_BASE, MERGE_SIDE1, and MERGE_SIDE2.  For
 this picture, the three commits for each of the three merges would be:
 
+....
 To create A':
    MERGE_BASE:   E
    MERGE_SIDE1:  G
@@ -125,6 +130,7 @@ To create C':
    MERGE_BASE:   B
    MERGE_SIDE1:  B'
    MERGE_SIDE2:  C
+....
 
 Sometimes, folks are surprised that these three-way merges are done.  It
 can be useful in understanding these three-way merges to view them in a
@@ -138,8 +144,7 @@ Conceptually the two statements above are the same as a three-way merge of
 B, B', and C, at least the parts before you decide to record a commit.
 
 
-=== 2. Why the renames on MERGE_SIDE1 in any given pick are always a ===
-===    superset of the renames on MERGE_SIDE1 for the next pick.     ===
+== 3. Why the renames on MERGE_SIDE1 in any given pick are always a superset of the renames on MERGE_SIDE1 for the next pick. ==
 
 The merge machinery uses the filenames it is fed from MERGE_BASE,
 MERGE_SIDE1, and MERGE_SIDE2.  It will only move content to a different
@@ -156,6 +161,7 @@ filename under one of three conditions:
 First, let's remember what commits are involved in the first and second
 picks of the cherry-pick or rebase sequence:
 
+....
 To create A':
    MERGE_BASE:   E
    MERGE_SIDE1:  G
@@ -165,6 +171,7 @@ To create B':
    MERGE_BASE:   A
    MERGE_SIDE1:  A'
    MERGE_SIDE2:  B
+....
 
 So, in particular, we need to show that the renames between E and G are a
 superset of those between A and A'.
@@ -181,11 +188,11 @@ are a subset of those between E and G.  Equivalently, all renames between E
 and G are a superset of those between A and A'.
 
 
-=== 3. Why any rename on MERGE_SIDE1 in any given pick is _almost_   ===
-===    always also a rename on MERGE_SIDE1 for the next pick.        ===
+== 4. Why any rename on MERGE_SIDE1 in any given pick is _almost_ always also a rename on MERGE_SIDE1 for the next pick. ==
 
 Let's again look at the first two picks:
 
+....
 To create A':
    MERGE_BASE:   E
    MERGE_SIDE1:  G
@@ -195,17 +202,25 @@ To create B':
    MERGE_BASE:   A
    MERGE_SIDE1:  A'
    MERGE_SIDE2:  B
+....
 
 Now let's look at any given rename from MERGE_SIDE1 of the first pick, i.e.
 any given rename from E to G.  Let's use the filenames 'oldfile' and
 'newfile' for demonstration purposes.  That first pick will function as
 follows; when the rename is detected, the merge machinery will do a
 three-way content merge of the following:
+
+....
     E:oldfile
     G:newfile
     A:oldfile
+....
+
 and produce a new result:
+
+....
     A':newfile
+....
 
 Note above that I've assumed that E->A did not rename oldfile.  If that
 side did rename, then we most likely have a rename/rename(1to2) conflict
@@ -254,19 +269,21 @@ were detected as renames, A:oldfile and A':newfile should also be
 detectable as renames almost always.
 
 
-=== 4. A detailed description of the counter-examples to #3.         ===
+== 5. A detailed description of the counter-examples to #4. ==
 
-We already noted in section 3 that rename/rename(1to1) (i.e. both sides
+We already noted in section 4 that rename/rename(1to1) (i.e. both sides
 renaming a file the same way) was one counter-example.  The more
 interesting bit, though, is why did we need to use the "almost" qualifier
 when stating that A:oldfile and A':newfile are "almost" always detectable
 as renames?
 
-Let's repeat an earlier point that section 3 made:
+Let's repeat an earlier point that section 4 made:
 
+....
   A':newfile was created by applying the changes between E:oldfile and
   G:newfile to A:oldfile.  The changes between E:oldfile and G:newfile were
   <50% of the size of E:oldfile.
+....
 
 If those changes that were <50% of the size of E:oldfile are also <50% of
 the size of A:oldfile, then A:oldfile and A':newfile will be detectable as
@@ -276,18 +293,21 @@ still somehow merge cleanly), then traditional rename detection would not
 detect A:oldfile and A':newfile as renames.
 
 Here's an example where that can happen:
+
   * E:oldfile had 20 lines
   * G:newfile added 10 new lines at the beginning of the file
   * A:oldfile kept the first 3 lines of the file, and deleted all the rest
+
 then
+
+....
   => A':newfile would have 13 lines, 3 of which matches those in A:oldfile.
-E:oldfile -> G:newfile would be detected as a rename, but A:oldfile and
-A':newfile would not be.
+  E:oldfile -> G:newfile would be detected as a rename, but A:oldfile and
+  A':newfile would not be.
+....
 
 
-=== 5. Why the special cases in #4 are still fully reasonable to use to    ===
-===    pair up files for three-way content merging in the merge machinery, ===
-===    and why they do not affect the correctness of the merge.            ===
+== 6. Why the special cases in #5 are still fully reasonable to use to pair up files for three-way content merging in the merge machinery, and why they do not affect the correctness of the merge. ==
 
 In the rename/rename(1to1) case, A:newfile and A':newfile are not renames
 since they use the *same* filename.  However, files with the same filename
@@ -295,14 +315,14 @@ are obviously fine to pair up for three-way content merging (the merge
 machinery has never employed break detection).  The interesting
 counter-example case is thus not the rename/rename(1to1) case, but the case
 where A did not rename oldfile.  That was the case that we spent most of
-the time discussing in sections 3 and 4.  The remainder of this section
+the time discussing in sections 4 and 5.  The remainder of this section
 will be devoted to that case as well.
 
 So, even if A:oldfile and A':newfile aren't detectable as renames, why is
 it still reasonable to pair them up for three-way content merging in the
 merge machinery?  There are multiple reasons:
 
-  * As noted in sections 3 and 4, the diff between A:oldfile and A':newfile
+  * As noted in sections 4 and 5, the diff between A:oldfile and A':newfile
     is *exactly* the same as the diff between E:oldfile and G:newfile.  The
     latter pair were detected as renames, so it seems unlikely to surprise
     users for us to treat A:oldfile and A':newfile as renames.
@@ -394,7 +414,7 @@ cases 1 and 3 seem to provide as good or better behavior with the
 optimization than without.
 
 
-=== 6. Interaction with skipping of "irrelevant" renames ===
+== 7. Interaction with skipping of "irrelevant" renames ==
 
 Previous optimizations involved skipping rename detection for paths
 considered to be "irrelevant".  See for example the following commits:
@@ -421,24 +441,27 @@ detection -- though we can limit it to the paths for which we have not
 already detected renames.
 
 
-=== 7. Additional items that need to be cached ===
+== 8. Additional items that need to be cached ==
 
 It turns out we have to cache more than just renames; we also cache:
 
+....
   A) non-renames (i.e. unpaired deletes)
   B) counts of renames within directories
   C) sources that were marked as RELEVANT_LOCATION, but which were
      downgraded to RELEVANT_NO_MORE
   D) the toplevel trees involved in the merge
+....
 
 These are all stored in struct rename_info, and respectively appear in
+
   * cached_pairs (along side actual renames, just with a value of NULL)
   * dir_rename_counts
   * cached_irrelevant
   * merge_trees
 
-The reason for (A) comes from the irrelevant renames skipping
-optimization discussed in section 6.  The fact that irrelevant renames
+The reason for `(A)` comes from the irrelevant renames skipping
+optimization discussed in section 7.  The fact that irrelevant renames
 are skipped means we only get a subset of the potential renames
 detected and subsequent commits may need to run rename detection on
 the upstream side on a subset of the remaining renames (to get the
@@ -447,23 +470,24 @@ deletes are involved in rename detection too, we don't want to
 repeatedly check that those paths remain unpaired on the upstream side
 with every commit we are transplanting.
 
-The reason for (B) is that diffcore_rename_extended() is what
+The reason for `(B)` is that diffcore_rename_extended() is what
 generates the counts of renames by directory which is needed in
 directory rename detection, and if we don't run
 diffcore_rename_extended() again then we need to have the output from
 it, including dir_rename_counts, from the previous run.
 
-The reason for (C) is that merge-ort's tree traversal will again think
+The reason for `(C)` is that merge-ort's tree traversal will again think
 those paths are relevant (marking them as RELEVANT_LOCATION), but the
 fact that they were downgraded to RELEVANT_NO_MORE means that
 dir_rename_counts already has the information we need for directory
 rename detection.  (A path which becomes RELEVANT_CONTENT in a
 subsequent commit will be removed from cached_irrelevant.)
 
-The reason for (D) is that is how we determine whether the remember
+The reason for `(D)` is that is how we determine whether the remember
 renames optimization can be used.  In particular, remembering that our
 sequence of merges looks like:
 
+....
    Merge 1:
    MERGE_BASE:   E
    MERGE_SIDE1:  G
@@ -475,6 +499,7 @@ sequence of merges looks like:
    MERGE_SIDE1:  A'
    MERGE_SIDE2:  B
    => Creates    B'
+....
 
 It is the fact that the trees A and A' appear both in Merge 1 and in
 Merge 2, with A as a parent of A' that allows this optimization.  So
@@ -482,12 +507,11 @@ we store the trees to compare with what we are asked to merge next
 time.
 
 
-=== 8. How directory rename detection interacts with the above and   ===
-===    why this optimization is still safe even if                   ===
-===    merge.directoryRenames is set to "true".                      ===
+== 9. How directory rename detection interacts with the above and why this optimization is still safe even if merge.directoryRenames is set to "true". ==
 
 As noted in the assumptions section:
 
+....
     """
     ...if directory renames do occur, then the default of
     merge.directoryRenames being set to "conflict" means that the operation
@@ -497,11 +521,13 @@ As noted in the assumptions section:
     is that some users will have set merge.directoryRenames to "true" to
     allow the merges to continue to proceed automatically.
     """
+....
 
 Let's remember that we need to look at how any given pick affects the next
 one.  So let's again use the first two picks from the diagram in section
 one:
 
+....
   First pick does this three-way merge:
     MERGE_BASE:   E
     MERGE_SIDE1:  G
@@ -513,6 +539,7 @@ one:
     MERGE_SIDE1:  A'
     MERGE_SIDE2:  B
     => creates B'
+....
 
 Now, directory rename detection exists so that if one side of history
 renames a directory, and the other side adds a new file to the old
@@ -545,7 +572,7 @@ while considering all of these cases:
     concerned; see the assumptions section).  Two interesting sub-notes
     about these counts:
 
-    * If we need to perform rename-detection again on the given side (e.g.
+   ** If we need to perform rename-detection again on the given side (e.g.
       some paths are relevant for rename detection that weren't before),
       then we clear dir_rename_counts and recompute it, making use of
       cached_pairs.  The reason it is important to do this is optimizations
@@ -556,7 +583,7 @@ while considering all of these cases:
       easiest way to "fix up" dir_rename_counts in such cases is to just
       recompute it.
 
-    * If we prune rename/rename(1to1) entries from the cache, then we also
+   ** If we prune rename/rename(1to1) entries from the cache, then we also
       need to update dir_rename_counts to decrement the counts for the
       involved directory and any relevant parent directories (to undo what
       update_dir_rename_counts() in diffcore-rename.c incremented when the
@@ -578,6 +605,7 @@ in order:
 
 Case 1: MERGE_SIDE1 renames old dir, MERGE_SIDE2 adds new file to old dir
 
+....
   This case looks like this:
 
     MERGE_BASE:   E,   Has olddir/
@@ -595,10 +623,13 @@ Case 1: MERGE_SIDE1 renames old dir, MERGE_SIDE2 adds new file to old dir
     * MERGE_SIDE1 has cached olddir/newfile -> newdir/newfile
   Given the cached rename noted above, the second merge can proceed as
   expected without needing to perform rename detection from A -> A'.
+....
 
 Case 2: MERGE_SIDE1 renames old dir, MERGE_SIDE2 renames  file into old dir
 
+....
   This case looks like this:
+
     MERGE_BASE:   E    oldfile, olddir/
     MERGE_SIDE1:  G    oldfile, olddir/ -> newdir/
     MERGE_SIDE2:  A    oldfile -> olddir/newfile
@@ -617,9 +648,11 @@ Case 2: MERGE_SIDE1 renames old dir, MERGE_SIDE2 renames  file into old dir
 
   Given the cached rename noted above, the second merge can proceed as
   expected without needing to perform rename detection from A -> A'.
+....
 
 Case 3: MERGE_SIDE1 adds new file to   old dir, MERGE_SIDE2 renames old dir
 
+....
   This case looks like this:
 
     MERGE_BASE:   E,   Has olddir/
@@ -635,9 +668,11 @@ Case 3: MERGE_SIDE1 adds new file to   old dir, MERGE_SIDE2 renames old dir
   In this case, with the optimization, note that after the first commit there
   were no renames on MERGE_SIDE1, and any renames on MERGE_SIDE2 are tossed.
   But the second merge didn't need any renames so this is fine.
+....
 
 Case 4: MERGE_SIDE1 renames  file into old dir, MERGE_SIDE2 renames old dir
 
+....
   This case looks like this:
 
     MERGE_BASE:   E,   Has olddir/
@@ -658,6 +693,7 @@ Case 4: MERGE_SIDE1 renames  file into old dir, MERGE_SIDE2 renames old dir
 
   Given the cached rename noted above, the second merge can proceed as
   expected without needing to perform rename detection from A -> A'.
+....
 
 Finally, I'll just note here that interactions with the
 skip-irrelevant-renames optimization means we sometimes don't detect
-- 
2.51.0

