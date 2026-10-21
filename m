Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616625;
	b=5fDaxiVmaee6sytkd/JfGWIReUYeTezlvUIp6PVt+9KqtthQsUj6D9BRISVFNcdUj4vc
	 v0/GBY4DfHh7k1zmr0Php0fcZzGlnW2sOHGOesiG1wkSf09eErgh9aREi/MyaWg6vtxRm
	 UboH7S4kK0bWzPkv13KXQIqzwlfa6xgH7IdDHcZVFVcsS9gZ/RZtfxkd55LwduIkcpf8g
	 ZSrQeYl0Q83pyWGl0Eh7c4zpIFc6h/PQLDcNKpBzjjg06A518wfvD92ACTRJIgAnsFGyb
	 JqS2Ahvcsr137m+Bu5MuTXfeNXe6OnsBtBVwcuA6omeRPJhl5hVhGvk2MGeSnczTdqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=90LudhBgjHE3Erm7zcraki1oskq8Rikk/YYQZ5pX5pk=;
	b=Ejap/vc/isEvgsI8/Ct7Q6QpuUVrLWPd2AGS7ElM8/3MUwQjGzE4KDeIkUw3ZzzBdSMf
	 QOoHgfV3nBRy2Vxyt3sR9ZQY14GfhPBMuSiBsTAqnXnsdmGMV0SNLpq3hSAFW/yZRv3Sp
	 MamM/xsWeBBfGX+ufT1Nz5mab0KqzfX5sBT5dF/EaecsHvStTqQAtlNvPID/E9zZQYmbu
	 n163POj81GGg9mVWqdOp97+RSuOL7IfdpEd4kOq2VjLVE8O571qqsU+GhhPoHN2b+bRLc
	 2WQaflTb0/9se1W0qGzpEGXtKpzIn9CBt3rHkahv4pH/K+bi6cQgETgoMTLbtVAT9jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QjxKNnRS;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE58606A320
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE58606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QjxKNnRS
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-84a248254f4so740011a34.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792616624; x=1793221424; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=90LudhBgjHE3Erm7zcraki1oskq8Rikk/YYQZ5pX5pk=;
        b=QjxKNnRS+dz/uMpr1Zi+Cf29JCdgaOW04Tfg+v42fPiKsHW7IsSqmuHYbIBdqA5f69
         yVJMqa2Nx9J5cRbCrRxHrZdtk4RQYikFd3uMs/gpbxYC9xX/4lnSTTclq+QSjMR3KQxR
         AhYa5rJ+zD5aUXVlKF2j08JeTBPGEawzjoGUZUr+IhrpuUgXHTr5MdYpQ1r8KZ8vAwpc
         4qeNUlJzMKGr1QApDVUW0n6V0SRPandDpFFNni8IucKc/R+yxK70rur6ncl1WvcOeYxd
         eahA6yGtadYys7jI7YYUUuB22bmuYJHFuUt22RJF4xkX0O8o6fsLDzlDlxfXz7iFxO2J
         WphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616624; x=1793221424;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90LudhBgjHE3Erm7zcraki1oskq8Rikk/YYQZ5pX5pk=;
        b=rnDO8N2XyVFygOLq4MNmhyTwXvAD0wCP7Xm5o4s8Ad53C3m8lLp+Tw0O69JaKWAu3t
         FD6eb5xUBxA456g/udD5iIlktPT+Ml55QweRgIfarAMPMy3kWNU75p+745Xv0+saktgj
         j0YrKKyslVzN8qp4u+Q85dprBqN+JkTiBNz33rHyXcv47GclmwhEFrVO3R/E2jKtM/qg
         ExF/Q4rdLT+DBqx2Ww2U5Gu6WXCDHmiXTYaJJVoVBFeCFBvSKNixsx9HQbxQsufNGa5L
         H1lICv+ArZgt8WqLsYclbst3o/TJ3SsPjnIi/Qct7vb/Ixwp3d+/z3ppJUgRBzg2Vagz
         ZHaQ==
X-Gm-Message-State: AFq9FYLQ/vtswLT3H2KcRIRlF8ojLlN4wIz9SSIOiUAuXeFlABey/7Af
	ipkDQsJM5Gjia1DQ0RPBf47zjbadKslTqZ+ojXuyVYc3ivkr1RyP5p8lmMo4iDP0
X-Gm-Gg: AYBFou2aDOAiTShWPJ2H+3WaakVtSB9sO8z8VhDA6NYit688gkcb1SMp/kd4ShIQxEL
	zWDNfd9/Di54H4c7wMM9llgfdfgnCrhldAB/zDtniy2Tl5CvpO1f9G0aFKnG0Mpn8No3G/kMMXv
	/sa6zdN+7jw+yRnCppVm8ne6ho54inhHv1l4valUPIleIRYWWvqMwa2ESth9m1BmRh0DB97sQs+
	gYqzpS6QPVG1Ydg1R54Vq9SFNDrfZlTIoaYwfDItvnHfkvmKcUiKcss+aD7SQSJwfMgeE4UuR+p
	kw200jR1MJlU5y5mYRnkGUr+LA5w20ECGAgXo5EBeYS84VXSWXIh8Op/djMQnsRYls/2AnJU9C1
	SvnQPf0h5ePWF/C/hGg7y8XAwkTp9GGAHOXa4LfpsMawI7B45njbpNWPic7tg5Op0CHUIeUuqt1
	YhQdHTrpboHG+84UYnzqS1RxBaUqpyq0g2LHjAicAZD/UDmwOxsg9IOssFwP2tzbDfwAUZfGiER
	ivZxxSoCxLXf5cw+h8gmeEgQuneyIZ/+tP6cUhxgq7b5+JgPVrxiHtMHHIMFokxk7hC6DgXAeyd
	LCDdeHg=
