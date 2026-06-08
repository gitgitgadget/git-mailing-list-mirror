Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEF3C3C0E
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945859; cv=none; b=AwPy7o7+n/7c2P+9jJo3F6OWMV1rPFLpedm7jXmFzZyqyXDTh3YV+ZoRgSifxS74g8n0sre/wdNApuv92JY89c2hv8im3TObqLQl0lLb9BNumXOMMbfe4Lsvdut3hz6GSrExnRtpIAGmMUXcmC6jnhWp+E/5WOAIoAaOtN6R7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945859; c=relaxed/simple;
	bh=mQMRTiMmI7FuTEM04Tfjm2eWUmkT8UJ3gxuJL/PU4dw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=oMf/7U2jIKrY/3amuKC+4kiA2qEqmSArM9zofps0Hn85UcvQYpGkTbIk6EUIu3n51T9naRj/hkPH3ocR66oIVoHg2pUceq2DPp8q/cJ/vuZzpdAhISLGGZGq/tguEEx+Dxgx14Q/+tMyECBqOHS0MQlnDfrAX6NXYgPJozXytu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeMbuq5E; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeMbuq5E"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-59c1bacf871so1664766e0c.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 12:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780945857; x=1781550657; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnvvoOI340vqQ6kSt3BQOxzbswDlAIXx6kiGdzcKDds=;
        b=KeMbuq5EamGip9AUuLRrRTVWq3LQg6HUhiEHKrfewUgGY+OSxRYefM0L/8/F8Q1+Ti
         X3bLbqPjS+iVDZn9nz+70i8pBej8xffwsgNY+lJ/NgwqOnEjewWXy8CcleSvRUFWK7/F
         9fWqr0HGZee2bMPyU3SffiV+bpsPW7h9uBPfNc5dRdr+OFpSttF0sylTg/cisyrBB1DD
         W+pi5f+XPGDccmqL77Kswk5z8xQ7MXIYkg/PqO0RY3efqtxwJmVOmCZM5tfnj3xKzMF+
         NomnR6nAKXRz+V7/+8BIikA9ztn24wfM+dffBg8sJY+nYZ+ZRa2UMjMwp1lBC0LbsqEL
         Svig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780945857; x=1781550657;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gnvvoOI340vqQ6kSt3BQOxzbswDlAIXx6kiGdzcKDds=;
        b=TlX0UUaRlRBekZ2bt+jyw90eRc7AFIIjyHKzgFRKfvTEwrRZ+J/Pg1pG2WJgKPpZJC
         J77l/NxUtoL1rJhZEPavIijVPTtXwBZOxr1EfrjhbC2cnpoJzCfU3L1d4SmqDTO8vfmY
         xanFfHZ0P8U2oWcTpSES3HTMg6kum7ifm+5lu6DvumOiykZTaQRXjhzUhW8LQdfunVS6
         msL2GCc69VI4YD49EKAeSRJ9oTSQQ6iUtbQKn/MLcckUYB5X1J0KyA1PjHVyFTSRWz6E
         A3vHlAramseW3lHf/tCawy0ViGNyxAhi5pJCKxrn6HldCZcx0eNqGSJlojaOOdlKLkM8
         Mu1g==
X-Gm-Message-State: AOJu0Yz3Pgg9DoosRAkf2SBHnsfjriqFf/cTC4gVUJaAdJXpsi11Qb5V
	XCBI/a/009IyfCSLt4ACAKkwkk19BeCRN/L52UKBn0aix7vKmfu/UWBjYDf/wBcP
X-Gm-Gg: Acq92OHZ6cVwhaA1gQRy9/x3/xwWVpnjZ+oKUpYo+zAeuQV46OYdwb4DH9sNnN0MP6d
	3qu28NJQFd3sSuD8a+j8TlUuPeMOF8xM4OGoXqWxAlsGqvz59nm4BRTRMPDhwH1nWbGEQ+q2Qyg
	Mg61/4GU4vTl6m7kGtiu9zSEnhqRP4piKCkL3ds+Jbfozobhrw1IzbRCWCwXKxlzfrVQqrsnzPv
	C3CqPu9DXHhQZUpvPZ9sg4IKcx8N/QmiiziKZ9hmkF2yLhUGzks2Dlen1MOvukApczOpPYxkxa0
	A/6spkiRPpeOQwTj4B3ACxcmzkkAQzapC6TwVn6uv4S12oW434O0FHKobeMTMPlwDafMekp8PxH
	TfqrQsIEIs7sYSS3KxdpBq80QyiOh4XBekggwfYU4sQF6EEdwt9isWCHmgmbpJpwNraeaUYfiw5
	LCdXb5osREWp7rONjbA1Mb4YgWKc0mEnHIPq7H
