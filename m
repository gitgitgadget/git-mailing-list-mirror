Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441806;
	b=dcZQqyPxZZWBgQlnxiseXzaDkp6VXil1dmOktBWR/VbgDl9co0AM4bGNqHAr9+9lDzjU
	 C6gp9mIpFYixBm/ahiKhBQFN8rqOPCSXyeIsIRwbYP1mD9n4cGemO6iGlkgEfgY+DiCye
	 nhuLozAlz4Cw8essrSn3F5UNvTUsPfkhlKaaH5snUiiGF1eAgIap8RIJ1tIxtyQhTFuXT
	 WjW20cAVTTUNsoPoqifNfT8vCdo2kih5J053BPtv1zA6iONHeDdjpuID13xfSOnwhcCWn
	 K70zk1Bu9asUH6YQVKqHVy/hmuYIBN9iNk82Jjo2e2Jvisz0XJPym5UFyE7CwILPNtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YB/dY1/JncGppmuxvNSdbjIP5bvqd49CyeqBNY5NcXQ=;
	b=iTx14pFKzFwMZZ03EI6GeGPqZ4kRN7lJqS8XkAO2c0V1mzb4iv/WRAmvx/0FT26/nHFu
	 pJ/a91thganYH0diPjEOCVmOswao0+iYED6+CJw20NW++e1LPhj9lYxl4EmKDaPpgSn5B
	 e9IDWCKmO3BGkXbkvCNSTrDxtoFGBkjdtHJITGWEuDwNRC6OEgYVN1OQgXLqm0yxoERPm
	 C/ikBF2Rxpk/4Hf1fnJ5tnHO03mciQkf7B07Bu9zRV0t90BY0N6hsS415LrK2xaD1PCQO
	 SVS1RDO3dlj+JSQ1AdYKVH9iN7b6Vyk8u/dkZgxY9n6VkxTfRcp+Bx/dG61/TBBTEYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t54zs3Ek;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D177B606A32C
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D177B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t54zs3Ek
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so9098695e9.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793441804; x=1794046604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YB/dY1/JncGppmuxvNSdbjIP5bvqd49CyeqBNY5NcXQ=;
        b=t54zs3Ekt2FSD37+c5XYPEbEAlE5r9THVxN0MYsyNavDWcscX4xLQGcXhA9WWCekH3
         jT9HOneOFjIF8G3hwQgQNJSOxKRrrkn5+HSTVTHK9zGWJGwOoY/LJCiP8yDbQUnubClt
         kyBksfdfwulQCVJ+sQN43nrWTt3IqYwRJkaMCCNh+QQZPcu37DWG1tRtWEOmspC0mPG0
         Kjxz2z458QXMfROqpjDuC4H0TWF8nYkXbuXLXpX8NgZDiQJVJYYcu9/FmXfKyF8E+9Dl
         CYQ6sN6JUxpMzgKVXUkIO7w6Q2Rj3G+P52EsOQiA0mKp5Q6SbWm8GATd1BKHxHKKEKPT
         3yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793441804; x=1794046604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YB/dY1/JncGppmuxvNSdbjIP5bvqd49CyeqBNY5NcXQ=;
        b=ELhCNW4Bl0pBDQaKPNwuMSwRccAGVe9MoyWXLAKU7ifKIXsUw7rLgdIZ1ttLA43go6
         eNDgc8DTKfQJ0NH3va8jl0Wpv5rZoEXxulVqjU1HKegk8whSxVnEyNIgovC2GBQ5qT2v
         d6GEWZEqfjQ9zaJa3R23FSwokfmERuNZM1/WlErrJtaWEOa8gGveZGiM/F7byr+pw1C5
         CZOUS5kV081OlhgbHKJYHB0fORblPVM4rSvhgGqZXDIVVU3+JQZenm+BiINBIr+ub5+X
         PzJNTfzdYCu+ORaEV/YLkugJ1h0ymziJTjBCmVxdcV/z3sJJy4Wc/stxl1f51fH9sgDq
         uLmA==
X-Gm-Message-State: AFq9FYKMpAlmUv9oVWkXWKPArBzZhG+AeA2CkZfDvl2PvkMcn/xafoLj
	H05n6t/C/nMmrVrgXdLqA36NIiyNXuNHLVQQ+vRWbKNCRp3lM93P523hoyNW7O5C
X-Gm-Gg: AYBFou2NCiFJhnJA1ZKYOGnMCga8f9MbWyri7mcjqCHNU1nOEa3lQZ/BGUyi05izMOR
	RabUgKoK31NzmIUPsNOhJkBkJa8vgOWk21gVU45u1Hod9EewA/+JjqGO3J6l8ZrX4TBAle/5yzM
	n3W0IZK2Z4XS1wSrQ1E8pLVS2mBP5vUD1lXJBF+IZI2x+VdqlEp1aU5ZnVJHiteJ6sU1X4/f8Pj
	92zA+heGctwoM9g9rt1Sq33UX4k3NeyjRf5yyHCbsJtCzhsGcG08jKndjJJmcmnYycDPDvLFK3T
	VxgMG7T0yC1IDehiasr9TCDeYJDV96hFnaTgeHJtsy+zjNCAUuGJReeN92l8MYXlTlrZiQ1BuLg
	og8laS1xZ1RMs/aYoD81obDuVIvHkXzhu3YJ27lq8aRvd+84d27o0P+ZxcI8FX+QVzcaejn6qca
	TW/+GBxI+YQ7dd44IseHSkY404jKYazZKj+LARqrcuARJQkNubEjsR8rx6mlEN1+8vvfa8ClD7o
	pujNXUG6X9MNkjuTPuiGlLB44VAsytzbl07DcgqQTCqhy0R6HiHvajw1La/lHCmuphRGS37CeCx
	t2qx1wUjmXqe+3z/DkgoLwQxt/p0J9LWPCJZYchoMZX4efcxuS/VG3mqaGwpVJE=
