Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841A2561AB
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714970; cv=none; b=TOYo56kMChpncFKExzMuMeFM2t5kyhlznHEMOubTLmHSgYdhM5Vt9Pld24uvdu+k7ha7k2RP7PBNTV95jqpRYOU+osi5Knf+Cymej9rgXXWIeAjym6xjMhRzWnPtIQPB7wmGBEN6xlzjZkv69LZrKEL/u6KsNErfboI71erHe3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714970; c=relaxed/simple;
	bh=r6uZre3z99OtwrdqxZnanU9xxWT1il6q1x/zgLCuLEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSZn6uNQvOefpnRosMKdam0IcazacYE/e6RNOfsxkAnMbh6Gg3ANAC9KCu8nrbuk6SdQ4kqvykALHlFfCsQV5hxXyLXCxfsqqA63ICfmKSVEdJvSMthPxzwD7XvxmKd8rZ7+6msHYAI/VeIBdWgyYmhGOaHDBt1dx8WaOoiM+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gur9AfED; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gur9AfED"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b713c7096f9so286461666b.3
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 00:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763714966; x=1764319766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpVvGSCYQ1WyTRWdHHyFLYCX1a32brgBS95cByAIu0o=;
        b=Gur9AfEDiacMoRUftNdmHajL+BM88r7/yiI8MG1fkhy1NgD0wwjKgVjGEzfATrAC+n
         Te3BO8reYZ3PkOXML9rSbpqD+D9CeI+gR2Z+EjYW3IdKHQ8Jl/0zZVWRwyr45S8tBuRZ
         c7mG81Fqx0Wy7cUa/P4i0ALkDwz4ojD7O/oAaqtMt5GgKyd5x+43008AEMbMjWbvrdB5
         xWMzKY7MF2tEn+XtN82DtRwb38JCeFl2L+gq2udiNKg4T+VJTCj4Mv8QdHuprW7g3dt+
         h1Dtazuc2gOVMHzXxwXLnX/krMApqycHJfBmPZKeVqm22SFUuBchMz233Lw63bznut7a
         fwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763714966; x=1764319766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpVvGSCYQ1WyTRWdHHyFLYCX1a32brgBS95cByAIu0o=;
        b=OUxleutFNaXoq6M0x4Ufu76vTJnnJ2unfyCiSgHy8mNnFR9O219tp8xkhKgSep1YnX
         ffiCGo5LGv7GbK28UnGxv5DyTBsLd6Yz4Cnn3Vee6HNUZ+qHZ9jV2Zh729iKT/D/siNk
         3+RBCiiXWv1YGCZJQTV4JZtelH5rlqnYKRNlLsxCzV3BMjRzaKInN1wcRnCfKH9/+4xw
         gGm7RnaRmKCtXZkYO+i/ngeqZvOd39HBM/j6G0d+w6BgfWKIp+GDKeM5QVF3XlZcKoga
         ov4jvv9tWLjqhug/tUILc7KLFq/to6dsjEYQlSDYHQSVHUDTcV9DvQKFm8tPPD4GTdQj
         Rwpg==
X-Gm-Message-State: AOJu0YxGo2edZ/ReA3xVU8UkfRKc67wDDILYxkADNVWrHUuhLhnE4AIq
	P9JlUqIM76RC3jjk/zBI8VnyXm7HpZJJXclLC/jj/OWdbT/ycywbCaeIESyKpadTXJI=
X-Gm-Gg: ASbGncs7YuuBXBkzOeMQfbqpOHNSNfAs6dM7CAfWhUKa9YIdl2IvgrXDNVULqojn71s
	XWg0C1IJ7tWizkCoBWjAm7ltqkiiIl4lcIc3qxFv1L9jiBPw6nl+kyojl4xsCDX7fAjemV3wNYT
	sa0McDPUgeo9ekt0fq2dHHxkV8UYo40+0LIVxJ4QQShcibDuU/iBn96KB2EdCBog6jcW83wMZfd
	JpAlYVmmymyDaayYQBKZ2/tGJI9+AkN/G8wxB19rAkdnL8AiuU+JdYIYnrNUShMeG+QuXK02Wpp
	UlcrFcgpVWz3vbnX6wN/Dv3ULwKStXD6F4HZaZoTILuv4ZiD9v5VPfmTo0Skr5r/pxs7AwRyewf
	VM/F5XxQkVJNZP5VPeXgUJScgykQaYE5wwNkFbsJBWIP0f0b/H9bAMps/P8kinJKYl9RN9e/jrC
	3AxedYEVuD6SjWw0JExj2owb6NkZHz6uctdzOWt/lMQXw+Mzh27mljHPjYD/QkI+jmcqe1I0zcD
	GM=
X-Google-Smtp-Source: AGHT+IGOdsn20Wmz3Qgee4ipN3ADM/Ur61iga1HzGORUeI0uKtCR3n+fR4K36bXlb4OdxjdYjWtyZQ==
X-Received: by 2002:a17:906:fe4e:b0:b73:4fd4:814f with SMTP id a640c23a62f3a-b76715ac4afmr137492166b.21.1763714965683;
        Fri, 21 Nov 2025 00:49:25 -0800 (PST)
