Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817107;
	b=gb7c8L/tC91TO3/OlHF1g3+X8o9ltskntRtYUXrmG4rCokCzVH+W/mHGbqGAA2FwcF50
	 uSCHmDgEih6oZ8GyGxzlnY5q31IKzujsZfz6Rxe4CdjuG/QPUwDCi5HxtVLPvKqF0sjMF
	 ubuHL75ippuhCR4HmUw1pknWDh4UGdrYoRzspfQb6pBr/y1c1mFRolLhlGWSAuNtDwBvc
	 3pNgC3MdbUXR+Aj9mQUXQdBMAJs1cSSFibSw803wRapWWotPbGTN0xNC0J86K3pycMDwX
	 gccPc370ZJZbs9Cpwu42WGfCFmvXtj3BB1GKC7mIAfBN6hxbNrDBxvVEkUYbYgsR2wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/axzXgLlLAMHN3trlzmXwskcHvn3Ko7MCqQW36WR8ig=;
	b=iQvgd0Ad8VD6cIbd+/cMGA4TK2aMgrpcuL8adOjDwreGT3FhIblfBvYwjohLRLX3VM8m
	 A/qpvStTgSy9tSaUrlLHxNDrmYkY9kGKHoZHRVmumFw+WU01JTmM9ZmHepRJzKUocukwm
	 PLev5vBFdcI4NWBkb7Z8B3rOLH1YFdV7s494P5JHFQDdUpvq72yYdD4VHFsbBcI7v/p/0
	 lVEkcrZVwxClV6F43ueA6bMS9Gq6QymFPHXF2NYRNAIfXEvIFFkNMKrGbLPSBZSe73+s4
	 urSAeihIYRcUQDDxwKxd1KgK3E2LgaQ10eXaQ/vvEtaLupaDPTjE9LwMyWSG3ZP6i3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qs7FnOq8;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB8606A683
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FB8606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qs7FnOq8
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-497614c95f0so4865316f8f.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795817105; x=1796421905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/axzXgLlLAMHN3trlzmXwskcHvn3Ko7MCqQW36WR8ig=;
        b=qs7FnOq8U5E7vSyl7xktECy8R3NdDOGH+jOsjXXgOjaUiIyKqs5qzhcqR5dBULIo6y
         LjsPrsnDpSKQNQ5d+q3iBoBmotkcfI0asXUW/t/7q4IbN5t3223mq6kIvF+t2TVAVi4d
         TH2haA9VNg06bE828ZZiplxk5WwbchG3VMMF967snwfz5QDwHBfD5vijv9j57K11ae5L
         dZxhsZuL6yWku0ieN7vdJfU4dCiPqzuV3bzG/ePXdN7GLfH1AmSWDUsxY1wC3tlDr00q
         BmlrXBy7/UN2Lj3FbFTfINtDtFUkWK1GUMOuAQXXezCrO1y5g3uEqdWyxRA+Y82FeFjI
         A1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795817105; x=1796421905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/axzXgLlLAMHN3trlzmXwskcHvn3Ko7MCqQW36WR8ig=;
        b=ttl3G7NPlkWu+h8fAIKmUv2AnAwNZoilUDQ7z7ED/Dk1WSBZ25bkHqy41w5TXMgPvK
         TD52ljBg+kj0E0rGet39cF/Q7apkhUZSvLxYUbwXkPLpxt/vo1hC+cX0fBAb04aO5c4r
         iRdA+WklonohsvY2ePqybNwFVwg4HqXNSSbGO7Wl/bcj/YGudjGCg5ll5k7+XnL4thfl
         SaR0UHru2Qc8pA9QdFhOWvAxM1GOY5aDJWQfn8nRtZPW7RLEH/fFCGPey5dZsQlV9SqS
         yWIwIYVu7FwqwlJXmx4MUUt1pCYVlDuOInj2ozsgh0fQYAXjTJdKEdTSozYAk9JqEjN9
         jMcw==
X-Gm-Message-State: APuU4Z9rrDhDGohNKWPv4hfm1NFW48iMmjI3a8JwXulvBYGHV4yOK+dJ
	X+6Io3Fbh3gCy5wRceqgvs2bTYMsWWX3ZqisK00fNUcPn1jPos4l0VzdFTAGX56P41M=
X-Gm-Gg: AZFdTZcGm+0wgAskyz9re3CvzOMKu4MQJLXMSferWO1YXKh3aWijiD/93FXrJXO3Lye
	p20I7ljhi2nEUyKamYdU7WK+80SZVXt0ePDET9iw4JHyjm0PlFRCrh/dbApAY7U58mygWyxzZE/
	DabEFq/z9nVJFQUfqSlmfYPydMloiogFfYHfzi2jZggZRCecg1aMZyA6yjbdLhDTJ5RuiPxaicu
	KAdftGGNkQ4HI9tJsNWmNgMbfO3zuSLIA1plzyz2xX4UtpMbzY8ai1djAC3WO2Z9pNarqGG3xeM
	yh92kchN9J0weYMO3IyiKaHmww1n1bM0pSNdsQ1/C7N7oadVFQGD4RpTJldOTbFon6Wg/LBgIhq
	FDaawJbS+1QSonZUv2ppPGzPle/PjPs1Km4RP1gB4LmlKeiNVAuHGvzFpc+BOxu7/jz2LTJZqUu
	myurkmEI5e4Q8Qm7iHBMeAl5mQnknaMxVcZMHS7SmVN6tQVL+9qokJelyv6c3PFMaGGMrlYGe9T
	QROo7LWZU+cFHc3Nfe9z+tsMt7XIbPIdHoYJu6ZWqdtgrxnf6X/bi5HsgF4mQ41QY5JsDF8NcbP
	Kv1jGdlSElSX3CvODn69pQXBFyBIYmwoOaPtJZIEiUKlE5NkhlN2wqbkxPvW9WG7HVNw4vzblpP
	DQRS6s1gsxG/kEKYuxcMirxFojWr0UmGwK33WQdthZYYClxxjKOvX2dOQn52PT5zncNeP7paACQ
	ITWCeFTsS85ircHoo0KCBHSk0z045U
X-Received: by 2002:a05:6000:4b1e:b0:48e:7e1f:8cee with SMTP id ffacd0b85a97d-4abb0f3c23bmr49265435f8f.12.1795817105369;
        Fri, 27 Nov 2026 14:05:05 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm51467422f8f.8.2026.11.27.14.05.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 14:05:04 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v7 1/6] notes: add notes_tree_or_default()
Date: Fri, 27 Nov 2026 23:04:40 +0100
Message-ID: <20261127220445.45639-2-okhuomonajayi54@gmail.com>
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

