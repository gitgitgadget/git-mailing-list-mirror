Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594134751A
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250320; cv=none; b=R541cUwwmf+sQ+xqukYlvBkFnBQpDz/edZ8QRPb24MwQxYcARMnAQ4/gpNji90ZRWYJUnc2anoYN7/L2SqdAz/x2mzqH2HanSmumVbnhArFbIzfmE2OEB7Vh4G+aiggCvvWquTVLXUZpezmH9yvXddcTXT+CRZKrcoJsdzkFF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250320; c=relaxed/simple;
	bh=pQgPqB2CUr1OIuwj4kStGXAcEehYPnvM9enfsxpRd/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m87wsM0whPmfLBOK+VGbiCaN+dYBWQ7A22xSa6Z56Zad1UMmft8EY1tpq0htuSgAw/TEjv8uN4KGuIOXiraPbGQO37BHkPxC320y8im7Ga5/TMoJWuIEF6kcH1YpCSrZJ8R8lfEGgs77tY0R7iFIWij/Qmokm5fpjT7n5era5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEhSRB4S; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEhSRB4S"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4670bcc40d7so67546b6e.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773250315; x=1773855115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhMbfb3V8Ag5UcdOlSnrML/ORhO0apItBqfJSqakPZg=;
        b=eEhSRB4SENypot69K+ap92w+TznAgJ4X4hkC0Vj342d1xRmc7fqFK9GSH/eobb9TP7
         ANkvBAPcafVttG/jDsy4LV3fFLrJvdEyPvYabt1kV2CkNMDBSNb2b4A4sB0EfopkUsoe
         oQ5qHvThFBjdD5gBSX7uIBfdYLxXgMjfxOu/WLYwlEj0dMoJZ1ALzSU765QpMm6nO0Ra
         LOwdzbKx1etIGzV/KPAPsDdBEofDaX383GRQE0poklKAJdbfo5MJCWV/kO8itONQaeC9
         7GmvDwfLKXKx/77P0dVlOME0iQ5omVJOn4XU5UlNsuN3cDaRG6nRLoA8PYIrx46AZwAF
         A8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250315; x=1773855115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vhMbfb3V8Ag5UcdOlSnrML/ORhO0apItBqfJSqakPZg=;
        b=IS/pZykIhJm/1FM5C9Kg4CHDHrNqhM/peFHO/EMQW1yt25g26iBo3HIGtrWbdExP9+
         9rXwr/xCexBQz+h1RdenWadzbylwZKgqWAhm35sZix2HZqRiLVfePP1EjGYHhHtHc0Yu
         7iVXKxSX3xx22q5rs6D8OxHqgtRLj9wRn0U4qGd3iYBRyeBfSWdfWhZqP9LFBHc0f2Rn
         1+YL91Bbhk2WB/7b5C+qtFBP8BcY/yJ8KohNVawn4MW2+c8d6a5rFT/Q6+j0Oigyv0aS
         yokQB+1dP3nTYrCrkim02R3I3/6x06grk6miKh7jCSCO8tR7dYwNUWqTPQ39FUoWRGx+
         mUbA==
X-Gm-Message-State: AOJu0YxXxCPay/k6WcC6iYbjfxeyI2bxUhkzyQ73NGjerurFv2WskeXu
	bWybYpgktMv2DrpRMyjF+ye2wYb2KtmLAsowTKMD9Y0UCAn4zmVYJZAcLxcAIg==
