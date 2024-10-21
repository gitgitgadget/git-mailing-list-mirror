Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04E1E47D3
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504703; cv=none; b=gZ96ICGhNE/1lhMyco5IYADt40hRwoetdAWFrCuWOJZpVZzhAhR7AdXzhy4XgmzY1hKgceFE2EZTl7JkY3uqPvXOE32TLUOHZ07jsXa+xoEdBx3aHfCPquHRSSDo96O87aeKUgrbW9dBaRSjnXIiNrmODHa0Hpl8FArPnI/pAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504703; c=relaxed/simple;
	bh=ISgypjhvzcRaMqnVcWBLHVsYHiFdzX1HnAF+bxdDRsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+OtXm1SKu/RrD/TEK5M8/nopvdp7cbYWPFvakayttA2HdgBQdGq7G2kd0bGTPzpGpecEyRRGiijoxfeNBuoz3ayRp6LmuvUz3v3EbLmU23AWySOVbwtmqzmWHf9vYjFq7aERVC+hstHh34Mvej66obhp3hyzmNLR/GisaWigqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OToNivyC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OToNivyC"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99cc265e0aso620576666b.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504700; x=1730109500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2LnPJzz+cQzYSiG278Ps7YoGhH9xVmXVzPeQLwEjY0=;
        b=OToNivyCkagNfhfsmnq+2kpeWRQSyUECIBTNJ2qb1FE9+F+jkwurM4GGvqvxuot46x
         YafENBD26LSw96/T8WJMjQMzR1yBuNrDAWkb330CuvhiHbcoy/NsPgfwXbOru91qSwi7
         JsvZl5jev9r3dv2fdpgrJigRAi5CbJyYvSdPblPvob0r5cws1Lt7LGT9s+4A6DwpzsB3
         nztJgBTb3k+UybQG0YtR4S4an4xZccb2LsNOba0EJZu2M6dKDoOVKFXF1yu9wG4GSbtM
         L+2n097+Y/Sse+62a9B/o+V91sVg/KsaukgjX1209OHaE9Fn6joK0SqJXD7lv14Mvq9A
         PMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504700; x=1730109500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2LnPJzz+cQzYSiG278Ps7YoGhH9xVmXVzPeQLwEjY0=;
        b=B1HPPnnqXXcaFCzLtUTFVS9DKGB30BMt/uQAo77svVI+/ekFSGHA1nepz8PFlisC5l
         up+ahGQIkd29n/bfx0Ap4h2uRQWMfojxkW4aFrt9I64OgVI7Ct/d+hv3PE8UHMSTBgTu
         uI++hhwamTteyKbDVZYSj5INzPXaXDxrNIZ1fB6zfF7xT0IV3YDoOWEETZEvcM+GVpiU
         N+kB5b7zk07hlu1caTIDia1Xc8PgtTSDQaswxrJJ/vv8wP3M8gC8OBAatoM7Dl4Q5R0Q
         Ew+9t6M7p/TuWfE1qzvGzC5gss5fNVizcTVmAHwniAS6AHQ/HmETwjd8o693LbD3FrTM
         q3NA==
X-Gm-Message-State: AOJu0YwzQKy3ZtisjcfsTSFi3hYgqsjzB90F0hMZB32gRblWrnfZITHQ
	tdkQNY3edkXYPRdJPPabjIzOiUjPta2BnoiLJwZSIs+7nnfy/bs/Za7Ydrdr
X-Google-Smtp-Source: AGHT+IGDZTfkpv8AY1EuPftivtrxDFHe3Kxeq8PTFEmcjw+eouQh24k28G0t+xerqFEQK0ZhGguajA==
X-Received: by 2002:a17:907:7214:b0:a9a:2afc:e4e3 with SMTP id a640c23a62f3a-a9a69c55bdfmr868628866b.50.1729504699435;
        Mon, 21 Oct 2024 02:58:19 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 17/20] packfile: stop using 'the_hash_algo'
