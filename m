Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C0448CF5
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014007; cv=none; b=fzZq279QRwz7otc6M3ARdfp7rCJ3+sN+PwNkNu3Z75MfQZfbgruWgjxQtTn+gSzbToypsEuRz8pWCzoWTUFxXjRq8mA6AWfC6gkG8QIl0gi27M5F6XWa/HkHE68TbRkwdQKIAHFcJWEyDWBiwlkpAl/UtoLHxJJJ3MLiMttt7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014007; c=relaxed/simple;
	bh=ktDUkSqmmdA5Phyz9LbjF4aK/FXaJ0skMeFsxs2/Ejc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S13XDZvQkXXq04tbPP0+Iv5wAr3qzPhoGGpDxVaB1LpW2/MKIYn5+7e+DL0hNSvbKpLF2rbECDOPPyyhZ7FqFXE78lDIvdP3VyBZXsylTksNxQ0mq2ShyPpNmbfrW3wC0SlI3sYo5+9ShCpDp8dkzcRNE4VHp2RIFwyKMf9uDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zoj53EVV; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zoj53EVV"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-669944f60b3so2497614d50.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014005; x=1786618805; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u6w8hI3XzFgiC4hYsq9eK3gtrlt4cAJCiAjutb067zE=;
        b=Zoj53EVVKD7kAwXW2plLDo16GB2uwMPaAA3LzJQ+Zizp/AH2h5zEfMfLQOCdTnHMfq
         6WErv/dOg1MRSg7hK16MOj1ZkmWYYFNcZRd5+qUp6A2DbPoI3Rz6ERf4gFaDQHwSqAFN
         Mwx2pX4V+7zkbVw1GVziBV+GobNqcziBcuq0MM2z8+N2BxtuIzD3bD4bji7cj5SPc+xS
         /zY7zdzQUj0z+YsilbEe2jy9es9Cj6q0o+YstQqd76iEeC9isR0yj5s8eVUBMPvNfFZH
         TA4+6WZyNNZB1eJIZuaXWFVGffmEZBYZm0ToQ3SzwlI/VmwEb5oIfBuTsS6m+40gBAIs
         jsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014005; x=1786618805;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6w8hI3XzFgiC4hYsq9eK3gtrlt4cAJCiAjutb067zE=;
        b=G8+rbd1QDC++6oBv259DfldrS1SfEP+4DAKCnFbe0Xyb/xABssHWI5dXcPNlTvgg5M
         4S4sgc925Z/9xoAtPccU3tH92yKN4R9tGwQMDi3Q5fGZQQY2gMbIM2/IUxl8dkHljkEi
         xVbd/eMVz254sLUPBxugQay1qdeFGghoo52EuITDwrTnUGVDZiqaiTwkZjICjddmpwVT
         mACJe0R7kqKQ9eCc6Rh5h1vlhbRswChx+jPeo5d9oJR2KO8f4XV5Vqs7OucKvmPjxSyu
         QSYyx4o9cZdczl5mIyxCSHdw3ThKPx0+xH5OZYa0WTuYIjUTa1gURPCyNspkABFvNhM1
         BOdA==
X-Gm-Message-State: AOJu0YzK+TJSS+UxizaFtBAOcIlZjan3nc6YMM8ac9jm6XjP7IvVYhyQ
	RlHYbIw0Aakxn+Mrs9RmCD5vzC3rwCwjTx3dj1P7y3uNH904Qr5yIHZMbI/xQQ==
X-Gm-Gg: AR+sD10wXY/5fXJJfeVCT+GYj0owPb0Ayc6qbg4ebW97Xr6MMTBXtEWQOuTJdv1TYoA
	9eOIHRBBYVBMT7oHWoY4Coks/k21qpzN6NZ8whcDZOIpq26HFIC7cSKd399FJgj2gdt+gQ7jUXB
	hwr44TOCRI3+sSa6PB9F9LAgDygPCxdpL4p8VbBxAIXT8ZYLmDBLwrVKLMIwnZQ+mEnYHjNLosy
	VQKNQyyfsJcaJw5Y0UZ/3FN4KL8oaJ3GKDOKpiepMt8Z2qdr2JIXO6DAumWHTsElj3dnF9BR3SY
	NCuEC/DVlEa21VWum9b8oad2OXbOfsqK1O6NHWj/y4YnWiR1BbHwIdLqDRVtavYkG2f90nSo4E4
	6bpA3jXvGf3V6azukHXI/5cGVVGjtYW37TKV0pabjzL6mxOH2gm9RkUZ0w3vpiZDnZPzbfIkXht
	a1td/fshUk/9wPwhFCf0dMuDKrxlP86BwHgaQmt6/WJHkdi1+LGF5hn3LT88hUCVY=
