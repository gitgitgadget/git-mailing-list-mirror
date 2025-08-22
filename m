Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A114D599
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898508; cv=none; b=QGRM2x8q2bvaA/R+92uBrQJ3T3TpQfVGSXRmb+Rgny1gTZdSyDn/Amt3D6m5KFuRy1uvNB7KEHRoBV4dEX6GRHfxmI2Jr5ly56a7oEJMp1j+iogw6tV24jU8CJGRV+fA/H21eLUwzzgwi+IVDi0jPsjeLJPZgGzCY34nM5Xh2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898508; c=relaxed/simple;
	bh=miFX0GGHLCgdbvGJ3+NIDleJ/AXsaQXWaTxs10zTWhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDyrDPtzg+a7qMAq5IzP8BynaBImSdm+2HHQO7Bw8ajKbY1JrtoXJZo+Op3bNR4qvFE+H/JScqY+0Er+zBYQuzeL53z37xuy8CdwcjCo73OQ7qBmsSKU9XhnlsF8xYcpn79cVsfysAMSyMd7DxQ8HI0vWPYSrTn/hXgirlRZU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/3THq06; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/3THq06"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74381df8cf1so918124a34.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755898505; x=1756503305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIEvHch/e/eHlz3aeWyL+TDNzjGXtCgkiqoH8MVQm0E=;
        b=R/3THq0660Qqbzj6/yvCXt9vl67zBUC41Ytm9a1e+sSIqCli1pEf4UJhqe90ccDRUk
         W1J9uRMGgYqecUGJbgF7MXpIB3FY3n+F+YwHvvPDmSBIermyU9uQGz8XFBjq9ZSo6Z3q
         O38GvVjPkzulZ6RzhxmqVZZ/Y6ywiC45r4skCFhHtMAICFXqFMD9oQvi/zx1QI+ILBK8
         ik+NIpEvnjTtqn0d8AjmhZOI9eOaYEb3UHZFHX/vKKybb4zTP4M10V875JJb0cHKMpFS
         EA9vGOvjnknZvz+Qh+Jg5o4JqlzF502Zqbr6sZSn90mnbaklV2ATyinnBXJ9luSpV6Ew
         foOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898505; x=1756503305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIEvHch/e/eHlz3aeWyL+TDNzjGXtCgkiqoH8MVQm0E=;
        b=SJWGjC7LAQyOsu6US8yBPKivFpqhoYBbhOaXbj7zAmQC7yOShAi7P3rgTkePh09tvY
         rhxuUEZObvkawS4x1QqZudFPp67Zhbs1naI9uXq9ItqebeRdmUWCGGIDf8hHUpCes5aV
         89o5hbSNe/BjcbTjgxXfZWDINruucmvYO3yh3IXHbHpDTWMcblAkka7IjTGoTIdtEL1r
         ghmio7oaWr09jJaY1YmslTjUQ7B0H7HUwufnrA31gjf2e2airC8TbhixqZ7X31XdjNnI
         OjESlcuufE9jsLcegtMJaQxQ5lL8W3A4Hbza34rDYYQ1FuzsAeapeWP4/+1TwgdYG8dp
         ekwg==
X-Gm-Message-State: AOJu0Yy1vO7cSZADWYaH/E3HtSegOYSM2jZehLOR3hJf5Iyj5PcH5hsL
	CEossLUxLNx+YFn8Hm3GNYaZY5kxIDf4ilQCTi40iWeL+QLDtXVVhOTFaMDP3FxL
X-Gm-Gg: ASbGncvCZcv9Ac9AzCLzUL9dZ7+9VreQfe5yp4+H0FLj1gnp9nAw9h3G1wCsExSTGFK
	6a1uJFBZLjaiT29lL+nEL/o9PvpcH7L560VnlRnCKdy/KdoI6r+cexxroWpk+cIojK1JC9kNQv4
	DzNkJGFGXe7pIwhk5I+4X7seBEq0+qW215omPa4dYf824QXiHuj86l2+YmjTwvOk8eIdAHr+R+N
	06JJXpQX9Ejp0s5hNQXXE14/jxeavYnHWG2xzjNwN/HnuV8/mSRaCVNKxTRYxNrJs05FKDu9DcN
	+0pMnqPaJuANEQf/dS+DCjTK4OBoHZKqyBFU/CerSBYqspBQELDBUSykn+LXvvWtufdLUtnEdtT
	jT0GzOlzvD0I8G/Rht7TjQpNtgjcnz+k=
