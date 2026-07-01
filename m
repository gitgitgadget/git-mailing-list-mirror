Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA9377EC2
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923854; cv=none; b=ZSUa36tDRWLlm95u5kj9NOVsS1oth7bo5qtm9ngqCTyCYu4sZF8W1h3q3Fk2sR5+l1V49biHzYrCsKbXCNjiw0j5oufP8qznmsxkoPJ4TgECdMRFBZcUDWfs+uO1UnpHJPpqk14+lwR37tGVO3dtMFFGUW9JQK1orvW/SFadfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923854; c=relaxed/simple;
	bh=omezY08UoZw9U/NB0ChAUsS5LBA6KeLAmSuQNHUoduM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EshMAA0sb5H+ptBE6Dl0gI5YFxHoy+/c+VQTrUp8/FoWsvpwuMs9xv0UoMmctgOZoA9qrixN8+ETxbbMcjhABSrphxttbHBJdW/S67Q9JIlOk47ijO6FyLgwNYs/a07+MhjGMzlc5Qb3H49r0iHrnybaKPxHm8+V0BYgqPYh7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNGAJ2sc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNGAJ2sc"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84783bce476so752899b3a.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923852; x=1783528652; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4aJO6/mTVMAQCgsIOkphbziW+XFZ+1V7UBwxQqIW9Y=;
        b=YNGAJ2scIM5KNp0IlZoNt+CjXV0J/TtqqzfVEjlwmcadGp3KxosOzYDdUDD52H2+w1
         zDN/Vz4aWtBgrTfDMjx1QpYzIncJHNWwvq7wu7gMXR7QVe/Jdx3I8H2VuQpnB0CvwtuM
         mqxSXCW0fOGPxihhE4CV8S0xh3khREH9WY3jM9i593x/KcboaiKQXsrLukeTTWCJ4Qom
         5NW8l/K/MxLYbVVvKDB8Y+lTrQJoRNz260kK5HXqM4bh7G7jkUPtV6bdkUVs11ejIrxY
         gFo3lzIQGstpG9V3cd/San7l7Z2ins4jDllL7RTs7Thj9yukXpIu0LnwwpKpcEetZbGK
         MVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923852; x=1783528652;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+4aJO6/mTVMAQCgsIOkphbziW+XFZ+1V7UBwxQqIW9Y=;
        b=s5qpXp4r2Wdlrqe3LfzC0WPbmdBQ7lngRUxVRgIhbmJRePvw6/Tqlnt4eufRpP/yiP
         Rr+tI4Yee+ZY3B/piEZErzdBzZShPW4SsKf4F+nRdr4cJ9gJ61+riinyyQ2j+i233VD4
         x78KvqB1SkTwX17d2Egzto3mfgye7tyNNeV+6Syh7Qcispv+bXGvFbUJa/IgoP3GbwgI
         53ytENZE/IrZvzpJBsrMdwGVA34KRHIoXLNfrxJ4usq2W3xhuj73Lej6faWAdO6EXbdj
         6Wy3R5lessmx9sXS48muaCQfScFY5Z5yYxlfzS+DN9I85AnZOar6m5wECrW/Bkjhdeg8
         hPog==
X-Gm-Message-State: AOJu0Yw9mJDFUcf/C5hEY06anxFUQ2vxLQeATUNdMhfDQdV4efcTVyxA
	JJyzol5VSQ8BZulg8OTctPtaGJW/xxuCR32BqqQXUIvKShmS3UtgdxJvqI0bAQ==
