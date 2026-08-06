Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D3442131
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013987; cv=none; b=JLYgdOhZRU38TI4pDC4F72nL9M6Pkp81yUuQPpI3MOZzWT+Q5e/hy7VQDBf15YwfuP/6HCrpzOXtpMxHb4g1qbfWtCa5ndOinrsS3T/plj23ipizGQJ5T62DSKDDrKjscP9YXWAcg8GOR5F7iqcpIAy9oYVDECiBrDVTIoQsE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013987; c=relaxed/simple;
	bh=i6GBaQSpsjJebar5IBPVaMuY0VJHZy4v8YzT4wZe7E0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A5T85AhKePCMEkAHiEcARGBU4Gd0TzkUeGjkVO81wUk3hQRLyraiCjHAxu7hxWSBDttBHFA+LAHHwAFXzJ2trw4m1jhFKHlV3sQGTs6u6AyJQYDS1L59WuuqEIOzSZyjb/+v32Pgp/FNHxu6KNv/Fb8kceVYYcz59X3cHmY66WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt62x5Q4; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt62x5Q4"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-668c1b780e5so3006392d50.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786013984; x=1786618784; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6WWaVAxllkNxupNwg1sk6NGMRVA74l1TUkDdzs6n+k8=;
        b=kt62x5Q4KWmHNk6F8xzPMe127ddHWoefZb3BMhI1o5XF/HOU0HBEHOVSBjjweH6eQ5
         8eOcvbv202SQSWsJYz/K3DeaaZ1+ormXjBIR5YwIYgk1RTSWiyvNlXG5dnA+g25hC+Vp
         GN8ZVr+4lvlZPrj4R0wl17bSmNIsPAWI7a7uZy5cw5K3hISJV6QppA+lm7hdTf6w3d7j
         6HX0ctR7leiC/3JGAyWzhlvxx95Xrn61l16XbgyQs51Dwd54+rm/L1AEPhwlNEHQpWrt
         CuMT7Ch4GMo1qWsg1Ag2YuME1+gcxEj1DGHWJuvcgY9I6yfFklAKqAha22sSS9i5Cs9U
         gEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013984; x=1786618784;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6WWaVAxllkNxupNwg1sk6NGMRVA74l1TUkDdzs6n+k8=;
        b=rn2J1vlcCnPPjyAOQvtVGJeDud7j+lmxOeL8er22/G0C3gWHOdtzqCHYAp0YzwpSz+
         D/Oe0fciofEamS6K4OZmmYxxB03D7Uf51nPwFzPOzpmp57fATUE8lyMySAFqkbpaRHPW
         6hwEkVKzCu4M/Wf0HC+X/PSwqo7sT5o/ZRY1UA7HUDsJWAKgXwXI4T0C3/CBkav54XnD
         AigRgOMtqUG2b8LwIga30Sx3NmrSnvLolqAV91Rdt07odEUZOYK4tGcK96G6pxL7uM7v
         9VcJRaxclo8dEOhmSm2DN7NaeW4Qvlf08GfxPv/KhGAevN+Ei5NtqVRAdm7Teuu1HPZ8
         3mQA==
X-Gm-Message-State: AOJu0Yzro0hoVuQ5JmrBYaFGONcd9QUUYeHgmuzutFQkrDMTmcUdC5fv
	+CvZ9yVGMB16AiWli9jG0sbVo/4B8hJgM4iVX+RG3caDor+EYNaWx88r4ZzQ4Q==
X-Gm-Gg: AR+sD11Q8izfd6cpoQxXfTqKfSmqbaZSiBZnccqeSLEB8aYoPz+gCseQNi6QsQk5TAF
	A/ry6j8QcWj5pyjlDDu77454DxoAK7jFZk4Dzv4gD0tI8vv+KQdL96wKUCxvV7jV0099Nd0q7VQ
	DphqKsb4+ut+ejFqmzyU3DcErMyEP51BVhrRC0OgZ5YXjYYF6Ie+MYS3BE34zQmac4rURXfmMSF
	pK5txtwT/DSlX9I2XJq/L/WMvILSSpNVBOgz7xZzY5rF6MqnBBrF3dzSNBAfraDnmWMMPDIFfEa
	WM90CplRucqr5MFmadSaa0Ml7Cxy3DwNwT223+jusRU1IAqBZfsOY1cuI5Jo7g2m27mpv4z9/eO
	F+xeIlFXrC4BTCegjFDaatfx/IQ46gARnBO7dfS5GQSGrfRVEAmxkXaJOu6Iv90Vx716CrLUke6
	dyqjYT7/FXyr+5ZJMlsL4awFn197fAaTH+FynxeQi+7f7qa78D0uDtGVSRLcQKiYI=
