Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793104609;
	b=CEmhSB8I0kUSUYrZ1i0M5hCHnV9TZHYSw+4QOq1oJ+UTxogh7bEhTjNionAYDF7b0HHe
	 NzLZznoKsPFgQmdlH4HmGrlWgVQilCvdK1kCF1kVR7wQ2vB02mT2KbW3Kq24rPjtZwiRS
	 r+6J6rdVNrmmGEm5f+3sfx37yEQj1+4H6UpkfwcX2wvL09tUtypInY8j5m69pFh+wxpH9
	 yO8jsjYxchLHA0wDcq6KVlb2yOS+JqAg/upRscnV+KsA0dNMF594p80zcnPa0mBolLUDi
	 BvtoH5Ys0Ctis4HTRMXMU203teiJOF95rtHQVtb33IOXbSZbQSEmvXIt8B6fvStAsnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Pna7HFd5M5UVOeeaPHoPJT+eFU8Em+srsee8in3jjgw=;
	b=W376SG24EPidNoTE6TD+83jDvFNhbh6/4M8II/AjUv8YJkpZf4ND3ft/B8Injl5KTP0x
	 nE78X/w6h5HU2oABtLE+yUqoo6LL+wU917P0P6N7kllTQ9OzBIvZWepjaOjRSXyiY8jCe
	 oJvBQhWzykmUYEgf4bU5km1pwxTXm0U76tdS4r98OFHGB/wo81gQvNqy4mmmk5tY+kpl2
	 +19lC8vxwptyEjR0YfWY7U5wI91UuNjn5akFLFDQeFSvZVq6J3XJ9yZmXiBYfmiHuLq+X
	 eRB6ucGmlRysljYXbjhBN5Pcg7Gx874rcqB4SMW4rxXCwr93bQu7iz/sadfdZ6ElqbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qdSE36LI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CCB606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33CCB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qdSE36LI
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-84a248254f4so2654427a34.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793104608; cv=none;
        d=google.com; s=arc-20260327;
        b=hSiB1UC4PVRanG88RHfYjCgkevTeT7LWDcbsK3/S9N8EvpqjoUBY0ZCESWmdRojDE7
         7J5+74dUrv12EB8D10vaxKJAVV3qsJ8P7xfuoofCiiRSUAJMgfA6dUUzpRf0iSN3O2RB
         A1XNXpPS9ybJqX8cfitphKsWkQzMxybtcZAekRz9UFED92dEu9DFE8CMO6BrANcO+cT2
         pBiXMxYvgukOYtAFto87ibZvkH0YKTX/RI3r/W8OhFEnPvp9DY5j+Uev7d9aF0LRMfWM
         UjFXA7OKOFDaKkC0PRniMxNrjjVWUMAL0eNLf+UDbuhuTPo5dCPPygwRW064H/tNYFhY
         eVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pna7HFd5M5UVOeeaPHoPJT+eFU8Em+srsee8in3jjgw=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=HrkPPFnUjNsSzgINaOGqa8Um5fiqZ7Rb1Qk3AizUgHFqfP/iItCsQUWUaLZbJBA/XF
         dOM1GsCAp+rqI1TB6GDC5QRpo9iMW9+Ntd4jO1BPrXBOGcygjKiTEHZgHIH2YrZCH8JY
         qy2toK2HafF8MqzKpCXBFAZ5TF0UY1GoznFhF8PYOYVsXDdY1JEKxS8+72wGVfnh9T1m
         r7FdtJgZXh9AcHnrmI+w87RZ9VIHccadiFV8oTkX2TRg5hSG1d+NdbNUKBSTK5t28zxT
         f0Zd7x5UnfgjYiAoWxM/7Z+z7sNqnIJrTDfDePpsd9SC7OUmjrQ8DsQVfmC8MBJeX3C3
         KH0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793104608; x=1793709408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pna7HFd5M5UVOeeaPHoPJT+eFU8Em+srsee8in3jjgw=;
        b=qdSE36LIwSU/fp8abIDZFprVXJU/wD3URU1Co/hczScyH07inGATSiAuIm5rC7fD0m
         wqoP5NwZ/O2r591iW6x5wgQXewOOsw/sCbrU+SNrr+YO1Ec7ybnP4QFDPyajTWvYJ1RQ
         vNDbgcy3mVK3oyCUTDQXvI1RDQEFFTd9eIM1hst5PxC9NRatB/34Ro2PbdO+6McNESWK
         Sq0uTDFdLJ4YORvwWdDLMbPP3q1wDcLNXlePuTneUFva1HinEW6QLw7IjiX5F/cTErk9
         UxR1IW6LZkSmYI+TRNwNi+pjgmN4YGrkmKbxd8mBw/+0ba0pNas6L6yiGDz0+ndjGx6Y
         Is2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793104608; x=1793709408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pna7HFd5M5UVOeeaPHoPJT+eFU8Em+srsee8in3jjgw=;
        b=jcC9AwNrveTck0nyXCn6RzRktlj4jEtj21xB7RfVC2BLG1tsGvHkOw6h90C1DyHw01
         2ynT08A1RXp4kV+pCqKUCYGifTLaOSL6VYCxDjVE3XD6oxLjW9pCSHyXUWIGtsiQvp6q
         hz4uVS8I680jN80Em6/2ScFJbRBVc5nErWw2Gd1c3FdTXoOiC01dMxGjo+WJ2pf+1cyk
         BM2rXxmCTaniPnIs0kMRZL1mjtvaEkS9nuSrOXvlDrrCyxBn0NlET6/EZjdQxTZIBWqm
         mrF+HQytENj1gwF5EfycXEBrXP7c+nmn2Al9PUUn99CYzHb+QBzw7OswBrfGIjRdn8Lk
         sm+g==