Date: Mon, 21 Oct 2024 11:58:00 +0200
Message-ID: <9be98d3e1bfaabf725286cdefaf02e48568f7028.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make changes to functions in 'packfile.c' to stop using the global
'the_hash_algo'. This requires changing some of the functions to accept
a repository variable and to modify layers above to pass this variable.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 object-name.c |  4 ++--
 pack-bitmap.c |  2 +-
 packfile.c    | 29 ++++++++++++++++++-----------
 packfile.h    |  3 ++-
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/object-name.c b/object-name.c
index 368242133a..83a36915d6 100644
--- a/object-name.c
+++ b/object-name.c
@@ -179,7 +179,7 @@ static void unique_in_pack(struct packed_git *p,
 		return;
 
 	num = p->num_objects;
-	bsearch_pack(&ds->bin_pfx, p, &first);
+	bsearch_pack(ds->repo, &ds->bin_pfx, p, &first);
 
 	/*
 	 * At this point, "first" is the location of the lowest object
@@ -766,7 +766,7 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 
 	num = p->num_objects;
 	mad_oid = mad->oid;
-	match = bsearch_pack(mad_oid, p, &first);
+	match = bsearch_pack(mad->repo, mad_oid, p, &first);
 
 	/*
 	 * first is now the position in the packfile where we would insert
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 97237acb24..da2fc45f3f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -741,7 +741,7 @@ static uint32_t bitmap_bsearch_pos(struct bitmap_index *bitmap_git,
 	if (bitmap_is_midx(bitmap_git))
 		found = bsearch_midx(oid, bitmap_git->midx, result);
 	else
-		found = bsearch_pack(oid, bitmap_git->pack, result);
+		found = bsearch_pack(the_repository, oid, bitmap_git->pack, result);
 
 	return found;
 }
diff --git a/packfile.c b/packfile.c
index b0147231cb..e06931154f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -30,7 +30,7 @@ char *odb_pack_name(struct repository *repo, struct strbuf *buf,
 {
 	strbuf_reset(buf);
 	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(repo),
-		    hash_to_hex(hash), ext);
+		    hash_to_hex_algop(hash, repo->hash_algo), ext);
 	return buf->buf;
 }
 
@@ -544,7 +544,7 @@ static int open_packed_git_1(struct repository *repo, struct packed_git *p)
 	unsigned char hash[GIT_MAX_RAWSZ];
 	unsigned char *idx_hash;
 	ssize_t read_result;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = repo->hash_algo->rawsz;
 
 	if (open_pack_index(repo, p))
 		return error("packfile %s index unavailable", p->pack_name);
@@ -614,7 +614,8 @@ static int open_packed_git(struct repository *repo, struct packed_git *p)
 	return -1;
 }
 
-static int in_window(struct pack_window *win, off_t offset)
+static int in_window(struct repository *repo, struct pack_window *win,
+		     off_t offset)
 {
 	/* We must promise at least one full hash after the
 	 * offset is available from this window, otherwise the offset
@@ -624,7 +625,7 @@ static int in_window(struct pack_window *win, off_t offset)
 	 */
 	off_t win_off = win->offset;
 	return win_off <= offset
-		&& (offset + the_hash_algo->rawsz) <= (win_off + win->len);
+		&& (offset + repo->hash_algo->rawsz) <= (win_off + win->len);
 }
 
 unsigned char *use_pack(struct repository *repo, struct packed_git *p,
@@ -640,16 +641,16 @@ unsigned char *use_pack(struct repository *repo, struct packed_git *p,
 	 */
 	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(repo, p))
 		die("packfile %s cannot be accessed", p->pack_name);
-	if (offset > (p->pack_size - the_hash_algo->rawsz))
+	if (offset > (p->pack_size - repo->hash_algo->rawsz))
 		die("offset beyond end of packfile (truncated pack?)");
 	if (offset < 0)
 		die(_("offset before end of packfile (broken .idx?)"));
 
-	if (!win || !in_window(win, offset)) {
+	if (!win || !in_window(repo, win, offset)) {
 		if (win)
 			win->inuse_cnt--;
 		for (win = p->windows; win; win = win->next) {
-			if (in_window(win, offset))
+			if (in_window(repo, win, offset))
 				break;
 		}
 		if (!win) {
@@ -714,6 +715,7 @@ struct packed_git *add_packed_git(struct repository *repo, const char *path,
 	struct stat st;
 	size_t alloc;
 	struct packed_git *p;
+	struct object_id oid;
 
 	/*
 	 * Make sure a corresponding .pack file exists and that
@@ -755,8 +757,12 @@ struct packed_git *add_packed_git(struct repository *repo, const char *path,
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
 	if (path_len < repo->hash_algo->hexsz ||
-	    get_hash_hex(path + path_len - repo->hash_algo->hexsz, p->hash))
+	    get_oid_hex_algop(path + path_len - repo->hash_algo->hexsz, &oid,
+			      repo->hash_algo))
 		hashclr(p->hash, repo->hash_algo);
+	else
+		memcpy(p->hash, oid.hash, repo->hash_algo->rawsz);
+
 	return p;
 }
 
@@ -1895,11 +1901,12 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 	return data;
 }
 
-int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32_t *result)
+int bsearch_pack(struct repository *repo, const struct object_id *oid,
+		 const struct packed_git *p, uint32_t *result)
 {
 	const unsigned char *index_fanout = p->index_data;
 	const unsigned char *index_lookup;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = repo->hash_algo->rawsz;
 	int index_lookup_width;
 
 	if (!index_fanout)
@@ -1990,7 +1997,7 @@ off_t find_pack_entry_one(struct repository *repo, const unsigned char *sha1,
 	}
 
 	hashcpy(oid.hash, sha1, repo->hash_algo);
-	if (bsearch_pack(&oid, p, &result))
+	if (bsearch_pack(repo, &oid, p, &result))
 		return nth_packed_object_offset(p, result);
 	return 0;
 }
diff --git a/packfile.h b/packfile.h
index 98ec3616b4..d145959480 100644
--- a/packfile.h
+++ b/packfile.h
@@ -145,7 +145,8 @@ void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
  *
  * See 'bsearch_hash' for more information.
  */
-int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32_t *result);
+int bsearch_pack(struct repository *repo, const struct object_id *oid,
+		 const struct packed_git *p, uint32_t *result);
 
 /*
  * Write the oid of the nth object within the specified packfile into the first
-- 
2.47.0

