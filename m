Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820822C234E
	for <git@vger.kernel.org>; Mon, 11 May 2026 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480353; cv=none; b=Ec8jmGaNh9QiC3LOJdIUW7QHivGPWXrg3IIcbe6e0dwRFOopqMg81BjzRiEXosuxNp7h+GaksbB5mDTCYeGfoR/RwWDq0gPboAeuQ+UYWHQsvIVHTxiV1+KqobO8c/Qa0KFaSLExiat4wuP3Ao+k/CMbeFoffbw9WiAwJthnx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480353; c=relaxed/simple;
	bh=btvZh4PZ8ryqZ1/tEc8j3wmiEexyQL0QqLJ2h/no300=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ABSnZBVxkAKuPViKxduV7GpdUL6JOSaDgsjunQXE5J87Llp2Oxq++88TNl9+7QohGeDFuQOr1yNGxY3y/mY7dloFo+4acA2sUI3KhITCUbGkItP00PyCgYIpj2gpPSEMbuX/I5vLeIEVDYvK+tdcB2oPCPxbfc+FPSpiSr/kUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP5W4LX6; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP5W4LX6"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f68f3b075fso4627839eec.0
        for <git@vger.kernel.org>; Sun, 10 May 2026 23:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778480350; x=1779085150; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3/UK3Qo6nBNpUk8hK+r49kmIYCM9HqQ5kyCaICWm0M=;
        b=OP5W4LX611i8EC6emsHm/t7vfN2oB5VFNgcZjqYYVf0YjjuX8OuNdx7zte4IZGgtPD
         8E/rLZHTwvgu2QgcFCzvrt2HT24tgPI/KVUlQrfdsqbXYRdqoqXtTNMiAndU5fVVoYnb
         HnLH7gLOgMkUNbTR+M5VP1D88MvtnbI1j3/QmKbneEM7DTzD3f4OWD6PZiupoyGq0mZK
         l6yAoPA2IG0I3nd1A9wzG2qoHY921Flqaz4ziYGxca8vv4Ds7S6B4dyiG/4rUzg3bA5e
         GmLKAyH35JVD+gqeuzGGLrcAN2U8YKedgE5eWep9A4S8vIy9j0uTrfLHa+W+hH5wArwx
         pyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778480350; x=1779085150;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n3/UK3Qo6nBNpUk8hK+r49kmIYCM9HqQ5kyCaICWm0M=;
        b=ky3IjFyLEHXukn23PGo8VIUZKitA2wvGN5cY7uLkarLi0CyvFhTgtksbLaYBRcGmkT
         yS0lLn7BGjkVGHFyap6Nb+Ti8KovAOGcee+GUnDWAKGwXqpr3ei40B1zK/HFBt4S05xG
         10vuxWh9kGUqcnhfJDPPGmZNUhp9oYq8QFZ9wJxGx86tdpjCDKTu4m1341EojKc8eHW1
         AhBaix12MoRYc/OwHNqIqEv9kYUpiQtAX54iNNPyY4OotrbDzQcGr79AEF+hBsD09Zj2
         rX5fHemJbdEMajkF8cKW7q6Rfa07t1Em6h8bFC2Y4ozxKHABmy4J07ug1Mw1I2+K1ErM
         44Ig==
X-Gm-Message-State: AOJu0YyDyWT893aIESGE7CDND8T454E1rA88YhhMMiDcZTzjmDF7IrQh
	pJrwowGCN7pLJ93Jlq5leUy8d5hQL046UIby7ssj4VBG+KMGGKaz7LbcQKt8jA==
X-Gm-Gg: Acq92OEeIXAM63RSEz8OkQR7pS+SrJk1vsixm1g0WM6U8LC5JoLU4InKaPA7Fu3wRZS
	KHy+FKPYHh2qHK0NWilEjsE/B4H3FaIY4wnDbWso/yqcnuqr5jnnK7RPo4cLOyPrR5YPQDMJMmf
	JNg9jBFoYNEHlBNJzvvDhMmpEl6iue0/82C+8CMv0tQe4vwStNn3WDHU/Pdz/Iri0CquIK0TNgG
	XfL7lVYFoQimub/3IbW6jmsnH1NO11F+VGI8e5cF3qRK40VMV5QQoE+vvvjZaOkzwRLJQVG+KTC
	tjN6TC4ajACeI63vMrMykwGg+R4DJLhefz87+u00SlcHGcsTboGymqT40erlwjw4NTE7Wsq17kY
	erSCNjcFhxGfi0PnLigE9Yt/H4V88xX5l1HRum5pcfmdaVQiMSBgQRv+BvBqF4TXCTOJV54erEs
	l/2L9HQDFVZQaigVleS8vrJ30=
