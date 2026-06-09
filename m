Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488A40D57F
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033289; cv=none; b=e3/8ilmKLokmoGQWNcNMQyyPoOG3QQ0mvN22/Ict5F1YPMjqfL8koQGnz1kljHkTfQXNz8YGHdpzzAPm5Am+2pefeqNAJ6zVPuyhdGUehghaplHLA3pSN6u5siM9ZDNib4i81O0v0IxJPjs53IazacZsir+pFu/NMYwnfbLpg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033289; c=relaxed/simple;
	bh=dZsxPVaSVmUUOA6GOvhsjgDWn5HrXQfJ2vTfAmbHeqM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=A7eGW3qMLeYUMZSfJhu59cMZxu1CpXBxplcY0mCig55V1OcaeWUy0Dp9rbouGbro5LGs8c1M3aQjm2jlXCkDfn8vbmF9Xtk3CLRW3gZDtn1R9XfiAra+gZh0pLxl9DAePTtAetrWen5HxweKx1FH7E+f8bifKT9gM16DKCe3TKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcVQIVaS; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcVQIVaS"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13810b63a1aso4413137c88.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781033287; x=1781638087; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=seEEt244Gs0anN62HLVScqA7iDqmUt1GUyWgQ+S8oTE=;
        b=hcVQIVaSOONinW3BQhBzwsvxOXQ4Klkpp0asUKMaDyyKaJXUxvG4J4kHAro6E2SCwc
         CiFS/oepRMZyl/0gK0Oq9mtGNOGZX99Z9k29/nbNGPphNInTTGYro2Zhtm3zHo23RjxT
         FbBKachSI7Mc9dY8F53YjHAXqb0sYVdmEpw8OqDX450ITbnlDfJst/c3t5S3EymrPypZ
         sXOl4sdI3C8Rq0Rytc6SNyM8JtALWGBvTRJOiY+YJ0LN8RAzZhCVQbs78Qm/gzZerOZw
         zwtkpxUNLxa3HovD897iuScjwvFwjJ+LTHyldvc8WUWIjnARRMg5OAKIU6YITggaG6sz
         mgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033287; x=1781638087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seEEt244Gs0anN62HLVScqA7iDqmUt1GUyWgQ+S8oTE=;
        b=DhfabIzN6AAjnQtz2EbCCYZDwppl3nip31PAuZ9/kSs7DU0LWZoDatwmK9Mb8mPgxk
         dT8ut1s3xvAq6m0jwQmcEQXtIPYjeLstyzK+f7EIG6HQiggGNrELm6S48KutqdMqrbJ3
         hHo3tQy0L05DaSqjdGiEUdy5a47yvlqGjDMw8EkoC5o4P/RaYVt2pN+1/F7ZghhzLq6Z
         TBcsniDfV4CnqEDTnxUJUGYu2IF86RN9uihjKqDf8DfqAapIEk+cm3PT6bPuaJTjuB/Y
         1c8y1bept/xcsvV1CgZYu9wfUlSXfg0vyIJpZHQfqLKPR04RVbCRkE56Vei8JxIMLm2L
         H8HA==
X-Gm-Message-State: AOJu0Yx7cMxE88s5RP7BZpG1OBn5uCTl7sRKK0R23yhSk+yGZnLQ5QyS
	rIOEWjQkcrp1vaopu8ZxPhNZXKGYO5+Bb4InwHMqzl9CYhHrN/HGKFfsF3U93g==
X-Gm-Gg: Acq92OHIQhpaGn/3oMXbSSbl5auCOOSm8OmjfSHSsiabDL6H0KHsoC2qamHxk+Riz47
	vpKn0philOtcLsWanVxrYpcDGPo1QMKcYFBpEK+2hium/FqB5oGo2mOxX6c5tAQ70qP6tSZSngD
	ovZ1hee5gOAXWQu5enrMP8xAMGGydgmGS3WU0Ku7+MC429ceWsocnFRn+eaRQsYdmP5dfNWwil1
	Uzzgdsj4fSl8JKLPpM9/3GWXLwhYVx8Th7wjrt+DiLMzhD6ENKZuLiI1z2D93bRlVXaErivxRs3
	RiVfBx6zWjTKjUNoYHQuRAXty+3Lby4n8zKqSa/rfPWsMr3oO3FSwYJbj3aaqW6buM0MyVeh2eF
	RZopyPzw5CPLhYSfe3Pfq1ZGz9Vc8C0jVyzXqF4HjbJuw4TDxWRMhKHlWD1jQ7L8m65Zq+b7cNA
	iiACHL30EczfwrmoB0LZvoRKbWlUkBTeU9Ilsl3HU=
X-Received: by 2002:a05:7022:ea4d:b0:137:f995:df25 with SMTP id a92af1059eb24-13831a63a3amr2038470c88.13.1781033287115;
        Tue, 09 Jun 2026 12:28:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.138])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm16723397c88.14.2026.06.09.12.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:28:06 -0700 (PDT)
Message-Id: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jun 2026 19:28:04 +0000
Subject: [PATCH] commit-reach: remove get_reachable_subset()
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

get_reachable_subset() and tips_reachable_from_bases() answer the
same question: given a set of bases and a set of tips, which tips
are reachable from at least one base?

get_reachable_subset() was introduced in fcb2c0769d (2018-11-02)
for add_missing_tags() in remote.c. tips_reachable_from_bases()
was added in cbfe360b14 (2023-03-20) as part of the ahead-behind
series. The two were never consolidated.

