Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D84391833
	for <git@vger.kernel.org>; Thu, 14 May 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783884; cv=none; b=C6q2yP3E7y7hYwVw+sNgNNemdXZQ62iEIRFuH0F5jbdIbKtzR++OEq6ho6gLX47jATZVR/qLS/XR12A9UYGNyq/1Sh/Sso2uxRc+HVSH/NasJyeCh2C/ngpMO20tr8GEYr73ydinFDvJQFkCDAjH1QW6aO000AFbIU7no7XQHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783884; c=relaxed/simple;
	bh=z5s2H3h57+q7+5w7gzXZnYaGgo3VNiEhXY8v+ekxKbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI7fKqqJ4ZetsEb7cylP9Mbh3CzfdmAlYqRzsKhU01K5pCXGvoGhaVIBiUpE5zOIynM2ZN4JoKA41mQPyrb1Ohthutn/HGrrMwWyL6DuA1xC5yTTYDmbQoL9dq6/r/Ng7YV7G6K/swsw3OWjLociBLLEDcsvn3lIIpLnvN2tyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpT6C9EU; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpT6C9EU"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-439c00ed7e0so2593980fac.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783881; x=1779388681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lojtYkYNoeWSv8cVxhWchhxwWjfyi8gRsqL9BQWTBIs=;
        b=VpT6C9EU+UsYc0sWiZLG3q2GYVUAv722Vg680iFMagUkgP0GXaEYZrCyqZUeI/Vyay
         +7oNfB7/uUH/BAL7mcZXUsTiZqifn6QeGosHZVJCw2dnXUq0faIaB+OKuSHH+7edKK74
         MPdQH2htk6GQcTg/CGMOkP3mLHB0x3Oc29Nb3dtTPwcZZWQnMhEgOKN/LiG1AENwJwvg
         Mo9ZGp1+5W1YwA1Ub50vlzGfr7aCMzF1QWSj7Rar7sWTHX+jsFjHpgfo+fG0vcBSYNAy
         6Uc0k+LTNpJdFukIsqhcIO/ryQMdlAIRAR7jxxmNlIpsI1Fyy/n5o6KS+nzwFoN1AM/n
         P3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783881; x=1779388681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lojtYkYNoeWSv8cVxhWchhxwWjfyi8gRsqL9BQWTBIs=;
        b=GYDrc4d0R3Ebkt44lGzLupOZiprXVd1Kd9VqSFBAGpJ3xCc62it18MY4S+SsRKGxM+
         R9gvkodIGnEh7cU1M5RcSL6b94p9ux/Vj3U6oZBF4QrPZqaDkHIv9OrsuCWr6K3DvpgQ
         8XXVkNlMBKpUzav10ji6yiHdVlkWjmw0gRhufK+VljPOoq1vmXCvHQGSJGICmxrO4dWA
         DImNxSMRnPjmCc3Qt5zZISasv2/XpLnGazicXOLIJsZDD1GGj3/OqbM8ovPZR5KNR5/3
         M/kNysMwSZLlbVtdcDNJN+V2QMHGmKhinfeMVSOZTxpMJLnQfLbVoMX6OV8rnjKq9zm/
         aLDA==
X-Gm-Message-State: AOJu0YyxfLa5xB+UO6ki8x5NXkHEagDOjhUfG/AtBUreWTLvx+w8OI3A
	27v1R67ipZScS8DdYKN3A0tUAdi/ybP0uXd6iLeiPHI33kVAh2RiZ6Xq6neNTQ==
