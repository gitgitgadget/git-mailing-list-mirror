Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8A222565
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781951828; cv=none; b=gZiigK2OT9XSlefQaYvt3KV7FxGpvljMtueKyz5nhj/wK9owP3xoLjOHgIUsIqlYLojqLsM7JgpRoNC8Xsu66k3UdnpKEGAl6Sp6YsDbHEb5YNzSH57i/j7O1WkOkNS/Mz7hJV1iCd/TIRzbuIPGNLq6KeciiAE9BmcN1Ti99sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781951828; c=relaxed/simple;
	bh=JGHK3KUZi5desxU44kbYFXw1hKsjSBbi4COB0ODcCX0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A1vc07jdiKkMvdMDgKUzAbQRkbF9St3WD5KDrp7F9cX0zl2iKwMl5b0PFcGmWVeVahTe/4Z/V/ReqwB7zJNxjJBDxOW4AtjAzRqo7z0KgB4RTLJfFEhfz3b0Oo969oRkCBWinJ+kX1nsb8nEAyImARKlpeWV7HwzetTmG2XP5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG3V8P0x; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG3V8P0x"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30bcf74e617so6079745eec.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781951826; x=1782556626; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZxIJ4RFGNnEsUXdy7qZKQ3mFBaYGeGHL0+RPgHVUM8=;
        b=nG3V8P0xzrWUwn06ivAocPcYIBu/iXHMl2DNn0to9IS1nfHfH55GZy5YN9Ot4jt7e/
         t/Gr9ZyPPkGSgTDWaQlZ49TPCK/w1y0F9wuPCGQagSdiVwCb0XjHmFT52RGW2CaMa2cR
         jatUjto0Xl/iJAq9euNDH9Pzd0V+svCuDIne0K5aMB0zusFH17ILUBbUeaCg3Z4jV8qH
         FHkM8CaOAVPoGH53O81YhBOmRmqC/yuMxgTLeSIPjh7KO1kETe2Yq0fI80YPqKf+Gb6j
         4kZqI9xPeFcYMsc1to/qLMWrtRVIiaQugX/sN3jofZ6za0YID/rGGT5o5NHKkSHlHptf
         uGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781951826; x=1782556626;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZxIJ4RFGNnEsUXdy7qZKQ3mFBaYGeGHL0+RPgHVUM8=;
        b=cuD7UEpW7ZPTzoXsfWhwBQfWk9w7H9e7C8a3/LfYY7pEGg10UBh3VFrL/A6N1Fevf5
         XaacWHzIqMpmS4i71tSjdBEXCdlgjc2UHoZzxpc1u0/7tJnCUBmF8FTlIVtk9qpa4fja
         GOqQ6A/a6zsAyxXRRKZ0MJmNroMH7ZWisFoktfgu9bNOCu0L0CzFmfSz9T+KTRoMaclT
         169eRhjT7QsZFjzKdrQMQkrgRY9oavhw+aYs/W1LnikbArab9oB6uZs6H/AGw1URvO93
         atTey2/sZPus1HcCHgmpAVTnYq1zAxEAZL6vasQqqsE0r5mDI41ERcWS++7gT+oEWTYP
         PO+g==
X-Gm-Message-State: AOJu0Yw6gAXIjkOdeQ1JukxDusJGyq2ncEI//Wp5j4qmch05UpYAP+4J
	/F5H3WWwhkGzLpwtEHA069PZEVQQvjO/DdNX0HvBivuMIYRDGBqkfgM4MrJ+AVTN
