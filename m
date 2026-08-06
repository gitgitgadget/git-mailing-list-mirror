Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835944606D
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014013; cv=none; b=TC4JSP35r17xq/edOdVvwfb4KbdxwEgehZW5qj7GRakDXxIR0Kj18mhQfEw2uzfvKsxGvFFBA/Fvj73lr2D0RrQLvH4Ky/puPGFo1pqa1e7ZmIDiAR59o9NSa5DFJh246WavNVrhCe+dFqD2MPHAoQZbcPYFQ7PMIfzj3nUeIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014013; c=relaxed/simple;
	bh=Xnjpxpgu88udi8hn+h7oz/MWwj6Hpnr52/Yc5YPPVtI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cVVlTc6hYGf2SoaIxlGtx+cRRZAVnwciil2vQ4aQsiPj/VL6fjAGzevxQWq+2SDbT+vo42aVxwnFMemzDJWLNx68vCGYhCRvB1hjoxXgVjv3uIZKhLeqkczo1hNBkFMSn9UjeSXjj5bCwa86+bCybuHFEJO9U8Ukn5sOwMcLFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZT1KnuT; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZT1KnuT"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ee6b2da98so30265977b3.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014011; x=1786618811; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N6eiLRkIurTjou4bYOeKv0M8weqEGsLKcqHQ6hcjwio=;
        b=gZT1KnuTigQKSbp/1jlnoNr908Eyqyh+2jd5qklxvYx99JoLpXw9E7ZjdKpRww+1ou
         r1vLgRsdasbNgSyZlhNbpYE5CUeEsWzI+bijkWwrr5CrlGYH2pvBEaX8aRbc2KWM48LR
         OBxl/37HEf8bO+yEHwAXI2ZHXDOgINIMX36M2XXYyXPuq7359FAOPN2rTEKP7KYZRZY5
         seoeVONe5iZOGMAQNZqbs6pH/P9xeSrw58posGDPpoAwIis4oAmgFBRTsqnQ7trwJVgi
         /oZHDncJ8capiBacXpf0qkMoIW7CiHTl5GoZozrF/SDecPblnc1m1I8X5haP84Ej7OSS
         hH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014011; x=1786618811;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6eiLRkIurTjou4bYOeKv0M8weqEGsLKcqHQ6hcjwio=;
        b=PbHvBI6fwqbIh5A7w3t70MD3SReGFEI7QBFg/c8t0zI/yMWScRl1I1BX7J0LKAzIPp
         rqBZHsN4/DIxOi4kUKGKAFT5d+1MpnkQIFxmOCYeezIPgP1Kr9VUV31QtfC3YhqbyMqV
         IWUap2skPL2Yq5NHSJgG00lo/aYQ/gADaPMfLGWjxDR0wHAneGR/7rFue3XINL0bra1S
         apNSBhUMqGVelNXC3EWke8NAlMBbH3+1GQKUg8BaOWeibNyfQhvzR1Jtr5O9JvpoPfUN
         TuTsmHpUj1E2eXpXhzmhY1TJ0hcdQjNupnJviHuJbJ7F2cBtqGDimbgJfmk2B7Vu3WCY
         Qdog==
X-Gm-Message-State: AOJu0YzxZvCwbjiFar9Z8CovbR4ScDSfyYntD1sU2c6ULd/7yudgOwdY
	rcETgpJLROEedcCSc9euJyiyvkokObil3vgelQGpg/aJOiLw8A6Rouspn0saBA==
X-Gm-Gg: AR+sD13jaN0fcdVqmeqtGLIbRDRc6ccHhyGVMCCcZpOo6eX0XwvPB1nimz7RTDdSq65
	J7mD7JuWdpForxQPlzFNp/hixcv8MP+8QqqofcskDm59Nadxs9IGJU0cDJFma3aG3y1lyeVLGta
	CmdPqRNyrD6DbVxpQIm+aNfVyzXAcWpI6JqIaPcR0XKIVkHFoaGJhLxUDupuhWAKZA1ldvzP+pm
	UB4OeKuA4AyWDw5+ZbOemSSAbogUnSPXdRJ+cOwu6GXKnm0tynmzkxQQfZTPIyrR8VhiP9w+Jrx
	vcEV524uI5nf+FRXLTCVp6CTeso1wbd0X747gGvkuGWaTdkcf2FOWRPsRkHWE0q0zrW72b6d0Y7
	l0XuBEVLTSVq4WgeuNGT2MJpLNNvBYiDtPsPCq2WSBdT/r4ZRhwXUAuHYJifxz6AGSGkI21y568
	InUdNBoGHCB+Co+dkIEBTe0jttZ0FrWkB1scYGeKvl+M76oDvRGNOcc2YVtcKhqcs=
