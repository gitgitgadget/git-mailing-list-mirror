Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9022EA169
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771448493; cv=none; b=K85I1iLQU3UT3nMJ7uNTi2tienPeMK9aWeg2x6ZP47PonQ9yzXAbzqXAwr/Rlh1zswzKc07YXPeW4nSSgcZ5WTKZx1xJVwDVMgsPCN2nz/4c8FI2ulDvg4kCPZyTddB383uZB1cKYwwGU5NbFz9eEHhgAenyBcNqiYZJVkX4TY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771448493; c=relaxed/simple;
	bh=H8yYWwAFoOAUSDavfTEfqxznacreNf9cih3qLEbxTpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnmtDnDSLzIc5Gn5VEqYFhKZM8GRsJA0TKMq1zvRQ238wJ6WewRQJX8p8u0gdzc32wSeNUMgjHltp/UTipV/5OM/+KNcflGYjCMs6s8W29+jG1corzh+FTa8YEbEccMv2S7P9m9qKAPbFYv2/l3CoK818E1gF1ElPLTCl7L/zpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba2XYCa2; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba2XYCa2"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d1872504cbso278076a34.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771448491; x=1772053291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EeJf0gNOsgoifGURJTObpcmjvDU3KFODrruFa5Rtv9I=;
        b=ba2XYCa2kuC/5Xel21gLXKz4zThkluoqF/mHcwQDN93uctV7iPlpnF2CQevoImfjrY
         ECxqKBTba5L+XDol7EOZT5xcnW+UUfgUtmhMXoVSSO+Ai7Xm9m3n52xMew16xBZ+DkZl
         Cmi3x5O1l6oGVy0zEWZUwEu9omuSPc9YkJCRzpDNQWYdQOUsX+qRyuJlO9JQpbZ4JRco
         1AyY0wMzJSyVUzIpTDRjeXpVL+XHgwclHL8S3zw9ZsHgly0j8V6KQBFp3UzMOl11WOKP
         Du4OYbNYVYTFEa8kRVT30kljyyUUpO3reB8yqcwpav2EstUh3kfHQErRHk4SIRIF8rYr
         slBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771448491; x=1772053291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeJf0gNOsgoifGURJTObpcmjvDU3KFODrruFa5Rtv9I=;
        b=pXNPBWj0tvdGHNiClz5XvcTQHUsofBEZ9YmcNacYRkGoQnQPudEg4N3RCmcYHEdDqR
         l3p8dBAdCz+CWpe2J4H9hxAdvvgS4Mmx+RLbrp9Ijm/f7k3CU1BqGaRTf/8ehENIv2im
         YE8ltJTBFK0EozvhbRm0gliRchupGCoRjNJq7x8NzL8CGpjqsetJJ1LGLM+F7UqtJ9v5
         f3/ifzbzkRJC9bvF1Fzh5phav7duzGQP5x7v6TkuthC0vh8cAhMTe/jONRrbUZ1ZNyFb
         Od1Q/qnRN7JNGccJybCd8R7pvrF6zPKjTaSJGNmN8aNgU/AhVi+SEYtZZGeFJ9eisez4
         4LlA==
X-Gm-Message-State: AOJu0Yz1slMx9AjjSJjJRn8xvCVaD4m2MxQkZ5Vs3wg69qX4HIJ4K+TH
	C2hqSwdgdcqogkFDODTkYYbjCjmWmyX4zSk8b0Ak6r2TlfT9AFTr2729kARckA==
