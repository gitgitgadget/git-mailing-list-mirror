Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761133;
	b=AZN2HYeNhgfCJw7+2K2Jo/8D8mkF0u2G4NIiYfLXEtVHWNsgGvXWAr55X159h+kUyltS
	 O1WKJBShYsf4Qc3ecVvcDcU9lmLXN145HWUb3wUS26/cNN37hqb3GDNraHq+u2gGo3uaE
	 PsXjBFagTtvgWaqP7QiNTUzyVYg4sX1Thp4KRgPBKRcDkmOYhkXEMvX/Y0wokehtQBwbu
	 JhQknJeUvsiPNpyDAG8AlMNko88SkUbumH/s3WPwWQ5XgZfE1faylFpg3aV8erpLLxO5I
	 j0y/2Crzm+EWH0MA917RHbAU79SjUAq4zkhWmppsPjgH1IeGOWojq1W2RmKMturgf3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=w0GD02hgCSQpmfTru7FzhjM9cr7dN3y4m3kJX5v2iCE=;
	b=SvXOg4QI+ld3jmr9AB0YzyutlzYKv7GWJStTvYbtCaV6vw9DDoM8H3k8GRcUBu+DO6wN
	 Li6uak0/svhREkF+54EeFCCRmqcji/T1t+wo9mMymqkSKR39tgAQkOLatOLTOvtlcn5+D
	 iSlkdCc4vGRLLLCJ3hKdJqiF6DwoiIggA1yr9MvHCOO8VnT3AefI6WHTQVjQgRLJkknfb
	 bMs6E3m6/40YoLlQNcr1uYzT307PvMqKcQRgwoXAMHWR5Pm6WjEgDy0qiaAvjT4PiqO5K
	 qOW1wX7luh1p3+urYmzgBzmDrvYe9VCoydhjy1yOEUcHRfcyoZ2e5ak0TJo0t4Wy0/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YZhgVUY4;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D6606A327
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D3D6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YZhgVUY4
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ab395abf79so8358667b3.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761131; x=1793365931; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w0GD02hgCSQpmfTru7FzhjM9cr7dN3y4m3kJX5v2iCE=;
        b=YZhgVUY4IHTDyz1F8nql2y+KCE1mDObq2jchuwcB1vHmaKrRA3MiiREVnl8Nxmte5K
         +wGpU+hkwUUEzmwEGhInIKaHwOPg6H58s2wI+AjB+q164vSE9eDtepDR2/1PNe+SqEvk
         xPrhbNxWcUO08+fqy+Wn2l78J7qo1LUkdLAWwoIYmrVcyZChONt7sfWgCIXqgLF9ekDQ
         InNXvQKOuYr+iLtpyhTHod1mHrOfvbWShg4LgZnv24pseoUXB4UsuzyGLmj13q5vtd0t
         673KtiSxTyGjFXFi9/U2q8H3gwAnS3QL1iY4IkFVm9NjZiJZtyC77kLJBr8Z+OKWbIzE
         PFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761131; x=1793365931;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w0GD02hgCSQpmfTru7FzhjM9cr7dN3y4m3kJX5v2iCE=;
        b=X2sd9MSQpXqvMto72ruT9wKVYSbYOvIDxDBcnNCjVSNIArXOWGNVYDizByiWScbpOD
         QMUQp1PHRB7tfh+jUMufWuPbRawZpmJJe6rcSLGpLCj2FHFuBAIb+2tCBvyo/r/qfp5I
         v18jwJ1VFGQoxAxYN/OxNGO/4lxeHiPI2WuLkgDPh7xss0hNM+kSVD/C+/YDjOuz+mjb
         ZCW/+tfE4B4mLTPvVBPofFePVvdWjceoCHWNOJmKT3Y/8Lw+lUgt7FeO2BJkLAlrbsUJ
         3K6KdDcBOrHZAXoqPeRMN8ZtIURKst3llSH1eiOWMy+gwGYllR0ugQaNL5EIzGH1RGJn
         Aa+w==
X-Gm-Message-State: AFq9FYLuy60NRQAWvzLhFaVuKmROWATFuDbG417Lv5yjw7Neo0U6oYyW
	fwbPv018UFXcgdXlmk1QC0k/C8Y1Oqvw+D65XHXy3DOKl/yKW9GUoQAk9ydatCp3
