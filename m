Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133111F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbeGPN1l (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34112 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeGPN1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so7472503pgv.1
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5dnKjgjxVe2YSPjA04fVPsuNLnfIYhjAxrWGdh2LcAw=;
        b=ZW2VAX8JYPBMVExbV4PUrSg8PJYgyCOUM07YlBxkDS8nkppJJvAXAq8HLM0ZPohwMA
         NYgymDsR2X8+PqoDAnEVdJhzNWSFqSa5iTjXnor7U8unS2OvmYaxDLj2LH6mtO2wQBCX
         JqO6akijL3hAY4qzMGE6dMs4ELhVbfL7R7HS4xziBWMdZ323PO8hKD6T5DiIecsIS+4s
         ewVxM2owpuha2PV6a/e6kXg2njboDwzEhAZpSCo27GQcvjumxXXSRp1rMdbQyASdV0mE
         5igzx/w/UdXW6ugodZ5ZL1VCd9w6fIzwGYNmfI8z782lXkpV4Bkz5UbZi24u3dhSMa8z
         U9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5dnKjgjxVe2YSPjA04fVPsuNLnfIYhjAxrWGdh2LcAw=;
        b=IqvSgJ5fNenQoixfF1cGDCQF0lgl2u4ejVKaO9uePiUGT/tYDQ7R3I21bPmUvWOD76
         kdgsCmN7EGlqk6hYNJf4eRrPq8+4+GXr5s1DtEeIbY7j0RqxBIbkcMNQgdkNQ0xmhBHc
         T/Q3yB5sSjo2zbPiOmBDS1W440aj9889euKJgJKy1a8QUNymNhdHWgzRvIWcLQfYJyIi
         EO+Q4bJ9BlP0SQP2rs5Vt+dr0FG9qry6kvGMwwC0NnjvZcz9fwK8j0jGGzHFIxllDI3U
         SI3rhHJtDr0Lf6GE0Yrbd0Cpbf2kx09rhPs1RYnUI2TI5zhs5PDqhW0LpOdDdBvwC/Ap
         qPnA==
X-Gm-Message-State: AOUpUlFHuej3kyminhEzuO/+cMBi8fqKZHxK2sp1Qtxk+Wb+1O9qITN+
        i+LiWiUDmdERNocgJuXM/y5iiA==
X-Google-Smtp-Source: AAOMgpdM4QJFUAxWL4glT8DFHW/KolDKE/l9+Wkblhvw5s/E5tPi0n1bCqCMGgT9vQhep+tR75j/Jg==
X-Received: by 2002:a63:455c:: with SMTP id u28-v6mr15506201pgk.210.1531746019306;
        Mon, 16 Jul 2018 06:00:19 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id l84-v6sm11930284pfg.3.2018.07.16.06.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:18 -0700 (PDT)
Message-Id: <b9687d2b21c4560178a509572770e3a058582a8b.1531746010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jun 2018 14:01:28 -0400
Subject: [PATCH 03/16] commit-reach: move commit_contains from ref-filter
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 120 ++++++++++++++++++++++++++++++++++++++++
 commit-reach.h |  18 +++++-
 fast-import.c  |   1 +
 ref-filter.c   | 147 +++----------------------------------------------
 4 files changed, 146 insertions(+), 140 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index a6bc4781a..9e56f90ea 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "commit-graph.h"
 #include "decorate.h"
 #include "prio-queue.h"
 #include "tree.h"
@@ -411,3 +412,122 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	unmark_and_free(used, TMP_MARK);
 	return found;
 }
