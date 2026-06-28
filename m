Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2422A80D
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649553; cv=none; b=IrYjLirDlSJomR1Yby7adp4ZfmDXoimSlcXpU8dYmrhhs/FLWIyp047z8lpVWbWpxRzT+M/azOS1garWG7hOB/VmkRmvZrGkYto7eKLRJDXuKwUsqo3TRL4JMdpp1p7FaSdmLDi31Sz7IqHFcGeY0Vnh4bE/Ey+UEbf5VBMYDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649553; c=relaxed/simple;
	bh=kerkBGQBs5yZprJyl91AykCqRmTQNBA2+icls5hjThQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O+h6IcLWOPi8tjrrDDxpZcCa2X0mFkfVLcY8UWZyStbyErRkIbt7gAzwI57Bp9QJ4ilAQhWqB49fXAnrnHGT6lP8y7rrLcTanx6Uwiy0zqNWG2FEeDu/Hi9NG5JEFum0WJgnnzyONVaEKA3UEu5M4pC4SAKL1n5Sc1oniaDf9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACvmI5Mi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACvmI5Mi"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51a8dec6299so16506371cf.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782649550; x=1783254350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wlz+w0u9zZK/t7lnHxiLF3OUnNbI1+eyKtgtfvs2X0g=;
        b=ACvmI5Mi5Ne+jZfwSmFLTMmTP6ZFuaGK6cY7KpgKrxYdXL6+VbwLduiB6ZRLYrz8Nr
         EqKKHiphVRzXSA+sN5nOqcQbkQUFkhV5+cOalUx7pEjF1MrVSlwmtaSeMTiJg7bis2ip
         ALVe5tBVID2ES2IN5d9RNiAxLuoPAhjXZUntmrk9Rz9WTau7MprzhnYRcw3jNRcC7lyv
         i8lTzRGdo8wbfKq56a9ormp2+uqkneDbzdGOznBvQhKSxGz4X1hK9PrQLkfNIfHiXIYv
         G1BoG8THFxSw254rHek5DuBbMNP6saONZKvn0nKdDn9S3plp3zpAUFN3p2jgG3bGXRml
         S3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649550; x=1783254350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wlz+w0u9zZK/t7lnHxiLF3OUnNbI1+eyKtgtfvs2X0g=;
        b=KvhsNqBHclsuBGmtwUwjUJfjcwNgCHxqhDse3HQ6chPs02axo00xXByHVT44xL609K
         rKjrR3u9/UkN+4McWnUG8Ei/saAw9l2M8v68l6vKaPfTzF84adxiO2CTJe+w3InFpTcx
         7GYjUv8lLIVpI+OtSVyC6sLGXqWuU3PEaFmPdOPopTV4rj2WVhUds7aAwgDR/79KT3D2
         0tCOvuoCd4Ep2FzVR6DZGvXG5I+1J1WcW/kRkWKSTm+b7AjIUoJX73cgSiPxwccFIXoX
         CuPHPijr9KCE6eF5G1cOfQOGt7maymBEly38d57+EwnkRDKewJUaQNOSLTnZSg1BLv1u
         DKYQ==
X-Gm-Message-State: AOJu0YyJuADttpZYevluy3ig6f4mHVU18d3E1kRlrCS/20No58iCeUnR
	GwnKMRLQaAT9sYC9qW/QczhtBw3VE474rR8h/UKxoGyYzLMOVD1r4ni3wuyRsg==
X-Gm-Gg: AfdE7cnIm4Vr5Lzrxhpi7adOCFwamnfhrqjYIgWzXFCHW+ojS4LbB8RpcBpyuXqiw+I
	mLs37gtXsCEJ0qFFCdz5dbOVBh8QSPH/ovybtfFcV3P7x1T0vH2Nx7uyI0lQwWw/gD73PPs5Rqx
	EFMVvtOcfsoKHZFiZaW7V/QQR6zVFgYcKzH9iR40RTnvI0luB59N2nEo5Tiq50h2Rm8xfU+b4nx
	PplXxCYhvVWEgKdxny0wlj/arf/a/RC4BTUVFIt8Hz+xMg0ja4NJoKKsyPgBNZPpbr0Mgbak1VX
	6g1lDo4BlZNWi8wMCwGRraMtmbbop+XovqvnVHa+xkg+yafZdRDeuqV+LJAyuQJ+aZqzTe1CUM0
	k5MBFJeB0OKiW/f3HCnIuQfEfrE7Rvm726OygK8wHv4hTxdhXOD1LWsv3oU0gNobQAeaxl6p//X
	84KimTYc4tGhlaCWHj
