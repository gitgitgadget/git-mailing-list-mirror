Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793445020;
	b=mOaiCr1+gzvGAqP5dh4+f0m9+Le4UvWixvzG54eq0kCBDeqqV6pYpQJ4AnYDhEfcWSaJ
	 EAcWB6JWaNvt0AVfDTG1WAe68GBXttCHC+5IM1exeF5V5zJ+jPUdCvYlfaR0DzK7mJ5W6
	 z9WJ/owECTNDZO12zHjfSYahse2S9PZ0KXnWUZVGOe/sTeOTAY7XEPpDEfhhQDRyaLNv+
	 v276N+wNzaWmKXr5xat0BDZDsnGsUYMiWIF1DzmP3GbEOus0yXedMte4wGcXQY4bl5j0U
	 6VEpEsTlMDbK3UJWqk7SnwnOP+KhzX4dgIlT/XzaRMWlOnVo18sdCZD0OLn8ykH6ABg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793445020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ruN9SwKMCeWi4P2h4crJvqsSSduvL1LIQiEC0cMygOw=;
	b=SwHcI/aNwi3POORRARuPTZzKIyiMXnMc2KsAGdMC/5ph/Wo4xhJt48VZ3lP1LlRbRo6x
	 N6iR3EVsyZHUNiToqlbsCrCYFtV7jTpRsXQtCWmnPUPWU0Cm8QOLIOwFThOe6gfflxHpV
	 9T7VqwNjWs9Q3R3ee/j7Pmx081+iwIUAfN+imE9kXn6oY5EYBhhQDoGoAY7G1HySmCS/N
	 edc7RkveAXbl587qdysOb9Ax6Sklssn3hLIR5tsKvqB3omF0Vau9MfTO26tEeC0EP0T5O
	 DCiA/+5L4TuUsHpG6rk5SMA7n76JghzPJcAZuOYneLgqlDZ4PfRjYdhA+O6fZwyHnDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xZ0gsrjk;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B782606A31C
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B782606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xZ0gsrjk
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e46e449e8so978555f8f.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793445019; x=1794049819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ruN9SwKMCeWi4P2h4crJvqsSSduvL1LIQiEC0cMygOw=;
        b=xZ0gsrjk6INF6tSiQbMTQB2Ef4IhCty8HRIW32hDAG13T07Dmi8nNRwqX8kOuWPjWs
         GJjkKKQCNhoSsLNbuJPvBcU/5btJ9ofoeIILYwvn3n39Yg1WuL2YZhNZDlXM3KDYcWq+
         J/3BqTtGVtvEzYIVlTsONNh3wYXTYJtE25Pck1f1i00VXfzzCEpmR9sBP5+NQCRHM/9j
         4K2VZSxzDOInKwe6xcEvTpYqutXgBEDbCsmPrxBLVVjle2MtlThfWG4npmfom03BEj9+
         tjxDac1BQyooLWJ0u0JAphLlmAwijisKaBx6P+iET3+uqiIYW3JCieZ9fQeV9LYjeTKt
         bV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793445019; x=1794049819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ruN9SwKMCeWi4P2h4crJvqsSSduvL1LIQiEC0cMygOw=;
        b=NhwquKszZ0ic1K6FNmXzlafyegBbcmCNDiHZ+XfOtkG9z7E3A81MQxs4ydwH4FpdJ5
         am9zKml50Wq/ONX2uZG15y3S/8gxx2+LO5t6dzU4PiQafUxsCslPYm0tMDmZ4F5G5kqi
         PT0s7nMAHsBdrkVggY46wZ4wuz4VheqaEll8KO+AuZi7cadiPh7F2J5S7ewRuADu0FFx
         YduQgC26q4kX9gUpHkpWktf/MkuELarBJEOd+3mqrv8LZ3MJMrX++k9IhH+xKfJDrDb4
         qWfIxwz3lR7ocXOL1o/atAnolJHZFulM627TSGWAFogKv7CHmaomJ3fAXHNpv7qOom1f
         JwjA==
X-Gm-Message-State: AFq9FYJAA1UofGyy6qum/xEUGe0mp/nXqfO/xm1DN1RctF7ho8vBHTfv
	o9/CdUSA82ahtsJxj2yPS58HmNnRmjJeD+Wru5hr9HcHSHCRa7176WSDBU0ba7TG
X-Gm-Gg: AYBFou3OrKYETx+FJ95L1Cs3QO8dJhhVeAF6RowMNrqVYWcsuUxfonkrOVgdG/6rUFI
	8SG+5Zks/RhhYr4Uh9KRiPRursJmHGMZ7PsqQ3qALDKrvC0x35maie/cZ+sYeXy3+a/HwTaXr8c
	taSTVZ7Es4KQd9REWzurMPC5SfetSHETGMECqTwb5/wk1ZZUmFnOExx2lFL+FnVLUFjyET703Uu
	89rmTW4gfVEFcFJMDAxey7lQJqGjFuYr8TYiDSdnW8nbmT2QiULU7O/y/EooSb7HRvvBVlHsHwb
	nG5KQZvFYZVmd9jIaQB/97lBsN6FIodb58dZOkHwcpOoFxeDL2z1K2yonyLDapcq2ssa9ABfYJk
	wHO/YfrXneZ/hvSUZiq1l33hxp8hK4H1WNQsFBXVcFuIHyJs3f8ewmEww+ObAUJXNdNWwn/HxTC
	H0pgOG57Z9Wc0vcqhiq2oXT5W9pJqe5+uQ4f8Dnb4arMPSQdyAxdQyAru3IM66aMyn64T8Z09rg
	+fCGfXRKhChzkNY8Ta7WM2cdz0C20m0yoMxGMLLFI5kg+qmCbbmjAAo9n0m2gq/WqSynYGE45ux
	MC3T2w7vtZAdPNUd6LB1sqPID3vfwFyAJ9ahtfix/CHW5n6zh/1DTpvsEcJqons=