X-Received: by 2002:a05:6122:c99:b0:575:29ef:7e13 with SMTP id 71dfb90a1353d-5ac4ee91214mr7610720e0c.3.1780945856595;
        Mon, 08 Jun 2026 12:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.213.35])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dcc2ecbesm14439909e0c.13.2026.06.08.12.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:10:56 -0700 (PDT)
Message-Id: <a3f4cb57f2f8f90a8b93123b1b10b17a5be8bbb8.1780945851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2140.v4.git.1780945851.gitgitgadget@gmail.com>
References: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
	<pull.2140.v4.git.1780945851.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 19:10:51 +0000
Subject: [PATCH v4 2/2] prio-queue: fold lazy_queue into prio_queue for
 automatic get+put fusion
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Defer the actual removal in prio_queue_get() until the next
operation.  If that next operation is a prio_queue_put(), the
removal and insertion are fused into a single replace — writing
the new element at the root and sifting it down — which avoids
a full remove-rebalance-insert cycle.

This matches the dominant usage pattern in git's commit traversal:
get a commit, then put its parents.  The first parent insertion
after each get is now a replace operation automatically.

This generalizes the lazy_queue pattern from builtin/describe.c
(introduced in 08bb69d70f) into prio_queue itself.  Three callers
independently implemented the same get+put fusion:

  - builtin/describe.c had a full lazy_queue wrapper
  - commit.c:pop_most_recent_commit() used peek+replace
  - builtin/show-branch.c:join_revs() used peek+replace

All three now collapse to plain _get() and _put(), with the data
structure handling the fusion internally.  This simplifies callers
and means every prio_queue user gets the optimization for free
without needing to implement it manually.

Remove prio_queue_replace() since no external callers remain.

Benchmarked on a 1.8M-commit monorepo (30 interleaved runs,
paired t-test, Xeon @ 2.20GHz):

Code paths that previously did eager get+put (new optimization):

  Command                       base    patched  change      p
  merge-base --all A A~1000     3828ms  3725ms   -2.69%  0.0001
  rev-list --count A~1000..A    3055ms  2986ms   -2.27%  0.0601
  log --oneline A~1000..A       3408ms  3350ms   -1.71%  0.0482

Code paths that already had manual get+put fusion (expect
neutral — the optimization moves into prio_queue but the number
of heap operations stays the same):

  Command                       base    patched  change      p
  show-branch A A~1000          9156ms  9127ms   -0.32%  0.3470
  describe (4751 revs, 81K repo) 1983ms 1963ms  -1.02%  <0.001

No regressions in any scenario.

Suggested-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/describe.c          | 75 +++++++-----------------------
 builtin/show-branch.c       | 11 ++---
 commit.c                    | 11 +----
 prio-queue.c                | 92 ++++++++++++++++++++-----------------
 prio-queue.h                | 15 ++----
 t/unit-tests/u-prio-queue.c |  6 +--
 6 files changed, 78 insertions(+), 132 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 8e88bdeea6..64424543ef 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -251,61 +251,19 @@ static int compare_pt(const void *a_, const void *b_)
 	return 0;
 }
 