X-Received: by 2002:a05:690e:488a:b0:663:9a0a:7b80 with SMTP id 956f58d0204a3-6699a9ff225mr6915961d50.19.1786013984273;
        Thu, 06 Aug 2026 03:59:44 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669915f5a6asm4679355d50.12.2026.08.06.03.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:59:43 -0700 (PDT)
Message-Id: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:31 +0000
Subject: [PATCH v7 00/10] commit-reach: terminate merge-base walk when one side is exhausted
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
Cc: Kristofer Karlsson <krka@spotify.com>

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
[2]. Patch 3 incorporates test cases from Elijah's branch.

This series implements the optimization only after the walk enters the
finite-generation region, where generation ordering guarantees that paint on
visited commits is final.

Patch 2 adds a test_trace2_data_singular helper to test-lib-functions.sh
that reports expected/actual values on assertion failure instead of a silent
grep exit. This was invaluable during development for iterating on step
counts across the series, and should be valuable for repairing tests after
future algorithmic changes. Happy to drop it if it is considered unnecessary
infrastructure.

The final patch removes the commit-date ordering fallback introduced by
091f4cf3 (commit: don't use generation numbers if not needed, 2018-08-30).
With side-exhaustion in place, the fallback is no longer needed for
performance, and removing it ensures the queue is always generation-ordered
regardless of graph version, so every termination condition can rely on a
single ordering invariant. This patch can be dropped if the scope is too
broad for this series.

Benchmarks

Trace2 step counts are deterministic (measured via trace2_data_intmax added
in patch 5). Wall-clock times are best-of-11 runs.

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


This series is based on master.

[1]
https://lore.kernel.org/git/CAL71e4Ps-2_0+uuZu43N9pFnXBemoAohPs_eyRJf8taXHJPAXQ@mail.gmail.com/T/#u
[2] https://github.com/gitgitgadget/git/pull/2150

Changes since v6:

 * Now based on master; all prerequisite topics have graduated.

 * Added a topological ceiling concept for v1 commit-graph support. When the
   commit-graph uses v1 topological levels (no GDAT chunk), generation
   numbers saturate at V1_MAX, breaking ordering guarantees in the same way
   as INFINITY. Patch 10 introduces a topo_ceiling (V1_MAX for v1, INFINITY
   for v2) that the side-exhaustion and single-result gates compare against,
   so saturated commits are treated as unordered.

 * Used $LF variable instead of a literal newline in the
   test_trace2_data_singular helper (patch 2), matching the existing pattern
   in test-lib. (Suggested by Rene Scharfe.)

 * Improved the min_generation / generation cutoff documentation to explain
   why callers can safely terminate early, rather than just stating the
   threshold rule.

Changes since v5:

 * Rebased on next, which now contains kk/commit-reach-find-all-fix. The
   gen_ordered guard from that topic is carried through patches 7-9 via
   state.gen_ordered, then removed in patch 10 along with the date-ordering
   fallback.

 * Minor documentation and test comment improvements.

Changes since v4:

 * New patch 2/10: added test_trace2_data_singular helper to
   test-lib-functions.sh. Shows expected/actual values on assertion failure
   instead of a silent grep failure. Makes iterating on step counts much
   easier.

 * New patch 6/10: added clock-skew topologies (se-, se2-) that expose
   side-exhaustion bugs when the commit-date ordering fallback fires with a
   v1 commit graph. All topologies use a shared skew_commit helper. Includes
   step count assertions for edge-case tests from patch 3.

 * Folded the nonstale_queue dedup wrapper removal (previously separate
   patch 6/8) into the paint_state introduction in patch 7/10.

 * New patch 10/10: remove the commit-date ordering fallback in
   paint_down_to_common(). The fallback (091cf18e) was a performance
   optimization for v1 commit graphs, but it breaks the generation ordering
   invariant that both the side-exhaustion and single-result optimizations
   depend on. With side-exhaustion in place, the fallback is no longer
   needed. If kept, this supersedes the separate "commit-reach: fix
   !FIND_ALL early exit with v1 commit graph" topic.

Changes since v3:

 * Fixed BUG assertion that was accidentally made unconditional in v3:
   restored the min_generation guard so it only fires when generation-based
   ordering is active.

 * Moved generation cutoff and single-result termination conditions into the
   documentation in patch 1, since they describe existing behavior.

 * Renamed paint_state counter fields for clarity: p1_count ->
   parent1_count, p2_count -> parent2_count, pending_merge_bases ->
   mb_candidate_count. Changed counter types from int to size_t. (Suggested
   by Rene Scharfe.)

Changes since v2:

 * New patch 9/10 (was 8/8): moved the min_generation termination check and
   the last_gen monotonicity assertion into paint_queue_get(), consolidating
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
   commits visited per paint walk (separate commit), with step-count
   assertions in tests for deterministic regression detection.

cc: Derrick Stolee stolee@gmail.com cc: Elijah Newren newren@gmail.com cc:
Kristofer Karlsson krka@spotify.com cc: René Scharfe l.s.r@web.de cc: SZEDER
Gábor szeder.dev@gmail.com

Elijah Newren (1):
  t6600: add test cases for side-exhaustion edge cases

Kristofer Karlsson (9):
  Documentation/technical: add paint-down-to-common doc
  test-lib-functions: improve diagnostic output for trace2 data
    assertions
  t6099, t6600: add side-exhaustion regression tests
  commit-reach: add trace2 instrumentation to paint_down_to_common()
  t6600: add clock-skew topologies and step counts for edge cases
  commit-reach: introduce struct paint_state with per-side counters
  commit-reach: terminate merge-base walk when one paint side is
    exhausted
  commit-reach: move min_generation check into paint_queue_get()
  commit-reach: remove commit-date ordering fallback

 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 164 ++++++++++++
 commit-reach.c                                | 160 +++++++++---
 t/meson.build                                 |   1 +
 t/t6099-merge-base-side-exhaustion.sh         |  82 ++++++
 t/t6600-test-reach.sh                         | 241 +++++++++++++++++-
 t/test-lib-functions.sh                       |  35 +++
 8 files changed, 631 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh


base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2149%2Fspkrka%2Fside-exhaust-pr-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2149/spkrka/side-exhaust-pr-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/2149

Range-diff vs v6:

  1:  5ef4f08105 !  1:  c1f303353c Documentation/technical: add paint-down-to-common doc
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +very small -- it only contains commits added since the last
      +commit-graph refresh.
      +
     ++With v1 commit-graphs (topological levels, no GDAT chunk),
     ++generation numbers saturate at `GENERATION_NUMBER_V1_MAX`.
     ++Saturated commits share the same generation value despite
     ++different topological depths, which breaks ordering guarantees
     ++in the same way as INFINITY. The early exit gates compare
     ++against `GENERATION_NUMBER_V1_MAX` for v1 graphs and
     ++`GENERATION_NUMBER_INFINITY` for v2 graphs, so that saturated
     ++commits are treated as unordered.
     ++
      +All reachable INFINITY-generation commits are visited before any
      +finite-generation commit, because INFINITY is larger than any finite
      +value. Once the walk crosses into the finite region, it stays there.
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +Generation cutoff
      +~~~~~~~~~~~~~~~~~
      +Some callers (notably `remove_redundant()`) supply a `min_generation`
     -+threshold -- the minimum generation of the input commits. No merge
     -+base can have a generation below this threshold, so the walk
     -+terminates as soon as it dequeues such a commit.
     ++threshold equal to the minimum generation of the input commits.
     ++These callers only need to determine reachability among the inputs,
     ++not find deep merge bases, so the walk can safely terminate when it
     ++dequeues a commit below this threshold.
      +
      +Single result
      +~~~~~~~~~~~~~
  2:  d0ee6d062e !  2:  57ecc0b18a test-lib-functions: improve diagnostic output for trace2 data assertions
     @@ t/test-lib-functions.sh: test_trace2_data () {
      +	fi &&
      +
      +	case "$actual" in
     -+	*"
     -+"*)
     ++	*"$LF"*)
      +		echo >&4 "error: trace2 data '$category/$key'$label_suffix has multiple entries, expected 1"
      +		printf '%s\n' "$actual" | sed 's/^/  actual:   /' >&4
      +		return 1
  3:  21ecf6dc34 =  3:  f857577e0c t6600: add test cases for side-exhaustion edge cases
  4:  d4ecf4b698 =  4:  e8565ce020 t6099, t6600: add side-exhaustion regression tests
  5:  9e76f5fb62 =  5:  490be76bef commit-reach: add trace2 instrumentation to paint_down_to_common()
  6:  171b3cd3ae =  6:  75d58639fc t6600: add clock-skew topologies and step counts for edge cases
  7:  92a327a94c =  7:  a1c8e89ef9 commit-reach: introduce struct paint_state with per-side counters
  8:  0d552869be =  8:  391fa07783 commit-reach: terminate merge-base walk when one paint side is exhausted
  9:  598a963375 =  9:  cd3273eb15 commit-reach: move min_generation check into paint_queue_get()
 10:  6d617da1f7 ! 10:  b655b24dc0 commit-reach: remove commit-date ordering fallback
     @@ Commit message
          while the queue was date-ordered, causing the early exit to fire
          before all merge bases were found.
      
     -    Also remove corrected_commit_dates_enabled() from commit-graph.c
     -    which has no remaining callers.
     +    For v1 commit-graphs where generation numbers saturate at
     +    GENERATION_NUMBER_V1_MAX, introduce a topological ceiling that
     +    the early exit gates compare against instead of
     +    GENERATION_NUMBER_INFINITY. This ensures saturated commits are
     +    treated as unordered, preventing premature termination when
     +    generation values are unreliable.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     @@ Documentation/technical/paint-down-to-common.adoc: descendant of this candidate
       ---------------------
       
      
     - ## commit-graph.c ##
     -@@ commit-graph.c: int generation_numbers_enabled(struct repository *r)
     - 	return !!first_generation;
     - }
     - 
     --int corrected_commit_dates_enabled(struct repository *r)
     --{
     --	struct commit_graph *g;
     --
     --	g = prepare_commit_graph(r);
     --	if (!g || !g->num_commits)
     --		return 0;
     --
     --	return g->read_generation_data;
     --}
     --
     - struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
     - {
     - 	struct commit_graph *g;
     -
     - ## commit-graph.h ##
     -@@ commit-graph.h: struct commit_graph *parse_commit_graph(struct repository *r,
     -  */
     - int generation_numbers_enabled(struct repository *r);
     - 
     --/*
     -- * Return 1 if and only if the repository has a commit-graph
     -- * file and generation data chunk has been written for the file.
     -- */
     --int corrected_commit_dates_enabled(struct repository *r);
     --
     - struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
     - 
     - enum commit_graph_write_flags {
     -
       ## commit-reach.c ##
      @@ commit-reach.c: struct paint_state {
       	size_t parent1_count;
     @@ commit-reach.c: struct paint_state {
      -	int gen_ordered;
       	timestamp_t min_generation;
       	timestamp_t last_gen;
     ++	timestamp_t topo_ceiling;
       };
     + 
     + static void paint_count_update(struct paint_state *state,
      @@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
       
       		/* one side is exhausted */
       		if ((!state->parent1_count || !state->parent2_count) &&
      -		    state->gen_ordered &&
     - 		    generation < GENERATION_NUMBER_INFINITY)
     +-		    generation < GENERATION_NUMBER_INFINITY)
     ++		    generation < state->topo_ceiling)
       			return NULL;
       	}
     + 
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				enum merge_base_flags mb_flags,
       				struct commit_list **result)
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
      -		state.queue.compare = compare_commits_by_commit_date;
      -		state.gen_ordered = 0;
      -	}
     ++	state.topo_ceiling = corrected_commit_dates_enabled(r)
     ++		? GENERATION_NUMBER_INFINITY
     ++		: GENERATION_NUMBER_V1_MAX;
       
       	one->object.flags |= PARENT1;
       	if (!n) {
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				 */
       				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
      -				    state.gen_ordered &&
     - 				    state.last_gen < GENERATION_NUMBER_INFINITY)
     +-				    state.last_gen < GENERATION_NUMBER_INFINITY)
     ++				    state.last_gen < state.topo_ceiling)
       					break;
       			}
     + 			/* Mark parents of a found merge stale */
      
       ## t/t6600-test-reach.sh ##
      @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-sides' '

-- 
gitgitgadget