+
+/*
+ * Mimicking the real stack, this stack lives on the heap, avoiding stack
+ * overflows.
+ *
+ * At each recursion step, the stack items points to the commits whose
+ * ancestors are to be inspected.
+ */
+struct contains_stack {
+	int nr, alloc;
+	struct contains_stack_entry {
+		struct commit *commit;
+		struct commit_list *parents;
+	} *contains_stack;
+};
+
+static int in_commit_list(const struct commit_list *want, struct commit *c)
+{
+	for (; want; want = want->next)
+		if (!oidcmp(&want->item->object.oid, &c->object.oid))
+			return 1;
+	return 0;
+}
+
+/*
+ * Test whether the candidate is contained in the list.
+ * Do not recurse to find out, though, but return -1 if inconclusive.
+ */
+static enum contains_result contains_test(struct commit *candidate,
+					  const struct commit_list *want,
+					  struct contains_cache *cache,
+					  uint32_t cutoff)
+{
+	enum contains_result *cached = contains_cache_at(cache, candidate);
+
+	/* If we already have the answer cached, return that. */
+	if (*cached)
+		return *cached;
+
+	/* or are we it? */
+	if (in_commit_list(want, candidate)) {
+		*cached = CONTAINS_YES;
+		return CONTAINS_YES;
+	}
+
+	/* Otherwise, we don't know; prepare to recurse */
+	parse_commit_or_die(candidate);
+
+	if (candidate->generation < cutoff)
+		return CONTAINS_NO;
+
+	return CONTAINS_UNKNOWN;
+}
+
+static void push_to_contains_stack(struct commit *candidate, struct contains_stack *contains_stack)
+{
+	ALLOC_GROW(contains_stack->contains_stack, contains_stack->nr + 1, contains_stack->alloc);
+	contains_stack->contains_stack[contains_stack->nr].commit = candidate;
+	contains_stack->contains_stack[contains_stack->nr++].parents = candidate->parents;
+}
+
+static enum contains_result contains_tag_algo(struct commit *candidate,
+					      const struct commit_list *want,
+					      struct contains_cache *cache)
+{
+	struct contains_stack contains_stack = { 0, 0, NULL };
+	enum contains_result result;
+	uint32_t cutoff = GENERATION_NUMBER_INFINITY;
+	const struct commit_list *p;
+
+	for (p = want; p; p = p->next) {
+		struct commit *c = p->item;
+		load_commit_graph_info(the_repository, c);
+		if (c->generation < cutoff)
+			cutoff = c->generation;
+	}
+
+	result = contains_test(candidate, want, cache, cutoff);
+	if (result != CONTAINS_UNKNOWN)
+		return result;
+
+	push_to_contains_stack(candidate, &contains_stack);
+	while (contains_stack.nr) {
+		struct contains_stack_entry *entry = &contains_stack.contains_stack[contains_stack.nr - 1];
+		struct commit *commit = entry->commit;
+		struct commit_list *parents = entry->parents;
+
+		if (!parents) {
+			*contains_cache_at(cache, commit) = CONTAINS_NO;
+			contains_stack.nr--;
+		}
+		/*
+		 * If we just popped the stack, parents->item has been marked,
+		 * therefore contains_test will return a meaningful yes/no.
+		 */
+		else switch (contains_test(parents->item, want, cache, cutoff)) {
+		case CONTAINS_YES:
+			*contains_cache_at(cache, commit) = CONTAINS_YES;
+			contains_stack.nr--;
+			break;
+		case CONTAINS_NO:
+			entry->parents = parents->next;
+			break;
+		case CONTAINS_UNKNOWN:
+			push_to_contains_stack(parents->item, &contains_stack);
+			break;
+		}
+	}
+	free(contains_stack.contains_stack);
+	return contains_test(candidate, want, cache, cutoff);
+}
+
+int commit_contains(struct ref_filter *filter, struct commit *commit,
+		    struct commit_list *list, struct contains_cache *cache)
+{
+	if (filter->with_commit_tag_algo)
+		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
+	return is_descendant_of(commit, list);
+}
diff --git a/commit-reach.h b/commit-reach.h
index 35ec9f0dd..925cb05d7 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -2,6 +2,8 @@
 #define __COMMIT_REACH_H__
 
 #include "commit.h"
+#include "commit-slab.h"
+#include "ref-filter.h"
 
 struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
@@ -19,7 +21,6 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
 int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
 int in_merge_bases(struct commit *commit, struct commit *reference);
 
-
 /*
  * Takes a list of commits and returns a new list where those
  * have been removed that can be reached from other commits in
@@ -40,4 +41,19 @@ void reduce_heads_replace(struct commit_list **heads);
 
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
 
+/*
+ * Unknown has to be "0" here, because that's the default value for
+ * contains_cache slab entries that have not yet been assigned.
+ */
+enum contains_result {
+	CONTAINS_UNKNOWN = 0,
+	CONTAINS_NO,
+	CONTAINS_YES
+};
+
+define_commit_slab(contains_cache, enum contains_result);
+
+int commit_contains(struct ref_filter *filter, struct commit *commit,
+		    struct commit_list *list, struct contains_cache *cache);
+
 #endif
diff --git a/fast-import.c b/fast-import.c
index 3ea578102..4a93df383 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -171,6 +171,7 @@ Format of STDIN stream:
 #include "packfile.h"
 #include "object-store.h"
 #include "mem-pool.h"
+#include "commit-reach.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
diff --git a/ref-filter.c b/ref-filter.c
index 9b2da8839..35b2d25ce 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -18,7 +18,7 @@
 #include "trailer.h"
 #include "wt-status.h"
 #include "commit-slab.h"
-#include "commit-graph.h"
+#include "commit-reach.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -1623,144 +1623,6 @@ static int get_ref_atom_value(struct ref_array_item *ref, int atom,
 	return 0;
 }
 
