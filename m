Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644160;
	b=FxIJDQ5TmZrwD4m9RzCC5ZZVgkKqYO3Fo97kjjEQaaYbTjMUUEsK8xKDGQcxc6/rnEzr
	 Ql/3FzbELsFMldElS+Zp/j6L0/poYZ07VpY67VpArD6HJD02IfOcEEw/i2wRtcry+E4Ue
	 LoRfisVwB7TAVOpE9Eot0nf+7iBLXxP3bdJwc0y8d+0zqw5W00M6/RI9AqPxBA1qBwPLj
	 AOax1vl5lHzjYO9jZ3pfuN5rraYZWDIHGLbHNC6e4qvnvqKZYb455q5PEeO0yWTFLAL4G
	 g7YJamlUYLdAhi285bKqXwES0Qr128Zc/wET5DRWN7lR8VzfcH9Y+W+/SIq4Xi85L2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N11S7T1DRKG5ujcWsbn8iGjg9bvbUOUNJzIYlDjwjcM=;
	b=NJkpGMpv+RkYx+hCyP1zfe08p295f1Q9I1kGDM9/VsEI4wfqAgFkFlX8dUCl/BP3aU9M
	 ivsO/fZ2sqYDDh3nvf/JZe+yutFrrpIZUnsWM5MvjgKw5Q2rLmrCk4ekagqymJjZmTT2/
	 /qaZHWPD2f0T/jfYAQvwUtqa2SM+fVfXQsPiuFIIFDjxQr4uNxKcxcYolkb2gz5Ftx+y/
	 7tzpnlwtv32pe8C6WD6Q/Bp5rTVlAtXdGSimnaaKT5qbIOBSZXutY8eDSNBb60oxR0+hT
	 JH6rcKsh/OIEAf6/0VWissu/SlZTtfjfw61VJMtU6xj2e4hel5TpqhkH7kfSmcj4Wmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VDuWLALr;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1352606A331
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1352606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VDuWLALr
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c51bf011392so73024366b.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644158; x=1796248958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N11S7T1DRKG5ujcWsbn8iGjg9bvbUOUNJzIYlDjwjcM=;
        b=VDuWLALrDdgoyW4D51KjJwL6LU4hNkojwRT+vQRxAbAQmr/kS5rxc4WhhB6BlneMLT
         CFu4Ca9Z6FJXvDDnU9vllYPqfHuSU31EYElSBFqYAUVlXZBbIAwW3Osadz4aPR/kVqAf
         wN2+tbAzY6sDWo/zB0L6XS6ihIj3lMqY4IjIiiyUylLEtezDGmY4wfhBaCp1ouEe9PjG
         Pp89NKmFWRn20TaP1nlWeAqsaEQDSfCzoGMbGMuMPFd5bRHoKtq3tcpIDvSVAKwJAltS
         nNZ4iEHdYDVmmHe0c7IRf5SIg5PnWVQ333lWwyCHiVfCqU/ukMKmn1WVL4dI5lFqALK3
         Yd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644158; x=1796248958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N11S7T1DRKG5ujcWsbn8iGjg9bvbUOUNJzIYlDjwjcM=;
        b=jRNg1VR0kGwBuf7J6zoSkyKaHCefowpIy+yuTMx5SHQ4OvH0Dtus4GuYkNPWd9odrV
         SzxjBLu8l+H2GhqVCgp0tP6ZbJQslkyUOMitWSLQmTFdEazLdIH+78yflMtFFDpNgR7x
         y0QPTGSvK3ju75B99F3YCLcc6WhJQGAYZtoL2G9iym+aTSDoEOHW9haAnNDJ4PDoGWbM
         /g6NFjlg+pw4n1R/Evh0hmD6XfD3E1ljnvk/a5AqgErH0BrY6VnzFyhpdOJGLvzCI2T1
         k1LPctYDX24Y+ECsjkN5yQY1ei84cRcd0ocvrz5QL/slNqr38TuXgKg0IPPABG6nDzTM
         +8fQ==
X-Gm-Message-State: APuU4Z8ld5x6WSEi5B4tpE/RC69hVSwxlodmk8Qbrdi/ec5I3/JGldKv
	SLiEnNWRgnPCvrM5y6NOiQGwyBeiBbl73EKgmB3knvS1+NOXqzePSfTt9QQPpAe+EmM=
