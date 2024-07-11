Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF67288A4
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722007; cv=none; b=OuGomssiGRNWf5lhLlRK2OW2MC6u64NCw8pOnINtv1SGWeqb4vlhFg3qqh5FlkaVIOQG3au7QJR/T4aN6UEm2oGpaSMG4eOS1KQKm8nZpAEpeNTpOCRaxdqIJwTMYPtX63eU2a1tTKah1EjD/Ad9qZK5Vqp6Gc8L8a8I/uf/bFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722007; c=relaxed/simple;
	bh=KtlJ8sDcwHR9Cs9fqUeL1iNqaMRakwU2FmLyqzqHdPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzBVdVbQKw6Pj6ALZEHfsOSENdYqZ2meG7YIqV8jX49RDepFfi1yZrCnBlccJZ5WrHEzaKn1FkQJsH8axtqDn+wK++huBePbr8KKDMpcf4pqxdYtArXYHExoADQOHm0dXZ+MJk7TAFcMFmlRZh0jPPJnrtkJcoWXtEj9LaONFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzDLfhO4; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzDLfhO4"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44e534a1fbeso31081cf.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720722005; x=1721326805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mR9rsziT5KVA7RvBWGm8CiKuYHTGOnRPMS/5eJkASs=;
        b=WzDLfhO4e4t7msAT8PGuHbKsHKH28ERP0mswTLNxZLKonA93bXI6segADqB2w6Zfbr
         PdMdqjOoeGW/HgZ0kmaQhVdgP4Ga8nw7ZKw39w316sy4oNIzoztzp5nZKqtgXUeuOqUy
         b85hU3fvIeCUAxJZEtN8d+ukjSrUdmCpF3/EMHG0plLi7Gp8thp2ZOajibzjRcfty4MW
         plkmAXIRDcj4OO8G6wzOlNYr9oyIiDjsMb7PnLHFVCnlpJn5zqQfYLifqwK1u/mqiglH
         3tH03EzavypBAlwlh2yi+74iMPnYctYdyHFsNY/TbFxxM4AFpdBlSN0fqJbnCZlm3+u5
         Bo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720722005; x=1721326805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mR9rsziT5KVA7RvBWGm8CiKuYHTGOnRPMS/5eJkASs=;
        b=Pw48xcI1ME415cNZA1+228aeIVR5ujrMLDoyusx0f2t4yFa5eTFA9iUfUQ6jmOh5DH
         9RvHUqsz5aAYzfCobOoFN6X1sWbiHr51YQ2P/eqRR4Nh0vJuKIJqBJoF8AEChfsilBFT
         KlDsPkWuOFfoTVFkYuVQwXK/7TdewqXH7Odu58szytT20sKnVekO7ekSqCWhGVpm8lEF
         H+HKu5TUmp11nD6hbcn2GLvUKI3vXiZbrUxMs6+qqpi85PLEl2nkjLLMu+ABQJoI/jCs
         UD5AV9NmVdm531U/pX+2NoQGa4JNHcsFj6us0xSbAZeO/jX6BEEq7xwlxB2lmjI4gG2/
         BVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqu9nLg+CNVLGaqh8l++R3Uuv4DbpZ+s/5rsFLpxzPcUayr+RYix+Q440LfnKkL82PCgLETO0XXCLiiH192q3YCDnW
X-Gm-Message-State: AOJu0YwFHszy4tZEqckhEvs0ruq/y7vToiLJuuiLq7MSISpE7FN+Rcca
	xmAoS2cjXNg7pCL6NlnfV+wwZWEqlUUvrKNI0x/3IUAyalh/QnGXOMXMqH1e3WPb23L/7GM6vwW
	rxg3gotfi4rrUSujUcf7NHNQvC4gEdzaVJzoorHPFsYRVVadNzZla
X-Google-Smtp-Source: AGHT+IErn+c6BpHn28sbHRae7CLk+e+bqN9l3jU+zewIG8y0SJAMl4OJModujHYLZtq4V5dApEQlPAi1HqGCgzLL4bc=
X-Received: by 2002:a05:622a:1986:b0:447:dd54:2cd4 with SMTP id
 d75a77b69052e-44e758fb955mr302491cf.22.1720722005101; Thu, 11 Jul 2024
 11:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <xmqqfrsi9i8y.fsf@gitster.g> <CAJoAoZn6zB+e5x6FEvesu173dHhgWBt7ZQ51H8ebp31kQKFCgw@mail.gmail.com>
 <007a01dad306$b12caad0$13860070$@nexbridge.com>
In-Reply-To: <007a01dad306$b12caad0$13860070$@nexbridge.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 11 Jul 2024 11:19:53 -0700
Message-ID: <CAJoAoZm4ThQfJHuARnyfRAy81sfp9LchCSF7K=TZ9z-xFBGxvg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: rsbecker@nexbridge.com
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >> > +* You should run nightly tests against the `next` branch and
> >> > +publish breakage reports to the mailing list immediately when they =
happen.
> >> > +* It may make sense to automate these; if you do, make sure they
> >> > +are not noisy (you don't need to send a report when everything
> >> > +works, only when something breaks).
> >> > +* Breakage reports should be actionable - include clear error
> >> > +messages that can help developers who may not have access to test d=
irectly on
> >your platform.
> >> > +* You should use git-bisect and determine which commit introduced
> >> > +the breakage; if you can't do this with automation, you should do
> >> > +this yourself manually as soon as you notice a breakage report was =
sent.
> >>
> >> All of the above are actually applicable to any active contributors on
> >> any platforms.  If your group feeds custom builds of Git out of
> >> "master" to your $CORP customers, you want to ensure you catch badness
> >> while it is still in "next" (or better yet, before it hits "next").
> >> If your internal builds are based on "next", you'd want to ensure that
> >> "next" stays clean, which means you'd need to watch "seen" (or better
> >> yet, patches floating on the list before they hit "seen").  Your group
> >> may build with unusual toolchain internal to your $CORP and may link
> >> with specialized libraries, etc., in which case maintaining such a
> >> build is almost like maintaining an exotic platform.
> >
> >Hits close to home ;)
>
> I hear that. Sometimes having an exotic platform and specialized librarie=
s are overlapping. I am still stuck with 32-bit git because some of the ava=
ilable DLLs on NonStop are still only 32-bit - I'm working hard on changing=
 that but it's not under my budget control.
>
> On that subject, I think it is important to have known or designated plat=
form maintainers for the exotics. The downside is that some people expect m=
iracles from us - I just had one request to permanently preserve timestamps=
 of files as they were at commit time. We're into weeks of explanations on =
why this is a bad idea. Nonetheless, there is a certain amount of responsib=
ility that comes with maintaining a platform, and knowing whom to ask when =
there are issues. The platform maintainers also can provide needed (preempt=
ive) feedback on dependency changes. I'm not sure how to encode that in a c=
ompatible policy, however.

I think it's a pretty good idea to have a contact list written down
somewhere, yeah. Maybe something similarly-formatted to a MAINTAINERS
file. I don't feel bad if it's just appended to the bottom of this doc
til we find a better place to put it... or maybe we can put such a
contact list in compat/, since someone lost trying to figure out a
compatibility thing might be looking there anyway?

Who else would we put on there? I can think of you for NonStop from
the top of my head; that AIX breakage I dug up was reported by AEvar,
but it's also a few years old; and I could imagine putting Johannes
down for Windows. Maybe that's enough to start with.

By the way, Randall, should I be waiting for a more complete review of
this patch from you before I reroll?

 - Emily
