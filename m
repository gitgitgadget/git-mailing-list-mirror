Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817124;
	b=nkYPFL/MtBgkoDJV+WlokT45/6PpD6z5xeTETVr2tHieOVQ46BrStxwgTk2gHVItdGIg
	 nslCxQZEcvs9WLW8NGOR9F81xEOZFImzBey8I9GUE1tLymHFZ9umyd50FwIorrmiJS1NC
	 usFoDbONjK3Jw1z34XltwSrvyKTsYKjbOGmXdZ0ulTnoRxSrhhGtLe5jjx8AekcZbNFjz
	 21VB/Xi9ygEU4HdyZgKEwl/8XA8qQ+wR4b9i2r66Hd50+z/7M4jSqMcdVWmvvV2FQ8EQp
	 6n/MV+Q3kbirs8ZPr5M5hGDkAI1h8iYDWZkRXMkCO7DQIcO64BTox5ESur2vYR4gJjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oa6xM3J1eLFqHBQ0HlYBfX6mC3Yk9nqOwhiBJMLPFN8=;
	b=1iTz0dTNDaKLP3MYNpIOWffcVTvvQIBNZlVRWHEwumPsT3uyXi0x017QPjYZYYw8N/HM
	 VZViLx41yWWW1VUsQh+1dhu3qhKC9hmwXC1Bpk7+zRFk+bTod6doLv3gO/b0bASYR7EdC
	 +6/x2DtNr5BIT5t1n6Y6YNerNp+bJGhW0VtC51q/b2Z7BZg1AW/seN1Ja3fDm5kQUDTrn
	 Nq4Ks33sQuywBjZc8SfsR9G5VNpgl5PH13b6uNtaRtQP3Pr16MR01CGfvA1KwkvnD5I0h
	 bCw4zJMw+gna2+2WyHJhQaF61V/W7mgTHGTlaPfTP2PB0ssKiwhEduaibGYxmyudUNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngt+1lUS;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F3606A31F
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E9F3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngt+1lUS
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-492690dd5daso6543487f8f.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795817122; x=1796421922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oa6xM3J1eLFqHBQ0HlYBfX6mC3Yk9nqOwhiBJMLPFN8=;
        b=ngt+1lUSzryHNisZyPPEH531Sp3HmWriiPY71CKFOMHlWlqVmbHOToHbpPJFMPBptf
         BRUlGgYHiqJO9khBMRoFbZ4/0Tu63OO0kscjEwbbDIT3LLpRWDnCjhy6Rr6Yn/lRg20d
         4Rs7OhDzWOCM6CoKpRks9B2UaGcjif3qzgPJnHOXyIXQkupcAujehNfgP6K8WXFq0ck2
         qJ02w7CI92hggSIrT+Z4Q1Swd5trvE7Qtyb5FPz3E9SrjtRK4PfhJcbU6SaMNXaEwJgF
         8xpgqZOfHteeaPz6KV1/NztH9y38f1nmjMfpV+wR4VvggpEK5tToMe2Wh/JuN4IQEaXv
         O1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795817122; x=1796421922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oa6xM3J1eLFqHBQ0HlYBfX6mC3Yk9nqOwhiBJMLPFN8=;
        b=P0gk9VEXSyD54TDID9gZOMoWCyBD4SdO2cHTwtarXaxrPnjW8t/feff+YwEPBVz5Li
         uNUxqu97xD/aNhU0gW0FvlRJWigZvxDo3ohdh7ZXBZEVPZU6zNtkEt82hY/jBfnKmFF8
         N0qtkA8w6pZdSxgoU+dddLTem8k/T7F+wZ8mQZKIcyrAo0VKiQmKVKUzAVmgf8OoGRpJ
         sxXQpTdIu0NfxbMsK5d/CXE3g1ahhmUReZh8gtN3eMBfEQayPO8qf9ZsBQ3geOrFX6vL
         GSOIaNnKiHu6rd7n0LzgMz6kdv4bTAX9ZvgMXEf+TIzZABCfDC2LJSyPQkQgzEmtTIcR
         ackw==
X-Gm-Message-State: APuU4Z+0DlnhMtK1k/KKGsxsXBbwK+f8bMjyULlesLlUtbX+oy6sCWN1
	RG5Hf/E71FCc7q/lac1Mmu3CZcSdJqFUnBN+xqJFsIrt4XlPg+SccroBdtLmjZc6yL8=
