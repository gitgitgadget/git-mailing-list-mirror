Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E493ECBEE
	for <git@vger.kernel.org>; Mon, 25 May 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719297; cv=none; b=ekujTACS0x5Bb7KhUAmWejOWjHUuygy88iCfupH08h6RcaidHfwzsWQoFDkZBhK59bWRav+Nl4HgZu8rOO3w35F1mW1ryZXwLGVYAWbxdPWb6hf/0R8/WdtAbR5xdIIHx25Oj36yaiW+vyfe/TT8aCgFbBGK/Ktri7XA3T4Avlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719297; c=relaxed/simple;
	bh=enicBIgx5WC5USndHXFoG0Y9QcCRwiywwDzGkG+/3p8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=EbPs0RacGD2vyAbBE682Uro+sYEIF3Nt/UuyZ0tAJjaZTf2tMfFQyCgtfqMXy0qp4aoOOgSwzlTqHvLupRqBlrgGHQDVvmCYhrBHr7jwQno139sQvOGREgs/+6sS3Wha+IiHlxylXvCkmWI6M9458z459W1G0q/+LB861V02dTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvI3YOYy; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvI3YOYy"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516df90c167so24174181cf.0
        for <git@vger.kernel.org>; Mon, 25 May 2026 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779719293; x=1780324093; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Hv8Q2uGh9k84i7mhZxLF2077zImJBDtvVHZeUxUiaA=;
        b=FvI3YOYysCz0pJC1HpwymPREk5Akwq7O+s+7+teCLuIG5K+Ndg5GnWQ3c5ZzIVcIFQ
         wFZXfWHBUByyjdhzXTDEdc3DSAboVTKOi4aNx3KMb1zThcy0Ze22vJKbo2nRnPWICHUm
         wVO5rUiwkb+15aMcMwEphEXlGtGaOygZ/RodD7HuahzWfZC/rbQckNfG/1RrQuYwewg2
         XtccA0MsWvIIKUAOG4xO7vAt5MPXO+IPQwFgaTHowTHd0g0EJpuTFmqIYx1lXBC+r9NL
         8cUdB1gIt94xb19/P80CdL4AWMsAWPcaGZE7o+s97/cQcJtQzD3w9fMLl3F1h+IDjvrQ
         xsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719293; x=1780324093;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Hv8Q2uGh9k84i7mhZxLF2077zImJBDtvVHZeUxUiaA=;
        b=F7WFzpbsm3P/MbjlHExcg9xXhPjJG8ZqtQGWUNaqQSVX8FdwgOeqBeqSua+J5pgBqO
         3C6k8ZmYQQBNzr8rUiinmufz80yKu0WsG4bTwILH0mJaiVKFf9molDDMLSXVrfUsP7Q8
         S1OxeB4zSMvArR6O0imVWiA8Rft4CVc3NLz/0NmncWguDyo0+yOXC+E5yNp7nWNbtN6M
         ScnNaCQUjFr3rz7gLPVFDKe/m3E/haKZ0wDNh9L49qqVol09OwoYl2WQEZOjZfpp3AoE
         VtPVW3WIM7ZbaEv89ANGKbnfWa9jpe+IRcQK6A/+MBsAEYlb7vDI5RUOJbKEL6xfd+SN
         RUEg==
X-Gm-Message-State: AOJu0YyBLevaFqFNprA7oIRHDLhYDc5iRGZB7YVIUyCKg5B2Gi/o2/au
	Zu33HRyGU6AQwBI1Xh6/2CdFWGX2Dq+OgD2JGvS107TuaSuekI0f77kxow8p6Q==
X-Gm-Gg: Acq92OHX96voUAIEmVW7IajZu3SzwBpaeqC14QI5OEidXQHXs4kI+I5iffceRWaCnAu
	mSvIBae0zgnCbLI8PNq4+qlDaC5wc7KO5LQf4CxePtgBX/kki+UP3X9SFPoRc8YbEXfGXavOrKR
	CJRB5ph8i/QPZ4ObFaH4O5mNjMcT6Y0leXRVqXijQ0+VEH/KlDKaqpo80v6zBa5931aARmlNnOb
	5Y1mV+ttPSeqQwQBdx+EQAOwX6B2qEgkNxJFN05ZwK3NFka74Pb71neAi+gHsLcrGAn7CkHLLhT
	58OgznojOEiFcflSmHinozT0opoFtflALbLLXeGTHc5qqvq2ud0sXYcGI5KZEXIpRvt6MOmnwRa
	bfCgpc/cEnzi7IQ1ivpq37HuV3v5xrqEruPSqWr9oaDKJa26OdsT2H0Icg6P855f86injyxb7ny
	cuZARYsh7zIrgKBV0I5d8qIjA=
