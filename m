Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541000;
	b=AM8RBc9h0dh1yZA/2Uoo50JSa18JXYHweaYNa2K+iEQLp90BnThHJC3/ETfPgXxpyQW4
	 NaeMuSGfkT8kNs1Azg+Ku95/kxXRAEoO2qTtR6b/mq6IP0HbOq5mN1wCmGCj/v86zltZ1
	 qFLw8rSbZNycOMTMmRv/vw7Mq5KWs3d5quxydB1MKnFRvWu4FF1Z4gX510eMbbovxwoqj
	 k9txr2QnY77/557n9y8AvjyaZsvHrMwDCA+DNVwYbUdgdlixtozirur+Au8ux4s1XcLDm
	 e5M7mb9IndSiPkcYUIhMsaQw4lfYzeyXTKnp85xZkjJmt3tfcgZ/e8NaCJFC8f8dJ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1I1Vrog9fdI8kljcvuSbh45rUrbPup3oMA9Sww25HEU=;
	b=X1W4UkoQhpIMU0rsug4jN50w3GomG4IAVmFZd2guL7gbLuz2C90z+9Yv10vKnXsLLVkX
	 HkUsQ8PTewqjb8dUpPMj8VhmtGcZB4qXbP+dtTdSwAxsedACVhn2OD4R/oMz6TN5GS41H
	 oLFSx0I8EoTRCFR3XcBKwsW3P0nl4q2xmiwNZz9dAVFPqhWABlJ4hAeDzh/6oUtnhwHgL
	 vFnsGDhz4XTyxyqcg1xYKyLnXnsh/0HGvXyldwCucNKocg93NoSbNHjqChOgREqvnbBpZ
	 7i6ixIWjgLFwBC7owEit2TGagc2DgnHYkuBopcCAc5RgdeAzLfBR801jk+WLYD/sqzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sSszWy6m;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CD606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 599CD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sSszWy6m
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5118deebcfso710989266b.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795540999; x=1796145799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1I1Vrog9fdI8kljcvuSbh45rUrbPup3oMA9Sww25HEU=;
        b=sSszWy6mGp214kOKfgralpoL7EOsVoaJ6m9h882wxp38EKxVA8lCHeo+9lOmdWqKVJ
         P4TqGAs6501ks54IWU8rSjdCNHCf7dt4TqhfhPhBAxK1UZB4SUm0UHr2fwIarqLw7tg5
         3sf2YohiofLwzFrPF+c4bRMP2u254CsbNuP1BH1gxGwsckr1WZmMHLxqZIi5AiA1tIVm
         oUo8ho8arR+620nfDIBO7QwF8ivSLMHIB9mzKCIz7qmWcCuDCuvfkka9ZfowRG7uZU0k
         wS0iulNrWzbRHI+G1qvMhtkM6KKRXy8is/Aw9SDOiiJsCAmQ5N6D8piNOMPbgOAYTiMw
         wMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540999; x=1796145799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1I1Vrog9fdI8kljcvuSbh45rUrbPup3oMA9Sww25HEU=;
        b=MsO2URPaKRf2zIs673FuAVqf1j4VfbEmnCfypNSlS5zJP76GcitOs/B4FmHcEZFUJn
         KDh4AYOTEmJPqV2aAjQgn5AB/OcZLbXnyTApFt3A7Q6uHH2PHCc1JD2FjpMRZtL6DKKH
         CrExiJSQotKMAwEvndvj7lfZxbzp5E8Jr1hCvRqVdSldXgXqzdpgw7JlnkgXO3c8xb2F
         e8D1/5VLkhsHDBT7yWuFbh4ERYpw+RUmYfbXBFrk/3Xqbd8TEvZTssnknGPHy6kHs9oP
         QxHUQ9mBzS8BL/xa//MsQMUNySGtftoYXdFHWjA4jKbcyJtkmfnBgJwflOJiV7HCL7by
         z0cA==
X-Gm-Message-State: APuU4Z9rMAuGJYHcriHNR6O+du0NlbgO3A4eREQEPQVxZYVzpmsAY3Pt
	72mS1dQqnsOCneS3Svkl1S2zt+dxuNOqpWQ5LEEoxpoTau7YcU6CUgJ1yaQt0iSJMbQ=
