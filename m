Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939C43CEFE
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013989; cv=none; b=Ab7+5PcONULzzaYqsNZfaB3QXL0gOpRv9o1EmgG3hzE1rPUHBd2NhVN33AYne/E6NuQRiJF7dyYduoO6N9gsrx3UnxHmj/CCGmfzbPDZuy94Gwj796v99/v0wYLue3cCfss6I+k3p+LxDBHAQAohC3FU3YlLytp1xlXeOk9dVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013989; c=relaxed/simple;
	bh=p/BwrbNHzMfWCthVBkVMdPhe/Lyg7VODiLR5PrgK2tk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AbuZkSSEpi+pvcRX3K7uGJjnr8DHEZBRg2sM8kmpAo9mWpLMUfAXPBW/D0gB63C9tcVWA31zvL4AsCm+9rN/xU4zYBJOJPHdDeUef0CSV84a+fKI4alPNI9X/52+2vGIj2CrpVwJH7pQU/WAe7sIJ5Et5P60EJtNi+oi0qDxbzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKBmKzCX; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKBmKzCX"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8143daf89c7so19664267b3.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786013986; x=1786618786; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=30fWl9yVs/bqkhBx7K5Ior4DzDFHURFJ7o8D+5feEoM=;
        b=VKBmKzCX+ExKys6ahNFKzsVghoDTc2z/TX+eEdQWsniEvP4QwVazhMw9g0xfgUIkQm
         4Tiwh/AK4xhQE4ym5IPdU9cHSqspF7Vym6Lrl87NrRnUpYSOW7HqXGTY38yjQ0vBiBOl
         W0vpEn3t6PQ2/+qtjWa38KlZu/BEIkXa/KDcCE7Iif4FbSCwaIsjM5bMYbHH02upS5tk
         ulvdtZdTY+DecTM6pp5nSdrpM+pNGE/PmEs172QcoUPvF4W5/OXwfTC9NXaULN2kHyYj
         Mb2Ic+OP0lqIbOOmTIHyzOmVV/oZoT5XA2Jd0IT9ArbR1jisEYq5KVsOU8dhYb0FOlOl
         3HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013986; x=1786618786;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=30fWl9yVs/bqkhBx7K5Ior4DzDFHURFJ7o8D+5feEoM=;
        b=Wieh99aRJz52VA/Q8Qcau3bmUF6yo3TggVqTw+TRalOmoVlv6mQjx04HD3UmOTejH7
         dC3QT9zQBJvTe8R00yyx5AXzax+Wo0RLirHS9BDuc2XMtlZ9NAWygMNEQrkBvi35vNBy
         mNSp20ApqUSRU5S39m4OODnLT92l5Czmj4PEpPx1IYdOm7BF2uPN5/bGU8oM59GEYA3k
         ovJnXYwxqIKBB4mUtVFLjpwS/4QLmNEbgTxd4QtqyHCnf7nd922EpTFamM435YTjDQSa
         k5rHXTEarV4hnFhy9hPKsDymDHulHIXYvlUVm2PKFd2edriHKkDHRyCOiFw24dhKkNu6
         y6tQ==
X-Gm-Message-State: AOJu0Yy14Sc2fkZgIOG9LPl04Rko0OsQH+9NX5VMHiM9Kk97sdU9jq5T
	QwPm2hgVbk1Q3lJpWA5HWMuw+c/Pw9hUlswlIo0iQqrDFOu5M5uHMzA2r14Dzw==
X-Gm-Gg: AR+sD13xJ9nwH5WKUrOREfbG3SguzgIcTepj+zqeg7kwcGBhiU9X2WpIz6v980Dw5PO
	C6fTTPjsS9VR3CYRamcCM0OiCgX0PmT42AEb6mSjzf8uQpn/QqJoM4nFkJBpnEy80sRXdi/RJA8
	kB/6PdyLaxcLzlAlct1afNv/PgmS+9asjMzhr5hvgBPStVdFP7tjRF4SRIZtq3CtWmJ1N0YYfSo
	hkD9TN35sy4aQ9TByYx3uNtFcoFIAqCIz1j3TZsGZszKMuYSXnm4PEReuFPgzk2qotVFHT/XE0S
	iy/j6t3jUpTvBz7bv6yde6b3tGoGo9EcT13UQz+w3NNbDVkraQi3saQ0T9baBiTl7NZCtOL6dLt
	CA5fnZxqbnQhJWfwJYgB40rPsORC18OUxfFxf8TwOIVR/rCOq2I00tY207xBOFM34hGAMu9x3IQ
	lOrpgT2fEFYEGLBnmbB9Mb54yrxqoMGY1Fp4rITs31cQmXRU5mcRG0B7zWb+YaZ/J3rt1tQEDy0
	g==