Received: from localhost (p200300f65f026708fb6c1faf4b8beb83.dip0.t-ipconnect.de. [2003:f6:5f02:6708:fb6c:1faf:4b8b:eb83])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7654cefeadsm412371266b.6.2025.11.21.00.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:49:25 -0800 (PST)
Date: Fri, 21 Nov 2025 09:49:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: `git submodule update --single-branch` tracks HEAD instead of
 branch from .gitmodules
Message-ID: <llfngawozm26eo3x42ndon55qenrzeto2tgl7djr2weho43gt5@sjcdk2ppafqc>
References: <xmkf25oq2vka2kipfqfybngkqffbljqygmtrtiujgsrao7g2wq@k56wxix4oism>
 <CALnO6CBdc=5KpUwweMzxpT+9CBXZVP4AG4bFS9sGucJJVmzjtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yikgmfbbs4zyofy5"
Content-Disposition: inline
In-Reply-To: <CALnO6CBdc=5KpUwweMzxpT+9CBXZVP4AG4bFS9sGucJJVmzjtQ@mail.gmail.com>


--yikgmfbbs4zyofy5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: `git submodule update --single-branch` tracks HEAD instead of
 branch from .gitmodules
MIME-Version: 1.0

Hello,

On Thu, Nov 20, 2025 at 11:05:00AM -0500, D. Ben Knoble wrote:
> On Mon, Nov 17, 2025 at 4:28=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > for a project I'm using several submodules, showing my issue with just
> > one of them
> >
> >         $ git ls-tree @:layers | grep poky
> >         160000 commit b33a8abe77081a2bdda0d89c61736473b2f9bb8b  poky
> >
> >         $ cat .gitmodules
> >         ...
> >         [submodule "yocto_poky"]
> >                 path =3D layers/poky
> >                 url =3D https://git.yoctoproject.org/git/poky
> >                 branch =3D scarthgap
> >
> >         $ git submodule update --init --checkout --recursive --single-b=
ranch
> >         ...
> >         Cloning into '/home/uwe/work/sri/poet-server/layers/poky'...
> >         remote: Enumerating objects: 8775, done.
> >         remote: Counting objects: 100% (3119/3119), done.
> >         remote: Compressing objects: 100% (158/158), done.
> >         remote: Total 8775 (delta 2974), reused 2961 (delta 2961), pack=
-reused 5656 (from 1)
> >         Receiving objects: 100% (8775/8775), 3.24 MiB | 15.45 MiB/s, do=
ne.
> >         Resolving deltas: 100% (6158/6158), completed with 391 local ob=
jects.
> >         From https://git.yoctoproject.org/git/poky
> >          * branch                      b33a8abe77081a2bdda0d89c61736473=
b2f9bb8b -> FETCH_HEAD
> >
> > so far so good. But:
>=20
> Is it? You've only cloned the HEAD from the origin:

I don't. b33a8abe77081a2bdda0d89c61736473b2f9bb8b isn't included in the
remote's HEAD, only in the scarthgap branch.

>        --single-branch, --no-single-branch
>            This option is only valid for the update command. Clone only o=
ne
>            branch during update: HEAD or one specified by --branch.
>=20
> Perhaps you want to use --branch here, [...]

Well, the submodule is initialized from .gitmodules which has a
specification of the branch. And the init steps works fine despite
the submodule commit not being included in HEAD of the remote poky repo.
I interpret that as --branch being provided (somewhat) implicitly.

And yes I'm aware I wail about something that is documented. But the
documentation is silly in the same way as the code.

> [...] and _perhaps_ update --single-branch should default to
> submodule.<name>.branch ?

Yes please. `git submodule update --init` already does it right, just
the fetch line in .git/modules/yocto_poky/config is wrong.

Best regards
Uwe

--yikgmfbbs4zyofy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkgJ5EACgkQj4D7WH0S
/k4MHgf/UwC5eaoQHTRtD+OPTXaCOkmFc1u+cqLLFlcy7q6Hr1E2e2LvFGbEI+Vz
81fmi2eddyCIxgZtn67K+sHU9WuuBYDybkk7JynGeGiaYabbCGZgLXAu+PqphoOS
fkmsnDqr2WNo9L0KVjYdFX5gMbWcjD5Uz8H+bb5tsjtzfjGxiAReJPtpe1BB400d
+Ru0/tOA20vI+CILdPuHhz+lnZRTOqCBaVir5WlUcMDicl1tI1ctU2qArSCBgJVg
mkUoWML417Sd7/0TaJ7heAkSSc7N4UkYxWSegMqNzCl2xId3QyAhX5Ibr/QkqhMg
qkk2ENgmkDbMMZYWWcuaYtGqSr5Opw==
=OtgM
-----END PGP SIGNATURE-----

--yikgmfbbs4zyofy5--
