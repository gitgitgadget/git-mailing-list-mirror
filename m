Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFE51F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeGPN1i (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39080 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbeGPN1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:37 -0400
Received: by mail-pl0-f66.google.com with SMTP id p23-v6so3965828plo.6
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=phSAN+LavDXt+Vt49PGInoUfvtto1wdOSOtVH8GSCyA=;
        b=Zk192wNjhmXmpdwxkve8fpj9P97W7HbgE8ye7rkgCpjpXQ/qzlttV7Uc/GL3vozm/3
         oREV0j7MD6WvXz1oEI6r0FaIFZectIJOOxpWIFFSTf79OlCsF87CkHGR+nWN0acyxA10
         AtegnfClhZy53LC1tzAzS0WhRrVHgRgi6VNV4p4r3c2U6QHKIOmrIqcew+cgPvIgIXQT
         hfHuoku03MTcFDyfz2pjOHkkXWxEu7NkJYmkDWhyeieQYW8SoJ9m4ILE6a/b66MzIGhz
         XGPf39xsM/rSVBGV/6rL4hOQrAESynd66gWvcwRLcCV6mm9y7F5SzbV1gospEw0Ke961
         0zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=phSAN+LavDXt+Vt49PGInoUfvtto1wdOSOtVH8GSCyA=;
        b=TXApxeRyJ6thpLHV507tv1mofNqgoklLmUaGjVSnfktLXfP+mFgqOL0sDrm6lPU2w2
         jyLDqh/yP/jo7cRR2sTh7CrKLz222l6qWT336WX8ZIVoEymFmFiDFRqbfbZh6EexsPpa
         eHpUUBvf1wQVGG9JPVkCBiOuj7YSgMlSk/yBJ9xzZ+PYAyKr+wC9/ThSetbuvGU83NIb
         sIvAxqT1YPg48OGWmmSiKZX7UVKVykVFlQ4G70i5q0X+RPzrMSwGA4PXYBDo3tASlp53
         gJWvjSYGfb9XRCg8XbGzG80tqw3OW3r1ugilxKPhG6AgfD9ljxvdxwPk+eJAwFXaRpyS
         pVdQ==
X-Gm-Message-State: AOUpUlG3lEs49ud2ZVVTMls1kXnMsdWMcW0gUBC8aNeC1eyT7uq6VSDa
        a1+ulm+wXHYauS2KUzW1sMZ9PA==
X-Google-Smtp-Source: AAOMgpcsOr8VCKaQDgPJjRyCxrxCE9aJqbt234c/NAHFhZCuTq6RMASEFKN2/g9JS2RiWnVzrhgdxA==
X-Received: by 2002:a17:902:4081:: with SMTP id c1-v6mr16488622pld.169.1531746016555;
        Mon, 16 Jul 2018 06:00:16 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id l71-v6sm27206996pgd.70.2018.07.16.06.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:15 -0700 (PDT)
Message-Id: <01bef3d654845236e9115ebc33d80673b7b4a5a2.1531746009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jun 2018 13:16:47 -0400
Subject: [PATCH 01/16] commit-reach: move walk methods from commit.c
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
 Makefile       |   1 +
 commit-reach.c | 359 +++++++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h |  41 ++++++
 commit.c       | 358 ------------------------------------------------
 4 files changed, 401 insertions(+), 358 deletions(-)
 create mode 100644 commit-reach.c
 create mode 100644 commit-reach.h

diff --git a/Makefile b/Makefile
index bb8bd6720..59781f4bc 100644
--- a/Makefile
+++ b/Makefile
@@ -829,6 +829,7 @@ LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
 LIB_OBJS += commit-graph.o
+LIB_OBJS += commit-reach.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
diff --git a/commit-reach.c b/commit-reach.c
new file mode 100644
index 000000000..f2e2f7461
--- /dev/null
+++ b/commit-reach.c
@@ -0,0 +1,359 @@
+#include "cache.h"
+#include "prio-queue.h"
+#include "commit-reach.h"
+
+/* Remember to update object flag allocation in object.h */
+#define PARENT1		(1u<<16)
+#define PARENT2		(1u<<17)
+#define STALE		(1u<<18)
+#define RESULT		(1u<<19)
+
+static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
+
+static int queue_has_nonstale(struct prio_queue *queue)
+{
+	int i;
+	for (i = 0; i < queue->nr; i++) {
+		struct commit *commit = queue->array[i].data;
+		if (!(commit->object.flags & STALE))
+			return 1;
+	}
+	return 0;
+}
+
+/* all input commits in one and twos[] must have been parsed! */
+static struct commit_list *paint_down_to_common(struct commit *one, int n,
+						struct commit **twos,
+						int min_generation)
+{
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	struct commit_list *result = NULL;
+	int i;
+	uint32_t last_gen = GENERATION_NUMBER_INFINITY;
+
+	one->object.flags |= PARENT1;
+	if (!n) {
+		commit_list_append(one, &result);
+		return result;
+	}
+	prio_queue_put(&queue, one);
+
+	for (i = 0; i < n; i++) {
+		twos[i]->object.flags |= PARENT2;
+		prio_queue_put(&queue, twos[i]);
+	}
+
+	while (queue_has_nonstale(&queue)) {
+		struct commit *commit = prio_queue_get(&queue);
+		struct commit_list *parents;
+		int flags;
+
+		if (commit->generation > last_gen)
+			BUG("bad generation skip %8x > %8x at %s",
+			    commit->generation, last_gen,
+			    oid_to_hex(&commit->object.oid));
+		last_gen = commit->generation;
+
+		if (commit->generation < min_generation)
+			break;
+
+		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
+		if (flags == (PARENT1 | PARENT2)) {
+			if (!(commit->object.flags & RESULT)) {
+				commit->object.flags |= RESULT;
+				commit_list_insert_by_date(commit, &result);
+			}
+			/* Mark parents of a found merge stale */
+			flags |= STALE;
+		}
+		parents = commit->parents;
+		while (parents) {
+			struct commit *p = parents->item;
+			parents = parents->next;
+			if ((p->object.flags & flags) == flags)
+				continue;
+			if (parse_commit(p))
+				return NULL;
+			p->object.flags |= flags;
+			prio_queue_put(&queue, p);
+		}
+	}
+
+	clear_prio_queue(&queue);
+	return result;
+}
+
+static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
+{
+	struct commit_list *list = NULL;
+	struct commit_list *result = NULL;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (one == twos[i])
+			/*
+			 * We do not mark this even with RESULT so we do not
+			 * have to clean it up.
+			 */
+			return commit_list_insert(one, &result);
+	}
+
+	if (parse_commit(one))
+		return NULL;
+	for (i = 0; i < n; i++) {
+		if (parse_commit(twos[i]))
+			return NULL;
+	}
+
+	list = paint_down_to_common(one, n, twos, 0);
+
+	while (list) {
+		struct commit *commit = pop_commit(&list);
+		if (!(commit->object.flags & STALE))
+			commit_list_insert_by_date(commit, &result);
+	}
+	return result;
+}
+
+struct commit_list *get_octopus_merge_bases(struct commit_list *in)
+{
+	struct commit_list *i, *j, *k, *ret = NULL;
+
+	if (!in)
+		return ret;
+
+	commit_list_insert(in->item, &ret);
+
+	for (i = in->next; i; i = i->next) {
+		struct commit_list *new_commits = NULL, *end = NULL;
+
+		for (j = ret; j; j = j->next) {
+			struct commit_list *bases;
+			bases = get_merge_bases(i->item, j->item);
+			if (!new_commits)
+				new_commits = bases;
+			else
+				end->next = bases;
+			for (k = bases; k; k = k->next)
+				end = k;
+		}
+		ret = new_commits;
+	}
+	return ret;
+}
+
+static int remove_redundant(struct commit **array, int cnt)
+{
+	/*
+	 * Some commit in the array may be an ancestor of
+	 * another commit.  Move such commit to the end of
+	 * the array, and return the number of commits that
+	 * are independent from each other.
+	 */
+	struct commit **work;
+	unsigned char *redundant;
+	int *filled_index;
+	int i, j, filled;
+
+	work = xcalloc(cnt, sizeof(*work));
+	redundant = xcalloc(cnt, 1);
+	ALLOC_ARRAY(filled_index, cnt - 1);
+
+	for (i = 0; i < cnt; i++)
+		parse_commit(array[i]);
+	for (i = 0; i < cnt; i++) {
+		struct commit_list *common;
+		uint32_t min_generation = array[i]->generation;
+
+		if (redundant[i])
+			continue;
+		for (j = filled = 0; j < cnt; j++) {
+			if (i == j || redundant[j])
+				continue;
+			filled_index[filled] = j;
+			work[filled++] = array[j];
+
+			if (array[j]->generation < min_generation)
+				min_generation = array[j]->generation;
+		}
+		common = paint_down_to_common(array[i], filled, work,
+					      min_generation);
+		if (array[i]->object.flags & PARENT2)
+			redundant[i] = 1;
+		for (j = 0; j < filled; j++)
+			if (work[j]->object.flags & PARENT1)
+				redundant[filled_index[j]] = 1;
+		clear_commit_marks(array[i], all_flags);
+		clear_commit_marks_many(filled, work, all_flags);
+		free_commit_list(common);
+	}
+
+	/* Now collect the result */
+	COPY_ARRAY(work, array, cnt);
+	for (i = filled = 0; i < cnt; i++)
+		if (!redundant[i])
+			array[filled++] = work[i];
+	for (j = filled, i = 0; i < cnt; i++)
+		if (redundant[i])
+			array[j++] = work[i];
+	free(work);
+	free(redundant);
+	free(filled_index);
+	return filled;
+}
+
+static struct commit_list *get_merge_bases_many_0(struct commit *one,
+						  int n,
+						  struct commit **twos,
+						  int cleanup)
+{
+	struct commit_list *list;
+	struct commit **rslt;
+	struct commit_list *result;
+	int cnt, i;
+
+	result = merge_bases_many(one, n, twos);
+	for (i = 0; i < n; i++) {
+		if (one == twos[i])
+			return result;
+	}
+	if (!result || !result->next) {
+		if (cleanup) {
+			clear_commit_marks(one, all_flags);
+			clear_commit_marks_many(n, twos, all_flags);
+		}
+		return result;
+	}
+
+	/* There are more than one */
+	cnt = commit_list_count(result);
+	rslt = xcalloc(cnt, sizeof(*rslt));
+	for (list = result, i = 0; list; list = list->next)
+		rslt[i++] = list->item;
+	free_commit_list(result);
+
+	clear_commit_marks(one, all_flags);
+	clear_commit_marks_many(n, twos, all_flags);
+
+	cnt = remove_redundant(rslt, cnt);
+	result = NULL;
+	for (i = 0; i < cnt; i++)
+		commit_list_insert_by_date(rslt[i], &result);
+	free(rslt);
+	return result;
+}
+
+struct commit_list *get_merge_bases_many(struct commit *one,
+					 int n,
+					 struct commit **twos)
+{
+	return get_merge_bases_many_0(one, n, twos, 1);
+}
+
+struct commit_list *get_merge_bases_many_dirty(struct commit *one,
+					       int n,
+					       struct commit **twos)
+{
+	return get_merge_bases_many_0(one, n, twos, 0);
+}
+
+struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
+{
+	return get_merge_bases_many_0(one, 1, &two, 1);
+}
+
+/*
+ * Is "commit" a descendant of one of the elements on the "with_commit" list?
+ */
+int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
+{
+	if (!with_commit)
+		return 1;
+	while (with_commit) {
+		struct commit *other;
+
+		other = with_commit->item;
+		with_commit = with_commit->next;
+		if (in_merge_bases(other, commit))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Is "commit" an ancestor of one of the "references"?
+ */
+int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference)
+{
+	struct commit_list *bases;
+	int ret = 0, i;
+	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
+
+	if (parse_commit(commit))
+		return ret;
+	for (i = 0; i < nr_reference; i++) {
+		if (parse_commit(reference[i]))
+			return ret;
+		if (reference[i]->generation < min_generation)
+			min_generation = reference[i]->generation;
+	}
+
+	if (commit->generation > min_generation)
+		return ret;
+
+	bases = paint_down_to_common(commit, nr_reference, reference, commit->generation);
+	if (commit->object.flags & PARENT2)
+		ret = 1;
+	clear_commit_marks(commit, all_flags);
+	clear_commit_marks_many(nr_reference, reference, all_flags);
+	free_commit_list(bases);
+	return ret;
+}
+
+/*
+ * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
+ */
+int in_merge_bases(struct commit *commit, struct commit *reference)
+{
+	return in_merge_bases_many(commit, 1, &reference);
+}
+
+struct commit_list *reduce_heads(struct commit_list *heads)
+{
+	struct commit_list *p;
+	struct commit_list *result = NULL, **tail = &result;
+	struct commit **array;
+	int num_head, i;
+
+	if (!heads)
+		return NULL;
+
+	/* Uniquify */
+	for (p = heads; p; p = p->next)
+		p->item->object.flags &= ~STALE;
+	for (p = heads, num_head = 0; p; p = p->next) {
+		if (p->item->object.flags & STALE)
+			continue;
+		p->item->object.flags |= STALE;
+		num_head++;
+	}
+	array = xcalloc(num_head, sizeof(*array));
+	for (p = heads, i = 0; p; p = p->next) {
+		if (p->item->object.flags & STALE) {
+			array[i++] = p->item;
+			p->item->object.flags &= ~STALE;
+		}
+	}
+	num_head = remove_redundant(array, num_head);
+	for (i = 0; i < num_head; i++)
+		tail = &commit_list_insert(array[i], tail)->next;
+	free(array);
+	return result;
+}
+
+void reduce_heads_replace(struct commit_list **heads)
+{
+	struct commit_list *result = reduce_heads(*heads);
+	free_commit_list(*heads);
+	*heads = result;
+}
diff --git a/commit-reach.h b/commit-reach.h
new file mode 100644
index 000000000..244f48c5f
--- /dev/null
+++ b/commit-reach.h
@@ -0,0 +1,41 @@
+#ifndef __COMMIT_REACH_H__
+#define __COMMIT_REACH_H__
+
+#include "commit.h"
+
+struct commit_list *get_merge_bases_many(struct commit *one,
+					 int n,
+					 struct commit **twos);
+struct commit_list *get_merge_bases_many_dirty(struct commit *one,
+					       int n,
+					       struct commit **twos);
+struct commit_list *get_merge_bases(struct commit *one, struct commit *two);
+struct commit_list *get_octopus_merge_bases(struct commit_list *in);
+
+/* To be used only when object flags after this call no longer matter */
+struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
+
+int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
+int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
+int in_merge_bases(struct commit *commit, struct commit *reference);
+
+
+/*
+ * Takes a list of commits and returns a new list where those
+ * have been removed that can be reached from other commits in
+ * the list. It is useful for, e.g., reducing the commits
+ * randomly thrown at the git-merge command and removing
+ * redundant commits that the user shouldn't have given to it.
+ *
+ * This function destroys the STALE bit of the commit objects'
+ * flags.
+ */
+struct commit_list *reduce_heads(struct commit_list *heads);
+
+/*
+ * Like `reduce_heads()`, except it replaces the list. Use this
+ * instead of `foo = reduce_heads(foo);` to avoid memory leaks.
+ */
+void reduce_heads_replace(struct commit_list **heads);
+
+#endif
diff --git a/commit.c b/commit.c
index 39b80bd21..32d1234bd 100644
--- a/commit.c
+++ b/commit.c
@@ -843,364 +843,6 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 		clear_author_date_slab(&author_date);
 }
 
