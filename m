Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794D11CAF
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443212; cv=none; b=Wdqh4shm/xXsui3V6X6opX/tPxvSYsum2GaO+VEz3JtOmJpLukCDImxEKSkN4svaiXzWiCBcdwdjLKjcw2trSpkCBwhKJWpmfmv5qIxtKeVZ71Fj4SS7IRUBYrg548OvuNFka/ly0uQNxO6blKUuteyLsVEAANGgISqJJw7sjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443212; c=relaxed/simple;
	bh=U/oGwrQ9oTWNyPhp7cci3EoQ6SGuv6WMkixY9JyHVio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E14qevYagjxqayBIiNx6OXNtJrxOKgsUK0J2lvHJHisgn3QYCVVsrlmZUGdLEBVn6ZXKVVpiLx3duO+oY/Wa2/c8cwftKxbuq+1z0nu2e31ohMYiNGwGSHwm86SJUBTVI2/k59jG/3GLyg2yoA3RPzUxG439bgK19XHPsm5ssV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=cj5lZ8zZ; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="cj5lZ8zZ"
Received: from inspiron-LM22 ([80.189.83.109])
	by smtp with ESMTPA
	id 4RXivYtrc2D8r4RYFvkVyt; Thu, 02 Oct 2025 23:13:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759443207; bh=sxcWEUbWjGItJumJGqdSPpSJjiJrSl6m3XacdlVt8NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cj5lZ8zZpha8vj0DzdUjCydmPp8JppG8nl6AIiak5LpoNELNk6eUbUhHWLvhlOKOP
	 IR9rsC/YJ13fpUtj2BsFTSgq8iOr+wCR9gfTNIbg5XJhLQrbt85stAZRhWQIQfkBwf
	 Do2wONLc7jgNd0EcK3J7q05dHiC+6UE0XZawT1a0GMuruDL0w5qvngaYXdycJALz1h
	 jeq8JsEnLQ2WbehLouW6hkZpqbVUsSdOK6AwTF4Zv+mjmFHnYEnnAuTLAGHdkJnAA0
	 K+DVJHXexTaQ/duqSP7icAoaps7ESEB0Sfw07K3tVXx59HQU45teI3bvxaSg6gp23v
	 X2ph99ggUA2hA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=beTIU/PB c=1 sm=1 tr=0 ts=68def907
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=1XWaLZrsAAAA:8 a=EBOSESyhAAAA:8
 a=RFXedqbJGepY2AArjB4A:9 a=mZhGPu6oBKMHfi1b:21 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 3/4] doc: sparse-checkout.adoc: fix asciidoc warnings
Date: Thu,  2 Oct 2025 23:12:15 +0100
Message-ID: <20251002221233.541844-4-ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfBKOrNiOFL/rnRYzjIxqXv6lenUln6LoKRh4DauRrSZfOmPWrKfiINErx7hPJEyKsSqerIwVl6Z1DU2w5/WN0MoI6kwSotWyyuSFU+Ohhj/ASdE1MBZc
 KlTCxZZATa1P1NJXCLIwTaqgRjyq9bAWd1XEKVpd5xoV3AVM+sFRrAV4kpwOuJAd3yGM9ZL5xLNP/+NTHbOmxMiRz4fZY6GlOvc=

Both asciidoc and asciidoctor issue warnings about 'list item index:
expected n got n-1' for n=1->7 on lines 928, 931, 951, 974, 980, 1033
and 1049. In asciidoc, numbered lists must start at one, whereas this
file has a list starting at zero. Also, asciidoc and asciidoctor warn
about 'section title out of sequence: expected level 1, got level 2'
on line 17. (asciidoc only complains about the first instance of this,
while asciidoctor complains about them all, on lines 95, 258, 303, 316,
545, 612, 752, 824, 895, 923 and 1053). These warnings stem from the
section titles not being correctly nested within a document/chapter
title.

In order to address the first set of warnings, simply renumber the list
from one to severn, rather than zero to six. Fortunately, this does not
require altering additional text, since the enumeration of 'Known Bugs'
is not referred to anywhere else in the document.

In order to address the second set of warnings, change the section title
syntax from '=== title ===' to '== title ==', effectively reducing the
nesting level of the title by one. Also, some apparent (sub-)titles are
not marked up with sub-title syntax, so add some '=== ' prefix(s) to the
relevant headings.

In addition to the warnings, address some other formatting issues:

  - the use of heavily nested unordered lists is not reflected in the
    output (making the file totally unreadable) because each level of
    nesting requires a different syntax. (i.e. replace '*' with '**'
    for the second level, '*' with '***' for the third level, etc.)
  - make use of literal blocks and manual indentation to get asciidoc
    and asciidoctor to display even remotely similar output.
  - make use of labelled lists, in some places, to get a similar looking
    output to the input, for both asciidoc and asciidoctor.
  - replace the trailing space in: `git grep ${SEARCH_TERM} OLDREV `
    otherwise the entire line in which that appears is removed from
    the output.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/technical/sparse-checkout.adoc | 704 ++++++++++---------
 1 file changed, 376 insertions(+), 328 deletions(-)

diff --git a/Documentation/technical/sparse-checkout.adoc b/Documentation/technical/sparse-checkout.adoc
index 0f750ef3e3..3fa8e53655 100644
--- a/Documentation/technical/sparse-checkout.adoc
+++ b/Documentation/technical/sparse-checkout.adoc
@@ -14,37 +14,41 @@ Table of contents:
   * Reference Emails
 
 
-=== Terminology ===
+== Terminology ==
 
