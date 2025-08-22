Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38FB2D73AB
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898510; cv=none; b=PT+HVD8dBWycRPni1Iw1IhMJToHziwVe+rNpW7wGXjPm2lTfEpPm1rmI1pYUrS5DttYmruDsc/8VNbRNfGkzOz2m5DtKTaEjhA2D/zA2zuksFX/HZpz3PPmiz0StF2thqZJcmGKmuoPFC7KuB+frMZWsUMJfl/cguHzS5N39V60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898510; c=relaxed/simple;
	bh=LjKin3okWdRD9FtNp1f72l1N8THebS1q71ZQtBkA/HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4sIe39lo2uRDLajc2l3J2oUoeqNLBCn29Eapz5IJ39Yb8i6xQofsrzQSTm8i2LbYy2LljhfJal2OGQuMhMZpl2WL+UY9eEqt/JKKnuEiyxKOrGWmChsTiFboQ+ysM+iPX39Z0T73E1xSYa8exXxIZX7vMdeSrdDjuxy+7Xz2bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4eImv5C; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4eImv5C"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74381dddc44so1195702a34.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755898508; x=1756503308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3iz4HSncF45OFK86uww2/znzkESTRN+7YSg3xLPZIE=;
        b=E4eImv5Cswi4m6W7jfknLzzJtRVVtRTs4lJct7Ah+6lluMOhPnTsihmaoRJ70B9pMW
         0S1dLzDtE7RXF/hDlyw5HS/BH3cx7hcZ5yhwUhqs9elL62ZXHit9zCNBCa+zf3tTIVzy
         h9gvqG3h/KtwSA1nabKObijhOBZducxLt7iQCe7ay8pwIPes31OMbOIsLJv625LeMhbE
         Jo/U1iOwIz2CZIa1Ur7yHB2Avwk+4BNf/nIrXIWRCBsjKTcIz+e7HxMIcrl1W2onz021
         Z8Gd69Wryg2idUWK8WDyBCYGK2Ncmk6BHe5kXn0b5k5fMVtrFv9JyCfw5E44g++aXikk
         FiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898508; x=1756503308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3iz4HSncF45OFK86uww2/znzkESTRN+7YSg3xLPZIE=;
        b=Fi2gCsv89LdA+d+jzAMqBEGoA5JTvsAjD2MZxBUHcJ/791M9Mh5gp7U+0ztQDq00O7
         I8y9kRhlQiU3pDLE6NSn1Ho8Bafpcch1cGTE/rxVzg8XSv+bfB4yvFrNFnHu5vsba1nX
         HkwumHvFylXnmBmnbGbjp+jsYL/I3W+8ui1OsmgNH7I70SCPh5G5c1ITcc4hw6mHulgh
         qtJ/2DFg+X+xaHgwTB7Kapl1giKrftwGV2r0UL8SPn/E0ytm8z6CBgzNWyc1PbumXRdb
         dK/siLSsJb1sYgpw4zYrLjLY8sPTBbLhVeW9aAxsmtRcO+c6BzG9hgAzt3hHRSdzn/LX
         hXZw==
X-Gm-Message-State: AOJu0YyWaTZwrWWep9hbMao508vkdD+ePltjjKJ0YGeZpX/oovboj/JS
	wXNdhuDGyLYLf2PTJ6xQpFIpXfX7j9Tlun9Sx36eaVKRFml0q/YxpDtXo0veURs9
X-Gm-Gg: ASbGncu+ETQHslBY4ze3vbXwN8JAOGe5przfSmvmbqEPC0wG68HjyMVZeHhd/3JL0ui
	d6cZPdKeAQnTWpmCNAuRhazu18u5wjMVmtU3sNjJD/5e6EzaJo7+oKn/XKmadv2ttwtiJqqDi/L
	X/gZVmR0quikR4orWPzQdcj2n/T1EkMZwLXm+iyxHZfl4JX9E6d9KFTvotcCNGixyN26ZGnU+RR
	ujDgZk0yMVKSfl5375/S1V+rk2WuA00ToW+S56nao5kptCnvDkdT5S4WK/riCT/6nBW2fau9QqX
	BAmsUIye1pSCjgdG/GNgSkNf9kShVAwmJ4GMRX7yufSEiwY5/GIPM8oXkSwpaha8EC1sdO2HuMO
	xKa+qlt09agUYLwwRG3Rj+euEW4kAd9I=
