Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541013;
	b=uRRRZbRW1gBgLucQ2kj/8Mn4ILJqn9rUBBqeCbzk6oDPmhj0OTwEfJkddfJA7N3+qz9E
	 co9Kdmw/xox6mJDb9eXdOnMYpUim6z6GouU9oRvHNTKKSBkrspxX8YwO/4m9KndKzf0V9
	 HKTcgHfiX+5oB7BrAtrAfzb9XHQGFX3XkqTAmMv4RmpAGGbrC0dEupg1Bhiy9s5/bROR6
	 0dSAaD5SDiBICuq8K+IvYdYrAhPRmVY7kY1O88qB2vrOBIMeYugov6l1cDVvvJH+z1mwL
	 5Ot6V4xu0aBC3/l4X00Yl+olvitYozgkzmd2yo64JulcdbTEeV6s6gysKjHX1ij0e/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rI/CZYT7nj+Xt8OMlEPct9x989KonMwBGm7t+Uaf95M=;
	b=XBsuyZnMoh/4c5T0ivhiIzzqQPb4R6OqFK0DV0iXCcUm/JLsoDHTKmoiwJbn33iy3HZ7
	 KJM2LLF4RUsYLT0accZGdZLxiUvntnnrH0W3xZSEXK1BUGb5S2XqZpFwXlQk/PT0yDm4k
	 twLefE1MnWk38EsYauRQpL9/5HJDE52nInMt2EmwMIbghD69Go7L1Lom714z/ClMHdgAQ
	 MiPQmi6ZC/UuuxZ1KnZn6CgvEkVCYcPOvBu0U4le3ZDAQVvStN+BqwUS77F0YkevjMeXB
	 T9GSYkkmGe8b5I151klZh9fy9iTm8ns2w1sKcpckn3xOFqqXTwB/ObCX6/vZ2KUVQ0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tGs58PQp;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FD606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F7FD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tGs58PQp
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d28f75d62so800503266b.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795541011; x=1796145811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rI/CZYT7nj+Xt8OMlEPct9x989KonMwBGm7t+Uaf95M=;
        b=tGs58PQpBJTGOr35inht8XyMKygDUl1XVsXYvYisbc7hLuPfdcq2G5XNxZdbwhL9hd
         kc0e3xXqWArAzmjX1a4U7zO81zpFATvEm2ZCUQAWOMMUNFVa9uocVzRrj7uUQHhR49Z0
         dr7hT5keUpNbJ5v5OIPuoEgwMEre8elw1IoMKZdIg/gS5GSLjRJWj48bwc2RAB9GOVqI
         9CQrmY34H4cAt4adsf7X6XQn2twTe+degnYL1NiPl6oEaR4Qhg5Z97fFkRTF0rMkjJuX
         3Q+ZyIVFLZV6misqaBpnKT2QO7yz8XHzGQ6DK5pADtpy4v6xgzFPM6IwUQXqX0+D1c1H
         RXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541011; x=1796145811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rI/CZYT7nj+Xt8OMlEPct9x989KonMwBGm7t+Uaf95M=;
        b=GOZIDk71YIEeNor5NHkm4uPWrTMrDkvJhV7sP/Z/a7tYNTp3GFXmXg3Ate2s3Dmymm
         C4XPNmGe36edMfcOE5VgIr7AyQ1O0ybM9Y/bSKGmT1Yp3W1GTFL7YuPPmMbn0xQbm7mt
         n785m6Yd1Z5gYb8+i4iAi1i6GLXLGTHu7cmX3+cMeS9wNACHlk6viniYlpPRM4KFaKot
         Xfix8s3t4X3Q5W8fvnkUhSk/fXI5v6xgj47geAPxgg7C84rIHMoEzbRDwbL2xsRcy3gN
         aFDPizOAJDn/GpoAq6grwmW4bfBXL57eWs99dhPwWBz5vUdQNd96itvRTgp5HCXSWRY4
         oEBw==
X-Gm-Message-State: APuU4Z/IABieEeOdGnhnleD62Vcq0V0dq8cb9EiOCEq0rhmQXwle1+jw
	AZV8IT0tHDFedrc9EhkoINudFU7xea7Rt0EHnxNzxATRIEB+JkIa9R+8eVV39owJsIo=
X-Gm-Gg: AZFdTZfIndSbCmRDoqgVy1cVKLsD3SXff/F72pf/DhTBqZBx3+RRmOWGriNN56SEiYm
	50/KJcKRH2mP+sbOtnNp0s03qH6Ym42s5O1Rk8YCUfET0M9nJAV+xkWj+cyadBmiFpimeqoZnCS
	Mo8Z3ZAcPHwjNZl2XzHCOk/KWVLv5z0PbqS+VP/VyLfcERF6Y8Sell9HFYvtAG5TKGjTvVZ78xS
	ydMPcdcWcy8rCAd+yyh6wAZA0Mtv9iTYashMo7JuPtCHz9siW/6yfbkW2FKeavPzdtjtiETj6/g
	QFUgN58e0FXJdaIIXHiOwZ0lHeCOmzG8MwXblw6Doe1AOWsxcMLumuV9183NejIkFkKTaoz46HR
	85tLku1J5uSnTnpMdRLgnCe4sMuperbdIKEJCg9ymSVpKO+QGbj93KXJgJxL2Rhueddm4EExHLd
	/OinO2NJxFBxDddghaphP8KkD8csqQMJ/nCB8PBLZEm2UnYSWpQcAyI7Hvhonfjf/8mloqJV6eb
	P0S3p6ZmY/4mT3dMBXQZwxmySp+m6tEhJDAwywcExl7s4zWItjC9vtpx3fZYItTTpt4fulfG15J
	FHQSdKO90diHyaXlZERmHup5yMK4NEclSBe2wFGFrVuZ77W3v2X4wEtGN0oOK+oh2RQc/shKcmh
	M9ib0u3w1n9imWwH+DeeXQF132tXxgdmBgiW63FOwcq/1ITa/PAgJUw1/T1HMwh6Hw93N9lVPk/
	w7JWjfBIMIyGDw4lDGG8tOyBrkdO1R
X-Received: by 2002:a17:907:5c5:b0:c33:ca5e:8ddb with SMTP id a640c23a62f3a-c51a200609dmr46738666b.28.1795541011389;
        Tue, 24 Nov 2026 09:23:31 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe01a0sm547394466b.68.2026.11.24.09.23.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:23:30 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v2 3/5] notes: use the tree's repository when writing and pruning
Date: Tue, 24 Nov 2026 18:21:44 +0100
Message-ID: <20261124172146.18330-4-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com>
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

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes.c | 62 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/notes.c b/notes.c
index 9cf71651ed..9d653c757a 100644
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
 
@@ -1214,6 +1223,7 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 	root.next = NULL; /* last forward entry in list is grounded */
 	strbuf_init(&root.buf, 256 * (32 + the_hash_algo->hexsz)); /* assume 256 entries */
 	root.path[0] = root.path[1] = '\0';
+	cb_data.repo = t->repo;
 	cb_data.root = &root;
 	cb_data.nn_list = &(t->first_non_note);
 	cb_data.nn_prev = NULL;
@@ -1223,8 +1233,8 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
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
@@ -1232,25 +1242,26 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 
 void prune_notes(struct notes_tree *t, int flags)
 {
-	struct note_delete_list *l = NULL;
+	struct prune_notes_data d = { 0 };
 
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
 
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
 
@@ -1368,7 +1379,8 @@ int copy_note(struct notes_tree *t,
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