With a commit-graph, tips_reachable_from_bases() can have an edge:
its DFS raises the generation floor as lower targets are found,
pruning more aggressively than the static floor in
get_reachable_subset(). Without generation numbers, some edge cases
may be slower with DFS instead of BFS since the date-ordered
prio_queue naturally stays near the top of the graph, but this
should not matter in practice -- worst case both visit the full
graph down from the bases.

The flag in remote.c changes from 1 (bit 0) to TMP_MARK (bit 4)
because tips_reachable_from_bases() uses SEEN (bit 0) internally.
TMP_MARK is already used for deduplication earlier in the same
function and is cleared before the reachability check.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    commit-reach: remove get_reachable_subset()
    
    This removes get_reachable_subset() and converts its only caller to use
    tips_reachable_from_bases() directly. Both answer the same category-2
    reachability question ("which tips are reachable from these bases?") but
    were introduced years apart and never consolidated.
    
    On the no-commit-graph tradeoff: without generation numbers, the
    date-ordered BFS in get_reachable_subset() can be more disciplined than
    DFS since it naturally stays near the top of the graph. But this only
    matters for repositories that are both large enough for the difference
    to be measurable and missing a commit-graph -- a combination that would
    already struggle for many other reasons. The fix there is to enable the
    commit-graph, not to maintain two implementations of the same
    reachability query.
    
    Notes for reviewers:
    
     * The flag in remote.c changes from 1 to TMP_MARK because
       tips_reachable_from_bases() uses SEEN (bit 0) internally. TMP_MARK is
       already used earlier in the same function and is cleared before the
       reachability block.
    
     * The sent_tips array is converted to a commit_list to match the
       tips_reachable_from_bases() API. This is O(n) list-node allocations,
       negligible compared to the graph walk.
    
     * Test helper and test names rename from get_reachable_subset to
       tips_reachable_from_bases to match the function being exercised.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2144%2Fspkrka%2Fkrka%2Fremove-get-reachable-subset-v2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2144/spkrka/krka/remove-get-reachable-subset-v2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2144

 commit-reach.c        | 73 -------------------------------------------
 commit-reach.h        | 13 --------
 remote.c              | 19 ++++++-----
 t/helper/test-reach.c | 39 +++++++++++------------
 t/t6600-test-reach.sh | 18 +++++------
 5 files changed, 36 insertions(+), 126 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5df471a313..e78752eb87 100644
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
 
diff --git a/commit-reach.h b/commit-reach.h
index 3f3a563d8a..b3e7051738 100644
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
diff --git a/remote.c b/remote.c
index f1a3681b7c..7cdb59ed87 100644
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
@@ -1479,11 +1478,12 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
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
+					 src_commits.nr, TMP_MARK);
+		commit_list_free(bases);
 
 		for_each_string_list_item(item, &src_tag) {
 			struct ref *dst_ref;
@@ -1503,7 +1503,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			 * Is this tag, which they do not have, reachable from
 			 * any of the commits we are sending?
 			 */
-			if (!(commit->object.flags & reachable_flag))
+			if (!(commit->object.flags & TMP_MARK))
 				continue;
 
 			/* Add it in */
@@ -1513,9 +1513,8 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 		}
 
 		clear_commit_marks_many(src_commits.nr, src_commits.items,
-					reachable_flag);
+					TMP_MARK);
 		commit_stack_clear(&src_commits);
-		commit_list_free(found_commits);
 	}
 
 	string_list_clear(&src_tag, 0);
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 5d86a96c17..eb44a64f50 100644
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
@@ -149,30 +150,26 @@ int cmd__reach(int ac, const char **av)
 
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
+	} else if (!strcmp(av[1], "tips_reachable_from_bases")) {
+		struct commit_list *bases = NULL;
+		struct commit_list *result = NULL;
+
+		for (size_t i = 0; i < X_stack.nr; i++)
+			commit_list_insert(X_stack.items[i], &bases);
+		tips_reachable_from_bases(the_repository,
+					 bases, Y_stack.items,
+					 Y_stack.nr, TMP_MARK);
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
index b5b314e570..51b140a539 100755
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
@@ -403,15 +403,15 @@ test_expect_success 'get_reachable_subset:all' '
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
+	test_all_modes tips_reachable_from_bases
 '
 
-test_expect_success 'get_reachable_subset:some' '
+test_expect_success 'tips_reachable_from_bases:some' '
 	cat >input <<-\EOF &&
 	X:commit-9-1
 	X:commit-8-3
@@ -422,14 +422,14 @@ test_expect_success 'get_reachable_subset:some' '
 	Y:commit-5-6
 	EOF
 	(
-		echo "get_reachable_subset(X,Y)" &&
+		echo "tips_reachable_from_bases(X,Y)" &&
 		git rev-parse commit-3-3 \
 			      commit-1-7 | sort
 	) >expect &&
-	test_all_modes get_reachable_subset
+	test_all_modes tips_reachable_from_bases
 '
 
-test_expect_success 'get_reachable_subset:none' '
+test_expect_success 'tips_reachable_from_bases:none' '
 	cat >input <<-\EOF &&
 	X:commit-9-1
 	X:commit-8-3
@@ -439,8 +439,8 @@ test_expect_success 'get_reachable_subset:none' '
 	Y:commit-7-6
 	Y:commit-2-8
 	EOF
-	echo "get_reachable_subset(X,Y)" >expect &&
-	test_all_modes get_reachable_subset
+	echo "tips_reachable_from_bases(X,Y)" >expect &&
+	test_all_modes tips_reachable_from_bases
 '
 
 test_expect_success 'for-each-ref ahead-behind:linear' '

base-commit: 600fe743028cbfb640855f659e9851522214bc0b
-- 
gitgitgadget
