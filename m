Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFB257855
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780832599; cv=none; b=n+JAiybc6HZBU/G59wzqO9vWOE7LrrN+0254mJJbLCGd2KIJtjKwa8db/m1rnQCZBviqVWAvhjGzaa8aY12j7HRnvpvBdVGzbkgcwlXdD8btGubKlJfhuNjLpt/L6njkZJnJ1V2C/qvvu+tFdKWRF0lrJH62vvl+NoJWumRhduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780832599; c=relaxed/simple;
	bh=arwOCM12XneWweJQcuep7Bue6yYrahnwSIsvnk8++kc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=dZ+O7HiNz3YU39HbXiBb99Pu0NONfKYR9RF5TWzh5ero0P3xHighdudgOoD4rfeb2CrVKzZIwDjDHZlMdhLIbA538yR6ai9h6Oh5tJodikIvs2bq4FFUzKcqm9xcEFN/l4E671M78A1yDxocK1a4h/2CECrqxrYNUTnD5tg7xEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpav862x; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpav862x"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30749947917so7434995eec.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780832597; x=1781437397; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh8+iWkYb+WM0SfyuVQMlKuzDfkujUxxXbZ/KdR+q9Y=;
        b=mpav862xEtP4+ykEWKgi0olwFexC3eUeRgKGavAqvGxpn8gzO0QU5UMZimBg8W8lUa
         ccK4IO++TFVL+AyyWgKk3hNf62CaI1lhivAtQFPofb8VIL6OCuN4ssSXHQHM3+By6OKx
         R4Z6AqXXspQIbCO3VsG0W7yJdaqaneu2LfetVNx5qRwvrmAMQnP+44PnFRf+VdLcGSFd
         uusNHuuoDJZIb+YqcSE7yyBQ+vUEJbcoH9XFCO6DAUdtJB9+CPbMH5WIkPX5V0esmgVD
         gDa3hFPdwshqDRMp3c3ZpizcCmZUa7+3AdZMsyb/McuW9IQ+gSrXfTvc+keUgIGNcv2J
         7AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780832597; x=1781437397;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xh8+iWkYb+WM0SfyuVQMlKuzDfkujUxxXbZ/KdR+q9Y=;
        b=eCt9DppUSqdrG6dwMME1/JerwL+7YNVEACCy6U8Kjnah+R/+7g7vkQ6ycE5NKNteay
         8dO/mjAiDbVhcuM9leRL/alF/XiqK5G9omMsKE9AoAGY8dtS5imMYHmqGvN54dN6QPRX
         xbl/IfVne8xVk2zOX8w1aK9N9Zs9UcNjYUFqwZRAV7Gt4JTJvX+d1feXdfIwEQFGPoKF
         PSTlME0SY1/pCjn5BKU3JlBk3SCGEYmhO+chTTVARWBL2ZF65fs96H2TncPuUT52UrZX
         PdDeLmicazJQqLbDtKPwzmGzH8HxVGH7MGtCqhz9jLSy3Kfp+MQgU65NuPQPUOaCuzTl
         djmw==
X-Gm-Message-State: AOJu0Ywt2wd6Gdr9X3PZyh0+trlCrUPDWIvBYiNRsMEW1hpjWub8BBYI
	pM0wXcj/5NhZMp5aTF69n6FD2N8KMohdvCcmvyBYfZ981RK3R6b+2pHlFf72Qg==
X-Gm-Gg: Acq92OGRkGcCt0p7VPcK49g/2u4gwhhMmMoepkeElBxE9VLwMGyRy8PLoDe3YvTtmJx
	CDgZSLVd7JT9Oa6zrzZ4b8x2RbsOK0k0O8bnUEzGxbDZFv3cXR2+n9yHFz1b9PxGJHGI6Luwxjh
	4GdVzJ2Nlrrfov6C6uEvNfe+7TuzeFUeQ2Ia6aPCYjIbFfiEd+xrfjNofApHJuBuRjGKryvSuM5
	vjU41hu+oI4uAyijo6HO06c8zJyL92LonHtn7zVvfJBgv32q3mPSHhjcpZpqgpT0iDDwcyijeUV
	yvEwkaUnNHbMfade04pvgWV+wjL8Bi+DB0MbicIIFQuzMZl6+g2aNpRenzr0zMiRHPOqP9DHuHI
	7J6Nz0vYWKLWyDlw7GNoOWRXv9mQHsZD36N68+3aRThQn4pffN5Mn9pYndIG1mtaS/4T43NkS4M
	Nv8smDoJoGHvfHewqqo7EhgPa/P51OYeQjHCIDDyas5sicsA==
X-Received: by 2002:a05:7300:534f:b0:304:e58b:cccb with SMTP id 5a478bee46e88-3077b357f9fmr6434463eec.2.1780832596571;
        Sun, 07 Jun 2026 04:43:16 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3078c1ac378sm5868122eec.1.2026.06.07.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:43:16 -0700 (PDT)
Message-Id: <e882206d29406604b1ea135b0bc00df85b097f45.1780832592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
References: <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
	<pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Jun 2026 11:43:10 +0000
Subject: [PATCH v3 1/2] prio-queue: fold lazy_queue into prio_queue for
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
removal and insertion are fused into a single replace, writing
the new element at the root and sifting it down which avoids
a full remove-rebalance-insert cycle.

