Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCA61F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbeGPN15 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38089 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbeGPN15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so7469083pgq.5
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OPgBJmVsDd6gmG5DWuvPD4iG6R1oLoyAQlJGLxBkxzQ=;
        b=M6HDm3YfctIH6jOgBwXqyy/WeuuloVNB4WaWfS56rv6id6GDHu6DyWf2mX+A0iYON1
         2KdMESq1SHTQIUJfepOpOdyO/048qydxV7K54SBj0/ULVSL+9SMItHlRfPKsuwjMazyc
         FVWUoQtZrqTyZQlwNTzIjmqiDoc2YzAMur8EMXg9o8uQCnmubqNFeJ7aNJsSF4VYQRnj
         vIzVtaLyI81VH91cQjIXVJ7YApeTfv3spd6zANEPZbjIy1/ewjhqgABos4N+xwgluCiX
         uc1Qh+Gvn364vkwO6LfGqqvCCxZfgPig2S/OUFTYZjr1m+mxsbWwJS0cjfPqILANupLv
         WGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OPgBJmVsDd6gmG5DWuvPD4iG6R1oLoyAQlJGLxBkxzQ=;
        b=YEeKuowiFgUFDBW/E+nExO6WxW1KigKmtYkKHOYtzQjySO3/1Idw99yTCK82mUwVF3
         CoVUXmWe/USJsY4FIjuZVszGflc5+kG/0NPdFeUz+ujkhjusBc4DMD7v53+Rg28NT0i8
         4pmal4AVY+9ODFICQjZ5xioP73TIozed/0RzC6Eq9rdLZsKGSyDQ6ySc1rzKixIvbDg6
         D6UrgrHytJF0rSSexVv7EtT3qlU+z6cPKp0hnCKkUF7Qg7nnmx/kmwutkfMPSXg7exu0
         SyW3NrpWPa1PDN7UMyrT6QhJqxXvd0K3TykGL498L0Axwx5OsgYm0m/s1Afy0E2xVAZU
         flYw==
X-Gm-Message-State: AOUpUlFbHC9t8M/Vf+20WWUeEHUFav+I6br1gL6a1aVQLTPzhknWGorG
        9Ur9oNYtmr9Q3puMUA8q1n2rsw==
X-Google-Smtp-Source: AAOMgpfxJw4vCtzDBOkHyyoqeFzC4eDqU/yOJqO2Ur0Umwh/i4Z9HPsR5f9LSSJNxbBMmRLDA6262w==
X-Received: by 2002:a62:4255:: with SMTP id p82-v6mr18108739pfa.238.1531746036362;
        Mon, 16 Jul 2018 06:00:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id z76-v6sm15694477pgz.16.2018.07.16.06.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:35 -0700 (PDT)
Message-Id: <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jun 2018 08:31:05 -0400
Subject: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The can_all_from_reach_with_flags() algorithm is currently quadratic in
the worst case, because it calls the reachable() method for every 'from'
without tracking which commits have already been walked or which can
already reach a commit in 'to'.

Rewrite the algorithm to walk each commit a constant number of times.

We also add some optimizations that should work for the main consumer of
this method: fetch negotitation (haves/wants).

The first step includes using a depth-first-search (DFS) from each from
commit, sorted by ascending generation number. We do not walk beyond the
minimum generation number or the minimum commit date. This DFS is likely
to be faster than the existing reachable() method because we expect
previous ref values to be along the first-parent history.

If we find a target commit, then we mark everything in the DFS stack as
a RESULT. This expands the set of targets for the other from commits. We
also mark the visited commits using 'assign_flag' to prevent re-walking
the same code.

We still need to clear our flags at the end, which is why we will have a
total of three visits to each commit.

Performance was measured on the Linux repository using
'test-tool reach can_all_from_reach'. The input included rows seeded by
tag values. The "small" case included X-rows as v4.[0-9]* and Y-rows as
v3.[0-9]*. This mimics a (very large) fetch that says "I have all major
v3 releases and want all major v4 releases." The "large" case included
X-rows as "v4.*" and Y-rows as "v3.*". This adds all release-candidate
tags to the set, which does not greatly increase the number of objects
that are considered, but does increase the number of 'from' commits,
demonstrating the quadratic nature of the previous code.

Small Case
----------

Before: 1.52 s
 After: 0.26 s

Large Case
----------

Before: 3.50 s
 After: 0.27 s

Note how the time increases between the two cases in the two versions.
The new code increases relative to the number of commits that need to be
walked, but not directly relative to the number of 'from' commits.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 124 ++++++++++++++++++++++++++++++-------------------
 commit-reach.h |   6 ++-
 upload-pack.c  |   5 +-
 3 files changed, 85 insertions(+), 50 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index c58e50fbb..ac132c8e4 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -513,65 +513,88 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 	return is_descendant_of(commit, list);
 }
 