X-Gm-Gg: AYBFou1VshGm+L3PooklCGDr6xX2nvcq9NAPvS5nka59pyFiwnAcpgCkEWl4ZRDJHQo
	sZTB6kpQ2IV20SzfLVnxSlKuHxTyVlO8JvYLtgl2EwuU0v8CCLuyRSLmmdevhkVE3ZdRyP2A5Yf
	lQ7TtFH93Fm7t+ARfdq97ey4XomGZZaxzWKvV4xHAmcZPkzG3BTW8eNNeLv5TfTS9/GaBko7ZmA
	lSB4/O5yLEAjoLtYh0Jfb06WDvjNYefxSkJGkWipYhvZQmS/4fIhF7dYew373AyDk8yzd9DmLI+
	FVGrIWtDi1bT7nJ1YMqEp1tABn3CfjOm+x0K0BH0FV2BaEUtMDpCZbLzZTdJUvgGFJrNPAxCjSB
	wdUhxtIqk6wVH+pO6kt88VS4ZqjrbH4TXrf7vPZut62izkjQBIAXufkoyqPeg/boKpdH3P9fI/j
	cpTg0TY4etmvewAhSXbqvH5HU6dQ9zec5+gDLGhnsWXurBK4XkBPXRCecZDY2Qyv9Q5hXcZauPQ
	oZ4fRZd7XKcSIJI3wZouQZOF+gkxaFiXjlmqGm6B5d7l8kFgvt22SpXzDki+oUie3SIY2vcI4w2
	0jDtUQ==
X-Received: by 2002:a05:690c:ec6:b0:8b0:aedf:77cd with SMTP id 00721157ae682-8b157ca7bbcmr19291167b3.2.1792761130485;
        Fri, 23 Oct 2026 06:12:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.148])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156115330sm13009567b3.18.2026.10.23.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:12:09 -0700 (PDT)
Message-Id: <9e84dd5c323453e48a7d6b0b2218c152c4b58823.1792761119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:11:58 +0000
Subject: [PATCH v5 5/6] connected: add incremental connectivity check via
 rev-list
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
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

The incremental check runs inside rev-list, selected by the
internal --connectivity-check option.  After the normal
revision walk identifies the incoming commits, the verifier
consumes them before the usual object traversal; any pending
non-commit tips are still handled by the existing traversal.

Partial-clone semantics are preserved: objects promised by a
promisor remote are accepted as connected, and on-demand fetching
is prevented by excluding promisor objects from traversal.

A new transfer.connectivityCheck value "incremental" selects the
new mode, with "full" remaining the default.  Deepening fetches
fall back to the full check because they do not have the normal
existing-reference boundary, and traversal instead follows the
effective shallow boundary.

Clones and pushes into an empty repository also use the full
check.  Without negative revisions there is no trusted boundary,
and the incremental check would have to verify all of history
from scratch like the full check does, with extra per-commit
overhead on top.  On git.git, checking 70K commits without a
boundary takes 5.3s with the full check and 9.2s with the
incremental one.

p5413 results (best of 3), scaling one dimension at a time.
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
    200K    0.13s  0.01s   13.0x
    800K    0.54s  0.03s   18.0x

The full mode must walk the trees of boundary commits, which
grows with overall tree size.  Incremental still scans the
root trees, but avoids descending into unchanged subtrees,
so it grows much more slowly with repository size.

Scaling incoming commit count (200K files, 10 files/commit):

    commits    full  incr.  full/incr
          1    0.13s  0.01s   13.0x
         10    0.13s  0.01s   13.0x
        100    0.16s  0.06s    2.7x
        500    0.29s  0.25s    1.2x
       3000    1.14s  1.44s    0.8x
       5000    1.87s  2.39s    0.8x
      10000    3.45s  5.13s    0.7x

With many commits the per-commit overhead of scanning both
the new and parent root trees accumulates and incremental
becomes slower.  Breakeven is between 500 and 3000 commits
and the ratio stabilizes near 0.7x for this fixture.

Scaling files per incoming commit (200K files, 10 commits):

    files/commit    full  incr.  full/incr
               1    0.13s  0.01s   13.0x
              10    0.13s  0.01s   13.0x
             100    0.15s  0.03s    5.0x
             500    0.23s  0.13s    1.8x
            1000    0.34s  0.27s    1.3x
            2000    0.65s  0.56s    1.2x

The advantage shrinks as more files change per commit, but
incremental stays slightly faster even at 2000 files/commit,
where every directory is touched.

Selected peak RSS measurements from the same fixtures:

    case                        full    incr.  ratio
    200K files, 10 commits      31 MB    12 MB   0.4x
    800K files, 10 commits     110 MB    26 MB   0.2x
    200K files, 5000 commits   155 MB   151 MB   1.0x

Incremental uses less memory when it can prune enough of the
boundary tree walk.  In the long-history case the two modes
visit similar object sets and memory converges.