-cone mode: one of two modes for specifying the desired subset of files
+*`cone mode`*::
+	one of two modes for specifying the desired subset of files
 	in a sparse-checkout.  In cone-mode, the user specifies
 	directories (getting both everything under that directory as
 	well as everything in leading directories), while in non-cone
 	mode, the user specifies gitignore-style patterns.  Controlled
 	by the --[no-]cone option to sparse-checkout init|set.
 
-SKIP_WORKTREE: When tracked files do not match the sparse specification and
+*`SKIP_WORKTREE`*::
+	When tracked files do not match the sparse specification and
 	are removed from the working tree, the file in the index is marked
 	with a SKIP_WORKTREE bit.  Note that if a tracked file has the
 	SKIP_WORKTREE bit set but the file is later written by the user to
 	the working tree anyway, the SKIP_WORKTREE bit will be cleared at
 	the beginning of any subsequent Git operation.
-
-	Most sparse checkout users are unaware of this implementation
-	detail, and the term should generally be avoided in user-facing
-	descriptions and command flags.  Unfortunately, prior to the
-	`sparse-checkout` subcommand this low-level detail was exposed,
-	and as of time of writing, is still exposed in various places.
-
-sparse-checkout: a subcommand in git used to reduce the files present in
++
+Most sparse checkout users are unaware of this implementation
+detail, and the term should generally be avoided in user-facing
+descriptions and command flags.  Unfortunately, prior to the
+`sparse-checkout` subcommand this low-level detail was exposed,
+and as of time of writing, is still exposed in various places.
+
+*`sparse-checkout`*::
+	a subcommand in git used to reduce the files present in
 	the working tree to a subset of all tracked files.  Also, the
 	name of the file in the $GIT_DIR/info directory used to track
 	the sparsity patterns corresponding to the user's desired
 	subset.
 
-sparse cone: see cone mode
+*`sparse cone`*:: see cone mode
 
-sparse directory: An entry in the index corresponding to a directory, which
+*`sparse directory`*::
+	An entry in the index corresponding to a directory, which
 	appears in the index instead of all the files under that directory
 	that would normally appear.  See also sparse-index.  Something that
 	can cause confusion is that the "sparse directory" does NOT match
@@ -52,7 +56,8 @@ sparse directory: An entry in the index corresponding to a directory, which
 	working tree.  May be renamed in the future (e.g. to "skipped
 	directory").
 
-sparse index: A special mode for sparse-checkout that also makes the
+*`sparse index`*::
+	A special mode for sparse-checkout that also makes the
 	index sparse by recording a directory entry in lieu of all the
 	files underneath that directory (thus making that a "skipped
 	directory" which unfortunately has also been called a "sparse
@@ -60,7 +65,8 @@ sparse index: A special mode for sparse-checkout that also makes the
 	directories.  Controlled by the --[no-]sparse-index option to
 	init|set|reapply.
 
-sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
+*`sparsity patterns`*::
+	patterns from $GIT_DIR/info/sparse-checkout used to
 	define the set of files of interest.  A warning: It is easy to
 	over-use this term (or the shortened "patterns" term), for two
 	reasons: (1) users in cone mode specify directories rather than
@@ -70,7 +76,8 @@ sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
 	transiently differ in the working tree or index from the sparsity
 	patterns (see "Sparse specification vs. sparsity patterns").
 
-sparse specification: The set of paths in the user's area of focus.  This
+*`sparse specification`*::
+	The set of paths in the user's area of focus.  This
 	is typically just the tracked files that match the sparsity
 	patterns, but the sparse specification can temporarily differ and
 	include additional files.  (See also "Sparse specification
@@ -87,12 +94,13 @@ sparse specification: The set of paths in the user's area of focus.  This
 	* If working with the index and the working copy, the sparse
 	  specification is the union of the paths from above.
 
-vivifying: When a command restores a tracked file to the working tree (and
+*`vivifying`*::
+	When a command restores a tracked file to the working tree (and
 	hopefully also clears the SKIP_WORKTREE bit in the index for that
 	file), this is referred to as "vivifying" the file.
 
 
-=== Purpose of sparse-checkouts ===
+== Purpose of sparse-checkouts ==
 
 sparse-checkouts exist to allow users to work with a subset of their
 files.
@@ -120,14 +128,12 @@ those usecases, sparse-checkouts can modify different subcommands in over a
 half dozen different ways.  Let's start by considering the high level
 usecases:
 
-  A) Users are _only_ interested in the sparse portion of the repo
-
-  A*) Users are _only_ interested in the sparse portion of the repo
-      that they have downloaded so far
-
-  B) Users want a sparse working tree, but are working in a larger whole
-
-  C) sparse-checkout is a behind-the-scenes implementation detail allowing
+[horizontal]
+A):: Users are _only_ interested in the sparse portion of the repo
+A*):: Users are _only_ interested in the sparse portion of the repo
+     that they have downloaded so far
+B):: Users want a sparse working tree, but are working in a larger whole
+C):: sparse-checkout is a behind-the-scenes implementation detail allowing
      Git to work with a specially crafted in-house virtual file system;
      users are actually working with a "full" working tree that is
      lazily populated, and sparse-checkout helps with the lazy population
@@ -136,7 +142,7 @@ usecases:
 It may be worth explaining each of these in a bit more detail:
 
 
-  (Behavior A) Users are _only_ interested in the sparse portion of the repo
+=== (Behavior A) Users are _only_ interested in the sparse portion of the repo
 
 These folks might know there are other things in the repository, but
 don't care.  They are uninterested in other parts of the repository, and
@@ -163,8 +169,7 @@ side-effects of various other commands (such as the printed diffstat
 after a merge or pull) can lead to worries about local repository size
 growing unnecessarily[10].
 
