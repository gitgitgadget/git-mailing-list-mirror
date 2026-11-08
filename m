Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794129255;
	b=ShiPJY9Zt2+L6efY4LvtUtMuniFNasmOWJv9uAEd1DVGvlZnwbNupE7nn96owZL7L91o
	 CH/cCLIGcKEgtyowjZN5KfZqLjg6xir7nVjqotSd933ymRfK83TGaQytImpfLkTAbaa3c
	 5LHrGDakQ5Zc3BtEPTBcTaFNKuDjycJDs7RV+6aR3kgpUBxP+lW6V9bAUjrBIjfQucxcT
	 xbcUaa0l3PzwHs7qx3bLYV5e126cLfqi0vE+0U9CFi4L1zuE1ZXyKfR2MTw6re3sIqa1n
	 IXbOXlimxixbD6/AZKl/R/gSlLiUoexX60CEhZLR11jGlf3UjNXC2oMS1lIEqn18IOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ag+X79g6HQG9cLNYLCBUvWaI1pt3WVvp4Xc6DGNwlHw=;
	b=3B1kFKHGnT2kIzIr0lp3qhdm4ufmZgBwwWgyRVtPWQv9EUl+DJc2dX2p8whJf5DlJUgl
	 06CDAR3J77VQnI4YQgdhLv9rsDJvUQWWl9r2adQwEZOq6kI4+oEkat8+IXrIv31e6P6aR
	 V/KNm5PlAIbsEBM4QQfIJ1y058lmkmfjWc4N3uj2yex+03oaWL5vxliks1MOLEo0hzHYW
	 iO51oKeA9e2vGaLTVFFZcwCu+xj6K7XmkAGxVTuSzFzqu5jrEF1TxRUSueJuJxrGWpf0E
	 H7B/JsHA5IPR1I1uZEk/2EU1iXx1GfaKCozExwE1hZZKmOGn3E5gAd6pIvngo4bgfyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=RGb3RCtc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B8606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 09:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA1B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=RGb3RCtc
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d473cfff6so795766b.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 01:14:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794129253; cv=none;
        d=google.com; s=arc-20260327;
        b=bp1CpA1sE5yW6NNqPmQxP6tP953dupXikdkjIDaLAkqk7uxTeHDHUOfuV4AQ44BvA5
         kAuNA5JRNrE39Mfo4TnQuGlqWZPrBqZGU4m8C1Iep3V0PNxOQvV/sFdJnjrj0z7K3OLV
         SmTeE0YhHGq8SUA8hOpFhpWe0k4Ras7jKyqSYRmPe9NAfzAIlOc7yU6Oh+bb62joaABs
         om6cFj6FrOEuv9ICvSaemjPl7zp5X0i9/YtBURaRhzs1K9yvaR5mtga2IOZwLWxgsalI
         g8qeArn287Ev0rNBnJRR5IHmxCTHM1tyjsNdvSatXMBSdPEvTvzzcAtdZ6eFVC5tBMAA
         k7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ag+X79g6HQG9cLNYLCBUvWaI1pt3WVvp4Xc6DGNwlHw=;
        fh=7TicZTHphpUp1+Hc/73T3BIRyS/lBBuZj0D19xU9RUE=;
        b=AYtmwQPpAcNlHQYRkJXbMMRdyLc62fDl25yfkHn8sTx426HIXktBfjW2/4vNLd+43a
         a1J7bT1WO1UOAW8C+3MiGHPpHhqVCEN5RoQiufxrY2gG1Qy0N4Y5WGBXFdO2jC0SeWW3
         xC0u6JcGJZT4tgGHwmh+CujP8NMvkYQC+qyh1MNj6QxkUa9R7t400j6wakOmEL5tw+Is
         0IRduiX6l6NmNF2wyO4kx5Jx2Zod5mJ7SbIJwcPXW+SbcrRE7/pXPF3mCfyoN4nI+Zyc
         7SWLApjjtajYMBJXI97OeJsVZOAcKc6KSLFSQAc1NIaptSVDTghS37hJaaHfQGxBGtip
         jwNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794129253; x=1794734053; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ag+X79g6HQG9cLNYLCBUvWaI1pt3WVvp4Xc6DGNwlHw=;
        b=RGb3RCtczIAvLGG6RuYEPj7ADIcLE9vHI3zN6cDmDyT3EPXbAw0HrTknt703laLc7D
         5Jh6OAa0foib1huSuml5xf97CAoGBdGGqT1SGaR6ou8gy+esBRDnhRxAGuJ/GAVXVJvV
         neBoPLKHlYe8SZMLhgSq/kfucub29Wh/8jG2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794129253; x=1794734053;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ag+X79g6HQG9cLNYLCBUvWaI1pt3WVvp4Xc6DGNwlHw=;
        b=2SMF0TidoahjMyob0tH1suiHClWlwo4bLCxSBceThXZ+M/uGmVFYYGzZElTIz63Q2+
         MM1BVTZ2WRb8djVrH/moePwCwLXOHZbN/ZBzEmp7hP5R0T94VX+iu2LDQMEfykUb+7H1
         G6XMBWuuOyVokocccJj1Hfep78TJyDP0AcN2IDIdK10ECv6FeLFYt1HFSZtOTMXNLl32
         CIOotoi6aXRyKSVuFLyJrgT/4vSvqFabVGffE7veWWzAi3NiCcUliwq2Eqa6LgPKPpEa
         kwqudlj/sfg63L+/RDs05LcgJxcmhfPtbZk+7f/YRKDQRHz5p8pkTFrTg4xKMpaRXWrw
         SjAQ==
