Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199763290AE
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343357; cv=none; b=oHQg2rCaEmzfCnG5qMqQFe3L4nwIk77ldcpz/ERLix9aKB8KoWRFqdl5niPioOjWHkAI3jbO91SLVKKlSNHEKQVpOPwUVSfgI8ZhBrCV9r9fjqli/fj/nLPvJWW4IP1wF2uDBreHu6qAqbFR97dan1vRf7lYUo34NG7Tv99+5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343357; c=relaxed/simple;
	bh=rTV4FHXUgDFizEya/vz2PcY9ukEtwcuIvZDyCu2AHJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2wZjpFS3Itx2ITuuhPZoGQ1OAeyhjEKYMYqYgMqowoWbo95+K2YfNEAQrNwVFec6iQhIYk4BIjxsmugs4izMxGreSdeRBcc2pgPo4M9cT8ctbtwRkEKmUFevW+krtQIlfEVF0LT8LI5/jTwlguOLfQJ3+eChTzn0j3825/KYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8sn9TRN; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8sn9TRN"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so590749fac.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773343355; x=1773948155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXhe6SxX9mKHzGNKESWYRSCgWt1Nnufqhk1kywXLsl4=;
        b=d8sn9TRN49wOfi9yff3zE6p/FXtlPKhw1EIIJh88fjFL+zkAiE98nitk2L/+XVXRk7
         0+veeydhl//nVvm8KZxGCh1ArLBn/Zp7EDYGkM0iukq5YJbCW0Kzh20BnnVxvDgbq7/9
         ebdjGj4pT35iDKBe9qOjNghHcF2+ix/bSEYp/Cv+nrFe/H7zrNwVUoHBswAE04U6GIsm
         PAXWFmrSw+nc2F5wqxXqUn4A2KSFsOIrk8G56AOQjToM8ogYEWGEWUWaOPjlQHmbaRpe
         kMz47DwCr1SEU3xIXiTbGeYSAZ3pqdM/7vD7G+UyvD5LV9CsdYyMv4CtqsCxtrcUsqbO
         yFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773343355; x=1773948155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VXhe6SxX9mKHzGNKESWYRSCgWt1Nnufqhk1kywXLsl4=;
        b=KkULQpi0TnJU30MuIWVIidZsVqA1G2aDva1vUyBN3GIX+Mb1OGzfuwsLRxnfcVw+w+
         p8DhzBDRLhG3dtDTJpaeKwP19TqUf0hC3Fu4bhZ9Azw51+P9OKeKlMHMdyQUFPUEvYaa
         LAVBXPqVeLjpqUpdq96mQrJi/6OW7IJBGxPuJ5kw88Wre4ycEBqp8f+Sf8HfteJpx85i
         MBVdLUH4Dunkhfn5+RxB3G4s8dAKlhgCULGbo+u2LHGfSd81M8r9TrEqxD2ZtYNAMyaH
         sDtOMDoWdHeuNND7OYEgAy9sEmZdJ4mRQlS1gVmxnFaat1hlBbPYboweOrZCpzdXYdno
         FpSQ==
X-Gm-Message-State: AOJu0YzyVv2ok+JNZlmPzArV6uEz0VcatyROHQ2+4BP69gc5SbY3RhHS
	J+AagCiRfyS9aRo7x12Q+KoYkkKkvf7L3jBT/H5HXvLWycdHQjOKnZE+L1j8fw==
X-Gm-Gg: ATEYQzyIpBkSzhEVHBUbE7GVog6AQHi2zKiS5vi5PdPPKyYyT2gwnF/1p/TMszbKabI
	4NW52J8r6qE20+MdtwvYaBXN336QxsYhjF7uzeANiYbH2LeQp9CoLbnueufE3G9J/EfLLACSX39
	rKsPdsE0PayCOcHG+cyiwYSH5HHO7+edOHhnk9NOTgtO744TimGY4p/54ViZeltDcDyumCMgBt2
	bmj1tSOpMH0Abs7HqM/44kqSWBci1t4jfEJUHu/bXcVDl4nperj2icuK1jHMRJLnAoOMVOQHl9t
	fBlxJahlIH0+lH4/OcyzxjkpSwFtfwLBUEBC1Wa9NOP1szpERtQKDR1Y1Dc0aHtNVIDLSDFuBkX
	Q3xa6ErOqdCm8EESGsLa4bKnN9MnBTjEqew/yDV8ovl6zLZnd3gpJdpa+wj1G/TemVQxEjrarBx
	LdxItxxp64jAVMhejDVdoVNs9u6xRjyyM=
X-Received: by 2002:a05:6870:d6a9:b0:417:3c98:39ec with SMTP id 586e51a60fabf-417b93d98b3mr280645fac.40.1773343354715;
        Thu, 12 Mar 2026 12:22:34 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6e82cdsm6159987fac.18.2026.03.12.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:22:34 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 2/3] gpg-interface: allow sign_buffer() to use default signing key
Date: Thu, 12 Mar 2026 14:22:27 -0500
Message-ID: <20260312192228.481134-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260312192228.481134-1-jltobler@gmail.com>
References: <20260311173147.2336432-1-jltobler@gmail.com>
 <20260312192228.481134-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `sign_commit_to_strbuf()` helper in "commit.c" provides fallback
