Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728806;
	b=bBkW4W/CwKETp0Jq7I0siP7rOhC8IFf1eWUVf2PA78ZbHJA++KsNF6oBE4KZYJfMdO8P
	 pGCqq5p1jzxBPFikhYfqk6hxhmxZ+Hg5gfCTn8O5s3uaY7HXh/srSYMX488TLaTZmnyN2
	 vrKCEzSDeoONCZ+uOldLWF8exJvLg2GZrBMQY/eKIrozEMLa/9YQvAEarC65TKlirS1OF
	 Bkqt1AJGLElXd+2iULH9Wkx3cyhPfOC3LakBM2h/u720D1J/38KhSsCx3gFEiX8UIZMBb
	 wV5m7VCFbOseHoxiaKjAtVqbOttEgHYUDyjgAz5sGEl/X2eYehm4XyRuj+OTqIRaxVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/axzXgLlLAMHN3trlzmXwskcHvn3Ko7MCqQW36WR8ig=;
	b=YW1JaDIaSa6YdS6qu7ka3SjyIaA7110z56yCOwvdnJ7n45QPyYNM7H6vQS2DyTOZIBdR
	 olo+QisVzfWu+uqn0lzeuj1YKA9rQj8EAYbi5Syz9d1aUNy0WoXsbwTjIBQz6egzdNPUK
	 Sn6vhCI/Xse6r4+YcuPQ4ogvulHa6CxL8AFbRZx65ji6Rer+TFxcM9bLyktiJUlDqVdM2
	 KOm0h95ortzq7T613JeUQaVkBmDwDtDrD8gVGGtkagcy2Z0lGysx2mcnzmrBZfDGQDX/6
	 zyvuspXFmWSjIUivXKcPgrS2U22ug1/hfyB+YcKu7liTaKIBLgyiR2NMWff+pRHNnCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kMTCpU+T;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DB606A32F
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA2DB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kMTCpU+T
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b8a2518f7cso8712202a12.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795728804; x=1796333604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/axzXgLlLAMHN3trlzmXwskcHvn3Ko7MCqQW36WR8ig=;
        b=kMTCpU+TBgZzhg8f0Bg0YO016THjm3LGpnqqx6KD2t0H/HKAZjW3x9OSEA7J7W3sxl
         TwVU+rGUiZx6wFR+lMkyER2Re2Q0hCTr4aS1R+h8vxVYBD4k/ZAu8hM/pajdOMCMcwpS
         nApGEFfPqUUNEn8YZYpg1EO/7xudxG6vJaFiwVsW+I1o1jYeCMsGl1U7MANZEbgHrnEh
         bJ9Fm2FrUL7GqZ/BKCn8DY1WI9QJ96uSQCptJzC++Udc1NzhOvnVE1jP4xY04fsVi+j7
         IvcOgDZLOefOAiu/oVeZgrbnGkDlW9WFkvvMjKxQTFt56M9qmtje08WYfhjxzakh+hHG
         lAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728804; x=1796333604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/axzXgLlLAMHN3trlzmXwskcHvn3Ko7MCqQW36WR8ig=;
        b=WrzAZ6uZuftfOOfeaU3SVij4ooFPgFkv+R2mw1hbE409dTquomjrVXipXc/v54GgoF
         DNWrLu6Xh4nm28gxcP/wHoNzAPW3AhF9gFMSaeWI3QAlfY+rDpp9om24VR5bJLKveEAV
         P6o9rfaNbfuzMkkVYlsKFLZMX1CW9CkVuT1jZpi0Io4npQtWKhuzS5DNGn57OoMlDWqN
         inruNz2kylu989Lna6nGJ0bMFhkKhbnBHXl/rgev6l594V90OQ041xa0UiUEnFMzFg94
         FjrFRAublLZXTR/hKJO3zsHpE4Uusqm1WP/ydEe0/p8Xaxkrz4ekc7AVnVzct1+08pMf
         NJrQ==
X-Gm-Message-State: APuU4Z9Rlklne/drwLMk81iLmLtQs572ZavTlqYrPyDhd8myVw5ClDCO
	FPo/ByZQn9ui/WeY5ArHIIEwLwOgjveuN+A0/lLDHQI+jixPwwzuIo9VwbnqTO8fyuMk5A==
X-Gm-Gg: AZFdTZclmEixq3BTDGvPZC8jILdyGT8Wv8APtiQKLDy9dwrT7ZNOGMHoLjmd6GKJbyN
	l7oPd8YjjWBECfhmaegCl7UFRvsqSFPrGpBXCfFSngTmOwC8TgxbgpbfNertMMpAbwfj5kxo27s
	HJ97DouQmkmeGVq9FshiRh/mWnPmb0UGVD9coJPzGwZRmjEJ7rWWce2stOsxKrRiQtka2Ykg4LN
	5mjFes+sv7Lo0OpVyrdCQmqp0WaVedJAW3pzfLYV6OI6L3edBtOW3IK2QZj6kPqbohzJqpMhvGd
	kAoSr6a0YMEmyqyquEZv46SYXx6i6P/f6J19dL1HNPr1mOE1z4bEaUxyKLh8C858aFgk0Y0UZcI
	0aknHPwTqYtx9BzA2JqDMF/R+qDKIA9E6gUXc/rbqofcUGCx2LbE8o3s0uJKNPmJT4ezxSMK2Nd
	PFiMHImM3L4W5VVOIofXzkGC9J+6+B0F7bPwf1G3JYJzJSPfAJMY6vAQ3hLNkvsMjZag8hKckq8
	mNKTFPuEtt9wji7SYn1/6dnE8ZtE2NXo8Bu1DT68XohW+nrNihylu/Zpoz9T/7qpwTDYPW+jOwj
	G/ZDBmbu7bPHT+52njfBYa7ge0Ic/WSD5hmeL6Xs+dsTlWQZDqQxBDp8Q9zTgenBXUk1KM8ylT8
	wp+tWZyTenvDY9+wGlOwEC8ynuG/m7ciiduxLmVyHhaCL8xvZbj7Md68Dgjwc7jhCA8SbjfScXU
	+KDQNSZqkeHP1yeFEsK0AwU8oEA/IWqBX/P00fcrMcO1Q2Jcc9BA==
X-Received: by 2002:a17:906:7945:b0:c51:558c:691a with SMTP id a640c23a62f3a-c51558c7853mr1438049966b.15.1795728804150;
        Thu, 26 Nov 2026 13:33:24 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b030ed9sm805237066b.86.2026.11.26.13.33.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 13:33:23 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v6 1/6] notes: add notes_tree_or_default()
Date: Thu, 26 Nov 2026 22:33:01 +0100
Message-ID: <20261126213306.87466-2-okhuomonajayi54@gmail.com>
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

Several notes entry points repeat the same check: a NULL tree
means the default notes tree, and the tree must already be
initialized.

Use one helper for that check. init_notes() asserts that the tree is
not yet initialized, free_notes() only frees what is there, and
format_note() initializes the tree when it is not, so those three keep
their own checks.

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