X-Gm-Gg: AfdE7ckDeQV5YEPfqw4vNI72e5SpMqxD/e1JQg+klK9UxFtPcqPDbA5VlfTtC1EjjFc
	+Ja9drEdcY+aSLwGc5FiuHBQwYtJRUrNJYtMlMyETSFpcznJCXHJ4iex57n0yUm+6nNR3nLKw0u
	WAZD07f+w93cWeEIWf3HzFu3knY03nrvRQGqHBVKfAkAoVIQsD6g+/2U27hSBuk2lFfKDoaiFk7
	56McJGhTAO5hPSgO2BJ+WCVkefeJ05azt8SvGra9hjm7NjT7cO7aTyQZK5CotpV2YnT9w4g+7F1
	tq1HdwQlwbCWv1hn0erFCZCPRAQ5tkq9pvQ0vNcRHd9MzQpwECfFCynVCeBtvoJ3VGQTQ9AH/MQ
	4QqMRWXDlxFiEPgOOmpIARe4OPxY7EVJkqsbedLc2+4clAKZSY+RNRzbOBi67Ef/i6nN05b0Bh5
	0eaxKhMc8xhrg8zkI3nKE8WKOytr0=
X-Received: by 2002:a05:7300:6da6:b0:304:de28:1b16 with SMTP id 5a478bee46e88-30c1dc4b98dmr2029418eec.28.1781951825787;
        Sat, 20 Jun 2026 03:37:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.54.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f137sm3094728eec.1.2026.06.20.03.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 03:37:05 -0700 (PDT)
Message-Id: <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 10:36:55 +0000
Subject: [PATCH/RFC 2/6] commit-reach: introduce struct paint_queue with
 per-side counters
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

Replace the nonstale_queue abstraction in paint_down_to_common() with
a new paint_queue struct that tracks per-side commit counts. Each
non-stale queued commit occupies exactly one counter bucket based on
its paint flags: PARENT1-only, PARENT2-only, or both sides (a pending
merge-base candidate).

The counters are maintained by paint_count_transition() which handles
all flag changes as bucket transfers: remove from the old bucket, add
to the new one. Either step is a no-op when the respective state has
no bucket (stale or zero).

The loop now drains the queue via paint_queue_get() and breaks when
all counters reach zero, replacing the old pointer-based termination
(max_nonstale). This is equivalent behavior.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 114 ++++++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 48 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 377a5cc42a..ba1e896f0f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -41,58 +41,75 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 }
 
 /*
- * A prio_queue with O(1) termination check.  'max_nonstale' tracks
- * the lowest-priority non-stale commit enqueued so far; once it is
- * popped, every remaining entry is known to be STALE.
+ * Priority queue with per-side commit counters for paint_down_to_common().
+ * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
+ * PARENT2-only, or both (a pending merge-base candidate).
  */
-struct nonstale_queue {
+struct paint_queue {
 	struct prio_queue pq;
-	struct commit *max_nonstale;
+	int p1_count;
+	int p2_count;
+	int pending_merge_bases;
 };
 
-static void nonstale_queue_put(struct nonstale_queue *queue,
-			       struct commit *c)
+/*
+ * Adjust per-side counters for a paint-state transition.  Non-stale
+ * commits are counted in one of three counters: PARENT1-only,
+ * PARENT2-only, or both.  Zero means "not in the queue" (used on
+ * enqueue/dequeue); stale commits are not counted at all.
+ */
+static void paint_count_transition(struct paint_queue *queue,
+				   unsigned old_flags, unsigned new_flags)
 {
-	struct commit *old = queue->max_nonstale;
+	unsigned old_paint = old_flags & (PARENT1 | PARENT2 | STALE);
+	unsigned new_paint = new_flags & (PARENT1 | PARENT2 | STALE);
 
-	prio_queue_put(&queue->pq, c);
-	if (c->object.flags & STALE)
+	if (old_paint == new_paint)
 		return;
-	if (!old || queue->pq.compare(old, c, queue->pq.cb_data) <= 0)
-		queue->max_nonstale = c;
-}
-
-static struct commit *nonstale_queue_get(struct nonstale_queue *queue)
-{
-	struct commit *commit = prio_queue_get(&queue->pq);
 
-	if (commit == queue->max_nonstale)
-		queue->max_nonstale = NULL;
-
-	return commit;
+	if (!(old_paint & STALE)) {
+		switch (old_paint & (PARENT1 | PARENT2)) {
+		case 0:                  break;
+		case PARENT1:            queue->p1_count--; break;
+		case PARENT2:            queue->p2_count--; break;
+		case PARENT1 | PARENT2:  queue->pending_merge_bases--; break;
+		default:                 BUG("unexpected paint state");
+		}
+	}
+	if (!(new_paint & STALE)) {
+		switch (new_paint & (PARENT1 | PARENT2)) {
+		case 0:                  break;
+		case PARENT1:            queue->p1_count++; break;
+		case PARENT2:            queue->p2_count++; break;
+		case PARENT1 | PARENT2:  queue->pending_merge_bases++; break;
+		default:                 BUG("unexpected paint state");
+		}
+	}
 }
 
-static void clear_nonstale_queue(struct nonstale_queue *queue)
+static void paint_queue_put(struct paint_queue *queue,
+			    struct commit *c, unsigned add_flags)
 {
-	clear_prio_queue(&queue->pq);
-	queue->max_nonstale = NULL;
-}
+	unsigned old_flags = c->object.flags;
+	c->object.flags |= add_flags;
 
-static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
-				     struct commit *c)
-{
-	if (c->object.flags & ENQUEUED)
-		return;
-	c->object.flags |= ENQUEUED;
-	nonstale_queue_put(queue, c);
+	if (old_flags & ENQUEUED) {
+		paint_count_transition(queue, old_flags, c->object.flags);
+	} else {
+		c->object.flags |= ENQUEUED;
+		prio_queue_put(&queue->pq, c);
+		paint_count_transition(queue, 0, c->object.flags);
+	}
 }
 
