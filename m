Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC6299931
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968215; cv=none; b=pkKMAP9KsehPFvsB3tVDYwwEvxtbVFmxgI5jWAXvCNI6QOj8RD5kmrnpuVaztMdfMMnYgVMg0x3OEhygYV3zuX9KebDUWHUYSX5mpMaSNujTeVrw+gGbubs0s1C49G759kfFMwqHnO+V22tSmmFb5UkDP05Wqux5SJx+sXZ2Cy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968215; c=relaxed/simple;
	bh=jht+YGRvWuCq4YInGG9bYWNftJzOg8rXaFCnYuB7kYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afth7sqSwly5T//SnL9RxXVhA547XhC65NQZqzPxM3js/zBOIpNzfrYyIcBhuqypOPRb5rHxUZXq2fKH0FvfOaDskM6rXRbBa/YR+JN2Yn2cZfWpR3066PpE7BdPrg+nyIG9ZsO6qMewUbgRfjeQJOPm0wEq/xR+dj2y2JNP+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYrH9sQZ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYrH9sQZ"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-31d6e39817fso6676715fac.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757968212; x=1758573012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2P8o+Jd5inuAMZ+vcaMfusW77tn3U22YOMvg2+iBA4=;
        b=VYrH9sQZmmpTPsIvemcFcxa9zuw1x5M5KCwqHz3gpShHQRQXZa4lUQWvCAVrcb8NtJ
         adtdv0N3Ze6ZIvrNgFy1gn3C/ZLJJHLOWBPgulrjLmJKfKE4Jx20icoZGe5CsTfKQxZy
         2LikYyjKcYUtqx0mai2QmG//dznkKUYSnATUiReQKZbnBioeCBHF1kKvNhgubiU3n8hs
         EYbI3kBheuVPjDDWh4Yl0YxCS78+B36FguuBNJ/QEo64k9CqtcUEus6kwCqKgrD3hKwf
         A+88N7Gcsc+gXhHLUt5S8zcgjoi4Uhcxm8zjaEh5HxsNPhfEwHip+rv2E+QBxiTdmUdA
         yi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968212; x=1758573012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2P8o+Jd5inuAMZ+vcaMfusW77tn3U22YOMvg2+iBA4=;
        b=mcks8Yfq1iX6cLoYhswJEMr+2CXP1o25tpnTAlO4vVXCa5leUJEFNC2HXD93Z3T6dQ
         c6IRWXlktFtgdUVz8gIfcUro42KyuURKr8jxvHT37nd88zpWX/+vMCNzSKql2gcmEvMz
         EyYNzsiUV6YREL8+w6sY2LmqrpUf8SyhFhy3ThQ5OcdAaqARwsCsCjx0Oq0cgClK31rj
         4CM6HipFfY483bqHRV8Cxih/oyod2U+YiufTURUlsf4dnZWVLq7XifOnn6c54PYr/Oev
         n93nvI6fjJGXVjkNiH5Ji083/0mAuTocWdFrAPd9IqqDz6/Fqfoa1bdbwyevZP19egPq
         TBNw==
X-Gm-Message-State: AOJu0Yyb+S3FPQlcwToC9UIgBI80jmGjG1wC0HyGsWALFcYwpF8aQT4n
	kklTA89QaYn9Y0+ijZDLiT0DLB2U2lNBC3jfpCb7/zLAtRJv/x2HGqu3YXIfpg==
X-Gm-Gg: ASbGncuGr8HYcxcAmfk3PXyaIv/2PfsNf2wagI0Lh1yFQyt34np2jPJk4UtDvc27vVv
	VSQJtl48FnaZ2rqiAJnrEO7Pz8CGaECRm2rKBBn2PBaHy+bFfdsPKr9w8zH8vrdU8xhl0c/FJJ3
	sbqMVh5Fek+GzP3c4BYC18K2Mrzrn3CKqMKpdBWJyYoKiPA/dMuB7HPjADrR7xgctlvVv3RGMPj
	y7fpZsfKfSrAuu7Uf+f4a/RMfCfnFUqixrAb+LyVdBvthr2W5BOM8Cxax5bZC8yfsl2DzhAeJh8
	3CQKTcw4ZaRhOVIk1kh+8/EOlwDfzdrjlnulHvYG+r1ZaLBgdAiR7/TGREdKVTkZ/Bvm2J9DCVI
	LMuCtgeBInwfgei50hpDUq8aC8i3F9ys=
