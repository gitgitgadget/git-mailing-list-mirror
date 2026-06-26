Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0543F6C3C
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479299; cv=none; b=V+EsKx59v2aIp781mMf2dYLwPqv9adicAEyeOBA95EzwbWQHAJy9q0ISbPEjA8Oj7NLQY3hBU0nVYJpnwGIGB4O+upP9DU5JTihh5jcP89cr+lSma0rbTgjUBOwQMjBrBIkgRpWFfHqsU9S4fIS+pdn/obD9DUA4K4a1ia8iPqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479299; c=relaxed/simple;
	bh=sMggIn7ep0XIp6x8AQFr7Mqhb6nNmRnfkfQ7IbzAcoc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rkiczsYjS4RmNtLACRa8kX8spZ2SzyDiPFkR/9vtVYDn//80xiz0FuIt8VM3fBFMAJf2R7z6CTqNzP7Wiiw2KoD2JucaBWwIibmGIfjZnyztbnUpGeQsnumdBX1LWepZ77j08zw5fqBCpfDvqhlt5a07a/Z+9itYu82d9W1QsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deCLSxMO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deCLSxMO"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9156b74006aso73142885a.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479297; x=1783084097; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLSVxgXLiftZ2rw5BnLu2DA37FQWvgfPa47rsgJXccc=;
        b=deCLSxMODopWi1ZroAXr4B0yMXgrHlj6BYrGD6eU5g63nK6VtvQHerKXMmkjSPIa3p
         ktWrMjGIN20++LrHe+821S7Yf5xGi1Ku3dbHpTRAYJR1IPNSiMY0+K+3/+hsxhzd9SLY
         RMY42JWNwwxm2wxYE6ENUz1bF34rxrGw9l/ofepMEhMTekldPYVhKQrg5qngVxzIROtE
         h/aL1tzih4qPfRTXQaaeLfah9auNJfqNY23DTtmiFEXJEgN9Lg16CPd85yrGmqm/QYZY
         mwKmqoX08ORFDiHG8Fy3OF+knCApUfGSmsQNDoN/YHJtmZ4Wc6gQxpMulTOgrkfZYJBx
         4BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479297; x=1783084097;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLSVxgXLiftZ2rw5BnLu2DA37FQWvgfPa47rsgJXccc=;
        b=ql3GzEVdUjdzBjJSEqAlTNms78VWeM+pzwB4+ZEm12bHBDWDVimhOsSb65rOq7Cc9r
         p8TAeYlMUQ17bzbj2KjcbWNDJD0r6JR+LCQSZ09ig9huboTiPD3+512RICa1govSga/N
         S8CpA4SqHhoFK2D4aN/PMcjjFWkU9BsQq46I/pXx/dc90LGh1i4bPULvKNyIX7WsYAxc
         CaVjyMe1WuH8d5Xj+RM3NpbqIgKtlaJJu57ZUub5bSGom9dCsu+Qhyz2k6g3B/qHgknF
         PnvKCdfWwYonJu1pElfvdwV/l3coJqatOMIhSwbRYoavbKstd35yytBVohuNUT9amEKs
         wzow==
X-Gm-Message-State: AOJu0YzLWGrcOhq100eGeYkVC8zDOiWVB7/7WZyAU6pFsNmbNLlACfFu
	9mbnEJktnmCNwGIV80jsbM3kzQXjVhFbM4eUchPvUpZawuA5tvLB2/X4yRDzjeA+
X-Gm-Gg: AfdE7cmBW+yloVHxdynq+20W4Xv1ZII1ihWgQjGVZjcT8SnOqKhf4zCJej9pFFix/w3
	ZkD5gSs+yOXZ9I6oZo5NM5dg1RxXEgnZM3K+VfycKJIs/CiT7qSwSzFbISZDNax87TnGw7Wh6vI
	aEA73QFkJWqlxdqoR/TAZQH/dvnMFPObmM3SdcLgRAU0sZmXnCtlXJgFpQ3dSpeL3cqQP3QARyG
	7SIULqTD93bY8VtdGQ3zAsijt5lND9S79urjppalv4UuKLnmTtA5CeqFlAP4nCoq537exyfYDJj
	4gndPGygxGUJ4vFK26JUGjCsIQ3LmeBh9v6a6+i6klz0H58uXieMA/rmhxAWrwAchHXmQhhIoH9
	4uq7rkGlrVCX+29aPzw8HjTmiaXdTi4egtpxFwDFNSbqZB0nIgosfzBWLP52NCMALzkwjmVi/qv
	CPx7EHVDP1iI+DDEVtdqgtSq50
