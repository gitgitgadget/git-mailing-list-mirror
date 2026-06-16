Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5C3C09E9
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621408; cv=none; b=oi7rvNUnvz3/S6nxMiPycpfCwgkOmdWv8HGNfmKR1zb39Apwzfwe25gp1tC8vOJ2/RIk6/4Lq2NaPZriOfakJkiRUaQvs+OdadlHLSC1jroQMOxZa8C59l5NVSemZrd5ZuwfMMp8W2wvKNlZDKgjBUiHSIepwKbuRe1uMpVJh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621408; c=relaxed/simple;
	bh=Ak422h5Vn7RIA/A6O/qXwyyOm/aai3FbRavjwiv8hcc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uIowtqFF2LTUa6kD7WrcFZ2Lb0tLAhSv0UNrVmZK+nau+ovgqy4I5G3rS6GJtRMtks47oXYFVwU6P1wk/mTzbzr35H4Paz0eQLo8rIrVVKszngDArjTMEHCeHgp8uAO2dRx1arMInb5NBYCOzPkmJsCvylpyj2BvDbwrOiCWd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9ekC4hZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9ekC4hZ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso66797946d6.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621406; x=1782226206; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEF80Mvo1UbuvTwjgFnf+s7q1ZLd4qmyjYN3CNbdrHQ=;
        b=C9ekC4hZTFI0zMbwDCNKE9JwNpmh70/RHFalbf6jU3aOaOULlt5Tqc8iYdVMQ9wrHk
         FBesLEAiKxGs/QD+3g7dzA9XkQ06LyaQvOTDPYkzu4+Hbo0wwufpcq6V/eTZGNAL415g
         OtmU4TalhKXB5xf5230EFj6VQo+vpetNJASNz1uUNSZprE5VcyQiD4y+0ftg/MgLxUVN
         b03m+6wAdExe92kbiSF+FO0x2GiJh+b4Q9cTBdB58cWn9jpra6uh19t5RGF56P/Ok4YW
         bHEN2UYLYupMLEeGZfW/ehc6XEGKnHa+dfnp/b5vJ9DBEB4K1S+fSg17d8Z+p8Ad38Kn
         FxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621406; x=1782226206;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KEF80Mvo1UbuvTwjgFnf+s7q1ZLd4qmyjYN3CNbdrHQ=;
        b=h5kvyZmwbz3rkig2YE+sUkBg7eIBIWcyA0ViDmt6eXv3dbkYoICMjwvmqOJ7ZpY8FW
         PDC50Cup2yxxXdrcZW78JHestuUEOK8SVrY+bRqnWo1Kh5eB2ZvK2880uB1jFcGN6PzI
         rZ7xPRCZcY/cVVfHbqsyReztoUFAhqMlJalaDh8M82FSKR3CMQYvQlfoHzZSV5kpxhG+
         FEgpsl+i8stjzy292EQIRVxK7qsaFXGSY1+NCQd+Y7d2+qum5c1HKISKkwhuB8Tq3nKM
         aQXHHrz2skxTAarG3YrVWSxuj2AE7fs2R1Hp2vQec0SZbhC28LwxEcE81BkwqzMNOrIP
         OizQ==
X-Gm-Message-State: AOJu0YxyDBwWJbFm/cRAIuTxOzxznjfdyvZzmtU0TUGO2BHcG4tHDp0E
	fyvu7XF6u0uzcsjGhDReFyfzcQH4WNJzhfxUifVzi9dY27TX4yvJFkG1vw/7NQ==
X-Gm-Gg: Acq92OF6IHjMqu530GgXJ2ebuVuZGP7C0mw2UYiy3A9Bvcu5KPzhWigkcr/3JpOlnI6
	SA76qpxHJmoQbaaZznYKZdZJtxlInDcZ7Oyjv9xKfJZcq/B7nOimuMLimHrlrR5kq+SIzYI2R5R
	1rltLQohj1uwBcsSHdUrUcVBikvFfhdxB1T1Az+EeeBQYsgcbgZ0KC9k9Uy81RCcH1Zo8ArMd8S
	Vx0Esowju/PKd5EfF4O8b8zThrNXU/ZJNw9MhLWzQN2caj6t46X0OUjbcMUNVF/3W0vwpCGGXPd
	N1teA2DIqPJ/p7lHO/KBzTh32pmS1UKmQuxZqSiytUWVgmmXV+OAnQlvN+NbmFOyHTkO5OZvfV1
	VKHB5YZpzJKv9Q+NuVtDW+djKGNeofmnv8pJeM+itSVZfMuyR8k1XQWrJtynHnK2e3JcF1Up8Vj
	xFnRIf8DMI3e02eJZOoOWMHnSNtQ6GiZXGThT2
