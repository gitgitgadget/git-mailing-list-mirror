Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187618F48
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877929; cv=none; b=bFWEtmQQN18saxzeimDSCDANUre2rmJlaAD+WULULQrJ+MAE8n1U+m0bdp8GfeFQ3I8tJWke7FdC2FqAWu+vwD0xeUFZG9a5CusPoddfqHDKGYSsGUE/kx5ri0N/OAG6lYMDjepBpd2ZKzoZDD+X9LYnSuDVjqeEMpmtkkwVZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877929; c=relaxed/simple;
	bh=c6QpUj1OxVAX+oRruFZt8fBh/8Rk2Oi+3WEX/8B07kw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V1XShV2U44PPb5cTwjK0CRaJ1dUmd0oWgOiikkTPIFZEJZA6J3oNGF+hD2e1GoEDAKwshmV9jIGkjZGZJoS3aORjRq1RtGpVL5qHcQsYHxps7X1FupD2qZesdHsYwF5iTmLG2cuo9oMKggsUHPTiDFe1CHSZHNe+mwC2k48bOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8VyRuwy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8VyRuwy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35af7bf408aso351946f8f.2
        for <git@vger.kernel.org>; Mon, 27 May 2024 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716877926; x=1717482726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8Zy5ZRWXeRyStruHYHFiMB6fzyI/Q5COEK66Ke/5qM=;
        b=G8VyRuwyPWWKKmSdaZfxgz6kgX7c6x4EQ3Q244i4uDN+sXRA71OxN/zXnB/JM/00//
         /EBRcsNCOVM7TwSZ6g7GoumF+t9zI820YZla7fS2BJjiSSV0/J4GdUYbAFUyACyqHIyi
         ItaYWGvOQGfQ25gmBmvKS0Mgaavvh8bvm62Wb/oYlsRQXW1tlDznZbeboNJANA1CIdAW
         ZXHYHbybebCMM4WdEVZkjIeokhU/CvdGt6rlLBeEXbsryEX++t+WXWbHhcBYbZhDFHOF
         AkuPDvpCDlwMkHjNkhilCU2TeF3eF/2feCYnnvVUi/MCRqurWPEXylx3sbhheBNZIs9O
         33zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716877926; x=1717482726;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8Zy5ZRWXeRyStruHYHFiMB6fzyI/Q5COEK66Ke/5qM=;
        b=lA3ler/dwyeL+87DfbornIxB+hZp34qtCiFrPU4tUjQoD3Ys3voK1TbRDxyfzxHv+Y
         QIxSJ9DFRVN6qit/qoGxA86dmyasmelsfU7B3jivachOxXek4ze5JdYmL+/sqWEev7cv
         DePmK9bwSsh5qIhhNZUXXrvqoCCp3GWA6nbmVll/yjQa61wAD64DCP4FvJbpbTZYcdUU
         ofP0KcLe6OyR4n+SKXPuMXwCdR3sNlkL0F1k9hjQbuKZoMQxrH0iKjMzGs0ivUlBi/ko
         Cvg/4lGmG5XmN6f1il28waiMFlD4EZ6V2MQE4aKEl9YHZbqBYbxn9s5CNQkg9ZGhe6Cd
         6Uhw==
X-Gm-Message-State: AOJu0YykxGmuQTSAYNUFJmEeYO4Of3M7OWNhMYuhk1dZivO8yzn4nnjA
	RR0iVrnH0xP12S6onfFlTV9S73xmAJaHhZjPtogqO0pbboIQH9CDlAWeaA==
X-Google-Smtp-Source: AGHT+IH6KKiLNrR7QcAfBbUjakJo37RLud5Da99CONWj4Seg1RolHlFPSIRkrCWkZ2MQEIXzzAXjdw==
X-Received: by 2002:a5d:4391:0:b0:355:585:e514 with SMTP id ffacd0b85a97d-35526c5b0c1mr7016400f8f.34.1716877925688;
        Mon, 27 May 2024 23:32:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf03f0sm10815464f8f.98.2024.05.27.23.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:32:04 -0700 (PDT)
Message-Id: <36b44eb4c18cfd805ccecd8df695b0d5ee9c409f.1716877921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
References: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 May 2024 06:32:01 +0000
Subject: [PATCH 2/2] apply: do not use the_repository
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philip Peterson <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

From: Philip Peterson <philip.c.peterson@gmail.com>

Because usage of the global the_repository is deprecated, remove
the usage of it in favor of a passed arg representing the repository.

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
 apply.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/apply.c b/apply.c
