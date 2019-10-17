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
	by dcvr.yhbt.net (Postfix) with ESMTP id D645C1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 20:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437324AbfJQURh (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:17:37 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:45129 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQURh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 16:17:37 -0400
Received: by mail-yb1-f201.google.com with SMTP id y6so2722098ybm.12
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4Uo3j7qHAfJI4XLY4La7B3jbu9qzZn2r38Y90Vqt5I4=;
        b=g0zr3Ax2fN7Da6Ey/9d98AFYpBfC3K2O2KeoxerhKDaVlb51v59UVe4lQkYQ+VqSCs
         3FnMFH9YcTfRaLFMh34OQhXpYFX+hKKXLrKK+2yIvzbpkTv+mz2qx3e9AY+H0Xt/XY/Y
         Oeg+7HULYW8TG74lwRnlEkPW5ubo1wmAY/lyYomY61Uw4dSj/ABHull88f24i9P7m5GS
         nWT3rvABWbmEt6VAo7WaNtFwRLHNHgxNZ/IQ3DgagzfQgTrSfynMRfqlMC8d6vjWvZlI
         WIGUVIB1e+STcgfsc5KyCtEfUnaKcemGEL4s6lxFMg3OfG/CqyBJVzF4WgLuNZRw65Ov
         /AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4Uo3j7qHAfJI4XLY4La7B3jbu9qzZn2r38Y90Vqt5I4=;
        b=SZRDxFMt5LDOmNhvolCsSbcONHfBzdDrCdgS0rn2cu+pLSTze7upNLPun3ilsIWXy4
         52DH4AzQKjLMZd3BrvZHkdKPS7+0okcSR3zSRwYK34aD7eSgd+j2zrhwbqxLD7DSOGnL
         Bxi4r/airW0uXyEettfO4r+xTVNQxVwMNQLxbNDYkfg8OvMGXWbwkpfRnEK1OVkreOLW
         ckgy2ZYCZ2uIBj9pvVKkqvXQSPQqI85cWRGb9tLaDzFHNrhQ9qat6dbiaCepaHyRAZc/
         xhjGKq19YiB5GG/ule3KDaRZiSs0lnoyceVXU3N+egajU8lSWmoxLzMSnwH+yiDnSk+g
         zAVg==
X-Gm-Message-State: APjAAAVwx/0hnUMShPUt4hHd+gMuVjAbq1r7axFlLQDKcTd+ifZozXiK
        OPPFf7Y7d37ycVJSE+gR8MPHXO7PLPkeFHV1GbmMMhQ96eolDNVcC2PDRLdDbdpDXuvBXJAXc0k
        /pSYh91NuQFQY8oj55JonIlBqQTpKq3+sl9ufQf035sOwKKZIO1m96FPCjp2QNG/P37jKnVeUVk
        JT
X-Google-Smtp-Source: APXvYqyrK0BNpc8tgBVbD4XRDrS+HZnpYtPfMfz2D/8zFd+uta8gqStxTxnlmTkFAqK7e2wZsXJNUpCu99dbnPWUmWvF
X-Received: by 2002:a25:d048:: with SMTP id h69mr3435849ybg.458.1571343454716;
 Thu, 17 Oct 2019 13:17:34 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:17:14 -0700
In-Reply-To: <cover.1571343096.git.jonathantanmy@google.com>
Message-Id: <7f18480c45193d2a54832705cd29353911ad5b83.1571343096.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com> <cover.1571343096.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 5/7] index-pack: calculate {ref,ofs}_{first,last} early
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is refactoring 2 of 2 to simplify struct base_data.

Whenever we make a struct base_data, immediately calculate its delta
children. This eliminates confusion as to when the
{ref,ofs}_{first,last} fields are initialized.

Before this patch, the delta children were calculated at the last
possible moment. This allowed the members of struct base_data to be
populated in any order, superficially useful when we have the object
contents before the struct object_entry. But this makes reasoning about
the state of struct base_data more complicated, hence this patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 125 +++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 64 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 220e1e3693..d21353757d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -33,12 +33,15 @@ struct object_stat {
 };
 
 struct base_data {
+	/* Initialized by make_base(). */
 	struct base_data *base;
 	struct object_entry *obj;
-	void *data;
-	unsigned long size;
 	int ref_first, ref_last;
 	int ofs_first, ofs_last;
+
+	/* Not initialized by make_base(). */
+	void *data;
+	unsigned long size;
 };
 
 struct thread_local {
@@ -362,14 +365,6 @@ static void set_thread_data(struct thread_local *data)
 		pthread_setspecific(key, data);
 }
 