X-Received: by 2002:a05:6214:450b:b0:8cc:f135:529e with SMTP id 6a1803df08f44-8d44f425cd7mr290681946d6.34.1781621406128;
        Tue, 16 Jun 2026 07:50:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f122b21bsm34367706d6.4.2026.06.16.07.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:50:04 -0700 (PDT)
Message-Id: <b401eb490faa7e1c3980129e0aa78422bbeb624f.1781621398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
	<pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Jun 2026 14:49:54 +0000
Subject: [PATCH v2 3/6] hash algorithms: use size_t for section lengths
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

Continue walking the code path for the >4GB `hash-object --literally`
test to the hash algorithm step for LLP64 systems.

This patch lets the SHA1DC code use `size_t`, making it compatible with
LLP64 data models (as used e.g. by Windows).

The interested reader of this patch will note that we adjust the
signature of the `git_SHA1DCUpdate()` function without updating _any_
call site. This certainly puzzled at least one reviewer already, so here
is an explanation:

This function is never called directly, but always via the macro
`platform_SHA1_Update`, which is usually called via the macro
`git_SHA1_Update`. However, we never call `git_SHA1_Update()` directly
in `struct git_hash_algo`. Instead, we call `git_hash_sha1_update()`,
which is defined thusly:

    static void git_hash_sha1_update(git_hash_ctx *ctx,
                                     const void *data, size_t len)
    {
        git_SHA1_Update(&ctx->sha1, data, len);
    }

i.e. it contains an implicit downcast from `size_t` to `unsigned long`
(before this here patch). With this patch, there is no downcast anymore.

With this patch, finally, the t1007-hash-object.sh "files over 4GB hash
literally" test case is fixed.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 object-file.c          | 4 ++--
 sha1dc_git.c           | 3 +--
 sha1dc_git.h           | 2 +-
 t/t1007-hash-object.sh | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index dccbe0fc3e..0056c369ce 100644
--- a/object-file.c
+++ b/object-file.c
@@ -316,7 +316,7 @@ int parse_loose_header(const char *hdr, struct object_info *oi)
 }
 
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
-			     const void *buf, unsigned long len,
+			     const void *buf, size_t len,
 			     struct object_id *oid,
 			     char *hdr, size_t *hdrlen)
 {
@@ -336,7 +336,7 @@ void write_object_file_prepare(const struct git_hash_algo *algo,
 	/* Generate the header */
 	*hdrlen = format_object_header(hdr, *hdrlen, type, len);
 
-	/* Sha1.. */
+	/* Hash (function pointers) computation */
 	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
 }
 
diff --git a/sha1dc_git.c b/sha1dc_git.c
index 9b675a046e..fe58d7962a 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -27,10 +27,9 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
 /*
  * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
  */
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, size_t len)
 {
 	const char *data = vdata;
-	/* We expect an unsigned long, but sha1dc only takes an int */
 	while (len > INT_MAX) {
 		SHA1DCUpdate(ctx, data, INT_MAX);
 		data += INT_MAX;
diff --git a/sha1dc_git.h b/sha1dc_git.h
index f6f880cabe..0bcf1aa84b 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -15,7 +15,7 @@ void git_SHA1DCInit(SHA1_CTX *);
 #endif
 
 void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, size_t len);
 
 #define platform_SHA_IS_SHA1DC /* used by "test-tool sha1-is-sha1dc" */
 
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 7867fd1dbf..f028a1cbcc 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -261,7 +261,7 @@ test_expect_success '--stdin outside of repository (uses default hash)' '
 	test_cmp expect actual
 '
 
-test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'files over 4GB hash literally' '
 	test-tool genzeros $((5*1024*1024*1024)) >big &&
 	test_oid large5GB >expect &&
-- 
gitgitgadget

