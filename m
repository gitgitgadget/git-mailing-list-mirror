Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA973C415C
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776487; cv=none; b=UEu1wBIwzyKOzUZJ8WZqecklSPJxojz6nFY5cbhDXMd9Es1jDzBSVkWXOK84bZ6i3t+ZYaXqwatfBhCn6k0HZH/mix1Bid/96b446j6nw9YKCkWjsd78jnpi81uHS61gsSzGOtzKZRWhjeGqWdRlBKYgGK2OdRIUCNKcy3bjOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776487; c=relaxed/simple;
	bh=dvYVgnKWW5DySTqWii39z5LmjNjsATRPXhi0A1bHtAE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rMKSGfwFnK+nJCKCSGWVONeGe0wI/5TW8seycaBnH2UsK31g5plorHVlKWZXwaEH5R0dLZae/CndbJqIPF5B6rT/vbXMQ0sG6I+hCEzX0Qlk4wtbkqTXJKmDSgT6jU5ApN3UpKboPFZZgBlK6MH/2xHUTRsRJleWAsXqoD5ItwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgS3JZfa; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgS3JZfa"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so1228047a12.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776486; x=1784381286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FRQioRPfgOeYycyB9tumx/EWMc/FHr9W3S2yMq8AzpA=;
        b=LgS3JZfaeFr9UNx1uIQR+G5/jaeGNRMFkot9YikiYpUZgPcSMq5+SJX/UUyJ5lxUuF
         9L1JQKvcb0CQ/54RChdkOi3y0bIQwzgu2nALAmQ2P42wWpgbcEQltwvCA1Si8hioM+js
         lOatpvfDw7oQ6MUPWsMD9SlzMaBWbeWi6SgB4V584FpcREza2pUqvQYmuPeUnwRA26IC
         Ey7hugkTecovp9YNaS44w9rRGLM+SzLWmSrtnFImi1KdT7xdM0XPq+ThpR/HngPinTS7
         Drt0k4qx6+aOGvuv5uPNO8zIGEjCtvV4Z0kuv4X8vcnO2TSKmgQIboaFS4tNxpJ/KDNw
         +7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776486; x=1784381286;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRQioRPfgOeYycyB9tumx/EWMc/FHr9W3S2yMq8AzpA=;
        b=oDSqQgaRBSkPslM/v95MCPl1QiUT8fnPRW6PqbJU4xzRwmy9a7wqK9J2/QRh8sz3EA
         vLFx0VMAKJRbwDa4DWnjW1pVne4sqgUSsdP9DPU+qlZ16aa71AgrL+5fEuw0n5UlUmnz
         dqACeFQcIi9g1TOuC/R3udAzIEhR8J2n2WgLsj5qhcY9z5pKsVPhak1goQuLlZAQxDXB
         lLAfDy7TfIR/s3ivIgvgEjj9hdH1+6GYXoMReHNyO0PLzweaIqJc0Dbbm78xcZVsevgW
         za7J/YDlYIuHNN5DfiUQ6qTR9+J8Ey6azpps5FwLHzFQz18WAeN+lg4oXZt9ehzeTDSX
         v23g==
X-Gm-Message-State: AOJu0YyeRnVhxWgpvFhhTq0+1EqiIzJV+8dF3IvblJXwuD3S92Ky9pem
	rTg1iZPD8T2jy7q5oihYFO5l5yYkLxWn0fGR3M9/ISeoIaQr5v90yPt9ID6fIw==