X-Gm-Gg: AZFdTZegqqR0+8rMsMT+jqF8Ai7dCR03Kvp+I9ZY6e4CyZALqqhkpZFIDiGW7+bhCGN
	/38kUF8cUF8hRcNXt3Cu7/4iGKpwlagARMH37SoVTyBMsM19yyB0gDC6zg8x4G1gqP3hK5TP+KP
	SM50kCaOdxVbZS3Emx3ZV8mYqMW01mJxT839ck4rYZnPui7OIRycsME75E2JGGquB+RhBQ783xc
	lCayqZCmrAzbR2x7518iDQkXW1E9p3MVYMtJaHzBAc4dy9FUdcQs2S6gBB3UOkHKlSuHl8r2mPO
	xXzrFWnhpDzMoPK6hJrn8qfRNM4AUjn+2gdVuxucHv/ZQXQBNWF3+HloV3K8Ig8gGS1TbNUme2M
	9MSbYkapYpF6oDWM5D1dcPmNMwPkx+D1QWZWoMqd3WTv7d/HnujfVxKVT6euZ8BOto934ZCvZtg
	4sjIeLHCr+sdfhntld9IxzH77v04/kH7YeMmUX7kUsxRzLHhx/BnWOUwydiT4YTl0N2Wz5mGsjB
	+bQ8/EhjNUEH1DeDm40I4jk1HBAT9Y6CsYPF9b3jIYVYRKsNAOVHnz2ilZw6qorJrEj0UjheSHC
	EqfCeq7ufCCMBRpydkvn7vVk+e5ElLvoP45FG5ugUkm6KtqTBNMyRcfr3OH/CU7gnTQu52tMmtk
	/0D1GqPec2JlPsE4Bo00B7DVh3ct6xjvNe26Te5Kf2cqfFWtOvahrwnT593Xqobb3RCMJldymjU
	tywQK3v1b8UUDf8Oa0ZS2/DVkLj9Ug
X-Received: by 2002:a17:906:d317:b0:c42:102f:15df with SMTP id a640c23a62f3a-c513a99abd8mr1231730066b.8.1795644158160;
        Wed, 25 Nov 2026 14:02:38 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec3c60sm676998366b.50.2026.11.25.14.02.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 14:02:37 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v5 1/6] notes: add notes_tree_or_default()
Date: Wed, 25 Nov 2026 23:02:09 +0100
Message-ID: <20261125220214.35881-2-okhuomonajayi54@gmail.com>
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

Several notes entry points repeat the same check: a NULL tree
means the default notes tree, and the tree must already be
initialized.

Use one helper for that check. notes_tree_init() asserts that
the tree is not yet initialized, free_notes() only frees what is
there, and format_note() initializes the tree when it is not, so
those three keep their own checks.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/notes.c b/notes.c
index ec9c2cb150..a73a51e1a0 100644
--- a/notes.c
+++ b/notes.c
@@ -1140,14 +1140,20 @@ void load_display_notes(struct display_notes_opt *opt)
 	string_list_clear(&display_notes_refs, 0);
 }
 
+static struct notes_tree *notes_tree_or_default(struct notes_tree *t)
+{
+	if (!t)
+		t = &default_notes_tree;
+	assert(t->initialized);
+	return t;
+}
+
 int add_note(struct notes_tree *t, const struct object_id *object_oid,
 		const struct object_id *note_oid, combine_notes_fn combine_notes)
 {
 	struct leaf_node *l;
 
-	if (!t)
-		t = &default_notes_tree;
-	assert(t->initialized);
+	t = notes_tree_or_default(t);
 	t->dirty = 1;
 	if (!combine_notes)
 		combine_notes = t->combine_notes;
@@ -1161,9 +1167,7 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 {
 	struct leaf_node l;
 
-	if (!t)
-		t = &default_notes_tree;
-	assert(t->initialized);
+	t = notes_tree_or_default(t);
 	oidread(&l.key_oid, object_sha1, the_repository->hash_algo);
 	oidclr(&l.val_oid, the_repository->hash_algo);
 	note_tree_remove(t, t->root, 0, &l);
@@ -1178,9 +1182,7 @@ const struct object_id *get_note(struct notes_tree *t,
 {
 	struct leaf_node *found;
 
-	if (!t)
-		t = &default_notes_tree;
-	assert(t->initialized);
+	t = notes_tree_or_default(t);
 	found = note_tree_find(t, t->root, 0, oid->hash);
 	return found ? &found->val_oid : NULL;
 }
@@ -1188,9 +1190,7 @@ const struct object_id *get_note(struct notes_tree *t,
 int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
 		void *cb_data)
 {
-	if (!t)
-		t = &default_notes_tree;
-	assert(t->initialized);
+	t = notes_tree_or_default(t);
 	return for_each_note_helper(t, t->root, 0, 0, flags, fn, cb_data);
 }
 
@@ -1201,9 +1201,7 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 	int ret;
 	int flags;
 
-	if (!t)
-		t = &default_notes_tree;
-	assert(t->initialized);
+	t = notes_tree_or_default(t);
 
 	/* Prepare for traversal of current notes tree */
 	root.next = NULL; /* last forward entry in list is grounded */
@@ -1229,9 +1227,7 @@ void prune_notes(struct notes_tree *t, int flags)
 {
 	struct note_delete_list *l = NULL;
 
-	if (!t)
-		t = &default_notes_tree;
-	assert(t->initialized);
+	t = notes_tree_or_default(t);
 
 	for_each_note(t, 0, prune_notes_helper, &l);
 
-- 
2.56.0

