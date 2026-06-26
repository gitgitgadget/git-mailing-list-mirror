Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281FA95E
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479291; cv=none; b=t/YhrBovSHp5Ke0QqNNLq4OWx/4kku1+01GG6tA0hDg/dDGRewKI9afYPKaOQVVWteSUNVbqB7ffUEAO1Wyc6YeLL9zV92qTsGcAMgJBa+tR97khzXuXJo0YHl0PU8wYFVAepur+wGyOEidr1sJm2QvSvBeByzv+rwlK8u5Dt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479291; c=relaxed/simple;
	bh=usWLQQeTh/5OjqE/VbKA9J4yKdWADkxXZ9KSwYynoas=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SQu9EuwZI94bBVMxgDcKfjauZyStqmgryvceQqi7YjQW6MvuYFwzpi7IMilz4wa/rldp81z0smRDZGIfl8oRNW/OeG7ixFKfsgH/2wNInYxQQwHRNiw+PqNAkUAbIcvLxq6/7qd1HimRwhih9sLr1+611CcfVMM9Jg4OgqJf0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdl1tWy7; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdl1tWy7"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8e855bb8216so4160746d6.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479288; x=1783084088; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFCsmjTJZ4etrOrBK6ihTgR7B7zf1sNZ1YQEs+mhAUE=;
        b=qdl1tWy7xI6Q9Ki4YbWrkz8Vjyll8X44t/fS6Ov3XlevrC8bbYVg++2NWBDtjCB9ti
         peEZhgBnEFFGUEFlBDWgAZnlM+aMcNBrWVXplLOfb2WFUCvnODUr112wuc0T0G7aFU17
         UEDKn/XqsTOARhGXq4nR2x0fDUhWkaX7+10rG6VGO/8PJZCWWbq5xO9gK379SxiBilO/
         R5rJQNxuZOHYEiizLL2oOjA5KxFFUwFjqoCVYU8HLEOuah0/gU32al93YTo47UKblonn
         7PfE7SOy769pRWIpPlz+ECu+7TKgULk+OhCg9UR3L7yrmKDKfWkHLBjY8CeD+5zV25J+
         ysJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479288; x=1783084088;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFCsmjTJZ4etrOrBK6ihTgR7B7zf1sNZ1YQEs+mhAUE=;
        b=TQ0tOpkElswupxBCVIRwHvfHX5AwGGMPWI8eY4Mms8vG8NcJ0TFqXImi4Xpt5V8Fha
         x/tNyJC/4WF2QBf793hdA5AZ3U4G8eSjxHWO+2gMTgIB/d3sJhg/uwE21/5Yeo3uA/FK
         2F4b0Strw9oW9aNDNUQlAuIvR/YhFKk16OwP5dJyiqtE4kKCw6SiOSANnUJdRp1WjkaC
         EEu340XoDC/fpWcT61lm6uxCqoXmwvVDEeIYseb9eGPsIwVAS2rigN7ncgZW6kem7sYp
         Mvw+TP5kB8CUbolGVeGLe5+mHlaGEFNhSWW2N29+O81Gxnt3AQ+N/QizLr1g2K+Ld8OM
         4Y2A==
X-Gm-Message-State: AOJu0Yxup2NerEm+2ED/ufbxpzkyinKuXW7kQax3xikPf7ScqgAmYIM4
	yBNAkgOhvAvjRRsLStKUTWJR7IssAOcOoSmi68dQI8PxspHRHq1KeemPTrcw+A==
X-Gm-Gg: AfdE7cnvkDGAwzKIyw+at74kfrh08Nv7qqdM2RnNpdxBFQzbJG8/TgypVT0Chc07Bj9
	n7CU65qy22x8vZZ5Eeda46yNphuKwA4qKmyv6URU67OaR70OhrZ2NctGjDWeK7z54IZDSCtb86t
	YBoL9mruJMzBsPs6eJgKTNJ8NpwuzW9jKX2HE8iPVlBl81WtnBQcN3J/UTNmJZC42hk5d7DTSDX
	RR1lS8Ejsy7SEBBuC+2eB2X9rlk/j1P32MYH3rTTPoc771/hxCKumslBEkkLTYZ9ZNrysQhGBn7
	+MvM4laBSwWsGFqhaLPB7MPP0iGD8w0RSY3kQN49IispTWe4b+x4kjLuLI609mbBZT3gRnYMkvP
	Zk4isn7Oew/9KmXKPWtUx8ikbqQYw2CtQV7Nx6nzcBEgBfUq4DAcHP+8+3XnJX7+/82kq4pmucs
	OYEuoAlQNyOoX3Qq0Wv0qAefIr
