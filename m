Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BC2206BC
	for <git@vger.kernel.org>; Wed, 28 May 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463272; cv=none; b=cMTveWMSRTxUbGEz6nWw7b3IquCydnTA9u355PZH64CX73nr1XIZxKWJ8+hXJaGJM8D/jBnMIxNhRXp3DgaBdEx8vFzcEsf2ROxCC1S08dIvbfrZrp/U0u8l2L4M02QtEnycGr2Y+M5Z8OHjDKD6TJH3SX6BYhfSBUHWjJtFKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463272; c=relaxed/simple;
	bh=4NICWBA3G4MrL/S4hj9CJm1sK73vQg+FGW9A+O7RtBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th+LSlePUjCfHW+V9nunHtSeY+z10y44aEO5HT0GMDLIw0xAWwPdmlPbbX97NR+Lzi4YWtN4FUX6OZVTBqthmNnF6gC45Eyo8YkBG2jc8f0T+K4dwjs4VAX+LNs7ZBb69bCIQbru52t7eq2aqsRc6s/VIDjnP1jWM4mTof+tcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6faa4853959so368876d6.2
        for <git@vger.kernel.org>; Wed, 28 May 2025 13:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463268; x=1749068068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWvlQ3I+TgXgrr1FrBv/fyW0SIgofq63JOCHpcSdkmI=;
        b=FeCq4GJea9DOKlwM0e6lR0OQhAXskdur7DjJcrAGUL2v6SPMtlz66+YBv3gFCj15x4
         dd/oUBdum+9yQ+huabynGaEay+IEbrMiTPIGsOTGqGFw78I/YknqthS8Z8Veph4iKZk+
         IeDg2KNHNYDwlpb5uJd8hR9U5/1AgAaAaHPsfr+qLnsn2wuYd0GUGYL1plUUkjADxwF7
         uU925vgzcQJoyxDV9nhNoMyCZjUdGi1ApiXnx0D9gqawFcX95YbaI2RRzP3ALQVnC2W5
         ppfyNYS+Ox70p9uR48rDcaE5mqkwewBh06bD+punJwc4dRLzbf5T3hBLL+VubD6GOG5s
         UYAg==
X-Gm-Message-State: AOJu0YwE2AkgaPj3Lw19GmYVr+CJEllfrhv0YTun8aGdUuKb9y+W8wTh
	6yNZ5GyHQyyelQ+SfDyvbozv0G/DNAkN6CvpqhluoDJA6qzvcWd59acnA73eJB4dG3qDimKwbFV
	SMc9MQV+dBnhe3ATf2JKkA4V3+VryJeI=
X-Gm-Gg: ASbGnctWcaFNzG4MRS9ygSl6Gz7HlhoH2BqXw//NlCXEAFZ7qyP+csteEOnRcmBIKQL
	DdlepNMo3h/kE1ot2wN0VNqHOsLZRYhOGIRxJI9cD6uO/GWPJX/7BjVJvDDLKi3cBuKobw9w1MW
	fsszdobVZAoVe85dohWeUFOvCkcCCCYGCsvsuNq7VNQAo9xid40gndBqGBHQ3vpXXR
X-Google-Smtp-Source: AGHT+IETeu7Yil78/whhX5TqKjBUbWKw9WWJ+bqfe05IkmQD7gvIn9Qan64Qn5Sxh2DkfxxJowBw8esSWpmNqGPy7G4=
X-Received: by 2002:ad4:5be2:0:b0:6f2:c10b:db04 with SMTP id
 6a1803df08f44-6fabe48d296mr25010716d6.1.1748463268496; Wed, 28 May 2025
 13:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
 <20250527-pks-meson-tap-v2-1-ae360f77786e@pks.im> <CAPig+cSYhY+LQ5pD+a1O16Rxwo_js45WqfcW8wtC2daYmNyMCQ@mail.gmail.com>
 <aDcx4dXe12tRUyYd@pks.im>
In-Reply-To: <aDcx4dXe12tRUyYd@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 28 May 2025 16:14:17 -0400
X-Gm-Features: AX0GCFsGpuIMw5e3LA8JsNUrpZhLH-cn1e80Ukfai35hLkRfxR1Dj0K4fH_oPdo
Message-ID: <CAPig+cR+eham=uSamUFmTuWDhZ6_r3dnMm1z+X25aw2K6maN7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] t: fix cases where output breaks TAP format
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:55=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> On Tue, May 27, 2025 at 03:47:16PM -0400, Eric Sunshine wrote:
> > On Tue, May 27, 2025 at 10:03=E2=80=AFAM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > > diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodul=
e-option.sh
> > > @@ -48,7 +48,7 @@ commit_file () {
> > > -test_create_repo sm1 &&
> > > +test_create_repo sm1 >/dev/null &&
> > >  add_file . foo >/dev/null
> > >
> > >  head1=3D$(add_file sm1 foo1 foo2)
> >
> > Unlike the case with t1007, in which the entire script needs an
> > overhaul, it is much easier to fix the problems in this script without
> > papering over them via ">/dev/null". In particular, it would be
> > preferable to resolve the issue by wrapping test_expect_success around
> > the code which currently resides outside of any test. So, for example,
> > the above could become:
> >
> >     test_expect_success 'setup submodule 1' '
> >         test_create_repo sm1 &&
> >         add_file . foo &&
> >         head1=3D$(add_file sm1 foo1 foo2) &&
> >         fullhead1=3D$(cd sm1; git rev-parse --verify HEAD)
> >     '
>
> Yes, it isn't particularly hard. But it does result in a bunch of
> shuffling that makes the patch way harder to read.

I'm not sure why such a change would require shuffling code around (or
perhaps I misunderstand the idea you are trying to convey). Unlike
t1007 which needs a major overhaul, each block of code which currently
exists outside of test_expect_success in this script can simply be
wrapped in test_expect_success (with a distinct "setup whatever"
title) in situ without shuffling the code around. Yes, such changes
would be noisy, but it would be very localized noise in each case,
thus not particularly difficult to review.

As such, since such a fix is so simple (even if a bit noisy) I'd
rather see it done properly rather than merely papering over the
problem. However, I'm just one reviewer; others, including yourself,
may feel differently.

> > > diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-en=
coding.sh
> > > @@ -7,12 +7,17 @@ test_description=3D'Clone repositories with non ASC=
II paths'
> > > -ISO8859=3D"$(printf "$ISO8859_ESCAPED")" &&
> > > -echo content123 >"$ISO8859" &&
> > > -rm "$ISO8859" || {
> > > +test_lazy_prereq FS_ACCEPTS_ISO_8859_1 '
> > > +       ISO8859=3D"$(printf "$ISO8859_ESCAPED")" &&
> > > +       echo content123 >"$ISO8859" 2>/dev/null &&
> > > +       rm "$ISO8859"
> > > +'
> >
> > Was the problem here that the `echo content123 > "$..."` was
> > potentially spitting out an error message to stderr, thus you had to
> > redirect it to /dev/null to silence it?
>
> Ah, this redirect is not required anymore. I had it in a previous
> version due to the exact problem that you mentioned, that echo spit out
> an error.

Okay. I'm perfectly fine with you turning this into a lazy prereq --
it's cleaner, more modern, and possibly easier to understand as a
prereq -- so no problem there. I asked about it merely because I
didn't understand why it was included in this patch, and the commit
message didn't explain its presence. It would do very well as a
separate patch, either within this series or standalone.