index 901b67e6255..364c05fbd06 100644
--- a/apply.c
+++ b/apply.c
@@ -3218,13 +3218,13 @@ static int apply_binary(struct apply_state *state,
 		return 0; /* deletion patch */
 	}
 
-	if (has_object(the_repository, &oid, 0)) {
+	if (has_object(state->repo, &oid, 0)) {
 		/* We already have the postimage */
 		enum object_type type;
 		unsigned long size;
 		char *result;
 
-		result = repo_read_object_file(the_repository, &oid, &type,
+		result = repo_read_object_file(state->repo, &oid, &type,
 					       &size);
 		if (!result)
 			return error(_("the necessary postimage %s for "
@@ -3278,7 +3278,7 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 	return 0;
 }
 
-static int read_blob_object(struct strbuf *buf, const struct object_id *oid, unsigned mode)
+static int read_blob_object(struct repository *r, struct strbuf *buf, const struct object_id *oid, unsigned mode)
 {
 	if (S_ISGITLINK(mode)) {
 		strbuf_grow(buf, 100);
@@ -3288,7 +3288,7 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		unsigned long sz;
 		char *result;
 
-		result = repo_read_object_file(the_repository, oid, &type,
+		result = repo_read_object_file(r, oid, &type,
 					       &sz);
 		if (!result)
 			return -1;
@@ -3298,11 +3298,11 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 	return 0;
 }
 
-static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf)
+static int read_file_or_gitlink(struct repository *r, const struct cache_entry *ce, struct strbuf *buf)
 {
 	if (!ce)
 		return 0;
-	return read_blob_object(buf, &ce->oid, ce->ce_mode);
+	return read_blob_object(r, buf, &ce->oid, ce->ce_mode);
 }
 
 static struct patch *in_fn_table(struct apply_state *state, const char *name)
@@ -3443,12 +3443,12 @@ static int load_patch_target(struct apply_state *state,
 			     unsigned expected_mode)
 {
 	if (state->cached || state->check_index) {
-		if (read_file_or_gitlink(ce, buf))
+		if (read_file_or_gitlink(state->repo, ce, buf))
 			return error(_("failed to read %s"), name);
 	} else if (name) {
 		if (S_ISGITLINK(expected_mode)) {
 			if (ce)
-				return read_file_or_gitlink(ce, buf);
+				return read_file_or_gitlink(state->repo, ce, buf);
 			else
 				return SUBMODULE_PATCH_WITHOUT_INDEX;
 		} else if (has_symlink_leading_path(name, strlen(name))) {
@@ -3510,14 +3510,14 @@ static int load_preimage(struct apply_state *state,
 	return 0;
 }
 
-static int resolve_to(struct image *image, const struct object_id *result_id)
+static int resolve_to(struct repository *r, struct image *image, const struct object_id *result_id)
 {
 	unsigned long size;
 	enum object_type type;
 
 	clear_image(image);
 
-	image->buf = repo_read_object_file(the_repository, result_id, &type,
+	image->buf = repo_read_object_file(r, result_id, &type,
 					   &size);
 	if (!image->buf || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(result_id));
@@ -3539,9 +3539,9 @@ static int three_way_merge(struct apply_state *state,
 
 	/* resolve trivial cases first */
 	if (oideq(base, ours))
-		return resolve_to(image, theirs);
+		return resolve_to(state->repo, image, theirs);
 	else if (oideq(base, theirs) || oideq(ours, theirs))
-		return resolve_to(image, ours);
+		return resolve_to(state->repo, image, ours);
 
 	read_mmblob(&base_file, base);
 	read_mmblob(&our_file, ours);
@@ -3636,8 +3636,8 @@ static int try_threeway(struct apply_state *state,
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
 		write_object_file("", 0, OBJ_BLOB, &pre_oid);
-	else if (repo_get_oid(the_repository, patch->old_oid_prefix, &pre_oid) ||
-		 read_blob_object(&buf, &pre_oid, patch->old_mode))
+	else if (repo_get_oid(state->repo, patch->old_oid_prefix, &pre_oid) ||
+		 read_blob_object(state->repo, &buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to perform 3-way merge."));
 
 	if (state->apply_verbosity > verbosity_silent && patch->direct_to_threeway)
@@ -4164,7 +4164,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			else
 				return error(_("sha1 information is lacking or "
 					       "useless for submodule %s"), name);
-		} else if (!repo_get_oid_blob(the_repository, patch->old_oid_prefix, &oid)) {
+		} else if (!repo_get_oid_blob(state->repo, patch->old_oid_prefix, &oid)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
-- 
gitgitgadget