X-Google-Smtp-Source: AGHT+IE5RHqfSKAlWVyD65ll24getuPRWeyIB5VtZa3FgqPBWzarOfeMvRVzqDGMTeh7GyHSHXrLOQ==
X-Received: by 2002:a05:6830:2b07:b0:742:fb51:7d82 with SMTP id 46e09a7af769-74500a5b6e0mr1858256a34.20.1755898504933;
        Fri, 22 Aug 2025 14:35:04 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61dc78c7814sm156497eaf.22.2025.08.22.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:35:04 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/4] bulk-checkin: remove global transaction state
Date: Fri, 22 Aug 2025 16:34:56 -0500
Message-ID: <20250822213500.1488064-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250821232249.319427-1-jltobler@gmail.com>
References: <20250821232249.319427-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The bulk-checkin subsystem provides an interface to write objects to the
object database in a bulk transaction. The state of an ongoing
transaction is stored across several global variables. This series aims
to remove this global transaction state in favor of storing state in in
`struct object_database`. This is done in preparation for a follow-up
change where the goal is to eventually move these transaction interfaces
into "odb.h".

Changes since V2:

- `index_blob_bulk_checkin()` is combined with
  `deflate_blob_bulk_checkin()` in patch 3 instead of 4.
- Continue to use `repo_get_object_directory()` instead of open coding.

Changes since V1:

- `index_blob_bulk_checkin()` now assumes that the caller always
  provides a setup `struct odb_transaction`. Callers are adjusted to
  ensure this.
- Functions in bulk-checkin.c now consistently access the repository
  through the provided `odb_transaction`.

Thanks,
-Justin

Justin Tobler (4):
  bulk-checkin: introduce object database transaction structure
  bulk-checkin: remove global transaction state
  bulk-checkin: require transaction for index_blob_bulk_checkin()
  bulk-checkin: use repository variable from transaction

 builtin/add.c            |   5 +-
 builtin/unpack-objects.c |   5 +-
 builtin/update-index.c   |   7 +-
 bulk-checkin.c           | 152 +++++++++++++++++++++------------------
 bulk-checkin.h           |  25 ++++---
 cache-tree.c             |   5 +-
 object-file.c            |  30 +++++---
 odb.h                    |   8 +++
 read-cache.c             |   5 +-
 9 files changed, 141 insertions(+), 101 deletions(-)