This matches the dominant usage pattern in git's commit traversal:
get a commit, then put its parents. The first parent insertion
after each get is now a replace operation automatically.

This generalizes the lazy_queue pattern from builtin/describe.c
(introduced in 08bb69d70f) into prio_queue itself. Three callers
independently implemented the same get+put fusion:

  - builtin/describe.c had a full lazy_queue wrapper
  - commit.c:pop_most_recent_commit() used peek+replace
  - builtin/show-branch.c:join_revs() used peek+replace

All three now collapse to plain _get() and _put(), with the data
structure handling the fusion internally. This simplifies callers
and means every prio_queue user gets the optimization for free
without needing to implement it manually.

Remove prio_queue_replace() since no external callers remain.
Add prio_queue_size() for callers that need the logical element
count, since the physical nr may temporarily include a
pending-removal element.

Benchmarked on a large monorepo (30 interleaved runs,
paired t-test, Xeon @ 2.20GHz):

Code paths that previously did eager get+put (new optimization):

  Command                       base    patched  change  p
  merge-base --all A A~1000     3828ms  3725ms   -2.69%  0.0001
  rev-list --count A~1000..A    3055ms  2986ms   -2.27%  0.0601
  log --oneline A~1000..A       3408ms  3350ms   -1.71%  0.0482

Code paths that already had manual get+put fusion (expect
neutral - the optimization moves into prio_queue but the number
of heap operations stays the same):

  Command                base   patched  change  p
  show-branch A A~1000   9156ms  9127ms  -0.32%  0.3470
  describe (git.git)     1983ms  1963ms  -1.02%  <0.001

No regressions in any scenario.

Suggested-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/describe.c          | 67 +++++++---------------------
 builtin/last-modified.c     |  4 +-
 builtin/show-branch.c       | 17 +++----
 commit-reach.c              |  5 +--
 commit.c                    | 11 +----
 pack-bitmap-write.c         |  4 +-
 prio-queue.c                | 88 ++++++++++++++++++-------------------
 prio-queue.h                | 12 +++--
 revision.c                  |  5 +--
 t/unit-tests/u-prio-queue.c |  6 +--
 walker.c                    |  4 +-
 11 files changed, 85 insertions(+), 138 deletions(-)

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
index 9748528ce6..a03c617470 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -34,64 +34,69 @@ void clear_prio_queue(struct prio_queue *queue)
 	queue->nr = 0;
 	queue->alloc = 0;
 	queue->insertion_ctr = 0;
+	queue->get_pending = 0;
+}
+
+static void sift_down_root(struct prio_queue *queue)
+{
+	size_t ix, child;
+
+	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
+		child = ix * 2 + 1;
+		if (child + 1 < queue->nr &&
+		    compare(queue, child, child + 1) >= 0)
+			child++;
+		if (compare(queue, ix, child) <= 0)
+			break;
+		swap(queue, child, ix);
+	}
 }
 
 void prio_queue_put(struct prio_queue *queue, void *thing)
 {
 	size_t ix, parent;
 
-	/* Append at the end */
+	if (queue->get_pending) {
+		queue->get_pending = 0;
+		queue->array[0].ctr = queue->insertion_ctr++;
+		queue->array[0].data = thing;
+		sift_down_root(queue);
+		return;
+	}
+
 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
 	queue->array[queue->nr].ctr = queue->insertion_ctr++;
 	queue->array[queue->nr].data = thing;
 	queue->nr++;
 	if (!queue->compare)
-		return; /* LIFO */
+		return;
 
-	/* Bubble up the new one */
 	for (ix = queue->nr - 1; ix; ix = parent) {
 		parent = (ix - 1) / 2;
 		if (compare(queue, parent, ix) <= 0)
 			break;
-
 		swap(queue, parent, ix);
 	}
 }
 
-static void sift_down_root(struct prio_queue *queue)
-{
-	size_t ix, child;
-
-	/* Push down the one at the root */
-	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
-		child = ix * 2 + 1; /* left */
-		if (child + 1 < queue->nr &&
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
 	if (!queue->nr)
 		return NULL;
 	if (!queue->compare)
-		return queue->array[--queue->nr].data; /* LIFO */
-
-	result = queue->array[0].data;
-	if (!--queue->nr)
-		return result;
+		return queue->array[--queue->nr].data;
+
+	if (queue->get_pending) {
+		if (!--queue->nr) {
+			queue->get_pending = 0;
+			return NULL;
+		}
+		queue->array[0] = queue->array[queue->nr];
+		sift_down_root(queue);
+	}
 
-	queue->array[0] = queue->array[queue->nr];
-	sift_down_root(queue);
-	return result;
+	queue->get_pending = 1;
+	return queue->array[0].data;
 }
 
 void *prio_queue_peek(struct prio_queue *queue)
@@ -100,19 +105,14 @@ void *prio_queue_peek(struct prio_queue *queue)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[queue->nr - 1].data;
-	return queue->array[0].data;
-}
 
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
+	if (queue->get_pending) {
+		queue->get_pending = 0;
+		if (!--queue->nr)
+			return NULL;
+		queue->array[0] = queue->array[queue->nr];
 		sift_down_root(queue);
 	}
+
+	return queue->array[0].data;
 }
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
-- 
gitgitgadget

