Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3328200BA7
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724935; cv=none; b=UCZHqkaHfvIQfGA1Y5dI26md9qRV8kX74y0iT+N6eSRu954zDOSc9ti87oHLGFsUqpKyinxaoAAwC9go4cXo0JNaMpa///JDuoBKPXrF7fElS0/49jdzcqawbzbH8tabn8BykQ9TV75c+2dmpt//XqyHBn4T96ab0Q+GaFwP2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724935; c=relaxed/simple;
	bh=388Q7IBxjvwIlJsOIxbdq2Kro5QoNip+705J8adNuP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjYvFUDPU1h4KQR+2W/JsiGapEMiyzEn9JYB/ncJwjo/1GGPcQWH6eIkgzh1jNpvBzzErL2sjSpQVLv14ihHWNecUuNmZ/HVWdA83gQrM/M3SBOjFXLRS18eSkgXvd4jKbe8VEQHxKDwT1iZKkHHt3WggUVZIZ3ivHRNIp9g16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwEh8oZk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwEh8oZk"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa578d10d50so281616666b.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724932; x=1733329732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5FksHJzH0Hty2G2uuMj9yVEOCFUPREVcLvufz8AueE=;
        b=WwEh8oZk/7DpzNR2aX/wf6X4IXQfiU/87fXK1xuFpO/lA1KSqvsVxCM5WlEBX7+qho
         +4lPUMupuN7ji/t/xcBQb5/cvGe/IlQ7VbP8TOO6k8xMAt/A/RYGO/glbz8R0USRn1Rq
         Z52sQzaYl9bgXqGRmR2/kooeV9ACoTJFjjjvfvqZdZPlrU2uNJrzhotI9RJ9NL3xJZFG
         Hg7p6S5jZ8dP2ORqHgN4X3K3lcGPJsIjVOG4hRaBONozqbg2lDtDjZB6zvCY2b/KJvpW
         jdxTSSvn1qbXBfbfDnVV5zNYYAoa5/hXgqbrw5zWeZtnjaGpPQm8vBXegnrwCFEzVqWG
         YHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724932; x=1733329732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5FksHJzH0Hty2G2uuMj9yVEOCFUPREVcLvufz8AueE=;
        b=qzSMuXktuAvCQeuOOl8OUXOf+23+EVovejIIICB2dvt5JvhwKGYR9wxwok5P9d+nzV
         W58/Rj7/c9MT7EunAHzuz3nAQzMxOsUbLiKtFu0fHE0TiT2hhR/cjwP2gaFmNjjYs+et
         Ld8+K/RQtFuPGdkUirrM7ySCk2GocVls0rI7srumHopCN0K+vmNgaboGN7cdDRCp6MF3
         wlyJIKPNAOdBhjxhJFhEfX9FPwkW248B/9VmmMf3dVnlT/zVN6eVc7VxQs1gqpZplBs7
         dN2indBOot0vncMwBaW+IfcPtAYKZ+P9gJfdhfHqfqSL/pjjBfKX5tB0mgX/8NK0EPTT
         0bUA==
X-Gm-Message-State: AOJu0Yy7ABmuO66utqqta/Ju3nMyGY2BdgdUoO1WGOj2Ds1UvncTVpqt
	iOWBWMuaok2EMrU2RWx3V1U+Lyg0UOBr7LzRi1a8SWgWei+iTsRuDrDhTQLS
X-Gm-Gg: ASbGncvft/FZMDusEd96Owvl5+cHKkclSF3940gkc2nl90T/Lrg6QGK1C9Gdn8sYC0l
	MrLlDyAHcaBhQk584Xbf/vaqYCcK5WuLPRQ/DZNuie0ghBL5wxuM8/wn1IuXEWJElkcCH4IWfmj
	YywjFISzQ7OeA8x55cbDw3ZAYGzPwlIGx/OEzSvgMkUbNVDZhJvSHBBlTwKuSk8tTM5J7j3VPy9
	goBpDj2KLcWntJ912TYFGwZ1XF9kthbV85wbxVWHkKBtThdCXGb0+VYYoFkvg==
X-Google-Smtp-Source: AGHT+IEWTQOaksKavQRfS7E2jVPcmsr3xAL6Cp0tv0VqJm16bGhFRL9ldZfG8AcPW33HE/XSDFUfJg==
X-Received: by 2002:a17:906:3143:b0:aa5:11fa:626d with SMTP id a640c23a62f3a-aa580ee013dmr357967266b.3.1732724931947;
        Wed, 27 Nov 2024 08:28:51 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:5640:4a6:5555:68ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54e15c169sm420042366b.67.2024.11.27.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:51 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 27 Nov 2024 17:28:30 +0100