X-Gm-Gg: ATEYQzxtsFUDDz0EefX4K/eJU2Ede+faq1tcCjYXCu0keCI2i6IvNR441sKu0csfimg
	6p6tlgtYDsciz13Qtr+lEqVFKA9EP/ilATqtGbqjIhE86QSzUxbDDANDv6omDuebi9BNTmX2W4j
	I8dONOHNf2w5JiTxRKZAwbiQN61LutnWUw+bVcuxLK2gB3Xg0Pm1PCPfSGk28NM5BAC+8CX6iar
	FB2ytZ4abEATNGNnJOskRnGWBbq8D0s9xhWIUMBe81u1S2Z0/AhVJ5F7J6ai1JGiBbdM33EwIIb
	fQPZ5/ryV9cKm0oSSC8Z1Y4mfwotmk8cErgJUIsbrX2P1HhQziVB34rlAFGbVj9hh/pXZZfVFqs
	Yqig5I3rV1HQdL8QE2lQd5tSOropQizv5bHqo3luO/2XVp7xtuTRGs2RxOo3Vpi9xuvUXx1Lg/S
	J8ptY3+K/gKSVf+eSjsShp7HFzza8S7NA=
X-Received: by 2002:a05:6808:1787:b0:45e:f09f:6359 with SMTP id 5614622812f47-467335b7dbemr1644091b6e.53.1773250315456;
        Wed, 11 Mar 2026 10:31:55 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e26e2c6sm2826761fac.7.2026.03.11.10.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:31:54 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/3] gpg-interface: introduce sign_buffer_with_key()
Date: Wed, 11 Mar 2026 12:31:46 -0500
Message-ID: <20260311173147.2336432-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260311173147.2336432-1-jltobler@gmail.com>
References: <20260310201116.1130160-1-jltobler@gmail.com>
 <20260311173147.2336432-1-jltobler@gmail.com>
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

Move the `sign_commit_to_strbuf()` helper from "commit.c" to
"gpg-interface.c" and rename it to `sign_buffer_with_key()`. Also export
this function so it can be used by "commit.c" and
"builtin/fast-import.c" in the subsequent commit.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 commit.c        | 16 ++--------------
 gpg-interface.c | 13 +++++++++++++
 gpg-interface.h |  7 +++++++
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index d16ae73345..1677b1ef25 100644
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
@@ -1737,7 +1725,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		oidcpy(&parent_buf[i++], &p->item->object.oid);
 
 	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
-	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
+	if (sign_commit && sign_buffer_with_key(&buffer, &sig, sign_commit)) {
 		result = -1;
 		goto out;
 	}
@@ -1769,7 +1757,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		free_commit_extra_headers(compat_extra);
 		free(mapped_parents);
 
-		if (sign_commit && sign_commit_to_strbuf(&compat_sig, &compat_buffer, sign_commit)) {
+		if (sign_commit && sign_buffer_with_key(&compat_buffer, &compat_sig, sign_commit)) {
 			result = -1;
 			goto out;
 		}
diff --git a/gpg-interface.c b/gpg-interface.c
index 87fb6605fb..a72fa35061 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -980,6 +980,19 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	return use_format->sign_buffer(buffer, signature, signing_key);
 }
 
+int sign_buffer_with_key(struct strbuf *buffer, struct strbuf *signature,
+			 const char *signing_key)
+{
+	char *keyid_to_free = NULL;
+	int ret = 0;
+	if (!signing_key || !*signing_key)
+		signing_key = keyid_to_free = get_signing_key();
+	if (sign_buffer(buffer, signature, signing_key))
+		ret = -1;
+	free(keyid_to_free);
+	return ret;
+}
+
 /*
  * Strip CR from the line endings, in case we are on Windows.
  * NEEDSWORK: make it trim only CRs before LFs and rename
diff --git a/gpg-interface.h b/gpg-interface.h
index 789d1ffac4..a32741aeda 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -83,6 +83,13 @@ size_t parse_signed_buffer(const char *buf, size_t size);
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 		const char *signing_key);
 
+/*
+ * Similar to `sign_buffer()`, but uses the default configured signing key as
+ * returned by `get_signing_key()` when the provided "signing_key" is NULL or
+ * empty. Returns 0 on success, non-zero on failure.
+ */
+int sign_buffer_with_key(struct strbuf *buffer, struct strbuf *signature,
+			 const char *signing_key);
 
 /*
  * Returns corresponding string in lowercase for a given member of
-- 
2.53.0.381.g628a66ccf6

