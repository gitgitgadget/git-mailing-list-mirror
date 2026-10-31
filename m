Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441804;
	b=H1m8W+UEs8q1q68S/TOWwGHCQJksGNVl1vBrsGxKTINOaWipGQ4mDVLTkl2FJQwYCFzy
	 coZBwwKwE060ImrIRR/cLPXm+CEwd/aTDVCmZIEJgjaH7S/nOinm7RpVsWtClcEKLfWCs
	 ITRIw++e71mKIFgESfFJzTvtoLHdFg9gayjL0S5abRKVJrrvkRrnWmT4a8gD36Brj13Gb
	 1XbLNErY2F1juZ93C1xoBv6ziHlmWBReCWIB/PVCT2zDOcAuJBUtpuaBAaAj6BmELgH57
	 UALXAyoYptRtoVAz/NcmuFFq5Fs8kzRD5Zm+HQ5keSd1mtDG+oHwB8BCyNs53UjvO5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wXGUkh6BsHTPAHZ7666xSclKl+g/IAbFX0DEkesSuXY=;
	b=TbQUr/hhrjF0eqaJyylyH9k7MhRRUL9+G5tSw2MjkHwA4fzTXr8U8W2u0DMPB0BGUCjQ
	 QeuVt/hx6PV4LiIFDP5lma7iIQNvLewyixzC5TTn0FgbtGzStW7VrMSWxoP/D79OLHE7p
	 Gcc87H3a5sAJDCW03Z3ZBCOcRAB3F5jrnm3w5KP7lFqgILZmccyEcUhdOFgPs8oufFENq
	 MY1H/TNFZ7KILJ9cyz22El9iXzJIoqM8VxxnnHSlPMpIwJa4WLm0/KDVByoe38uStmThJ
	 21cygKMKprwHdz/ym/AhdIAVo8uM7tGBGE/Xe+/ClGdkMGOM+Vh/uCmGm9iI+URDhoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0L5Ves8;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888A606A323
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C888A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0L5Ves8
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so9404175e9.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793441802; x=1794046602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXGUkh6BsHTPAHZ7666xSclKl+g/IAbFX0DEkesSuXY=;
        b=B0L5Ves8KhTW/AJWuUNf/OYt32j/ADlhPkUyJktmDVplO5ScLmpedvrgPQrc8pb+mF
         ZhoXxcSW4LzwLLCSI2VyPDcVI4rFAHRbpcYmebEvysvGN5hugx9Qs6zxovH6MbSm1lT+
         gZz4Diow02rFUnJhCDOmedgFA+TGPO7lbnQPZnr+Qb4vJ+pIejIPol1uSrRH3L/fJXQW
         ZHNTqzyGrPPa5w5h/0jrVQ+7qdXnqJrrnQ4fJlO/K6rEds8pzL+LWCe2HBHQKpZUmaMU
         12uDeE1w217f8kKoSiBSentzAeEWZFg9rbVBhxmJu8WRvf4tdIxWJAHotuzGYYmfA67D
         p7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793441802; x=1794046602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXGUkh6BsHTPAHZ7666xSclKl+g/IAbFX0DEkesSuXY=;
        b=qy/9jUJz2RIryNpajHrwWZOW9he07u4HAUKxmp8w+wORe2bHKyFJ0wGRoqgIapDHVi
         tyFj7/+NnwpQfkAjhqqObAUe8jDgatR4g3t8+70ztFgXfDS7lFva4J2BTEgar8/wpR2D
         XPV+yhx6ZareGgTOJ0xXDnUMEnpEUChyTKNbSow+45w8AU1v7pmzGFjlW1ew7yWV0EkE
         3zFf9eFCmCmVfeJIAX8o2Txh4u2rB+fs7r4L5nieMBXZfCLBrpX0gGj2F6/2YvJHmxQF
         RdTUqHL9mOzEHLYzsQUp6mtIxdxr5CVcwXuJDLjSJgI92hcZKH5hdZAJ59KS8FXi5BEk
         Ukvg==
X-Gm-Message-State: AFq9FYJHt1eNXzXilF3olgbfCDHbugMc/VmX/iUlolREgV0TFYI92StB
	N9g5D9fLlkbTyX0IXWo0sFn+2tiEHg4sAom7FNxk6EmziTsc1Tq7T72enhIni1XI
X-Gm-Gg: AYBFou0dQTgd2EeQ+rZH+A3TBC0z65lCYJkzQaYXvDlKsakMS1mM9ywGRC0HPBR8Fod
	akLe50B0Sj8qGFK5kMeOCB2WPkJpp/3EAyb/sR/Hk1oBgXkutPm4STc2dSN3V2vjhMv+JYfm5JE
	ZH82psnAsO5yXv42oJ+kRrm1Km7CUlpxuFy/DkgYPAnLB2C6yP1cGZYPTdIxX59GnxTjQCguawt
	99UBAYXnadyK+rB72Eq0Qyq7YgpMNhgbTx/7MF5hZ0/lcPZwdUTzsV/rOlCU0BGF99qWti9Msmh
	X1jvzWwaHlEaMYiu08KFlYSYgm2s+1pPFxPuuhJA9ddkpQrLdGNjcjjmQ4Nbvz4zkfOBD7bTt23
	tsnv4lxutxYZJlXnIKHmnp6kXX1xtLUeyyIB265mKKCYk6cRJn1QGKLqLvE7hVjLpUt//Wr0KaA
	u+8zfumTS5PMt59yboHn8blGGnhTLhqNorcGNMuTCBMQrOeJm4XlGSCsaXNFZbc9nPQcFnDbztJ
	2waQ7wvWwZy/O/yx2Gnr+u6o47vVX4WthqaREgJeJopZq+Hj65ypgl/1onbIXX42teT+UuSGgcx
	eVKV572EbCvr82iYglWxVL/QRdeFY61GYUgSyd4EyZBGqfOQ5sHw1LIHSG8KqI0=