X-Gm-Gg: Acq92OGKEucl1+DyB0ekmyOYfTNQez8vj/NV07Gp/AyUyMpLJxv8oB3reyz/rlF4FM8
	cydXxnYnb0MV6qU4lhWOMYqdkGBNysuPXRnHEfE/nzeYWZxfCH4kRmsHI/I3kuGVWosNIgLMXiO
	+NwcBC3s+V/wEtugIoGJapd4uKhy7iJ5ooKbnGY64VZPS6Wilx/AA9+/biX6w7A1QNMe2E+D3sr
	Y+fhEdg+NMwvXOOUf9Al+mIadI1bYrFcwxb6bCBM1Dn52VyHJZruv1rhXxszJjVTrAJqCo536vd
	8dqbXO8Hnto3z0ab6M7PJHnu3+Asl4j/JFowLTs3Ko0TVacRqRD9A9xV+5dhkvHXvEaS/L+8YT6
	jViakaCh8THJZVbg2XNfLVxf+zKagBX6gIGE6bZWi11SQ3HEL+hKcmNGYeUAdVRtKBvirT6Q+/W
	ahwc0Ovg9XwYYmb/hWMnvZ+VQMqeD7C7428C45HJhuQg==
X-Received: by 2002:a05:6870:1428:b0:424:23a2:5cd with SMTP id 586e51a60fabf-43a2d8f450cmr579243fac.6.1778783881385;
        Thu, 14 May 2026 11:38:01 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4d7ff3sm2405955fac.9.2026.05.14.11.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:38:00 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 5/7] object-file: avoid fd seekback by checking object size upfront
Date: Thu, 14 May 2026 13:37:38 -0500
Message-ID: <20260514183740.1505171-6-jltobler@gmail.com>
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

In certain scenarios, Git handles writing blobs that exceed
"core.bigFileThreshold" differently by streaming the object directly
into a packfile. When there is an active ODB transaction, these blobs
are streamed to the same packfile instead of using a separate packfile
for each. If "pack.packSizeLimit" is configured and streaming another
object causes the packfile to exceed the configured limit, the packfile
is truncated back to the previous object and the object write is
restarted in a new packfile.

This works fine, but requires the fd being read from to save a
checkpoint so it becomes possible to rewind the input source via seeking
back to a known offset at the beginning. In a subsequent commit, blob
streaming is converted to use `struct odb_write_stream` as a more
generic input source instead of an fd which doesn't provide a mechanism
for rewinding.

For this use case though, rewinding the fd is not strictly necessary
because the inflated size of the object is known and can be used to
approximate whether writing the object would cause the packfile to
exceed the configured limit prior to writing anything. These blobs
written to the packfile are never deltified thus the size difference
between what is written versus the inflated size is due to zlib
compression. While this does prevent packfiles from being filled to the
potential maximum is some cases, it should be good enough and still
prevents the packfile from exceeding any configured limit.

Use the inflated blob size to determine whether writing an object to a
packfile will exceed the configured "pack.packSizeLimit".

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 86 +++++++++++++++------------------------------------
 1 file changed, 25 insertions(+), 61 deletions(-)

diff --git a/object-file.c b/object-file.c
index a59030911f..6d7afdb723 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1448,29 +1448,17 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 
 /*
  * Read the contents from fd for size bytes, streaming it to the
- * packfile in state while updating the hash in ctx. Signal a failure
- * by returning a negative value when the resulting pack would exceed
- * the pack size limit and this is not the first object in the pack,
- * so that the caller can discard what we wrote from the current pack
- * by truncating it and opening a new one. The caller will then call
- * us again after rewinding the input fd.
- *
- * The already_hashed_to pointer is kept untouched by the caller to
- * make sure we do not hash the same byte when we are called
- * again. This way, the caller does not have to checkpoint its hash
- * status before calling us just in case we ask it to call us again
- * with a new pack.
+ * packfile in state while updating the hash in ctx.
  */
-static int stream_blob_to_pack(struct transaction_packfile *state,
-			       struct git_hash_ctx *ctx, off_t *already_hashed_to,
-			       int fd, size_t size, const char *path)
+static void stream_blob_to_pack(struct transaction_packfile *state,
+				struct git_hash_ctx *ctx, int fd, size_t size,
+				const char *path)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
 	unsigned char obuf[16384];
 	unsigned hdrlen;
 	int status = Z_OK;
