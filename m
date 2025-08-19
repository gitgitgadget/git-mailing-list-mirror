Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970AE4A35
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570165; cv=none; b=eIOVAP9jZpn2pvjGYg07VqSCTYt9sZPb47IscXUz6dTN/Tys7zPmlx91BYXgda+25DfqGdNy8/C/pQPMB/iZQ4hKknzdXDav07R0BgpKKa/MPV6csbvf/uDjudzxcFLDClu+FFQYsi/yJsNSfnR33i635ahGnuU/dRDYrU6ND6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570165; c=relaxed/simple;
	bh=Eks7k2DdsBO8kLcJe78b1IlVreDlcRr0qIqrM5BCWQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LX1AdAqG3WwSJPY5uGQYC6h4w4XeBqgZ4xKNQ1pLRA3mIk5GkFnZ5isc4J4JvPsbvCc0CT+BuhXJ9weozPbp22Ajviguwws/CixnB3zATv6+gJLw5kVxg3tOdnfAGdLfOcqvFVIw6KJEUk9+kESQDSyKbRB+L9g5Jh2I8WHGMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1aW0YVY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1aW0YVY"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-333f8d1ecffso36692891fa.0
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 19:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755570162; x=1756174962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r8b2dXtOB51Zu6uoioGPMPkg9Kjx3FL/kYw6FqCj5E=;
        b=E1aW0YVYCz/I8r5xC8FvDrQZHPQaU6UmBIeik9WPR+n7vprYN+hD4QRUwJkDFKAs4F
         lpui2TS61JObSQkDgvF8+iienfDR89MRjDA/UVUqVeoNKxRNJOXjrHQLQGBYHw3QzV6m
         37SlsbHDF9iKekSZ9dnvmL/ejv+spuz7DGSXUldgw8A8f1+50+b5PQFT+M+FtOpOmmhr
         Vc0CxMODAm0Gxmx20ue++HGnqqNyKRm5wdjLEgPuRiPPMOhOYhrIrbX9bwYc17Q0h/ZO
         9h/EcM49DbG/kHoMqy80aY67acPYdz37aizShMq+pRQJPQuRhqOoSAONQVHVKEY1wsU1
         IWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755570162; x=1756174962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r8b2dXtOB51Zu6uoioGPMPkg9Kjx3FL/kYw6FqCj5E=;
        b=h52rEsYPbDVeB6VDUuNgsKFnlnXVFnKM2pu89Um7kZ01qGrDDbEvpaUswniEzCsI/D
         rfwMjnrQEqVwC9yLeeJGVZJdjcpbUVFFyw0ShWnKl0UEmoxtHeY20JlrYHve1usrUi+5
         vKiaEHI4/VryUNSFSsFIlG4vfz/zXdjg2gtw+85dDtVXD4vcDwYlItN+0TyrUjosNS3S
         xuIIaPYk3G7rCMauX5rKg0uO9edrr/3jEDsGRdY0iV7ANtHTv1Nf2l1buH73w2cqL/Cm
         l2ops06c1FQryUAVOxaTXXmsQUPgK2N3xxdHNTCIgl9VJFnHi432Np/gXGtkORlJAfQw
         cnhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF/E7FGnDAnB3T8Bp4ILYzkq2GBCpx0i76pPXVxjBkVNxyTet3Ti6OXTLHsZbPA3s/C/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5x6fPsE+8WXQ/SLLVAdBXEIo/hzKcNmlYHrY3gsWWARlHatb/
	ij+yzJN9izRLfcOEc2yFKoMsvqD5KZ04hCjzB5LLRZSduGrhq6fn1/LC5wfaCffZyAJd6jLe92H
	GbV96VUG69nt5715x78VzS1TaiqHKHU0=
X-Gm-Gg: ASbGncvui5dftE/D4H3sOIS+gDsXhaN9VDxUZvAWjzKo1lwxw01QCLodtQLHh3UvgQi
	+3qJZbE+uwdGIwvXXzx7bXciMI2ZRa9tk28hHwv5EQreS5ZvHZwLsr97pEpqh+31kpp8qjWtwgl
	cVv91pNLJqXskOk4b7Fu9bQviyZFRGei4PwfFgUiUc4HN0HArnFfBPde2BOSvH/T6P15uYjOt6G
	hXSPHes
X-Google-Smtp-Source: AGHT+IHxqaqX4/NSdOEGLOifFYXEaVtFgBXfGEuF2JwBz/b3GC42f0zh/5UF6Zt2K7BLjV+GmrDg5Sk4MTQAS6+XZkI=
X-Received: by 2002:a05:651c:198d:b0:333:f936:da4 with SMTP id
 38308e7fff4ca-335304ee169mr2192391fa.10.1755570161405; Mon, 18 Aug 2025
 19:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com>
 <DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
In-Reply-To: <DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 18 Aug 2025 20:22:30 -0600
X-Gm-Features: Ac12FXwbmslmtI5HVzGdS2CvM6IlFBUlw_nYKTJ6Uuk2ls12e2Dz7zZTgFZexAY
Message-ID: <CAH=ZcbDc+Hi28Cu2roE1gezwPWbarxBj6JOjTb2ytnrYS72uTQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] Do support Windows again after requiring Rust
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 11:13=E2=80=AFAM Matthias A=C3=9Fhauer <mha1993@liv=
e.de> wrote:
> > diff --git a/ci/install-rust.sh b/ci/install-rust.sh
> > index 141ceddb17cf..c22baa629ceb 100644
> > --- a/ci/install-rust.sh
> > +++ b/ci/install-rust.sh
> > @@ -28,6 +28,9 @@ if [ "$BITNESS" =3D "32" ]; then
> >   $CARGO_HOME/bin/rustup default --force-non-host $RUST_VERSION || exit=
 $?
> > else
> >   $CARGO_HOME/bin/rustup default $RUST_VERSION || exit $?
> > +  if [ "$CI_OS_NAME" =3D "windows" ]; then
> > +    $CARGO_HOME/bin/rustup target add x86_64-pc-windows-gnu || exit $?
> > +  fi
> > fi
> >
> > . $CARGO_HOME/env
> > diff --git a/config.mak.uname b/config.mak.uname
> > index 3e26bb074a4b..a22703284b56 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -727,19 +727,26 @@ ifeq ($(uname_S),MINGW)
> >               prefix =3D /mingw32
> >               HOST_CPU =3D i686
> >               BASIC_LDFLAGS +=3D -Wl,--pic-executable,-e,_mainCRTStartu=
p
> > +             CARGO_BUILD_TARGET =3D i686-pc-windows-gnu
> >         endif
> >         ifeq (MINGW64,$(MSYSTEM))
> >               prefix =3D /mingw64
> >               HOST_CPU =3D x86_64
> >               BASIC_LDFLAGS +=3D -Wl,--pic-executable,-e,mainCRTStartup
> > +             CARGO_BUILD_TARGET =3D x86_64-pc-windows-gnu
>
> I've said it when Johannes originally sent this patch[1], but it bears
> repeating: The *-pc-windows-gnu targets will pass CI, but would mean
> raising the required Windows version from 8.1 to 10. We'd want to use
> the *-win7-windows-gnu targets[2] to keep Windows 8.1 supported.
>
> [1]
> https://lore.kernel.org/git/pull.1980.git.git.1752784344.gitgitgadget@gma=
il.com/T/#ma10be2ed0a0e776b0af2fdd0de63d51ba51609e4
> [2]
> https://doc.rust-lang.org/nightly/rustc/platform-support/win7-windows-gnu=
.html
>
> >         else ifeq (CLANGARM64,$(MSYSTEM))
> >               prefix =3D /clangarm64
> >               HOST_CPU =3D aarch64
> >               BASIC_LDFLAGS +=3D -Wl,--pic-executable,-e,mainCRTStartup
> > +             CARGO_BUILD_TARGET =3D aarch64-pc-windows-gnu
>
> As I've also mentioned before [1], this target doesn't seem to exist. The
> correct target seems to be aarch64-pc-windows-gnullvm. [3]
>
> [3] https://doc.rust-lang.org/rustc/platform-support/windows-gnullvm.html

I'll be happy to make that change for the next round.