X-Received: by 2002:a53:d590:0:b0:664:ce2f:faba with SMTP id 956f58d0204a3-6699a91bf8emr5892591d50.3.1786014004743;
        Thu, 06 Aug 2026 04:00:04 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669913d50ccsm4759794d50.9.2026.08.06.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:00:03 -0700 (PDT)
Message-Id: <a1c8e89ef9f1d0fb5cb10ec9687633df8792ec7b.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:38 +0000
Subject: [PATCH v7 07/10] commit-reach: introduce struct paint_state with
 per-side counters
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

Add a paint_state struct for use by paint_down_to_common() that
wraps a prio_queue with per-side commit counters. Each non-stale
queued commit occupies exactly one counter bucket based on its
paint flags: PARENT1-only, PARENT2-only, or both sides (a pending
merge-base candidate).

The counters are maintained by paint_count_update() which adjusts
the appropriate bucket by a signed delta. An exhaustive switch on
the paint+stale bits documents all valid flag combinations in one
place.

Convert paint_down_to_common() to use paint_state. The loop now
drains the queue via paint_queue_get() which returns NULL when all
counters reach zero, replacing the old pointer-based termination
(max_nonstale). This is equivalent behavior -- both conditions
detect that no non-stale entries remain.

paint_queue_get() uses a "pop first" form: it dequeues a commit,
then checks the counters. This means the loop exits one iteration
earlier than the old code in some topologies (the popped stale
commit is never processed), so a few step counts drop by one.

The existing nonstale_queue is left in place for ahead_behind(),
though nonstale_queue_put_dedup() and nonstale_queue_get_dedup()
became unused and are removed.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       |   9 +-
 commit-reach.c                                | 103 +++++++++++++-----
 t/t6600-test-reach.sh                         |   6 +-
 3 files changed, 82 insertions(+), 36 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index cea0cc2f91..37fa6f93c1 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -103,15 +103,12 @@ re-enqueued is bounded by the number of flag transitions.
 Termination
 -----------
 
-The walk uses a `nonstale_queue` wrapper around `prio_queue` that
-tracks `max_nonstale`: the lowest-priority non-stale commit enqueued
-so far. Once that commit is dequeued, every remaining entry is known
-to be STALE and the loop terminates. Specifically, the main loop
+The walk tracks the number of commits of each type in the queue
+(PARENT1-only, PARENT2-only, pending merge-base). The main loop
 ends when one of the following conditions holds:
 
   1. The queue is empty.
-  2. `max_nonstale` has been dequeued, meaning the queue only contains
-     STALE entries.
+  2. The queue contains only stale entries.
   3. Generation cutoff: the dequeued commit's generation is below
      a caller-supplied `min_generation` threshold.
   4. Single result: the caller only needs one merge base, one has
diff --git a/commit-reach.c b/commit-reach.c
index d59e76a2e2..a62b5e4624 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -79,21 +79,73 @@ static void clear_nonstale_queue(struct nonstale_queue *queue)
 	queue->max_nonstale = NULL;
 }
 
-static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
-				     struct commit *c)
+/*
+ * Priority queue with per-side commit counters for paint_down_to_common().
+ * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
+ * PARENT2-only, or both (a pending merge-base candidate).
+ */
+struct paint_state {
+	struct prio_queue queue;
+	size_t parent1_count;
+	size_t parent2_count;
+	size_t mb_candidate_count;
+	int gen_ordered;
+};
+
+static void paint_count_update(struct paint_state *state,
+			       unsigned flags, int delta)
 {
-	if (c->object.flags & ENQUEUED)
-		return;
-	c->object.flags |= ENQUEUED;
-	nonstale_queue_put(queue, c);
+	switch (flags & (PARENT1 | PARENT2 | STALE)) {
+	case PARENT1:
+		state->parent1_count += delta;
+		break;
+
+	case PARENT2:
+		state->parent2_count += delta;
+		break;
+
+	case PARENT1 | PARENT2:
+		state->mb_candidate_count += delta;
+		break;
+
+	case PARENT1 | PARENT2 | STALE:
+		break;
+
+	default:
+		BUG("unexpected paint state");
+	}
+}
+
+static void paint_queue_put(struct paint_state *state,
+			    struct commit *c, unsigned add_flags)
+{
+	unsigned old_flags = c->object.flags;
+	c->object.flags |= add_flags;
+
+	if (old_flags & ENQUEUED) {
+		paint_count_update(state, old_flags, -1);
+		paint_count_update(state, c->object.flags, 1);
+	} else {
+		c->object.flags |= ENQUEUED;
+		prio_queue_put(&state->queue, c);
+		paint_count_update(state, c->object.flags, 1);
+	}
 }
 