X-Google-Smtp-Source: AGHT+IFBKwjqqWyR9qOiXzku1hSPOG9P6t4iTX4Sw4EGuRArXda67xWwMv+izs4jNDRebARUkToqjg==
X-Received: by 2002:a05:6830:dc7:b0:743:968b:3440 with SMTP id 46e09a7af769-74500a6d2e6mr1687163a34.20.1755898507620;
        Fri, 22 Aug 2025 14:35:07 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61dc78c7814sm156497eaf.22.2025.08.22.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:35:07 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/4] bulk-checkin: use repository variable from transaction
Date: Fri, 22 Aug 2025 16:35:00 -0500
Message-ID: <20250822213500.1488064-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822213500.1488064-1-jltobler@gmail.com>
References: <20250821232249.319427-1-jltobler@gmail.com>
 <20250822213500.1488064-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bulk-checkin subsystem depends on `the_repository`. Adapt functions
and call sites to access the repository through `struct odb_transaction`
instead. The `USE_THE_REPOSITORY_VARIBALE` is still required as the
`pack_compression_level` and `pack_size_limit_cfg` globals are still
used.

Also adapt functions using packfile state to instead access it through
the transaction. This makes some function parameters redundant and go
away.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 67 +++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 542d8125a86..124c4930676 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -38,25 +38,26 @@ struct odb_transaction {
 	struct bulk_checkin_packfile packfile;
 };
 
-static void finish_tmp_packfile(struct strbuf *basename,
-				const char *pack_tmp_name,
-				struct pack_idx_entry **written_list,
-				uint32_t nr_written,
-				struct pack_idx_option *pack_idx_opts,
+static void finish_tmp_packfile(struct odb_transaction *transaction,
+				struct strbuf *basename,
 				unsigned char hash[])
 {
+	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct repository *repo = transaction->odb->repo;
 	char *idx_tmp_name = NULL;
 
-	stage_tmp_packfiles(the_repository, basename, pack_tmp_name,
-			    written_list, nr_written, NULL, pack_idx_opts, hash,
-			    &idx_tmp_name);
-	rename_tmp_packfile_idx(the_repository, basename, &idx_tmp_name);
+	stage_tmp_packfiles(repo, basename, state->pack_tmp_name,
+			    state->written, state->nr_written, NULL,
+			    &state->pack_idx_opts, hash, &idx_tmp_name);
+	rename_tmp_packfile_idx(repo, basename, &idx_tmp_name);
 
 	free(idx_tmp_name);
 }
 
-static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
+static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
 {
+	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct repository *repo = transaction->odb->repo;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
 
@@ -73,17 +74,17 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
 		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
-		fixup_pack_header_footer(the_hash_algo, fd, hash, state->pack_tmp_name,
+		fixup_pack_header_footer(repo->hash_algo, fd, hash, state->pack_tmp_name,
 					 state->nr_written, hash,
 					 state->offset);
 		close(fd);
 	}
 
-	strbuf_addf(&packname, "%s/pack/pack-%s.", repo_get_object_directory(the_repository),
-		    hash_to_hex(hash));
-	finish_tmp_packfile(&packname, state->pack_tmp_name,
-			    state->written, state->nr_written,
-			    &state->pack_idx_opts, hash);
+	strbuf_addf(&packname, "%s/pack/pack-%s.",
+		    repo_get_object_directory(transaction->odb->repo),
+		    hash_to_hex_algop(hash, repo->hash_algo));
+
+	finish_tmp_packfile(transaction, &packname, hash);
 	for (uint32_t i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
@@ -94,7 +95,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 
 	strbuf_release(&packname);
 	/* Make objects we just wrote available to ourselves */
-	reprepare_packed_git(the_repository);
+	reprepare_packed_git(repo);
 }
 
 /*
@@ -117,7 +118,8 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
 	 * to ensure that the data in each new object file is durable before
 	 * the final name is visible.
 	 */
-	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", repo_get_object_directory(the_repository));
+	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
+		    repo_get_object_directory(transaction->odb->repo));
 	temp = xmks_tempfile(temp_path.buf);
 	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
 	delete_tempfile(&temp);
@@ -131,16 +133,17 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
 	transaction->objdir = NULL;
 }
 
