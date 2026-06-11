Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9630D3F6
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178573; cv=none; b=aOLYyx44K1Vl5mLdN8OhBBXa+UzNuquaxZgNVya3qInrBJn98XfVFo3trZjoXVVFu10OD5c0IlUaOwh/gI/1Iq/Ljr/kz+KFYvIf0IKiHHojdnro3VTvrLvrbrnciQVx3mUAKvMPAFtv9PCgeQG7FlTFSAxvmfIy8E8t71Heh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178573; c=relaxed/simple;
	bh=GGwcgvYl9Mv1uene1GlDbAhFrf+SiF2gnVWFKcPtKog=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NkBwrVCOaECVqt7ZVrO7vvUaAkd3RUJd/XzCBOLp0Hpddy5oXdk2HMFTeanrIbcpQ89Lm/oFo/fA+ttMOc7OirnLa6oyinjlIqVQNthtaBbE/sfL2ok90M6fkpioo5Q5S0Opd7lTkdBguVb4eTqQpfW36cwE+ZtdTkAvNr/cLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/XZPWPk; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/XZPWPk"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-307263ad0cbso11047676eec.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781178570; x=1781783370; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEI7jeshfA17u6da4an6zT0gbI66u8nrbj98GqFLFwE=;
        b=a/XZPWPk8Yf/tVOHT4fTG3Pbif8+aCuQsMN161vz2qayu+v4Bpe6zzNc30WhmUHQa8
         PEk3OTX1xZRBsR7CSGGQ/TjlX5hXLW5+lwVrix5hH5phjP6ihB4SMTxpv5vAn8Gy/buf
         4nZhaQh3K4od0f2zo6NHcuVHIaAtxzm3Yz/1wWTYIhSmbBOj2ZY9Zi9kTGoQdLYSk2Eo
         Aa3l1WD4+AA0ZXsADUg2q53L2Ock3VQmd5vP4nH+BvmwVFbYs6EBth+FhOmLetQaZSl0
         Hj5V+KMnJX1M90hhL6Oeo5A/vZ86P0M9tBYIvp4HKxxaCKBkikwKfxpSIK8Ws0Qrttp3
         r6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781178570; x=1781783370;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEI7jeshfA17u6da4an6zT0gbI66u8nrbj98GqFLFwE=;
        b=MPPIpFZtDB9dVtPeXsfxvsKDwptYrf9bQu5b4gIwqEqPwJLzzEhm0iYr5ZeAUTq/m9
         VFLdf1yZJ/+yGDIkH+CTazCSGpS/M9BAx3fZC66uLbA1BDLk/TPLmVzJr9mHAsSOiEES
         GOaPbIHgWw7H49Wd5FosSZ3b/Fok2dLBsH5y3SSZQ5VhDB+Jdz/lXkQtOzDLEIyPu/pY
         NHwjcnDj9TNAvSbQSBEwnVhkXfbug9OXIsjEXRY6g55S5TyopAOm09HPFA9pf54Zbt0i
         oK5AyxEsL/xcezZXPBiZ667VcGttByXSPlqM7EBoe4VayKxFzkxmdYb6wgvefUvWEGKC
         VG9Q==
X-Gm-Message-State: AOJu0Yz9eTKqLKEOrRRgGDnFbMvaXXAJM/ljrAU/IChAPeUgj4+Xbzk1
	DO1WplHjaXBChG28Wbmd44N/Sr1mprz28SLh5+fU+jwja6+EBRGDH1tIujV1hQ==
X-Gm-Gg: Acq92OEmgity5pVH65bneL2xD99RsgaKmga5eq7asVWl3gg4tkgrEHqvWBEeIvctgOQ
	ceZ0Rs/F+gJOsWIDS2liCDFxfrsMyqaEsvra+hbUf3CWpTp0rP+SKou30I3t5gycevSo+LfnhCz
	w8MJS/RCt56zg5UBg3F7q062hvDTZZELWujc5xAlNJZP2GcztxhFa3y2X8uaDgSFlX1AJIfHCc5
	TuAi0RhbPXZo+2O7QPaslEzBO6TrQ3gvgG9Y68WMkhkYenSIia9u+nrkMp6lMKurM4mi4OrgvuK
	M2nEYmwJfLxRBvxH5Sb7fTz3hCzCkD5AAoGKF5dp5beS1hG/BY03XYQPDyJxg/QAFBu+oSKqyIP
	0wKWRhJdXouJYiTbgzh04yS2YCervnJX2i5Zyd3BbN6kwy8mBtAjkfFiQavFo0IHzBY1yBUTiqC
	3jkxeAPJ68XJJkLR5lXyOjbPQ6vhx5jwfDI0eU
X-Received: by 2002:a05:7301:4342:b0:2da:2ec2:64e5 with SMTP id 5a478bee46e88-308049a3520mr1804283eec.18.1781178569658;
        Thu, 11 Jun 2026 04:49:29 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806c2efc3sm1728839eec.2.2026.06.11.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:49:28 -0700 (PDT)
