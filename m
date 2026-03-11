Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D234A76F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258546; cv=pass; b=uFuRNp4P/J7SyvGLRA1DqoLtoqouawjnzcBI3BZ5lQShhSDbXTRiXChBo8y4l/AQ6ezSFRkwSeJ7iMCVEVEBM/oVl6xQ4a7T6UpntPSEmFThgUcvJtnSOc2L0ZvhEMRvfG7BodrnL1VjHZlG1IpHD/jzXMkNFgxTwEj/E4+JmgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258546; c=relaxed/simple;
	bh=dEWMTJwyEN2/7akwMhMjZp16aXwepobKwuPij0Pkubw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdCE+ECrjSjK7mhLVE6WGu3jnFx7H/9iyi7lS+8IzzyojOHTkyw9DIWC2ddJV+us/Wy2uRaOJoLFhgD4tCBgyTRIfUYAwui7L1WYJp2LD3sz7GngH0CB3i92D4fZ33TXpfQmJCAu5xEKPRMkzfidTXNZELvWOebXEfjJPqAgMAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG2zGJmq; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG2zGJmq"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-798374d0f44so22337177b3.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773258541; cv=none;
        d=google.com; s=arc-20240605;
        b=TvfUMfI8X0Y8zGlIPywxP0emAai4pSmDFdsUo4cqAKoI+MduWuxF/pFaEn7bRmXjAD
         j1UfFCPKyIFN9IK2ervXyPYm5wwbfPqXmm61kK7blmNgqv/KWzKcbrf5ijXOb2aiBZXs
         V7DRTG1dp5XDaqxP3MsSxd1U/qPVbFiNqGYUvEX3opeEqmIeukDVfWOTGQv69pVUsHMp
         R/oBOWkiMZJH/ldJijNBp+CQr5UajwduPWdvRtt03AFaNRuQXsC+m+FPZUQJVKlJbX2r
         bk/uPrqhRLHEa+ZxlI6FbbUs0XiVa+hjH4qGRIfAvbfPhDRmaaS7pPFugtrxfw9lE3ZM
         97Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UC6gQnN5UUKowf8ow4wxLtDwlbpgwY14dFWKSf3+K8c=;
        fh=jlRpvZ9X+tvXm6YF0ePxl+1FyunRX2COKQGck/qQCks=;
        b=EMrQ5X84FBpEzi8CsXaYO5IT1PaVBCV5NBHPJY7bD4wQJpVnegLhHrKE+oAgOvR+sk
         qJqPyabWGtM64R8MveUHNmVEi0ZrAC1Ud0lJyfrKzkmrLqcs8J85RxYjXRDz9VCQLI0F
         jX9qjurLzxocYwoL3u1Ne+7k+SbX/jRkwk8aX483NHsma1pXlvRHiayfmkPIgAqgQv+t
         WRtnoq4AW2bbOy9pnw9wyig8y6XFhnlkwKXGIUaHZyRhRSu+E4+Bodb0eGtErDYiYXT4
         BkcbRjxwFVykIqcpxnV8/fxyAiIRJoiQz2Cn0iq2Xz081GCGlZiWGKkBt1iY7QkPKL5v
         FV4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258541; x=1773863341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UC6gQnN5UUKowf8ow4wxLtDwlbpgwY14dFWKSf3+K8c=;
        b=eG2zGJmqBrC3B1hZuxICgbrsDqNZneiKJy5aYjyB8Y45trAFx5q1hcgz8/pAqEOJ/W
         ZNMqZpj/b/EXR/0tjskKeIA1Hhr4AGI3H2PmKiTy/bj4QmemzWyGgn8BA/OZUVcfuaGq
         o0pNMviSFfGCxFtOTeaTxXaNLkLLfupFP8/Wt6vxGHlcFTqnX2+H2qdy4J2CDm4an74y
         tRZJff/QXe9oyIp35BOvN1djTUCmekUSqzPi62/s9DbZWOPRM1yl9sUWTGq8bxlKcDS9
         fQ69XzqoLKW9kwJyG0UOsRRCfUrPdI3kPBtk39U1O8g+iknHY4mW0hmnd5IgDyxfbmOl
         wpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258541; x=1773863341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC6gQnN5UUKowf8ow4wxLtDwlbpgwY14dFWKSf3+K8c=;
        b=l+ft7MqBILWMDPLuQNjQxtaPqrPgu6W82DwgS74ZrrNsKyzyNhi7XSvWMdXitm+Pxx
         iGwL7eC6rL7h5fa4X7GVXxiGfm9rWtyUTsOuRbNVUUy5FSQI06H+6sPYpsW96Uei5YhW
         yuoCe/mn4TFHStLo2ixRh99oyDCLaVi+KrJ/bjE1Dt+A5kZbhR24R/lWLhvFqxcJ2UTS
         JoOapsZlVR7Dv6j2l0p+af284E7w6gSdlsMcks5qnuhE6UnX2IHyeJ8rLpmNJtO/4u3F
         747Le3N7Iob23aS9dVVT+FohgUzIld0sBgeIN0H0aB2XH6zQv4Sucy69dTXNUmaC9Aeg
         jATQ==
