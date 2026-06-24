Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B55C2D6409
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303267; cv=none; b=D0j22JhlJwbWZY5L/6HjrzvNv9jeOwS/ub6wOKlEXfTd8AQlXULSJqHcYOW/8qVDkceow20b9Bz1A9eEMid07CWaM5AbJQN3JAKI9/b131WwZ41I0LTlZ1UkLtidzLR1Vbv7OLU95gmSDOB5IllYlGgC6ZVWWJiI9OvgZVl3XJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303267; c=relaxed/simple;
	bh=pD9gM6J+tfKQnxooE9JbcnXQVatpNJL0LLbXttZ5BOU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XTivyN2kzd8hGHTCvX5PASrMPL/uhbwXpQxk/OZ40+UxaKJM+l0qrPLAin5Lju/HFK2tp9438/bsUskwnJ90M0ybgKt17kxqHjnyzvkjVzYv5W+ZkG9zDgQcfAF36tziAIOXlEtOKK9wMmG0P9EKA1/Cc+52+sMo1L8LOm0TC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZQjW+zi; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZQjW+zi"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-922ff615c14so99964385a.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303265; x=1782908065; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t+DQVpZGQQrKczcwl2eE0Aa8Q8EmTGczTFzPxmfVrI=;
        b=pZQjW+ziPCH5dAPeK8zYI1qjlBOqdpgSKVd0yNcVr3ndR70zmI2zRM+tBbH3ltPcqV
         4U/Ub6110m00hnZ6jnPmsOepBuROfYD+Hz1OwKUaG+npapHi67/MHVPsXX5N0F9jTFcK
         aKR9qu/SRQ3+EqsCAVFEc3vTSy2MEpARDvpb6GIyqqbaEFspcgZZNVXJ8kOUxNHWV20X
         J3w4fujDGfzYk5iHNcTMM7QrthhbGqC1lgaerHv5jKIUi/4vyeGRQwHH1+3J8tSlctBB
         7keWJgh+kLg4YwlZ0vo2ACFPRywRceXqe/xqS6tkVOZtO7DT8w9CTtRJYAunSWeG2qpb
         8JKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303265; x=1782908065;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3t+DQVpZGQQrKczcwl2eE0Aa8Q8EmTGczTFzPxmfVrI=;
        b=Wfg09EQlbTT4tUb+gyNr+bF6pkEo48JCCxuRRchPc8jL0GYiyABRS3DWwwNgc+bqSE
         TGsVoYGradxOgTaS+cOLpTmm5UibaUidZ9N8TjPgowLrmdA6i/0WqYGRhaRIPrBtI7QF
         +VjbTpxj04Bhcrm5G2jwPzjfGrm5m+YWJE3x+XCzBIVljp6WKpgrF6axou53rBAloeIJ
         qDZ6xkEwwgFsj2rnVFS8mFu8HToPq+9sGxqkDKSihB0smGK3cXHDeG/oCOgG0fdPTpZk
         yq40+kMXp0hbds57KZf6zxniwKthlDiiCp3E/UdTHwlzWq4nKkFzG+K/BnV8AimSblVb
         BfQQ==
X-Gm-Message-State: AOJu0YwQQ1Gn94ZwH53cyq9DrU0cmmBrdj9IrLoAUQ1n9oF1iN6v9ENM
	1OdzUQGYLiwff+a2H5H8ZUXoTGNAOT4f+SJWmTFsryTyaEhnLEtjl31pJcR9yjcu
X-Gm-Gg: AfdE7cnQyAiVJbzfLt+bTO9LIH/Z4gmUkeDcv5+V6iNmjE/UqcCljWtdL3WySZjDOpc
	wuINrA8osj+Hn24Y3pf4RJVb6xYsEJrbdCHQvO4RFTr6GyC9Psh3o9ino1zyavu3WvyZGeq3Xzg
	kd2yru54YZbmDC/ZSSEvfdQk2sCtCc8dnRKo9ltfJDIgQH0L0kNXuhxYLUFEN44qUV4diShiae+
	XA/x5FMVcB+t7Rn2xifST3fZIKly1FEFDesPJngfQtSZAZrhviy6ATXhS+XyyqkWreshPjM0gbF
	TiG0lPo3+Rar988SkvXcwkWR3QrrLGvx3IBKMtJ9ITeJjoBgZYjtfd2vIQb4Pz49BxGryFNr70y
	jTgOgll4OdAJcbmfXo3AZD7k1hSVehjrBkaqSgY9wQhcTeJRxT/Y+4Eji2wEjrPoLrxlSWqmP4P
	veZ7S8LeDoEeskwYY=
X-Received: by 2002:a05:620a:4091:b0:915:9f87:eae6 with SMTP id af79cd13be357-9277e73d52dmr474937985a.42.1782303265042;
        Wed, 24 Jun 2026 05:14:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.92.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-927c75ca817sm149856985a.27.2026.06.24.05.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:14:24 -0700 (PDT)
Message-Id: <f24edd45f0af1da64513164d5d720fe70c1decff.1782303254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 12:14:11 +0000
Subject: [PATCH v2 5/7] commit-reach: introduce struct paint_state with
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

The existing nonstale_queue is left in place for ahead_behind().

Step counts (via trace2 from the previous commit) are identical
before and after this refactoring, confirming no behavioral change.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       |  9 +-
 commit-reach.c                                | 93 ++++++++++++++++---
 2 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index c10d5d2887..0f4e1892a5 100644
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
 
 Stale entry condition
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/commit-reach.c b/commit-reach.c
index f6a438550b..bf102f5e28 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -97,6 +97,74 @@ static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
 	return commit;
 }
 
+/*
+ * Priority queue with per-side commit counters for paint_down_to_common().
+ * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
+ * PARENT2-only, or both (a pending merge-base candidate).
+ */
+struct paint_state {
+	struct prio_queue queue;
+	int p1_count;
+	int p2_count;
+	int pending_merge_bases;
+};
+
+static void paint_count_update(struct paint_state *state,
+			       unsigned flags, int delta)
+{
+	switch (flags & (PARENT1 | PARENT2 | STALE)) {
+	case PARENT1:
+		state->p1_count += delta;
+		break;
+
+	case PARENT2:
+		state->p2_count += delta;
+		break;
+
+	case PARENT1 | PARENT2:
+		state->pending_merge_bases += delta;
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
+	struct commit *commit;
+
+	if (!state->p1_count && !state->p2_count &&
+	    !state->pending_merge_bases)
+		return NULL;
+
+	commit = prio_queue_get(&state->queue);
+	if (commit) {
+		commit->object.flags &= ~ENQUEUED;
+		paint_count_update(state, commit->object.flags, -1);
+	}
+	return commit;
+}
+
 /*
  * See Documentation/technical/paint-down-to-common.adoc
  *
@@ -109,31 +177,29 @@ static int paint_down_to_common(struct repository *r,
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
@@ -172,7 +238,7 @@ static int paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
-				clear_nonstale_queue(&queue);
+				clear_prio_queue(&state.queue);
 				commit_list_free(*result);
 				*result = NULL;
 				/*
@@ -187,12 +253,11 @@ static int paint_down_to_common(struct repository *r,
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
-- 
gitgitgadget

