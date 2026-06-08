Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9B3BD63B
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945857; cv=none; b=X0XBSer8g2jmZGml2CVo284LFkpmlAxnHtv3HJHGhA4aAuH959fW+WI4GZuIHiAnwLmOcpHiffGltZ2tm8tucPc/tX5jt+oiWgMj7GC0TFi6pnQ1HAG2iRk2rAY9trmyhm09MDvryu26LVWYq9QPNb8e+YStvP7tM+c6MACX3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945857; c=relaxed/simple;
	bh=PJxp9HB6dBULv951SrCAwZ4LPgDv+lyjLULUxTIhDVw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=FyY+qqVTLUmFVt2xDAHfft91q3yhWbiDedRTChqzYW904A/p8IlpI3P8J6yr0llqQJo9IAFwfkcynFwUwOVfnB7sHLo9lY/ESGaHcdSlBGaS2LqNiO1SBkqVBwcI8CexfpAi3fjHRcbzz+Tb/tq/5z/IXK2DueyaJ6pywxKHrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evb6QCJC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evb6QCJC"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso1911554a91.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780945855; x=1781550655; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzl4f5liheBcMglVkr8Rk8DE0WcNVIop/j6xDbpL3PY=;
        b=Evb6QCJCo8UN/vn3IWLFd+hOa05JVoaNJWfbqSYR8VxZadrBu2VMl3WiwwYJKiFSw7
         Mvgbc0stHRtW8IQdXG2hmkE5SksHZI8n5jxFqGGAP+JN5Fzi2AZNA+bH6YVHGVAqfEVo
         DcLS7ktL1hBk6c109Iss2LFo196mBYg9FPhLg2TwzQ6aQzcbc/dooh1EHhe4ZGGZmJ1g
         4OlnkYYRnUbuBx0n2oTIlNgrlwAIK3Vi33koGgSfuBwq7O8Z2P/5esDavfSxQEoGTwy+
         wP4zeL+qbpQnG2KdoL2eam2ZEEaGelVOYFBE6VcKUJSYOntYzT+6YuumJqN8SDKYRfQX
         QJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780945855; x=1781550655;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzl4f5liheBcMglVkr8Rk8DE0WcNVIop/j6xDbpL3PY=;
        b=e/rjXDOTJxJPp2L59RvVXGhwMHSak1URf+95qOmFEUGqaWKzpfZOUwfs1BEh5S/zGG
         ArVVERiBDmG8FDe1NBZK6OOQ9vc2NpFFHluGDP43zClIp9g6s/H4zAFYnC++03j5aNS7
         VBJupfX0tJYDWPRXmmsrTFGt0JR+AMYyiMj2dmy/koK6k4UFrt+QNs0CX6U4Cg4DLgcI
         TqcAgyqd4UiO8tTvDPmNtYmaMxRgHGdOWBsfpzZ12HuJm6FdPH7rFj1C92WrhpBxsh9/
         I9qnhGRncftXHOM/iQnuEppl4nvfOQLfhVoU6n/VLKmBnNYYkIUCA+Q/nNTpgZ4msloY
         E6qw==
X-Gm-Message-State: AOJu0Yym+0yG1ySyF4WwNuXcf62WB+TNtV/1m2wt0ehp+IhxFbz1qBAM
	O4KP6It1Aps2VJso7O6bLVFJ/+nFSADpqjg2LXMDLcEW2iWWnnOpaMrP841Unw==
X-Gm-Gg: Acq92OGizAq/z0uKx8Apm/zfS06rODkd6tn5NLxTrKGH7gM648AxLSd4jCYMq4B/Odd
	JJn/8fbZ2rjw1dkofwQYOR/ZDRcKvj8ZsEzObvtY8Ms8OXwJUmFf3oCq8lBS+jCR4n4k0ef3tGL
	dz9cFGIPn99vDKDVNWeiGlysr3vxx3Q3w6o5P9fIUfz9rFt405tUpsQO+mX8X9hjWBdTEufGXxq
	2OWdBvNFjTpjh3VcVvUk9juPxQuNrrDoMCQOUIKm/1ABhbgn2eOAM8ak1BUjjqTU3Maj8J1H2MO
	3+D+KO6mVb4g1IlcSWG70vvt1pLYH8WVgrzm6kePkQASf7G3jM9wj2jLso+aRO9q1OWFqzTlx+g
	kZMnRLzBTseXAIjbhTxKT2N+QALXoGiCN7J8cpnV9I7hBurRivTlChRE+OqLbUyXx3D6fnA1UNT
	TlgwjCl+GkzMgnimMywWAvcuoAlVr5e8BXASLt
X-Received: by 2002:a17:90b:2c90:b0:36b:218c:719e with SMTP id 98e67ed59e1d1-370f0c4fa04mr16955273a91.21.1780945853992;
        Mon, 08 Jun 2026 12:10:53 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.213.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c668f90sm20778422a91.6.2026.06.08.12.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:10:53 -0700 (PDT)
Message-Id: <pull.2140.v4.git.1780945851.gitgitgadget@gmail.com>
In-Reply-To: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
References: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 19:10:49 +0000
Subject: [PATCH v4 0/2] prio-queue: fold lazy_queue into prio_queue for automatic get+put fusion
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

Rene's lazy_queue wrapper in describe.c was a clever optimization -- by
deferring the get, a following put becomes a simple replace, avoiding a full
remove-rebalance-insert cycle.

It turns out this pattern is so common in git's traversal code that it makes
sense to fold it into prio_queue itself. Gets and puts are interleaved in
virtually every commit walk, so the fusion is essentially always a win.

This is mostly a code simplification -- three callers had independently
reimplemented the same optimization, and they all collapse to plain get+put
now. The 1.7-2.7% speedup on traversal-heavy workloads is a nice bonus.

More details and benchmark numbers in the commit message.