The regression cases in the CPU benchmarks are in wall-clock
time rather than memory, primarily from scanning some trees
more than once: a commit's tree is read as a candidate when the
commit is verified, and again as a trusted parent tree when its
children are verified.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/config/transfer.adoc            |   8 +
 Documentation/rev-list-options.adoc           |   2 +-
 .../technical/connectivity-check.adoc         | 147 ++++
 Makefile                                      |   1 +
 builtin/rev-list.c                            |  27 +
 connected.c                                   |  14 +-
 meson.build                                   |   1 +
 t/meson.build                                 |   1 +
 t/perf/p5413-connectivity-check.sh            |  17 +-
 t/t5413-connectivity-check.sh                 | 774 ++++++++++++++++++
 t/t6700-tree-depth.sh                         |  17 +
 tree-verify.c                                 | 433 ++++++++++
 tree-verify.h                                 |  15 +
 13 files changed, 1450 insertions(+), 7 deletions(-)
 create mode 100755 t/t5413-connectivity-check.sh
 create mode 100644 tree-verify.c
 create mode 100644 tree-verify.h

diff --git a/Documentation/config/transfer.adoc b/Documentation/config/transfer.adoc
index 811456f1bf..cba7597a58 100644
--- a/Documentation/config/transfer.adoc
+++ b/Documentation/config/transfer.adoc
@@ -10,6 +10,14 @@ transfer.connectivityCheck::
 --
 `full` (default);;
 	Walk the full object closure of the boundary commits.
+`incremental`;;
+	Verify incoming commits by diffing their trees against parent
+	trees, recursively descending only into entries that differ.
+	The largest benefits occur when incoming commits change a
+	small fraction of a large tree closure, and it can be slower
+	than `full` when there are many incoming commits.
+	Falls back to `full` for clones, pushes into an empty
+	repository and deepening fetches.
 --
 +
 Unknown values are treated as `full`, with a warning.
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 3979a142a5..2023ad5f75 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1103,7 +1103,7 @@ It is an error to use `--missing-only` without `--missing=print` or
 	traversal, rather than just silencing errors about missing
 	objects.
 
-`--connectivity-check=full`::
+`--connectivity-check=(full|incremental)`::
 	(For internal use only.)  Used by `check_connected()` to
 	select the connectivity check algorithm; see
 	`transfer.connectivityCheck` in linkgit:git-config[1].
diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
index a112d5be3e..8b7d619d4c 100644
--- a/Documentation/technical/connectivity-check.adoc
+++ b/Documentation/technical/connectivity-check.adoc
@@ -110,3 +110,150 @@ tag, tree, or blob, that object is not part of the commit walk.
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
+topological order (ancestors first).  This all happens inside
+the same `rev-list` invocation, and the promisor fast path above
+still runs first.
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
index 619855f4e4..c07ad6e30c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -28,9 +28,11 @@
 #include "commit-reach.h"
 #include "quote.h"
 #include "strbuf.h"
