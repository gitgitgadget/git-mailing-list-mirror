Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABF3164DF
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173486; cv=none; b=fiPOUTDyZg5qNduusICmRIET1pCdQnByyw1A9rMX4agjoNLSPtAxH9dgye/9KmXGmLdvdoTQYofwcLJnwgXKa1HJWdpIwo1jY0XL6WkaDTy5Z5StuvpAVU09ksYZkJct3adu+LRBi2CR3FJ+Co2S3hyyuqQlkP5XoAhDBXSYqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173486; c=relaxed/simple;
	bh=dRwefKuBmaUFrZj3viihe0yuEU/BWLoxTHffwkS/d8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNVblIQ+Z0Vr9YFcJH5gKiRtQ+gDczc0IihERHBvDqxq5IGqE3S9jHdlRdmXyKID41OJO/gUGTFXp5LBz/05/H/eAh8VO3NFUkINkZn/x57u0tOYMkajpgb52Hs3djHzKYhHdhK3myiku6XOhV/wb/Z03iOn16IMnsVUT/Fi2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsF2d9Hy; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsF2d9Hy"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-67ba58c0220so196172eaf.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173484; x=1773778284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OQEVGY2hMq2AHh7FCREeeqMBbkKE6IKPcAFZAq+3FA=;
        b=dsF2d9HyGPXacdnYeUT+CpyATHYqVfNNtJJIDNvu1v+Qd+hLPVGVPT7AbLgnfsHVJ1
         rqZ+LmhjD4mai7qUDQLqb00SLzd+Gsrt8vVETxkkjLp5Lgnjxiajjm61ISbbnaFIFopk
         8UZPnEzsAEFlN1OiQ1RykqpoTQhdLCFdLU/spIDNitFDlduj85uAEUz1E+LtPDDSBLoD
         xTjdjOHGNPNrcqLOUlqvbw48yueSL9hcb1UIdFL5K2raaq8rPyWeyAUZUu3pLXlA6BCs
         dbUnqAduiMdd7wJs+7BdnBpxV5rCjqm3ROyGG/bHE1BPqJXheZmvO++OwvAn3klgN2cW
         gIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173484; x=1773778284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3OQEVGY2hMq2AHh7FCREeeqMBbkKE6IKPcAFZAq+3FA=;
        b=HPAlZ1jMkbEzcwIo3+8TpLNHENPdhhN6jd7k6FijADToIEVlY0ceSIDEj8iCN1KI7X
         yCHZyMpvVTvGpqekpJle5/JIKo3n4PPofyzlWwf7TpvI2cqSg4h1SNmHGdvmx5c6qCnm
         9Z8h0VNd4qjkigZ4uV4DzuJ6vvqoPIXYoYrJzi2uIqkShVT09fkOTA8+3El1t3tAVQDJ
         sK9h1bcn45S+5FLyoDc+PuqkeJP/Uuy2NZkPpqg0WrBKflIyMffzRDIFT2ptwLsYd8Me
         TvZGPrwZ0fS/m/H1TqCm/ApIOKfca15CpCjgQgUze43NvOrFxEBB3Vu1TCDg1vUeB1xr
         ekIw==
X-Gm-Message-State: AOJu0YybpEph+pxNaqUW89OfMLfTRVRFMvsqudtUfC8dCwr8CH074XlG
	z/BW2ODpb+ELTsoZukPPWZcJNfrUcZCBlgofdlu7sf90Tla72BxthTvTWoKsbg==
X-Gm-Gg: ATEYQzzwWvLNRhUVIccsukVqiPBVKrXpcfGAfCwIro+yUN+ULZvHtbHiQaIOoXqDdgN
	MqA8Re/0Pq+R5sEEFk9daNC8jeTd19uxEjAyNXVmjZmKkvEXjiwaiI2RRYbx60webCqAnXExbG5
	y9fTmadBLuW++jrYo/zMnjXvb8os10lwSZz+Jqbjn2LnPs/yIFsbEPEDOeNMuvJ2eD+7zHUhN3W
	z9IEjH0w+nR0lsv3uHuy0f8IP6sMwmfMyUNMDxIJVyKc+cVLWUBMdRWl4tnH0wS4n0djCDWk+Fr
	lssfk30ZSwmBqN/ldgQ+Mo3lfwWUeVPl9FwNZYCVOdNwzHDP5E8EWpsWEXgLBI2p7nHcYEvprBQ
	Z+o18y5AeFsAcWE194lZyRKgxK447Oy7WJ9cpK5CDTlC3bixkJvDiD2BwaNgBGC5CnuqDsDYqWi
	Bc8Qxgvjlm8XaJHB0hC/8k5Jxr57JA1Ls=
X-Received: by 2002:a05:6820:993:b0:67b:b6d1:317 with SMTP id 006d021491bc7-67bc8dee8e0mr5930eaf.3.1773173483930;
        Tue, 10 Mar 2026 13:11:23 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bacd85dd6sm6221066eaf.11.2026.03.10.13.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:11:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/3] gpg-interface: introduce sign_buffer_with_key()
Date: Tue, 10 Mar 2026 15:11:15 -0500
Message-ID: <20260310201116.1130160-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260310201116.1130160-1-jltobler@gmail.com>
References: <20260306205359.1723254-1-jltobler@gmail.com>
 <20260310201116.1130160-1-jltobler@gmail.com>
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
reused by git-fast-import(1) when re-signing invalid commit signatures.

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

