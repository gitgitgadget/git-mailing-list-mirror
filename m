Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685B420476
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440538; cv=none; b=h3Sit+N7z8Ksn51S3bZMpWHe1fbAn63Xe374Aln4OPmNFlWQ6PJocszPNnorDIXJYw+5qZg+xW+iZ86gk01zqPH0KekAdm3u0ebvKsZ1o88y5V1KK3D4LnlCflQiXbkG+UibRsq+1iUMI7v7uKW9InKyDeG9caE05OZFKYoiOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440538; c=relaxed/simple;
	bh=X7I2oydYVW3F6LT93/nDNrsN2UUgn3160YdKyktxs0Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RwMUgL5mPb+cvu/qbOQtPU+Bwu/y9Lh1KcQMXD6zIh2jL4X6ZZ4fAUBgC1t6+ZJo2Ry5fmdjIP3XVBjTPwwffMXcrI0ucZc09waUvUr/tapO5HKzm2gZ5Zbn81QzeFmSifhxVOG0wjdbzJQgPog64xaiEtRCQWfs/yOyy+SpVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mExwh/p+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mExwh/p+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so675263a91.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440536; x=1787045336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xNnny1LSZ+qYQcaGmeX1B3QGk2kq73iLyFuLtFwte00=;
        b=mExwh/p+xnVp3SrXOQLE/YjQVfl7BzxkmI9YKWGXNbIeY0jKMp3Q0BEZJSxbs2ctIN
         dw3uW96n1S2eafJuFmZyVXTlYdslN6E10x1nepwQ2bgjLrKdXeDhSayiy6h1s/PPmRfX
         r5dqicwBwT3NBG9WOdAL9vL4EGiq4BTsp/qEEmM4azuIHnhwi7KzPTTdM+UXPrqAeTBD
         vnMWGgY9U7M1avCgft60vgVXvJaK7ulnZ0m6KsG1zL6jHE3Q6gzdmsPYdYDf+yOd2Fh6
         beTwZFaXdSc4nXUj2nGdvh6WlXcH5dbTXZCzmR36ZXVqyp4WURdSe8omRMwAv7VHdAdX
         +lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440536; x=1787045336;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNnny1LSZ+qYQcaGmeX1B3QGk2kq73iLyFuLtFwte00=;
        b=ltnUuj4ud4/iuBj8XGxThTNJ9qdbbmtVjzCWJ37FQX8cBILEmqcLZamLlZehSlHOXV
         805kgIrL4wN7G34YnKJA6UljRsYlMiqIUcRwZ+j7mKbJBSOeQ37/LGAKKqSa2FvGVXFD
         jemW5MuegoF2qU3+mB4veqcBmBmG18LAI28q0G/bVzLtA7t7sCUidn1O79wIXxDuxOMF
         khFgh2sd1RHrchldTtVVvCKulCmyheezOIpwFF0bvEm1G9F3fTSVQg0ohDV24yubtpP2
         OaGmSltQujHtxHSfjbuLxj8pbZOWafQuyJtu2DcNitkpPXKKhPHMzgHz0Ljd1wM2BYAb
         Fgng==
X-Gm-Message-State: AOJu0Yyw061/03D5ZCpPXd4pfrjYSxNv2evNA5CupAHJz3slemX31Oo6
	wpOeOhOCSFk3hhnFHz5CUaNLE3bICJbqPS43o7UBf/WgsPqMrLjY8WVP0PLilA==
X-Gm-Gg: AR+sD11lJeRZe7UYtN1XLbhHddAkKC+cFzZ9MsESwLozq9BxX89KHxGGDqkPe00G1mG
	QTFUDh08TQUSvQvQI9E1u1XphxG7FX3fOU4loEsgwyizpo2TFLf6cV0qzDL2H+eaF74CN7asKNJ
	rKmplRVNsMxw9qjoO1iQrlzicZvzhEulR9LdCP2iyRkHIhBF9xfaedOVz5+SVDS9lwA7K1LEwTy
	ImJ6xo/ixlcTurQNLn5zMXVZN07SoaTW5m5U4aSrWW7hh+6QX1pqBMjn3/w6oPOcIzINW8LOFB4
	rzqXnKXAFoJKp97MAotpzEmMJZ7KDFW81wTMBi+LD6x92biZMWHCiH/QMvworMLEvUjq37goHUp
	hMq5fvJncNel30d0GHK6WX2Y/oMwL99o84z9KC+K8mwNVrbING1aUCthfN2xdIJGKfWMopchjq7
	OwbHtRw3eIIwYcBQs6Yj5j1kYkLXng0ZOLya35pr64gr4SZv3x8XtsDqb++zfn27f9