X-Gm-Message-State: AFq9FYL8ZGxRQax65U4d3JfCu74B9zJzFcMZaILaRZ2iAs/V5JQTa2fK
	+noanF4uz3YS02ZOicHgtBzxOVeDE9PXaNJ8t3+qGyfl9Isb6l6oc0MNtwr7FJ0WP9dLMWSQocK
	CYdaX8ffFaJsfHy5VKrIyFmfxO2Ofcm8oyrtQ
X-Gm-Gg: AYBFou25MjJ5l/l2/Svbk9ClUV4NZplwFn07uwGB1Skbzll3CT4OhjoeCsipvLJfkme
	FuhLTGwCdjIWLnfDzi6t7iF/RJzDqNaCI0UHPSgp75272RWkS+BXW1wulO1CPIhCOJHb6GUQkRf
	2Szs6S3YCbqqKA+MoUuE9K6vAztTk26rr5vXtDKNaoyBa/qdzHsGy758V1qUBvOGEDrBGn/8mYk
	yJ789BYNTxg0wR8c1O7MUGSy5fgUJW+sbM7v/Yrk3UkZ3S+6dsvpiEkD2LRlia6iPptqmFwM82v
	RWMX3Fy0Hm3bNLdngbC9aYCpJ/ia+DnzxMIdxTDfwA7SYiKN8NDAhzu4y/1gkz1ZRXdQSbN4GOz
	WtNQI3D61sUgK+eeRBM4ZSM6YyqScW2bi8LNh0eaNUC5PHMBUPmwgNIPKKx6O6ur4shOHnQ5aoa
	UM6zhC0rWn0bNNUBsq2fbaFVHP6CsHP+5+C13aZ0J8kBQ0sb3SaehG3cIbNoXme73HTpKqZHJaI
	U8WoPj613eTb5TXDJXglfR5
X-Received: by 2002:a05:6830:b13:b0:844:a8bf:7dc7 with SMTP id
 46e09a7af769-850fe6e7f2amr8037110a34.17.1793104608099; Tue, 27 Oct 2026
 05:36:48 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
 <20261023-pks-odb-files-reload-alternates-v2-5-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-5-30559d7ff43b@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Oct 2026 13:36:35 +0100
X-Gm-Features: AclHuK84KrTYXLl-wZN_UzoQyuEYoplv2UvAD_t4BgR89PR43GlDgrYaPV2dx6k
Message-ID: <CAP8UFD1-Fh-fiGpFiVtBk09JygbD0P5fOYHgXjvk1X+YUCVyPQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] odb/source-files: avoid stat'ing already-known alternates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> When adding alternates we first check whether the alternate exists
> before checking whether we already know about it. This results in a
> useless stat(3p) syscall in the case where we already track the
> alternate.
>
> Reorder the logic so that we first check whether we know the alternate
> already before checking whether its directory exists to avoid the
> syscall.

Does avoiding the syscall means not printing the "object directory %s
does not exist" error then, when we know the alternates but its
directory was removed?
