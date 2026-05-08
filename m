Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8B33F5BD
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228215; cv=none; b=dBabxNmVnbCxbiz0mPfCK7zcPvkU6swXXjSLwO26x312HIbsvH59lXz2cObBTXVcQcV8BxrRFhEm1/CwlilSmr7aOd6K8kHg0y/YZN3kONId2EGtFJoD8hjVl6KRiZMgC1VQ35ErSdvlxgH6Ths3rP4/Du5ifp6ar8dnXWZF2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228215; c=relaxed/simple;
	bh=4KRUiOEDKDLH570CZaSaCVclCjVnfO/nPJ5a/pMlUt8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=V/QP6gtT6G9MjNmeoilb3+Xeq90ZL5LBor4FpYMkIpHmgk3f/9oBDiVTns8j3rcdwhqK7gNp54ptpB+5Y7VFlEhnj31AXLHPj+RhsXn0VtyQR0AHe/JJJzJRo60CiceAMZ2+JNIByvB6jAwQwhXtSaKRANYLcohaNoTVDFSUdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsknDcF8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsknDcF8"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50fb1ad3734so30307491cf.1
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228213; x=1778833013; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAqQJQ6WKCQaCaWHBVgZFpwigjdpS1RSACTbKorVlbY=;
        b=jsknDcF8WWhbB4fLHouukDeGVpgPRdbdUIdzfHA2xfYJbx5D8/zNMcBI5nF6DdOUPJ
         1+RQW7vuLhWJ3aq1SH8h6GcHYJURT2xo5kz9zE4T8iw8k1ZcuEdIhFt/f3mTwjESznqs
         p4OxUYh9kJk3RUUmlIxFtXygp6pKt+tYGg6+JndDnsnbOLsVBYSKcAVxMK2lEhIS8Zy2
         H5QO8OpnT2iDb1w58pI+8JMzYpffQfj0qtJcudAakzOZyFDb02hQk7jpnq7jp7yfZ93Q
         mpKVG2gFpbNRGAL/a9C/7n+ucICFQJb7a1EGg/9FYQ4OGnZxywkrZ1Q9Wc/G/prynIkx
         Pi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228213; x=1778833013;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fAqQJQ6WKCQaCaWHBVgZFpwigjdpS1RSACTbKorVlbY=;
        b=hka/x3DM3HbJ4ZHflQsHfdSyWHRuYHYHzr2rOwXBrxqk4vYAYrh1a5EOTwPZdQmgYc
         R71bSLcIRe/RVew/3aHv6WwuXQlPFoH7x1ANWtH1kLoqoYejRSc044BSYaP5gUqgvsBt
         zDbKN5YKXjcVfZVBiga3CHvte85TovjcPc5AeQz0okoh0F2m/EfLbPpnNXhQHS+IKC5P
         ApH2OyCx33bboPLgDn++xrBepTQTbxh14lpnEHOv6MkqwnvUlItJfEa/nrVD1MmFKBzD
         t++8+f3GBePIcEIf7/ObxVd2E/727i0zzU2yrVJhoIbEvOOAj4YfZl54kPaY8GeGHrIJ
         5iWA==
X-Gm-Message-State: AOJu0YzIS+ZbYYu3IUFUffqI62xa+6QYqn5dv1IIaZNnDiADSBJY+kcA
	y3kxQPUfLeCI2GORXe5Kaf1eKD9Yiglp5+O06p0u0+JRXRdm+nsbHwu5hMEM4A==
X-Gm-Gg: AeBDies+aIIuDB9P4LFJeQXdBdwqr31hDSi/piqWjyR8ExhxOqGrKoVnJbi7Fg82/rf
	7a/bULrZiPMuOdvtHn1nrAo2tNCduHmMd2AKVjDFlVBH7zYP3Hp060tRLw2kf63K7hi84FdV/ro
	Vw6v2668zGza4Yu8XXw2igphszRkvuKtUzVp+Pz5Qp7KnEecsYrPLnt9XvWIklwxqnvAZow493u
	GrFIDS67VzqrEQKCvJz9EkuZ+bWDYQGH9mZ8Oo3mLEJPORe4T76GuTZ7gaPWN1vmntyYHFT8b12
	gfS9Uokg0cu6lga3npPERD0kazxSRM5CwSQKegY7unJ0nLraoesHL2bxGoW1ShBbbOAbt+UE+nk
	Iug8y6Byav0GT6f8bpX3fhXiStTmWt9elpPH7Z+praYOdPe3z45FEQQePDjV5X7fts7O+S9q2vx
	6Gi1ea/pShqitPlrpyGP7l5tQbKbyGLCfVP+UZ