+#include "tree-verify.h"
 
 enum connectivity_check_mode {
 	CONNECTIVITY_CHECK_FULL,
+	CONNECTIVITY_CHECK_INCREMENTAL,
 };
 
 struct connectivity_check {
@@ -42,6 +44,8 @@ static void parse_connectivity_check(const char *arg,
 {
 	if (!strcmp(arg, "full"))
 		check->mode = CONNECTIVITY_CHECK_FULL;
+	else if (!strcmp(arg, "incremental"))
+		check->mode = CONNECTIVITY_CHECK_INCREMENTAL;
 	else
 		die(_("unknown --connectivity-check mode '%s'"), arg);
 }
@@ -991,6 +995,29 @@ int cmd_rev_list(int argc,
 
 	prepare_maximal_independent(&revs);
 
+	/*
+	 * Without a boundary of negative revisions, as in a clone or a
+	 * push into an empty repository, every incoming commit is new.
+	 * The incremental check would still work, but it would verify
+	 * the whole object graph like the full check, with extra
+	 * per-commit overhead on top, so use the full check.
+	 */
+	if (!revs.limited)
+		connectivity_check.mode = CONNECTIVITY_CHECK_FULL;
+
+	if (connectivity_check.mode == CONNECTIVITY_CHECK_INCREMENTAL) {
+		struct commit *commit;
+		struct commit_list *new_commits = NULL;
+
+		while ((commit = get_revision(&revs)) != NULL)
+			commit_list_insert(commit, &new_commits);
+
+		if (verify_commits_incremental(repo, &new_commits,
+					       revs.exclude_promisor_objects))
+			die(_("connectivity check failed"));
+		commit_list_free(new_commits);
+	}
+
 	if (revs.tree_objects)
 		mark_edges_uninteresting(&revs, show_edge, 0);
 
diff --git a/connected.c b/connected.c
index 0147b7d3b3..c032987410 100644
--- a/connected.c
+++ b/connected.c
@@ -71,16 +71,28 @@ static int check_connected_promisor(struct repository *repo,
  * Fills in the --connectivity-check mode to pass to rev-list.
  */
 static void connectivity_check_mode(struct repository *repo,
+				    struct check_connected_options *opt,
 				    struct strbuf *mode)
 {
 	const char *algorithm = NULL;
 
+	/*
+	 * Deepening fetches do not have the usual boundary of
+	 * existing references, so use the full check for them.
+	 */
+	if (opt->is_deepening_fetch) {
+		strbuf_addstr(mode, "full");
+		return;
+	}
+
 	if (repo_config_get_string_tmp(repo,
 				       "transfer.connectivitycheck",
 				       &algorithm))
 		algorithm = "full";
 	if (!strcasecmp(algorithm, "full"))
 		strbuf_addstr(mode, "full");
+	else if (!strcasecmp(algorithm, "incremental"))
+		strbuf_addstr(mode, "incremental");
 	else {
 		warning(_("unknown transfer.connectivityCheck algorithm '%s', "
 			  "using 'full'"), algorithm);
@@ -156,7 +168,7 @@ int check_connected(struct repository *repo,
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=%s",
 			     _("Checking connectivity"));
-	connectivity_check_mode(repo, &mode);
+	connectivity_check_mode(repo, opt, &mode);
 	strvec_pushf(&rev_list.args, "--connectivity-check=%s", mode.buf);
 	strbuf_release(&mode);
 
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
index 9e968d0106..250140a79a 100755
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
@@ -51,9 +51,16 @@ test_perf_conn () {
 		fi
 	'
 
-	test_perf "$label" --prereq PERL '
+	test_perf "$label (full)" --prereq PERL '
 		cat '"${name}"'_new |
-		git -C '"$name"' rev-list \
+		git -C '"$name"' rev-list --connectivity-check=full \
+			--objects --stdin --not --all --quiet \
+			--exclude-promisor-objects
+	'
+
+	test_perf "$label (incremental)" --prereq PERL '
+		cat '"${name}"'_new |
+		git -C '"$name"' rev-list --connectivity-check=incremental \
 			--objects --stdin --not --all --quiet \
 			--exclude-promisor-objects
 	'
diff --git a/t/t5413-connectivity-check.sh b/t/t5413-connectivity-check.sh
new file mode 100755
index 0000000000..109ad17cff
--- /dev/null
+++ b/t/t5413-connectivity-check.sh
@@ -0,0 +1,774 @@
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
+	printf '%s\n' "$@" |
+	git rev-list --connectivity-check="$mode" \
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
+		echo "$original" >.git/test-oid &&
+		echo "$orig_blob" >.git/test-blob
+	)
+'
+
+missing_oid=$(test_oid missing)
+original_oid=$(cat replace-test/.git/test-oid)
+orig_blob_oid=$(cat replace-test/.git/test-blob)
+
+for mode in full incremental
+do
+
+# The full traversal reports a missing tree as "bad tree object".
+case "$mode" in
+full)
+	missing_tree="bad tree object"
+	;;
+incremental)
+	missing_tree="missing tree object"
+	;;
+esac
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
+		test_grep "missing blob object.*$missing_oid" err
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
+		test_grep "$missing_tree $missing_oid" err
+	)
+'
+
+test_expect_success "$mode: verifies direct tree tip" '
+	(
+		cd main-repo &&
+		bad_tree=$(printf "100644 blob ${missing_oid}\tfile.txt\n" |
+			git mktree --missing) &&
+		test_expect_code 128 check_connected "$bad_tree" 2>err &&
+		test_grep "missing blob object.*$missing_oid" err
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
+		test_grep "missing blob object.*$orig_blob_oid" err
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
+test_expect_success "$mode: tolerates missing promisor parent commit" '
+	test_when_finished "rm -rf mp-src mp-server.git mp-client" &&
+	git init mp-src &&
+	test_commit -C mp-src --no-tag base file.txt &&
+	git clone --bare mp-src mp-server.git &&
+	git -C mp-server.git config uploadpack.allowfilter true &&
+	git -C mp-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --filter=blob:none \
+		"file://$(pwd)/mp-server.git" mp-client &&
+	test_commit -C mp-src --no-tag c1 file.txt &&
+	test_commit -C mp-src --no-tag c2 file.txt &&
+	c1=$(git -C mp-src rev-parse HEAD~1) &&
+	c2=$(git -C mp-src rev-parse HEAD) &&
+	(
+		cd mp-client &&
+		# Add a promisor pack holding only c2, so its parent c1
+		# is missing but promised (as after a lazy fetch that
+		# omits dependents).
+		echo "$c2" |
+		git -C ../mp-src pack-objects --stdout >c2.pack &&
+		git index-pack --promisor --stdin <c2.pack &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$c1" &&
+		tree=$(git rev-parse HEAD^{tree}) &&
+		local_commit=$(git hash-object -t commit -w --stdin <<-EOF
+		tree $tree
+		parent $c1
+		author A U Thor <author@example.com> 1112912053 -0700
+		committer C O Mitter <committer@example.com> 1112912053 -0700
+
+		on top of a missing promisor commit
+		EOF
+		) &&
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
+# The full check only checks that blobs exist, but the incremental
+# check reads their headers and reports a corrupt blob.
+test_expect_success 'incremental: rejects corrupt blob' '
+	test_when_finished "rm -rf corrupt-repo" &&
+	git init corrupt-repo &&
+	(
+		cd corrupt-repo &&
+		test_commit base &&
+		blob=$(echo corrupt | git hash-object -w --stdin) &&
+		tree=$(printf "100644 blob $blob\tfile\n" | git mktree) &&
+		commit=$(git commit-tree "$tree" -p HEAD -m corrupt) &&
+		path=.git/objects/$(test_oid_to_path "$blob") &&
+		chmod +w "$path" &&
+		echo garbage >"$path" &&
+		mode=incremental &&
+		test_expect_code 128 check_connected "$commit" 2>err &&
+		test_grep "unable to read blob object $blob" err
+	)
+'
+
+# Algorithm selection.
+
+# Run a command with its trace2 events in "trace" and its stderr
+# in "err".
+run_traced () {
+	rm -f trace &&
+	GIT_TRACE2_EVENT="$(pwd)/trace" "$@" 2>err
+}
+
+# Check which connectivity check the last run_traced used.
+expect_mode () {
+	case "$1" in
+	full)
+		test_grep ! trees_loaded trace
+		;;
+	incremental)
+		test_grep trees_loaded trace
+		;;
+	*)
+		BUG "unknown mode: $1"
+		;;
+	esac
+}
+
+test_expect_success 'setup source repository' '
+	git init src &&
+	test_commit -C src base file.txt &&
+	test_commit -C src --no-tag update file.txt updated
+'
+
+test_expect_success 'unknown transfer.connectivityCheck falls back to full' '
+	test_when_finished "rm -rf dst" &&
+	git init --bare dst &&
+	git -C dst fetch ../src base:refs/heads/main &&
+	for value in bogus
+	do
+		set_connectivity_check dst "$value" &&
+		run_traced git -C dst fetch ../src main &&
+		expect_mode full &&
+		test_grep "unknown transfer.connectivityCheck algorithm .$value., using .full." err ||
+		return 1
+	done
+'
+
+test_expect_success 'push uses incremental when configured' '
+	test_when_finished "rm -rf dst" &&
+	git init --bare dst &&
+	git -C src push ../dst base:refs/heads/main &&
+	set_connectivity_check dst incremental &&
+	run_traced git -C src push ../dst main &&
+	expect_mode incremental
+'
+
+test_expect_success 'fetch uses incremental when configured' '
+	test_when_finished "rm -rf dst" &&
+	git init --bare dst &&
+	git -C dst fetch ../src base:refs/heads/main &&
+	set_connectivity_check dst incremental &&
+	run_traced git -C dst fetch ../src main &&
+	expect_mode incremental
+'
+
+for mode in incremental
+do
+	test_expect_success "push with $mode into an empty repository uses full" '
+		test_when_finished "rm -rf dst" &&
+		git init --bare dst &&
+		set_connectivity_check dst $mode &&
+		run_traced git -C src push ../dst main &&
+		expect_mode full
+	'
+
+	test_expect_success "clone with $mode uses full" '
+		test_when_finished "rm -rf dst" &&
+		run_traced git -c transfer.connectivityCheck=$mode \
+			clone --no-local src dst &&
+		expect_mode full
+	'
+done
+
+test_done
diff --git a/t/t6700-tree-depth.sh b/t/t6700-tree-depth.sh
index 0f6a2ad9b5..edb31e3914 100755
--- a/t/t6700-tree-depth.sh
+++ b/t/t6700-tree-depth.sh
@@ -82,6 +82,23 @@ test_expect_success 'default limit for rev-list fails gracefully' '
 	test_must_fail git rev-list --objects big >/dev/null
 '
 
+# The incremental check needs a boundary; without negative revisions
+# rev-list falls back to the full check.
+test_expect_success 'limit recursion of incremental check' '
+	boundary=$(git commit-tree $EMPTY_TREE -m boundary) &&
+	git $small_ok rev-list --connectivity-check=incremental \
+		--objects small --not $boundary >/dev/null &&
+	test_must_fail git $small_no rev-list \
+		--connectivity-check=incremental --objects small \
+		--not $boundary >/dev/null
+'
+
+test_expect_success 'default limit for incremental check fails gracefully' '
+	boundary=$(git commit-tree $EMPTY_TREE -m boundary) &&
+	test_must_fail git rev-list --connectivity-check=incremental \
+		--objects big --not $boundary >/dev/null
+'
+
 test_expect_success 'limit recursion of diff-tree -r' '
 	git $small_ok diff-tree -r $EMPTY_TREE small &&
 	test_must_fail git $small_no diff-tree -r $EMPTY_TREE small
diff --git a/tree-verify.c b/tree-verify.c
new file mode 100644
index 0000000000..25db76d30b
--- /dev/null
+++ b/tree-verify.c
@@ -0,0 +1,433 @@
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
+/* Values are enum tree_state, stored as a byte to keep the map small. */
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
+/* The entries of a tree that still need to be verified. */
+struct work_list {
+	struct work_item *items;
+	size_t nr, alloc;
+	bool has_subtrees;
+};
+
+static void work_list_clear(struct work_list *list)
+{
+	for (size_t i = 0; i < list->nr; i++)
+		oid_array_clear(&list->items[i].parent_trees);
+	free(list->items);
+}
+
+struct verify_state {
+	kh_oid_tree_t *trees;
+	struct oidset trusted_blobs;
+	size_t trees_loaded;
+	size_t blobs_checked;
+	int exclude_promisor_objects;
+
+	/*
+	 * Scratch space for reading one tree at a time.  It lives here
+	 * rather than on the stack to keep the frame of the recursive
+	 * verify_tree() small.
+	 */
+	struct tree_desc desc;
+	struct name_entry entry;
+};
+
+/*
+ * Merge-walk the work list against one base tree entry, recording
+ * same-path parent subtrees as recursive comparison bases.
+ * Returns the updated work-list cursor.
+ */
+static size_t collect_subtree_bases(struct work_list *list, size_t wi,
+				    const struct name_entry *entry)
+{
+	while (wi < list->nr) {
+		struct work_item *item = &list->items[wi];
+		int cmp = base_name_compare(item->entry.path,
+					    item->entry.pathlen,
+					    item->entry.mode,
+					    entry->path, entry->pathlen,
+					    entry->mode);
+		if (cmp > 0)
+			break;
+		if (cmp < 0) {
+			wi++;
+			continue;
+		}
+		if (S_ISDIR(item->entry.mode) && S_ISDIR(entry->mode))
+			oid_array_append(&item->parent_trees, &entry->oid);
+		return wi + 1;
+	}
+	return wi;
+}
+
+/*
+ * Report an object that could not be read, telling a missing object
+ * apart from one that exists but cannot be read, e.g. because it is
+ * corrupt.
+ */
+static int unreadable_object_error(struct repository *repo,
+				   const struct object_id *oid,
+				   const char *type)
+{
+	if (!odb_has_object(repo->objects, oid, 0))
+		return error(_("missing %s object %s"), type, oid_to_hex(oid));
+	return error(_("unable to read %s object %s"), type, oid_to_hex(oid));
+}
+
+static int verify_blob(struct repository *repo,
+		       const struct object_id *oid,
+		       struct verify_state *vs)
+{
+	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
+
+	if (oidset_contains(&vs->trusted_blobs, oid))
+		return 0;
+
+	vs->blobs_checked++;
+	oi.typep = &type;
+	if (odb_read_object_info_extended(repo->objects, oid, &oi,
+					  OBJECT_INFO_LOOKUP_REPLACE |
+					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+		if (vs->exclude_promisor_objects &&
+		    is_promisor_object(repo, oid))
+			return 0;
+		return unreadable_object_error(repo, oid, "blob");
+	}
+	if (type != OBJ_BLOB)
+		return error(_("object %s is a %s, not a %s"),
+			     oid_to_hex(oid), type_name(type), "blob");
+	oidset_insert(&vs->trusted_blobs, oid);
+	return 0;
+}
+
+/*
+ * Read a tree object into *bufp.  Returns -1 if the object exists
+ * but is not a tree.  Otherwise returns 0, leaving *bufp NULL if the
+ * object could not be read.
+ */
+static int read_tree_object(struct object_database *odb,
+			    const struct object_id *oid,
+			    void **bufp, size_t *sizep)
+{
+	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
+
+	oi.typep = &type;
+	oi.sizep = sizep;
+	oi.contentp = bufp;
+	if (odb_read_object_info_extended(odb, oid, &oi,
+					  OBJECT_INFO_LOOKUP_REPLACE |
+					  OBJECT_INFO_SKIP_FETCH_OBJECT))
+		*bufp = NULL;
+	if (*bufp && type != OBJ_TREE) {
+		FREE_AND_NULL(*bufp);
+		return error(_("object %s is a %s, not a %s"),
+			     oid_to_hex(oid), type_name(type), "tree");
+	}
+	return 0;
+}
+
+/* List the entries of a tree that are not yet known to be trusted. */
+static void list_untrusted_entries(struct verify_state *vs,
+				   const struct object_id *tree_oid,
+				   void *tree_buf, size_t tree_size,
+				   struct work_list *list)
+{
+	struct name_entry *entry = &vs->entry;
+
+	init_tree_desc(&vs->desc, tree_oid, tree_buf, tree_size);
+	while (tree_entry(&vs->desc, entry)) {
+		if (S_ISGITLINK(entry->mode))
+			continue;
+		if (S_ISDIR(entry->mode)) {
+			if (tree_map_get(vs->trees, &entry->oid) >=
+			    TREE_TRUSTED)
+				continue;
+			list->has_subtrees = true;
+		} else {
+			if (oidset_contains(&vs->trusted_blobs, &entry->oid))
+				continue;
+		}
+		ALLOC_GROW(list->items, list->nr + 1, list->alloc);
+		memset(&list->items[list->nr], 0, sizeof(list->items[0]));
+		list->items[list->nr++].entry = *entry;
+	}
+}
+
+/*
+ * Scan one trusted base tree: expand it if that has not happened yet,
+ * and collect its same-path subtrees as bases for untrusted subtrees.
+ */
+static int scan_base_tree(struct repository *repo, struct verify_state *vs,
+			  const struct object_id *base_oid,
+			  struct work_list *list)
+{
+	int expanded = tree_map_get(vs->trees, base_oid) >= TREE_EXPANDED;
+	struct name_entry *entry = &vs->entry;
+	size_t wi = 0, base_size;
+	void *base_buf;
+
+	if (expanded && !list->has_subtrees)
+		return 0;
+
+	if (read_tree_object(repo->objects, base_oid, &base_buf, &base_size))
+		return -1;
+	if (!base_buf) {
+		if (vs->exclude_promisor_objects &&
+		    is_promisor_object(repo, base_oid))
+			return 0;
+		return unreadable_object_error(repo, base_oid, "tree");
+	}
+
+	vs->trees_loaded++;
+	init_tree_desc(&vs->desc, base_oid, base_buf, base_size);
+
+	while (tree_entry(&vs->desc, entry)) {
+		if (S_ISGITLINK(entry->mode))
+			continue;
+
+		/* Same-path subtree as a base for an untrusted one. */
+		if (list->has_subtrees)
+			wi = collect_subtree_bases(list, wi, entry);
+
+		/* Expand: the base is trusted, so are its entries. */
+		if (!expanded) {
+			if (S_ISDIR(entry->mode))
+				tree_map_add(vs->trees, &entry->oid,
+					     TREE_TRUSTED);
+			else
+				oidset_insert(&vs->trusted_blobs,
+					      &entry->oid);
+		}
+	}
+
+	if (!expanded)
+		tree_map_add(vs->trees, base_oid, TREE_EXPANDED);
+
+	free(base_buf);
+	return 0;
+}
+
+/*
+ * Verify a tree against the trusted base trees, loading as little as
+ * possible:
+ *
+ * First list the entries that are not yet known to be trusted.  When
+ * the parent trees have been expanded before, only the changed entries
+ * remain.
+ *
+ * Then scan the trusted base trees (the same-path trees of the parent
+ * commits).  A base that has not been expanded yet is read so that its
+ * entries can be marked trusted; this often shows that listed entries
+ * are trusted after all.  An already expanded base is still read when
+ * there are untrusted subtrees, because its subtree at the same path is
+ * what lets the untrusted subtree skip its own unchanged entries in
+ * turn.
+ *
+ * Finally check that the remaining blobs exist, and recurse into the
+ * remaining subtrees with the same-path subtrees as their bases.
+ */
+static int verify_tree(struct repository *repo,
+		       const struct object_id *tree_oid,
+		       const struct oid_array *trusted_bases,
+		       struct verify_state *vs, int depth)
+{
+	struct work_list list = { 0 };
+	size_t i, tree_size;
+	void *tree_buf;
+	int ret = 0;
+
+	/*
+	 * Enforce core.maxTreeDepth like process_tree() in list-objects.c,
+	 * so that the full and incremental checks reject the same trees.
+	 */
+	if (depth > repo->settings.max_allowed_tree_depth)
+		return error(_("exceeded maximum allowed tree depth"));
+
+	if (tree_map_get(vs->trees, tree_oid) >= TREE_TRUSTED)
+		return 0;
+
+	if (read_tree_object(repo->objects, tree_oid, &tree_buf, &tree_size))
+		return -1;
+	if (!tree_buf) {
+		/*
+		 * A missing tree that is promised can be fetched on demand,
+		 * so it is not an error, as in the full check.
+		 */
+		if (vs->exclude_promisor_objects &&
+		    is_promisor_object(repo, tree_oid))
+			return 0;
+		return unreadable_object_error(repo, tree_oid, "tree");
+	}
+
+	vs->trees_loaded++;
+	list_untrusted_entries(vs, tree_oid, tree_buf, tree_size, &list);
+
+	/* Scan the base trees, unless nothing is left to verify. */
+	for (i = 0; list.nr && i < trusted_bases->nr; i++) {
+		ret = scan_base_tree(repo, vs, &trusted_bases->oid[i], &list);
+		if (ret)
+			goto done;
+	}
+
+	/*
+	 * Check the remaining entries in tree order.  Verifying a subtree
+	 * can show that later entries are trusted, which then makes them
+	 * cheap to skip.
+	 */
+	for (i = 0; i < list.nr && !ret; i++) {
+		struct work_item *item = &list.items[i];
+
+		if (S_ISDIR(item->entry.mode))
+			ret = verify_tree(repo, &item->entry.oid,
+					  &item->parent_trees, vs, depth + 1);
+		else
+			ret = verify_blob(repo, &item->entry.oid, vs);
+	}
+	if (!ret)
+		tree_map_add(vs->trees, tree_oid, TREE_EXPANDED);
+
+done:
+	free(tree_buf);
+	work_list_clear(&list);
+	return ret;
+}
+
+static int verify_commit_tree(struct repository *repo,
+			      struct commit *commit,
+			      struct verify_state *vs)
+{
+	struct oid_array parent_trees = OID_ARRAY_INIT;
+	const struct object_id *tree_oid;
+	struct commit_list *p;
+	int ret;
+
+	/*
+	 * Parent trees are trusted: boundary parents are already
+	 * connected, and earlier incoming parents were verified
+	 * first due to the topological processing order.
+	 *
+	 * The revision walk skips missing parents that are promised
+	 * (see process_parents()), so do the same here.  Such a parent
+	 * contributes no base, which only means less of the new tree
+	 * can be skipped.
+	 */
+	for (p = commit->parents; p; p = p->next) {
+		if (repo_parse_commit_gently(repo, p->item, 1) < 0) {
+			if (vs->exclude_promisor_objects &&
+			    is_promisor_object(repo, &p->item->object.oid))
+				continue;
+			ret = error(_("unable to parse commit %s"),
+				    oid_to_hex(&p->item->object.oid));
+			goto out;
+		}
+		tree_oid = get_commit_tree_oid(p->item);
+		if (!tree_oid) {
+			ret = error(_("unable to load root tree for commit %s"),
+				    oid_to_hex(&p->item->object.oid));
+			goto out;
+		}
+		tree_map_add(vs->trees, tree_oid, TREE_TRUSTED);
+		oid_array_append(&parent_trees, tree_oid);
+	}
+
+	tree_oid = get_commit_tree_oid(commit);
+	if (!tree_oid) {
+		ret = error(_("unable to load root tree for commit %s"),
+			    oid_to_hex(&commit->object.oid));
+		goto out;
+	}
+	ret = verify_tree(repo, tree_oid, &parent_trees, vs, 0);
+out:
+	oid_array_clear(&parent_trees);
+	return ret;
+}
+
+int verify_commits_incremental(struct repository *repo,
+			       struct commit_list **commits,
+			       int exclude_promisor_objects)
+{
+	struct verify_state vs = { 0 };
+	struct commit_list *iter;
+	unsigned nr_before;
+	int ret = 0;
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
+	if (commit_list_count(*commits) < nr_before) {
+		ret = error(_("cycle detected in incoming commit graph"));
+		goto out;
+	}
+
+	*commits = commit_list_reverse(*commits);
+
+	for (iter = *commits; iter && !ret; iter = iter->next)
+		ret = verify_commit_tree(repo, iter->item, &vs);
+
+out:
+	kh_destroy_oid_tree(vs.trees);
+	oidset_clear(&vs.trusted_blobs);
+	trace2_data_intmax("connectivity", repo,
+			   "trees_loaded", (intmax_t)vs.trees_loaded);
+	trace2_data_intmax("connectivity", repo,
+			   "blobs_checked", (intmax_t)vs.blobs_checked);
+	return ret;
+}
diff --git a/tree-verify.h b/tree-verify.h
new file mode 100644
index 0000000000..ac7092da1c
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
+ * Returns 0 on success, or reports an error and returns -1.
+ */
+int verify_commits_incremental(struct repository *repo,
+			       struct commit_list **commits,
+			       int exclude_promisor_objects);
+
+#endif /* TREE_VERIFY_H */
-- 
gitgitgadget

