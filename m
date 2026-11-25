Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644195;
	b=vyl+/AKDAu2mtq8hRi1N/g5y7MD96ZnWIpnZMJQlzXwj0J2mqEl2PNlpW5c9khlhAD5B
	 Ccbjp+UXxQR2cmgLrKxx0ElDIlztj1MigskUvPwPGR8tiPop2wDR+uU8GME8nfT5q7YzC
	 FFKDysLLYssr8eqDPWNFf06RF/o0BqFzwKtgY7mPidJ0fCRHWKku69SQo1AiaSem7KX/x
	 fF1WQ76jimDs5mxy6R75pBztv/CtVjYbyEzP0J4O7WRlC9zQMFgq7iCLUMaAQrFg7zuIB
	 DWKK0CKS73AcvsMBmslz3VcyXRb9XeCcnusOf7Uh+8Q32UOK3sq8mALNc6O0M8uQ36g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ca6iqNDuk02EQZpE6y35+KaNUOvoZaNDmqcH3+rsxzE=;
	b=NEpSccytkfL37zzN+S+UvCTQ4aC5mhAci0Xt9DAZar4GstEf0kyayDbUlj93b42jHkfh
	 9VfCqR74WJcJCpsXhNzT+5fawOQfXfdQLwqlGPhtZWd8OykJCoEvKhd+dIx81tkdc7Scd
	 cShXhiH21EQnM98BLvf4fje/rJDZ9H3Bcn663Ke6fvAJXA7tb3RafRvOk2uX6yTC7kk8O
	 FR0UFJ2KPG6XR3ni8+umvZR2JVkkhnukU4PS7MElKicOPeMlbjgv1Gqs7ik+ovEVOjWbQ
	 q/eIKUdDRzA/LBFw40feEGr5sVcBUpwfovtGCYvboRZMEIwyxWv18D6Q1jQFa7qWw8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qwQImPzS;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41EF606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B41EF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qwQImPzS
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c51c294cef6so13516966b.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644193; x=1796248993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ca6iqNDuk02EQZpE6y35+KaNUOvoZaNDmqcH3+rsxzE=;
        b=qwQImPzS35vhT9xHHu1o38WWNdhKqYQ4qObXFw6kfNQVj1WU3LaPmFe3hQwf4kXrT4
         /9ZjON436SdETc4+w6R22NfcYq7OxITwo74MhQdLLpNkn/9S29Rviyol5I9LHng3BcpN
         Ck5lbgW1hfnpk2hV9v+35EQVk1FH0vAN/+lOiWSsqBQ3ZR2Wk7XuUzj2E0M8ZTFGvzbi
         fvSJjxv3uk+IDAJwxTDnx35lkjPZGnR8jLXYjjbf4PQA8I52HrAnmYaOkEWCC317fZQN
         Yrv+xC8aN20zXqrvDay9YzPVGz4xhTqpGbUh+Rw+oLOw0+QuVR7tGcauZPZMVAe0chbS
         4pkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644193; x=1796248993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ca6iqNDuk02EQZpE6y35+KaNUOvoZaNDmqcH3+rsxzE=;
        b=YxcwRWw+LZVzGU1WIIxq/w9VU3AZgtpX459+cFn1FffSeRayRXYUa4IdLPXvaHJUEA
         B9Wspw0zYMu9QogxGuP48hZHnG0SQkmNeP8WJYll+FrFJ8pjdXB6CPr16kVclSVGgSYn
         qrldYApyPmNYOmOJJH1W5hsLyN6Ez+DKH5W76ijwMhpS6NsDtpmelrc1aQpqGHAomLpJ
         4OC9k7JaQ437CVwbrcsxR2ezeE96ezD7HARn/cL13xGW+fTt44r9Aw1FYPPSmwDYHFif
         QHuLDQOHJDJrWhNJ7QNbRPXWzMmWTMDR+UCyarxbRIb8MHiMWlYIWnzgTVlgoEXf1e1f
         s2sg==
X-Gm-Message-State: APuU4Z8pGZODl6HYO8uST7JR053bqHYRce6L7pcWkhiRl4fBp84JNCvc
	wLOO9Ir5wxmCp7rAoR2yiNUW55lpUfqf9t/ADrzRZBDtJOvNuBBC69p+o6V1HIwEx1w=
X-Gm-Gg: AZFdTZdjBCGBTLal8b0Cj1njICtiWr7MA6pl4IM3oMfmyghuqY1s9AtxfCHutvabAN3
	FJ5+UhouyFBXZzxGXNC7165E26SUG4ydR11uZjQ0r5C1Cm5UsCQ8qkDzTtlZyR8bA7rEVD0tWY2
	judieUIEXbb9D9fOgxoaF+N4QR2TZAZ+ERUbBi+bUsMBPWTvnq9xSrBPPKAVGNLHeIPVQiCSiup
	rOmALAxVqz9BunTbge3Dt9yA4VXqF6PJ0BZ1mqCQUgsJyUv8pbHiZ8cuTAP+5fzxg4byDVjGeww
	Oni3ret9SNXOHnPX82t9wo32fbM5uxvN2dx9p1CvJ0W3KulAsIQRSahDWdK8ieLbI2DF/RTRIU+
	s4dkXU0jhkQmuHVuCDcxi9pt4MwG4vMy7er7ZyRAVdZH4Gvfh7q0jnOehvS/kMOi4I3t/I5+yo2
	hx8Q3yToMkWOIxE0J3Bfh44WCZKgLsji0ixjjpKRl+EF038+rz9iTUuSOhTZ8VRJOANE0HtgTYZ
	1VGhJ64SjXRzqQBdkFlqRLoUuM3daBjAI4InFsMijylCPrjlFwhmVQG5deL59Hvd9TUmNADJ6IP
	GSW5XZuucmSvJ2h1P7tI/PIhzVpv/2d3EM9LzAnQEP3+7VhYRDWOptaSFKAHMfnSnAYOb2DItGI
	95JHCNGES44rJm9rjjKTGYSFTANs9nHpxjypzl745KydKeISM568KZnL/9TTJB+cSbz0YVmmNvs
	ohlVkKlFSveZ5Renzps+s4t/Sqcwbb
X-Received: by 2002:a17:907:940a:b0:c29:5d41:dfe8 with SMTP id a640c23a62f3a-c513acbb4a8mr1564827366b.43.1795644192922;
        Wed, 25 Nov 2026 14:03:12 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec3c60sm676998366b.50.2026.11.25.14.03.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 14:03:12 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v5 6/6] notes: pass the repository to the combine_notes callbacks
Date: Wed, 25 Nov 2026 23:02:14 +0100
Message-ID: <20261125220214.35881-7-okhuomonajayi54@gmail.com>
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

