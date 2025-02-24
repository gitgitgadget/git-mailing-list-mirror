Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3825B699
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418309; cv=none; b=kQJeUj8cWLOKDjW9BnTB7+/Khp7/z6inAa2sjkS3VCWCxSlgKa7wt9aMnR8o157xgkku+hxRaozgAfd4/jJfct/4sUq1PfYpi2urrKkQilxWak8KV9lYlYXJZNKioP70sIjWDZnkI9/1ClclwGjEH17xQI1sCMHIV9vTd251Ktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418309; c=relaxed/simple;
	bh=+O5VjkD1o68vIZG6cTt8kEqv/u1Erw6XqZKHhc7pilg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIQJMvO3zHiRMNbbIpYaZ7tjQc+T51Yevg7lGZlHfZDbXsrqgrY6pp6Nz9Uee+hoLVIYWfQxhjyM84qMxc81cmzv+NLr2xmfqQAD76m+ElLiLkF7jl+VkOhs37wiMtZU4yeEu4I1Xzc54kZJtPPcL47SYhGyjdaWPeGZBfcZp0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=We3Fp4y/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We3Fp4y/"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb90c20baeso605778566b.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 09:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740418306; x=1741023106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJn+PlMubmRchwcX2IMJcqGbrqXt4T19vODiu+trCSA=;
        b=We3Fp4y/chUuTzI0bwxaNUAcC6hWlJZP6lTaMlpP2HM33hiabALfbx1M+iZASTVFg3
         yq05cE3mZ3VEJJilwsaPv7LluiaF1e41m78bwFhM45u3zdnUWdZmSzz2RRm1TwryBQxA
         QSD4rk7ncc1eQMoTeECultx0Tigd/uflgI57JUR8nD1iFzE4SBQlFIodENAAP8pheyBG
         xnssY+RdmjYeO6dCA1uq245HQXH7z/gsPrpSb+84MmBxxnv1+3wBWWQEVHntD3aewpZf
         CODQEKsmQjf4dDusMHZjg3LbZIsW7Twwdro5z32tUfuRuRji6eYyfazc4O6QKtKg6HEU
         kL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418306; x=1741023106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJn+PlMubmRchwcX2IMJcqGbrqXt4T19vODiu+trCSA=;
        b=ANXBifXCVUoxSsrgOHewxLr+PEq/QZ8HSBdswGlkapXsM2HglWUAjwv987cepYWaTD
         y3ho9dEPvgSfk5qMgQlTHfwtOARlFi7bhkVVJ8iY0alz3mE9fuoaywbjCGXBL4HmoLcM
         CQCNdHO19e56aSvjiUk0PmRGpQ1qbw6fuT+rQlPjDZYmshlV2/mgYg0ck17J9dw6P3h9
         Z4+iNDr72uSJHxGHIDEwSFV+P/307dyLbO3HCV5HMwW3PnQXt1JUPic6B86tJYyKdUjO
         6/TPjuzQ2YjOurkeBF/jL7Y+t0jcdR3jRTNF+Zm/XW5FCq8hfDxQFEbQLlCy/Sh+7rU8
         aCDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgwexyaM7NyY8LrbYDFCrEb/LW3kMNa4Fz28PcDZMEEFnxzNoXMAZmhfz92X1K7/uDIm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67nxHwaT30BVIKJ/jCutXYHqph1fU+GafjLDA0wwLN4cxMqv5
	5tHVL1e6ddi+TVrRwbbBNAKf4JDNJJY7ggvqjSPWaVXaAydiaJZ/5z411cPPH3Ofi6gJUPQd96f
	Ra7FQ8yH04nLL2ONk/tZXYz7ixk0=
X-Gm-Gg: ASbGncsT/Dovzc5HC90O/Oi1wUmPFQvSuInm056Rcp+2J6HIPERV5NSMqwzOSVYrhZg
	QGAn80C9ua4Ed1W6TradoGibedTa+JMFH4pqg2OjkOH5YnO5tmsP7n2HUvVaKeW54P1eAs47KzP
	8t5ZYvfC2uLs7GigpGcavX7QfZNwyVDzEz/c1URxY=
X-Google-Smtp-Source: AGHT+IGqPAYDWd52JTsP0UCf/D1go+KBhcPn9hdhVVFJZZvntCApYDE3Qj9+adGK7jdTV8Ca0YAffBUQvXsxDOAaR4s=
X-Received: by 2002:a17:906:594f:b0:abe:cba1:2432 with SMTP id
 a640c23a62f3a-abecba127e4mr123370066b.49.1740418306151; Mon, 24 Feb 2025
 09:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
 <70b76a89-00a4-4ba6-92f2-4fb46981317d@free.fr> <xmqqy0xz9nno.fsf@gitster.g>
 <0256f214-795d-42a4-8319-4ba79777face@gmail.com> <xmqqa5ad8vzf.fsf@gitster.g>
In-Reply-To: <xmqqa5ad8vzf.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 24 Feb 2025 12:31:34 -0500
X-Gm-Features: AWEUYZmn2cn1rSAj9phWGRQlmyYkkD173Td4WKXLzbMeUQOdruNIbQNkTEf5QHQ
Message-ID: <CALnO6CC+7fPjD5f_LZ1PFavdpKqAjMDmrFL8azwatYpS=+pODg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] merge-strategies.adoc: detail submodule merge
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 5:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
>
> >> And of course a 6-line paragraph is not large enough to put in a
> >> separate file to be included.
> >
> > I'm a newbie here, so I can't have a strong opinion on what's
> > the best solution for managing those files. But, given that:
> >
> > 1. `ort` will sometime replace `recursive`
> > 2. the last change in the content of this document was in
> >    f5a3c5e637, three years ago, basically copying the content
> >    from `recursive` to `ort`
> >
> > it looks like to me that creating another file only for this
> > paragraph would harder to maintain than that duplication.
> >
> > I mean, if eventually `recursive` is replaced by `ort`, one
> > will need to remember to move this paragraph to
> > `merge-strategies`, as it will be used only in the `ort`
> > documentation. On the other hand, given that this document
> > haven't changed since the introduction of `ort`, this
> > duplication doesn't seem to me that will be hard to be
> > managed.
>
> A relatively easy way out would be to have the full warning in the
> 'ort' section, and then only add only something like
>
>         For a path that is a submodule, the same caution as 'ort'
>         applies to this strategy.
>
> to the 'recursive' section.

Indeed, that seems preferable to me (based on a similar conversation
about a different documentation change in another project [1]).

[1]: https://github.com/racket/racket/pull/5144#issuecomment-2563172012

--=20
D. Ben Knoble
