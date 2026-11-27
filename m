Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817118;
	b=3Gwqd6U8crg+VH3afE+Nb/8j6yVYHk4BTwaqCQy+ayYSRlHAMcqIqXJIbfFR5PYQsg8f
	 TeVXcBcO4gAEOx6w6ow6+nyZAHKCSTN+6FLNyDQ4XN3nO/8EIqa/TpaYrLAujkffqt1lP
	 qL4Qe6eZOomeGZWBQyz8UEHuvzU0lW7TDrV+E/w4E3vjtrPQDtaZ9pqvldBNwejnezXUb
	 phNxV6Fk0eni7gM3FiaV5vQYIPLrHjiE/QoHy52DuWNOyHZQMd+SuWlVXzpeMl4+4oX/J
	 aDQVucyYK8E4G10/zqcNM2AttVVOJoqsT9dw0M1v0LrK/OHwW4Pbpm3s42sFAQyi/FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xDX6/oxFEDLhflwV1DLUpZ5kjLykq7eRmSKd86+85J4=;
	b=tjucP16d2LGczPuHJ4forIC8mCctoyrqVvWhjLQyiM6zALLGJNTiVaI9XUMaXuj0RPmX
	 rng4r4bDPLfs9Muxt62B4UN/J/dtpFc1ntiF+YLuBAVGq0NfFr3ER2YllG6e0cSf46ZYR
	 AdjHbztjO60QA/ClUXrN6xUH+wOFIEwGzYTTf/OU4GP6UpadcjkGE/p/zGmK0uyPy/Q72
	 LFykhpYbiNxPf3G7nWWhIjYHtW8XsZ4HbI6Ct4c/IVIWULyVSYK6NK5YA3SjJioq35qPM
	 p6IVwYw4KypdvyIhZkbFITQIMRMESgQrMhxrem3TinucoWPSXmakdP2rS/AsmN4660w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pP/08kdp";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32234606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32234606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pP/08kdp
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e09aa5264so5000500f8f.2
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795817116; x=1796421916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xDX6/oxFEDLhflwV1DLUpZ5kjLykq7eRmSKd86+85J4=;
        b=pP/08kdpJha2k4IMpD66m5fd484ko/OjTPrtBcKFR9qzYymcMBKpj8QE/+V4OgR6Ol
         5BzLSVtIrfw42TcptEvfkOGuXVU1dJyMf1LxORzUeLEv0bGliLYKhQM3UEoIXZbmQjjN
         Dw40GaouUitJsNXFkxUTO+TsAduQ4Y3KOuufro8h8YukrbpYEG72w+SNh2GcLOpVkTgh
         BFV+e6rwWK78kp9J8xDJ6XJ7M/mHsineYDhPoKNNWhA4efhdyRnRFltv0J4dHtpk967Q
         6pb3kxs4Yn6VbkztwtAQ4G/JKMJi2xZijYZzdh2V5wgoHOe8XG8n/UuOG4lj4lQsMZyl
         iIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795817116; x=1796421916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xDX6/oxFEDLhflwV1DLUpZ5kjLykq7eRmSKd86+85J4=;
        b=SIYWf7lhxWNyX3KTJLmvgF7R3lI/HZs4TZ0HLG2AcY3t3D9pC0uD9sDFW78leVChHu
         dUiNDgA5Qp3IlIqZ2hFur8gn2jyTSSvlBSNzztG/tcDkfF3FlFeCAxLB/ghOYwosXUE1
         udsJ6igkbHQK1IXrW5jIfuEIFHO+JT4cUBrGSM7Nryet0p4HXGGl+R/5i+TUgTKBwcdN
         V1RywXmQ/ElyVGWBJ0CzVykpG5sZ2FT02D4JpF1RzboYrSrUDFnUkWXhzCvKaxLvI82n
         ijqHAENGHbKRVcfAMuBMH97mVwM77XwGUo/HSeiLLHOsa5B3kB4xbDFo1FKYRk6g8Riz
         v2zw==
X-Gm-Message-State: APuU4Z800fGilV9iJ93+qOXbuymT3fn5e5HTNckXJowGRGqfB8CY/rb/
	TouEkYX1JjloS4hvYRCHCDNzGeO+u8j/55xXHgX0Ri7HRQPwdIrHTafJ3+gOXwz+5zg=