X-Gm-Gg: AZFdTZfvxIQeOtHhyrlVTEJicKO3oX8Jj40gcSzPjiLp2oXoL3PSqtKulsFSjWEewX9
	p9DZEzCGBhj4gYpE9dnipDx4/PkOiqfEpH9mnH1h3mIPDtvbUxf2YsJDuW+T9bb6tJ1GXi/Klm4
	B2PDM/gQcFgoqONLtaw8qk/FKDPi8RTInf+BUfrDiB5ykf0L6/FkPVDqlgG+IyxcB4aILNWKYv8
	RYZYYkX4fV5pLurf3wxrSr/w9ASC5HKZy+2N68p7P6V/o8ZHQkrGKi+xuO8K0pAacM8ThcE1rtk
	Ap4zjKX9/FeMDGkMNeIqIINnO/L4i56f4vZMBZOb0dCYX5+OWApmTJSUerMDudvR6t2nD25TeXE
	M+rvDgY4VU064gYrkFkUHLqTAvj/o+RFSVKX5ha+90p0ZyLi3rynzADcUSiybH0tkL/aRiLEJjL
	VhKg4o+xOdPM4qSMrTewQ03cZYKUI02bWPYPDRisbHSKpGY5wqQCYpMlOoybcL0wpQDuWIFf6Cw
	XNk0kBA8m/BsrqVkj3rdxhNedCLLniDiiD2QW191iv8GTag94Y2+foRr6xGnneyruTLG8S4DISQ
	RU+Ya8GWxKd8+lnaHwjRHkCK06XznDfUXnSTD/M6eS4/4sl8c7Ma04OJTvLP8HdTt6OeNKfmDjG
	vNdKMYw3IqDINjSx89yynS6eYit64WmykTUP9jLt9bbiBkRn8wkdI8wUlS+DGNws+fLns2nfqvB
	mZcJR4kBZW/8hA/LEVky/oFJpOq2Wx
X-Received: by 2002:a5d:64e7:0:b0:48b:a4b:5a2c with SMTP id ffacd0b85a97d-4abab5ea34bmr58463185f8f.3.1795817122456;
        Fri, 27 Nov 2026 14:05:22 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm51467422f8f.8.2026.11.27.14.05.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 14:05:22 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v7 4/6] notes: use the tree's repository when writing and pruning
Date: Fri, 27 Nov 2026 23:04:43 +0100
Message-ID: <20261127220445.45639-5-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127220445.45639-1-okhuomonajayi54@gmail.com>
References: <20261126213306.87466-1-okhuomonajayi54@gmail.com>
 <20261127220445.45639-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

write_notes_tree() writes the notes tree into the_repository,
and prune_notes() looks for missing objects there too. Both
already have the notes tree.

Write through t->repo. tree_write_stack_finish_subtree() takes
the repository, passed down from the tree. prune_notes() hands
the repository to its callback in a small struct.

copy_note() also writes through the tree, by calling add_note(),
so it uses the tree's hash algorithm for its null object ID.
It now takes a NULL tree the same way as the other entry points,
through notes_tree_or_default(), before reading the tree's
repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes.c | 71 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/notes.c b/notes.c
index da63d35935..1cdf09c81c 100644
--- a/notes.c
+++ b/notes.c
@@ -673,16 +673,17 @@ static void tree_write_stack_init_subtree(struct tree_write_stack *tws,
 	tws->path[1] = path[1];
 }
 
