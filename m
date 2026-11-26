Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728820;
	b=dpzEnY7VlDRxuXD/rcn82HRzZ2VdyOycD0Q6Ue4sovmDGJPZO/s7eaGh1zZ4hBF4e09D
	 SRUCEIObv/ncFlgCJ5EbQ5DYYyJpDH9lpgYI1WuMmBoGYGuVR6pN9V9tQpI60QT08D06K
	 9QF8Sr7CZ1MoV0F0MeYkkrYPEpEdqzWSmA/OpOqhz0ITXfbjgC7m0btZ8l27JaW1kU/Q5
	 I7nq18k2afQd0dW7jRbnMZnIvopt+LcBW3m3cl8srLylqumrBrSF28C/FDrPyeNtl7Z1A
	 3/iFTBIMcApusoa4qZTE5h4OqURCKg8RHPVgNkYy7fVyGJX0DT/HAciHK/0KZQ2XEyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oa6xM3J1eLFqHBQ0HlYBfX6mC3Yk9nqOwhiBJMLPFN8=;
	b=cUJWsMKpkUoipC+m94EMPJZa+ZLCG/Ejl7QOHFqs0LlTj6HpHJXxBToR3zGMSZZVOZFY
	 24uTsQEVPvwAbhIHXhPIZvi28FoIH4LDXNuzD3+PHPjzy+QlBB2kxWWTTo6uLyqaaSvCG
	 2nsaZlx7PRPIOc+oq5r2kc/FvNTbzqiHz/faunxE6EKqhs4kMT+/uQ6J5q/BFyRBtaao+
	 M/D4fr7Gh0V9Z9fMJ4AUQB6TE4EAnnu68kzJ4MGQ+REHT6G0wG+R1KTPwcLomwjDy3+i/
	 ufc1AnRvXHSH2jegoXGVJ/lQD/Q6MOR4DdWZrNqYLImQTq36QV3QRK9GUeJ/gL9592g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HB6+NCxK;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905F606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8905F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HB6+NCxK
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c513a854320so321170566b.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795728819; x=1796333619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oa6xM3J1eLFqHBQ0HlYBfX6mC3Yk9nqOwhiBJMLPFN8=;
        b=HB6+NCxKZBuVeqoA+0vtIcm/XZT0BMqn0avJYbRigzh/iZOmcya5tf3FnHeC/FbR4S
         PS3foVIMN0kaR1oGxsYUqwtI6GWsnP1f+33l7gNGyToOQKOfmEhpEiFU1uJzNOSBtqOH
         R6Bz9z1xSGTMiFU2Tq9c/gVDzYI4+gwCsVVcFT3nyQr1+QIXAR7gJB3g8oVZ8Azgsgpu
         28aSt3AlKZl4yE4R/6Yloe8mYUuGUtS3xFH1OkuNVDX3Jv0xdo096muWiF5BeNNTgdmv
         dbNtjDZ5mP5QfpSWg7cwKW2EYPbqPIJRt29nXtRMymf08D5OhmiHW+9DrNKvDhWKnlW7
         sPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728819; x=1796333619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oa6xM3J1eLFqHBQ0HlYBfX6mC3Yk9nqOwhiBJMLPFN8=;
        b=BnqMjSyHbV4qLbZTYqBq5LeMMTF2KRXZeU2vXTo2U4a+ZuhDgy49F70blM3HMcN/yi
         uQCg25ySbJq/RtINHor3Qhc1TYSzfMvBr1youTji2pbpto/dRtbHr1ekgRJCkAn9gu4O
         xcAvWr6b7Y0wamh+lgoNofAOemFy8bo1zlr/DR7SCCDt1mkb6OkoEyK8FCM+Aq7vpRPt
         fibq9gqdcSwj6fn2NJ41Fsj5CcQcJGq9Hi202DhBkymy2RYpTNEV7lJSZQxjFGAVpQ40
         PO3+cX0/wQpCsw1sKUbvAScWMy65P4gq2F1vBJiq0zzuCq9LK+OKAith12a9PwR7p78r
         4arg==
X-Gm-Message-State: APuU4Z+sKafd3mQSkM8kcmSxIJ96vyjxdVztAYEZdxomNDxkzHyVwoJ+
	ZqtTLXho4mGDxsZEI8wovJ8ils7w+nogiLoT6HDOuL0/iPywP8+uPGMg5Ahued0ra3YxSg==
X-Gm-Gg: AZFdTZfhyKdODN8lOyNAsBBd/HyJQcI+lbPJBdxvAG+CuYvJ8plQtwXZAMdW18W1edX
	tRoB3WNV4KWWVwKUNhCFkBoSWc7wm6txtYM4b5JsehDDicmc6lV65Bxh5UwvqTj/WhZuhDkE11z
	mdfNJLAXvsj464/h74wiI3/5sg8u9irmZkIr2TzNBpPyWVZl1IcLHMsGbtxXsUwyRyQ89Q92PpJ
	mLQaZpWLmlZvL/wTgeOHSIxwWxzWvKHW4Q87f2+gvMevyPkOEEL5eZJcTYonB7L83SpDE5kuzwT
	M+j+QJdJ3l20NZfGVTcTH5NJt1QMgYoCkmbZkLzz31dau6scuDu+rMGRpbnMOED5udeTkSZsX3n
	puY7cbF9xqjTiu6avCGTdAohgoU7td/hE9AFv4bJ+/1MErQHqs24Hf6zZSyErYAK0kXGpLCYc6a
	5Dpi8zCUzu3vy2ysVAj/NwLbGrg5UyafgWFg+L8cooDoQIzsYe7T972b4p3LyS/qFzPRWHKG0ss
	Drvc1kz6SzyhG77CsXUcsWUEpEDzAIe2MU3cZm06GCDd+i8Y4GAV2XB5y39zecxkQ7txX2XCRBT
	amCLIR/S9vfC6Cby0zyMjgRnl/FuUGihUGC85zq8xMbTYGFXMjBR6UtXdhmo55ppvl2Hw1BgP2r
	x8l9t7ZYmGXSfgVen7lCsCpyoKz2GTcnCWe2VN4DNu/D+QUzHYLTGC4Bmvz5o8Aeokx83mxdUIJ
	wgybONvHh4tjUvzniD0E9jzVK0hZK5XEbD5Pl8EXMJlsxiN0CSMw==
X-Received: by 2002:a17:907:d01:b0:c51:8d3d:eef with SMTP id a640c23a62f3a-c518d3d16a1mr899828766b.12.1795728818953;
        Thu, 26 Nov 2026 13:33:38 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b030ed9sm805237066b.86.2026.11.26.13.33.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 13:33:38 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v6 4/6] notes: use the tree's repository when writing and pruning
Date: Thu, 26 Nov 2026 22:33:04 +0100
Message-ID: <20261126213306.87466-5-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126213306.87466-1-okhuomonajayi54@gmail.com>
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
 <20261126213306.87466-1-okhuomonajayi54@gmail.com>
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

