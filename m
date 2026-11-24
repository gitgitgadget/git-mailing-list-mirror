Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541008;
	b=oX5TDmS9hamg5xHsZk6oDkOSNzvmTnWqKzJctrY9Y415g1gq57pPnhW+bO6IQqmE8XAM
	 KvY3CZKE93gmRdjAgr3CsNaoNq/ms3qrUTjy7WunqvVwC3GZd7sQ7pIBBTone051MNgRi
	 E1u0ZrROTfnADqITK+BNesn2PoTBkwpCDTpkkAiBChDFCEicU6JB4HZJygrzcaLA/ZYXL
	 w6ZPh33+EH4eA1Hsi8ojVJZeWKRJIDU8w4nW5bC1ZQ2bj32uTIsMf2bZXahK7L1OrVmG4
	 cEw0etbrmyDyFU1RcLZW/AU3wc9endfynVkOgFddGfrqMlJlJMbGiQhRt/Ta8piW4YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pfg6ygtJKtk5oNldU2WZ6rVWfVFqT2SU/8rSRfhpTbE=;
	b=vORXHlntxNCLSS5vyUvy2JxH5iLZVAdt6cw7v97PALPtiZ0Eal0UODyfmi93euYGANUY
	 6gsD6yWXyv5Qp+LGSIBWvr+cjrXbstQt3fqClMyz8CsyQxE5vIiTQ1LO6NVSlcppN6Ekm
	 o2/UVnz2zC24ej2KiH0849rOAtgr7d+VLPVX6IYWYVXBWbJ4REzQVZOYln4G52LhVcPmo
	 Xf+fFMYD5eWUTNkoCBQyAiTBIIUSdSXBWIgD6heYqjIMjuAW/hVxeh70w79/gOxmCi985
	 91WJfYpJB+PzOnaDcuxtvWftmvqYCMunStKfXeKGldfY0oTOu7QO9LNLKrkAPYKva8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kh5ZNqfh;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371E606A323
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2371E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kh5ZNqfh
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c5188e4980fso307721866b.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795541006; x=1796145806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pfg6ygtJKtk5oNldU2WZ6rVWfVFqT2SU/8rSRfhpTbE=;
        b=kh5ZNqfhpaaQWbSA7jRaAV6TSy/ldMNU6G0zJgRm+9mvvraPeRbpPhFKkPMBVQNqrr
         Kq5KSJuH0Ft08ylWkSDja+mAZJWaAt04uTgOS3R549fIHa7RYMb5jB/eAUsGYwGdD0UL
         LkWNoNDbl58zvTJcDyq76j5gFhCVdKq2KAmQh5ZfA7NurdQmslC8iZDLPdFYKgzw542C
         PqlqU8AXO6VLBf7Sea8i2wPEnEsVEKN4OCb1A7XN8+qQTSoCPJw48HI6FF1aVORYxnFn
         uf4RgmF+hIIlrqqDQCnd8Hvpfa68NtNFY5Qd6pm9eO2KnTkq/+dS5HoOoJT1l/9vSL90
         HPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541006; x=1796145806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pfg6ygtJKtk5oNldU2WZ6rVWfVFqT2SU/8rSRfhpTbE=;
        b=W/cxPWzYm0Ze7u1l2IRfHmq+Uu6CU2iDIlzEsrxX/MMfgIfLvkBIPshJNYXqq19kfU
         MbUtWGD+P7ZhImnJIvnwCYG73K+zCGyWY1U1g3Vnnwutx1K2w71B0Q0lZwVuMLPPYaIC
         Rh1Gl2kB9W3JxfKwP/QgHRMd6QWQltKO7wTqjZNDTeW/s9Lwo+yPKoePGBihkFVcoCE5
         39PhCe1CffHaqt6c7SgFVe9o/Zc3aQo/VBGBhQKjqR0jPy8D6TTJIbvkmYByTeNCzwvH
         J1C6eMb/tFUXed6avAVb1AX7zxwjW7g/66C30yf1w8Z4KWw3EyCTmt3k22PIboBLgX2G
         p6EQ==
X-Gm-Message-State: APuU4Z/gPai6SNyT99Fgh9r43xYdWDUmaZJkIr+OYsV6u4CCYoyuJbQn
	8wPtYTQ1NrEnBCCvew50jpqySfK/1jPHQQTJ3HlGNyd7faWVwJHM/0QHGiNHqaBvbCc=
X-Gm-Gg: AZFdTZcTvPmrrdz5Feh+1CoXmP1ym43Z3Jc5HPMjrr8OT6J72xvEymnVdx+g+u/YzKh
	oRNzUwSrhpdXCq1x2VjUNj5Rpk/YhBJCzqIt2X6GLwO9Q7BU37zP/maWpwlPD5BTcy+HkBQxDFb
	7sDYaWZARuE9vtSst+6NsQFPrSOYSs+2LwJB6POC8vjgNCk1YvLdUPG2s9mhkzYTwIhvF1s3ldX
	k1xa0ZQuctE2VWMT7oY4x4zIH3r66822F2G/+SerxPXGZw/mLtrxPkBtU/QNHAb3Zw439qaPN5E
	R1xOuEi7W8+QXnlkAl8e0xmYrjNJn+ToJTqiCObty9p6/+XY26ZSGCHA53qB5eqF0lOFpg42dfN
	PX1PRN0TnauUCGjPBoJqfgXVoq3w66oHenDGn56vIxKX6oic7V3SN1xKs+IaQaWGaoRZpnMH+9t
	5iDftyJoZm0L8hLY0isXtk3LpbCjoOuzKSROM3sKcTYMf2NIGoGRwj3ebKlkfVkqvdEO74yHo9x
	evm2usa4nhGRB7VTyahOZQK1pC45Mkiqo+bzmPzGFniikzC1fiMvi6am9eEh+dSCgzGY+JETtr3
	pw+qsmWu7CfXnueB18HIKqTZnPLu+fIkog8q0yx4IIM+FPUA8umfT+R9YSDW83lnPpk7TDqSEnH
	NOK7knaK6ynXgsNJa1KApRuXp07ITrM7zq0f5b2PZJsVQWthUTlPy5Ixx9nvS0IrjF02yYiNaN/
	ZqdDE1KjRvv2/jln3lGyUgacmIrteg
X-Received: by 2002:a17:907:8b90:b0:c51:5f6:cf70 with SMTP id a640c23a62f3a-c513a41fcc7mr1352051266b.1.1795541006303;
        Tue, 24 Nov 2026 09:23:26 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe01a0sm547394466b.68.2026.11.24.09.23.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:23:25 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v2 2/5] notes: use the tree's repository when reading notes
Date: Tue, 24 Nov 2026 18:21:43 +0100
Message-ID: <20261124172146.18330-3-okhuomonajayi54@gmail.com>
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

note_tree_find(), add_non_note(), load_subtree(), remove_note()
and format_note() already have the notes tree, but still read
objects and hash algorithms from the_repository.

Read them from t->repo, the repository stored on the tree.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/notes.c b/notes.c
index b79fe65478..9cf71651ed 100644
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
@@ -1169,8 +1169,8 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
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
@@ -1302,7 +1302,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!oid)
 		return;
 
-	if (!(msg = odb_read_object(the_repository->objects, oid, &type, &msglen)) ||
+	if (!(msg = odb_read_object(t->repo->objects, oid, &type, &msglen)) ||
 	    type != OBJ_BLOB) {
 		free(msg);
 		return;
-- 
2.56.0