X-Forwarded-Encrypted: i=1; AL+hErGmWoT0kN3SUH2L+kKHTn2llQ75rEADwt+ssC4R0xOSR0Yd6HwGySQiu+JI2tzmp/Dx2+4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nFanm+GYOJKoHodXS8kwZmIk+/DPVvpXIchaTMO3HFhZKrMic
	ku9XCdtg02fG6RYU3OvyAVItCHojxm6i6awMMIyRWdlOILTg/9xxCRgViLZtkW0SXEVsH1gjbG4
	NOclNgtJ2aXr9PWHjwT+o2ELYwN20yh9ifMpofMZEpg==
X-Gm-Gg: AYBFou2pQk+b58hJ4e5VIiQoMZHju3frWkvlQGV4P2voomb7HYwbxDGVl7bATJOjnxu
	ArnfnM4cnvN3+9DdONjMQYhSxeMH4zKdFNhkyxUHgUj1x7dWUVpTXT0hvCaC0Uk7zFDAfpVPrY8
	6kXvwenRAEeEKKBraHyEiMT16Oc3zDvOzUzyQOoBSg2buApJNZv/ReiSyGmpM2/MNxvRmMQMt+q
	t7bX3rUEVMCU9pZ2U0uqRWCUwotaRSXjWzmtKT2u/3WOF2//GkNjeul4Y3e8jsduAVNZCzHfSX3
	DGmgX2kHpahwaPcGHm9HJ4FamxEcWa7XpAcD//lYGcI+S8/NQtZt/ado45Z4Mff3HET4tETupdX
	g8EtriCUTEx9tt5e3sz/fJzvaE88PMUY6Ho0bpg==
X-Received: by 2002:a17:907:948e:b0:c40:4965:72c3 with SMTP id
 a640c23a62f3a-c4d6db3d277mr72153566b.19.1794129253101; Sun, 08 Nov 2026
 01:14:13 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com> <xmqqjymo8bv6.fsf@gitster.g>
In-Reply-To: <xmqqjymo8bv6.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 8 Nov 2026 10:13:59 +0100
X-Gm-Features: AclHuK8cAf6bgLXx-e93IhYdTNHalmPSSha7KYeFjrh9mZ-BsuTbVVeaL_bpKYY
Message-ID: <CAL71e4OGJWYPO5Wbcj16JwbhiXB0+EiAerH+ur19jWiM2hkyKg@mail.gmail.com>
Subject: Re: [PATCH 0/3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Nov 2026 at 00:23, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Open question: is patch 3 wanted? It folds "genzeros" into "genbytes",
> > spelling the NUL byte as "NUL", so that there is a single command.
>
> I would suggest genbytes to take the value of the byte in decimal or
> hex, instead of av[1][0], so that you do not have to treat NUL any
> specially.  I would actually think it is even better to limit the
> input format only to [0-9a-f][0-9a-f], i.e., two hexadecimal digits
> that does not allow uppercase to represent values 0-255 (inclusive),
> without support for any other input format like decimal.
>
> After all, this is just a test helper, so ergonomics or flexibility
> do not matter as much as simplicity.

Yes, I actually had one local prototype that used this approach,
but I held off on it since it would mean a semantically larger
change.  But I agree it would improve the ergonomics, so I can do it.
And it's not too many call sites to convert anyway.

Thanks,
Kristofer
