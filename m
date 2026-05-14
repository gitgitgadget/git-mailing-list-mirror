Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737639E184
	for <git@vger.kernel.org>; Thu, 14 May 2026 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783884; cv=none; b=MeC3NvAxnobc4AGlL048U5IH8e78GBSG72nXm+TWBhNakcp3jYuJKkF9FUHwGbSjNODjFI/qSJSfLOn4f/VQfuuFRQf/1TSAUXaCYIu3UX2X5P7kbrfLjyK4LiguI5+sxtjvJ0AieIySBcQFGDWbpBIvLBkRebvet723QviSQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783884; c=relaxed/simple;
	bh=bl9AeoL1hU0mS9K12lrlimYskqU/smewYnu5gGQosow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaWT7uEOEPPoeAlpVddHyqti6JMnwRhWzX1eIoQ71qUMizY74IRSbkbj/wRgFyaRy5fDUru7LKkrgamoqYn3YJVUJkvnSm6nfDa17uFNhOm/jg0fSzbm/zKHoXDjaU36oz3H97KquQZ73F27pbWsMDV6EhVZsI5GgNggsQoXL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0kK4j/N; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0kK4j/N"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-439712b3416so1654853fac.2
        for <git@vger.kernel.org>; Thu, 14 May 2026 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783882; x=1779388682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJZd47IQIT2qmg5eq1Xcq2csypNNAXKqKKd574y7zAQ=;
        b=I0kK4j/Ney3TDGXxVB5Iu/fggHqDtVsP2LtSW9bDyYuab2xZY4272TA55wqwlMCDVA
         AnxNKjY2Qdiva75cmg8KgUM6BEhQ/h/clDmjWz9/H4N7tf64vrGQoH35HWHH26eGn0iF
         zedTtFzT78EdIE3/xI0ZPCvMve4XjjJogNipPd66noX/8UvUqfOwIY5b5hBLJ8Cshq0C
         GfRtXa28ZAWM9ULaPgcoIoA8Ar2Syuue8xRcZcyr4JeNyzmHAGo1ugmQKUcC+nrVhBAC
         zs/fqF4zyDE4ZtcIrEj994qTIxMl5ip3r0JT3SYY3sffM/n8UmoiPPzWESyqmsGqQxdP
         HlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783882; x=1779388682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJZd47IQIT2qmg5eq1Xcq2csypNNAXKqKKd574y7zAQ=;
        b=Us17DC1O1F/wvmqhflvrPdKk1j4RxLb8iZMUpzSu1k+tzBZzPFIhbeMdLiyGpysI9N
         IPvGVnaihx5e0XBCb7tpm9tmq61fVVxZUFush9Y8rs6V4gYKqtrdDREIia2WzE3wqLSI
         TPQqRQlAywEk7tmIK81B/EmKKaMTbZTXJEkUFvT+fql3O7nO+CM+zzzqTWORs81abAb3
         +E7VdjXwrGn10jMKgX6ubQ39qqCl12YOw31zCwTsGkNbUJLzTIq21NHxp1LAWVtWA0mM
         Z6JQnaSay7T18uO8+ZMy+CmuAl8UlaPt1I50R2ftDSwkopvFEjQOErb/+9FqAUlhYJ/D
         B2AQ==
X-Gm-Message-State: AOJu0YxWfjBHedeEursRoc4FcUdhB+A3SUabWkqZSI9KrR9n+nh4aoTx
	0gdzeyX4JnWHIJr3ZagVhph6x+zcdwXJ6lqP9xoi3eFeyWYY1RmNr33IY0Vjlw==