X-Received: by 2002:a05:693c:2b15:b0:2d9:6373:ad22 with SMTP id 5a478bee46e88-2f85c07f8bfmr5652069eec.12.1778480349842;
        Sun, 10 May 2026 23:19:09 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.58.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8884752ccsm11926576eec.17.2026.05.10.23.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:19:09 -0700 (PDT)
Message-Id: <pull.2109.v2.git.1778480348118.gitgitgadget@gmail.com>
In-Reply-To: <pull.2109.git.1778252837132.gitgitgadget@gmail.com>
References: <pull.2109.git.1778252837132.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 06:19:08 +0000
Subject: [PATCH v2] commit-reach: early exit paint_down_to_common for single
 merge-base
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Commits not in the commit-graph get GENERATION_NUMBER_INFINITY and
sort to the top of the priority queue.  After those, commits with
finite generation numbers are popped in non-increasing order.
When find_all is false the first doubly-painted commit with a
finite generation is therefore a best merge-base: no commit still
in the queue can be a descendant of it.  Skip the expensive STALE
drain in this case.

Add find_all parameter to repo_get_merge_bases_many_dirty() and
thread it through to paint_down_to_common().  git merge-base
(without --all) passes show_all=0, triggering the early exit.

On a 2.2M-commit merge-heavy monorepo with commit-graph:

  HEAD vs ~500:   5,229ms -> 24ms
  HEAD vs ~1000:  4,214ms -> 39ms
  HEAD vs ~5000:  3,799ms -> 46ms
  HEAD vs ~10000: 3,827ms -> 61ms

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    [RFC] commit-reach: skip STALE drain when only one merge-base needed
    
    Context for what this is all about.
    
    I am working with a very large git monorepo and have been investigating
    performance issues. After some digging I ended up looking more deeply
    into git merge-base. I saw it had an --all parameter but the default is
    to only return a single merge-base. Looking through the code and adding
    debug timing, I realized that although the total time to compute the
    merge-base was high, a very small amount of time was spent finding the
    initial merge-base value that was later returned.
    
    The optimization is actually quite dramatic in a large repo - runtime
    went down from 5000ms to 50ms, so it's roughly a 100x optimization. This
    comes from an exploding frontier of STALE commits to drain.
    
    Thus, my idea is simply to return early from the function once we know
    what will be returned. This only works if we find a candidate that we
    know will not be pruned later - but fortunately if we have a commit
    graph with generations we will visit commits in order such that it will
    actually not be pruned.
    
    CC: Derrick Stolee stolee@gmail.com
    
    Changes since v1 (thanks Junio for the review):
    
     * Dropped the has_gens variable entirely. If a commit has a finite
       generation then it is in the commit-graph, and so are all its
       ancestors — no additional check is needed to know the queue ordering
       is sound. Without a commit-graph every commit gets INFINITY and the
       guard never fires. This also avoids the misleading interaction with
       callers that pass non-zero min_generation without having generation
       data.
    
     * Simplified the early exit guard from three conditions to two:
       !find_all && generation < GENERATION_NUMBER_INFINITY.
    
     * Fixed multi-line comment style per CodingGuidelines.
    
     * Replaced "dominate" with concrete reasoning about queue ordering.
    
     * Did not extract a helper function: after the simplifications above
       the inner block is four lines and reads naturally inline. The right
       boundary for a helper is not obvious (it could absorb just the result
       marking, or also the RESULT flag check, or also the PARENT1|PARENT2
       test) and each level requires more local state passed by pointer.
       Happy to extract one if preferred.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2109%2Fspkrka%2Fmerge-base-early-exit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2109/spkrka/merge-base-early-exit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2109

