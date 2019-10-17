Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882031F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 20:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437543AbfJQURm (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:17:42 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40110 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQURm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 16:17:42 -0400
Received: by mail-pl1-f202.google.com with SMTP id f10so2195854plr.7
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eozVfvq4ip4nW178ugLyVb+jkghpn2B5c9Z7OGvbiWA=;
        b=TCZ6Js6RW8EzjOjVQV76QaU1DhbjYYu/vPl8pbxsl9QcINfcBP8Cw4BjEjW7Sj3INW
         B7n5jtljNbqn8IqeBnjzTR4WHQS+Mwj6X84Nw3IZfOGF8dGTR1bt+gNsnLB88bvz127p
         5xKygme4OuokGW1UnrgWSeTGckGUIrVH/ilh8JuQG5Tx/c/3YyAD/Moc4tArCv5eJMS1
         iaW+7EVf5NEroSJc3NuBa1bqjX4m0ui3wiasM6hOUujO63AP04lRE43IsBqwkAkUZKmH
         kWpqcbMfh7h30vO3SLFjBEYrnPTBlK2Il+Nffi3HtWVO8X3muY1HDue2/zB7O5Ww+vku
         axfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eozVfvq4ip4nW178ugLyVb+jkghpn2B5c9Z7OGvbiWA=;
        b=lhQvq/VJCLVjs8dNItxOP1yjyR9Lk4m/VzNdJ4YYEzDPmGErwbuua4JkgTqXISyVsT
         qvj8JNoHdbFgFJdMhBXyCKILnAE7+WA8Yh2FmxD9oZwWcWkUDtNU7ftRq+7wsWv1xyBo
         OYmU8zN0s1Do8rK57glsG7Mrt8BPoqPe6KIL07ukaswLTEWKjI/5iI4YXS9WUU5ThMA7
         7h68DhS240OZGAfwYq60y2b0YuO9TAm84wZbZjLnZPqYaVOuR3Zb/d4zhQq0yFyMfo4o
         mSe6qr/1G8l/TDYfDh1Vq/fUL6qWIUM+/kwAlxQBgWNQKH27LurmdJltiwWEB1AYbZjw
         yTFQ==
X-Gm-Message-State: APjAAAVswAUPY2Sl/kFV4y+aSGhGHJ9AdvfWIzCmmAc8ZKgUo7Nm1f+Y
        EUUJ/X+ZfV2ZP/wAT+XxgORreuqDh+p1oBqvlJKiDv3uNRtnm+/DwkJTLegqgdDBPquWuWqgkbe
        3M47sA+TB2DlQ+o3ZA13toF0QSKhbzGEbhONHkXLXZ3l27RCWkg9jWtnP3tsGDC7Mf3nN6eGCzX
        X3
X-Google-Smtp-Source: APXvYqz+xXHEHGk33F13pvRSylMJfhJ4l7L/r4xMoXkPB3UkZ48CsDIQBV/jClPOMf4YkXJhiA9gdptig2j3L4dzxMxe
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr6128133pgi.221.1571343459569;
 Thu, 17 Oct 2019 13:17:39 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:17:16 -0700
In-Reply-To: <cover.1571343096.git.jonathantanmy@google.com>
Message-Id: <2f2e36d3efede79f55347ce9d80d453bb05a4e15.1571343096.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com> <cover.1571343096.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 7/7] index-pack: make quantum of work smaller
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, when index-pack resolves deltas, it does not split up delta
trees into threads: each delta base root (an object that is not a
REF_DELTA or OFS_DELTA) can go into its own thread, but all deltas on
that root (direct or indirect) are processed in the same thread.

This is a problem when a repository contains a large text file (thus,
delta-able) that is modified many times - delta resolution time during
fetching is dominated by processing the deltas corresponding to that
text file.

This patch contains a solution to that. When cloning using

  git -c core.deltabasecachelimit=1g clone \
    https://fuchsia.googlesource.com/third_party/vulkan-cts

on my laptop, clone time improved from 3m2s to 2m5s (using 3 threads,
which is the default).

The solution is to have a global work stack. This stack contains delta
bases (objects, whether appearing directly in the packfile or generated
by delta resolution, that themselves have delta children) that need to
be processed; whenever a thread needs work, it peeks at the top of the
stack and processes its next unprocessed child. If a thread finds the
stack empty, it will look for more delta base roots to push on the stack
instead.

