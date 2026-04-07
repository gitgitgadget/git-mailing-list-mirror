Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924CA26158C
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593057; cv=none; b=EgC+XAxidusYW+ggNlwLOeVyX2ya2GRn/YFaoeiLhEiGZ22ka1ohJapWu2dnF4rDpNfvT1FQMptjp819VFgPRVKS95PdvoboMHZUgY9uv0S6Lc9GhrTG+IAsQnmeEVplboS/JnIjn37+8GXCqTsdebny9iXIzaUepRR7foCIAvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593057; c=relaxed/simple;
	bh=nXxcyyf00MGe4P2sYJew8Q510pj9uyZ5UylZw+y+zGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9QcyVuGHn4V4goS3uwf8LVagRfPWnHbI1ET8zTuxmTmu3v499v1OcuQgjO8+billwV8QaL3LkhMQhwzEg+wpMaimox6tLBigA8c0Pzt38ZHAYytmHz+A4AQWmMzTwXifYFT+aLHweXghCqn2hO6VWkp4lF8NzhIU4HFsEhmIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG8rtey4; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG8rtey4"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-463a0e14abfso3016382b6e.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775593054; x=1776197854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3itD/jUm7L4FU4CJbm1JdokHiEk5WG3uqGl66QAM0sc=;
        b=kG8rtey4VKRJ6bayD2TsDF9JhaXI8Y/QKlAsy1JTKzut5mYP1GU85tKfezb1BjVOI+
         tGHGvq3HQx92P9ltcI50xC5ZMNekWW1JFoDKN3rCTNvxIS/W9K8VwjEh1keqp5X7vKjN
         zAzRJDJRO8Nd7Bt0BPnSugGFrw4wjRSl90gb0f4HdZ6SaUhtk1Kq3uK4AMR7kceoWCkO
         DEIIGdoVYNM/SxWlQWpGzRbd5A00EpDC2nlYIzgBZUpmWQbyihlgC3AXtRYlyooySwhZ
         nrOL3bnzfG7im+IftdnnTu88g4PVyvnkMWl3dGpBjcnEFKbWqIcIDgghS4TS4a2XQ6cs
         d3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593054; x=1776197854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3itD/jUm7L4FU4CJbm1JdokHiEk5WG3uqGl66QAM0sc=;
        b=Ta+7EG/eMZ2qexqq3UbofNpeFQpoVCdSsuNteS3rtq3+ej+IlViZOWVJOSW50qBMGJ
         a+JxJ42tGBLZ+ElaI/tTSMrcHehtW5pW4HvXay9W8zi97DsHa86oJ+kkdFV9/z8bys/T
         znrnOvJxK3MGMRcvD+AG3NBs8PBWsOKDa/pjiE8MB+DNjHJcKPsxzODk5sv7hpL/csih
         CVY1esotq8L4maXXwRoNUgKQTsplzbHmlZDppYtg1ewjG/uKXJD0boBWj1sko8CTFFL0
         VbtJHthKvgNvIIjC5MeCHp3G9Urj38IonEv+jVM1NIjJyLPq5jygqfTzTeqna8aCbX29
         VuYw==
X-Gm-Message-State: AOJu0Yy1Nbh4WUPvYP/ww8G+wenKS2MzSDpIDffoSzjCB3/FAWV/PSul
	PBPPFbD7l3Dp1bd0nZh6UVHkYoaIVj0vtj41UP+cQgavm7tTXyhKmnk74MrrBw==
X-Gm-Gg: AeBDieuGiH6Uy8SmmOmCuaHoM3VJtgDvbJSXPPuoSf5l4zrD2u9mQoKX65q20Dk+AsN
	YV1aWdLVf4ElaIhzpMb9wkxGuk5Vo9GHHsGrNmKEqLmUS2iKML8azMCZONs+4ddIfnlNILkr5sK
	/3du7JrcH9I6WiKaBs1UdGSPiCU0HVW/f11Y74FWdYs2e1l2Z8SzRLgkgbze19Wp18/4i1FPoIO
	C28Zd9vnzCHIeJ0cVK5BkKTMIJMuw1wH/IVt1GoSUj7CC1AMGirGdfU2p6mwSMZzb0cNT+JMz6j
	vUPjZmHCF4sjf1l9fD3C/HiYOGPn/UvEhQvPk+Q2UETZRfMU8RaYZsHgX+kGOVIOPZJOqxJmZ+5
	xT2RoEoU/IchE4VNYIW9OW7ZZVcVmkgFYTDmJJozKqaZhnpHnXQPNYQshe5jTpc3tQ39gIk1Bd4
	VVpEDYdfnSecdE8w9VXVIfzviideYWg5w=