X-Gm-Gg: AZuq6aIpVIRt3devAzaYORANBNDoZSoabN9VF/qQyTWNzmVujKzQDTBoMd3RguJ/FH5
	urSIPAQFsUOqYpdcfW5NXckYA33qcx857vzZoWp1n1imWtR1HgXpS1nK8VZvvlXyb1T6bxYnsDd
	DAGU/FaZeG6KW0jAZt93PkdI+R+YuU6YuMVDxkEk8XUyD73elrJRhPACzGabaCIOOeaBkirX5/t
	DunjzgdEpk6GSIT1ko52vsRgH/BVcWlhFMNfgCmDojdeH7K0BKDSqgOJA61P6BDPKVb/dQNHWHt
	zqsLysKxu1WgNEFK7vcLK6uHiAStSFcKgd0oWCZe48GecptdyeFX3ESrREXE0ZxCIBm/JAzexbf
	nhc9C8qi261ngFtLC/gg3Fdq7Bxn8BRmU3ZFkS/52BM688zTp5Rs+TFlKxG5QV0tQRg6nHGrd8F
	AcKIRfLb8XKGpQIi7eAlCAJY5POnnTEJk=
X-Received: by 2002:a05:6830:6187:b0:7cf:d784:5d6 with SMTP id 46e09a7af769-7d5061f9288mr2423163a34.5.1771448490719;
        Wed, 18 Feb 2026 13:01:30 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7530a8bsm19987447a34.4.2026.02.18.13.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 13:01:30 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] object-file: use `container_of()` to convert from base types
Date: Wed, 18 Feb 2026 15:01:20 -0600
Message-ID: <20260218210120.1146078-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To improve code hygiene, replace direct casts from `struct
odb_transaction` and `struct odb_read_stream` to their concrete
implementations with `container_of()`.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---

Greeting,

This patch is a small cleanup following discussion in [1].

Thanks,
-Justin

[1]: <87o6m5rff8.fsf@iotcl.com>

---
 object-file.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1b62996ef0..1a24f08978 100644
--- a/object-file.c
+++ b/object-file.c
@@ -719,7 +719,8 @@ struct odb_transaction_files {
 
 static void prepare_loose_object_transaction(struct odb_transaction *base)
 {
-	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
 
 	/*
 	 * We lazily create the temporary object directory
@@ -738,7 +739,8 @@ static void prepare_loose_object_transaction(struct odb_transaction *base)
 static void fsync_loose_object_transaction(struct odb_transaction *base,
 					   int fd, const char *filename)
 {
-	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
 
 	/*
 	 * If we have an active ODB transaction, we issue a call that
@@ -1634,11 +1636,14 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 				 type, path, flags);
 	} else {
 		struct object_database *odb = the_repository->objects;
+		struct odb_transaction_files *files_transaction;
 		struct odb_transaction *transaction;
 
 		transaction = odb_transaction_begin(odb);
-		ret = index_blob_packfile_transaction((struct odb_transaction_files *)odb->transaction,
-						      oid, fd,
+		files_transaction = container_of(odb->transaction,
+						 struct odb_transaction_files,
+						 base);
+		ret = index_blob_packfile_transaction(files_transaction, oid, fd,
 						      xsize_t(st->st_size),
 						      path, flags);
 		odb_transaction_commit(transaction);
@@ -1992,7 +1997,8 @@ int read_loose_object(struct repository *repo,
 
 static void odb_transaction_files_commit(struct odb_transaction *base)
 {
-	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
 
 	flush_loose_object_transaction(transaction);
 	flush_packfile_transaction(transaction);
@@ -2047,7 +2053,8 @@ struct odb_loose_read_stream {
 
 static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t sz)
 {
-	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
+	struct odb_loose_read_stream *st =
+		container_of(_st, struct odb_loose_read_stream, base);
 	size_t total_read = 0;
 
 	switch (st->z_state) {
@@ -2093,7 +2100,9 @@ static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t
 
 static int close_istream_loose(struct odb_read_stream *_st)
 {
-	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
+	struct odb_loose_read_stream *st =
+		container_of(_st, struct odb_loose_read_stream, base);
+
 	if (st->z_state == ODB_LOOSE_READ_STREAM_INUSE)
 		git_inflate_end(&st->z);
 	munmap(st->mapped, st->mapsize);

base-commit: 73fd77805fc6406f31c36212846d9e2541d19321
-- 
2.53.0