Subject: [PATCH v3 5/8] midx: cleanup internal usage of `the_repository`
 and `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-5-c5a99f85009b@gmail.com>
References: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
In-Reply-To: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, 
 shejialuo@gmail.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7347; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=388Q7IBxjvwIlJsOIxbdq2Kro5QoNip+705J8adNuP4=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnR0i9kltlbAEXQxUqgU31+dMBYZJp2yZu0J2ol
 UG6rZj/GemJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0dIvQAKCRA+1Z8kjkaM
 f16zC/0TrVRHgTmGZ7OV5MbOxGd+kPGcH6KTHL2mc6Pq4FO4B0HCclRVu3rmhWczw4w/SW4EEfG
 /WwCwdqPXUlB3KbNsWTKeH6mA1J/ALjS0JMkxbQMEcQT6gXM8OKxuCq0mzdFEJA3DXKYJBdot1n
 7MJ8c4JfP7RCitiChgvqCW51wGKEp6Sb/fT0HfyGAC18uvewCVGPHOSI3PLIk5p1nzBAMt2OfJK
 eDagVI+qWGBl8RN4J6Wj+KhcKjL9YWJnRPtaF0CsbB3REsbltncG57G+BHiliPD1vaXhG9eT7I4
 7bmLIBmKy5LXZSiOqKcFwwML0u2sZl9+mPLFAovg4F57byWkzCAxMECojCvORnmJUlXA2l4pU1i
 pv+VD8Nzl+0zpcHAj0ILhcEXc1DfqHOKi6rDUCTWK6SQlAi1XOcCBZwJMnwKEK0tJvOfajrjBmM
 88jUwWUuCP0JVAfpttrOBQcboFRuA3+SZOO2LVV76G/1X5EsBKJbOLCCWAkhMFu4/3GJY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the `midx.c` file, there are multiple usages of `the_repository` and
`the_hash_algo` within static functions of the file. Some of the usages
can be simply swapped out with the available `repository` struct. While
some of them can be swapped out by passing the repository to the
required functions.

This leaves out only some other usages of `the_repository` and
`the_hash_algo` in the file in non-static functions, which we'll tackle
in upcoming commits.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/midx.c b/midx.c
index 079c45a1aafb658a7b887ac216cc6ecf5f0fb6ff..6f0fb8285af14843da132ef1b0c3a8bdd06732c9 100644
--- a/midx.c
+++ b/midx.c
@@ -25,7 +25,7 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 {
-	return m->data + m->data_len - the_hash_algo->rawsz;
+	return m->data + m->data_len - m->repo->hash_algo->rawsz;
 }
 
 void get_midx_filename(struct strbuf *out, const char *object_dir)
@@ -94,7 +94,8 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
 
-static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir,
+static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
+							  const char *object_dir,
 							  const char *midx_name,
 							  int local)
 {
@@ -131,7 +132,7 @@ static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
 	m->data = midx_map;
 	m->data_len = midx_size;
 	m->local = local;
-	m->repo = the_repository;
+	m->repo = r;
 
 	m->signature = get_be32(m->data);
 	if (m->signature != MIDX_SIGNATURE)
@@ -144,12 +145,12 @@ static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
 		      m->version);
 
 	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
-	if (hash_version != oid_version(the_hash_algo)) {
+	if (hash_version != oid_version(r->hash_algo)) {
 		error(_("multi-pack-index hash version %u does not match version %u"),
-		      hash_version, oid_version(the_hash_algo));
+		      hash_version, oid_version(r->hash_algo));
 		goto cleanup_fail;
 	}
-	m->hash_len = the_hash_algo->rawsz;
+	m->hash_len = r->hash_algo->rawsz;
 
 	m->num_chunks = m->data[MIDX_BYTE_NUM_CHUNKS];
 
@@ -206,8 +207,8 @@ static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
 			      m->pack_names[i]);
 	}
 
-	trace2_data_intmax("midx", the_repository, "load/num_packs", m->num_packs);
-	trace2_data_intmax("midx", the_repository, "load/num_objects", m->num_objects);
+	trace2_data_intmax("midx", r, "load/num_packs", m->num_packs);
+	trace2_data_intmax("midx", r, "load/num_objects", m->num_objects);
 
 	free_chunkfile(cf);
 	return m;
@@ -240,8 +241,9 @@ void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
 	strbuf_addf(buf, "/multi-pack-index-%s.%s", hash_to_hex(hash), ext);
 }
 
-static int open_multi_pack_index_chain(const char *chain_file,
-				       int *fd, struct stat *st)
+static int open_multi_pack_index_chain(const struct git_hash_algo *hash_algo,
+				       const char *chain_file, int *fd,
+				       struct stat *st)
 {
 	*fd = git_open(chain_file);
 	if (*fd < 0)
@@ -250,7 +252,7 @@ static int open_multi_pack_index_chain(const char *chain_file,
 		close(*fd);
 		return 0;
 	}
-	if (st->st_size < the_hash_algo->hexsz) {
+	if (st->st_size < hash_algo->hexsz) {
 		close(*fd);
 		if (!st->st_size) {
 			/* treat empty files the same as missing */
@@ -292,7 +294,8 @@ static int add_midx_to_chain(struct multi_pack_index *midx,
 	return 1;
 }
 
-static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
+static struct multi_pack_index *load_midx_chain_fd_st(struct repository *r,
+						      const char *object_dir,
 						      int local,
 						      int fd, struct stat *st,
 						      int *incomplete_chain)
@@ -303,7 +306,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 	uint32_t i, count;
 	FILE *fp = xfdopen(fd, "r");
 
-	count = st->st_size / (the_hash_algo->hexsz + 1);
+	count = st->st_size / (r->hash_algo->hexsz + 1);
 
 	for (i = 0; i < count; i++) {
 		struct multi_pack_index *m;
@@ -312,7 +315,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 		if (strbuf_getline_lf(&buf, fp) == EOF)
 			break;
 
-		if (get_oid_hex(buf.buf, &layer)) {
+		if (get_oid_hex_algop(buf.buf, &layer, r->hash_algo)) {
 			warning(_("invalid multi-pack-index chain: line '%s' "
 				  "not a hash"),
 				buf.buf);
@@ -325,7 +328,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 		strbuf_reset(&buf);
 		get_split_midx_filename_ext(&buf, object_dir, layer.hash,
 					    MIDX_EXT_MIDX);
-		m = load_multi_pack_index_one(object_dir, buf.buf, local);
+		m = load_multi_pack_index_one(r, object_dir, buf.buf, local);
 
 		if (m) {
 			if (add_midx_to_chain(m, midx_chain)) {
@@ -348,7 +351,8 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 	return midx_chain;
 }
 
-static struct multi_pack_index *load_multi_pack_index_chain(const char *object_dir,
+static struct multi_pack_index *load_multi_pack_index_chain(struct repository *r,
+							    const char *object_dir,
 							    int local)
 {
 	struct strbuf chain_file = STRBUF_INIT;
@@ -357,10 +361,10 @@ static struct multi_pack_index *load_multi_pack_index_chain(const char *object_d
 	struct multi_pack_index *m = NULL;
 
 	get_midx_chain_filename(&chain_file, object_dir);
-	if (open_multi_pack_index_chain(chain_file.buf, &fd, &st)) {
+	if (open_multi_pack_index_chain(r->hash_algo, chain_file.buf, &fd, &st)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
-		m = load_midx_chain_fd_st(object_dir, local, fd, &st,
+		m = load_midx_chain_fd_st(r, object_dir, local, fd, &st,
 					  &incomplete);
 	}
 
@@ -376,9 +380,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir,
 
 	get_midx_filename(&midx_name, object_dir);
 
-	m = load_multi_pack_index_one(object_dir, midx_name.buf, local);
+	m = load_multi_pack_index_one(the_repository, object_dir,
+				      midx_name.buf, local);
 	if (!m)
-		m = load_multi_pack_index_chain(object_dir, local);
+		m = load_multi_pack_index_chain(the_repository, object_dir, local);
 
 	strbuf_release(&midx_name);
 
@@ -520,7 +525,7 @@ int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 		     uint32_t *result)
 {
 	int ret = bsearch_hash(oid->hash, m->chunk_oid_fanout,
-			       m->chunk_oid_lookup, the_hash_algo->rawsz,
+			       m->chunk_oid_lookup, m->repo->hash_algo->rawsz,
 			       result);
 	if (result)
 		*result += m->num_objects_in_base;
@@ -551,7 +556,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	n = midx_for_object(&m, n);
 
 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
-		the_repository->hash_algo);
+		m->repo->hash_algo);
 	return oid;
 }
 

-- 
2.47.1