X-Received: by 2002:a05:6808:1302:b0:45e:e088:5f3e with SMTP id 5614622812f47-46ef8d5bf69mr9949172b6e.49.1775593054251;
        Tue, 07 Apr 2026 13:17:34 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d9387a763sm10510177b6e.18.2026.04.07.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:17:33 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	luca.stefani.ge1@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] object-file: avoid ODB transaction when not writing objects
Date: Tue,  7 Apr 2026 15:17:30 -0500
Message-ID: <20260407201730.2526914-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ce1661f9da (odb: add transaction interface, 2025-09-16), existing ODB
transaction logic is adapted to create a transaction interface at the
ODB layer. The intent here is for the ODB transaction interface to
eventually provide an object source agnostic means to manage
transactions.

An unintended consequence of this change though is that
`object-file.c:index_fd()` may enter the ODB transaction path even when
no object write is requested. In non-repository contexts, this can
result in a NULL dereference and segfault. One such case occurs when
running git-diff(1) outside of a repository with "core.bigFileThreshold"
forcing the streaming path in `index_fd()`:

        $ echo foo >foo
        $ echo bar >bar
        $ git -c core.bigFileThreshold=1 diff -- foo bar

In this scenario, the caller only needs to compute the object ID. Object
hashing does not require an ODB, so starting a transaction is both
unnecessary and invalid.

Fix the bug by avoiding the use of ODB transactions in `index_fd()` when
callers are only interested in computing the object hash.

Reported-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---

Greetings,

This patch addresses a bug report[1] where performing git-diff(1) on
files that exceed "core.bigFileThreshold" outside of a repository causes
a segfault. Originally this patch was included in another series sent to
the mailing list[2] as a preparatory refactor. Since it happens to fix
the reported bug though, I've extracted it from that series with the
hope of upstreaming more quickly.

I wasn't entirely sure if this patch should be based on master or maint.
I went with master, but am happy to resend if this is incorrect.

Thanks,
-Justin

[1]: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
[2]: <20260331033835.2863514-1-jltobler@gmail.com>

---
 object-file.c           | 57 ++++++++++++++++++++++++++++++++---------
 t/t1517-outside-repo.sh |  8 ++++++
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/object-file.c b/object-file.c
index 4f77ce0982..63408fc290 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1640,6 +1640,34 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	return 0;
 }
 
+static int hash_blob_stream(const struct git_hash_algo *hash_algo,
+			    struct object_id *result_oid, int fd, size_t size)
+{
+	unsigned char buf[16384];
+	struct git_hash_ctx ctx;
+	unsigned header_len;
+
+	header_len = format_object_header((char *)buf, sizeof(buf),
+					  OBJ_BLOB, size);
+	hash_algo->init_fn(&ctx);
+	git_hash_update(&ctx, buf, header_len);
+
+	while (size) {
+		size_t rsize = size < sizeof(buf) ? size : sizeof(buf);
+		ssize_t read_result = read_in_full(fd, buf, rsize);
+
+		if ((read_result < 0) || ((size_t)read_result != rsize))
+			return -1;
+
+		git_hash_update(&ctx, buf, rsize);
+		size -= read_result;
+	}
+
+	git_hash_final_oid(result_oid, &ctx);
+
+	return 0;
+}
+
 int index_fd(struct index_state *istate, struct object_id *oid,
 	     int fd, struct stat *st,
 	     enum object_type type, const char *path, unsigned flags)
@@ -1661,18 +1689,23 @@ int index_fd(struct index_state *istate, struct object_id *oid,
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
+							      xsize_t(st->st_size),
+							      path, flags);
+			odb_transaction_commit(transaction);
+		} else {
+			ret = hash_blob_stream(the_repository->hash_algo, oid,
+					       fd, xsize_t(st->st_size));
+		}
 	}
 
 	close(fd);
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index c824c1a25c..c1dbc6359a 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -93,6 +93,14 @@ test_expect_success 'diff outside repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff files exceeding bigFileThreshold outside repository' '
+	cd non-repo &&
+	echo foo >foo &&
+	echo bar >bar &&
+	test_must_fail git -c core.bigFileThreshold=1 diff -- foo bar >actual &&
+	test_grep "diff --git a/foo b/bar" actual
+'
+
 test_expect_success 'stripspace outside repository' '
 	nongit git stripspace -s </dev/null
 '

base-commit: 1adf5bca8c3cf778103548b9355777cf2d12efdd
-- 
2.53.0.381.g628a66ccf6

