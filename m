Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A6485CEC
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806889; cv=none; b=poNnJv6wcqHojnu30wYgc8QYtGWaIJK/pzaGzBkNWN6xcNTcafzQbsm+c5x7ETkSaWRBnziNvL1wJZdN1zF9JFkcsUwIedeuyyiCR5LXCczMhGSOr+AecC+xFwJRCaVrHrgbfvLqlGmehuapZlQ2PwBf9DiubKy9AtkJNQPZDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806889; c=relaxed/simple;
	bh=CdlRvpe7t1BPHXrU508X68YKXasdKWF5ZU04igLmA9A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j0jb8O0lP7c587NivTAbgPBxCQuQKk6XrdJ3vI+EsuViIYawlD04GY8SMo/vzcDkWTAGZs39ZUXE+UPZUEQKxPuq5yLBtbZ29ew/IxHvaaZJcxih9y0FTflf4nh/dvEwTXisMA3n7q8RItBBGBfx87GLK4V7tdvwzJNGNDG4nHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ4AAOVH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ4AAOVH"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917b78dfe30so33581796d6.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806885; x=1792411685; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xJvtOU/zyiro0wXxBqm715XEgAAsUITCZFYLL4zA5XQ=;
        b=mQ4AAOVHJcZtw48XZWXYZeVg+zOiXbcntjSM0dWhPxXGkOOBdBRMDrDyKrDRxR+yxX
         0oYvA+mvU1WsMVxC0GWOf44j6DnPlkbsaikR/NCB18p2WS9YFPf07U+mQAuBJaCtuMXF
         av85eIZ+wB6d5K3wlzGfTOVmJ2yy/w28gL34Z2l/H+ChMer/XbANDFnTU1IwAvhqGoiW
         tCarusNqANuqlU7HKk1DLfXvuydP38tky9UOgTN3lrHv3jRonpQip6xUj0byb7Bc6HQk
         WU65k3DY3zk+MKUyiqaEl702R2Ag/X5iOvlxpF0UNWZOjMa+fB0GF2yZ2+4mF79crtMi
         ffeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806885; x=1792411685;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJvtOU/zyiro0wXxBqm715XEgAAsUITCZFYLL4zA5XQ=;
        b=RZ3/3T3GcaovgouTY3rK1NVAquxIzh35/vlWLbmkTiZMDT6VNV2SU+MIZrOvsOxy32
         iv8PPOVIyXDfAVwjY9Qf0QHWjfGvOlwsLoyJzA1c12039KwAFij3q08U8j6wymNs5RAp
         YO3qytKoASoOKdX82OD+IF5Y8FidoQ9Bacf8IccTD+joh+CMljGRzeKraoo8fwOWhcT2
         pnx2muqDuVR05Kzn98UwbZKbjN/Xp+BeJAY90BSgC4Oh3wkVIBJjrgO6CkkRO+xkMmgS
         FXF0qpp6IVbZFNnFXAiKce3U765lZBRQiBS4R7yCwnZc6Il8RkHEVYAjfMRf/MWInrrj
         ecBg==
X-Gm-Message-State: AFq9FYIXY6eq4yj8iMZrMU8iueFiR4m+irkIaRZr/6C+bsgCQQD868PF
	3jlbi3jEGgZJXL/5n/RCc77pa80yrQCbsZEgZQq9AAnmhU3fRASHONaGklJUnFI/
X-Gm-Gg: AYBFou0LfoRA0YzkbkSyLkDb7Eq4OXiXN55Dus3KSvW3zb5oZVTFLk8zKsFP4ZEESj2
	JHawuhMavssaiZQcMFb1I8re0cLeAazC0CgAdO9z8k/90Bev86WM0ayEEfUDILGI0zMJZizKgrd
	jzMwEJtGfokhhCQl6tgfS77FThJV9W49Yc594Lnyy5B0XetqLWwwWkPxZV+EX6gn2aKu308CoPt
	ZPS4YS3Cp6RQ38y6OQoV2xaFT6PA1CHjAvkNcX2T2VDLVQ6+nmrAFc8JHcpHOXIxKFrwN0zWNbZ
	d6/ubEkyb1OtyOVAyuxj7B4muZ+xRRJWCoqicD5JDE12jgzUPY2i9RkkOjIKK85ipfNtPCvioJ3
	/Lug9fbHJVT5EaV68njC64RF+vFp9mQnYkbwOAtPy+R3U9phGlYvGLcPEd84MwqyoNlf8YteYBQ
	yMAqqQw+S4Dr2MQxsGLNSvYzfb10ZM3HLG/au1G9SNXWeYTopCr9E4rPpmXigk+osXF4wownDvS
	g==
X-Received: by 2002:a05:620a:4507:b0:93e:c12c:fbbb with SMTP id af79cd13be357-93ec12d05d1mr1463949785a.72.1791806884182;
        Mon, 12 Oct 2026 05:08:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.13.57])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98fe4a2sm854287585a.42.2026.10.12.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:08:03 -0700 (PDT)
Message-Id: <efaada0b6a8ffdb4d1c01d7f34a0d6596a99c149.1791806877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 12:07:57 +0000
Subject: [PATCH v3 4/4] connected: add incremental connectivity check via
 rev-list
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The full connectivity check uses rev-list to find commits
reachable from the incoming tips but not from the
already-connected side, then walks their object closure.  Commit
traversal stops at the connectivity boundary, but trees and blobs
reachable from that boundary still need to be walked so they can
be marked uninteresting, allocating a struct object for each one.
On repositories where the boundary commits have large trees, the
connectivity check for small incoming changes visits and tracks
more objects than needed.

Add an alternative connectivity check that verifies incoming
commits incrementally against their parents.

The verifier processes incoming commits with ancestors first and
compares each new tree against its trusted parent trees.  Entries
already seen on the trusted side are skipped by OID, so unchanged
subtrees need not remain at the same path to be recognized.
Changed subtrees are recursively compared against same-path parent
subtrees, and new subtrees without a comparison base are verified
from scratch.

See Documentation/technical/connectivity-check.adoc for the trust
invariants and detailed algorithm.

The incremental check runs as an internal
--verify-trees-incremental mode in rev-list.  After the normal
revision walk identifies the incoming commits, the verifier
consumes them before the usual object traversal; any pending
non-commit tips are still handled by the existing traversal.

Partial-clone semantics are preserved: objects promised by a
promisor remote are accepted as connected, and on-demand fetching
is prevented by excluding promisor objects from traversal.  The
new mode is selected by transfer.connectivityCheck=incremental,
with full remaining the default.  Deepening fetches fall back to
the full check because they do not have the normal
existing-reference boundary, and traversal instead follows the
effective shallow boundary.

p5413 results (median of 3), scaling one dimension at a time.
Each fixture is a repository with a flat tree of many
directories containing 100 files each.  The incoming set is a
chain of commits on top of the existing history, with each
commit changing files in different directories round-robin.
The three axes vary the total repository tree size, the number
of incoming commits, and the number of files changed per
incoming commit.

Scaling tree size (10 incoming commits, 10 files/commit):

    files    full  incr.  full/incr
      5K    0.01s  0.01s    1.0x
     50K    0.04s  0.01s    4.0x
    200K    0.15s  0.01s   15.0x
    800K    0.61s  0.03s   20.3x

