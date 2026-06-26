Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA93F44CA
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479298; cv=none; b=TSj9W+9qmfRO+eY8z5UfdkbB5CRuAxMLP7uu1Ud1WbqtKEsFkl8819SYyi1JyeoGdudL4BfEfCpA4pwXsyQ7uTKCaRIFB86q7feqrikChqd6jbAtz3j/GP6CRGfI1iaxlzcS8wcbVTKMyRuB3rEdNIKIJc/DsFg2prTTPolfcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479298; c=relaxed/simple;
	bh=5UlQdKpvKJNEcxZhO9XJ5PvzTOZ958yafYyvY7IQPgY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KHlQmAY0PoOhD5EN9aeZMxGBKKvI0MhETk1cGxf8Um/W0e0wfzjxeNAStjc4gyafh0CC3F8//k59PTpQMnJEiy5z1VKm1szWWd7l5t5ZC14eSM8SqjJ1BmCcW6GelfL7nWJ9Av4dlfpM2gTmmWrgdmAhalLQB+NgSrV6HS8z/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7ycdB4i; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7ycdB4i"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59e23d70dfaso339691e0c.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479296; x=1783084096; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj1x4wj5a/XGcUfbgVnHAU/GNH9YCJHqwpYccdgJ+b8=;
        b=P7ycdB4iXsbH5FhUFZItg6DusD5qa4gQcdJjS5J7MwG9v8vTtzipyNKf5084ruUriu
         on48fG/vRV1Ofbw15td4zeKGRO56XDDZYaw2OVRtrYHoQUFYo7lT+pjcNKAlYOm8SafP
         cGJ5tzRLWRxvx14nuPN6JbPNI5YoelDNJ6bksDzt6uBfg2nEPn3fNkSj26Pgfk0ukn67
         Ki6cJUBTdp883TknglQrRxXbC4WEquHLOd5SMh3XWIJ18hBVB8zNQnKAPtMGLk2dlDfK
         dTb0F5B9z2krtjjty1UWlZZBEhsZURF7cVniZa7GVyeT+pca/LufYxggcdSgoUHzUuv4
         FjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479296; x=1783084096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aj1x4wj5a/XGcUfbgVnHAU/GNH9YCJHqwpYccdgJ+b8=;
        b=HJFzHcNCQ6Ld/rWJIny4W779q1qRvNrjP2tO/4yPVOI3Gi1C4Ba2s5bjl4Mu3gHCgB
         cDXeoMW0VGaBWFWdUjkolmUMbJ1B6dld/zk/vqrRSOQ7MQjMA+ILN6V2LRlHpBLQqlQU
         mmLXZyhbl6X5pjh8kgEsNAbJAxoDf987TAgZR6NVmaFhJxOAJNwoBbIeUFyfE7TbCUT4
         WvJ3OhWDqe9IfWx4GtZ5TzAli+gcYylPyL2z1ookVExEzXP2uuUzdw6JFUR0cQFqy3Vl
         Qihd1r1aLcvhwTuyGGV645dEdulkZQJGoFnwfiBYkV9jscWcE8UVb56cE8DO0m8nrEma
         9REw==
X-Gm-Message-State: AOJu0YxM85xCODWUP9/tjkkZg4ORD51kWAMMsZiQB+zPZV9OrQ9uDa5h
	lU1DAEX/7iW8aMqKkctCIvDMLTDISOkh6rrOf+k1HnO8vDucx28XnVd8dVW9BDfI
X-Gm-Gg: AfdE7cmqDiwvr4n1yCujVZRHdakAK/4cIe/YKqdmNOjdP1YbnT4jd3+uPYBb/t5PW5W
	5DwYs56SoS8L6wnyJm7PlZBA0wqB5Vic9H5y+53CcdFHowAXInFwgnjuBhu6yQRc4LUJlsxn7yN
	CGkd0B0yxvj4OnqvO7rXaCFnJ+R5plXHUIO5VMcoFA8Ya613jjxCHxzLjSPQtwmON6TaDCnx2VC
	qWsNElW03hVX02ljjT7Jm2D8G/3Mq8HBLHSqmsFUE6ZSbL/TFyQUFOIX5tIoAyBRWP6QUGC+/Pc
	T8vBKDaiW7ItxRem7PCmLG+PnvExj75eDT6SZJVd3BMG8qlAS4D//a7bhuFr7BlQ+s79vtzbeX+
	RwJ9LRjNKUWRKJZIwBlnMfytVefEwcGZwfEVTEz67NanOz/sLQvO4eqj4R6+knTg/s8uOEdVqpi
	W9TwrWfoLQXv2VJg==
