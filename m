Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E09D222597
	for <git@vger.kernel.org>; Fri,  8 May 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252842; cv=none; b=Sie7Gt4kq4PHjS8p/mifIfoE0PpRe9X/HqbmdZO6NlESdejzA8DqlNXntv38CtXTV1lItynuZL8z2Ez2K0IttfLqLK4SlI6oL+6BdcoQ0h5ZxXLVMbvy0AuqKadRjnyXzF6d+qMf4K176hRj59wWW3A5jqnQ1aLy4ljnd+W5x1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252842; c=relaxed/simple;
	bh=1JSvcWn3ENPWtLX7UIEFxpIvr+Our0re/8+0r02MuBQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=RG/VxglR32ttHuM3ADZoLBKOjtQewYQXZ9FCGo/s6weCobZFuQBtBGB/ClLSn/ar3RzwqUcAxFv/k2qsoYVrMAJ4sOg0y4WIWcQ8JIxoWiewHM6EmvJuOBqw1eVvnM8joyC/KOaBo96L403EYl8g6B2qv+hUHGCQ6zEcH3pLlws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnrqPJX0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnrqPJX0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b4650d5f5cso8210385ad.0
        for <git@vger.kernel.org>; Fri, 08 May 2026 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252840; x=1778857640; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BUKPD5RGVXGc9wJ4/lt3Vq1SdI4801tr1iO5/UJBuoM=;
        b=WnrqPJX0qzm5mSKEPPmjAbQNNTNhdTIMVScsmRPt5tJmnoginNO/E3pq1vl5Jag0fy
         PcPODd7zcIsYhMO6osZ1bp124w/1hCViWAw+Ix8099ZQnc3B4j/wTq7J9BvEC9X45x99
         +/rWtE4KtT1GV1ezWpiCKm/hjyjK1tt5hK8jwiWe+MCBL7MMVcFHJGDs9KLn/A1Jg1e9
         R1pBTW8heweckRUY2Xz27gZbdqZMBC8xzoYtNjdhCGJFOtVSLuCvC0cuFAWdsB7YHrug
         nzT3q30kV8nDW/7z8KYYjSKvXpXm6vfYaXe6S297OSMzLg0VdYh0s6B9vLSr3VQk7L5Z
         KvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252840; x=1778857640;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUKPD5RGVXGc9wJ4/lt3Vq1SdI4801tr1iO5/UJBuoM=;
        b=I6agGFHo1O5zwoCqQq18P+8sylBaXC4v0XMaBtB04r2kKNrJSONNZJTSuHTwdCh8L3
         h/EwxOpVGM2iPZGAHY2rR/bRgHxPDEbJGJueeZHSxHwxPwPyfQVNnR0DXwCQvwEwRmmR
         WqBMFPZrgiMm0OYHf/jrJjSBleSDkxpbLMRLRZelQU+XQxnmGMMcBiB3yxtqw97HUymG
         Fkw8tEFe++CYSzBEGh4nvBGczs7hx4yN7hIXB2AcfIAPgsissxRRbrhjYKZdWUeTTUzz
         cvnlk9PNBl4F7PfJZpzS4JRsL5RHubiwYrrDOCgq1pY5CyCgOfVeSEQr3MTDINm7XUnm
         SBwg==
X-Gm-Message-State: AOJu0Yy5LFqvzfxMZ+Xzx+2pn+k0+oK5LBZsBGu1S4BmSCY4x4kILa5z
	wxQpQVIF118RjBMEywAfBp/+0pYv6P2f3Oni0MlZx56UaSBvXwI+MRVIyrLAfg==
X-Gm-Gg: Acq92OHNpVOGsOTcvyoJEXzQkRne7lV+Eo7tm3n0jqssJYwhz68qE1Q5o0Hz211iswr
	Cm5HDfDzQdzHh6PEFjewZhdIUpXuGFcx9iE3pYzZpkoRZLSkBF7zaCo8ix3TCf2pFWwKVKUlPCc
	64wuKSITD0JLa5UFWaUPEgiIUxMrlwTl8Mm0i8gd23w/PCJ2w9iLvZgbxY0fL+/i2m95R2HKcs6
	SN/rDBS6KnDJJ44cKlUzI9jk1b0TCgfclu7LmJP4prRWGavrwb5SA/IjaEmYX1SSlLZYHIjh2u3
	PpvDNb+R5nJYB+RmtGs4/UkmlnaVJKWa2N6+V6v5vy2fMVtTEDh47KkU0BlCMCOKSjUNtLJ79we
	yoIipqdhaOOAgyWB4d88YaEzhiBu88nUQ5DHNuQ9fQuRUrykvV3JXnWWpE4+udKl30QAqgXp0Vz
	5xny8FJIsF3pHPkdTqySXcJaI=
X-Received: by 2002:a17:903:b46:b0:2b2:eb9d:1648 with SMTP id d9443c01a7336-2ba79c25ad9mr136817665ad.37.1778252839587;
        Fri, 08 May 2026 08:07:19 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.76.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm23207245ad.54.2026.05.08.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:07:18 -0700 (PDT)
