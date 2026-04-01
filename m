Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAF3382CD
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012610; cv=none; b=CQfi0c2Jhp6D2OmcprWhlW1krhHtJr97G4dq0rQugEN1oSOJnvSIblUokZ32eTiRoIwVtBhqatdWckYmtpWQey+n6d72WWGZcLAmuB8Ao+9XtX/gLQGO+ho4l9UtpJZT9SuJ4fLWqZiu6sHTcnzg9fwFNgBP90QQwPyDxYDqiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012610; c=relaxed/simple;
	bh=I9UvJH72Spwjvzewg4hvfuYcg1Ob/UlXxBGnSvaH/cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqwEv0lbd6O4VLEdWrJsuUuDGxNMjY6Xp13V1IApfEvPvZLQsgA/+cMAJDBkTAY/EN/CrJmH2SZMub7m9nl5qTyWGxCDPxF8w9VFTEBCGUOkqzEpJG7bEZiU0XJyewB8+2g1ZzS/kUhmpwPFhxBQt0iNM9A4fDdHyE8pHNkeYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCZp6daY; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCZp6daY"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d9bba96f7dso3427171a34.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775012604; x=1775617404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXK4hXxYV/cEGIuU6F5WYHaUrNZbyG8PT1ifp6iyCok=;
        b=SCZp6daYOAqrdjaGmRIkDXHe3Ce2iKmLNimzDcZBi1FL0Nf+dxGS54u3k0Fx2SoU0i
         H4I6eylbvfwsdDiJepx4ffLlAnGEqF8UcnKd6ZpGT7Wlzy7+v3wFoGHFX2EpqKZrA5lZ
         lgca4oeqgmzQoEK4i7ZDCrK7RSd0r6nO3K3GOnKwcKQYgqzDcPnnPy7PLwq2BSCgdME/
         yJkHcjqYPp+Bup8V8JztGmktz87QDjK71uNRh4nqvNpeK2dBPdLzf1kGPMg5PVxVTN+a
         0qvh8/gngx3zjIjZUNlBggOst7mgGRT2Z+jyuUPturOiP2ibIoNsRNRrbiIvuy0PihGO
         QQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775012604; x=1775617404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XXK4hXxYV/cEGIuU6F5WYHaUrNZbyG8PT1ifp6iyCok=;
        b=C8gyo4n4ow7s/mapCxI7/hJR39F1hkqNMyjh2ytHLh6QouNA5330tAJgjXG+mDePBg
         QyfLb0/3v8DjQBDhl03t5Mq2ZRVA8ORusRa6Ryot6b5BjmqV7kINmlWcgK6qpAfCqNWN
         RqVC1mltwHp7JpKWNZlKeJYtmW3YzlXDLSJfOD9FwMKfIbPL6qmVF2Fhgo0xlztUxaEG
         V2vl7soSC5GgSA4vpPfUGy1CtdwGq00cOgOfquILtsSVrMfLTBtPFq+ldPDJ1X8DtMU8
         0U/Uzkm8eOflgUrmI/jUQyOsg5uaglzgLbPBBquUA45/+w64tcsJYrw3Yl5WnWc7flpA
         PlZQ==
X-Gm-Message-State: AOJu0YzyTx3e4I2GYKlTUIbLTfxBFFaW3dmneB/DxQI2+lhYKm8NxIM7
	NM3tv/QB2cQrpK+VW65XzUs26oQHaJPEf9V/eSotkOvxgrGMp4zL6JgFMNo9Sw==
X-Gm-Gg: ATEYQzxVhvl/0mkZl3JaGEA/1ZcIEhoHospKj11Hfw21kLDQEbgt3yoP0C1atfU1UuI
	7mJ8M7Lgx9gP7OYDzMKpZkQhAMr3iVpAv+FNj8a3xDivRWFOFMaNSq4NjYGSoLwfmwvguFqz7+w
	y9DLjHNtFgIgkpGUQk033bpUE7+Qc4BitAsrpF5AXNiVnbKGkeEqZdC6Fc/HRxrzJP/LDyTCNOS
	Rf0k5Pj89e5rB7ca/xudzSLWb1uSO8l54esjMub43TdVkiIp1hOba4EBX9/f31WdPu9xj5d27hv
	hDZ8Z7BQTovEVkIl4TQTRcwUTcAsbxvyIbANt7RFYEkmxWF6pifFeljNHQdMYzdCUlvwS5MY1/D
	Z2hgP80rG994CplGqntSa8TP60wDVA70Xvn18GVsddtupNVswfSVJyZUJuJj1WfUdnDoWCEngfn
	jDhLBZjyW4+j/+ETxH1Yw/PMUxWz6B357RIpDdRsk2Ug==
X-Received: by 2002:a05:6830:2713:b0:7d7:faef:fa0 with SMTP id 46e09a7af769-7db9925800dmr1263122a34.3.1775012604362;
        Tue, 31 Mar 2026 20:03:24 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm10266001a34.24.2026.03.31.20.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:03:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/7] object-file: remove flags from transaction packfile writes
