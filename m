Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74F4AE8D2
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197155; cv=none; b=i/+pAaUCTeUGo+mjZWKls4+zdsw3G8SQ3SWTYWVys66FV4OKAOSy95V5B9uPk/jJsEmp2OwW1uenAiEKlkpG6HuwrYVLd176+k+rgUmRucv6JcZAqWCO4SXuyKWspSE4pd9VvVSdoT8OLQqdZYy4mflLzVTIFPgam5kp67viZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197155; c=relaxed/simple;
	bh=PcnJe1hxWFYhSx6tsxc5lVoLLy8++5c6Ua24+BmcUK0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fDULfetNvDnL0JIolgyCgNsB7eUuB06vcznWs3MHm21hvnLUy9xadeQdjC+H6zq9kR4cOtO9iSgP8VazaNlloidvxZ56SNZ1clvhbNrTIVl4a5DDWrbllVvDmsyZcdmz+xV03d1k+b1AS3aE9nbLm8NYyxmGoMV1KaKSDEcfuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcuaH00b; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcuaH00b"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92ea24a2dbfso382104085a.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197152; x=1788801952; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rTJpEcWR1dDJPn1JJP45z8b49q3IMI5p2yZF+XSUBV0=;
        b=LcuaH00bWs234MTE5phlxe3RNjDWRyjiHvbxjy/9R0kUUf34YAiI1or8K8jwbxWb3h
         6bNGKFROKB6RYvRfZ9tNIWwFHsxEGv436LCIu+ywiB4hljhAfUqq93L7dOus2sAAktxj
         vlvYCr+RQ5JDQ9qgAD/1Phadt7SW0oExGfBnVkZ+v/Nq9OcYOxQyJkYtjyrkA9KkSuCN
         rbOIRtCjIlLBzv2FLJexz5yUGD5aa6ga59O2AdxmK9xB9y9pDvPWWXgLfSKV5OLlZzYN
         dIPB53SbdHMIG7bYO5vgwHtMs4tfsIA5N4FPKLTXsGSF5jDkb0qatKAhY/Ju9VxitM7j
         jvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197152; x=1788801952;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTJpEcWR1dDJPn1JJP45z8b49q3IMI5p2yZF+XSUBV0=;
        b=K/cy6q329m/eXXf7j27VgE0WrFuDS3Emcj5QCi+yi535zK+hWHNI39383MozD6cmkZ
         TfVX2JqMJqKmNG9KDnuPcR5tUkxAhDSNlXGk4674XX1yuiWoMPvmvOdL8yzKl2kVakbr
         wY/BeoVKsoWzphuXU6yNSXbwMT4y4UBg4MLPKRpFc+WYCP5RWZLSk6J19rPlFg8hODr3
         nK2cRBZaBXuDaiv8rIPxs6LBbFInAuloKyZu7d1Ak+ZJZoTcEsiDMQp/jC8EUSx2/Nrj
         NlpPqnu60+J7KgJGl0kRBJOwwpDIoj1w3Sm3v/QYRASxgUxcdLH/UQds2gSaeHcP4aVG
         SBng==
X-Gm-Message-State: AFuF++m1P2N6ZVsGt+YeN+n4g94O2oN+RFBenfSEucw+lWpPrlfRGDCO
	54bJg6Evy9Ret6pujbIBuD20+YCQK1FqmvGmwWQ3LnnmheaIPGc3dA+EVafUOwxd
X-Gm-Gg: AR+sD11N+HnHJ/HJ0heHorLfrUwG35mxcMEoyZdBSuG76loPtDE7zS21IAdMPmcQpLW
	KXld43eOuPZ64YoLC1SzPybG+xrETr2bSg2tCEca5KxW7iUMYOW4kZyaC41dI69n0GD1TDaSRuj
	3ywByLbfZ5FlVQuk+lR4b5Dd7AH9T8snZIKGMwlasLcYOrXGdAvePZCKw8Porsd/w9hOMHcAPOe
	tWMyDd07lKzNo6QD3+mWNSQGJFMXigPS4iXfJBuxwM0ipQQKmTpFc0izYCg4m5kwgibzCv0xUfN
	oTCMaicztD9m5z0CrVeMyIJXFMWMQRXnMedAe5gQpIdD6ma7vVQEaRjW5oMia+oNyqfBgLWEXRx
	Z/ozhs2b2I4jSA/3RNOpglcqrec7bZIb7of7YS9SRZpPNCXMOZtKpDA+w9w/rFglSNgsB0f2Gxf
	DAWQDLSQSSOvEYP7bSl53LCIiaFyS30IQAVoecFm5mqUC6baZrx68c9KOS8InFbbK9
