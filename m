Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C93BE64D
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165577; cv=none; b=PUt3GSp+xPapl7Fgcg0CLY1QoHuvwI0RTRsBGOa0bkgHAv3+c0Qp/nYSW09OLq8gBHiEPybH6QUeSG7UY6Mc/xX079hV/oYEWsxugNYDr0hQTG/Gad088vyyKgCchARrrW0Xl7rHR95AYa9Rlk5X7/V0/7DZPZ2kweFMK6kx/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165577; c=relaxed/simple;
	bh=l0g5JblmZaOuQm5Apfm4Zj2HExNOclMCXNVeWI7o0OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSFvB7ikcxcXNvkfiTyxrvxMV7kRwfOS4Fu5WaM279ttMMt4tEJc9G4ppXLyH3KIl4Z6PS8rjLbi2helGIBu/GhQGZ58XcsqEzXRLAO4ZW4tzvOs6vt6IqkwRodStXw8TQ7wXib2wHHC8/gXvFjaNWIXTcTZQe/o2KTyz4/1hhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhjYkCXU; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhjYkCXU"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-415e568a7ecso545451fac.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165574; x=1775770374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B95k0c/0SffJGWTo5QTCiZAZT5wLJVXCV/3PFNYzAM=;
        b=UhjYkCXUr0kQYatfDfmnRbKn5VztyLbD+WE1OROOdldA9VkdMC0p74JseXGpn6kJd2
         /YuZl0f/GnHV+j0SL2D/CDlI/axYg+zxOXDsg3ao6IDbnzei3Fb5Almc+YxM3/ABTS/Y
         qZKnf4QRNaUKYyj2C2jECZrXkoS/sZaRVEjU6a6NdCY1TySomldbz2zGSY8+riRUmstu
         3PSQW7Nf+uZDzIMo/38XcFcq0rh5SjZG/mZ7mB7DH2wCRCyyd/Z2XBoapl9pzhHMWohp
         /flNMn5PzzNjraiN4uWM+6asz2mdPRDNQZ3ZZoLOfAMVk+vvk5kHJFTq/VMRZz3jWLMi
         MJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165574; x=1775770374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2B95k0c/0SffJGWTo5QTCiZAZT5wLJVXCV/3PFNYzAM=;
        b=kB+ERboUsbyW/oQvHbI7VsKJFrYGDQ0n7INKrNMYjfwYNrbKutZV51XLw74nyTgCVT
         z3hGByJCmytCK3vqWSOJcYG2RetF150hefjnErn4vFd9rmLepqUFOjS6m2s/j3Yy0iak
         0cx7bQ8Am62N1Ukyw3z+LHZPXyoLWgVJAuTY/2ZmDTB+1IMRs2JiaDifr9LoWjnQAQtq
         l5G5QU6iYycbRjLNGxpJSh0sJGOf4BiJ9iROGUzgoy9loJJQK4VxR8XZAexOYMifB/ZW
         9/oBU8psrOPdc6gNz1LBqFVKa3Y9hJrfJUi0Axhab+8unMeVIvzSQZ37fXGTj/4cv0oF
         jrQw==
X-Gm-Message-State: AOJu0YywZ7UCGo3piTGmOuWZ+fgffy4u7UYV0o8NjUT2RvQanSc9nI52
	a0SifQ7lFbntI5c2Yl89e953RlzB3hOZ6kOvwYKWHMfj0XthxWr0cHcx/RbdMQ==
X-Gm-Gg: AeBDiev07ghk/gL0FjVR/JEu7M6O44p41a9gf8nd0DuuUPsY+d1gwgV4GJU3HVv4Uka
	wO9cnr023U5bZlEG25FJ8NyblBMKugYB/JKC+N5Gz2cjLaJgiaqk+5m5ojmM9Qu2CzKjoCvcQ0J
	r9JwFQyoe3RM/3KNB5iGoZC6suEig421BEdclWqbRBouw5aQ3VCgmoZU8nor1EaMRwS7Vgy/joU
	Hwe3ChQnbrim7W8nqbjTFmVpyKgyii+6l9Qv1mAGcK4VgAr1MRVE2ZcImsPVxSvugb+4t0MOypq
	e5mcwoANOH1qlsrNL/yasS9HwC3Vnt8X/A4YJbTwIDQNAtPq//o3IdEikVRzH9DiXdiLJngkMOi
	X1dTyMheVoHooHP4fym+SqKkvVigmSDhX+M9aTtmUZ4x565oG/RNsatX0j30riVuIEAHW4aWqae
	3+SJezT/z0Wp+V3+zk2JyJKJqxtWcxmik=
X-Received: by 2002:a05:6870:8906:b0:41c:216b:841b with SMTP id 586e51a60fabf-423100c4085mr302226fac.37.1775165574038;
        Thu, 02 Apr 2026 14:32:54 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm3325030fac.6.2026.04.02.14.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:32:53 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 6/7] object-file: generalize packfile writes to use odb_write_stream
Date: Thu,  2 Apr 2026 16:32:19 -0500
Message-ID: <20260402213220.2651523-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260402213220.2651523-1-jltobler@gmail.com>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
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
index 0284d5434b..7fa2b9239f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1446,18 +1446,19 @@ static int hash_blob_stream(struct odb_write_stream *stream,
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
 
@@ -1466,23 +1467,21 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
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
@@ -1502,6 +1501,11 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
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
 
@@ -1573,10 +1577,13 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
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
@@ -1610,7 +1617,7 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	hashfile_checkpoint(state->f, &checkpoint);
 	idx->offset = state->offset;
 	crc32_begin(state->f);
-	stream_blob_to_pack(state, &ctx, fd, size, path);
+	stream_blob_to_pack(state, &ctx, size, stream);
 	git_hash_final_oid(result_oid, &ctx);
 
 	idx->crc32 = crc32_end(state->f);
@@ -1654,15 +1661,12 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 
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
2.53.0.381.g628a66ccf6

