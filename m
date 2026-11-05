Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910852;
	b=T6gj7PlDvBiGDemhpFhAgAFHa8E4OvEuJqYko5YiKzdJ+6SHsjL4sLU4CC3I253lJcg0
	 dngb6Htg0E90MXlsfEUKKZ3hqxuvBcG3UdeEwrdgZhxpwTvJf1sBWZ9Cf2Bi4JIKxh1HU
	 D2iFNjbuYPMa4Mqszc2JnE27+5a/PsVyh182Lbe747oerVYAi3m26I+m8ume4h6lQ4/e3
	 8j1gTdA5C/Mg1jd/ciVzxAKhRoM1ZIWlccTZI28gi+mDA0RwB+dB6UkWakdu2FJC4Wxgm
	 dGDiXuENJ8aAIX08LqDcUmAeXVX8WWFl3fxuE39wJ4AwhATsaFRigVNasseyfX/XLKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lCywf9YNPnjxxmLlnG6R2eQ4wEC8mzBvkmtIxI59emc=;
	b=zyl1Fz9j2hgrpZQNHjfa547wQe4Y9Yeq1Ng31//zobsv6caYf+FtaZdWC6juaRcbBByG
	 oALWB/g0rFyM0anLxBnD4hLv7Vflu9qefboBfK/PIenKgo+J/m7aguWX2HHqsjdnYxJxg
	 3mpV8dezSPm/TcKZKVPlHnxfFaZ2HiKjClrB7ge8skvpAOn4/v5re4ynP0a0erf1IPIhz
	 Ii30zP5HvRmgoo+RpDNEDk0AvM+ZkPWXIiVwSyBk4jLx5x7K/Pw9DNpUf57CTBszrJ4a8
	 IT7p2gyfA0isyJGx98XqkdTL171S7Ga0Dnn4qfQ9t27Lmbg5dwivY6y8l1VYxUnK0aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfbahP7F;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88C606A329
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 20:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D88C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfbahP7F
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso97628a12.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 12:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910850; x=1794515650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCywf9YNPnjxxmLlnG6R2eQ4wEC8mzBvkmtIxI59emc=;
        b=hfbahP7FWMiNfngYQMrV7yxDp/bG5fTnScwef2E2+hXKfbsjPk5MwxocmMPQW0ryoK
         cwe44vFR5tj0JQ8ZR50VuZ1CG/aJ2gH1Kg5t7cJDCCu8Y3LvVyzuQx5M9pRi2vZR6PnA
         glnGKz1KVYHx8PnLyrk5qlDNOTW8EUOUARjG44kygDqs1w4wXu9U27HibZKANctEWZpu
         QXj0YUDFLjOAQ0hzZUIislQ/YnOZSS0YJgKPCYH2wvLloXX2xIjcBbrgFvcVTnwNvh78
         qbz3jAt7yVZrB7qeNkunD1Gs5WB49mjvZyKcDnkO4m+mMbSMvafPzgq/JlIGw5hR53EM
         KpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910850; x=1794515650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCywf9YNPnjxxmLlnG6R2eQ4wEC8mzBvkmtIxI59emc=;
        b=CL4Xcozk5s3ep5UV2SLSYKV+idBewWy9uqVtpe6ZfNVo8TjRRSDkUahR/Em4Amqbuf
         jgKOU9neTUwzICuRqYd8r2q2c9SS3VttEExl4Kuup4hXdK1fPgBV41FfuuoYr7DowPnl
         PV4q3viZ6nFOtGQ2u+1nlXaddTz90rCqw3ftPXHb7q3qRxAdxbTLxrSwcuuaTxv9X9SI
         hcTA8Crw1Xpn9ZNaN/2MCTisCbIkrZdbzk1oZWShw9yfkT6GBfssu/8BDViuWbhqwuXM
         B1mcc/Sx6UjBHtP8o+Oc85mfPxp63PTlMCIL1wvJ3IqaYDVzwI8JcVTglpAlIyyQD7SX
         dsWw==
X-Gm-Message-State: APuU4Z+ryX9D/zrus43VqAtileeyg9b0LV85N++cmKA0iM6vNyPeC+Js
	LyQGf5ex6OXu9dWUuAYZq2k6Niep+wcA8/8Q1UHGG2ul9nRmQX+LxuJpOH6OMGKMtF+Qbw==
X-Gm-Gg: AYBFou0UOUDVCQWgOyort3vB/tR2M8j74/jjmGuaGoUUaQh7ymxrfZgbUbKl1HcPwYk
	V2qJBoi6HMCBUdbx5DjOIoZnmYkE/4dcGLdTJ4qeEYd74gi1zae21VeD3ovJvyFI1aj3zqx9toH
	O5IsoZ6oBc7qGeL80q9A3jSC0GUnFJ9zzyKhM/oiQVZeT19YaTbAmJ1a0WrWJ9lJCjwnxw7PjsR
	lY4S1x34grsfeRA+XOcsOSEdUbljD0uHHM9hdoJrA0Rc90r1fd43D2Wm1MyMwIk64AA9B242xEN
	kmxYuxD/fxOJR7fSrgPkI+Z1rvnY94p0LoEXfaS67aCfbwBekjj9rkfiaXZlgDGmrt/ajomRxxW
	n6At4JxeVlWW5MUCDg/Pq/wgmOWUQJtrYGrpQK2X22PucTjOfMXMmJxrJaRj8jfMa+pLlbrZCPJ
	tkrByUrwMlnU6saD59XFk1e8FwDcduve/b1birGhXDBiEkk8rGFijc0/lqgOq3nCfFtOZ0vGe8k
	0PlM97XeUrdJ8onthsLCqgXJnAhuEj9c1yR6A/Zv8oNEry70nCo6Q+QCopKWv2OwNQuviorLjvE
	PzFLQ4C7iAzlMfBSRvfkRnhlrD3p/DC9aMAfV8LWtd8diZVSGt3wcldpG6s6mKkKiB4cuoNgZxi
	flAx+ZH+lz7qqWzAdCyh9vMCMmQJbJSC03JAuZxQa4eF+ni0CehXR5Sn7VT3HUurDueTIT5a8Bx
	j41TEuwuAPJCGhIGq4X6PvPBPFMCLw
X-Received: by 2002:a05:6402:5d5:b0:6aa:f0e:a168 with SMTP id 4fb4d7f45d1cf-6b5977e7587mr312854a12.21.1793910850380;
        Thu, 05 Nov 2026 12:34:10 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5853e0536sm702689a12.31.2026.11.05.12.34.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 12:34:09 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: [Outreachy PATCH 3/6] notes: use the tree's repository when writing and pruning
Date: Thu,  5 Nov 2026 21:33:41 +0100
Message-ID: <20261105203344.48513-4-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
References: <xmqq1p8zw49g.fsf@gitster.g>
 <20261105203344.48513-1-okhuomonajayi54@gmail.com>
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

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes.c | 59 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/notes.c b/notes.c
index 5c2e8815f8..c83bcc29ad 100644
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
 
@@ -1213,6 +1222,7 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 	root.next = NULL; /* last forward entry in list is grounded */
 	strbuf_init(&root.buf, 256 * (32 + the_hash_algo->hexsz)); /* assume 256 entries */
 	root.path[0] = root.path[1] = '\0';
+	cb_data.repo = t->repo;
 	cb_data.root = &root;
 	cb_data.nn_list = &(t->first_non_note);
 	cb_data.nn_prev = NULL;
@@ -1222,8 +1232,8 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
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
@@ -1231,25 +1241,26 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 
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
 
-- 
2.56.0

