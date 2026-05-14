Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE33A2546
	for <git@vger.kernel.org>; Thu, 14 May 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783883; cv=none; b=izWg3UlvHeCDaJIw60ugMAtbEnmPrNxyzK7WyxyT7O2hqLnItq/fHojllXrqKfzBsRHA8NLQlRU7LtXrHFxwRrbN4Sw/V9p1S03BIzHy5sYYiGZunzp5i5aKXqDAVWv8Yp9PEwy8UO2PW0f3DToD62zLfSCp6oiE/0Eog/QJ2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783883; c=relaxed/simple;
	bh=laEOJp5FTZ4VAnxCSBKa6UKjzdA8/DGLXx2zZset2zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlDvq0AFRxqJCRjIHk4byIwHq9sxmcNMs2rvcvxa/5b3j58rvWrHFGXWCWfKn81JuY1ACFZhgVl3E6dyEC8KZrKFzBUYjYAn5g0l6ZVhdaX6QYXR6CexNQaa+CK5xreYf6OqWItZvzJRW52iK+FR0t3BM2dG8Toe2DytZU1aFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCl0RxXW; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCl0RxXW"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40ea36b56b7so6360256fac.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783880; x=1779388680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajd5BNfdo29tIffLcVoHrE/c4arrjuaOXhIp8+fPQz4=;
        b=LCl0RxXWQvhbxQ6AdZYA88xuZEjpFW4ifL5XUM5Vg2Ee5tAZRZCVf1LDAN/BOOp/I3
         Asy+MIGqwH34rkDQ+OSrlnJJQgb+kFOzZd+ibzxFLz3GtAFBgcHbnxfNAkVLoGBs5XC3
         jOlXCzPfrAOkAIDUkBEJpCNmo1j3Q4FX/wQ5cK+vtkosTlyi3wMqV2C+N+wAvGfFZ23A
         HAaxl/6BfbO+TGbsZ7G4onva4ELvojM3ng+1bBzkmLwFGsM1bp/IX6UoxtsL6o7B/wA8
         oJQUViYDRKVJIoKXQYmAUPxvwAWL5h9mE8ZCSthHrVxxZ5nz0FoLTUmQKLLwgeBxyymq
         oc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783880; x=1779388680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ajd5BNfdo29tIffLcVoHrE/c4arrjuaOXhIp8+fPQz4=;
        b=ZmIPz5V3ZgtKukDo8veaqRyaBEbzVL3AxWwHBH+pNOSTODyp3LoLXou+aIAHlpJ01h
         Vb2iBZNhchNASzfviW1n12E3/3CnrI/TmRK4NeyNFB5o4CPCdJp/hq0Fg9sausrW5C0Z
         x/X6L2/YY+cJSpZskoFggQ2vuuKgx3BMd5nDReWQS9qQDokD5mpd+cMziaYJ3BFpl9pD
         z34ykwEWmZu64WtPZTqznL/eoAZueyWc+6/ycqERsIw6VZXnsPR7PiuTHh9Vf84dvcTr
         0x3VM0sE1mo/58rqjmt4ZFv6HdhGcUFbbERqXiUuus2+yEe+0JD8Sm6ojsHsK5G8ZUuk
         tK9w==
X-Gm-Message-State: AOJu0Ywx9fSpTM/OIcb/Th1KxhMEod6V/RZVYol2KhdhQiu1puR8HPCx
	wUvJMAPytEhEwkVSGi+EKshbI87GH/NUykuPQVjmHHE/5LyzPa+ah6/eCr1Yug==
X-Gm-Gg: Acq92OGGOi1sYKM/OI4+a824I+wqsfcpe38Gz6sSNDEfVRgnPBwmOD2AmPb6sciuWk/
	2ZUH2o5lO5NhGlFhsjVC4JgTvszYPUziHBWjr2LZCgyRij7fZgcBl9ZurKP8iKivV2b6yRhznAl
	VD6x8+R7ouvZ/k79NlAxBAe9xUAxYnXVNz/LreKTRSwMksOKg/33QsozXnydcSRoEOg7Hj9l7Y3
	/2a34ED6JfwazLM5wSo3UY+3rNk3Skm6mDKKeGJd/6F7mlEVl0kaLsFAYlDJRKA3Dkneul2YC6M
	NG65+RRouB6Xg/JXiAiVobrTC9oj8cBg8MlEyIJwxmkfZh4gedwS9WgBm1jglnjUPZt3fDHaAcx
	diP/33wCEyuv45wg+++OlfXeavk4XXGitOy7FZCCrsDh9bwtjD05xXBzYT82utoJg6l2GK2gG+J
	6wq9dWBFvPSG51xG8JRsCp590H6uH/cUZpjV0WJ0xrsw==
