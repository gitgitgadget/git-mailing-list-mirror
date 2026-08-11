Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66808422E35
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440552; cv=none; b=emI0P/8OEryS+uBOEGe7K1H6/AmvEVzvLT0VARJjC4XKw8dpuAjM1YNDjpWZJXu501W2Zf0y7fKznL74YQBuLgSiHPbPTfsY+LLcqbguIZ/I/M2asYdrbLQtwS9A51r4wbz5tqkUKrywalGxsiJVVnjXJrpbbYHRfdh1SffTbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440552; c=relaxed/simple;
	bh=90nxnj07LVHd08x8HYuZWskGc4OgqhN2Qy6Tsi7rL9g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Cvk6+0oPwgmPL0UfjFCj+qfRNxP+hO2QUl585ZnsamPvz+rDREa8wiJuL65HC9Fn3z8vzLXrFWyG89JBMciYl1H5ui5HWafOJRoLvoE4s6kricdI27ayotmGMxInXAGqlSxETqwXPgmQTWfQEiq2v+hYbCMVbY+yhe3JPlNB89o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oidusFvm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oidusFvm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf27856f9cso33640355ad.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440548; x=1787045348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vNNGPhfaOxrBSz23UppNcMWBRlmGWbtkLWYq2IeXVvY=;
        b=oidusFvm8cWMdoZUVAtMfmQSu9rULEMaw5KVUEgmMJZLrVdIU/klxDtcyYnFj25oxv
         rWZMQTUkfdcIN+y59RUePU6/WGzNRIXdJdnOcjVVQMXryuKpKOrni126MYKBbH63+tcR
         jCenwMgt48L9bY6xV3JeiAl66TpmFKAyY1AWi6L0bO7v2uKFBCiBVNvXZREb1hxedNa3
         U0MDS4ybkHtH8F4JcTLPWYmrOMB+zVdprx3zRtJ7XTu1e3qK3rcpQFEw7nGvcvOHN8Lc
         WCev3OArxtw3aKW1Fn23zlRmEw4pW2JWywoCUZm3vA33mnBB2U5dzrbbffaGe0dgFUfH
         j9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440548; x=1787045348;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vNNGPhfaOxrBSz23UppNcMWBRlmGWbtkLWYq2IeXVvY=;
        b=ZHVcvO0G6UwybOGsNfV7TfATIhSCHTveiTYEh4mgqegtlbaBXRRQYsl0971a62rYcW
         J2I8vw4YRHCNBZGXlIl6+Hg9V/3h+vHgdBus2MXqm03TEa+Vbqamp1PUjv8MeDF52HD/
         6SygH2OH6gSREOgws1nJswKcxMpc1jUGgTN8rnsCEms37+5M8Ff230B0UPxVPi1535vL
         ooeUWjBQGKFkGFZoQH21z6ie/+NpA9Vn6OyWRoS3OpgFH9aMRKDxsmcoPoZ+JhTNRZeY
         xE3fYMpSPfhLvz0JeriAft0lGqilfRXq9N0FoN1imvLOTAmMsAK5cAVCYA/E3xvwFMWK
         5WXw==
X-Gm-Message-State: AOJu0YxxxUSU/X8ETIhQfBHEvT6lEXO+kvUl3u5QJ1MsmB6JuXw9i0I3
	EcerlDAWXskJQ+vQCyOgB82fzo/okpqnNa/Z5DxTqk400QVs1layFgLvTEDDrkbE
X-Gm-Gg: AR+sD13kDdCxNP43KQPNxllPgEYND8MQSUYITpJB95WdWBbEE4s12BgTHjSsKksNSUy
	gYpbYvIF/ZWKOsvcB1Q4wckLi2TF7MK3H6vlZEIbTcRfOgNi2mRU3WLHjDAMS+aHWoa98+wnN4Y
	qoSakEn2MzzvvBGf398jPrJmoC8bJPut/MpMJaIq7LXHvSwgfzXG6Tn9bHa1qufmar0v2lUxtcM
	DRCaY4xQdDMCv9gDy3am8PSNDKYxeKj7cQ6JCx874yG+FRV+5mri0ZaGzPWIXiht8DQXl7Y2qsF
	hxmvoi9QNGXTaF7+eA/Eegzvk2xjZuzB4KWKkGSptHfm3Z5u0PXp3RDdvVqGSUvbxNvLOx5Ujip
	oS8YxjIboTv3N7NEo1EtfZVep+hivZZfFwADp/5umnp47jUxiPPf0pDzPjLIiNAtUCWjlsAdq7H
	plfvG0xrWIX793rhugpr0nmFoHGwWX8UYAw94EDsjlXa0IM1/0Khw1lDbVvcl7LRE=