X-Gm-Gg: AfdE7cl2Nuv8/rvf7fWAKXUyQDTroXU7aT6k6LLSKS3jd29T1gfvHwMeqRAKO9y7tTP
	kn+7OUrA1MXeOK784YzSzVsfted9Kl6iRwxAwKmD9fyGVS3eM5IP22ajOE0jQ03Cyibq4JKfCBC
	IFZl2tfOYo6c5bKLlYQN0nY1vID010mhtYSQqBbEN0sSRqczqpLXsonPUt2hRJ0nV5DHTrewXBP
	HVIFOqFqAmOvIFhiS8/XNjJUMMFY3IIm18A3YtMayrQsaZUusltDPA88499NA1jOOcqKhJpXI5o
	/AM+bMzDXH58mZp9ZIDv1PuDRUWGYoUZjJwE6sLb4u6Kcn1pxqCoa7Tfgoyiaa6qQk1JimxBNmy
	GW8RQhzVvkJqcWt0EcWdiDR3+bjaXfe19G8CYA+dmlwqK7HkUELoIcGYvBZ8WPXVoB7USk6wQbw
	WgfSCR34pwQvzWYCtjGsE6X6+Fjg==
X-Received: by 2002:a05:6a00:418f:b0:846:5d03:6503 with SMTP id d2e1a72fcca58-847c0ad9694mr2028518b3a.62.1782923851603;
        Wed, 01 Jul 2026 09:37:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb6db74fsm84920b3a.10.2026.07.01.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:30 -0700 (PDT)
Message-Id: <b45c302caa9d53040fe9e10fabea8f4de7506379.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:10 +0000
Subject: [PATCH v5 09/10] commit-reach: move min_generation check into
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Consolidate the min_generation termination condition into
paint_queue_get(), alongside the existing stale-entry and
side-exhaustion checks.

Move last_gen into struct paint_state so that
commit_graph_generation() is called exactly once per dequeued commit
and the result is shared across all termination checks and the
monotonicity BUG assertion.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 2b9249105c..871d67d07a 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -90,6 +90,8 @@ struct paint_state {
 	size_t parent2_count;
 	size_t mb_candidate_count;
 	int gen_ordered;
+	timestamp_t min_generation;
+	timestamp_t last_gen;
 };
 
 static void paint_count_update(struct paint_state *state,
@@ -139,11 +141,23 @@ static void paint_queue_put(struct paint_state *state,
 static struct commit *paint_queue_get(struct paint_state *state)
 {
 	struct commit *commit = prio_queue_get(&state->queue);
+	timestamp_t generation;
 
 	if (!commit)
 		return NULL;
 
 	commit->object.flags &= ~ENQUEUED;
+	generation = commit_graph_generation(commit);
+
+	if (state->min_generation && generation > state->last_gen)
+		BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
+		    generation, state->last_gen,
+		    oid_to_hex(&commit->object.oid));
+	state->last_gen = generation;
+
+	/* generation cutoff */
+	if (generation < state->min_generation)
+		return NULL;
 
 	if (!state->mb_candidate_count) {
 		/* only stale entries remain */
@@ -153,7 +167,7 @@ static struct commit *paint_queue_get(struct paint_state *state)
 		/* one side is exhausted */
 		if ((!state->parent1_count || !state->parent2_count) &&
 		    state->gen_ordered &&
-		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
+		    generation < GENERATION_NUMBER_INFINITY)
 			return NULL;
 	}
 
@@ -180,9 +194,10 @@ static int paint_down_to_common(struct repository *r,
 	struct commit *commit;
 	int i;
 	int steps = 0;
-	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
+	state.min_generation = min_generation;
+	state.last_gen = GENERATION_NUMBER_INFINITY;
 	if (!min_generation && !corrected_commit_dates_enabled(r)) {
 		state.queue.compare = compare_commits_by_commit_date;
 		state.gen_ordered = 0;
@@ -201,18 +216,8 @@ static int paint_down_to_common(struct repository *r,
 	while ((commit = paint_queue_get(&state))) {
 		struct commit_list *parents;
 		int flags;
-		timestamp_t generation = commit_graph_generation(commit);
 		steps++;
 
-		if (min_generation && generation > last_gen)
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
@@ -224,7 +229,7 @@ static int paint_down_to_common(struct repository *r,
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

