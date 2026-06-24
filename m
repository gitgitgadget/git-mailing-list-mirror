Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F162BEC43
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303271; cv=none; b=TS9LBhrmDKEMdmf6eLnxI2u1eZDE2YxP400n2dlFw5Bpcb8hlDR5ihrUiWTIWQANQgTGtoxGATgdSsD2aHKWrqYlC8x9YaZNjqmAUojqqbKBAYPDOEn1eZjBxANcUdrDBIp7mlriEaS6F/p5FKO3c5IMpuTJqKEW3cvvi+VRGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303271; c=relaxed/simple;
	bh=HvDCLc11wTtO6sC5Eyv4JivN/7K1wCAjLB/fV3SNHB4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KJ+NYBN0hnW5vWCqH/cHwDP/8qtuOInjIwzltaTLd/c6Z/jjgvw8mdTkUyH5uDvphdCLzInqhr15vuynqMgWKcS4dgkr9dhh3bXyl2Wa5CfwDddIbocMkyoNl87rTYNpgvcQ75VNPSdZ9QPLP3IRSO0CDuSxYookms7ejj9mzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgxSRlyK; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgxSRlyK"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-519eedc30a3so9270581cf.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303269; x=1782908069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jym4wQPdpjUlZF6TDZSCkYtnTM6W7Lda2iurHZercQw=;
        b=VgxSRlyKHPcvQ63Xroe6LonUvnAauYhc4dwgn9QKfFRqqxhdBxrc9IkTvd6w5x3+5e
         pRghD9UuBdzOlsz0iRcwMRoF//LAehoDy73GXh/WnbqWNXadhhql1uFjQzKPS2ATcVq4
         UcOCWdVw0pMUiHrNf++sl2pBDcC4PuttJ2bol1TK2zidBykeW6rvImFkB204BIFBBMhQ
         dOaMlD5p1iaOHLU1HR5BDDWMgSdYxme5PXkr9nfYqFZa9xa1BaIUUEcFogtQ4NzzU3CY
         EUN2UjHAyiBH9HsdJx2TsqyTjObjUodFY0OAtacUYwLdvEEerT3y+8mDBGG7itx08Emz
         GEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303269; x=1782908069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jym4wQPdpjUlZF6TDZSCkYtnTM6W7Lda2iurHZercQw=;
        b=OrDqjs30aYni8TGWOuXT/4wGaXwcq5Wz8t5CLZn+w8r4Ghqwhd1EedylkGjnYdKg1o
         Uljz5vIVm/R94eHz+oLS5a4PCsVdGPASjgxLCulaCoelLer2nFPsg90TOsbdaBsFnwHH
         SExdjcnGk2yXIwxFN/slC7j7RcQbJdYbP/daqJJgSUc+RllvS6rcPq/0Ka+OjF5VOHuk
         QrYSWQQV8Pd4TSZv2uS+dj8CCU0MbULwQdv/hHptKSe/ohGLirD8/M44apK89FYur4a0
         8wtUuPLW8kkP8LyGBj6GN9tNuq850OXNLAFy1u/zkpgRenTSQ6/oFsOvlb6ZbiI6+ttT
         8nKA==
X-Gm-Message-State: AOJu0YxMp0f+0H8MJmY1DeoGFmEtV6x0LKbPZXM0i765kPPWxA8/waAD
	hl6bVMOAqSxbPCe41os0SWv/Gf/a1r5q9IpIusZB+I5JTyPaanuI/OSZZiqWnNsd