-	off_t offset = 0;
 
 	git_deflate_init(&s, pack_compression_level);
 
@@ -1487,15 +1475,9 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 			if ((size_t)read_result != rsize)
 				die("failed to read %u bytes from '%s'",
 				    (unsigned)rsize, path);
-			offset += rsize;
-			if (*already_hashed_to < offset) {
-				size_t hsize = offset - *already_hashed_to;
-				if (rsize < hsize)
-					hsize = rsize;
-				if (hsize)
-					git_hash_update(ctx, ibuf, hsize);
-				*already_hashed_to = offset;
-			}
+
+			git_hash_update(ctx, ibuf, rsize);
+
 			s.next_in = ibuf;
 			s.avail_in = rsize;
 			size -= rsize;
@@ -1506,14 +1488,6 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 		if (!s.avail_out || status == Z_STREAM_END) {
 			size_t written = s.next_out - obuf;
 
-			/* would we bust the size limit? */
-			if (state->nr_written &&
-			    pack_size_limit_cfg &&
-			    pack_size_limit_cfg < state->offset + written) {
-				git_deflate_abort(&s);
-				return -1;
-			}
-
 			hashwrite(state->f, obuf, written);
 			state->offset += written;
 			s.next_out = obuf;
@@ -1530,7 +1504,6 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 		}
 	}
 	git_deflate_end(&s);
-	return 0;
 }
 
 static void flush_packfile_transaction(struct odb_transaction_files *transaction)
@@ -1606,48 +1579,39 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 					   size_t size, const char *path)
 {
 	struct transaction_packfile *state = &transaction->packfile;
-	off_t seekback, already_hashed_to;
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint;
 	struct pack_idx_entry *idx;
 
-	seekback = lseek(fd, 0, SEEK_CUR);
-	if (seekback == (off_t)-1)
-		return error("cannot find the current offset");
-
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
 	transaction->base.source->odb->repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
+	/*
+	 * If writing another object to the packfile could result in it
+	 * exceeding the configured size limit, flush the current packfile
+	 * transaction.
+	 *
+	 * Note that this uses the inflated object size as an approximation.
+	 * Blob objects written in this manner are not delta-compressed, so
+	 * the difference between the inflated and on-disk size is limited
+	 * to zlib compression and is sufficient for this check.
+	 */
+	if (state->nr_written && pack_size_limit_cfg &&
+	    pack_size_limit_cfg < state->offset + size)
+		flush_packfile_transaction(transaction);
+
 	CALLOC_ARRAY(idx, 1);
 	prepare_packfile_transaction(transaction);
 	hashfile_checkpoint_init(state->f, &checkpoint);
 
-	already_hashed_to = 0;
-
-	while (1) {
-		prepare_packfile_transaction(transaction);
-		hashfile_checkpoint(state->f, &checkpoint);
-		idx->offset = state->offset;
-		crc32_begin(state->f);
-
-		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 fd, size, path))
-			break;
-		/*
-		 * Writing this object to the current pack will make
-		 * it too big; we need to truncate it, start a new
-		 * pack, and write into it.
-		 */
-		hashfile_truncate(state->f, &checkpoint);
-		state->offset = checkpoint.offset;
-		flush_packfile_transaction(transaction);
-		if (lseek(fd, seekback, SEEK_SET) == (off_t)-1)
-			return error("cannot seek back");
-	}
+	hashfile_checkpoint(state->f, &checkpoint);
+	idx->offset = state->offset;
+	crc32_begin(state->f);
+	stream_blob_to_pack(state, &ctx, fd, size, path);
 	git_hash_final_oid(result_oid, &ctx);
 
 	idx->crc32 = crc32_end(state->f);
-- 
2.54.0.105.g59ff4886a5