X-Received: by 2002:a05:690c:6209:b0:812:be92:6ea6 with SMTP id 00721157ae682-8225d084b3amr2826077b3.28.1786013986293;
        Thu, 06 Aug 2026 03:59:46 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201341d216sm37970677b3.26.2026.08.06.03.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:59:45 -0700 (PDT)
Message-Id: <c1f303353caeb5be301ea24f4a042d695459061b.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:32 +0000
Subject: [PATCH v7 01/10] Documentation/technical: add paint-down-to-common
 doc
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
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a technical document describing the paint_down_to_common()
algorithm used for merge-base computation, covering the paint
walk, generation number regions, and termination conditions.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 185 ++++++++++++++++++
 commit-reach.c                                |   6 +-
 4 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2699f0b24a..f8dea4b395 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -129,6 +129,7 @@ TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/packfile-uri
 TECH_DOCS += technical/pack-heuristics
+TECH_DOCS += technical/paint-down-to-common
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/platform-support
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index ec07088c57..9ce11d5e48 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -18,6 +18,7 @@ articles = [
   'multi-pack-index.adoc',
   'packfile-uri.adoc',
   'pack-heuristics.adoc',
+  'paint-down-to-common.adoc',
   'parallel-checkout.adoc',
   'partial-clone.adoc',
   'platform-support.adoc',
diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
new file mode 100644
index 0000000000..cea0cc2f91
--- /dev/null
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -0,0 +1,185 @@
+Merge-Base Computation and paint_down_to_common()
+==================================================
+
+The function `paint_down_to_common()` in `commit-reach.c` computes merge
+bases by walking the commit graph backwards from two sets of tips and
+finding where their ancestry meets.
+
+Use cases
+---------
+
+Computing merge bases is used in two different ways:
+
+ 1. *Finding all merge bases* (`merge-base --all`, `merge-tree`,
+    `merge`, `rebase`). A merge base is a common ancestor that is
+    not itself an ancestor of another common ancestor.
+
+ 2. *Ancestry checks* (`in_merge_bases`, used by `merge-base
+    --is-ancestor`, `branch -d`, `fetch`). These ask: "is commit A
+    an ancestor of commit B?" If a common ancestor equals one of the
+    inputs, that input is necessarily the only merge base -- no other
+    common ancestor can be both as recent and not an ancestor of it.
+
+Both use cases share the same algorithm and implementation.
+
+Algorithm
+---------
+
+Given a commit `one` and a set of commits `twos[]`, the walk paints
+commits with two colors:
+
+  - PARENT1: reachable from `one`
+  - PARENT2: reachable from any commit in `twos[]`
+
+The walk uses a priority queue ordered by generation number
+(highest first), breaking ties by commit date. Each step dequeues
+the highest-priority commit (this is when we say a commit is
+"visited") and propagates its paint flags to its parents, enqueuing
+them if they gained new flags. When a commit receives both PARENT1
+and PARENT2, it is a merge-base candidate. A candidate gains the
+STALE flag so its ancestors propagate staleness -- any deeper common
+ancestor is necessarily redundant.
+
+[[generation-regions]]
+INFINITY and finite generation regions
+--------------------------------------
+
+The properties in this section assume generation-number ordering (the
+default comparator). They do NOT hold when the date-ordering fallback
+is active -- see <<date-ordering-fallback>>.
+
+The commit-graph stores a generation number for each commit.
+Commits not in the commit-graph have generation
+`GENERATION_NUMBER_INFINITY`. The graph is closed under
+reachability: if a commit is in the graph, all its ancestors are
+too. This partitions the commit graph into two regions:
+
+....
+    +---------------------------------------+
+    |          INFINITY region              |
+    |  generation = INFINITY                |
+    |  queue order: heuristic (commit date) |
+    +---------------------------------------+
+                    |
+                    v
+    +---------------------------------------+
+    |          Finite region                |
+    |  generation = finite                  |
+    |  queue order: topological             |
+    +---------------------------------------+
+....
+
+When the commit-graph is enabled, the INFINITY region is typically
+very small -- it only contains commits added since the last
+commit-graph refresh.
+
+With v1 commit-graphs (topological levels, no GDAT chunk),
+generation numbers saturate at `GENERATION_NUMBER_V1_MAX`.
+Saturated commits share the same generation value despite
+different topological depths, which breaks ordering guarantees
+in the same way as INFINITY. The early exit gates compare
+against `GENERATION_NUMBER_V1_MAX` for v1 graphs and
+`GENERATION_NUMBER_INFINITY` for v2 graphs, so that saturated
+commits are treated as unordered.
+
+All reachable INFINITY-generation commits are visited before any
+finite-generation commit, because INFINITY is larger than any finite
+value. Once the walk crosses into the finite region, it stays there.
+
+In the finite region, generation ordering guarantees topological
+traversal: children are always visited before their parents. This
+means that paint on already-visited commits is final -- no future
+traversal step can add paint to them.
+
+In the INFINITY region, commit-date ordering can violate this: a
+parent with a later date can be visited before a child with an earlier
+date. Paint flags are therefore NOT final at visit time, and a
+commit visited with only one side's paint may later gain the other.
+
+Paint flags are only added, never removed. Since each flag can be set
+at most once per commit, the number of times a commit can be
+re-enqueued is bounded by the number of flag transitions.
+
+Termination
+-----------
+
+The walk uses a `nonstale_queue` wrapper around `prio_queue` that
+tracks `max_nonstale`: the lowest-priority non-stale commit enqueued
+so far. Once that commit is dequeued, every remaining entry is known
+to be STALE and the loop terminates. Specifically, the main loop
+ends when one of the following conditions holds:
+
+  1. The queue is empty.
+  2. `max_nonstale` has been dequeued, meaning the queue only contains
+     STALE entries.
+  3. Generation cutoff: the dequeued commit's generation is below
+     a caller-supplied `min_generation` threshold.
+  4. Single result: the caller only needs one merge base, one has
+     been found, and the walk has entered the finite-generation
+     region.
+
+Stale entry condition
+~~~~~~~~~~~~~~~~~~~~~
+Once all queued entries are stale, no new merge-base candidates can
+be discovered -- that requires at least one non-stale commit from
+each side meeting. Continuing the walk could still invalidate
+existing candidates by proving one is an ancestor of another, but
+`remove_redundant()` handles that as a post-processing step, so it
+is safe to exit early.
+
+Generation cutoff
+~~~~~~~~~~~~~~~~~
+Some callers (notably `remove_redundant()`) supply a `min_generation`
+threshold equal to the minimum generation of the input commits.
+These callers only need to determine reachability among the inputs,
+not find deep merge bases, so the walk can safely terminate when it
+dequeues a commit below this threshold.
+
+Single result
+~~~~~~~~~~~~~
+When only one merge base is needed, the walk is in the
+finite-generation region, and the queue uses generation ordering,
+the first candidate found is necessarily the highest-generation
+common ancestor. No remaining commit in the queue can be a
+descendant of this candidate (generation ordering guarantees
+children are visited first), so it cannot be redundant and the walk
+can stop immediately.
+
+This optimization is NOT safe when the date-ordering fallback is
+active, because commit-date order can visit a deeper ancestor
+before a shallower one -- see <<date-ordering-fallback>>.
+
+[[date-ordering-fallback]]
+Date-ordering fallback
+----------------------
+
+When the commit-graph has generation numbers v1 and no
+generation floor is specified, topological ordering
+(via generation numbers) is disabled.  Topological levels are
+correct but unbalanced -- ordering by such generation numbers
+can sometimes cause the walk to detour too far before finding
+merge bases.  Commit-date ordering typically reaches them in
+fewer steps -- see this change for more details:
+
+   091f4cf3 (commit: don't use generation numbers if not needed,
+   2018-08-30)
+
+With generation number v2 (corrected commit dates) we have the best
+of both worlds and do not need this fallback.
+
+For v1, `paint_down_to_common()` falls back to pure commit-date
+ordering via `compare_commits_by_commit_date`.  Because commit
+dates are not monotonic (clock skew, rebases, etc.), the queue
+may visit commits out of topological order.
+
+This disables the optimization that depends on generation ordering:
+
+  - *Single result*: the first merge-base candidate found may not
+    be the shallowest, because a deeper ancestor with a higher
+    commit date can be dequeued first.
+
+Related documentation
+---------------------
+
+  - `Documentation/technical/commit-graph.adoc` -- generation numbers
+    and the reachability closure property.
diff --git a/commit-reach.c b/commit-reach.c
index b53c6b1cdf..8541264136 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -96,7 +96,11 @@ static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
 	return commit;
 }
 
-/* all input commits in one and twos[] must have been parsed! */
+/*
+ * See Documentation/technical/paint-down-to-common.adoc
+ *
+ * All input commits in one and twos[] must have been parsed!
+ */
 static int paint_down_to_common(struct repository *r,
 				struct commit *one, int n,
 				struct commit **twos,
-- 
gitgitgadget

