Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF13603CF
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019548; cv=none; b=LYR8B8yqSedJlEApv9ln8bBSXoBnBbUQEo/SCIZ3XKjJASXcMsOy3n7YDSe/a9UGCygLUiG1Rk8nOdjzOPqgs4kNufTvm13mS3cPWqhjyqHN5JusC0WMH/UHG77sORPCKGS9Jr1dt7MvJ4jdxQEXg+exb0sYuI1wEE3zbxq9EVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019548; c=relaxed/simple;
	bh=kKVDCKn/98gM9SOp8V6ZFm/2pZn5IXfy/dH3DwoQj2U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oXaRdY4ExmLcSwByqOBPm4U5VwM66pHHcwX3r3TfHwmA4OEr1R8gpHF+OvDHci++e2qvXWeQqrwt7u5AYGOMAfQLD9zDk4bdQHG6gVAusKyGub+PEhDeCFSNc8c6eXMH9yaheVogblBVK883iuFgk7ERzPbG42HsREW1S5qg0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=R8WclXKH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="R8WclXKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774019544; x=1774624344;
	i=johannes.schindelin@gmx.de;
	bh=URpGuHS+FiMEgVW5BwfycLu8HqI2yk622qvMqKzb1kE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R8WclXKHaBw/c845eLzfq9uQjOELqhguUaaPCaQjt3wEtpRuzXHcBbEE43zouAkn
	 dHrtHdSbHHoOTCizanpv1QQH/VmaAWb9lmWhckWRC/RpJ6I9tGxdpQMReQcFhcsgc
	 vv50agCz+/kuYSiqDojUZ/r4WRtz/AHwtcWVXPNYf+2A3IZxGHDwjZsUFNBHGnZM1
	 KkMo05qNic/pNJHnAtv0TNdjNAxGiDpcIELODCpK/DZAoGUTP2WtN69CMOFZJJEoc
	 vSshXiiy8vmkcnVZUnxrSokE2GM4ZcAE8fXo0LamzN/A4p5fHkvBBm8ZVYdCKas4B
	 BbT1Jtukz6OgSCnVig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1vjKmX3BmQ-017qhY; Fri, 20
 Mar 2026 16:12:23 +0100
Date: Fri, 20 Mar 2026 16:12:20 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] regex: not all macOS platforms seem to have
 REG_ENHANCED
In-Reply-To: <5b8e24c2-452c-486e-a143-386e06a75e03@web.de>
Message-ID: <58f3c772-6d38-0807-29c5-75e26c229c1d@gmx.de>
References: <xmqq8qbnigxp.fsf@gitster.g> <6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de> <77b6ec9f-46a5-1f38-9733-188e20da55ec@gmx.de> <d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de> <5b8e24c2-452c-486e-a143-386e06a75e03@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-955267593-1774019543=:3024"
X-Provags-ID: V03:K1:E6vqs0GurnhkPsMhjCJuBkA+jCy4omFTJabd4cO8O7koKp1P+6G
 7utAWFT+dL14x1Rpd8IfH7mVKzCnLYttqSD5tdn8yh3Lbu2cf8JQ2LQKsdNLktqDX/RfUIK
 ssKg5cQEzk93hS1cQLaLfmUl9dR59stFDGtY5qK4eVbsIsVNePl7kub/fCyfI7kl5w3vXhS
 U9yi0nd/u/9jhn+mZp7mQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IkYwFsPZs8E=;dyrxVCPnGMgYbw8ks9MMT+V2CPH
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-955267593-1774019543=:3024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Fri, 20 Mar 2026, Ren=C3=A9 Scharfe wrote:

> On 3/20/26 9:55 AM, Johannes Schindelin wrote:
>=20
> > Homebrew's LLVM clang uses different include paths from Apple's clang.
> > In particular, the `regex.h` it sees does not define `REG_ENHANCED`,
> > which is an Apple-specific extension present in the macOS SDK headers
> > since at least macOS 10.12.  The Makefile unconditionally sets
> > `USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS` for all Darwin builds via
> > `config.mak.uname`, which pulls in `compat/regcomp_enhanced.c`, which
> > references `REG_ENHANCED`, hence the build failure.
>=20
> I suspect it uses the same regex.h.  The definition of REG_ENHANCED is
> gated by a __MAC_OS_X_VERSION_MIN_REQUIRED check, though, and that fails
> because __MAC_OS_X_VERSION_MIN_REQUIRED is defined as
> __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__ and that one in turn is not
> defined by the Homebrew version of clang in the runner.

That makes sense! I couldn't investigate this because I do not have a
local macOS setup to test with, and I did not want to abuse GitHub
Actions' runners (nor did I want to spend more of my own time on the
investigation).

> I can't reproduce this locally, by the way.
> /opt/homebrew/Cellar/llvm/22.1.1/bin/clang is not linked to
> /opt/homebrew/bin on my machine and also provides a sensible definition
> of __MAC_OS_X_VERSION_MIN_REQUIRED.

Hmm. I am convinced, though, that if it hits CI, it hits human users as
well. Maybe the difference is that you upgraded from an existing setup
while the runners (I think) are built from scratch every time.

> > The `osx-gcc` job (CC=3Dgcc-13) is unaffected because Homebrew GCC is
> > configured to use Apple's SDK sysroot, so it still picks up Apple's
> > `regex.h` which defines `REG_ENHANCED`.  The `osx-meson` job is
> > unaffected because Meson does a compile-time test for `REG_ENHANCED`
> > (via `compiler.get_define`) and simply skips the feature when it is
> > absent.
> >=20
> > Work around this by setting `NO_REGEX` when `CC=3Dclang` on Darwin, wh=
ich
> > makes the build use Git's bundled regex implementation instead of the
> > system one.  This sidesteps the missing `REG_ENHANCED` define entirely=
.
>=20
> Or how about using /usr/bin/clang explicitly on macOS instead of any old
> clang from $PATH?  That would avoid user-visible changes.

That would fix our CI runs, but it would expose users who set their `CC =
=3D
clang` to the same problem that broke our CI builds...

Ciao,
Johannes

>=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  config.mak.uname | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/config.mak.uname b/config.mak.uname
> > index e6efd0f30913..c437accbcc50 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -162,6 +162,17 @@ ifeq ($(uname_S),Darwin)
> >  		NEEDS_GOOD_LIBICONV =3D UnfortunatelyYes
> >          endif
> > =20
> > +	# Homebrew's LLVM clang ships a regex.h that lacks REG_ENHANCED,
> > +	# which is needed for USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS above.
> > +	# Use our bundled regex instead.  This became a practical problem
> > +	# when Homebrew 5.1.0 started auto-linking versioned keg-only
> > +	# formulae (like llvm@15) into $(HOMEBREW_PREFIX)/bin/, causing
> > +	# CC=3Dclang in CI to silently pick up Homebrew's clang instead of
> > +	# Apple's /usr/bin/clang.
> > +	ifeq ($(CC),clang)
> > +		NO_REGEX =3D HomebrewsClangUsesARegexThatLacksREG_ENHANCED
> > +	endif
> > +
> >  	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both requi=
re
> >  	# Unix domain sockets and PThreads.
> >          ifndef NO_PTHREADS
>=20
>=20
>=20

--8323328-955267593-1774019543=:3024--