X-Received: by 2002:a05:690c:6a0b:b0:81e:fe1c:2de8 with SMTP id 00721157ae682-8201bccfb48mr87415277b3.3.1786014010652;
        Thu, 06 Aug 2026 04:00:10 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8210f9f94b1sm17049237b3.22.2026.08.06.04.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:00:09 -0700 (PDT)
Message-Id: <b655b24dc0bedbe8803da87e977684217f7d1f69.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:41 +0000
Subject: [PATCH v7 10/10] commit-reach: remove commit-date ordering fallback
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

Remove the fallback that switched paint_down_to_common() from
generation ordering to commit-date ordering when the commit-graph
lacks corrected commit dates (v1 graph with topo levels only).

The fallback was added in 091f4cf3 (commit: don't use generation
numbers if not needed, 2018-08-30) to avoid a performance
regression on the Linux kernel repo where v1 topo levels caused
"git merge-base v4.8 v4.9" to walk 636k commits instead of 167k.
A side branch with a low topo level stayed in the queue behind a
long chain, preventing early STALE propagation.

Side-exhaustion (added in the previous commits) solves this
differently by terminating the walk as soon as one paint side
empties from the queue, preventing the deep walk regardless of
queue ordering. Benchmarks of "git merge-base --all v4.8 v4.9"
on the Linux kernel repo show that side-exhaustion reduces the
step count far below what the date-ordering fallback achieved:

                         steps      time
  no graph, baseline:   167,413    3.25 s
  v1 graph, baseline:   167,413    0.25 s
  v2 graph, baseline:   167,441    0.29 s
  v1 graph, this series:  5,725    0.02 s
  v2 graph, this series:  3,887    0.01 s

With generation ordering always active, the existing min_generation
check in paint_queue_get() correctly identifies when the walk has
reached the finite generation region. The date ordering fallback
broke this invariant: a commit could have a finite topo level
while the queue was date-ordered, causing the early exit to fire
before all merge bases were found.

For v1 commit-graphs where generation numbers saturate at
GENERATION_NUMBER_V1_MAX, introduce a topological ceiling that
the early exit gates compare against instead of
GENERATION_NUMBER_INFINITY. This ensures saturated commits are
treated as unordered, preventing premature termination when
generation values are unreliable.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       | 51 +++----------------
 commit-reach.c                                | 23 +++++----
 t/t6600-test-reach.sh                         | 23 ++++-----
 3 files changed, 27 insertions(+), 70 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 7c93f7e676..bdd5ffb5c3 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -44,10 +44,6 @@ ancestor is necessarily redundant.
 INFINITY and finite generation regions
 --------------------------------------
 
-The properties in this section assume generation-number ordering (the
-default comparator). They do NOT hold when the date-ordering fallback
-is active -- see <<date-ordering-fallback>>.
-
 The commit-graph stores a generation number for each commit.
 Commits not in the commit-graph have generation
 `GENERATION_NUMBER_INFINITY`. The graph is closed under
@@ -91,10 +87,12 @@ traversal: children are always visited before their parents. This
 means that paint on already-visited commits is final -- no future
 traversal step can add paint to them.
 
-In the INFINITY region, commit-date ordering can violate this: a
-parent with a later date can be visited before a child with an earlier
-date. Paint flags are therefore NOT final at visit time, and a
-commit visited with only one side's paint may later gain the other.
+In the INFINITY region, all commits share the same generation
+value, so the queue breaks ties by commit date. This can violate
+topological ordering: a parent with a later date can be visited
+before a child with an earlier date. Paint flags are therefore
+NOT final at visit time, and a commit visited with only one
+side's paint may later gain the other.
 
 Paint flags are only added, never removed. Since each flag can be set
 at most once per commit, the number of times a commit can be
@@ -159,43 +157,6 @@ descendant of this candidate (generation ordering guarantees
 children are visited first), so it cannot be redundant and the walk
 can stop immediately.
 
-This optimization is NOT safe when the date-ordering fallback is
-active, because commit-date order can visit a deeper ancestor
-before a shallower one -- see <<date-ordering-fallback>>.
-
-[[date-ordering-fallback]]
-Date-ordering fallback
-----------------------
-
-When the commit-graph has generation numbers v1 and no
-generation floor is specified, topological ordering
-(via generation numbers) is disabled.  Topological levels are
-correct but unbalanced -- ordering by such generation numbers
-can sometimes cause the walk to detour too far before finding
-merge bases.  Commit-date ordering typically reaches them in
-fewer steps -- see this change for more details:
-
-   091f4cf3 (commit: don't use generation numbers if not needed,
-   2018-08-30)
-
-With generation number v2 (corrected commit dates) we have the best
-of both worlds and do not need this fallback.
-
-For v1, `paint_down_to_common()` falls back to pure commit-date
-ordering via `compare_commits_by_commit_date`.  Because commit
-dates are not monotonic (clock skew, rebases, etc.), the queue
-may visit commits out of topological order.
-
-This disables the optimizations that depend on generation ordering:
-
-  - *Single result*: the first merge-base candidate found may not
-    be the shallowest, because a deeper ancestor with a higher
-    commit date can be dequeued first.
-
-  - *Side exhaustion*: one paint side can appear to drain from the
-    queue while commits from that side are still waiting with lower
-    dates, causing premature termination.
-
 Related documentation
 ---------------------
 
