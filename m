Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074B3A1693
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649569; cv=none; b=oxSOKXvHwhB5uUx6C9ER1hBXPKAmZyBSUWfIa5qG5Z+jGUpbv3jzNpwhiERyyhc832pjjZqJjeBOstYNp+uRkx5B+tvJa4Dxew7BZ7fGcoR1ynyF/W2Mr7MIO+ptXsfrjZHA0LB7PUtE1LDLEFhTospCuEGSUBvBz6zHUYimjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649569; c=relaxed/simple;
	bh=+z2h7zWZ5SjcBrrh8W868pXNJbrUnhRunT5ot4k3KBY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lsIY0VwWrT4BkkLNtpydp89OKtkp+8DlYDJuGOq8w5z6J1RavCkHymLgTPxISWbZX8ngxEEqHWJttXG7M7k7ZzFrvR9Yiqanz38wtqxBvbgfEylEqYrg1dtEmIAxqG4W1xpsX4CLgGwI1kxOdFh5MwDwuTrzLk4P/VAhVEwAFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6yOEkqp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6yOEkqp"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e50c5d14cso1276085a.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782649567; x=1783254367; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4BW5O2CS0IiTR7a3rgkFJ1ltt5YpO7v6CRU4AlLG/c=;
        b=N6yOEkqpTClRQC2tC1PfsWpicqZZJec9jJdntT1+AheYfLYex9KQh4jsIcmGTVXRFX
         H9OFEaWyte0HldmKvvJY8C7rbxLkV4bOufReJlLDCUIv0KNiKnzeVt/usmr7uDqfVQlO
         /D+qhH1BQXvBpd3LaR389V0Jtdk7J6XVMgVv/tz+dD7Naixqtp2luKfITnz/y3j+keNW
         cvhyZytgtdyA6sL7iXkbc7iw6+suJVqw4dWRiH3H7V/c4tVzJ/O20nNYfBkD0l6TA5m8
         Au4NmIWZVSGWBFbYVr58+95J4EJDydM7ukHW/5ExDTBtB6XE6qDxgsyNSm0eB98WGI6N
         leIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649567; x=1783254367;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4BW5O2CS0IiTR7a3rgkFJ1ltt5YpO7v6CRU4AlLG/c=;
        b=JJG9S2Mz4IreW5bQzRz7FiH34f/1qdBO0hI10TQCOsW6XRRJqiOjNy7Kx24kUNZsle
         673jkO1LxueP9HYEynbg3nSsuoP2r4LI+daE2PAIvKo344K6Nv6yF5KXNL86TT7LkDzU
         QEXRLMS4ksAcPKNu5DXiymGbaOh2AZlfyz9wJ8imsFZAgElAOoeLmYJlptDhDglWkMTE
         LoS5De5A1zrUtiHNG3UjPw5Yr88xhYVW20EekBazqvx+5UW40WCfLA2UXgO0euyLFKe2
         AKyZlpXrnaHq2YXTpsdR7rBnpJJVpaq2+uxQvi79OhhxOj5ORGYey5srtqtOP4IKL0TZ
         w/vw==
X-Gm-Message-State: AOJu0Ywl2PBDQ5e2K88b7eC0N0UeS6qZuetAIGbLuTmuKrUVp4EF+JVQ
	+RHcVchKhYUFZ5ZuLyWorDSIrEQi1uv8kXYQ2H3tNchpM98UvOiUv/XUm+/QHw==
X-Gm-Gg: AfdE7ckcjeWw6+kvypMBICKonRS9SuEFqTxBFA0CB1mxijQ+ZPlccbQnynHWFYfLaxk
	+L/aAF0WtL7xE89vONcZJA/lAto8pYALBdL87H8jcrEa1djAlEM8PMvKn1xzJjr4GXIEMvJNWCP
	Ep1cQYZqlrVjToLKCmCHBwjYP+Ut9aVbRhOlaN8/sYHZ2jxzmLpUWeLd//25K+R5i3P5SNiNqlZ
	UOJamOETRtUKaiGcAw2Kwy5G4WxDdNmukrA7yx8kL4ZygDCDyc73izwVS6YUGBkX/85sky5c+Oa
	ug475v5Ee0XCyqXkTpToUqoO7bEYwBk1FDWKfjNdwJrawEBafO7xtEdRMTsQLtlvCpUcg7FfROh
	KbcQQjvuBH5w7cBTcfYlFa+5jeJx1m60Kzl7zrPLDnAEvGWdm1W3bPHLNAEw1YFUL6HrdZHRLiD
	a0UpxqlSgMWxTDUwfZ
X-Received: by 2002:ac8:6f1b:0:b0:517:260f:8ea0 with SMTP id d75a77b69052e-51a8b2a4368mr105975711cf.56.1782649567267;
        Sun, 28 Jun 2026 05:26:07 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51addb1csm143288261cf.23.2026.06.28.05.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:26:06 -0700 (PDT)
Message-Id: <450678064972beae5f21b9135e34069a1a8ea585.1782649547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
	<pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 12:25:45 +0000
Subject: [PATCH v4 7/8] commit-reach: terminate merge-base walk when one paint
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
per-side counters introduced earlier.  Once the walk enters the
finite-generation region, terminate early when one side's exclusive
count drops to zero -- no new merge-base can form without both paint
sides meeting.

The check also waits for pending_merge_bases to reach zero, ensuring
all merge-base candidates have been dequeued and recorded before
exiting.

The INFINITY gate ensures correctness: commits without a commit-graph
entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
which is not topologically reliable.  The optimization only fires
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
 .../technical/paint-down-to-common.adoc         | 17 +++++++++++++++++
 commit-reach.c                                  | 17 ++++++++++++++---
 t/t6600-test-reach.sh                           |  4 ++--
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index ac3e2b39a5..15adac7885 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -99,6 +99,9 @@ ends when one of the following conditions holds:
   4. Single result: the caller only needs one merge base, one has
      been found, and the walk has entered the finite-generation
      region.
+  5. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
+     remain in the queue, no pending merge-base candidates exist,
+     and the walk has entered the finite-generation region.
 
 Stale entry condition
 ~~~~~~~~~~~~~~~~~~~~~
@@ -109,6 +112,20 @@ existing candidates by proving one is an ancestor of another, but
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
 Generation cutoff
 ~~~~~~~~~~~~~~~~~
 Some callers (notably `remove_redundant()`) supply a `min_generation`
diff --git a/commit-reach.c b/commit-reach.c
index 176ffd68d0..e174b219c6 100644
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
 
-	if (!state->parent1_count && !state->parent2_count &&
-	    !state->mb_candidate_count)
-		return NULL;
+	if (!state->mb_candidate_count) {
+		/* only stale entries remain */
+		if (!state->parent1_count && !state->parent2_count)
+			return NULL;
+
+		/* one side is exhausted */
+		if ((!state->parent1_count || !state->parent2_count) &&
+		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
+			return NULL;
+	}
 
 	paint_count_update(state, commit->object.flags, -1);
 	return commit;
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

