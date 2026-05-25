Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9D3ED5DC
	for <git@vger.kernel.org>; Mon, 25 May 2026 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719292; cv=none; b=uAvq+58Q7J9F4Mo6b+qqIULT1ReRAd6pGKltk4l8cJSTHxHesjsvy7khdj0HD6gPFbda4nw/buAlMEhC4aYLbHfyuUMxFOW2gJvdPIlVZlXmxNOeU7UmCn0jI2yDInaqToUhj5uz+CavIDMdS6Ow2XsQUMJF7uwWcqZRiu0S4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719292; c=relaxed/simple;
	bh=T5QnS3hRZ3geLtHfpfQ89Fc8B9tk2qtYpqBlQe+itvY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Ey+X+qZVXIFpnFwgG6sTrT08SZiK0n6dWmJnOVCyLJOV/5zpzj9CA+Ecdc13w7PZ70jT+/fOyWC7aCo30xNAiZ1mFXYwR0KmF61CvPJiOpa92p8m8gJ7z4u8d0QvVXoDm2YMsIJQ8Tpbp1DSPsetWgtIVxf8NRsxKStILAKtLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+JID7tn; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+JID7tn"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8c7154725easo111762956d6.0
        for <git@vger.kernel.org>; Mon, 25 May 2026 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779719290; x=1780324090; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3bTGYXpHf75cyfvMbYtqfG2xBB/qYRQNqCyOnpq2lk=;
        b=s+JID7tnPB6Y89yBez+NgXEHhFI2bm/e8mGkONnwntUHZLKR330kcCES8bMsTYHUw9
         gaUNTdcrxgrs8pVXn2ILwqyjcC6vnGPul9FUwQInDn+h0fXvJZPp5z9qweJA31c/3mSR
         izWDIWAuxZWbTnZc4dOHiqru6KGxH2sC+3PFH4uJeE0/dujWqbR25RHB+ek4orYeX3qx
         SqIONbukuVmfSa71Hgn6+4TcLf6zscVOs3AbtDEuPJUl6c97PoKMOKjSWXsi/gBtyZ1h
         yK90fUrY70ljmRADcVq1MyKvaRq1mo834lUUiY9qKohoSCyw+cIBO+xgHBvfvEenEDQ+
         7QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719290; x=1780324090;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3bTGYXpHf75cyfvMbYtqfG2xBB/qYRQNqCyOnpq2lk=;
        b=NOth6L4p5cvlhbe0upOG/BcjIG0CFmZNBVsoBzY+YklBaR12Yv6cjnK6apQ75DEeJf
         oXUIOQbHep1wQRSEPXelaZxUkLEL4WyRBf6tT5II9L06HHP84gGGVLhTtuNv2tG7D6po
         wTAzRVhAHSAS5qBa1SYYLGqKpzg/1QTaZ3R4aYa3GxeVMXI4vNaYHXrsPqxPtrHRxFRK
         k2VEv63KV3UUV6Lzdjp/CV/jgRM1grm0ZZde3SpiXtoROiQlh7zsUmW514lxsz6tGsC4
         0fICiSn+eGp1BpnpL1firnRTMljb7HhuCKuO+aBQcHGNb8XIgxieLztLQsAX72R2Hjbl
         SUxg==
X-Gm-Message-State: AOJu0YxZ2zaNTifLeVuWthv285L/lNM0dzmhlXa34NfuC7VELPpy6N+l
	ya6Tz8/EaTZxACrIoLWj6OEWbisLVwPmW+nL0XQEuZCxwDVMlf5IVUXStP3DSA==
X-Gm-Gg: Acq92OG/IFIrjioCwSl+h615xm5hlQkL8jcZyP0BYpyVvfASy5n7a+qmwRFJHAo4eAT
	U0n0NvDBQl13zlFWPaxa0E6CEQUGvAxooGcbs+8JUomsM+Mk2buyHYzLfh2xHsMBPwMHn/Lq5IK
	LEgvKjHR2tLZOc2XX76wyx/qzqxdAHIEYYuZF37edm3KzMqZ5h1hjFhCFenvJVyvcsJqvF54f8W
	8B9Xhl5mry35gJ4oxdU8jqUV3njzZPDtr3yoadsbM6J78GENnIbydfOhfOII3RR6jP/NC3MI9DZ
	2dPJ+9roLOJJlA7l4Ic9jclpYftCT9B+c+upXhyVRYIJs18OgYNgF8meTgLGvEUP291H+kEKV5u
	Vpz446YEgNwua855XFFWl0DmDNlT6f+3dVpzu8Y86xUtXjkMKUi5cYUnyE4O6bwyzl6PFCV2Lmy
	0X18xmQNOySXrihI8WQKXDW84=
