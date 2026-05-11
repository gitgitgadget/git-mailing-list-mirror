Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4339F17E
	for <git@vger.kernel.org>; Mon, 11 May 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504358; cv=none; b=Otr3q3N8I0jcs5Uvic4oeR5BywVkG43Rp0+MBjvi1kWprXL1Bg8bKgElkOMzy/IP9mmwnsy6SVjuhpGzUuEfpmahboveZTJ9FrwEe0vK2IMDB/ep9YLkRyVqUE9V0K0sudqT48SC/1TWRYUvXLPYNdZpVYGsHugz7f34OJIpl5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504358; c=relaxed/simple;
	bh=SCoER1qkxyouRsVrbFSaPwaq98iX1w8QJtTFAD5o4ug=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jIrWJ3M6LXItdK5AyWIiH3jEEf6A6JgTFzfWxHTrLJCaj/K6FqL2gTL9maVfSw2FpaakW/cv8j+dd5KC6ceQn9vWzH7F7Po1PUzZ64pgBxBjm8vTHCQGbXmbVmFklnF5E0M6aeVWo/kj0yM96St7KgXTI0El9SosDgPPbqFDM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+uTum1v; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+uTum1v"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f30a4601bbso4341305eec.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778504355; x=1779109155; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNdDjB/vTGZqWd8rZ6vdN7ZW9YtxklK1IG6H0CYe798=;
        b=g+uTum1vwMpYauyb35M8mk6x3HU4wBMBnNVZztS49MNH6l6F5et26/0l4RFt5gviph
         xU1MDpMWsmjEyMWDJ46AtLuckbLNh9EunVLuqHhPQVSDGPKoKqlm7zkyUqbKJ9gga26n
         Ya1uho4FHNPcQnanDL2e3VWxBBl9csXYo6Kw/ry7jVDmybHpeQar+rUnyE/PC2busMxu
         c2jbQrg0jbTEuFEncgw9JxFB5KlhltWB6IX5PQq8ABmUv3Olo6/HWf+du9il6lznVWKd
         AgDF3NCoFEFnLHcRyhYuQfus2aTZvgd0aFzyaj02uE8rvpFNVTj/8zBDFX7+X2Dn7Rdp
         MHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504355; x=1779109155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eNdDjB/vTGZqWd8rZ6vdN7ZW9YtxklK1IG6H0CYe798=;
        b=YHDUVih3QM51mEK0bdixYTsWxxR6XbM44RzGktlCN/F3ciKF+Ip8xtDDZgqL/iqj2U
         Widwa6qUy99uriRnlpBmVCDmEWm1LdsWiloapJE8oXjma6kl1IZ5FniS6sSVgIF1ScTz
         S4fqyGEONmE5/A/hIguOHDBuKnWpbMs5xuQjW74VsxT7Jw5aOJjvNYl/yuBvxyOevS8j
         o3ckaWbhWO9L75O0rc114AdAnnoFtG6mEh8zWIDAVqDyftlIF/kxUm7zHuiP0xpyA2te
         eOSrIxiHl718f/2uTceE3XsEdnIY6qfxs4TPCTcUm80p1WpnYtqLySUeBxz9WlQEFirn
         Bi/g==
X-Gm-Message-State: AOJu0YwF3ait+8N4rniWQ0x6E5dWR4REzrtSLn4qzmSEy4v+6pa5BABp
	Q7KSEW/4Rykc3XgBUFIF9F/OPQLycCZz5x2iVS7TPLaWibNEuG7mObkR/Zg6Jg==
X-Gm-Gg: Acq92OEMXgdwTPZpvS+ApHX8eeaWJfIOkmmU07lWD4/A3//yIoftgyX9onzhFJ+dwQN
	E/dj9mwtmEMX5y4fet0fNTy+1maChrnMCvsBs1zQqB9lsMTqOXrazivNKqMRax7N8PysQlKeEJD
	UrdiMcfxRK4dn4OLHNpLZDNTVMfCO767lFJxU+rjBeUwcKuxu6pulYHd87gY4I7viJmFPI/hVuA
	PeNDEZV2NGmz8CZAILO3IlTrL26Lpf6SK1ojfVyEErktX8jwJIRPVBE9txWrOVyHzx2CFaBEBIM
	ReAdEl4J04a/5YcPFHLjPBPzqeQ6NG2F4UQ4bNhQ//8kX0NNHtVnLYEn3bArFcUIQD7YWJJuo2r
	vXTAP41XwroXSNbfiLm5VhrlMDAqIAHkaH0EANWVp8FeLk601DJlML8BHLerUSfaNYojZc5BsT7
	FFGiCapITxi+hUA9YZwvcNxIDLGMJk7vQZQWI=