Range-diff against v2:
1:  5c9358e0b03 = 1:  5c9358e0b03 bulk-checkin: introduce object database transaction structure
2:  4a1b80a6baf = 2:  4a1b80a6baf bulk-checkin: remove global transaction state
3:  ce329932fdd ! 3:  ae5dbd0e1af bulk-checkin: require transaction for index_blob_bulk_checkin()
    @@ Commit message
     
         Update `index_blob_bulk_checkin()` to assume that a valid transaction is
         always provided. Callers are now expected to ensure a transaction is set
    -    up beforehand. The single call site in `object-file.c:index_fd()` is
    -    updated accordingly. Due to how `{begin,end}_odb_transaction()` handles
    -    nested transactions, a new transaction is only created and committed if
    -    there is not already an ongoing transaction.
    +    up beforehand. With this simplification, `deflate_blob_bulk_checkin()`
    +    is no longer needed as a standalone internal function and is combined
    +    with `index_blob_bulk_checkin()`. The single call site in
    +    `object-file.c:index_fd()` is updated accordingly. Due to how
    +    `{begin,end}_odb_transaction()` handles nested transactions, a new
    +    transaction is only created and committed if there is not already an
    +    ongoing transaction.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## bulk-checkin.c ##
    -@@ bulk-checkin.c: int index_blob_bulk_checkin(struct odb_transaction *transaction,
    - 			    struct object_id *oid, int fd, size_t size,
    - 			    const char *path, unsigned flags)
    +@@ bulk-checkin.c: static void prepare_to_stream(struct bulk_checkin_packfile *state,
    + 		die_errno("unable to write pack header");
    + }
    + 
    +-static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    +-				struct object_id *result_oid,
    +-				int fd, size_t size,
    +-				const char *path, unsigned flags)
    ++int index_blob_bulk_checkin(struct odb_transaction *transaction,
    ++			    struct object_id *result_oid, int fd, size_t size,
    ++			    const char *path, unsigned flags)
      {
    ++	struct bulk_checkin_packfile *state = &transaction->packfile;
    + 	off_t seekback, already_hashed_to;
    + 	struct git_hash_ctx ctx;
    + 	unsigned char obuf[16384];
    +@@ bulk-checkin.c: void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
    + 	}
    + }
    + 
    +-int index_blob_bulk_checkin(struct odb_transaction *transaction,
    +-			    struct object_id *oid, int fd, size_t size,
    +-			    const char *path, unsigned flags)
    +-{
     -	int status;
     -
     -	if (transaction) {
    @@ bulk-checkin.c: int index_blob_bulk_checkin(struct odb_transaction *transaction,
     -	}
     -
     -	return status;
    -+	return deflate_blob_to_pack(&transaction->packfile, oid, fd, size, path,
    -+				    flags);
    - }
    - 
    +-}
    +-
      struct odb_transaction *begin_odb_transaction(struct object_database *odb)
    + {
    + 	if (!odb->transaction) {
     
      ## bulk-checkin.h ##
     @@ bulk-checkin.h: void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
4:  08e26647915 ! 4:  a05af82fddb bulk-checkin: use repository variable from transaction
    @@ Commit message
         `pack_compression_level` and `pack_size_limit_cfg` globals are still
         used.
     
    +    Also adapt functions using packfile state to instead access it through
    +    the transaction. This makes some function parameters redundant and go
    +    away.
    +
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## bulk-checkin.c ##
    @@ bulk-checkin.c: static void flush_bulk_checkin_packfile(struct bulk_checkin_pack
     -			    state->written, state->nr_written,
     -			    &state->pack_idx_opts, hash);
     +	strbuf_addf(&packname, "%s/pack/pack-%s.",
    -+		    transaction->odb->sources->path,
    ++		    repo_get_object_directory(transaction->odb->repo),
     +		    hash_to_hex_algop(hash, repo->hash_algo));
     +
     +	finish_tmp_packfile(transaction, &packname, hash);
    @@ bulk-checkin.c: static void flush_batch_fsync(struct odb_transaction *transactio
      	 */
     -	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", repo_get_object_directory(the_repository));
     +	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
    -+		    transaction->odb->sources->path);
    ++		    repo_get_object_directory(transaction->odb->repo));
      	temp = xmks_tempfile(temp_path.buf);
      	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
      	delete_tempfile(&temp);
    @@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin_packfile *sta
      	reset_pack_idx_option(&state->pack_idx_opts);
      
      	/* Pretend we are going to write only one object */
    -@@ bulk-checkin.c: static void prepare_to_stream(struct bulk_checkin_packfile *state,
    - 		die_errno("unable to write pack header");
    - }
    - 
    --static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    --				struct object_id *result_oid,
    --				int fd, size_t size,
    --				const char *path, unsigned flags)
    -+int index_blob_bulk_checkin(struct odb_transaction *transaction,
    -+			    struct object_id *result_oid,
    -+			    int fd, size_t size,
    -+			    const char *path, unsigned flags)
    - {
    -+	struct bulk_checkin_packfile *state = &transaction->packfile;
    - 	off_t seekback, already_hashed_to;
    - 	struct git_hash_ctx ctx;
    - 	unsigned char obuf[16384];
    -@@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    +@@ bulk-checkin.c: int index_blob_bulk_checkin(struct odb_transaction *transaction,
      
      	header_len = format_object_header((char *)obuf, sizeof(obuf),
      					  OBJ_BLOB, size);
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      		if (idx) {
      			hashfile_checkpoint(state->f, &checkpoint);
      			idx->offset = state->offset;
    -@@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    +@@ bulk-checkin.c: int index_blob_bulk_checkin(struct odb_transaction *transaction,
      			BUG("should not happen");
      		hashfile_truncate(state->f, &checkpoint);
      		state->offset = checkpoint.offset;
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
      			return error("cannot seek back");
      	}
    -@@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    +@@ bulk-checkin.c: int index_blob_bulk_checkin(struct odb_transaction *transaction,
      		return 0;
      
      	idx->crc32 = crc32_end(state->f);
    @@ bulk-checkin.c: void prepare_loose_object_bulk_checkin(struct odb_transaction *t
      	if (transaction->objdir)
      		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
      }
    -@@ bulk-checkin.c: void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
    - 	}
    - }
    - 
    --int index_blob_bulk_checkin(struct odb_transaction *transaction,
    --			    struct object_id *oid, int fd, size_t size,
    --			    const char *path, unsigned flags)
    --{
    --	return deflate_blob_to_pack(&transaction->packfile, oid, fd, size, path,
    --				    flags);
    --}
    --
    - struct odb_transaction *begin_odb_transaction(struct object_database *odb)
    - {
    - 	if (!odb->transaction) {
     @@ bulk-checkin.c: void flush_odb_transaction(struct odb_transaction *transaction)
      		return;
      

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0