X-Received: by 2002:a05:6820:290e:b0:67e:366b:a2b0 with SMTP id 006d021491bc7-69c94292218mr430066eaf.7.1778783880603;
        Thu, 14 May 2026 11:38:00 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4d7ff3sm2405955fac.9.2026.05.14.11.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:37:59 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 4/7] object-file: remove flags from transaction packfile writes
Date: Thu, 14 May 2026 13:37:37 -0500
Message-ID: <20260514183740.1505171-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260514183740.1505171-1-jltobler@gmail.com>
References: <20260402213220.2651523-1-jltobler@gmail.com>
 <20260514183740.1505171-1-jltobler@gmail.com>
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
 object-file.c   | 132 +++++++++++++++++++++++++++++-------------------
 odb/streaming.c |  46 +++++++++++++++++
 odb/streaming.h |  12 +++++
 3 files changed, 138 insertions(+), 52 deletions(-)

diff --git a/object-file.c b/object-file.c
index a1afca23c5..a59030911f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1397,11 +1397,10 @@ static int already_written(struct odb_transaction_files *transaction,
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
@@ -1414,6 +1413,39 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
 		die_errno("unable to write pack header");
 }
 
+static int hash_blob_stream(struct odb_write_stream *stream,
+			    const struct git_hash_algo *hash_algo,
+			    struct object_id *result_oid, size_t size)
+{
+	unsigned char buf[16384];
+	struct git_hash_ctx ctx;
+	unsigned header_len;
+	size_t bytes_hashed = 0;
+
+	header_len = format_object_header((char *)buf, sizeof(buf),
+					  OBJ_BLOB, size);
+	hash_algo->init_fn(&ctx);
+	git_hash_update(&ctx, buf, header_len);
+
+	while (!stream->is_finished) {
+		ssize_t read_result = odb_write_stream_read(stream, buf,
+							    sizeof(buf));
+
+		if (read_result < 0)
+			return -1;
+
+		git_hash_update(&ctx, buf, read_result);
+		bytes_hashed += read_result;
+	}
+
+	if (bytes_hashed != size)
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
@@ -1431,15 +1463,13 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
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
@@ -1474,20 +1504,18 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
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
@@ -1575,8 +1603,7 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  */
 static int index_blob_packfile_transaction(struct odb_transaction_files *transaction,
 					   struct object_id *result_oid, int fd,
-					   size_t size, const char *path,
-					   unsigned flags)
+					   size_t size, const char *path)
 {
 	struct transaction_packfile *state = &transaction->packfile;
 	off_t seekback, already_hashed_to;
@@ -1584,7 +1611,7 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint;
-	struct pack_idx_entry *idx = NULL;
+	struct pack_idx_entry *idx;
 
 	seekback = lseek(fd, 0, SEEK_CUR);
 	if (seekback == (off_t)-1)
@@ -1595,33 +1622,26 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
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
@@ -1629,8 +1649,6 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 			return error("cannot seek back");
 	}
 	git_hash_final_oid(result_oid, &ctx);
-	if (!idx)
-		return 0;
 
 	idx->crc32 = crc32_end(state->f);
 	if (already_written(transaction, result_oid)) {
@@ -1668,18 +1686,28 @@ int index_fd(struct index_state *istate, struct object_id *oid,
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
+		struct odb_write_stream stream;
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
+		odb_write_stream_release(&stream);
 	}
 
 	close(fd);
diff --git a/odb/streaming.c b/odb/streaming.c
index a68dd2cbe3..20531e864c 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -237,6 +237,11 @@ ssize_t odb_write_stream_read(struct odb_write_stream *st, void *buf, size_t sz)
 	return st->read(st, buf, sz);
 }
 
+void odb_write_stream_release(struct odb_write_stream *st)
+{
+	free(st->data);
+}
+
 int odb_stream_blob_to_fd(struct object_database *odb,
 			  int fd,
 			  const struct object_id *oid,
@@ -292,3 +297,44 @@ int odb_stream_blob_to_fd(struct object_database *odb,
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
+	stream->is_finished = 0;
+}
diff --git a/odb/streaming.h b/odb/streaming.h
index 65ced911fe..2a8cac19a4 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -5,6 +5,7 @@
 #define STREAMING_H 1
 
 #include "object.h"
+#include "odb.h"
 
 struct object_database;
 struct odb_read_stream;
@@ -65,6 +66,11 @@ struct odb_write_stream {
 ssize_t odb_write_stream_read(struct odb_write_stream *stream, void *buf,
 			      size_t len);
 
+/*
+ * Releases memory allocated for underlying stream data.
+ */
+void odb_write_stream_release(struct odb_write_stream *stream);
+
 /*
  * Look up the object by its ID and write the full contents to the file
  * descriptor. The object must be a blob, or the function will fail. When
@@ -82,4 +88,10 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 			  struct stream_filter *filter,
 			  int can_seek);
 
+/*
+ * Sets up an ODB write stream that reads from an fd.
+ */
+void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
+			      size_t size);
+
 #endif /* STREAMING_H */
-- 
2.54.0.105.g59ff4886a5