logic to get the default configured signing key when a key is not
provided and handles generating the commit signature accordingly. This
signing operation is not really specific to commits as any arbitrary
buffer can be signed. Also, in a subsequent commit, this same logic is
reused by git-fast-import(1) when signing commits with invalid
signatures.

Remove the `sign_commit_to_strbuf()` helper from "commit.c" and extend
`sign_buffer()` in "gpg-interface.c" to support using the default key as
a fallback when the `SIGN_BUFFER_USE_DEFAULT_KEY` flag is provided. Call
sites are updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/tag.c   |  4 ++--
 commit.c        | 19 +++++--------------
 gpg-interface.c | 13 +++++++++++--
 gpg-interface.h | 12 ++++++++++--
 send-pack.c     |  2 +-
 5 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index aeb04c487f..540d783c67 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -167,7 +167,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 	char *keyid = get_signing_key();
 	int ret = -1;
 
-	if (sign_buffer(buffer, &sig, keyid))
+	if (sign_buffer(buffer, &sig, keyid, 0))
 		goto out;
 
 	if (compat) {
@@ -176,7 +176,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 		if (convert_object_file(the_repository ,&compat_buf, algo, compat,
 					buffer->buf, buffer->len, OBJ_TAG, 1))
 			goto out;
-		if (sign_buffer(&compat_buf, &compat_sig, keyid))
+		if (sign_buffer(&compat_buf, &compat_sig, keyid, 0))
 			goto out;
 		add_header_signature(&compat_buf, &sig, algo);
 		strbuf_addbuf(&compat_buf, &compat_sig);
diff --git a/commit.c b/commit.c
index d16ae73345..1b9b2d4499 100644
--- a/commit.c
+++ b/commit.c
@@ -1148,18 +1148,6 @@ int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct gi
 	return 0;
 }
 
-static int sign_commit_to_strbuf(struct strbuf *sig, struct strbuf *buf, const char *keyid)
-{
-	char *keyid_to_free = NULL;
-	int ret = 0;
-	if (!keyid || !*keyid)
-		keyid = keyid_to_free = get_signing_key();
-	if (sign_buffer(buf, sig, keyid))
-		ret = -1;
-	free(keyid_to_free);
-	return ret;
-}
-
 int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature,
 			const struct git_hash_algo *algop)
@@ -1737,7 +1725,8 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		oidcpy(&parent_buf[i++], &p->item->object.oid);
 
 	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
-	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
+	if (sign_commit && sign_buffer(&buffer, &sig, sign_commit,
+				       SIGN_BUFFER_USE_DEFAULT_KEY)) {
 		result = -1;
 		goto out;
 	}
@@ -1769,7 +1758,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		free_commit_extra_headers(compat_extra);
 		free(mapped_parents);
 
-		if (sign_commit && sign_commit_to_strbuf(&compat_sig, &compat_buffer, sign_commit)) {
+		if (sign_commit && sign_buffer(&compat_buffer, &compat_sig,
+					       sign_commit,
+					       SIGN_BUFFER_USE_DEFAULT_KEY)) {
 			result = -1;
 			goto out;
 		}
diff --git a/gpg-interface.c b/gpg-interface.c
index 87fb6605fb..ce935908cc 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -973,11 +973,20 @@ const char *gpg_trust_level_to_str(enum signature_trust_level level)
 	return sigcheck_gpg_trust_level[level].display_key;
 }
 
-int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
+int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
+		const char *signing_key, enum sign_buffer_flags flags)
 {
+	char *keyid_to_free = NULL;
+	int ret = 0;
+
 	gpg_interface_lazy_init();
 
-	return use_format->sign_buffer(buffer, signature, signing_key);
+	if (flags & SIGN_BUFFER_USE_DEFAULT_KEY && (!signing_key || !*signing_key))
+		signing_key = keyid_to_free = get_signing_key();
+
+	ret = use_format->sign_buffer(buffer, signature, signing_key);
+	free(keyid_to_free);
+	return ret;
 }
 
 /*
diff --git a/gpg-interface.h b/gpg-interface.h
index 789d1ffac4..37f3ac42db 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -74,6 +74,15 @@ int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct
  */
 size_t parse_signed_buffer(const char *buf, size_t size);
 
+/* Flags for sign_buffer(). */
+enum sign_buffer_flags {
+	/*
+	 * Use the default configured signing key as returned by `get_signing_key()`
+	 * when the provided "signing_key" is NULL or empty.
+	 */
+	SIGN_BUFFER_USE_DEFAULT_KEY = (1 << 0),
+};
+
 /*
  * Create a detached signature for the contents of "buffer" and append
  * it after "signature"; "buffer" and "signature" can be the same
@@ -81,8 +90,7 @@ size_t parse_signed_buffer(const char *buf, size_t size);
  * at the end.  Returns 0 on success, non-zero on failure.
  */
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
-		const char *signing_key);
-
+		const char *signing_key, enum sign_buffer_flags flags);
 
 /*
  * Returns corresponding string in lowercase for a given member of
diff --git a/send-pack.c b/send-pack.c
index 67d6987b1c..07ecfae4de 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -391,7 +391,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	if (!update_seen)
 		goto free_return;
 
-	if (sign_buffer(&cert, &cert, signing_key))
+	if (sign_buffer(&cert, &cert, signing_key, 0))
 		die(_("failed to sign the push certificate"));
 
 	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
-- 
2.53.0.381.g628a66ccf6

