Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441805;
	b=BfJiGGEXW40DRcb9tIdGm5XfLiHqzngb2aK1JoZ4Cik/uHzGr7NPX23TDh4l5cRZGlek
	 9YviIf7SKLiQ7wCwCNr5nEnWNOn/OV4mtd8iiDCQf54uILhWAmXjSOfG7M0Zjn1lS/2VZ
	 wWr3s79vc0+yg6bb5igpTLpu9r4TNpy/xhvQx5m1qmlSQq3T3jjGCr69vN+EpvP8jHuB1
	 DWJu8aH6RTv7ZT2KInz/HsgBiZZf8/vOs1f8RzPRTuY2kosaPTKi5z+7TDcujaOvUOlm9
	 oB5tyl7fpuSs3sY7bJjavvO8CtQDd/JObQ/JZ8vzR+fvh//weWxOt7p1G4mv2rwW/vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dPkKzaHYkJhh6wa7QFoKyPu7Q3qgqtI2wNOLP5sPG0o=;
	b=mh3uRK5X9SXnVR+nFHsILcAyJXFBk8m338Olog8528CQE8L5O8tVWS5eNiOFEpe69ylO
	 2tFarfDlv5gDx3w6jAFyZ/qT5GmPzRQfrauv4IfeLc+/y7FZQqY5+bFM+USTiZC0+asvR
	 eixEewzav9vOIJHTSFkXTMJEfVEvIMa2nEoUjgwAPX83wfXuoC/1yYgYRsyafseEcek+y
	 bIRwmEaOY6UqRDF+k5fXjbByEgdayrSwL/VlMdiBEWYXRf0+RwIvKWVM/NtDAXhaS45iw
	 JSYruZUItmBwMfpGRi8rWCfJKYZX+g1VU81VsN6W18YHOQmW4QZ6pRzAH4VNo6+hNnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ujdq6UAr;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D8606A31E
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ujdq6UAr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so16625725e9.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793441803; x=1794046603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dPkKzaHYkJhh6wa7QFoKyPu7Q3qgqtI2wNOLP5sPG0o=;
        b=Ujdq6UAr+4SkYYWOZRrP/b9CBRKyfDjxYcyS92DACVUVS/rnerl1YHkZWY4RiSj0aj
         aKHKPRwlIX3NY7wQVRsFnhOEBWtcmvhBaCsjHV9DUa+S681jsvMDEGICnYEF9DN4RLUZ
         uTKHdyVPFozb+Xm0/gCKIq2YjkQ0mtwHHlmC43oFKtZ0dw+ZklPK4+8cyQrnEjP6CqkS
         UV0W87PGNl0mAQkOchtN0b+xn4VCnL3fDdn11xLC0kPkColT7apHDP8Rz4qLoTu6k99m
         5u9pkHygILtBrUYRzCwispngDcPAWZnJPkDl+NRtUvkWs1+rrF1nRNs2ppWaXISFkc54
         rsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793441803; x=1794046603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dPkKzaHYkJhh6wa7QFoKyPu7Q3qgqtI2wNOLP5sPG0o=;
        b=EuzEhFpxy+H0sk5HDKSEloCM/+JELYVbjNEVqB2uBf2TOJa8rchgN89lv5+XQZr29X
         9QXyaGTFhbswdIDP9obbDu20bqNMcuy/6GeM5gB3YCHiMRKiW3ubmAEBJHYZB139xru8
         zG/1cz+6O3ElkDVO+h50g0ZEzRn+MEnJgZnha/5KtMQa67Sfh+6LsHhZR/ryf2TnhqMc
         q4qsn+mCbHTgw3vrG14sHjSKK/Ch/fteZPuUmUZQOyX/qRRuDgKk4iynyTnUHw7dzxE9
         Y44/uyyrE+5zgVlQg+7x3t8Aa6ZqkSgcCIpwPDCx7hB2U6wNTfKd+34J0rclqBA8E9Vo
         a9EA==
X-Gm-Message-State: AFq9FYIG7mNguKzasPKowVdz12hZyCJFwqvQOv1p6sIjr+xEYPY/u3fD
	otGePs/Ii6lmiuAF+LfTh1j+r35Fo/OimbjXfrWDI+r05JiAsrR1tWrNX9aVIzgU