-static int tree_write_stack_finish_subtree(struct tree_write_stack *tws)
+static int tree_write_stack_finish_subtree(struct repository *r,
+					   struct tree_write_stack *tws)
 {
 	int ret;
 	struct tree_write_stack *n = tws->next;
 	struct object_id s;
 	if (n) {
-		ret = tree_write_stack_finish_subtree(n);
+		ret = tree_write_stack_finish_subtree(r, n);
 		if (ret)
 			return ret;
-		ret = odb_write_object(the_repository->objects, n->buf.buf,
+		ret = odb_write_object(r->objects, n->buf.buf,
 				       n->buf.len, OBJ_TREE, &s);
 		if (ret)
 			return ret;
@@ -695,9 +696,10 @@ static int tree_write_stack_finish_subtree(struct tree_write_stack *tws)
 	return 0;
 }
 
-static int write_each_note_helper(struct tree_write_stack *tws,
-		const char *path, unsigned int mode,
-		const struct object_id *oid)
+static int write_each_note_helper(struct repository *r,
+				  struct tree_write_stack *tws,
+				  const char *path, unsigned int mode,
+				  const struct object_id *oid)
 {
 	size_t path_len = strlen(path);
 	unsigned int n = 0;
@@ -711,7 +713,7 @@ static int write_each_note_helper(struct tree_write_stack *tws,
 	}
 
 	/* tws point to last matching tree_write_stack entry */
-	ret = tree_write_stack_finish_subtree(tws);
+	ret = tree_write_stack_finish_subtree(r, tws);
 	if (ret)
 		return ret;
 
@@ -733,6 +735,7 @@ static int write_each_note_helper(struct tree_write_stack *tws,
 }
 
 struct write_each_note_data {
+	struct repository *repo;
 	struct tree_write_stack *root;
 	struct non_note **nn_list;
 	struct non_note *nn_prev;
@@ -748,8 +751,8 @@ static int write_each_non_note_until(const char *note_path,
 		if (note_path && cmp == 0)
 			; /* do nothing, prefer note to non-note */
 		else {
-			ret = write_each_note_helper(d->root, n->path, n->mode,
-						     &n->oid);
+			ret = write_each_note_helper(d->repo, d->root, n->path,
+						     n->mode, &n->oid);
 			if (ret)
 				return ret;
 		}
@@ -779,7 +782,8 @@ static int write_each_note(const struct object_id *object_oid UNUSED,
 
 	/* Weave non-note entries into note entries */
 	return  write_each_non_note_until(note_path, d) ||
-		write_each_note_helper(d->root, note_path, mode, note_oid);
+		write_each_note_helper(d->repo, d->root, note_path, mode,
+				       note_oid);
 }
 
 struct note_delete_list {
@@ -787,23 +791,28 @@ struct note_delete_list {
 	const unsigned char *sha1;
 };
 
+struct prune_notes_data {
+	struct repository *repo;
+	struct note_delete_list *list;
+};
+
 static int prune_notes_helper(const struct object_id *object_oid,
 			      const struct object_id *note_oid UNUSED,
 			      char *note_path UNUSED,
 			      void *cb_data)
 {
-	struct note_delete_list **l = (struct note_delete_list **) cb_data;
+	struct prune_notes_data *d = cb_data;
 	struct note_delete_list *n;
 
-	if (odb_has_object(the_repository->objects, object_oid,
+	if (odb_has_object(d->repo->objects, object_oid,
 			   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		return 0; /* nothing to do for this note */
 
 	/* failed to find object => prune this note */
 	n = (struct note_delete_list *) xmalloc(sizeof(*n));
-	n->next = *l;
+	n->next = d->list;
 	n->sha1 = object_oid->hash;
-	*l = n;
+	d->list = n;
 	return 0;
 }
 
@@ -1212,6 +1221,7 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 	root.next = NULL; /* last forward entry in list is grounded */
 	strbuf_init(&root.buf, 256 * (32 + the_hash_algo->hexsz)); /* assume 256 entries */
 	root.path[0] = root.path[1] = '\0';
+	cb_data.repo = t->repo;
 	cb_data.root = &root;
 	cb_data.nn_list = &(t->first_non_note);
 	cb_data.nn_prev = NULL;
@@ -1221,8 +1231,8 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 		FOR_EACH_NOTE_YIELD_SUBTREES;
 	ret = for_each_note(t, flags, write_each_note, &cb_data) ||
 	      write_each_non_note_until(NULL, &cb_data) ||
-	      tree_write_stack_finish_subtree(&root) ||
-	      odb_write_object(the_repository->objects, root.buf.buf,
+	      tree_write_stack_finish_subtree(t->repo, &root) ||
+	      odb_write_object(t->repo->objects, root.buf.buf,
 			       root.buf.len, OBJ_TREE, result);
 	strbuf_release(&root.buf);
 	return ret;
@@ -1230,23 +1240,24 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 
 void prune_notes(struct notes_tree *t, int flags)
 {
-	struct note_delete_list *l = NULL;
+	struct prune_notes_data d = { 0 };
 
 	t = notes_tree_or_default(t);
 
-	for_each_note(t, 0, prune_notes_helper, &l);
+	d.repo = t->repo;
+	for_each_note(t, 0, prune_notes_helper, &d);
 
-	while (l) {
+	while (d.list) {
 		struct note_delete_list *next;
 
 		if (flags & NOTES_PRUNE_VERBOSE)
-			printf("%s\n", hash_to_hex(l->sha1));
+			printf("%s\n", hash_to_hex(d.list->sha1));
 		if (!(flags & NOTES_PRUNE_DRYRUN))
-			remove_note(t, l->sha1);
+			remove_note(t, d.list->sha1);
 
-		next = l->next;
-		free(l);
-		l = next;
+		next = d.list->next;
+		free(d.list);
+		d.list = next;
 	}
 }
 
@@ -1355,8 +1366,13 @@ int copy_note(struct notes_tree *t,
 	      const struct object_id *from_obj, const struct object_id *to_obj,
 	      int force, combine_notes_fn combine_notes)
 {
-	const struct object_id *note = get_note(t, from_obj);
-	const struct object_id *existing_note = get_note(t, to_obj);
+	const struct object_id *note;
+	const struct object_id *existing_note;
+
+	t = notes_tree_or_default(t);
+
+	note = get_note(t, from_obj);
+	existing_note = get_note(t, to_obj);
 
 	if (!force && existing_note)
 		return 1;
@@ -1364,7 +1380,8 @@ int copy_note(struct notes_tree *t,
 	if (note)
 		return add_note(t, to_obj, note, combine_notes);
 	else if (existing_note)
-		return add_note(t, to_obj, null_oid(the_hash_algo), combine_notes);
+		return add_note(t, to_obj, null_oid(t->repo->hash_algo),
+				combine_notes);
 
 	return 0;
 }
-- 
2.56.0

