Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910844;
	b=mOMhs4xGookGRtUZRx3s8lYtJTm7HzWEZvcr4PkXXkEO5cWI/ZM7fj/qGNShl3ID159W
	 /bvi2TdYJRr0Xc63Tweg8HIqeG5ZKllQ6fubaK3mGD5mprUnne9leLDdPt7Hfnj0e6SR3
	 TaiVdOkf44QL+ZqiuFJHdg58Y0tu04Z+4qSkJMhuMrSII3wENWFv3nuG4Fd7ohIJAk+iF
	 CFQZxZh7kupX/z8muRqoIKEsu1/SISZwU0EhGtX/0PmmNQFTd3hnXANME7HUjeTDZ5MaS
	 KkV+B48OIvpIlpL8AjSbApf9MEYBfIEy/+60FazKHZxnJTsIlQQVmda3aHLKy51OGcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BPNLmSFDgR+Q6cgkY+shmCO3ObWo2ck10kxZq7wM4hI=;
	b=sQP+WQGPepsHj9RRjvYRJY+RQUnoVoYynHWW1CqTrDXyY3iQSvwFD2go0/B4kT8a8uxj
	 drQmPZgw9SatQc8uFez9L+TUJqpeb4ohpAidg8VEzIwVOwiz9Uk7ULQT8dRfVeQ7Xvui9
	 L9ZvrEjqLsxceSvDA6yjkB2JmvmJOcohsdg9hiMMHNy5fkIqDUiYay3tRxGGGR2z4h3vM
	 i/L8lUfRdAUdlH2LW+e75PZzQJWO5oKJxPR0rkyB/Ggae+KGx/YRgBYKhf8TxKX5Awn/A
	 jJQTMM/B8Phbz6Acd2YIY9hegsE4pItkgW8jdk35VSvqljGqxFAJogtv73zLwmebnaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=czIgFzGL;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E14606A336
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 20:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E14606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=czIgFzGL
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso79306a12.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 12:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910842; x=1794515642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPNLmSFDgR+Q6cgkY+shmCO3ObWo2ck10kxZq7wM4hI=;
        b=czIgFzGL7AqwR2LjDHWIi+18eotv/EuRqH7tlll+zg6HeckCSUSzji7x9HFytKacD0
         rsM990Hetjvf4MTStqUBZ2zXfC+GWELP3FKk131QmCSkoA9hHfVpc8F0tjoKb+T9hVy7
         6maEKqNpkApazRzsjrrJFQj9sJ5R5BBeLVQHTMod7DxKslP2gWdUNcGkpPB+xVbjOzFq
         NIvHXMwKzX90zC9YXC/ZmmX+Htch0pdjERAFtmBq5PP0+FUD5SZu9C5uc3X6EP2bBWJQ
         LYH7+lPqZ8jTYhArDByp+jaeGAmivotnj5FUWrMGkKTFx4X/znxY3REK1AjiOusLjZbl
         lHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910842; x=1794515642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BPNLmSFDgR+Q6cgkY+shmCO3ObWo2ck10kxZq7wM4hI=;
        b=Z4+WvlI6MEyvg1TEzSa8WUn1krW5fxXeAIpNFRdG02HfmIAkkP/ac4O3ue2SpSAv3z
         NZj8Fh9ioid8SK6g63HuSmqNBBKW9LfyxitfP1wYF59EKw3LqeG2noDVecdHjOnQ7WRy
         74zpvvx9Vf5wOXaEZcChbaaJqQhNohmvChss/CCdhQeyRNlSIUcYF2fi4U/eBmeoV2Ts
         h3nC4MSTrLuvqC7VHpda5cpL23okzSBW7q9i5NxtpulQUmnHrWphsnoKYpPLdqth+9+Q
         kBxpxA/+7M3F0vGJ/ht7vly700+r3vQZmmySXJ9Ovb6wQb2LyhO6Tia560V6M1H7l/Nn
         IiPg==
X-Gm-Message-State: APuU4Z8X2ZwxY/mlTBMUMHSwEkmtyf2MaeMw+UrBcyYgAIFTkjIbfzjn
	Zl/WSAYCfV/VMQj8zC/cyQsKIuE/mQ/g1ZZVIbNsB3qt+f5Orr1U8n571AP9Dmmb1mmxRw==