Date: Tue, 31 Mar 2026 22:03:12 -0500
Message-ID: <20260401030316.1847362-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260401030316.1847362-1-jltobler@gmail.com>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260401030316.1847362-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `index_blob_packfile_transaction()` function handles streaming a
blob from an fd to compute its object ID and conditionally writes the
object directly to a packfile if the INDEX_WRITE_OBJECT flag is set. A
subsequent commit will make these packfile object writes part of the
transaction interface. Consequently, having the object write be
conditional on this flag is a bit awkward.

In preparation for this change, introduce a dedicated
`hash_blob_stream()` helper that only computes the OID from a `struct
odb_write_stream`. This is invoked by `index_fd()` instead when the
INDEX_WRITE_OBJECT is not set. The object write performed via
`index_blob_packfile_transaction()` is made unconditional accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c   | 131 +++++++++++++++++++++++++++++-------------------
 odb/streaming.c |  40 +++++++++++++++
 odb/streaming.h |   8 +++
 3 files changed, 127 insertions(+), 52 deletions(-)

diff --git a/object-file.c b/object-file.c
index f3038756fc..f317a24ccf 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1395,11 +1395,10 @@ static int already_written(struct odb_transaction_files *transaction,
 }
 
 /* Lazily create backing packfile for the state */
-static void prepare_packfile_transaction(struct odb_transaction_files *transaction,
-					 unsigned flags)
+static void prepare_packfile_transaction(struct odb_transaction_files *transaction)
 {
 	struct transaction_packfile *state = &transaction->packfile;
-	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
+	if (state->f)
 		return;
 
 	state->f = create_tmp_packfile(transaction->base.source->odb->repo,
@@ -1412,6 +1411,38 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
 		die_errno("unable to write pack header");
 }
 
+static int hash_blob_stream(struct odb_write_stream *stream,
+			    const struct git_hash_algo *hash_algo,
+			    struct object_id *result_oid, size_t size)
+{
+	unsigned char buf[16384];
+	struct git_hash_ctx ctx;
+	unsigned header_len;
+	size_t total = 0;
+
+	header_len = format_object_header((char *)buf, sizeof(buf),
+					  OBJ_BLOB, size);
+	hash_algo->init_fn(&ctx);
+	git_hash_update(&ctx, buf, header_len);
+
+	while (!stream->is_finished) {
+		ssize_t read_result = stream->read(stream, buf, sizeof(buf));
+
+		if (read_result < 0)
+			return -1;
+
+		git_hash_update(&ctx, buf, read_result);
+		total += read_result;
+	}
+
+	if (total != size)
+		return -1;
+
+	git_hash_final_oid(result_oid, &ctx);
+
+	return 0;
+}
+
 /*
  * Read the contents from fd for size bytes, streaming it to the
  * packfile in state while updating the hash in ctx. Signal a failure
@@ -1429,15 +1460,13 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
  */
 static int stream_blob_to_pack(struct transaction_packfile *state,
 			       struct git_hash_ctx *ctx, off_t *already_hashed_to,
-			       int fd, size_t size, const char *path,
-			       unsigned flags)
+			       int fd, size_t size, const char *path)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
 	unsigned char obuf[16384];
 	unsigned hdrlen;
 	int status = Z_OK;
-	int write_object = (flags & INDEX_WRITE_OBJECT);
 	off_t offset = 0;
 
 	git_deflate_init(&s, pack_compression_level);
@@ -1472,20 +1501,18 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 		status = git_deflate(&s, size ? 0 : Z_FINISH);
 
 		if (!s.avail_out || status == Z_STREAM_END) {
-			if (write_object) {
-				size_t written = s.next_out - obuf;
-
-				/* would we bust the size limit? */
-				if (state->nr_written &&
-				    pack_size_limit_cfg &&
-				    pack_size_limit_cfg < state->offset + written) {
-					git_deflate_abort(&s);
-					return -1;
-				}
-
-				hashwrite(state->f, obuf, written);
-				state->offset += written;
+			size_t written = s.next_out - obuf;
+
+			/* would we bust the size limit? */
+			if (state->nr_written &&
+			    pack_size_limit_cfg &&
+			    pack_size_limit_cfg < state->offset + written) {
+				git_deflate_abort(&s);
+				return -1;
 			}
+
+			hashwrite(state->f, obuf, written);
+			state->offset += written;
 			s.next_out = obuf;
 			s.avail_out = sizeof(obuf);
 		}
@@ -1573,8 +1600,7 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  */
 static int index_blob_packfile_transaction(struct odb_transaction_files *transaction,
 					   struct object_id *result_oid, int fd,
-					   size_t size, const char *path,
-					   unsigned flags)
+					   size_t size, const char *path)
 {
 	struct transaction_packfile *state = &transaction->packfile;
 	off_t seekback, already_hashed_to;
@@ -1582,7 +1608,7 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint;
-	struct pack_idx_entry *idx = NULL;
+	struct pack_idx_entry *idx;
 
 	seekback = lseek(fd, 0, SEEK_CUR);
 	if (seekback == (off_t)-1)
@@ -1593,33 +1619,26 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	transaction->base.source->odb->repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
-	/* Note: idx is non-NULL when we are writing */
-	if ((flags & INDEX_WRITE_OBJECT) != 0) {
-		CALLOC_ARRAY(idx, 1);
-
-		prepare_packfile_transaction(transaction, flags);
-		hashfile_checkpoint_init(state->f, &checkpoint);
-	}
+	CALLOC_ARRAY(idx, 1);
+	prepare_packfile_transaction(transaction);
+	hashfile_checkpoint_init(state->f, &checkpoint);
 
 	already_hashed_to = 0;
 
 	while (1) {
-		prepare_packfile_transaction(transaction, flags);
-		if (idx) {
-			hashfile_checkpoint(state->f, &checkpoint);
-			idx->offset = state->offset;
-			crc32_begin(state->f);
-		}
+		prepare_packfile_transaction(transaction);
+		hashfile_checkpoint(state->f, &checkpoint);
+		idx->offset = state->offset;
+		crc32_begin(state->f);
+
 		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 fd, size, path, flags))
