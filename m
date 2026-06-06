Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09417241695
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780757890; cv=none; b=C3lQEYvp05dri9D8T3U9yIF3RLi+YCu61w1POsu6ku69sQlCKIm6N0tS/bncb40vHsJrfveyswMclAPcN6T12kKiZSZrQ67WeYXtCNIDTKqoYW/niP49HXXr8YsbzIQ/B0emzbhmBToX+jl1kF86jR+cQO3jjwBmEvn5ov8dwJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780757890; c=relaxed/simple;
	bh=/6c1yxs2h1bNAQIF5kZLANVJyyzYViT4ho59qSuuZyg=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Z/u8I42Bn5ZByRpHjl9Np89Yu6JVdOe3TVZLINuAG1GfoYu24SJ5bxtXAuPOjjalhC4jGBbKmeHeG8gWUz86XxIeCFwFBdh26xnVWzEwMzSs723qH6KvnQLYkGPBjaV5VZxiaiWelNtYKNkIZiipGYCob/zeR1utshvNeobmr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6qGFRS+; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6qGFRS+"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30749947917so6115189eec.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2026 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780757888; x=1781362688; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ilQ5iyQPZQjaR8ovhw4/7O8eH5bbOIBeqKfVM4oq4yE=;
        b=l6qGFRS+3bkrpVa6p9CXm/Y8TJBk1ARi5JLgLhugA+BXqJolrQdOq+tnAhSoQOLjWO
         mpBJ5zuWFSlt8Z2g6cSMbZMPx0BP8X075xnbgokrxOBnRGPIZa+S5dD7ceRYG218y2Tg
         OIohvtIEWYXaKZquO/P97Y3/5vMu6wjMnflhsZGHx3kngpFyqmb3a6FdDNZ9CFdxk0V7
         SIjI9UfVm5NlueaLOPD8tpbXEinPAFDtUg5F86u03OxYGLx4iaAR/Xzea68oUhl59Ris
         0I0qr+6DMrtDvJR5ZM6y0SxMSVxZCUCtaFye4Bl+NkLJrqKDE0Rq6yKuvEShm7wTkUdU
         bSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780757888; x=1781362688;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilQ5iyQPZQjaR8ovhw4/7O8eH5bbOIBeqKfVM4oq4yE=;
        b=Go35Pl6sjg2CvA7D8K6U94UxkQAAWPYkdv+PHNK7NaT5WglpuDiSCM8+PBV7WmgbMF
         zpm7VQ/b8haCJmIilhaysTqFl1vzQDycpiTBk78Wz4DDxry25jX4QScZpyEy5TdyPnZG
         b30JCDk/5kQqD+XlHZGY5aTmE0E6+3up8IsBFYMcIiwX2cSR5yH4l8bT+7jsVnpLDPDi
         SCAwKs3PJ6URWZLFrIyHp2pvRv+gwHkygPjnaVv7Ri7vjrCY35XA9ryTpDd4CBUQpygx
         GSx9LNLGI9GTfy6XM4gOXJLcbZM04Zc44hr05NpXSlw4vq6FJqQfRahEUGqyMizJO3pR
         i2GA==
X-Gm-Message-State: AOJu0YxRO4o/rp/ZtC7jDSx/2cmzZSNCMqz/5S/Nh84ZYcnr/CEDQV3c
	TMyX8DagMr51cUp4AYx4szskqQx5EwT1azr4s1Mi5pp8HlOSKnF8dkyUZxWIaw==
X-Gm-Gg: Acq92OGyAMSiG/i5oTajIkk4450/gAZAtFTWH/Y0oX2oDxo1ueD8DrFV/7Clnfp9+oN
	42ODFbhYuZgWXscAA7wbl9kwjpQ5F7cIZ+tUEuQB6tW5HUVZaAv7kISkCsO5smp4CFYxTxgzeET
	97SO8sPEza9v44dmZVzmHYRDPD2Q6HtuYXIbFscXEtu7AFXjEVvd5tMPe/HDh7nadU2ZiijRY1Q
	2CmWo6hJq0oNCCO/pUuRZaxMZT81L8q4W5EaYIYOkew0t+O1/aqy7sGPFdxXnDgtvioeWGgUb6m
	A3Ow7yUgeEhv/q8nYOcChGz58e4PhP3UNdd4NMQ+p042R2/mNBqz+pAJbXBogAcCf8ivv5t/2Qj
	TWMbaVuj5qaL1DvojOEKnYJb3HQxHNB+fbY0nc5jVeUkedqOu8G3AhINmlUzgNDMSMvy4gTbFMJ
	/oinnsR/3Ra9RMRBtf+T1nq/YGZvtbQVhE1uldsF8H+UvD