X-Received: by 2002:a05:7300:df4b:b0:2d2:129a:1694 with SMTP id 5a478bee46e88-2f54d79b993mr11173055eec.18.1778504354552;
        Mon, 11 May 2026 05:59:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.83])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm17652062eec.31.2026.05.11.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:59:13 -0700 (PDT)
Message-Id: <pull.2109.v4.git.1778504352.gitgitgadget@gmail.com>
In-Reply-To: <pull.2109.v3.git.1778498532730.gitgitgadget@gmail.com>
References: <pull.2109.v3.git.1778498532730.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 12:59:10 +0000
Subject: [PATCH v4 0/2] [RFC] commit-reach: skip STALE drain when only one merge-base needed
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>

Context for what this is all about.

I am working with a very large git monorepo and have been investigating
performance issues. After some digging I ended up looking more deeply into
git merge-base. I saw it had an --all parameter but the default is to only
return a single merge-base. Looking through the code and adding debug
timing, I realized that although the total time to compute the merge-base
was high, a very small amount of time was spent finding the initial
merge-base value that was later returned.

The optimization is actually quite dramatic in a large repo - runtime went
down from 5000ms to 50ms, so it's roughly a 100x optimization. This comes
from an exploding frontier of STALE commits to drain.

Thus, my idea is simply to return early from the function once we know what
will be returned. This only works if we find a candidate that we know will
not be pruned later - but fortunately if we have a commit graph with
generations we will visit commits in order such that it will actually not be
pruned.

CC: Derrick Stolee stolee@gmail.com

Changes since v1 (thanks Junio for the review):

 * Dropped the has_gens variable entirely. If a commit has a finite
   generation then it is in the commit-graph, and so are all its ancestors —
   no additional check is needed to know the queue ordering is sound.
   Without a commit-graph every commit gets INFINITY and the guard never
   fires. This also avoids the misleading interaction with callers that pass
   non-zero min_generation without having generation data.

 * Simplified the early exit guard from three conditions to two: !find_all
   && generation < GENERATION_NUMBER_INFINITY.

 * Fixed multi-line comment style per CodingGuidelines.

 * Replaced "dominate" with concrete reasoning about queue ordering.

 * Did not extract a helper function: after the simplifications above the
   inner block is four lines and reads naturally inline. The right boundary
   for a helper is not obvious (it could absorb just the result marking, or
   also the RESULT flag check, or also the PARENT1|PARENT2 test) and each
   level requires more local state passed by pointer. Happy to extract one
   if preferred.

Changes since v2 (thanks Patrick for the suggestion):

 * Split into two commits: the first is a pure refactoring that introduces
   enum merge_base_flags and replaces the boolean ignore_missing_commits
   parameter, the second adds the new MERGE_BASE_FIND_ALL flag and the early
   exit optimization.

 * Replaced the boolean find_all and ignore_missing_commits parameters in
   paint_down_to_common() with a single enum merge_base_flags mb_flags,
   reducing the function from 8 to 7 parameters. The enum is threaded
   through merge_bases_many(), get_merge_bases_many_0(), and the public
   repo_get_merge_bases_many_dirty() API.

 * Named the enum merge_base_flags rather than paint_down_to_common_flags
   since the flags express caller intent and are threaded through multiple
   layers including the public API.

 * Used mb_flags as the parameter name to avoid shadowing the existing local
   int flags (commit object flags) inside paint_down_to_common().

Kristofer Karlsson (2):
  commit-reach: introduce merge_base_flags enum
  commit-reach: early exit paint_down_to_common for single merge-base

 builtin/merge-base.c  |  4 +++-
 commit-reach.c        | 36 +++++++++++++++++++++++++++---------
 commit-reach.h        | 12 +++++++++++-
 t/t6600-test-reach.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 11 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2109%2Fspkrka%2Fmerge-base-early-exit-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2109/spkrka/merge-base-early-exit-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2109

