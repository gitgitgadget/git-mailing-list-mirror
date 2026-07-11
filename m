Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD93381EB2
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776489; cv=none; b=rf3abWD8yBFQyH26v1x2TlHIRYRE7pBj0x6dQKlZkKGy+GjAYk6ULES7aP5i/EvpYDFiWkjICjQGN6n0YnSYTlHXzMeGxPRhR63dRaorxO6lCp5I7IEvXSlFDI7ZHycxvk1HB16730KOx1eNT2LrYyhb1nt5iTfS3EGIqq4I3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776489; c=relaxed/simple;
	bh=u2Un9x5Y3yUZnBZsZ6T6AscFo+gQdaCgfCRd424x+18=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tB1OwBGLfKZP7rSzfA+zo0WE0C4wN5ZAhHIWJWSNNUGwSywbsxCiMBqEg6Wz4h3H3aqKWiDdkIh7TCcIAxkm+ovTMOMsT3IuUjDIm+8DfSPwMJSKtL5TtaP42I0gCaklSTIGBZ6N0HHbruEFMWpbbF5zdFmroCIQWzt5Wpd7mCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ4xX5LQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ4xX5LQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cacb8416a1so15339615ad.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776487; x=1784381287; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9dImOABY5hpX6e+26Xxrwg3jViYHvwaN1TNztuYSHmc=;
        b=cQ4xX5LQqnDbvJg7iXyYcfQ8ikFwUE/CXXM+R/0kzIbNcsd7glereutt2ExcrWgjfH
         qpjG95SBV5OG6wmWjfTH92zbZ1c6KrZeedEWocsBpywcnaEfppbGAeoLEqVbfiK4s+Zj
         zVW3/Ellh5AgJ0Ey3XkA2FKuCGaYLOq//5chJUiWzdnVpm0vnID7JHsuDx79ecwxmDEg
         YBSl8WS5LLq068kbDkwFZZdhw9Vx+yd05+UpzhNKfszD/lN8CESNBFUw002JqNx87N+N
         f/cYH/dLZTUXUEqMUUIpnrIYyWj5XNngohUkzh+OJcqGb0SSBwYFa+Ouk4VCpdWvyzXl
         F2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776487; x=1784381287;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9dImOABY5hpX6e+26Xxrwg3jViYHvwaN1TNztuYSHmc=;
        b=euWvMyEddfguD+rmh+fNiYG8JcpLspROy1VU2hYDPFJr9XRdIQcseR9QtXRbnNon7z
         ngv2oQk8Z1dOmmVZAlNRnerO7D+28oCiLqhvP8jAwO5wLsJnXxcTFcG303OuJAtWfvep
         Tm8mABfPgBHeWz7spEBuV7bZCrQc+ADdwynSmah8r1k1cVS8Ci5o0nyYVsMRVoyyFn+K
         OrGq5GcbiKmo0xtILBELmObM3YCPTxgF/hO36vzAAI2iV9lthMv0OKnL69WjxAXHo9Vj
         ye7jz6SuBfd/Ggy2c7bt7SZ7GRBzpb0yFCD8ZPplBfCFqEko/e83PODRKohaXYu6g7DS
         3CoA==
X-Gm-Message-State: AOJu0Yx6nESTZuF0nyC4RAsT/YUK4K/IbM7B50pgeJgAKJ28tbv7qovg
	/lsyxlDhm7S+8No36i33Mv+p1VvV7L31X8ToY6RnrhwrleO6PoXfyH9ZUGkKnw==
X-Gm-Gg: AfdE7cmQftxJYm798hh6rIm6i4UsIFQmLamp2jxl6wCSEVTQNtswAlECNOSCub4YBID
	INH5/TzIft54LCPzz5R6ufS7n/YX2kmK0S7NhtAZOCVdPHFEmX124m6F1h/y/iDsSPDRIWVP4cx
	o9YpbsuoxjgmXIVp6neYqhyQ4sjt0zkYSaeZIXSclnn0UnYr499RhqKNy+Qhx0VTqxnF9R1ZTdI
	o8R4/bJgRnsAcznPb8xlgdBWLiniEF8HziGN9DjESNRhX9gb8IXWkumNOYMeDZIIuFysFDc8A1g
	B/UP6tCt/r32qiB3EeEqM/kRtTWUmnfOFDYslHJ3oJjoAs3UXiVRg9T3L+prGn+SXm18h6CvdsA
	+Ki67gq+YAVxqu5PkdQcuzisgm75bW/o+5HKht9dR+Mg9CxlzSVuhSvmRTBqHkhmEzov2FXH/FG
	nioM3hRZNUlqEmuQA=
X-Received: by 2002:a05:6a21:10d:b0:3c1:d78:6457 with SMTP id adf61e73a8af0-3c110783da0mr3007665637.32.1783776487336;
        Sat, 11 Jul 2026 06:28:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm55485048c88.12.2026.07.11.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:28:06 -0700 (PDT)
Message-Id: <598a9633758733aeffd33c3145e777fe6848081f.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:44 +0000
Subject: [PATCH v6 09/10] commit-reach: move min_generation check into
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
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
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
index eabd689e52..8f6c810e4f 100644
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
@@ -225,7 +230,7 @@ static int paint_down_to_common(struct repository *r,
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
 				    state.gen_ordered &&
-				    generation < GENERATION_NUMBER_INFINITY)
+				    state.last_gen < GENERATION_NUMBER_INFINITY)
 					break;
 			}
 			/* Mark parents of a found merge stale */
-- 
gitgitgadget

