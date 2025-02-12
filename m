Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833D1FBCA6
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340270; cv=none; b=JFZeFvYWioZ7jhetCu7XwY+vDfNr2wx12BRRK/KWRcZ1rn2w8XU/2GvFi5U/5qV88nZBuuMoU7EpXeGqE99ByhtO17Ca60i5FZHadY9ftcAuLQZLtkp8qNx95Ni1sD9LLwgCnS42OVhIwstwxsXJVIvjgdvq7uYZj7t5cJ3BNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340270; c=relaxed/simple;
	bh=z4oOteuTsO1wfDjhO0EUSRFQSuyfmqb1+GOFK6v7sC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4vEBAUnUo6qV8gRlKdA/JyjOqvq5gfYOsbKfwyGiFsXbLdIaP0sea/ANzLb+/bXHBnnhGfaA95gbJVpWxhKPDP+BmpLmM6bPKbeXJN3wJytVeMYEvVeAlfV3/lXRCjfJIsdbRPNq0GkItg7+oR4gBq50PPpchXb6NBet7LmyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX0Ls9p6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX0Ls9p6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f7f1e1194so90223165ad.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 22:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739340268; x=1739945068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n4MkGwwSrn9iOloBqOG2El9mfylZ8I2utSNPtiLQrw=;
        b=SX0Ls9p6ND8V3weIUm9aRXmr99Z8yG2n4zOJlaIj0u8PkvHdndLvF1JDzfBD4a709N
         i3pg1Li46Y+RdoaAEOL568X6uRjJDT3r29ecuzJgZAg4953FMD8UN/s7Gi+2dFFSrrbY
         uTF5K8HeM0O6AlaoLYEs1Nt0rlXj9LuQar6MU79YdpTfysNG+vO38TTrw0ydiERGIDlt
         KuYkErZn4KNRUxkW5K90uRcf3fJpbKnU4FPXBnTaN5jNJHBFavqaGqniZh1YpHETfpVZ
         DJIfQbBwIeQJg/wVy8lAEi2KqdLWmgBT3YwpBRO7EjTv6T6aNpLZwvoc2r53D5IMBdlh
         N/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739340268; x=1739945068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+n4MkGwwSrn9iOloBqOG2El9mfylZ8I2utSNPtiLQrw=;
        b=SUBYjrUvURgXmm9XoY+SJnpByEzdzVEVIK+5g0d9SFvraQs2zAzPq4Pul0Rd0k0LSU
         SIYNQr3YE93r3SwN2tQzBg+mYTfA1ELYhlS4EdRDO6z1yr20CifG4XhucdviMkjZtI1K
         RSMiin1/osUNJiLkURKlz+eG/b3yqPzleuOAyVGQsISw/ReZ2vNKX8iG4Ptkv2z+S8pp
         FL6QwU7fIIx9mlv4BxSZvqoSgd1p3fyWGInj0zWP2uFntDqnFb9r5qQvmP2o41Wxgf4f
         ivaiHYYtFRYJY0b9EZ7cfBxfWUKTBiB4lOLghYvSywQ8S7ATzK07NRboyEgWkX5qcEXm
         +7dw==
X-Gm-Message-State: AOJu0YxTl1LGeDHi4Qtg4L3tEam1Et/3q+WJ6ju44Wya+2UpncLshSFu
	mUIND9aKp9I5aIsRRHppo7O8o81allRkiwbD9wAxpjmqdLdwUK3JHnCUAg==
X-Gm-Gg: ASbGncvpvPfu1917pXufD8iY70sx6EdMiNX8ooB/Y44Org5dQrG6mrBLbSpF/LenZc7
	6SVByqRhYpqLo1fV5Rgk7maC6bx024AGw9Oe204f50b4CHfeetiisDmHnuTjJaIUkAn9mhapPII
	QC+YsQ/4UcvKQsIIp2Wvb9usRizJvtLTTy72TUABwjzc/fb5pAlm9fRxHEUU6zJdENYy8UtpGgD
	YBKPxwc2aVhEhye0tJzDYjT4IpBzrcdkF1oau4ZNqtF/jvr4mK3HjUbSw8oZWbj192nHzHaXBSB
	7CY+wWotgLgWWtsBZRiAFwr0pA==
X-Google-Smtp-Source: AGHT+IGtPuGkXwMo7gEEixZKESDt9WObsF67tINp+DlkiodVNgNei8rxRx0Oh7HHa2AcJGqgvw1cpw==
X-Received: by 2002:a05:6a20:a10d:b0:1ed:a6d8:3439 with SMTP id adf61e73a8af0-1ee5c790a1dmr3851198637.22.1739340268402;
        Tue, 11 Feb 2025 22:04:28 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53f6e2633sm5747411a12.16.2025.02.11.22.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:04:27 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 6/6] xdiff: avoid signed vs. unsigned comparisons in xutils.c
Date: Tue, 11 Feb 2025 22:04:18 -0800
Message-ID: <20250212060418.1645241-6-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.643.g32d702c6e8
In-Reply-To: <20250212060418.1645241-1-davvid@gmail.com>
References: <20250212060418.1645241-1-davvid@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparisons all involve comparisons against unsigned values.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 xdiff/xutils.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 169edff5ab..444a108f87 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -20,8 +20,6 @@
  *
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "xinclude.h"
 
 
@@ -377,7 +375,7 @@ static int xdl_format_hunk_hdr(long s1, long c1, long s2, long c2,
 	nb += 3;
 	if (func && funclen) {
 		buf[nb++] = ' ';
-		if (funclen > sizeof(buf) - nb - 1)
+		if ((size_t)funclen > sizeof(buf) - nb - 1)
 			funclen = sizeof(buf) - nb - 1;
 		memcpy(buf + nb, func, funclen);
 		nb += funclen;
@@ -439,7 +437,7 @@ void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
 {
 	void *tmp = NULL;
 	size_t n = ((LONG_MAX - 16) / 2 >= *alloc) ? 2 * *alloc + 16 : LONG_MAX;
-	if (nr > n)
+	if ((size_t)nr > n)
 		n = nr;
 	if (SIZE_MAX / size >= n)
 		tmp = xdl_realloc(p, n * size);
-- 
2.48.1.643.g61982db19f