X-Gm-Gg: AfdE7clDxtwWHqX/zt/1C9dBvESeLTI8h8VEsm0avkf8ryfSKRPnSHIvTKhNlIip396
	XWSN12MUgXAWMe1UpRURPLLZzt7JJ9kdTuukMHnYH4bkJMEee7DLFb57yTP4XaV8No9tle84LVU
	k7txVr8xKBtmRkQueS5A7n0AuGVaYPKORKjNSwtry9iancFOs9L1IF0C4KjRECjDy7TJJK5GIx2
	hn/YcMHMuvQbIOuQWyc5lRXkbCwgWzOVvmfOVAKXdadTSrPsGO1Cx1hbnmE3K+CGHHAo9KgtUz3
	JrKS8mNvFrL1doPKyYfYzxftgOTnZuyUZUAb7q6s9DjjlF/nunCjfAREVK6lAlG2KXCfhKwAD07
	qi8QjfNFJRkW3d6LilQ4UomV530qX7oAGh201wWkyItSuDtrcZf3qpSVXKrAhEy1ja1BaTgZPYG
	Z9tZPOe+ZxHfzr49A=
X-Received: by 2002:a05:6a20:431a:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3c110a4b297mr2908012637.19.1783776485653;
        Sat, 11 Jul 2026 06:28:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm90815400c88.14.2026.07.11.06.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:28:04 -0700 (PDT)
Message-Id: <0d552869bec1506187d5ade7a36a6a5d97ae2ed0.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:43 +0000
Subject: [PATCH v6 08/10] commit-reach: terminate merge-base walk when one
 paint side is exhausted
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
 .../technical/paint-down-to-common.adoc       | 23 ++++++++++++++++++-
 commit-reach.c                                | 18 ++++++++++++---
 t/t6600-test-reach.sh                         |  4 ++--
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 3b3f7ac8af..7ae9b11529 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -105,6 +105,9 @@ ends when one of the following conditions holds:
   4. Single result: the caller only needs one merge base, one has
      been found, and the walk has entered the finite-generation
      region.
+  5. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
+     remain in the queue, no pending merge-base candidates exist,
+     and the walk has entered the finite-generation region.
 
 Stale entry condition
 ~~~~~~~~~~~~~~~~~~~~~
@@ -115,6 +118,20 @@ existing candidates by proving one is an ancestor of another, but
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
@@ -159,12 +176,16 @@ ordering via `compare_commits_by_commit_date`.  Because commit
 dates are not monotonic (clock skew, rebases, etc.), the queue
 may visit commits out of topological order.
 
-This disables the optimization that depends on generation ordering:
+This disables the optimizations that depend on generation ordering:
 
   - *Single result*: the first merge-base candidate found may not
     be the shallowest, because a deeper ancestor with a higher
     commit date can be dequeued first.
 
+  - *Side exhaustion*: one paint side can appear to drain from the
+    queue while commits from that side are still waiting with lower
+    dates, causing premature termination.
+
 Related documentation
 ---------------------
 
diff --git a/commit-reach.c b/commit-reach.c
index ed5e935efd..eabd689e52 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -132,6 +132,10 @@ static void paint_queue_put(struct paint_state *state,
 	}
 }
 
+/*
+ * Dequeue the next commit for the paint walk, or return NULL when
+ * no more merge bases can be discovered.
+ */
 static struct commit *paint_queue_get(struct paint_state *state)
 {
 	struct commit *commit = prio_queue_get(&state->queue);
@@ -141,9 +145,17 @@ static struct commit *paint_queue_get(struct paint_state *state)
 
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
+		    state->gen_ordered &&
+		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
+			return NULL;
+	}
 
 	paint_count_update(state, commit->object.flags, -1);
 	return commit;
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index f9895f5fd7..6bf17cb7b6 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -297,7 +297,7 @@ test_expect_success 'in_merge_bases_many:self' '
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
 	test_all_modes in_merge_bases_many &&
-	test_paint_down_steps 45 2 25 3
+	test_paint_down_steps 45 1 25 1
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -414,7 +414,7 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	>input &&
 	git rev-parse commit-9-1 >expect &&
 	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
-	test_paint_down_steps 81 80 81 81
+	test_paint_down_steps 81 9 57 81
 '
 
 test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
-- 
gitgitgadget

