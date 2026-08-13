Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF148550F
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632985; cv=none; b=IlUw7HN9cm+rkpxoX9/A4DUCdlt0bLLCQln7PBbNO+z41k92oLlcZ7J0Fyo57ALYY3tDOQft5wA9pUooIj8wV96i1HxIO5IF50zAQu/lF/qbaJ2Qo7za1iEOol44bBBPltcaVCdm8r2ffrQiX1Vhxr74hHH/2xefRVaQXzZfae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632985; c=relaxed/simple;
	bh=+LVFfQXn4E3aQj3TfTQAwJ54tYMX8XkC/zSBu2IbZIU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fKlKsv+bJuU9OITEXFHwKoDI+vOVPQ0YWUsjDLhltRCdNXIUZw6RoTXgv6h4g6O2fr2+2QOF2yd+Y4OwgXdxbgGA5mixhWG9anvxChQrL0hBGQgMb7KPedW2ZhjxqT8C+J7tRzLtpvf2wbCgld6ky8loT7qcRxjh24pN/KPIJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3xhSF53; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3xhSF53"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c67a73eb7so496981d50.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632974; x=1787237774; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PInzZ8mSiS6horE61UKC9DbmMNdj41puoWya0qEnPYY=;
        b=T3xhSF53SMx7q0jvehuQpHZrWIAcfBHLD3Cj3ucmegHnQ945rk8zkJEGWYefAttVQo
         t6gomSYl6aiHo1RtRkYwnxaMPD/LVJ6vZjz0slZET98qZEgspHuX1GeZ+3Wc02C7k1L1
         ltNZMx42UrOtkS/xVcXuxs4AakchUNyg0uaTZqFSg9TeacQ6SRB/Ybu+H8+Jna+kdHcp
         aDXlxHwqcaFGa195VhxLSbbJNZ96lv6tI4iMgo2VFsNhmDgJQIzPCha1UsTGHmyM5v/l
         3iQM3rzp13E57eEmqbG7jwEpJmUA2Gy3YZkErDeFT0PhagTmFJHu2sfm8gerZfXugu76
         9zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632974; x=1787237774;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PInzZ8mSiS6horE61UKC9DbmMNdj41puoWya0qEnPYY=;
        b=VXIuOe/PmiLSQoOh5YUFULpJuo/rtdVpS3q+ksRNMjA+0cForb4ZTZgF314CwedQnX
         aPBoo8Qk/X65MsVtdQMfxrnKSJv2d7BBojlJ9gqWgRGV5xuWdmhim6kTo2bk9UbXwJzw
         9bwZy/45CSKepBSgF5xbVHrlkttnefG7DuCmJ9QGInfEBijmJLcBhDxXIkD9r5fTHlgV
         csvp3S29m6AXXXyb8GCZi8Lzl9ZmmPZtpjPaL1WdVdENj4S7D7fi2rKkJr4dlfOqnns1
         tLLlsObrxW21H/UPt16g0jPz+9jTZvv/6cEI11w+NanrM/HRmiUSo15dUGOSvlvpZ3BK
         czbg==
X-Gm-Message-State: AOJu0YyQefCbKwukelRfozM7xkNESsAXjkMDQebmHy7UprJz5u5TfPZj
	n92v+WVlAogWoYzkAOdWHnEwELyRSTs6GWgDa/Kx6wNnRNKspgNtLEYyBq2wdw==