X-Gm-Gg: AYBFou0qapcGpZAz7pi90zjDXhdZ3OJIC0BNqJRIzIIK3q2CYm7F9dDU399ZAM5VhBb
	TdwGbN952crlGiyoQJOx9KKRV2L9GloZ5ZWsWq1B3Dznw7Lgg9PjcH9vCq3fxTSJ/qydJQogNkK
	kRcjhdZqIWzJij/2guX24FUTAdskieIOIrEQ2q2AFx16aNY/axEf1XD4aJtdWZH0BBbX8TDrD+x
	vtxpq4p+xRWXyYa292/9rrKXjDsMrzVyAcyJmqEEjg59eZiiBerwkhZHKqeW5TNm8FNee7Pm5dw
	gqkCdZRJGDUzO2f5jK5ohtGwp17WpIVa5lk5o4Pmkb//res270ic+K78gFQvn/44otvacf5KUiA
	XsNy3m6fr0tMHAtZsYFH6HyejSuCoTvfqO4tzYAmZX8aR0wxbVvzme5yMqhZfiihVBKQA2Y/sG+
	ojpdE7PrLmsJgts1xXLIyQ/djSeBrfR+encbacYegSBm3q7lWIjkbzLc+Ugn9/J7zhUUIHPmdb0
	pMgxeRIRACobkOx+17eCx1zSLu5+bZx2UgzJetFWbUxv5LYQUFJQG3GVo96WjNcIuSeb1OaVYHk
	YNBO9aULgb85qT23c0yOnYnlMgmuQgrovEJX7Zv93M/A+M5/ND1JmP1ZR3O+kK4rlO/QsjWJxB5
	IunRNYQMAsGIpocPwgQMG6jlufE6dJMyMiTlQJk0O3nPbnzFoleIcCUUV2Ktu2BXOgK0fxG/suW
	7yDVSg6K0+wRfZhwOAoiH4Rsu2MJuJYjshb7rfSPDWCzHztAlx5g==
X-Received: by 2002:a05:6402:51d3:b0:6b5:9159:75d6 with SMTP id 4fb4d7f45d1cf-6b597813ae3mr291030a12.34.1793910842180;
        Thu, 05 Nov 2026 12:34:02 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5853e0536sm702689a12.31.2026.11.05.12.33.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 12:34:01 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: [Outreachy PATCH 1/6] notes: store the repository in struct notes_tree
Date: Thu,  5 Nov 2026 21:33:39 +0100
Message-ID: <20261105203344.48513-2-okhuomonajayi54@gmail.com>
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

A notes tree is always read from one repository, but the tree
does not record which one. Later code has to fall back to
the_repository.

Store the repository on the tree. init_notes() and
load_notes_trees() take it as their first argument, and
init_notes() saves it in t->repo. notes_cache_init() passes
the repository it was given. Other callers pass
the_repository for now.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 builtin/notes.c |  8 +++++---
 notes-cache.c   |  3 ++-
 notes-utils.c   |  3 ++-
 notes.c         | 26 +++++++++++++++-----------
 notes.h         |  9 ++++++---
 5 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9f1f0ec840..7e7dff6672 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -370,7 +370,8 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 		if (!c)
 			return 0;
 	} else {
-		init_notes(NULL, NULL, NULL, NOTES_INIT_WRITABLE);
+		init_notes(the_repository, NULL, NULL, NULL,
+			   NOTES_INIT_WRITABLE);
 		t = &default_notes_tree;
 	}
 
