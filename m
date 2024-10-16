Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758A13B298
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044029; cv=none; b=osWKnzLMc7wC/9zrTxI0W1ieTsHsHP3BR3tDPT8Jh9J3YEoi+zmueR/tuhZ2+pTE90RONGW0UIHSBRDSWZKGdX6gQGegGAUGpMDjpjAViqcYIgiFCifdTCoeKpaxhj9jsj9sMWOc3lEsp/nb4KZttvDkbipwdNbqES3+q7IPJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044029; c=relaxed/simple;
	bh=ZfNcSyrBJHEzj+mcDMX832QpZCT5hqMZb7Z70Yj3FeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEk2UNJ2ISfbGdH6ToA8oPXucgbcXjBW8ak626KyE/MA6Xnon5BjZYYG0exj/4RaNoNT4zyv2+LPwVnwVrDAkg6GBj5FpyL7xz81tS1YtqwBnNsAbd0yzBiyN7D1xNy4mYFwTgBUNC/hmCyEw3p0L0WFz67EAgfXDLfJvU67Oj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e29327636f3so3171022276.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729044025; x=1729648825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYYFN2gCx4lo8sj5DPEckCMUyJHN/ETEGHRly/tV/NA=;
        b=eE7FjdXqSMf8Rx5IrCxKwoiYlVyv+Nc14Ky/qVtx+VnqId6AZEPCYSHj4o/DmokbBV
         hNt4usoAxG4TWeTptUAJGIM6mUv8lkX9rloOLHI/PxFIHGV8iZsTejXOEkA0RrUVYcwN
         alPVUd1P1/oFiiTuWdcN7K41zNXV08D3vjGVmCh57lNz7/N9ZO8jOmkJiaaiUeFP+w6/
         0fLEclrx43rZDFC7BpDYEv2aJd2f04z3OhimCpY1qega+kW8Y449EIj8bJ5gHNDJuX5j
         arqex+4EPlbt9rHpGXBOiOqfQWSnaaNPlF5BL0ScRyNLaO33XGPWNVzUK/svr80yMAFl
         o8xw==
X-Forwarded-Encrypted: i=1; AJvYcCW77yTjOIqs5ubL8ooRXwZsltplB3Bl+B7fwmPO2uk4SDfp4iRJtZDJ7Fb1jK3dqjSl4aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPhnERldfqogaWdPifMOJNXmPeGWTwgMLCopMb5WQV7qplPpml
	31a+OMlBevYa/C+emOq614SLK6bYi4n7Bktd0gnsog0/FiIJZy8Hkx3S8hAzPbwZqcWaYBOtQhN
	cQaR7hcsrBYyuuldJM/Nyun9QZOw=
X-Google-Smtp-Source: AGHT+IEpS3yal9J4gPjFJE7RVVNFoFYEDPmiWc0gfLssKRyG0Vi1wO+v1fyflNf6Gw9u0GzleCZ6aJOnCuZ4lJBV0UQ=
X-Received: by 2002:a05:6902:f81:b0:e1d:2639:66be with SMTP id
 3f1490d57ef6-e2931bd76f1mr10610854276.43.1729044024893; Tue, 15 Oct 2024
 19:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241011074022.GC18010@coredump.intra.peff.net> <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
 <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net> <CAPig+cS0vkTXeZX7qt6oOq3QpkWovfJnXuH7c3JtyAKOfnq1Ww@mail.gmail.com>
 <Zw7AVzBORjvxrvKh@nand.local> <Zw8BMEYHaH2ImMmY@tapette.crustytoothpaste.net>
In-Reply-To: <Zw8BMEYHaH2ImMmY@tapette.crustytoothpaste.net>
From: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date: Tue, 15 Oct 2024 22:00:09 -0400
Message-ID: <CAOO-Oz0t8V28P7VEACAu69_dD47ZuPPazN9vy_c1dLCeAU5N_Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perlg
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 7:57=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Nobody, outside of the FreeBSD maintainer, has even bothered to set up
> CI for a platform other than the three major ones.  The patches to fix
> SunOS 5.10 also don't include any tests or CI.  I don't think it's
> reasonable for us to go out of our way to support these systems if
> nobody using those platforms has bothered to provide even the most
> rudimentary check that they work.  How can we expect developers who
> don't use these systems to even know if they work without some basic
> tests, even if it's for only one architecture, especially given that in
> many cases it involves adding just three lines to the workflow file?
>
> I think the answer is that we can't.  Since we don't have anyone who has
> demonstrated that there's basic interest in helping the contributors
> support their platform by setting up tests or volunteering to be the
> maintainer, we can't support those platforms specifically and we're
> essentially left with just honouring the policy that we've set, which is
> what I'm doing here.

The machine I use to build for SunOS takes, let's be generous and
say an hour to build git from a fresh checkout. If I'm iterating
on trying to fix something, run make, and see that it's building
daemon.o, I know I've got another hour or so before I find out if
my change worked, and maybe discover what the *next* new issue
is. There are faster SunOS machines, but not the one I happen to
have available. You would not want this machine in any sort of CI
system. That said, until sometime this summer, I was building
every release of git on that machine within days, often hours, of
it being tagged, for *nearly 15 years*. If something broke, I'd
fix it, test the build (which could take hours if I had to
iterate), and submit a patch. You can find them in the logs. It
was, fortunately, not that often, which is a testament to git
remaining portable. Thank you all for that.

As I mentioned in my report regarding the SunOS build, I'm
personally ready to abandon that particular use of my time,
though if it's fixed, it'll go back onto my semi-automated build
scripts for git releases, and I'll continue to submit patches as
needed. It's not a CI, and no, I don't have notifications for and
don't build RCs, but it's something.

> It's also reasonably easy to build new versions of Perl with things like
> perlbrew or other toolchain tools, and those are the common suggestion
> that people use when they have a toolchain that's out of date.  I've
> worked at a company which did some very unusual things with Perl
> (specifically compiling it to C for performance) and who I think had at
> one point used the oldest Perl I'm aware of being used at a Perl shop
> (at the time, 5.6) for major development, and I know they're now using a
> modern Perl and wouldn't be affected.  In fact, people doing Perl
> development professionally are overwhelmingly using very modern Perl, so
> the practical implication is that we only need to consider the distro
> Perl here, since everyone will be using something at least that new (or
> will have an easy way to build such a version).

Building a new perl is easy. Telling the system-controlled apache
mod_perl to trust me and use my perl, less easy. (gitweb.perl.)

-Alejandro
