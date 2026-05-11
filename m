Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C521351C1E
	for <git@vger.kernel.org>; Mon, 11 May 2026 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498539; cv=none; b=UcfUxuWmtIdhIDbPmD9iKqcQsK1YDSVvAwzWy0QldENI9QMM80Ak/LoXJAWJczwtNrPCvjEXG28Se1wEjmKvJT2+IpNfuuA4YhxLoIH0btTdp/DnIW1dRWCHQlL2+L9HHetAQ6HEyxzX7yc+VSd5GeU2BA9OySKlWdPr1HIJB3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498539; c=relaxed/simple;
	bh=is1PGenRq3aOD8SvcnLxXKZC28+/UwDdkcPVyvgCCv8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KsbGFXwrcWvyWochbW+7hfk5rglV0o7mMGMFsxy3RIJekeFGFkjafRnewUgGSv1eYl8xRtFP8b23CoeXE79WQBj1cypL7Xqpo0As9rRHrrgj1qy07tJaDQgXXZ02DK1NaObBhZN7DA7oxMcU2zSLgVEfAHIBrn715tgbo27IXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMSURyJb; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMSURyJb"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1309f4ee97fso5061022c88.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778498536; x=1779103336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+b7V6XTVb8jCI5vzX4igcV1RAzsQpoDFSsk3fYE5Nk=;
        b=mMSURyJbbj5+WS3xK05+JvOhANApdMeBm+kp8zOzy7aanxgSMNM8eAaZv1Q2LzPNey
         om1Yxj+VBCwRrnBsax9c+r2MhSUDLZ2EIsrCdAxxth7BvrqDMiWZlAHfG5ItecGY4wJU
         gwKZDYbPgq1W/46+snSdK5c96cXdYLSVJd4StO0yBbFjHQfts/VtLhRTWhXzvHEsfQH4
         iTBe3SpnZTBDXl4jiXPu7fg+Bma2uoR4TUZvb0E8KLvCXBErm+Spxok4PmAP/zFTxZB/
         Os5PamIjvdN4wPG5HEiegKeoLi+mWEOFQIFMQgD/+2tZToa32WRG2cqfMKA7myHy+ElZ
         unIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778498536; x=1779103336;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+b7V6XTVb8jCI5vzX4igcV1RAzsQpoDFSsk3fYE5Nk=;
        b=muWupsLkdcRB37wAPWmtZHzl9ha5cnJHnnLerusDNmsLDWJTUWekCwN2b2yTX4zMyk
         pWB2MDmVhcCWDSfYm5Ot6veYZqPVkcsj05K+ceovfF2LsHshbZaC9UM4a+/M+FIsbyiT
         db+uqv2GWf53CsOXVPDkm2p6l/6ymUDDr7CUkI+OEdQyupyOlrje4FEBoRxc0oCkBPPA
         mCtbAQXs8Z4ZS55Ji4DDPHydRTPKBe04OdOglhkmC4JdOeUKAuMgloTHOJkOzfvKOcMm
         OfVJzXmoQfDuGGuDQI2Ukcv1Ujw5naOxHz15/NfZFRniBOtCQoBGtWLsTFPC5zb2+8l1
         IW0w==
X-Gm-Message-State: AOJu0YyPhBNDcSyZstI9TPkR5wzt276Qn0nWTzT7MvIaKWklOlLr3y+A
	SkflHbxOdqzUYVITItcf9YdxEEgX+I0tMNmIDVlvx5bZk55TkqREs5/YB2jCXg==
X-Gm-Gg: Acq92OFJA5MPWCyasUxsSDb9Ezi21UFfNmTljInUlpBW/gO14bi8ZrBKg+tGmoqImEW
	1tI7/UivumQuj4iFKymNUSuyLUobfVH3glP/1XarF87nXV7405bhwZhxRtmP6Mw8DoBMx7Wl2jz
	A/sdogbmU7lmA+8hyfEIetZkQqNM2Q5e7RRZNzjxQ9xIwerxEIqGtQBfjJnSQFIHgCGS04ea5DY
	6vMrzfpMyhZYOlC+0fbE2qkC3NqyfbIjVjJ0JV4jUR47xSor1WvMdIrqG3jUeAkTIwurxvfEFbR
	1i3LkqfJ+18vhU3xg+iRHvULxcE++Zxl8ZLMQIhpZKHLRJimDtnV/XGM5wL7gYhXgQXeYTRDDOF
	eVKmrICA6SOsjJIa5rzM0CmhCPEdM8NlqOvtI16xK/FvBBUx0TCp/x45ApsHc+RxJIEv9xsjewI
	2SueAnCP4/+BjAdO7g/p687hy6