Related to but independent of the cascade sift-down work in
kk/prio-queue-cascade-sift -- the two can land in either order.

Changes in v4:

 * Thanks Junio for review, applied all suggestions.

 * Renamed .nr_internal to .nr_

 * Restored flush_get() as a static inline helper instead of inlining the
   flush logic into get() and peek().

 * Guard empty-queue check with nr_ <= get_pending.

 * Flipped commit order: the rename/accessor commit is now first, and the
   behavioral fusion change is second. This was partly messy -- the first
   rename commit introduces some ugly intermediate code (e.g. describe.c's
   prio_queue_for_each with a skip variable) that gets cleaned up in commit
   2 when the lazy get makes it unnecessary.

Changes in v3:

 * Adopted Rene's suggestion to move the flush logic below the LIFO
   early-return (LIFO mode never sets get_pending, so flushing there is a
   no-op).

 * Went a step further and inlined the flush logic directly into get() and
   peek(), eliminating the flush_get() helper and its forward declaration of
   sift_down_root().

 * Updated benchmark numbers with more rigorous methodology: 30 interleaved
   runs with paired t-test on an idle server. Split results into code paths
   that already had manual fusion (neutral) vs code paths that benefit from
   the new automatic fusion (1.7-2.7% improvement).

Changes in v2:

 * Added a second commit that renames .nr to .nr_internal so that direct
   access from outside prio-queue.c is a compile error. Verified that after
   the rename, only prio-queue.c references nr_internal.

 * Added prio_queue_for_each() macro for callers that need to walk all
   elements (describe.c, show-branch.c, commit-reach.c, revision.c,
   negotiator/skipping.c).

 * Converted remaining .nr loop conditions to use
   prio_queue_get()/prio_queue_peek() as the loop condition, or
   prio_queue_size() where get/peek isn't suitable.

 * Fixed several callers missed in v1 (object-name.c, fetch-pack.c,
   path-walk.c, pack-bitmap-write.c, negotiator/default.c,
   negotiator/skipping.c, revision.c, builtin/last-modified.c).

Kristofer Karlsson (2):
  prio-queue: rename .nr to .nr_ and add accessor helpers
  prio-queue: fold lazy_queue into prio_queue for automatic get+put
    fusion

 builtin/describe.c          |  70 ++++++-----------------
 builtin/last-modified.c     |   7 +--
 builtin/show-branch.c       |  24 +++-----
 commit-reach.c              |  14 ++---
 commit.c                    |  11 +---
 fetch-pack.c                |   4 +-
 negotiator/default.c        |   4 +-
 negotiator/skipping.c       |  12 ++--
 object-name.c               |   2 +-
 pack-bitmap-write.c         |  10 ++--
 path-walk.c                 |   8 +--
 prio-queue.c                | 110 +++++++++++++++++++-----------------
 prio-queue.h                |  19 ++++---
 revision.c                  |  16 +++---
 t/unit-tests/u-prio-queue.c |   6 +-
 walker.c                    |   4 +-
 16 files changed, 141 insertions(+), 180 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2140%2Fspkrka%2Flazy-prio-queue-pr-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2140/spkrka/lazy-prio-queue-pr-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2140