X-Gm-Gg: AZFdTZcJfRa+MJlQovTOjSlSXFbTgGke7h97t6Av9uojZnxYCuU86vq+N6bCE377dSW
	/y1OjaGRRJqlxAwUP0yRUZnhztrJpRZ2cEnT5UH0xdY6whU5qrbeks3ntMtBput6nTAJrXlkfhT
	jE5MR6BskXbFDBa56SxvJaHmYuNTovGBTbrjgM3uyGOKUlN0Q1yPOlKvMpidUFJPlh3Oz48FQYv
	lFArYYY1OfYaVNzzuxGT8baS1JImdOadTKKCgGGi7ADkwvtjwmpPIQyGM6bSrsRhqXnlfQmzB/4
	wtixMyTbrQmMxZwwY3+e2CfEYJHkbgM7mM1rlAJTm7mrhA2UQuMsPYYuiivdNYK+sAK/OvsAJzH
	d7d301AiH1R7EY/Q6HeecUOXCbbvkpfzp9ILHoiAh0lRSskruF62uanEa9f0baJfgwu4D3ijqu4
	4RAZqGzt9yzBCmXoYtN+dRkVAaYynVBehfFCnKLx40Rsa/JxrKksB+J/aZIYbucep2eN0T8THAv
	MO1VUZxS6AHpvFbb0MWtN8E5kJZmT74kUiJAbDZ9qq4QsidaZUToViqSPxYwOMf5UXwNerOmGHj
	2bA4f9win2op+swSETPu8ZDZKdfZDjBv/+8wrjRFrI01sGK/FNDMgBbcaJ9U20qHkgbR/NEmUBi
	1iOsHPU69JkvrNfZY1GgDHwyRWLOVmlscqDkPo7g5hDtDq67137r/75GwaACWiLDlg/qc/dYcUh
	omEo64FIBg9KN90vELINbMeN0GvSmK
X-Received: by 2002:a17:907:9306:b0:c50:5d6f:df2 with SMTP id a640c23a62f3a-c513ac9944bmr1250720666b.45.1795540998563;
        Tue, 24 Nov 2026 09:23:18 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe01a0sm547394466b.68.2026.11.24.09.23.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:23:18 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v2 1/5] notes: store the repository in struct notes_tree
Date: Tue, 24 Nov 2026 18:21:42 +0100
Message-ID: <20261124172146.18330-2-okhuomonajayi54@gmail.com>
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

A notes tree is always read from one repository, but the tree
does not record which one. Later code has to fall back to
the_repository.

Store the repository on the tree. Rename init_notes() to
notes_tree_init() and load_notes_trees() to notes_tree_load(),
since every caller changes anyway. notes_tree_init() takes the
tree first and the repository second, and saves the repository
in t->repo. notes_tree_load() takes the repository first.
notes_cache_init() passes the repository it was given. Other
callers pass the_repository for now.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 builtin/notes.c |  8 +++++---
 notes-cache.c   |  3 ++-
 notes-utils.c   |  3 ++-
 notes.c         | 30 ++++++++++++++++++------------
 notes.h         | 11 +++++++----
 5 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9f1f0ec840..725280c785 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -370,7 +370,8 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 		if (!c)
 			return 0;
 	} else {
-		init_notes(NULL, NULL, NULL, NOTES_INIT_WRITABLE);
+		notes_tree_init(NULL, the_repository, NULL, NULL,
+				NOTES_INIT_WRITABLE);
 		t = &default_notes_tree;
 	}
 