X-Google-Smtp-Source: AGHT+IGopYfp5kaWmlC8ihzu0TknQEQydGYypqLmG8y644//YfezOpdjMrSeFcHW9zTnMspQvW8f9A==
X-Received: by 2002:a05:6870:9121:b0:315:29a5:fc3b with SMTP id 586e51a60fabf-32e567c3da9mr6408837fac.15.1757968211948;
        Mon, 15 Sep 2025 13:30:11 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524c260735sm3114325a34.39.2025.09.15.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:30:11 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/6] object-file: update naming from bulk-checkin
Date: Mon, 15 Sep 2025 15:29:55 -0500
Message-ID: <20250915202956.3784935-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250915202956.3784935-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250915202956.3784935-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the names of several functions and types relocated from the
bulk-checkin subsystem for better clarity. Also drop
finish_tmp_packfile() as a standalone function in favor of embedding it
in flush_packfile_transaction() directly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 80 +++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/object-file.c b/object-file.c
index 3958063e48..63195da2e8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -667,7 +667,7 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
-struct bulk_checkin_packfile {
+struct transaction_packfile {
 	char *pack_tmp_name;
 	struct hashfile *f;
 	off_t offset;
@@ -682,10 +682,10 @@ struct odb_transaction {
 	struct object_database *odb;
 
 	struct tmp_objdir *objdir;
-	struct bulk_checkin_packfile packfile;
+	struct transaction_packfile packfile;
 };
 
-static void prepare_loose_object_bulk_checkin(struct odb_transaction *transaction)
+static void prepare_loose_object_transaction(struct odb_transaction *transaction)
 {
 	/*
 	 * We lazily create the temporary object directory
@@ -701,7 +701,7 @@ static void prepare_loose_object_bulk_checkin(struct odb_transaction *transactio
 		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
 
-static void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
+static void fsync_loose_object_transaction(struct odb_transaction *transaction,
 					   int fd, const char *filename)
 {
 	/*
@@ -722,7 +722,7 @@ static void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
 /*
  * Cleanup after batch-mode fsync_object_files.
  */
-static void flush_batch_fsync(struct odb_transaction *transaction)
+static void flush_loose_object_transaction(struct odb_transaction *transaction)
 {
 	struct strbuf temp_path = STRBUF_INIT;
 	struct tempfile *temp;
@@ -733,7 +733,7 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
 	/*
 	 * Issue a full hardware flush against a temporary file to ensure
 	 * that all objects are durable before any renames occur. The code in
-	 * fsync_loose_object_bulk_checkin has already issued a writeout
+	 * fsync_loose_object_transaction has already issued a writeout
 	 * request, but it has not flushed any writeback cache in the storage
 	 * hardware or any filesystem logs. This fsync call acts as a barrier
 	 * to ensure that the data in each new object file is durable before
@@ -762,7 +762,7 @@ static void close_loose_object(struct odb_source *source,
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		fsync_loose_object_bulk_checkin(source->odb->transaction, fd, filename);
+		fsync_loose_object_transaction(source->odb->transaction, fd, filename);
 	else if (fsync_object_files > 0)
 		fsync_or_die(fd, filename);
 	else
@@ -940,7 +940,7 @@ static int write_loose_object(struct odb_source *source,
 	static struct strbuf filename = STRBUF_INIT;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_bulk_checkin(source->odb->transaction);
+		prepare_loose_object_transaction(source->odb->transaction);
 
 	odb_loose_path(source, &filename, oid);
 
@@ -1029,7 +1029,7 @@ int stream_loose_object(struct odb_source *source,
 	int hdrlen;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_bulk_checkin(source->odb->transaction);
+		prepare_loose_object_transaction(source->odb->transaction);
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", source->path);
@@ -1349,10 +1349,10 @@ static int already_written(struct odb_transaction *transaction,
 }
 
 /* Lazily create backing packfile for the state */
-static void prepare_to_stream(struct odb_transaction *transaction,
-			      unsigned flags)
+static void prepare_packfile_transaction(struct odb_transaction *transaction,
+					 unsigned flags)
 {
-	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct transaction_packfile *state = &transaction->packfile;
 	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
 		return;
 
@@ -1381,7 +1381,7 @@ static void prepare_to_stream(struct odb_transaction *transaction,
  * status before calling us just in case we ask it to call us again
  * with a new pack.
  */
-static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
+static int stream_blob_to_pack(struct transaction_packfile *state,
 			       struct git_hash_ctx *ctx, off_t *already_hashed_to,
 			       int fd, size_t size, const char *path,
 			       unsigned flags)
@@ -1457,28 +1457,13 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 	return 0;
 }
 
-static void finish_tmp_packfile(struct odb_transaction *transaction,
-				struct strbuf *basename,
-				unsigned char hash[])
+static void flush_packfile_transaction(struct odb_transaction *transaction)
 {
-	struct bulk_checkin_packfile *state = &transaction->packfile;
-	struct repository *repo = transaction->odb->repo;
-	char *idx_tmp_name = NULL;
-
-	stage_tmp_packfiles(repo, basename, state->pack_tmp_name,
-			    state->written, state->nr_written, NULL,
-			    &state->pack_idx_opts, hash, &idx_tmp_name);
-	rename_tmp_packfile_idx(repo, basename, &idx_tmp_name);
-
-	free(idx_tmp_name);
-}
-
-static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
-{
-	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct transaction_packfile *state = &transaction->packfile;
 	struct repository *repo = transaction->odb->repo;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
+	char *idx_tmp_name = NULL;
 
 	if (!state->f)
 		return;
@@ -1503,11 +1488,16 @@ static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
 		    repo_get_object_directory(transaction->odb->repo),
 		    hash_to_hex_algop(hash, repo->hash_algo));
 
-	finish_tmp_packfile(transaction, &packname, hash);
+	stage_tmp_packfiles(repo, &packname, state->pack_tmp_name,
+			    state->written, state->nr_written, NULL,
+			    &state->pack_idx_opts, hash, &idx_tmp_name);
+	rename_tmp_packfile_idx(repo, &packname, &idx_tmp_name);
+
 	for (uint32_t i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
 clear_exit:
+	free(idx_tmp_name);
 	free(state->pack_tmp_name);
 	free(state->written);
 	memset(state, 0, sizeof(*state));
@@ -1535,11 +1525,12 @@ static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_blob_bulk_checkin(struct odb_transaction *transaction,
-			    struct object_id *result_oid, int fd, size_t size,
-			    const char *path, unsigned flags)
+static int index_blob_packfile_transaction(struct odb_transaction *transaction,
+					   struct object_id *result_oid, int fd,
+					   size_t size, const char *path,
+					   unsigned flags)
 {
-	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct transaction_packfile *state = &transaction->packfile;
 	off_t seekback, already_hashed_to;
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
@@ -1560,14 +1551,14 @@ static int index_blob_bulk_checkin(struct odb_transaction *transaction,
 	if ((flags & INDEX_WRITE_OBJECT) != 0) {
 		CALLOC_ARRAY(idx, 1);
 
-		prepare_to_stream(transaction, flags);
+		prepare_packfile_transaction(transaction, flags);
 		hashfile_checkpoint_init(state->f, &checkpoint);
 	}
 
 	already_hashed_to = 0;
 
 	while (1) {
-		prepare_to_stream(transaction, flags);
+		prepare_packfile_transaction(transaction, flags);
 		if (idx) {
 			hashfile_checkpoint(state->f, &checkpoint);
 			idx->offset = state->offset;
@@ -1585,7 +1576,7 @@ static int index_blob_bulk_checkin(struct odb_transaction *transaction,
 			BUG("should not happen");
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
-		flush_bulk_checkin_packfile(transaction);
+		flush_packfile_transaction(transaction);
 		if (lseek(fd, seekback, SEEK_SET) == (off_t)-1)
 			return error("cannot seek back");
 	}
@@ -1634,9 +1625,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		if (!the_repository->objects->transaction)
 			transaction = begin_odb_transaction(the_repository->objects);
 
-		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
-					      oid, fd, xsize_t(st->st_size),
-					      path, flags);
+		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
+						      oid, fd,
+						      xsize_t(st->st_size),
+						      path, flags);
 
 		end_odb_transaction(transaction);
 	}
@@ -1999,8 +1991,8 @@ void end_odb_transaction(struct odb_transaction *transaction)
 	 */
 	ASSERT(transaction == transaction->odb->transaction);
 
-	flush_batch_fsync(transaction);
-	flush_bulk_checkin_packfile(transaction);
+	flush_loose_object_transaction(transaction);
+	flush_packfile_transaction(transaction);
 	transaction->odb->transaction = NULL;
 	free(transaction);
 }
-- 
2.51.0.193.g4975ec3473b