X-Gm-Gg: AfdE7cnnerwPNJVjPFzEwRoB69YDskCzXsm3OAMFRIgRgu60s83Cgh7W9KNzHNwGaPM
	B3B4bY6Q0nQA86vjx9x11t7C6MDi0Tl64228SNVz8Wae6v2AyrTQInWybixupUS8a9t9bFKUnKK
	fQuRJ8R8qkgUHEKxYVfd0wF7K6WrzhDFU57UKfuApvSET/+JwOsXc86p5YjdgbAot/H6TwHJvIC
	MvWnpp8lMuMsTLNWZ/iEq5X31XR43fZ8cNi+QJcmF+FsfxwgmSPwnNwsIoAMbB+jkNz/rW37pdA
	mguuD2suqcOKGM6TW7ZXBHxKaVRzg+SjX/vBAPefcjWdaJnfROmr2l1hWubx6MDI/kq81NY8zJB
	Q04WhrOcxNqk06TIZwI68BFXm7IewAw8GcXWW5Nk9HxosLK8VG410p3L9u20qPz01NcGRn765+O
	Iemp2b0fJYjZWPoJw=
X-Received: by 2002:a05:622a:1dcf:b0:516:ce43:f4ee with SMTP id d75a77b69052e-51a61b46c76mr47026361cf.20.1782303268571;
        Wed, 24 Jun 2026 05:14:28 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.92.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm47323091cf.10.2026.06.24.05.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:14:27 -0700 (PDT)
Message-Id: <d84b932e5b078edc8255b6944ecb67fc1aa086b0.1782303254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 12:14:13 +0000
Subject: [PATCH v2 7/7] commit-reach: terminate merge-base walk when one paint
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

Step counts measured with trace2 on git.git with commit-graph:

  merge-base --all v2.0.0 v2.55.0-rc1:
    before: 72264 steps    after: 44589 steps

  merge-base --all v2.55.0-rc1 v2.55.0-rc1~5:
    before:   110 steps    after:     7 steps

Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       | 17 ++++++++++++
 commit-reach.c                                | 27 ++++++++++++++-----
 t/t6600-test-reach.sh                         |  4 +--
 3 files changed, 39 insertions(+), 9 deletions(-)

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
index e0d9874f99..f79d0b64d6 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -133,17 +133,30 @@ static void paint_queue_put(struct paint_state *state,
 
 static struct commit *paint_queue_get(struct paint_state *state)
 {
-	struct commit *commit;
+	struct commit *commit = prio_queue_get(&state->queue);
 
-	if (!state->p1_count && !state->p2_count &&
-	    !state->pending_merge_bases)
+	if (!commit)
 		return NULL;
 
-	commit = prio_queue_get(&state->queue);
-	if (commit) {
-		commit->object.flags &= ~ENQUEUED;
-		paint_count_update(state, commit->object.flags, -1);
+	commit->object.flags &= ~ENQUEUED;
+
+	if (!state->pending_merge_bases) {
+		if (!state->p1_count && !state->p2_count)
+			return NULL;
+		/*
+		 * Side exhaustion: a new merge-base can only form
+		 * when both PARENT1-only and PARENT2-only commits
+		 * remain in the queue. In the finite-generation
+		 * region the queue is ordered topologically, so
+		 * no future step can add paint to visited commits
+		 * and an exhausted side cannot reappear.
+		 */
+		if ((!state->p1_count || !state->p2_count) &&
+		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
+			return NULL;
 	}
+
+	paint_count_update(state, commit->object.flags, -1);
 	return commit;
 }
 
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index c1109fb42f..03175befb3 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -332,12 +332,12 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	cp commit-graph-full .git/objects/info/commit-graph &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-full.txt" \
 		git merge-base --all commit-9-9 commit-9-1 >actual &&
-	test_trace2_data paint_down_to_common steps 80 <trace-full.txt &&
+	test_trace2_data paint_down_to_common steps 9 <trace-full.txt &&
 
 	cp commit-graph-half .git/objects/info/commit-graph &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-half.txt" \
 		git merge-base --all commit-9-9 commit-9-1 >actual &&
-	test_trace2_data paint_down_to_common steps 81 <trace-half.txt
+	test_trace2_data paint_down_to_common steps 57 <trace-half.txt
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget
