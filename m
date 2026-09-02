Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD852E738A
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377007; cv=pass; b=U49utEZ7NfNkfV54L2TP8jae09vOiq87L/9JypZ12aUJO1kyFOt7VAPhJ2pf1/KM3sswW0445petHfbGWyaRqKtAzdm9uoEoHlGrRKEimNEKlYUSac/GHBEUfUDFCKadA6CjZSLP3G1Smulhfy1wWYFX6Xu4OtSEuzTdfio/HrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377007; c=relaxed/simple;
	bh=VMrDJBaa66KuFv0csy6O3qvERz8n2AoF6opzPYnVMGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7QDc6RbeSkAHaGM0+8nbmjx6phB6avZSM28JxrGDOK/90jErlWzwyZsYBQ5hqxZVYF34EbJvTvk9DYWfJwxKUdrmezUiZcbYh+O3ZDQ/igTNQHa1n0VPBVq5Heqw1yS0n+DTgwpBbX0GOVdH5oHHbCbEXmuM3Q/PL0zkh+6QHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2pfLKQW; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2pfLKQW"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so1767356a91.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 12:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788377006; cv=none;
        d=google.com; s=arc-20260327;
        b=fhQpjWjdxqQWUuCdaZdxpH6wMp3jqmBngjKVdWDAbYBkq6pflYt7vOt5HfTn0EwF3K
         2ChmTPxh7GsWS/kU+wX1hNxDoZjPnPUy2B9qDy8EQVKyUF5LT04i5v795Qm9ObHaYPcD
         Bxnv6qq0rPXT8uGDHiBqn6ftIDmWst2SylyZibOCrqq8ZxpPbaM7Bs0gRtnpFSgCcGEw
         3yhyX+l/7iOeg7HJfP5EpBYkqoVJUXacvUhhB7eMF+0sP8GfK/Np8S00nx8famTOFMuI
         sFiCf2d6RKvFPZXJY8S4q/dgZTuqcMubTU+P1Q8vkQWTXsCPc2m3nMcNCIzGbokOglyK
         J9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMrDJBaa66KuFv0csy6O3qvERz8n2AoF6opzPYnVMGQ=;
        fh=YlvwB1jrZi605gi3niB67Bi90wUDMc2WViKkk2TGGgI=;
        b=hAT3M5vuIyiiw0B0e7CkTGb5JmkrVv4cXDdiAFhJewJ9NBpfkThYsCs2wZ1MAL+ptA
         /tu9feUNkMgcfzy1nhWYwM11hdB7Db3xfEQMGEiJGNgCFF+cW2Dn0QE/TmWKZIZhxYCy
         3ONflL7F1nhzv0leiVNm9NDx4+W0xwY9Qiro5Pp4qWkHuTibHqPJGLlPImOIBRih+8Lz
         kZz/1BWq7ZXPJfRHTxVvJk9LPYGnaC4+YEsqs+0JV2Wl1GTmyEQ7Bf4wt0coh/hsC7nc
         8WZXl9vA9we2LIu3oB1dS7o6kvyULaXrCiNKFinRr1omfEyM4N4xXm4tYefQnjjVz4cj
         SA8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377006; x=1788981806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VMrDJBaa66KuFv0csy6O3qvERz8n2AoF6opzPYnVMGQ=;
        b=a2pfLKQWqvL2nW0kqxOsFUwGkAkMMDr4mNbDEdR7Cn4dbrdXF7RmgHLGX5lAWUMMmJ
         /mmLi2NJJgkE+BVmOoRfvZWfd3wX+DLyTFmVol/zgNshApWU2hef/QFxQOPwCMoyORhA
         Ia2f9DGw8ezHrtsVv9oXsngEmypnPBEcmnFMUCQ8Lyb9oIU9EL/WLglWqE9UHE9QXzZ2
         rRW8vmHsc4M660f6rnTq3eTZfHEsSREWPQdCyWZH7sPlMwHVjg+NiDwxU8jgCwiHwaC7
         f+7kxlmqQMP5hKCMPDURkvFYCvlQrwEn/rWAq8yqLFnHRii4IVthdiK/SkBAqt58usXa
         a+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377006; x=1788981806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMrDJBaa66KuFv0csy6O3qvERz8n2AoF6opzPYnVMGQ=;
        b=Br06Knpm86PeVZoYuMdW5i8EER1m85OQhoB1jKZcRF6fC4mOHJ9e6iK4EZdrcLvz3o
         TvpbxdK/9SA+lfLhWaiji8pi5U8FHh410tLzSLcmBZWff9ovvD09Q8D0osH3LmNFSBdc
         jv5urdXRb1MC9QGYo30R3kdMGxxKrSRCjkgFyP5YLESaHmBZLgjQyzn1jgrGRmdvadKA
         eiem88Obs/dwLbLz5ObGISOZkVFH3Alsc+719wjurUrl4w9Ood36cd/z8HESqlscN5Ii
         wpvrsd+P3plg3UwpQhuUDNPyBqs8jRVHI7bt/ZYUKhsVXvT+rDA/rDTp0ZwgX2t90niH
         8JfQ==