X-Received: by 2002:a05:7022:222:b0:12f:1f67:e741 with SMTP id a92af1059eb24-131a6b0d55dmr13182831c88.44.1778498535735;
        Mon, 11 May 2026 04:22:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.226.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278758e0csm14779876c88.12.2026.05.11.04.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:22:14 -0700 (PDT)
Message-Id: <pull.2109.v3.git.1778498532730.gitgitgadget@gmail.com>
In-Reply-To: <pull.2109.v2.git.1778480348118.gitgitgadget@gmail.com>
References: <pull.2109.v2.git.1778480348118.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 11:22:12 +0000
Subject: [PATCH v3] commit-reach: early exit paint_down_to_common for single
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Commits not in the commit-graph get GENERATION_NUMBER_INFINITY and
sort to the top of the priority queue.  After those, commits with
finite generation numbers are popped in non-increasing order.
When MERGE_BASE_FIND_ALL is not set the first doubly-painted commit
with a finite generation is therefore a best merge-base: no commit
still in the queue can be a descendant of it.  Skip the expensive
STALE drain in this case.

Introduce enum merge_base_flags with MERGE_BASE_FIND_ALL and
MERGE_BASE_IGNORE_MISSING_COMMITS, replacing the two boolean
parameters in paint_down_to_common().  Thread the flags through
merge_bases_many(), get_merge_bases_many_0(), and the public
repo_get_merge_bases_many_dirty() API.  git merge-base (without
--all) passes 0, triggering the early exit.

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
    
    Changes since v2 (thanks Patrick for the suggestion):
    
     * Replaced the boolean find_all and ignore_missing_commits parameters
       in paint_down_to_common() with a single enum merge_base_flags
       mb_flags, reducing the function from 8 to 7 parameters. The enum is
       defined in commit-reach.h with MERGE_BASE_FIND_ALL and
       MERGE_BASE_IGNORE_MISSING_COMMITS.
    
     * Named the enum merge_base_flags rather than
       paint_down_to_common_flags since the flags express caller intent and
       are threaded through multiple layers including the public
       repo_get_merge_bases_many_dirty() API.
    
     * Used mb_flags as the parameter name to avoid shadowing the existing
       local int flags (commit object flags) inside paint_down_to_common().

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2109%2Fspkrka%2Fmerge-base-early-exit-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2109/spkrka/merge-base-early-exit-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2109