Range-diff vs v3:

 1:  e4dada892f ! 1:  12d9e1c85f commit-reach: early exit paint_down_to_common for single merge-base
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    commit-reach: early exit paint_down_to_common for single merge-base
     +    commit-reach: introduce merge_base_flags enum
      
     -    Commits not in the commit-graph get GENERATION_NUMBER_INFINITY and
     -    sort to the top of the priority queue.  After those, commits with
     -    finite generation numbers are popped in non-increasing order.
     -    When MERGE_BASE_FIND_ALL is not set the first doubly-painted commit
     -    with a finite generation is therefore a best merge-base: no commit
     -    still in the queue can be a descendant of it.  Skip the expensive
     -    STALE drain in this case.
     +    Replace the boolean ignore_missing_commits parameter in
     +    paint_down_to_common() with an enum merge_base_flags, and thread
     +    the flags through merge_bases_many(), get_merge_bases_many_0(),
     +    and the public repo_get_merge_bases_many_dirty() API.
      
     -    Introduce enum merge_base_flags with MERGE_BASE_FIND_ALL and
     -    MERGE_BASE_IGNORE_MISSING_COMMITS, replacing the two boolean
     -    parameters in paint_down_to_common().  Thread the flags through
     -    merge_bases_many(), get_merge_bases_many_0(), and the public
     -    repo_get_merge_bases_many_dirty() API.  git merge-base (without
     -    --all) passes 0, triggering the early exit.
     +    This makes callsites with boolean parameters easier to read and
     +    prepares the function for additional flags in a subsequent commit.
      
     -    On a 2.2M-commit merge-heavy monorepo with commit-graph:
     -
     -      HEAD vs ~500:   5,229ms -> 24ms
     -      HEAD vs ~1000:  4,214ms -> 39ms
     -      HEAD vs ~5000:  3,799ms -> 46ms
     -      HEAD vs ~10000: 3,827ms -> 61ms
     +    No functional change: the single caller that used
     +    ignore_missing_commits (repo_in_merge_bases_many) now sets
     +    MERGE_BASE_IGNORE_MISSING_COMMITS in the flags word, and all
     +    other callers pass 0.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## builtin/merge-base.c ##
     -@@
     - 
     - static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
     - {
     -+	enum merge_base_flags flags = show_all ? MERGE_BASE_FIND_ALL : 0;
     +@@ builtin/merge-base.c: static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
       	struct commit_list *result = NULL, *r;
       
       	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
      -					    rev_nr - 1, rev + 1, &result) < 0) {
      +					    rev_nr - 1, rev + 1,
     -+					    flags, &result) < 0) {
     ++					    0, &result) < 0) {
       		commit_list_free(result);
       		return -1;
       	}
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				struct commit_list **result)
       {
       	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     -@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     - 			if (!(commit->object.flags & RESULT)) {
     - 				commit->object.flags |= RESULT;
     - 				tail = commit_list_append(commit, tail);
     -+				/*
     -+				 * The queue is generation-ordered; no
     -+				 * remaining common ancestor can be a
     -+				 * descendant of this one.
     -+				 */
     -+				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
     -+				    generation < GENERATION_NUMBER_INFINITY)
     -+					break;
     - 			}
     - 			/* Mark parents of a found merge stale */
     - 			flags |= STALE;
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				 * corrupt commits would already have been
       				 * dispatched with a `die()`.
     @@ commit-reach.c: static int merge_bases_many(struct repository *r,
       		commit_list_free(list);
       		return -1;
       	}
     -@@ commit-reach.c: static int remove_redundant_no_gen(struct repository *r,
     - 				min_generation = curr_generation;
     - 		}
     - 		if (paint_down_to_common(r, array[i], filled,
     --					 work, min_generation, 0, &common)) {
     -+					 work, min_generation,
     -+					 MERGE_BASE_FIND_ALL, &common)) {
     - 			clear_commit_marks(array[i], all_flags);
     - 			clear_commit_marks_many(filled, work, all_flags);
     - 			commit_list_free(common);
      @@ commit-reach.c: static int get_merge_bases_many_0(struct repository *r,
       				  size_t n,
       				  struct commit **twos,
     @@ commit-reach.c: int repo_get_merge_bases_many(struct repository *r,
       			      struct commit_list **result)
       {
      -	return get_merge_bases_many_0(r, one, n, twos, 1, result);
     -+	return get_merge_bases_many_0(r, one, n, twos, 1,
     -+				     MERGE_BASE_FIND_ALL, result);
     ++	return get_merge_bases_many_0(r, one, n, twos, 1, 0, result);
       }
       
       int repo_get_merge_bases_many_dirty(struct repository *r,
     @@ commit-reach.c: int repo_get_merge_bases(struct repository *r,
       			 struct commit_list **result)
       {
      -	return get_merge_bases_many_0(r, one, 1, &two, 1, result);
     -+	return get_merge_bases_many_0(r, one, 1, &two, 1,
     -+				     MERGE_BASE_FIND_ALL, result);
     ++	return get_merge_bases_many_0(r, one, 1, &two, 1, 0, result);
       }
       
       /*
     @@ commit-reach.c: int repo_in_merge_bases_many(struct repository *r, struct commit
       	struct commit_list *bases = NULL;
       	int ret = 0, i;
       	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
     -+	enum merge_base_flags mb_flags = MERGE_BASE_FIND_ALL;
     ++	enum merge_base_flags mb_flags = 0;
      +
      +	if (ignore_missing_commits)
      +		mb_flags |= MERGE_BASE_IGNORE_MISSING_COMMITS;
     @@ commit-reach.h: int repo_get_merge_bases_many(struct repository *r,
       			      struct commit *one, size_t n,
       			      struct commit **twos,
       			      struct commit_list **result);
     --/* To be used only when object flags after this call no longer matter */
      +enum merge_base_flags {
     -+	MERGE_BASE_FIND_ALL               = (1 << 0),
     -+	MERGE_BASE_IGNORE_MISSING_COMMITS = (1 << 1),
     ++	MERGE_BASE_IGNORE_MISSING_COMMITS = (1 << 0),
      +};
      +
     -+/*
     -+ * To be used only when object flags after this call no longer matter.
     -+ * Without MERGE_BASE_FIND_ALL and with generation numbers available,
     -+ * returns after finding the first merge-base, skipping the STALE drain.
     -+ */
     + /* To be used only when object flags after this call no longer matter */
       int repo_get_merge_bases_many_dirty(struct repository *r,
       				    struct commit *one, size_t n,
       				    struct commit **twos,
     @@ commit-reach.h: int repo_get_merge_bases_many(struct repository *r,
       				    struct commit_list **result);
       
       int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result);
     -
     - ## t/t6010-merge-base.sh ##
     -@@ t/t6010-merge-base.sh: test_expect_success 'merge-base --octopus --all for complex tree' '
     - 	test_cmp expected actual
     - '
     - 
     -+# The following tests verify that "git merge-base" (without --all)
     -+# returns the same result with and without a commit-graph.
     -+# This exercises the early-exit optimisation in paint_down_to_common
     -+# that skips the STALE drain when generation numbers are available.
     -+
     -+test_expect_success 'setup for commit-graph tests' '
     -+	git init graph-repo &&
     -+	(
     -+		cd graph-repo &&
     -+
     -+		# Build a forked DAG:
     -+		#
     -+		#     L1---L2  (left)
     -+		#    /
     -+		#   S
     -+		#    \
     -+		#     R1---R2  (right)
     -+		#
     -+		test_commit GS &&
     -+		git checkout -b left &&
     -+		test_commit L1 &&
     -+		test_commit L2 &&
     -+		git checkout GS &&
     -+		git checkout -b right &&
     -+		test_commit GR1 &&
     -+		test_commit GR2
     -+	)
     -+'
     -+
     -+test_expect_success 'merge-base without commit-graph' '
     -+	(
     -+		cd graph-repo &&
     -+		rm -f .git/objects/info/commit-graph &&
     -+		git merge-base left right >actual &&
     -+		git rev-parse GS >expected &&
     -+		test_cmp expected actual
     -+	)
     -+'
     -+
     -+test_expect_success 'merge-base with commit-graph' '
     -+	(
     -+		cd graph-repo &&
     -+		git commit-graph write --reachable &&
     -+		git merge-base left right >actual &&
     -+		git rev-parse GS >expected &&
     -+		test_cmp expected actual
     -+	)
     -+'
     -+
     -+test_expect_success 'merge-base --all with commit-graph' '
     -+	(
     -+		cd graph-repo &&
     -+		git merge-base --all left right >actual &&
     -+		git rev-parse GS >expected &&
     -+		test_cmp expected actual
     -+	)
     -+'
     -+
     -+test_expect_success 'merge-base agrees with --all for single result' '
     -+	(
     -+		cd graph-repo &&
     -+		git commit-graph write --reachable &&
     -+		git merge-base left right >actual.single &&
     -+		git merge-base --all left right >actual.all &&
     -+		test_cmp actual.all actual.single
     -+	)
     -+'
     -+
     -+test_expect_success 'setup for deep chain commit-graph test' '
     -+	git init deep-repo &&
     -+	(
     -+		cd deep-repo &&
     -+
     -+		# Build a deep forked DAG:
     -+		#
     -+		#   L1--L2--...--L20  (left)
     -+		#  /
     -+		# S
     -+		#  \
     -+		#   R1--R2--...--R20  (right)
     -+		#
     -+		test_commit DS &&
     -+		git checkout -b left &&
     -+		for i in $(test_seq 1 20)
     -+		do
     -+			test_commit DL$i || return 1
     -+		done &&
     -+		git checkout DS &&
     -+		git checkout -b right &&
     -+		for i in $(test_seq 1 20)
     -+		do
     -+			test_commit DR$i || return 1
     -+		done
     -+	)
     -+'
     -+
     -+test_expect_success 'deep chain: merge-base matches with and without commit-graph' '
     -+	(
     -+		cd deep-repo &&
     -+		rm -f .git/objects/info/commit-graph &&
     -+		git merge-base left right >actual.no-graph &&
     -+		git rev-parse DS >expected &&
     -+		test_cmp expected actual.no-graph &&
     -+		git commit-graph write --reachable &&
     -+		git merge-base left right >actual.graph &&
     -+		test_cmp expected actual.graph
     -+	)
     -+'
     -+
     -+test_expect_success 'deep chain: --all and non---all agree with commit-graph' '
     -+	(
     -+		cd deep-repo &&
     -+		git commit-graph write --reachable &&
     -+		git merge-base left right >actual.single &&
     -+		git merge-base --all left right >actual.all &&
     -+		test_cmp actual.all actual.single
     -+	)
     -+'
     -+
     - test_done
     -
     - ## t/t6600-test-reach.sh ##
     -@@ t/t6600-test-reach.sh: test_expect_success 'rev-list --maximal-only matches merge-base --independent' '
     - 	test_cmp expect.sorted actual.sorted
     - '
     - 
     -+# The following tests verify the early-exit optimisation in
     -+# paint_down_to_common when merge-base is invoked without --all.
     -+# Each test checks all four commit-graph configurations.
     -+
     -+merge_base_all_modes () {
     -+	test_when_finished rm -rf .git/objects/info/commit-graph &&
     -+	git merge-base "$@" >actual &&
     -+	test_cmp expect actual &&
     -+	cp commit-graph-full .git/objects/info/commit-graph &&
     -+	git merge-base "$@" >actual &&
     -+	test_cmp expect actual &&
     -+	cp commit-graph-half .git/objects/info/commit-graph &&
     -+	git merge-base "$@" >actual &&
     -+	test_cmp expect actual &&
     -+	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
     -+	git merge-base "$@" >actual &&
     -+	test_cmp expect actual
     -+}
     -+
     -+test_expect_success 'merge-base without --all (unique base)' '
     -+	git rev-parse commit-5-3 >expect &&
     -+	merge_base_all_modes commit-5-7 commit-8-3
     -+'
     -+
     -+test_expect_success 'merge-base without --all is one of --all results' '
     -+	test_when_finished rm -rf .git/objects/info/commit-graph &&
     -+
     -+	cp commit-graph-full .git/objects/info/commit-graph &&
     -+	git merge-base --all commit-5-7 commit-4-8 commit-6-6 commit-8-3 >all &&
     -+	git merge-base commit-5-7 commit-4-8 commit-6-6 commit-8-3 >single &&
     -+	test_line_count = 1 single &&
     -+	grep -F -f single all &&
     -+
     -+	cp commit-graph-half .git/objects/info/commit-graph &&
     -+	git merge-base --all commit-5-7 commit-4-8 commit-6-6 commit-8-3 >all &&
     -+	git merge-base commit-5-7 commit-4-8 commit-6-6 commit-8-3 >single &&
     -+	test_line_count = 1 single &&
     -+	grep -F -f single all
     -+'
     -+
     - test_done
 -:  ---------- > 2:  19f1605067 commit-reach: early exit paint_down_to_common for single merge-base

-- 
gitgitgadget
