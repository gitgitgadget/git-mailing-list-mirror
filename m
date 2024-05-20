Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDFDDDA
	for <git@vger.kernel.org>; Mon, 20 May 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224835; cv=none; b=A1ADpB3KQsuj86JVgdYnher0I3rlHEwoyMUeuxlN7yJAzCBCh8eNOi5XvR3f4m796IxoGNp51MI84MrpEocN/tU4jFcl4x+CJ4LPLb0V6SO99EOx1hF3td0tE/qXrnoQ9cRyQ7Z63P+qmlKiPdqgyv0mFLlzoIv1rlKaNuI0tUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224835; c=relaxed/simple;
	bh=WR0C/yu3L3cULKu31i0KUQpIlbM0ZDLhgXKIi3A3KN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f25h0c4Soj8EyFQCynKSzDMaH50Bh4BcWfu04aOOcfHUWK5VHcUbmHFBeGWqikVe6ueZeutZFvg1sLT8eVUHRdQ0CyE24YgZU32iBxdeyehJEFfy7Zrvjws5gwYrcPJmy2nDBuvUjs4lA66oY0bWzajxjt08YW6jcKPQ/72cRxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b782287f9so9685106d6.0
        for <git@vger.kernel.org>; Mon, 20 May 2024 10:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716224833; x=1716829633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVaO6yT9fPpgLEFbROAxE0ybriGBoA4wDc0fzcPoVhs=;
        b=WOQcUXLtPxv9Xr49LO4KmgOVounvld/gQerA+tgCo0NRkrlLUAWJsLRg/aP2UPu0/w
         n4jkEko/XT5FyN9Ho3TgoE3DgHKBWEEKiHNbS4W4fk2BNYICRVK8x0Xqlr0Clcn5YER7
         Bt44Si5pKdMRxX8+0CVmbXn3zWPy4HhrNawee+0456zQ8FNu3Oa00MkWYpuVl5gbrvuw
         Y4rjVmxgHCZbuH76VUulBQVuXxs5OVxKfYUQY7XNGkMtdSsoRq6xg6Y+nWyiiNOPqGXS
         vX9kaIsUZz2wwhEC2C15N364oXoJXOQTHwJSksN1MnRoYk5yijCWjdB2nxvUhC/IVxRf
         /P0g==
X-Forwarded-Encrypted: i=1; AJvYcCXQIqHhGoiBLzi7BFWJVrAGKsAST9dkEjPGBbjhlGQt2pGYEEiBmSFuBtlkphrvfEEQuYKGuTK8zLvqQ5v5ZnM97VCH
X-Gm-Message-State: AOJu0YyAzbktqIv0cHvC+hZizHv7ydPKhsPz5K3M7V0X68Z4fBgQte1n
	fmkMN9a1vpdvq/u77khWfXrB/bOZAtIZWDB89wonas0Cty2ivARjnlIjKYlEzvpopag0TXCP0aM
	H51/mYDwKWiLD6dxQ2T9J3gWH86w=
X-Google-Smtp-Source: AGHT+IEwsdZRZBnTLjQLKgHy9Mptlube5ARbuCr2Wp+INz5DPhjtyX34AWN0+vtrOqr11rn+vNSjJTCPiezzu6akhkI=
X-Received: by 2002:a05:6214:5b84:b0:6a9:ecd9:7123 with SMTP id
 6a1803df08f44-6a9ece8b5b0mr50912836d6.44.1716224832611; Mon, 20 May 2024
 10:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <xmqqseyclaq8.fsf@gitster.g> <CAPig+cQsc4AUJ7-0v=rS8VVK9JG1+_iSwa_gWUUigs=uwYq6Lw@mail.gmail.com>
In-Reply-To: <CAPig+cQsc4AUJ7-0v=rS8VVK9JG1+_iSwa_gWUUigs=uwYq6Lw@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 20 May 2024 13:07:01 -0400
Message-ID: <CAPig+cSGjE69N0TpB4ub7vY5fXHpDJ6j4-xet8G1zcgRo4OHHA@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: Extend regexp pattern for /proc/cpuinfo on
 Linux SPARC
To: Junio C Hamano <gitster@pobox.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, git@vger.kernel.org, 
	Sam James <sam@gentoo.org>, Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 12:50=E2=80=AFPM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> On Mon, May 20, 2024 at 12:16=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >         # Windows
> >         return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROC=
ESSORS});
> >         # Linux / MSYS2 / Cygwin / WSL
> > -       do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^proces=
sor[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
> > +       do {
> > +               local @ARGV=3D'/proc/cpuinfo';
> > +               my @num =3D grep(/^processor[\s\d]*:|^CPU[\d]*:/, <>);
> > +# print STDERR "FOUND <@num>\n";
> > +               return 1 if (!@num);
> > +               return scalar(@num);
> > +       } if -r '/proc/cpuinfo';
> >         # macOS & BSD
> >         return qx/sysctl -n hw.ncpu/ if $^O =3D~ /(?:^darwin$|bsd)/;
> >         return 1;
>
> I had a more all-inclusive change in mind. These number-of-cpu checks
> are in order from least to most costly but they are not necessarily
> mutually exclusive. As such, my thinking was that the logic would fall
> through to the next check if the preceding check produced zero or
> nonsense.

Hmph. Looking at this more closely, I guess I did make these more
mutually-exclusive than I had thought, so falling through to the next
check probably doesn't buy us much. In any case, for robustness, I
still think that each check needs to have a sensible fallback. An
alternative would be for the caller of ncores() to fallback to 1 if
ncores() returns 0 (or nonsense).