Range-diff vs v2:

 1:  f7b5c267f3 ! 1:  e4dada892f commit-reach: early exit paint_down_to_common for single merge-base
     @@ Commit message
          Commits not in the commit-graph get GENERATION_NUMBER_INFINITY and
          sort to the top of the priority queue.  After those, commits with
          finite generation numbers are popped in non-increasing order.
     -    When find_all is false the first doubly-painted commit with a
     -    finite generation is therefore a best merge-base: no commit still
     -    in the queue can be a descendant of it.  Skip the expensive STALE
     -    drain in this case.
     +    When MERGE_BASE_FIND_ALL is not set the first doubly-painted commit
     +    with a finite generation is therefore a best merge-base: no commit
     +    still in the queue can be a descendant of it.  Skip the expensive
     +    STALE drain in this case.
      
     -    Add find_all parameter to repo_get_merge_bases_many_dirty() and
     -    thread it through to paint_down_to_common().  git merge-base
     -    (without --all) passes show_all=0, triggering the early exit.
     +    Introduce enum merge_base_flags with MERGE_BASE_FIND_ALL and
     +    MERGE_BASE_IGNORE_MISSING_COMMITS, replacing the two boolean
     +    parameters in paint_down_to_common().  Thread the flags through
     +    merge_bases_many(), get_merge_bases_many_0(), and the public
     +    repo_get_merge_bases_many_dirty() API.  git merge-base (without
     +    --all) passes 0, triggering the early exit.
      
          On a 2.2M-commit merge-heavy monorepo with commit-graph:
      
     @@ Commit message
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## builtin/merge-base.c ##
     -@@ builtin/merge-base.c: static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
     +@@
     + 
     + static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
     + {
     ++	enum merge_base_flags flags = show_all ? MERGE_BASE_FIND_ALL : 0;
       	struct commit_list *result = NULL, *r;
       
       	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
      -					    rev_nr - 1, rev + 1, &result) < 0) {
      +					    rev_nr - 1, rev + 1,
     -+					    show_all, &result) < 0) {
     ++					    flags, &result) < 0) {
       		commit_list_free(result);
       		return -1;
       	}
      
       ## commit-reach.c ##
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 				struct commit *one, int n,
       				struct commit **twos,
       				timestamp_t min_generation,
     - 				int ignore_missing_commits,
     -+				int find_all,
     +-				int ignore_missing_commits,
     ++				enum merge_base_flags mb_flags,
       				struct commit_list **result)
       {
       	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
      +				 * remaining common ancestor can be a
      +				 * descendant of this one.
      +				 */
     -+				if (!find_all &&
     ++				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
      +				    generation < GENERATION_NUMBER_INFINITY)
      +					break;
       			}
       			/* Mark parents of a found merge stale */
       			flags |= STALE;
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 				 * corrupt commits would already have been
     + 				 * dispatched with a `die()`.
     + 				 */
     +-				if (ignore_missing_commits)
     ++				if (mb_flags & MERGE_BASE_IGNORE_MISSING_COMMITS)
     + 					return 0;
     + 				return error(_("could not parse commit %s"),
     + 					     oid_to_hex(&p->object.oid));
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       static int merge_bases_many(struct repository *r,
       			    struct commit *one, int n,
       			    struct commit **twos,
     -+			    int find_all,
     ++			    enum merge_base_flags mb_flags,
       			    struct commit_list **result)
       {
       	struct commit_list *list = NULL, **tail = result;
     @@ commit-reach.c: static int merge_bases_many(struct repository *r,
       	}
       
      -	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
     -+	if (paint_down_to_common(r, one, n, twos, 0, 0, find_all, &list)) {
     ++	if (paint_down_to_common(r, one, n, twos, 0, mb_flags, &list)) {
       		commit_list_free(list);
       		return -1;
       	}
     @@ commit-reach.c: static int remove_redundant_no_gen(struct repository *r,
       		}
       		if (paint_down_to_common(r, array[i], filled,
      -					 work, min_generation, 0, &common)) {
     -+					 work, min_generation, 0, 1, &common)) {
     ++					 work, min_generation,
     ++					 MERGE_BASE_FIND_ALL, &common)) {
       			clear_commit_marks(array[i], all_flags);
       			clear_commit_marks_many(filled, work, all_flags);
       			commit_list_free(common);
     @@ commit-reach.c: static int get_merge_bases_many_0(struct repository *r,
       				  size_t n,
       				  struct commit **twos,
       				  int cleanup,
     -+				  int find_all,
     ++				  enum merge_base_flags mb_flags,
       				  struct commit_list **result)
       {
       	struct commit_list *list, **tail = result;
     @@ commit-reach.c: static int get_merge_bases_many_0(struct repository *r,
       	int ret;
       
      -	if (merge_bases_many(r, one, n, twos, result) < 0)
     -+	if (merge_bases_many(r, one, n, twos, find_all, result) < 0)
     ++	if (merge_bases_many(r, one, n, twos, mb_flags, result) < 0)
       		return -1;
       	for (i = 0; i < n; i++) {
       		if (one == twos[i])
     @@ commit-reach.c: int repo_get_merge_bases_many(struct repository *r,
       			      struct commit_list **result)
       {
      -	return get_merge_bases_many_0(r, one, n, twos, 1, result);
     -+	return get_merge_bases_many_0(r, one, n, twos, 1, 1, result);
     ++	return get_merge_bases_many_0(r, one, n, twos, 1,
     ++				     MERGE_BASE_FIND_ALL, result);
       }
       
       int repo_get_merge_bases_many_dirty(struct repository *r,
       				    struct commit *one,
       				    size_t n,
       				    struct commit **twos,
     -+				    int find_all,
     ++				    enum merge_base_flags mb_flags,
       				    struct commit_list **result)
       {
      -	return get_merge_bases_many_0(r, one, n, twos, 0, result);
     -+	return get_merge_bases_many_0(r, one, n, twos, 0, find_all, result);
     ++	return get_merge_bases_many_0(r, one, n, twos, 0, mb_flags, result);
       }
       
       int repo_get_merge_bases(struct repository *r,
     @@ commit-reach.c: int repo_get_merge_bases(struct repository *r,
       			 struct commit_list **result)
       {
      -	return get_merge_bases_many_0(r, one, 1, &two, 1, result);
     -+	return get_merge_bases_many_0(r, one, 1, &two, 1, 1, result);
     ++	return get_merge_bases_many_0(r, one, 1, &two, 1,
     ++				     MERGE_BASE_FIND_ALL, result);
       }
       
       /*
      @@ commit-reach.c: int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
     + 	struct commit_list *bases = NULL;
     + 	int ret = 0, i;
     + 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
     ++	enum merge_base_flags mb_flags = MERGE_BASE_FIND_ALL;
     ++
     ++	if (ignore_missing_commits)
     ++		mb_flags |= MERGE_BASE_IGNORE_MISSING_COMMITS;
     + 
     + 	if (repo_parse_commit(r, commit))
     + 		return ignore_missing_commits ? 0 : -1;
     +@@ commit-reach.c: int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
       
       	if (paint_down_to_common(r, commit,
       				 nr_reference, reference,
      -				 generation, ignore_missing_commits, &bases))
     -+				 generation, ignore_missing_commits, 1, &bases))
     ++				 generation, mb_flags, &bases))
       		ret = -1;
       	else if (commit->object.flags & PARENT2)
       		ret = 1;
     @@ commit-reach.h: int repo_get_merge_bases_many(struct repository *r,
       			      struct commit **twos,
       			      struct commit_list **result);
      -/* To be used only when object flags after this call no longer matter */
     ++enum merge_base_flags {
     ++	MERGE_BASE_FIND_ALL               = (1 << 0),
     ++	MERGE_BASE_IGNORE_MISSING_COMMITS = (1 << 1),
     ++};
     ++
      +/*
      + * To be used only when object flags after this call no longer matter.
     -+ * When find_all is false and generation numbers are available, returns
     -+ * after finding the first merge-base, skipping the STALE drain.
     ++ * Without MERGE_BASE_FIND_ALL and with generation numbers available,
     ++ * returns after finding the first merge-base, skipping the STALE drain.
      + */
       int repo_get_merge_bases_many_dirty(struct repository *r,
       				    struct commit *one, size_t n,
       				    struct commit **twos,
     -+				    int find_all,
     ++				    enum merge_base_flags mb_flags,
       				    struct commit_list **result);
       
       int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result);


 builtin/merge-base.c  |   4 +-
 commit-reach.c        |  36 +++++++++----
 commit-reach.h        |  12 ++++-
 t/t6010-merge-base.sh | 119 ++++++++++++++++++++++++++++++++++++++++++
 t/t6600-test-reach.sh |  40 ++++++++++++++
 5 files changed, 200 insertions(+), 11 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index c7ee97fa6a..a87011c6cd 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -11,10 +11,12 @@
 
 static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
 {
+	enum merge_base_flags flags = show_all ? MERGE_BASE_FIND_ALL : 0;
 	struct commit_list *result = NULL, *r;
 
 	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
-					    rev_nr - 1, rev + 1, &result) < 0) {
+					    rev_nr - 1, rev + 1,
+					    flags, &result) < 0) {
 		commit_list_free(result);
 		return -1;
 	}
diff --git a/commit-reach.c b/commit-reach.c
index d3a9b3ed6f..5a52be90a6 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -54,7 +54,7 @@ static int paint_down_to_common(struct repository *r,
 				struct commit *one, int n,
 				struct commit **twos,
 				timestamp_t min_generation,
-				int ignore_missing_commits,
+				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
@@ -97,6 +97,14 @@ static int paint_down_to_common(struct repository *r,
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |= RESULT;
 				tail = commit_list_append(commit, tail);
+				/*
+				 * The queue is generation-ordered; no
+				 * remaining common ancestor can be a
+				 * descendant of this one.
+				 */
+				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
+				    generation < GENERATION_NUMBER_INFINITY)
+					break;
 			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
@@ -118,7 +126,7 @@ static int paint_down_to_common(struct repository *r,
 				 * corrupt commits would already have been
 				 * dispatched with a `die()`.
 				 */
-				if (ignore_missing_commits)
+				if (mb_flags & MERGE_BASE_IGNORE_MISSING_COMMITS)
 					return 0;
 				return error(_("could not parse commit %s"),
 					     oid_to_hex(&p->object.oid));
@@ -136,6 +144,7 @@ static int paint_down_to_common(struct repository *r,
 static int merge_bases_many(struct repository *r,
 			    struct commit *one, int n,
 			    struct commit **twos,
+			    enum merge_base_flags mb_flags,
 			    struct commit_list **result)
 {
 	struct commit_list *list = NULL, **tail = result;
@@ -165,7 +174,7 @@ static int merge_bases_many(struct repository *r,
 				     oid_to_hex(&twos[i]->object.oid));
 	}
 
-	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
+	if (paint_down_to_common(r, one, n, twos, 0, mb_flags, &list)) {
 		commit_list_free(list);
 		return -1;
 	}
@@ -246,7 +255,8 @@ static int remove_redundant_no_gen(struct repository *r,
 				min_generation = curr_generation;
 		}
 		if (paint_down_to_common(r, array[i], filled,
-					 work, min_generation, 0, &common)) {
+					 work, min_generation,
+					 MERGE_BASE_FIND_ALL, &common)) {
 			clear_commit_marks(array[i], all_flags);
 			clear_commit_marks_many(filled, work, all_flags);
 			commit_list_free(common);
@@ -425,6 +435,7 @@ static int get_merge_bases_many_0(struct repository *r,
 				  size_t n,
 				  struct commit **twos,
 				  int cleanup,
+				  enum merge_base_flags mb_flags,
 				  struct commit_list **result)
 {
 	struct commit_list *list, **tail = result;
@@ -432,7 +443,7 @@ static int get_merge_bases_many_0(struct repository *r,
 	size_t cnt, i;
 	int ret;
 
-	if (merge_bases_many(r, one, n, twos, result) < 0)
+	if (merge_bases_many(r, one, n, twos, mb_flags, result) < 0)
 		return -1;
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
@@ -475,16 +486,18 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit **twos,
 			      struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 1, result);
+	return get_merge_bases_many_0(r, one, n, twos, 1,
+				     MERGE_BASE_FIND_ALL, result);
 }
 
 int repo_get_merge_bases_many_dirty(struct repository *r,
 				    struct commit *one,
 				    size_t n,
 				    struct commit **twos,
+				    enum merge_base_flags mb_flags,
 				    struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 0, result);
+	return get_merge_bases_many_0(r, one, n, twos, 0, mb_flags, result);
 }
 
 int repo_get_merge_bases(struct repository *r,
@@ -492,7 +505,8 @@ int repo_get_merge_bases(struct repository *r,
 			 struct commit *two,
 			 struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, 1, &two, 1, result);
+	return get_merge_bases_many_0(r, one, 1, &two, 1,
+				     MERGE_BASE_FIND_ALL, result);
 }
 
 /*
@@ -537,6 +551,10 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 	struct commit_list *bases = NULL;
 	int ret = 0, i;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
+	enum merge_base_flags mb_flags = MERGE_BASE_FIND_ALL;
+
+	if (ignore_missing_commits)
+		mb_flags |= MERGE_BASE_IGNORE_MISSING_COMMITS;
 
 	if (repo_parse_commit(r, commit))
 		return ignore_missing_commits ? 0 : -1;
@@ -555,7 +573,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 
 	if (paint_down_to_common(r, commit,
 				 nr_reference, reference,
-				 generation, ignore_missing_commits, &bases))
+				 generation, mb_flags, &bases))
 		ret = -1;
 	else if (commit->object.flags & PARENT2)
 		ret = 1;
diff --git a/commit-reach.h b/commit-reach.h
index 6012402dfc..41607d8952 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -17,10 +17,20 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit *one, size_t n,
 			      struct commit **twos,
 			      struct commit_list **result);
-/* To be used only when object flags after this call no longer matter */
+enum merge_base_flags {
+	MERGE_BASE_FIND_ALL               = (1 << 0),
+	MERGE_BASE_IGNORE_MISSING_COMMITS = (1 << 1),
+};
+
+/*
+ * To be used only when object flags after this call no longer matter.
+ * Without MERGE_BASE_FIND_ALL and with generation numbers available,
+ * returns after finding the first merge-base, skipping the STALE drain.
+ */
 int repo_get_merge_bases_many_dirty(struct repository *r,
 				    struct commit *one, size_t n,
 				    struct commit **twos,
+				    enum merge_base_flags mb_flags,
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
