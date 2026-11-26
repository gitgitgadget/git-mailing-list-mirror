Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728816;
	b=en71/fJNhz3r+UQw2olj6kZ2yxmQXUpSgW/4AvU+0vnh+pLZKcTqtbXVB08E2+eTQSKu
	 ZJ/3nygbp2B81JL1lAYjxuGMqcTYWSATGtkv/bar8HcG9G7Y6P5w15IBZZm2z2+Zqc7kl
	 o6STu35Mu34GyS21EbjXDErpAhgDn3wvqNc4PVhWvDP3JM7xVCqJPtiVCVqNbK6ueCnAc
	 TosAfmOb8IkeB37h/1YgdojmQLgV62Y9MllvADfpY8/V2YPFJhUVSYyinwc3qXiDn2gqA
	 47POHb3maNe5VhpJ1yLuXp/0dODA3EfzlbG2W7KDc6qATs3ym3yuCw51UJtm89k3Q6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k/xbcnvYIgQCMUH2z3YR+/jPxJoAOWlAQds/xVuaG1M=;
	b=i4njmMs9u5K2jlR8gL4M/yEnYi6rQot1J/J5xDRb3jM+6dtmUeiQCPGNaxX9XCc/iD9P
	 gYL66UFMG2esygAtka/DNIKRdelggFcNmHHyiQrutEoehWyWQTX41FFoYx+konAhRG2FV
	 THN2VtuAN+IpizZEiaD+S/CF79mucI/xDv6IWzZ5klD1Z+/Mk36WP16FShLwsiVrWBval
	 4EWTwm0i80pKo6EyBpPAyp+hAv8fIMA+BsdcBRJAv40Z6H/pkUG5aWcNqqDhgOXTepp8i
	 JRb/rqtJW5Waj2VSsDcS5Zot7e/Bp/JYNn+UvEShVsaGVcNqd3Dr7mmkuazLN3txXWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jw7PD+in;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E5606A32F
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 600E5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jw7PD+in
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c506a231b88so997209566b.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795728815; x=1796333615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k/xbcnvYIgQCMUH2z3YR+/jPxJoAOWlAQds/xVuaG1M=;
        b=jw7PD+infiTBj7Dlq7qkHbdHjtiRa0sHBMZadhltnGxW3i7iVtMUbC6EZyNZ8GP4hn
         5CTRfi1lA+4ZJXRPiHTguua89p+3Ors6wo0NrBReHoibz47F0EjY1rbiyItBP6a/Lm4W
         hYCsevPA9d3n/OMUav7m87rkocSEblITdnOB2e7WnGmeDbn6jLzn4nB+K7DI60jH8Ngg
         JoxTjYFZ6HfAeKjUzdB+DFcHFmJo8D1hHEhR+lVJWwxbIp8DLNa+y0D0hfL9Yf4YByzA
         vs1PabaLiINZwrWnc7QdYqMYQehMchBBQmcoqupV3elI+V6ujC4YqhlvIhASWXOjrVGR
         2pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728815; x=1796333615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k/xbcnvYIgQCMUH2z3YR+/jPxJoAOWlAQds/xVuaG1M=;
        b=ckOQ48uQ7fDkzYlHzI1HI47VL/7lofJrVpOJgWVVWvxsIqcOKnnbQ0ZrqjUWrHkU8K
         SEjDM/7vFW9sQTsSB/42PoBjBzrMoceYbgmdoLb4SJ32R+NUNFd/ZsLbRL9ZitEopUI4
         BDU4pZNJrsSeKQQapdrFCkYxbD7bOZtu5WL2VFfhcqKEqtVMulm14B3Hvt64ZP6ikQJE
         gemUrmMaqnyTghMWY+kIV2yElx33gNZm6sMl03QUpKpa+LFU7O/YzrT4kPEwAApxW1fU
         sgz82hY7A6JNsbwz1sb9Flhx8xN4e0I3zfRFvPT/6kBcku3/P3cSZ9d9qiMipohtTjTO
         qr7w==
