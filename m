Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0D3E3DAE
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914515; cv=none; b=Tq3YQf/Lyjlqi6IqXMcL+0522O6SOFiBWlY/UShiJH8QCzDX2gnYRpVd40XLkiW0JV790Y7FMj6/EfbLEaxIsY5o9HaUxAGkpTIee08D6UujV8XWXYk3hCf9wBCly0IsT4L09b98I5j/LnBPy7jtRHaVGyz/H2feFvjBVyxR9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914515; c=relaxed/simple;
	bh=tSbufVcJiEkUtsd8kLFuuMYgfq8bFLYj9hZ+oW1nTkY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Cpm9ELOyuFxV30E77gLWoonLhay08BqBN+J7p4PBMk3fV1ucUhbNzPU+zJMYwDSZGMf60tIWcCgGWm07uQGoAyIqRMXtY3OXdZMYfPaQvKm7ebJfSYUK0MP0ro0IyyMHODTPQcw0Kn+fmAlhjwYfonLcgCRacb4UFLd+WB8GOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYbM4h0N; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYbM4h0N"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso2609979241.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914512; x=1778519312; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i2NDGwvL63jnQD9E4n7rfS9u10d2wecpKCuKWSHUt4=;
        b=hYbM4h0N1LV7HNmNPHZQpBZehPrOYQkzUz1yZq59euZm2ns1aP27ruKjHHK4PozD/h
         yM89dcp1Hesy70gXKWviq5G1ew6hCPExaOXzFN4sVvg8mW3qsCKWZMjJbLGqpwbdlkxI
         1Z888okteMPcOrtv/7tNR1Yi+gGxxz0e1amEQDzr3eid2PR94k8DPvwoy5Ws1Ft/Un//
         FKFtgghBEGo8lCrqBvLzkchuOFoMAertTwd75qvT3jAdwDauFfEYYroSGQ8k2cYBG8Mu
         XWwA9Ld+j4AE/1lmsZi78YuPHHMSgFLIuwH2TMF6MdnLEhdnKSZJBo88vyrvaO0MV86g
         7YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914512; x=1778519312;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8i2NDGwvL63jnQD9E4n7rfS9u10d2wecpKCuKWSHUt4=;
        b=hqD76oGkLZxpEcOLKhshraB56whrwxX27DLqu5b9oYuFuy1taulagOEmz+KBwxvNtA
         5q6tebMXJ3b/Ro0789z14l7hxpr2LKZi4T9f7hNxxwOh2yF44/XdzYnLqGnSnCXtHe3P
         y/Rv1jb1vL7vpXVQ0N94ENZdpmZgnVu1cnMEn9on/xPhGwGREDfDBWj6zX0HWVyO1+sH
         v1qLKne5UuaMXhJDkGMRJnHFA7+jw/n/+IvHoN7kNt2CiIAfSIFxDcLMjdT0cZVAJH90
         iYye4hCOwNm7Va7SS104TGY7fdt+fQXxFoM0r0N/uZxDEyjcflbD/6CFkglUUZCGU+pW
         8rSQ==
X-Gm-Message-State: AOJu0YxwUVAiBQOJ2m97IZdEEz0FIUxVOAY1o4XFW9lBdYCURjBePfmC
	ChzznipMef+PSpLKm9bR7bVF1h+nW8blD6aGN7BxNWO1qpupnflBR9qY5u2wsz63
X-Gm-Gg: AeBDiesrFZHnVJrmaMnEcDP6XeZHsCoSJOLB1d8hw8jsI6CQC/EcqJKGRQZX6d3qydo
	g1pIoyenzJZHTu7ogR2GvvV1Ssorg001bBYmF3DNamEGcZt9D0W45JyfKexCkBood6T/xKCiapI
	MkYF+yLxfPZZdi+8FFT/9i9l6cCUhtvgMF1CM7jPtFyATIX63kpGWvDJMy1y2QEB+ytPNwCdEZH
	Ckrxk+znL1X6XvE0TUgcHzTZ4/P8FMqyBAesWPgyuhzDLBSaPP28elgFCun0q3lGbxhTg8wj+ds
	59ug++umJ3qzLf1Keo1cZ3wmjLaqzdbKyUvN/UP43tcC35FyYfFxqlcyUwVXJJOHeTkL38As3iO
	uRG3XeGwDEeU4aHj2/WYMEVbBY2qRLfwzwhAodaRc07L6I1EVmeesyiBtSogKJOoNaKEDV2HNdG
	qFyB6UbeNQz08H3KRx8evgeHoBifyWf9KkUolu
X-Received: by 2002:a05:6102:c4f:b0:605:218d:ae0f with SMTP id ada2fe7eead31-62d86a1cd99mr4612695137.18.1777914512174;
        Mon, 04 May 2026 10:08:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.101.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc293837b5sm1190819185a.10.2026.05.04.10.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:31 -0700 (PDT)
Message-Id: <92f4327b1fe09126dd6421b071a9071ce5530371.1777914508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 17:08:19 +0000
Subject: [PATCH v2 02/11] git-zlib: handle data streams larger than 4GB
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

