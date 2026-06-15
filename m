Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631B3E4C90
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524356; cv=none; b=RlNha9dHYN4CdYqfkbCe24w8Yo9Uz+P6d7mZgfggeidCqudzSSLD/quU4P222WSYff09ItyF7eSeJUOmBUgpeXtKxshz1F1Z/oNRsPJ1z+5REFezOeXPNh3OLxFMbNMOJXKJ3bohgNzk1C1Gm3xR2loBufxYio5Tyai/B7eVXdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524356; c=relaxed/simple;
	bh=PzMuDHn1B0CdosbC/Rj+xWK3XMum6/7dK0OSho1k74Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UBDOFvGIGvx2uAS3W1VNN7+kHdWckKjF4xwD2XnCLTcmGg2v28ONn6OcMOWxjBug2PXWUo0UYw3NyEMC6nk0n4ZRPvRGIgpZYH5AhZ3TWwfoFJQmcIkS+8EzeBVzGDImdw8osIGvrs0zauuKxKswlcD/CRf4PFIPc9KNaxL/520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llIs4TFn; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llIs4TFn"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91562bf6c12so384049585a.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524354; x=1782129154; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaBlM4cNgc8Fuapm5M5sRNaI1m419/QRUqlVg3CVfj4=;
        b=llIs4TFnvJCFrmU7lLLLcB6sieuDQCED1Xzr860MdO+V3spq8cYnvT5CZhq/69NsFK
         IXLfPpq9EC1wSeLTFkxnkrTfhWNp8Q1BOA0qbwYl4mz+kd8De3Nf7lW8y7AKUE35vZB3
         gx6yRlj9YNew5ccxaCKqKGzPNR9PEQxcSgkAH/rX01TZBGL2jQatQpC0EXy30abRvX7A
         3i6iSbqahmBG9wEadnv6xb1g3KUGHS0Xq9fNkMaasVnKryVljbyZSkGtuVBXkIkljTFV
         Jnu7gU65ALF2/6TeV4O4m5IcSM91ccQVoOZFRwJ7h3txceth5DISJVAKqJIM094NSyIe
         JSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524354; x=1782129154;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaBlM4cNgc8Fuapm5M5sRNaI1m419/QRUqlVg3CVfj4=;
        b=GNEB5AkHeyk6vjlqjX/7zX4FLs3xbp1IKrZ8ZkMRchNhtKxfeeYsMF4KLzzb5N5hPo
         pTNUXkmYsRMDMvz9JDu29MBkU2zMdvGy73cz1N7SR7D4cHcqL0KfHvHXiBrdxUDRKb+M
         7FyAlxo1lpvTIrMkdWgeI49zlwBDW1gPk2OGXeup8KoBoQMZNNpLKDPnJxI28j6iW6+U
         BLU6Bm+sckOlE+fhxhUTu8UHpuA8R8orx9Wb9shcuoc8BAN7PFeMxv/4sw/Rl5UO9sKb
         OyGwwOhV8Crpm6IsiEkfAjbRywtbxFEZUqci0kZFiOsilH0SmxkhLLUANkdHjpH+3QX0
         1O2g==
X-Gm-Message-State: AOJu0Yw0hDATw+MGwurVV8gzfGXl6e6fbKwPY8O15lJ9kqELGKbpVTaJ
	ArMiP80rR6G5miaezPTroqULGG3ZpincFRj6YsQZipOz4gIg0p3P9Wh0cPdi8A==
X-Gm-Gg: Acq92OFTQNoolfpvSFdTxW8sVGF83Rw/dqDMsGduAxqjGWCtcSvNrp+j6kebEjw15gE
	Bz0tZxtlyWtg5cSP/aa42sU2VsGc9jhggo8YCw+1Pwl3McoHdLmCxe5htziXOmO8qoUdm9OwtW0
	pUNt75sCdoarnWs4tZd8KyVvMnLQyvoefHxpZOL2MeR0NpLNV5X2rwBtwLZN8tUvOQi1Pz3fHAH
	OdGbVKZUAbdJokY42e+EUe2hdEufQMMvxBLFQ/YpJ5VSn8Bl7U8we3Rv84nqsl+yffyWFeFzQau
	01/dQmBb7B0xjYeMvGK7HYSWqPMJ4CPw4WBovF23shHrA+jM7MXmAoxJNGk8xDSRo4LH1Zrvd1Y
	E+TdCY5GF7sfH6qef6D/ny8iX9aaZQvN7zwLE+KR9bIEx6pqY1RtzFA/ho2MBuWWVGr02o9COAb
	u0Z+mb3IAl39VG69fN1m8fy6sluPc=
X-Received: by 2002:a05:620a:472a:b0:916:1585:4679 with SMTP id af79cd13be357-9161bf9eff5mr2204698385a.53.1781524354220;
        Mon, 15 Jun 2026 04:52:34 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006426sm1080212085a.22.2026.06.15.04.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:52:33 -0700 (PDT)
Message-Id: <66a642c39e7755755fe388af7612ac8c9bf41a5a.1781524349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 11:52:24 +0000
Subject: [PATCH v2 2/7] patch-delta: use size_t for sizes
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`patch_delta()` takes the source and delta sizes by value and writes
back the reconstructed target size through an `unsigned long *`.  That
datatype cannot represent a value that exceeds 4 GiB on systems where
`unsigned long` is 32-bit (notably 64-bit Windows builds), though, even
though the delta encoding itself, the on-disk layout, and the in-memory
buffers happily carry such sizes. A `size_t` companion to
`get_delta_hdr_size()`, `get_delta_hdr_size_sz()`, was introduced in
17fa077596 (delta, packfile: use size_t for delta header sizes,
2026-05-08) precisely so that `patch_delta()` could be widened without
changing the on-the-wire decoding helper's signature.