X-Received: by 2002:a05:622a:a491:b0:51a:8f1c:6fb3 with SMTP id d75a77b69052e-51a8f1c79e8mr54916501cf.30.1782649550344;
        Sun, 28 Jun 2026 05:25:50 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51bf2b175e1sm14236671cf.4.2026.06.28.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:25:49 -0700 (PDT)
Message-Id: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 12:25:38 +0000
Subject: [PATCH v4 0/8] commit-reach: terminate merge-base walk when one side is exhausted
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
    Kristofer Karlsson <krka@spotify.com>

commit-reach: terminate merge-base walk when one paint side is exhausted

Optimize paint_down_to_common() for merge-base queries that hit large
one-sided histories.

When the walk from one side reaches a commit with a very low generation
number that the other side never paints, the walk is forced to drain most of
the graph. A common trigger is a repository import that grafts a separate
history with its own root, but any merge that introduces a low-generation
commit never painted by the other side has the same effect.

A new merge-base candidate can only be discovered when exclusive PARENT1 and
PARENT2 paint meet. This series teaches paint_down_to_common() to stop as
soon as one side has no exclusive commits left in the queue; once one side
is exhausted, no further candidates can appear.

  origin/HEAD  o   o  PR HEAD
               |   |
     (import)  o   :
              / \ /
             |   o  merge-base
             |   |
             :   :  (~2.5M commits)
             |   |
  import root   main root


In the RFC thread [1], Derrick Stolee provided a criss-cross counterexample
that sharpened the halt condition, and Elijah Newren independently
discovered the same optimization and shared an implementation in PR #2150
[2]. Patches 2-3 incorporate test cases from Elijah's branch.

This series implements the optimization only after the walk enters the
finite-generation region, where generation ordering guarantees that paint on
visited commits is final.

Patch layout:

1/8 Documentation/technical: add paint-down-to-common doc 2/8 t6600: add
test cases for side-exhaustion edge cases 3/8 t6099, t6600: add
side-exhaustion regression tests 4/8 commit-reach: add trace2
instrumentation to paint_down_to_common() 5/8 commit-reach: introduce struct
paint_state with per-side counters 6/8 commit-reach: remove unused
nonstale_queue dedup wrappers 7/8 commit-reach: terminate merge-base walk
when one paint side is exhausted 8/8 commit-reach: move min_generation check
into paint_queue_get()

Benchmarks

Step counts are deterministic (measured via trace2_data_intmax added in
patch 4). Wall-clock times are best-of-11 runs.

2.6M-commit monorepo with commit-graph:

                                        steps              wall-clock
  merge-base --all  (across import)  2143438 ->      3     3.67s ->    5ms
  merge-base --all  (1000 apart)     2692915 ->   1035     4.41s ->    7ms
  merge-base --all  (5000 apart)     2692915 ->   6401     4.45s ->   13ms
  merge-base --all  (HEAD vs import) 2698872 ->  45960     4.50s ->   79ms
  merge-tree        (across import)  2143438 ->      3     4.42s ->   11ms


git.git (88k commits, commit-graph):

                                        steps              wall-clock
  merge-base --all v2.0.0 v2.55.0-rc1 72264 ->  44589      110ms ->   68ms
  merge-base --all HEAD HEAD~1000      9891 ->   3828       18ms ->   10ms
  merge-base --all HEAD HEAD~10000    72303 ->  41487      101ms ->   50ms


Changes since v3:

 * Fixed BUG assertion that was accidentally made unconditional in v3:
   restored the min_generation guard so it only fires when generation-based
   ordering is active.

 * Moved generation cutoff and single-result termination conditions into the
   documentation in patch 1/8, since they describe existing behavior.

 * Renamed paint_state counter fields for clarity: p1_count ->
   parent1_count, p2_count -> parent2_count, pending_merge_bases ->
   mb_candidate_count. Changed counter types from int to size_t. (Suggested
   by Rene Scharfe.)

