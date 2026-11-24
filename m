Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541024;
	b=2t8KjAHrYh5AhRWsC69Hi9tXBsUaQGlEkIs6WGY+h3vSX1pOg3eFDKN49JNe37fGgOwA
	 8p9vw2f8+SVHw9DlfEe707817+eQTGxri88Z77wROrz3N/x+EuvtWSamyGKM8EObc9QWD
	 VOpfDHeVwZ/6gEcUqpO+aTqGIL8Mcd1wJDXv9FCWlt3nCz0+x0fO530wIjnNRJy/+uoYC
	 yDePG1ZcKFanaun3X3M3vrgn9gqBc8whtqmILarTWXPbWw+bSbI1IOD32idLCRzaa2WPA
	 uEkYVKyB261HzpDBgJIMKspNP6H7zD6tk4CTAbIQi2FQC06/9W2P0HyuexRodNy6ZqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9+WkDByY9p6OKltcLAksyn5x2Sd2UcS1egN61x/oJvQ=;
	b=kq01TkxEAE2hKSKca+K604in2AeJzAGf1THMHy2jXI2H8Vj1oZaMEpHAmdZPJaF1iwzi
	 XIuvrHIdhYplkJJyMITVAmU6JI67/GmO8koTihdi9IeDrhf1SYMYbZB5w4XC72lK3598r
	 kwVKypGhIxcmIhSH8ue4jITbWWA4OgBH/sr/u9ND39nsTrx7f4YyxU/EbQ1/xnJdHUk0G
	 cQ/d5ijh/DC0ri9BIy36sX7xBZ2V0ou8PluPf9kfpo/Ts7dRHAVxudPZ59JHMAHklwidH
	 GIDwY11KlhU+P/feeoazA3Mktlot2TQIatKn9R7VpSO75vnpzKYLv1CgQshkqzyt/Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vroft28P;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97686606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97686606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vroft28P
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50e26763a4so882084866b.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795541022; x=1796145822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+WkDByY9p6OKltcLAksyn5x2Sd2UcS1egN61x/oJvQ=;
        b=Vroft28PVZOY1DF2VTnwlameX7YoP0AJzQQXwUP+QCIg4zYchRHl+ZMTUxfNZm4Tco
         0Nbe23BP8pL3/MqkznXLC2ImctS1lhb5juFnUh6OrL31qXG5fLFAxidAGlR4VJSg9bH4
         IPMkSYdwtJQn0Eh0VjJDj9SaGCGpLzsc99gRN9kwrR/8HYukOypX8ZtgH1VsGFLjBsKV
         dimSItZTiGFggTU0/oTshvEz2n6rFuTL+60fklKXJTfTM8drUU4DAicYjJ4ieRenGy+4
         o08k40iZLDi6tZ/zaj1xUPZVtHDIh2BhCWMFYnD+ZtiDLOqbb1RnwD3dKPNfsIroEXPh
         vjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541022; x=1796145822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9+WkDByY9p6OKltcLAksyn5x2Sd2UcS1egN61x/oJvQ=;
        b=gUfIaDJP5C0RH3eU7DbwCnzg5nLP/JN/rQFtY16hoI6mnnPiD8Jj9sgIF6YZeAkX3I
         5ZDEFl3kLtYX7JP4x90HXKUuFX+NU/M+zC09rw78g6V4b6yEC5tNNw5K8pgfwzG5HR2N
         CEecx57Y+iGfV6Z7ynHL68AZzuCT5aGKEj1IElSWOEQv/dzBBA2DeDHkeVDqD5iG0ApQ
         SCEFxxF5AnSil18VqmSnBF4pAVI78iT3Z5cAHsWW3W2hXbgBvrZk51EoMWqAh9Tx7sEn
         eRGK1oQIlSi4xyIFjTZWo30mjIeZnBiiyCOTuk6glOb3UU1WmDDGsJEL2d/a8o7+FVCA
         FkuA==
X-Gm-Message-State: APuU4Z8gKTxuhQ1AJlnBTF2BSM8JQqyVf4HP/N1qTIWZXLtUqGSlv7LF
	IMbXYVMBDAjF1NLXODIUefwb1jwNoaXKgKJONjfU1mM13RKn7tYmaOyN77z9p22+4WU=
X-Gm-Gg: AZFdTZdNuOElERmxA08uBcRHdnqKG3ar8XROR6JGMrW7IVllwgmbUKF0AW+i6V3NOdV
	pyxLNVW+tSJqnEtCZBwV7i6ob+noRfix2TJkyDHOj/L4Hla3NO19fcbMBnw1Sjlss4gRSYK0ouj
	G+2rtmIaBrArQhlzzNUmELaVzz8gAsI8id/i1m8PkpSVbAP6bsFbmlLk4nNBEjAEFFTy/+fVc9u
	RMh5N6uS39EwjOBo+yWHatSHH47qls8OqWFgCY1DefkbmxS+domUOlBS/euTaNXubs1St1oe9QY
	qBrpRnAidLCJOEjQaXtLrHeOs5uSR/hnoUSzupGt9wC4uHLU4LYU3YlelKWbpeIViLk/nn2Z64r
	G2E1lSF+XmnJV8H28oVQZKi6xjVXwi1NKGoHB+VMrp/CYIge8DQYrN31XUA9pDcMAiWt09M1fGp
	ckPgVuxe8r2tWZLYZ2RJEteB6N33jHf9qS067xXs+v9CwkFQfWeGf7c7qbz45mR9VuF85bYFGzv
	yXL37v1QrOo2xxDKkaqOUK75STQ1jDkEq4u9RDygyqzJ/9r5GaxkhtUmqBBm+LZXrhwXDjRagGl
	NvZO7ted0j2aepOg8M6AhuaXRqymvUjJkf/IYdPDwq1rEp+v6duGOaUEWymkfrlKKezKeOfrHW0
	gVg94i64DpGLD7n7TqJPxJyPhZlBTr7aud3lKXZYYP4QHhjKEmvV8dPF2ORAouDo+NOHDXSkLsS
	ZilaGBAl2nR1N+xDJj+kH48BOpAXnk
X-Received: by 2002:a17:906:f5a5:b0:c46:6a50:40c2 with SMTP id a640c23a62f3a-c513ac7e167mr1293472466b.39.1795541021759;
        Tue, 24 Nov 2026 09:23:41 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe01a0sm547394466b.68.2026.11.24.09.23.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:23:41 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v2 5/5] notes: pass the repository to the combine_notes callbacks
Date: Tue, 24 Nov 2026 18:21:46 +0100
Message-ID: <20261124172146.18330-6-okhuomonajayi54@gmail.com>
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
index ed6fc9a1c2..055ba84b7d 100644
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
index 520a816714..3aa1d3e45e 100644
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