diff --git a/commit-reach.c b/commit-reach.c
index b50b0e4e47..85bda146e6 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -89,9 +89,9 @@ struct paint_state {
 	size_t parent1_count;
 	size_t parent2_count;
 	size_t mb_candidate_count;
-	int gen_ordered;
 	timestamp_t min_generation;
 	timestamp_t last_gen;
+	timestamp_t topo_ceiling;
 };
 
 static void paint_count_update(struct paint_state *state,
@@ -166,8 +166,7 @@ static struct commit *paint_queue_get(struct paint_state *state)
 
 		/* one side is exhausted */
 		if ((!state->parent1_count || !state->parent2_count) &&
-		    state->gen_ordered &&
-		    generation < GENERATION_NUMBER_INFINITY)
+		    generation < state->topo_ceiling)
 			return NULL;
 	}
 
@@ -187,9 +186,13 @@ static int paint_down_to_common(struct repository *r,
 				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
+	/*
+	 * Generation ordering is required for the side-exhaustion and
+	 * single-result early exits, which rely on topological traversal
+	 * order (children visited before parents) in the finite region.
+	 */
 	struct paint_state state = {
-		.queue = { compare_commits_by_gen_then_commit_date },
-		.gen_ordered = 1,
+		.queue = { compare_commits_by_gen_then_commit_date }
 	};
 	struct commit *commit;
 	int i;
@@ -198,10 +201,9 @@ static int paint_down_to_common(struct repository *r,
 
 	state.min_generation = min_generation;
 	state.last_gen = GENERATION_NUMBER_INFINITY;
-	if (!min_generation && !corrected_commit_dates_enabled(r)) {
-		state.queue.compare = compare_commits_by_commit_date;
-		state.gen_ordered = 0;
-	}
+	state.topo_ceiling = corrected_commit_dates_enabled(r)
+		? GENERATION_NUMBER_INFINITY
+		: GENERATION_NUMBER_V1_MAX;
 
 	one->object.flags |= PARENT1;
 	if (!n) {
@@ -229,8 +231,7 @@ static int paint_down_to_common(struct repository *r,
 				 * descendant of this one.
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
-				    state.gen_ordered &&
-				    state.last_gen < GENERATION_NUMBER_INFINITY)
+				    state.last_gen < state.topo_ceiling)
 					break;
 			}
 			/* Mark parents of a found merge stale */
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 6bf17cb7b6..445449a458 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -381,7 +381,7 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		git rev-parse pi-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 5 4 5 5
+	test_paint_down_steps 5 4 5 4
 '
 
 test_expect_success 'setup mixed finite/INFINITY topology' '
@@ -414,31 +414,26 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	>input &&
 	git rev-parse commit-9-1 >expect &&
 	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
-	test_paint_down_steps 81 9 57 81
+	test_paint_down_steps 81 9 57 37
 '
 
 test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
-	# Verify correct merge base under clock skew.  se-D (the
-	# merge base) has a higher date than its child se-C.
-	# Generation ordering ensures se-C is visited before se-D,
-	# so P1 paint propagates correctly and se-D is found.
+	# Verify that the merge base is computed correctly even
+	# when commits have non-monotonic commit dates.
 	>input &&
 	git rev-parse se-D >expect &&
 	run_all_modes git merge-base --all se-A se-B &&
-	test_paint_down_steps 6 4 6 6
+	test_paint_down_steps 6 4 6 4
 '
 
 test_expect_success 'merge-base --all with clock skew and redundant ancestor (side-exhaustion)' '
-	# Verify correct merge base when clock skew could cause a
-	# too-deep result.  MB1 is the correct merge base; MB2 is
-	# its ancestor.  A reaches MB2 via E (high date) and MB1
-	# via C (low date).  Generation ordering ensures C is
-	# visited before side-exhaustion fires, so MB1 is found
-	# and remove_redundant correctly discards MB2.
+	# Verify that the correct merge base is found even when
+	# non-monotonic commit dates could cause a redundant
+	# ancestor to be visited first.
 	>input &&
 	git rev-parse se2-MB1 >expect &&
 	run_all_modes git merge-base --all se2-A se2-B &&
-	test_paint_down_steps 8 6 8 8
+	test_paint_down_steps 8 6 8 6
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget
