Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4041A01C8
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631498; cv=none; b=CDDBUV9R7Jz+7OkGFQpMh4kgn/hxadSzQ1vmH1Qc2migKPPnYLeNiXfFvbXM5fH6IQu3zSf6g+asqzwuPk61Ge6UX7NeLQeaq+CNaxeg0tRluFRlqGjcQQ99wPDiECNRB0w3h+8Ev2qJZ8Heh76BcrVRbfiJQ3bpAsOITX/7cas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631498; c=relaxed/simple;
	bh=SaK3qP/HLfUFm7NOA2HOU7rBbYLEr17MKsCZ0qPe8LQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bieJ8bvLQbsDLwxR+gkApHqFMgPM5lVEAUH08vJEZMAyt+RJxJYmFDbwUO7W8UYnn2ek6YTx2cp5ocg4gNoMrEoheKaKj2AIZyGtVJU3f40I4MSW8pihQ3DJkodRpIWif4MwvcarHgJCDPDHsvPtAYYWdVe/FcK/PrEOTiO3WjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj8rJdBE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj8rJdBE"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-530e062217eso7934240e87.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 03:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723631494; x=1724236294; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVZCYY51GsHPcR3dN3RpwGmxaGZMXz0R5c5jQmj7I5E=;
        b=hj8rJdBE+wi5B2FKQmfG+udpa7nY8/mPE2MvQPm4p8OFb4Holswh+TrDqJNxzqOohW
         TyKTU3IMuX1+zWwjdXFTzqVyX7yYngL3dAT+VpboSxRRyPbn+fR3ec4AA5tsfTRqg4GD
         h3CzD9t9Z0a+tdUKOBT2YfGDpdJBS03Owodi0uDVhcw+o14fXrfKBFV+UW1Za8AUtCi6
         NhIZWSxjCvnCcorDXyIfQ9U30BVneAoy98y52aMsIkA5S4G2MXR/ewv/52Eqv/wdZVZP
         MGPXYZSKKiioTKn3Zy87y/qwE6ou33odfFcwoaOyH1F2Nd9WTxKtcae+Jq+Mref3UZXe
         Ix2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631494; x=1724236294;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVZCYY51GsHPcR3dN3RpwGmxaGZMXz0R5c5jQmj7I5E=;
        b=HJkaJ+qPsUhO/NMwrx1rbo+RZyJyhCjMQekvFRX8xJUWrvPq+7wu5cVuL74aL58jll
         UHxRnsTqLXL8FsTacJFAvK1RDk6jHQR0nYzquVQKrdrCZxFePNwYOYQF4MCRb0208DXv
         bra4QWPuYlXrgeiXeL7dZmXMz++qZMLyRTEBhiJIyUpIZyFoHYyEzfTyHDYlQp4XbcXG
         713xtjY8w4fo7WwZqo2yRDqHIXeTtN1q15bSjn8/g7z1phh4QHXzH6Sty+mDm/B/sUpO
         8RVEsikTln67yeDrUcJxN3QA4gpvgfK5cSjgDW+bZxO/ckLBCX+JJGjAUvFapoiGs58r
         h9og==
X-Gm-Message-State: AOJu0YzC+KyfQltwvAjyFQmborafCLsMqG+jlqc6JrMKsSOr55TFhmLe
	6NLOAnMBZVxLI3MjCaftmB7gmHDmCOJ0ivistxf6A/+CwG8umEYYRTdh3A==
X-Google-Smtp-Source: AGHT+IEzV7lyij7WhyzUDpmMWdW8aIbaq4iGDJTbP1J1ruxaBpxDbLapjBd3jj8aZjGi4SCQouBALA==
X-Received: by 2002:a05:6512:687:b0:52c:d27b:ddcb with SMTP id 2adb3069b0e04-532eda8e7ecmr1786315e87.3.1723631493353;
        Wed, 14 Aug 2024 03:31:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded4ea80sm15469895e9.38.2024.08.14.03.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:31:32 -0700 (PDT)
Message-Id: <f93d642c8d93e3f394b04d7cb655863268a60ee8.1723631490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
References: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
	<pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Aug 2024 10:31:27 +0000
Subject: [PATCH v3 1/4] commit-reach: add get_branch_base_for_tip
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
Cc: gitster@pobox.com,
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new reachability algorithm that intends to discover (from a heuristic)
which branch was used as the starting point for a given commit. Add focused
tests using the 'test-tool reach' command.

In repositories that use pull requests (or merge requests) to advance one or
more "protected" branches, the history of that reference can be recovered by
following the first-parent history in most cases. Most are completed using
no-fast-forward merges, though squash merges are quite common. Less common
is rebase-and-merge, which still validates this assumption. Finally, the
case that breaks this assumption is the fast-forward update (with potential
rebasing).  Even in this case, the previous commit commonly appears in the
first-parent history of the branch.

Similar assumptions can be made for a topic branch created by a single user
with the intention to merge back into another branch. Using 'git commit',
'git merge', and 'git cherry-pick' from HEAD will default to having the
first-parent commit be the previous commit at HEAD. This history changes
only with commands such as 'git reset' or 'git rebase', where the command
names also imply that the branch is starting from a new location.

With this movement of branches in mind, the following heuristic is proposed
as a way to determine the base branch for a given source branch:

  Among a list of candidate base branches, select the candidate that
  minimizes the number of commits in the first-parent history of the source
  that are not in the first-parent history of the candidate.

Prior third-party solutions to this problem have used this optimization
criteria, but have relied upon extracting the first-parent history and
comparing those lists as tables instead of using commit-graph walks.

Given current command-line interface options, this optimization criteria is
not easy to detect directly. Even using the command

  git rev-list --count --first-parent <base>..<source>

does not measure this count, as it uses full reachability from <base> to
determine which commits to remove from the range '<base>..<source>'. This
may lead to one asking if we should instead be using the full reachability
of the candidate and only the first-parent history of the source. This,
unfortunately, does not work for repositories that use long-lived branches
and automation to merge across those branches.

In extremely large repositories, merging into a single trunk may not be
feasible.  This is usually due to the desired frequency of updates
(thousands of engineers doing daily work) combined with the time required to
perform a validation build.  These factors combine to create significant
risk of semantic merge conflicts, leading to build breaks on the trunk. In
response, repository maintainers can create a single Level Zero (L0) trunk
and multiple Level One (L1) branches. By partitioning the engineers by
organization, these engineers may see lower risk of semantic merge conflicts
as well as be protected against build breaks in other L1 branches. The key
to making this system work is a semi-automated process of merging L1
branches into the L0 trunk and vice-versa.  In a large enough organization,
these L1 branches may further split into L2 or L3 branches, but the same
principles apply for merging across deeper levels.

If these automated merges use a typical merge with the second parent
bringing in the "new" content, then each L0 and L1 branch can track its
previous positions by following first-parent history, which appear as
parallel paths (until reaching the first place where the branches diverged).
If we also walk to second parents, then the histories overlap significantly
and cannot be distinguished except for very-recent changes.

For this reason, the first-parent condition should be symmetrical across the
base and source branches.

Another common case for desiring the result of this optimization method is
the use of release branches. When releasing a version of a repository, a
branch can be used to track that release. Any updates that are worth fixing
in that release can be merged to the release branch and shipped with only
the necessary fixes without any new features introduced in the trunk branch.
The 'maint-2.<X>' branches represent this pattern in the Git project. The
microsoft/git fork uses 'vfs-2.<X>.<Y>' branches to track the changes that
are custom to that fork on top of each upstream Git release 2.<X>.<Y>. This
application doesn't need the symmetrical first-parent condition, but the use
of first-parent histories does not change the results for these branches.

To determine the base branch from a list of candidates, create a new method
in commit-reach.c that performs a single* commit-graph walk. The core
concept is to walk first-parents starting at the candidate bases and the
source, tracking the "best" base to reach a given commit. Use generation
numbers to ensure that a commit is walked at most once and all children have
been explored before visiting it.  When reaching a commit that is reachable
from both a base and the source, we will then have a guarantee that this is
the closest intersection of first-parent histories. Track the best base to
reach that commit and return it as a result. In rare cases involving
multiple root commits, the first-parent history of the source may never
intersect any of the candidates and thus a null result is returned.

* There are up to two walks, since we require all commits to have a computed
  generation number in order to avoid incorrect results. This is similar to
  the need for computed generation numbers in ahead_behind() as implemented
  in fd67d149bde (commit-reach: implement ahead_behind() logic, 2023-03-20).

In order to track the "best" base, use a new commit slab that stores an
integer.  This value defaults to zero upon initialization, so use -1 to
track that the source commit can reach this commit and use 'i + 1' to track
that the ith base can reach this commit. When multiple bases can reach a
commit, minimize the index to break ties. This allows the caller to specify
an order to the bases that determines some amount of preference when the
heuristic does not result in a unique result.