X-Received: by 2002:a05:600c:37cc:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4ac1980143dmr91301815e9.35.1793441804151;
        Sat, 31 Oct 2026 03:16:44 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm127220015e9.6.2026.10.31.03.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:16:43 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>,
	Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v3 3/4] convert: use size_t for buffer sizes
Date: Sat, 31 Oct 2026 11:16:34 +0100
Message-ID: <1617177880b7cbde051bc4295f1fbd6ea2be457b.1793439137.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793439137.git.gitter.spiros@gmail.com>
References: <cover.1793352943.git.gitter.spiros@gmail.com> <cover.1793439137.git.gitter.spiros@gmail.com>
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

The conversion code receives its buffers with a size_t length, but the
helpers that scan them, gather_stats(), gather_convert_stats(),
gather_convert_stats_ascii() and count_ident(), take an "unsigned long".
On platforms where that is 32 bits wide, like Windows, they only look
at the first "size mod 2^32" bytes of a file over 4GiB. The decision
whether a file is binary, or contains CRLF line endings or "$Id$"
keywords, is then based on that prefix, and we may convert the line
endings of a file that is binary further down, or not expand keywords
that appear after the first 4GiB.

read_blob_data_from_index(), which feeds has_crlf_in_index(),
get_cached_convert_stats_ascii() and the reading of .gitattributes from
the index, gets the size of the blob as a size_t, but hands it out
through cast_size_t_to_ulong(), so on such platforms "git add" of a file
whose staged version is over 4GiB dies when core.autocrlf is in effect.

Use size_t for all of them.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 attr.c          |  2 +-
 convert.c       | 14 +++++++-------
 read-cache-ll.h |  2 +-
 read-cache.c    |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/attr.c b/attr.c
index 0e63f1b6de..1acb4ef430 100644
--- a/attr.c
+++ b/attr.c
@@ -793,7 +793,7 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 {
 	struct attr_stack *stack = NULL;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int sparse_dir_pos = -1;
 
 	if (!istate)
diff --git a/convert.c b/convert.c
index 036506842c..ca5594cab0 100644
--- a/convert.c
+++ b/convert.c
@@ -42,9 +42,9 @@ struct text_stat {
 	unsigned printable, nonprintable;
 };
 
-static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
+static void gather_stats(const char *buf, size_t size, struct text_stat *stats)
 {
-	unsigned long i;
+	size_t i;
 
 	memset(stats, 0, sizeof(*stats));
 
@@ -102,7 +102,7 @@ static int convert_is_binary(const struct text_stat *stats)
 	return 0;
 }
 
-static unsigned int gather_convert_stats(const char *data, unsigned long size)
+static unsigned int gather_convert_stats(const char *data, size_t size)
 {
 	struct text_stat stats;
 	int ret = 0;
@@ -119,7 +119,7 @@ static unsigned int gather_convert_stats(const char *data, unsigned long size)
 	return ret;
 }
 
-static const char *gather_convert_stats_ascii(const char *data, unsigned long size)
+static const char *gather_convert_stats_ascii(const char *data, size_t size)
 {
 	unsigned int convert_stats = gather_convert_stats(data, size);
 
@@ -141,7 +141,7 @@ const char *get_cached_convert_stats_ascii(struct index_state *istate,
 					   const char *path)
 {
 	const char *ret;
-	unsigned long sz;
+	size_t sz;
 	void *data = read_blob_data_from_index(istate, path, &sz);
 	ret = gather_convert_stats_ascii(data, sz);
 	free(data);
@@ -223,7 +223,7 @@ static void check_global_conv_flags_eol(const char *path,
 
 static int has_crlf_in_index(struct index_state *istate, const char *path)
 {
-	unsigned long sz;
+	size_t sz;
 	void *data;
 	const char *crp;
 	int has_crlf = 0;
@@ -1077,7 +1077,7 @@ static int read_convert_config(const char *var, const char *value,
 	return 0;
 }
 
-static int count_ident(const char *cp, unsigned long size)
+static int count_ident(const char *cp, size_t size)
 {
 	/*
 	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 066dd8bc3b..d279059b5f 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -416,7 +416,7 @@ int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
 int index_name_is_other(struct index_state *, const char *, int);
-void *read_blob_data_from_index(struct index_state *, const char *, unsigned long *);
+void *read_blob_data_from_index(struct index_state *, const char *, size_t *);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a3..635dad1ba3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3472,7 +3472,7 @@ int index_name_is_other(struct index_state *istate, const char *name,
 }
 
 void *read_blob_data_from_index(struct index_state *istate,
-				const char *path, unsigned long *size)
+				const char *path, size_t *size)
 {
 	int pos, len;
 	size_t sz;
@@ -3503,7 +3503,7 @@ void *read_blob_data_from_index(struct index_state *istate,
 		return NULL;
 	}
 	if (size)
-		*size = cast_size_t_to_ulong(sz);
+		*size = sz;
 	return data;
 }
 
-- 
2.53.0

