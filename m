Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208F29ACF5
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314727; cv=none; b=d+mFIqc89LKBcs31FsZsO8QRuSn+0R5KStN8ka+f8+fqrgAlntP9uikKHF5kU3UCQ+2ypwdPdUdtjqEHQlrlRbu/Oqg8qs3b+ip22YTRX6VG5xtYzIjtACq+wWWQaSOP0SeasIPsqIK+g0HMB0Cr2USBdfv7NvzeYHR/a2MqfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314727; c=relaxed/simple;
	bh=oD1jv1+2JR1Q2y9XCyeniCSSRhnGIh6rXqX9MYt6enU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n1jpWbaHBri0zWuFzisFM4gqBB6Fr9oqcrzzJYv3UEXcTi5GVku/BMCkPeXvEmCPgjWIXK4iG7w0uAuqbYc6UamPX00mkN3VT9tPciaNndT12f0f7ZambkLtQDXXzamKAXIZBc/w5Y2O+LOgVXVARW2QXcv6Sclwvnw2f2CTINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9b0IT0D; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9b0IT0D"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0be50048eso836659f8f.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314724; x=1747919524; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn8OUWnAqAz4A+lGvm/M06nRuDDDhFvEseS7cLOQ9ho=;
        b=A9b0IT0DImbTAHzF5cOMpz1APgB7LvIRkUs4ldO4kTkoQQzTYA3RfmswUDY8zCtzzC
         hoZxfCBE5yYMA7d1LJ6W9LEOsITCuDM47BYV5RNeYLUNOR1Qk7GkOcXhEzcbRHVvd+O6
         m66eZSsDfOUV43Kiu6mFB7NuxN4ofZKeUX6OnQNEwrPrXtAmUswTx7pic0xb7hDZ0otn
         XmBL5hn2jYtFvgQ76T0egTX+7j4oIp7giPC+D64cRhH/baqiXxYWauTxNnRF1iELfsY6
         Zajdv4ZROALEbqa0rvyCYzqM+Osapt4WpGLf3GUpFxAw8M67aN4uCPOYQHgkYX3xdDKD
         YKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314724; x=1747919524;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn8OUWnAqAz4A+lGvm/M06nRuDDDhFvEseS7cLOQ9ho=;
        b=tmif1Duudrl+UAdg5X9Oyta/1GATOMVg98EI66pZ3KxIwkdMHbEOMIeEjEggkxV/Gx
         Kyi9jfHB/NLbgp+WHs/wl5iF40GQGSlBOktQkXkjdfasbwBja92nw7jVp39/qo43objW
         zOw+70TUitbw/MioOjhjtUc3Q1eDScy7avdM5DbLI8yRB3rornL3GUtrswY/PIMPG3uw
         Uu8dEd1n6bmsE1MWToRH8aPuts4Ct3j9SBa9GoZl82YuLbD4at4jZEXsd2URvNFy6HLc
         3FnWcZULejiyfZii38PVUUMT8UNaIey317V71HaMhFoQn/8Eaoi5zlH51f145LDR6k/l
         54TQ==
X-Gm-Message-State: AOJu0YzDinTVBJcK/l/yT+kz09YHpPZ560nhztaTcvfNjFvz9aE4JzeJ
	ZgW/G3r+w9RD0/FsCqV0ao9EZCngCi8Q3mrGsz7vh72vPw/hd7uM45SpCw==
X-Gm-Gg: ASbGncvKnLCvcouamiIq/Nq+u/grE5c0jRpE/TdKUzJbWVXDZpQ+xKrN8HencAkqsDQ
	tCsDsp2BglBZWr5W33aTBYvuzcOfhZXF+Mj0zc/kUgJzyMfBXP3I+0YwX1KyucQRcyZ3bF82XSp
	kaGaZG5xz7sKL816SYVthcS3tRw0WYNigKLdTZuofQL0zwE1zg45c+Cjx2Rw4YJT9x3ylQcg2Cj
	EEymLTaIJirKBOtAGGEheaY5GTNcbHOhnHurpsgrCsR6Peq2giQb6nx6xh+1WYmsZoE2OmGCCGv
	FpbTUt2+SUusBhyBFJH3gw7zFfrx2fBMDJlgaXB57Fth188C3pOsVyvLyH2n6bc=
X-Google-Smtp-Source: AGHT+IFHUVElGiNa7YTRMP+sRcNDViDBugRZ/YuMeqpvxz0Ch/AdKDjGzFto7aNEvoE8vZ48K1o7lA==
X-Received: by 2002:a05:600c:1d01:b0:43c:e8a5:87a with SMTP id 5b1f17b1804b1-442f210d5a4mr82265495e9.16.1747314711743;
        Thu, 15 May 2025 06:11:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8ab839esm30610405e9.17.2025.05.15.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:51 -0700 (PDT)
Message-Id: <767b1e74fc70d78c7e3c84a2dc5eb7b607252f4f.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:39 +0000
Subject: [PATCH 01/11] commit: simplify code
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

The difference of two unsigned integers is defined to be unsigned, and
therefore it is misleading to check whether it is greater than zero
(instead, the more natural way would be to check whether the difference
is zero or not).

Let's instead avoid the subtraction altogether, and compare the two
operands directly, which makes the code more obvious as a side effect.

Pointed out by CodeQL's rule with the ID
`cpp/unsigned-difference-expression-compared-zero`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66bd91fd523d..fba0dded64a7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1022,7 +1022,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			for (i = 0; i < the_repository->index->cache_nr; i++)
 				if (ce_intent_to_add(the_repository->index->cache[i]))
 					ita_nr++;
-			committable = the_repository->index->cache_nr - ita_nr > 0;
+			committable = the_repository->index->cache_nr > ita_nr;
 		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
-- 
gitgitgadget