X-Received: by 2002:a05:6000:2603:b0:48e:6852:aea0 with SMTP id ffacd0b85a97d-48e6e526830mr11130016f8f.48.1793445018377;
        Sat, 31 Oct 2026 04:10:18 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm8853670f8f.55.2026.10.31.04.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:10:13 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/4] fsck: use size_t for the size of objects to check
Date: Sat, 31 Oct 2026 12:09:58 +0100
Message-ID: <7551e796e7d27fbe3a6710801adce788bdc17230.1793444420.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793444420.git.gitter.spiros@gmail.com>
References: <cover.1793444420.git.gitter.spiros@gmail.com>
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

fsck functions such as fsck_object() and fsck_buffer() take the object
size as an "unsigned long", while some callers pass a size_t. On
platforms where "long" is 32 bits, this truncates the size for objects
of 4GiB or more.

When checking large objects on those platforms, fsck inspects only a
prefix of the buffer.

Use size_t for the size parameter across the fsck functions and internal
helpers, including the loop index in verify_headers().

Some callers and pack verification paths still pass "unsigned long" to
fsck_object(), and fsck_tree() passes the size to tree-walk routines;
those will be updated separately.

Triggering this requires processing 4GiB or more of input on a platform
where "long" is 32 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 fsck.c | 18 +++++++++---------
 fsck.h |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index 94c8651c7d..7b0e9a5892 100644
--- a/fsck.c
+++ b/fsck.c
@@ -614,7 +614,7 @@ static int verify_ordered(unsigned mode1, const char *name1,
 }
 
 static int fsck_tree(const struct object_id *tree_oid,
-		     const char *buffer, unsigned long size,
+		     const char *buffer, size_t size,
 		     struct fsck_options *options)
 {
 	int retval = 0;
@@ -826,12 +826,12 @@ static int fsck_tree(const struct object_id *tree_oid,
  *     case hit the newline we found here as the end-of-header. This makes it
  *     OK for them to use helpers like parse_oid_hex(), or even skip_prefix().
  */
-static int verify_headers(const void *data, unsigned long size,
+static int verify_headers(const void *data, size_t size,
 			  const struct object_id *oid, enum object_type type,
 			  struct fsck_options *options)
 {
 	const char *buffer = (const char *)data;
-	unsigned long i;
+	size_t i;
 
 	for (i = 0; i < size; i++) {
 		switch (buffer[i]) {
@@ -948,7 +948,7 @@ static int fsck_ident(const char **ident, const char *ident_end,
 }
 
 static int fsck_commit(const struct object_id *oid,
-		       const char *buffer, unsigned long size,
+		       const char *buffer, size_t size,
 		       struct fsck_options *options)
 {
 	struct object_id tree_oid, parent_oid;
@@ -1010,7 +1010,7 @@ static int fsck_commit(const struct object_id *oid,
 }
 
 static int fsck_tag(const struct object_id *oid, const char *buffer,
-		    unsigned long size, struct fsck_options *options)
+		    size_t size, struct fsck_options *options)
 {
 	struct object_id tagged_oid;
 	int tagged_type;
@@ -1019,7 +1019,7 @@ static int fsck_tag(const struct object_id *oid, const char *buffer,
 }
 
 int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
-			unsigned long size, struct fsck_options *options,
+			size_t size, struct fsck_options *options,
 			struct object_id *tagged_oid,
 			int *tagged_type)
 {
@@ -1182,7 +1182,7 @@ static int fsck_gitmodules_fn(const char *var, const char *value,
 }
 
 static int fsck_blob(const struct object_id *oid, const char *buf,
-		     unsigned long size, struct fsck_options *options)
+		     size_t size, struct fsck_options *options)
 {
 	int ret = 0;
 
@@ -1251,7 +1251,7 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 	return ret;
 }
 
-int fsck_object(struct object *obj, void *data, unsigned long size,
+int fsck_object(struct object *obj, void *data, size_t size,
 	struct fsck_options *options)
 {
 	if (!obj)
@@ -1261,7 +1261,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 }
 
 int fsck_buffer(const struct object_id *oid, enum object_type type,
-		const void *data, unsigned long size,
+		const void *data, size_t size,
 		struct fsck_options *options)
 {
 	if (type == OBJ_BLOB)
diff --git a/fsck.h b/fsck.h
index e77935c8a9..2a075a5572 100644
--- a/fsck.h
+++ b/fsck.h
@@ -196,7 +196,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
  * Blob objects my pass a NULL data pointer, which indicates they are too large
  * to fit in memory. All other types must pass a real buffer.
  */
-int fsck_object(struct object *obj, void *data, unsigned long size,
+int fsck_object(struct object *obj, void *data, size_t size,
 	struct fsck_options *options);
 
 /*
@@ -204,7 +204,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
  * struct.
  */
 int fsck_buffer(const struct object_id *oid, enum object_type,
-		const void *data, unsigned long size,
+		const void *data, size_t size,
 		struct fsck_options *options);
 
 /*
@@ -212,7 +212,7 @@ int fsck_buffer(const struct object_id *oid, enum object_type,
  * exposed fsck_object() internals for git-mktag(1).
  */
 int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
-			unsigned long size, struct fsck_options *options,
+			size_t size, struct fsck_options *options,
 			struct object_id *tagged_oid,
 			int *tag_type);
 
-- 
2.53.0

