Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6042AF8C
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440549; cv=none; b=OTeksz11lAiNl24JDiPmfwHBMLvqJUGSIYIpkKs3tORgCS1AWXflzFPtVQIveKQcdgJldyuZ+aZ+2iaOixZWQ37WSxtByxQdpy4kqc0H+wEJhblv3MaP9azsVIczLf74c38t8UX3fH7IiWuIoZsr+kSmgkYKa/4GvYKds2x1g74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440549; c=relaxed/simple;
	bh=cmogRmk7Ev/4ywVTcT9Aieahv3JJ4LNbfobMJSIp6Sk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E/ZkrO3Q5a15/NP/9yznQnILGBx4icP5fU2s1qlC3rOuhAixnyGUq0gc5Qo+UAcWduYDF4Kr6PizsliJ0zXbjHCDFOmrlTY4+VK0oAKmVeZnczjo/DGsDDEW1dgjCgUCd60/bg17sEuv1uNO6uykp/2md6J1am3O+KicedkKThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrq4TKhC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrq4TKhC"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38f620399a0so541374a91.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440546; x=1787045346; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qCD3Fxfepkjq7u7TPK6Iu51IyOha2D+weCJ5x+s7OME=;
        b=qrq4TKhCRhQm1Hx7eT6E8GpBEfHu5lucl9GH5UMkeonJWytLu513ULHmZnn2FeswHB
         fTuN98pc2KlRwLf9Du6tLdM714iAegpJybxLGEoHQGMTja3ZUlbFLctb2g5+WWyT45hG
         1HhhAko4JM19R9CFwxfpcANxNeHZVS0Sxj9w82xE5rFdWKY/rnJ0S5g94OHRz9rwvWUo
         Mzn61OKS/FMSMgmPP4FHkwfpM9UjrxHVtEVOFi/6tFQQNMX/A7454pT7ZJq81hz7od9n
         U6/pqbyh6yMk9ji+8iVY1Z/Gx+MYXdv1YGkfd1tPHvWS2krpREGb33tBhv3aXniUd1ND
         ef3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440546; x=1787045346;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCD3Fxfepkjq7u7TPK6Iu51IyOha2D+weCJ5x+s7OME=;
        b=cDOOMLlufzJbXrKITEJhTVfDuSBeWGb9vLWxvnwZ474ch73S78AQj3q0JBsHGffMak
         OQAWxpFm2iUXgMGuxRkRGkfl3YMNcXsfKG11l7gQWXXPYNPc7xOr/rmmQW4RGXXT9zBR
         BF5qVATkTGSMw4JtgYVj9WEd9xi7ChkMrJtrJEQZ3K1e2/waKiQA0OrLSDkgC53cBsgd
         nIo5NlxiL0OU9xUNvt/wr8CO1jX/EqgIkTY/FHJuRdiPfUntUpTGjidn1Z4fTUD0BdOx
         1M4/g4SVCbpHDaVoM+8GlOehBlPHa07zKQ2JRlS6KJNjqxVKR2tL8IOMA3HG+AsYxWwk
         4Jow==
X-Gm-Message-State: AOJu0YxCFTkdqePKxwKlH6HFIzxs/ywkVE789M7Oz7BfA7/R7NC5XFoK
	7eMgF0JdWEd2MOU3absSKxP3LaOrg/84a5TmIUK7uZFqIvpMoXOoIAUjf9hE5zNl
X-Gm-Gg: AR+sD13Akr3bZSjbJVUIrYZxTaTftJQeJ328daxUMvmf81dyTwlfzKo2CWMVW52VMSg
	z8IFRhSkeRePtJHKnnfhxIrkkl2EG88RR02EOm4Tv3mCvvOrfL0xz3SqwMhFX2YRyng9Pf5MTbU
	o+0l4nVlD102/jrudl67GjMHg+uIaiAUb46QcOWworvaUHEa8lbHfmPA/iQlUYne74pcaaI44n8
	kqXBscrRNUGD6jHXTTR5yMOfte3jc/ERXEmA09eZyXtdapMZyEGaXFdHKUxh2oku2G0QalrBaVK
	KmGJ7GiMxBRco0NQQpEkp2z4cjLrQduZO1hem4Fvx5o95Mm4tpoeywLazmFEhGoEXLKmLMLsjir
	o+L+FtpGnEAUItfSiIFHKnVKKQ+92OyJU+Zn5UocBSoQgU+cgo5qhTcLEJosqLJZusc3UT2QgbM
	wB7HMZlOTHwa0TAPw89OXihXAUT4HaPktaQPVSD/y8GoQWGNff7rLZ/mFwPVThkrI=
X-Received: by 2002:a17:90b:574d:b0:392:c868:35af with SMTP id 98e67ed59e1d1-392ec6ef5f1mr1976630a91.20.1786440545838;
        Tue, 11 Aug 2026 02:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392ee41936asm1224649a91.14.2026.08.11.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:05 -0700 (PDT)
Message-Id: <9a0f4df49a9b97ec819168ec0cbae96566df62b4.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:51 +0000
Subject: [PATCH v8 09/10] commit-reach: move min_generation check into
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
index 7c5bbe00c3..32e65a52b5 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -90,6 +90,8 @@ struct paint_state {
 	size_t parent2_count;
 	size_t mb_candidate_count;
 	int gen_ordered;
+	timestamp_t min_generation;
+	timestamp_t last_gen;
 	timestamp_t topo_ceiling;
 };
 
@@ -140,11 +142,23 @@ static void paint_queue_put(struct paint_state *state,
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
 
 	/*
 	 * Check exit condition before decrementing: the counters
@@ -159,7 +173,7 @@ static struct commit *paint_queue_get(struct paint_state *state)
 		/* one side is exhausted */
 		if ((!state->parent1_count || !state->parent2_count) &&
 		    state->gen_ordered &&
-		    commit_graph_generation(commit) < state->topo_ceiling)
+		    generation < state->topo_ceiling)
 			return NULL;
 	}
 
@@ -186,9 +200,10 @@ static int paint_down_to_common(struct repository *r,
 	struct commit *commit;
 	int i;
 	int steps = 0;
-	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
+	state.min_generation = min_generation;
+	state.last_gen = GENERATION_NUMBER_INFINITY;
 	state.topo_ceiling = corrected_commit_dates_enabled(r)
 		? GENERATION_NUMBER_INFINITY
 		: GENERATION_NUMBER_V1_MAX;
@@ -210,18 +225,8 @@ static int paint_down_to_common(struct repository *r,
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
@@ -234,7 +239,7 @@ static int paint_down_to_common(struct repository *r,
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
 				    state.gen_ordered &&
-				    generation < state.topo_ceiling)
+				    state.last_gen < state.topo_ceiling)
 					break;
 			}
 			/* Mark parents of a found merge stale */
-- 
gitgitgadget

