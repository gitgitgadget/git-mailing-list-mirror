Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADF298CBE
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647339; cv=none; b=KaxpLQ2GOTyXE3IWf4LqKNxmAd8SSUC2/UA34U56Y2rof5xbXEbMtu5hNYUqkLaOD3q/G0hQ+yUDLbdogTRzDS1eO9AzQ2AeyUXESSm6fzfSb6DDLULhSqCaEYRXjO4nR8UPt+I094T30m/pvNAqYL91ZKGkOfS0IW7KgIVoF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647339; c=relaxed/simple;
	bh=O0AC+PNwZkGxHvGLzwt0KXs2Jm1na3/9Y7/w5FBUHI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCtk8yZePhrgcc5/XX7oi/qywbPlU02uCoqFMtKoZxu4Tr2jiMes2533KoDcIEEsvKJRMpVQ5aHj/7aLLpekrW6yb8Y99yhaEo8sFSGRWCqaBH3n/LHJEG6T4ZmTwBcx3UcAxOtLJ7bDa1IQpZ1bzBw6+11UuG4I1j97cucYAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiskuR2p; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiskuR2p"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso1981312a12.3
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647336; x=1761252136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4wNaFiCgC1vy94easMRDyD1x/7Q6DIk/aR3ZjnPPuE=;
        b=XiskuR2p8tQAg+0D/Pvxy1cfS1qvGQiVOf9a5pMsxJHj8ZR5k/1ogtTT9o68MPkUV3
         vKH89XNt5tUyMRQ9cF2xDbBf21D6VwFY3hp+ZXTfVYBP8AH4uSsc1vx+38v0uHGHOLGl
         S7CSaAdV5SC5aUDk1JcHgGOVs5pg79gZ1pYwe/pdpToCiSbKxo54rcWIPLx3mRK2PZAY
         6ZUMc5A4u29/owr+k4OXyHdUkJKKvDet3QA+mUkT7He04wZLHQY0ud10q8jpTKENSl9W
         ZW6n5Wp2mina8gs5ly9FXOc4tbDhkiCFRAtxSIE4XRK6g2VthfGUmfyi4u7559jHquUD
         X+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647336; x=1761252136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4wNaFiCgC1vy94easMRDyD1x/7Q6DIk/aR3ZjnPPuE=;
        b=GD6RsRdftNvHuIgRttYpsFKd9rdBNsEr49DTTMne/kQEXh9Pn1I3VBFjFlYRVWB6Xs
         rDUvHqCuHyHkHCbRJGHYX0vzy3gjrYlmfduCZAcT394xZHI2rvJmaZGfLFaFnXjafXte
         gjP1aGk252qAxQ/Cq/SUx4CMmG0SkktVxxRHtPny12Oeq1dlQ5eICjcW45b2pT+8k7ji
         eQiMTAQtIZz7dO1SkO25nM4iETzOHBbu+4cfhCMr3cmzX4+jsV9zS/mrjHPpKFoZf0gT
         vTK+ytKMcbcdsdqnUsWzwtwj4zAV1WCcuizjEAuGEm6i3cgT10YOjBLowPSRNrGmO/Xr
         VBzg==
X-Forwarded-Encrypted: i=1; AJvYcCWi7NX4KhVbAXJ+br8n4l6zqgTbQvLPNlzp/BfSq0dcFjRGDscN1s1AH0QXhFoKCVnTTms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9aU1Nuu+/njoga4An1VaM2W4jVYpaf0KKJTQzivOWJe9oxWt
	hWy0Z6l8gikzyv5Vx6RGHVZ+3ySC/BHKicLfNW9nq1ILvzCrwtr29WzXMJJmlGrZZO0RoyPiyIL
	kcKdVbIQivZ28snRMiPD7TMV2/G+ggh0U5g==
X-Gm-Gg: ASbGncsRbqWny6UMMs53RLtgygKXIzrwWOeM4Y6+hxOmWsmW/iMLH+9W/Jt4O9OGKf9
	BHAZnEIH86no9Lu2imrZsc9kb7kssaXeUhEOMtOoel5FvgY18jfdFQGqBwD31L9Ej8dZGmqDsxJ
	Nrvq2Z7MUeOyStyvfK5T4EC0YXWPNUmXyAhOYVA8Px0NHCZe0VZP5opzyqBC1cImygAhxmpJyYO
	OxEsqsFYrbjiPz+Omj/OQVqzKlKl3H35sQZ6pB8k01QrNVZX4tELAVTOx8C8wEQjrraX1TcL79q
	NHoLCmepktZgVLcIWQ==
X-Google-Smtp-Source: AGHT+IHfVUooiNyUr2927jyG2hb6oVA0Az8ocqLSvLvE76hPIAQDg21OfUCDlocmyl52Esg4zRWELdY8aFINLkK89DQ=
X-Received: by 2002:a05:6402:3585:b0:63b:f05d:b985 with SMTP id
 4fb4d7f45d1cf-63c1f6edb50mr1027594a12.35.1760647335788; Thu, 16 Oct 2025
 13:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
 <aPAgBPLH4QYa0ceP@fruit.crustytoothpaste.net> <xmqqh5vz7ygc.fsf@gitster.g>
In-Reply-To: <xmqqh5vz7ygc.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 16 Oct 2025 16:42:03 -0400
X-Gm-Features: AS18NWBDEdwqOf7znFrIsgggtsZh6be5YHRTX8VeQGhO6uttWgAnccErjRB8MxQ
Message-ID: <CALnO6CDH8i0++gTXZCXScLpXnvKTXN5=fYxLJ4W+mgfcSaZt_Q@mail.gmail.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be
 removed in 3.0
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Martin von Zweigbergk via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Martin von Zweigbergk <martinvonz@gmail.com>, Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 9:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> >> +Support for "git diff X..Y" syntax will be removed. Use "git diff X Y=
" instead.
> >> +This will open up the syntax for a more consistent interpretation of
> >> +"git diff $(git merge-base X Y) Y".
> >
> > I feel like this is going to break a whole lot of existing scripts and
> > probably more than a few forges as well.  It seems especially bad that
> > we would add it back in the future with a completely different meaning,
> > since we'll have some people that use 10-year LTS distros that go from,
> > say, Git 2.51 to Git 3.xx, where the latter reintroduces the syntax wit=
h
> > different semantics.
> >
> > We've never really changed the meaning of things like revisions or
> > revision-adjacent code in the past and I think those kinds of things
> > we're pretty much stuck with forever.  With that in mind, I don't think
> > this is a good idea.
>
> I do not think X..Y (or X...Y), if accepted by commands, would never
> change their meanings in the middle of the commands' lives.
> Teaching "git diff" to complain and barf on X..Y is a possibility,
> but to do the same for X...Y, we would need to come up with an
> alternative syntax first.

Isn't the alternative syntax

    git diff --merge-base X Y

? That's what the manual says, at any rate.

> The same for "git checkout master..."  that detaches HEAD at the
> fork point of the current topic (so that I can "git am" in a new
> iteration of patches on top).  As the syntax "git diff master..."
> is symmetric with it, if one were to change, both should change to
> the same.

As a gut reaction, this is a bit apples-to-oranges: for me, the issue
with the diff notations is that "git diff X...Y" shows changes "only
on the Y side" (where as with rev-list/log/etc. it does "both sides");
contrast with "X..Y" in both scenarios.

Meanwhile, checkout is only ever really expecting a single point to
checkout. Still, perhaps a different notation that means "merge-base"
is warranted for that case, making the following equivalent with my
hypothetical syntax:

    git log X...Y
    git log X Y X^{merge-Y}
    git log X Y X^{M-Y} # hyphen optional here? "merge/M" vs "mergebase/MB"=
?

Inspiration from X^{/search}, of course, since any non-<type> and
non-"/" prefix is effectively unused. Anyway, then you'd write

    git checkout master^{M}

or some such (where the "empty" bit becomes a synonym for HEAD as usual).

--=20
D. Ben Knoble
