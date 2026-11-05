Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910848;
	b=rn0eMqSh1mIiSCpeN9J2oMgpxVWUCP4OLlwg32SWoJYXrMUeJbxCYMz5aEJ633gS/Op9
	 34jJvUDvYNqj847oXCNf8OhzziEiESOXLXCSi65W5WmvrOVule1BaMUnv8S1E4mYxMohk
	 p1/1sAddiUc21h+BbWzusfDR4mQgPThCi/0yQuE101FtQv8G3VztlneqNj7qSGNzf0Wz4
	 +Y9NOLQY4+lqUyat0+/JWodVGzraVQQTvQmxcIF8ZjFTopNRa2HuBa0G7wdD8Yrr0e1xz
	 uS07Y6/SewNxPHg2rcanDIubmo5mOJrHfPUWnr49TFudvoHIzC6za4T7tsYY6bLLO+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6An+fqsvVdSQMfFDMowNflVw7X6oktbHlCLur7ed03c=;
	b=rc0jglXFDHogeOruoZWXEspwj2IZG2pnkU9bEAXiPhuaCW9y81cc02ZZorpHQTaGzbIm
	 kFFoU0XUdxEio4PYGchRdyr/t/BRh2h0/WqDpxr+9q4QvkRYMrR3MTu8AVT0s3voCUVX4
	 w5Oug1UysyUd/AvC51o1Ji5/bep8XFtqNSJK51y84idAi95bHnIaHdcj0mr3CrEvLt67U
	 sT0oQ6xQEDRTYOj0iPDZAzYBlmptYgWJdhNYtAUT4jNT8qLIBUAKG5ClxCm8lJHwv4OfG
	 sB/RBS64ehrFVGIz4cvq7JFdzs/1XOcbvVyQ9vXKpP8gGXCLBz4SJ3auMOEIhE6AmWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Prk9Rxvx;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF0606A330
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 20:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6EF0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Prk9Rxvx
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so570328a12.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 12:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910846; x=1794515646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6An+fqsvVdSQMfFDMowNflVw7X6oktbHlCLur7ed03c=;
        b=Prk9RxvxJFo+PGH1CFty/ygio+2/NlKU55LTn6tjmiTRWsDJKjltthppVt8nlUb4yq
         XIb9FgWRd87wVIJcezTcEybMVtlTO8dN3EuaWEKmNKxqWqnEgiNCFRGOMxp0sKWWuFT+
         A/wgp9vqEnaH/vLPcMAQ6td5skaPJHm6WoLEZe86eAHyF4/2O6AzgfqEQF0doVUpglwf
         fYrx6WW86ggHgHcKEVJJnzn+a75LVnnaJdEUHK5iK8QcibSfirbK283fBp+Mnzz/KQ0E
         cbTyqcsTBKWhYYit/2K7lMTXiNfcprTi7/YCSSXskNTdSTsLfUFSZQC56L314SeVGc0q
         U7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910846; x=1794515646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6An+fqsvVdSQMfFDMowNflVw7X6oktbHlCLur7ed03c=;
        b=hen6lwaxKfiMzg1XihxFBD+nWxIZ+Og94s3SUcWKuRlYWw7xtXPFCAJVMQK+wh70jf
         DiJAtOwkqootn0oqVbTTRBLFeMKcphSVlEoiAjnYQlKnOHkcQFrbdrgrCBsL6ZuTXsGo
         NguF/kqgoM0/BTHbTeSFwilU6k2BL1M5JcNu6Uv5+5LdCzog9xUmrhAVuUFpdSgEq5NW
         4mbudKU2rjlXgwaP/yM5Hq7Prny5SrhfNBgxWRj34OP64RdMJGchDfgPJ8pp2qrCqYRQ
         UpI8YQ4xUL1ZCg+yWNIK+fSQQx2ALIw31+KfPnS3XfZM38rWAiP7NmrZJg7jXUC2PIBv
         kgsw==
X-Gm-Message-State: APuU4Z+8FEfRdwMZzj/j89Bzgt98AlvwdsQtfUAwaFg4r5j1jRWnaZyZ
	5duYqUGP2cf+vfmGkVuQHHp6YMEAV4LjYYa8hQ+7Y2WKDe5vWnr210TIsFnoPrw0f3uc+A==
X-Gm-Gg: AYBFou2ATtB39A7ZO+Ti59RvcqyFgC9d5N1U4CPJiRs8UOkfMcro5ZBwW7ZT2QKzJJP
	E0/KciRfZlDaW6uuzE9IcKGKGbB/WVzRRXl2Qy6BUZ6/Wx/pR7V+j7fJPKXs+qgN8akFtFfqgEN
	XnMdbQmc3TxXjnlHpt93zG+/VKYVtTg6WCGVSK6rncM/9A2HKOPZ9Y125kfd7Sw6gvHD+/lZ6FM
	vPcFciJ9HinlO+7sNLOZk3XBulUsiTmdDuPi4rxI+hFjGg7SH1Qpf5ay5ald30OEXD4QRliZ+r1
	vIhxc+NcYfe6o0gSqsJZ2xPaBS3SpGvEAT36ZRe7CBwHhSeErCvFbIWjX1Q+3dLIa6fCa3aVvhD
	p3eWqjppG/llfcgRlufw4g1TByRn+oHEDFmkH1W+3jfK1rgwgyb4j4FYb4Xdx2xZ81CInhvIA0g
	uNhB7XFCZfEr2vnxpBGEgnOmEVIrXD33wqTODVKSr3hVn0BgPKEohywTKseLGJFuBFJ+iK/klFK
	E/6WsxWPOhnBAeKM95uEWzvrakqcbKP5IaBR8lobpoaGdi5wOxAnQVUx9esIYuJpIrv+i+UgHNL
	DEz57S5FyGBCwgQJplEA1AFF1oTlLP/eYdfjdcvq4KJ/Y8I1hj0E+V8obIk3EDKi6DenXuDn/t5
	NDg9Lk3g7+08sztjpbazv0+LPDaruHy6Yq93SQwVSn8+Mkq+BYnjMhFVG7zIj6atcwr8FahmzsX
	5SKJn3BQM8x9HKgltUOvJT8WdWuXZ3
