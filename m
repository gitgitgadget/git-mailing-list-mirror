Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C8291C1E
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898510; cv=none; b=mg9IkdVYxR3LvD+gpF/wAXJA7r38IXu/33z5uEomZ9WXGmB2PSulWkPMmyekeAbGMxRjGDlHJy4Cg13+Xu+r3tBwp3rOftWojQySYIYA3ERjSdM5S65GMvunsbBjl1VOXgwqCYvv296mvbCayuC5nQaj58DJ1lBwYMtUsc2CI8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898510; c=relaxed/simple;
	bh=IJOy//V9M1JEpnu6r8MmsvNlkd2HP/bgDdyezcyYRNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tt6D6CFc6LJOIfg1ayFKLudcEhWGHJbve+zLHflgMQbahA7YelRQFq0di/5yiuCpt/FeOll/4o3wDhy7QmIAwgWIp6WvLdTn5btps2x3b4J60lMt4adOkkj5LpMoIyG1pWBKbnyq4dqBsZApNJYeJyknxO5MbwQZwOMvqi5whRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUbIXHoe; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUbIXHoe"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74382009686so713778a34.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755898507; x=1756503307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh7CsQ5ncJlye3ab8RJ69ayFWhH8kmcWycsztSTGqUI=;
        b=eUbIXHoekzg/sb+EyKjszRJFDRCCE0e+qR8j+CavTMlg8fVXbTexQIGmZvoZbdvYoC
         1iaYz9Lmn+TXMAi/S+SO9qvvAuH0BcFjvhoaeGK+FQ4X/RiaDBeoJ/k7gYpMfr8K/8KE
         JHCIC+tVS4degPyHZ2+geAJfYk6ueaBFFYygnjnEjAe9Lp88K56iltb66Isiv+wFmjmQ
         K4bC1RZSWHXg/GNtc+dztCWcWcQHlAgL8VP9uwqLhEk14pf5mJ7/+VwEyb/cwtwqW087
         uJ+JCo6BxJXXTE+qjhGibkoconCOFWsW+5je32Fy+XOyssj4M2a3KEmk3YuD3bzO+QjP
         /nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898507; x=1756503307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh7CsQ5ncJlye3ab8RJ69ayFWhH8kmcWycsztSTGqUI=;
        b=uXNgiCKXSf7hdajbqcMJ9EDBtoTiAfvG2IEoxyzFDkN6JrpyPRUU15ripFbOVILMQH
         5CTUkyoYtQumRChcw80zqoO62nPN83mLZsBgWHNGKFfyXffnhVYg1JK/GGLsLSa16q0p
         +ehFjuWntk3Vdes6fYSpbaIh5mSqWtbFlvRENl6tncly/DQpRxogsEYDmcVtAJmft2Py
         MzP7iJxT1nBJIevnhpMhooqN3DaJouXy+M14snvqyeDAmOndsc4yCEhTGFqb+ZfX1Eul
         +RoKqiCazvUU2mTgVo9Tp2cW09HCy/uQP3lkSzKWMN2+CE6R8s4Hyy2Q3/FerVvjcCwe
         9AHg==
X-Gm-Message-State: AOJu0YyNFqFQvRIOiGmJUpmcMo8Eh2Z8YBI2PObLsOlNnO/TUKS4KLdd
	iQrhaTTQw3ZjFUODzceoEwwW6qwEyVygRTJC7/fp4B4fa8M7q3HYaKWJUKLZDcjf
X-Gm-Gg: ASbGncurF/jzNCy4Tgb/LgCUJDfaQ5ElGNTMT5XnHlLwHPFcyPpYfrOGMDfUSjIoPJW
	ZVq6yNwEBE06nkz80bHAeRQTyyCH4SOdV2B2Qvo6rRPYMiSJ6ha5gUdOoQp1r5rWkOvVX5R0GPw
	bdNoLAauqtabrDWmPiRWrsCF4mQZkWdugApIAhkUanCbcXucDtddhVpS8ZF2BES8T+xER96pQTf
	vc7bIkYfitcx0fGchb5/Fa5TVBU8rKUUNw7/gMSRA1fDXwhRh1kdLhylmHRh+f2RhVFdtRtQemF
	aW9mVEkgb73yJCB/Yc/vRFp1S2AtJbvtaw7MpWiN895UxWNGWg8xB5jvLPLLKwLHm+yaXkO9HQc
	cEeWOIHka2kONvBL2t0iA2WDHq2nHx8U=
