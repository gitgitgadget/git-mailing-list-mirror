Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946F23A6
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720517; cv=none; b=ZZ5ecEdalu4qMNKttVtq25p2+7sMtj2JVzhTzOUL2BNU8ofAs0x6BLOyL2xCI4NdPzDugN/vv25OOa7RLHm7n2Jlcpp8w3iBC4p+sH58YD/maP/vgxHpO0UKeEa34u8vpVQQLit8HlXKfQTpsPkvmKcotRXgfPuLCQ7Z11fETkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720517; c=relaxed/simple;
	bh=ZGBi6zmz94/KIX2/rj7sYLQbWHx3l/hmB4KOeZCa/6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uErogTKZF3KngBKGlx4BFclSSp4hqY13hi7taJLRKnl2Fe7xufkYmTWt5lG3SOcjTLnVZyWvcelGUPtTyJ0KOHGECCan+vB00Q8ErMQoCR7CGK+/JT4I20MJPb/viia+CvbmySJuNKGRFLawpSDD5X06fWBUKJi679uVr1h67SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7oK4M0T; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7oK4M0T"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso1487515a12.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 03:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730720514; x=1731325314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsmUY+zYGc++3aDdKHLhdgz3wvb8VAJjQs8Ok+OhWTs=;
        b=j7oK4M0TuPBCjUUTUN5r6ZIfHXj56qIyQZowIC7sXN1S6CVAc0O8Ei7hVqkzBiDSTV
         ZJL4oBQhAVud32TQJBDefJUUFoFZpsauxTACsa24mqKBA+JRt1G2hytYXGq1oXK+Fqac
         JNaOOS1HkNYTIb8Llr4gnogipHljMVpwq8pe+fm4SPpNFdZ+J260drM7rBtmz/N1Ngkj
         PqHg5KAAIH792utLfOK9/t79gyC2DLgIJ/iCVa1Hx80UvUFh5YeiGpzFCqsn7Wp5WSyx
         7dxxUIbEas1kW/ITP5JwleSGWCQXdL6c8p0be9NlUHcKSK6ZmY+iOIzic2C3MQ1c0W+o
         qaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720514; x=1731325314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsmUY+zYGc++3aDdKHLhdgz3wvb8VAJjQs8Ok+OhWTs=;
        b=wAaeDLq04he+2JgkqjqxHCgx6Ff2fXgsv07Dl+mDFWIsaVmurIXd8IeX1B64zoyvxZ
         dq/QG612NGY0C/dTREM8Sqq4AAgeYGl2ZI+Fgohdsr76D+GUFBGtqKjwh8ptYVAPZWy7
         fS11Dk/jBQncdsGE7jBJU0ZhlAGsHwn9FinB9SqhPDWg9M2wTeqoih9O2ylJ8nu/tla4
         rRAuvbUxX3p5y4pZgnRWu8Q6Z50y/qp9h9+XIxhuu68aOvmEebunTaXuXLhoTH7iZb2N
         B/T7UoS6oqjAILMIDPOaw2gQ/hMgWEkPxoKgyJ5oAhxnnYcRiKKJBVO3WjkYucmecgXb
         PgHw==
X-Gm-Message-State: AOJu0YwE1yM8M3qZKiaUe4YmAKDO2pbNc02GRqUMTMcGoayihzcMmfo5
	YWJ6I6GPxm3ILlajQDz+tkxwAw+dN/nc1YDk7+pDAk+eRPxSrtA495mrFQix
X-Google-Smtp-Source: AGHT+IHa76FftEy5JPdyFfINlcdbdoTRyihoDM3qswYwUN+fn89NVc9onZgyq139TGkKWC7UdDSigA==
X-Received: by 2002:a05:6402:5cb:b0:5c9:3ff:2734 with SMTP id 4fb4d7f45d1cf-5cd54a84c79mr14760129a12.12.1730720514197;
        Mon, 04 Nov 2024 03:41:54 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7e97f2sm4157219a12.87.2024.11.04.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:41:53 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v5 2/9] packfile: use `repository` from `packed_git` directly
Date: Mon,  4 Nov 2024 12:41:40 +0100
Message-ID: <70fc8a79afe6d1d91dd2a820d868f063a83de8f0.1730714298.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730714298.git.karthik.188@gmail.com>
References: <cover.1730714298.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous commit, we introduced the `repository` structure inside
`packed_git`. This provides an alternative route instead of using the
global `the_repository` variable. Let's modify `packfile.c` now to use
this field wherever possible instead of relying on the global state.
There are still a few instances of `the_repository` usage in the file,
where there is no struct `packed_git` locally available, which will be
fixed in the following commits.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 packfile.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/packfile.c b/packfile.c
index 6058eddf35..5bfa1e17c2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -79,7 +79,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	size_t idx_size;
 	int fd = git_open(path), ret;
 	struct stat st;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
 
 	if (fd < 0)
 		return -1;
@@ -243,7 +243,7 @@ struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
 	free(path);