X-Received: by 2002:a05:693c:834d:b0:307:91f5:9377 with SMTP id 5a478bee46e88-30791f63488mr1611327eec.9.1780757887817;
        Sat, 06 Jun 2026 07:58:07 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.63.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm14954688eec.5.2026.06.06.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 07:58:06 -0700 (PDT)
Message-Id: <pull.2140.git.1780757885582.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Jun 2026 14:58:04 +0000
Subject: [PATCH] prio-queue: fold lazy_queue into prio_queue for automatic
 get+put fusion
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
  - commit.c:pop_most_recent_commit() reimplements the same
    get_pending flag with peek+replace
  - builtin/show-branch.c:join_revs() used the same peek+replace
    pattern

All three now collapse to plain _get() and _put(),
with the data structure handling the fusion internally.

Remove prio_queue_replace() since no external callers remain.
Add prio_queue_size() for callers that need the logical element
count, since the physical nr may temporarily include a
pending-removal element.

Benchmarked on a large monorepo (10-15 interleaved runs, 1 warmup):

  Command                       base    patched  speedup
  merge-base --all A A~1000     3.88s   3.77s    1.03x
  rev-list --count A~1000..A    3.57s   3.43s    1.04x
  log --oneline A~1000..A       3.70s   3.49s    1.06x
  rev-parse :/pattern           365ms   364ms    1.00x
  describe HEAD (linux.git)     184ms   190ms    1.00x

No regressions in any scenario.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    prio-queue: fold lazy_queue into prio_queue for automatic get+put fusion
    
    Rene's lazy_queue wrapper in describe.c was a clever optimization -- by
    deferring the get, a following put becomes a simple replace, avoiding a
    full remove-rebalance-insert cycle.
    
    It turns out this pattern is so common in git's traversal code that it
    makes sense to fold it into prio_queue itself. Gets and puts are
    interleaved in virtually every commit walk, so the fusion is essentially
    always a win.
    
    This is mostly a code simplification -- three callers had independently
    reimplemented the same optimization, and they all collapse to plain
    get+put now. The 3-6% speedup on traversal-heavy workloads is a nice
    bonus.
    
    More details and benchmark numbers in the commit message. Benchmarks
    were run on next which includes kk/commit-reach-optim -- those results
    represent the more realistic end state.
    
    Related to but independent of the cascade sift-down work in
    kk/prio-queue-cascade-sift -- the two can land in either order.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2140%2Fspkrka%2Flazy-prio-queue-pr-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2140/spkrka/lazy-prio-queue-pr-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2140

 builtin/describe.c          | 67 +++++++++----------------------------
 builtin/last-modified.c     |  4 +--
 builtin/show-branch.c       | 17 ++++------
 commit-reach.c              |  5 ++-
 commit.c                    | 11 ++----
 pack-bitmap-write.c         |  4 +--
 prio-queue.c                | 49 +++++++++++++++------------
 prio-queue.h                | 12 +++----
 revision.c                  |  5 ++-
 t/unit-tests/u-prio-queue.c |  6 ++--
 walker.c                    |  4 +--
 11 files changed, 68 insertions(+), 116 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1c47d7c0b7..85564f3487 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -251,56 +251,20 @@ static int compare_pt(const void *a_, const void *b_)
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
-	return queue->queue.nr == (queue->get_pending ? 1 : 0);
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
+	struct commit *c;
 