Message-Id: <pull.2109.git.1778252837132.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 15:07:17 +0000
Subject: [PATCH] commit-reach: early exit paint_down_to_common for single
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

When find_all is false and generation numbers are available, the
priority queue pops in non-increasing generation order.  The first
doubly-painted commit is a valid best merge-base; no later commit
can dominate it.  Skip the expensive STALE drain in this case.

The early exit is guarded by three conditions: find_all must be
false, the commit-graph must provide generation numbers, and the
merge-base commit itself must have a finite generation (not
GENERATION_NUMBER_INFINITY from being outside the commit-graph).

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
    performance issue. After some digging I ended up looking more deeply
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2109%2Fspkrka%2Fmerge-base-early-exit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2109/spkrka/merge-base-early-exit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2109

 builtin/merge-base.c  |   3 +-
 commit-reach.c        |  26 ++++++---
 commit-reach.h        |   5 +-
 t/t6010-merge-base.sh | 119 ++++++++++++++++++++++++++++++++++++++++++
 t/t6600-test-reach.sh |  40 ++++++++++++++
 5 files changed, 183 insertions(+), 10 deletions(-)

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
index d3a9b3ed6f..c9d2d594de 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -55,14 +55,16 @@ static int paint_down_to_common(struct repository *r,
 				struct commit **twos,
 				timestamp_t min_generation,
 				int ignore_missing_commits,
+				int find_all,
 				struct commit_list **result)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	int i;
+	int has_gens = min_generation || corrected_commit_dates_enabled(r);
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
-	if (!min_generation && !corrected_commit_dates_enabled(r))
+	if (!has_gens)
 		queue.compare = compare_commits_by_commit_date;
 
 	one->object.flags |= PARENT1;
@@ -97,6 +99,11 @@ static int paint_down_to_common(struct repository *r,
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |= RESULT;
 				tail = commit_list_append(commit, tail);
+				/* Generation-ordered queue: no later
+				 * commit can dominate this one. */
+				if (!find_all && has_gens &&
+				    generation < GENERATION_NUMBER_INFINITY)
+					break;
 			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
@@ -136,6 +143,7 @@ static int paint_down_to_common(struct repository *r,
 static int merge_bases_many(struct repository *r,
 			    struct commit *one, int n,
 			    struct commit **twos,
+			    int find_all,
 			    struct commit_list **result)
 {
 	struct commit_list *list = NULL, **tail = result;
@@ -165,7 +173,7 @@ static int merge_bases_many(struct repository *r,
 				     oid_to_hex(&twos[i]->object.oid));
 	}
 
-	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
+	if (paint_down_to_common(r, one, n, twos, 0, 0, find_all, &list)) {
 		commit_list_free(list);
 		return -1;
 	}
@@ -246,7 +254,7 @@ static int remove_redundant_no_gen(struct repository *r,
 				min_generation = curr_generation;
 		}
 		if (paint_down_to_common(r, array[i], filled,
-					 work, min_generation, 0, &common)) {
+					 work, min_generation, 0, 1, &common)) {
 			clear_commit_marks(array[i], all_flags);
 			clear_commit_marks_many(filled, work, all_flags);
 			commit_list_free(common);
@@ -425,6 +433,7 @@ static int get_merge_bases_many_0(struct repository *r,
 				  size_t n,
 				  struct commit **twos,
 				  int cleanup,
+				  int find_all,
 				  struct commit_list **result)
 {
 	struct commit_list *list, **tail = result;
@@ -432,7 +441,7 @@ static int get_merge_bases_many_0(struct repository *r,
 	size_t cnt, i;
 	int ret;
 
-	if (merge_bases_many(r, one, n, twos, result) < 0)
+	if (merge_bases_many(r, one, n, twos, find_all, result) < 0)
 		return -1;
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
@@ -475,16 +484,17 @@ int repo_get_merge_bases_many(struct repository *r,
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
@@ -492,7 +502,7 @@ int repo_get_merge_bases(struct repository *r,
 			 struct commit *two,
 			 struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, 1, &two, 1, result);
+	return get_merge_bases_many_0(r, one, 1, &two, 1, 1, result);
 }
 
 /*
@@ -555,7 +565,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 
 	if (paint_down_to_common(r, commit,
 				 nr_reference, reference,
-				 generation, ignore_missing_commits, &bases))
+				 generation, ignore_missing_commits, 1, &bases))
 		ret = -1;
 	else if (commit->object.flags & PARENT2)
 		ret = 1;
diff --git a/commit-reach.h b/commit-reach.h
index 6012402dfc..908b9539c5 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -17,10 +17,13 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit *one, size_t n,
 			      struct commit **twos,
 			      struct commit_list **result);
-/* To be used only when object flags after this call no longer matter */
+/* To be used only when object flags after this call no longer matter.
+ * When find_all is false and generation numbers are available, returns
+ * after finding the first merge-base, skipping the STALE drain. */
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
