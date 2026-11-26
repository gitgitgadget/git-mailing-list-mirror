Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728833;
	b=a+z53QkxtBjXiHqpkoBHgVc3St3T9OGPyHBtYuZKOhd644EosiMnGhhGt+2qziCqi0Qh
	 I+3z+5PX28pz29ZlZ0CgzFfe2aSfe+jCjwO2M1dJI7kur8bHqwatYXIml7VbYXtoa2S6k
	 RAPdtrEpsdIkRcl62ZDQjeluMvB11bphHvYdwjKAAyK3b0nLsgm0Gax09tWSoBsRQ3VD0
	 G3hsMkiekOg5tx73jXVDGSFLhASs+QgXXxDWKZDxd56yU4j/4daO0NM4PWuYVqMfJ0qkp
	 0JpGa4rUlKGw1BwItQ1u0uiQSLKCj+6ekG4cSxB6AhPklb4vvSYD4drMU+eCcrWSq+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ca6iqNDuk02EQZpE6y35+KaNUOvoZaNDmqcH3+rsxzE=;
	b=t99XK1mc7ZZ3mkwIHu4B2/ZYw0f7chsPg36g3FmV8NmzTyO5qO+nnGyd0bnJP39GNfZ8
	 M0YT69GXXZvnoPeRuwGZeQLNlvIiMf/mwvodcKLV0m1TfIDhFkhLQNvahdEH2oCLL1GYs
	 H49vC1A2CfIedRy9e1Xsq+KbM675IFpGQWjbFNGXRvG8tIXyg/ZPZCYQcYU9KExKv+MGm
	 CleV6QFWOwGZDaNG5It2NsOmkZdaPmNXdq7bT8LkgZ/v8HD4yhxbltuKJteXe4YjHlwUP
	 nPkgyq6UASxg3+u1vLZE3O2SVcdTiLw2BeiB4xQrkCaHH6LAZBDmUB464H/TgVtqdrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJrMq9MQ;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1AE606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJrMq9MQ
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c516a1623d0so822177466b.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795728831; x=1796333631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ca6iqNDuk02EQZpE6y35+KaNUOvoZaNDmqcH3+rsxzE=;
        b=QJrMq9MQyKhzWeyxaPXHBPvoTHlkE0z/N1pw2vqhUn8sVZvvM+VTbgZTCP7UEGgOYH
         xuNtihk2Rysv/Yjpo7dNsve0JTEPYkWpyq/qPGjbwZ2U5f48Sv5f1c/qg4iEU7U8ATiY
         X7sa98hMAbrunD3ih5tZu+OlwBsYZZzOYGlk8DMkjCzYKPscYYckQkZ6pT8PGsCX0v/7
         p2L287ckRISMC15AbAZ9O6aFbysMywPSy7iWjpLLQUk7WM2lrQ2XTGhoqHCE1wC4NxjM
         car1MHDRsX7zSlOgrgJeZq/w2vtx5JurjdPpaPb+IlEhzI4ER4yQzYkwHsWyfOv4VsSR
         LWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728831; x=1796333631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ca6iqNDuk02EQZpE6y35+KaNUOvoZaNDmqcH3+rsxzE=;
        b=ouvLr2okbWawo0LFavlcMQsKvpChSoLYzL3YQIaVXTgtXANL3BG/glnk6CUiCOo6GY
         GcJshUzDGP2V25J5scqI+sZyJ7IAZA6CEEWDKKeSNS4dM/sSHuLqJSBS9JnztlnYd6gQ
         am+K1uL4ioocW0KSrDRVE4hHPvyMNGinvZ35arNw/1olXhjvNsXS9SGMrm0atejXqVQ2
         WBSttZNNXzaVQQY6FhAjcDBmGNvIF/NoT4JW4dWe6z7zHkHb1KkBb5OngDAVCe4uNlFi
         IvOtUl9QgsA9nrdvo7WMkd7lqCpfp9CiUXSwEsAj2sruCpJEvXx2CG048pf3HI0i/Uqg
         XHJA==
X-Gm-Message-State: APuU4Z+/WpgaiajPcswSq0MbwDqtLaR+7hRMmylAuGWWrX0KMmwczzP1
	D5ZOn8rztOg3aVf7JdUc+9a1+ZWzwdyi2SxPEAYuWrC0rGIwwQG/lNvWEbKxsLRMh4eHhw==
