Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644180;
	b=1Whtm/yn9VU7UvFE0J+CLfdNf0bpHFwxUyvc/D1aoPcbt88HGSSMr+aJ7PKP2mDe5VWD
	 xBVR/xp5YcoOHfar6MeX/mXkhL9BDpnDGaI5IJoX05C/UpU5zF6G5XXjlmrzpkV4YGVsY
	 k1D424lDE+9hJvnDKuXuF2RvTd5aoI2MGCi+bs5+H3dV/B0ycy/TkKOPGArDuM+0gTovC
	 RF6GO66fuVINQs0MIuEaqqmsORWVsGgd/Lv7LbOCggzqXLyT3EpgIewIUkjX12o90CgaM
	 4WVUUNRyew/lzB5M9ydsJoUk5LRGRXFoRoy3QwoqFzoNsImvPk42/Lc5vPsiXxI8jBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oa6xM3J1eLFqHBQ0HlYBfX6mC3Yk9nqOwhiBJMLPFN8=;
	b=UIcx/oH32bwm0XKvtJxhvmrC8bJNOMs5H1HhgLfC67brRstfjYOsLJnbMYWULUQzj1vW
	 /Pw/ahmZV0WBuh0Tgvybck4ekRRZRpLIjLDXrypGwXwP4jYs5HjJTz4IWNNOiCE2aaIMP
	 eWVPvwA2QLuAYegVwm0YO8lIgAWRm+4fTsYU6Tsz0fhCoa/Dd5Vbivv9kfC5hk+bk2rRY
	 ODYzha8g1tR9cEzNDHiSblMLSlBHS6WZp10ebDKEqKnKvuME9okV/kbtkOy9TD4wfaZKw
	 sPiDMY5aCTkuM7mHYoD+leP3OnND8pvkjl9cKgXUk7li5THNGYkOmAVTv1hkMamdjlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oood5DA0;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D9606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B83D9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oood5DA0
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c5127c7abd5so988225666b.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644178; x=1796248978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oa6xM3J1eLFqHBQ0HlYBfX6mC3Yk9nqOwhiBJMLPFN8=;
        b=oood5DA0h+0ww8Kam7+5yWnQzhAa5hL0j3VwA1VBu9CfFHMebOVtZhYmnQtpJAcHBw
         D9VONgTdow+/c6h4LxEY4AIp8Tn/VgocjrlhG7pmRiTYPyCFb6LjiHFj+q4mciguD3q4
         FjEcENIUOApqHKvKDkQjMrQHSbeW2KiTId5Hx/I0brDaaYFcPJFrryvOEy1AEVyxW8X7
         NYD/gjD2KHzpQ6FcuwOAREkJMzgy4ovxWhrYN8JwBqnv0cBZrqYOZm3X9novZ223TekQ
         1+clTQjyO8x/ayLJhTVcz1qXt3OAJxtuV3ggdILzw9yno5Cd0FOsloCWP+wq3nWbucrY
         Hvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644178; x=1796248978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oa6xM3J1eLFqHBQ0HlYBfX6mC3Yk9nqOwhiBJMLPFN8=;
        b=a9LmpqBZ2L/NtDg0HsjaqDJ6i0FsfwKJkJ2bdr/C6my5nOnLcfRO90flQgtm/FUn2P
         Cg37eUwmyA6hajbT0D2m9+4QuZ9/cXE2Pp8JNPMHWFQm+b8Yfa6pPHLK3t1Xw+QA30hF
         BBrsRtEdgDNP3V0Ki6GjAjNynfBmN1yBiLur3RMdYM/lAaPD9GiCj+Mvur4U6Hxmv26j
         pQYa/Eb4LKDoii1j8nnAfRYOu9N84Ymw585CCqCUzgMs2Az9G2WYE9QnO++3QTqrQGhS
         YxEDMJpEWXu6uWWtHlo9z9OtN+QE4cl6nS1OtGSIpsyOPjOdDRG3GZZ5K6psWv4zS8uF
         BfWQ==
X-Gm-Message-State: APuU4Z8VTMioXZdfoFk0xxhjI0b6xnHsrEBhzkgvtq75w1ue/ehUScDb
	wp+BZPzS/k802Ed1y97YI0+WZLsqJv28+RTT4zCQu0WAm/GXItJ4r1efZLdPq8aCJUo=
X-Gm-Gg: AZFdTZdIG913VuHuD/ZG2dCwZ2W5TOKCYo9cSdAdpdQHzDYSsi78S5UTZeZB3G1BVSM
	3Sb769ux79NoNroSD5N3yxdHUtLblYuFM7cszf7JpFzdlnyyEplPwbbK3bps/ydwfYaKC0TAH/D
	UL9R8ihJsPvGnPsaFq6WWdPg0dipGhz16uL0kclhogXWOUjxcR3REBljYz0S5NnylCIS9UGXh4E
	MWf5g0LhDs7QJG/Ezk0TKxJig7DQ3dvXBntZYabpqEHlP3Iyc0Tri10/FetcyIHYq21ugqekLqv
	Z01YNLKiOFzo5E3hsBF3VcSSOzgyIGREVVQigD/6WHrkU4pNBb+mstRy9diD5Q92ORgNidEy91Q
	R3eTezD12YkIyTNGmtpGJuSrU90984o06ZvBEAh5akdTlF397x/8pfNlshz/HSzzCjdspWqh/ip
	wwCyWavnMtYY6mFrAqKMTR4+YakZB08oOuL4wPs/X0Bka1zvyLDAH7BgSbdSMbO4Mqj0m+NXSpQ
	+Jwaa1pfUnlLcVZiJz3lh6gM5dAeUI21M4/OWEeOVwMtIF8JKfEQWRq8J/3IVR83WgxjqNHtv4n
	lKCUuDM4rVRe8ckBOeOQvbxEQZLnYJX1c8Z2vtXK1nomCE7HXX2G7jEVBM9R8h8kROB6kwAEhE/
	i42F7NlK/Ow3dtf4g4NO9psyV3rwJON/tVsxuu23wx3IusEVBh4sAOxP+UvR0bZxxddtEyGSs25
	Yep+xeBPm8fW0pb7v3YkfvSjid2oUikaJFofUdmuT9zPufigcP1w==
X-Received: by 2002:a17:906:c59:b0:c46:5973:2a1d with SMTP id a640c23a62f3a-c513aad1251mr1195277266b.43.1795644178084;
        Wed, 25 Nov 2026 14:02:58 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec3c60sm676998366b.50.2026.11.25.14.02.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 14:02:56 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v5 4/6] notes: use the tree's repository when writing and pruning
Date: Wed, 25 Nov 2026 23:02:12 +0100
Message-ID: <20261125220214.35881-5-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125220214.35881-1-okhuomonajayi54@gmail.com>
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
 <20261125220214.35881-1-okhuomonajayi54@gmail.com>
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