The trickiest part of the integer slab is what happens when reaching a
collision among the histories of the bases and the history of the source.
This is noticed when viewing the first parent and seeing that it has a slab
value that differs in sign (negative or positive). In this case, the
collision commit is stored in the method variable 'branch_point' and its
slab value is set to -1. The index of the best base (so far) is stored in
the method variable 'best_index'. It is possible that there are multiple
commits that have the branch_point as its first parent, leading to multiple
updates of best_index.  The result is determined when 'branch_point' is
visited in the commit walk, giving the guarantee that all commits that could
reach 'branch_point' were visited.

Several interesting cases of collisions and different results are tested in
the t6600-test-reach.sh script. Recall that this script also tests the
algorithm in three possible states involving the commit-graph file and how
many commits are written in the file. This provides some coverage of the
need (and lack of need) for the ensure_generations_valid() method.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 commit-reach.c        | 126 ++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h        |  17 ++++++
 t/helper/test-reach.c |   2 +
 t/t6600-test-reach.sh |  61 ++++++++++++++++++++
 4 files changed, 206 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 8f9b008f876..4753197ec88 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1222,3 +1222,129 @@ done:
 	free(commits);
 	repo_clear_commit_marks(r, SEEN);
 }
+
+/*
+ * This slab initializes integers to zero, so use "-1" for "tip is best" and
+ * "i + 1" for "bases[i] is best".
+ */
+define_commit_slab(best_branch_base, int);
+static struct best_branch_base best_branch_base;
+#define get_best(c) (*best_branch_base_at(&best_branch_base, (c)))
+#define set_best(c,v) (*best_branch_base_at(&best_branch_base, (c)) = (v))
+
+int get_branch_base_for_tip(struct repository *r,
+			    struct commit *tip,
+			    struct commit **bases,
+			    size_t bases_nr)
+{
+	int best_index = -1;
+	struct commit *branch_point = NULL;
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	int found_missing_gen = 0;
+
+	if (!bases_nr)
+		return -1;
+
+	repo_parse_commit(r, tip);
+	if (commit_graph_generation(tip) == GENERATION_NUMBER_INFINITY)
+		found_missing_gen = 1;
+
+	/* Check for missing generation numbers. */
+	for (size_t i = 0; i < bases_nr; i++) {
+		struct commit *c = bases[i];
+		repo_parse_commit(r, c);
+		if (commit_graph_generation(c) == GENERATION_NUMBER_INFINITY)
+			found_missing_gen = 1;
+	}
+
+	if (found_missing_gen) {
+		struct commit **commits;
+		size_t commits_nr = bases_nr + 1;
+
+		CALLOC_ARRAY(commits, commits_nr);
+		COPY_ARRAY(commits, bases, bases_nr);
+		commits[bases_nr] = tip;
+		ensure_generations_valid(r, commits, commits_nr);
+		free(commits);
+	}
+
+	/* Initialize queue and slab now that generations are guaranteed. */
+	init_best_branch_base(&best_branch_base);
+	set_best(tip, -1);
+	prio_queue_put(&queue, tip);
+
+	for (size_t i = 0; i < bases_nr; i++) {
+		struct commit *c = bases[i];
+		int best = get_best(c);
+
+		/* Has this already been marked as best by another commit? */
+		if (best) {
+			if (best == -1) {
+				/* We agree at this position. Stop now. */
+				best_index = i + 1;
+				goto cleanup;
+			}
+			continue;
+		}
+
+		set_best(c, i + 1);
+		prio_queue_put(&queue, c);
+	}
+
+	while (queue.nr) {
+		struct commit *c = prio_queue_get(&queue);
+		int best_for_c = get_best(c);
+		int best_for_p, positive;
+		struct commit *parent;
+
+		/* Have we reached a known branch point? It's optimal. */
+		if (c == branch_point)
+			break;
+
+		repo_parse_commit(r, c);
+		if (!c->parents)
+			continue;
+
+		parent = c->parents->item;
+		repo_parse_commit(r, parent);
+		best_for_p = get_best(parent);
+
+		if (!best_for_p) {
+			/* 'parent' is new, so pass along best_for_c. */
+			set_best(parent, best_for_c);
+			prio_queue_put(&queue, parent);
+			continue;
+		}
+
+		if (best_for_p > 0 && best_for_c > 0) {
+			/* Collision among bases. Minimize. */
+			if (best_for_c < best_for_p)
+				set_best(parent, best_for_c);
+			continue;
+		}
+
+		/*
+		 * At this point, we have reached a commit that is reachable
+		 * from the tip, either from 'c' or from an earlier commit to
+		 * have 'parent' as its first parent.
+		 *
+		 * Update 'best_index' to match the minimum of all base indices
+		 * to reach 'parent'.
+		 */
+
+		/* Exactly one is positive due to initial conditions. */
+		positive = (best_for_c < 0) ? best_for_p : best_for_c;
+
+		if (best_index < 0 || positive < best_index)
+			best_index = positive;
+
+		/* No matter what, track that the parent is reachable from tip. */
+		set_best(parent, -1);
+		branch_point = parent;
+	}
+
+cleanup:
+	clear_best_branch_base(&best_branch_base);
+	clear_prio_queue(&queue);
+	return best_index > 0 ? best_index - 1 : -1;
+}
diff --git a/commit-reach.h b/commit-reach.h
index bf63cc468fd..9a745b7e176 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -139,4 +139,21 @@ void tips_reachable_from_bases(struct repository *r,
 			       struct commit **tips, size_t tips_nr,
 			       int mark);
 