Widen `patch_delta()`'s three size parameters to `size_t` and switch
its internal use of `get_delta_hdr_size()` to the `_sz` variant.
Then propagate the wider type through the callers.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c                  |  2 +-
 builtin/index-pack.c     |  4 ++--
 builtin/unpack-objects.c |  2 +-
 delta.h                  |  6 +++---
 packfile.c               |  4 +---
 patch-delta.c            | 12 ++++++------
 t/helper/test-delta.c    | 10 ++++++----
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/apply.c b/apply.c
index 249248d4f2..3cf544e9a9 100644
--- a/apply.c
+++ b/apply.c
@@ -3232,7 +3232,7 @@ static int apply_binary_fragment(struct apply_state *state,
 				 struct patch *patch)
 {
 	struct fragment *fragment = patch->fragments;
-	unsigned long len;
+	size_t len;
 	void *dst;
 
 	if (!fragment)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index cf0bd8280d..3c4474e681 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -71,7 +71,7 @@ struct base_data {
 	/* Not initialized by make_base(). */
 	struct list_head list;
 	void *data;
-	unsigned long size;
+	size_t size;
 };
 
 /*
@@ -1048,7 +1048,7 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 {
 	void *delta_data, *result_data;
 	struct base_data *result;
-	unsigned long result_size;
+	size_t result_size;
 
 	if (show_stat) {
 		int i = delta_obj - objects;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 59e9b8711e..e7a50c493c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -314,7 +314,7 @@ static void resolve_delta(unsigned nr, enum object_type type,
 			  void *delta, unsigned long delta_size)
 {
 	void *result;
-	unsigned long result_size;
+	size_t result_size;
 
 	result = patch_delta(base, base_size,
 			     delta, delta_size,
diff --git a/delta.h b/delta.h
index fad68cfc45..bb149dc82b 100644
--- a/delta.h
+++ b/delta.h
@@ -75,9 +75,9 @@ diff_delta(const void *src_buf, unsigned long src_bufsize,
  * *trg_bufsize is updated with its size.  On failure a NULL pointer is
  * returned.  The returned buffer must be freed by the caller.
  */
-void *patch_delta(const void *src_buf, unsigned long src_size,
-		  const void *delta_buf, unsigned long delta_size,
-		  unsigned long *dst_size);
+void *patch_delta(const void *src_buf, size_t src_size,
+		  const void *delta_buf, size_t delta_size,
+		  size_t *dst_size);
 
 /* the smallest possible delta size is 4 bytes */
 #define DELTA_SIZE_MIN	4
diff --git a/packfile.c b/packfile.c
index 89366abfe3..e202f48837 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1964,10 +1964,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			      (uintmax_t)curpos, p->pack_name);
 			data = NULL;
 		} else {
-			unsigned long sz;
 			data = patch_delta(base, base_size, delta_data,
-					   delta_size, &sz);
-			size = sz;
+					   delta_size, &size);
 
 			/*
 			 * We could not apply the delta; warn the user, but
diff --git a/patch-delta.c b/patch-delta.c
index b5c8594db6..44cda97994 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -12,13 +12,13 @@
 #include "git-compat-util.h"
 #include "delta.h"
 
-void *patch_delta(const void *src_buf, unsigned long src_size,
-		  const void *delta_buf, unsigned long delta_size,
-		  unsigned long *dst_size)
+void *patch_delta(const void *src_buf, size_t src_size,
+		  const void *delta_buf, size_t delta_size,
+		  size_t *dst_size)
 {
 	const unsigned char *data, *top;
 	unsigned char *dst_buf, *out, cmd;
-	unsigned long size;
+	size_t size;
 
 	if (delta_size < DELTA_SIZE_MIN)
 		return NULL;
@@ -27,12 +27,12 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 	top = (const unsigned char *) delta_buf + delta_size;
 
 	/* make sure the orig file size matches what we expect */
-	size = get_delta_hdr_size(&data, top);
+	size = get_delta_hdr_size_sz(&data, top);
 	if (size != src_size)
 		return NULL;
 
 	/* now the result size */
-	size = get_delta_hdr_size(&data, top);
+	size = get_delta_hdr_size_sz(&data, top);
 	dst_buf = xmallocz(size);
 
 	out = dst_buf;
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 52ea00c937..8223a60229 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -21,7 +21,7 @@ int cmd__delta(int argc, const char **argv)
 	int fd;
 	struct strbuf from = STRBUF_INIT, data = STRBUF_INIT;
 	char *out_buf;
-	unsigned long out_size;
+	size_t out_size;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p")))
 		usage(usage_str);
@@ -31,11 +31,13 @@ int cmd__delta(int argc, const char **argv)
 	if (strbuf_read_file(&data, argv[3], 0) < 0)
 		die_errno("unable to read '%s'", argv[3]);
 
-	if (argv[1][1] == 'd')
+	if (argv[1][1] == 'd') {
+		unsigned long delta_size;
 		out_buf = diff_delta(from.buf, from.len,
 				     data.buf, data.len,
-				     &out_size, 0);
-	else
+				     &delta_size, 0);
+		out_size = delta_size;
+	} else
 		out_buf = patch_delta(from.buf, from.len,
 				      data.buf, data.len,
 				      &out_size);
-- 
gitgitgadget