Range-diff vs v3:

 2:  033215e304 ! 1:  d0f2294661 prio-queue: rename .nr to .nr_internal to prevent direct access
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    prio-queue: rename .nr to .nr_internal to prevent direct access
     +    prio-queue: rename .nr to .nr_ and add accessor helpers
      
     -    Rename the .nr member to .nr_internal so that callers outside
     -    prio-queue.c that directly reference .nr get a compilation error.
     -    This catches both existing misuse and future in-flight topics.
     +    Rename the .nr member to .nr_ so that callers outside prio-queue.c
     +    that directly reference .nr get a compilation error.  This catches
     +    both existing misuse and future in-flight topics.
      
     -    Add prio_queue_for_each() macro for callers that need to walk all
     -    elements in the queue, accounting for the get_pending offset.
     +    Add prio_queue_size() for callers that need to know the element count
     +    and prio_queue_for_each() for callers that need to walk all elements.
      
          Convert all external .nr users:
           - Loop conditions: use prio_queue_size(), prio_queue_get(), or
     @@ Commit message
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## builtin/describe.c ##
     -@@ builtin/describe.c: static unsigned long finish_depth_computation(struct prio_queue *queue,
     - 	struct oidset unflagged = OIDSET_INIT;
     - 	struct commit *c;
     +@@ builtin/describe.c: static void lazy_queue_put(struct lazy_queue *queue, void *thing)
       
     --	for (size_t i = queue->get_pending; i < queue->nr; i++) {
     --		struct commit *commit = queue->array[i].data;
     --		if (!(commit->object.flags & best->flag_within))
     --			oidset_insert(&unflagged, &commit->object.oid);
     -+	prio_queue_for_each(queue, c) {
     -+		if (!(c->object.flags & best->flag_within))
     -+			oidset_insert(&unflagged, &c->object.oid);
     - 	}
     + static bool lazy_queue_empty(const struct lazy_queue *queue)
     + {
     +-	return queue->queue.nr == (queue->get_pending ? 1 : 0);
     ++	return prio_queue_size(&queue->queue) == (queue->get_pending ? 1 : 0);
     + }
       
     - 	while ((c = prio_queue_get(queue))) {
     + static void lazy_queue_clear(struct lazy_queue *queue)
     +@@ builtin/describe.c: static unsigned long finish_depth_computation(struct lazy_queue *queue,
     + {
     + 	unsigned long seen_commits = 0;
     + 	struct oidset unflagged = OIDSET_INIT;
     ++	struct commit *commit;
     ++	int skip = queue->get_pending ? 1 : 0;
     + 
     +-	for (size_t i = queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) {
     +-		struct commit *commit = queue->queue.array[i].data;
     ++	prio_queue_for_each(&queue->queue, commit) {
     ++		if (skip) {
     ++			skip = 0;
     ++			continue;
     ++		}
     + 		if (!(commit->object.flags & best->flag_within))
     + 			oidset_insert(&unflagged, &commit->object.oid);
     + 	}
      
       ## builtin/last-modified.c ##
      @@ builtin/last-modified.c: static void process_parent(struct last_modified *lm,
       static int last_modified_run(struct last_modified *lm)
       {
       	int max_count, queue_popped = 0;
     --	struct commit *c;
      +	struct commit *c, *n;
       	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
       	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
       	struct commit_list *list;
     +@@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm)
     + 		}
     + 	}
     + 
     +-	while (queue.nr) {
     ++	while ((c = prio_queue_get(&queue))) {
     + 		int parent_i;
     + 		struct commit_list *p;
     +-		struct commit *c = prio_queue_get(&queue);
     + 		struct bitmap *active_c = active_paths_for(lm, c);
     + 
     + 		if ((0 <= max_count && max_count < ++queue_popped) ||
      @@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm)
       		 */
       		repo_parse_commit(lm->rev.repo, c);
     @@ builtin/show-branch.c: static const char *get_color_reset_code(void)
       
       static struct commit *interesting(struct prio_queue *queue)
       {
     --	for (size_t i = queue->get_pending; i < queue->nr; i++) {
     +-	for (size_t i = 0; i < queue->nr; i++) {
      -		struct commit *commit = queue->array[i].data;
      -		if (commit->object.flags & UNINTERESTING)
      -			continue;
     @@ builtin/show-branch.c: static const char *get_color_reset_code(void)
       	}
       	return NULL;
       }
     +@@ builtin/show-branch.c: static void join_revs(struct prio_queue *queue,
     + {
     + 	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
     + 	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
     ++	struct commit *commit;
     + 
     +-	while (queue->nr) {
     ++	while ((commit = prio_queue_peek(queue))) {
     + 		struct commit_list *parents;
     + 		int still_interesting = !!interesting(queue);
     +-		struct commit *commit = prio_queue_peek(queue);
     + 		bool get_pending = true;
     + 		int flags = commit->object.flags & all_mask;
     + 
      
       ## commit-reach.c ##
      @@ commit-reach.c: static int compare_commits_by_gen(const void *_a, const void *_b)
     @@ commit-reach.c: static int compare_commits_by_gen(const void *_a, const void *_b
       			return 1;
       	}
      @@ commit-reach.c: void ahead_behind(struct repository *r,
     - 		  struct commit **commits, size_t commits_nr,
       		  struct ahead_behind_count *counts, size_t counts_nr)
       {
     -+	struct commit *c;
       	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
     ++	void *entry;
       	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
       
     -@@ commit-reach.c: void ahead_behind(struct repository *r,
     - 	init_bit_arrays(&bit_arrays);
     - 
     - 	for (size_t i = 0; i < commits_nr; i++) {
     --		struct commit *c = commits[i];
     --		struct bitmap *bitmap = get_bit_array(c, width);
     -+		struct bitmap *bitmap;
     -+		c = commits[i];
     -+		bitmap = get_bit_array(c, width);
     - 
     - 		bitmap_set(bitmap, i);
     - 		insert_no_dup(&queue, c);
     - 	}
     - 
     - 	while (queue_has_nonstale(&queue)) {
     --		struct commit *c = prio_queue_get(&queue);
     - 		struct commit_list *p;
     --		struct bitmap *bitmap_c = get_bit_array(c, width);
     -+		struct bitmap *bitmap_c;
     -+		c = prio_queue_get(&queue);
     -+		bitmap_c = get_bit_array(c, width);
     - 
     - 		for (size_t i = 0; i < counts_nr; i++) {
     - 			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
     + 	if (!commits_nr || !counts_nr)
      @@ commit-reach.c: void ahead_behind(struct repository *r,
       
       	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
       	repo_clear_commit_marks(r, PARENT2 | STALE);
      -	for (size_t i = 0; i < queue.nr; i++)
      -		free_bit_array(queue.array[i].data);
     -+	prio_queue_for_each(&queue, c)
     -+		free_bit_array(c);
     ++	prio_queue_for_each(&queue, entry)
     ++		free_bit_array(entry);
       	clear_bit_arrays(&bit_arrays);
       	clear_prio_queue(&queue);
       }
     +@@ commit-reach.c: int get_branch_base_for_tip(struct repository *r,
     + 			    size_t bases_nr)
     + {
     + 	int best_index = -1;
     +-	struct commit *branch_point = NULL;
     ++	struct commit *c, *branch_point = NULL;
     + 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     + 	int found_missing_gen = 0;
     + 
     +@@ commit-reach.c: int get_branch_base_for_tip(struct repository *r,
     + 		prio_queue_put(&queue, c);
     + 	}
     + 
     +-	while (queue.nr) {
     +-		struct commit *c = prio_queue_get(&queue);
     ++	while ((c = prio_queue_get(&queue))) {
     + 		int best_for_c = get_best(c);
     + 		int best_for_p, positive;
     + 		struct commit *parent;
      
       ## fetch-pack.c ##
      @@ fetch-pack.c: static int mark_complete_oid(const struct reference *ref, void *cb_data UNUSED)
     @@ object-name.c: static int get_oid_oneline(struct repository *r,
      
       ## pack-bitmap-write.c ##
      @@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bitmap_writer *writer,
     + 			      struct bitmap_index *old_bitmap,
       			      const uint32_t *mapping)
       {
     - 	struct commit *c;
     ++	struct commit *c;
      +	struct tree *tree;
       	int found;
       	uint32_t pos;
       	if (!ent->bitmap)
      @@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bitmap_writer *writer,
     + 
     + 	prio_queue_put(queue, commit);
     + 
     +-	while (queue->nr) {
     ++	while ((c = prio_queue_get(queue))) {
     + 		struct commit_list *p;
     +-		struct commit *c = prio_queue_get(queue);
     + 
     + 		if (old_bitmap && mapping) {
     + 			struct ewah_bitmap *old;
     +@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bitmap_writer *writer,
       		}
       	}
       
     @@ prio-queue.c: void prio_queue_reverse(struct prio_queue *queue)
       	if (queue->compare)
       		BUG("prio_queue_reverse() on non-LIFO queue");
      -	if (!queue->nr)
     -+	if (!queue->nr_internal)
     ++	if (!queue->nr_)
       		return;
      -	for (i = 0; i < (j = (queue->nr - 1) - i); i++)
     -+	for (i = 0; i < (j = (queue->nr_internal - 1) - i); i++)
     ++	for (i = 0; i < (j = (queue->nr_ - 1) - i); i++)
       		swap(queue, i, j);
       }
       
     @@ prio-queue.c: void prio_queue_reverse(struct prio_queue *queue)
       {
       	FREE_AND_NULL(queue->array);
      -	queue->nr = 0;
     -+	queue->nr_internal = 0;
     ++	queue->nr_ = 0;
       	queue->alloc = 0;
       	queue->insertion_ctr = 0;
     - 	queue->get_pending = 0;
     -@@ prio-queue.c: static void sift_down_root(struct prio_queue *queue)
     - {
     - 	size_t ix, child;
     - 
     --	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
     --		child = ix * 2 + 1;
     --		if (child + 1 < queue->nr &&
     -+	/* Push down the one at the root */
     -+	for (ix = 0; ix * 2 + 1 < queue->nr_internal; ix = child) {
     -+		child = ix * 2 + 1; /* left */
     -+		if (child + 1 < queue->nr_internal &&
     - 		    compare(queue, child, child + 1) >= 0)
     --			child++;
     -+			child++; /* use right child */
     -+
     - 		if (compare(queue, ix, child) <= 0)
     - 			break;
     -+
     - 		swap(queue, child, ix);
     - 	}
       }
      @@ prio-queue.c: void prio_queue_put(struct prio_queue *queue, void *thing)
     - 		return;
     - 	}
     + 	size_t ix, parent;
       
     + 	/* Append at the end */
      -	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
      -	queue->array[queue->nr].ctr = queue->insertion_ctr++;
      -	queue->array[queue->nr].data = thing;
      -	queue->nr++;
     -+	/* Append at the end */
     -+	ALLOC_GROW(queue->array, queue->nr_internal + 1, queue->alloc);
     -+	queue->array[queue->nr_internal].ctr = queue->insertion_ctr++;
     -+	queue->array[queue->nr_internal].data = thing;
     -+	queue->nr_internal++;
     ++	ALLOC_GROW(queue->array, queue->nr_ + 1, queue->alloc);
     ++	queue->array[queue->nr_].ctr = queue->insertion_ctr++;
     ++	queue->array[queue->nr_].data = thing;
     ++	queue->nr_++;
       	if (!queue->compare)
     --		return;
     -+		return; /* LIFO */
     + 		return; /* LIFO */
       
     + 	/* Bubble up the new one */
      -	for (ix = queue->nr - 1; ix; ix = parent) {
     -+	/* Bubble up the new one */
     -+	for (ix = queue->nr_internal - 1; ix; ix = parent) {
     ++	for (ix = queue->nr_ - 1; ix; ix = parent) {
       		parent = (ix - 1) / 2;
       		if (compare(queue, parent, ix) <= 0)
       			break;
     -+
     - 		swap(queue, parent, ix);
     - 	}
     - }
     +@@ prio-queue.c: static void sift_down_root(struct prio_queue *queue)
     + 	size_t ix, child;
     + 
     + 	/* Push down the one at the root */
     +-	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
     ++	for (ix = 0; ix * 2 + 1 < queue->nr_; ix = child) {
     + 		child = ix * 2 + 1; /* left */
     +-		if (child + 1 < queue->nr &&
     ++		if (child + 1 < queue->nr_ &&
     + 		    compare(queue, child, child + 1) >= 0)
     + 			child++; /* use right child */
       
     - void *prio_queue_get(struct prio_queue *queue)
     +@@ prio-queue.c: void *prio_queue_get(struct prio_queue *queue)
       {
     + 	void *result;
     + 
      -	if (!queue->nr)
     -+	if (!queue->nr_internal)
     ++	if (!queue->nr_)
       		return NULL;
       	if (!queue->compare)
     --		return queue->array[--queue->nr].data;
     -+		return queue->array[--queue->nr_internal].data; /* LIFO */
     - 
     - 	if (queue->get_pending) {
     --		if (!--queue->nr) {
     -+		if (!--queue->nr_internal) {
     - 			queue->get_pending = 0;
     - 			return NULL;
     - 		}
     --		queue->array[0] = queue->array[queue->nr];
     -+		queue->array[0] = queue->array[queue->nr_internal];
     - 		sift_down_root(queue);
     - 	}
     - 
     -@@ prio-queue.c: void *prio_queue_get(struct prio_queue *queue)
     +-		return queue->array[--queue->nr].data; /* LIFO */
     ++		return queue->array[--queue->nr_].data; /* LIFO */
     + 
     + 	result = queue->array[0].data;
     +-	if (!--queue->nr)
     ++	if (!--queue->nr_)
     + 		return result;
     + 
     +-	queue->array[0] = queue->array[queue->nr];
     ++	queue->array[0] = queue->array[queue->nr_];
     + 	sift_down_root(queue);
     + 	return result;
     + }
       
       void *prio_queue_peek(struct prio_queue *queue)
       {
      -	if (!queue->nr)
     -+	if (!queue->nr_internal)
     ++	if (!queue->nr_)
       		return NULL;
       	if (!queue->compare)
      -		return queue->array[queue->nr - 1].data;
     -+		return queue->array[queue->nr_internal - 1].data;
     - 
     - 	if (queue->get_pending) {
     - 		queue->get_pending = 0;
     --		if (!--queue->nr)
     -+		if (!--queue->nr_internal)
     - 			return NULL;
     --		queue->array[0] = queue->array[queue->nr];
     -+		queue->array[0] = queue->array[queue->nr_internal];
     - 		sift_down_root(queue);
     - 	}
     ++		return queue->array[queue->nr_ - 1].data;
     + 	return queue->array[0].data;
     + }
       
     + void prio_queue_replace(struct prio_queue *queue, void *thing)
     + {
     +-	if (!queue->nr) {
     ++	if (!queue->nr_) {
     + 		prio_queue_put(queue, thing);
     + 	} else if (!queue->compare) {
     +-		queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
     +-		queue->array[queue->nr - 1].data = thing;
     ++		queue->array[queue->nr_ - 1].ctr = queue->insertion_ctr++;
     ++		queue->array[queue->nr_ - 1].data = thing;
     + 	} else {
     + 		queue->array[0].ctr = queue->insertion_ctr++;
     + 		queue->array[0].data = thing;
      
       ## prio-queue.h ##
      @@ prio-queue.h: struct prio_queue {
     @@ prio-queue.h: struct prio_queue {
       	size_t insertion_ctr;
       	void *cb_data;
      -	size_t alloc, nr;
     -+	size_t alloc, nr_internal; /* use prio_queue_size() for logical count */
     ++	size_t alloc, nr_;
       	struct prio_queue_entry *array;
     - 	unsigned get_pending;
       };
     -@@ prio-queue.h: void *prio_queue_peek(struct prio_queue *);
       
     - static inline size_t prio_queue_size(struct prio_queue *queue)
     - {
     --	return queue->nr - queue->get_pending;
     -+	return queue->nr_internal - queue->get_pending;
     - }
     +@@ prio-queue.h: void *prio_queue_get(struct prio_queue *);
     +  */
     + void *prio_queue_peek(struct prio_queue *);
       
     ++static inline size_t prio_queue_size(const struct prio_queue *queue)
     ++{
     ++	return queue->nr_;
     ++}
     ++
      +#define prio_queue_for_each(queue, it) \
     -+	for (size_t pq_ix_ = (queue)->get_pending; \
     -+	     pq_ix_ < (queue)->nr_internal && ((it) = (queue)->array[pq_ix_].data, 1); \
     ++	for (size_t pq_ix_ = 0; \
     ++	     pq_ix_ < (queue)->nr_ && ((it) = (queue)->array[pq_ix_].data, 1); \
      +	     pq_ix_++)
      +
     - void clear_prio_queue(struct prio_queue *);
     - 
     - /* Reverse the LIFO elements */
     + /*
     +  * Replace the "thing" that compares the smallest with a new "thing",
     +  * like prio_queue_get()+prio_queue_put() would do, but in a more
      
       ## revision.c ##
      @@ revision.c: static struct commit *handle_commit(struct rev_info *revs,
     @@ revision.c: static struct commit *handle_commit(struct rev_info *revs,
       		if (commit->object.flags & UNINTERESTING)
       			continue;
       
     +@@ revision.c: static int limit_list(struct rev_info *revs)
     + 	struct commit_list *original_list = revs->commits;
     + 	struct commit_list *newlist = NULL;
     + 	struct commit_list **p = &newlist;
     +-	struct commit *interesting_cache = NULL;
     ++	struct commit *commit, *interesting_cache = NULL;
     + 	struct prio_queue queue = { .compare = compare_commits_by_commit_date };
     + 
     + 	if (revs->ancestry_path_implicit_bottoms) {
     +@@ revision.c: static int limit_list(struct rev_info *revs)
     + 		prio_queue_put(&queue, commit);
     + 	}
     + 
     +-	while (queue.nr) {
     +-		struct commit *commit = prio_queue_get(&queue);
     ++	while ((commit = prio_queue_get(&queue))) {
     + 		struct object *obj = &commit->object;
     + 
     + 		if (commit == interesting_cache)
      @@ revision.c: static enum rewrite_result rewrite_one_1(struct rev_info *revs,
       
       static void merge_queue_into_list(struct prio_queue *q, struct commit_list **list)
     @@ revision.c: static enum rewrite_result rewrite_one_1(struct rev_info *revs,
       		struct commit_list *p = *list;
       
       		if (p && p->item->date >= item->date)
     +
     + ## walker.c ##
     +@@ walker.c: static struct prio_queue complete = { compare_commits_by_commit_date };
     + static int process_commit(struct walker *walker, struct commit *commit)
     + {
     + 	struct commit_list *parents;
     ++	struct commit *item;
     + 
     + 	if (repo_parse_commit(the_repository, commit))
     + 		return -1;
     + 
     +-	while (complete.nr) {
     +-		struct commit *item = prio_queue_peek(&complete);
     ++	while ((item = prio_queue_peek(&complete))) {
     + 		if (item->date < commit->date)
     + 			break;
     + 		pop_most_recent_commit(&complete, COMPLETE);
 1:  e882206d29 ! 2:  a3f4cb57f2 prio-queue: fold lazy_queue into prio_queue for automatic get+put fusion
     @@ Commit message
      
          Defer the actual removal in prio_queue_get() until the next
          operation.  If that next operation is a prio_queue_put(), the
     -    removal and insertion are fused into a single replace, writing
     -    the new element at the root and sifting it down which avoids
     +    removal and insertion are fused into a single replace — writing
     +    the new element at the root and sifting it down — which avoids
          a full remove-rebalance-insert cycle.
      
          This matches the dominant usage pattern in git's commit traversal:
     -    get a commit, then put its parents. The first parent insertion
     +    get a commit, then put its parents.  The first parent insertion
          after each get is now a replace operation automatically.
      
          This generalizes the lazy_queue pattern from builtin/describe.c
     -    (introduced in 08bb69d70f) into prio_queue itself. Three callers
     +    (introduced in 08bb69d70f) into prio_queue itself.  Three callers
          independently implemented the same get+put fusion:
      
            - builtin/describe.c had a full lazy_queue wrapper
     @@ Commit message
            - builtin/show-branch.c:join_revs() used peek+replace
      
          All three now collapse to plain _get() and _put(), with the data
     -    structure handling the fusion internally. This simplifies callers
     +    structure handling the fusion internally.  This simplifies callers
          and means every prio_queue user gets the optimization for free
          without needing to implement it manually.
      
          Remove prio_queue_replace() since no external callers remain.
     -    Add prio_queue_size() for callers that need the logical element
     -    count, since the physical nr may temporarily include a
     -    pending-removal element.
      
     -    Benchmarked on a large monorepo (30 interleaved runs,
     +    Benchmarked on a 1.8M-commit monorepo (30 interleaved runs,
          paired t-test, Xeon @ 2.20GHz):
      
          Code paths that previously did eager get+put (new optimization):
      
     -      Command                       base    patched  change  p
     +      Command                       base    patched  change      p
            merge-base --all A A~1000     3828ms  3725ms   -2.69%  0.0001
            rev-list --count A~1000..A    3055ms  2986ms   -2.27%  0.0601
            log --oneline A~1000..A       3408ms  3350ms   -1.71%  0.0482
      
          Code paths that already had manual get+put fusion (expect
     -    neutral - the optimization moves into prio_queue but the number
     +    neutral — the optimization moves into prio_queue but the number
          of heap operations stays the same):
      
     -      Command                base   patched  change  p
     -      show-branch A A~1000   9156ms  9127ms  -0.32%  0.3470
     -      describe (git.git)     1983ms  1963ms  -1.02%  <0.001
     +      Command                       base    patched  change      p
     +      show-branch A A~1000          9156ms  9127ms   -0.32%  0.3470
     +      describe (4751 revs, 81K repo) 1983ms 1963ms  -1.02%  <0.001
      
          No regressions in any scenario.
      
     @@ builtin/describe.c: static int compare_pt(const void *a_, const void *b_)
      -
      -static bool lazy_queue_empty(const struct lazy_queue *queue)
      -{
     --	return queue->queue.nr == (queue->get_pending ? 1 : 0);
     +-	return prio_queue_size(&queue->queue) == (queue->get_pending ? 1 : 0);
      -}
      -
      -static void lazy_queue_clear(struct lazy_queue *queue)
     @@ builtin/describe.c: static int compare_pt(const void *a_, const void *b_)
       {
       	unsigned long seen_commits = 0;
       	struct oidset unflagged = OIDSET_INIT;
     +-	struct commit *commit;
     +-	int skip = queue->get_pending ? 1 : 0;
      +	struct commit *c;
       
     --	for (size_t i = queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) {
     --		struct commit *commit = queue->queue.array[i].data;
     -+	for (size_t i = queue->get_pending; i < queue->nr; i++) {
     -+		struct commit *commit = queue->array[i].data;
     - 		if (!(commit->object.flags & best->flag_within))
     - 			oidset_insert(&unflagged, &commit->object.oid);
     +-	prio_queue_for_each(&queue->queue, commit) {
     +-		if (skip) {
     +-			skip = 0;
     +-			continue;
     +-		}
     +-		if (!(commit->object.flags & best->flag_within))
     +-			oidset_insert(&unflagged, &commit->object.oid);
     ++	prio_queue_for_each(queue, c) {
     ++		if (!(c->object.flags & best->flag_within))
     ++			oidset_insert(&unflagged, &c->object.oid);
       	}
       
      -	while (!lazy_queue_empty(queue)) {
     @@ builtin/describe.c: static void describe_commit(struct commit *cmit, struct strb
       	if (debug) {
       		static int label_width = -1;
      
     - ## builtin/last-modified.c ##
     -@@ builtin/last-modified.c: static void process_parent(struct last_modified *lm,
     - static int last_modified_run(struct last_modified *lm)
     - {
     - 	int max_count, queue_popped = 0;
     -+	struct commit *c;
     - 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     - 	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
     - 	struct commit_list *list;
     -@@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm)
     - 		}
     - 	}
     - 
     --	while (queue.nr) {
     -+	while ((c = prio_queue_get(&queue))) {
     - 		int parent_i;
     - 		struct commit_list *p;
     --		struct commit *c = prio_queue_get(&queue);
     - 		struct bitmap *active_c = active_paths_for(lm, c);
     - 
     - 		if ((0 <= max_count && max_count < ++queue_popped) ||
     -
       ## builtin/show-branch.c ##
     -@@ builtin/show-branch.c: static const char *get_color_reset_code(void)
     - 
     - static struct commit *interesting(struct prio_queue *queue)
     - {
     --	for (size_t i = 0; i < queue->nr; i++) {
     -+	for (size_t i = queue->get_pending; i < queue->nr; i++) {
     - 		struct commit *commit = queue->array[i].data;
     - 		if (commit->object.flags & UNINTERESTING)
     - 			continue;
      @@ builtin/show-branch.c: static void join_revs(struct prio_queue *queue,
     - {
     - 	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
     - 	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
     -+	struct commit *commit;
     - 
     --	while (queue->nr) {
     -+	while ((commit = prio_queue_peek(queue))) {
     + 	while ((commit = prio_queue_peek(queue))) {
       		struct commit_list *parents;
       		int still_interesting = !!interesting(queue);
     --		struct commit *commit = prio_queue_peek(queue);
      -		bool get_pending = true;
       		int flags = commit->object.flags & all_mask;
       
     @@ builtin/show-branch.c: static void join_revs(struct prio_queue *queue,
       
       	/*
      
     - ## commit-reach.c ##
     -@@ commit-reach.c: int get_branch_base_for_tip(struct repository *r,
     - 			    size_t bases_nr)
     - {
     - 	int best_index = -1;
     --	struct commit *branch_point = NULL;
     -+	struct commit *c, *branch_point = NULL;
     - 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     - 	int found_missing_gen = 0;
     - 
     -@@ commit-reach.c: int get_branch_base_for_tip(struct repository *r,
     - 		prio_queue_put(&queue, c);
     - 	}
     - 
     --	while (queue.nr) {
     --		struct commit *c = prio_queue_get(&queue);
     -+	while ((c = prio_queue_get(&queue))) {
     - 		int best_for_c = get_best(c);
     - 		int best_for_p, positive;
     - 		struct commit *parent;
     -
       ## commit.c ##
      @@ commit.c: void commit_list_sort_by_date(struct commit_list **list)
       struct commit *pop_most_recent_commit(struct prio_queue *queue,
     @@ commit.c: void commit_list_sort_by_date(struct commit_list **list)
       }
       
      
     - ## pack-bitmap-write.c ##
     -@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bitmap_writer *writer,
     - 			      struct bitmap_index *old_bitmap,
     - 			      const uint32_t *mapping)
     - {
     -+	struct commit *c;
     - 	int found;
     - 	uint32_t pos;
     - 	if (!ent->bitmap)
     -@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bitmap_writer *writer,
     - 
     - 	prio_queue_put(queue, commit);
     - 
     --	while (queue->nr) {
     -+	while ((c = prio_queue_get(queue))) {
     - 		struct commit_list *p;
     --		struct commit *c = prio_queue_get(queue);
     - 
     - 		if (old_bitmap && mapping) {
     - 			struct ewah_bitmap *old;
     -
       ## prio-queue.c ##
      @@ prio-queue.c: void clear_prio_queue(struct prio_queue *queue)
     - 	queue->nr = 0;
     + 	queue->nr_ = 0;
       	queue->alloc = 0;
       	queue->insertion_ctr = 0;
      +	queue->get_pending = 0;
     @@ prio-queue.c: void clear_prio_queue(struct prio_queue *queue)
      +{
      +	size_t ix, child;
      +
     -+	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
     -+		child = ix * 2 + 1;
     -+		if (child + 1 < queue->nr &&
     ++	/* Push down the one at the root */
     ++	for (ix = 0; ix * 2 + 1 < queue->nr_; ix = child) {
     ++		child = ix * 2 + 1; /* left */
     ++		if (child + 1 < queue->nr_ &&
      +		    compare(queue, child, child + 1) >= 0)
     -+			child++;
     ++			child++; /* use right child */
     ++
      +		if (compare(queue, ix, child) <= 0)
      +			break;
     ++
      +		swap(queue, child, ix);
      +	}
     ++}
     ++
     ++static inline void flush_get(struct prio_queue *queue)
     ++{
     ++	if (!queue->get_pending)
     ++		return;
     ++	queue->get_pending = 0;
     ++	queue->array[0] = queue->array[--queue->nr_];
     ++	sift_down_root(queue);
       }
       
       void prio_queue_put(struct prio_queue *queue, void *thing)
       {
       	size_t ix, parent;
       
     --	/* Append at the end */
      +	if (queue->get_pending) {
      +		queue->get_pending = 0;
      +		queue->array[0].ctr = queue->insertion_ctr++;
     @@ prio-queue.c: void clear_prio_queue(struct prio_queue *queue)
      +		return;
      +	}
      +
     - 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
     - 	queue->array[queue->nr].ctr = queue->insertion_ctr++;
     - 	queue->array[queue->nr].data = thing;
     - 	queue->nr++;
     - 	if (!queue->compare)
     --		return; /* LIFO */
     -+		return;
     - 
     --	/* Bubble up the new one */
     - 	for (ix = queue->nr - 1; ix; ix = parent) {
     - 		parent = (ix - 1) / 2;
     - 		if (compare(queue, parent, ix) <= 0)
     - 			break;
     --
     - 		swap(queue, parent, ix);
     + 	/* Append at the end */
     + 	ALLOC_GROW(queue->array, queue->nr_ + 1, queue->alloc);
     + 	queue->array[queue->nr_].ctr = queue->insertion_ctr++;
     +@@ prio-queue.c: void prio_queue_put(struct prio_queue *queue, void *thing)
       	}
       }
       
     @@ prio-queue.c: void clear_prio_queue(struct prio_queue *queue)
      -	size_t ix, child;
      -
      -	/* Push down the one at the root */
     --	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
     +-	for (ix = 0; ix * 2 + 1 < queue->nr_; ix = child) {
      -		child = ix * 2 + 1; /* left */
     --		if (child + 1 < queue->nr &&
     +-		if (child + 1 < queue->nr_ &&
      -		    compare(queue, child, child + 1) >= 0)
      -			child++; /* use right child */
      -
     @@ prio-queue.c: void clear_prio_queue(struct prio_queue *queue)
       {
      -	void *result;
      -
     - 	if (!queue->nr)
     +-	if (!queue->nr_)
     ++	if (queue->nr_ <= queue->get_pending) {
     ++		queue->nr_ = 0;
     ++		queue->get_pending = 0;
       		return NULL;
     ++	}
       	if (!queue->compare)
     --		return queue->array[--queue->nr].data; /* LIFO */
     --
     + 		return queue->array[--queue->nr_].data; /* LIFO */
     + 
      -	result = queue->array[0].data;
     --	if (!--queue->nr)
     +-	if (!--queue->nr_)
      -		return result;
     -+		return queue->array[--queue->nr].data;
     -+
     -+	if (queue->get_pending) {
     -+		if (!--queue->nr) {
     -+			queue->get_pending = 0;
     -+			return NULL;
     -+		}
     -+		queue->array[0] = queue->array[queue->nr];
     -+		sift_down_root(queue);
     -+	}
     ++	flush_get(queue);
       
     --	queue->array[0] = queue->array[queue->nr];
     +-	queue->array[0] = queue->array[queue->nr_];
      -	sift_down_root(queue);
      -	return result;
      +	queue->get_pending = 1;
     @@ prio-queue.c: void clear_prio_queue(struct prio_queue *queue)
       }
       
       void *prio_queue_peek(struct prio_queue *queue)
     -@@ prio-queue.c: void *prio_queue_peek(struct prio_queue *queue)
     + {
     +-	if (!queue->nr_)
     ++	if (queue->nr_ <= queue->get_pending) {
     ++		queue->nr_ = 0;
     ++		queue->get_pending = 0;
       		return NULL;
     ++	}
       	if (!queue->compare)
     - 		return queue->array[queue->nr - 1].data;
     + 		return queue->array[queue->nr_ - 1].data;
      -	return queue->array[0].data;
      -}
       
      -void prio_queue_replace(struct prio_queue *queue, void *thing)
      -{
     --	if (!queue->nr) {
     +-	if (!queue->nr_) {
      -		prio_queue_put(queue, thing);
      -	} else if (!queue->compare) {
     --		queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
     --		queue->array[queue->nr - 1].data = thing;
     +-		queue->array[queue->nr_ - 1].ctr = queue->insertion_ctr++;
     +-		queue->array[queue->nr_ - 1].data = thing;
      -	} else {
      -		queue->array[0].ctr = queue->insertion_ctr++;
      -		queue->array[0].data = thing;
     -+	if (queue->get_pending) {
     -+		queue->get_pending = 0;
     -+		if (!--queue->nr)
     -+			return NULL;
     -+		queue->array[0] = queue->array[queue->nr];
     - 		sift_down_root(queue);
     - 	}
     +-		sift_down_root(queue);
     +-	}
     ++	flush_get(queue);
      +
      +	return queue->array[0].data;
       }
      
       ## prio-queue.h ##
      @@ prio-queue.h: struct prio_queue {
     + 	prio_queue_compare_fn compare;
     + 	size_t insertion_ctr;
       	void *cb_data;
     - 	size_t alloc, nr;
     +-	size_t alloc, nr_;
     ++	size_t alloc, nr_; /* use prio_queue_size() for logical count */
       	struct prio_queue_entry *array;
      +	unsigned get_pending;
       };
       
       /*
     -@@ prio-queue.h: void *prio_queue_get(struct prio_queue *);
     -  */
     - void *prio_queue_peek(struct prio_queue *);
     +@@ prio-queue.h: void *prio_queue_peek(struct prio_queue *);
     + 
     + static inline size_t prio_queue_size(const struct prio_queue *queue)
     + {
     +-	return queue->nr_;
     ++	return queue->nr_ - queue->get_pending;
     + }
     + 
     + #define prio_queue_for_each(queue, it) \
     +-	for (size_t pq_ix_ = 0; \
     ++	for (size_t pq_ix_ = (queue)->get_pending; \
     + 	     pq_ix_ < (queue)->nr_ && ((it) = (queue)->array[pq_ix_].data, 1); \
     + 	     pq_ix_++)
       
      -/*
      - * Replace the "thing" that compares the smallest with a new "thing",
     @@ prio-queue.h: void *prio_queue_get(struct prio_queue *);
      - * empty.
      - */
      -void prio_queue_replace(struct prio_queue *queue, void *thing);
     -+static inline size_t prio_queue_size(struct prio_queue *queue)
     -+{
     -+	return queue->nr - queue->get_pending;
     -+}
     - 
     +-
       void clear_prio_queue(struct prio_queue *);
       
     -
     - ## revision.c ##
     -@@ revision.c: static int limit_list(struct rev_info *revs)
     - 	struct commit_list *original_list = revs->commits;
     - 	struct commit_list *newlist = NULL;
     - 	struct commit_list **p = &newlist;
     --	struct commit *interesting_cache = NULL;
     -+	struct commit *commit, *interesting_cache = NULL;
     - 	struct prio_queue queue = { .compare = compare_commits_by_commit_date };
     - 
     - 	if (revs->ancestry_path_implicit_bottoms) {
     -@@ revision.c: static int limit_list(struct rev_info *revs)
     - 		prio_queue_put(&queue, commit);
     - 	}
     - 
     --	while (queue.nr) {
     --		struct commit *commit = prio_queue_get(&queue);
     -+	while ((commit = prio_queue_get(&queue))) {
     - 		struct object *obj = &commit->object;
     - 
     - 		if (commit == interesting_cache)
     + /* Reverse the LIFO elements */
      
       ## t/unit-tests/u-prio-queue.c ##
      @@ t/unit-tests/u-prio-queue.c: static void test_prio_queue(int *input, size_t input_size,
     @@ t/unit-tests/u-prio-queue.c: static void test_prio_queue(int *input, size_t inpu
       			break;
       		default:
       			prio_queue_put(&pq, &input[i]);
     -
     - ## walker.c ##
     -@@ walker.c: static struct prio_queue complete = { compare_commits_by_commit_date };
     - static int process_commit(struct walker *walker, struct commit *commit)
     - {
     - 	struct commit_list *parents;
     -+	struct commit *item;
     - 
     - 	if (repo_parse_commit(the_repository, commit))
     - 		return -1;
     - 
     --	while (complete.nr) {
     --		struct commit *item = prio_queue_peek(&complete);
     -+	while ((item = prio_queue_peek(&complete))) {
     - 		if (item->date < commit->date)
     - 			break;
     - 		pop_most_recent_commit(&complete, COMPLETE);

-- 
gitgitgadget