Range-diff vs v1:

 1:  54cdf9bfd9 ! 1:  f7b5c267f3 commit-reach: early exit paint_down_to_common for single merge-base
     @@ Metadata
       ## Commit message ##
          commit-reach: early exit paint_down_to_common for single merge-base
      
     -    When find_all is false and generation numbers are available, the
     -    priority queue pops in non-increasing generation order.  The first
     -    doubly-painted commit is a valid best merge-base; no later commit
     -    can dominate it.  Skip the expensive STALE drain in this case.
     -
     -    The early exit is guarded by three conditions: find_all must be
     -    false, the commit-graph must provide generation numbers, and the
     -    merge-base commit itself must have a finite generation (not
     -    GENERATION_NUMBER_INFINITY from being outside the commit-graph).
     +    Commits not in the commit-graph get GENERATION_NUMBER_INFINITY and
     +    sort to the top of the priority queue.  After those, commits with
     +    finite generation numbers are popped in non-increasing order.
     +    When find_all is false the first doubly-painted commit with a
     +    finite generation is therefore a best merge-base: no commit still
     +    in the queue can be a descendant of it.  Skip the expensive STALE
     +    drain in this case.
      
          Add find_all parameter to repo_get_merge_bases_many_dirty() and
          thread it through to paint_down_to_common().  git merge-base
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				struct commit_list **result)
       {
       	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     - 	int i;
     -+	int has_gens = min_generation || corrected_commit_dates_enabled(r);
     - 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
     - 	struct commit_list **tail = result;
     - 
     --	if (!min_generation && !corrected_commit_dates_enabled(r))
     -+	if (!has_gens)
     - 		queue.compare = compare_commits_by_commit_date;
     - 
     - 	one->object.flags |= PARENT1;
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       			if (!(commit->object.flags & RESULT)) {
       				commit->object.flags |= RESULT;
       				tail = commit_list_append(commit, tail);
     -+				/* Generation-ordered queue: no later
     -+				 * commit can dominate this one. */
     -+				if (!find_all && has_gens &&
     ++				/*
     ++				 * The queue is generation-ordered; no
     ++				 * remaining common ancestor can be a
     ++				 * descendant of this one.
     ++				 */
     ++				if (!find_all &&
      +				    generation < GENERATION_NUMBER_INFINITY)
      +					break;
       			}
     @@ commit-reach.h: int repo_get_merge_bases_many(struct repository *r,
       			      struct commit **twos,
       			      struct commit_list **result);
      -/* To be used only when object flags after this call no longer matter */
     -+/* To be used only when object flags after this call no longer matter.
     ++/*
     ++ * To be used only when object flags after this call no longer matter.
      + * When find_all is false and generation numbers are available, returns
     -+ * after finding the first merge-base, skipping the STALE drain. */
     ++ * after finding the first merge-base, skipping the STALE drain.
     ++ */
       int repo_get_merge_bases_many_dirty(struct repository *r,
       				    struct commit *one, size_t n,
       				    struct commit **twos,


 builtin/merge-base.c  |   3 +-
 commit-reach.c        |  26 ++++++---
 commit-reach.h        |   7 ++-
 t/t6010-merge-base.sh | 119 ++++++++++++++++++++++++++++++++++++++++++
 t/t6600-test-reach.sh |  40 ++++++++++++++
 5 files changed, 186 insertions(+), 9 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index c7ee97fa6a..6b9d42f596 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -14,7 +14,8 @@ static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
 	struct commit_list *result = NULL, *r;
 
 	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
-					    rev_nr - 1, rev + 1, &result) < 0) {
+					    rev_nr - 1, rev + 1,
+					    show_all, &result) < 0) {
 		commit_list_free(result);
 		return -1;
 	}
diff --git a/commit-reach.c b/commit-reach.c
index d3a9b3ed6f..b4ca00bb7e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -55,6 +55,7 @@ static int paint_down_to_common(struct repository *r,
 				struct commit **twos,
 				timestamp_t min_generation,
 				int ignore_missing_commits,
+				int find_all,
 				struct commit_list **result)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