-	hashcpy(p->hash, sha1, the_repository->hash_algo);
+	hashcpy(p->hash, sha1, p->repo->hash_algo);
 	if (check_packed_git_idx(idx_path, p)) {
 		free(p);
 		return NULL;
@@ -278,7 +278,7 @@ static int unuse_one_window(struct packed_git *current)
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = the_repository->objects->packed_git; p; p = p->next)
+	for (p = current->repo->objects->packed_git; p; p = p->next)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -540,7 +540,7 @@ static int open_packed_git_1(struct packed_git *p)
 	unsigned char hash[GIT_MAX_RAWSZ];
 	unsigned char *idx_hash;
 	ssize_t read_result;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = p->repo->hash_algo->rawsz;
 
 	if (open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
@@ -597,7 +597,7 @@ static int open_packed_git_1(struct packed_git *p)
 	if (read_result != hashsz)
 		return error("packfile %s signature is unavailable", p->pack_name);
 	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
-	if (!hasheq(hash, idx_hash, the_repository->hash_algo))
+	if (!hasheq(hash, idx_hash, p->repo->hash_algo))
 		return error("packfile %s does not match index", p->pack_name);
 	return 0;
 }
@@ -637,7 +637,7 @@ unsigned char *use_pack(struct packed_git *p,
 	 */
 	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
 		die("packfile %s cannot be accessed", p->pack_name);
-	if (offset > (p->pack_size - the_hash_algo->rawsz))
+	if (offset > (p->pack_size - p->repo->hash_algo->rawsz))
 		die("offset beyond end of packfile (truncated pack?)");
 	if (offset < 0)
 		die(_("offset before end of packfile (broken .idx?)"));
@@ -711,6 +711,7 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	struct stat st;
 	size_t alloc;
 	struct packed_git *p;
+	struct object_id oid;
 
 	/*
 	 * Make sure a corresponding .pack file exists and that
@@ -751,9 +752,13 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	p->pack_size = st.st_size;
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
-	if (path_len < the_hash_algo->hexsz ||
-	    get_hash_hex(path + path_len - the_hash_algo->hexsz, p->hash))
-		hashclr(p->hash, the_repository->hash_algo);
+	if (path_len < r->hash_algo->hexsz ||
+	    get_oid_hex_algop(path + path_len - r->hash_algo->hexsz, &oid,
+			      r->hash_algo))
+		hashclr(p->hash, r->hash_algo);
+	else
+		hashcpy(p->hash, oid.hash, r->hash_algo);
+
 	return p;
 }
 
@@ -1243,9 +1248,9 @@ off_t get_delta_base(struct packed_git *p,
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		struct object_id oid;
-		oidread(&oid, base_info, the_repository->hash_algo);
+		oidread(&oid, base_info, p->repo->hash_algo);
 		base_offset = find_pack_entry_one(&oid, p);
-		*curpos += the_hash_algo->rawsz;
+		*curpos += p->repo->hash_algo->rawsz;
 	} else
 		die("I am totally screwed");
 	return base_offset;
@@ -1266,7 +1271,7 @@ static int get_delta_base_oid(struct packed_git *p,
 {
 	if (type == OBJ_REF_DELTA) {
 		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
-		oidread(oid, base, the_repository->hash_algo);
+		oidread(oid, base, p->repo->hash_algo);
 		return 0;
 	} else if (type == OBJ_OFS_DELTA) {
 		uint32_t base_pos;
@@ -1608,7 +1613,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 				goto out;
 			}
 		} else
-			oidclr(oi->delta_base_oid, the_repository->hash_algo);
+			oidclr(oi->delta_base_oid, p->repo->hash_algo);
 	}
 
 	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
@@ -1897,7 +1902,7 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 {
 	const unsigned char *index_fanout = p->index_data;
 	const unsigned char *index_lookup;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
 	int index_lookup_width;
 
 	if (!index_fanout)
@@ -1922,7 +1927,7 @@ int nth_packed_object_id(struct object_id *oid,
 			 uint32_t n)
 {
 	const unsigned char *index = p->index_data;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
 	if (!index) {
 		if (open_pack_index(p))
 			return -1;
@@ -1933,11 +1938,10 @@ int nth_packed_object_id(struct object_id *oid,
 	index += 4 * 256;
 	if (p->index_version == 1) {
 		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
-			the_repository->hash_algo);
+			p->repo->hash_algo);
 	} else {
 		index += 8;
-		oidread(oid, index + st_mult(hashsz, n),
-			the_repository->hash_algo);
+		oidread(oid, index + st_mult(hashsz, n), p->repo->hash_algo);
 	}
 	return 0;
 }
@@ -1959,7 +1963,7 @@ void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
 off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 {
 	const unsigned char *index = p->index_data;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
 	index += 4 * 256;
 	if (p->index_version == 1) {
 		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
@@ -2159,7 +2163,7 @@ int for_each_object_in_pack(struct packed_git *p,
 	int r = 0;
 
 	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
-		if (load_pack_revindex(the_repository, p))
+		if (load_pack_revindex(p->repo, p))
 			return -1;
 	}
 
@@ -2227,7 +2231,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
 }
 
 static int add_promisor_object(const struct object_id *oid,
-			       struct packed_git *pack UNUSED,
+			       struct packed_git *pack,
 			       uint32_t pos UNUSED,
 			       void *set_)
 {
@@ -2235,12 +2239,12 @@ static int add_promisor_object(const struct object_id *oid,
 	struct object *obj;
 	int we_parsed_object;
 
-	obj = lookup_object(the_repository, oid);
+	obj = lookup_object(pack->repo, oid);
 	if (obj && obj->parsed) {
 		we_parsed_object = 0;
 	} else {
 		we_parsed_object = 1;
-		obj = parse_object(the_repository, oid);
+		obj = parse_object(pack->repo, oid);
 	}
 
 	if (!obj)
-- 
2.47.0