X-Received: by 2002:a05:6102:32c3:b0:631:2472:e832 with SMTP id ada2fe7eead31-73434045959mr3383660137.8.1782479295806;
        Fri, 26 Jun 2026 06:08:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92b25710637sm43669685a.19.2026.06.26.06.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:08:15 -0700 (PDT)
Message-Id: <f3572a8a89c74fad54a9e53be6f0e34daa2d50c2.1782479286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 13:08:04 +0000
Subject: [PATCH v3 7/8] commit-reach: terminate merge-base walk when one paint
 side is exhausted
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

Add an early termination check to paint_down_to_common() using the
per-side counters introduced earlier. Once the walk enters the
finite-generation region, terminate early when one side's exclusive
count drops to zero -- no new merge-base can form without both paint
sides meeting.

The check also waits for pending_merge_bases to reach zero, ensuring
all merge-base candidates have been dequeued and recorded before
exiting.

The INFINITY gate ensures correctness: commits without a commit-graph
entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
which is not topologically reliable. The optimization only fires
once the walk enters the finite-generation region where ordering
guarantees hold.

Widen the existing generation-monotonicity BUG assertion to fire
unconditionally, not only when min_generation is set. The
side-exhaustion optimization depends on correct generation ordering,
so the assertion should always be active.

Step counts measured with trace2 on git.git with commit-graph:

  merge-base --all v2.0.0 v2.55.0-rc1:
    before: 72264 steps    after: 44589 steps

  merge-base --all v2.55.0-rc1 v2.55.0-rc1~5:
    before:   110 steps    after:     7 steps

Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       | 17 +++++++++++++++++
 commit-reach.c                                | 19 +++++++++++++++----
 t/t6600-test-reach.sh                         |  4 ++--
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 0f4e1892a5..983dfcf233 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -94,6 +94,9 @@ ends when one of the following conditions holds:
 
   1. The queue is empty.
   2. The queue contains only stale entries.
+  3. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
+     remain in the queue, no pending merge-base candidates exist,
+     and the walk has entered the finite-generation region.
 
 Stale entry condition
 ~~~~~~~~~~~~~~~~~~~~~
@@ -104,6 +107,20 @@ existing candidates by proving one is an ancestor of another, but
 `remove_redundant()` handles that as a post-processing step, so it
 is safe to exit early.
 
+Side-exhaustion condition
+~~~~~~~~~~~~~~~~~~~~~~~~~
+A new merge-base requires commits from both sides to meet. When one
+side's exclusive counter reaches zero and there are no pending
+merge-base candidates, no future traversal step can produce a new
+candidate.
+
+This optimization only activates in the finite-generation region
+where topological ordering holds. In that region, children are
+always visited before parents, so paint flags are final at visit
+time and an exhausted side cannot reappear. In the INFINITY region,
+commit-date ordering can violate this guarantee, so the check is
+skipped.
+
 Related documentation
 ---------------------
 
diff --git a/commit-reach.c b/commit-reach.c
index ee0e0fdf6e..0248d6fedb 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -131,6 +131,10 @@ static void paint_queue_put(struct paint_state *state,
 	}
 }
 
+/*
+ * Dequeue the next commit for the paint walk, or return NULL when
+ * no more merge bases can be discovered.
+ */
 static struct commit *paint_queue_get(struct paint_state *state)
 {
 	struct commit *commit = prio_queue_get(&state->queue);
@@ -140,9 +144,16 @@ static struct commit *paint_queue_get(struct paint_state *state)
 
 	commit->object.flags &= ~ENQUEUED;
 
-	if (!state->p1_count && !state->p2_count &&
-	    !state->pending_merge_bases)
-		return NULL;
+	if (!state->pending_merge_bases) {
+		/* only stale entries remain */
+		if (!state->p1_count && !state->p2_count)
+			return NULL;
+
+		/* one side is exhausted */
+		if ((!state->p1_count || !state->p2_count) &&
+		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
+			return NULL;
+	}
 
 	paint_count_update(state, commit->object.flags, -1);
 	return commit;
@@ -188,7 +199,7 @@ static int paint_down_to_common(struct repository *r,
 		timestamp_t generation = commit_graph_generation(commit);
 		steps++;
 
-		if (min_generation && generation > last_gen)
+		if (generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
 			    generation, last_gen,
 			    oid_to_hex(&commit->object.oid));
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 51f3d70492..6365007560 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -220,7 +220,7 @@ test_expect_success 'in_merge_bases_many:self' '
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
 	test_all_modes in_merge_bases_many &&
-	test_paint_down_steps 45 2 25 3
+	test_paint_down_steps 45 1 25 1
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -337,7 +337,7 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	>input &&
 	git rev-parse commit-9-1 >expect &&
 	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
-	test_paint_down_steps 81 80 81 81
+	test_paint_down_steps 81 9 57 10
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget

