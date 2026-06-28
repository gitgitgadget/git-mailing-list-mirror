Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C53A16BA
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649555; cv=none; b=rwKE5DgAb8YDS4ICYI3hTAz/SxXDHISltoaRMrTc04AUIxoNh/cwyufB8HhbgIPNmn2Cg8gFS2HouxQ/OZ271nIDRYW+Mj/qo72XEh0CCcCbLsUVKCr/icpVpOzIzi7OWPr0pa7X2WJvWMLG1r/evnrA7SwreIyn2gq9OHSibLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649555; c=relaxed/simple;
	bh=lIqMNB4uz/3PD5WCByzTJWsSuYYKtUvhnU/2eNGEmbo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jHRXznr1S1K70cO4lqGkqwVQRF1TZnR7nLRbSatTZBWmbOMFCjRMos7LVaQ9zhIblpH8wHV4uXJlNBjGMaYRtMGb9fUEKMb0pUrT2NHHsKlGunGR0F3cffuifaFAXq/7GoHXBU/s4sOvkjeg7bUZe9VKT9pnMUwqA+930jpXR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2zwznOI; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2zwznOI"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51bf2479349so4543621cf.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782649553; x=1783254353; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfKGBoHJtpqmg720kRIPFjmDel3hmC/p1JUTmg/9+bE=;
        b=C2zwznOIqE0yqf8klI2u/YPKgGuHSdDSEuixLYi9UXfOBIlugeGEfQCPxmi5TV3GZd
         g0MBwslIMqf07B2pYFS8+ygZ0Ab05VKccEA676FgVzzZNVWX55BbrymG79Qq3TG3qQA1
         xHKEm2w3GAU50m5spuR16oQB63/vB+/haCsZBzx0SNvRgqiu7TrcAhcnB3NXMu4gvpio
         dOCyrfRuePShm4HL35XGFwKfleTMdNOJU37ZRtstPLilFvjVbnY4bUsM8CMclIS8odWQ
         CJkB/M6RT7bn+JjNxLLNAbsQ05mKm5rviCp5tKWSa0XFwMjR9kfS1LByFy5IgFBkdnln
         SbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649553; x=1783254353;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NfKGBoHJtpqmg720kRIPFjmDel3hmC/p1JUTmg/9+bE=;
        b=goyLbNCCl4mryNYajRkNwyG61ZkPzAUY4DewYydBNzA+Y79ePUN9TlpSnTElVDo1a1
         9DnStAb2RF8LeYs0VDjH8VArn+3VGWvbiVSiZGTl69rWu20BuILnUyB/fub/joljxWFu
         dhbeidQFf/ciZcfC85i13SOIQlNZfMeMrah/1Q6a6wCCqZpDc76J9PDtUHe0PY4ATf51
         ctyXRPPTfgfJ8gaQEzTaePpri2ft+41kagJQajVDOjC7SqvqhmldUxfWxRWaB1CgbZJD
         Jli6Z9IIGat6PoEl7qgKUfjIv288Ieq+3ObM61qUEnn/+2Tx9WU0nBLCiPvHZ4RTVD6Y
         ZhLQ==
X-Gm-Message-State: AOJu0Yx6EZB/IpFGbm2imYpwnq2pjfq2znkOfY7WQ8+lrlWr0lrMkIz6
	NjkPuR8Bk+i4KySKpuR38BBcAG9EH46crxJIgLmFtVIw4jmT+hUMb+oZXhb9Dg==
X-Gm-Gg: AfdE7clf72vJR+rB1tNUCVxdQ6lzJEXga83BvhoQNFB336kiJJ3MaYhQsjGCWIslx6F
	eUyX8WCHjl39kAgMd0/kIKbeoy9eylGSUlQYKAjVONuQ9wgOjJZGQjRn3DoycKA9xuaB91LLyhu
	5yuE4gkRlfdieJe1P1r+0QWjEC1zsjTuah4zZ0MUnn+zq3X8FXhdRW82eXLnClM4FmMC5VQQ2D0
	YMqwMuKJsHhOf8Yl/o3zW8jA8Z/1wPpPS1ZMLuT4V2zABnhMdGGYhF7kRg9zMsHs/6JMBxnAuhB
	jTzLzgs1F6NV7YUtROMSc5gGu50q87Na26NDjIcfwXqsbiZd/4lMCW+jk32TKaq65NSEXrDjMfI
	CxCGA/pqV7z8A/AsdsyMhfNJMrJu5/6cbs3uC/v9iYXJOBm+FmUsk8lAo7F+5n8zQnczz9Xg5XM
	7X3D633Exf8mTxvHNB
X-Received: by 2002:ac8:7e8d:0:b0:51a:8c9c:7f3d with SMTP id d75a77b69052e-51a8c9c83e1mr88749121cf.64.1782649552972;
        Sun, 28 Jun 2026 05:25:52 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a6e7669ebsm91963151cf.12.2026.06.28.05.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:25:51 -0700 (PDT)
Message-Id: <3efb095b0345a16f3478003d88a0b633830b2dc1.1782649547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
	<pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 12:25:39 +0000
Subject: [PATCH v4 1/8] Documentation/technical: add paint-down-to-common doc
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
 .../technical/paint-down-to-common.adoc       | 135 ++++++++++++++++++
 commit-reach.c                                |   6 +-
 4 files changed, 142 insertions(+), 1 deletion(-)
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
index 0000000000..a4dfcba038
--- /dev/null
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -0,0 +1,135 @@
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
+When only one merge base is needed and the walk is in the
+finite-generation region, the first candidate found is necessarily
+the highest-generation common ancestor. No remaining commit in the
+queue can be a descendant of this candidate (generation ordering
+guarantees children are visited first), so it cannot be redundant
+and the walk can stop immediately.
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