X-Received: by 2002:a05:622a:408b:b0:517:9157:ecf0 with SMTP id d75a77b69052e-51a727cda2amr100090081cf.29.1782479287619;
        Fri, 26 Jun 2026 06:08:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515ccdbbsm94525391cf.11.2026.06.26.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:08:06 -0700 (PDT)
Message-Id: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 13:07:57 +0000
Subject: [PATCH v3 0/8] commit-reach: terminate merge-base walk when one side is exhausted
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


Changes since v2:

 * New patch 8/8: moved the min_generation termination check and the
   last_gen monotonicity assertion into paint_queue_get(), consolidating
   halt conditions. commit_graph_generation() is now called once per
   dequeued commit and shared across all checks.

 * Widened the generation-monotonicity BUG assertion to fire
   unconditionally, not only when min_generation is set. The side-exhaustion
   optimization depends on correct generation ordering, so the assertion
   should always be active. This is a behavior change: the BUG() now fires
   for any generation ordering violation, regardless of the caller.

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
 .../technical/paint-down-to-common.adoc       | 137 +++++++++++++
 commit-reach.c                                | 147 ++++++++++----
 t/meson.build                                 |   1 +
 t/t6099-merge-base-side-exhaustion.sh         |  82 ++++++++
 t/t6600-test-reach.sh                         | 181 ++++++++++++++++--
 7 files changed, 501 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh


base-commit: 6c3d7b73556db708feb3b16232fab1efc4353428
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2149%2Fspkrka%2Fside-exhaust-pr-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2149/spkrka/side-exhaust-pr-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2149