X-Gm-Gg: AZFdTZfSun0KsvfLn6k7y1bOAsmIdbxrzpv1NSUq6qK0dVzL24EOE5HQ0R3YigZPwSR
	RL2j8RG3BjNWh/hOeC0Vlu+KGeGXEWl6LjCThLkNZOQUX42uNu91ct4qbVrIVL48Oi5C2Dl6RSM
	7UeTS/btXFDBsq1OjVK8n/ijPq6d3GIyjpmbIX+gBWlYcpOLViOC934sNgDaHr4XmsoP4YmAB+H
	eV4RF6VvFaiK07LfJGU/z4fEcDfz/7dH9e0T4SmiFzv+Zk320GgI8jDbu3zJ4T11KV5YrUHaz1L
	9LUKWKM0oOjZrYv3F6dDXRETlFPa0bslvWbUSP+kPZaNSA3Ouf/cQmA35haJ2LUafwcCiiM+AQz
	dUFlLP9fTriyCGL8XQgZXGLoMLrDf/tsSliIiyYI1B+Tyur9nmgtc8JnSiYc44HoLjA66fGigFG
	MtV8Dm1nOstuy+SMgYVRCoNpd8aZHN6H/fNX5L64Jv45ks5TG6W4W3cXPGecVsOsewkZgbZJghb
	c5VxSTiwqNu+Aa9f5G1EIv/uApiOx7Gt4LfOOOL+zk+XParbrID/RG2LklmxvPyQUHkZ3umofjy
	l0a88O/y2v5JdHACgz++keN+QU2MabaD5mgRm0fHLFi1GqTvmM1RhwXowhy2ja6D2QuXUUogWNm
	OPo99cr/d5Fm+muw3wqoUZW6C5l/AarU9FwUtSgCOWJIzeSszK9IqYoYeXhLJI8tMs4RinQHrBx
	LXIsD0TT5HAPK65vanPEAuZ53yrUia
X-Received: by 2002:a05:600c:46d3:b0:4bb:6687:5394 with SMTP id 5b1f17b1804b1-4bb888097b0mr541458975e9.9.1795817116452;
        Fri, 27 Nov 2026 14:05:16 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm51467422f8f.8.2026.11.27.14.05.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 14:05:15 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v7 3/6] notes: use the tree's repository when reading notes
Date: Fri, 27 Nov 2026 23:04:42 +0100
Message-ID: <20261127220445.45639-4-okhuomonajayi54@gmail.com>
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

In the previous step we added a '.repo' member to struct notes_tree
so a notes tree records which repository it belongs to. Notes trees
are passed down many call chains, but functions like note_tree_find()
still read objects and hash algorithms from the_repository.

There is a catch in the notes API's NULL contract. Passing NULL in
place of a notes tree is allowed and means "use the default notes
tree", so a 't' handed around a call chain may be NULL and 't->repo'
cannot be dereferenced blindly. A previous commit introduced a
notes_tree_or_default() helper to cope with this, and ensured all the
high-level entry points (except copy_note(), see below), as well as
the internal format_note(), call this helper. The leaf helpers
note_tree_find(), add_non_note() and load_subtree() do not check for
NULL themselves; they rely on being reached only through those entry
points (for example get_note() -> note_tree_find(), and
note_tree_search() lazily unpacking a subtree through load_subtree(),
still after the tree has been resolved).

Given those guarantees, read objects and hash algorithms from t->repo
instead of the_repository in note_tree_find(), add_non_note(),
load_subtree(), remove_note() and format_note().

copy_note() also takes a notes tree but does not resolve NULL before
using it, so a mechanical the_repository -> t->repo replacement there
would be unsafe; it is handled in the next patch.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/notes.c b/notes.c
index 6bfe80f176..da63d35935 100644
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
@@ -1173,8 +1173,8 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	struct leaf_node l;
 
 	t = notes_tree_or_default(t);
-	oidread(&l.key_oid, object_sha1, the_repository->hash_algo);
-	oidclr(&l.val_oid, the_repository->hash_algo);
+	oidread(&l.key_oid, object_sha1, t->repo->hash_algo);
+	oidclr(&l.val_oid, t->repo->hash_algo);
 	note_tree_remove(t, t->root, 0, &l);
 	if (is_null_oid(&l.val_oid)) /* no note was removed */
 		return 1;
@@ -1298,7 +1298,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!oid)
 		return;
 
-	if (!(msg = odb_read_object(the_repository->objects, oid, &type, &msglen)) ||
+	if (!(msg = odb_read_object(t->repo->objects, oid, &type, &msglen)) ||
 	    type != OBJ_BLOB) {
 		free(msg);
 		return;
-- 
2.56.0