Changes since v2:

 * New patch 8/8: moved the min_generation termination check and the
   last_gen monotonicity assertion into paint_queue_get(), consolidating
   halt conditions. commit_graph_generation() is now called once per
   dequeued commit and shared across all checks.

 * Moved all halt conditions inside paint_queue_get() with the "pop first"
   form: pop, check, then decrement counters. This keeps the optimization
   commit's diff minimal (just inserting the new checks between pop and
   decrement).

 * Shortened the doc comment on paint_queue_get() to describe what it does
   rather than how. Inline comments on each return NULL explain the specific
   halt condition.

 * Replaced the manual commit-graph setup in the step-count test with
   run_all_modes, which now sets GIT_TRACE2_EVENT per mode and produces
   trace-mode-{none,full,half,no-gdat}.txt files.

 * Added a test_paint_down_steps helper for concise 4-mode step assertions
   with diagnostic output on mismatch (prints "expected X, got Y" instead of
   a silent grep failure).

 * Added step-count assertions to the single-walk edge-case tests:
   in_merge_bases_many:self, pending-stale, infinity-both-sides,
   mixed-finite-infinity.

 * Included step counts alongside wall-clock times in the benchmark tables.

Changes since v1:

 * Reordered patches: documentation first (describing the existing
   algorithm), tests before code changes, so they demonstrate passing with
   old logic first.

 * Dropped the ahead_behind decoupling patch. paint_state is now a NEW
   struct alongside nonstale_queue instead of replacing it. ahead_behind()
   is completely untouched.

 * Removed nonstale_queue_put_dedup() and nonstale_queue_get_dedup() (dead
   code after the conversion) in a separate commit.

 * Renamed: struct paint_queue -> paint_state, field pq -> queue,
   paint_count_add/remove -> paint_count_update (single function with signed
   delta parameter).

 * Split the old paint_count_transition (which handled both old and new
   flags in one call) into separate remove/add calls with a signed delta.
   This eliminates the need for the case 0 handler (which tracked "not in
   the queue") and allows an exhaustive switch on (PARENT1 | PARENT2 |
   STALE) that documents all valid flag combinations, with BUG() in default.

 * Added trace2_data_intmax() instrumentation to report the number of
   commits visited per paint walk (separate commit), with deterministic
   step-count assertions in t6600.

 * Expanded switch statements to multi-line format per .clang-format.

 * Used !count style throughout instead of count == 0.

 * Updated technical documentation alongside code changes.

[1]
https://lore.kernel.org/git/CAL71e4Ps-2_0+uuZu43N9pFnXBemoAohPs_eyRJf8taXHJPAXQ@mail.gmail.com/T/#u
[2] https://github.com/gitgitgadget/git/pull/2150

Elijah Newren (1):
  t6600: add test cases for side-exhaustion edge cases

Kristofer Karlsson (7):
  Documentation/technical: add paint-down-to-common doc
  t6099, t6600: add side-exhaustion regression tests
  commit-reach: add trace2 instrumentation to paint_down_to_common()
  commit-reach: introduce struct paint_state with per-side counters
  commit-reach: remove unused nonstale_queue dedup wrappers
  commit-reach: terminate merge-base walk when one paint side is
    exhausted
  commit-reach: move min_generation check into paint_queue_get()

 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 149 ++++++++++++++
 commit-reach.c                                | 147 ++++++++++----
 t/meson.build                                 |   1 +
 t/t6099-merge-base-side-exhaustion.sh         |  82 ++++++++
 t/t6600-test-reach.sh                         | 181 ++++++++++++++++--
 7 files changed, 513 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh


base-commit: 6c3d7b73556db708feb3b16232fab1efc4353428
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2149%2Fspkrka%2Fside-exhaust-pr-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2149/spkrka/side-exhaust-pr-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2149

