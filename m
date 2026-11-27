Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817136;
	b=N6Xs0BjJYBSMCVVBeN13CWKQFeKHOrdcu+nttMYzGsCBgnTsGj+IVOarTcejAYLkxgC+
	 VNaUp2qZFPYoc6jIF4wRzoJ2aetfJiqPokcNYQWaATb4NvpgbzXS1ygKW9Gv5fgqXv+Th
	 RJyZmqTQgH2hFFHCAjgM7Y7ZP3Q59vsl7T26wxJ1fDYgWOjovrUB2nCZCUbNOcIZJpnww
	 FFEu66XO4MZgBRej2+9vli14uD47WZngbIH45BqCaNJL0S82MhnzSlVGRxCSyTJ9S/x1I
	 dfmtMeMEqyVI6s+krE1aZZ2MAWZJpoll4JaYpdaE9CpMVzCX68YrhpuOYzZ/Edu0FwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ca6iqNDuk02EQZpE6y35+KaNUOvoZaNDmqcH3+rsxzE=;
	b=CpEaZpzFI49Wcz3NNlAqXYVUIyYhlOQ9Bfs7qX3VZp6eh8M47/kbGpXbzcu9wTlSd+bC
	 WEriQI8EbQo1sgeHqJSoFY6Gn5Gt3brE09REBFTom+6P8GjsVEJNGUAkg0vVLDyDSoDSl
	 HDsQ+7sjV9eNYlZHusCZ8W9nsfudxgoy7kAxr8HZkAhxWu1eknMj+ZEa5a+UuBMLOPiLG
	 w6oARLDS+ciRS0+Il3Vnqt3ob13VhjrVSxUN/yazkRq8VFnXQ3J/yr5ImLWl2PDq4tGIU
	 jkyNM+yap8kbSZAgawiUUP//upjkqW+Lv+s11/EWFFL4LOFDqdSO1r2Pv3aMlTfz+HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vYpQNMKi;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03E606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A03E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vYpQNMKi
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso86653575e9.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795817134; x=1796421934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ca6iqNDuk02EQZpE6y35+KaNUOvoZaNDmqcH3+rsxzE=;
        b=vYpQNMKit0ENTZX9a0ZsU8zsZxN1cu2jzzsU5RBgH/NrEqdGB6FlwlMc618T0ApJ25
         AMMsX09nt9hkF8E/dqKrcQgFgilHlMavartOHjnubKJuexHLFCEzIqnsccalf+nh7aeH
         CWfBpPodIaydVjCp/uxMZ4yOOPogpE+QdfEeZLjaRnNqk3kY4u7d2DM/jPeGGAp/cH1p
         qDi2Yns6TINUrpr+MqS0/kpauZrq/abWqgNnsq0Ik7R0kZQHZw7zlE+p36qKbA8cb0Ag
         PlVoD85GOGpx09TF99JB2eDuG7B31ChjkhfO7hw8XhiQaL/wRifZZg6ahGfxMOf6/umj
         bREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795817134; x=1796421934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ca6iqNDuk02EQZpE6y35+KaNUOvoZaNDmqcH3+rsxzE=;
        b=RV6Ssr7t3t+A4yxiZTn0eoFiADagauYdXzO1t62E6WX2b2pqT+ZEIhARjOo2z2SEuf
         6DnznUKmfcJDJCcLGiBARMAcFdMz2VbXQiDfkgM2Zbo0QVV5SwaJT9/FTkwBHY+iFvZX
         b8OAxvul2F/wcic8+aQzYhtZmYUgkFKIEx4AJQcEyjLKd9PcTPwVLu4GMNLe1efRkCF5
         u6bq9cDwN/sH+7Fumwv+yngEzZGjDOlUWIhV4d53GfG1lPnAJpESWk6Y48EjUl2b+mw5
         FDIMLTjNYptZU6WSs0XeUGzbt4vxBMuTlopRLyMnrCM7PxEPGgVHdlBnEdBliC/cvz3K
         /cUQ==
X-Gm-Message-State: APuU4Z+Oml5KqukXSsT/UkWBrWFycwSYj3NGxihfvfeK0E7QeDXnqtsp
	vf3vAA8XBs8Ijl8VeJWX41kbnVi0DXL1zEVwHfpwvIeEDN3eT8yLyeXaEsUMMSdNnmk=
X-Gm-Gg: AZFdTZfDFRRZpGmf8IloYZX3d1+avAqrjBCya3aeSNFU6i+tMd+SPY/1xSVKD+p0BFD
	ckFpG7eiunBKEs1tJoO9hHCvt6hBoAtDd65jPLIv9R6wpA1U9OM3RsADTHAupdH3Qf1Eb1ePlkR
	Yvuxk+mx0olMKJC2AHut3lGUiiD/RVZEPD8Qv80JXjhpXGT14tnyBaOXQtPjncCoJUFztVKZ/iN
	MHHBKtaJ1fqQOGb3Apqo/5Iyw/vv1bUcWBfN1lqg0jPWfDO6JZeP8MJTm1N/a+OmdVwAWNaGv0j
	UdkPSXg/hME0kfCSnjeYz+LTUHcfKkAI5zARXzj4ZPOdFQYjFz97MKKx7zWsPzdmOHQ291G+HBN
	IE+2Vxdg8YBL5GD8Z0GA29QETZ/mAzYNdDKTDsZoKOt4hNbsxrWVPY8HiF1Q98Fn2/wk8Opu4p3
	8ePX9/9FiYSIZ9SMd6i1f4w6UCwqMzXGYAMy4QbgLBos1tkte5n1RLzgdAY9t/pH8JNvmYaEUT0
	DinHVJHHrV5Xw/jmk/EjIQFdWeUK3Tg0c4I/bnA2qpith5RGPbyML8Q6oFcaxSwLqxupF9kS5eD
	CHpHaHxF4Vy9+iJXQEEObdP57rm/00ClwpdqgmZS/LmRwpp3YQmDmzf5Dyx2oUn2wCULzrIZJyR
	UJ7XjY4dakdjIZD12iQgooEOayDHcXwzKn+/glRGvOf3mJ37wnCISkA0wFn5A4RtEC+NqtHhx6X
	+SMWu60nalckwSoT+Erq2xQ6eJ4hK4
X-Received: by 2002:a05:600c:4515:b0:4bb:6f67:ca0b with SMTP id 5b1f17b1804b1-4bb888267f4mr542823695e9.29.1795817133846;
        Fri, 27 Nov 2026 14:05:33 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm51467422f8f.8.2026.11.27.14.05.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 14:05:33 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v7 6/6] notes: pass the repository to the combine_notes callbacks
Date: Fri, 27 Nov 2026 23:04:45 +0100
Message-ID: <20261127220445.45639-7-okhuomonajayi54@gmail.com>
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

