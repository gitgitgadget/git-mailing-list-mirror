Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3215D8F0
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455113; cv=none; b=I0ufDvDTmQEbiQakiuV1Zu5Q3eFgjdzsB0G0z4RUo/Jkpdanmi7yJWsh3HrfSLEslUcOxKbdbMhDqNgGh7/r0PslPGAx2A5HrH14IzFu1tZVBcm5MUxQbqYjfbzjx82cEladpykBgxKDOyLBlBBEucz8nq9mKdH+ROwTc0Pn3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455113; c=relaxed/simple;
	bh=iJGxrQU+Vc+EP6eYT5m26q+9UzhSUC0Rfwk7+73Em1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yp2pidSbTGoe6AlDY3OybfW3Vg5d9EbhnPCVa7X/X86p7d7LVfNY7ZI4EyGeQpABHQM/W0yKT1n34Ryjv+bO4HojX7g1A9NKAaLTOSkkiR0XROVpY5uwHtfAX1jC2X6ejBF5Z+sPRmMKU9WoAHThnGlPNyFO33UTLjys7NGCeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg3jkEtt; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg3jkEtt"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e9b26a5e45so2666340137.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751455110; x=1752059910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V81+HTDrQ6z7Ol6bWib4HyIBREAfti1Lp6U1q8AH4QM=;
        b=Jg3jkEttmkc9S6u5rOJP0LawmHGnR4Tg7xD5h2rg5kPthfEr4uU63avfHHJvV120zg
         sdgSHbQD6d7YuqRgytlPLiPdNoiwlFZ3kAFmgohNvl2j+kmR77RAGaIWrH+XMLvgDP//
         dfZaZPdPfsQUlQhI5ob+SbFwPpL3VU0iFzlftzgmUjr+SIkcynMKQUSbUFW/EsR3zZr1
         1q/o88hBAr6wp4ETqxQQtxrcglTBpjfv4iJq6S3ardNFVm4oNlHO+dxhD6+w/I3UgVQd
         w0bhCV5B8i/oG8VRafVgAaaDedgU7z0/sYD+mJ+HroBXuF70IU+5x2jMknGipLUkJw0s
         vdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455110; x=1752059910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V81+HTDrQ6z7Ol6bWib4HyIBREAfti1Lp6U1q8AH4QM=;
        b=vZd5WiC2vC/do3j+hQgV0o0oIaCCPeW44RCslcU4EcJPzESllSiL04FhURwMiYnAPw
         qKA6sqchIgK+juILmCToIKeFG6DqH+UlpG0nRkf7NejYVW0Muifm2yS8VtqCi35xVsCG
         FrTh9GDmOpt9vEgkCquOzGWJpkxx1ashIthYCLHdU7KDku3EoO693uwiPZ1Yy/hFml1h
         0MVpNHt+ikt+RUOjLskVcGxvfU4MoSQvYRIXGYozFPxS6BfLlPJqo3NCFNsJ7Kkr3lgB
         erOeDlcGpPVD9ocK8OoWWWBo4H1AK3Al/9Yy+w9aas9eKIijjaONfpVG3TDQgW8/8/we
         LUCg==
X-Forwarded-Encrypted: i=1; AJvYcCVsowfKLKWuIx3XLR03rJ6HO8U6lvFped9B00fQbWAlCbX0YvfTalpVr2vDAEFUOfWHYP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQ+1DhNNSgP6edXxRpeGGlAD6toX95Cp01JW0tksYRRg7cki8
	Ugi1GEvMJrqcc+BLV/ui0NHVle+j/bSzofvGohMAfPqP1d+ofyObXgAMvl9iJXnFu2jCs903ama
	8TiIkKRds0P8CNJ6tFod+zRudQmAgaRI=
X-Gm-Gg: ASbGncvvBAcJFwaBYkP6yg5H0QOburr2zZn9KfCunsDhqxSMxesTsRWFzq4Tx5Hmpqv
	mX943o8VqXXwL3V9qpWGWczwiIfmYuFCRSStuHrL9qKOKZ1+p5jAUb/Y++mdYudRDmbnq02ZHkz
	Vp5c4C+sn+FFVT2yTnOtp3eQTiEvD/XCzGSDmEkYFDM0M=
X-Google-Smtp-Source: AGHT+IFCyALuQ8xKaOnGrw8nD31PXvk8qJh62RebTuDcU2jhb3wezlWrd5gOWcFPivEtTs+azgQFISGHdFbQqYeRypg=
X-Received: by 2002:a05:6102:4bc8:b0:4ec:b36e:ad09 with SMTP id
 ada2fe7eead31-4f160e0b52fmr961547137.10.1751455110401; Wed, 02 Jul 2025
 04:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751296633.git.ayu.chandekar@gmail.com> <f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
 <aGPcKgR0G72JRSlM@pks.im> <xmqqikkbkglx.fsf@gitster.g> <CAE7as+YtmRxD3P-T4bzccgJnd0Ocj0kdW00g-=3gtdoWhTRVeA@mail.gmail.com>
 <aGSYLJaqDziLqtXk@pks.im>
In-Reply-To: <aGSYLJaqDziLqtXk@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 2 Jul 2025 16:48:19 +0530
X-Gm-Features: Ac12FXx8LE5Al7tgIAdxLYsZyIYRCaD7qFabwaVyThLoxDKyF8HWOGdDtCTvAuE
Message-ID: <CAPSxiM9ahAPEr5fj_A1RpgYjJQmv9kZ2jYfR2Knat5yHZNDkEA@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on 'the_repository'
To: Patrick Steinhardt <ps@pks.im>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:17=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Jul 01, 2025 at 11:39:48PM +0530, Ayush Chandekar wrote:
> > On Tue, Jul 1, 2025 at 10:12=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> > >
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > > > On Mon, Jun 30, 2025 at 10:11:05PM +0530, Ayush Chandekar wrote:
> > > >> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
> > > >>      expire =3D TIME_MAX;
> > > >>      save_commit_buffer =3D 0;
> > > >>      disable_replace_refs();
> > > >> -    repo_init_revisions(the_repository, &revs, prefix);
> > > >> +    repo_init_revisions(repo, &revs, prefix);
> > > >
> > > > Does this work correctly when running outside of a repository? In
> > > > general `cmd_prune()` is not executed and would instead die as it i=
s
> > > > declared as `RUN_SETUP`, without the `_GENTLY` suffix. But when the=
 user
> > > > asks for help we may still execute the function with a NULL pointer=
.
> > >
> > > Good eyes.  "git prune -h" would safely exit in parse_options() in
> > > such a case, but this part happens before the parse_options() call.
> > >
> >
> > Thanks for pointing that out, Patrick. Right now, `parse_options()` is
> > called just after the `repo_init_revisions()`. I can move the call to
> > it before this.
> >
> > Although when I tried running "git prune -h", it still gave me the
> > expected output.
>
> Well, as long as it works and as long as we have a test somewhere that
> ensures it keeps working I'm happy.
To add to the testing part, I noticed that there is no test for
checking "git prune -h".

You(Ayush) can add that in "t/t1517-outside-repo.sh" there is a
similar test for that also in the file.
"test_expect_success 'update-server-info does not crash with -h" You
can check it out.

Usman
>
> Patrick
>