Range-diff vs v3:

 1:  2593866bce ! 1:  3efb095b03 Documentation/technical: add paint-down-to-common doc
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +  1. The queue is empty.
      +  2. `max_nonstale` has been dequeued, meaning the queue only contains
      +     STALE entries.
     ++  3. Generation cutoff: the dequeued commit's generation is below
     ++     a caller-supplied `min_generation` threshold.
     ++  4. Single result: the caller only needs one merge base, one has
     ++     been found, and the walk has entered the finite-generation
     ++     region.
      +
      +Stale entry condition
      +~~~~~~~~~~~~~~~~~~~~~
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +`remove_redundant()` handles that as a post-processing step, so it
      +is safe to exit early.
      +
     ++Generation cutoff
     ++~~~~~~~~~~~~~~~~~
     ++Some callers (notably `remove_redundant()`) supply a `min_generation`
     ++threshold -- the minimum generation of the input commits. No merge
     ++base can have a generation below this threshold, so the walk
     ++terminates as soon as it dequeues such a commit.
     ++
     ++Single result
     ++~~~~~~~~~~~~~
     ++When only one merge base is needed and the walk is in the
     ++finite-generation region, the first candidate found is necessarily
     ++the highest-generation common ancestor. No remaining commit in the
     ++queue can be a descendant of this candidate (generation ordering
     ++guarantees children are visited first), so it cannot be redundant
     ++and the walk can stop immediately.
     ++
      +Related documentation
      +---------------------
      +
 2:  9efc084850 = 2:  1a0154b406 t6600: add test cases for side-exhaustion edge cases
 3:  14b0d86b93 = 3:  017bf156c5 t6099, t6600: add side-exhaustion regression tests
 4:  2592264cda = 4:  df3b090a2b commit-reach: add trace2 instrumentation to paint_down_to_common()
 5:  e82e0c72b6 ! 5:  fed9f2c368 commit-reach: introduce struct paint_state with per-side counters
     @@ Documentation/technical/paint-down-to-common.adoc: re-enqueued is bounded by the
      -  2. `max_nonstale` has been dequeued, meaning the queue only contains
      -     STALE entries.
      +  2. The queue contains only stale entries.
     - 
     - Stale entry condition
     - ~~~~~~~~~~~~~~~~~~~~~
     +   3. Generation cutoff: the dequeued commit's generation is below
     +      a caller-supplied `min_generation` threshold.
     +   4. Single result: the caller only needs one merge base, one has
      
       ## commit-reach.c ##
      @@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
     @@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_q
      + */
      +struct paint_state {
      +	struct prio_queue queue;
     -+	int p1_count;
     -+	int p2_count;
     -+	int pending_merge_bases;
     ++	size_t parent1_count;
     ++	size_t parent2_count;
     ++	size_t mb_candidate_count;
      +};
      +
      +static void paint_count_update(struct paint_state *state,
     @@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_q
      +{
      +	switch (flags & (PARENT1 | PARENT2 | STALE)) {
      +	case PARENT1:
     -+		state->p1_count += delta;
     ++		state->parent1_count += delta;
      +		break;
      +
      +	case PARENT2:
     -+		state->p2_count += delta;
     ++		state->parent2_count += delta;
      +		break;
      +
      +	case PARENT1 | PARENT2:
     -+		state->pending_merge_bases += delta;
     ++		state->mb_candidate_count += delta;
      +		break;
      +
      +	case PARENT1 | PARENT2 | STALE:
     @@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_q
      +
      +	commit->object.flags &= ~ENQUEUED;
      +
     -+	if (!state->p1_count && !state->p2_count &&
     -+	    !state->pending_merge_bases)
     ++	if (!state->parent1_count && !state->parent2_count &&
     ++	    !state->mb_candidate_count)
      +		return NULL;
      +
      +	paint_count_update(state, commit->object.flags, -1);
 6:  e6181bf3c1 = 6:  4db485b48a commit-reach: remove unused nonstale_queue dedup wrappers
 7:  f3572a8a89 ! 7:  4506780649 commit-reach: terminate merge-base walk when one paint side is exhausted
     @@ Commit message
          commit-reach: terminate merge-base walk when one paint side is exhausted
      
          Add an early termination check to paint_down_to_common() using the
     -    per-side counters introduced earlier. Once the walk enters the
     +    per-side counters introduced earlier.  Once the walk enters the
          finite-generation region, terminate early when one side's exclusive
          count drops to zero -- no new merge-base can form without both paint
          sides meeting.
     @@ Commit message
      
          The INFINITY gate ensures correctness: commits without a commit-graph
          entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
     -    which is not topologically reliable. The optimization only fires
     +    which is not topologically reliable.  The optimization only fires
          once the walk enters the finite-generation region where ordering
          guarantees hold.
      
     -    Widen the existing generation-monotonicity BUG assertion to fire
     -    unconditionally, not only when min_generation is set. The
     -    side-exhaustion optimization depends on correct generation ordering,
     -    so the assertion should always be active.
     -
          Step counts measured with trace2 on git.git with commit-graph:
      
            merge-base --all v2.0.0 v2.55.0-rc1:
     @@ Commit message
      
       ## Documentation/technical/paint-down-to-common.adoc ##
      @@ Documentation/technical/paint-down-to-common.adoc: ends when one of the following conditions holds:
     - 
     -   1. The queue is empty.
     -   2. The queue contains only stale entries.
     -+  3. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
     +   4. Single result: the caller only needs one merge base, one has
     +      been found, and the walk has entered the finite-generation
     +      region.
     ++  5. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
      +     remain in the queue, no pending merge-base candidates exist,
      +     and the walk has entered the finite-generation region.
       
     @@ Documentation/technical/paint-down-to-common.adoc: existing candidates by provin
      +commit-date ordering can violate this guarantee, so the check is
      +skipped.
      +
     - Related documentation
     - ---------------------
     - 
     + Generation cutoff
     + ~~~~~~~~~~~~~~~~~
     + Some callers (notably `remove_redundant()`) supply a `min_generation`
      
       ## commit-reach.c ##
      @@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
     @@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
       
       	commit->object.flags &= ~ENQUEUED;
       
     --	if (!state->p1_count && !state->p2_count &&
     --	    !state->pending_merge_bases)
     +-	if (!state->parent1_count && !state->parent2_count &&
     +-	    !state->mb_candidate_count)
      -		return NULL;
     -+	if (!state->pending_merge_bases) {
     ++	if (!state->mb_candidate_count) {
      +		/* only stale entries remain */
     -+		if (!state->p1_count && !state->p2_count)
     ++		if (!state->parent1_count && !state->parent2_count)
      +			return NULL;
      +
      +		/* one side is exhausted */
     -+		if ((!state->p1_count || !state->p2_count) &&
     ++		if ((!state->parent1_count || !state->parent2_count) &&
      +		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
      +			return NULL;
      +	}
       
       	paint_count_update(state, commit->object.flags, -1);
       	return commit;
     -@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     - 		timestamp_t generation = commit_graph_generation(commit);
     - 		steps++;
     - 
     --		if (min_generation && generation > last_gen)
     -+		if (generation > last_gen)
     - 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
     - 			    generation, last_gen,
     - 			    oid_to_hex(&commit->object.oid));
      
       ## t/t6600-test-reach.sh ##
      @@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:self' '
 8:  4b9f192d98 ! 8:  8dd15d44e6 commit-reach: move min_generation check into paint_queue_get()
     @@ Commit message
          Move last_gen into struct paint_state so that
          commit_graph_generation() is called exactly once per dequeued commit
          and the result is shared across all termination checks and the
     -    monotonicity BUG assertion.  The loop body in paint_down_to_common()
     -    reads state.last_gen instead of recomputing the generation number.
     +    monotonicity BUG assertion.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     - ## Documentation/technical/paint-down-to-common.adoc ##
     -@@ Documentation/technical/paint-down-to-common.adoc: ends when one of the following conditions holds:
     -   3. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
     -      remain in the queue, no pending merge-base candidates exist,
     -      and the walk has entered the finite-generation region.
     -+  4. Generation cutoff: the dequeued commit's generation is below
     -+     a caller-supplied `min_generation` threshold.
     - 
     - Stale entry condition
     - ~~~~~~~~~~~~~~~~~~~~~
     -@@ Documentation/technical/paint-down-to-common.adoc: time and an exhausted side cannot reappear. In the INFINITY region,
     - commit-date ordering can violate this guarantee, so the check is
     - skipped.
     - 
     -+Generation cutoff
     -+~~~~~~~~~~~~~~~~~
     -+Some callers (notably `remove_redundant()`) supply a `min_generation`
     -+threshold -- the minimum generation of the input commits. No merge
     -+base can have a generation below this threshold, so the walk
     -+terminates as soon as it dequeues such a commit.
     -+
     - Related documentation
     - ---------------------
     - 
     -
       ## commit-reach.c ##
      @@ commit-reach.c: struct paint_state {
     - 	int p1_count;
     - 	int p2_count;
     - 	int pending_merge_bases;
     + 	size_t parent1_count;
     + 	size_t parent2_count;
     + 	size_t mb_candidate_count;
      +	timestamp_t min_generation;
      +	timestamp_t last_gen;
       };
     @@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
       	commit->object.flags &= ~ENQUEUED;
      +	generation = commit_graph_generation(commit);
      +
     -+	if (generation > state->last_gen)
     ++	if (state->min_generation && generation > state->last_gen)
      +		BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
      +		    generation, state->last_gen,
      +		    oid_to_hex(&commit->object.oid));
     @@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
      +	if (generation < state->min_generation)
      +		return NULL;
       
     - 	if (!state->pending_merge_bases) {
     + 	if (!state->mb_candidate_count) {
       		/* only stale entries remain */
      @@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
       
       		/* one side is exhausted */
     - 		if ((!state->p1_count || !state->p2_count) &&
     + 		if ((!state->parent1_count || !state->parent2_count) &&
      -		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
      +		    generation < GENERATION_NUMBER_INFINITY)
       			return NULL;
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
      -		timestamp_t generation = commit_graph_generation(commit);
       		steps++;
       
     --		if (generation > last_gen)
     +-		if (min_generation && generation > last_gen)
      -			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
      -			    generation, last_gen,
      -			    oid_to_hex(&commit->object.oid));

-- 
gitgitgadget
