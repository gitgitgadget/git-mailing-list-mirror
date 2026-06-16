Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550636F433
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621406; cv=none; b=ocCrTQSmH0WiQqD//wcgtFRi+8pAVayKKWc0lRlmLtK3uN3/AwweVjXYZwduMZP6yy4qf5comMmtFzvv0Cpx7BM6cdI+28biC2X7kL+sX5IOncWxTq97BwHSXfeJabskIwmwZpWbIsN2yLidIEsqv5kJyaC1YKYiR8a0JxNoyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621406; c=relaxed/simple;
	bh=bSdNG3OOGkRYc+2eyuRoB2y/Af/srqmdFJOlFUuAkMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CCcBPMJtv9wY575PuS+d5LnM1CkomEWKRyy2MtadNsddicjnqv7ADwCJ3pNHErtZes/MDfP6QYteNdUbyo6XmgAoKcXwbPwbHA/qQsbR1pN84QvZIVV3BaASinVDNfnyohzm/vcF83pChjHhEIjcMk+UbcVDtrOKZvtC1Ld++Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhVcnB4E; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhVcnB4E"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91562bf6c12so545824885a.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621404; x=1782226204; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdHQSqxu60N4H6efYdnkS+LTsGbh3E1RjhrhU8vUhyw=;
        b=AhVcnB4E7JwazSJofUEY00ablMKkU9OljRdb+ysKt7if7OtcmbuQvQuwdhIab8DfAQ
         Z+sJbHFE6mJCV9J8eW96FPY7MEy/ras04T5iHNpeTaiF+kx6+AxxwQKR64Ie51QEccMR
         IgebxJ8hbbLj9EOFst0+3cOSwb9ELzQJaJwHB0PqxJJFIjUeYggAh9nm+gisOeMtLVRp
         SzELCcD4XBNLAFmpCk59VStYWK8xNaqbr+QaKPDXDgn4kFePnsW+8h1AfttWm59K15mD
         44F0Vu6kC5aCueKrowVhLcMijAsHdeQZyVposSALKE8JK1gFcwLbymnAq4ge6R4AKrAf
         ZQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621404; x=1782226204;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CdHQSqxu60N4H6efYdnkS+LTsGbh3E1RjhrhU8vUhyw=;
        b=eca+cvs5uNEAHi2oFRMHE3ExPU+FBoqMPsdoPV2r3+OkzSbXOzvqfJ2aXz5Yv2WDNw
         ++2edEJixvxZpDxcbazQWyBCqhM9HNcpkgJuUBGmuDb2jIoDn1j3+VQuhyZ2epBVUSK/
         oxp6JHEEFlffmlTvBWZ+jBIM+UKblVeKL4b5Y6VgmpetLFh35qR8C2YZJPTimaEoUyhw
         BzxBVBnoM+A4PvIq8QbtPGfhyl8//rjXtTVxRF0zhlX/NrBstjQi3afNxkGmPAcQgWGQ
         mCfBGpwTWMkrcJcn7Lvc9yPEv8WV32MFu1/b5AYnV0Uqrg+o2ppVVsc+48038mnPwMwO
         jK8g==
X-Gm-Message-State: AOJu0YyuvFmfe8UjvTgse9gPueZb4WMLbH1k+DZJsbxHT+evJsw4iHXn
	JFH0G+yIliMQ99K3WyQ1PQQ+mRaG4415Jl8aqzwszBbJwvzCXa6MPb/k0/5aaQ==
X-Gm-Gg: Acq92OEf350QvW9AcxY3jZgZWHz3g6tq1SDH92X9HyYA74iL7VSQiF0XQx7ytTkyR9j
	Cb2rfPX9eyghB1md3sgznBAzQV3CLpWShxQLtkTIqMsPcu3nCw5adGOOUGgVTzCoNBTpdaCWGcj
	EBMfu4nPDKo3OI0EJkftZUuen6+iQ5u7UksO0o3Q6JTcevVoyOIYVKHnB7eg4oGJw23JkQFpS7r
	uNbK1U+QF5f5Tjy7nBFk/RoSuzEcgSw9j1YUh5j405N7xzj3CkiilR0FHxE0Lbe6B2OQk72T9g3
	BLse7ONJUAuIiAesWeoURhRtmTHZK/YMgqy5LF+3aHs4tu8JaLSEBSrepdnsdYoY5St5jfviPEH
	4gxLfDERicGQ1qb9viQTWNAuxWCqFa6mKSEsh6SraOKFLLDIhM88GjRIFEa6CXZBuMpk9JBNOnf
	hoCSPMFeCv1JWqjyEJWrIfL/1zLoutOjDHbfXE
X-Received: by 2002:a05:620a:4692:b0:914:bd3f:b6db with SMTP id af79cd13be357-9161bc1f346mr2811204585a.10.1781621403815;
        Tue, 16 Jun 2026 07:50:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a06367dsm1480835685a.43.2026.06.16.07.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:50:02 -0700 (PDT)
Message-Id: <aa5859c14fa2b52741c70a581866c8129c50aa93.1781621398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
	<pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Jun 2026 14:49:53 +0000