X-Received: by 2002:a05:600c:a49:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4ac17ffb2ffmr109909565e9.9.1793441801859;
        Sat, 31 Oct 2026 03:16:41 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm127220015e9.6.2026.10.31.03.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:16:41 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] odb: use size_t for the length of objects to write
Date: Sat, 31 Oct 2026 11:16:32 +0100
Message-ID: <4961a1824ad75b6cfa81ab89af650cfc440cff81.1793439137.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793439137.git.gitter.spiros@gmail.com>
References: <cover.1793352943.git.gitter.spiros@gmail.com> <cover.1793439137.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

c6a4629e32 (odb: use size_t for object_info.sizep and the size APIs,
2026-06-15) widened the read side of the object database API, and the
write_object() callback of odb_source already takes a size_t. But
odb_write_object_ext(), odb_write_object() and odb_source_write_object()
in front of it, as well as write_loose_object() behind it, still take
an "unsigned long", which is only 32 bits wide on Windows.

Most callers hand them a size_t from a strbuf or from odb_read_object(),
which silently gets truncated. The most visible case is index_mem() and
index_stream_convert_blob(): when "git add" or "git hash-object -w"
runs a file over 4GiB through a conversion (core.autocrlf, which is on
by default in Git for Windows, an eol or ident attribute, or a clean
filter), we write a blob made of the first "size mod 2^32" bytes. The
index records it with the stat data of the real file, so "git status"
stays clean and nobody notices until the file is checked out again.
"git hash-object" without "-w" uses hash_object_file(), which takes a
size_t, so the two disagree on the object ID of the same file.

Use size_t throughout, including for the size kept by the in-memory
source.

The existing "hash filtered files over 4GB correctly" test in t1007
only hashes, so add a variant that writes the object with "git
hash-object -w" and checks its object ID and that it exists. Like the
other tests over 4GB, it needs EXPENSIVE and SIZE_T_IS_64BIT. Truncating
the length to 32 bits in odb_write_object_ext(), as happens on Windows
without this patch, makes it fail with a different object ID.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 odb.c                  |  2 +-
 odb.h                  |  4 ++--
 odb/source-inmemory.c  |  2 +-
 odb/source-loose.c     |  2 +-
 odb/source.h           |  2 +-
 t/t1007-hash-object.sh | 11 +++++++++++
 6 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/odb.c b/odb.c
index 2c93a9490c..1f173625b7 100644
--- a/odb.c
+++ b/odb.c
@@ -640,7 +640,7 @@ void odb_assert_oid_type(struct object_database *odb,
 }
 
 int odb_write_object_ext(struct object_database *odb,
-			 const void *buf, unsigned long len,
+			 const void *buf, size_t len,
 			 enum object_type type,
 			 struct object_id *oid,
 			 const struct object_id *compat_oid_in,
diff --git a/odb.h b/odb.h
index dd85b880a7..45182d28cb 100644
--- a/odb.h
+++ b/odb.h
@@ -621,14 +621,14 @@ enum odb_write_object_flags {
  * Returns 0 on success, a negative error code otherwise.
  */
 int odb_write_object_ext(struct object_database *odb,
-			 const void *buf, unsigned long len,
+			 const void *buf, size_t len,
 			 enum object_type type,
 			 struct object_id *oid,
 			 const struct object_id *compat_oid,
 			 enum odb_write_object_flags flags);
 
 static inline int odb_write_object(struct object_database *odb,
-				   const void *buf, unsigned long len,
+				   const void *buf, size_t len,
 				   enum object_type type,
 				   struct object_id *oid)
 {
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 75cf29fa9d..c13cffc805 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -10,7 +10,7 @@
 struct inmemory_object {
 	enum object_type type;
 	const void *buf;
-	unsigned long size;
+	size_t size;
 };
 
 static const struct inmemory_object *find_cached_object(struct odb_source_inmemory *source,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 50cb388c35..60801e70e8 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -758,7 +758,7 @@ static int end_loose_object_common(struct odb_source_loose *loose,
 
 static int write_loose_object(struct odb_source_loose *loose,
 			      const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
+			      int hdrlen, const void *buf, size_t len,
 			      const time_t *mtime, unsigned flags)
 {
 	int fd, ret;
diff --git a/odb/source.h b/odb/source.h
index 8b839caa39..07d5019aa5 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -451,7 +451,7 @@ static inline int odb_source_freshen_object(struct odb_source *source,
  * object ID and the compatibility object ID, if non-NULL.
  */
 static inline int odb_source_write_object(struct odb_source *source,
-					  const void *buf, unsigned long len,
+					  const void *buf, size_t len,
 					  enum object_type type,
 					  const struct object_id *oid,
 					  const struct object_id *compat_oid,
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 463b38f990..e76557981d 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -297,4 +297,15 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 	test_cmp expect actual
 '
 
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
+		'write filtered files over 4GB correctly' '
+	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	test_oid large5GB >expect &&
+	test_config filter.null-filter.clean "cat" &&
+	echo "big filter=null-filter" >.gitattributes &&
+	git hash-object -w -- big >actual &&
+	test_cmp expect actual &&
+	git cat-file -e "$(cat actual)"
+'
+
 test_done
-- 
2.53.0