-static struct base_data *alloc_base_data(void)
-{
-	struct base_data *base = xcalloc(1, sizeof(struct base_data));
-	base->ref_last = -1;
-	base->ofs_last = -1;
-	return base;
-}
-
 static void free_base_data(struct base_data *c)
 {
 	if (c->data) {
@@ -406,19 +401,6 @@ static void prune_base_data(struct base_data *youngest_child)
 	free(ancestry);
 }
 
-static void link_base_data(struct base_data *base, struct base_data *c)
-{
-	c->base = base;
-	if (c->data)
-		get_thread_data()->base_cache_used += c->size;
-	prune_base_data(c);
-}
-
-static void unlink_base_data(struct base_data *c)
-{
-	free_base_data(c);
-}
-
 static int is_delta_type(enum object_type type)
 {
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
@@ -928,10 +910,25 @@ static void *get_base_data(struct base_data *c)
 	return c->data;
 }
 
-static void resolve_delta(struct object_entry *delta_obj,
-			  struct base_data *base, struct base_data *result)
+static struct base_data *make_base(struct object_entry *obj,
+				   struct base_data *parent)
 {
-	void *base_data, *delta_data;
+	struct base_data *base = xcalloc(1, sizeof(struct base_data));
+	base->base = parent;
+	base->obj = obj;
+	find_ref_delta_children(&obj->idx.oid,
+				&base->ref_first, &base->ref_last);
+	find_ofs_delta_children(obj->idx.offset,
+				&base->ofs_first, &base->ofs_last);
+	return base;
+}
+
+static struct base_data *resolve_delta(struct object_entry *delta_obj,
+				       struct base_data *base)
+{
+	void *base_data, *delta_data, *result_data;
+	struct base_data *result;
+	unsigned long result_size;
 
 	if (show_stat) {
 		int i = delta_obj - objects;
@@ -945,19 +942,31 @@ static void resolve_delta(struct object_entry *delta_obj,
 	}
 	delta_data = get_data_from_pack(delta_obj);
 	base_data = get_base_data(base);
-	result->obj = delta_obj;
-	result->data = patch_delta(base_data, base->size,
-				   delta_data, delta_obj->size, &result->size);
+	result_data = patch_delta(base_data, base->size,
+				  delta_data, delta_obj->size, &result_size);
 	free(delta_data);
-	if (!result->data)
+	if (!result_data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
-	hash_object_file(result->data, result->size,
+	hash_object_file(result_data, result_size,
 			 type_name(delta_obj->real_type), &delta_obj->idx.oid);
-	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
+	sha1_object(result_data, NULL, result_size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
+
+	result = make_base(delta_obj, base);
+	if (result->ref_last == -1 && result->ofs_last == -1) {
+		free(result_data);
+	} else {
+		result->data = result_data;
+		result->size = result_size;
+		get_thread_data()->base_cache_used += result->size;
+		prune_base_data(result);
+	}
+
 	counter_lock();
 	nr_resolved_deltas++;
 	counter_unlock();
+
+	return result;
 }
 
 /*
@@ -983,30 +992,15 @@ static int compare_and_swap_type(signed char *type,
 static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 						  struct base_data *prev_base)
 {
-	if (base->ref_last == -1 && base->ofs_last == -1) {
-		find_ref_delta_children(&base->obj->idx.oid,
-					&base->ref_first, &base->ref_last);
-
-		find_ofs_delta_children(base->obj->idx.offset,
-					&base->ofs_first, &base->ofs_last);
-
-		if (base->ref_last == -1 && base->ofs_last == -1) {
-			free(base->data);
-			return NULL;
-		}
-
-		link_base_data(prev_base, base);
-	}
-
 	if (base->ref_first <= base->ref_last) {
 		struct object_entry *child = objects + ref_deltas[base->ref_first].obj_no;
-		struct base_data *result = alloc_base_data();
+		struct base_data *result;
 
 		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
 					   base->obj->real_type))
 			BUG("child->real_type != OBJ_REF_DELTA");
 
-		resolve_delta(child, base, result);
+		result = resolve_delta(child, base);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
 			free_base_data(base);
 
@@ -1016,11 +1010,11 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 
 	if (base->ofs_first <= base->ofs_last) {
 		struct object_entry *child = objects + ofs_deltas[base->ofs_first].obj_no;
-		struct base_data *result = alloc_base_data();
+		struct base_data *result;
 
 		assert(child->real_type == OBJ_OFS_DELTA);
 		child->real_type = base->obj->real_type;
-		resolve_delta(child, base, result);
+		result = resolve_delta(child, base);
 		if (base->ofs_first == base->ofs_last)
 			free_base_data(base);
 
@@ -1028,7 +1022,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 		return result;
 	}
 
-	unlink_base_data(base);
+	free_base_data(base);
 	return NULL;
 }
 
@@ -1071,9 +1065,8 @@ static int compare_ref_delta_entry(const void *a, const void *b)
 
 static void resolve_base(struct object_entry *obj)
 {
-	struct base_data *base_obj = alloc_base_data();
-	base_obj->obj = obj;
-	base_obj->data = NULL;
+	struct base_data *base_obj = make_base(obj, NULL);
+
 	find_unresolved_deltas(base_obj);
 }
 
@@ -1367,21 +1360,25 @@ static void fix_unresolved_deltas(struct hashfile *f)
 	for (i = 0; i < nr_ref_deltas; i++) {
 		struct ref_delta_entry *d = sorted_by_pos[i];
 		enum object_type type;
-		struct base_data *base_obj = alloc_base_data();
+		struct base_data *base;
+		void *data;
+		unsigned long size;
+		struct object_entry *obj;
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
-		base_obj->data = read_object_file(&d->oid, &type,
-						  &base_obj->size);
-		if (!base_obj->data)
+		data = read_object_file(&d->oid, &type, &size);
+		if (!data)
 			continue;
 
-		if (check_object_signature(&d->oid, base_obj->data,
-				base_obj->size, type_name(type)))
+		if (check_object_signature(&d->oid, data,
+					   size, type_name(type)))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
-		base_obj->obj = append_obj_to_pack(f, d->oid.hash,
-					base_obj->data, base_obj->size, type);
-		find_unresolved_deltas(base_obj);
+		obj = append_obj_to_pack(f, d->oid.hash, data, size, type);
+		base = make_base(obj, NULL);
+		base->data = data;
+		base->size = size;
+		find_unresolved_deltas(base);
 		display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
-- 
2.23.0.866.gb869b98d4c-goog