Subject: [PATCH v2 2/6] object-file.c: use size_t for header lengths
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

Continue walking the code path for the >4GB `hash-object --literally`
test. The `hash_object_file_literally()` function internally uses both
`hash_object_file()` and `write_object_file_prepare()`. Both function
signatures use `unsigned long` rather than `size_t` for the mem buffer
sizes. Use `size_t` instead, for LLP64 compatibility.

While at it, convert those function's object's header buffer length to
`size_t` for consistency. The value is already upcast to `uintmax_t` for
print format compatibility.

Note: The hash-object test still does not pass. A subsequent commit
continues to walk the call tree's lower level hash functions to identify
further fixes.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 object-file.c         | 10 +++++-----
 object-file.h         |  6 +++---
 odb/source-files.c    |  2 +-
 odb/source-inmemory.c |  2 +-
 odb/source-loose.c    |  4 ++--
 odb/source.h          |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/object-file.c b/object-file.c
index 9afa842da2..dccbe0fc3e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -318,7 +318,7 @@ int parse_loose_header(const char *hdr, struct object_info *oi)
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
 			     const void *buf, unsigned long len,
 			     struct object_id *oid,
-			     char *hdr, int *hdrlen)
+			     char *hdr, size_t *hdrlen)
 {
 	algo->init_fn(c);
 	git_hash_update(c, hdr, *hdrlen);
@@ -327,9 +327,9 @@ static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_c
 }
 
 void write_object_file_prepare(const struct git_hash_algo *algo,
-			       const void *buf, unsigned long len,
+			       const void *buf, size_t len,
 			       enum object_type type, struct object_id *oid,
-			       char *hdr, int *hdrlen)
+			       char *hdr, size_t *hdrlen)
 {
 	struct git_hash_ctx c;
 
@@ -472,11 +472,11 @@ out:
 }
 
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		      unsigned long len, enum object_type type,
+		      size_t len, enum object_type type,
 		      struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
-	int hdrlen = sizeof(hdr);
+	size_t hdrlen = sizeof(hdr);
 
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
diff --git a/object-file.h b/object-file.h
index 528c4e6e69..4c87cd160b 100644
--- a/object-file.h
+++ b/object-file.h
@@ -131,12 +131,12 @@ int finalize_object_file_flags(struct repository *repo,
 			       enum finalize_object_file_flags flags);
 
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		      unsigned long len, enum object_type type,
+		      size_t len, enum object_type type,
 		      struct object_id *oid);
 void write_object_file_prepare(const struct git_hash_algo *algo,
-			       const void *buf, unsigned long len,
+			       const void *buf, size_t len,
 			       enum object_type type, struct object_id *oid,
-			       char *hdr, int *hdrlen);
+			       char *hdr, size_t *hdrlen);
 int write_loose_object(struct odb_source_loose *loose,
 		       const struct object_id *oid, char *hdr,
 		       int hdrlen, const void *buf, unsigned long len,
diff --git a/odb/source-files.c b/odb/source-files.c
index 5bdd042922..3b1261eba9 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -159,7 +159,7 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 }
 
 static int odb_source_files_write_object(struct odb_source *source,
-					 const void *buf, unsigned long len,
+					 const void *buf, size_t len,
 					 enum object_type type,
 					 struct object_id *oid,
 					 struct object_id *compat_oid,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index e004566d76..7f1b6f4636 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -227,7 +227,7 @@ static int odb_source_inmemory_count_objects(struct odb_source *source,
 }
 
 static int odb_source_inmemory_write_object(struct odb_source *source,
-					    const void *buf, unsigned long len,
+					    const void *buf, size_t len,
 					    enum object_type type,
 					    struct object_id *oid,
 					    struct object_id *compat_oid UNUSED,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 7d7ea2fb84..4cfa5b23fc 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -591,7 +591,7 @@ static int odb_source_loose_freshen_object(struct odb_source *source,
 }
 
 static int odb_source_loose_write_object(struct odb_source *source,
-					 const void *buf, unsigned long len,
+					 const void *buf, size_t len,
 					 enum object_type type, struct object_id *oid,
 					 struct object_id *compat_oid_in,
 					 enum odb_write_object_flags flags)
@@ -601,7 +601,7 @@ static int odb_source_loose_write_object(struct odb_source *source,
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
 	char hdr[MAX_HEADER_LEN];
-	int hdrlen = sizeof(hdr);
+	size_t hdrlen = sizeof(hdr);
 
 	/* Generate compat_oid */
 	if (compat) {
diff --git a/odb/source.h b/odb/source.h
index 2192a101b8..1c65a05e2c 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -199,7 +199,7 @@ struct odb_source {
 	 * return 0 on success, a negative error code otherwise.
 	 */
 	int (*write_object)(struct odb_source *source,
-			    const void *buf, unsigned long len,
+			    const void *buf, size_t len,
 			    enum object_type type,
 			    struct object_id *oid,
 			    struct object_id *compat_oid,
-- 
gitgitgadget

