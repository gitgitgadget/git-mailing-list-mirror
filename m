Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792534582;
	b=RL4c1S6WZgBgRR2IMR2P5+ko58qiZnvzhIQVhKp+P29h3A5KG0Rqg9fb0mw/8sPlyKtn
	 mGEPmVDj0/vPIHCGK+Mho9ktrdmsxkxr7fzP87SUd7DatqEfyWCSIgGPeBMoJi8pyQrbl
	 zfCn9YmUZL4tVYoFU89tGPNYuMEKrCAkZScC+EZZxhCOmGrFM1bU3qBY4+KfQjnbcmwxF
	 dztu7R1FeXmgAh4gBjv/aDdPAap5boCWWKTt+s7rwZ7ogVYNeXQLF+Jl+gfUpy4Dd3WtJ
	 G3EjG+PICpz731XW1vnm2YjsWaxniGCIoZkfQgcO257uFPZi950iLgdWuTWvyjXROVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=a1vwVTOnaR8nca5AYUrsG1KLQZzkhPA0lmdtpU6Py4w=;
	b=QDBHkiz5W1/DQMRgJdC5sVTvePG/nNvunpzL9k8yJFc1uzsUcE0EseKu39NxQRV1MPSI
	 A5Excte8bSUwSc6x0oI8ILhyTSygpE0vwzNWBQVwKarB4IhI6KMGBjqCrvHAjgZ9o5Y9M
	 tMu4XhI30sXsPe94PCcBpBoYqrPL8Arsops/JrOJxbwoL0vfXOEO7M3sFoZj2FGrMa3Vl
	 J0lONyT15CSzqN0lww4LIiXwJEHyv35LbeL/U+neYhMvUPL6+y7SfcMK5yfowKELLBD9t
	 7ZJWJs9cGrNZA2zdqadeLoR7sLLeHmZNkTK+fNHWzh0ZtocqUbvTW+AC8TA9dn6lgfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hmrMXukS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E693606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 22:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E693606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hmrMXukS
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2acc1e170cso3674966b.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792534580; cv=none;
        d=google.com; s=arc-20260327;
        b=IAG7lXOXNU8ET91Otb2+jp4jy5Fyhg+ebIJBnVLsiZaS6TCOcyeH5Cdy2+aCxcENlU
         7xOMUJkJ1ZyJmpst9CYWDEQ2wVfSYYfAfjBKZqOVfmhh5Tc+8T8T/KMcKu89SFpBsWPh
         2kf5cPcQaMB9L+IVGAYO7RGhuACvZmw/GQQ0mWeB9PllIoWqe/q+7Ddo/jZVjcdkW0oV
         7UEhqPDEHIiH64AO8toxF6GkZ7aFvE18JgFMq5waVYNvoxJB1/7/bm4mSc5tAQt60Z5Y
         bhpwmTIl5VqG4GgE1x8QiGkUSShSpzySNguWudNDBHBFcSMl0J4UKrWaDC9KHIc+CSdR
         a/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a1vwVTOnaR8nca5AYUrsG1KLQZzkhPA0lmdtpU6Py4w=;
        fh=EQSAdm3aN1LhADUld0TR+IGs+v75FElmDOwPtAdo2Rs=;
        b=E1zgMUgcXDowCikWpVk+4mLwfU8Fl9hfUMKnyECqwvdSdYqGoofwBNtTGCkg1hYI+H
         JgwKy0EbzPZATTdPA3XnkIDAFRcL3RJ4/O4J2hXomxd6USUgc58Q+KcP6yZ0nPnpzy8G
         uzXTZsofHJ6s04pv1sPB7aMmXjkFZgBv8rl1Hecvj/PcwXx69T4OHkOpDzqo1uj81NXt
         Ebc3X3j7FrGjxpw8iECvecxcbvLf9Yp1r8kieodIVUA2DcybEpn09fVoIaBj//W/GyQD
         bdJYS1E/NaOoV5jTe3R+E7Ssol9W+kyBZG6VVLqWZww5g4d61cFH2rFh+cBFfvFexpy9
         wgSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792534580; x=1793139380; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1vwVTOnaR8nca5AYUrsG1KLQZzkhPA0lmdtpU6Py4w=;
        b=hmrMXukSbxTyvAX57PpemPsMxwhGZobJ1wyFjO0dJQDlXmGdYkH9zGIP6gLx1PCYFH
         +DT+sXJymkvPDUY5b2NgtQ9NNukTgZ0ytn7xfCV07gyUeZshSVf5DbWpVSA1y+0b/KX+
         ROMOUMr0bznUs8HcztzjhzuLysIV/2c/ISuBljo8SrS/SqAf51OFe+griFsSgMzkjEv1
         pNE9G2ER1uRASKvPoz63L28YdBJwEYdjVfnsAhAoa1UTbrdb6y9c5keZLLFWzyoXy0Xd
         ENEThUJ0c34Y5X8v4gKeWdDC2bgWpc62Vcnx+2NJZ8ZzQ6mOu4CUZlM36oOV8i/eUwqD
         +inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792534580; x=1793139380;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a1vwVTOnaR8nca5AYUrsG1KLQZzkhPA0lmdtpU6Py4w=;
        b=1uJAJElqmEoPWyLdk0qCbktWMaFFUXJ+u9ftrfmZosoi09R3rWBpdR+UyAyOOugp3i
         29l0XezS/ZKRPfYh5Qrr91+eWurQLndniaxKFExkxvu543v3de85PQYBB8wXrR4DDjEn
         oHFS2hzg0Ki/kUqiidRcZVIixEB8+jAJFMxd6gLfc85bfiwAoOPocYNGC4oGXjgF2Jyl
         fTOW3CrUvzCUFTzX/cVfAag9fgAjViw3ytER+88KMDmYeSWHoXmFkJTlQpAO/vvlfA7v
         88mza1TdDtp5QJ2OHaAcOyJYr9UNFQCS/zF36354ZspFX+8ruEj515x1I2B/yEHhpL4I
         jS5g==
