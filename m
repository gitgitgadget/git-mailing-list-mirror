Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817112;
	b=BMTRw9B+yrOmXbxERAWuJAMc+367SEi/VjWLz0nyGQ2E3Pm89bbJGb2xfN11yQQI7myr
	 2tIW3ylBolQSDMtIPDjF5FM+09N8C97gi32CUSh8tf9Llr9jibIMDpV8SNiuH9Oojn9jQ
	 /ld1px9FGl9Bf5DYIZRB+u1dLgC5tir4PBrH4DOqc7ZdH1W/VWNPhyDzfaXzgTsdQj+3c
	 UZS6Q9rC/eYuNLKqOegthbuRhQf+fvxEImUjrZbIXuDgWDG8WcLdHA/3COGvy7u1AIURj
	 /Cc5hfh+widrlk2RiOSB2s0RA9zwAjmBeFMp7m76EvTz1KIMM2doGIlXCW7d/zhfP0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pIrUuAgjffxgB23dY1zrC/ndxydb9lIGQYal54SORaU=;
	b=0u5Xibh1MQ+z5s5G8MUYTPnj3RAtFQaesECYvO66HS83Wy+HXoZjhJuCd8I3tUi6X+1T
	 4kIRpyf9MCn7x1krYCDZR9fLzSCmqIvRxaSLdVVSbCYlqJGiAh6S2A2vL4yUQrNN88lph
	 VRqM6pm8be2ax8qFgeou81eu6SMSwB6WFkbskLWECCybwnr95ZsFbi6I+EIRO1yvx8Hwg
	 BwvuN6G7qnQNUY5bI2D7dKKIUNeBS/6ohe10Ne5hD1cmyzdRGzpTunO5l4eUeLnjNVeBc
	 KKNnHgFLyJynXkB2iSOrcRVa95QeMXpopEk3K0xqvApeUk8eG1H2t7cPtpewdjBFt+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zSOJESUg;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC1606A335
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ECC1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zSOJESUg
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4b52fcb410dso3473953f8f.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795817110; x=1796421910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIrUuAgjffxgB23dY1zrC/ndxydb9lIGQYal54SORaU=;
        b=zSOJESUgZrsCjXj4oMyUPQw26WMRRAKkpZP+zacSty7glmPfPQWDkm0eRi21hh+D1k
         GdI3kgnEGYYRalh7wSjHDHUQsG3zRpj7fblasCuI0rzoFwyVa8KotAI0aPIKeBUFyZPX
         CqnfAMlzIDWaVYdsi6+4/ez9KZ4bJCEEEa236+yQFbwW8ftMeS5VeZ0F2+aVm2uV5+Us
         hDtzpbX8+8+NG4mJKuJY9jNt4gntKeV41mJItvWULxJBPZaucAJLASf8HboGc4uUHmmE
         k6KoEzRdJjjF/RguHHu0gspCf7aVEsts7swLOwD9IUm37VBxwhiT1weQ3pG0fCc1cSf3
         0y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795817110; x=1796421910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pIrUuAgjffxgB23dY1zrC/ndxydb9lIGQYal54SORaU=;
        b=RAbqRJc0RS8eVZQ/7B8e5EYPa5KrG24TnmOwjI0unV+73u643EnZYWVlZtH4mJhV7P
         htQAwfTRj/JorozVSQ6kB49gvgo5vNsiKPQXY+hIXAbyum+Kvfo+nLhSbHrDC/cv3O3N
         t3jokmJdQ/Hy7zNxpu3/c+dDtmzcA/ZAea2LhyMiUhqzew0hdJ03c7vZkkRQcxhRH50N
         wLivNVH43pKghvUonhyMPBNOigZt/u0MYR7+Ty+DuNBXXqz+WU4ikt4HlPJUXMbD3/wH
         LJ2/ofYFAe8ydSNwy+VKmMMgP3l85OrR+FNUEvq6tQgT18exIrvIZWZyTDrw+zjuuB8g
         nd3Q==
X-Gm-Message-State: APuU4Z/aJ8KophUrf4qwwpHGWo/NDv+0RRWMj9LIerrVojXl+O+GDeYh
	xQ+7nBks/VrXhRhMGxcNyZgs5Pt5e148P8kYapZtqqA47IHXWNxsghVXC7AgnVhcckc=
