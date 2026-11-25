Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644173;
	b=z5RZyn73QmjX3bEXE84xwS1cXet2u0SFMbmZR3+6OuTeOU2CebRnC2xzYYkp6NcA5C0I
	 5WHCjEhWYIBWkF6+oExDvTly7r8MywrZ296ajKx90GedvuQD3gc9aDJj+e/Uiv4NGsTHw
	 q4BxX/KUuyRMRUr1Gref8q3Gijp6ntmasgLqFSoJukNLiYjXN4tkWl6fyMFlx4PqiEy32
	 NGEkkw9kHgsmLrBeVh7DFbhUzV6yRHjyFNFzwWOn4omIHaRz7kjWqIMRaHo9xy4/foO9W
	 pw9Up9B8zpsqE14IMufmjkVulg4DTOWBQgvzCZYrEABrh9fL/9njKBeuzxIAXs5WbPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cjTJb0nGcW7IyBrYPeaaBxVJS+YV+7W69mgCbjFa/bs=;
	b=Q2Wra0z09Luh2Zez146rajrMyE9gS6+0Q5WEe+M/zyvxPaMwAZUY7CKQlKMvzEtnlHxd
	 cS6l65Zf9RDuAf9+tzoP8BzjB7A14rTSnLFFUYLrSdoOmZI5m8kcljAxC6MeMApR5q7Mz
	 GhOEQcb4DHzCwteNLTEAHc+tUDguYgfVELMQPSH+Dk87R/VsM7C+ByQ0GtllUXD/jql7f
	 nbndbAiNPo1tgIVAtGM9rb5hW3eDIDolZSEvQsUSI93triozKA32GFmd+WwU+CQ5pq4Dd
	 wrpMzUogF2Hqp3f+eBhtiU3bLvfcfZ1+ZLcD71VG60YXG2VaptQ4WIKN0QnUw4KhPDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rk+2ABvi;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A88606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A88606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rk+2ABvi
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d581da0aaso882892266b.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644171; x=1796248971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjTJb0nGcW7IyBrYPeaaBxVJS+YV+7W69mgCbjFa/bs=;
        b=Rk+2ABviKo5eWifW6G9OBxffPIBJvRwSszJALTIMB4RL07k8yFhCruuh3R5Y/KYGfe
         phOlIPSKgwz7VCCDHjKvGakE+p+F9p1qC+poEwoeBvPiUHfModU+QYNpyzauXsoIfw32
         Ykw0BmP2PE63pNaQwkdjKvWAKELhuaBQ4tc6ZmVLIIrk3K+cq81VrTgxXki/NrQjwdlc
         fvRTZTLhopFyqoiSpHO6tw5tKuZegKIiR1OoeQKPQsxTr+Mcuq59K7/a4PwGrJx/hS/f
         Mj30C2qQOC6a8IIE7yySeJsEeHOpFCu5jfHP9LTlW30DTXaqGfRHQhHNUX3AGeu0Xdd2
         A+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644171; x=1796248971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cjTJb0nGcW7IyBrYPeaaBxVJS+YV+7W69mgCbjFa/bs=;
        b=Duv/dj+o/TDNqHGtB1LAIIOGFuBrDDWU/iqZasbSR9bKJgG7zs6teJacdHM5BsVhFK
         EjRDW1IiqL6DdcAzfNOgkF94iAZQ7NlnB6nKQRuiuaQBaHqELYy71FmWwJqPYcuaOEym
         d3uKuZ6NRH/VNm4wlyMnBJPnUaJzHb2KiWtA68UwFlEdZWnY4UCAx/SdX8X2dCoAKBPe
         D/i6b3N4vW7MGrRXihf4yHu87TL5fpClTA6nRTUTkwVxaIoDaqgN2LeDH9N7qEnqx9pm
         o4lghOP7WswywXXiBm8bflvq72P/JmzWxISXRnLbNv919sdV1NSo8V416kSdQ0GUf3HQ
         SzMA==
X-Gm-Message-State: APuU4Z8ebcThOJGEEneieZed1cI5VSrZb8nsSB9zC9UvIGK8jSxt67pI
	oUW0ddhuiY98Vbx1uYN+DrOcf1pswMWxBBQ8qMg+Iz2MBsULHL4zbP574XKiqLXcIOA=
X-Gm-Gg: AZFdTZeq03Dk4nHH1xw8bZ3IyBJ+k2o/yq1oGhusXt63/bwbwg4hrg2YzRRVj8tlk1L
	F0ADrOfVU+K9br6dCZ5F49RXplUMsP6Po21YFNcqn1CAQpw2EQAAnQQr6QfWl7G+mkrrgTHLqvF
	dpmA0nllJ5ZXL0Si8GhsDrYg8rwP2NmnSFQ+LfaOg0BZ8scbGygfElwwI8a10AD9DT6UBD2AY/E
	b4hxRXXCsxRu43qmOjMhEBVru6AxwZJziasgKtcDT7PVWm0NtDEnZSOvvrpVmiLP27V3f4y4Q0y
	2+J2+yo8zH+TPcdCB66PGbFDuHpuTbOT5GRy++EFVKj9auo8J4bwjhf+BqRyoCxdJxwN7SYrOIo
	u4VZh6IC2Ah77dQnnfRYy1Bt2+Z+lviRLM+nnCOsDjlpmX94EbxlLaeDucrDD1KxD1DEvI+0bjR
	qOXTXKtsUFiO7Rlmb+bOlFJt6pYHYpTVipejomcJ2gn9CnTeAZF3PUyFIqcAZnDHmJYQK8EgzE+
	fm99g/QmLKMP0cP0EELPZXvj2UG731Lx38M5DM81CB/Gh3OyaR6juvVOTAVwVPR/a5WB1vFWoBT
	i+nlvtDXtp1XQxYtWIZsBjngGHVDuTswmcH//0/Z9qxUn2rEhXSXIivKtOAyWOHEv56jBJJxqNr
	5OWGOrkZlg+IjPC0aLarebdYQtlkF54nj2Br1Ymb6Hvqnooln5SOnAI8MDMdGM5cfBdY8hoZgku
	fF+XN+yz3AQ/v0PpIbTPOxA49xyXB5iw==
X-Received: by 2002:a17:906:7c06:b0:c50:6505:624 with SMTP id a640c23a62f3a-c513ac9aeb5mr1120332066b.43.1795644170854;
        Wed, 25 Nov 2026 14:02:50 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec3c60sm676998366b.50.2026.11.25.14.02.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 14:02:50 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v5 3/6] notes: use the tree's repository when reading notes
Date: Wed, 25 Nov 2026 23:02:11 +0100
Message-ID: <20261125220214.35881-4-okhuomonajayi54@gmail.com>
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

note_tree_find(), add_non_note(), load_subtree(), remove_note()
and format_note() already have the notes tree, but still read
objects and hash algorithms from the_repository.

Read them from t->repo, the repository stored on the tree.

note_tree_find(), add_non_note() and load_subtree() do not check
for a NULL tree themselves. add_note(), remove_note() and
get_note() replace a NULL tree with the default notes tree and
assert that it is initialized before those helpers run.
format_note() does the same NULL swap, and initializes the tree
if it is not already. load_subtree() is also reached when a
lookup unpacks a subtree, which is still after that check.
copy_note() is the one public function that does not do this;
the next patch adds the guard.

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

