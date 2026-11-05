Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910861;
	b=qXPMfspWCXpiJ2t2b+XYVEvoOqoQzUGYexRR7JChIzigA2at0YPbxo/xCJyd8yC73RZR
	 rPHvTaiNR2/1VjtzyvJCw3eUuUOqzk84qQW/gaKLb+CNYzhFtHSm1QG2DOl4e+rn8b3L0
	 EWgAcJ+hLzjpXLP/Uwr8/E9p0hqCkOmaUAHDb45wn8gT28MzqFexGhTLCh+JP22B6JnUl
	 ttkT9DAaUPQ0pis3jw9+8Dd31RoP5LGfLHB3GTvyXSb/W5IBUe7JtUfp9dJ97XE+Sk5Q8
	 yaPGOBSRH4gLhh2OzSD08omwM9GJCGOgDRq5EwML0IY6S/BdzTePjFJnGcK6xAukZyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lwgPUWq5m7U13KKOOaGI18bwDDbo07T1I8xdSxuDAnE=;
	b=lDJOPSzoY2oPoOV+YfOVJAI+dn0NRpdxQItMzK4c7Cu5eqgMDJMp51QbCTtJoc26Tl0w
	 E134S5devDxHSEBR8UBD0nZJgw48W629q8TlgfU10ai7QIFwHLWqvYJrMcwjSQME3lGQp
	 u4PBo0AgxZxIWQclXavJ0h1QALV5RIOorj+TEgPC1iYKjrKRFfmgc37VSPLmPMfZxeveq
	 ZHlnm6OZUgkRf4IusDpEBz8j7mKyNBywoxHS2RjQpQatXsEmvtCWRmvDpG24/gCri1Xmk
	 XVJKw8Ln9vwKBOAlZpzI+cKVnJoC1lUcKzAg0YRm15OE6RLzGFmgSz+90MRpKJg3eCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjYexmb1;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA148606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 20:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA148606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjYexmb1
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso817899a12.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 12:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910859; x=1794515659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwgPUWq5m7U13KKOOaGI18bwDDbo07T1I8xdSxuDAnE=;
        b=cjYexmb1HCyQouXSp0edI/lNvV98lnb3/YjxnR3ETgNZd99wZsWpIsWkBmC/2kEgqy
         EaDyD1GZmSDZqcK7cUSv19HehyKqUgUPVO1XRKidtxmZd/qQz+OiGPmMjoIP7+rS/GjD
         A8Z/iHc+iTQ9xLympUkiXiFDGIFe73waFaoqzyOLLuUvQz7/43Dr46pKswzGFqhTwvrw
         19DGmvtMVuM5pJsXZex/VgZtvIQokObWlyxu2Srr6YWNBBEQ+hEUbJjoHLR7cqHymAYE
         f5vVPEnL8fs6G6iB7xMOhKdY8AAWH2h/DEJR2Lhf4QTSHGt8/eAdeaOD+wgWa7xoTIJn
         zRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910859; x=1794515659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lwgPUWq5m7U13KKOOaGI18bwDDbo07T1I8xdSxuDAnE=;
        b=DOCssVBH8EpcX0+iMbKw3TgM7ub2Xa9TzNtn0FsZMoggCgqA9j2sX/J3QdZfuzH5b3
         NEm2XQRFknWJnWtzH/yXWYrkMGXU3SPERt4jlEuDaBJ6JT3J3M5/AaVvfNRf6MkiDyAb
         nncJeyJmPY/K6lWfK78e/n/g4cIOIrCnR1UjTexPB15Zig/pr6x2YvS+k7VVkQOQQY1I
         22ho5IRMvXdbTyNotjnjE00rbu7RgEk34LcWvRVBdSY/VfPLKB5yfjE9AAs1darFxFck
         OauykHLu8d/IgRtg/DvQg7Rp0DF/TZUELZ6rNP07pnR5+8TZrXO9qzejN1M34zYvg4+v
         wcxA==