-static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
+static struct commit *paint_queue_get(struct paint_state *state)
 {
-	struct commit *commit = nonstale_queue_get(queue);
+	struct commit *commit = prio_queue_get(&state->queue);
+
+	if (!commit)
+		return NULL;
+
+	commit->object.flags &= ~ENQUEUED;
+
+	if (!state->parent1_count && !state->parent2_count &&
+	    !state->mb_candidate_count)
+		return NULL;
 
-	if (commit)
-		commit->object.flags &= ~ENQUEUED;
+	paint_count_update(state, commit->object.flags, -1);
 	return commit;
 }
 
@@ -109,18 +161,19 @@ static int paint_down_to_common(struct repository *r,
 				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
-	struct nonstale_queue queue = {
-		{ compare_commits_by_gen_then_commit_date }
+	struct paint_state state = {
+		.queue = { compare_commits_by_gen_then_commit_date },
+		.gen_ordered = 1,
 	};
+	struct commit *commit;
 	int i;
-	int gen_ordered = 1;
 	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
 	if (!min_generation && !corrected_commit_dates_enabled(r)) {
-		queue.pq.compare = compare_commits_by_commit_date;
-		gen_ordered = 0;
+		state.queue.compare = compare_commits_by_commit_date;
+		state.gen_ordered = 0;
 	}
 
 	one->object.flags |= PARENT1;
@@ -128,15 +181,12 @@ static int paint_down_to_common(struct repository *r,
 		commit_list_append(one, result);
 		return 0;
 	}
-	nonstale_queue_put_dedup(&queue, one);
+	paint_queue_put(&state, one, 0);
 
-	for (i = 0; i < n; i++) {
-		twos[i]->object.flags |= PARENT2;
-		nonstale_queue_put_dedup(&queue, twos[i]);
-	}
+	for (i = 0; i < n; i++)
+		paint_queue_put(&state, twos[i], PARENT2);
 
-	while (queue.max_nonstale) {
-		struct commit *commit = nonstale_queue_get_dedup(&queue);
+	while ((commit = paint_queue_get(&state))) {
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
@@ -162,7 +212,7 @@ static int paint_down_to_common(struct repository *r,
 				 * descendant of this one.
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
-				    gen_ordered &&
+				    state.gen_ordered &&
 				    generation < GENERATION_NUMBER_INFINITY)
 					break;
 			}
@@ -176,7 +226,7 @@ static int paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
-				clear_nonstale_queue(&queue);
+				clear_prio_queue(&state.queue);
 				commit_list_free(*result);
 				*result = NULL;
 				/*
@@ -191,12 +241,11 @@ static int paint_down_to_common(struct repository *r,
 				return error(_("could not parse commit %s"),
 					     oid_to_hex(&p->object.oid));
 			}
-			p->object.flags |= flags;
-			nonstale_queue_put_dedup(&queue, p);
+			paint_queue_put(&state, p, flags);
 		}
 	}
 
-	clear_nonstale_queue(&queue);
+	clear_prio_queue(&state.queue);
 	trace2_data_intmax("paint_down_to_common", r,
 			   "steps", steps);
 	commit_list_sort_by_date(result);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 55aa220bb3..f9895f5fd7 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -366,7 +366,7 @@ test_expect_success 'get_merge_bases_many:pending-stale' '
 		git rev-parse ps-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 6 6 6 6
+	test_paint_down_steps 5 5 5 5
 '
 
 test_expect_success 'get_merge_bases_many:infinity-both-sides' '
@@ -381,7 +381,7 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		git rev-parse pi-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 5 5 5 5
+	test_paint_down_steps 5 4 5 5
 '
 
 test_expect_success 'setup mixed finite/INFINITY topology' '
@@ -438,7 +438,7 @@ test_expect_success 'merge-base --all with clock skew and redundant ancestor (si
 	>input &&
 	git rev-parse se2-MB1 >expect &&
 	run_all_modes git merge-base --all se2-A se2-B &&
-	test_paint_down_steps 8 7 8 8
+	test_paint_down_steps 8 6 8 8
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget

