Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3713E02A
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770517693; cv=pass; b=ZXmhPGnMc7blo8OmQhtxZx/EM5ZNB53a+QrrF0cMwsd41FEN/G5e0/DkCIyPQpR/brHuZl+/8dWM2gBzhAkY7ArQXjtvppxMhDqIlxCx+7yTi4CQu/O+/9bMFOc1JquTxmHVIW6ZxRUgERdmoQuhCrqUGii4VCjl3HhNJ/T/oWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770517693; c=relaxed/simple;
	bh=L8GzZlqqtNOGAoHkdalWVv4I/wupcj8UVz0ukxEvSLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz98ct9pyQ3Al3++3wPqz9OIYPKx5WARx//iYJnHybRc/3rKtLxAkxNaUejUQvX0V0LuxLprlr6RZRqd+gt8Qr9cASXXiFwEzc+Kek/IAAsmIFUb9qkpM4H0NEoNZuoVgZb78WuTHgzRglhhjlV6mdSSjiq97ClKVziCF2prZl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/jQYrdb; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/jQYrdb"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c698873a1deso1650118a12.0
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 18:28:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770517692; cv=none;
        d=google.com; s=arc-20240605;
        b=RrpxGSBAMZQouFZQPlqm9DHg2dcO9rO4PmzXITBBV7JgJnjmugs/GZ9QHzr1D4g3bI
         qGKTUGbdOoPzeODLUtzYs5NCjVH9RvLn7J71sozZEtrorO7r3KoLYhxNeRofpznlda6S
         Vc82tsXDEE7aIKzAgtgVBEYKocUMWaw5zAQEdZtS+CXFey4SUb570zoRNrx9xdeHSlyl
         m6dEid0LGIKCv0zewtoPIeciM/iN9yj3ESe3og3zL6TtI6AoKqkouVEPwhjnclJodF43
         dSNMZNijfJe8YUhYymsK6LlUzIvKs8Hwt76Z+FGz3HHEC+Vg0UktLHaBvwynoduBxv5t
         nnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L8GzZlqqtNOGAoHkdalWVv4I/wupcj8UVz0ukxEvSLg=;
        fh=gvIsCH6h5VpgUnY7aF+K/brDuP4oJiTe2ppwfN4WE1g=;
        b=k5BS8ssWWXtizjsHxhPvc+qoUXxxuLn1t/WoxCxvYIkXvndtCD3ySlsq3Rnd0HDhEU
         RDvfEnk1AeT53+okteY7lcTY2hIZGPlOUoF76rTICbGdXjYXYtPo1abhE8XPmiggFGLQ
         f4DtpGDKTvfyfl9+FUhrLCdBHn+h1mUFd/V3FrnzmrINp4sj2FXUQC7NX19HRc1TCOXy
         TnyqztvvYitYWAI02vhKxNWpqZuyjVt5jrFGXjQXlyRAClm7B5e28GIQKyun9spwoxn7
         NwL8+Cin9FDIOdZYZRUbLvrUxD6IjafzKlR1r1UeF7vscy3u+6gMgxJCuirtQjlqVvyb
         U2hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770517692; x=1771122492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8GzZlqqtNOGAoHkdalWVv4I/wupcj8UVz0ukxEvSLg=;
        b=Z/jQYrdbzfShyZuSDNsMNc/BGlBh+jLSNv3gfwS12tysHWsXANWjvz0MjwbKFwUY3a
         ZcYa510OwXvRTf5bI37IlM0EaKYC6ukaNuP2wY81bF5+YI1rkJApGsH6dMoFQsNl+xDx
         nIUlVDnuFQwlSDM0e3AAUkn9oFioE65N5I55cu0zJ1v4D9QqI/tzp+nxnhucGe23DLeV
         IVZi9xoHCqVa1x8Js7W2IDHpFYqmQrMfwvxhpYcB1Mjo70cw2GpCVqPHLLJ5MD/NgPDf
         nkWSY1u24dZWxtPoSIoOp61hBY9K8GVjRQe5BiP8kU6FMRNqa2xSdiUiYWLKjXdISY7X
         wNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770517692; x=1771122492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8GzZlqqtNOGAoHkdalWVv4I/wupcj8UVz0ukxEvSLg=;
        b=smlbTkwaxlasJMYGJyiRKmwiluFDWlFS9yDTbUiWNHpDHZzuhLMp44Sbbn1qtjNd9x
         NbTofFg9jyal44nq9TZ37+4vpO1jtUQbuJhhxme2c4dMbCBfwaANgXS5Fm0pCUyW0IDB
         uqeB84wbdNFga7dgGvL2YHOS8jlNAx4DStFsQRCVgNl6tQ8SzUZ8YQBacV5rW/+Q7n86
         Usmkky2htRJHKhiofm1RaI/F0LShT825xR67MDitHeW0wPh4xaQsplQ1AoeF9y4HLXrD
         Y5yjWERpk1k2/9lDCjq++21csZmQqYbQU2C+aiazSG8Cpn/JTderSOfzRpVsoNXS2/cD
         uiMg==