-static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
+static int already_written(struct odb_transaction *transaction,
+			   struct object_id *oid)
 {
 	/* The object may already exist in the repository */
-	if (odb_has_object(the_repository->objects, oid,
+	if (odb_has_object(transaction->odb, oid,
 			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 1;
 
 	/* Might want to keep the list sorted */
-	for (uint32_t i = 0; i < state->nr_written; i++)
-		if (oideq(&state->written[i]->oid, oid))
+	for (uint32_t i = 0; i < transaction->packfile.nr_written; i++)
+		if (oideq(&transaction->packfile.written[i]->oid, oid))
 			return 1;
 
 	/* This is a new object we need to keep */
@@ -239,13 +242,15 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 }
 
 /* Lazily create backing packfile for the state */
-static void prepare_to_stream(struct bulk_checkin_packfile *state,
+static void prepare_to_stream(struct odb_transaction *transaction,
 			      unsigned flags)
 {
+	struct bulk_checkin_packfile *state = &transaction->packfile;
 	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
 		return;
 
-	state->f = create_tmp_packfile(the_repository, &state->pack_tmp_name);
+	state->f = create_tmp_packfile(transaction->odb->repo,
+				       &state->pack_tmp_name);
 	reset_pack_idx_option(&state->pack_idx_opts);
 
 	/* Pretend we are going to write only one object */
@@ -272,21 +277,21 @@ int index_blob_bulk_checkin(struct odb_transaction *transaction,
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
-	the_hash_algo->init_fn(&ctx);
+	transaction->odb->repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & INDEX_WRITE_OBJECT) != 0) {
 		CALLOC_ARRAY(idx, 1);
 
-		prepare_to_stream(state, flags);
+		prepare_to_stream(transaction, flags);
 		hashfile_checkpoint_init(state->f, &checkpoint);
 	}
 
 	already_hashed_to = 0;
 
 	while (1) {
-		prepare_to_stream(state, flags);
+		prepare_to_stream(transaction, flags);
 		if (idx) {
 			hashfile_checkpoint(state->f, &checkpoint);
 			idx->offset = state->offset;
@@ -304,7 +309,7 @@ int index_blob_bulk_checkin(struct odb_transaction *transaction,
 			BUG("should not happen");
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
-		flush_bulk_checkin_packfile(state);
+		flush_bulk_checkin_packfile(transaction);
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
@@ -313,7 +318,7 @@ int index_blob_bulk_checkin(struct odb_transaction *transaction,
 		return 0;
 
 	idx->crc32 = crc32_end(state->f);
-	if (already_written(state, result_oid)) {
+	if (already_written(transaction, result_oid)) {
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		free(idx);
@@ -338,7 +343,7 @@ void prepare_loose_object_bulk_checkin(struct odb_transaction *transaction)
 	if (!transaction || transaction->objdir)
 		return;
 
-	transaction->objdir = tmp_objdir_create(the_repository, "bulk-fsync");
+	transaction->objdir = tmp_objdir_create(transaction->odb->repo, "bulk-fsync");
 	if (transaction->objdir)
 		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
@@ -379,7 +384,7 @@ void flush_odb_transaction(struct odb_transaction *transaction)
 		return;
 
 	flush_batch_fsync(transaction);
-	flush_bulk_checkin_packfile(&transaction->packfile);
+	flush_bulk_checkin_packfile(transaction);
 }
 
 void end_odb_transaction(struct odb_transaction *transaction)
-- 
2.51.0