-int reachable(struct commit *from, int with_flag, int assign_flag,
-	      time_t min_commit_date)
+static int compare_commits_by_gen(const void *_a, const void *_b)
 {
-	struct prio_queue work = { compare_commits_by_commit_date };
+	const struct commit *a = (const struct commit *)_a;
+	const struct commit *b = (const struct commit *)_b;
 
-	prio_queue_put(&work, from);
-	while (work.nr) {
-		struct commit_list *list;
-		struct commit *commit = prio_queue_get(&work);
-
-		if (commit->object.flags & with_flag) {
-			from->object.flags |= assign_flag;
-			break;
-		}
-		if (!commit->object.parsed)
-			parse_object(the_repository, &commit->object.oid);
-		if (commit->object.flags & REACHABLE)
-			continue;
-		commit->object.flags |= REACHABLE;
-		if (commit->date < min_commit_date)
-			continue;
-		for (list = commit->parents; list; list = list->next) {
-			struct commit *parent = list->item;
-			if (!(parent->object.flags & REACHABLE))
-				prio_queue_put(&work, parent);
-		}
-	}
-	from->object.flags |= REACHABLE;
-	clear_commit_marks(from, REACHABLE);
-	clear_prio_queue(&work);
-	return (from->object.flags & assign_flag);
+	if (a->generation < b->generation)
+		return -1;
+	if (a->generation > b->generation)
+		return 1;
+	return 0;
 }
 
 int can_all_from_reach_with_flag(struct object_array *from,
 				 int with_flag, int assign_flag,
-				 time_t min_commit_date)
+				 time_t min_commit_date,
+				 uint32_t min_generation)
 {
+	struct commit **list = NULL;
 	int i;
+	int result = 1;
 
+	ALLOC_ARRAY(list, from->nr);
 	for (i = 0; i < from->nr; i++) {
-		struct object *from_one = from->objects[i].item;
+		list[i] = (struct commit *)from->objects[i].item;
 
-		if (from_one->flags & assign_flag)
-			continue;
-		from_one = deref_tag(the_repository, from_one, "a from object", 0);
-		if (!from_one || from_one->type != OBJ_COMMIT) {
-			/* no way to tell if this is reachable by
-			 * looking at the ancestry chain alone, so
-			 * leave a note to ourselves not to worry about
-			 * this object anymore.
-			 */
-			from->objects[i].item->flags |= assign_flag;
-			continue;
-		}
-		if (!reachable((struct commit *)from_one, with_flag, assign_flag,
-			       min_commit_date))
+		parse_commit(list[i]);
+
+		if (list[i]->generation < min_generation)
 			return 0;
 	}
-	return 1;
+
+	QSORT(list, from->nr, compare_commits_by_gen);
+
+	for (i = 0; i < from->nr; i++) {
+		/* DFS from list[i] */
+		struct commit_list *stack = NULL;
+
+		list[i]->object.flags |= assign_flag;
+		commit_list_insert(list[i], &stack);
+
+		while (stack) {
+			struct commit_list *parent;
+
+			if (stack->item->object.flags & with_flag) {
+				pop_commit(&stack);
+				continue;
+			}
+
+			for (parent = stack->item->parents; parent; parent = parent->next) {
+				if (parent->item->object.flags & (with_flag | RESULT))
+					stack->item->object.flags |= RESULT;
+
+				if (!(parent->item->object.flags & assign_flag)) {
+					parent->item->object.flags |= assign_flag;
+
+					parse_commit(parent->item);
+
+					if (parent->item->date < min_commit_date ||
+					    parent->item->generation < min_generation)
+						continue;
+
+					commit_list_insert(parent->item, &stack);
+					break;
+				}
+			}
+
+			if (!parent)
+				pop_commit(&stack);
+		}
+
+		if (!(list[i]->object.flags & (with_flag | RESULT))) {
+			result = 0;
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	for (i = 0; i < from->nr; i++) {
+		clear_commit_marks(list[i], RESULT);
+		clear_commit_marks(list[i], assign_flag);
+	}
+	return result;
 }
 
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
@@ -581,6 +604,7 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	time_t min_commit_date = cutoff_by_min_date ? from->item->date : 0;
 	struct commit_list *from_iter = from, *to_iter = to;
 	int result;
+	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
 
 	while (from_iter) {
 		add_object_array(&from_iter->item->object, NULL, &from_objs);
@@ -588,6 +612,9 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		if (!parse_commit(from_iter->item)) {
 			if (from_iter->item->date < min_commit_date)
 				min_commit_date = from_iter->item->date;
+
+			if (from_iter->item->generation < min_generation)
+				min_generation = from_iter->item->generation;
 		}
 
 		from_iter = from_iter->next;
@@ -597,6 +624,9 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		if (!parse_commit(to_iter->item)) {
 			if (to_iter->item->date < min_commit_date)
 				min_commit_date = to_iter->item->date;
+
+			if (to_iter->item->generation < min_generation)
+				min_generation = to_iter->item->generation;
 		}
 
 		to_iter->item->object.flags |= PARENT2;
@@ -605,7 +635,7 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	}
 
 	result = can_all_from_reach_with_flag(&from_objs, PARENT2, PARENT1,
-					      min_commit_date);
+					      min_commit_date, min_generation);
 
 	while (from) {
 		clear_commit_marks(from->item, PARENT1);
diff --git a/commit-reach.h b/commit-reach.h
index 58de0df56..482d9eb5d 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -63,11 +63,13 @@ int reachable(struct commit *from, int with_flag, int assign_flag,
  * Determine if every commit in 'from' can reach at least one commit
  * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
  * as a marker for commits that are already visited. Do not walk
- * commits with date below 'min_commit_date'.
+ * commits with date below 'min_commit_date' or generation below
+ * 'min_generation'.
  */
 int can_all_from_reach_with_flag(struct object_array *from,
 				 int with_flag, int assign_flag,
-				 time_t min_commit_date);
+				 time_t min_commit_date,
+				 uint32_t min_generation);
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		       int commit_date_cutoff);
 
diff --git a/upload-pack.c b/upload-pack.c
index 11c426685..1e498f118 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -338,11 +338,14 @@ static int got_oid(const char *hex, struct object_id *oid)
 
 static int ok_to_give_up(void)
 {
+	uint32_t min_generation = GENERATION_NUMBER_ZERO;
+
 	if (!have_obj.nr)
 		return 0;
 
 	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE,
-					    COMMON_KNOWN, oldest_have);
+					    COMMON_KNOWN, oldest_have,
+					    min_generation);
 }
 
 static int get_common_commits(void)
-- 
gitgitgadget