Message-Id: <pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com>
In-Reply-To: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jun 2026 11:49:27 +0000
Subject: [PATCH v2] commit-reach: remove get_reachable_subset()
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
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

get_reachable_subset() and tips_reachable_from_bases() both answer
the same reachability question but use different traversal
strategies: priority queue vs depth-first search.  Consolidate them
into tips_reachable_from_bases() with a mode parameter to select
between DFS and PQ traversal, preserving the preferred strategy for
each caller.

This works cleanly because prio_queue already supports LIFO mode
(when compare is NULL), so a single prio_queue acts as either a
stack or a heap depending on the mode.

The unified traversal pushes all unseen parents at once rather than
peeking and pushing one parent at a time.  This eliminates merge
commit revisits entirely: a 2-parent merge now requires 1 visit
instead of 3.  For DFS (LIFO) mode, the first parent is pushed
last so it ends up on top of the stack, preserving first-parent
traversal order.

Parsing is deferred to pop time for DFS since parent objects carry
valid flags without a full repo_parse_commit() call.  PQ mode
parses before push so the heap can order by generation number.

Add exhaustive reachability tests that use every commit in the
grid as a tip, protecting against subtle traversal bugs such as
wrong parent ordering or premature pruning.  The existing tests
are also extended to exercise both DFS and PQ modes.

The flag in remote.c changes from 1 (bit 0) to TMP_MARK (bit 4)
because tips_reachable_from_bases() uses SEEN (bit 0) internally.
TMP_MARK is already used for deduplication earlier in the same
function and is cleared before the reachability check.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    commit-reach: remove get_reachable_subset()
    
    This removes get_reachable_subset() and consolidates its only caller
    into tips_reachable_from_bases() with a mode parameter to select between
    DFS and priority queue traversal. Both functions answer the same
    reachability query and use the same generation-number pruning strategy,
    differing primarily in traversal order (DFS vs generation-ordered PQ).
    They were introduced years apart and never consolidated.
    
    The unified function uses prio_queue for both modes: LIFO (stack) when
    compare is NULL, min-heap when given a comparator.
    
    Changes since v1:
    
     * Replaced the commit_stack + reverse-push pattern with a simpler
       approach: push all unseen parents directly, with the first parent
       pushed last so it lands on top of the LIFO stack. This preserves
       first-parent DFS order without needing a temporary stack to reverse
       parent order.
    
     * Deferred repo_parse_commit() to pop time for DFS mode. Parent objects
       carry valid flags without a full parse, so we avoid parsing
       already-SEEN parents in the inner loop. PQ mode still parses before
       push so the heap can order by generation number.
    
     * Moved the generation floor check from the parent loop to pop time,
       simplifying the hot path at the cost of occasionally enqueueing
       commits that will later be discarded.
    
     * Added SEEN flag on base commits before enqueueing, preventing
       duplicate processing if bases overlap with the traversal.
    
     * Added PQ mode to the existing test-reach tests so both DFS and PQ
       paths are exercised by the test suite.
    
     * Added two new reachability tests that use all 100 commits in the grid
       as tips - the idea is to better detect subtle traversal bugs.
    
    Notes for reviewers:
    
     * The flag in remote.c changes from 1 to TMP_MARK because
       tips_reachable_from_bases() uses SEEN (bit 0) internally. TMP_MARK is
       already used earlier in the same function and is cleared before the
       reachability block.
    
     * Test helper and test names rename from get_reachable_subset to
       tips_reachable_from_bases to match the function being exercised.
    
    As Stolee noted in the v1 review, commit-graph is now stable and
    expected for repositories where this matters, making the DFS approach
    with dynamic floor raising an attractive default. The mode parameter
    could be dropped in a future patch if we decide to use DFS everywhere,
    but preserving each caller's existing strategy keeps this change
    conservative and avoids any behavior change for add_missing_tags().
    
    Performance was not a goal of this refactoring, but the simplified DFS
    traversal turned out to be a pleasant surprise -- eliminating merge
    commit revisits and deferring parse to pop time gives a consistent
    speedup across repositories:
    
    Benchmark results (median, 30 runs, pre-built binaries):
    
    Repository   Command                   Speedup
    -----------------------------------------------------------
    linux        branch --merged=HEAD       1.09x faster
    linux        for-each-ref --merged=HEAD 1.14x faster
    git          branch --merged=HEAD       neutral
    git          for-each-ref --merged=HEAD 1.12x faster
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2144%2Fspkrka%2Fkrka%2Fremove-get-reachable-subset-v2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2144/spkrka/krka/remove-get-reachable-subset-v2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2144