X-Received: by 2002:a05:622a:1a82:b0:50d:3efd:bd93 with SMTP id d75a77b69052e-51475b6f692mr80857961cf.11.1778228212834;
        Fri, 08 May 2026 01:16:52 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3addb3aasm11657696d6.10.2026.05.08.01.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:16:51 -0700 (PDT)
Message-Id: <311cdc601d089bc96e17dc008780a1e7e54fa49d.1778228209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:39 +0000
Subject: [PATCH v3 01/11] index-pack, unpack-objects: use size_t for object
 size
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When unpacking objects from a packfile, the object size is decoded
from a variable-length encoding. On platforms where unsigned long is
32-bit (such as Windows, even in 64-bit builds), the shift operation
overflows when decoding sizes larger than 4GB. The result is a
truncated size value, causing the unpacked object to be corrupted or
rejected.

Fix this by changing the size variable to size_t, which is 64-bit on
64-bit platforms, and ensuring the shift arithmetic occurs in 64-bit
space.

Declare the per-byte continuation variable `c` as size_t as well,
matching the canonical varint decoder unpack_object_header_buffer()
in packfile.c. With c as size_t the expression (c & 0x7f) << shift
is naturally size_t-typed, so the explicit cast that an earlier
iteration carried at the use site is no longer needed.

While at it, add the same overflow guard that
unpack_object_header_buffer() carries: if the cumulative shift would
exceed bitsizeof(size_t) - 7, refuse the input rather than invoking
undefined behavior. Unlike unpack_object_header_buffer(), which
labels this case "bad object header", report it as the platform
limit it actually is: a header may be perfectly well-formed and
still encode a size we cannot represent locally (notably on a
32-bit build consuming a packfile produced on a 64-bit host).

This was originally authored by LordKiRon <https://github.com/LordKiRon>,
who preferred not to reveal their real name and therefore agreed that I
take over authorship.

Helped-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/index-pack.c     | 8 +++++---
 builtin/unpack-objects.c | 4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ca7784dc2c..2e4b42fa12 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -37,7 +37,7 @@ static const char index_pack_usage[] =
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;
+	size_t size;
 	unsigned char hdr_size;
 	signed char type;
 	signed char real_type;
@@ -469,7 +469,7 @@ static int is_delta_type(enum object_type type)
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
-static void *unpack_entry_data(off_t offset, unsigned long size,
+static void *unpack_entry_data(off_t offset, size_t size,
 			       enum object_type type, struct object_id *oid)
 {
 	static char fixed_buf[8192];
@@ -524,7 +524,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
 			      struct object_id *oid)
 {
 	unsigned char *p;
-	unsigned long size, c;
+	size_t size, c;
 	off_t base_offset;
 	unsigned shift;
 	void *data;
@@ -539,6 +539,8 @@ static void *unpack_raw_entry(struct object_entry *obj,
 	size = (c & 15);
 	shift = 4;
 	while (c & 0x80) {
+		if ((bitsizeof(size_t) - 7) < shift)
+			die(_("object size too large for this platform"));
 		p = fill(1);
 		c = *p;
 		use(1);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e01cf6e360..76b3d0dee3 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -533,7 +533,7 @@ static void unpack_one(unsigned nr)
 {
 	unsigned shift;
 	unsigned char *pack;
-	unsigned long size, c;
+	size_t size, c;
 	enum object_type type;
 
 	obj_list[nr].offset = consumed_bytes;
@@ -545,6 +545,8 @@ static void unpack_one(unsigned nr)
 	size = (c & 15);
 	shift = 4;
 	while (c & 0x80) {
+		if ((bitsizeof(size_t) - 7) < shift)
+			die(_("object size too large for this platform"));
 		pack = fill(1);
 		c = *pack;
 		use(1);
-- 
gitgitgadget