@@ -420,7 +421,7 @@ static struct notes_tree *init_notes_check(const char *subcommand,
 {
 	struct notes_tree *t;
 	const char *ref;
-	init_notes(NULL, NULL, NULL, flags);
+	init_notes(the_repository, NULL, NULL, NULL, flags);
 	t = &default_notes_tree;
 
 	ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t->ref;
@@ -841,7 +842,8 @@ static int merge_commit(struct notes_merge_options *o)
 	else
 		oidclr(&parent_oid, the_repository->hash_algo);
 
-	init_notes(&t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
+	init_notes(the_repository, &t, "NOTES_MERGE_PARTIAL",
+		   combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
 		refs_resolve_refdup(get_main_ref_store(the_repository),
diff --git a/notes-cache.c b/notes-cache.c
index 74cef802bd..7c35ebe64b 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -50,7 +50,8 @@ void notes_cache_init(struct repository *r, struct notes_cache *c,
 	strbuf_addf(&ref, "refs/notes/%s", name);
 	if (!notes_cache_match_validity(r, ref.buf, validity))
 		flags |= NOTES_INIT_EMPTY;
-	init_notes(&c->tree, ref.buf, combine_notes_overwrite, flags);
+	init_notes(r, &c->tree, ref.buf,
+		   combine_notes_overwrite, flags);
 	strbuf_release(&ref);
 }
 
diff --git a/notes-utils.c b/notes-utils.c
index 5c1c75d5b8..404e9a5eea 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -169,7 +169,8 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 		free(c);
 		return NULL;
 	}
-	c->trees = load_notes_trees(c->refs, NOTES_INIT_WRITABLE);
+	c->trees = load_notes_trees(the_repository, c->refs,
+				    NOTES_INIT_WRITABLE);
 	string_list_clear(c->refs, 0);
 	free(c->refs);
 	return c;
diff --git a/notes.c b/notes.c
index ec9c2cb150..4ab3d45d7c 100644
--- a/notes.c
+++ b/notes.c
@@ -1012,8 +1012,9 @@ char *default_notes_ref(struct repository *repo)
 	return notes_ref;
 }
 
-void init_notes(struct notes_tree *t, const char *notes_ref,
-		combine_notes_fn combine_notes, int flags)
+void init_notes(struct repository *r, struct notes_tree *t,
+		const char *notes_ref, combine_notes_fn combine_notes,
+		int flags)
 {
 	struct object_id oid, object_oid;
 	unsigned short mode;
@@ -1025,7 +1026,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	assert(!t->initialized);
 
 	if (!notes_ref)
-		notes_ref = to_free = default_notes_ref(the_repository);
+		notes_ref = to_free = default_notes_ref(r);
 	update_ref_namespace(NAMESPACE_NOTES, xstrdup(notes_ref));
 
 	if (!combine_notes)
@@ -1034,6 +1035,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
 	t->first_non_note = NULL;
 	t->prev_non_note = NULL;
+	t->repo = r;
 	t->ref = xstrdup(notes_ref);
 	t->update_ref = (flags & NOTES_INIT_WRITABLE) ? t->ref : NULL;
 	t->combine_notes = combine_notes;
@@ -1041,15 +1043,15 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->dirty = 0;
 
 	if (flags & NOTES_INIT_EMPTY ||
-	    repo_get_oid_treeish(the_repository, notes_ref, &object_oid))
+	    repo_get_oid_treeish(r, notes_ref, &object_oid))
 		goto out;
-	if (flags & NOTES_INIT_WRITABLE && refs_read_ref(get_main_ref_store(the_repository), notes_ref, &object_oid))
+	if (flags & NOTES_INIT_WRITABLE && refs_read_ref(get_main_ref_store(r), notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
-	if (get_tree_entry(the_repository, &object_oid, "", &oid, &mode))
+	if (get_tree_entry(r, &object_oid, "", &oid, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, oid_to_hex(&object_oid));
 
-	oidclr(&root_tree.key_oid, the_repository->hash_algo);
+	oidclr(&root_tree.key_oid, r->hash_algo);
 	oidcpy(&root_tree.val_oid, &oid);
 	load_subtree(t, &root_tree, t->root, 0);
 
@@ -1057,7 +1059,8 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	free(to_free);
 }
 
-struct notes_tree **load_notes_trees(struct string_list *refs, int flags)
+struct notes_tree **load_notes_trees(struct repository *r,
+				     struct string_list *refs, int flags)
 {
 	struct string_list_item *item;
 	int counter = 0;
@@ -1065,7 +1068,7 @@ struct notes_tree **load_notes_trees(struct string_list *refs, int flags)
 	ALLOC_ARRAY(trees, refs->nr + 1);
 	for_each_string_list_item(item, refs) {
 		struct notes_tree *t = xcalloc(1, sizeof(struct notes_tree));
-		init_notes(t, item->string, combine_notes_ignore, flags);
+		init_notes(r, t, item->string, combine_notes_ignore, flags);
 		trees[counter++] = t;
 	}
 	trees[counter] = NULL;
@@ -1136,7 +1139,8 @@ void load_display_notes(struct display_notes_opt *opt)
 						     item->string);
 	}
 
-	display_notes_trees = load_notes_trees(&display_notes_refs, 0);
+	display_notes_trees = load_notes_trees(the_repository,
+					       &display_notes_refs, 0);
 	string_list_clear(&display_notes_refs, 0);
 }
 
@@ -1290,7 +1294,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!t)
 		t = &default_notes_tree;
 	if (!t->initialized)
-		init_notes(t, NULL, NULL, 0);
+		init_notes(the_repository, t, NULL, NULL, 0);
 
 	oid = get_note(t, object_oid);
 	if (!oid)
diff --git a/notes.h b/notes.h
index 6dc6d7b265..0f50020816 100644
--- a/notes.h
+++ b/notes.h
@@ -50,6 +50,7 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
  * simultaneously.
  */
 extern struct notes_tree {
+	struct repository *repo;
 	struct int_node *root;
 	struct non_note *first_non_note, *prev_non_note;
 	char *ref;
@@ -107,8 +108,9 @@ char *default_notes_ref(struct repository *repo);
  * Precondition: The notes_tree structure is zeroed (this can be achieved with
  * memset(t, 0, sizeof(struct notes_tree)))
  */
-void init_notes(struct notes_tree *t, const char *notes_ref,
-		combine_notes_fn combine_notes, int flags);
+void init_notes(struct repository *r, struct notes_tree *t,
+		const char *notes_ref, combine_notes_fn combine_notes,
+		int flags);
 
 /*
  * Add the given note object to the given notes_tree structure
@@ -319,7 +321,8 @@ void format_display_notes(const struct object_id *object_oid,
  * Load the notes tree from each ref listed in 'refs'.  The output is
  * an array of notes_tree*, terminated by a NULL.
  */
-struct notes_tree **load_notes_trees(struct string_list *refs, int flags);
+struct notes_tree **load_notes_trees(struct repository *r,
+				     struct string_list *refs, int flags);
 
 /*
  * Add all refs that match 'glob' to the 'list'.
-- 
2.56.0