X-Gm-Message-State: APuU4Z/bRpMrXIRlslxpwou8v/3YDYjFD0MAgYTAX2ZnNYn/Yi8GOrAM
	9wyxHiuwebbFSnpcCPp4zShcklKqFj5NJgom55VVtW9a8ZSOfMZpwBqgaLK/s4mJV2rKIw==
X-Gm-Gg: AYBFou18c5ac38a93Y6p7p2EX8viEe14ABI95iwccrJNBL3hhD987PLYbLG40guaiXT
	5gQaqLbSlzVPshctBpZYuG4L4ylrptyqqu4j+U0YJrndy5JwA6eA9A44ICEdUIiH8U29km2okLy
	TqX+7RTOI7djfVdSe2HgIz7DEH0DjjHxg//FI/AuQWo8wJsUq2w21RBiXEcu8FBeGocsv5O0edv
	MRRW0dnJEjFFM2EdOl+ERdB9sNOIQ0R8fhhO7dDm9iUo/B3Ho25Xhs/EwwjZOI2dC2OoY1zns9d
	xykSnXMK7PDMrmWwGXwZkRaX72GbA7Ihnz0TC+sYXm3kdw8C76XGElYtwcBwq2yRTpKEbsR5KM4
	0yfwei54329t2VLHTPlrTLVrK0YficL9MfKRL0glAtfaeB2l5ux/SpQE+vH6TnEunUr57F5lPBk
	EZp+I5DY/d76yyT4si5XlUXFY8FASbe3IBvvKqqH/S70mAvfg/kJmSR99zBjZVNnqt6apOQ4gP7
	zcJbvD8wunE7xd6x8+Xhul31xQN8ccTljDwvbrHgkbHtcXPftyjtEXwG+pu/q/DbEtqeE9jp7hG
	rYf4aLgcTzaTKmKYw5KWo3w9bT1kZRljbrhCDo8M3upFu5zUHQqtibl7LXAqV3ydMZEB3YW838P
	f84sDjgzgDHnZmmVft56BNYYMVw5spOVRRusbTQwFYAZJ3OhKzVeN0FpbPbc2LkSGxLAbHXf+hC
	nicCZBM+/0TV97KCeqykHA1p1Bpr2o
X-Received: by 2002:a05:6402:4342:b0:6b5:6476:3d1b with SMTP id 4fb4d7f45d1cf-6b59780261cmr257403a12.32.1793910859289;
        Thu, 05 Nov 2026 12:34:19 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5853e0536sm702689a12.31.2026.11.05.12.34.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 12:34:18 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: [Outreachy PATCH 5/6] notes: pass the repository to the combine_notes callbacks
Date: Thu,  5 Nov 2026 21:33:43 +0100
Message-ID: <20261105203344.48513-6-okhuomonajayi54@gmail.com>
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

combine_notes_concatenate() and combine_notes_cat_sort_uniq() read
and write note blobs in the_repository, even when the notes tree
belongs to another repository. The callbacks are only called from
note_tree_insert(), which has the tree.

Pass the tree's repository to all combine_notes callbacks. Also make
copy_note() use the tree's hash algorithm for its null object ID.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes.c | 34 ++++++++++++++++++++--------------
 notes.h | 23 ++++++++++++++---------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/notes.c b/notes.c
index cff63a4410..d675562bf6 100644
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
@@ -1382,7 +1387,8 @@ int copy_note(struct notes_tree *t,
 	if (note)
 		return add_note(t, to_obj, note, combine_notes);
 	else if (existing_note)
-		return add_note(t, to_obj, null_oid(the_hash_algo), combine_notes);
+		return add_note(t, to_obj, null_oid(t->repo->hash_algo),
+				combine_notes);
 
 	return 0;
 }
diff --git a/notes.h b/notes.h
index b571ecede4..6d6f6068d8 100644
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

