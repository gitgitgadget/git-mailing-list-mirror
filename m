Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16302BE056
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928347; cv=none; b=Sy/eBVO4Y/T9L8jqejO2hEInBpAegX3xTuegYh/Vz1yiKApaoL1oYsoTq+B46YjzBn5dVeZtyJRrSdvt7pSNAp5xot0S/aoWce0Wwf9IawLmON55v79IIeg617IAWP3oOSTTWX3/UL5iDSruY0OJDJ6xsQVWkQvCJLnxMafnJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928347; c=relaxed/simple;
	bh=cVuJ7l48GtEKJs22ET01m8y4N86Rg5fKRdmM6sBkuE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CymgyVBshYpVtMJtjgCHJ6o/uE56+2dEbL/cV25JXvfsvG1bUaoj59qwbbmZfVdKdKuASnHpwdZEjtvw6h3UjYiMnNPGK5CBriCOEp+/un7HZgQRBup8Ab4U5HqCFx8Eee6IhYIRpZ7UA0wbuYL4VMBN/9W6yrdqKwxMNesj8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlZ+m5NL; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlZ+m5NL"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7e565c877so2580984a34.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774928344; x=1775533144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46cPjVYtsDLCM/+bqyRmeBti59ztiT/906wNxsqCczo=;
        b=IlZ+m5NLCmlSwmdH90nk1iOSw2HVTXH5ZeBmnShgEdtX+t0LH7njV74HsflqJOXcQk
         /vpLrgbOuMK1GL8KeGci4XsnJglY0MaIsFOyWNx75Qr/TJez7+/HhQEOIDsNOLI9C+uE
         nsEtYzwaV6Ikt1bVq020DWuCeJsOyKTKd5pQwrIYzq0tzYt3sYIoLee/8iYg8Rs3bijq
         9aANb2wYOU3CF02i9GZ8OFm0mKrdedV49V1IAyOCk/ktQHyrSRSETHKMUnVR/0QjNQ2F
         p3f7dl0yYjie0RU9JdBb6HrIqhOzP3OclnAfCzSVX/1FjccYxMLO+pDGq/881MouagAc
         ptdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774928344; x=1775533144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=46cPjVYtsDLCM/+bqyRmeBti59ztiT/906wNxsqCczo=;
        b=ENDNjl9GYTvs4jzsAOmHY9TY7ePYAdsldTPOQMpCZeFJNEvPn96B54DbWe2/3BTcT0
         DFchHBCuvJIEFDIVv2aCW1Sr/fP+t54DgbOl4XZPJMmW/JSluzPf6T5h2zOwTZY02KDX
         YdhIk2234WPxJnMLsmGYS57P25SC+hp4B2HBcY4WxX5bNhcItDXvGG1QEwic6Mogf40z
         mGENDMaBYEt+nIbVSr9aJzdkCtH4rNfKuXR5TC3f9EwjnJqKAfVhCRZkeTDvO69sSBR/
         UrbNvMWwaZ69DxZBz8mRhthR0JNaM/gQw7QrIqYWBjbBAffGMoNO7J2kJRbUli4DOvGT
         F4Qg==
X-Gm-Message-State: AOJu0YxF3lY10jX4431IuSRdQRmICK6Ii3IRQXSezgTuQy7oFw10+17t
	goKyMSp6/e8QNrBMkwb7nxjAHPNX3jZd2vS3qXBw5ctjLbQY9rZJWoa1l50eJA==
X-Gm-Gg: ATEYQzxjs8/7vgolG4wzbST0CmWY38rf+iO+OFtZsPT0R5sJxyShMAn0hon3dMeqoq+
	23ccGHzkDGhpfCIQ6iaDVZgzSqsrnCW2Fu8+8wUFoQZ7G7TRNlGB/r0KCFVJYWI0fIoncF3kLiv
	r8qWaWb8GxlZQSxmxoPIdN6go0M1l1RqurMyVPLAGj0Yyt6+bPZQ3VXSL24oJkYdIv7cszfUDK4
	gUUFGKYWLaX9KlrhwZRX9hNIC1+TrDPbohRXnGQA51FCRkFrUz/nGeJS8fEoY37J5nxGSwR62/9
	JBd53g9lVmhdpUcPO3OjE53UDdH7WauSlqdve/3YY0YVVNy7PwVdi9QFSprN9UtqsDuqBYC+CZL
	458rQlCMy8rUeNBATL8F0uvxvRLYzCk8/eQER7JCH/2dSZdvstmBdy5wKkLBKPzB4JzRZKlh6ee
	gF9xYWa3Iuf7uXzUktmJLPy5RS+up2ByI=
X-Received: by 2002:a05:6830:7007:b0:7d7:d1f0:300e with SMTP id 46e09a7af769-7d9faee106bmr8659588a34.24.1774928344356;
        Mon, 30 Mar 2026 20:39:04 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a3b2e37sm7494665a34.10.2026.03.30.20.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:39:03 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 5/6] object-file: generalize packfile writes to use odb_write_stream
Date: Mon, 30 Mar 2026 22:38:34 -0500
Message-ID: <20260331033835.2863514-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260331033835.2863514-1-jltobler@gmail.com>
References: <20260331033835.2863514-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `index_blob_packfile_transaction()` function streams blob data
directly from an fd. This makes it difficult to reuse as part of a
generic transactional object writing interface.