X-Received: by 2002:a05:6830:2b0f:b0:822:27d6:c2ae with SMTP id 46e09a7af769-84d05bc3252mr2883691a34.3.1792616624185;
        Wed, 21 Oct 2026 14:03:44 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.19.225])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cb7b9d54dsm3159285a34.0.2026.10.21.14.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:03:43 -0700 (PDT)
Message-Id: <8f4a8389d0c022de216d1086117fd23d2a8260a9.1792616615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2255.v2.git.1792616615.gitgitgadget@gmail.com>
References: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
	<pull.2255.v2.git.1792616615.gitgitgadget@gmail.com>
From: "Matthew Suozzo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 21:03:35 +0000
Subject: [PATCH v2 2/2] reftable/basics: widen allocation size arguments to
 uintmax_t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Aniket Gupta <aniketgupta3001@gmail.com>,
    Matthew Suozzo <m@suozzo.co>,
    Matthew Suozzo <m@suozzo.co>

From: Matthew Suozzo <m@suozzo.co>

reftable_alloc_size() takes its arguments as size_t, but
reftable_obj_record_decode() passes it a uint64_t count. On 32-bit
platforms, a count wider than 32 bits is truncated before the overflow
check, so the decoder can get a small allocation for a large count and
write past its end. reftable_calloc() takes size_t arguments the same
way.

Make reftable_alloc_size() and reftable_calloc() take uintmax_t
arguments, so the check sees the full count.

Assisted-by: Claude Opus 5.5
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Aniket Gupta <aniketgupta3001@gmail.com>
Signed-off-by: Matthew Suozzo <m@suozzo.co>
---
 reftable/basics.c                |  9 +++++----
 reftable/basics.h                |  5 +++--
 t/unit-tests/u-reftable-basics.c | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index f0442a46cf..6103b72b44 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -44,18 +44,19 @@ void reftable_free(void *p)
 		free(p);
 }
 
-void *reftable_calloc(size_t nelem, size_t elsize)
+void *reftable_calloc(uintmax_t nelem, uintmax_t elsize)
 {
+	size_t size;
 	void *p;
 
-	if (nelem && elsize > SIZE_MAX / nelem)
+	if (reftable_alloc_size(nelem, elsize, &size) < 0)
 		return NULL;
 
-	p = reftable_malloc(nelem * elsize);
+	p = reftable_malloc(size);
 	if (!p)
 		return NULL;
 
-	memset(p, 0, nelem * elsize);
+	memset(p, 0, size);
 	return p;
 }
 
diff --git a/reftable/basics.h b/reftable/basics.h
index e4b83b2b03..29d2b799ca 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -184,10 +184,11 @@ size_t names_length(const char **names);
 void *reftable_malloc(size_t sz);
 void *reftable_realloc(void *p, size_t sz);
 void reftable_free(void *p);
-void *reftable_calloc(size_t nelem, size_t elsize);
+void *reftable_calloc(uintmax_t nelem, uintmax_t elsize);
 char *reftable_strdup(const char *str);
 
-static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
+static inline int reftable_alloc_size(uintmax_t nelem, uintmax_t elsize,
+				      size_t *out)
 {
 	if (nelem && elsize > SIZE_MAX / nelem)
 		return -1;
diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
index c5d83b6714..37bf1ade5a 100644
--- a/t/unit-tests/u-reftable-basics.c
+++ b/t/unit-tests/u-reftable-basics.c
@@ -200,6 +200,24 @@ void test_reftable_basics__put_get_be16(void)
 	cl_assert_equal_i(in, out);
 }
 
+void test_reftable_basics__alloc_size(void)
+{
+	size_t out;
+
+	cl_assert_equal_i(reftable_alloc_size(3, 5, &out), 0);
+	cl_assert_equal_i(out, 15);
+	cl_assert(reftable_alloc_size(SIZE_MAX, 2, &out) < 0);
+
+	/* Counts that do not fit in a size_t. */
+	if (SIZE_MAX < UINTMAX_MAX) {
+		cl_assert(reftable_alloc_size((uintmax_t)SIZE_MAX + 1,
+					      1, &out) < 0);
+		cl_assert(reftable_alloc_size(1, (uintmax_t)SIZE_MAX + 1,
+					      &out) < 0);
+		cl_assert(reftable_calloc((uintmax_t)SIZE_MAX + 1, 1) == NULL);
+	}
+}
+
 void test_reftable_basics__alloc_grow(void)
 {
 	int *arr = NULL, *old_arr;
-- 
gitgitgadget