X-Received: by 2002:a05:622a:8c1c:b0:516:82e2:7788 with SMTP id d75a77b69052e-516c54cd049mr187117891cf.1.1779719287382;
        Mon, 25 May 2026 07:28:07 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.135.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8d0a4e3sm93357191cf.29.2026.05.25.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:28:06 -0700 (PDT)
Message-Id: <pull.2124.v2.git.1779719286.gitgitgadget@gmail.com>
In-Reply-To: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 14:28:02 +0000
Subject: [PATCH v2 0/3] commit-reach: replace queue_has_nonstale() scan with O(1) tracking
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
    Kristofer Karlsson <krka@spotify.com>

This is v2 of the series to replace the O(n) queue_has_nonstale() scan with
O(1) tracking.

Changes since v1:

 * Replaced the nonstale counter with a max_nonstale pointer approach, as
   suggested by Jeff King. Instead of counting non-stale entries, we track
   the lowest-priority non-stale commit; when it is popped, all remaining
   entries must be stale.

 * Restructured from 5 patches to 3:
   
   1. object.h: fix stale entries in object flag allocation table
   2. commit-reach: deduplicate queue entries in paint_down_to_common
   3. commit-reach: replace queue_has_nonstale() scan with O(1) tracking

 * Separated concerns: ENQUEUED dedup is a paint_down_to_common concern
   (commit 2), while nonstale_queue is a general wrapper usable by both
   paint_down_to_common and ahead_behind (commit 3). ahead_behind uses its
   own PARENT2-based dedup via insert_no_dup.

 * The nonstale_queue struct is intentionally kept thin (no ENQUEUED
   handling). Dedup variants (nonstale_queue_put_dedup /
   nonstale_queue_get_dedup) are layered on top for paint_down_to_common.

Performance on a large monorepo (3.7M commits), merge-base --all on deep
import branches:

                                      Baseline        Patched
component import, wide frontier (1):  8536ms           3956ms
component import, wide frontier (2):  5757ms           4383ms
component import, wide frontier (3):  4743ms           1927ms


Profiling shows paint_down_to_common() drops from 50% to 4% of total runtime
(~27x faster). The remaining time is in commit graph lookups, heap
operations, and object management — per-commit costs that are not addressed
by this series.

Simple/linear cases show no regression (sub-15ms regardless).

Kristofer Karlsson (3):
  object.h: fix stale entries in object flag allocation table
  commit-reach: deduplicate queue entries in paint_down_to_common
  commit-reach: replace queue_has_nonstale() scan with O(1) tracking

 commit-reach.c | 101 +++++++++++++++++++++++++++++++++++++------------
 object.h       |   7 ++--
 2 files changed, 80 insertions(+), 28 deletions(-)


base-commit: 56a4f3c3a221adf1df9b39da69b8a6890f803157
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2124%2Fspkrka%2Fqueue-has-nonstale-v3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2124/spkrka/queue-has-nonstale-v3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2124

