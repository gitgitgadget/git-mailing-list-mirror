Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644167;
	b=UBPVuiw6WzYHSFx328YYHF0O6zOyCIT/Q9vHDcinut9JuXppf+o1qu/vUdYCB4gGuQe2
	 4okEUKLCkehyzZ1QX3ls30/lMbqQ4R+bsdbhi/TCRDdj2Giuj9pWw83L/4gFD0OSp/qBK
	 5MHvR1jjfYWMsI9s4c1M0qxKPdY3HicFHhpbten/QLWb2yxx3S26NyRw7DbzlmKVJBhAI
	 cGykLMRhSXfaVUwguS0J96tDqqMK76CIvzgE4RD6+NZRUIC6ZSeFvqee1sA0oPCTJDLAZ
	 Y/7fwys2+pZteEbYA87KWHIFgCtysJRtSju+KT+tlTameBbbgncXqvviPZbQIbRnuMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pIrUuAgjffxgB23dY1zrC/ndxydb9lIGQYal54SORaU=;
	b=hBUAxiefdQxyQlZCKF+aPELOpShrmCkpgMUOmmb44S1ZIISmkPwB8qy4zSg6BR4C/G9q
	 Bh3uaHeL3CRH/Yr+mPlmtTCWipaWxZX0Dvv09XkOVeCmOgo1vgFv1+aJJQqciCPdj5DiZ
	 o885lNY6T+3/WxH2QxxGZTjuu3v89qt/Tj0YohSxfiJhHJ2zZgHA349Ru7nGZPJspxM8I
	 pvPqUk9xLqKi0khyPU/ZbUWUTYlibe2TMu9Pu3lJziP2wowsEqMmx33s6tP0Nc4gSpQyC
	 NzyUf409UkHiVsU2mCHStK4JkKNOExcjKDvKhimvNRQCrm50Zert93iotOnWWOWIYpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="a/2S5Rma";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4E606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAD4E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a/2S5Rma
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4395d31228so1070729766b.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644165; x=1796248965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIrUuAgjffxgB23dY1zrC/ndxydb9lIGQYal54SORaU=;
        b=a/2S5RmaseCOZuZLIC9PSEpxYmKTq44Pyw4CG7r+3Ad4Dke9jfScDJEzOICh5T7kWU
         XfQ8ZvSe2W/Q5u7DT/gWnGmBS+8Zr/JkTUReRcfiHW4+FGS2cfELyMcsE85KOPnAD4nA
         bIdowV/aL70r7+2qhMJtdGL3DjHxMOxFxEv2wDox9esPsEcFNBSyXldDiHcSztrpYRjh
         M+R4szuelI1QYzj1GyvkpchrArOSoJyozOkv4LS3zpQTCXRcb00w3KlKPf0FTqQUmeNW
         yYqWGxirVBNAMxynOdyYuATYiJa7P4499W7o3FXQoSqoF2d3GYBZAtdQP+nEnbF0nT+8
         P/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644165; x=1796248965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pIrUuAgjffxgB23dY1zrC/ndxydb9lIGQYal54SORaU=;
        b=z7Lj0offmVMM2N16XKUuVrce4dkNTqa9fz60xFR5tjClPEhbGitGQbj/gHOqOrIbTu
         i1GKbxuyzdgvJyqsD6FBvauOuPDzSPVyVwC0YBDpvCpfcHPPcopmPboxPO/zLTme7f14
         PTvDbm0C4jOjefmR2tmd9kUf08L6cG426SbB9yTqDaFHi6uM4ZMbekqrVL3ZF2+6JeG/
         RWvZ53zVOK07/JA7vvCiJmVqzeGrFzy2EPN36jIZfyzsrZxo3iBrvaRFSk2PUC62JGZ9
         FVyCY427QTli8JTWUPuB4zXIj5uUOdUya49N5PwLEEpdoeLTxbswx9cpH4rNMrpSQgnZ
         E9PA==
X-Gm-Message-State: APuU4Z9rXvhyyXGuFrx88awDStfp2iQPnjV2SsDEadxRWkpbc9vQjilh
	jVyKm7C846VMuoFIq6X2NA6L+pIWdK3mnARDRdEOrfGek3MuXYLPmjAam7jgBNyiAbM=
X-Gm-Gg: AZFdTZc76/QhWdS3Sr5YySNID8bBnoesPtw4mevQngnGBrFaF19+lrzlB+9CvWq6jeb
	fSMALXDorIZRruGnz8sr+7drZoCLQM25K06ZtixCwkMB4N7Qi/qtr++VK/TqLy95tUHdMDL6t9f
	r+MCf0m7sTQncD6yatHYxr+fHhf6yTaRtKLIK9BR7oq8cG0H+QTm6QHUKOPcc3IAGaGE/Vbgjo1
	4tvCa8sCRGEHDvTz/ZJ27HVJdffv5SX4x4zKfDQy3kilcyEHZptApfn7DmeMsSRY1T1CsWr1NNq
	HlpHLEc95fX66GoAlZLxADUqatj5tKmZSC7L7zHWddMNbb8ZS668XHNtCkWFG6yu3OnE04cE2Ly
	b/C52KH0y+mgcJbs2Esfk5wET460RB1K/TalqfauDm2KomCvCRRkPG6307IB6BcFbBnHMzXZhgM
	R6uYF4a4cCN5wDiCQ52CWHvn9+uibN+xsAOiZ8Yx5DdT/Uo0fOtTpcFSaKiTBBd59oNtuEorupA
	m+zAYWuSHKHjJ02gA/OEPmTWLcdHswglj97LcGJbmPFqbc7nb/w+0ok4FkYfJzS8MK1qjRiP4W9
	+ONO70YLLdVx0fMHuPWzisZMDm2xwVjQr4DTBXihbxpxiZ8jAKibi/eOyOOZCSp/H8YIKb40rR0
	BMnzUlW8R1YdUwYIH6gunHQT+00s3B9QCA4/z+ilN9cXliDEhJpznV/iEihXTUwhfFi0nMSdDVh
	9mGTCgdhOZoD0Gjufac3+MuHI2vfm5
X-Received: by 2002:a17:906:2dd8:b0:c2e:3ed7:7db4 with SMTP id a640c23a62f3a-c513a840ebemr1223228066b.23.1795644164757;
        Wed, 25 Nov 2026 14:02:44 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec3c60sm676998366b.50.2026.11.25.14.02.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 14:02:43 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v5 2/6] notes: store the repository in struct notes_tree
Date: Wed, 25 Nov 2026 23:02:10 +0100
Message-ID: <20261125220214.35881-3-okhuomonajayi54@gmail.com>
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

