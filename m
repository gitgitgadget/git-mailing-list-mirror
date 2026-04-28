Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22752313E29
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393588; cv=none; b=TTyac4QlkPictd4S6dIHZaGsSn1oLx7alOw6dVsfS25erGD6VMboJZAJAffMq5lXcfSjVfPzCBXq3Mf5agvQ91zkwYtOsFikKOEV8uNTxoDLSk68bNo3bi7/h0K0u6lXAw3gQEe4QULiAn/durDn63JnY9k87fNMDPoUKJjqE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393588; c=relaxed/simple;
	bh=tSbufVcJiEkUtsd8kLFuuMYgfq8bFLYj9hZ+oW1nTkY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BPU9jW0KyaxVvTIS6wVFIUf5HaxzK/EnxEur152fgXuwyYCbfWgQ4y2PTBpytmvRNlYhDBFYNDRL3y+p02dIf2JeZQyiiByKzwAHyqOUE/IxQNf7Tl4/sO+FEakz59IZ94gS7LZkcQ4sdNope2aKtIrSPEK9eegK1cCiYKWQq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdBJlBRD; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdBJlBRD"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-673ee2a98b1so6194865eaf.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393585; x=1777998385; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i2NDGwvL63jnQD9E4n7rfS9u10d2wecpKCuKWSHUt4=;
        b=ZdBJlBRD8DQwuUdxx5egViIcytIWi4jiuHPJ1MPCqETYC6OR73rowEMR4772BK0ajM
         Y4CjJGk8fmRi8c+bdMFzPLYH9oSrnGDLwlv/juZASzc4CEpeWslA4LL5A24cw1CKzeLN
         e5uOj9UmnDsINvXUwc2hLviRvB3gT/Fqe2UriVyrgNRjDlokw7RFUk9nfKMC0ekQhIrq
         mz6Hl3YASbFk/x6OuQoQaco+LZAWdVq9Y0mrejBYg1DMy0ps5wAA/OVbhCr1YS5Be5YR
         hLFMB7oodGEUFkuxcmj7OUMpX/ykJIx/37N4wxzgXs+BLwRgRNmGsyOXzk/2SZeK0dvB
         Jcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393585; x=1777998385;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8i2NDGwvL63jnQD9E4n7rfS9u10d2wecpKCuKWSHUt4=;
        b=OdzRiSH+ZOoF/oeYoec9kVLREOfBoCH7H1J/qLNO6z7K/QXAIVbYwFsj+HNTDT210K
         RVtM2fmVV/o7sxOoCHIzy+eqZSiPn+TU42sxLjrJNvR4u1uAk8Lxn4noM0OZtU9yQ5Zz
         DFzP2dxOQPta3IJcTwUB6JLPU9F8cQhBs9UGRcOxxsJ6cELuP5lZ4JLN4UoAjdUbp8fK
         jybMtKEkAscAI67IWkjC4xmEhaYabxpDoGeQOvFjsto5fM2+UFLrV5bdkTtQPgdtwXq9
         27oT8/ly/PINJJL8294ka+0ZpcBWwZEdpXxCHhXn5k9ELG9wJ0HWklgqt41WU/iISRWc
         3hRQ==
X-Gm-Message-State: AOJu0Yyo2opALWIqL3nf0O9gfsi/t8MLvGdAfqmmFMkOjVoFgcqZ7rqL
	7/regSUivbrAryoQ86r+2E0aPlrPB3W2COC87kDLErAExtx8acgKB2ZYChs2Cg==
X-Gm-Gg: AeBDiesuttH/jyzBz70j/gmv4zd4CRqnZR5t79RC7oXE1qvWnmBocpJU8YGNLRF9PzP
	bOD9gcQGDZ4opd5sI0vrYh/KhUKG6/U63Km6Qw/JssCKj3Nam3og6/YXUpZONpkW7SJ2ny7BTKZ
	KTwMCYK2rvN28NKeq9X6z7ZIBFj+iLnc0WXCnlf+R8+x5SUNk21bl4MnoCkoVnrDe1wWVYGcXdi
	x/XP31NsiD1xIoMxWAB4waKiIqgRjLMu8MMbtgffWMXFOfTEQpJHa8dC/WFTzu+kZXsp7N2Agrx
	VKMCGKzZw07aoY0Eev841sf2PSK1OSNIKRwLncpunVhJTntBknGV8Sy1m/S5ZCCLiCEescT79Rc
	mFA/pn39NZryieIB+3wOA325+kQjT6MdD9VSKfkDbCkLbbS0N3tENk1jzBGLJ0P61c5gwPCkb1A
	HpeY7iSYCdEexlPH/dE6Lj2Fg1D3WvrU/Mh/Kc+H0=
X-Received: by 2002:a05:6820:2224:b0:694:9e10:fdce with SMTP id 006d021491bc7-6965ca3b9a7mr1729428eaf.4.1777393585299;
        Tue, 28 Apr 2026 09:26:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.163.230])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6965ba371d2sm1756281eaf.11.2026.04.28.09.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:26:24 -0700 (PDT)
Message-Id: <92f4327b1fe09126dd6421b071a9071ce5530371.1777393580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 16:26:16 +0000
Subject: [PATCH 2/6] git-zlib: handle data streams larger than 4GB
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
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