X-Received: by 2002:ad4:5744:0:b0:8cc:d29:9f78 with SMTP id 6a1803df08f44-8cc7b6009d6mr231681046d6.11.1779719290109;
        Mon, 25 May 2026 07:28:10 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.135.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e6832sm110453396d6.30.2026.05.25.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:28:09 -0700 (PDT)
Message-Id: <03771eb34c3ef1a896f5a63b4247b0a79f1589bb.1779719286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2124.v2.git.1779719286.gitgitgadget@gmail.com>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
	<pull.2124.v2.git.1779719286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 14:28:05 +0000
Subject: [PATCH v2 3/3] commit-reach: replace queue_has_nonstale() scan with
 O(1) tracking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Jeff King <peff@peff.net>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

paint_down_to_common() and ahead_behind() call queue_has_nonstale()
on every iteration to decide whether to continue the walk.
queue_has_nonstale() performs a linear scan of the priority queue,
making the overall walk O(n*m) where n is the number of commits
walked and m is the queue size.

Introduce 'struct nonstale_queue', a thin wrapper around prio_queue
that maintains a 'max_nonstale' pointer — the lowest-priority
(oldest) non-stale commit seen so far. When this commit is popped,
every remaining queue entry is known to be stale, so the walk can
stop. This reduces the per-iteration termination check from O(m)
to O(1).

Uses <= 0 (not < 0) when comparing priorities so that among distinct
commits with equal priority (same generation and timestamp) the
last-enqueued one is tracked. Since prio_queue breaks ties by
insertion order, this ensures max_nonstale is always the last in its
priority class to be popped, making pointer equality on pop
sufficient for correctness.

The previous commit's ENQUEUED deduplication guarantees each commit
appears at most once in the queue, which is required for the pointer
equality check to be unambiguous.

On a large monorepo (3.7M commits), this yields ~2x end-to-end
speedup for merge-base calculations on deep import branches.
Profiling shows paint_down_to_common() drops from 50% to 4% of
total runtime (~27x faster), with the remaining time in commit
graph lookups and heap operations:

  Before: 8536ms / 5757ms / 4743ms  (three test cases)
  After:  3956ms / 4383ms / 1927ms

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 96 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 85583ae359..b5328a804c 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -40,32 +40,62 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	return 0;
 }
 
-static void prio_queue_put_dedup(struct prio_queue *queue, struct commit *c)
+/*
+ * A prio_queue with O(1) termination check.  'max_nonstale' tracks
+ * the lowest-priority non-stale commit enqueued so far; once it is
+ * popped, every remaining entry is known to be STALE.
+ */
+struct nonstale_queue {
+	struct prio_queue pq;
+	struct commit *max_nonstale;
+};
+
+static void nonstale_queue_put(struct nonstale_queue *queue,
+			       struct commit *c)
+{
+	struct commit *old = queue->max_nonstale;
+
+	prio_queue_put(&queue->pq, c);
+	if (c->object.flags & STALE)
+		return;
+	if (!old || queue->pq.compare(old, c, queue->pq.cb_data) <= 0)
+		queue->max_nonstale = c;
+}
+
+static struct commit *nonstale_queue_get(struct nonstale_queue *queue)
+{
+	struct commit *commit = prio_queue_get(&queue->pq);
+
+	if (commit == queue->max_nonstale)
+		queue->max_nonstale = NULL;
+
+	return commit;
+}
+
+static void clear_nonstale_queue(struct nonstale_queue *queue)
+{
+	clear_prio_queue(&queue->pq);
+	queue->max_nonstale = NULL;
+}
+
+static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
+				     struct commit *c)
 {
 	if (c->object.flags & ENQUEUED)
 		return;
 	c->object.flags |= ENQUEUED;
-	prio_queue_put(queue, c);
+	nonstale_queue_put(queue, c);
 }
 
-static struct commit *prio_queue_get_dedup(struct prio_queue *queue)
+static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
 {
-	struct commit *commit = prio_queue_get(queue);
+	struct commit *commit = nonstale_queue_get(queue);
+
 	if (commit)
 		commit->object.flags &= ~ENQUEUED;
 	return commit;
 }
 