@@ -97,6 +98,14 @@ static int paint_down_to_common(struct repository *r,
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |= RESULT;
 				tail = commit_list_append(commit, tail);
+				/*
+				 * The queue is generation-ordered; no
+				 * remaining common ancestor can be a
+				 * descendant of this one.
+				 */
+				if (!find_all &&
+				    generation < GENERATION_NUMBER_INFINITY)
+					break;
 			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
@@ -136,6 +145,7 @@ static int paint_down_to_common(struct repository *r,
 static int merge_bases_many(struct repository *r,
 			    struct commit *one, int n,
 			    struct commit **twos,
+			    int find_all,
 			    struct commit_list **result)
 {
 	struct commit_list *list = NULL, **tail = result;
@@ -165,7 +175,7 @@ static int merge_bases_many(struct repository *r,
 				     oid_to_hex(&twos[i]->object.oid));
 	}
 
-	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
+	if (paint_down_to_common(r, one, n, twos, 0, 0, find_all, &list)) {
 		commit_list_free(list);
 		return -1;
 	}
@@ -246,7 +256,7 @@ static int remove_redundant_no_gen(struct repository *r,
 				min_generation = curr_generation;
 		}
 		if (paint_down_to_common(r, array[i], filled,
-					 work, min_generation, 0, &common)) {
+					 work, min_generation, 0, 1, &common)) {
 			clear_commit_marks(array[i], all_flags);
 			clear_commit_marks_many(filled, work, all_flags);
 			commit_list_free(common);
@@ -425,6 +435,7 @@ static int get_merge_bases_many_0(struct repository *r,
 				  size_t n,
 				  struct commit **twos,
 				  int cleanup,
+				  int find_all,
 				  struct commit_list **result)
 {
 	struct commit_list *list, **tail = result;
@@ -432,7 +443,7 @@ static int get_merge_bases_many_0(struct repository *r,
 	size_t cnt, i;
 	int ret;
 
-	if (merge_bases_many(r, one, n, twos, result) < 0)
+	if (merge_bases_many(r, one, n, twos, find_all, result) < 0)
 		return -1;
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
@@ -475,16 +486,17 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit **twos,
 			      struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 1, result);
+	return get_merge_bases_many_0(r, one, n, twos, 1, 1, result);
 }
 
 int repo_get_merge_bases_many_dirty(struct repository *r,
 				    struct commit *one,
 				    size_t n,
 				    struct commit **twos,
+				    int find_all,
 				    struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 0, result);
+	return get_merge_bases_many_0(r, one, n, twos, 0, find_all, result);
 }
 
 int repo_get_merge_bases(struct repository *r,
@@ -492,7 +504,7 @@ int repo_get_merge_bases(struct repository *r,
 			 struct commit *two,
 			 struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, 1, &two, 1, result);
+	return get_merge_bases_many_0(r, one, 1, &two, 1, 1, result);
 }
 
 /*
@@ -555,7 +567,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 
 	if (paint_down_to_common(r, commit,
 				 nr_reference, reference,
-				 generation, ignore_missing_commits, &bases))
+				 generation, ignore_missing_commits, 1, &bases))
 		ret = -1;
 	else if (commit->object.flags & PARENT2)
 		ret = 1;
diff --git a/commit-reach.h b/commit-reach.h
index 6012402dfc..c3b570a5cc 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -17,10 +17,15 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit *one, size_t n,
 			      struct commit **twos,
 			      struct commit_list **result);
-/* To be used only when object flags after this call no longer matter */
+/*
+ * To be used only when object flags after this call no longer matter.
+ * When find_all is false and generation numbers are available, returns
+ * after finding the first merge-base, skipping the STALE drain.
+ */
 int repo_get_merge_bases_many_dirty(struct repository *r,
 				    struct commit *one, size_t n,
 				    struct commit **twos,
+				    int find_all,
 				    struct commit_list **result);
 
 int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result);
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 44c726ea39..f6c85d4f53 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -305,4 +305,123 @@ test_expect_success 'merge-base --octopus --all for complex tree' '
 	test_cmp expected actual
 '
 