X-Gm-Message-State: AOJu0YzlqH5t5Vggw3OSt/vRkObosTgbfYTTQX/qdC1YbH5zPkkhoJZZ
	GId6ajQjpzfl4B9KFf48piUDp2Uebgt7o5ScICNXzdg2p5i5/B0KryjNEhSL9SgelN7MMVf6wSt
	zOq1lKX289BDxzBGhOvzHZ97WTfGMvKs=
X-Gm-Gg: ATEYQzxbdTF6jnHOQ55mJkAMBG/B3i/3eqqaA7eiGcgpQRNyt6G8NU5lV2RqZ0Ybrei
	XclKoawyEO8tjEMPC1GiNAW5wTDgGvlaKpMj16a+zk8DEOMiNlmdmyLppPjz9FN7wkETWuergaP
	ZpV2tuCuxfHoAcWZZFdKryFfusPfBZ48eyD0oUz4u233SnjqKGzT01M5aJzJcH3p80aan9TGxPC
	hpFD6wgqD7srVZao6gcQEo+hgwgIXmzSbJ8t32qpTDgmZv0ZzVTYR+Eh4t0bxpR81N7apLQiAFH
	XxbJg/A6fvrtsjomFBIICEFfq2Cl5UBU5H7HbOIdvC/RlVa2Nw==
X-Received: by 2002:a05:690c:4b08:b0:794:bc47:df1 with SMTP id
 00721157ae682-799475e5ae4mr8902007b3.22.1773258540644; Wed, 11 Mar 2026
 12:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212041017.91370-1-amishhhaaaa@gmail.com> <20260228104654.80831-1-amishhhaaaa@gmail.com>
 <20260228104654.80831-2-amishhhaaaa@gmail.com> <xmqqwlzu43rh.fsf@gitster.g>
In-Reply-To: <xmqqwlzu43rh.fsf@gitster.g>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Thu, 12 Mar 2026 01:18:49 +0530
X-Gm-Features: AaiRm51JWGqu5pmQt2K-g7Ynjwt-3LS4LFM2huQ41KLU2sXfi_V-8_c-0UP9Wcw
Message-ID: <CAPvEtrf7gqyQYMcsii===kXY5Vut0EC_VsJ=xWUKNrq6YmA=nA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] help: cleanup the contruction of keys_uniq
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, avarab@gmail.com, peff@peff.net, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Perhaps something like this would replace the original "grep | sed"
> pipeline?
>
>         sed -E -e "
>                 /^[^.]+\.[^.]+$/b out
>                 /^[^.]+\.[^.]+\.[^.]+$/b out
>                 d
>                 : out
>                 s/\..*//
>         " human |
>         sort -u
>
>

Thank you for pointing me in the right direction!

-- 
Thanks,
Amisha