The full mode must walk the trees of boundary commits, which
grows with overall tree size.  Incremental still scans the
root trees, but avoids descending into unchanged subtrees,
so it grows much more slowly with repository size.

Scaling incoming commit count (200K files, 10 files/commit):

    commits    full  incr.  full/incr
          1    0.14s  0.01s   14.0x
         10    0.15s  0.01s   15.0x
        100    0.19s  0.05s    3.8x
        500    0.32s  0.27s    1.2x
       3000    1.23s  1.52s    0.8x
       5000    1.88s  2.43s    0.8x
      10000    3.72s  5.36s    0.7x

With many commits the per-commit overhead of scanning both
the new and parent root trees accumulates and incremental
becomes slower.  Breakeven is between 500 and 3000 commits
and the ratio stabilizes near 0.7x for this fixture.

Scaling files per incoming commit (200K files, 10 commits):

    files/commit    full  incr.  full/incr
               1    0.14s  0.01s   14.0x
              10    0.15s  0.01s   15.0x
             100    0.16s  0.04s    4.0x
             500    0.23s  0.14s    1.6x
            1000    0.34s  0.28s    1.2x
            2000    0.70s  0.63s    1.1x

Breakeven is around 1000 files/commit.  At 2000 files/commit
(every directory touched), incremental remains slightly faster;
bypassing the object cache for tree reads likely helps here.

For small repositories both modes are fast enough that the
difference is difficult to measure reliably.

Selected peak RSS measurements from the same fixtures:

    case                        full    incr.  ratio
    200K files, 10 commits      31 MB    12 MB   0.4x
    800K files, 10 commits     110 MB    26 MB   0.2x
    200K files, 5000 commits   155 MB   151 MB   1.0x

Incremental uses substantially less memory when it can prune
most of the boundary tree walk.  In the long-history case the
two modes visit similar object sets and memory converges.

The regression cases in the CPU benchmarks are in wall-clock
time rather than memory, primarily from scanning some trees
more than once.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/connectivity-check.adoc         | 145 ++++
 Makefile                                      |   1 +
 builtin/rev-list.c                            |  15 +
 meson.build                                   |   1 +
 t/meson.build                                 |   1 +
 t/perf/p5413-connectivity-check.sh            |  15 +-
 t/t5413-connectivity-check.sh                 | 680 ++++++++++++++++++
 tree-verify.c                                 | 316 ++++++++
 tree-verify.h                                 |  15 +
 9 files changed, 1185 insertions(+), 4 deletions(-)
 create mode 100755 t/t5413-connectivity-check.sh
 create mode 100644 tree-verify.c
 create mode 100644 tree-verify.h

diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
index abef02debd..a1d2e9709c 100644
--- a/Documentation/technical/connectivity-check.adoc
+++ b/Documentation/technical/connectivity-check.adoc
@@ -108,3 +108,148 @@ tag, tree, or blob, that object is not part of the commit walk.
 These non-commit tips are verified during the tree and blob
 traversal that follows the commit walk within the same rev-list
 invocation.
+
+Incremental connectivity check
+------------------------------
+
+The incremental mode, selected by
+`transfer.connectivityCheck=incremental`, avoids traversing the
+full tree walk of the boundary commits.  Instead, it verifies
+each incoming commit's tree against the already-trusted trees of
+its parent commits.
+
+The same `--not --all` boundary as the full check identifies the
+incoming commits.  The incremental mode reuses this boundary but
+replaces what happens afterwards: rather than walking boundary
+trees to mark objects uninteresting, it compares each incoming
+commit's tree against its parents' trees, processing commits in
+topological order (ancestors first).
+
+Trust model
+~~~~~~~~~~~
+
+A tree is trusted when its transitive object closure is known to
+be connected.
+
+Every parent of an incoming commit is either on the
+already-connected side of the `--not --all` boundary (a boundary
+parent whose tree is trusted by definition) or is an earlier
+incoming commit that was already verified due to the topological
+processing order.  In both cases the parent's tree is trusted, so
+all parent trees can be unconditionally used as comparison bases.
+
+Once an incoming commit's tree has been verified, it is trusted
+and can serve as a comparison base for later descendants.  This
+gives an inductive correctness argument: the base case is the
+trust boundary established by `--not --all`, and the inductive
+step is that verifying a commit extends the trusted set.
+
+Tree states
+~~~~~~~~~~~
+
+The verifier tracks tree OIDs in three states:
+
+untrusted::
+	The tree has not yet been established as connected.  This
+	is the implicit state of an OID not present in the state
+	map.
+
+trusted::
+	The tree is known to have a connected transitive closure,
+	but its direct entries have not yet been published into the
+	verifier's trusted object sets.
+
+expanded::
+	The tree is trusted and its direct non-gitlink entries
+	have also been published into the trusted object sets.
+
+State transitions are monotonic: a tree may move from untrusted
+to trusted to expanded, but never backwards.  An untrusted tree
+that is successfully verified goes directly to expanded.
+
+Blobs require only trusted/untrusted state: a blob becomes
+trusted when it is found in a trusted tree or when its existence
+and type have been verified directly.
+
+The trusted/expanded distinction is an optimization.  An expanded
+parent does not need to be reread merely to publish entries that
+are already trusted, though it may still be read when same-path
+subtree bases are needed for recursive comparison.
+
+Algorithm
+~~~~~~~~~
+
+At a high level:
+
+    verify(commits):
+        sort topologically (ancestors first)
+        for each commit:
+            mark parent root trees as trusted
+            verify_tree(commit.tree, parent root trees)
+
+    verify_tree(tree, base_trees):
+        if tree already trusted: return
+        read tree, collect entries not already trusted
+        for each available base tree:
+            publish its entries as trusted
+            record same-path subtrees as bases
+        for each collected entry:
+            if now trusted: skip
+            if blob: verify blob connectivity and type
+            if tree: verify_tree(entry, its recorded bases)
+        mark tree as expanded
+
+The important ordering within `verify_tree` is that entries from
+the new tree are collected before the base trees are scanned, but
+are processed only afterwards.  Trust learned from any base can
+therefore eliminate work before recursive verification begins.
+
+Same-path parent subtrees are passed down as comparison bases
+during recursive descent.  If no comparison base is available,
+the new subtree is verified from scratch.
+
+Example
+~~~~~~~
+
+Consider a commit that changes one file under `lib/` and moves an
+unchanged subtree from `src/` to `dev/`:
+
+    Parent tree              New tree
+    +-- src/   (aaa)         +-- dev/   (aaa)
+    +-- lib/   (bbb)         +-- lib/   (ccc)
+         +-- foo.c (ddd)          +-- foo.c (ddd)
+         +-- bar.c (eee)          +-- bar.c (fff)
+
+Scanning the parent makes `aaa` trusted even though it moved from
+`src/` to `dev/`, so that subtree is skipped.  The changed `ccc`
+subtree is compared against its same-path parent `bbb`; scanning
+`bbb` makes `ddd` and `eee` trusted, leaving only the new `fff`
+blob to be checked.
+
+This illustrates two properties:
+
+* Trust is OID-based rather than path-based.  An unchanged subtree
+  is recognized after a move.
+
+* Same-path parent subtrees provide recursive comparison bases.
+  These bases improve pruning efficiency but are not required for
+  correctness; a new subtree can always be verified from scratch.
+
+Multiple parents
+~~~~~~~~~~~~~~~~
+
+For a merge commit, root trees from all parents are comparison
+bases.  When several parents contain a same-path subtree, each
+matching subtree is collected as a recursive comparison base.
+
+Entries published from any trusted parent become globally trusted,
+so a matching tree or blob entry present in any parent can be
+skipped while verifying the merge tree.
+
+Missing comparison bases
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+A promised base tree may not be locally available for comparison.
+In that case the verifier skips that base and verifies the new
+subtree without it.  The missing comparison can reduce pruning but
+does not affect correctness.
diff --git a/Makefile b/Makefile
index a96be506b5..fa42e295e2 100644
--- a/Makefile
+++ b/Makefile
@@ -1339,6 +1339,7 @@ LIB_OBJS += trailer.o
 LIB_OBJS += transport-helper.o
 LIB_OBJS += transport.o
 LIB_OBJS += tree-diff.o