-  (Behavior A*) Users are _only_ interested in the sparse portion of the repo
-      that they have downloaded so far (a variant on the first usecase)
+=== (Behavior A*) Users are _only_ interested in the sparse portion of the repo that they have downloaded so far (a variant on the first usecase)
 
 This variant is driven by folks who using partial clones together with
 sparse checkouts and do disconnected development (so far sounding like a
@@ -173,15 +178,14 @@ reason for yet another variant is that downloading even just the blobs
 through history within their sparse specification may be too much, so they
 only download some.  They would still like operations to succeed without
 network connectivity, though, so things like `git log -S${SEARCH_TERM} -p`
-or `git grep ${SEARCH_TERM} OLDREV ` would need to be prepared to provide
+or `git grep ${SEARCH_TERM} OLDREV` would need to be prepared to provide
 partial results that depend on what happens to have been downloaded.
 
 This variant could be viewed as Behavior A with the sparse specification
 for history querying operations modified from "sparsity patterns" to
 "sparsity patterns limited to the blobs we have already downloaded".
 
-  (Behavior B) Users want a sparse working tree, but are working in a
-      larger whole
+=== (Behavior B) Users want a sparse working tree, but are working in a larger whole
 
 Stolee described this usecase this way[11]:
 
@@ -229,8 +233,7 @@ those expensive checks when interacting with the working copy, and may
 prefer getting "unrelated" results from their history queries over having
 slow commands.
 
-  (Behavior C) sparse-checkout is an implementational detail supporting a
-	       special VFS.
+=== (Behavior C) sparse-checkout is an implementational detail supporting a special VFS.
 
 This usecase goes slightly against the traditional definition of
 sparse-checkout in that it actually tries to present a full or dense
@@ -255,13 +258,13 @@ will perceive the checkout as dense, and commands should thus behave as if
 all files are present.
 
 
-=== Usecases of primary concern ===
+== Usecases of primary concern ==
 
 Most of the rest of this document will focus on Behavior A and Behavior
 B.  Some notes about the other two cases and why we are not focusing on
 them:
 
-  (Behavior A*)
+=== (Behavior A*)
 
 Supporting this usecase is estimated to be difficult and a lot of work.
 There are no plans to implement it currently, but it may be a potential
@@ -275,7 +278,7 @@ valid for this usecase, with the only exception being that it redefines the
 sparse specification to restrict it to already-downloaded blobs.  The hard
 part is in making commands capable of respecting that modified definition.
 
-  (Behavior C)
+=== (Behavior C)
 
 This usecase violates some of the early sparse-checkout documented
 assumptions (since files marked as SKIP_WORKTREE will be displayed to users
@@ -300,20 +303,20 @@ Behavior C do not assume they are part of the Behavior B camp and propose
 patches that break things for the real Behavior B folks.
 
 
-=== Oversimplified mental models ===
+== Oversimplified mental models ==
 
 An oversimplification of the differences in the above behaviors is:
 
-  Behavior A: Restrict worktree and history operations to sparse specification
-  Behavior B: Restrict worktree operations to sparse specification; have any
-	      history operations work across all files
-  Behavior C: Do not restrict either worktree or history operations to the
-	      sparse specification...with the exception of branch checkouts or
-	      switches which avoid writing files that will match the index so
-	      they can later lazily be populated instead.
+(Behavior A):: Restrict worktree and history operations to sparse specification
+(Behavior B):: Restrict worktree operations to sparse specification; have any
+	     history operations work across all files
+(Behavior C):: Do not restrict either worktree or history operations to the
+	     sparse specification...with the exception of branch checkouts or
+	     switches which avoid writing files that will match the index so
+	     they can later lazily be populated instead.
 
 
-=== Desired behavior ===
+== Desired behavior ==
 
 As noted previously, despite the simple idea of just working with a subset
 of files, there are a range of different behavioral changes that need to be
@@ -326,37 +329,38 @@ understanding these differences can be beneficial.
 
 * Commands behaving the same regardless of high-level use-case
 
-  * commands that only look at files within the sparsity specification
+  ** commands that only look at files within the sparsity specification
 
-      * diff (without --cached or REVISION arguments)
-      * grep (without --cached or REVISION arguments)
-      * diff-files
+      *** diff (without --cached or REVISION arguments)
+      *** grep (without --cached or REVISION arguments)
+      *** diff-files
 
-  * commands that restore files to the working tree that match sparsity
+  ** commands that restore files to the working tree that match sparsity
     patterns, and remove unmodified files that don't match those
     patterns:
 
-      * switch
-      * checkout (the switch-like half)
-      * read-tree
-      * reset --hard
+      *** switch
+      *** checkout (the switch-like half)
+      *** read-tree
+      *** reset --hard
 
-  * commands that write conflicted files to the working tree, but otherwise
+  ** commands that write conflicted files to the working tree, but otherwise
     will omit writing files to the working tree that do not match the
     sparsity patterns:
 
-      * merge
-      * rebase
-      * cherry-pick
-      * revert
+      *** merge
+      *** rebase
+      *** cherry-pick
+      *** revert
 
-      * `am` and `apply --cached` should probably be in this section but
+      *** `am` and `apply --cached` should probably be in this section but
 	are buggy (see the "Known bugs" section below)
 
     The behavior for these commands somewhat depends upon the merge
     strategy being used:
-      * `ort` behaves as described above
-      * `octopus` and `resolve` will always vivify any file changed in the merge
+
+      *** `ort` behaves as described above
+      *** `octopus` and `resolve` will always vivify any file changed in the merge
 	relative to the first parent, which is rather suboptimal.
 
     It is also important to note that these commands WILL update the index
@@ -372,21 +376,21 @@ understanding these differences can be beneficial.
     specification and the sparsity patterns (much like the commands in the
     previous section).
 
-  * commands that always ignore sparsity since commits must be full-tree
+  ** commands that always ignore sparsity since commits must be full-tree
 
-      * archive
-      * bundle
-      * commit
-      * format-patch
-      * fast-export
-      * fast-import
-      * commit-tree
+      *** archive
+      *** bundle
+      *** commit
+      *** format-patch
+      *** fast-export
+      *** fast-import
+      *** commit-tree
 
-  * commands that write any modified file to the working tree (conflicted
+  ** commands that write any modified file to the working tree (conflicted
     or not, and whether those paths match sparsity patterns or not):
 
-      * stash
-      * apply (without `--index` or `--cached`)
+      *** stash
+      *** apply (without `--index` or `--cached`)
 
 * Commands that may slightly differ for behavior A vs. behavior B:
 
@@ -394,19 +398,20 @@ understanding these differences can be beneficial.
   behaviors, but may differ in verbosity and types of warning and error
   messages.
 
-  * commands that make modifications to which files are tracked:
-      * add
-      * rm
-      * mv
-      * update-index
+  ** commands that make modifications to which files are tracked:
+
+      *** add
+      *** rm
+      *** mv
+      *** update-index
 
     The fact that files can move between the 'tracked' and 'untracked'
     categories means some commands will have to treat untracked files
     differently.  But if we have to treat untracked files differently,
     then additional commands may also need changes:
 
-      * status
-      * clean
+      *** status
+      *** clean
 
     In particular, `status` may need to report any untracked files outside
     the sparsity specification as an erroneous condition (especially to
@@ -420,9 +425,10 @@ understanding these differences can be beneficial.
     may need to ignore the sparse specification by its nature.  Also, its
     current --[no-]ignore-skip-worktree-entries default is totally bogus.
 
-  * commands for manually tweaking paths in both the index and the working tree
-      * `restore`
-      * the restore-like half of `checkout`
+  ** commands for manually tweaking paths in both the index and the working tree
+
+      *** `restore`
+      *** the restore-like half of `checkout`
 
     These commands should be similar to add/rm/mv in that they should
     only operate on the sparse specification by default, and require a
@@ -433,18 +439,19 @@ understanding these differences can be beneficial.
 
 * Commands that significantly differ for behavior A vs. behavior B:
 
-  * commands that query history
-      * diff (with --cached or REVISION arguments)
-      * grep (with --cached or REVISION arguments)
-      * show (when given commit arguments)
-      * blame (only matters when one or more -C flags are passed)
-	* and annotate
-      * log
-      * whatchanged (may not exist anymore)
-      * ls-files
-      * diff-index
-      * diff-tree
-      * ls-tree
+  ** commands that query history
+
+      *** diff (with --cached or REVISION arguments)
+      *** grep (with --cached or REVISION arguments)
+      *** show (when given commit arguments)
+      *** blame (only matters when one or more -C flags are passed)
+	**** and annotate
+      *** log
+      *** whatchanged (may not exist anymore)
+      *** ls-files
+      *** diff-index
+      *** diff-tree
+      *** ls-tree
 
     Note: for log and whatchanged, revision walking logic is unaffected
     but displaying of patches is affected by scoping the command to the
@@ -458,91 +465,91 @@ understanding these differences can be beneficial.
 
 * Commands I don't know how to classify
 
-  * range-diff
+  ** range-diff
 
     Is this like `log` or `format-patch`?
 
-  * cherry
+  ** cherry
 
     See range-diff
 
 * Commands unaffected by sparse-checkouts
 
-  * shortlog
-  * show-branch
-  * rev-list
-  * bisect
-
-  * branch
-  * describe
-  * fetch
-  * gc
-  * init
-  * maintenance
-  * notes
-  * pull (merge & rebase have the necessary changes)
-  * push
-  * submodule
-  * tag
-
-  * config
-  * filter-branch (works in separate checkout without sparse-checkout setup)
-  * pack-refs
-  * prune
-  * remote
-  * repack
-  * replace
-
-  * bugreport
-  * count-objects
-  * fsck
-  * gitweb
-  * help
-  * instaweb
-  * merge-tree (doesn't touch worktree or index, and merges always compute full-tree)
-  * rerere
-  * verify-commit
-  * verify-tag
-
-  * commit-graph
-  * hash-object
-  * index-pack
-  * mktag
-  * mktree
-  * multi-pack-index
-  * pack-objects
-  * prune-packed
-  * symbolic-ref
-  * unpack-objects
-  * update-ref
-  * write-tree (operates on index, possibly optimized to use sparse dir entries)
-
-  * for-each-ref
-  * get-tar-commit-id
-  * ls-remote
-  * merge-base (merges are computed full tree, so merge base should be too)
-  * name-rev
-  * pack-redundant
-  * rev-parse
-  * show-index
-  * show-ref
-  * unpack-file
-  * var
-  * verify-pack
-
-  * <Everything under 'Interacting with Others' in 'git help --all'>
-  * <Everything under 'Low-level...Syncing' in 'git help --all'>
-  * <Everything under 'Low-level...Internal Helpers' in 'git help --all'>
-  * <Everything under 'External commands' in 'git help --all'>
+  ** shortlog
+  ** show-branch
+  ** rev-list
+  ** bisect
+
+  ** branch
+  ** describe
+  ** fetch
+  ** gc
+  ** init
+  ** maintenance
+  ** notes
+  ** pull (merge & rebase have the necessary changes)
+  ** push
+  ** submodule
+  ** tag
+
+  ** config
+  ** filter-branch (works in separate checkout without sparse-checkout setup)
+  ** pack-refs
+  ** prune
+  ** remote
+  ** repack
+  ** replace
+
+  ** bugreport
+  ** count-objects
+  ** fsck
+  ** gitweb
+  ** help
+  ** instaweb
+  ** merge-tree (doesn't touch worktree or index, and merges always compute full-tree)
+  ** rerere
+  ** verify-commit
+  ** verify-tag
+
+  ** commit-graph
+  ** hash-object
+  ** index-pack
+  ** mktag
+  ** mktree
+  ** multi-pack-index
+  ** pack-objects
+  ** prune-packed
+  ** symbolic-ref
+  ** unpack-objects
+  ** update-ref
+  ** write-tree (operates on index, possibly optimized to use sparse dir entries)
+
+  ** for-each-ref
+  ** get-tar-commit-id
+  ** ls-remote
+  ** merge-base (merges are computed full tree, so merge base should be too)
+  ** name-rev
+  ** pack-redundant
+  ** rev-parse
+  ** show-index
+  ** show-ref
+  ** unpack-file
+  ** var
+  ** verify-pack
+
+  ** <Everything under 'Interacting with Others' in 'git help --all'>
+  ** <Everything under 'Low-level...Syncing' in 'git help --all'>
+  ** <Everything under 'Low-level...Internal Helpers' in 'git help --all'>
+  ** <Everything under 'External commands' in 'git help --all'>
 
 * Commands that might be affected, but who cares?
 
-  * merge-file
-  * merge-index
-  * gitk?
+  ** merge-file
+  ** merge-index
+  ** gitk?
 
 
-=== Behavior classes ===
+== Behavior classes ==
 
 From the above there are a few classes of behavior:
 
@@ -573,18 +580,19 @@ From the above there are a few classes of behavior:
 
     Commands in this class generally behave like the "restrict" class,
     except that:
-      (1) they will ignore the sparse specification and write files with
-	  conflicts to the working tree (thus temporarily expanding the
-	  sparse specification to include such files.)
-      (2) they are grouped with commands which move to a new commit, since
-	  they often create a commit and then move to it, even though we
-	  know there are many exceptions to moving to the new commit.  (For
-	  example, the user may rebase a commit that becomes empty, or have
-	  a cherry-pick which conflicts, or a user could run `merge
-	  --no-commit`, and we also view `apply --index` kind of like `am
-	  --no-commit`.)  As such, these commands can make changes to index
-	  files outside the sparse specification, though they'll mark such
-	  files with SKIP_WORKTREE.
+
+	(1) they will ignore the sparse specification and write files with
+	    conflicts to the working tree (thus temporarily expanding the
+	    sparse specification to include such files.)
+	(2) they are grouped with commands which move to a new commit, since
+	    they often create a commit and then move to it, even though we
+	    know there are many exceptions to moving to the new commit.  (For
+	    example, the user may rebase a commit that becomes empty, or have
+	    a cherry-pick which conflicts, or a user could run `merge
+	    --no-commit`, and we also view `apply --index` kind of like `am
+	    --no-commit`.)  As such, these commands can make changes to index
+	    files outside the sparse specification, though they'll mark such
+	    files with SKIP_WORKTREE.
 
   * "restrict also specially applied to untracked files"
 
@@ -609,37 +617,39 @@ From the above there are a few classes of behavior:
     specification.
 
 
-=== Subcommand-dependent defaults ===
+== Subcommand-dependent defaults ==
 
 Note that we have different defaults depending on the command for the
 desired behavior :
 
   * Commands defaulting to "restrict":
-    * diff-files
-    * diff (without --cached or REVISION arguments)
-    * grep (without --cached or REVISION arguments)
-    * switch
-    * checkout (the switch-like half)
-    * reset (<commit>)
-
-    * restore
-    * checkout (the restore-like half)
-    * checkout-index
-    * reset (with pathspec)
+
+    ** diff-files
+    ** diff (without --cached or REVISION arguments)
+    ** grep (without --cached or REVISION arguments)
+    ** switch
+    ** checkout (the switch-like half)
+    ** reset (<commit>)
+
+    ** restore
+    ** checkout (the restore-like half)
+    ** checkout-index
+    ** reset (with pathspec)
 
     This behavior makes sense; these interact with the working tree.
 
   * Commands defaulting to "restrict modulo conflicts":
-    * merge
-    * rebase
-    * cherry-pick
-    * revert
 
-    * am
-    * apply --index (which is kind of like an `am --no-commit`)
+    ** merge
+    ** rebase
+    ** cherry-pick
+    ** revert
+
+    ** am
+    ** apply --index (which is kind of like an `am --no-commit`)
 
-    * read-tree (especially with -m or -u; is kind of like a --no-commit merge)
-    * reset (<tree-ish>, due to similarity to read-tree)
+    ** read-tree (especially with -m or -u; is kind of like a --no-commit merge)
+    ** reset (<tree-ish>, due to similarity to read-tree)
 
     These also interact with the working tree, but require slightly
     different behavior either so that (a) conflicts can be resolved or (b)
@@ -648,16 +658,17 @@ desired behavior :
     (See also the "Known bugs" section below regarding `am` and `apply`)
 
   * Commands defaulting to "no restrict":
-    * archive
-    * bundle
-    * commit
-    * format-patch
-    * fast-export
-    * fast-import
-    * commit-tree
 
-    * stash
-    * apply (without `--index`)
+    ** archive
+    ** bundle
+    ** commit
+    ** format-patch
+    ** fast-export
+    ** fast-import
+    ** commit-tree
+
+    ** stash
+    ** apply (without `--index`)
 
     These have completely different defaults and perhaps deserve the most
     detailed explanation:
@@ -679,53 +690,59 @@ desired behavior :
     sparse specification then we'll lose changes from the user.
 
   * Commands defaulting to "restrict also specially applied to untracked files":
-    * add
-    * rm
-    * mv
-    * update-index
-    * status
-    * clean (?)
-
-    Our original implementation for the first three of these commands was
-    "no restrict", but it had some severe usability issues:
-      * `git add <somefile>` if honored and outside the sparse
-	specification, can result in the file randomly disappearing later
-	when some subsequent command is run (since various commands
-	automatically clean up unmodified files outside the sparse
-	specification).
-      * `git rm '*.jpg'` could very negatively surprise users if it deletes
-	files outside the range of the user's interest.
-      * `git mv` has similar surprises when moving into or out of the cone,
-	so best to restrict by default
-
-    So, we switched `add` and `rm` to default to "restrict", which made
-    usability problems much less severe and less frequent, but we still got
-    complaints because commands like:
-	git add <file-outside-sparse-specification>
-	git rm <file-outside-sparse-specification>
-    would silently do nothing.  We should instead print an error in those
-    cases to get usability right.
-
-    update-index needs to be updated to match, and status and maybe clean
-    also need to be updated to specially handle untracked paths.
-
-    There may be a difference in here between behavior A and behavior B in
-    terms of verboseness of errors or additional warnings.
+
+    ** add
+    ** rm
+    ** mv
+    ** update-index
+    ** status
+    ** clean (?)
+
+....
+        Our original implementation for the first three of these commands was
+        "no restrict", but it had some severe usability issues:
+
+          * `git add <somefile>` if honored and outside the sparse
+	    specification, can result in the file randomly disappearing later
+	    when some subsequent command is run (since various commands
+	    automatically clean up unmodified files outside the sparse
+	    specification).
+          * `git rm '*.jpg'` could very negatively surprise users if it deletes
+	    files outside the range of the user's interest.
+          * `git mv` has similar surprises when moving into or out of the cone,
+	    so best to restrict by default
+
+        So, we switched `add` and `rm` to default to "restrict", which made
+        usability problems much less severe and less frequent, but we still got
+        complaints because commands like:
+
+	    git add <file-outside-sparse-specification>
+	    git rm <file-outside-sparse-specification>
+
+        would silently do nothing.  We should instead print an error in those
+        cases to get usability right.
+
+        update-index needs to be updated to match, and status and maybe clean
+        also need to be updated to specially handle untracked paths.
+
+        There may be a difference in here between behavior A and behavior B in
+        terms of verboseness of errors or additional warnings.
+....
 
   * Commands falling under "restrict or no restrict dependent upon behavior
     A vs. behavior B"
 
-    * diff (with --cached or REVISION arguments)
-    * grep (with --cached or REVISION arguments)
-    * show (when given commit arguments)
-    * blame (only matters when one or more -C flags passed)
-      * and annotate
-    * log
-      * and variants: shortlog, gitk, show-branch, whatchanged, rev-list
-    * ls-files
-    * diff-index
-    * diff-tree
-    * ls-tree
+    ** diff (with --cached or REVISION arguments)
+    ** grep (with --cached or REVISION arguments)
+    ** show (when given commit arguments)
+    ** blame (only matters when one or more -C flags passed)
+      *** and annotate
+    ** log
+      *** and variants: shortlog, gitk, show-branch, whatchanged, rev-list
+    ** ls-files
+    ** diff-index
+    ** diff-tree
+    ** ls-tree
 
     For now, we default to behavior B for these, which want a default of
     "no restrict".
@@ -749,7 +766,7 @@ desired behavior :
     implemented.
 
 
-=== Sparse specification vs. sparsity patterns ===
+== Sparse specification vs. sparsity patterns ==
 
 In a well-behaved situation, the sparse specification is given directly
 by the $GIT_DIR/info/sparse-checkout file.  However, it can transiently
@@ -821,45 +838,48 @@ under behavior B index operations are lumped with history and tend to
 operate full-tree.
 
 
-=== Implementation Questions ===
-
-  * Do the options --scope={sparse,all} sound good to others?  Are there better
-    options?
-    * Names in use, or appearing in patches, or previously suggested:
-      * --sparse/--dense
-      * --ignore-skip-worktree-bits
-      * --ignore-skip-worktree-entries
-      * --ignore-sparsity
-      * --[no-]restrict-to-sparse-paths
-      * --full-tree/--sparse-tree
-      * --[no-]restrict
-      * --scope={sparse,all}
-      * --focus/--unfocus
-      * --limit/--unlimited
-    * Rationale making me lean slightly towards --scope={sparse,all}:
-      * We want a name that works for many commands, so we need a name that
+== Implementation Questions ==
+
+  * Do the options --scope={sparse,all} sound good to others?  Are there better options?
+
+    ** Names in use, or appearing in patches, or previously suggested:
+
+      *** --sparse/--dense
+      *** --ignore-skip-worktree-bits
+      *** --ignore-skip-worktree-entries
+      *** --ignore-sparsity
+      *** --[no-]restrict-to-sparse-paths
+      *** --full-tree/--sparse-tree
+      *** --[no-]restrict
+      *** --scope={sparse,all}
+      *** --focus/--unfocus
+      *** --limit/--unlimited
+
+    ** Rationale making me lean slightly towards --scope={sparse,all}:
+
+      *** We want a name that works for many commands, so we need a name that
 	does not conflict
-      * We know that we have more than two possible usecases, so it is best
+      *** We know that we have more than two possible usecases, so it is best
 	to avoid a flag that appears to be binary.
-      * --scope={sparse,all} isn't overly long and seems relatively
+      *** --scope={sparse,all} isn't overly long and seems relatively
 	explanatory
-      * `--sparse`, as used in add/rm/mv, is totally backwards for
+      *** `--sparse`, as used in add/rm/mv, is totally backwards for
 	grep/log/etc.  Changing the meaning of `--sparse` for these
 	commands would fix the backwardness, but possibly break existing
 	scripts.  Using a new name pairing would allow us to treat
 	`--sparse` in these commands as a deprecated alias.
-      * There is a different `--sparse`/`--dense` pair for commands using
+      *** There is a different `--sparse`/`--dense` pair for commands using
 	revision machinery, so using that naming might cause confusion
-      * There is also a `--sparse` in both pack-objects and show-branch, which
+      *** There is also a `--sparse` in both pack-objects and show-branch, which
 	don't conflict but do suggest that `--sparse` is overloaded
-      * The name --ignore-skip-worktree-bits is a double negative, is
+      *** The name --ignore-skip-worktree-bits is a double negative, is
 	quite a mouthful, refers to an implementation detail that many
 	users may not be familiar with, and we'd need a negation for it
 	which would probably be even more ridiculously long.  (But we
 	can make --ignore-skip-worktree-bits a deprecated alias for
 	--no-restrict.)
 
-  * If a config option is added (sparse.scope?) what should the values and
+  ** If a config option is added (sparse.scope?) what should the values and
     description be?  "sparse" (behavior A), "worktree-sparse-history-dense"
     (behavior B), "dense" (behavior C)?  There's a risk of confusion,
     because even for Behaviors A and B we want some commands to be
@@ -868,19 +888,20 @@ operate full-tree.
     the primary difference we are focusing is just the history-querying
     commands (log/diff/grep).  Previous config suggestion here: [13]
 
-  * Is `--no-expand` a good alias for ls-files's `--sparse` option?
+  ** Is `--no-expand` a good alias for ls-files's `--sparse` option?
     (`--sparse` does not map to either `--scope=sparse` or `--scope=all`,
     because in non-cone mode it does nothing and in cone-mode it shows the
     sparse directory entries which are technically outside the sparse
     specification)
 
-  * Under Behavior A:
-    * Does ls-files' `--no-expand` override the default `--scope=all`, or
+  ** Under Behavior A:
+
+    *** Does ls-files' `--no-expand` override the default `--scope=all`, or
       does it need an extra flag?
-    * Does ls-files' `-t` option imply `--scope=all`?
-    * Does update-index's `--[no-]skip-worktree` option imply `--scope=all`?
+    *** Does ls-files' `-t` option imply `--scope=all`?
+    *** Does update-index's `--[no-]skip-worktree` option imply `--scope=all`?
 
-  * sparse-checkout: once behavior A is fully implemented, should we take
+  ** sparse-checkout: once behavior A is fully implemented, should we take
     an interim measure to ease people into switching the default?  Namely,
     if folks are not already in a sparse checkout, then require
     `sparse-checkout init/set` to take a
@@ -892,7 +913,7 @@ operate full-tree.
     is seamless for them.
 
 
-=== Implementation Goals/Plans ===
+== Implementation Goals/Plans ==
 
  * Get buy-in on this document in general.
 
@@ -910,25 +931,26 @@ operate full-tree.
    request that they not trigger this bug." flag
 
  * Flags & Config
-   * Make `--sparse` in add/rm/mv a deprecated alias for `--scope=all`
-   * Make `--ignore-skip-worktree-bits` in checkout-index/checkout/restore
+
+   ** Make `--sparse` in add/rm/mv a deprecated alias for `--scope=all`
+   ** Make `--ignore-skip-worktree-bits` in checkout-index/checkout/restore
      a deprecated aliases for `--scope=all`
-   * Create config option (sparse.scope?), tie it to the "Cliff notes"
+   ** Create config option (sparse.scope?), tie it to the "Cliff notes"
      overview
 
-   * Add --scope=sparse (and --scope=all) flag to each of the history querying
+   ** Add --scope=sparse (and --scope=all) flag to each of the history querying
      commands.  IMPORTANT: make sure diff machinery changes don't mess with
      format-patch, fast-export, etc.
 
-=== Known bugs ===
+== Known bugs ==
 
 This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but we've
 been working on it.
 
-0. Behavior A is not well supported in Git.  (Behavior B didn't used to
+1. Behavior A is not well supported in Git.  (Behavior B didn't used to
    be either, but was the easier of the two to implement.)
 
-1. am and apply:
+2. am and apply:
 
    apply, without `--index` or `--cached`, relies on files being present
    in the working copy, and also writes to them unconditionally.  As
@@ -948,7 +970,7 @@ been working on it.
    files and then complain that those vivified files would be
    overwritten by merge.
 
-2. reset --hard:
+3. reset --hard:
 
    reset --hard provides confusing error message (works correctly, but
    misleads the user into believing it didn't):
@@ -971,13 +993,13 @@ been working on it.
     `git reset --hard` DID remove addme from the index and the working tree, contrary
     to the error message, but in line with how reset --hard should behave.
 
-3. read-tree
+4. read-tree
 
    `read-tree` doesn't apply the 'SKIP_WORKTREE' bit to *any* of the
    entries it reads into the index, resulting in all your files suddenly
    appearing to be "deleted".
 
-4. Checkout, restore:
+5. Checkout, restore:
 
    These command do not handle path & revision arguments appropriately:
 
@@ -1030,7 +1052,7 @@ been working on it.
     S tracked
     H tracked-but-maybe-skipped
 
-5. checkout and restore --staged, continued:
+6. checkout and restore --staged, continued:
 
    These commands do not correctly scope operations to the sparse
    specification, and make it worse by not setting important SKIP_WORKTREE
@@ -1046,56 +1068,82 @@ been working on it.
    the sparse specification, but then it will be important to set the
    SKIP_WORKTREE bits appropriately.
 
-6. Performance issues; see:
-    https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
+7. Performance issues; see:
+
+   https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
 
 
-=== Reference Emails ===
+== Reference Emails ==
 
 Emails that detail various bugs we've had in sparse-checkout:
 
-[1] (Original descriptions of behavior A & behavior B)
-    https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
-[2] (Fix stash applications in sparse checkouts; bugs from behavioral differences)
-    https://lore.kernel.org/git/ccfedc7140dbf63ba26a15f93bd3885180b26517.1606861519.git.gitgitgadget@gmail.com/
-[3] (Present-despite-skipped entries)
-    https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/
-[4] (Clone --no-checkout interaction)
-    https://lore.kernel.org/git/pull.801.v2.git.git.1591324899170.gitgitgadget@gmail.com/ (clone --no-checkout)
-[5] (The need for update_sparsity() and avoiding `read-tree -mu HEAD`)
-    https://lore.kernel.org/git/3a1f084641eb47515b5a41ed4409a36128913309.1585270142.git.gitgitgadget@gmail.com/
-[6] (SKIP_WORKTREE is advisory, not mandatory)
-    https://lore.kernel.org/git/844306c3e86ef67591cc086decb2b760e7d710a3.1585270142.git.gitgitgadget@gmail.com/
-[7] (`worktree add` should copy sparsity settings from current worktree)
-    https://lore.kernel.org/git/c51cb3714e7b1d2f8c9370fe87eca9984ff4859f.1644269584.git.gitgitgadget@gmail.com/
-[8] (Avoid negative surprises in add, rm, and mv)
-    https://lore.kernel.org/git/cover.1617914011.git.matheus.bernardino@usp.br/
-    https://lore.kernel.org/git/pull.1018.v4.git.1632497954.gitgitgadget@gmail.com/
-[9] (Move from out-of-cone to in-cone)
-    https://lore.kernel.org/git/20220630023737.473690-6-shaoxuan.yuan02@gmail.com/
-    https://lore.kernel.org/git/20220630023737.473690-4-shaoxuan.yuan02@gmail.com/
-[10] (Unnecessarily downloading objects outside sparse specification)
-     https://lore.kernel.org/git/CAOLTT8QfwOi9yx_qZZgyGa8iL8kHWutEED7ok_jxwTcYT_hf9Q@mail.gmail.com/
-
-[11] (Stolee's comments on high-level usecases)
-     https://lore.kernel.org/git/1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com/
+[1] (Original descriptions of behavior A & behavior B):
+
+https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
+
+[2] (Fix stash applications in sparse checkouts; bugs from behavioral differences):
+
+https://lore.kernel.org/git/ccfedc7140dbf63ba26a15f93bd3885180b26517.1606861519.git.gitgitgadget@gmail.com/
+
+[3] (Present-despite-skipped entries):
+
+https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/
+
+[4] (Clone --no-checkout interaction):
+
+https://lore.kernel.org/git/pull.801.v2.git.git.1591324899170.gitgitgadget@gmail.com/ (clone --no-checkout)
+
+[5] (The need for update_sparsity() and avoiding `read-tree -mu HEAD`):
+
+https://lore.kernel.org/git/3a1f084641eb47515b5a41ed4409a36128913309.1585270142.git.gitgitgadget@gmail.com/
+
+[6] (SKIP_WORKTREE is advisory, not mandatory):
+
+https://lore.kernel.org/git/844306c3e86ef67591cc086decb2b760e7d710a3.1585270142.git.gitgitgadget@gmail.com/
+
+[7] (`worktree add` should copy sparsity settings from current worktree):
+
+https://lore.kernel.org/git/c51cb3714e7b1d2f8c9370fe87eca9984ff4859f.1644269584.git.gitgitgadget@gmail.com/
+
+[8] (Avoid negative surprises in add, rm, and mv):
+
+  * https://lore.kernel.org/git/cover.1617914011.git.matheus.bernardino@usp.br/
+  * https://lore.kernel.org/git/pull.1018.v4.git.1632497954.gitgitgadget@gmail.com/
+
+[9] (Move from out-of-cone to in-cone):
+
+  * https://lore.kernel.org/git/20220630023737.473690-6-shaoxuan.yuan02@gmail.com/
+  * https://lore.kernel.org/git/20220630023737.473690-4-shaoxuan.yuan02@gmail.com/
+
+[10] (Unnecessarily downloading objects outside sparse specification):
+
+https://lore.kernel.org/git/CAOLTT8QfwOi9yx_qZZgyGa8iL8kHWutEED7ok_jxwTcYT_hf9Q@mail.gmail.com/
+
+[11] (Stolee's comments on high-level usecases):
+
+https://lore.kernel.org/git/1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com/
 
 [12] Others commenting on eventually switching default to behavior A:
+
   * https://lore.kernel.org/git/xmqqh719pcoo.fsf@gitster.g/
   * https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/
   * https://lore.kernel.org/git/a86af661-cf58-a4e5-0214-a67d3a794d7e@github.com/
 
-[13] Previous config name suggestion and description
-  * https://lore.kernel.org/git/CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com/
+[13] Previous config name suggestion and description:
+
+   https://lore.kernel.org/git/CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com/
 
 [14] Tangential issue: switch to cone mode as default sparse specification mechanism:
-  https://lore.kernel.org/git/a1b68fd6126eb341ef3637bb93fedad4309b36d0.1650594746.git.gitgitgadget@gmail.com/
+
+https://lore.kernel.org/git/a1b68fd6126eb341ef3637bb93fedad4309b36d0.1650594746.git.gitgitgadget@gmail.com/
 
 [15] Lengthy email on grep behavior, covering what should be searched:
-  * https://lore.kernel.org/git/CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com/
+
+https://lore.kernel.org/git/CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com/
 
 [16] Email explaining sparsity patterns vs. SKIP_WORKTREE and history operations,
      search for the parenthetical comment starting "We do not check".
-    https://lore.kernel.org/git/CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com/
+
+https://lore.kernel.org/git/CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com/
 
 [17] https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/
-- 
2.51.0

