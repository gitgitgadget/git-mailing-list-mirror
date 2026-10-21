Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577816;
	b=ggS8bieLnamxs2uF87QGrcumGLMvkodiAb7eaehjHGQOoamIwiIjFMoIeNsertA3DjXa
	 1kpWOk/Il0KcBYWRQBzi6TUI7xvAalnK5NejT4rTE5gdfe3ENGtnc+TuiEG2nXiumPahi
	 DKt+dhyuR83mPwzZtEgssjKaCAAjKuCZaoXprTvnaIuow11Oi0MeRMNrdlaH4h6H1nzY+
	 CxGjS7cnsImkoCd9FRLM9xVAWEC9RDWD8whmGzBF4eKOY68rcaeLxhwzsjfa70zKs3+lS
	 jf7M7kabPCSZ4qWHj5h7cG/EuJyuK0vStb2O51PvK/6CZ7JZi447TgiY0tAsGd7ujiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YB/dY1/JncGppmuxvNSdbjIP5bvqd49CyeqBNY5NcXQ=;
	b=DHlo61lkXWyKGlxm8FQ720wIf5DXuXP9jgP/c6DZ0hFFsf4XFnR1+8bWqMvx7zmsIy8B
	 0KytuWfZCEg2wbBC+e+gYujL8ZOXxHKJVF2ySysSJPY8ChLuWxS16qFqPODQDXtrLI45E
	 j34h1wk5tOZJy/Nzjp51/qZqYDidpfzY/y29n0KG2m40xmX/utWH3bTN0PX/GSB2AkW55
	 TWNAKY8IpMl9qnlJulWSfjywNkC/Vs2VvPorRQRW2PpoRUmVbQAGvhLVar3FRQDz9lmIh
	 bIaLM4wep5zMMYu3d35rozau1GA9dqFG0c7r+jaVLp8YUysVuOAW6Pohw3IURpioH2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FA6R6IZI;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4364606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4364606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FA6R6IZI
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso6800325e9.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577809; x=1793182609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YB/dY1/JncGppmuxvNSdbjIP5bvqd49CyeqBNY5NcXQ=;
        b=FA6R6IZIJgJHiTpZsbGnIOFJQPlb25v/r2rijowU9fIxKFZEOgABWA9x79JMMkvFKT
         1Wt8Ewzq5FMon7g2JJM6H6pZA1uzQeQJWNx/S+VbE+IGrd34fooB/o2wHSqwpFovjdFd
         gA1O3ZGRMN5LmwLDzwlFsrHgsV7D622wb4ODtoNeR8oV0H7sgzWiG0ZlVQWR1B6ow4vg
         CZB/7Dvpps0H6ZDYzxUg8TzfNEY7s3Dg4vmGNNKNj2lXoJfpHnE9M78X62jUJVz9FWqW
         hJuDnnL+P4hHQsKDddccGyyXGuBupzY0tC+hx6248Ww8ZHbL0KWmutTbICsyf4K0BoaE
         DfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577809; x=1793182609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YB/dY1/JncGppmuxvNSdbjIP5bvqd49CyeqBNY5NcXQ=;
        b=xZM2uzanKWTnktEKbOkIq6O+GZg7XSA1v9EzKavFPez2RtChMYeiKyNv//EoJdUK93
         sNBV5XMhCeD0e758iLhqrYGQM5N4Div8CDrjNs5kzv6wLP4r0pJX58zSEKRaBJG+lkga
         2bHTQjxST1FpplHmnQK8lwZJIOXQMyR6HoEx9bkZoavXzbG5lQFH1vd6fr6oC3juejEV
         0mB2cslXUkEYfDddLVoCFMccbikNjiucsq7e4BURGAJY2SCuHTMwPoHBPgbzSAKz7bqS
         eVP/2PBna86LctEbvgxhYkyU2TxUrymTMA4t0r+KaX549KbJBFwPeN40lD0LiVuAFyBl
         uRzA==
X-Gm-Message-State: AFq9FYKvJ5Vv4wA6A7kXWR/YInXN2vig2QQxN1mlvCGIZ9JrtQrFqYzd
	nvjtSOS+HesVxWQf8dd3BnQuEKX3XCHPXRU16gC8v606IaE14AbYj9v9ku376qvb
X-Gm-Gg: AYBFou2vsxTrI90cpcvXBHu9K+VCYSbTMuzb2d9zT2AGPwet7st/uc7bpsKxAc+vW3I
	ZuEj3aH5I0z+kEKP5S4t7r6L4SD2/SphsLjnAnT+llQEYu4WQOssu9XR36VPPzejamHCXh+QyTa
	KRnW+AelIQVyo9kdOICZB+QHb5O4mI0TM6DtnKx1DZOFc/6RI8vJMtZmCkOzKzlLViVLxlforaV
	yZLoEqM2FGXnpndOOqmfQ5O277EUh2+OQJHAlLiIPWMjdOR2sox7GE70jSd2Q5tBM4U1ctw6pQ+
	3eohIbOO5E4VAJX6+vVeehKo1J6Y8Mc/8mV9fB39AeWXp4+mJoLK3ArrkEQV0B5+lfZZksKEDGg
	S6ZFkd31RkfrAaLtPOuMhw/J7YdAH0k71yLow8/wSMTX57taL464NyiXk9ek37vlzkoCz+SowMr
	zv0erC0nUm9fOOjQ8Ci9ll46TkIYLZ6ygjexS4YHTAFNFR05ZiJ4d860NHkwdBHuPBGumM3mIBq
	QfYcb/onZ/d7mbBIGRg9mamRytNlfFOmm002HFfhsh7/4FI4UkJ0BaYOt/jV79EqaT2b5RFkUNu
	O8eIAbeIFeUW
X-Received: by 2002:a05:600d:82c1:b0:4a1:ef9d:1b68 with SMTP id 5b1f17b1804b1-4a1fdd246a1mr32070925e9.10.1792577808859;
        Wed, 21 Oct 2026 03:16:48 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.28.1.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258427cesm4472602f8f.52.2026.10.21.03.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:16:48 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shuqi Liang <cheskaqiqi@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH 3/3] convert: use size_t for buffer sizes
Date: Wed, 21 Oct 2026 12:16:39 +0200
Message-ID: <20261021101640.329990-4-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021101640.329990-1-gitter.spiros@gmail.com>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
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