@@ -420,7 +421,7 @@ static struct notes_tree *init_notes_check(const char *subcommand,
 {
 	struct notes_tree *t;
 	const char *ref;
-	init_notes(NULL, NULL, NULL, flags);
+	notes_tree_init(NULL, the_repository, NULL, NULL, flags);
 	t = &default_notes_tree;
 
 	ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t->ref;
@@ -841,7 +842,8 @@ static int merge_commit(struct notes_merge_options *o)
 	else
 		oidclr(&parent_oid, the_repository->hash_algo);
 
-	init_notes(&t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
+	notes_tree_init(&t, the_repository, "NOTES_MERGE_PARTIAL",
+			combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
 		refs_resolve_refdup(get_main_ref_store(the_repository),
diff --git a/notes-cache.c b/notes-cache.c
index 74cef802bd..b9a2940435 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -50,7 +50,8 @@ void notes_cache_init(struct repository *r, struct notes_cache *c,
 	strbuf_addf(&ref, "refs/notes/%s", name);
 	if (!notes_cache_match_validity(r, ref.buf, validity))
 		flags |= NOTES_INIT_EMPTY;
-	init_notes(&c->tree, ref.buf, combine_notes_overwrite, flags);
+	notes_tree_init(&c->tree, r, ref.buf,
+			combine_notes_overwrite, flags);
 	strbuf_release(&ref);
 }
 
diff --git a/notes-utils.c b/notes-utils.c
index 5c1c75d5b8..ea43fedd43 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -169,7 +169,8 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 		free(c);
 		return NULL;
 	}
-	c->trees = load_notes_trees(c->refs, NOTES_INIT_WRITABLE);
+	c->trees = notes_tree_load(the_repository, c->refs,
+				   NOTES_INIT_WRITABLE);
 	string_list_clear(c->refs, 0);
 	free(c->refs);
 	return c;
diff --git a/notes.c b/notes.c
index ec9c2cb150..b79fe65478 100644
--- a/notes.c
+++ b/notes.c
@@ -1012,8 +1012,9 @@ char *default_notes_ref(struct repository *repo)
 	return notes_ref;
 }
 
-void init_notes(struct notes_tree *t, const char *notes_ref,
-		combine_notes_fn combine_notes, int flags)
+void notes_tree_init(struct notes_tree *t, struct repository *r,
+		     const char *notes_ref, combine_notes_fn combine_notes,
+		     int flags)
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
+struct notes_tree **notes_tree_load(struct repository *r,
+				    struct string_list *refs, int flags)
 {
 	struct string_list_item *item;
 	int counter = 0;
@@ -1065,7 +1068,8 @@ struct notes_tree **load_notes_trees(struct string_list *refs, int flags)
 	ALLOC_ARRAY(trees, refs->nr + 1);
 	for_each_string_list_item(item, refs) {
 		struct notes_tree *t = xcalloc(1, sizeof(struct notes_tree));
-		init_notes(t, item->string, combine_notes_ignore, flags);
+		notes_tree_init(t, r, item->string,
+				combine_notes_ignore, flags);
 		trees[counter++] = t;
 	}
 	trees[counter] = NULL;
@@ -1136,7 +1140,8 @@ void load_display_notes(struct display_notes_opt *opt)
 						     item->string);
 	}
 
-	display_notes_trees = load_notes_trees(&display_notes_refs, 0);
+	display_notes_trees = notes_tree_load(the_repository,
+					      &display_notes_refs, 0);
 	string_list_clear(&display_notes_refs, 0);
 }
 
@@ -1270,7 +1275,8 @@ void free_notes(struct notes_tree *t)
  * Fill the given strbuf with the notes associated with the given object.
  *
  * If the given notes_tree structure is not initialized, it will be auto-
- * initialized to the default value (see documentation for init_notes() above).
+ * initialized to the default value (see documentation for
+ * notes_tree_init() above).
  * If the given notes_tree is NULL, the internal/default notes_tree will be
  * used instead.
  *
@@ -1290,7 +1296,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!t)
 		t = &default_notes_tree;
 	if (!t->initialized)
-		init_notes(t, NULL, NULL, 0);
+		notes_tree_init(t, the_repository, NULL, NULL, 0);
 
 	oid = get_note(t, object_oid);
 	if (!oid)
diff --git a/notes.h b/notes.h
index 6dc6d7b265..c81bc99446 100644
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
@@ -63,7 +64,7 @@ extern struct notes_tree {
  * Return the default notes ref.
  *
  * The default notes ref is the notes ref that is used when notes_ref == NULL
- * is passed to init_notes().
+ * is passed to notes_tree_init().
  *
  * This the first of the following to be defined:
  * 1. The '--ref' option to 'git notes', if given
@@ -107,8 +108,9 @@ char *default_notes_ref(struct repository *repo);
  * Precondition: The notes_tree structure is zeroed (this can be achieved with
  * memset(t, 0, sizeof(struct notes_tree)))
  */
-void init_notes(struct notes_tree *t, const char *notes_ref,
-		combine_notes_fn combine_notes, int flags);
+void notes_tree_init(struct notes_tree *t, struct repository *r,
+		     const char *notes_ref, combine_notes_fn combine_notes,
+		     int flags);
 
 /*
  * Add the given note object to the given notes_tree structure
@@ -319,7 +321,8 @@ void format_display_notes(const struct object_id *object_oid,
  * Load the notes tree from each ref listed in 'refs'.  The output is
  * an array of notes_tree*, terminated by a NULL.
  */
-struct notes_tree **load_notes_trees(struct string_list *refs, int flags);
+struct notes_tree **notes_tree_load(struct repository *r,
+				    struct string_list *refs, int flags);
 
 /*
  * Add all refs that match 'glob' to the 'list'.
-- 
2.56.0

