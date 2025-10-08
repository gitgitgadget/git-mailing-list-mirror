Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547127E06C
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957210; cv=none; b=rqpyzKYzokpCkLG+bxKhyakPimHaBnpvphteAbOq+wZME4nNlV/RuOr8WzDzesbVu7/7/9pyT0wkscIwDhcgqOA6lFs9yl1BcnbKoMBtT+Ep9Fj5UOb5H+MXepY2r+z+WTTdSkip8oYSa7g26zI6VK0ZaGSIOZmR91THzRj7y40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957210; c=relaxed/simple;
	bh=o7F5MwcF4K3NCXlXUEBhUSgGZ3W2lUa2dG8oT8iOIug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U07McHW2IdqQZQTJraVJEEwlL1qhkg9nv3ItDohqV0nxgh1LFE9mfyak+8RUqcDyZ3ahDMMYCrFMuGnXAduYogPewXJhb7ZT5IQ9Ne8fs5cR+6Gu+Sts4vGA37uyyfsBr8L51eBWg7Vw+9S39oIHNHnX4eHSJMlA+AuzM4HMLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1z79GtP; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1z79GtP"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42f6e0bdcf7so2253205ab.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759957207; x=1760562007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=865Z/YKpxPQ0LIaNJ6lsBVTDfciFq0XYKTKlbdELZI0=;
        b=c1z79GtPXnophBxdygrqqWQjc7rYAWBVcnUtxPRXZgpZp2BzWKScGWpeGLufA5eZAx
         gG4j6s6E8KgH1xdW4FRcufj94MxTVp9xQHrwoPuun8NiTTvVEG5LNPeRNDQGHZR5Y/rD
         ynOAxrns7bHynwMTsudPQiszRP0sL8pGXrdiwonQyGbwJW+y36wlrxCXRJ3uHfmU2tcA
         T0/13cxDghe9PW/eKk2ZTvfv2m7sCS0wp9Ppmg6PJl0MTluOow8wtIF4bgnz1GlizDf6
         4BFgS/fWddWDhChtiH1oJ8xP6nRUNYZzyRv3U1LSJtgldx457JslCxiVTRAEiDUxPVCv
         26rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759957207; x=1760562007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=865Z/YKpxPQ0LIaNJ6lsBVTDfciFq0XYKTKlbdELZI0=;
        b=OFufgGVf+vAqIJHRnWaT8LlqMcsmj7ZGU8dsuBDmZKfUTJ1gRWmfgo2K3YTGNQrLnx
         wAO4Z3BHwoFy2kmDFtxRJQi8fX3kPGCvviJYBdGRR0m1H31qPmqjjRsO3Y/kGL5r/olL
         c1hJxlqwB2qMC4ndl4xwFtduhSB9Tb1NCI4NtKGf2eEkyXxQtNqYRvH7cztXjt/rLY9V
         8tVW0ICW6bMDLasBb4J3552Lom7WPeyF6KxVd/w9gExLc2VsdhJ1XQiELtAomKEkbEl5
         mF5GTCUT6YkRmMwZWjAAH1620KzJcvWXS28Led0htrIZWIymdgHhVlBjItft7R0ca5dT
         qEUg==
X-Forwarded-Encrypted: i=1; AJvYcCV9hZVsrbDDWGvgCXXUFUjUsCiS2LQNvIF2MBiVTKf8GcNY4dz4ao0nNb+lmHBDpaT69Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSWr5ZY5kjqTWYdJPAVFTjb4f+aHaqUsiXgGqhe8WZKB67nX2
	NF0WzKzPtglKBzaGnhXj1gQVgYctbZ/ycprXLwW0Z2If4sR2dJ3TBIdoEwTdpQOU9zJs8U87HcL
	XpGUNPjR3pAUlEwJpHQBVcZM3yfEj7tA=
X-Gm-Gg: ASbGncsLHZMu5BmQE4CVEh6/MwAMGHBAvai1vGlRUD+n+FSjM7K6TjgbkD4tS0O175M
	EAPxb4zec4g3BLwXfwB1TcFiCqmF6webJDJ0BrnLj6TbTKRvsr9eGL8I04As46xW6rcryNNeg7a
	qMDFZwlhsrTVbmn081Ku7nyecjC/uaXHXgrgCbqv5O7CLT/7SVgBUX8kxVp9tYICGf2djWealOA
	9EgT7R8g/uT0QeZqtosloG2DlSaZ8irY1Um040FwB7a4lcQr95KRCgZdM2Ux8zR
