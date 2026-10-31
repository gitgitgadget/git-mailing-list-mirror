Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469857;
	b=rcXTk+ND3xm9ibXvaw1fMI0LP5cF5+dttX4N9ZT99aKmDcL0Qcu0V15XAM1WO6Zx21UX
	 cZhN2zPwNQ7gsH1eem19dQ7Suh6dxWELqwy8iGsJnGw6N/6k5cPBeSIcdPI4AbxCAl8KB
	 LQR5pQH0MTXXGDzHyqQrA0YVN2aXiVaxLOwAB+gmLt1ARzqHWaMGQCq4vkSv6Us4qNHme
	 zxM29uPupYvakQ7Pf1ON6lz4iooNIKqmF/ftyhy/FFemDZNLJTNfuqbbJDvBOlqCOItUV
	 Dh5oo7rtEXgZPmG047JES9wGHirX3ljnyT4LFk/UYXyGrUpVVCd5JLWTfcKxnEpDG7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=a598aTrIjK4CL313LQkjSQgO5LVsGB6Oei4OeSSPIQA=;
	b=OuwKzw6a4Hp5HMv9MOD2vQmVHMafAy2KU4YWdvY1JdwGTyjSVXiIxtgbqUj6ppt6sRz1
	 t01qPR5aNwiDG/ilv27GO5TgJdVyx00OKrBpiMqmsZWaK9ecF2SHsfm8zQYYsFafe3swl
	 LDE2JkYtAkUHPdjmwVU7FPdofKn8WPKpa5zf016kUTSM1cqnNkHki6LeE+F+drBnBGHJQ
	 0HD2Mpy5XCwnXfTLGqFjYCCYWE+l2/V9DIL5Cdw0mHc/a7+fWs/vT49TL0kgDwg1IsszK
	 lgaGcVQGWMgJUh26H4YbqV3TjrnpNg67G8va8ZouwyEXzLfgV6KmrJS89AA1pLuHP3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDgwyReR;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB53606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 18:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FB53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDgwyReR
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso20587785e9.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793469855; x=1794074655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a598aTrIjK4CL313LQkjSQgO5LVsGB6Oei4OeSSPIQA=;
        b=QDgwyReRFX41xETWnv1TrpPZNam7ktrXjQfuSWfo9iZmBZiYBn+u7sgrPJr7Uc549u
         Wt58hzsym+mPwLlGLNxUCweY2CW70VeEAh1d4pu2GPdBN6N6BHM8/VVvvIXgkWRPE0cC
         WJnMakF8xfpxzu7ZdnXyMsQmHy10ZOLmGyefLLbvLZrHWZrbkriG25J5hSrcKqQ4gSlD
         wyhxT9CfsVawG7GS6Pt0NkF9ZeBl9s7jCP01MIXnvloaqzPQGAwX77VbT/BKmdWPT3yT
         iYv7/5awarMeCu9PKmcbRhNzqbW3X47ISeYv/bdcKDwjP7jF82B6qeQt2M01+Dq/EDbS
         Y1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793469855; x=1794074655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a598aTrIjK4CL313LQkjSQgO5LVsGB6Oei4OeSSPIQA=;
        b=hGm6x9jzCd33ERFKqVh0u/UP9H4b3K9/x4KmS2DXdwKE9+iKhDtT14EfGLCUCmSYpH
         JnJqnXmAtDdOZcCAhLgbXULXSs/R2JoRbC5RYCtv/VgoGfJAL9NQBybY+3UEMtWfJT8e
         Z/zjsiwDTE+2e6LjHqVo0yrpl1aieoReY/yHTn5gi8Dlp90+9Ki3sGRbobcD86KErrdP
         ihk+BM/kps8BnRuBq4u1nBQB1S2Gp7C3oPuuTfhsEzHh9HmRPiwANoRaFuc2NNiakDgA
         eF6aX9V+UZ+1A0AzYW+tGlQK06euQM6BUAPujQyuNJHxvvNuCD5k7oK8wiqa+rxtqb0j
         HOYQ==
X-Gm-Message-State: AFq9FYINebF+iNp7FrJPI0mZ0rNkZuqpyQb1D39mVMnwD5yXfRBOI2km
	xlBM9T3Jy/K46xTD0/7c51SaklCLIRRnAlxRBm6To4GZqFCq26vMUVE5ZjChpL3K