X-Received: by 2002:a17:903:988:b0:2d0:cc92:f7ac with SMTP id d9443c01a7336-2d31791a673mr24596855ad.14.1786440547349;
        Tue, 11 Aug 2026 02:29:07 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315f44eefsm4701775ad.31.2026.08.11.02.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:06 -0700 (PDT)
Message-Id: <677e25077ce131fbd0ee52bfd61fbbefc23f9056.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:52 +0000
Subject: [PATCH v8 10/10] commit-reach: remove commit-date ordering fallback
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
check in paint_queue_get() can safely terminate once the walk
crosses below the caller's generation floor. The date ordering
fallback broke this invariant: a commit could have a finite topo
level while the queue was date-ordered, causing the early exit to
fire before all merge bases were found.

With the fallback removed, gen_ordered is always true and can be
dropped. The topo_ceiling field (introduced earlier) already
handles V1_MAX saturation, so the early exit gates need no further
changes.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       | 37 -------------------
 commit-reach.c                                | 15 +++-----
 t/t6600-test-reach.sh                         |  8 ++--
 3 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 2393bb03b6..c33c7ea7c1 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -148,43 +148,6 @@ candidate (generation ordering guarantees children are visited
 first), so it cannot be redundant and the walk can stop
 immediately.
 
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
-(via generation numbers) is disabled. Topological levels are
-correct but unbalanced -- ordering by such generation numbers
-can sometimes cause the walk to detour too far before finding
-merge bases. Commit-date ordering typically reaches them in
-fewer steps -- see this change for more details:
-
-   091f4cf3 (commit: don't use generation numbers if not needed,
-   2018-08-30)
-
-With generation number v2 (corrected commit dates) we have the best
-of both worlds and do not need this fallback.
-
-For v1, `paint_down_to_common()` falls back to pure commit-date
-ordering via `compare_commits_by_commit_date`. Because commit
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
index 32e65a52b5..ace49c0d91 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -89,7 +89,6 @@ struct paint_state {
 	size_t parent1_count;
 	size_t parent2_count;
 	size_t mb_candidate_count;
-	int gen_ordered;
 	timestamp_t min_generation;
 	timestamp_t last_gen;
 	timestamp_t topo_ceiling;
@@ -172,7 +171,6 @@ static struct commit *paint_queue_get(struct paint_state *state)
 
 		/* one side is exhausted */
 		if ((!state->parent1_count || !state->parent2_count) &&
-		    state->gen_ordered &&
 		    generation < state->topo_ceiling)
 			return NULL;
 	}
@@ -193,9 +191,13 @@ static int paint_down_to_common(struct repository *r,
 				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
+	/*
+	 * Generation ordering is required for the side-exhaustion and
+	 * single-result early exits, which rely on topological traversal
+	 * order (children visited before parents) in the ordered region.
+	 */
 	struct paint_state state = {
-		.queue = { compare_commits_by_gen_then_commit_date },
-		.gen_ordered = 1,
+		.queue = { compare_commits_by_gen_then_commit_date }
 	};
 	struct commit *commit;
 	int i;
@@ -207,10 +209,6 @@ static int paint_down_to_common(struct repository *r,
 	state.topo_ceiling = corrected_commit_dates_enabled(r)
 		? GENERATION_NUMBER_INFINITY
 		: GENERATION_NUMBER_V1_MAX;
-	if (!min_generation && !corrected_commit_dates_enabled(r)) {
-		state.queue.compare = compare_commits_by_commit_date;
-		state.gen_ordered = 0;
-	}
 
 	one->object.flags |= PARENT1;
 	if (!n) {
@@ -238,7 +236,6 @@ static int paint_down_to_common(struct repository *r,
 				 * descendant of this one.
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
-				    state.gen_ordered &&
 				    state.last_gen < state.topo_ceiling)
 					break;
 			}
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 23417897c8..13c84e0a42 100755
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
@@ -414,7 +414,7 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	>input &&
 	git rev-parse commit-9-1 >expect &&
 	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
-	test_paint_down_steps 81 9 57 81
+	test_paint_down_steps 81 9 57 37
 '
 
 test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
@@ -423,7 +423,7 @@ test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
 	>input &&
 	git rev-parse se-D >expect &&
 	run_all_modes git merge-base --all se-A se-B &&
-	test_paint_down_steps 6 4 6 6
+	test_paint_down_steps 6 4 6 4
 '
 
 test_expect_success 'merge-base --all with clock skew and redundant ancestor (side-exhaustion)' '
@@ -433,7 +433,7 @@ test_expect_success 'merge-base --all with clock skew and redundant ancestor (si
 	>input &&
 	git rev-parse se2-MB1 >expect &&
 	run_all_modes git merge-base --all se2-A se2-B &&
-	test_paint_down_steps 8 6 8 8
+	test_paint_down_steps 8 6 8 6
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget
