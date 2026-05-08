Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183B38228C
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228217; cv=none; b=FMGE2CXomfPwAnYDvfFukRQ7I3x1zZHygEiXI1d7TMresdG/ExlJujs/N56zJDrXGKIvCCFNDCm0lZx4v7Z+eswJeX24re6w0ecMfGNff7H1UVV+cy55zz6dDneopngOn/5LfQUaDw86PL93j30FJSiIa/be0KVzA9jWArQzz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228217; c=relaxed/simple;
	bh=tSbufVcJiEkUtsd8kLFuuMYgfq8bFLYj9hZ+oW1nTkY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HhPeqqGckxbmSahp6ULCDxVaJWtT3yOYxjESGZnvPySPbYbnsHFrjznFbGqnBIetbdgoHTyWEZr83i8a9sghKhjN4N7CluGxxcGo8CXTwnNYruZ8po6/y4HsIvSxG9zRH1lYloUI8pmT3WHo3n3n/6ptB/esS/mOhF24X23+rv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/hPcHji; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/hPcHji"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso19250986d6.0
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228215; x=1778833015; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i2NDGwvL63jnQD9E4n7rfS9u10d2wecpKCuKWSHUt4=;
        b=R/hPcHjiNpm6yYB7EAkm4auQkhE80yY1MLzILnZj0FIQkeZUxRZuL8rxWoC0kWtuE0
         01k7uGTlr+5ZcIk0QZo0Re3x2kjvmIglT+iX9HMu9mNto/aAuAblUlkBQQIWVuAm4Xwt
         Qp2qvWHvwShLiBcC/bKDqR7ljvTqRKu4YY99l3Q8eYxFgPVHqLfPxXrd48UomfHsrmcp
         jzzVd4HQy7m8bacJAgsPfWRsYqkjPb6KQoJWSGESN6PXehqY+uncIw6SFk42n0QhpC58
         XIXiHGxZmvby9M9P9hS0/1vJpDuMqCBF2WUJAJ4eiRgmmd/xvtQtvkFxkWStiMI/MULQ
         hkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228215; x=1778833015;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8i2NDGwvL63jnQD9E4n7rfS9u10d2wecpKCuKWSHUt4=;
        b=WZb83g1q18lajfE3JYjisfouJL5RpODVx56AnWjsPlEuFc5F/WHbDJ9/USJ1TYdIYx
         f7+Mu3TegfPnDC2o9iJH+xfY7GNkHLhE1IOWJQNwX0aR7TX0pD8Zfgyo86NmMpxPab7/
         lLXFkeGEuc8fmvtjti5uIdb9r1QqOMAhokvsQbqnZ96EpOc6FFx4Wh8DRfV/yqUUpxqK
         zJyX5A/a+lOg5EK4Tkml2f2a5vWUP77igeVR5nr4WFmNeprrZGmfoFRKMI0Q6xy8OWo4
         d/Qt+IEGXhBhznuHwoQ04y9YudV8se9njwbv0uyAhdWpoEoMkkp4N2OWRemUZ0IsXOLQ
         EOdA==
X-Gm-Message-State: AOJu0YxulzgoPcua4AUikUObCi5OyE8CvRHLx0cBtB+fBJ9LPaPyISaK
	jTL3w7D7/hfSpCcPcigrvjT9ZEEo4JXh0RNL2RLwmdu0vZkhBDySZP+iGkRtBA==
X-Gm-Gg: Acq92OFfeswI0qerh9IGLj4F2hwfujdvP5wr1py+zyu8+/NHgjlV67TbC4qsmbHjZU+
	fqk8WYJ7GtzPuGi6ygb1TZwx6KoP4P705BRNGzZCDWUILt1e1ZJ03bogRgACtUyy1YmOMUOxchH
	kUp8lgwT7yZ2el1wKkez/iOP2G8E0lUFSCH+CooS+ZaodYlkXib0W8H/Bk2cKSxhGN49litx0Eb
	96Mue2ifKO1+YmCn5vfhm1YQTa0DKENNPFn9aF8o7d3Bo8AnuDrj2NZjwy56w/NKf37o17E7OEu
	l8V/2n6C4ZpPOGN4ga1eJrFgC7gJeRafX4Ih53KoMNgUOp7hQUyubM+SMgINn91LpdFpUL81C0o
	2k78xtI3qTqzZpPSz6GVHF9G/dgk4q8OY+UAo3LYmTgnTygFzca4b7EFnkIFJGYuS68+K8uZF4E
	IQUNqFQuoijkCMpTNW4XzKaya/LwK8MpRqr4q1
X-Received: by 2002:a05:6214:3215:b0:8ac:ae21:462 with SMTP id 6a1803df08f44-8bc449abec2mr171870006d6.27.1778228214799;
        Fri, 08 May 2026 01:16:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a43665fsm11518816d6.20.2026.05.08.01.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:16:54 -0700 (PDT)