X-Gm-Gg: Acq92OEVasEcuI/FxaOzWlRNTZgIJEELZtDop9Y/Dz1XBMpAEOnF0qoNaRML4u2Fpuv
	60JAYHBx+ZGjiIswY2NJ45M+YtW1Ov3hn8NswT17LLVjiqEh5sQW+uvewJrVssvTpRy0T5JUg1F
	gIOnlIuxC/UsLl9ZoQik44zPo1C53WM85CclDEMFprCyCXRx1csOzPt57jP9Tzcf9ikFnZ6QF/r
	iDMXYgS1clw5FBdbnEcVxIao44VRxqHhm0SltNLqXfgL+VEEgzrWxXrlA7pNKAnil9PFKQOt/Yq
	xeJF4gknS3dpyI8E+O9c7cVYlYeUGskqnZRPipAPmJEh2j16toX9BiqtX3Ps/92vkV2AiK5+sRt
	ZP0UAlaMuFNql3X7ZIwaesXYRGeQW0UEICgHMqVF/OZ0H8Fe6Ux6SJ9H/pNu/KbcvIH/ZfQNHfL
	e8ssoTahBaJ/7NTRvB0yS1BUEemBRDtTA=
X-Received: by 2002:a05:6870:fb92:b0:41c:fdd7:5b4d with SMTP id 586e51a60fabf-43a2dce18a4mr513014fac.19.1778783882073;
        Thu, 14 May 2026 11:38:02 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4d7ff3sm2405955fac.9.2026.05.14.11.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:38:01 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 6/7] object-file: generalize packfile writes to use odb_write_stream
Date: Thu, 14 May 2026 13:37:39 -0500
Message-ID: <20260514183740.1505171-7-jltobler@gmail.com>
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

The `index_blob_packfile_transaction()` function streams blob data
directly from an fd. This makes it difficult to reuse as part of a
generic transactional object writing interface.

Refactor the packfile write path to operate on a `struct
odb_write_stream`, allowing callers to supply data from arbitrary
sources.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 56 +++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/object-file.c b/object-file.c
index 6d7afdb723..0d492e6962 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1447,18 +1447,19 @@ static int hash_blob_stream(struct odb_write_stream *stream,
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
 	unsigned char ibuf[16384];
 	unsigned char obuf[16384];
 	unsigned hdrlen;
 	int status = Z_OK;
+	size_t bytes_read = 0;
 
 	git_deflate_init(&s, pack_compression_level);
 
@@ -1467,23 +1468,21 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
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
+			ssize_t rsize = odb_write_stream_read(stream, ibuf,
+							      sizeof(ibuf));
+
+			if (rsize < 0)
+				die("failed to read blob data");
 
 			git_hash_update(ctx, ibuf, rsize);
 
 			s.next_in = ibuf;
 			s.avail_in = rsize;
-			size -= rsize;
+			bytes_read += rsize;
 		}
 
-		status = git_deflate(&s, size ? 0 : Z_FINISH);
+		status = git_deflate(&s, stream->is_finished ? Z_FINISH : 0);
 
 		if (!s.avail_out || status == Z_STREAM_END) {
 			size_t written = s.next_out - obuf;
@@ -1503,6 +1502,11 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 			die("unexpected deflate failure: %d", status);
 		}
 	}
+
+	if (bytes_read != size)
+		die("read %" PRIuMAX " bytes of blob data, but expected %" PRIuMAX " bytes",
+		    (uintmax_t)bytes_read, (uintmax_t)size);
+
 	git_deflate_end(&s);
 }
 
@@ -1574,10 +1578,13 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
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
@@ -1611,7 +1618,7 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	hashfile_checkpoint(state->f, &checkpoint);
 	idx->offset = state->offset;
 	crc32_begin(state->f);
-	stream_blob_to_pack(state, &ctx, fd, size, path);
+	stream_blob_to_pack(state, &ctx, size, stream);
 	git_hash_final_oid(result_oid, &ctx);
 
 	idx->crc32 = crc32_end(state->f);
@@ -1655,15 +1662,12 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 
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
+
+			ret = index_blob_packfile_transaction(odb->transaction,
+							      &stream,
+							      xsize_t(st->st_size),
+							      oid);
 			odb_transaction_commit(transaction);
 		} else {
 			ret = hash_blob_stream(&stream,
-- 
2.54.0.105.g59ff4886a5