Refactor the packfile write path to operate on a `struct
odb_write_stream`, allowing callers to supply data from arbitrary
sources.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 99 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 29 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1de2244ac5..4c797d6498 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1433,18 +1433,18 @@ static int hash_blob_stream(const struct git_hash_algo *hash_algo,
 }
 
 /*
- * Read the contents from fd for size bytes, streaming it to the
+ * Read the contents from the stream provided, streaming it to the
  * packfile in state while updating the hash in ctx.
  */
 static void stream_blob_to_pack(struct transaction_packfile *state,
-				struct git_hash_ctx *ctx, int fd, size_t size,
-				const char *path)
+				struct git_hash_ctx *ctx, size_t size,
+				struct odb_write_stream *stream)
 {
 	git_zstream s;
-	unsigned char ibuf[16384];
 	unsigned char obuf[16384];
 	unsigned hdrlen;
 	int status = Z_OK;
+	size_t total = 0;
 
 	git_deflate_init(&s, pack_compression_level);
 
@@ -1453,24 +1453,19 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 	s.avail_out = sizeof(obuf) - hdrlen;
 
 	while (status != Z_STREAM_END) {
-		if (size && !s.avail_in) {
-			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
-			ssize_t read_result = read_in_full(fd, ibuf, rsize);
-			if (read_result < 0)
-				die_errno("failed to read from '%s'", path);
-			if ((size_t)read_result != rsize)
-				die("failed to read %u bytes from '%s'",
-				    (unsigned)rsize, path);
+		if (!stream->is_finished && !s.avail_in) {
+			unsigned long rsize;
+			unsigned const char *buf = stream->read(stream, &rsize);
 
 			if (rsize)
-				git_hash_update(ctx, ibuf, rsize);
+				git_hash_update(ctx, buf, rsize);
 
-			s.next_in = ibuf;
+			s.next_in = (unsigned char *)buf;
 			s.avail_in = rsize;
-			size -= rsize;
+			total += rsize;
 		}
 
-		status = git_deflate(&s, size ? 0 : Z_FINISH);
+		status = git_deflate(&s, stream->is_finished ? Z_FINISH : 0);
 
 		if (!s.avail_out || status == Z_STREAM_END) {
 			size_t written = s.next_out - obuf;
@@ -1490,6 +1485,10 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 			die("unexpected deflate failure: %d", status);
 		}
 	}
+
+	if (total != size)
+		die("unexpected number of bytes read");
+
 	git_deflate_end(&s);
 }
 
@@ -1543,6 +1542,40 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
 	odb_reprepare(repo->objects);
 }
 
+struct read_object_fd_data {
+	int fd;
+	size_t size;
+	unsigned char buf[16384];
+};
+
+static const void *read_object_fd(struct odb_write_stream *stream,
+				  unsigned long *len)
+{
+	struct read_object_fd_data *data = stream->data;
+	ssize_t read_result;
+	size_t rsize;
+
+	if (stream->is_finished) {
+		*len = 0;
+		return NULL;
+	}
+
+	rsize = data->size < sizeof(data->buf) ? data->size : sizeof(data->buf);
+	read_result = read_in_full(data->fd, data->buf, rsize);
+	if (read_result < 0)
+		die_errno("failed to read blob data");
+	if ((size_t)read_result != rsize)
+		die("failed to read %u bytes of blob data", (unsigned)rsize);
+
+	data->size -= rsize;
+	if (!data->size)
+		stream->is_finished = 1;
+
+	*len = rsize;
+
+	return data->buf;
+}
+
 /*
  * This writes the specified object to a packfile. Objects written here
  * during the same transaction are written to the same packfile. The
@@ -1561,10 +1594,13 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_blob_packfile_transaction(struct odb_transaction_files *transaction,
-					   struct object_id *result_oid, int fd,
-					   size_t size, const char *path)
+static int index_blob_packfile_transaction(struct odb_transaction *base,
+					   struct odb_write_stream *stream,
+					   size_t size, struct object_id *result_oid)
 {
+	struct odb_transaction_files *transaction = container_of(base,
+								 struct odb_transaction_files,
+								 base);
 	struct transaction_packfile *state = &transaction->packfile;
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
@@ -1593,7 +1629,7 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	hashfile_checkpoint(state->f, &checkpoint);
 	idx->offset = state->offset;
 	crc32_begin(state->f);
-	stream_blob_to_pack(state, &ctx, fd, size, path);
+	stream_blob_to_pack(state, &ctx, size, stream);
 	git_hash_final_oid(result_oid, &ctx);
 
 	idx->crc32 = crc32_end(state->f);
@@ -1634,15 +1670,20 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 	} else {
 		if (flags & INDEX_WRITE_OBJECT) {
 			struct object_database *odb = the_repository->objects;
-			struct odb_transaction_files *files_transaction;
-			struct odb_transaction *transaction;
-
-			transaction = odb_transaction_begin(odb);
-			files_transaction = container_of(odb->transaction,
-							 struct odb_transaction_files,
-							 base);
-			ret = index_blob_packfile_transaction(files_transaction, oid, fd,
-						      xsize_t(st->st_size), path);
+			struct odb_transaction *transaction = odb_transaction_begin(odb);
+			struct read_object_fd_data data = {
+				.fd = fd,
+				.size = xsize_t(st->st_size),
+			};
+			struct odb_write_stream in_stream = {
+				.read = read_object_fd,
+				.data = &data,
+			};
+
+			ret = index_blob_packfile_transaction(odb->transaction,
+							      &in_stream,
+							      xsize_t(st->st_size),
+							      oid);
 			odb_transaction_commit(transaction);
 		} else {
 			if (hash_blob_stream(the_repository->hash_algo, oid, fd,
-- 
2.53.0.381.g628a66ccf6