X-Received: by 2002:a17:90b:134f:b0:380:86d8:8162 with SMTP id 98e67ed59e1d1-392ed1ebf73mr994554a91.18.1786440536301;
        Tue, 11 Aug 2026 02:28:56 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d537d905sm2953450a91.14.2026.08.11.02.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:28:55 -0700 (PDT)
Message-Id: <d74c9d578194f44cd662b69d05eadce42c474313.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:43 +0000
Subject: [PATCH v8 01/10] Documentation/technical: add paint-down-to-common
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
 .../technical/paint-down-to-common.adoc       | 174 ++++++++++++++++++
 commit-reach.c                                |   6 +-
 4 files changed, 181 insertions(+), 1 deletion(-)
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
index 0000000000..4bd3c2adb5
--- /dev/null
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -0,0 +1,174 @@
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
+the highest-priority commit and propagates its paint flags to its
+parents, enqueuing any parent that gained new flags. When a
+commit receives both PARENT1 and PARENT2, it is a merge-base
+candidate. A candidate gains the STALE flag so its ancestors
+propagate staleness -- any deeper common ancestor is necessarily
+redundant.
+
+[[generation-regions]]
+Topologically ordered and unordered generation regions
+------------------------------------------------------
+
+Commits fall into two regions based on whether their generation
+numbers provide a topological ordering guarantee:
+
+....
+    +------------------------------------------+
+    |          Unordered region                |
+    |  generation = INFINITY or V1_MAX         |
+    |  queue order: heuristic (commit date)    |
+    +------------------------------------------+
+                      |
+                      v
+    +------------------------------------------+
+    |          Ordered region                  |
+    |  generation = finite, unsaturated        |
+    |  queue order: topological                |
+    +------------------------------------------+
+....
+
+In the ordered region, a child's generation is strictly greater
+than its parent's. Same-generation commits are necessarily
+independent, so the queue always processes children before
+their parents.
+
+In the unordered region, parent-child pairs can share the same
+generation number, so topological order is not guaranteed. The
+queue uses commit-date as a heuristic, which typically produces
+a reasonable traversal order but may process a parent before
+its child.
+
+Commits not in the commit-graph have generation INFINITY; v1
+commit-graphs saturate at V1_MAX. Both place commits in the
+unordered region. Any optimization that depends on generation
+ordering must account for this saturation boundary.
+
+With generation ordering, values in the unordered region exceed
+those in the ordered region. The walk may therefore transition
+from the unordered region into the ordered region, but never in
+the reverse direction. Without a commit-graph, every commit has INFINITY
+and the walk operates entirely in the unordered region.
+
+In the ordered region, paint on a dequeued commit is final --
+no future step can add flags to it. In the unordered region,
+a dequeued commit may later gain additional paint. Paint flags
+are only added, never removed, bounding the number of
+re-enqueues per commit.
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
+     been found, and the walk has entered the ordered region.
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
+When only one merge base is needed and the walk is in the
+ordered region with generation ordering, the first candidate
+found is necessarily the highest-generation common ancestor.
+No remaining commit in the queue can be a descendant of this
+candidate (generation ordering guarantees children are visited
+first), so it cannot be redundant and the walk can stop
+immediately.
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
+(via generation numbers) is disabled. Topological levels are
+correct but unbalanced -- ordering by such generation numbers
+can sometimes cause the walk to detour too far before finding
+merge bases. Commit-date ordering typically reaches them in
+fewer steps -- see this change for more details:
+
+   091f4cf3 (commit: don't use generation numbers if not needed,
+   2018-08-30)
+
+With generation number v2 (corrected commit dates) we have the best
+of both worlds and do not need this fallback.
+
+For v1, `paint_down_to_common()` falls back to pure commit-date
+ordering via `compare_commits_by_commit_date`. Because commit
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