+/*
+ * Given a 'tip' commit and a list potential 'bases', return the index 'i' that
+ * minimizes the number of commits in the first-parent history of 'tip' and not
+ * in the first-parent history of 'bases[i]'.
+ *
+ * Among a list of long-lived branches that are updated only by merges (with the
+ * first parent being the previous position of the branch), this would inform
+ * which branch was used to create the tip reference.
+ *
+ * Returns -1 if no common point is found in first-parent histories, which is
+ * rare, but possible with multiple root commits.
+ */
+int get_branch_base_for_tip(struct repository *r,
+			    struct commit *tip,
+			    struct commit **bases,
+			    size_t bases_nr);
+
 #endif
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 1e3b431e3e7..8579b607aa5 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -114,6 +114,8 @@ int cmd__reach(int ac, const char **av)
 		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array, 0));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
+	else if (!strcmp(av[1], "get_branch_base_for_tip"))
+		printf("%s(A,X):%d\n", av[1], get_branch_base_for_tip(r, A, X_array, X_nr));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
 		struct commit_list *list = NULL;
 		if (repo_get_merge_bases_many(the_repository,
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index b330945f497..e789a4720c1 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -612,4 +612,65 @@ test_expect_success 'for-each-ref merged:none' '
 		--format="%(refname)" --stdin
 '
 
+# For get_branch_base_for_tip, we only care about
+# first-parent history. Here is the test graph with
+# second parents removed:
+#
+#             (10,10)
+#            /
+#         (10,9)    (9,10)
+#        /         /
+#    (10,8)    (9,9)      (8,10)
+#   /         /          /
+#         ( continued...)
+#   \     /        /           /
+#    (3,1)     (2,2)      (1,3)
+#        \     /          /
+#         (2,1)      (1,2)
+#              \    /
+#              (1,1)
+#
+# In short, for a commit (i,j), the first-parent history
+# walks all commits (i, k) with k from j to 1, then the
+# commits (l, 1) with l from i to 1.
+
+test_expect_success 'get_branch_base_for_tip: none reach' '
+	# (2,3) branched from the first tip (i,4) in X with i > 2
+	cat >input <<-\EOF &&
+		A:commit-2-3
+		X:commit-1-2
+		X:commit-1-4
+		X:commit-4-4
+		X:commit-8-4
+		X:commit-10-4
+	EOF
+	echo "get_branch_base_for_tip(A,X):2" >expect &&
+	test_all_modes get_branch_base_for_tip
+'
+
+test_expect_success 'get_branch_base_for_tip: equal to tip' '
+	# (2,3) branched from the first tip (i,4) in X with i > 2
+	cat >input <<-\EOF &&
+		A:commit-8-4
+		X:commit-1-2
+		X:commit-1-4
+		X:commit-4-4
+		X:commit-8-4
+		X:commit-10-4
+	EOF
+	echo "get_branch_base_for_tip(A,X):3" >expect &&
+	test_all_modes get_branch_base_for_tip
+'
+
+test_expect_success 'get_branch_base_for_tip: all reach tip' '
+	# (2,3) branched from the first tip (i,4) in X with i > 2
+	cat >input <<-\EOF &&
+		A:commit-4-1
+		X:commit-4-2
+		X:commit-5-1
+	EOF
+	echo "get_branch_base_for_tip(A,X):0" >expect &&
+	test_all_modes get_branch_base_for_tip
+'
+
 test_done
-- 
gitgitgadget

