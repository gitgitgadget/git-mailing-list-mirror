Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDCE2208A
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546461; cv=none; b=QkdQnZ5f/+qipwtF9rYOsEBe9XVucLDNm2+r3kAPySSr0oLuZJNdt4MybwioDUQZvCTzZT+p6HREj4oFIVgEIXrB/2WlGZB5XphnVk91h13ZRncSeMy8uZFB/S2UBzACPH7OikenDONTvAgT8nIc+HeBE/G4MgeAf4fU6edOc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546461; c=relaxed/simple;
	bh=2jS5VG8VX4b1kSiDozeSXCHK0u3ys9ztkKwSAuHrXgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlhasFbQ1lOIK9+MG9KVUm704GxPtCsne+C8DQ2dkZ50YgyWry5zlRm/6vIJI6Vyf/sekyKhmUbC0PEQgUBDgNC9Ao95JiZQ/4hRoDeg3M8Uvcj/R7Z9QFK9FFfwMpu6fEmAJEaCPomV7FZy/k6VZbks+KbYrOlH28TFscY4mg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqO9qqww; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqO9qqww"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a45670f9508so54289066b.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 02:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709546458; x=1710151258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJ2GkAeS35dZnKBayvV8TsW7JM8uQZy8KWOFWmMw41U=;
        b=XqO9qqww4VqsikuFOvTSoVcBZPvB/pJRqWlpCN3Zb1Jwlhe2zdLN6IotBeS2uFsSCj
         g4PBZm4I/t5hlEbd66myHtRfgvGl3divYEVykUemJM4W3EGXTd77VD6hhQhFhJ0U2DB4
         hyYbYcAloMlii9b+QvXq5kKK0bdlrpYwPNJOfk1BnjqNgHEhOL7/1/JQlasGDuCF22Zi
         m5KmC+CaDt/EG/jYTZeh3ZDo9cZohEw7H4hd3LGAH9FTv7dY1YO4DkCiu/7PxBEV1Lxw
         IJYnxk+DfzD3qKdKnleXwTmYIifDEm6PpTKlD2RU7n3cH+q6kjOxgSBk9Wk8VwvM44hX
         WpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709546458; x=1710151258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJ2GkAeS35dZnKBayvV8TsW7JM8uQZy8KWOFWmMw41U=;
        b=G1aHZKaeWkppaTsCvGZ+s8WiLayUAv7ttYn9C/BQpVxIca97DqN4niMxxzjGBQEFCS
         lYle2oR3WfsumFIiQSek6TV/0gPeB2/60JXAZEELM3aOpQa9kQqlG0CmhmCc3JBVWWnJ
         qGZtaO241CzL3pCiIi6h2yEUjehkxXPHQq3pZ30kVxSfD9pjVFeis5gyDvwWNMWbuiwv
         UogdSIdkjNPfwjMioqz2y1jASO9A5DxdqjCvzWYG+mlTDot0/fDbfRWy4DnritpWyngb
         ZX48C3IPwXi1Hz+4K12dmiDC6mmSN+bye77QY6vHu6d+Bh2G+u+5r9tdrhH9GgX9yrKB
         V2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNEfbrOX/FZzr4r9UYQX1jGSIG2NeEXOOgcW83xcchiDXQQcbjwsSfuCur5vfNH2c6utm4nYG4QPO+RvwE1XhlripF
X-Gm-Message-State: AOJu0YzM0CcFrM6ME3x6dY4Ht98/mfs6u+dBYMI2qTce0FoSxmgO45a9
	BndQpv3W/gp3Q46LzZWKMoaIQG/kb/1MHe4W8H/ByjeJK5LaRUuLR1Vq8UFQBxxKj79hUq58lrc
	p40jF/l7Y56QVoXXJJWBrgk51ToU=