-static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
+static struct commit *paint_queue_get(struct paint_queue *queue)
 {
-	struct commit *commit = nonstale_queue_get(queue);
+	struct commit *commit = prio_queue_get(&queue->pq);
 
-	if (commit)
+	if (commit) {
 		commit->object.flags &= ~ENQUEUED;
+		paint_count_transition(queue, commit->object.flags, 0);
+	}
 	return commit;
 }
 
@@ -104,9 +121,10 @@ static int paint_down_to_common(struct repository *r,
 				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
-	struct nonstale_queue queue = {
-		{ compare_commits_by_gen_then_commit_date }
+	struct paint_queue queue = {
+		.pq = { compare_commits_by_gen_then_commit_date }
 	};
+	struct commit *commit;
 	int i;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
@@ -119,15 +137,12 @@ static int paint_down_to_common(struct repository *r,
 		commit_list_append(one, result);
 		return 0;
 	}
-	nonstale_queue_put_dedup(&queue, one);
+	paint_queue_put(&queue, one, 0);
 
-	for (i = 0; i < n; i++) {
-		twos[i]->object.flags |= PARENT2;
-		nonstale_queue_put_dedup(&queue, twos[i]);
-	}
+	for (i = 0; i < n; i++)
+		paint_queue_put(&queue, twos[i], PARENT2);
 
-	while (queue.max_nonstale) {
-		struct commit *commit = nonstale_queue_get_dedup(&queue);
+	while ((commit = paint_queue_get(&queue))) {
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
@@ -165,7 +180,7 @@ static int paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
-				clear_nonstale_queue(&queue);
+				clear_prio_queue(&queue.pq);
 				commit_list_free(*result);
 				*result = NULL;
 				/*
@@ -180,12 +195,15 @@ static int paint_down_to_common(struct repository *r,
 				return error(_("could not parse commit %s"),
 					     oid_to_hex(&p->object.oid));
 			}
-			p->object.flags |= flags;
-			nonstale_queue_put_dedup(&queue, p);
+			paint_queue_put(&queue, p, flags);
 		}
+
+		if (queue.p1_count + queue.p2_count +
+		    queue.pending_merge_bases == 0)
+			break;
 	}
 
-	clear_nonstale_queue(&queue);
+	clear_prio_queue(&queue.pq);
 	commit_list_sort_by_date(result);
 	return 0;
 }
-- 
gitgitgadget