-struct lazy_queue {
-	struct prio_queue queue;
-	bool get_pending;
-};
-
-#define LAZY_QUEUE_INIT { { compare_commits_by_commit_date }, false }
-
-static void *lazy_queue_get(struct lazy_queue *queue)
-{
-	if (queue->get_pending)
-		prio_queue_get(&queue->queue);
-	else
-		queue->get_pending = true;
-	return prio_queue_peek(&queue->queue);
-}
-
-static void lazy_queue_put(struct lazy_queue *queue, void *thing)
-{
-	if (queue->get_pending)
-		prio_queue_replace(&queue->queue, thing);
-	else
-		prio_queue_put(&queue->queue, thing);
-	queue->get_pending = false;
-}
-
-static bool lazy_queue_empty(const struct lazy_queue *queue)
-{
-	return prio_queue_size(&queue->queue) == (queue->get_pending ? 1 : 0);
-}
-
-static void lazy_queue_clear(struct lazy_queue *queue)
-{
-	clear_prio_queue(&queue->queue);
-	queue->get_pending = false;
-}
-
-static unsigned long finish_depth_computation(struct lazy_queue *queue,
+static unsigned long finish_depth_computation(struct prio_queue *queue,
 					      struct possible_tag *best)
 {
 	unsigned long seen_commits = 0;
 	struct oidset unflagged = OIDSET_INIT;
-	struct commit *commit;
-	int skip = queue->get_pending ? 1 : 0;
+	struct commit *c;
 
-	prio_queue_for_each(&queue->queue, commit) {
-		if (skip) {
-			skip = 0;
-			continue;
-		}
-		if (!(commit->object.flags & best->flag_within))
-			oidset_insert(&unflagged, &commit->object.oid);
+	prio_queue_for_each(queue, c) {
+		if (!(c->object.flags & best->flag_within))
+			oidset_insert(&unflagged, &c->object.oid);
 	}
 
-	while (!lazy_queue_empty(queue)) {
-		struct commit *c = lazy_queue_get(queue);
+	while ((c = prio_queue_get(queue))) {
 		struct commit_list *parents = c->parents;
 		seen_commits++;
 		if (c->object.flags & best->flag_within) {
@@ -321,7 +279,7 @@ static unsigned long finish_depth_computation(struct lazy_queue *queue,
 			repo_parse_commit(the_repository, p);
 			seen = p->object.flags & SEEN;
 			if (!seen)
-				lazy_queue_put(queue, p);
+				prio_queue_put(queue, p);
 			flag_before = p->object.flags & best->flag_within;
 			p->object.flags |= c->object.flags;
 			flag_after = p->object.flags & best->flag_within;
@@ -369,8 +327,8 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
 
 static void describe_commit(struct commit *cmit, struct strbuf *dst)
 {
-	struct commit *gave_up_on = NULL;
-	struct lazy_queue queue = LAZY_QUEUE_INIT;
+	struct commit *c, *gave_up_on = NULL;
+	struct prio_queue queue = { compare_commits_by_commit_date };
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
@@ -412,9 +370,8 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 	}
 
 	cmit->object.flags = SEEN;
-	lazy_queue_put(&queue, cmit);
-	while (!lazy_queue_empty(&queue)) {
-		struct commit *c = lazy_queue_get(&queue);
+	prio_queue_put(&queue, cmit);
+	while ((c = prio_queue_get(&queue))) {
 		struct commit_list *parents = c->parents;
 		struct commit_name **slot;
 
@@ -448,7 +405,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 				t->depth++;
 		}
 		/* Stop if last remaining path already covered by best candidate(s) */
-		if (annotated_cnt && lazy_queue_empty(&queue)) {
+		if (annotated_cnt && !prio_queue_size(&queue)) {
 			int best_depth = INT_MAX;
 			unsigned best_within = 0;
 			for (cur_match = 0; cur_match < match_cnt; cur_match++) {
@@ -471,7 +428,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 			struct commit *p = parents->item;
 			repo_parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
-				lazy_queue_put(&queue, p);
+				prio_queue_put(&queue, p);
 			p->object.flags |= c->object.flags;
 			parents = parents->next;
 
@@ -486,7 +443,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 			strbuf_add_unique_abbrev(dst, cmit_oid, abbrev);
 			if (suffix)
 				strbuf_addstr(dst, suffix);
-			lazy_queue_clear(&queue);
+			clear_prio_queue(&queue);
 			return;
 		}
 		if (unannotated_cnt)
@@ -502,11 +459,11 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 	QSORT(all_matches, match_cnt, compare_pt);
 
 	if (gave_up_on) {
-		lazy_queue_put(&queue, gave_up_on);
+		prio_queue_put(&queue, gave_up_on);
 		seen_commits--;
 	}
 	seen_commits += finish_depth_computation(&queue, &all_matches[0]);
-	lazy_queue_clear(&queue);
+	clear_prio_queue(&queue);
 
 	if (debug) {
 		static int label_width = -1;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 8846f2376f..2435e8aeda 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -232,12 +232,13 @@ static void join_revs(struct prio_queue *queue,
 	while ((commit = prio_queue_peek(queue))) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(queue);
-		bool get_pending = true;
 		int flags = commit->object.flags & all_mask;
 
 		if (!still_interesting && extra <= 0)
 			break;
 
+		prio_queue_get(queue);
+
 		mark_seen(commit, seen_p);
 		if ((flags & all_revs) == all_revs)
 			flags |= UNINTERESTING;
@@ -253,14 +254,8 @@ static void join_revs(struct prio_queue *queue,
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
 			p->object.flags |= flags;
-			if (get_pending)
-				prio_queue_replace(queue, p);
-			else
-				prio_queue_put(queue, p);
-			get_pending = false;
+			prio_queue_put(queue, p);
 		}
-		if (get_pending)
-			prio_queue_get(queue);
 	}
 
 	/*
diff --git a/commit.c b/commit.c
index fd8723502e..976bfc4618 100644
--- a/commit.c
+++ b/commit.c
@@ -795,24 +795,17 @@ void commit_list_sort_by_date(struct commit_list **list)
 struct commit *pop_most_recent_commit(struct prio_queue *queue,
 				      unsigned int mark)
 {
-	struct commit *ret = prio_queue_peek(queue);
-	int get_pending = 1;
+	struct commit *ret = prio_queue_get(queue);
 	struct commit_list *parents = ret->parents;
 
 	while (parents) {
 		struct commit *commit = parents->item;
 		if (!repo_parse_commit(the_repository, commit) && !(commit->object.flags & mark)) {
 			commit->object.flags |= mark;
-			if (get_pending)
-				prio_queue_replace(queue, commit);
-			else
-				prio_queue_put(queue, commit);
-			get_pending = 0;
+			prio_queue_put(queue, commit);
 		}
 		parents = parents->next;
 	}
-	if (get_pending)
-		prio_queue_get(queue);
 	return ret;
 }
 
diff --git a/prio-queue.c b/prio-queue.c
index ead4faf4bb..199775d5af 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -34,12 +34,48 @@ void clear_prio_queue(struct prio_queue *queue)
 	queue->nr_ = 0;
 	queue->alloc = 0;
 	queue->insertion_ctr = 0;
+	queue->get_pending = 0;
+}
+
+static void sift_down_root(struct prio_queue *queue)
+{
+	size_t ix, child;
+
+	/* Push down the one at the root */
+	for (ix = 0; ix * 2 + 1 < queue->nr_; ix = child) {
+		child = ix * 2 + 1; /* left */
+		if (child + 1 < queue->nr_ &&
+		    compare(queue, child, child + 1) >= 0)
+			child++; /* use right child */
+
+		if (compare(queue, ix, child) <= 0)
+			break;
+
+		swap(queue, child, ix);
+	}
+}
+
+static inline void flush_get(struct prio_queue *queue)
+{
+	if (!queue->get_pending)
+		return;
+	queue->get_pending = 0;
+	queue->array[0] = queue->array[--queue->nr_];
+	sift_down_root(queue);
 }
 
 void prio_queue_put(struct prio_queue *queue, void *thing)
 {
 	size_t ix, parent;
 
+	if (queue->get_pending) {
+		queue->get_pending = 0;
+		queue->array[0].ctr = queue->insertion_ctr++;
+		queue->array[0].data = thing;
+		sift_down_root(queue);
+		return;
+	}
+
 	/* Append at the end */
 	ALLOC_GROW(queue->array, queue->nr_ + 1, queue->alloc);
 	queue->array[queue->nr_].ctr = queue->insertion_ctr++;
@@ -58,61 +94,33 @@ void prio_queue_put(struct prio_queue *queue, void *thing)
 	}
 }
 
-static void sift_down_root(struct prio_queue *queue)
-{
-	size_t ix, child;
-
-	/* Push down the one at the root */
-	for (ix = 0; ix * 2 + 1 < queue->nr_; ix = child) {
-		child = ix * 2 + 1; /* left */
-		if (child + 1 < queue->nr_ &&
-		    compare(queue, child, child + 1) >= 0)
-			child++; /* use right child */
-
-		if (compare(queue, ix, child) <= 0)
-			break;
-
-		swap(queue, child, ix);
-	}
-}
-
 void *prio_queue_get(struct prio_queue *queue)
 {
-	void *result;
-
-	if (!queue->nr_)
+	if (queue->nr_ <= queue->get_pending) {
+		queue->nr_ = 0;
+		queue->get_pending = 0;
 		return NULL;
+	}
 	if (!queue->compare)
 		return queue->array[--queue->nr_].data; /* LIFO */
 
-	result = queue->array[0].data;
-	if (!--queue->nr_)
-		return result;
+	flush_get(queue);
 
-	queue->array[0] = queue->array[queue->nr_];
-	sift_down_root(queue);
-	return result;
+	queue->get_pending = 1;
+	return queue->array[0].data;
 }
 
 void *prio_queue_peek(struct prio_queue *queue)
 {
-	if (!queue->nr_)
+	if (queue->nr_ <= queue->get_pending) {
+		queue->nr_ = 0;
+		queue->get_pending = 0;
 		return NULL;
+	}
 	if (!queue->compare)
 		return queue->array[queue->nr_ - 1].data;
-	return queue->array[0].data;
-}
 
-void prio_queue_replace(struct prio_queue *queue, void *thing)
-{
-	if (!queue->nr_) {
-		prio_queue_put(queue, thing);
-	} else if (!queue->compare) {
-		queue->array[queue->nr_ - 1].ctr = queue->insertion_ctr++;
-		queue->array[queue->nr_ - 1].data = thing;
-	} else {
-		queue->array[0].ctr = queue->insertion_ctr++;
-		queue->array[0].data = thing;
-		sift_down_root(queue);
-	}
+	flush_get(queue);
+
+	return queue->array[0].data;
 }
diff --git a/prio-queue.h b/prio-queue.h
index 7f2aa986b1..570b48e648 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -30,8 +30,9 @@ struct prio_queue {
 	prio_queue_compare_fn compare;
 	size_t insertion_ctr;
 	void *cb_data;
-	size_t alloc, nr_;
+	size_t alloc, nr_; /* use prio_queue_size() for logical count */
 	struct prio_queue_entry *array;
+	unsigned get_pending;
 };
 
 /*
@@ -54,22 +55,14 @@ void *prio_queue_peek(struct prio_queue *);
 
 static inline size_t prio_queue_size(const struct prio_queue *queue)
 {
-	return queue->nr_;
+	return queue->nr_ - queue->get_pending;
 }
 
 #define prio_queue_for_each(queue, it) \
-	for (size_t pq_ix_ = 0; \
+	for (size_t pq_ix_ = (queue)->get_pending; \
 	     pq_ix_ < (queue)->nr_ && ((it) = (queue)->array[pq_ix_].data, 1); \
 	     pq_ix_++)
 
-/*
- * Replace the "thing" that compares the smallest with a new "thing",
- * like prio_queue_get()+prio_queue_put() would do, but in a more
- * efficient way.  Does the same as prio_queue_put() if the queue is
- * empty.
- */
-void prio_queue_replace(struct prio_queue *queue, void *thing);
-
 void clear_prio_queue(struct prio_queue *);
 
 /* Reverse the LIFO elements */
diff --git a/t/unit-tests/u-prio-queue.c b/t/unit-tests/u-prio-queue.c
index 63e58114ae..af3e0b8598 100644
--- a/t/unit-tests/u-prio-queue.c
+++ b/t/unit-tests/u-prio-queue.c
@@ -53,13 +53,13 @@ static void test_prio_queue(int *input, size_t input_size,
 			prio_queue_reverse(&pq);
 			break;
 		case REPLACE:
-			peek = prio_queue_peek(&pq);
+			get = prio_queue_get(&pq);
 			cl_assert(i + 1 < input_size);
 			cl_assert(input[i + 1] >= 0);
 			cl_assert(j < result_size);
-			cl_assert_equal_i(result[j], show(peek));
+			cl_assert_equal_i(result[j], show(get));
 			j++;
-			prio_queue_replace(&pq, &input[++i]);
+			prio_queue_put(&pq, &input[++i]);
 			break;
 		default:
 			prio_queue_put(&pq, &input[i]);
-- 
gitgitgadget