X-Google-Smtp-Source: AGHT+IEkBf+BbqENshewz04ueJVax+yj0POCyR5PAW668uZXGrmz1z2gWjvjdNldF7In/FtvRvbWoaf0jcSu6q2TaZ8=
X-Received: by 2002:a17:906:1114:b0:a3e:8300:1af3 with SMTP id
 h20-20020a170906111400b00a3e83001af3mr5625503eja.30.1709546457679; Mon, 04
 Mar 2024 02:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225112722.89221-1-l.s.r@web.de> <20240225112722.89221-4-l.s.r@web.de>
 <CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
 <d96aaf45-f073-42d0-b69c-703393634848@web.de> <ZdzfYPim2SP22eeS@google.com>
 <CAP8UFD2t1KRo01eenK_RVndyVx5Vp9F4FepTgnR+mwhTGTvXnw@mail.gmail.com> <bd48f19b-0600-4e64-835b-98d3a97bb7f2@web.de>
In-Reply-To: <bd48f19b-0600-4e64-835b-98d3a97bb7f2@web.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 4 Mar 2024 11:00:45 +0100
Message-ID: <CAP8UFD2M2+x-pRX2nzCXbLW=nKcW4_RWc9qua5q-fU8QbGu1oA@mail.gmail.com>
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Achu Luma <ach.lumap@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 11:00=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Am 27.02.24 um 11:04 schrieb Christian Couder:

> > Yeah, I know about TAP harnesses like prove, but the most
> > straightforward way to run the unit tests is still `make unit-tests`
> > in the t/ directory. Also when you add or change some tests, it's a
> > good idea to run `make unit-tests` to see what the output is, so you
> > still have to see that output quite often when you work on tests and
> > going through 3598 of mostly useless output instead of just 14 isn't
> > nice.
>
> I was starting the programs from t/unit-tests/bin/ individually because
> I didn't know 'make unit-tests' exists.  This is much nicer, thank you!
> Especially after adding 'DEFAULT_UNIT_TEST_TARGET =3D unit-tests-prove' t=
o
> config.mak to complement the 'DEFAULT_TEST_TARGET =3D prove' I added long
> ago.  It would be even nicer if the former was the default when the
> latter is set.
>
> As unit tests are added, their output is surely going to grow to
> multiple screens with or without prove, no?  So someone writing or
> debugging tests will still go back to starting then individually
> eventually.

When t-ctype will be run individually from t/unit-tests/bin/, for
example when adding or debugging ctype tests, it would still be better
if there are only 14 lines in its output rather than 3598.

> The size of the output in itself is not a problem, I assume, but that
> most of it is useless -- details of successful tests are uninteresting.
> A test harness can aggregate the output, but prove annoyed me when used
> with the regular tests by also aggregating error output and only showing
> the numbers of failed tests.  Finding their names involved running the
> test script again without prove.  Turns out it has an option for that.
> Added 'GIT_PROVE_OPTS =3D --failures' to config.mak as well, will see if
> it helps.
>
> Is it too much to ask developers to use a test harness?  Perhaps: It's
> yet another dependency and not enabled by default.

Yeah, it's a dependency, and when running CI tests, it's sometimes
better and simpler to have the canonical output rather than having the
output processed by a test harness.

Also if we add some verbose or immediate modes (like -v and -i with
the shell test framework) or perhaps other kinds of modes (checking
for memory leaks or other errors using existing tools for example),
these modes might not interact nicely with test harnesses but still be
useful. Requiring to always use a test harness might restrict us for
no good reason.

And anyway it doesn't make sense to have meaningful messages as second
arguments to the TEST() macros if we always want to use a test harness
that just discards them. Either:

  - we decide that we will always use some test harness, and then we
might just want to remove that second argument and yeah we can have
thousands of tests output lines from a single binary, or
  - we acknowledge that we don't always want to use a test harness,
and then we want a relatively short and meaningful output from a
single binary.

> What's the right level of aggregation and how do we achieve it?
> Grouping by class is natural and follows the test definition.  We
> could stop after patch 2.  Dunno.

I am Ok with just removing this patch like you did in v2. Thanks.