X-Gm-Gg: AZFdTZdIvlBDjiduD9PvTYmNG0/O4Ww8tnEeCt8HvnqquxjogQegjEeJra3rmOOFjhU
	V7lgfDbZ+/1y4xtpsFds4BFbCRS0i1IDwc1p02jo2NhYdWEThJt8yQ4KgzfulAMPlGE7QhLruR1
	c5aC+sV+OsHHAVJ2zMWnQSsozZp3bknoasR99/EHgLGPcnyDuAu8q6JcCL5GsHTD7fnhzDmmoNR
	SDVKAzN9Bicgm5bTi78/XSqN9No3s2I/Ad1/WYSn0RYNQvOoWHm97VxQxaouKpYI5AJZPj0b6Ik
	+bnB8H0IYYv8curP55GCknqsQqilMJZMayhteE6j6jypQOfVlrVVjAbuvF83rXOzZ920leeFeZb
	/CAcc3YVnFhThvSwky5T6ljuFL9sEobdrAr4vNdcWlq9nqHriPRdliDAVDrKCDkwF05uDfCa+mv
	tcYIUnBU3xXXRPVJlSgmgh0Xfb9fG10qbRvSWd472PuW1gjUBpNlr+f9LxYQwnDkLO9qYdEn0yd
	Mr2GJW2aDd6lt6Y7Z9WeW2V+qWwztIupw8xNe/FCD6iOWGP3BloK0HHIpOyPZRxYg+U9gEyyV2N
	Iy7m4uX0kxQk0s0mJv8xqIzhe0vUtN6QmZJBKpCmfi3L2+11lHKlN9E+GZDYJW3CFOQdR/3sWl1
	O2IV5wBPWkfj3I4dzcKy6KVqXyLd3C5O0voF/eZEZk0xLCFgxwhBMw4sCbw4pC+q11x/hnNyXoE
	7mtmjc961r1nvOGL2cUUZHmfyVipPyAlCOnJsNiHDX0KwvRLTebA==
X-Received: by 2002:a05:6000:454b:b0:4af:e519:cce5 with SMTP id ffacd0b85a97d-4afe519ceb3mr30409532f8f.3.1795817110480;
        Fri, 27 Nov 2026 14:05:10 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm51467422f8f.8.2026.11.27.14.05.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 14:05:09 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v7 2/6] notes: store the repository in struct notes_tree
Date: Fri, 27 Nov 2026 23:04:41 +0100
Message-ID: <20261127220445.45639-3-okhuomonajayi54@gmail.com>
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
 notes.h         | 15 +++++++++++----
 5 files changed, 38 insertions(+), 21 deletions(-)

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
index a73a51e1a0..6bfe80f176 100644
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
 
@@ -1266,7 +1271,8 @@ void free_notes(struct notes_tree *t)
  * Fill the given strbuf with the notes associated with the given object.
  *
  * If the given notes_tree structure is not initialized, it will be auto-
- * initialized to the default value (see documentation for init_notes() above).
+ * initialized to the default value (see documentation for
+ * notes_tree_init() above).
  * If the given notes_tree is NULL, the internal/default notes_tree will be
  * used instead.
  *
@@ -1286,7 +1292,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!t)
 		t = &default_notes_tree;
 	if (!t->initialized)
-		init_notes(t, NULL, NULL, 0);
+		notes_tree_init(t, the_repository, NULL, NULL, 0);
 
 	oid = get_note(t, object_oid);
 	if (!oid)
diff --git a/notes.h b/notes.h
index 6dc6d7b265..f4d1e31cd8 100644
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
@@ -100,15 +101,20 @@ char *default_notes_ref(struct repository *repo);
  *
  * If you pass t == NULL, the default internal notes_tree will be initialized.
  *
+ * 'r' is the repository that this notes_tree belongs to.
+ *
  * The combine_notes function that is passed becomes the default combine_notes
  * function for the given notes_tree. If NULL is passed, the default
  * combine_notes function is combine_notes_concatenate().
  *
+ * 'flags' is a combination of the NOTES_INIT_* flags above.
+ *
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
@@ -319,7 +325,8 @@ void format_display_notes(const struct object_id *object_oid,
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