X-Gm-Gg: AR+sD12PPG3sFI5G4tAgOsR4VbzwK3yoBWADHalS0PlLFAiBDY6Uh+0O8ytwVfZvLqi
	mIAO3tmRddbd+F4fxDtMe5nhbN3et46nqE/7umbQltxzveKQLeatQDNmsbtKw7CCGVioyawuQ/q
	G6NGHDrHf9MYlZJQAn1SK54mGL/nhKtcJuHbQDD3wmpuWv662/c2Qr80p+UQDtEFiXIQ0lPvHsS
	BObOLTqwS3h6akbVdrgsqC2Iv5Az8jTBEZRk8qWMKjUp9vak8H8JJFqg/1O/BucIBxQXcnAkGTP
	vIzFmerchn2r0dx0tLF8N/RhKl7OCnm6ELtFi0aga5A7EAKwHKxb0jQBONOI5Pyy2ZcS6lXoDD/
	0bvWdtxQJz5C7cU87flYUwS59OTrMg970llEmy+7NQTgv2EacyUYLSR/yQ+IZhqxmt2ayIsW3mT
	bxC/jsDXMp4mEAx7/7gVqMztv5CJPOtKaDikGVX/oourUHlJIew2e6Yb3kIoePep8=
X-Received: by 2002:a05:690e:682:b0:664:b559:d524 with SMTP id 956f58d0204a3-66c543c3a1fmr1870235d50.4.1786632973569;
        Thu, 13 Aug 2026 07:56:13 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c56e9b401sm927821d50.7.2026.08.13.07.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:13 -0700 (PDT)
Message-Id: <bc4a58336a094052f636786af495adcb84ab24f8.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:51 +0000
Subject: [PATCH v3 13/13] packfile: widen `unpack_object_header_buffer()` to
 `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As part of the ongoing effort to replace `unsigned long` data types with
`size_t` wherever appropriate (mainly to fix all those problems on
Windows with objects larger than 4GB), let's also adjust the return type
and the type of the `len` parameter of this function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c       |  6 ++----
 oss-fuzz/fuzz-pack-headers.c |  2 +-
 packfile.c                   | 10 ++++------
 packfile.h                   |  3 ++-
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 87aa8f44e7..d9922174f1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2260,8 +2260,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		int have_base = 0;
 		struct object_id base_ref;
 		struct object_entry *base_entry;
-		unsigned long used, used_0;
-		size_t avail;
+		size_t used, used_0, avail;
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
@@ -2773,8 +2772,7 @@ size_t oe_get_size_slow(struct packing_data *pack,
 	struct pack_window *w_curs;
 	unsigned char *buf;
 	enum object_type type;
-	unsigned long used;
-	size_t avail, size;
+	size_t used, avail, size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
 		size_t sz;
diff --git a/oss-fuzz/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
index ef61ab577c..e44afe0b8d 100644
--- a/oss-fuzz/fuzz-pack-headers.c
+++ b/oss-fuzz/fuzz-pack-headers.c
@@ -9,7 +9,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	size_t len;
 
 	unpack_object_header_buffer((const unsigned char *)data,
-				    (unsigned long)size, &type, &len);
+				    size, &type, &len);
 
 	return 0;
 }
diff --git a/packfile.c b/packfile.c
index 629fe46a6a..faecb3cf17 100644
--- a/packfile.c
+++ b/packfile.c
@@ -866,12 +866,11 @@ struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *s
 	return store->packs.head;
 }
 
-unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, size_t *sizep)
+size_t unpack_object_header_buffer(const unsigned char *buf, size_t len,
+				   enum object_type *type, size_t *sizep)
 {
 	unsigned shift;
-	size_t size, c;
-	unsigned long used = 0;
+	size_t size, c, used = 0;
 
 	c = buf[used++];
 	*type = (c >> 4) & 7;
@@ -960,8 +959,7 @@ int unpack_object_header(struct packed_git *p,
 			 size_t *sizep)
 {
 	unsigned char *base;
-	size_t left;
-	unsigned long used;
+	size_t left, used;
 	enum object_type type;
 
 	/* use_pack() assures us we have [base, base + 20) available
diff --git a/packfile.h b/packfile.h
index 3cff8bdcb9..e4e64117fb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -300,7 +300,8 @@ int packfile_fill_entry(struct packed_git *p,
 int is_pack_valid(struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t,
 		   enum object_type *, size_t *);
-unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);
+size_t unpack_object_header_buffer(const unsigned char *buf, size_t len,
+				   enum object_type *type, size_t *sizep);
 size_t get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
 off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
-- 
gitgitgadget
