Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655033126CA
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007546; cv=none; b=DAQwrgaotupcOtdjexH48kZmQ7pJU1uvPLvNOjVFMHhUeOaSTh3xScaTLLVG5+uwOjMKvBk2/K9TKMEsI1AgYNsn6x19/2oekJXHEH3KAJAAVTImUa9+phcnM0aZv6MbUz0/BY0EBf+rSI0SPHFEOadvasWWrl+fLFi2nSaJvRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007546; c=relaxed/simple;
	bh=iaE0NgCEzWro03x5kQ9et7KBxHXDKZt/Slv0CjfuNHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qX9b/8+YVjdxYdI6s7UR5ciSHSpmJ9D+43/9/Vl/29Fn4Ccv2/iJ0Z5+npIcoUa8PFhOt5H3HQ6KXmKfiV3UfpbP0ZKkBn7y+QZMtX9pqazmksX9oVLciLKABZqe6MFB9hdkeAkKaZJLPIlz2cH5KUpCFnqunplpNQ2N1RS6r4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b5d70c2cccso2581421cf.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 10:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007543; x=1757612343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaE0NgCEzWro03x5kQ9et7KBxHXDKZt/Slv0CjfuNHo=;
        b=lqVbN9Qc3sDWFUAgivPF5hhRY7D0CqO7IEU7G2LPUqyE0W+gOscltiwR5fLa59aqop
         /m176O5uFisFWasyrFIU3rkiwnsgDCGFtN0r6+bZ379nSOil4Z2eJ7m6h7lf2HQCHQzQ
         tX6OUBH1TCwZYY6iOPWHllY5oyVvdas2nIzhHYfg7n5KPrVB9FuKifY0UbgDg5TiSiPG
         1aSEiqWW8/alrFimyZVFbrAdCYF6X8+D5W+0YwOgz/KiXAgHsOh1qKC5kpVAsOt5dHxO
         UneM8jhZPkfYK3euFjufi0+dsbe8mxKk+fl28IwMzWJKJHgsRMgvfcF3yZxxJfJdR5uW
         R5sA==
X-Gm-Message-State: AOJu0YzrlfbeIEds0DbCi76yojM1l9U2hKIG342K5zhGQp0EtW/6lj+J
	mKhaQqXGRL0p69YbhFz8rPthd2fKT4MKMJqo40HC9ZlXN+mtLkIfBojY4nqT1CRJ5DBybkCWH6J
	m1ynDeNSBLT/19oFm8G9m3KeMvtRvkvE=
X-Gm-Gg: ASbGncsKvjloHB09u7dHRUvGxHPnyxnU7weqDxKzZtJk/0sElSWmOy+qQ6JvqEGeHTs
	P6PLC/IE0OygozKctLIJlh5xEBh5QoB4IgWAW/sSga/anL49q9yOx7DPHZRfj+GN9rYVSAvJnWu
	KS95IYpzh2S4Fw6ks8sppQnc/wSBS2ZO4KPKZE8tX5ohj5+VbmM3mOjV4Mb3O9YO9VlUjRToFjm
	aXIJoa1LIJj6wlvDM9lCVhpntM=
X-Google-Smtp-Source: AGHT+IEGmYLlyhYsCUIMXfOHZ4+gwNI/FDzOjLGHC8eZPp+on2Ma3r5bu+0hY2URR4XZOX6N1BY6X+1oeLttFG9pIfA=
X-Received: by 2002:ad4:5d4e:0:b0:70d:bcbe:4e79 with SMTP id
 6a1803df08f44-70f5a5fae45mr204178096d6.6.1757007543037; Thu, 04 Sep 2025
 10:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im> <20250904-b4-pks-rust-breaking-change-v1-3-3af1d25e0be9@pks.im>
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-3-3af1d25e0be9@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 4 Sep 2025 13:38:52 -0400
X-Gm-Features: Ac12FXw14MkK79h-YDL9kUHDrZVCvjXKACe2LV_Vp3ac-VZnHKVcszs6YqB4bJk
Message-ID: <CAPig+cThyuo7=A2f7_XkE_TZmSRc5i=EFgZOw_pKgu+Ckgx70w@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] BreakingChanges: announce Rust becoming mandatory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Over the last couple of years the appetite for bringin Rust into the
> codebase has grown significantly across the developer base. Introducing
> Rust is a major change though and has ramifications for the whole
> ecosystem:

s/bringin/bringing/

> Instead, preceding commits have introduced a test balloon into our build
> infrastructure that convert one tiny subsystem to use Rust. For now,
> using Rust to build that subsystem is entirely optional -- if no Rust
> support is available, we continue to use the C implementation. This test
> balloon has the intention to give distributions time and let them ease
> into our adoption of Rust.

If it's entirely optional and automatically disabled on platforms
which don't have Rust installed/available, then it isn't a test
balloon, is it? All previous test balloons in this project were
architected in such a way that Git would fail to build if the platform
in question lacked the feature being "test-ballooned", and the idea
was that packagers of those systems would alert the Git project about
the problem or somehow resolve it themselves via the platform's local
build infrastructure.

However, with the approach implemented here, Git will build as usual
on all platforms on which it already builds successfully, which means
that the Git project is unlikely to hear complaints from packagers,
especially if packagers haven't followed the relevant discussion
threads and are unaware that a Rust test is being conducted. Moreover,
the project has already heard from some packagers/maintainers that
Rust support is lacking or (currently) impossible, so the project
already has the sort of knowledge that a test balloon is intended to
elicit.

That's not to say that the changes implemented by this series can't be
valuable, but rather that for these patches to be valuable, you
probably need some way to advertise the test more loudly so that
packagers actually attempt the Rust build. One possible way to rectify
this shortcoming would be to enable the Rust code by default in the
Git project but give packagers a way to opt out of it if they can't
make it work on their platforms.

> Having multiple implementations of the same subsystem is not sustainable
> though, and the plan is to eventually be able to use Rust freely all
> across our codebase. As such, there is the intent to make Rust become a
> mandatory part of our build process.
>
> Add an announcement to our breaking changes that Rust will become
> mandatory in Git 3.0. A (very careful and non-binding) estimate might be
> that this major release might be released in the second half of next
> year, which should give distributors enough time to prepare for the
> change.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