X-Received: by 2002:a05:6402:1ed1:b0:6b5:8297:f44e with SMTP id 4fb4d7f45d1cf-6b5977a476emr307520a12.5.1793910845814;
        Thu, 05 Nov 2026 12:34:05 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5853e0536sm702689a12.31.2026.11.05.12.34.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 12:34:05 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: [Outreachy PATCH 2/6] notes: use the tree's repository when reading notes
Date: Thu,  5 Nov 2026 21:33:40 +0100
Message-ID: <20261105203344.48513-3-okhuomonajayi54@gmail.com>
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

note_tree_find(), add_non_note(), load_subtree(), remove_note()
and format_note() already have the notes tree, but still read
objects and hash algorithms from the_repository.

Read them from t->repo, the repository stored on the tree.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/notes.c b/notes.c
index 4ab3d45d7c..5c2e8815f8 100644
--- a/notes.c
+++ b/notes.c
@@ -153,7 +153,7 @@ static struct leaf_node *note_tree_find(struct notes_tree *t,
 	void **p = note_tree_search(t, &tree, &n, key_sha1);
 	if (GET_PTR_TYPE(*p) == PTR_TYPE_NOTE) {
 		struct leaf_node *l = (struct leaf_node *) CLR_PTR_TYPE(*p);
-		if (hasheq(key_sha1, l->key_oid.hash, the_repository->hash_algo))
+		if (hasheq(key_sha1, l->key_oid.hash, t->repo->hash_algo))
 			return l;
 	}
 	return NULL;
@@ -357,7 +357,7 @@ static void add_non_note(struct notes_tree *t, char *path,
 	n->next = NULL;
 	n->path = path;
 	n->mode = mode;
-	oidread(&n->oid, sha1, the_repository->hash_algo);
+	oidread(&n->oid, sha1, t->repo->hash_algo);
 	t->prev_non_note = n;
 
 	if (!t->first_non_note) {
@@ -402,9 +402,9 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	void *buf;
 	struct tree_desc desc;
 	struct name_entry entry;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = t->repo->hash_algo->rawsz;
 
-	buf = fill_tree_descriptor(the_repository, &desc, &subtree->val_oid);
+	buf = fill_tree_descriptor(t->repo, &desc, &subtree->val_oid);
 	if (!buf)
 		die("Could not read %s for notes-index",
 		     oid_to_hex(&subtree->val_oid));
@@ -462,8 +462,8 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		CALLOC_ARRAY(l, 1);
 		oidcpy(&l->key_oid, &object_oid);
 		oidcpy(&l->val_oid, &entry.oid);
-		oid_set_algo(&l->key_oid, the_hash_algo);
-		oid_set_algo(&l->val_oid, the_hash_algo);
+		oid_set_algo(&l->key_oid, t->repo->hash_algo);
+		oid_set_algo(&l->val_oid, t->repo->hash_algo);
 		if (note_tree_insert(t, node, n, l, type,
 				     combine_notes_concatenate))
 			die("Failed to load %s %s into notes tree "
@@ -493,7 +493,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				strbuf_addch(&non_note_path, '/');
 			}
 			strbuf_addstr(&non_note_path, entry.path);
-			oid_set_algo(&entry.oid, the_hash_algo);
+			oid_set_algo(&entry.oid, t->repo->hash_algo);
 			add_non_note(t, strbuf_detach(&non_note_path, NULL),
 				     entry.mode, entry.oid.hash);
 		}
@@ -1168,8 +1168,8 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
-	oidread(&l.key_oid, object_sha1, the_repository->hash_algo);
-	oidclr(&l.val_oid, the_repository->hash_algo);
+	oidread(&l.key_oid, object_sha1, t->repo->hash_algo);
+	oidclr(&l.val_oid, t->repo->hash_algo);
 	note_tree_remove(t, t->root, 0, &l);
 	if (is_null_oid(&l.val_oid)) /* no note was removed */
 		return 1;
@@ -1300,7 +1300,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!oid)
 		return;
 
-	if (!(msg = odb_read_object(the_repository->objects, oid, &type, &msglen)) ||
+	if (!(msg = odb_read_object(t->repo->objects, oid, &type, &msglen)) ||
 	    type != OBJ_BLOB) {
 		free(msg);
 		return;
-- 
2.56.0