-	for (size_t i = queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) {
-		struct commit *commit = queue->queue.array[i].data;
+	for (size_t i = queue->get_pending; i < queue->nr; i++) {
+		struct commit *commit = queue->array[i].data;
 		if (!(commit->object.flags & best->flag_within))
 			oidset_insert(&unflagged, &commit->object.oid);
 	}
 
-	while (!lazy_queue_empty(queue)) {
-		struct commit *c = lazy_queue_get(queue);
+	while ((c = prio_queue_get(queue))) {
 		struct commit_list *parents = c->parents;
 		seen_commits++;
 		if (c->object.flags & best->flag_within) {
@@ -316,7 +280,7 @@ static unsigned long finish_depth_computation(struct lazy_queue *queue,
 			repo_parse_commit(the_repository, p);
 			seen = p->object.flags & SEEN;
 			if (!seen)
-				lazy_queue_put(queue, p);
+				prio_queue_put(queue, p);
 			flag_before = p->object.flags & best->flag_within;
 			p->object.flags |= c->object.flags;
 			flag_after = p->object.flags & best->flag_within;
@@ -364,8 +328,8 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
 
 static void describe_commit(struct commit *cmit, struct strbuf *dst)
 {
-	struct commit *gave_up_on = NULL;
-	struct lazy_queue queue = LAZY_QUEUE_INIT;
+	struct commit *c, *gave_up_on = NULL;
+	struct prio_queue queue = { compare_commits_by_commit_date };
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
@@ -407,9 +371,8 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 	}
 
 	cmit->object.flags = SEEN;
-	lazy_queue_put(&queue, cmit);
-	while (!lazy_queue_empty(&queue)) {
-		struct commit *c = lazy_queue_get(&queue);
+	prio_queue_put(&queue, cmit);
+	while ((c = prio_queue_get(&queue))) {
 		struct commit_list *parents = c->parents;
 		struct commit_name **slot;
 
@@ -443,7 +406,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 				t->depth++;
 		}
 		/* Stop if last remaining path already covered by best candidate(s) */
-		if (annotated_cnt && lazy_queue_empty(&queue)) {
+		if (annotated_cnt && !prio_queue_size(&queue)) {
 			int best_depth = INT_MAX;
 			unsigned best_within = 0;
 			for (cur_match = 0; cur_match < match_cnt; cur_match++) {
@@ -466,7 +429,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 			struct commit *p = parents->item;
 			repo_parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
-				lazy_queue_put(&queue, p);
+				prio_queue_put(&queue, p);
 			p->object.flags |= c->object.flags;
 			parents = parents->next;
 
@@ -481,7 +444,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 			strbuf_add_unique_abbrev(dst, cmit_oid, abbrev);
 			if (suffix)
 				strbuf_addstr(dst, suffix);
-			lazy_queue_clear(&queue);
+			clear_prio_queue(&queue);
 			return;
 		}
 		if (unannotated_cnt)
@@ -497,11 +460,11 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
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
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 8900ceece1..df2a508244 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -344,6 +344,7 @@ static void process_parent(struct last_modified *lm,
 static int last_modified_run(struct last_modified *lm)
 {
 	int max_count, queue_popped = 0;
+	struct commit *c;
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *list;
@@ -389,10 +390,9 @@ static int last_modified_run(struct last_modified *lm)
 		}
 	}
 
-	while (queue.nr) {
+	while ((c = prio_queue_get(&queue))) {
 		int parent_i;
 		struct commit_list *p;
-		struct commit *c = prio_queue_get(&queue);
 		struct bitmap *active_c = active_paths_for(lm, c);
 
 		if ((0 <= max_count && max_count < ++queue_popped) ||
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..9f7f28f339 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -62,7 +62,7 @@ static const char *get_color_reset_code(void)
 
 static struct commit *interesting(struct prio_queue *queue)
 {
-	for (size_t i = 0; i < queue->nr; i++) {
+	for (size_t i = queue->get_pending; i < queue->nr; i++) {
 		struct commit *commit = queue->array[i].data;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
@@ -228,17 +228,18 @@ static void join_revs(struct prio_queue *queue,
 {
 	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
 	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
+	struct commit *commit;
 
-	while (queue->nr) {
+	while ((commit = prio_queue_peek(queue))) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(queue);
-		struct commit *commit = prio_queue_peek(queue);
-		bool get_pending = true;
 		int flags = commit->object.flags & all_mask;
 
 		if (!still_interesting && extra <= 0)
 			break;
 
+		prio_queue_get(queue);
+
 		mark_seen(commit, seen_p);
 		if ((flags & all_revs) == all_revs)
 			flags |= UNINTERESTING;
@@ -254,14 +255,8 @@ static void join_revs(struct prio_queue *queue,
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
diff --git a/commit-reach.c b/commit-reach.c
index 9b3ea46d6f..0fec2f00be 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1269,7 +1269,7 @@ int get_branch_base_for_tip(struct repository *r,
 			    size_t bases_nr)
 {
 	int best_index = -1;
-	struct commit *branch_point = NULL;
+	struct commit *c, *branch_point = NULL;
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	int found_missing_gen = 0;
 
@@ -1322,8 +1322,7 @@ int get_branch_base_for_tip(struct repository *r,
 		prio_queue_put(&queue, c);
 	}
 
-	while (queue.nr) {
-		struct commit *c = prio_queue_get(&queue);
+	while ((c = prio_queue_get(&queue))) {
 		int best_for_c = get_best(c);
 		int best_for_p, positive;
 		struct commit *parent;
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
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 1c8070f99c..f7c63e3027 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -513,6 +513,7 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			      struct bitmap_index *old_bitmap,
 			      const uint32_t *mapping)
 {
+	struct commit *c;
 	int found;
 	uint32_t pos;
 	if (!ent->bitmap)
@@ -520,9 +521,8 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 
 	prio_queue_put(queue, commit);
 
-	while (queue->nr) {
+	while ((c = prio_queue_get(queue))) {
 		struct commit_list *p;
-		struct commit *c = prio_queue_get(queue);
 
 		if (old_bitmap && mapping) {
 			struct ewah_bitmap *old;
diff --git a/prio-queue.c b/prio-queue.c
index 9748528ce6..1407f2f801 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -34,12 +34,34 @@ void clear_prio_queue(struct prio_queue *queue)
 	queue->nr = 0;
 	queue->alloc = 0;
 	queue->insertion_ctr = 0;
+	queue->get_pending = 0;
+}
+
+static void sift_down_root(struct prio_queue *queue);
+
+static inline void flush_get(struct prio_queue *queue)
+{
+	if (!queue->get_pending)
+		return;
+	queue->get_pending = 0;
+	if (!--queue->nr)
+		return;
+	queue->array[0] = queue->array[queue->nr];
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
 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
 	queue->array[queue->nr].ctr = queue->insertion_ctr++;
@@ -78,41 +100,24 @@ static void sift_down_root(struct prio_queue *queue)
 
 void *prio_queue_get(struct prio_queue *queue)
 {
-	void *result;
+	flush_get(queue);
 
 	if (!queue->nr)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[--queue->nr].data; /* LIFO */
 
-	result = queue->array[0].data;
-	if (!--queue->nr)
-		return result;
-
-	queue->array[0] = queue->array[queue->nr];
-	sift_down_root(queue);
-	return result;
+	queue->get_pending = 1;
+	return queue->array[0].data;
 }
 
 void *prio_queue_peek(struct prio_queue *queue)
 {
+	flush_get(queue);
+
 	if (!queue->nr)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[queue->nr - 1].data;
 	return queue->array[0].data;
 }
-
-void prio_queue_replace(struct prio_queue *queue, void *thing)
-{
-	if (!queue->nr) {
-		prio_queue_put(queue, thing);
-	} else if (!queue->compare) {
-		queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
-		queue->array[queue->nr - 1].data = thing;
-	} else {
-		queue->array[0].ctr = queue->insertion_ctr++;
-		queue->array[0].data = thing;
-		sift_down_root(queue);
-	}
-}
diff --git a/prio-queue.h b/prio-queue.h
index da7fad2f1f..482ab5e71d 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -32,6 +32,7 @@ struct prio_queue {
 	void *cb_data;
 	size_t alloc, nr;
 	struct prio_queue_entry *array;
+	unsigned get_pending;
 };
 
 /*
@@ -52,13 +53,10 @@ void *prio_queue_get(struct prio_queue *);
  */
 void *prio_queue_peek(struct prio_queue *);
 
-/*
- * Replace the "thing" that compares the smallest with a new "thing",
- * like prio_queue_get()+prio_queue_put() would do, but in a more
- * efficient way.  Does the same as prio_queue_put() if the queue is
- * empty.
- */
-void prio_queue_replace(struct prio_queue *queue, void *thing);
+static inline size_t prio_queue_size(struct prio_queue *queue)
+{
+	return queue->nr - queue->get_pending;
+}
 
 void clear_prio_queue(struct prio_queue *);
 
diff --git a/revision.c b/revision.c
index 5693618be4..8ce8ffa43d 100644
--- a/revision.c
+++ b/revision.c
@@ -1446,7 +1446,7 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *original_list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
-	struct commit *interesting_cache = NULL;
+	struct commit *commit, *interesting_cache = NULL;
 	struct prio_queue queue = { .compare = compare_commits_by_commit_date };
 
 	if (revs->ancestry_path_implicit_bottoms) {
@@ -1461,8 +1461,7 @@ static int limit_list(struct rev_info *revs)
 		prio_queue_put(&queue, commit);
 	}
 
-	while (queue.nr) {
-		struct commit *commit = prio_queue_get(&queue);
+	while ((commit = prio_queue_get(&queue))) {
 		struct object *obj = &commit->object;
 
 		if (commit == interesting_cache)
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
diff --git a/walker.c b/walker.c
index e98eb6da53..e3de77f092 100644
--- a/walker.c
+++ b/walker.c
@@ -84,12 +84,12 @@ static struct prio_queue complete = { compare_commits_by_commit_date };
 static int process_commit(struct walker *walker, struct commit *commit)
 {
 	struct commit_list *parents;
+	struct commit *item;
 
 	if (repo_parse_commit(the_repository, commit))
 		return -1;
 
-	while (complete.nr) {
-		struct commit *item = prio_queue_peek(&complete);
+	while ((item = prio_queue_peek(&complete))) {
 		if (item->date < commit->date)
 			break;
 		pop_most_recent_commit(&complete, COMPLETE);

base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
-- 
gitgitgadget