Range-diff vs v1:

 1:  df8e2de11b ! 1:  da01032a32 commit-reach: remove get_reachable_subset()
     @@ Metadata
       ## Commit message ##
          commit-reach: remove get_reachable_subset()
      
     -    get_reachable_subset() and tips_reachable_from_bases() answer the
     -    same question: given a set of bases and a set of tips, which tips
     -    are reachable from at least one base?
     +    get_reachable_subset() and tips_reachable_from_bases() both answer
     +    the same reachability question but use different traversal
     +    strategies: priority queue vs depth-first search.  Consolidate them
     +    into tips_reachable_from_bases() with a mode parameter to select
     +    between DFS and PQ traversal, preserving the preferred strategy for
     +    each caller.
      
     -    get_reachable_subset() was introduced in fcb2c0769d (2018-11-02)
     -    for add_missing_tags() in remote.c. tips_reachable_from_bases()
     -    was added in cbfe360b14 (2023-03-20) as part of the ahead-behind
     -    series. The two were never consolidated.
     +    This works cleanly because prio_queue already supports LIFO mode
     +    (when compare is NULL), so a single prio_queue acts as either a
     +    stack or a heap depending on the mode.
      
     -    With a commit-graph, tips_reachable_from_bases() can have an edge:
     -    its DFS raises the generation floor as lower targets are found,
     -    pruning more aggressively than the static floor in
     -    get_reachable_subset(). Without generation numbers, some edge cases
     -    may be slower with DFS instead of BFS since the date-ordered
     -    prio_queue naturally stays near the top of the graph, but this
     -    should not matter in practice -- worst case both visit the full
     -    graph down from the bases.
     +    The unified traversal pushes all unseen parents at once rather than
     +    peeking and pushing one parent at a time.  This eliminates merge
     +    commit revisits entirely: a 2-parent merge now requires 1 visit
     +    instead of 3.  For DFS (LIFO) mode, the first parent is pushed
     +    last so it ends up on top of the stack, preserving first-parent
     +    traversal order.
     +
     +    Parsing is deferred to pop time for DFS since parent objects carry
     +    valid flags without a full repo_parse_commit() call.  PQ mode
     +    parses before push so the heap can order by generation number.
     +
     +    Add exhaustive reachability tests that use every commit in the
     +    grid as a tip, protecting against subtle traversal bugs such as
     +    wrong parent ordering or premature pruning.  The existing tests
     +    are also extended to exercise both DFS and PQ modes.
      
          The flag in remote.c changes from 1 (bit 0) to TMP_MARK (bit 4)
          because tips_reachable_from_bases() uses SEEN (bit 0) internally.
     @@ commit-reach.c: int can_all_from_reach(struct commit_list *from, struct commit_l
       define_commit_slab(bit_arrays, struct bitmap *);
       static struct bit_arrays bit_arrays;
       
     +@@ commit-reach.c: static int compare_commit_and_index_by_generation(const void *va, const void *vb
     + void tips_reachable_from_bases(struct repository *r,
     + 			       struct commit_list *bases,
     + 			       struct commit **tips, size_t tips_nr,
     +-			       int mark)
     ++			       int mark, enum tips_reachable_mode mode)
     + {
     + 	struct commit_and_index *commits;
     ++	struct commit_list *p;
     ++	struct commit *c;
     + 	size_t min_generation_index = 0;
     + 	timestamp_t min_generation;
     +-	struct commit_list *stack = NULL;
     ++	struct prio_queue queue = { NULL };
     + 
     + 	if (!bases || !tips || !tips_nr)
     + 		return;
     + 
     + 	/*
     +-	 * Do a depth-first search starting at 'bases' to search for the
     +-	 * tips. Stop at the lowest (un-found) generation number. When
     +-	 * finding the lowest commit, increase the minimum generation
     +-	 * number to the next lowest (un-found) generation number.
     ++	 * Search starting at 'bases' looking for the tips. Stop at the
     ++	 * lowest un-found generation number, raising the floor as tips
     ++	 * are found. Use DFS by default; with TIPS_REACHABLE_PQ,
     ++	 * use a priority queue ordered by generation then commit date.
     + 	 */
     ++	if (mode == TIPS_REACHABLE_PQ)
     ++		queue.compare = compare_commits_by_gen_then_commit_date;
     + 
     + 	CALLOC_ARRAY(commits, tips_nr);
     + 
     +@@ commit-reach.c: void tips_reachable_from_bases(struct repository *r,
     + 
     + 	while (bases) {
     + 		repo_parse_commit(r, bases->item);
     +-		commit_list_insert(bases->item, &stack);
     ++		bases->item->object.flags |= SEEN;
     ++		prio_queue_put(&queue, bases->item);
     + 		bases = bases->next;
     + 	}
     + 
     +-	while (stack) {
     +-		int explored_all_parents = 1;
     +-		struct commit_list *p;
     +-		struct commit *c = stack->item;
     ++	while ((c = prio_queue_get(&queue))) {
     ++		struct commit *first_parent = NULL;
     ++
     ++		repo_parse_commit(r, c);
     ++
     ++		/* Skip if below the current generation floor. */
     ++		if (commit_graph_generation(c) < min_generation)
     ++			continue;
     + 
     + 		/* Does it match any of our tips? */
     + 		{
     +@@ commit-reach.c: void tips_reachable_from_bases(struct repository *r,
     + 		}
     + 
     + 		for (p = c->parents; p; p = p->next) {
     +-			repo_parse_commit(r, p->item);
     +-
     + 			/* Have we already explored this parent? */
     + 			if (p->item->object.flags & SEEN)
     + 				continue;
     + 
     +-			/* Is it below the current minimum generation? */
     +-			if (commit_graph_generation(p->item) < min_generation)
     +-				continue;
     +-
     + 			/* Ok, we will explore from here on. */
     + 			p->item->object.flags |= SEEN;
     +-			explored_all_parents = 0;
     +-			commit_list_insert(p->item, &stack);
     +-			break;
     ++			/* Parse before pushing in PQ mode for ordering. */
     ++			if (mode == TIPS_REACHABLE_PQ)
     ++				repo_parse_commit(r, p->item);
     ++			if (!first_parent)
     ++				first_parent = p->item;
     ++			else
     ++				prio_queue_put(&queue, p->item);
     + 		}
     +-
     +-		if (explored_all_parents)
     +-			pop_commit(&stack);
     ++		/*
     ++		 * Add the first parent last so that it is on top of
     ++		 * the LIFO queue, maintaining first-parent DFS order.
     ++		 */
     ++		if (first_parent)
     ++			prio_queue_put(&queue, first_parent);
     + 	}
     + 
     + done:
     +@@ commit-reach.c: done:
     + 		commits[i].commit->object.flags &= ~RESULT;
     + 	free(commits);
     + 	repo_clear_commit_marks(r, SEEN);
     +-	commit_list_free(stack);
     ++	clear_prio_queue(&queue);
     + }
     + 
     + /*
      
       ## commit-reach.h ##
      @@ commit-reach.h: int can_all_from_reach_with_flag(struct object_array *from,
     @@ commit-reach.h: int can_all_from_reach_with_flag(struct object_array *from,
       struct ahead_behind_count {
       	/**
       	 * As input, the *_index members indicate which positions in
     +@@ commit-reach.h: void ahead_behind(struct repository *r,
     +  * For all tip commits, add 'mark' to their flags if and only if they
     +  * are reachable from one of the commits in 'bases'.
     +  */
     ++enum tips_reachable_mode {
     ++	TIPS_REACHABLE_DFS,
     ++	TIPS_REACHABLE_PQ,
     ++};
     + void tips_reachable_from_bases(struct repository *r,
     + 			       struct commit_list *bases,
     + 			       struct commit **tips, size_t tips_nr,
     +-			       int mark);
     ++			       int mark, enum tips_reachable_mode mode);
     + 
     + /*
     +  * Given a 'tip' commit and a list potential 'bases', return the index 'i' that
     +
     + ## ref-filter.c ##
     +@@ ref-filter.c: static void reach_filter(struct ref_array *array,
     + 	tips_reachable_from_bases(the_repository,
     + 				  *check_reachable,
     + 				  to_clear, array->nr,
     +-				  UNINTERESTING);
     ++				  UNINTERESTING, TIPS_REACHABLE_DFS);
     + 
     + 	old_nr = array->nr;
     + 	array->nr = 0;
      
       ## remote.c ##
      @@ remote.c: static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
     @@ remote.c: static void add_missing_tags(struct ref *src, struct ref **dst, struct
      +			commit_list_insert(sent_tips.items[i], &bases);
      +		tips_reachable_from_bases(the_repository,
      +					 bases, src_commits.items,
     -+					 src_commits.nr, TMP_MARK);
     ++					 src_commits.nr, TMP_MARK,
     ++					 TIPS_REACHABLE_PQ);
      +		commit_list_free(bases);
       
       		for_each_string_list_item(item, &src_tag) {
     @@ t/helper/test-reach.c: int cmd__reach(int ac, const char **av)
      -				    oid_to_hex(&list->item->object.oid));
      -			count++;
      -		}
     -+	} else if (!strcmp(av[1], "tips_reachable_from_bases")) {
     ++	} else if (!strcmp(av[1], "tips_reachable_from_bases") ||
     ++		   !strcmp(av[1], "tips_reachable_from_bases_pq")) {
     ++		enum tips_reachable_mode mode =
     ++			!strcmp(av[1], "tips_reachable_from_bases_pq")
     ++			? TIPS_REACHABLE_PQ : TIPS_REACHABLE_DFS;
      +		struct commit_list *bases = NULL;
      +		struct commit_list *result = NULL;
      +
     @@ t/helper/test-reach.c: int cmd__reach(int ac, const char **av)
      +			commit_list_insert(X_stack.items[i], &bases);
      +		tips_reachable_from_bases(the_repository,
      +					 bases, Y_stack.items,
     -+					 Y_stack.nr, TMP_MARK);
     ++					 Y_stack.nr, TMP_MARK,
     ++					 mode);
      +		commit_list_free(bases);
      +
      +		printf("tips_reachable_from_bases(X,Y)\n");
     @@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:all' '
       			      commit-5-6 | sort
       	) >expect &&
      -	test_all_modes get_reachable_subset
     -+	test_all_modes tips_reachable_from_bases
     ++	test_all_modes tips_reachable_from_bases &&
     ++	test_all_modes tips_reachable_from_bases_pq
       '
       
      -test_expect_success 'get_reachable_subset:some' '
     @@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:some' '
       			      commit-1-7 | sort
       	) >expect &&
      -	test_all_modes get_reachable_subset
     -+	test_all_modes tips_reachable_from_bases
     ++	test_all_modes tips_reachable_from_bases &&
     ++	test_all_modes tips_reachable_from_bases_pq
       '
       
      -test_expect_success 'get_reachable_subset:none' '
     @@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:none' '
      -	echo "get_reachable_subset(X,Y)" >expect &&
      -	test_all_modes get_reachable_subset
      +	echo "tips_reachable_from_bases(X,Y)" >expect &&
     -+	test_all_modes tips_reachable_from_bases
     ++	test_all_modes tips_reachable_from_bases &&
     ++	test_all_modes tips_reachable_from_bases_pq
       '
       
       test_expect_success 'for-each-ref ahead-behind:linear' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'for-each-ref merged:duplicate at min generation' '
     + 		--format="%(refname)" --stdin
     + '
     + 
     ++test_expect_success 'for-each-ref merged:all reachable commits' '
     ++	for x in $(test_seq 1 10)
     ++	do
     ++		for y in $(test_seq 1 10)
     ++		do
     ++			echo "refs/heads/commit-$x-$y" || return 1
     ++		done
     ++	done >input &&
     ++	for x in $(test_seq 1 5)
     ++	do
     ++		for y in $(test_seq 1 5)
     ++		do
     ++			echo "refs/heads/commit-$x-$y" || return 1
     ++		done
     ++	done | sort >expect &&
     ++	run_all_modes git for-each-ref --merged=commit-5-5 \
     ++		--format="%(refname)" --stdin
     ++'
     ++
     ++test_expect_success 'for-each-ref merged:all reachable, multibase' '
     ++	for x in $(test_seq 1 10)
     ++	do
     ++		for y in $(test_seq 1 10)
     ++		do
     ++			echo "refs/heads/commit-$x-$y" || return 1
     ++		done
     ++	done >input &&
     ++	for x in $(test_seq 1 10)
     ++	do
     ++		for y in $(test_seq 1 10)
     ++		do
     ++			if { test $x -le 3 && test $y -le 7; } ||
     ++			   { test $x -le 7 && test $y -le 3; }
     ++			then
     ++				echo "refs/heads/commit-$x-$y" || return 1
     ++			fi
     ++		done
     ++	done | sort >expect &&
     ++	run_all_modes git for-each-ref \
     ++		--merged=commit-3-7 \
     ++		--merged=commit-7-3 \
     ++		--format="%(refname)" --stdin
     ++'
     ++
     + # For get_branch_base_for_tip, we only care about
     + # first-parent history. Here is the test graph with
     + # second parents removed:


 commit-reach.c        | 131 +++++++++++-------------------------------
 commit-reach.h        |  19 ++----
 ref-filter.c          |   2 +-
 remote.c              |  20 +++----
 t/helper/test-reach.c |  44 +++++++-------
 t/t6600-test-reach.sh |  65 ++++++++++++++++++---
 6 files changed, 129 insertions(+), 152 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5df471a313..1cad7b211e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1013,79 +1013,6 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	return result;
 }
 
-struct commit_list *get_reachable_subset(struct commit **from, size_t nr_from,
-					 struct commit **to, size_t nr_to,
-					 unsigned int reachable_flag)
-{
-	struct commit **item;
-	struct commit *current;
-	struct commit_list *found_commits = NULL;
-	struct commit **to_last = to + nr_to;
-	struct commit **from_last = from + nr_from;
-	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
-	int num_to_find = 0;
-
-	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
-
-	for (item = to; item < to_last; item++) {
-		timestamp_t generation;
-		struct commit *c = *item;
-
-		repo_parse_commit(the_repository, c);
-		generation = commit_graph_generation(c);
-		if (generation < min_generation)
-			min_generation = generation;
-
-		if (!(c->object.flags & PARENT1)) {
-			c->object.flags |= PARENT1;
-			num_to_find++;
-		}
-	}
-
-	for (item = from; item < from_last; item++) {
-		struct commit *c = *item;
-		if (!(c->object.flags & PARENT2)) {
-			c->object.flags |= PARENT2;
-			repo_parse_commit(the_repository, c);
-
-			prio_queue_put(&queue, *item);
-		}
-	}
-
-	while (num_to_find && (current = prio_queue_get(&queue)) != NULL) {
-		struct commit_list *parents;
-
-		if (current->object.flags & PARENT1) {
-			current->object.flags &= ~PARENT1;
-			current->object.flags |= reachable_flag;
-			commit_list_insert(current, &found_commits);
-			num_to_find--;
-		}
-
-		for (parents = current->parents; parents; parents = parents->next) {
-			struct commit *p = parents->item;
-
-			repo_parse_commit(the_repository, p);
-
-			if (commit_graph_generation(p) < min_generation)
-				continue;
-
-			if (p->object.flags & PARENT2)
-				continue;
-
-			p->object.flags |= PARENT2;
-			prio_queue_put(&queue, p);
-		}
-	}
-
-	clear_prio_queue(&queue);
-
-	clear_commit_marks_many(nr_to, to, PARENT1);
-	clear_commit_marks_many(nr_from, from, PARENT2);
-
-	return found_commits;
-}
-
 define_commit_slab(bit_arrays, struct bitmap *);
 static struct bit_arrays bit_arrays;
 
@@ -1212,22 +1139,26 @@ static int compare_commit_and_index_by_generation(const void *va, const void *vb
 void tips_reachable_from_bases(struct repository *r,
 			       struct commit_list *bases,
 			       struct commit **tips, size_t tips_nr,
-			       int mark)
+			       int mark, enum tips_reachable_mode mode)
 {
 	struct commit_and_index *commits;
+	struct commit_list *p;
+	struct commit *c;
 	size_t min_generation_index = 0;
 	timestamp_t min_generation;
-	struct commit_list *stack = NULL;
+	struct prio_queue queue = { NULL };
 
 	if (!bases || !tips || !tips_nr)
 		return;
 
 	/*
-	 * Do a depth-first search starting at 'bases' to search for the
-	 * tips. Stop at the lowest (un-found) generation number. When
-	 * finding the lowest commit, increase the minimum generation
-	 * number to the next lowest (un-found) generation number.
+	 * Search starting at 'bases' looking for the tips. Stop at the
+	 * lowest un-found generation number, raising the floor as tips
+	 * are found. Use DFS by default; with TIPS_REACHABLE_PQ,
+	 * use a priority queue ordered by generation then commit date.
 	 */
+	if (mode == TIPS_REACHABLE_PQ)
+		queue.compare = compare_commits_by_gen_then_commit_date;
 
 	CALLOC_ARRAY(commits, tips_nr);
 
@@ -1245,14 +1176,19 @@ void tips_reachable_from_bases(struct repository *r,
 
 	while (bases) {
 		repo_parse_commit(r, bases->item);
-		commit_list_insert(bases->item, &stack);
+		bases->item->object.flags |= SEEN;
+		prio_queue_put(&queue, bases->item);
 		bases = bases->next;
 	}
 
-	while (stack) {
-		int explored_all_parents = 1;
-		struct commit_list *p;
-		struct commit *c = stack->item;
+	while ((c = prio_queue_get(&queue))) {
+		struct commit *first_parent = NULL;
+
+		repo_parse_commit(r, c);
+
+		/* Skip if below the current generation floor. */
+		if (commit_graph_generation(c) < min_generation)
+			continue;
 
 		/* Does it match any of our tips? */
 		{
@@ -1276,25 +1212,26 @@ void tips_reachable_from_bases(struct repository *r,
 		}
 
 		for (p = c->parents; p; p = p->next) {
-			repo_parse_commit(r, p->item);
-
 			/* Have we already explored this parent? */
 			if (p->item->object.flags & SEEN)
 				continue;
 
-			/* Is it below the current minimum generation? */
-			if (commit_graph_generation(p->item) < min_generation)
-				continue;
-
 			/* Ok, we will explore from here on. */
 			p->item->object.flags |= SEEN;
-			explored_all_parents = 0;
-			commit_list_insert(p->item, &stack);
-			break;
+			/* Parse before pushing in PQ mode for ordering. */
+			if (mode == TIPS_REACHABLE_PQ)
+				repo_parse_commit(r, p->item);
+			if (!first_parent)
+				first_parent = p->item;
+			else
+				prio_queue_put(&queue, p->item);
 		}
-
-		if (explored_all_parents)
-			pop_commit(&stack);
+		/*
+		 * Add the first parent last so that it is on top of
+		 * the LIFO queue, maintaining first-parent DFS order.
+		 */
+		if (first_parent)
+			prio_queue_put(&queue, first_parent);
 	}
 
 done:
@@ -1302,7 +1239,7 @@ done:
 		commits[i].commit->object.flags &= ~RESULT;
 	free(commits);
 	repo_clear_commit_marks(r, SEEN);
-	commit_list_free(stack);
+	clear_prio_queue(&queue);
 }
 
 /*
diff --git a/commit-reach.h b/commit-reach.h
index 3f3a563d8a..71e60d727a 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -96,19 +96,6 @@ int can_all_from_reach_with_flag(struct object_array *from,
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		       int commit_date_cutoff);
 
-
-/*
- * Return a list of commits containing the commits in the 'to' array
- * that are reachable from at least one commit in the 'from' array.
- * Also add the given 'flag' to each of the commits in the returned list.
- *
- * This method uses the PARENT1 and PARENT2 flags during its operation,
- * so be sure these flags are not set before calling the method.
- */
-struct commit_list *get_reachable_subset(struct commit **from, size_t nr_from,
-					 struct commit **to, size_t nr_to,
-					 unsigned int reachable_flag);
-
 struct ahead_behind_count {
 	/**
 	 * As input, the *_index members indicate which positions in
@@ -144,10 +131,14 @@ void ahead_behind(struct repository *r,
  * For all tip commits, add 'mark' to their flags if and only if they
  * are reachable from one of the commits in 'bases'.
  */
+enum tips_reachable_mode {
+	TIPS_REACHABLE_DFS,
+	TIPS_REACHABLE_PQ,
+};
 void tips_reachable_from_bases(struct repository *r,
 			       struct commit_list *bases,
 			       struct commit **tips, size_t tips_nr,
-			       int mark);
+			       int mark, enum tips_reachable_mode mode);
 
 /*
  * Given a 'tip' commit and a list potential 'bases', return the index 'i' that
diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..9c8896d347 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3157,7 +3157,7 @@ static void reach_filter(struct ref_array *array,
 	tips_reachable_from_bases(the_repository,
 				  *check_reachable,
 				  to_clear, array->nr,
-				  UNINTERESTING);
+				  UNINTERESTING, TIPS_REACHABLE_DFS);
 
 	old_nr = array->nr;
 	array->nr = 0;
diff --git a/remote.c b/remote.c
index 00723b385e..0324c25743 100644
--- a/remote.c
+++ b/remote.c
@@ -1459,9 +1459,8 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 	 * sent to the other side.
 	 */
 	if (sent_tips.nr) {
-		const int reachable_flag = 1;
-		struct commit_list *found_commits;
 		struct commit_stack src_commits = COMMIT_STACK_INIT;
+		struct commit_list *bases = NULL;
 
 		for_each_string_list_item(item, &src_tag) {
 			struct ref *ref = item->util;
@@ -1479,11 +1478,13 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			commit_stack_push(&src_commits, commit);
 		}
 
-		found_commits = get_reachable_subset(sent_tips.items,
-						     sent_tips.nr,
-						     src_commits.items,
-						     src_commits.nr,
-						     reachable_flag);
+		for (size_t i = 0; i < sent_tips.nr; i++)
+			commit_list_insert(sent_tips.items[i], &bases);
+		tips_reachable_from_bases(the_repository,
+					 bases, src_commits.items,
+					 src_commits.nr, TMP_MARK,
+					 TIPS_REACHABLE_PQ);
+		commit_list_free(bases);
 
 		for_each_string_list_item(item, &src_tag) {
 			struct ref *dst_ref;
@@ -1503,7 +1504,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			 * Is this tag, which they do not have, reachable from
 			 * any of the commits we are sending?
 			 */
-			if (!(commit->object.flags & reachable_flag))
+			if (!(commit->object.flags & TMP_MARK))
 				continue;
 
 			/* Add it in */
@@ -1513,9 +1514,8 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 		}
 
 		clear_commit_marks_many(src_commits.nr, src_commits.items,
-					reachable_flag);
+					TMP_MARK);
 		commit_stack_clear(&src_commits);
-		commit_list_free(found_commits);
 	}
 
 	string_list_clear(&src_tag, 0);
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 5d86a96c17..66ee35e70d 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -7,6 +7,7 @@
 #include "hex.h"
 #include "object-name.h"
 #include "ref-filter.h"
+#include "revision.h"
 #include "setup.h"
 #include "string-list.h"
 #include "tag.h"
@@ -149,30 +150,31 @@ int cmd__reach(int ac, const char **av)
 
 		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache));
 		clear_contains_cache(&cache);
-	} else if (!strcmp(av[1], "get_reachable_subset")) {
-		const int reachable_flag = 1;
-		int count = 0;
-		struct commit_list *current;
-		struct commit_list *list = get_reachable_subset(X_stack.items, X_stack.nr,
-								Y_stack.items, Y_stack.nr,
-								reachable_flag);
-		printf("get_reachable_subset(X,Y)\n");
-		for (current = list; current; current = current->next) {
-			if (!(list->item->object.flags & reachable_flag))
-				die(_("commit %s is not marked reachable"),
-				    oid_to_hex(&list->item->object.oid));
-			count++;
-		}
+	} else if (!strcmp(av[1], "tips_reachable_from_bases") ||
+		   !strcmp(av[1], "tips_reachable_from_bases_pq")) {
+		enum tips_reachable_mode mode =
+			!strcmp(av[1], "tips_reachable_from_bases_pq")
+			? TIPS_REACHABLE_PQ : TIPS_REACHABLE_DFS;
+		struct commit_list *bases = NULL;
+		struct commit_list *result = NULL;
+
+		for (size_t i = 0; i < X_stack.nr; i++)
+			commit_list_insert(X_stack.items[i], &bases);
+		tips_reachable_from_bases(the_repository,
+					 bases, Y_stack.items,
+					 Y_stack.nr, TMP_MARK,
+					 mode);
+		commit_list_free(bases);
+
+		printf("tips_reachable_from_bases(X,Y)\n");
 		for (size_t i = 0; i < Y_stack.nr; i++) {
-			if (Y_stack.items[i]->object.flags & reachable_flag)
-				count--;
+			if (Y_stack.items[i]->object.flags & TMP_MARK)
+				commit_list_insert(Y_stack.items[i], &result);
 		}
+		print_sorted_commit_ids(result);
 
-		if (count < 0)
-			die(_("too many commits marked reachable"));
-
-		print_sorted_commit_ids(list);
-		commit_list_free(list);
+		clear_commit_marks_many(Y_stack.nr, Y_stack.items, TMP_MARK);
+		commit_list_free(result);
 	}
 
 	object_array_clear(&X_obj);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index b5b314e570..b736d893d5 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -391,7 +391,7 @@ test_expect_success 'rev-list: symmetric difference topo-order' '
 	run_all_modes git rev-list --topo-order commit-3-8...commit-6-6
 '
 
-test_expect_success 'get_reachable_subset:all' '
+test_expect_success 'tips_reachable_from_bases:all' '
 	cat >input <<-\EOF &&
 	X:commit-9-1
 	X:commit-8-3
@@ -403,15 +403,16 @@ test_expect_success 'get_reachable_subset:all' '
 	Y:commit-5-6
 	EOF
 	(
-		echo "get_reachable_subset(X,Y)" &&
+		echo "tips_reachable_from_bases(X,Y)" &&
 		git rev-parse commit-3-3 \
 			      commit-1-7 \
 			      commit-5-6 | sort
 	) >expect &&
-	test_all_modes get_reachable_subset
+	test_all_modes tips_reachable_from_bases &&
+	test_all_modes tips_reachable_from_bases_pq
 '
 
-test_expect_success 'get_reachable_subset:some' '
+test_expect_success 'tips_reachable_from_bases:some' '
 	cat >input <<-\EOF &&
 	X:commit-9-1
 	X:commit-8-3
@@ -422,14 +423,15 @@ test_expect_success 'get_reachable_subset:some' '
 	Y:commit-5-6
 	EOF
 	(
-		echo "get_reachable_subset(X,Y)" &&
+		echo "tips_reachable_from_bases(X,Y)" &&
 		git rev-parse commit-3-3 \
 			      commit-1-7 | sort
 	) >expect &&
-	test_all_modes get_reachable_subset
+	test_all_modes tips_reachable_from_bases &&
+	test_all_modes tips_reachable_from_bases_pq
 '
 
-test_expect_success 'get_reachable_subset:none' '
+test_expect_success 'tips_reachable_from_bases:none' '
 	cat >input <<-\EOF &&
 	X:commit-9-1
 	X:commit-8-3
@@ -439,8 +441,9 @@ test_expect_success 'get_reachable_subset:none' '
 	Y:commit-7-6
 	Y:commit-2-8
 	EOF
-	echo "get_reachable_subset(X,Y)" >expect &&
-	test_all_modes get_reachable_subset
+	echo "tips_reachable_from_bases(X,Y)" >expect &&
+	test_all_modes tips_reachable_from_bases &&
+	test_all_modes tips_reachable_from_bases_pq
 '
 
 test_expect_success 'for-each-ref ahead-behind:linear' '
@@ -657,6 +660,50 @@ test_expect_success 'for-each-ref merged:duplicate at min generation' '
 		--format="%(refname)" --stdin
 '
 
+test_expect_success 'for-each-ref merged:all reachable commits' '
+	for x in $(test_seq 1 10)
+	do
+		for y in $(test_seq 1 10)
+		do
+			echo "refs/heads/commit-$x-$y" || return 1
+		done
+	done >input &&
+	for x in $(test_seq 1 5)
+	do
+		for y in $(test_seq 1 5)
+		do
+			echo "refs/heads/commit-$x-$y" || return 1
+		done
+	done | sort >expect &&
+	run_all_modes git for-each-ref --merged=commit-5-5 \
+		--format="%(refname)" --stdin
+'
+
+test_expect_success 'for-each-ref merged:all reachable, multibase' '
+	for x in $(test_seq 1 10)
+	do
+		for y in $(test_seq 1 10)
+		do
+			echo "refs/heads/commit-$x-$y" || return 1
+		done
+	done >input &&
+	for x in $(test_seq 1 10)
+	do
+		for y in $(test_seq 1 10)
+		do
+			if { test $x -le 3 && test $y -le 7; } ||
+			   { test $x -le 7 && test $y -le 3; }
+			then
+				echo "refs/heads/commit-$x-$y" || return 1
+			fi
+		done
+	done | sort >expect &&
+	run_all_modes git for-each-ref \
+		--merged=commit-3-7 \
+		--merged=commit-7-3 \
+		--format="%(refname)" --stdin
+'
+
 # For get_branch_base_for_tip, we only care about
 # first-parent history. Here is the test graph with
 # second parents removed:

base-commit: 1ff279f3404a482a83fb04c7457e41ab26884aea
-- 
gitgitgadget