The main weakness of having a global work stack is that more time is
spent in the mutex, but profiling has shown that most time is spent in
the resolution of the deltas themselves, so this shouldn't be an issue
in practice. In any case, experimentation (as described in the clone
command above) shows that this patch is a net improvement.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 336 ++++++++++++++++++++++++-------------------
 1 file changed, 190 insertions(+), 146 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 31607a77fc..072592a35d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -38,15 +38,49 @@ struct base_data {
 	struct object_entry *obj;
 	int ref_first, ref_last;
 	int ofs_first, ofs_last;
+	/*
+	 * Threads should increment retain_data if they are about to call
+	 * patch_delta() using this struct's data as a base, and decrement this
+	 * when they are done. While retain_data is nonzero, this struct's data
+	 * will not be freed even if the delta base cache limit is exceeded.
+	 */
+	int retain_data;
+	/*
+	 * The number of direct children that have not been fully processed
+	 * (entered work_head, entered done_head, left done_head). When this
+	 * number reaches zero, this struct base_data can be freed.
+	 */
+	int children_remaining;
 
 	/* Not initialized by make_base(). */
+	struct list_head list;
 	void *data;
 	unsigned long size;
 };
 
+/*
+ * Stack of struct base_data that have unprocessed children.
+ * threaded_second_pass() uses this as a source of work (the other being the
+ * objects array).
+ */
+LIST_HEAD(work_head);
+
+/*
+ * Stack of struct base_data that have children, all of whom have been
+ * processed or are being processed, and at least one child is being processed.
+ * These struct base_data must be kept around until the last child is
+ * processed.
+ */
+LIST_HEAD(done_head);
+
+/*
+ * All threads share one delta base cache.
+ */
+size_t base_cache_used;
+size_t base_cache_limit;
+
 struct thread_local {
 	pthread_t thread;
-	size_t base_cache_used;
 	int pack_fd;
 };
 
@@ -369,36 +403,38 @@ static void free_base_data(struct base_data *c)
 {
 	if (c->data) {
 		FREE_AND_NULL(c->data);
-		get_thread_data()->base_cache_used -= c->size;
+		base_cache_used -= c->size;
 	}
 }
 