X-Google-Smtp-Source: AGHT+IHzeC7FrVfJPb4S8q5MIbsfpRgG+x4nXpyEsXwdPJAfERvUv2fHl3jJPQQiOIi77cATA6FGon9hwJQusRJ1JsM=
X-Received: by 2002:a05:6e02:380e:b0:424:80f2:2a3 with SMTP id
 e9e14a558f8ab-42f87346febmr46308305ab.6.1759957207336; Wed, 08 Oct 2025
 14:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com> <9d310bd5-453f-43a4-b477-ba02baa7a664@gmail.com>
 <d9764c7b-8de2-4b54-8c44-a4bd7f5860e8@gmail.com> <1bfffc20-7e25-4633-a0b8-6660913a74dd@gmail.com>
In-Reply-To: <1bfffc20-7e25-4633-a0b8-6660913a74dd@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 8 Oct 2025 13:59:55 -0700
X-Gm-Features: AS18NWDHlqaNGI2DnslbgBf9V3ix9BhzPWBZ10UbmfK9Mas1O-9wfpWswgNj7yw
Message-ID: <CABPp-BHyKM9hVvTiPx=n9HzO7Mf9oHrJvWcvVi+HxxMXWqMekA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, gitster@pobox.com, 
	christian.couder@gmail.com, ps@pks.im, code@khaugsbakk.name, 
	rybak.a.v@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	toon@iotcl.com, johncai86@gmail.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 1:09=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> On 08/10/25 19:31, Phillip Wood wrote:
> > Hi Siddharth
> >
> > On 02/10/2025 23:20, Siddharth Asthana wrote:
> >> On 30/09/25 15:35, Phillip Wood wrote:
> >>> On 27/09/2025 00:08, Siddharth Asthana wrote:
> >>>> The git replay command currently outputs update commands that must b=
e
> >>>> piped to git update-ref --stdin to actually update references:
> >>
> >> The actual advantages of the new default aren't about atomicity (that
> >> already exists), but rather:
> >> - Eliminating the pipeline for the common case
> >> - Better ergonomics for users who just want refs updated
> >> - Simpler server-side automation
> >>
> >> I will rewrite the commit message to accurately reflect this. Elijah
> >> provided a good suggested structure that captures the real trade-offs
> >> without false claims.
> >
> > That's great. I agree that having replay update the refs itself is a
> > useful improvement.
> >
> >>>> +--allow-partial::
> >>>> +    Allow some ref updates to succeed even if others fail. By
> >>>> default,
> >>>> +    ref updates are atomic (all succeed or all fail). With this
> >>>> option,
> >>>> +    failed updates are reported as warnings rather than causing
> >>>> the entire
> >>>> +    command to fail. The command exits with code 0 only if all
> >>>> updates
> >>>> +    succeed; any failures result in exit code 1. Cannot be used wit=
h
> >>>> +    `--output-commands`.
> >>>
> >>> Rather than having two incompatible options perhaps we could have a
> >>> single "--update-refs=3D(yes|print|allow-partial-updates)" argument. =
I
> >>> think the name "--allow-partial" is rather ambiguous as it does not
> >>> say what it is allowing to be partial.
> >>
> >> After thinking about this and Elijah's feedback, I am leaning toward
> >> dropping --allow-partial entirely since I don't have a concrete use ca=
se
> >> for it. That simplifies things to just: default atomic updates vs
> >> --output-commands for the traditional pipeline.
> >>
> >> Would you still prefer a --update-refs=3D<mode> style, or is the simpl=
er
> >> --output-commands flag sufficient given that --allow-partial is going
> >> away?
> >
> > The advantage of --update-refs=3D<mode> is that it allows for future
> > extensions such as adding support for partial in a way that does not
> > add conflicting options.
>
>
> That's a good point about extensibility. Elijah suggested
> --[no-]update-refs
> which is simpler but less extensible.
>
> Between:
> - --[no-]update-refs (simple, covers current needs)
> - --update-refs=3D<mode> (extensible for future modes)
>
> I am inclined toward the simpler --[no-]update-refs for now since we don'=
t
> have concrete plans for other modes. But if you think the extensibility i=
s
> important, I can go with the =3D<mode> style. What do you think?

I like Phillip's suggestion more than my own.