+LIB_OBJS += tree-verify.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += tree.o
 LIB_OBJS += unpack-trees.o
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 9a76bb9c9c..ae5012ec25 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -28,6 +28,7 @@
 #include "commit-reach.h"
 #include "quote.h"
 #include "strbuf.h"
+#include "tree-verify.h"
 
 struct rev_list_info {
 	struct rev_info *revs;
@@ -727,6 +728,7 @@ int cmd_rev_list(int argc,
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
 	int filter_provided_objects = 0;
+	int verify_trees_incremental = 0;
 	const char *show_progress = NULL;
 	int ret = 0;
 
@@ -770,6 +772,7 @@ int cmd_rev_list(int argc,
 			repo->fetch_if_missing = 0;
 			revs.exclude_promisor_objects = 1;
 		} else if (!strcmp(arg, "--verify-trees-incremental")) {
+			verify_trees_incremental = 1;
 			repo->fetch_if_missing = 0;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(repo, arg);
@@ -973,6 +976,18 @@ int cmd_rev_list(int argc,
 
 	prepare_maximal_independent(&revs);
 
+	if (verify_trees_incremental) {
+		struct commit *commit;
+		struct commit_list *new_commits = NULL;
+
+		while ((commit = get_revision(&revs)) != NULL)
+			commit_list_insert(commit, &new_commits);
+
+		verify_commits_incremental(repo, &new_commits,
+					   revs.exclude_promisor_objects);
+		commit_list_free(new_commits);
+	}
+
 	if (revs.tree_objects)
 		mark_edges_uninteresting(&revs, show_edge, 0);
 
diff --git a/meson.build b/meson.build
index 0a95d90d21..d94dedc26c 100644
--- a/meson.build
+++ b/meson.build
@@ -562,6 +562,7 @@ libgit_sources = [
   'transport-helper.c',
   'transport.c',
   'tree-diff.c',
+  'tree-verify.c',
   'tree-walk.c',
   'tree.c',
   'unpack-trees.c',
diff --git a/t/meson.build b/t/meson.build
index f65eb04684..b23b4c90b0 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -654,6 +654,7 @@ integration_tests = [
   't5410-receive-pack.sh',
   't5411-proc-receive-hook.sh',
   't5412-receive-report-hook.sh',
+  't5413-connectivity-check.sh',
   't5500-fetch-pack.sh',
   't5501-fetch-push-alternates.sh',
   't5502-quickfetch.sh',
diff --git a/t/perf/p5413-connectivity-check.sh b/t/perf/p5413-connectivity-check.sh
index 3fabc82a87..ed195089ef 100755
--- a/t/perf/p5413-connectivity-check.sh
+++ b/t/perf/p5413-connectivity-check.sh
@@ -1,9 +1,9 @@
 #!/bin/sh
 
-test_description='performance of connectivity check
+test_description='performance of connectivity check modes
 
-Benchmark the rev-list connectivity check, avoiding pack transfer
-noise.
+Compare the default and incremental rev-list connectivity modes
+directly, avoiding pack transfer noise.
 
 Each repository has a flat tree of many directories with 100 files
 in each.  Three axes are scaled independently: tree size, commit
@@ -51,12 +51,19 @@ test_perf_conn () {
 		fi
 	'
 
-	test_perf "$label" '
+	test_perf "$label (full)" '
 		cat '"${name}"'_new |
 		git -C '"$name"' rev-list \
 			--objects --stdin --not --all --quiet \
 			--exclude-promisor-objects
 	'
+
+	test_perf "$label (incremental)" '
+		cat '"${name}"'_new |
+		git -C '"$name"' rev-list --verify-trees-incremental \
+			--objects --stdin --not --all --quiet \
+			--exclude-promisor-objects
+	'
 }
 
 # Scaling tree size (10 commits, 10 files/commit).
diff --git a/t/t5413-connectivity-check.sh b/t/t5413-connectivity-check.sh
new file mode 100755
index 0000000000..1c84cfe452
--- /dev/null
+++ b/t/t5413-connectivity-check.sh
@@ -0,0 +1,680 @@
+#!/bin/sh
+
+test_description='connectivity check (transfer.connectivityCheck)'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_oid_cache <<-\EOF
+missing sha1:0000000000000000000000000000000000000001
+missing sha256:0000000000000000000000000000000000000000000000000000000000000001
+EOF
+
+set_connectivity_check () {
+	git -C "$1" config transfer.connectivityCheck "$2"
+}
+
+# Run a connectivity check via rev-list directly.  Uses $mode
+# (set by the enclosing for-loop) to choose full or incremental.
+check_connected () {
+	flags= &&
+	if test "$mode" = incremental
+	then
+		flags=--verify-trees-incremental
+	fi &&
+	printf '%s\n' "$@" |
+	git rev-list $flags \
+		--objects --stdin --not --all --quiet \
+		--exclude-promisor-objects
+}
+
+# Run git with a temporary index, leaving the real index untouched.
+tmpgit () {
+	GIT_INDEX_FILE=.git/tmp-idx git "$@"
+}
+
+# Create a commit with one file changed, without modifying HEAD,
+# index, or worktree.  Prints the new commit OID on stdout.
+# Usage: commit_with_change <parent> <path> <content>
+commit_with_change () {
+	new_blob=$(echo "$3" | git hash-object -w --stdin) &&
+	tmpgit read-tree "$1" &&
+	tmpgit update-index --replace \
+		--cacheinfo "100644,$new_blob,$2" &&
+	new_tree=$(tmpgit write-tree) &&
+	rm -f .git/tmp-idx &&
+	git commit-tree "$new_tree" -p "$1" -m "modify $2"
+}
+
+# Check OIDs and optionally verify trace2 counts.
+# Usage: check_connected_trace <trace-file> <trees> <blobs> <oid>...
+# An empty string for <trees> or <blobs> skips that assertion.
+check_connected_trace () {
+	trace_file=$1 trees=$2 blobs=$3 &&
+	shift 3 &&
+	test_env GIT_TRACE2_EVENT="$(pwd)/$trace_file" \
+		check_connected "$@" &&
+	if test "$mode" != incremental
+	then
+		return
+	fi &&
+	if test -n "$trees"
+	then
+		test_trace2_data_singular connectivity trees_loaded "$trees" \
+			<"$trace_file"
+	fi &&
+	if test -n "$blobs"
+	then
+		test_trace2_data_singular connectivity blobs_checked "$blobs" \
+			<"$trace_file"
+	fi
+}
+
+# Shared setup: a repo with several root-level files and nested dirs.
+# The unchanged/ subtree (10 dirs x 10 files = 100 blobs, 11 trees)
+# acts as a canary: any test asserting small tree/blob counts would
+# fail dramatically if incremental accidentally walked into it.
+
+test_expect_success 'setup main repo' '
+	git init main-repo &&
+	(
+		cd main-repo &&
+		for i in $(test_seq 1 5)
+		do
+			echo "file $i" >"file-$i.txt" || return 1
+		done &&
+		git add file-*.txt &&
+		git commit -m "initial" &&
+
+		mkdir -p a/b/c &&
+		echo deep >a/b/c/deep.txt &&
+		echo other >a/other.txt &&
+		git add a/b/c/deep.txt a/other.txt &&
+		git commit -m "add nested dirs" &&
+
+		for i in $(test_seq 1 10)
+		do
+			d="unchanged/dir-$i" &&
+			mkdir -p "$d" &&
+			for j in $(test_seq 1 10)
+			do
+				echo "$i $j" >"$d/file-$j.txt" || return 1
+			done
+		done &&
+		git add unchanged/ &&
+		git commit -m "add unchanged canary subtree"
+	)
+'
+
+test_expect_success 'setup replacement object repo' '
+	git init replace-test &&
+	(
+		cd replace-test &&
+
+		test_commit --no-tag original file.txt &&
+		original=$(git rev-parse HEAD) &&
+		orig_blob=$(git rev-parse HEAD:file.txt) &&
+
+		# Orphan replacement commit with a different tree
+		replacement_tree=$(echo replaced | git hash-object -w --stdin |
+			xargs -I{} git mktree <<-EOF
+			100644 blob {}	file.txt
+			EOF
+		) &&
+		replacement=$(git commit-tree -m "replacement" \
+			"$replacement_tree") &&
+
+		git replace "$original" "$replacement" &&
+
+		# Remove the original blob so only the replacement
+		# tree is complete.
+		rm .git/objects/$(test_oid_to_path "$orig_blob") &&
+
+		# Drop branch and HEAD so --not --all does not
+		# exclude the original commit.
+		git update-ref -d refs/heads/main &&
+		git update-ref -d HEAD &&
+
+		echo "$original" >.git/test-oid
+	)
+'
+
+missing_oid=$(test_oid missing)
+original_oid=$(cat replace-test/.git/test-oid)
+
+for mode in full incremental
+do
+
+# Corruption detection: craft broken object graphs and verify detection.
+# All tests use main-repo without modifying its refs or worktree.
+
+test_expect_success "$mode: rejects commit with missing blob" '
+	(
+		cd main-repo &&
+		bad_tree=$(printf "100644 blob ${missing_oid}\tfile.txt\n" |
+			git mktree --missing) &&
+		bad_commit=$(git commit-tree "$bad_tree" -p HEAD -m "bad") &&
+		test_expect_code 128 check_connected "$bad_commit" 2>err &&
+		test_grep "missing blob object" err
+	)
+'
+
+test_expect_success "$mode: rejects commit with missing subtree" '
+	(
+		cd main-repo &&
+		bad_tree=$(printf "40000 tree ${missing_oid}\tdir\n" |
+			git mktree --missing) &&
+		bad_commit=$(git commit-tree "$bad_tree" -p HEAD -m "bad") &&
+		test_expect_code 128 check_connected "$bad_commit" 2>err &&
+		test_grep "bad tree object" err
+	)
+'
+
+test_expect_success "$mode: verifies direct tree tip" '
+	(
+		cd main-repo &&
+		bad_tree=$(printf "100644 blob ${missing_oid}\tfile.txt\n" |
+			git mktree --missing) &&
+		test_expect_code 128 check_connected "$bad_tree" 2>err &&
+		test_grep "missing blob object" err
+	)
+'
+
+test_expect_success "$mode: verifies direct blob tip" '
+	(
+		cd main-repo &&
+		blob_oid=$(echo "hello" | git hash-object -w --stdin) &&
+		check_connected "$blob_oid"
+	)
+'
+
+test_expect_success "$mode: rejects missing direct blob tip" '
+	(
+		cd main-repo &&
+		test_expect_code 128 check_connected \
+			"$missing_oid" 2>err
+	)
+'
+
+test_expect_success PERL_TEST_HELPERS \
+	"$mode: rejects blob OID reused as tree entry" '
+	(
+		cd main-repo &&
+
+		blob_oid=$(git rev-parse HEAD:file-1.txt) &&
+		bin_oid=$(echo "$blob_oid" | hex2oct) &&
+
+		bad_tree=$(printf "40000 subdir\0$bin_oid" |
+			git hash-object -t tree -w --stdin) &&
+		bad_commit=$(git commit-tree -p HEAD -m "child" "$bad_tree") &&
+
+		test_expect_code 128 check_connected "$bad_commit" 2>err &&
+		test_grep "not a tree" err
+	)
+'
+
+test_expect_success PERL_TEST_HELPERS \
+	"$mode: rejects tree OID reused as blob entry" '
+	(
+		cd main-repo &&
+
+		tree_oid=$(git rev-parse HEAD:a) &&
+		bin_oid=$(echo "$tree_oid" | hex2oct) &&
+
+		bad_tree=$(printf "100644 fakefile\0$bin_oid" |
+			git hash-object -t tree -w --stdin) &&
+		bad_commit=$(git commit-tree -p HEAD -m "child" "$bad_tree") &&
+
+		test_expect_code 128 check_connected "$bad_commit" 2>err &&
+		test_grep "not a blob" err
+	)
+'
+
+test_expect_success "$mode: checks multiple tips" '
+	(
+		cd main-repo &&
+		c1=$(commit_with_change HEAD file-1.txt "tip-a") &&
+		c2=$(commit_with_change HEAD file-2.txt "tip-b") &&
+		git tag -a -m "tagged" multi-tag "$c1" &&
+		tag_oid=$(git rev-parse multi-tag) &&
+		git tag -d multi-tag &&
+		check_connected "$c2" "$tag_oid"
+	)
+'
+
+# Tree-diff optimization: verify trace2 counts.
+
+test_expect_success "$mode: handles root commit (no parents)" '
+	(
+		cd main-repo &&
+		blob_oid=$(echo "root-content" | git hash-object -w --stdin) &&
+		tree_oid=$(printf "100644 blob %s\tfile.txt\n" \
+			"$blob_oid" | git mktree) &&
+		root_oid=$(git commit-tree "$tree_oid" -m "root") &&
+
+		# No parent trees, so the full tree is verified.
+		# 1 tree loaded (root), 1 blob checked.
+		check_connected_trace trace-root.txt 1 1 "$root_oid"
+	)
+'
+
+test_expect_success "$mode: handles single file change" '
+	(
+		cd main-repo &&
+		oid=$(commit_with_change HEAD file-1.txt "changed") &&
+
+		# 2 trees loaded (new root + parent root), 1 blob checked.
+		check_connected_trace trace-flat.txt 2 1 "$oid"
+	)
+'
+
+test_expect_success "$mode: handles nested change" '
+	(
+		cd main-repo &&
+		oid=$(commit_with_change HEAD a/b/c/deep.txt "deep-changed") &&
+		# 4 new trees + 4 parent trees = 8 loaded, 1 blob checked.
+		check_connected_trace trace-nested.txt 8 1 "$oid"
+	)
+'
+
+test_expect_success "$mode: handles change-then-revert" '
+	(
+		cd main-repo &&
+		c1=$(commit_with_change HEAD file-1.txt "revert-tmp") &&
+		c2=$(commit_with_change "$c1" file-1.txt "file 1") &&
+		c3=$(commit_with_change "$c2" file-1.txt "revert-final") &&
+
+		# c1: new root + parent root = 2 loads.  c2: root matches
+		# HEAD (already trusted), skipped.  c3: new root + parent
+		# already expanded = 1 load.  Total: 3 trees, 2 blobs.
+		check_connected_trace trace-revert.txt 3 2 "$c3"
+	)
+'
+
+test_expect_success "$mode: handles subtree moved to another path" '
+	(
+		cd main-repo &&
+		moved_tree=$(git ls-tree HEAD |
+			sed "s/	a$/	moved/" |
+			git mktree) &&
+		moved=$(git commit-tree "$moved_tree" -p HEAD -m move) &&
+		# New root + parent root scanned, but the moved subtree
+		# (same OID) is trusted and not descended into.
+		check_connected_trace trace-move.txt 2 0 "$moved"
+	)
+'
+
+test_expect_success "$mode: handles multi-parent merge" '
+	(
+		cd main-repo &&
+		left=$(commit_with_change HEAD file-1.txt left) &&
+		right=$(commit_with_change HEAD file-2.txt right) &&
+		git update-ref refs/heads/left "$left" &&
+		git update-ref refs/heads/right "$right" &&
+		left_blob=$(git rev-parse "$left:file-1.txt") &&
+		right_blob=$(git rev-parse "$right:file-2.txt") &&
+		tmpgit read-tree HEAD &&
+		tmpgit update-index --replace \
+			--cacheinfo "100644,$left_blob,file-1.txt" &&
+		tmpgit update-index --replace \
+			--cacheinfo "100644,$right_blob,file-2.txt" &&
+		merge_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		merge=$(git commit-tree "$merge_tree" \
+			-p "$left" -p "$right" -m merge) &&
+		# Both parent root trees are scanned as bases, so
+		# blobs from each parent are trusted without ODB checks.
+		check_connected_trace trace-merge.txt 3 0 "$merge" &&
+		git update-ref -d refs/heads/left &&
+		git update-ref -d refs/heads/right
+	)
+'
+
+test_expect_success "$mode: handles merge with incoming and boundary parents" '
+	(
+		cd main-repo &&
+		# parent1 is incoming (not a ref), HEAD is boundary.
+		parent1=$(commit_with_change HEAD file-1.txt merge-inc) &&
+		merge=$(git commit-tree \
+			"$(git rev-parse "$parent1^{tree}")" \
+			-p "$parent1" -p HEAD -m merge-mixed) &&
+		# parent1 verified first (topo order): 2 trees, 1 blob.
+		# merge tree = parent1 tree (already trusted): 0 extra.
+		check_connected_trace trace-merge-inc.txt 2 1 "$merge"
+	)
+'
+
+test_expect_success "$mode: handles gitlink entries (submodules)" '
+	(
+		cd main-repo &&
+		tmpgit read-tree HEAD &&
+		tmpgit update-index --add \
+			--cacheinfo "160000,$missing_oid,my-submodule" &&
+		gitlink_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		gitlink_commit=$(git commit-tree "$gitlink_tree" -p HEAD \
+			-m "add gitlink") &&
+
+		# Gitlink entries are skipped -- the missing submodule
+		# commit OID does not cause a failure.
+		check_connected_trace trace-gitlink.txt 2 0 "$gitlink_commit"
+	)
+'
+
+test_expect_success "$mode: handles file-to-directory transition" '
+	(
+		cd main-repo &&
+
+		# Parent: "foo" is a blob at root.
+		blob_a=$(echo "file-content" | git hash-object -w --stdin) &&
+		tmpgit read-tree HEAD &&
+		tmpgit update-index --add \
+			--cacheinfo "100644,$blob_a,foo" &&
+		parent_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		parent=$(git commit-tree "$parent_tree" -p HEAD \
+			-m "add foo as file") &&
+
+		# Child: "foo" becomes a directory (foo/bar.txt).
+		blob_b=$(echo "dir-content" | git hash-object -w --stdin) &&
+		tmpgit read-tree "$parent" &&
+		tmpgit update-index --remove foo &&
+		tmpgit update-index --add \
+			--cacheinfo "100644,$blob_b,foo/bar.txt" &&
+		child_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		child=$(git commit-tree "$child_tree" -p "$parent" \
+			-m "foo: file to directory") &&
+		check_connected_trace trace-f2d.txt "" "" "$child"
+	)
+'
+
+test_expect_success "$mode: handles directory-to-file transition" '
+	(
+		cd main-repo &&
+
+		# Parent: "bar/baz.txt" exists (bar is a directory).
+		blob_a=$(echo "nested" | git hash-object -w --stdin) &&
+		tmpgit read-tree HEAD &&
+		tmpgit update-index --add \
+			--cacheinfo "100644,$blob_a,bar/baz.txt" &&
+		parent_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		parent=$(git commit-tree "$parent_tree" -p HEAD \
+			-m "add bar as directory") &&
+
+		# Child: "bar" becomes a plain file.
+		blob_b=$(echo "flat" | git hash-object -w --stdin) &&
+		tmpgit read-tree "$parent" &&
+		tmpgit update-index --remove bar/baz.txt &&
+		tmpgit update-index --add \
+			--cacheinfo "100644,$blob_b,bar" &&
+		child_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		child=$(git commit-tree "$child_tree" -p "$parent" \
+			-m "bar: directory to file") &&
+		check_connected_trace trace-d2f.txt "" "" "$child"
+	)
+'
+
+# Replacement objects.
+
+test_expect_success "$mode: accepts with replacement objects" '
+	(
+		cd replace-test &&
+		check_connected "$original_oid"
+	)
+'
+
+test_expect_success "$mode: rejects without replacement objects" '
+	(
+		cd replace-test &&
+		GIT_NO_REPLACE_OBJECTS=1 &&
+		export GIT_NO_REPLACE_OBJECTS &&
+		test_expect_code 128 check_connected \
+			"$original_oid" 2>err &&
+		test_grep "missing blob object" err
+	)
+'
+
+test_expect_success "$mode: accepts missing promised blob" '
+	test_when_finished "rm -rf prom-src prom-server.git prom-client" &&
+	git init prom-src &&
+	test_commit -C prom-src --no-tag base file.txt original &&
+	test_commit -C prom-src --no-tag "add file2" file2.txt extra &&
+	git clone --bare prom-src prom-server.git &&
+	git -C prom-server.git config uploadpack.allowfilter true &&
+	git -C prom-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/prom-server.git" prom-client &&
+	(
+		cd prom-client &&
+		promised_blob=$(git rev-parse HEAD:file2.txt) &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_blob" &&
+		new_tree=$(printf "100644 blob %s\tnewname.txt\n" \
+			"$promised_blob" |
+			git mktree --missing) &&
+		new_commit=$(git commit-tree "$new_tree" \
+			-p HEAD -m "reuse promised blob") &&
+		check_connected "$new_commit" &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_blob"
+	)
+'
+
+test_expect_success "$mode: does not lazy-fetch promised blob" '
+	test_when_finished "rm -rf nofetch-src nofetch-server.git nofetch-client" &&
+	git init nofetch-src &&
+	test_commit -C nofetch-src --no-tag base file.txt content &&
+	git clone --bare nofetch-src nofetch-server.git &&
+	git -C nofetch-server.git config uploadpack.allowfilter true &&
+	git -C nofetch-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/nofetch-server.git" nofetch-client &&
+	(
+		cd nofetch-client &&
+		promised_blob=$(git rev-parse HEAD:file.txt) &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_blob" &&
+		new_tree=$(printf "100644 blob %s\tfile.txt\n" \
+			"$promised_blob" |
+			git mktree --missing) &&
+		new_commit=$(git commit-tree "$new_tree" \
+			-m "root commit with promised blob") &&
+		check_connected "$new_commit" &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_blob"
+	)
+'
+
+test_expect_success "$mode: accepts missing promised tree" '
+	test_when_finished "rm -rf prom-tree-src prom-tree-server.git prom-tree-client" &&
+	git init prom-tree-src &&
+	mkdir -p prom-tree-src/a/b &&
+	test_commit -C prom-tree-src --no-tag "nested dirs" a/b/file.txt deep &&
+	git clone --bare prom-tree-src prom-tree-server.git &&
+	git -C prom-tree-server.git config uploadpack.allowfilter true &&
+	git -C prom-tree-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --no-checkout --filter=tree:1 \
+		"file://$(pwd)/prom-tree-server.git" prom-tree-client &&
+	(
+		cd prom-tree-client &&
+		promised_tree=$(git ls-tree HEAD -- a |
+			awk "{print \$3}") &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_tree" &&
+		new_tree=$(printf "40000 tree %s\trenamed\n" \
+			"$promised_tree" |
+			git mktree --missing) &&
+		new_commit=$(git commit-tree "$new_tree" \
+			-p HEAD -m "reuse promised tree") &&
+		check_connected "$new_commit" &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_tree"
+	)
+'
+
+test_expect_success "$mode: verifies new subtree when parent subtree is promised" '
+	test_when_finished "rm -rf prom-base-src prom-base-server.git prom-base-client" &&
+	git init prom-base-src &&
+	mkdir -p prom-base-src/a &&
+	test_commit -C prom-base-src --no-tag "base" a/file.txt deep &&
+	git clone --bare prom-base-src prom-base-server.git &&
+	git -C prom-base-server.git config uploadpack.allowfilter true &&
+	git -C prom-base-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --no-checkout --filter=tree:1 \
+		"file://$(pwd)/prom-base-server.git" prom-base-client &&
+	(
+		cd prom-base-client &&
+		parent_subtree=$(git ls-tree HEAD -- a |
+			awk "{print \$3}") &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$parent_subtree" &&
+		new_blob=$(echo "local-content" | git hash-object -w --stdin) &&
+		new_subtree=$(printf "100644 blob %s\tfile.txt\n" \
+			"$new_blob" | git mktree) &&
+		new_root=$(printf "40000 tree %s\ta\n" \
+			"$new_subtree" | git mktree) &&
+		new_commit=$(git commit-tree "$new_root" \
+			-p HEAD -m "replace promised subtree") &&
+		check_connected "$new_commit" &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$parent_subtree"
+	)
+'
+
+test_expect_success "$mode: verifies local commit in partial clone" '
+	test_when_finished "rm -rf pc-src pc-server.git pc-client" &&
+	git init pc-src &&
+	test_commit -C pc-src --no-tag base file.txt &&
+	git clone --bare pc-src pc-server.git &&
+	git -C pc-server.git config uploadpack.allowfilter true &&
+	git -C pc-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --filter=blob:none \
+		"file://$(pwd)/pc-server.git" pc-client &&
+	(
+		cd pc-client &&
+		local_commit=$(commit_with_change HEAD file.txt local-content) &&
+		check_connected "$local_commit"
+	)
+'
+
+test_expect_success "$mode: respects shallow boundary" '
+	test_when_finished "rm -rf shallow-src shallow" &&
+	git init shallow-src &&
+	test_commit -C shallow-src --no-tag base file content-1 &&
+	mkdir shallow-src/sub &&
+	test_commit -C shallow-src --no-tag change sub/other content-2 &&
+	git clone --depth=1 "file://$(pwd)/shallow-src" shallow &&
+	(
+		cd shallow &&
+		tip=$(git rev-parse HEAD) &&
+		git for-each-ref --format="delete %(refname)" |
+			git update-ref --no-deref --stdin &&
+		check_connected "$tip"
+	)
+'
+
+test_expect_success "$mode: deepening fetch succeeds" '
+	test_when_finished "rm -rf deepen-src deepen-server.git deepen-client" &&
+	git init deepen-src &&
+	test_commit -C deepen-src --no-tag c1 file.txt &&
+	test_commit -C deepen-src --no-tag c2 file.txt &&
+	test_commit -C deepen-src --no-tag c3 file.txt &&
+	git clone --bare deepen-src deepen-server.git &&
+	git clone --depth=1 "file://$(pwd)/deepen-server.git" deepen-client &&
+	set_connectivity_check deepen-client $mode &&
+	test -f deepen-client/.git/shallow &&
+	GIT_TRACE2_EVENT="$(pwd)/deepen-trace.txt" \
+		git -C deepen-client fetch --deepen=2 origin main &&
+	# Incremental falls back to full for deepening fetches,
+	# so the trees_loaded event should not appear.
+	test_grep ! trees_loaded deepen-trace.txt
+'
+
+test_expect_success "$mode: malformed tree detected" '
+	(
+		cd main-repo &&
+		echo abc >malformed-tree &&
+		malformed_tree=$(git hash-object --literally -t tree -w \
+			malformed-tree) &&
+		malformed_commit=$(git commit-tree "$malformed_tree" \
+			-p HEAD -m malformed) &&
+		test_expect_code 128 check_connected \
+			"$malformed_commit" 2>err
+	)
+'
+
+test_expect_success PERL_TEST_HELPERS \
+	"$mode: mid-tree corruption detected" '
+	(
+		cd main-repo &&
+		# Build a tree with one valid entry followed by garbage.
+		blob_oid=$(echo "valid" | git hash-object -w --stdin) &&
+		bin_oid=$(echo "$blob_oid" | hex2oct) &&
+		printf "100644 good\0${bin_oid}GARBAGE" >corrupt-mid-tree &&
+		corrupt_tree=$(git hash-object --literally -t tree -w \
+			corrupt-mid-tree) &&
+		corrupt_commit=$(git commit-tree "$corrupt_tree" \
+			-p HEAD -m "mid-tree corruption") &&
+		test_expect_code 128 check_connected \
+			"$corrupt_commit" 2>err &&
+		test_grep "too-short tree object" err
+	)
+'
+
+done
+
+# Algorithm selection.
+
+test_expect_success 'invalid transfer.connectivityCheck is rejected' '
+	test_when_finished "rm -rf invalid-cfg-src invalid-cfg-dst" &&
+	git init invalid-cfg-src &&
+	test_commit -C invalid-cfg-src --no-tag base file.txt &&
+	git clone invalid-cfg-src invalid-cfg-dst &&
+	test_commit -C invalid-cfg-src --no-tag update file.txt updated &&
+	git -C invalid-cfg-dst config transfer.connectivityCheck bogus &&
+	test_must_fail git -C invalid-cfg-dst fetch origin main 2>err &&
+	test_grep "unknown transfer.connectivityCheck" err
+'
+
+test_expect_success 'push uses incremental when configured' '
+	test_when_finished "rm -rf int-src int-dst.git" &&
+	git init int-src &&
+	test_commit -C int-src --no-tag base file.txt &&
+	git clone --bare int-src int-dst.git &&
+	test_commit -C int-src --no-tag update file.txt updated &&
+	set_connectivity_check int-dst.git incremental &&
+	GIT_TRACE2_EVENT="$(pwd)/push-trace.txt" \
+		git -C int-src push ../int-dst.git main &&
+	test_trace2_data_singular connectivity trees_loaded 2 \
+		<push-trace.txt
+'
+
+test_expect_success 'fetch uses incremental when configured' '
+	test_when_finished "rm -rf fetch-src fetch-dst" &&
+	git init fetch-src &&
+	test_commit -C fetch-src --no-tag base file.txt &&
+	git clone fetch-src fetch-dst &&
+	test_commit -C fetch-src --no-tag update file.txt updated &&
+	set_connectivity_check fetch-dst incremental &&
+	GIT_TRACE2_EVENT="$(pwd)/fetch-trace.txt" \
+		git -C fetch-dst fetch origin main &&
+	test_trace2_data_singular connectivity trees_loaded 2 \
+		<fetch-trace.txt
+'
+
+test_expect_success 'clone respects transfer.connectivityCheck' '
+	test_when_finished "rm -rf clone-src clone-dst" &&
+	git init clone-src &&
+	test_commit -C clone-src --no-tag base file.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/clone-trace.txt" \
+		git -c transfer.connectivityCheck=incremental \
+		clone --no-local clone-src clone-dst &&
+	test_trace2_data_singular connectivity trees_loaded 0 \
+		<clone-trace.txt
+'
+
+test_done
diff --git a/tree-verify.c b/tree-verify.c
new file mode 100644
index 0000000000..b381a50102
--- /dev/null
+++ b/tree-verify.c
@@ -0,0 +1,316 @@
+#include "git-compat-util.h"
+#include "commit.h"
+#include "gettext.h"
+#include "hex.h"
+#include "khash.h"
+#include "object.h"
+#include "odb.h"
+#include "oid-array.h"
+#include "oidset.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "tree-verify.h"
+#include "packfile.h"
+#include "trace2.h"
+
+enum tree_state {
+	TREE_UNTRUSTED = 0,
+	TREE_TRUSTED   = 1,
+	TREE_EXPANDED  = 2,
+};
+
+KHASH_INIT(oid_tree, struct object_id, unsigned char, 1,
+	   oidhash_by_value, oideq_by_value)
+
+static enum tree_state tree_map_get(kh_oid_tree_t *m,
+				    const struct object_id *oid)
+{
+	khint_t pos = kh_get_oid_tree(m, *oid);
+	if (pos == kh_end(m))
+		return TREE_UNTRUSTED;
+	return kh_val(m, pos);
+}
+
+static void tree_map_add(kh_oid_tree_t *m, const struct object_id *oid,
+			 enum tree_state state)
+{
+	int added;
+	khint_t pos = kh_put_oid_tree(m, *oid, &added);
+	if (added)
+		kh_val(m, pos) = state;
+	else if (state > kh_val(m, pos))
+		kh_val(m, pos) = state;
+}
+
+struct work_item {
+	struct name_entry entry;
+	struct oid_array parent_trees;
+};
+
+struct verify_state {
+	kh_oid_tree_t *trees;
+	struct oidset trusted_blobs;
+	int trees_loaded;
+	int blobs_checked;
+	int exclude_promisor_objects;
+};
+
+/*
+ * Merge-walk the work list against one base tree entry, recording
+ * same-path parent subtrees as recursive comparison bases.
+ * Returns the updated work-list cursor.
+ */
+static size_t collect_subtree_bases(struct work_item *work, size_t nr_work,
+				    size_t wi, const struct name_entry *entry)
+{
+	while (wi < nr_work) {
+		int cmp = base_name_compare(
+			work[wi].entry.path, work[wi].entry.pathlen,
+			work[wi].entry.mode,
+			entry->path, entry->pathlen,
+			entry->mode);
+		if (cmp > 0)
+			break;
+		if (cmp < 0) {
+			wi++;
+			continue;
+		}
+		if (S_ISDIR(work[wi].entry.mode) &&
+		    S_ISDIR(entry->mode))
+			oid_array_append(&work[wi].parent_trees,
+					 &entry->oid);
+		return wi + 1;
+	}
+	return wi;
+}
+
+static void verify_blob(struct repository *repo,
+			const struct object_id *oid,
+			struct verify_state *vs)
+{
+	int type;
+
+	if (oidset_contains(&vs->trusted_blobs, oid))
+		return;
+
+	vs->blobs_checked++;
+	type = odb_read_object_info(repo->objects, oid, NULL);
+	if (type == OBJ_BLOB) {
+		oidset_insert(&vs->trusted_blobs, oid);
+		return;
+	}
+	if (type >= 0)
+		die(_("object %s is a %s, not a %s"),
+		    oid_to_hex(oid), type_name(type), "blob");
+	if (vs->exclude_promisor_objects &&
+	    is_promisor_object(repo, oid))
+		return;
+	die(_("missing blob object '%s'"), oid_to_hex(oid));
+}
+
+static void *read_tree_object(struct object_database *odb,
+			      const struct object_id *oid,
+			      size_t *sizep)
+{
+	enum object_type type;
+	void *buf = odb_read_object(odb, oid, &type, sizep);
+
+	if (buf && type != OBJ_TREE) {
+		free(buf);
+		die(_("object %s is a %s, not a %s"),
+		    oid_to_hex(oid), type_name(type), "tree");
+	}
+	return buf;
+}
+
+static void verify_tree(struct repository *repo,
+			const struct object_id *new_tree_oid,
+			const struct oid_array *base_trees,
+			struct verify_state *vs, int depth)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct work_item *work = NULL;
+	size_t nr_work = 0, alloc_work = 0;
+	int need_subtree_bases = 0;
+	size_t i, tree_size;
+	void *tree_buf;
+
+	if (depth > repo->settings.max_allowed_tree_depth)
+		die(_("exceeded maximum allowed tree depth"));
+
+	if (tree_map_get(vs->trees, new_tree_oid) >= TREE_TRUSTED)
+		return;
+
+	tree_buf = read_tree_object(repo->objects, new_tree_oid, &tree_size);
+	if (!tree_buf) {
+		if (vs->exclude_promisor_objects &&
+		    is_promisor_object(repo, new_tree_oid))
+			return;
+		die(_("bad tree object %s"),
+		    oid_to_hex(new_tree_oid));
+	}
+
+	vs->trees_loaded++;
+	init_tree_desc(&desc, new_tree_oid, tree_buf, tree_size);
+
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISGITLINK(entry.mode))
+			continue;
+		if (S_ISDIR(entry.mode)) {
+			if (tree_map_get(vs->trees, &entry.oid) >= TREE_TRUSTED)
+				continue;
+			need_subtree_bases = 1;
+		} else {
+			if (oidset_contains(&vs->trusted_blobs, &entry.oid))
+				continue;
+		}
+		ALLOC_GROW(work, nr_work + 1, alloc_work);
+		memset(&work[nr_work], 0, sizeof(work[nr_work]));
+		work[nr_work].entry = entry;
+		nr_work++;
+	}
+
+	if (!nr_work) {
+		free(tree_buf);
+		goto done;
+	}
+
+	for (i = 0; base_trees && i < base_trees->nr; i++) {
+		const struct object_id *base_oid = &base_trees->oid[i];
+		int expanded = tree_map_get(vs->trees, base_oid) >= TREE_EXPANDED;
+		struct tree_desc base_desc;
+		struct name_entry scan_entry;
+		size_t wi = 0, base_size;
+		void *base_buf;
+
+		if (expanded && !need_subtree_bases)
+			continue;
+
+		base_buf = read_tree_object(repo->objects, base_oid,
+					    &base_size);
+		if (!base_buf) {
+			if (vs->exclude_promisor_objects &&
+			    is_promisor_object(repo, base_oid))
+				continue;
+			die(_("bad tree object %s"),
+			    oid_to_hex(base_oid));
+		}
+
+		vs->trees_loaded++;
+		init_tree_desc(&base_desc, base_oid, base_buf, base_size);
+
+		while (tree_entry(&base_desc, &scan_entry)) {
+			if (S_ISGITLINK(scan_entry.mode))
+				continue;
+
+			if (need_subtree_bases)
+				wi = collect_subtree_bases(work, nr_work,
+							   wi, &scan_entry);
+
+			if (!expanded) {
+				if (S_ISDIR(scan_entry.mode))
+					tree_map_add(vs->trees,
+						     &scan_entry.oid,
+						     TREE_TRUSTED);
+				else
+					oidset_insert(&vs->trusted_blobs,
+						      &scan_entry.oid);
+			}
+		}
+
+		if (!expanded)
+			tree_map_add(vs->trees, base_oid, TREE_EXPANDED);
+
+		free(base_buf);
+	}
+
+	for (i = 0; i < nr_work; i++) {
+		if (S_ISDIR(work[i].entry.mode))
+			verify_tree(repo, &work[i].entry.oid,
+				    &work[i].parent_trees, vs,
+				    depth + 1);
+		else
+			verify_blob(repo, &work[i].entry.oid, vs);
+	}
+
+	free(tree_buf);
+
+done:
+	tree_map_add(vs->trees, new_tree_oid, TREE_EXPANDED);
+	for (i = 0; i < nr_work; i++)
+		oid_array_clear(&work[i].parent_trees);
+	free(work);
+}
+
+static void verify_commit_tree(struct repository *repo,
+			       struct commit *commit,
+			       struct verify_state *vs)
+{
+	struct oid_array base_trees = OID_ARRAY_INIT;
+	const struct object_id *tree_oid;
+	struct commit_list *p;
+
+	/*
+	 * Parent trees are trusted: boundary parents are already
+	 * connected, and earlier incoming parents were verified
+	 * first due to the topological processing order.
+	 */
+	for (p = commit->parents; p; p = p->next) {
+		parse_commit_or_die(p->item);
+		tree_oid = get_commit_tree_oid(p->item);
+		if (!tree_oid)
+			die(_("unable to load root tree for commit %s"),
+			    oid_to_hex(&p->item->object.oid));
+		tree_map_add(vs->trees, tree_oid, TREE_TRUSTED);
+		oid_array_append(&base_trees, tree_oid);
+	}
+
+	tree_oid = get_commit_tree_oid(commit);
+	if (!tree_oid)
+		die(_("unable to load root tree for commit %s"),
+		    oid_to_hex(&commit->object.oid));
+	verify_tree(repo, tree_oid, &base_trees, vs, 0);
+	oid_array_clear(&base_trees);
+}
+
+void verify_commits_incremental(struct repository *repo,
+				struct commit_list **commits,
+				int exclude_promisor_objects)
+{
+	struct verify_state vs = { 0 };
+	struct commit_list *iter;
+	unsigned nr_before;
+
+	if (repo->fetch_if_missing)
+		BUG("verify_commits_incremental must not be called "
+		    "with fetch_if_missing set");
+
+	vs.trees = kh_init_oid_tree();
+	vs.exclude_promisor_objects = exclude_promisor_objects;
+
+	/*
+	 * Ancestors must be verified before descendants so that parent
+	 * trees can be trusted without re-verification.  Sort explicitly
+	 * rather than relying on the caller's ordering.
+	 *
+	 * sort_in_topological_order() silently drops cycle members,
+	 * so explicitly check if the size has changed.
+	 */
+	nr_before = commit_list_count(*commits);
+	sort_in_topological_order(commits, REV_SORT_IN_GRAPH_ORDER);
+	if (commit_list_count(*commits) < nr_before)
+		die(_("cycle detected in incoming commit graph"));
+
+	*commits = commit_list_reverse(*commits);
+
+	for (iter = *commits; iter; iter = iter->next)
+		verify_commit_tree(repo, iter->item, &vs);
+
+	kh_destroy_oid_tree(vs.trees);
+	oidset_clear(&vs.trusted_blobs);
+	trace2_data_intmax("connectivity", repo,
+			   "trees_loaded", vs.trees_loaded);
+	trace2_data_intmax("connectivity", repo,
+			   "blobs_checked", vs.blobs_checked);
+}
diff --git a/tree-verify.h b/tree-verify.h
new file mode 100644
index 0000000000..6aadadff70
--- /dev/null
+++ b/tree-verify.h
@@ -0,0 +1,15 @@
+#ifndef TREE_VERIFY_H
+#define TREE_VERIFY_H
+
+struct commit_list;
+struct repository;
+
+/*
+ * Verify trees of commits incrementally against their parents.
+ * Dies on verification failure.
+ */
+void verify_commits_incremental(struct repository *repo,
+				struct commit_list **commits,
+				int exclude_promisor_objects);
+
+#endif /* TREE_VERIFY_H */
-- 
gitgitgadget
