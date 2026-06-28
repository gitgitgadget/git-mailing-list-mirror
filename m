Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0F3A48DF
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649564; cv=none; b=fBbvkmVDZzH3d7MSC84ii2ymEB1dEQYqm0+3kjb3bxpBslUm6bYZa6P+HEH8T/9OY1M3r0AlkWTLfA3nwb0Y1lQeG0NnzF/VeTGaGcuJ8+o+3TTMrnhfwJx2H9JVLERnqanYR/Ma1x/5QjYBaKfZBgeZ8FLnSE/V4R+yrn0CcnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649564; c=relaxed/simple;
	bh=CeX+AiYf8NcQEOYSZOmw5i6PIXTy/D2TDVF/LtD/puA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aim1Lg0ScprqCzGgA14q+kv5tIlYjUF7uF5t+gqumb8Cma78cRSlGqGbPM7nMT+QEUXhoWKYEXZl1Wo4K8mKAQ9Yeut46lHawvj0YZ+4uBg46CBRLjLbCKNWGYHoWtjdhDm6XiEeFxS6mgMR3JUKjI6FIyEgHMjjKPtW3GUui2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz2i/azC; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz2i/azC"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-915ab38ac14so327151185a.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782649562; x=1783254362; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuVL7KrT8U5YrPtPEy3nGfPDJuTjyYKW3cyDb3NVQHw=;
        b=Oz2i/azC8OEVAqW2B2gztLbNRgaACQOu/lmfjlWY2uAunnki43LICTKl6fDmRsa4lL
         Zp/pqnNgoRZzYsp/IZtwtdcAJ65gyj8uXYnC9Jry6AY/izFrRe8Sd5+TaIu49tXxihwk
         yCAx1C2kutyhpzrj65sz+NDpu9qGBPeubInwrOrF+TaUmVWjPdfKsytt5Twfe36bF17R
         p4Bw97STLIRiGTZpR1RTdr9ZT0geNhaAw+Dykit/f297MVQODKdH7/vamd1lP2FFTAPi
         EXfzmViBBGi02h0r+91JehWP7P0+ChC6N6qkGOtuN9C3hEogp8aahR3fCy3TWyqlJ/G9
         iPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649562; x=1783254362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuVL7KrT8U5YrPtPEy3nGfPDJuTjyYKW3cyDb3NVQHw=;
        b=LaiCRGIScvsZDNINFF7FkvhBb9BaGOKmM4R31zEtniT8ZVP8gSq8+XuGF2zXNoCZM4
         8dDoEDIfGe8o/XwOhNBY1wTKYCGk2wV3/J1tGXAnHjO9XyDcFBQeEB4EHQT0K4OnUukw
         /elICG/5Z25O5n20hLn8mozPSeeLYQdDvdA9D/8rKNINur0TOLTfHv1mQJRNhI4R6udv
         B9Q+y28Ok0uUHgZ/d+D6r/QqQMpLXXs1saxoYFb5eA1x5gJQJ9ykCvDBojnvBr44rU3E
         ErS9oQToEkIHRSemn7wmyd7g7Ms/NqmooGs8gWgx5AumXjQFUWIh76lxKM8BrTxIW71c
         m0Hw==
X-Gm-Message-State: AOJu0YzKJy9wbUqyL9chNhla6rqWtoDmYZ2QZ8B8atqad+eEZA/LRY63
	pInhOGvJOdusAAPLKyUyxrsfguzzTZeIMGZQNwzn/EuxuhBTkeXMB+FTyIyGwQ==
X-Gm-Gg: AfdE7cny28wSPjYZxWaHNSLmmtC/kbE3j4sRJFJfj7cU6V4mqsRm4YMtEuIvcU3oW6x
	rz+8zbfXvcL/M3HSPHLDIPN9nM9V2VmvPEtXlEXnv1jr6JSNXc5qtj2PwcOKJmcIGroZaZbj5Ns
	bNEqapcgOnmfg5ek20IuR52O4G+RyCH4Tdvo95sqY9GDnExgvIO+bVQ8USR8+QqmucLKZ3FAFkb
	yIvhWlamrkNTzx/JmhadO4PnV/tIlc/y5TWEKrWIRdVANHLHekirdKNI1XfgfJLkHEHrbtEqfDS
	zKK+vwdME1q7icHNQ7/aEk4ADSAgNRviI5BKFeChK5sX6hD52kVEtBFu9fzohSQYXsOgX4hq6nj
	uAKUTjCKMzhPsikvAODb6dbwhdiAXFpEt9p1Ppy8TibE1RH7P5/kKNcre72rdF1XZjAI6x+/S8s
	dyJhx9t90JsnvooHty
X-Received: by 2002:a05:620a:458c:b0:92e:4e45:de9d with SMTP id af79cd13be357-92e4e45e5cfmr66406485a.17.1782649562233;
        Sun, 28 Jun 2026 05:26:02 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92da627a75bsm426992585a.45.2026.06.28.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:26:01 -0700 (PDT)
Message-Id: <fed9f2c36827f17d636e0ef986b358c15fd86239.1782649547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
	<pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 12:25:43 +0000
Subject: [PATCH v4 5/8] commit-reach: introduce struct paint_state with
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
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

The existing nonstale_queue is left in place for ahead_behind().

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       |  9 +-
 commit-reach.c                                | 94 ++++++++++++++++---
 t/t6600-test-reach.sh                         |  4 +-
 3 files changed, 85 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index a4dfcba038..ac3e2b39a5 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -88,15 +88,12 @@ re-enqueued is bounded by the number of flag transitions.
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
index f6a438550b..9ae306f60c 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -97,6 +97,75 @@ static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
 	return commit;
 }
 
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
+};
+
+static void paint_count_update(struct paint_state *state,
+			       unsigned flags, int delta)
+{
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
+}
+
+static struct commit *paint_queue_get(struct paint_state *state)
+{
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
+
+	paint_count_update(state, commit->object.flags, -1);
+	return commit;
+}
+
 /*
  * See Documentation/technical/paint-down-to-common.adoc
  *
@@ -109,31 +178,29 @@ static int paint_down_to_common(struct repository *r,
 				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
-	struct nonstale_queue queue = {
-		{ compare_commits_by_gen_then_commit_date }
+	struct paint_state state = {
+		.queue = { compare_commits_by_gen_then_commit_date }
 	};
+	struct commit *commit;
 	int i;
 	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
 	if (!min_generation && !corrected_commit_dates_enabled(r))
-		queue.pq.compare = compare_commits_by_commit_date;
+		state.queue.compare = compare_commits_by_commit_date;
 
 	one->object.flags |= PARENT1;
 	if (!n) {
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
@@ -172,7 +239,7 @@ static int paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
-				clear_nonstale_queue(&queue);
+				clear_prio_queue(&state.queue);
 				commit_list_free(*result);
 				*result = NULL;
 				/*
@@ -187,12 +254,11 @@ static int paint_down_to_common(struct repository *r,
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
index b3a31b80ac..51f3d70492 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -289,7 +289,7 @@ test_expect_success 'get_merge_bases_many:pending-stale' '
 		git rev-parse ps-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 6 6 6 6
+	test_paint_down_steps 5 5 5 5
 '
 
 test_expect_success 'get_merge_bases_many:infinity-both-sides' '
@@ -304,7 +304,7 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		git rev-parse pi-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 5 5 5 5
+	test_paint_down_steps 5 4 5 5
 '
 
 test_expect_success 'setup mixed finite/INFINITY topology' '
-- 
gitgitgadget

