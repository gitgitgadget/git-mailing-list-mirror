Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397721883E
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684199; cv=none; b=Q2fx/YEiudEOeYW73EUpM53ix5QTU+qtOzU6GU5cDal6ghkzPFlh4CR0yEx+QOQ2Uv3iEsN/DHhW3chQw+R3zloQiFzp8qW393U1Tyz6pyogLcO5GJOuPJmTCbEtzNTlqZO/jyeFDSsfU6wLohDslhaF6l93fpR9Zg+m/8zh2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684199; c=relaxed/simple;
	bh=Ok/4E6SiEjxsQGSkw4lhLuSqLzW6cPDYzkJpKtXDctI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qx1ATyHPB5PXA2wz3TWWbNAi1pdAGprtz5WunpQ29CgKd/Y2kuTBWblz1UTy+vUI7ut3XLdGoYj2MZW1bOO4lVAiXRpTRCwszT9xinNrziccOjaicn425FQ9tX1BaGYQr4TblZQxxrM222iG0uY3C88YC6EO9uHiW7DSvqgIcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG5OLwry; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG5OLwry"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cace91f112so2767095ad.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684192; x=1788288992; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VU8yuVhDeJuZIfeWaLIYtUBg9gCORCCUsaBPGSHLv/0=;
        b=hG5OLwryt0NysDg5IClIo4CFY37OdV3Ysr4SCiS0HyTIIxQBlQYsgNxpkdqy1DZgcl
         jO9aWD4IV+hbsYPbi94Bbo3MZPeNSP3j1gkq28kVeLykDPg8mw1RrvXxWbTojSTjqAcb
         29TNg80pd0hu7OZvwVzumdt4zfZtAxAndUFpFB7gniH+PKHHPV4LztDjwKVgPTPS1YWH
         8DufOoOD4Zq2G1lMWF4EUse4CVtnSxWcpV6rNliig3NDNxNKyVIYV5v2ueEdVyCPaeks
         Lw0WdZwCf/7OvNFsX72JiQ5kwBoatKbXkpLUYBrc4TeSLft0jtJiMzGOzmXHU7659h9L
         9siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684192; x=1788288992;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VU8yuVhDeJuZIfeWaLIYtUBg9gCORCCUsaBPGSHLv/0=;
        b=tYasFA0scMrmwYV08dE8xXJy4B4eKbOOegyYQcaW0JwWTSIcEcjj2kfo2qdcRyS84t
         d6yodcchKhfpj3bCrwbzVBvJUrYIML2g5OsW27UpBqgjr/o/Zln2YToY/Obh9NKd8L6t
         0sDbGcYbIn4CkeW8jvnVx78ozjoPDT1S7lTy2bpT7yqPBs/ypwxxeH4IBU70gVOahuac
         pl984DqgiNHxco3/DHs+7K/sEhb+VZADN/5zLljW1SFT0Ll4q7JSOUhiklYD303pVvIv
         2We7pc0mQzuk2NRHw6KwtxmwRIjom/1kaReHa+jcBxFVuZ84A28+y9Zaxrl21dvN8QOp
         qmEA==
X-Gm-Message-State: AFuF++mkmDvwbOLDYG0kuj2FsIazepgPal6h1jM8gmU9OZox9jxsZVKu
	N4aSmIii6zQiJEYjFF0p/aXGN83LwWBVIQ9uJyDj1O/RySoHavTX88UN7snvXpaN
X-Gm-Gg: AR+sD10xNqDkhjQVqZ0Gs/L61CIf/ERNbuiT1NGkstm9vjUQFrf7b48GPa9qoXTJ1T3
	cfZswIpl716bDvHw2ejpI8nlOrp+qoGY6mg/I2Ez5Ea57uZmINo61gXU8zqab+/eGB6IrxneLgw
	th409nLk2icE2hHptYACO8N28sn6zOM2LFr798c7+NsBuAjRNDw46l5FT1lO4cRXIwsw8Y9qOh9
	q+16O3PKrfEX5VI8mvpS+Cq7CUuIjtcWQd2WbWlQvDiUDUpw0BzgpGZV50T2DzeIm8dtf+2ptu7
	f267xiJnuw+/qMIo6B1cjCtMJl/G7zEFWe+OgM4TcBzDmrp3Rn6Ih63A/PLWO1HGNd7lZGQXPSD
	pzUKK0O3JYECoURozRm2a0AzemxJCNlrSynjpjpP49xTJ1VaxKpFkUi/H6BXfwaA82fSA5BUiHE
	4DFj9YggDLrwmUlPCpj4sTacDKxk0KQJ8L26P+a8Eeri84Hzb8NvttRHluFe/2UZvxMmsWmAQiT
	w==
X-Received: by 2002:a17:903:19ce:b0:2d6:f6ba:263d with SMTP id d9443c01a7336-2d707aafd1fmr6321285ad.7.1787684192478;
        Tue, 25 Aug 2026 11:56:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d884d5esm955863eec.17.2026.08.25.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:56:31 -0700 (PDT)
Message-Id: <120cf1967bde4e719a781c391b285c718553ad58.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 18:56:20 +0000
Subject: [PATCH v2 6/7] trace2: remove use of ALLOC_GROW()
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

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h     |  3 +++
 trace2/tr2_tls.c | 34 +++++++++++++++++++++++++++++++++-
 trace2/tr2_tls.h |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/banned-die.h b/banned-die.h
index 14aecfdc7a..423e7b607d 100644
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
index ae2d39d2f5..8596292a94 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -108,8 +108,33 @@ void tr2tls_unset_self(void)
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
+	if (ctx->nr_open_regions < ctx->alloc)
+		return;
+
+	if (ctx->alloc > SIZE_MAX / (2 * sizeof(*ctx->array_us_start))) {
+		ctx->nr_skipped_regions++;
+		return;
+	}
+	new_alloc = ctx->alloc * 2;
+
+	new_array = realloc(ctx->array_us_start,
+			    new_alloc * sizeof(*ctx->array_us_start));
+	if (!new_array) {
+		ctx->nr_skipped_regions++;
+		return;
+	}
+
+	ctx->array_us_start = new_array;
+	ctx->alloc = new_alloc;
 
-	ALLOC_GROW(ctx->array_us_start, ctx->nr_open_regions + 1, ctx->alloc);
 	ctx->array_us_start[ctx->nr_open_regions++] = us_now;
 }
 
@@ -117,6 +142,11 @@ void tr2tls_pop_self(void)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
+	if (ctx->nr_skipped_regions) {
+		ctx->nr_skipped_regions--;
+		return;
+	}
+
 	if (!ctx->nr_open_regions)
 		BUG("no open regions in thread '%s'", ctx->thread_name);
 
@@ -137,6 +167,8 @@ uint64_t tr2tls_region_elasped_self(uint64_t us)
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