X-Gm-Message-State: APuU4Z+wPS6MyqzimBxTVU530FlRm/eXRBuB07i/Ctl7Ujqrz66ZjOoj
	nDpgXGOchfBT6JNG4q7q3qJV9TSKvkSPu0d8l5V6unP3W4CVNIGx9OW2b1Hm//TwOQ35mw==
X-Gm-Gg: AZFdTZe/Cf+SMTwL4bWI6LWpOI4gRWQhgxEiMuZ2Xk8XiR91IaZz5xWIxseaeF7ZjKb
	POpXqRvXGfah0KY+VZxRaIfTi/gwQR+lDjqBz7zXhfsc/pgxHlep9oyZcDvJ/1jwN9SMBAkC2EO
	6nfxgLrquCM01A+MWgYKLGFMQh6DQs/t6LHOhieo9jEoxi3HcCNlNKYlwf7jQzcN4PkoT72tcM5
	19+oznIAd8utAc3BqBpScMbQMm4ZamXd7UD23nT5LGMCBancSqeLGMb5X5F4a4lLZqgat04QW01
	xz0VJufGdl4+LIK2IFOAD7SEGeuRN2e8KDA18ayiGSdKpTvA7YQrh5cBO6oyv7+woKv95mdx5Kq
	vYt2pGnPUx9AY41vvi6r+N6xl1AqMIZ59wsavYNEwelpz5svSYXzofjU8GaLlGv3xpDh8Npt/NK
	73dysb48SBJI94vGge4o56szpOvbC2DLpiAcsng5pVr4l3ORR6qxR+HjHZQZBO3VXH0oiH6VW2Z
	H5PCUgjnvEoSLnaXnF0iUw/LX8EGihEMBD5jUSQfuzjaLIHv1zpbLPTuAg9XtxBzCnZpjsO7Hne
	3czicr2L9w/ocJNop2dr74k04LOu1q17fLykKNr5qEkVjMSncqrrkpW9Bpyou/SaS4s/lakNmdT
	kv3S3j5dDHN7KShvawHPoyC5k0dKU4Gw8MnpOIdyj7hNJqdZnagNVLrL8S26SRMSbcOXLK7WfcU
	zMpO5x8QK1CzzWU6mFl3jR8mFYudcT
X-Received: by 2002:a17:907:7718:b0:c4d:456c:4a29 with SMTP id a640c23a62f3a-c513a5dac6bmr1278080666b.14.1795728814747;
        Thu, 26 Nov 2026 13:33:34 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b030ed9sm805237066b.86.2026.11.26.13.33.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 13:33:33 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v6 3/6] notes: use the tree's repository when reading notes
Date: Thu, 26 Nov 2026 22:33:03 +0100
Message-ID: <20261126213306.87466-4-okhuomonajayi54@gmail.com>
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

In the previous step we added a '.repo' member to struct notes_tree
so a notes tree records which repository it belongs to. Notes trees
are passed down many call chains, but functions like note_tree_find()
still read objects and hash algorithms from the_repository.

There is a catch in the notes API's NULL contract. Passing NULL in
place of a notes tree is allowed and means "use the default notes
tree", so a 't' handed around a call chain may be NULL and 't->repo'
cannot be dereferenced blindly. The high-level entry points cope with
this: add_note(), remove_note() and get_note() replace a NULL 't'
with the default notes tree via notes_tree_or_default() on entry, so
afterwards 't->repo' is safe. The internal format_note() does the
same swap and initializes the tree if needed. The leaf helpers
note_tree_find(), add_non_note() and load_subtree() do not check for
NULL themselves; they rely on being reached only through those entry
points (get_note() -> note_tree_find(), and note_tree_search() lazily
unpacking a subtree through load_subtree(), still after the tree has
been resolved).

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