X-Received: by 2002:a05:620a:26a9:b0:922:68e8:d945 with SMTP id af79cd13be357-9293bb44894mr1049494485a.16.1782479296669;
        Fri, 26 Jun 2026 06:08:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9260079070bsm1180413085a.40.2026.06.26.06.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:08:16 -0700 (PDT)
Message-Id: <4b9f192d98b8e8f2d30eed4261a73e766eeafcc2.1782479286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 13:08:05 +0000
Subject: [PATCH v3 8/8] commit-reach: move min_generation check into
 paint_queue_get()
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

Consolidate the min_generation termination condition into
paint_queue_get(), alongside the existing stale-entry and
side-exhaustion checks.

Move last_gen into struct paint_state so that
commit_graph_generation() is called exactly once per dequeued commit
and the result is shared across all termination checks and the
monotonicity BUG assertion.  The loop body in paint_down_to_common()
reads state.last_gen instead of recomputing the generation number.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       |  9 ++++++
 commit-reach.c                                | 31 +++++++++++--------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 983dfcf233..eef249f4a4 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -97,6 +97,8 @@ ends when one of the following conditions holds:
   3. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
      remain in the queue, no pending merge-base candidates exist,
      and the walk has entered the finite-generation region.
+  4. Generation cutoff: the dequeued commit's generation is below
+     a caller-supplied `min_generation` threshold.
 
 Stale entry condition
 ~~~~~~~~~~~~~~~~~~~~~
@@ -121,6 +123,13 @@ time and an exhausted side cannot reappear. In the INFINITY region,
 commit-date ordering can violate this guarantee, so the check is
 skipped.
 
+Generation cutoff
+~~~~~~~~~~~~~~~~~
+Some callers (notably `remove_redundant()`) supply a `min_generation`
+threshold -- the minimum generation of the input commits. No merge
+base can have a generation below this threshold, so the walk
+terminates as soon as it dequeues such a commit.
+
 Related documentation
 ---------------------
 
diff --git a/commit-reach.c b/commit-reach.c
index 0248d6fedb..0cd785c31b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -89,6 +89,8 @@ struct paint_state {
 	int p1_count;
 	int p2_count;
 	int pending_merge_bases;
+	timestamp_t min_generation;
+	timestamp_t last_gen;
 };
 
 static void paint_count_update(struct paint_state *state,
@@ -138,11 +140,23 @@ static void paint_queue_put(struct paint_state *state,
 static struct commit *paint_queue_get(struct paint_state *state)
 {
 	struct commit *commit = prio_queue_get(&state->queue);
+	timestamp_t generation;
 
 	if (!commit)
 		return NULL;
 
 	commit->object.flags &= ~ENQUEUED;
+	generation = commit_graph_generation(commit);
+
+	if (generation > state->last_gen)
+		BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
+		    generation, state->last_gen,
+		    oid_to_hex(&commit->object.oid));
+	state->last_gen = generation;
+
+	/* generation cutoff */
+	if (generation < state->min_generation)
+		return NULL;
 
 	if (!state->pending_merge_bases) {
 		/* only stale entries remain */
@@ -151,7 +165,7 @@ static struct commit *paint_queue_get(struct paint_state *state)
 
 		/* one side is exhausted */
 		if ((!state->p1_count || !state->p2_count) &&
-		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
+		    generation < GENERATION_NUMBER_INFINITY)
 			return NULL;
 	}
 
@@ -177,9 +191,10 @@ static int paint_down_to_common(struct repository *r,
 	struct commit *commit;
 	int i;
 	int steps = 0;
-	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
+	state.min_generation = min_generation;
+	state.last_gen = GENERATION_NUMBER_INFINITY;
 	if (!min_generation && !corrected_commit_dates_enabled(r))
 		state.queue.compare = compare_commits_by_commit_date;
 
@@ -196,18 +211,8 @@ static int paint_down_to_common(struct repository *r,
 	while ((commit = paint_queue_get(&state))) {
 		struct commit_list *parents;
 		int flags;
-		timestamp_t generation = commit_graph_generation(commit);
 		steps++;
 
-		if (generation > last_gen)
-			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
-			    generation, last_gen,
-			    oid_to_hex(&commit->object.oid));
-		last_gen = generation;
-
-		if (generation < min_generation)
-			break;
-
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags == (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
@@ -219,7 +224,7 @@ static int paint_down_to_common(struct repository *r,
 				 * descendant of this one.
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
-				    generation < GENERATION_NUMBER_INFINITY)
+				    state.last_gen < GENERATION_NUMBER_INFINITY)
 					break;
 			}
 			/* Mark parents of a found merge stale */
-- 
gitgitgadget