+					 fd, size, path))
 			break;
 		/*
 		 * Writing this object to the current pack will make
 		 * it too big; we need to truncate it, start a new
 		 * pack, and write into it.
 		 */
-		if (!idx)
-			BUG("should not happen");
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		flush_packfile_transaction(transaction);
@@ -1627,8 +1646,6 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 			return error("cannot seek back");
 	}
 	git_hash_final_oid(result_oid, &ctx);
-	if (!idx)
-		return 0;
 
 	idx->crc32 = crc32_end(state->f);
 	if (already_written(transaction, result_oid)) {
@@ -1666,18 +1683,28 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	} else {
-		struct object_database *odb = the_repository->objects;
-		struct odb_transaction_files *files_transaction;
-		struct odb_transaction *transaction;
-
-		transaction = odb_transaction_begin(odb);
-		files_transaction = container_of(odb->transaction,
-						 struct odb_transaction_files,
-						 base);
-		ret = index_blob_packfile_transaction(files_transaction, oid, fd,
-						      xsize_t(st->st_size),
-						      path, flags);
-		odb_transaction_commit(transaction);
+		struct odb_write_stream stream = { 0 };
+		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));
+
+		if (flags & INDEX_WRITE_OBJECT) {
+			struct object_database *odb = the_repository->objects;
+			struct odb_transaction_files *files_transaction;
+			struct odb_transaction *transaction;
+
+			transaction = odb_transaction_begin(odb);
+			files_transaction = container_of(odb->transaction,
+							 struct odb_transaction_files,
+							 base);
+			ret = index_blob_packfile_transaction(files_transaction, oid, fd,
+						      xsize_t(st->st_size), path);
+			odb_transaction_commit(transaction);
+		} else {
+			ret = hash_blob_stream(&stream,
+					       the_repository->hash_algo, oid,
+					       xsize_t(st->st_size));
+		}
+
+		free(stream.data);
 	}
 
 	close(fd);
diff --git a/odb/streaming.c b/odb/streaming.c
index 5927a12954..85187541c5 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -287,3 +287,43 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 	odb_read_stream_close(st);
 	return result;
 }
+
+struct read_object_fd_data {
+	int fd;
+	size_t remaining;
+};
+
+static ssize_t read_object_fd(struct odb_write_stream *stream,
+			      unsigned char *buf, size_t len)
+{
+	struct read_object_fd_data *data = stream->data;
+	ssize_t read_result;
+	size_t count;
+
+	if (stream->is_finished)
+		return 0;
+
+	count = data->remaining < len ? data->remaining : len;
+	read_result = read_in_full(data->fd, buf, count);
+	if (read_result < 0 || (size_t)read_result != count)
+		return -1;
+
+	data->remaining -= count;
+	if (!data->remaining)
+		stream->is_finished = 1;
+
+	return read_result;
+}
+
+void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
+			      size_t size)
+{
+	struct read_object_fd_data *data;
+
+	CALLOC_ARRAY(data, 1);
+	data->fd = fd;
+	data->remaining = size;
+
+	stream->data = data;
+	stream->read = read_object_fd;
+}
diff --git a/odb/streaming.h b/odb/streaming.h
index c7861f7e13..e5232cd4d1 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -5,6 +5,7 @@
 #define STREAMING_H 1
 
 #include "object.h"
+#include "odb.h"
 
 struct object_database;
 struct odb_read_stream;
@@ -64,4 +65,11 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 			  struct stream_filter *filter,
 			  int can_seek);
 
+/*
+ * Sets up an ODB write stream that reads from an fd. The caller is expected to
+ * free the underlying stream data.
+ */
+void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
+			      size_t size);
+
 #endif /* STREAMING_H */
-- 
2.53.0.381.g628a66ccf6