X-Gm-Message-State: AOJu0YyRBM+mMC3JzrsawzK9sqzRBCT4FYZMF3LdYozdWiAblzfEp7qV
	jj4QT1l3EKQLukXn1YDAR+n8wi+WwYzjjKV4XNOWoaE+GrL2gjVB2/rsu56nXjknDo66EcZ0j0m
	rl1TPl9NKyWmdiZBmUbtIHiS5DMOrdM0=
X-Gm-Gg: AZuq6aJtZuIQ2GU3dIudGGAIOWiy/gtuPllaOp0mOSlPnW2rcXlK72RhWCajBLlDegW
	ou6CxUMyJm6WdqHdZkn+KU8+oigfKM/JD6Is3CudTFmNG5AdYPVQeZQ84jAUoxjcC4keYXs/lvj
	f9yIsKKdr8c5t6OneOX6yjumoEGf1Etrec61lHlocHphkO4wdbyct16GsgSqgfKmpIJ4klRiBYa
	c3sdsbmoH0+0UnjzYzRK0hmOhdY4JRMiyWLlWwOMOMzqcri9zeXCSe0nAARKkEFY13MzrPL8bja
	GEr7aKtqUITT2vQqMeD/dyOHV55AlaHWpJC38H3NW5Lg+aIvGC1mPxBmwdS4shIQqL2TiMbZULX
	1iWtWJdSCO6CmfkizSktZIapr1Q==
X-Received: by 2002:a17:903:1aa7:b0:2a9:5e25:4708 with SMTP id
 d9443c01a7336-2a95e255b6emr47366995ad.3.1770517692444; Sat, 07 Feb 2026
 18:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADjtP1FSAQZRyBCjPZ00Y2g=fdtRZWHP44XLqjor-OrYXAN-vw@mail.gmail.com>
In-Reply-To: <CADjtP1FSAQZRyBCjPZ00Y2g=fdtRZWHP44XLqjor-OrYXAN-vw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 7 Feb 2026 21:28:01 -0500
X-Gm-Features: AZwV_QhN2I0OvvLmYTjfGcSqsTLwPS-YpoqNjcitKjmPpNj_r-NjtJJcLJinltw
Message-ID: <CALnO6CAS5bpxDuqZ1Tf=SeY5Z6JpRpm1vbPCUtnyj6AsNqGJ8Q@mail.gmail.com>
Subject: Re: git clean ignore
To: Sylvain Rabot <sylvain@abstraction.fr>
Cc: git <git@vger.kernel.org>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 9:53=E2=80=AFAM Sylvain Rabot <sylvain@abstraction.f=
r> wrote:
>
> Hi,
>
> I'm a big user of git clean -fdx which is the shortest path to a clean wo=
rktree.

If you can't drop -x for some reason, consider "git worktree add" ?

--=20
D. Ben Knoble
