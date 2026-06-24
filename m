Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B782594B9
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303260; cv=none; b=YQpCZD0h0GHuKNjCp5yan5xavnKYpeDN+CQXdcDY+ByQ5Wzz9XSPrsbRYo4XP1jKEXEjhgfR8uRRdBDTddsCKpwoXcngDe/6vl5tcfRTOrbs3wOOBbdpVHgGh1tl06YLaUQl1Ye7kP0IywKC/ptQ6jwTycBMntnqVlgY4FtuMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303260; c=relaxed/simple;
	bh=dR63eSWee6QM6AFxDKc9EsotT7DOCJIbKaNFdhJAG6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FbGr4ClPgLgGB0XzqYYdSZ8Xwc2b4EwTtThlAjVOkSK0t4YWQangIREOw5EMKZkssT4ca+N0QeudfJYWYDPJBO0evds1o0LHIvrmu5SY4q2uEAbP7EQRzRifztcmptKYNIVQrl+29h5nFTzGWqSeHZB0fGcx5RSAZbxIGJ+yRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icKmWe9i; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icKmWe9i"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5177945a279so7012131cf.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303258; x=1782908058; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVAkuNSa6NuBhbVHLflA5aobrLeeRfR8LBud2P0XpuQ=;
        b=icKmWe9iUabh52yIk9bTIsODsFgon71IuAOf4Oo4+i5+0V+YIqsJJkWfUQMnfqWfvs
         CSU/cOCBJMvEJahzcW69RO+kXA/dSLZ3jezdCtJunGJQ4BCRT6VAYdnknz+zG6bq40Fh
         emOMU5lMid9YCPmSusTfW1zcK7+NMGzvbSz7vYuNQ714HMkWg0yJLlW8ekJDLWN8oWwc
         8jg2xlMA3TOzN73Ul8FRm3nhg3cLONIvR/bHoOXDXuTO1zlODfnAb4jksoYv5fdmg9hw
         1MVUE6/oEZLvf8IxhrwnwxApOrMsgZHNEIsETvQF5jJ5KjIZ3r2C/cRrEK+X01ing8ta
         EaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303258; x=1782908058;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVAkuNSa6NuBhbVHLflA5aobrLeeRfR8LBud2P0XpuQ=;
        b=hjrOTcfG6mWVcp4AlHu30ApH/1R38mt+KkEc2Ol52zB7PQmzZw4wu60M1zRfYP48SK
         IWS/bXP5ALYSxJE1HVtB0NCPHxOX1HogZHyA8kZLl3MlRRz9vqFtbP6qOf6p6aRY6rPJ
         xKd9oXfY3h+IGkqzq9v+QKmC6dFr1XohaSO3CeOU1/AVBTCXgIwsZOETZjYp7MVjvQfb
         Jt90xxGiHWYUKT3bDEJvGbmy+wX9hBWuIQJzdhN/IThLjMcX+zOsvwvtYhHFvUfk55s8
         P0SbT+LrDzQhmx8puuMp51sYd9CkSrVVKD3QVjO5gVfbL+di8aolUAd+tfI2nwb5XPkK
         vI/g==
X-Gm-Message-State: AOJu0Yz2XQoo14Rm1DSDo4IzegEqP2pC7V4e+AjCp4mAL8SC71yIAifm
	qj6pBlI1Av/RQ+84m9Rp6TLEYKoigDdaJEJNJ8t/n497hK2vsX40YsZUdNi++g==
X-Gm-Gg: AfdE7ck6Y3Bxh0ciyx6p62WE9VefO4qw4VffqQNvD41evRvdRs+8d7w76/3RojqkYe0
	Tb9sb6SvxXXce89w5IhfFBrIfeBgSCEcuOpiV2NvAv9vPDfG/27kqzsZKGCUbmei8S1NNBYISVD
	B62QVZXpuegKe7eEihggmZ2NlG9QuLY0H/TdJuFtGObS2BA9PfXROGJnSjWsFpWoMk1QoANU80x
	hawyN7Bh8wcLRKvXU7ONyOmrTVgZD1oWrUL+2Q9PmDC5WbYpt9tnVcXoJVV6gFOgqqxCvZCABlo
	hZbrrJ/ajHCcMOiFzpcQs9JCslMisZM/WqphZy+NTBHyG043wQo5GFWCphTOs0PU/HMJGjVmKaI
	+nZIVpcsQS2CWoNl/s/ezlWmleRg1hvO1pHwnxCUksdurhVZfn5xaNamm3IbNi5E8CiQTvggTyE
	uQukm0K/6u0CYTpWM=
X-Received: by 2002:ac8:5996:0:b0:516:d95f:bf33 with SMTP id d75a77b69052e-51a61f5d20emr45471531cf.50.1782303257861;
        Wed, 24 Jun 2026 05:14:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.92.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51abc1e9sm46983641cf.21.2026.06.24.05.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:14:17 -0700 (PDT)
Message-Id: <19ed743bd10be5341eee040eb8070876b984773d.1782303254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 12:14:07 +0000
Subject: [PATCH v2 1/7] Documentation/technical: add paint-down-to-common doc
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
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a technical document describing the paint_down_to_common()
algorithm used for merge-base computation, covering the paint
walk, generation number regions, and termination conditions.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 114 ++++++++++++++++++
 commit-reach.c                                |   6 +-
 4 files changed, 121 insertions(+), 1 deletion(-)
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
index 0000000000..c10d5d2887
--- /dev/null
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -0,0 +1,114 @@
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
+The walk uses a priority queue ordered by generation number (falling
+back to commit date when generation numbers are unavailable). Each
+step dequeues the highest-priority commit (this is when we say a
+commit is "visited") and propagates its paint flags to its parents,
+enqueuing them if they gained new flags. When a commit receives
+both PARENT1 and PARENT2, it is a merge-base candidate. A candidate
+gains the STALE flag so its ancestors propagate staleness -- any
+deeper common ancestor is necessarily redundant.
+
+INFINITY and finite generation regions
+--------------------------------------
+
+The commit-graph stores a generation number for each commit. Commits
+not in the commit-graph have generation `GENERATION_NUMBER_INFINITY`. The
+graph is closed under reachability: if a commit is in the graph, all
+its ancestors are too. This partitions the commit graph into two regions:
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
+Related documentation
+---------------------
+
+  - `Documentation/technical/commit-graph.adoc` -- generation numbers
+    and the reachability closure property.
diff --git a/commit-reach.c b/commit-reach.c
index 5df471a313..a9483759e0 100644
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