X-Received: by 2002:a05:620a:4788:b0:931:328:fecf with SMTP id af79cd13be357-939138ffbe0mr2564955785a.26.1788197152544;
        Mon, 31 Aug 2026 10:25:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939170167fasm839701785a.8.2026.08.31.10.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:25:51 -0700 (PDT)
Message-Id: <ccd284fbebcdc43812948bbd8b2d413dbf2b260d.1788197143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 17:25:42 +0000
Subject: [PATCH v3 6/7] trace2: remove use of ALLOC_GROW()
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
Cc: gitster@pobox.com,
    Taylor Blau <ttaylorr@openai.com>,
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The ALLOC_GROW() helper can call die() on a failed memory allocation.
We need to remove this from the trace2 API code to prevent a recursive
die() handler.

This helper is used to track the nested region stack. Use a new
skipped_regions member to track how many times a region was entered
without being added to the stack, and decrease that amount as we leave
each region. This allows us to avoid a failure and instead stop
deepening the stack, giving as much nesting behavior as possible without
failing the entire process.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h     |  3 +++
 trace2/tr2_tls.c | 34 +++++++++++++++++++++++++++++++++-
 trace2/tr2_tls.h |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/banned-die.h b/banned-die.h
index 4d1800353d..cff1072397 100644
--- a/banned-die.h
+++ b/banned-die.h
@@ -23,4 +23,7 @@
 #undef ALLOC_ARRAY
 #define ALLOC_ARRAY(x, alloc) BANNED(ALLOC_ARRAY)
 
+#undef ALLOC_GROW
+#define ALLOC_GROW(x, nr, alloc) BANNED(ALLOC_GROW)
+
 #endif /* BANNED_DIE_H */
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 49bd505d62..5e4624d0b3 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -109,8 +109,33 @@ void tr2tls_unset_self(void)
 void tr2tls_push_self(uint64_t us_now)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	uint64_t *new_array;
+	size_t new_alloc;
+
+	if (ctx->nr_skipped_regions) {
+		ctx->nr_skipped_regions++;
+		return;
+	}
+
+	if (ctx->nr_open_regions >= ctx->alloc) {
+		if (ctx->alloc >
+		    SIZE_MAX / (2 * sizeof(*ctx->array_us_start))) {
+			ctx->nr_skipped_regions++;
+			return;
+		}
+		new_alloc = ctx->alloc * 2;
+
+		new_array = realloc(ctx->array_us_start,
+				    new_alloc * sizeof(*ctx->array_us_start));
+		if (!new_array) {
+			ctx->nr_skipped_regions++;
+			return;
+		}
+
+		ctx->array_us_start = new_array;
+		ctx->alloc = new_alloc;
+	}
 
-	ALLOC_GROW(ctx->array_us_start, ctx->nr_open_regions + 1, ctx->alloc);
 	ctx->array_us_start[ctx->nr_open_regions++] = us_now;
 }
 
@@ -118,6 +143,11 @@ void tr2tls_pop_self(void)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
+	if (ctx->nr_skipped_regions) {
+		ctx->nr_skipped_regions--;
+		return;
+	}
+
 	if (!ctx->nr_open_regions)
 		BUG("no open regions in thread '%s'", ctx->thread_name);
 
@@ -138,6 +168,8 @@ uint64_t tr2tls_region_elasped_self(uint64_t us)
 	uint64_t us_start;
 
 	ctx = tr2tls_get_self();
+	if (ctx->nr_skipped_regions)
+		return 0;
 	if (!ctx->nr_open_regions)
 		return 0;
 
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 3bdbf4d275..c365017923 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -20,6 +20,7 @@ struct tr2tls_thread_ctx {
 	uint64_t *array_us_start;
 	size_t alloc;
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
+	size_t nr_skipped_regions;
 	int thread_id;
 	struct tr2_timer_block timer_block;
 	struct tr2_counter_block counter_block;
-- 
gitgitgadget