-/*
- * Unknown has to be "0" here, because that's the default value for
- * contains_cache slab entries that have not yet been assigned.
- */
-enum contains_result {
-	CONTAINS_UNKNOWN = 0,
-	CONTAINS_NO,
-	CONTAINS_YES
-};
-
-define_commit_slab(contains_cache, enum contains_result);
-
-struct ref_filter_cbdata {
-	struct ref_array *array;
-	struct ref_filter *filter;
-	struct contains_cache contains_cache;
-	struct contains_cache no_contains_cache;
-};
-
-/*
- * Mimicking the real stack, this stack lives on the heap, avoiding stack
- * overflows.
- *
- * At each recursion step, the stack items points to the commits whose
- * ancestors are to be inspected.
- */
-struct contains_stack {
-	int nr, alloc;
-	struct contains_stack_entry {
-		struct commit *commit;
-		struct commit_list *parents;
-	} *contains_stack;
-};
-
-static int in_commit_list(const struct commit_list *want, struct commit *c)
-{
-	for (; want; want = want->next)
-		if (!oidcmp(&want->item->object.oid, &c->object.oid))
-			return 1;
-	return 0;
-}
-
-/*
- * Test whether the candidate is contained in the list.
- * Do not recurse to find out, though, but return -1 if inconclusive.
- */
-static enum contains_result contains_test(struct commit *candidate,
-					  const struct commit_list *want,
-					  struct contains_cache *cache,
-					  uint32_t cutoff)
-{
-	enum contains_result *cached = contains_cache_at(cache, candidate);
-
-	/* If we already have the answer cached, return that. */
-	if (*cached)
-		return *cached;
-
-	/* or are we it? */
-	if (in_commit_list(want, candidate)) {
-		*cached = CONTAINS_YES;
-		return CONTAINS_YES;
-	}
-
-	/* Otherwise, we don't know; prepare to recurse */
-	parse_commit_or_die(candidate);
-
-	if (candidate->generation < cutoff)
-		return CONTAINS_NO;
-
-	return CONTAINS_UNKNOWN;
-}
-
-static void push_to_contains_stack(struct commit *candidate, struct contains_stack *contains_stack)
-{
-	ALLOC_GROW(contains_stack->contains_stack, contains_stack->nr + 1, contains_stack->alloc);
-	contains_stack->contains_stack[contains_stack->nr].commit = candidate;
-	contains_stack->contains_stack[contains_stack->nr++].parents = candidate->parents;
-}
-
-static enum contains_result contains_tag_algo(struct commit *candidate,
-					      const struct commit_list *want,
-					      struct contains_cache *cache)
-{
-	struct contains_stack contains_stack = { 0, 0, NULL };
-	enum contains_result result;
-	uint32_t cutoff = GENERATION_NUMBER_INFINITY;
-	const struct commit_list *p;
-
-	for (p = want; p; p = p->next) {
-		struct commit *c = p->item;
-		load_commit_graph_info(the_repository, c);
-		if (c->generation < cutoff)
-			cutoff = c->generation;
-	}
-
-	result = contains_test(candidate, want, cache, cutoff);
-	if (result != CONTAINS_UNKNOWN)
-		return result;
-
-	push_to_contains_stack(candidate, &contains_stack);
-	while (contains_stack.nr) {
-		struct contains_stack_entry *entry = &contains_stack.contains_stack[contains_stack.nr - 1];
-		struct commit *commit = entry->commit;
-		struct commit_list *parents = entry->parents;
-
-		if (!parents) {
-			*contains_cache_at(cache, commit) = CONTAINS_NO;
-			contains_stack.nr--;
-		}
-		/*
-		 * If we just popped the stack, parents->item has been marked,
-		 * therefore contains_test will return a meaningful yes/no.
-		 */
-		else switch (contains_test(parents->item, want, cache, cutoff)) {
-		case CONTAINS_YES:
-			*contains_cache_at(cache, commit) = CONTAINS_YES;
-			contains_stack.nr--;
-			break;
-		case CONTAINS_NO:
-			entry->parents = parents->next;
-			break;
-		case CONTAINS_UNKNOWN:
-			push_to_contains_stack(parents->item, &contains_stack);
-			break;
-		}
-	}
-	free(contains_stack.contains_stack);
-	return contains_test(candidate, want, cache, cutoff);
-}
-
-static int commit_contains(struct ref_filter *filter, struct commit *commit,
-			   struct commit_list *list, struct contains_cache *cache)
-{
-	if (filter->with_commit_tag_algo)
-		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
-	return is_descendant_of(commit, list);
-}
-
 /*
  * Return 1 if the refname matches one of the patterns, otherwise 0.
  * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
@@ -1987,6 +1849,13 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 	return ref_kind_from_refname(refname);
 }
 
+struct ref_filter_cbdata {
+	struct ref_array *array;
+	struct ref_filter *filter;
+	struct contains_cache contains_cache;
+	struct contains_cache no_contains_cache;
+};
+
 /*
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
-- 
gitgitgadget

