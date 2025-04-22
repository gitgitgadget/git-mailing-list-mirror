Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9118A6AB
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309838; cv=none; b=HS0dChOPTecwJdhsykG1a8z03Mp09iqhj3zuIdgxA8aPZteZhCnYazG7Q/rrhC6QGY5gi92WVFnQHWZYcci7tbZc1jexhllewPkLlpP6qyaVmY5jdIxA1qUyPYoCwyBhz/TpUeUNOeLVsR2HfVO/P646JOBirs3vtRvfKI1lyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309838; c=relaxed/simple;
	bh=JYNMSR249WnQzb6RCRQhPhdxC09g5Q8nYrNqLNTMeGA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u8e4v150YX+ZAkRk0m44A/m5gzmbWmI28SjGp7lt247wTbJVmSYIuQuxSYDPi+a3ObkJd9dov0hf3A/nTKSiXmYWcW6sgXjxuu8qZ2evwNUiU6I8q19+0z8Fo602peVcXyWLzrXe7m02dtiC1e1zeQvp6RuougZFx0HEwv7ZAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZEh4OldR; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZEh4OldR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745309830; x=1745914630;
	i=johannes.schindelin@gmx.de;
	bh=jGEhRJGUkXJzM9qE5gft36TtRKghI/8Eco0o3JsGj4Q=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZEh4OldRnPd3LIhvjFpcTjfeMlSF82Njsq898n8S8lqcQpbiHjmDjK6GWNSTP0f5
	 +1UGQbMir+w1e22Fc7TjkM0ONFMYqVUpICYzJZnYOcs80p7lLEbO9fDMf8mFlHqI/
	 jbe48I1DKhJaxscitrYSKYGgRmPdbPd1kYsJmnvQvp9hTb2YL0gW09V1qOenudF81
	 jxvYYT7NkQDvf4y3KlnVotjhXD0SPLwvHvUp6tdev0zgF7bNUoXcNPvTMFkgetBkw
	 z6Ax7rRkPg69Z5HQ9i1iSKPhL2FXlR0w5r/qkD87EGdBDic1j/jHQ0YZai3PwSS5y
	 7UAjTJ2PuIsfLeUYsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.53]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1uFhXL05Kr-00791r; Tue, 22
 Apr 2025 10:17:10 +0200
Date: Tue, 22 Apr 2025 10:17:09 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Dropping nedmalloc support? was Re: [PATCH 3/6] mingw: do not use
 nedmalloc on Windows/ARM64
In-Reply-To: <aAdIlq8Np8LpahLS@pks.im>
Message-ID: <00fd3145-b3d2-ddab-466d-d06fd27298ec@gmx.de>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com> <6c2e17eca68b143eff7b33d195bc66a486471547.1745239150.git.gitgitgadget@gmail.com> <aAdIlq8Np8LpahLS@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G/3PuMemEAW4syCzNKlyky1y4wxtm2FPZfgG5CWlxedT1TdvW8S
 WlYFpAsQyVEsY0iMIqaO7ZjAV9NbvWSXXrQj1kPS2j/6D+ASwvdbb4P8DwjaPVYApC0iApE
 udqpV5ZlOcBIDSEqQPkcIizpeNM86d3qtKHqgwW+vMktPNciX9Fpnvq+HtvivZFCk1o8/Yy
 PUfPvi/9RJ8DKkZQxZktg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hh1qGgO1JJg=;z94EqeHCAJDYwrK+MgApYUQXRXi
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 22 Apr 2025, Patrick Steinhardt wrote:

> On Mon, Apr 21, 2025 at 12:39:07PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > It does not compile there, and seeing as nedmalloc has been pretty muc=
h
> > unmaintained since at least November 2017, as per
> > https://github.com/ned14/nedmalloc/issues/20#issuecomment-343432314,
> > there is also no hope that any fixes will materialize there.
>=20
> This kind of raises the question whether we want to keep on maintaining
> nedmalloc in our codebase at all. Is there any strong reason to have it?

To the contrary, There is a very strong reason to drop it: nedmalloc is
unmaintained.

There is just a teeny tiny blocker before it can be dropped, though:

$ git grep -n USE_NED_ALLOCATOR upstream/master -- ':(exclude)Makefile'
upstream/master:config.mak.uname:478:   # USE_NED_ALLOCATOR =3D YesPlease
upstream/master:config.mak.uname:741:   USE_NED_ALLOCATOR =3D YesPlease
upstream/master:contrib/buildsystems/CMakeLists.txt:258:                  =
              USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_W=
IN32_MMAP

The commented-out one is the MSVC build (I had experimental Git for
Windows patches to enable nedmalloc even in MSVC builds, which I abandoned
in favor of https://github.com/git-for-windows/git/pull/4580 to enable
mimalloc in MSVC builds, but I abandoned that effort, too, because Git
decided to favor Meson over first-class MSVC support and I decided to
focus on avoiding to have my time wasted by the Git project).

As you are quite aware (because it caused plenty of trouble with your
reftable patch series), Git for Windows switched to mimalloc quite a while
ago (https://github.com/microsoft/mimalloc).

When I switched Git for Windows to mimalloc, I did (re-)run a couple of
performance tests to see whether having a custom allocator is still
necessary, and from my (unfortunately too vague) recollection, Windows
11's default allocator seems to have performed quite well in comparison.
Which is in stark contrast to the results of the performance tests I ran
when originally integrating nedmalloc. So: In theory, Git for Windows
could drop building with a custom allocator, iff it wasn't for older
Windows version that are still supported.

Which means that I would like to upstream the vendored-in mimalloc first,
with the patch to use it when building on Windows by default, before
dropping nedmalloc from Git's source code.

Ciao,
Johannes