-static void prune_base_data(struct base_data *youngest_child)
+static void prune_base_data(struct base_data *retain)
 {
-	struct base_data *b;
-	struct thread_local *data = get_thread_data();
-	struct base_data **ancestry = NULL;
-	size_t nr = 0, alloc = 0;
-	ssize_t i;
+	struct list_head *pos;
 
-	if (data->base_cache_used <= delta_base_cache_limit)
+	if (base_cache_used <= base_cache_limit)
 		return;
 
-	/*
-	 * Free all ancestors of youngest_child until we have enough space,
-	 * starting with the oldest. (We cannot free youngest_child itself.)
-	 */
-	for (b = youngest_child->base; b != NULL; b = b->base) {
-		ALLOC_GROW(ancestry, nr + 1, alloc);
-		ancestry[nr++] = b;
+	list_for_each_prev(pos, &done_head) {
+		struct base_data *b = list_entry(pos, struct base_data, list);
+		if (b->retain_data || b == retain)
+			continue;
+		if (b->data) {
+			free_base_data(b);
+			if (base_cache_used <= base_cache_limit)
+				return;
+		}
 	}
-	for (i = nr - 1;
-	     i >= 0 && data->base_cache_used > delta_base_cache_limit;
-	     i--) {
-		if (ancestry[i]->data)
-			free_base_data(ancestry[i]);
+
+	list_for_each_prev(pos, &work_head) {
+		struct base_data *b = list_entry(pos, struct base_data, list);
+		if (b->retain_data || b == retain)
+			continue;
+		if (b->data) {
+			free_base_data(b);
+			if (base_cache_used <= base_cache_limit)
+				return;
+		}
 	}
-	free(ancestry);
 }
 
 static int is_delta_type(enum object_type type)
@@ -850,15 +886,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 }
 
 /*
- * This function is part of find_unresolved_deltas(). There are two
- * walkers going in the opposite ways.
- *
- * The first one in find_unresolved_deltas() traverses down from
- * parent node to children, deflating nodes along the way. However,
- * memory for deflated nodes is limited by delta_base_cache_limit, so
- * at some point parent node's deflated content may be freed.
- *
- * The second walker is this function, which goes from current node up
+ * Walk from current node up
  * to top parent if necessary to deflate the node. In normal
  * situation, its parent node would be already deflated, so it just
  * needs to apply delta.
@@ -886,7 +914,7 @@ static void *get_base_data(struct base_data *c)
 		if (!delta_nr) {
 			c->data = get_data_from_pack(obj);
 			c->size = obj->size;
-			get_thread_data()->base_cache_used += c->size;
+			base_cache_used += c->size;
 			prune_base_data(c);
 		}
 		for (; delta_nr > 0; delta_nr--) {
@@ -902,7 +930,7 @@ static void *get_base_data(struct base_data *c)
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, _("failed to apply delta"));
-			get_thread_data()->base_cache_used += c->size;
+			base_cache_used += c->size;
 			prune_base_data(c);
 		}
 		free(delta);
@@ -920,6 +948,8 @@ static struct base_data *make_base(struct object_entry *obj,
 				&base->ref_first, &base->ref_last);
 	find_ofs_delta_children(obj->idx.offset,
 				&base->ofs_first, &base->ofs_last);
+	base->children_remaining = base->ref_last - base->ref_first +
+		base->ofs_last - base->ofs_first + 2;
 	return base;
 }
 
@@ -953,14 +983,8 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 		    &delta_obj->idx.oid);
 
 	result = make_base(delta_obj, base);
-	if (result->ref_last == -1 && result->ofs_last == -1) {
-		free(result_data);
-	} else {
-		result->data = result_data;
-		result->size = result_size;
-		get_thread_data()->base_cache_used += result->size;
-		prune_base_data(result);
-	}
+	result->data = result_data;
+	result->size = result_size;
 
 	counter_lock();
 	nr_resolved_deltas++;
@@ -969,84 +993,6 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 	return result;
 }
 
-/*
- * Standard boolean compare-and-swap: atomically check whether "*type" is
- * "want"; if so, swap in "set" and return true. Otherwise, leave it untouched
- * and return false.
- */
-static int compare_and_swap_type(signed char *type,
-				 enum object_type want,
-				 enum object_type set)
-{
-	enum object_type old;
-
-	type_cas_lock();
-	old = *type;
-	if (old == want)
-		*type = set;
-	type_cas_unlock();
-
-	return old == want;
-}
-
-static struct base_data *find_unresolved_deltas_1(struct base_data *base,
-						  struct base_data *prev_base)
-{
-	if (base->ref_first <= base->ref_last) {
-		struct object_entry *child = objects + ref_deltas[base->ref_first].obj_no;
-		struct base_data *result;
-
-		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
-					   base->obj->real_type))
-			BUG("child->real_type != OBJ_REF_DELTA");
-
-		get_base_data(base);
-		result = resolve_delta(child, base);
-		if (base->ref_first == base->ref_last && base->ofs_last == -1)
-			free_base_data(base);
-
-		base->ref_first++;
-		return result;
-	}
-
-	if (base->ofs_first <= base->ofs_last) {
-		struct object_entry *child = objects + ofs_deltas[base->ofs_first].obj_no;
-		struct base_data *result;
-
-		assert(child->real_type == OBJ_OFS_DELTA);
-		child->real_type = base->obj->real_type;
-		get_base_data(base);
-		result = resolve_delta(child, base);
-		if (base->ofs_first == base->ofs_last)
-			free_base_data(base);
-
-		base->ofs_first++;
-		return result;
-	}
-
-	free_base_data(base);
-	return NULL;
-}
-
-static void find_unresolved_deltas(struct base_data *base)
-{
-	struct base_data *new_base, *prev_base = NULL;
-	for (;;) {
-		new_base = find_unresolved_deltas_1(base, prev_base);
-
-		if (new_base) {
-			prev_base = base;
-			base = new_base;
-		} else {
-			free(base);
-			base = prev_base;
-			if (!base)
-				return;
-			prev_base = base->base;
-		}
-	}
-}
-
 static int compare_ofs_delta_entry(const void *a, const void *b)
 {
 	const struct ofs_delta_entry *delta_a = a;
@@ -1065,33 +1011,128 @@ static int compare_ref_delta_entry(const void *a, const void *b)
 	return oidcmp(&delta_a->oid, &delta_b->oid);
 }
 