X-Gm-Gg: AZFdTZe78WLpXQBNSckjkO9WD55MR8Q9teMat89VUsZbPC809e7TIRuHpLWSajzTPWg
	zvbMT5XTu/+FoKpOR1c63R2wshk8Y4O4pCIWZLekwFbhcIrhUuOBF8yQH5v1Ki73OKvOJP1cw/3
	/cwUE8keOSTimKRjbkeMsafgGVQ8OPj/ezIg9q00N00wl3fd3feLL3yEDAgESkuBKeiTGhxg/oO
	pZAqYDe8jqYO2QA/wjLZ6ExGGM6JsjAJYnWb3fQ9O/9Wb8lf6FPFdXCRKz6opGH/ZU4jKryStyZ
	NJvlOy8o1FymY+s/HPwfqizcaTIIgfFhcRrRwWtXCN7Q136Z+YNYk8j1OxMehrwhXJGqWZtMWaV
	OrCJxehoAVa1Av4fkyL7J8sML+toQL515v1gBU0dlW4jj11DNmNooEnuyIY5Qx2/pe0FZcjgwlg
	6+/0627U00ZTe+Z1OmI2WQa9sQs6a+DGp+goZQ+FhsBdcznlftNUIUABBKEP4SQeFMQaqJKgAKY
	R2LZ93GwjTLBkDa6Ikg3Uz93uKxtZ3K8HSJqBTty2o/bXVZMvQIpDCId9kIfu22cXrDZHhiLbnx
	r9jUnwgPBLFX5p/L+744zNiQZPJtR32rGXEz3sylnqNZGZRDlbUlzrz2mgc+cuj1b6wYR59Dso8
	JssNJQ2yntkbs6A84MR7mbeAY5bxFSsfXeG7DuReubm1xJCgF5il7OtPDp3mR29YpST31VWKXmb
	VwISJr4LKJgxwTPtfKIzcVGz1R/1iX
X-Received: by 2002:a17:906:7c2:b0:c50:f0fe:438a with SMTP id a640c23a62f3a-c513a5e2526mr1532049466b.8.1795728831089;
        Thu, 26 Nov 2026 13:33:51 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b030ed9sm805237066b.86.2026.11.26.13.33.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 13:33:49 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v6 6/6] notes: pass the repository to the combine_notes callbacks
Date: Thu, 26 Nov 2026 22:33:06 +0100
Message-ID: <20261126213306.87466-7-okhuomonajayi54@gmail.com>
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

combine_notes_concatenate() and combine_notes_cat_sort_uniq() read
and write note blobs in the_repository, even when the notes tree
belongs to another repository. The callbacks are only called from
note_tree_insert(), which has the tree.

Pass the tree's repository to all combine_notes callbacks.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes.c | 31 ++++++++++++++++++-------------
 notes.h | 23 ++++++++++++++---------
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/notes.c b/notes.c
index f327652994..25e5873ac2 100644
--- a/notes.c
+++ b/notes.c
@@ -279,7 +279,7 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 					return 0;
 				}
 