X-Forwarded-Encrypted: i=1; AKwUvByWaKFNf4DpTtYg6bYSiXTRYrfi/Tqmg09FZgQe9R4zjhjwSuugqUtdoKz3mZiIJDGC4Ws=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKc3NpXjRap3R+GqooKq8TBdz/5MjppGfL+hDn+NrB0ZVsCDdv
	3M/3052uoDndZzyrOAepDICosVmVXfsh3epiSLgO6fP/fF/Tp/ay1HzGCDmeJBiKT0c3q7j7WkH
	2uiHGiboYta3uhJ6kgXLKUph6kilAkmA=
X-Gm-Gg: AYBFou3cjwqZZGiPn/Rso2zgL3XzNfPeCK3PM3bwna6BnC0pv6zbTpEknhJWEMNnIJy
	+2+NSbk+dvUq8dAXI/Ev8V3CYsg7uQcM2DbjwMxjYAAC/MKCk2vS3Qq4ArvIMZNyUn7n2sc9oNT
	O3NqKAHk77PWNePL8ETzd931ZZzCQ4XHQWA7HXO/IL1hKupNyKweEx2XD3CZePAw5DJBNFg1mlJ
	9Rfb1aRPLPAxcJcCNG9QyvAvHsn9htkWXsqo/8qSzOb10nPXhQmbY+c1+abFacB7gz7f/eSXzPl
	YqilEkREXBdArX0+z2cVexlDIq1TMS6cjPbdWvccXyyOGDjXoWvIEeuEvhaLuGrQ7PtFrZ2NFrg
	mcuiMmICs9GZl2No0Dpccwl4=
X-Received: by 2002:a17:907:1c8f:b0:c2e:2252:6ddb with SMTP id
 a640c23a62f3a-c467961da02mr36647166b.10.1792534580465; Tue, 20 Oct 2026
 15:16:20 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017105244.90295-1-okhuomonajayi54@gmail.com>
 <CAPSxiM-OyrVEzYgja0nwa8PikfU1WpsCYbiNiXpcxb4TM4=mOA@mail.gmail.com> <xmqqwlrcrqaz.fsf@gitster.g>
In-Reply-To: <xmqqwlrcrqaz.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 20 Oct 2026 23:16:09 +0100
X-Gm-Features: AclHuK9abc1NwPu1_1GXID97FPOfLs7Rw0w25QtQloIR-IVzXiiebAxp0Zxnfq8
Message-ID: <CAPSxiM-8Uuj5HMDbz_Mow6gYfUkYTiPVVc+Uc0qQbVYD9jjrYA@mail.gmail.com>
Subject: Re: [Outreachy PATCH] merge-blobs: stop using the_repository
To: Junio C Hamano <gitster@pobox.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> Is that really needed?
>
> I thought that we already use short-and-sweet "r" elsewhere, and it
> is expected we will have many more functions that take "struct
> repository *" as the first parameter as the libification stuff goes
> further, so if we consistently say "r", that would be just familiar
> and descriptive as "repository" to our developers, without risking
> to make readers wonder what "repo" stands for, things other than
> "repository", like "reposses" ;-).

We also have "repo" used in some places, we might want to pick one, but
I do not think it is a big issue.

Since, there instances of "r"  Okhuomon does not have to send a new patch
for changing the variable name then.

Thanks.
