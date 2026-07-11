Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727F3C2B95
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776473; cv=none; b=jb94wGb6UPuIQz0s2FXbTlQScNSVARA8NdJupgAnjc015iX3ZI4n6LGldpFU0VdEU8v3YOp4I6AYLpZWM2D0oxIjx5lQczzsZLSsSuGi6mfoYCbquvjYvaXOkhbwQw08tSVdxpHNR71Z3hCsjyGuf4KpbeaNQ7NFC1i7SIFVt6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776473; c=relaxed/simple;
	bh=5/RFJwQF2+587cdFiQwGHVpGbrLy/kfqLrKgi7CyKUg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t8h8GbTEuWuy15imtgYZQdD9sk7V6R4NciXe3/VeswEl8gonotVvXvvuUlHOEpzOzhySRNSwop1/NYhfpTDkzFl1086DWE7l+gSaeEZmkHAXn9VqiI3GN4YUBWFhRO/t+P9jdlaWCk+FBM2abgqWXb+ixwTI472v2xJ3Im6/5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVaBUQmJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVaBUQmJ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca913a601fbso1281961a12.3
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776471; x=1784381271; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=86MXUuA8Vww5FfCovkUCtKUFxfQa1fFrzspvefGWXDQ=;
        b=DVaBUQmJq9hgvYrwmdevr5IKrH9k5bRnFDAoIrO5NrOfSmljw45IAkwot2l/KI+rgW
         FprJwRC2bcL1m5ijYlKflhLJK+xSzOa5WK0z+KSWRHboXkxBDxv1KsuUR205ZpEG1s1H
         1XsXHJ5PG7I5UoWfNCzv/QqY2mwC8Y17kUZywwHYbbdjVaNhOcv1yVEVowrxKIhKZeBt
         0Xojq4WMMyFC7fWqthI7nFGxxxe+HVRtGLEj8DqdzMsAAwR9xfJftXoIr9N7ROUU+fCs
         z4BXRI5gBgsdHi8q0Th9aHUEBptmWxdLmMOM3rciw29UfzEE9OVRr+f+zR4TXypUQv82
         yELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776471; x=1784381271;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=86MXUuA8Vww5FfCovkUCtKUFxfQa1fFrzspvefGWXDQ=;
        b=qVgCIx5wdbH1FfK+QWQY3CmZObnFT/la+kVmm8zi5heGj6QjBjWqcI/dFG2XOfkxIs
         HUcKqdXU50qVgrN/IAr0DR41afLITGPkEvQw8KcF+74BObegs2uKLel2r5IumH9D2xTQ
         HWEFETSYKHnIOiO8FJKFGeiQjGuq/I3o7zO+wE8CY10vJFLYJQu8Ht1JFHD9NlzTJI1N
         /n0+87N7TFtb9IouB5nbNdOoHHh14zVpThqVVAZc71TtPPnEKFLlHeIv/3fNFlU6CAwM
         qNPIsbV1nvME2s5rJoIKRz7YWVs/PqU+t16qC/tq1XzCqTRZ5X6CfBs+jeR9oUumcBY4
         3srw==
X-Gm-Message-State: AOJu0Yx6Q/lNfgVnmsIHTir2dwm+cL0VoVZtJOKreSZxTxL4/jZK13q6
	aEnxN0ty9gBst38c/l4cueTvFfJhiK8jOoENZ83iwapkVS/IwsmLilHzMp+f/g==
X-Gm-Gg: AfdE7clGHLJiZDCQAxmBfRr08rXMbAwRh21t8GwPaC/hiVs+czwQSP3CMdH9Z7Ur/xi
	4tDiAnqwD8tzGrXeZhqf9ZLyx/JOb/cXbHGMMmE9h7iWCKS9LVz2ApeA3WQMu2MZ0tT3Y1ENcfR
	u1UOxKnSbv6+xkfsGQ+6BJM7ICL/Xqgx0F5sFspCLySEkZOhVEpCq0j1McxP7bYERpmc42AKJXS
	EOm2tFfDSwP7ypinj8AB1eB96+dnjim0oLKnLZ/Rgdnavqd6FcsiJdZTMWubBX9/QvZFV8OPbZC
	IXJxHtW+xs9wzwhSIot0qXUFcnAjVwG9RaRxpJcPir2uI90H/Z7OLTWMc/dCJvFjCe3YD09WTm4
	YZXysRpHEqtWQa72bW2yMUzc8XT0LEeJOL6m0jv3e8LbmArzIvi+pLDgGRx4YY+IfC+QgmiXzdB
	6qwfPD5v399WDnbhk=
X-Received: by 2002:a05:6a20:12d0:b0:3bd:3a53:c147 with SMTP id adf61e73a8af0-3c110b43718mr3364215637.45.1783776471424;
        Sat, 11 Jul 2026 06:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b9ca880fsm11419937eec.23.2026.07.11.06.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:27:49 -0700 (PDT)
Message-Id: <5ef4f08105bc5485444e824cec39e684692a9348.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:36 +0000
Subject: [PATCH v6 01/10] Documentation/technical: add paint-down-to-common
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a technical document describing the paint_down_to_common()
algorithm used for merge-base computation, covering the paint
walk, generation number regions, and termination conditions.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 175 ++++++++++++++++++
 commit-reach.c                                |   6 +-
 4 files changed, 182 insertions(+), 1 deletion(-)
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
index 0000000000..c203f14455
--- /dev/null
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -0,0 +1,175 @@
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
+threshold -- the minimum generation of the input commits. No merge
+base can have a generation below this threshold, so the walk
+terminates as soon as it dequeues such a commit.
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
index d7221fe389..778e11f5d3 100644
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