-				ret = combine_notes(&l->val_oid,
+				ret = combine_notes(t->repo, &l->val_oid,
 						    &entry->val_oid);
 				if (!ret && is_null_oid(&l->val_oid))
 					note_tree_remove(t, tree, n, entry);
@@ -816,7 +816,8 @@ static int prune_notes_helper(const struct object_id *object_oid,
 	return 0;
 }
 
-int combine_notes_concatenate(struct object_id *cur_oid,
+int combine_notes_concatenate(struct repository *r,
+			      struct object_id *cur_oid,
 			      const struct object_id *new_oid)
 {
 	char *cur_msg = NULL, *new_msg = NULL, *buf;
@@ -827,14 +828,14 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 
 	/* read in both note blob objects */
 	if (!is_null_oid(new_oid))
-		new_msg = odb_read_object(the_repository->objects, new_oid,
+		new_msg = odb_read_object(r->objects, new_oid,
 					  &new_type, &new_len);
 	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
 		free(new_msg);
 		return 0;
 	}
 	if (!is_null_oid(cur_oid))
-		cur_msg = odb_read_object(the_repository->objects, cur_oid,
+		cur_msg = odb_read_object(r->objects, cur_oid,
 					  &cur_type, &cur_len);
 	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
 		free(cur_msg);
@@ -858,20 +859,22 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 	free(new_msg);
 
 	/* create a new blob object from buf */
-	ret = odb_write_object(the_repository->objects, buf,
+	ret = odb_write_object(r->objects, buf,
 			       buf_len, OBJ_BLOB, cur_oid);
 	free(buf);
 	return ret;
 }
 
-int combine_notes_overwrite(struct object_id *cur_oid,
+int combine_notes_overwrite(struct repository *r UNUSED,
+			    struct object_id *cur_oid,
 			    const struct object_id *new_oid)
 {
 	oidcpy(cur_oid, new_oid);
 	return 0;
 }
 
-int combine_notes_ignore(struct object_id *cur_oid UNUSED,
+int combine_notes_ignore(struct repository *r UNUSED,
+			 struct object_id *cur_oid UNUSED,
 			 const struct object_id *new_oid UNUSED)
 {
 	return 0;
@@ -881,7 +884,8 @@ int combine_notes_ignore(struct object_id *cur_oid UNUSED,
  * Add the lines from the named object to list, with trailing
  * newlines removed.
  */
-static int string_list_add_note_lines(struct string_list *list,
+static int string_list_add_note_lines(struct repository *r,
+				      struct string_list *list,
 				      const struct object_id *oid)
 {
 	char *data;
@@ -892,7 +896,7 @@ static int string_list_add_note_lines(struct string_list *list,
 		return 0;
 
 	/* read_sha1_file NUL-terminates */
-	data = odb_read_object(the_repository->objects, oid, &t, &len);
+	data = odb_read_object(r->objects, oid, &t, &len);
 	if (t != OBJ_BLOB || !data || !len) {
 		free(data);
 		return t != OBJ_BLOB || !data;
@@ -918,7 +922,8 @@ static int string_list_join_lines_helper(struct string_list_item *item,
 	return 0;
 }
 
-int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
+int combine_notes_cat_sort_uniq(struct repository *r,
+				struct object_id *cur_oid,
 				const struct object_id *new_oid)
 {
 	struct string_list sort_uniq_list = STRING_LIST_INIT_DUP;
@@ -926,9 +931,9 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 	int ret = 1;
 
 	/* read both note blob objects into unique_lines */
-	if (string_list_add_note_lines(&sort_uniq_list, cur_oid))
+	if (string_list_add_note_lines(r, &sort_uniq_list, cur_oid))
 		goto out;
-	if (string_list_add_note_lines(&sort_uniq_list, new_oid))
+	if (string_list_add_note_lines(r, &sort_uniq_list, new_oid))
 		goto out;
 	string_list_remove_empty_items(&sort_uniq_list, 0);
 	string_list_sort_u(&sort_uniq_list, 0);
@@ -938,7 +943,7 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 				 string_list_join_lines_helper, &buf))
 		goto out;
 
-	ret = odb_write_object(the_repository->objects, buf.buf,
+	ret = odb_write_object(r->objects, buf.buf,
 			       buf.len, OBJ_BLOB, cur_oid);
 
 out:
diff --git a/notes.h b/notes.h
index 30adf0c197..3eb73adf54 100644
--- a/notes.h
+++ b/notes.h
@@ -13,10 +13,10 @@ struct strbuf;
  * When adding a new note annotating the same object as an existing note, it is
  * up to the caller to decide how to combine the two notes. The decision is
  * made by passing in a function of the following form. The function accepts
- * two object_ids -- of the existing note and the new note, respectively. The
- * function then combines the notes in whatever way it sees fit, and writes the
- * resulting oid into the first argument (cur_oid). A non-zero return
- * value indicates failure.
+ * the repository the notes live in and two object_ids -- of the existing
+ * note and the new note, respectively. The function then combines the notes
+ * in whatever way it sees fit, and writes the resulting oid into cur_oid.
+ * A non-zero return value indicates failure.
  *
  * The two given object_ids shall both be non-NULL and different from each
  * other. Either of them (but not both) may be == null_oid, which indicates an
@@ -27,17 +27,22 @@ struct strbuf;
  * combine_notes_concatenate(), which appends the contents of the new note to
  * the contents of the existing note.
  */
-typedef int (*combine_notes_fn)(struct object_id *cur_oid,
+typedef int (*combine_notes_fn)(struct repository *r,
+				struct object_id *cur_oid,
 				const struct object_id *new_oid);
 
 /* Common notes combinators */
-int combine_notes_concatenate(struct object_id *cur_oid,
+int combine_notes_concatenate(struct repository *r,
+			      struct object_id *cur_oid,
 			      const struct object_id *new_oid);
-int combine_notes_overwrite(struct object_id *cur_oid,
+int combine_notes_overwrite(struct repository *r,
+			    struct object_id *cur_oid,
 			    const struct object_id *new_oid);
-int combine_notes_ignore(struct object_id *cur_oid,
+int combine_notes_ignore(struct repository *r,
+			 struct object_id *cur_oid,
 			 const struct object_id *new_oid);
-int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
+int combine_notes_cat_sort_uniq(struct repository *r,
+				struct object_id *cur_oid,
 				const struct object_id *new_oid);
 
 /*
-- 
2.56.0

