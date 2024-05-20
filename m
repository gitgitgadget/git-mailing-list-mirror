Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5151137749
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223827; cv=none; b=aEr0LF9lN1mLJFZdnGyNaNMq1qYPt5CS5CfMEzC+Liip4FbbtV4t2/TiXFO1rHxOVxaiHaL4UC2OYc1i5+JMHjcpcLXblRy/3dPWUpahAEdIKmBj90+5MdwQI18piXlkxPiB5GpOKjuRsDma0Mfoo2MlxBZEZ6Nr9dV0HjjH6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223827; c=relaxed/simple;
	bh=J2NXmRyWZaJsQIQsUET+hYgVvRWjfk8InUMSIVT3e3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnxMv5A+fvWJKGbM+LihI4/ZQX5NkOd/ZqsyoKFzHB41FMxfSSxz7J+mBL1ug5hTdzu7+aQo1GYrnSZXyvll+8agyFHclMYhqHBDMqxA++C8sSm01AcZkWyDZjEIfDeTYelIEXETfxXfHurmRCpgQ9NI7oi2DN0qR3ORR/fJ1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792c7704e09so261146985a.1
        for <git@vger.kernel.org>; Mon, 20 May 2024 09:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716223824; x=1716828624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TME9i5bKSuJDg2/O9R3V6e4pwBDzg3rdKN6F89Ruzik=;
        b=JUybwV2P+Ra233qcmQ+07n2T9ZMcKr+bY/qjqvXg1nKDFpKY8IPEQZ9+t11y/IsbOA
         RH4wLnv7ITElEwhMTaFt75xHn5R9AuaDsXPkWWdjeRyyFUzR4MnBfjyIcRFDVdfBMqsL
         AmqSxw5nYeqEtzu+V+LfwjcO5I+5OQsCmWBx4djOgONWggpbkrCUmjYEX5iNtNwhglbV
         PMogu6ZjT2SU8XQEsFgSI8Fxc22E1cs4t7NT161lgPKQlOMtzc0QVa0vsa3VUhTMNmw9
         OVLBtWXAXQOYVb4J3ieuedJJhOwP29yPe3Xcfysn9K+vC652+5l22KucY+F8YAXkIi7W
         a0TA==
X-Forwarded-Encrypted: i=1; AJvYcCV2MXIbizfSGgGANvX0kW5U/xVvwqXBlHbZ+r4/S8W0pldn01vMLZzT2AuTm/PcWeQSDtjSHaMs8x0AsdXbEafr4p7H
X-Gm-Message-State: AOJu0YyJGfAsK3H+rlqsvxpYfcYzC5UM0gCUpNRfvl5XDEcEulIB3FHC
	mK5iXrPEVeW8JBLGtWXoBMvCwH06VfQcL9KC+h2aGDl4oHQSaeNNFWZTZw+3W8bQY3EWSXpmrjb
	sch1Hu0ofg7RoK8Vvle/uVEiLTx4=
X-Google-Smtp-Source: AGHT+IHUi654EdRrtLbgNbegMnNu3h2DSYlDU9jBROqklk5uxiwNQ99vthysApZb9Wyqi8ZEz4t/iJyoKPw3wPtITbA=
X-Received: by 2002:a05:6214:4a88:b0:6a9:19a4:b901 with SMTP id
 6a1803df08f44-6a919a4bbe3mr108240136d6.12.1716223824528; Mon, 20 May 2024
 09:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de> <xmqqseyclaq8.fsf@gitster.g>
In-Reply-To: <xmqqseyclaq8.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 20 May 2024 12:50:12 -0400
Message-ID: <CAPig+cQsc4AUJ7-0v=rS8VVK9JG1+_iSwa_gWUUigs=uwYq6Lw@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: Extend regexp pattern for /proc/cpuinfo on
 Linux SPARC
To: Junio C Hamano <gitster@pobox.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, git@vger.kernel.org, 
	Sam James <sam@gentoo.org>, Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 12:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:
> > On SPARC systems running Linux, individual processors are denoted with
> > "CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:" so that
> > the current regexp in ncores() returns 0. Extend the regexp to match
> > lines with "CPUnn:" as well to properly detect the number of available
> > cores on these systems.
> >
> > Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > ---
> > diff --git a/t/chainlint.pl b/t/chainlint.pl
> > @@ -718,7 +718,7 @@ sub ncores {
> >       # Windows
> >       return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCES=
SORS});
> >       # Linux / MSYS2 / Cygwin / WSL
> > -     do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processo=
r[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
> > +     do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processo=
r[\s\d]*:||^CPU[\d]*:/, <>)); } if -r '/proc/cpuinfo';
>
> Is the doubled || intended?  Doesn't it introduce an empty pattern
> that slurps every single line of /proc/cpuinfo?

I was also wondering about `||`; it looks like a typo.

More importantly, though, we can simplify the pattern to:

    /^(processor|CPU)[\s\d]*:/

which is much easier to comprehend and gives correct results from the
SPARC /proc/cpuinfo output.

> I was wondering if we want to first add the "reasonable fallback"
> Eric mentioned ealier, and then build on top, whose result may look
> like the attached.

I'm fine with a well-focused patch which just fixes the reported
problem; the "reasonable fallback" change can be layered atop at any
time. But, of course, if Adrian wants to tackle it as part of this
series, I would not object.

> diff --git i/t/chainlint.pl w/t/chainlint.pl
> @@ -718,7 +718,13 @@ sub ncores {
>         # Windows
>         return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCES=
SORS});
>         # Linux / MSYS2 / Cygwin / WSL
> -       do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processo=
r[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
> +       do {
> +               local @ARGV=3D'/proc/cpuinfo';
> +               my @num =3D grep(/^processor[\s\d]*:|^CPU[\d]*:/, <>);
> +# print STDERR "FOUND <@num>\n";
> +               return 1 if (!@num);
> +               return scalar(@num);
> +       } if -r '/proc/cpuinfo';
>         # macOS & BSD
>         return qx/sysctl -n hw.ncpu/ if $^O =3D~ /(?:^darwin$|bsd)/;
>         return 1;

I had a more all-inclusive change in mind. These number-of-cpu checks
are in order from least to most costly but they are not necessarily
mutually exclusive. As such, my thinking was that the logic would fall
through to the next check if the preceding check produced zero or
nonsense.
