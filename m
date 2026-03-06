Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1F481641
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830449; cv=none; b=llnAJmm+e38fjuqcxuGEVvl8UhT0w6UlULHRSj++XTFdGLwu2ZrSyjglPJ3ypU+LSf9Gi7isJIpDfEOCIKNTnc1EzvVV3hYFYeWoPRdUW1Iw5hT5UaYxntUGprxKJboUneUkPZQeWtS3lMpTd1a2QRqrfqDdGvmF2mbLbTfKHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830449; c=relaxed/simple;
	bh=bs2jKsUp5ts2q/QTfWy7H4RPSugYFCK1HCJTvff/oqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeBAE35wraZXzH5mV2XMGGm6WniMLoOxcZ7B9ErER+7Vs4ou6rmXFO8TX9xgfWaG5P+krc/eo7MlEA6shS5vbf9AKYNQJQle3HpG/il0HrXSeurvImB0/VGF/cUvYX3XbSHMnOWUJ1pgdGKmODFn6Q1+wj16hxGk0znjfAZeTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyqz9bva; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyqz9bva"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-414ffb4c0a0so3931135fac.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 12:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772830447; x=1773435247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bft83RfhJeHCk0FmLQQ8BT4sXUWW1k8E63Ym22xXxf0=;
        b=dyqz9bvapKcqIDneONmidlNRxBOn690Cb/zU4RtgDNMIHlxbocnQfxXjT8ByrWOZHb
         KFMlcntGVKM+Qu5GFT48I6Jklq/e7Bv+uFHENmHt6XrGe7Eyn4qPU2V1b2fE/YBeIq68
         ChYV30JHjm2zPJQOhZavuiLwjyLY6L2Jz7txF3mRapH+gZn76DfT8hT9Ku5rTRooLIFG
         yZgMy2YuAACYAt3ShEyul/6XAgF0l0DNPuBG8a2WAoZsn1sBmh+NAwPnc+MUfcjb7jW8
         Rkgbv7HihHKPlyEatqsy/a3uoZz7vQWr/d0Ts4oOcu4VXu98Vj83M5fcR8dBTf9+q5LZ
         HTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772830447; x=1773435247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bft83RfhJeHCk0FmLQQ8BT4sXUWW1k8E63Ym22xXxf0=;
        b=f8tpAT7R7Fk7nlecvFMjzvvmFmNuGTD1/MObWcLBLXXsniopLUWHV/g9g8705MtVqe
         IgWynMPO9n0K3icb3KvOtmDY6D1WkzuUZmgSsQoSHkLsqaECpsNW6Rb26U559DHqQzjt
         O8Pmhxs8+RaUZtRoeFpTxhpLhwnjQm45WVsnXtIWwhxs6KmWW393KKu+SujKpYHXQE4B
         1poWhfDVZ0n05WXbHrGY2mNGOkbgqXOnNXvww+0yWdx+wjf5//y9YMrd2NY+hEhe/+de
         Q2LWfwvH6HOQzMRwtdKeXMuHxuTgMTeYa2ejjpXoXny90ClAa9bVjNz40UxlNUNd8xxH
         qGzw==
X-Gm-Message-State: AOJu0YzDdvxBSphiHnXdtU6jGFqmePrJMaEGQypmvpedCJzFpCophPmw
	x9ALsyw7imUlETvg7+AGuQJ5+1Uj96rEEyyJsedVENvdRDv5YsUQBk5ZtO38+A==
X-Gm-Gg: ATEYQzx+s7HNu1P/SDVcwRVgsj5oya0XS0gWacqL6fWKRUCCX5Xs+xUN56oUQ/tBOah
	D/pgVz08l//iJZDNaiyB+S9flZv03tSJ8iIp6dRqE+VmCkvPO2UYy9x+kDliB3aFvrDIWoN+q7q
	BGOyJVZaHrkDN2h3TvAt173Mp1DQuH7RrU54br0B7a3MCqJxWX2jeyW7RZ9iGli77S39mdQcwyJ
	cFQqZDzSVJXmcEfsgrnhuGlNUTslgxPtdVyfeVK3YkeZhU8G2Iib4Gw4azMDGhn1ZNDVRS0/WlK
	jYlNmFoWC1wqtkN+y+rJ/hzRFYtCn6ySCl9puOc6dD4lXRUXRO+lpsWOSFFGHmj37sHuYGGZcVr
	J54aWTfpp37ytvKaXiTFJYvdhA4ULxk+vfNqpR90Eua5JvfZxps1gpnJUR/7+Im273IRDnLNInE
	nhiF+6v0Mb9o0X/RerPZcjDoJZXDCRKRs=
X-Received: by 2002:a05:6870:b1ce:b0:409:95c6:f2d2 with SMTP id 586e51a60fabf-416e40844acmr2064982fac.30.1772830446602;
        Fri, 06 Mar 2026 12:54:06 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e688d5cdsm2278014fac.20.2026.03.06.12.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:54:05 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gister@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/3] gpg-interface: introduce sign_buffer_with_key()
Date: Fri,  6 Mar 2026 14:53:58 -0600
Message-ID: <20260306205359.1723254-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260306205359.1723254-1-jltobler@gmail.com>
References: <20260223194146.3476768-1-jltobler@gmail.com>
 <20260306205359.1723254-1-jltobler@gmail.com>
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
reused by git-fast-import(1) when resigning invalid commit signatures.
Introduce `sign_buffer_with_key()` to centralize signing key resolution
in gpg-interface to allow callers to reuse the same behavior without
duplicating logic.

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