Message-Id: <c611913194cab1fcba5f990bf44ba15f721e1223.1778228209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:40 +0000
Subject: [PATCH v3 02/11] git-zlib: handle data streams larger than 4GB
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, zlib's `uLong` type is 32-bit even on 64-bit systems. When
processing data streams larger than 4GB, the `total_in` and `total_out`
fields in zlib's `z_stream` structure wrap around, which caused the
sanity checks in `zlib_post_call()` to trigger `BUG()` assertions.

The git_zstream wrapper now tracks its own 64-bit totals rather than
copying them from zlib. The sanity checks compare only the low bits,
using `maximum_unsigned_value_of_type(uLong)` to mask appropriately for
the platform's `uLong` size.

This is based on work by LordKiRon in git-for-windows#6076.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-zlib.c    | 25 +++++++++++++++++--------
 git-zlib.h    |  4 ++--
 object-file.c |  2 +-
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/git-zlib.c b/git-zlib.c
index df9604910e..b91cb323ae 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -30,6 +30,9 @@ static const char *zerr_to_string(int status)
  */
 /* #define ZLIB_BUF_MAX ((uInt)-1) */
 #define ZLIB_BUF_MAX ((uInt) 1024 * 1024 * 1024) /* 1GB */
+
+/* uLong is 32-bit on Windows, even on 64-bit systems */
+#define ULONG_MAX_VALUE maximum_unsigned_value_of_type(uLong)
 static inline uInt zlib_buf_cap(unsigned long len)
 {
 	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
@@ -39,31 +42,37 @@ static void zlib_pre_call(git_zstream *s)
 {
 	s->z.next_in = s->next_in;
 	s->z.next_out = s->next_out;
-	s->z.total_in = s->total_in;
-	s->z.total_out = s->total_out;
+	s->z.total_in = (uLong)(s->total_in & ULONG_MAX_VALUE);
+	s->z.total_out = (uLong)(s->total_out & ULONG_MAX_VALUE);
 	s->z.avail_in = zlib_buf_cap(s->avail_in);
 	s->z.avail_out = zlib_buf_cap(s->avail_out);
 }
 
 static void zlib_post_call(git_zstream *s, int status)
 {
-	unsigned long bytes_consumed;
-	unsigned long bytes_produced;
+	size_t bytes_consumed;
+	size_t bytes_produced;
 
 	bytes_consumed = s->z.next_in - s->next_in;
 	bytes_produced = s->z.next_out - s->next_out;
-	if (s->z.total_out != s->total_out + bytes_produced)
+	/*
+	 * zlib's total_out/total_in are uLong which may wrap for >4GB.
+	 * We track our own totals and verify only the low bits match.
+	 */
+	if ((s->z.total_out & ULONG_MAX_VALUE) !=
+	    ((s->total_out + bytes_produced) & ULONG_MAX_VALUE))
 		BUG("total_out mismatch");
 	/*
 	 * zlib does not update total_in when it returns Z_NEED_DICT,
 	 * causing a mismatch here. Skip the sanity check in that case.
 	 */
 	if (status != Z_NEED_DICT &&
-	    s->z.total_in != s->total_in + bytes_consumed)
+	    (s->z.total_in & ULONG_MAX_VALUE) !=
+	    ((s->total_in + bytes_consumed) & ULONG_MAX_VALUE))
 		BUG("total_in mismatch");
 
-	s->total_out = s->z.total_out;
-	s->total_in = s->z.total_in;
+	s->total_out += bytes_produced;
+	s->total_in += bytes_consumed;
 	/* zlib-ng marks `next_in` as `const`, so we have to cast it away. */
 	s->next_in = (unsigned char *) s->z.next_in;
 	s->next_out = s->z.next_out;
diff --git a/git-zlib.h b/git-zlib.h
index 0e66fefa8c..44380e8ad3 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -7,8 +7,8 @@ typedef struct git_zstream {
 	struct z_stream_s z;
 	unsigned long avail_in;
 	unsigned long avail_out;
-	unsigned long total_in;
-	unsigned long total_out;
+	size_t total_in;
+	size_t total_out;
 	unsigned char *next_in;
 	unsigned char *next_out;
 } git_zstream;
diff --git a/object-file.c b/object-file.c
index 2acc9522df..086b2b65ff 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1118,7 +1118,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	} while (ret == Z_OK || ret == Z_BUF_ERROR);
 
 	if (stream.total_in != len + hdrlen)
-		die(_("write stream object %ld != %"PRIuMAX), stream.total_in,
+		die(_("write stream object %"PRIuMAX" != %"PRIuMAX), (uintmax_t)stream.total_in,
 		    (uintmax_t)len + hdrlen);
 
 	/*
-- 
gitgitgadget