-static int queue_has_nonstale(struct prio_queue *queue)
-{
-	for (size_t i = 0; i < queue->nr; i++) {
-		struct commit *commit = queue->array[i].data;
-		if (!(commit->object.flags & STALE))
-			return 1;
-	}
-	return 0;
-}
-
 /* all input commits in one and twos[] must have been parsed! */
 static int paint_down_to_common(struct repository *r,
 				struct commit *one, int n,
@@ -74,28 +104,30 @@ static int paint_down_to_common(struct repository *r,
 				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
-	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	struct nonstale_queue queue = {
+		{ compare_commits_by_gen_then_commit_date }
+	};
 	int i;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
 	if (!min_generation && !corrected_commit_dates_enabled(r))
-		queue.compare = compare_commits_by_commit_date;
+		queue.pq.compare = compare_commits_by_commit_date;
 
 	one->object.flags |= PARENT1;
 	if (!n) {
 		commit_list_append(one, result);
 		return 0;
 	}
-	prio_queue_put_dedup(&queue, one);
+	nonstale_queue_put_dedup(&queue, one);
 
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
-		prio_queue_put_dedup(&queue, twos[i]);
+		nonstale_queue_put_dedup(&queue, twos[i]);
 	}
 
-	while (queue_has_nonstale(&queue)) {
-		struct commit *commit = prio_queue_get_dedup(&queue);
+	while (queue.max_nonstale) {
+		struct commit *commit = nonstale_queue_get_dedup(&queue);
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
@@ -133,7 +165,7 @@ static int paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
-				clear_prio_queue(&queue);
+				clear_nonstale_queue(&queue);
 				commit_list_free(*result);
 				*result = NULL;
 				/*
@@ -149,11 +181,11 @@ static int paint_down_to_common(struct repository *r,
 					     oid_to_hex(&p->object.oid));
 			}
 			p->object.flags |= flags;
-			prio_queue_put_dedup(&queue, p);
+			nonstale_queue_put_dedup(&queue, p);
 		}
 	}
 
-	clear_prio_queue(&queue);
+	clear_nonstale_queue(&queue);
 	commit_list_sort_by_date(result);
 	return 0;
 }
@@ -1057,11 +1089,11 @@ struct commit_list *get_reachable_subset(struct commit **from, size_t nr_from,
 define_commit_slab(bit_arrays, struct bitmap *);
 static struct bit_arrays bit_arrays;
 
-static void insert_no_dup(struct prio_queue *queue, struct commit *c)
+static void insert_no_dup(struct nonstale_queue *queue, struct commit *c)
 {
 	if (c->object.flags & PARENT2)
 		return;
-	prio_queue_put(queue, c);
+	nonstale_queue_put(queue, c);
 	c->object.flags |= PARENT2;
 }
 
@@ -1086,7 +1118,9 @@ void ahead_behind(struct repository *r,
 		  struct commit **commits, size_t commits_nr,
 		  struct ahead_behind_count *counts, size_t counts_nr)
 {
-	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
+	struct nonstale_queue queue = {
+		{ .compare = compare_commits_by_gen_then_commit_date }
+	};
 	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
 
 	if (!commits_nr || !counts_nr)
@@ -1109,8 +1143,8 @@ void ahead_behind(struct repository *r,
 		insert_no_dup(&queue, c);
 	}
 
-	while (queue_has_nonstale(&queue)) {
-		struct commit *c = prio_queue_get(&queue);
+	while (queue.max_nonstale) {
+		struct commit *c = nonstale_queue_get(&queue);
 		struct commit_list *p;
 		struct bitmap *bitmap_c = get_bit_array(c, width);
 
@@ -1152,10 +1186,10 @@ void ahead_behind(struct repository *r,
 
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
 	repo_clear_commit_marks(r, PARENT2 | STALE);
-	for (size_t i = 0; i < queue.nr; i++)
-		free_bit_array(queue.array[i].data);
+	for (size_t i = 0; i < queue.pq.nr; i++)
+		free_bit_array(queue.pq.array[i].data);
 	clear_bit_arrays(&bit_arrays);
-	clear_prio_queue(&queue);
+	clear_nonstale_queue(&queue);
 }
 
 struct commit_and_index {
-- 
gitgitgadget