-/* merge-base stuff */
-
-/* Remember to update object flag allocation in object.h */
-#define PARENT1		(1u<<16)
-#define PARENT2		(1u<<17)
-#define STALE		(1u<<18)
-#define RESULT		(1u<<19)
-
-static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
-
-static int queue_has_nonstale(struct prio_queue *queue)
-{
-	int i;
-	for (i = 0; i < queue->nr; i++) {
-		struct commit *commit = queue->array[i].data;
-		if (!(commit->object.flags & STALE))
-			return 1;
-	}
-	return 0;
-}
-
-/* all input commits in one and twos[] must have been parsed! */
-static struct commit_list *paint_down_to_common(struct commit *one, int n,
-						struct commit **twos,
-						int min_generation)
-{
-	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
-	struct commit_list *result = NULL;
-	int i;
-	uint32_t last_gen = GENERATION_NUMBER_INFINITY;
-
-	one->object.flags |= PARENT1;
-	if (!n) {
-		commit_list_append(one, &result);
-		return result;
-	}
-	prio_queue_put(&queue, one);
-
-	for (i = 0; i < n; i++) {
-		twos[i]->object.flags |= PARENT2;
-		prio_queue_put(&queue, twos[i]);
-	}
-
-	while (queue_has_nonstale(&queue)) {
-		struct commit *commit = prio_queue_get(&queue);
-		struct commit_list *parents;
-		int flags;
-
-		if (commit->generation > last_gen)
-			BUG("bad generation skip %8x > %8x at %s",
-			    commit->generation, last_gen,
-			    oid_to_hex(&commit->object.oid));
-		last_gen = commit->generation;
-
-		if (commit->generation < min_generation)
-			break;
-
-		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
-		if (flags == (PARENT1 | PARENT2)) {
-			if (!(commit->object.flags & RESULT)) {
-				commit->object.flags |= RESULT;
-				commit_list_insert_by_date(commit, &result);
-			}
-			/* Mark parents of a found merge stale */
-			flags |= STALE;
-		}
-		parents = commit->parents;
-		while (parents) {
-			struct commit *p = parents->item;
-			parents = parents->next;
-			if ((p->object.flags & flags) == flags)
-				continue;
-			if (parse_commit(p))
-				return NULL;
-			p->object.flags |= flags;
-			prio_queue_put(&queue, p);
-		}
-	}
-
-	clear_prio_queue(&queue);
-	return result;
-}
-
-static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
-{
-	struct commit_list *list = NULL;
-	struct commit_list *result = NULL;
-	int i;
-
-	for (i = 0; i < n; i++) {
-		if (one == twos[i])
-			/*
-			 * We do not mark this even with RESULT so we do not
-			 * have to clean it up.
-			 */
-			return commit_list_insert(one, &result);
-	}
-
-	if (parse_commit(one))
-		return NULL;
-	for (i = 0; i < n; i++) {
-		if (parse_commit(twos[i]))
-			return NULL;
-	}
-
-	list = paint_down_to_common(one, n, twos, 0);
-
-	while (list) {
-		struct commit *commit = pop_commit(&list);
-		if (!(commit->object.flags & STALE))
-			commit_list_insert_by_date(commit, &result);
-	}
-	return result;
-}
-
-struct commit_list *get_octopus_merge_bases(struct commit_list *in)
-{
-	struct commit_list *i, *j, *k, *ret = NULL;
-
-	if (!in)
-		return ret;
-
-	commit_list_insert(in->item, &ret);
-
-	for (i = in->next; i; i = i->next) {
-		struct commit_list *new_commits = NULL, *end = NULL;
-
-		for (j = ret; j; j = j->next) {
-			struct commit_list *bases;
-			bases = get_merge_bases(i->item, j->item);
-			if (!new_commits)
-				new_commits = bases;
-			else
-				end->next = bases;
-			for (k = bases; k; k = k->next)
-				end = k;
-		}
-		ret = new_commits;
-	}
-	return ret;
-}
-
-static int remove_redundant(struct commit **array, int cnt)
-{
-	/*
-	 * Some commit in the array may be an ancestor of
-	 * another commit.  Move such commit to the end of
-	 * the array, and return the number of commits that
-	 * are independent from each other.
-	 */
-	struct commit **work;
-	unsigned char *redundant;
-	int *filled_index;
-	int i, j, filled;
-
-	work = xcalloc(cnt, sizeof(*work));
-	redundant = xcalloc(cnt, 1);
-	ALLOC_ARRAY(filled_index, cnt - 1);
-
-	for (i = 0; i < cnt; i++)
-		parse_commit(array[i]);
-	for (i = 0; i < cnt; i++) {
-		struct commit_list *common;
-		uint32_t min_generation = array[i]->generation;
-
-		if (redundant[i])
-			continue;
-		for (j = filled = 0; j < cnt; j++) {
-			if (i == j || redundant[j])
-				continue;
-			filled_index[filled] = j;
-			work[filled++] = array[j];
-
-			if (array[j]->generation < min_generation)
-				min_generation = array[j]->generation;
-		}
-		common = paint_down_to_common(array[i], filled, work,
-					      min_generation);
-		if (array[i]->object.flags & PARENT2)
-			redundant[i] = 1;
-		for (j = 0; j < filled; j++)
-			if (work[j]->object.flags & PARENT1)
-				redundant[filled_index[j]] = 1;
-		clear_commit_marks(array[i], all_flags);
-		clear_commit_marks_many(filled, work, all_flags);
-		free_commit_list(common);
-	}
-
-	/* Now collect the result */
-	COPY_ARRAY(work, array, cnt);
-	for (i = filled = 0; i < cnt; i++)
-		if (!redundant[i])
-			array[filled++] = work[i];
-	for (j = filled, i = 0; i < cnt; i++)
-		if (redundant[i])
-			array[j++] = work[i];
-	free(work);
-	free(redundant);
-	free(filled_index);
-	return filled;
-}
-
-static struct commit_list *get_merge_bases_many_0(struct commit *one,
-						  int n,
-						  struct commit **twos,
-						  int cleanup)
-{
-	struct commit_list *list;
-	struct commit **rslt;
-	struct commit_list *result;
-	int cnt, i;
-
-	result = merge_bases_many(one, n, twos);
-	for (i = 0; i < n; i++) {
-		if (one == twos[i])
-			return result;
-	}
-	if (!result || !result->next) {
-		if (cleanup) {
-			clear_commit_marks(one, all_flags);
-			clear_commit_marks_many(n, twos, all_flags);
-		}
-		return result;
-	}
-
-	/* There are more than one */
-	cnt = commit_list_count(result);
-	rslt = xcalloc(cnt, sizeof(*rslt));
-	for (list = result, i = 0; list; list = list->next)
-		rslt[i++] = list->item;
-	free_commit_list(result);
-
-	clear_commit_marks(one, all_flags);
-	clear_commit_marks_many(n, twos, all_flags);
-
-	cnt = remove_redundant(rslt, cnt);
-	result = NULL;
-	for (i = 0; i < cnt; i++)
-		commit_list_insert_by_date(rslt[i], &result);
-	free(rslt);
-	return result;
-}
-
-struct commit_list *get_merge_bases_many(struct commit *one,
-					 int n,
-					 struct commit **twos)
-{
-	return get_merge_bases_many_0(one, n, twos, 1);
-}
-
-struct commit_list *get_merge_bases_many_dirty(struct commit *one,
-					       int n,
-					       struct commit **twos)
-{
-	return get_merge_bases_many_0(one, n, twos, 0);
-}
-
-struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
-{
-	return get_merge_bases_many_0(one, 1, &two, 1);
-}
-
-/*
- * Is "commit" a descendant of one of the elements on the "with_commit" list?
- */
-int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
-{
-	if (!with_commit)
-		return 1;
-	while (with_commit) {
-		struct commit *other;
-
-		other = with_commit->item;
-		with_commit = with_commit->next;
-		if (in_merge_bases(other, commit))
-			return 1;
-	}
-	return 0;
-}
-
-/*
- * Is "commit" an ancestor of one of the "references"?
- */
-int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference)
-{
-	struct commit_list *bases;
-	int ret = 0, i;
-	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
-
-	if (parse_commit(commit))
-		return ret;
-	for (i = 0; i < nr_reference; i++) {
-		if (parse_commit(reference[i]))
-			return ret;
-		if (reference[i]->generation < min_generation)
-			min_generation = reference[i]->generation;
-	}
-
-	if (commit->generation > min_generation)
-		return ret;
-
-	bases = paint_down_to_common(commit, nr_reference, reference, commit->generation);
-	if (commit->object.flags & PARENT2)
-		ret = 1;
-	clear_commit_marks(commit, all_flags);
-	clear_commit_marks_many(nr_reference, reference, all_flags);
-	free_commit_list(bases);
-	return ret;
-}
-
-/*
- * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
- */
-int in_merge_bases(struct commit *commit, struct commit *reference)
-{
-	return in_merge_bases_many(commit, 1, &reference);
-}
-
-struct commit_list *reduce_heads(struct commit_list *heads)
-{
-	struct commit_list *p;
-	struct commit_list *result = NULL, **tail = &result;
-	struct commit **array;
-	int num_head, i;
-
-	if (!heads)
-		return NULL;
-
-	/* Uniquify */
-	for (p = heads; p; p = p->next)
-		p->item->object.flags &= ~STALE;
-	for (p = heads, num_head = 0; p; p = p->next) {
-		if (p->item->object.flags & STALE)
-			continue;
-		p->item->object.flags |= STALE;
-		num_head++;
-	}
-	array = xcalloc(num_head, sizeof(*array));
-	for (p = heads, i = 0; p; p = p->next) {
-		if (p->item->object.flags & STALE) {
-			array[i++] = p->item;
-			p->item->object.flags &= ~STALE;
-		}
-	}
-	num_head = remove_redundant(array, num_head);
-	for (i = 0; i < num_head; i++)
-		tail = &commit_list_insert(array[i], tail)->next;
-	free(array);
-	return result;
-}
-
-void reduce_heads_replace(struct commit_list **heads)
-{
-	struct commit_list *result = reduce_heads(*heads);
-	free_commit_list(*heads);
-	*heads = result;
-}
-
 static const char gpg_sig_header[] = "gpgsig";
 static const int gpg_sig_header_len = sizeof(gpg_sig_header) - 1;
 
-- 
gitgitgadget