-static void resolve_base(struct object_entry *obj)
-{
-	struct base_data *base_obj = make_base(obj, NULL);
-
-	find_unresolved_deltas(base_obj);
-}
-
 static void *threaded_second_pass(void *data)
 {
-	set_thread_data(data);
+	if (data)
+		set_thread_data(data);
 	for (;;) {
-		int i;
-		counter_lock();
-		display_progress(progress, nr_resolved_deltas);
-		counter_unlock();
+		struct base_data *parent = NULL;
+		struct object_entry *child_obj;
+		struct base_data *child;
+
 		work_lock();
-		while (nr_dispatched < nr_objects &&
-		       is_delta_type(objects[nr_dispatched].type))
-			nr_dispatched++;
-		if (nr_dispatched >= nr_objects) {
-			work_unlock();
-			break;
+		if (list_empty(&work_head)) {
+			/*
+			 * Take an object from the object array.
+			 */
+			while (nr_dispatched < nr_objects &&
+			       is_delta_type(objects[nr_dispatched].type))
+				nr_dispatched++;
+			if (nr_dispatched >= nr_objects) {
+				work_unlock();
+				break;
+			}
+			child_obj = &objects[nr_dispatched++];
+		} else {
+			/*
+			 * Peek at the top of the stack, and take a child from
+			 * it.
+			 */
+			parent = list_first_entry(&work_head, struct base_data,
+						  list);
+
+			if (parent->ref_first <= parent->ref_last) {
+				child_obj = objects +
+					ref_deltas[parent->ref_first++].obj_no;
+				assert(child_obj->real_type == OBJ_REF_DELTA);
+				child_obj->real_type = parent->obj->real_type;
+			} else {
+				child_obj = objects +
+					ofs_deltas[parent->ofs_first++].obj_no;
+				assert(child_obj->real_type == OBJ_OFS_DELTA);
+				child_obj->real_type = parent->obj->real_type;
+			}
+
+			if (parent->ref_first > parent->ref_last &&
+			    parent->ofs_first > parent->ofs_last) {
+				/*
+				 * This parent has run out of children, so move
+				 * it to done_head.
+				 */
+				list_del(&parent->list);
+				list_add(&parent->list, &done_head);
+			}
+
+			/*
+			 * Ensure that the parent has data, since we will need
+			 * it later.
+			 *
+			 * NEEDSWORK: If parent data needs to be reloaded, this
+			 * prolongs the time that the current thread spends in
+			 * the mutex. A mitigating factor is that parent data
+			 * needs to be reloaded only if the delta base cache
+			 * limit is exceeded, so in the typical case, this does
+			 * not happen.
+			 */
+			get_base_data(parent);
+			parent->retain_data++;
 		}
-		i = nr_dispatched++;
 		work_unlock();
 
-		resolve_base(&objects[i]);
+		if (parent) {
+			child = resolve_delta(child_obj, parent);
+			if (!child->children_remaining)
+				FREE_AND_NULL(child->data);
+		} else {
+			child = make_base(child_obj, NULL);
+			if (child->children_remaining) {
+				/*
+				 * Since this child has its own delta children,
+				 * we will need this data in the future.
+				 * Inflate now so that future iterations will
+				 * have access to this object's data while
+				 * outside the work mutex.
+				 */
+				child->data = get_data_from_pack(child_obj);
+				child->size = child_obj->size;
+			}
+		}
+
+		work_lock();
+		if (parent)
+			parent->retain_data--;
+		if (child->data) {
+			/*
+			 * This child has its own children, so add it to
+			 * work_head.
+			 */
+			list_add(&child->list, &work_head);
+			base_cache_used += child->size;
+			prune_base_data(NULL);
+		} else {
+			/*
+			 * This child does not have its own children. It may be
+			 * the last descendant of its ancestors; free those
+			 * that we can.
+			 */
+			struct base_data *p = parent;
+
+			while (p) {
+				struct base_data *next_p;
+
+				p->children_remaining--;
+				if (p->children_remaining)
+					break;
+
+				next_p = p->base;
+				free_base_data(p);
+				list_del(&p->list);
+				free(p);
+
+				p = next_p;
+			}
+		}
+		work_unlock();
 	}
 	return NULL;
 }
@@ -1192,6 +1233,7 @@ static void resolve_deltas(void)
 					  nr_ref_deltas + nr_ofs_deltas);
 
 	nr_dispatched = 0;
+	base_cache_limit = delta_base_cache_limit * nr_threads;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
 		for (i = 0; i < nr_threads; i++) {
@@ -1362,10 +1404,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 	for (i = 0; i < nr_ref_deltas; i++) {
 		struct ref_delta_entry *d = sorted_by_pos[i];
 		enum object_type type;
-		struct base_data *base;
 		void *data;
 		unsigned long size;
-		struct object_entry *obj;
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
@@ -1376,11 +1416,15 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		if (check_object_signature(&d->oid, data,
 					   size, type_name(type)))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
-		obj = append_obj_to_pack(f, d->oid.hash, data, size, type);
-		base = make_base(obj, NULL);
-		base->data = data;
-		base->size = size;
-		find_unresolved_deltas(base);
+
+		/*
+		 * Add this as an object to the objects array and call
+		 * threaded_second_pass() (which will pick up the added
+		 * object).
+		 */
+		append_obj_to_pack(f, d->oid.hash, data, size, type);
+		threaded_second_pass(NULL);
+
 		display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
-- 
2.23.0.866.gb869b98d4c-goog

