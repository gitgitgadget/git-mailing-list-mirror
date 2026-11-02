Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648433;
	b=K9aYAUHSSGa1clwpFjnuCgUS6x4gyGrAGWCnEjMr5yrIb6ijxZ4RV05D1hbR1NYsEm82
	 QLTGkjuJwObyIT4w/psodjmYAlRDX0ju7j/g8qBNfs4bpR5AQUhl5LboOiNxudqExy7rW
	 wnFWGdaJolX8Tg2O2yG9p4t8pi2pZG0TRO4tEoLjRKSG0T3NRibAy3yjEpljJu9jJfZBp
	 Od7jBfv85aeuj/xoKlAAqFvphSxCLWLRwKv2HV7vqmq3O7pPSc/VfAc7gRrn/x7STv3Bk
	 wMXMkHvK45oJDSVKXISQkqEbQzhOZwmd8sjkD4eAjNcE2drOejkKm/9m/TDbGB1GqIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=VZ9FN4F2voOGS+anACp0/i7FTxMbQeDSoQF3jtjms9U=;
	b=py4USZc2zLwG7WZN7kC9gWepvl+6zEqtbhetsGaHIqstU3uLwmyOYCOIvspNLFov+pFl
	 OEn2pKh9kfw03J9zupq6JS98oGQHQl5WjF9Q7YrfavyKOAlYwL2EcuBgKTQMO8SrYGLoh
	 QXMUqlbSCXKkEo/+IJiheo6mWPIFQ37A4FNb9OfFsmI2Bas4q/8J6TOFr6kYm9/IrKp5Q
	 GDmCpQ+DUld8nL/vhze41KjJbTdOrj3P6Wq7akiLsMcpTveFre5JHH2dpt3zjFQyFT319
	 pylS/J7Ny1gjR+l1PAiYR5p75Q77LHaVKFA48uvud92fi/5Am5JHCDXDC7P3OELCSQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ug5g4pjl;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D00606EEBC
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 19:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1D00606EEBC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ug5g4pjl
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91b55859245so52952486d6.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 11:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648432; x=1794253232; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VZ9FN4F2voOGS+anACp0/i7FTxMbQeDSoQF3jtjms9U=;
        b=ug5g4pjl/niIcZ4j9+qKnzEfw6e2Z6l8D1UHhvoDIq3ZkRpUufc6F/IeDNuv7k0Ozr
         b/hCs+L8pdiYJNckHWxeAwQAn+saNBXZ/kQYUc+SEgQn40q50wTlzo4DmDafhexuzo21
         7igSTDSZxqdGDl+Op/ur9TrUnJ3fEAQVJ/5ZkFF7cKn1bT2B7dNQgQ0momev2zb2nGTl
         9YkAGB0pZ/VHD/qBOysnmGMkIzb+Wu778yc08Pu7gPgoJDtQEvsYXX8zPo1K/JDCXxR1
         gribiygEC7XOKgJhCHDNFukjcYD2SWZi6jRpDAJUPOVnJ8eIKKtjLawPG5+9+xamYI11
         V5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648432; x=1794253232;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZ9FN4F2voOGS+anACp0/i7FTxMbQeDSoQF3jtjms9U=;
        b=GXSYcJWgRO4J5o9o+hecVAK8kHYOomiUlnCJCjI5Ipalv3mpi508o0bd/MiKYjmNfZ
         OegY3OHbSiJkEVq6babV84r3TLsZlMpubTyeqtuRZI2z2PbHraf3Kw7b0D36aBSen+2d
         5qLKofjTUuZS08spOHrQeS4CIKhPPulvoX51hlB2m+tHyLfPi5LEYwf2O00auNrKZ8pZ
         fgwP9whAhI4eWIKqa/KbdhobYCyttZN7CUPZhQkmk+5jWu+7JkZbb0Oyg/Zp0g6DV7LZ
         qVpU1cRYFrgppkVI1p+VvGSdSC86tCqL6Icxve6CTBZM5BvhKyXJop7NzKeLEEnIH0cV
         ZT1A==
X-Gm-Message-State: APuU4Z8RlyNOaPQ63ufIgAGGvC0FMpB410B1kfwLSjzmMT9chOpsn14Z
	ETX/t2wZYkvMAOmP3yS/MSVb9OAO9z02/fTReyCIkw9m1eoO7kHy3mp7551U4XZq
X-Gm-Gg: AYBFou0ra6uDgwH7EHCZEwEFO7glPU8Jcb5DQbTRKqfZgqgVEYVKjertm4gJUz9cIcP
	qPiiIJb7pPDvfsVglGDPj7GkUT421LFzMMmLzNoiPxD/7fXMWohWM6zEvkrF9eohoLuChsP11g2
	PoSsu8RE/TUKKezx3LjqFF0K46FBKlPU6SWfEYV697G1zTRIwQfBOr3pVddUYh3BjStzQmElF/x
	bgy9R+NFjhoZ9VyrlRN/SIyBaF9nTYnLK5AWR9IFwCJHwcgHjeKZhK28MoM6kH8PHJL1Pe0mEQm
	9tdRchayb3Tq1Cywm4FwuoBTd5/Uq5err3rlqKL2f1WKbLJIOx3vNyToO1xl7ZvUnTlo62krXf9
	2ML+Io3xCAHF2zt++eVTC3otgVrclqWwhJDd1iPoSY7eeNm4mC7yDmBZ+pQhnCL+1BwcCVcgpQs
	M5Dfyc5yLLMcg+37OzLGC2uABcaxJksQuGHvqYW3wsD76W2W5p80tTHylZqqsh77dCBJw4SiM14
	s6oPgp/1f741kDf6VY9y525X8wyhhU9tRej6PluI5QxpDqhaPzcZIxIOX5ALOUA6qrQg7pIT0aB
	Kyb/qfhtPfStueiJ+XTu0dsYgrErYOON
X-Received: by 2002:a05:6214:2585:b0:91c:797f:1210 with SMTP id 6a1803df08f44-91ca4c0357cmr176830086d6.55.1793648431494;
        Mon, 02 Nov 2026 11:40:31 -0800 (PST)
Received: from [127.0.0.1] ([172.214.47.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f254acsm99770266d6.11.2026.11.02.11.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:40:31 -0800 (PST)
Message-Id: <pull.2288.v4.git.1793648430.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 19:40:28 +0000
Subject: [PATCH v4 0/2] [Outreachy PATCH] t4041: use submodule repository for commit abbreviations
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

Srujith A Poojary (2):
  submodule: use the submodule repository to abbreviate commits
  t4041: test SHA-256 submodule abbreviations

 submodule.c                      |  5 +++--
 t/t4041-diff-submodule-option.sh | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2288%2Fpoojarysrujith%2Fmicroproject-git-libification-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2288/poojarysrujith/microproject-git-libification-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2288

Range-diff vs v3:

 1:  a8c54b9292 = 1:  a8c54b9292 submodule: use the submodule repository to abbreviate commits
 -:  ---------- > 2:  99a1234544 t4041: test SHA-256 submodule abbreviations

-- 
gitgitgadget