X-Google-Smtp-Source: AGHT+IGErsHp5uQGNDCdl34MC2b9eUTyuW7H/76P05AHKmQVwQOxD/Ry7mNTxZr/vEbbI4zsYXu1dg==
X-Received: by 2002:a05:6830:25c6:b0:742:e3d2:1134 with SMTP id 46e09a7af769-74500a51708mr2427157a34.19.1755898506734;
        Fri, 22 Aug 2025 14:35:06 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61dc78c7814sm156497eaf.22.2025.08.22.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:35:06 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/4] bulk-checkin: require transaction for index_blob_bulk_checkin()
Date: Fri, 22 Aug 2025 16:34:59 -0500
Message-ID: <20250822213500.1488064-4-jltobler@gmail.com>
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

The bulk-checkin subsystem provides a mechanism to write blobs directly
to a packfile via `index_blob_bulk_checkin()`. If there is an ongoing
transaction when invoked, objects written via this function are stored
in the same packfile. The packfile is not flushed until the transaction
itself is flushed. If there is no transaction, the single object is
written to a packfile and immediately flushed. This complicates
`index_blob_bulk_checkin()` as it cannot reliably use the provided
transaction to get the associated repository.

Update `index_blob_bulk_checkin()` to assume that a valid transaction is
always provided. Callers are now expected to ensure a transaction is set
up beforehand. With this simplification, `deflate_blob_bulk_checkin()`
is no longer needed as a standalone internal function and is combined
with `index_blob_bulk_checkin()`. The single call site in
`object-file.c:index_fd()` is updated accordingly. Due to how
`{begin,end}_odb_transaction()` handles nested transactions, a new
transaction is only created and committed if there is not already an
ongoing transaction.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 27 ++++-----------------------
 bulk-checkin.h |  7 +++++--
 object-file.c  | 21 ++++++++++++++-------
 3 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 53a20a2d92f..542d8125a86 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -254,11 +254,11 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 		die_errno("unable to write pack header");
 }
 
-static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
-				struct object_id *result_oid,
-				int fd, size_t size,
-				const char *path, unsigned flags)
+int index_blob_bulk_checkin(struct odb_transaction *transaction,
+			    struct object_id *result_oid, int fd, size_t size,
+			    const char *path, unsigned flags)
 {
+	struct bulk_checkin_packfile *state = &transaction->packfile;
 	off_t seekback, already_hashed_to;
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
@@ -361,25 +361,6 @@ void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
 	}
 }
 
-int index_blob_bulk_checkin(struct odb_transaction *transaction,
-			    struct object_id *oid, int fd, size_t size,
-			    const char *path, unsigned flags)
-{
-	int status;
-
-	if (transaction) {
-		status = deflate_blob_to_pack(&transaction->packfile, oid, fd,
-					      size, path, flags);
-	} else {
-		struct bulk_checkin_packfile state = { 0 };
-
-		status = deflate_blob_to_pack(&state, oid, fd, size, path, flags);
-		flush_bulk_checkin_packfile(&state);
-	}
-
-	return status;
-}
-
 struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 {
 	if (!odb->transaction) {
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 16254ce6a70..ac8887f476b 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -14,8 +14,11 @@ void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
 				     int fd, const char *filename);
 
 /*
- * This creates one packfile per large blob unless bulk-checkin
- * machinery is "plugged".
+ * This writes the specified object to a packfile. Objects written here
+ * during the same transaction are written to the same packfile. The
+ * packfile is not flushed until the transaction is flushed. The caller
+ * is expected to ensure a valid transaction is setup for objects to be
+ * recorded to.
  *
  * This also bypasses the usual "convert-to-git" dance, and that is on
  * purpose. We could write a streaming version of the converting
diff --git a/object-file.c b/object-file.c
index 1740aa2b2e3..bc15af42450 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1253,19 +1253,26 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
 	 * die() for large files.
 	 */
-	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path))
+	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path)) {
 		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
-	else if (!S_ISREG(st->st_mode))
+	} else if (!S_ISREG(st->st_mode)) {
 		ret = index_pipe(istate, oid, fd, type, path, flags);
-	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
-		 type != OBJ_BLOB ||
-		 (path && would_convert_to_git(istate, path)))
+	} else if ((st->st_size >= 0 &&
+		    (size_t)st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
+		   type != OBJ_BLOB ||
+		   (path && would_convert_to_git(istate, path))) {
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
-	else
-		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
+	} else {
+		struct odb_transaction *transaction;
+
+		transaction = begin_odb_transaction(the_repository->objects);
+		ret = index_blob_bulk_checkin(transaction,
 					      oid, fd, xsize_t(st->st_size),
 					      path, flags);
+		end_odb_transaction(transaction);
+	}
+
 	close(fd);
 	return ret;
 }
-- 
2.51.0