Range-diff vs v1:

 -:  ---------- > 1:  105f4646c2 object.h: fix stale entries in object flag allocation table
 1:  1d3751569b ! 2:  fc38c0f856 commit-reach: deduplicate queue entries in paint_down_to_common
     @@ Commit message
          combinations. Add an ENQUEUED flag to track whether a commit is
          currently in the priority queue, and skip it if already present.
      
     +    Introduce prio_queue_put_dedup() and prio_queue_get_dedup()
     +    wrappers that manage the ENQUEUED flag on enqueue and dequeue.
     +
          This change is performance-neutral on its own: the O(n)
          queue_has_nonstale() scan still dominates the per-iteration cost.
          However, the deduplication guarantee (each commit appears in the
          queue at most once) is a prerequisite for the next commit, which
     -    replaces that scan with an O(1) nonstale counter.
     +    replaces that scan with O(1) tracking.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     @@ commit-reach.c: static int compare_commits_by_gen(const void *_a, const void *_b
       	return 0;
       }
       
     -+static void maybe_enqueue(struct prio_queue *queue, struct commit *c)
     ++static void prio_queue_put_dedup(struct prio_queue *queue, struct commit *c)
      +{
      +	if (c->object.flags & ENQUEUED)
      +		return;
      +	c->object.flags |= ENQUEUED;
      +	prio_queue_put(queue, c);
      +}
     ++
     ++static struct commit *prio_queue_get_dedup(struct prio_queue *queue)
     ++{
     ++	struct commit *commit = prio_queue_get(queue);
     ++	if (commit)
     ++		commit->object.flags &= ~ENQUEUED;
     ++	return commit;
     ++}
      +
       static int queue_has_nonstale(struct prio_queue *queue)
       {
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       		return 0;
       	}
      -	prio_queue_put(&queue, one);
     -+	maybe_enqueue(&queue, one);
     ++	prio_queue_put_dedup(&queue, one);
       
       	for (i = 0; i < n; i++) {
       		twos[i]->object.flags |= PARENT2;
      -		prio_queue_put(&queue, twos[i]);
     -+		maybe_enqueue(&queue, twos[i]);
     ++		prio_queue_put_dedup(&queue, twos[i]);
       	}
       
       	while (queue_has_nonstale(&queue)) {
     -@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     +-		struct commit *commit = prio_queue_get(&queue);
     ++		struct commit *commit = prio_queue_get_dedup(&queue);
     + 		struct commit_list *parents;
       		int flags;
       		timestamp_t generation = commit_graph_generation(commit);
     - 
     -+		commit->object.flags &= ~ENQUEUED;
     -+
     - 		if (min_generation && generation > last_gen)
     - 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
     - 			    generation, last_gen,
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       					     oid_to_hex(&p->object.oid));
       			}
       			p->object.flags |= flags;
      -			prio_queue_put(&queue, p);
     -+			maybe_enqueue(&queue, p);
     ++			prio_queue_put_dedup(&queue, p);
       		}
       	}
       
     @@ object.h: void object_array_init(struct object_array *array);
      - * commit-reach.c:                                  16-----19
      + * commit-reach.c:                                  16-------20
        * builtin/last-modified.c:                         1617
     -  * sha1-name.c:                                              20
     +  * object-name.c:                                            20
        * list-objects-filter.c:                                      21
 2:  4742f5e634 < -:  ---------- commit-reach: optimize queue scan in paint_down_to_common
 3:  711a0e2235 ! 3:  03771eb34c commit-reach: optimize queue scan in ahead_behind
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    commit-reach: optimize queue scan in ahead_behind
     +    commit-reach: replace queue_has_nonstale() scan with O(1) tracking
      
     -    Apply the same nonstale_count optimization from the previous commit
     -    to ahead_behind(). This replaces the remaining caller of the O(n)
     -    queue_has_nonstale() scan with an O(1) counter check, allowing
     -    queue_has_nonstale() to be removed.
     +    paint_down_to_common() and ahead_behind() call queue_has_nonstale()
     +    on every iteration to decide whether to continue the walk.
     +    queue_has_nonstale() performs a linear scan of the priority queue,
     +    making the overall walk O(n*m) where n is the number of commits
     +    walked and m is the queue size.
      
     -    ahead_behind() already deduplicates queue entries using the PARENT2
     -    flag (via insert_no_dup), so the counter is maintained through
     -    insert_no_dup() and mark_stale() using PARENT2 as the queued_flag.
     +    Introduce 'struct nonstale_queue', a thin wrapper around prio_queue
     +    that maintains a 'max_nonstale' pointer — the lowest-priority
     +    (oldest) non-stale commit seen so far. When this commit is popped,
     +    every remaining queue entry is known to be stale, so the walk can
     +    stop. This reduces the per-iteration termination check from O(m)
     +    to O(1).
      
     +    Uses <= 0 (not < 0) when comparing priorities so that among distinct
     +    commits with equal priority (same generation and timestamp) the
     +    last-enqueued one is tracked. Since prio_queue breaks ties by
     +    insertion order, this ensures max_nonstale is always the last in its
     +    priority class to be popped, making pointer equality on pop
     +    sufficient for correctness.
     +
     +    The previous commit's ENQUEUED deduplication guarantees each commit
     +    appears at most once in the queue, which is required for the pointer
     +    equality check to be unambiguous.
     +
     +    On a large monorepo (3.7M commits), this yields ~2x end-to-end
     +    speedup for merge-base calculations on deep import branches.
     +    Profiling shows paint_down_to_common() drops from 50% to 4% of
     +    total runtime (~27x faster), with the remaining time in commit
     +    graph lookups and heap operations:
     +
     +      Before: 8536ms / 5757ms / 4743ms  (three test cases)
     +      After:  3956ms / 4383ms / 1927ms
     +
     +    Suggested-by: Jeff King <peff@peff.net>
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## commit-reach.c ##
     -@@ commit-reach.c: static void mark_stale(struct commit *c, unsigned queued_flag,
     - 	}
     +@@ commit-reach.c: static int compare_commits_by_gen(const void *_a, const void *_b)
     + 	return 0;
     + }
     + 
     +-static void prio_queue_put_dedup(struct prio_queue *queue, struct commit *c)
     ++/*
     ++ * A prio_queue with O(1) termination check.  'max_nonstale' tracks
     ++ * the lowest-priority non-stale commit enqueued so far; once it is
     ++ * popped, every remaining entry is known to be STALE.
     ++ */
     ++struct nonstale_queue {
     ++	struct prio_queue pq;
     ++	struct commit *max_nonstale;
     ++};
     ++
     ++static void nonstale_queue_put(struct nonstale_queue *queue,
     ++			       struct commit *c)
     ++{
     ++	struct commit *old = queue->max_nonstale;
     ++
     ++	prio_queue_put(&queue->pq, c);
     ++	if (c->object.flags & STALE)
     ++		return;
     ++	if (!old || queue->pq.compare(old, c, queue->pq.cb_data) <= 0)
     ++		queue->max_nonstale = c;
     ++}
     ++
     ++static struct commit *nonstale_queue_get(struct nonstale_queue *queue)
     ++{
     ++	struct commit *commit = prio_queue_get(&queue->pq);
     ++
     ++	if (commit == queue->max_nonstale)
     ++		queue->max_nonstale = NULL;
     ++
     ++	return commit;
     ++}
     ++
     ++static void clear_nonstale_queue(struct nonstale_queue *queue)
     ++{
     ++	clear_prio_queue(&queue->pq);
     ++	queue->max_nonstale = NULL;
     ++}
     ++
     ++static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
     ++				     struct commit *c)
     + {
     + 	if (c->object.flags & ENQUEUED)
     + 		return;
     + 	c->object.flags |= ENQUEUED;
     +-	prio_queue_put(queue, c);
     ++	nonstale_queue_put(queue, c);
     + }
     + 
     +-static struct commit *prio_queue_get_dedup(struct prio_queue *queue)
     ++static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
     + {
     +-	struct commit *commit = prio_queue_get(queue);
     ++	struct commit *commit = nonstale_queue_get(queue);
     ++
     + 	if (commit)
     + 		commit->object.flags &= ~ENQUEUED;
     + 	return commit;
       }
       
      -static int queue_has_nonstale(struct prio_queue *queue)
     @@ commit-reach.c: static void mark_stale(struct commit *c, unsigned queued_flag,
       /* all input commits in one and twos[] must have been parsed! */
       static int paint_down_to_common(struct repository *r,
       				struct commit *one, int n,
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 				enum merge_base_flags mb_flags,
     + 				struct commit_list **result)
     + {
     +-	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     ++	struct nonstale_queue queue = {
     ++		{ compare_commits_by_gen_then_commit_date }
     ++	};
     + 	int i;
     + 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
     + 	struct commit_list **tail = result;
     + 
     + 	if (!min_generation && !corrected_commit_dates_enabled(r))
     +-		queue.compare = compare_commits_by_commit_date;
     ++		queue.pq.compare = compare_commits_by_commit_date;
     + 
     + 	one->object.flags |= PARENT1;
     + 	if (!n) {
     + 		commit_list_append(one, result);
     + 		return 0;
     + 	}
     +-	prio_queue_put_dedup(&queue, one);
     ++	nonstale_queue_put_dedup(&queue, one);
     + 
     + 	for (i = 0; i < n; i++) {
     + 		twos[i]->object.flags |= PARENT2;
     +-		prio_queue_put_dedup(&queue, twos[i]);
     ++		nonstale_queue_put_dedup(&queue, twos[i]);
     + 	}
     + 
     +-	while (queue_has_nonstale(&queue)) {
     +-		struct commit *commit = prio_queue_get_dedup(&queue);
     ++	while (queue.max_nonstale) {
     ++		struct commit *commit = nonstale_queue_get_dedup(&queue);
     + 		struct commit_list *parents;
     + 		int flags;
     + 		timestamp_t generation = commit_graph_generation(commit);
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 			if ((p->object.flags & flags) == flags)
     + 				continue;
     + 			if (repo_parse_commit(r, p)) {
     +-				clear_prio_queue(&queue);
     ++				clear_nonstale_queue(&queue);
     + 				commit_list_free(*result);
     + 				*result = NULL;
     + 				/*
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 					     oid_to_hex(&p->object.oid));
     + 			}
     + 			p->object.flags |= flags;
     +-			prio_queue_put_dedup(&queue, p);
     ++			nonstale_queue_put_dedup(&queue, p);
     + 		}
     + 	}
     + 
     +-	clear_prio_queue(&queue);
     ++	clear_nonstale_queue(&queue);
     + 	commit_list_sort_by_date(result);
     + 	return 0;
     + }
      @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, size_t nr_from,
       define_commit_slab(bit_arrays, struct bitmap *);
       static struct bit_arrays bit_arrays;
       
      -static void insert_no_dup(struct prio_queue *queue, struct commit *c)
     -+static void insert_no_dup(struct prio_queue *queue, struct commit *c,
     -+			  int *nonstale_count)
     ++static void insert_no_dup(struct nonstale_queue *queue, struct commit *c)
       {
       	if (c->object.flags & PARENT2)
       		return;
     - 	prio_queue_put(queue, c);
     +-	prio_queue_put(queue, c);
     ++	nonstale_queue_put(queue, c);
       	c->object.flags |= PARENT2;
     -+	if (!(c->object.flags & STALE))
     -+		(*nonstale_count)++;
       }
       
     - static struct bitmap *get_bit_array(struct commit *c, int width)
      @@ commit-reach.c: void ahead_behind(struct repository *r,
     + 		  struct commit **commits, size_t commits_nr,
     + 		  struct ahead_behind_count *counts, size_t counts_nr)
       {
     - 	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
     +-	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
     ++	struct nonstale_queue queue = {
     ++		{ .compare = compare_commits_by_gen_then_commit_date }
     ++	};
       	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
     -+	int nonstale_count = 0;
       
       	if (!commits_nr || !counts_nr)
     - 		return;
      @@ commit-reach.c: void ahead_behind(struct repository *r,
     - 		struct bitmap *bitmap = get_bit_array(c, width);
     - 
     - 		bitmap_set(bitmap, i);
     --		insert_no_dup(&queue, c);
     -+		insert_no_dup(&queue, c, &nonstale_count);
     + 		insert_no_dup(&queue, c);
       	}
       
      -	while (queue_has_nonstale(&queue)) {
     -+	while (nonstale_count > 0) {
     - 		struct commit *c = prio_queue_get(&queue);
     +-		struct commit *c = prio_queue_get(&queue);
     ++	while (queue.max_nonstale) {
     ++		struct commit *c = nonstale_queue_get(&queue);
       		struct commit_list *p;
       		struct bitmap *bitmap_c = get_bit_array(c, width);
       
     -+		if (!(c->object.flags & STALE))
     -+			nonstale_count--;
     -+
     - 		for (size_t i = 0; i < counts_nr; i++) {
     - 			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
     - 			int reach_from_base = !!bitmap_get(bitmap_c, counts[i].base_index);
      @@ commit-reach.c: void ahead_behind(struct repository *r,
     - 			 * queue is STALE.
     - 			 */
     - 			if (bitmap_popcount(bitmap_p) == commits_nr)
     --				p->item->object.flags |= STALE;
     -+				mark_stale(p->item, PARENT2, &nonstale_count);
       
     --			insert_no_dup(&queue, p->item);
     -+			insert_no_dup(&queue, p->item, &nonstale_count);
     - 		}
     + 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
     + 	repo_clear_commit_marks(r, PARENT2 | STALE);
     +-	for (size_t i = 0; i < queue.nr; i++)
     +-		free_bit_array(queue.array[i].data);
     ++	for (size_t i = 0; i < queue.pq.nr; i++)
     ++		free_bit_array(queue.pq.array[i].data);
     + 	clear_bit_arrays(&bit_arrays);
     +-	clear_prio_queue(&queue);
     ++	clear_nonstale_queue(&queue);
     + }
       
     - 		free_bit_array(c);
     + struct commit_and_index {

-- 
gitgitgadget