X-Gm-Gg: AYBFou37EtkoLTqq3zjHMPbQl3PL3zWbQcNRTljRvmMQ2Vtyq+x2HqZpr7n+ra4f3Pa
	IPL3NKPeFSxrknCx9/mFKqqwvDjpnSEqzFyuHgjWLj7W3/gylxSdnhOh3yOgEiRkv6WXRuOl0aJ
	fepaq4Q4tjlRJ+M8b6840CXpFb5PGHWrmGF9F/9jPy/4TH6SVUXGBPAoGiyw9IRvUSmgpS2ZI2K
	JSY8QltvWKOGt6pnM0xVFFXTl0DMQXCOcRgPHfbKWrkF5ixLgT6ygy2hcLyWYLZ9bAh68qA1ksn
	/lwhbyIwLyoIFtDqfk7Q7C0BI4jnhe2x3U2+tbrfKG7z+MAE8BB6rb9pxV5Ydy1G03L33mIGWSC
	SpKw4lyXIxVbk6OscNn888AVHtjSake/WPZQPl6DsTREM37FcuCe1J3kFFQl0G2rtbQBMdCIN0t
	1gDk6WhMbXy+vmmdO5FcwEV2B3deeZ6z8jCA/8T89hj6E6snO95G4VpXGdEPqataUeWOGsklb0g
	y5voxmNdrTwSJtLmBYe5IJsIva2ZSKS6dn/OpK37j+HYxitf6d/lRfaCU6bx6+sZrjcw5+JRLio
	JjM0BWrFjeFR/bOZVCs9uqehnGMKS+ZYFDXDgNEEris4lI4q9iZj1TgXCeMa4FhvWNEeMqCQol5
	7sydER6D1
X-Received: by 2002:a05:600c:34d1:b0:4a2:133:45e1 with SMTP id 5b1f17b1804b1-4ac183d136dmr103219915e9.24.1793441802731;
        Sat, 31 Oct 2026 03:16:42 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm127220015e9.6.2026.10.31.03.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:16:42 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] diff: use size_t for the allocation size of word-diff buffers
Date: Sat, 31 Oct 2026 11:16:33 +0100
Message-ID: <b27ef2a8882c2badb88d257ca28ed38b67c13c1b.1793439137.git.gitter.spiros@gmail.com>
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

Since 3c7a31204f (xdiff: use size_t for buffer sizes, 2026-09-30) the
size of an mmfile_t is a size_t, but the word-diff code still grows
these buffers with ALLOC_GROW() using an "unsigned long" (in struct
diff_words_buffer) or a "long" (in diff_words_fill()) for the allocated
size.

On platforms where "long" is 32 bits wide this is not just cosmetic.
diff_words_fill() writes every word followed by a newline, so its
output can be up to twice as large as its input, which is limited by
MAX_XDIFF_SIZE to just under 1GiB. alloc_nr() computes (alloc + 16) * 3
in the type of "alloc", which overflows a signed 32-bit "long" as soon
as the buffer grows past about 700MiB. The result is undefined behavior,
in practice a negative size that REALLOC_ARRAY() turns into a huge
allocation request and a die().

The buffer in diff_words_append() is bounded by MAX_XDIFF_SIZE, so
there it is only a matter of consistency, but if that limit ever went
away, ALLOC_GROW() would truncate the requested size, and the memcpy()
right after it would overflow the buffer.

Use size_t for both.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index b4ac17f8ef..9483931c05 100644
--- a/diff.c
+++ b/diff.c
@@ -1959,7 +1959,7 @@ static void emit_rewrite_diff(const char *name_a,
 
 struct diff_words_buffer {
 	mmfile_t text;
-	unsigned long alloc;
+	size_t alloc;
 	struct diff_words_orig {
 		const char *begin, *end;
 	} *orig;
@@ -2192,7 +2192,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 		regex_t *word_regex)
 {
 	int i, j;
-	long alloc = 0;
+	size_t alloc = 0;
 
 	out->size = 0;
 	out->ptr = NULL;
-- 
2.53.0