+# The following tests verify that "git merge-base" (without --all)
+# returns the same result with and without a commit-graph.
+# This exercises the early-exit optimisation in paint_down_to_common
+# that skips the STALE drain when generation numbers are available.
+
+test_expect_success 'setup for commit-graph tests' '
+	git init graph-repo &&
+	(
+		cd graph-repo &&
+
+		# Build a forked DAG:
+		#
+		#     L1---L2  (left)
+		#    /
+		#   S
+		#    \
+		#     R1---R2  (right)
+		#
+		test_commit GS &&
+		git checkout -b left &&
+		test_commit L1 &&
+		test_commit L2 &&
+		git checkout GS &&
+		git checkout -b right &&
+		test_commit GR1 &&
+		test_commit GR2
+	)
+'
+
+test_expect_success 'merge-base without commit-graph' '
+	(
+		cd graph-repo &&
+		rm -f .git/objects/info/commit-graph &&
+		git merge-base left right >actual &&
+		git rev-parse GS >expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'merge-base with commit-graph' '
+	(
+		cd graph-repo &&
+		git commit-graph write --reachable &&
+		git merge-base left right >actual &&
+		git rev-parse GS >expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'merge-base --all with commit-graph' '
+	(
+		cd graph-repo &&
+		git merge-base --all left right >actual &&
+		git rev-parse GS >expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'merge-base agrees with --all for single result' '
+	(
+		cd graph-repo &&
+		git commit-graph write --reachable &&
+		git merge-base left right >actual.single &&
+		git merge-base --all left right >actual.all &&
+		test_cmp actual.all actual.single
+	)
+'
+
+test_expect_success 'setup for deep chain commit-graph test' '
+	git init deep-repo &&
+	(
+		cd deep-repo &&
+
+		# Build a deep forked DAG:
+		#
+		#   L1--L2--...--L20  (left)
+		#  /
+		# S
+		#  \
+		#   R1--R2--...--R20  (right)
+		#
+		test_commit DS &&
+		git checkout -b left &&
+		for i in $(test_seq 1 20)
+		do
+			test_commit DL$i || return 1
+		done &&
+		git checkout DS &&
+		git checkout -b right &&
+		for i in $(test_seq 1 20)
+		do
+			test_commit DR$i || return 1
+		done
+	)
+'
+
+test_expect_success 'deep chain: merge-base matches with and without commit-graph' '
+	(
+		cd deep-repo &&
+		rm -f .git/objects/info/commit-graph &&
+		git merge-base left right >actual.no-graph &&
+		git rev-parse DS >expected &&
+		test_cmp expected actual.no-graph &&
+		git commit-graph write --reachable &&
+		git merge-base left right >actual.graph &&
+		test_cmp expected actual.graph
+	)
+'
+
+test_expect_success 'deep chain: --all and non---all agree with commit-graph' '
+	(
+		cd deep-repo &&
+		git commit-graph write --reachable &&
+		git merge-base left right >actual.single &&
+		git merge-base --all left right >actual.all &&
+		test_cmp actual.all actual.single
+	)
+'
+
 test_done
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index dc0421ed2f..51c23b7683 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -882,4 +882,44 @@ test_expect_success 'rev-list --maximal-only matches merge-base --independent' '
 	test_cmp expect.sorted actual.sorted
 '
 
+# The following tests verify the early-exit optimisation in
+# paint_down_to_common when merge-base is invoked without --all.
+# Each test checks all four commit-graph configurations.
+
+merge_base_all_modes () {
+	test_when_finished rm -rf .git/objects/info/commit-graph &&
+	git merge-base "$@" >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-full .git/objects/info/commit-graph &&
+	git merge-base "$@" >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-half .git/objects/info/commit-graph &&
+	git merge-base "$@" >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
+	git merge-base "$@" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'merge-base without --all (unique base)' '
+	git rev-parse commit-5-3 >expect &&
+	merge_base_all_modes commit-5-7 commit-8-3
+'
+
+test_expect_success 'merge-base without --all is one of --all results' '
+	test_when_finished rm -rf .git/objects/info/commit-graph &&
+
+	cp commit-graph-full .git/objects/info/commit-graph &&
+	git merge-base --all commit-5-7 commit-4-8 commit-6-6 commit-8-3 >all &&
+	git merge-base commit-5-7 commit-4-8 commit-6-6 commit-8-3 >single &&
+	test_line_count = 1 single &&
+	grep -F -f single all &&
+
+	cp commit-graph-half .git/objects/info/commit-graph &&
+	git merge-base --all commit-5-7 commit-4-8 commit-6-6 commit-8-3 >all &&
+	git merge-base commit-5-7 commit-4-8 commit-6-6 commit-8-3 >single &&
+	test_line_count = 1 single &&
+	grep -F -f single all
+'
+
 test_done

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