X-Gm-Message-State: AFuF++m+UZB/x6r5aiPcW3fXK1KS6F7j4Qy7+TpY3jNZcKjGemjL+lUC
	SSx3vtHfMte7ydq8bEs6ii6MHEPhhi1Jb5txHcXovf1j+GSG5xcll/gSSX+Ur3++Sq42D418PtB
	2nAYX3E0GjTYXeUB8yqwx6wyGEGAMctk=
X-Gm-Gg: AYBFou3Mf0H/oAYM5DAgbQ/X59VpP9L2/6zcWQh3DQDGG5iWWTEAQ+qL8rzggWdSRWi
	F9DLlFTDIQTAXtk57rRaWyVndvI2hL165QMDhUEeRu4h+rskeJdSb9AizXSJ9bQhlu8YO6DGLiH
	thwTwYYcieZftlvMqOEB4Sxf+jeG9VWI3H8fcOYYMrNKKzC2IH/nB3vkU2CiD3Vw5+ieMlhow/X
	1KuNSA4Oe7/9RumQJ+/bYAQxWwI80S+9sj9yvTnnwogDmwxpgDwAR9PhYV6/Ge92nitJReTgwZA
	1OXpk/A5mPMPk5mFKGGJA6/Xv1CVS+5pzWlXOO5Z8mJPWhTpUoYCXD+UvgM9LApjeZiS9ZvnY9X
	i4WhIl4pXGuV1lxsWFoY02FkNcbCL3oz2KKz/ARK0hBqG2OStweo/kSwDWuXXtzLBHXe9oeYkQi
	Rz5vROjnrdubUsaOX1dRDPgmHGUhubKgZVboSpnHY=
X-Received: by 2002:a17:90b:4b0f:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-39aee152d1cmr9761120a91.12.1788377005801; Wed, 02 Sep 2026
 12:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD33n1h587u5W+akp0MGHAgt5uMqpJVJ6HeZqTGDr2Ahig@mail.gmail.com>
 <CALnO6CB_MMDrq_R8USxqVrg7+dBQaTLR-mo0DhX4QktUyOOOPw@mail.gmail.com>
In-Reply-To: <CALnO6CB_MMDrq_R8USxqVrg7+dBQaTLR-mo0DhX4QktUyOOOPw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 2 Sep 2026 21:23:13 +0200
X-Gm-Features: AcwNN1XK49n7qkYIWfTWMdAv6GiKVFIm3I3VCfr8YxoSd291neK3DD7SzaDXCcg
Message-ID: <CAP8UFD0vvKV=FLFqh+_d7Rff6O0WNmiOWCESjHWf2o-tv39s3g@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 138
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jakub Narebski <jnareb@gmail.com>, Markus Jansen <mja@jansen-preisler.de>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Kristofer Karlsson <krka@spotify.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:46=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:

> FWIW, the following post discussing benchmarks around topics related
> to this series (I think?) and the release of v2.55.0 was shared in
> Discord:
>
> https://lnkd.in/p/eYGZb79T
>
> May be of interest.

Thanks for the link, it's indeed interesting.

The article is already quite long though, and in the "Reviews"
articles I prefer to focus on what happens on the mailing list, so I
will not add it to the article.
