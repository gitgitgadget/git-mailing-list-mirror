Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795038840;
	b=t0HUkmZ6hyffWeSL76+hf1WqYs8cDpqb74+uE4bjkhrvQxv2rVB4ER36/oAL+5esvrhb
	 Zp7LdGLnxSQJZrHB5KASDGt3NfOGccuOyW7b17cVqk7d2phdmY3ZObqOe7hO6XyjF7ugJ
	 1HoLijXAq7LAKZq4qqUfbtrsSV2axbLfrticPsekT/IClEo113cnkPljQeOgww385ZQrn
	 Rk5CeBfl5hDpd2jAelq3sV4WJ9/EEU/2qYP4ejjgDgdEyVVBE7ANYFcRqRlx1aQ11TLvz
	 pQ+50948TPoPOmsHMykOR+uk6iz4DQEei/UKSzt7qwAAilzHx1FI9SGjkKZj9oo/7yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=cgXgNCR/ae5DHfQ9LZYpT7KcfIMty9leYKtPt8ITmlo=;
	b=ZKRbtTGqIoF4tfwLs8o71Yh9KP2PWVe2hdcHKvYhgOEebPf/bUojEQb3KUMlMxnnE7N/
	 paMzMJVQ9zdyj8xVhD/CqJDquNnyTguAqfxoQ94QcljuBgQX7xdADf3WEKdsh1+gNZ5Zi
	 k6VrYiCfrtW/+hJclPz3agI/K+7eFuEKvuXlZ/2tHSKd0S9XD3DnxOsXTHbJkFfvluEVm
	 ThtCKN/bPs7sqDcI0vQlFAC1EdRtXy/ppPJ7194ZLtMYluTpYKW0VB7D+XIsE1i+9wofN
	 xb4W5Y+0+Qw79c13lM50dErAhbBnbCc1HUctKr504ALG9AKMvfMjnSYUbENMYxBbAvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nkXFNgQ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74C606A338
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC74C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nkXFNgQ3
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso1101a12.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:53:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795038838; cv=none;
        d=google.com; s=arc-20260327;
        b=ZmAK9IABBjUeNScdMLYu69avpC0assJx/iYjZD3HKyqEhstjhpyOcpWq2tKosaFU8x
         D1gR6Amr5dPflqx7GE49Hy0hcJe3Z8r9IU0u4LCOR99POIfu9Sq2oIWzrt0yoSnDKOkQ
         wMdn75BRLNjXjcPwIqmnM+VOBlA+LE55Pxmrb9Rh8Izc4KHCV7jVSa2SxEiY3qJRGqM4
         lifVoGrLoN7BbemIM299NMf1CSKLji750thwegvHsN0h1eFiELcD77m4fQh6hOXeA7vH
         rhiF+ghJl3yeuLOSCc9nKZC/L2yWEzehmKJO4IxcZuinmOeq3AZMkM8dzlnTWliVlNeh
         JrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=cgXgNCR/ae5DHfQ9LZYpT7KcfIMty9leYKtPt8ITmlo=;
        fh=wrTqu/8TFdAZQutBq3Y0u8nP8uKQe1VGHpKpmLz4rHo=;
        b=oLo4EvWtgGQSKtZRT45JiQ5EgiT6syX3AIU9w2tok04VTOHhUs0UKHm8uCikdzWx11
         eYy8+ZmQAG8l7cZXXp34gOnvqXEV1ekRam2FMmS/dBxlVKUS9aeSapz/gGdFKdox/oIB
         s6ThafTY7v1FG/ERNOIqPbahI4HhOk09oT4cCJQ2AHPumIUNIsO+S2DaGHDyPHXjkdC0
         Jn/0eAeBG8J4NtPJl10BSvAbNZmXwUo5AU/Ez5P7KCt/WrM5mnnr11TONiSQeWLAsHOp
         x4kf95mOj9zwL7R0AxCfiDGjWK5jYVeUhzDMp3kIrJUE4nr+CjdX7ZjisLS4bK2ossbN
         W9ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795038838; x=1795643638; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgXgNCR/ae5DHfQ9LZYpT7KcfIMty9leYKtPt8ITmlo=;
        b=nkXFNgQ3wRalfyEYlHliLHUzXcMv5WNQvcbi2INJ9vf+Zrzifr+2ieAuqE45OcwZbI
         ssGDtRTFM/hseGzjtdXVfv+PISoOZ+e8F0cwh35mLTRVGe6f8dI5dcDPdGk9JmP4DK6F
         LzdYCUCRWSH5H44BJhj475c1tTddIzU0gTUPmeEHGjIz7SAROrHyb7YY6MFCshWFgVIH
         laqEO6KYi2c9q08pPkrAExznLPPbogQ+/wjLP+F0+rBoCUTtglXuSP0eNFz6D17w+tlO
         pqJWMpJmXNSUV9NzGYa08K7VmNFJXtQz21Qxa+Bf9ZNIOAQxSNaccOh889atQqKJP/rU
         VBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038838; x=1795643638;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cgXgNCR/ae5DHfQ9LZYpT7KcfIMty9leYKtPt8ITmlo=;
        b=pW1aDW7vDgg1Y4jvpeAAYhZVV7fVmsIKU6uGNuOToj9hmxr3dIcL7mFCiXxjHHkSuJ
         Td77TUAPyBBu5Xyx4G8h7m8oslkEOgqlEQOlfLOOOXgJJraXfjwZl2LC/fxbtLf6yzTq
         nmwL09P09hJ+0Y7cniltueOvCdsZJDHs9wWJbWLEu4n1SISzJhRoQUsqAu8hZEKZxeig
         QZl9YHiVaWfghS48kIv+G2HVO4HRxkwxNLXqiZ6l7452ADaeNS3adSsKyGbu6tciOPeu
         3Zr+FaA8agdjaiQwdssbrXmXRHk9lesZqBsognR24IBqrz2yEivLdPICE36Nm7AVlP63
         k+zg==
X-Forwarded-Encrypted: i=1; AL+hErGloEJalD2ErlQZ44ds3OJhe7T1LwSX2XwUTfNOf2KKSONNvoNFg7a8aTIdS8rBL6RBGvo=@vger.kernel.org
X-Gm-Message-State: APuU4Z88+K418Uzy4pNvr9kwk1K5xNediO3/1Nck3Oa2RzWjfudw6rX6
	tMmW1Yz4GEh6FvvxmeSAgkZslCrRz3haT5mFQd8ri7telJ/IM1DJntCMOHR4jt9Fb06B16VyiZn
	OGNVKpY/6WU4bvElo27JmCVcD9EhHwc9z0oKUv1C8
X-Gm-Gg: AYBFou1YAdArlEMB9lckac0HVeG/xo4hdTPt7qe5mNr1vQKw0JZ1InLqLGAhlZUTcVF
	TV36BM6DeP36TuiGl8i/4RgYn2QR+pDzESz8JMeyj4SWgPptlFAaqc6OCFZ+JJfm/Hm6Nlc+U7E
	b3C3qHgfPOyYRrK7mr99Yi5onwklOFq7H894VGgcvB5pzgCThRM+m9mDSfcN1AwV6RVKUskUFG/
	H0y8EgR1hsXbnn9L6bSWVOEsBliBOeOdX26MuGmTYzAYuRd4bou4U3AkHLMTaOSJb5BoFazG0TO
	sT7axlTA69mEKVG3ccpJygP8RjpqBluhhhDU6zss0iPoFyA6J9D5FWcuyBdL9qwJSJXDG0Ayqek
	h2ZkTAeeugkM5bihDHjesHqas5Nk7NcFOzUcpLOUAtNMa9g2K1xXFTjOUHBgEsQlYxkOv9mLTrw
	7GLvhhlr5y+tY=
X-Received: by 2002:aa7:c4ec:0:b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6ba100a9db7mr8273a12.7.1795038837696; Wed, 18 Nov 2026 13:53:57
 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 13:53:57 -0800
In-Reply-To: <av2TehodwlsK6BnO@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com> <6510dddc39ca61fe1ae2f81cb8e7febd5f82d5ca.1794022836.git.gitgitgadget@gmail.com>
 <av2TehodwlsK6BnO@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Wed, 18 Nov 2026 13:53:57 -0800
X-Gm-Features: AclHuK8DiXALX-cbACeZRnuakN4fYqmtKvL4E_RYBl9DEXratKmnHdbCCyS5oj0
Message-ID: <CAF+mdify3esjp-ghiFj6uQEEwqQvOzMd0+Q9Z36BoWQGADb8tg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] http: add http.retryStatusCodes config option
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Maybe the fact that Git now handles retries is a motivation for
> providers to fix their infrastructure and instead align on one specific
> error code here. So instead of making this configurable, can we instead
> nudge the ecosystem in the right direction and make providers fix their
> infra, so that it just works and users don't have to configure anything?

For rate limiting, I agree that providers should align on 429.
502/503/504 cover different failures: reverse proxies, CDNs, and
client-side proxies return 502/504 when a connection drops or times
out, and servers return 503 during temporary overload or maintenance.

We also should not retry them by default because in some setups they
could point to a permanently broken proxy or server. Keeping 429 as the
default lets CI systems and system administrators opt in centrally via
http.retryStatusCodes where 5xx errors are transient.

Thanks!