X-Gm-Gg: AYBFou1/pQ8AjTdv4snnzWDyUCSW0hP8Cbuga7PTTzQeivgG7O3l7sYfBqrCMKQputg
	EHoZsvsCULYFadKWN6dJxflMbDeR7m7gb58palUw98YiK5Q2jUGBblVTDCifW6z1wQEeFxoXrsV
	2DZYFMpI+r2u6f8O615v1G1OH66nvN2bcWde8mu+9ZoUKbRCA9X11ZgWUeTK+JkLQ1vADI/fjWP
	cZ1X+A78nvSkrLgNBIYGa2DOwt6Dohn/AnnFKk50OELs83dXIWxBChU7JkOYRD53QV68QWrpYXj
	ajOjwQeRQENKl5TKzF16050s6VR5yeqAKbVoS/irK7EcIuPCCCktwgMk/eOF+tqt4t7+2SFDBAB
	YJmSz2S9GGfKtEER1/DCh+qgTWHeS/JyHOvao7bFMV3zrpDD/HaNJ1WijvT3+wpOXC996t2SE4s
	6/iuDkFcJaY40VoPPVtyOkrssIjENEMuKeQELv5sN8f/O1JNStbqhXJciGjAIpuzN6h16dY7lI8
	iuzcG1AdT3LpEWGYUdqdvNHExmovRhX4mOYBm1lz73wnWELMuSAMPU4EfuT3NADOrhL9tS2NxBt
	hcFc22/q9RFUUx+miThAH2dD5O0fbOsWC7x7RYqw2vqEEUgZKe01qpAr01gQ8qk=
X-Received: by 2002:a05:600c:a00d:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4ac185bc336mr130349905e9.18.1793469853952;
        Sat, 31 Oct 2026 11:04:13 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09ad5ff8sm100087395e9.4.2026.10.31.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:04:13 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] pack-objects: use size_t for streamed large blobs
Date: Sat, 31 Oct 2026 19:04:10 +0100
Message-ID: <20261031180411.257932-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
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

In builtin/pack-objects.c, write_no_reuse_object() handles blobs
exceeding core.bigFileThreshold by writing them in a streaming path. It
takes the size from st->size (size_t) and assigns it to an "unsigned
long" variable, which is then written to the pack object header, and
write_large_blob_data() adds up the compressed length in an "unsigned
long" as well.

On platforms where "long" is 32 bits, handling a blob of 4GiB or more
truncates the size in the pack header while the data decompresses to the
full size, corrupting the object. If the compressed data also exceeds
4GiB, the length accumulation overflows "unsigned long", misaligning the
offsets of all subsequent objects in the index.

When running repack or gc on a loose large blob, the original loose copy
is pruned, leaving only the corrupted packed copy and resulting in data
loss. Truncating st->size to 16 bits, with a 100KiB loose blob reachable
from a commit and "git -c core.bigFileThreshold=1k repack -a -d", leaves
a corrupt packed object and no loose copy.

Switch the streamed path to use size_t for size and datalen, make
write_large_blob_data() add up and return the length as a size_t, and
use off_t for write_no_reuse_object()'s return value. Other truncations
in pack-objects are not reachable because core.bigFileThreshold is
itself an "unsigned long".

Triggering this requires processing an object of 4GiB or more on a
platform where "long" is 32 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/pack-objects.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfb..452e785888 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -412,13 +412,13 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	return stream.total_out;
 }
 
-static unsigned long write_large_blob_data(struct odb_stream *st, struct hashfile *f,
-					   const struct object_id *oid)
+static size_t write_large_blob_data(struct odb_stream *st, struct hashfile *f,
+				    const struct object_id *oid)
 {
 	git_zstream stream;
 	unsigned char ibuf[1024 * 16];
 	unsigned char obuf[1024 * 16];
-	unsigned long olen = 0;
+	size_t olen = 0;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	git_deflate_init(&stream, cfg->pack_compression_level);
@@ -513,10 +513,10 @@ static inline int oe_size_greater_than(struct packing_data *pack,
 }
 
 /* Return 0 if we will bust the pack-size limit */
-static unsigned long write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
-					   unsigned long limit, int usable_delta)
+static off_t write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
+				   unsigned long limit, int usable_delta)
 {
-	unsigned long size, datalen;
+	size_t size, datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.53.0

