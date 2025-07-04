Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE42F2705
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751627690; cv=none; b=UdCwWgCdNwZRN8Nw16F3ryHemPU7BvLikrBAwJbu4R7pGTVG5TS2ZkGGrSRze7NKNVW287JJViFaJotpUtUgvdeNgPR3nN6rv0ZvVQNOub2cOFQrL6tNTGTNdv4V2qEUFDCabY2kUB21x53TVlTFyjIzCMax0EzNwmXRqHV7Fyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751627690; c=relaxed/simple;
	bh=t6lMB7XXOjY1+AJ32Dm2i/mC/X5DzrjUEOwm5jv0r6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8UJn7FB1+oVEQdA6hQdVyQ8BHz7xcbjyo1aP36krBgH35gJcQzBL1LXkxurykY81oNawxACRNRbTPACzjK6vFO+vgFo2c78NyohE5cbyzKnkvtqxI52yHMBMunGK9tEOzbDEWxiBZJ+r0UV8duQCgSpGVuTtKKU1Wlq2VCa7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpUxyKSx; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpUxyKSx"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso1270099a91.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751627689; x=1752232489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/QyAZmEBeg5SJDHwMfkzcSEqqQPh1nEnAi9M6VL/gM=;
        b=VpUxyKSxdJ7eHTZLDSny0CdcgL3ENQj53fh9VGRf6LBYqyNCvobjaVUNR76WT681Ih
         Ytq5Wgp7pwR0N3wxVs8A1f2PYOcYQHCTklQT4ommsV+G4yWa9IlLN9sgz9wq54Yf6BC2
         yhKbN+6iy1WPbG3tder9Vkv6N7LqHyspAvjUvsp8bk2AW8ib5PThtjO5tx0Vyb4IU1Pk
         GHjxBhHeEmRYmoYoHpWxw1rrnmc0Y7rR6W+W4x/AJi7Y2yNSVb4kVXZcwLLdHVQFiLdE
         zDVxJShXdpYnXJYVNY1bbaW0vkqgBevavNL/Bv2uD4I9c7yF1Dt8Q81xN/ykA1Pk1O3i
         sV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751627689; x=1752232489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/QyAZmEBeg5SJDHwMfkzcSEqqQPh1nEnAi9M6VL/gM=;
        b=aEIPh3amJMjgr1YYJPJByvaTd+Dd5DXM47Ni4xEnzSugiVUZcTEhdWItuIfZmEh0Fh
         Y/eadPHbjaUqI2EbTOlhUgRbnAtYNUO4PZj5rm+42PiBAQeaxpCYDsv7etAnOIfczCKz
         RSosnC0O45w41gU8N6ABu7IOc5GQzNWc2cKtAqGXDMqWBhwOAV1UxpdQONWBAVxQkM++
         onO5lSY2Mqq00oBR+2Kv5ZBvNmPXVYHN3qTrt0+GHRkavUO5ipLu1ix0Xn66a+WHwZn/
         ftEz30ZkBAQPDttdgl7uxMld89xwieAOU5bCSIY/0EGDWkPjkEohI6RBuTQ1i/xeKLpV
         +CvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPeeIA/OSIFfu5PyzM53YTaqGN3jB3noi893x2K4gFoD1s8wlckURIzxFGdzxbZk6Pjmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyREb4n7BDhB1+FLgBGMF1kUMhACAfXsUQJihDCQAFvq7VdmKrh
	yHj7e3PSZyO745vEvB4MLd5kcrYiML0FOFaJfuJvGH9B4SjXYZD6cit5
X-Gm-Gg: ASbGncsBaCYYtBAv2qCilaroLUf+JlHg9BNfriSFHa0zkiPDYJahw+a55Pkxei00Q9O
	47IXApr4mSWiKEK/MLHKenN1pgSxNGnSHpMuRlRWn81Zb144r8cWja1A06V2+xwAdpGVpI8Nh88
	p1jwau4DCMMREAoOVVq9Rtkjd/V9+/wLGPRBSmBgpTP1TJ1VI4vSwrcRKl+HJlhLp3Al44ON6W3
	WKdMkEQyF6FTJk5yaLrF0D+HxXNV1cP+2sMgSDlMk3KGYtyOd+qmhsbUhCHki0pD7WK7sBQdmER
	kksl94CIkD9Qdvpw8frWjDtF/UpWv4SllX97DvwwOhIYTEq8Igm5bIxr6D9mU5vEYJ2+WIx6e9c
	PDbo=
X-Google-Smtp-Source: AGHT+IGHZuFuWPUZNKqI6kUQQNNNS9xgXCXJQ3X3bpCdzuPHbNmIQynlkzSvk74+671DqyQLMK6zVw==
X-Received: by 2002:a17:90b:6ce:b0:311:ad7f:329f with SMTP id 98e67ed59e1d1-31aac53af2amr3176041a91.31.1751627688553;
        Fri, 04 Jul 2025 04:14:48 -0700 (PDT)
Received: from r760 ([188.253.126.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9ccf8881sm4720522a91.29.2025.07.04.04.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 04:14:48 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v4 0/4] bloom: enable bloom filter optimization for multiple pathspec elements in revision traversal
Date: Fri,  4 Jul 2025 19:14:33 +0800
Message-ID: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.107.g33b6ec8c79
In-Reply-To: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
References: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables bloom filter optimization for multiple pathspec
elements. Compared to v3, v4 rename *_bloom_key and *_bloom_keyvec methods
to bloom_key_* and bloom_keyvec_*, respectively, to follow the git code
guidelines. Also, it adds a new test helper to return murmur3 hash.

Lidong Yan (4):
  bloom: add test helper to return murmur3 hash
  bloom: rename function operates on bloom_key
  bloom: replace struct bloom_key * with struct bloom_keyvec
  bloom: optimize multiple pathspec items in revision traversal

 blame.c               |   2 +-
 bloom.c               |  52 +++++++++++++++--
 bloom.h               |  41 +++++++++----
 line-log.c            |   4 +-
 revision.c            | 131 +++++++++++++++++++++++-------------------
 revision.h            |   6 +-
 t/helper/test-bloom.c |   8 +--
 t/t4216-log-bloom.sh  |  23 +++++---
 8 files changed, 174 insertions(+), 93 deletions(-)

-- 
2.50.0.107.g33b6ec8c79