Range-diff vs v2:

 1:  19ed743bd1 = 1:  2593866bce Documentation/technical: add paint-down-to-common doc
 2:  6151b8e0a3 = 2:  9efc084850 t6600: add test cases for side-exhaustion edge cases
 3:  90f09ecb5c = 3:  14b0d86b93 t6099, t6600: add side-exhaustion regression tests
 4:  6ade4df2ed ! 4:  2592264cda commit-reach: add trace2 instrumentation to paint_down_to_common()
     @@ Commit message
      
          Add a step counter and trace2_data_intmax() call so that the number
          of commits visited during the paint walk is observable via
     -    GIT_TRACE2_PERF. This provides a way to measure the impact of
     +    GIT_TRACE2_EVENT. This provides a way to measure the impact of
          future optimizations without relying on wall-clock benchmarks alone.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       }
      
       ## t/t6600-test-reach.sh ##
     -@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
     - 	test_all_modes get_merge_bases_many
     +@@ t/t6600-test-reach.sh: test_expect_success 'setup' '
       '
       
     -+test_expect_success 'merge-base --all commit-walk steps' '
     -+	test_when_finished rm -rf .git/objects/info/commit-graph \
     -+		.git/objects/info/commit-graphs &&
     -+	rm -rf .git/objects/info/commit-graph \
     -+		.git/objects/info/commit-graphs &&
     -+
     -+	GIT_TRACE2_EVENT="$(pwd)/trace-none.txt" \
     -+		git merge-base --all commit-9-9 commit-9-1 >actual &&
     -+	test_trace2_data paint_down_to_common steps 81 <trace-none.txt &&
     + run_all_modes () {
     +-	test_when_finished rm -rf .git/objects/info/commit-graph &&
     +-	"$@" <input >actual &&
     +-	test_cmp expect actual &&
     +-	cp commit-graph-full .git/objects/info/commit-graph &&
     +-	"$@" <input >actual &&
     +-	test_cmp expect actual &&
     +-	cp commit-graph-half .git/objects/info/commit-graph &&
     +-	"$@" <input >actual &&
     +-	test_cmp expect actual &&
     +-	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
     +-	"$@" <input >actual &&
     +-	test_cmp expect actual
     ++	graph=.git/objects/info/commit-graph &&
     ++	test_when_finished rm -rf "$graph" "${graph}s" &&
     ++	rm -f trace-mode-*.txt &&
      +
     -+	cp commit-graph-full .git/objects/info/commit-graph &&
     -+	GIT_TRACE2_EVENT="$(pwd)/trace-full.txt" \
     -+		git merge-base --all commit-9-9 commit-9-1 >actual &&
     -+	test_trace2_data paint_down_to_common steps 80 <trace-full.txt &&
     ++	for mode in none full half no-gdat
     ++	do
     ++		rm -rf "$graph" "${graph}s" &&
     ++		cp "commit-graph-${mode}" "$graph" 2>/dev/null ||
     ++		true &&
     ++		GIT_TRACE2_EVENT="$(pwd)/trace-mode-${mode}.txt" \
     ++			"$@" <input >actual &&
     ++		test_cmp expect actual || return 1
     ++	done
     + }
     + 
     + test_all_modes () {
     + 	run_all_modes test-tool reach "$@"
     + }
     + 
     ++test_paint_down_steps () {
     ++	for mode in none full half no-gdat
     ++	do
     ++		test_trace2_data paint_down_to_common steps "$1" \
     ++			<"trace-mode-${mode}.txt" || return 1
     ++		shift
     ++	done
     ++}
      +
     -+	cp commit-graph-half .git/objects/info/commit-graph &&
     -+	GIT_TRACE2_EVENT="$(pwd)/trace-half.txt" \
     -+		git merge-base --all commit-9-9 commit-9-1 >actual &&
     -+	test_trace2_data paint_down_to_common steps 81 <trace-half.txt
     + test_expect_success 'ref_newer:miss' '
     + 	cat >input <<-\EOF &&
     + 	A:commit-5-7
     +@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:self' '
     + 	X:commit-6-8
     + 	EOF
     + 	echo "in_merge_bases_many(A,X):1" >expect &&
     +-	test_all_modes in_merge_bases_many
     ++	test_all_modes in_merge_bases_many &&
     ++	test_paint_down_steps 45 2 25 3
     + '
     + 
     + test_expect_success 'is_descendant_of:hit' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:pending-stale' '
     + 		echo "get_merge_bases_many(A,X):" &&
     + 		git rev-parse ps-B
     + 	} >expect &&
     +-	test_all_modes get_merge_bases_many
     ++	test_all_modes get_merge_bases_many &&
     ++	test_paint_down_steps 6 6 6 6
     + '
     + 
     + test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     + 		echo "get_merge_bases_many(A,X):" &&
     + 		git rev-parse pi-B
     + 	} >expect &&
     +-	test_all_modes get_merge_bases_many
     ++	test_all_modes get_merge_bases_many &&
     ++	test_paint_down_steps 5 5 5 5
     + '
     + 
     + test_expect_success 'setup mixed finite/INFINITY topology' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
     + 		echo "get_merge_bases_many(A,X):" &&
     + 		git rev-parse ps-X
     + 	} >expect &&
     +-	test_all_modes get_merge_bases_many
     ++	test_all_modes get_merge_bases_many &&
     ++	test_paint_down_steps 3 3 3 3
      +'
      +
     ++test_expect_success 'merge-base --all commit-walk steps' '
     ++	>input &&
     ++	git rev-parse commit-9-1 >expect &&
     ++	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
     ++	test_paint_down_steps 81 80 81 81
     + '
     + 
       test_expect_success 'reduce_heads' '
     - 	cat >input <<-\EOF &&
     - 	X:commit-1-10
 5:  f24edd45f0 ! 5:  e82e0c72b6 commit-reach: introduce struct paint_state with per-side counters
     @@ Commit message
          (max_nonstale). This is equivalent behavior -- both conditions
          detect that no non-stale entries remain.
      
     -    The existing nonstale_queue is left in place for ahead_behind().
     +    paint_queue_get() uses a "pop first" form: it dequeues a commit,
     +    then checks the counters. This means the loop exits one iteration
     +    earlier than the old code in some topologies (the popped stale
     +    commit is never processed), so a few step counts drop by one.
      
     -    Step counts (via trace2 from the previous commit) are identical
     -    before and after this refactoring, confirming no behavioral change.
     +    The existing nonstale_queue is left in place for ahead_behind().
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     @@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_q
      +
      +static struct commit *paint_queue_get(struct paint_state *state)
      +{
     -+	struct commit *commit;
     ++	struct commit *commit = prio_queue_get(&state->queue);
     ++
     ++	if (!commit)
     ++		return NULL;
     ++
     ++	commit->object.flags &= ~ENQUEUED;
      +
      +	if (!state->p1_count && !state->p2_count &&
      +	    !state->pending_merge_bases)
      +		return NULL;
      +
     -+	commit = prio_queue_get(&state->queue);
     -+	if (commit) {
     -+		commit->object.flags &= ~ENQUEUED;
     -+		paint_count_update(state, commit->object.flags, -1);
     -+	}
     ++	paint_count_update(state, commit->object.flags, -1);
      +	return commit;
      +}
      +
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       	trace2_data_intmax("paint_down_to_common", r,
       			   "steps", steps);
       	commit_list_sort_by_date(result);
     +
     + ## t/t6600-test-reach.sh ##
     +@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:pending-stale' '
     + 		git rev-parse ps-B
     + 	} >expect &&
     + 	test_all_modes get_merge_bases_many &&
     +-	test_paint_down_steps 6 6 6 6
     ++	test_paint_down_steps 5 5 5 5
     + '
     + 
     + test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     + 		git rev-parse pi-B
     + 	} >expect &&
     + 	test_all_modes get_merge_bases_many &&
     +-	test_paint_down_steps 5 5 5 5
     ++	test_paint_down_steps 5 4 5 5
     + '
     + 
     + test_expect_success 'setup mixed finite/INFINITY topology' '
 6:  8c72f01083 = 6:  e6181bf3c1 commit-reach: remove unused nonstale_queue dedup wrappers
 7:  d84b932e5b ! 7:  f3572a8a89 commit-reach: terminate merge-base walk when one paint side is exhausted
     @@ Commit message
          once the walk enters the finite-generation region where ordering
          guarantees hold.
      
     +    Widen the existing generation-monotonicity BUG assertion to fire
     +    unconditionally, not only when min_generation is set. The
     +    side-exhaustion optimization depends on correct generation ordering,
     +    so the assertion should always be active.
     +
          Step counts measured with trace2 on git.git with commit-graph:
      
            merge-base --all v2.0.0 v2.55.0-rc1:
     @@ Documentation/technical/paint-down-to-common.adoc: existing candidates by provin
      
       ## commit-reach.c ##
      @@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
     + 	}
     + }
       
     ++/*
     ++ * Dequeue the next commit for the paint walk, or return NULL when
     ++ * no more merge bases can be discovered.
     ++ */
       static struct commit *paint_queue_get(struct paint_state *state)
       {
     --	struct commit *commit;
     -+	struct commit *commit = prio_queue_get(&state->queue);
     + 	struct commit *commit = prio_queue_get(&state->queue);
     +@@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
     + 
     + 	commit->object.flags &= ~ENQUEUED;
       
      -	if (!state->p1_count && !state->p2_count &&
      -	    !state->pending_merge_bases)
     -+	if (!commit)
     - 		return NULL;
     - 
     --	commit = prio_queue_get(&state->queue);
     --	if (commit) {
     --		commit->object.flags &= ~ENQUEUED;
     --		paint_count_update(state, commit->object.flags, -1);
     -+	commit->object.flags &= ~ENQUEUED;
     -+
     +-		return NULL;
      +	if (!state->pending_merge_bases) {
     ++		/* only stale entries remain */
      +		if (!state->p1_count && !state->p2_count)
      +			return NULL;
     -+		/*
     -+		 * Side exhaustion: a new merge-base can only form
     -+		 * when both PARENT1-only and PARENT2-only commits
     -+		 * remain in the queue. In the finite-generation
     -+		 * region the queue is ordered topologically, so
     -+		 * no future step can add paint to visited commits
     -+		 * and an exhausted side cannot reappear.
     -+		 */
     ++
     ++		/* one side is exhausted */
      +		if ((!state->p1_count || !state->p2_count) &&
      +		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
      +			return NULL;
     - 	}
     -+
     -+	paint_count_update(state, commit->object.flags, -1);
     ++	}
     + 
     + 	paint_count_update(state, commit->object.flags, -1);
       	return commit;
     - }
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 		timestamp_t generation = commit_graph_generation(commit);
     + 		steps++;
       
     +-		if (min_generation && generation > last_gen)
     ++		if (generation > last_gen)
     + 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
     + 			    generation, last_gen,
     + 			    oid_to_hex(&commit->object.oid));
      
       ## t/t6600-test-reach.sh ##
     -@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps' '
     - 	cp commit-graph-full .git/objects/info/commit-graph &&
     - 	GIT_TRACE2_EVENT="$(pwd)/trace-full.txt" \
     - 		git merge-base --all commit-9-9 commit-9-1 >actual &&
     --	test_trace2_data paint_down_to_common steps 80 <trace-full.txt &&
     -+	test_trace2_data paint_down_to_common steps 9 <trace-full.txt &&
     +@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:self' '
     + 	EOF
     + 	echo "in_merge_bases_many(A,X):1" >expect &&
     + 	test_all_modes in_merge_bases_many &&
     +-	test_paint_down_steps 45 2 25 3
     ++	test_paint_down_steps 45 1 25 1
     + '
       
     - 	cp commit-graph-half .git/objects/info/commit-graph &&
     - 	GIT_TRACE2_EVENT="$(pwd)/trace-half.txt" \
     - 		git merge-base --all commit-9-9 commit-9-1 >actual &&
     --	test_trace2_data paint_down_to_common steps 81 <trace-half.txt
     -+	test_trace2_data paint_down_to_common steps 57 <trace-half.txt
     + test_expect_success 'is_descendant_of:hit' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps' '
     + 	>input &&
     + 	git rev-parse commit-9-1 >expect &&
     + 	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
     +-	test_paint_down_steps 81 80 81 81
     ++	test_paint_down_steps 81 9 57 10
       '
       
       test_expect_success 'reduce_heads' '
 -:  ---------- > 8:  4b9f192d98 commit-reach: move min_generation check into paint_queue_get()

-- 
gitgitgadget
