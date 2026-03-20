Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79F374E67
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996921; cv=none; b=JZG+Zrybpyan5BmHuo7jdDQAJfdkBQD5qklCf0IFD+ukwFv/mfDHlMLXfAtrKxBUS29plZx+SqMTMBsFucw+CcTFpu4L2+ucGA+i1Gw1OVE3sN1oBcFBmPTY0mJr+IBG/Eq9H8KozJjIxhg/jSvakhsB5YZ2ahp1vJj4OxXRn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996921; c=relaxed/simple;
	bh=iW1iRYTola73tyactY4B1S00BD2jdbYh7xIgupLDC0w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hZE0mAHQ47zRlK1AdR5/xa/4er2WXwHbMSs632LxNEYGh4qjztYr6eVmNOxnvJ+WJKhhPsTInOejmVvkLjVqVJXIT2LZtvu7tFbjZUsxi9bVn7FP7Rs6pTWAMvHE8wcDEXE9oZ+6h6gML/uO8lpLKhAT+uszf/MLeeV9CH2Xv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=QLg3MLx8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="QLg3MLx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773996917; x=1774601717;
	i=johannes.schindelin@gmx.de;
	bh=IsXPM8A/ZtY+zs5xDBKxtwfJ+ZXVrXU4/YkY2tznonk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QLg3MLx82JbcQDfm3X+E9W7Y0eyg5TINt0NUDI2TStVbwqIn5kSNgvv3KdOCL4jo
	 pJ/bSkQqsrQj0u/9yuIecCYfYN/m2oOb3FgdtlVdzJhhXubFAXeWm2hj/kS3FL4fQ
	 KpxKc6gqxd/vB7kjOMw5bMBG0dCww719oTJVd6JqVCspSz+NK0E1iZTJmxuN5PLvg
	 k0o+G+YuFgmH2ORSTG3FQJfJeN6Z7uyrwAtDIac12sjqfKuB7a/ICQZuFEU6nABIo
	 VkmOhOzUZHRrVscfrCnGgqv8PmAMOmG9LVjg/waA5TYCDrHgpXSNWFcjYY4BfLN0z
	 Dt7jm+OLbgxPKJIWww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1vaayp1kTu-00ul6I; Fri, 20
 Mar 2026 09:55:17 +0100
Date: Fri, 20 Mar 2026 09:55:15 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] regex: not all macOS platforms seem to have
 REG_ENHANCED
In-Reply-To: <77b6ec9f-46a5-1f38-9733-188e20da55ec@gmx.de>
Message-ID: <d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de>
References: <xmqq8qbnigxp.fsf@gitster.g> <6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de> <77b6ec9f-46a5-1f38-9733-188e20da55ec@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G7bF4MtWYK7brgZ6qn1xCd7HHqkzwzbd4I6PntoMGxdv1WWuKge
 icp0GgriWHdP1DKiXRZ0NAU0X659/2hpegZqT+tokAtPIS3JACS7w7AfomOtcYWV5pOXfNc
 XQmN9vJmMbeDlSNvVBPGcoZH9b7VKzBTaK10DbkzTV7mqWGkvlpXwye3v+HybPcRoFJXPcm
 m9TUUnNER+TrbLmdBU7/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dtDO5QoS6ak=;BFiyB2lvqBTPFCgZHNRrr0YSiKo
 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
 MSOCBB6kcFg
Content-Transfer-Encoding: quoted-printable

Me again, sorry,

On Fri, 20 Mar 2026, Johannes Schindelin wrote:

> On Fri, 20 Mar 2026, Johannes Schindelin wrote:
>=20
> > On Fri, 20 Mar 2026, Junio C Hamano wrote:
> >=20
> > > The build seems to have started failing on macos-14 CI jobs at
> > > GitHub, however, as apparently not all the macOS platforms have this
> > > flag defined.
>=20
> [... I need to ...] recommend something like this in the `Darwin` clause
> in `config.mak.uname`:
>=20
> -- snipsnap --
> diff --git a/config.mak.uname b/config.mak.uname
> index f9ffefa67a4f..572f8967bc36 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -172,6 +172,10 @@ ifeq ($(uname_S),Darwin)
>  		NEEDS_GOOD_LIBICONV =3D UnfortunatelyYes
>          endif
> =20
> +	ifeq ($(CC),clang)
> +		NO_REGEX =3D HomebrewsClangSeemsToBeMissingEnhancedRegexSupportAsOfMa=
rch2026
> +	endif
> +
>  	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
>  	# Unix domain sockets and PThreads.
>          ifndef NO_PTHREADS

Turns out that my analysis was not _quite_ complete yet. With Claude Opus'
assistance, I was able to find the exact turn of events that led to the CI
failure. Here is my proposal for an alternative to your patch, Junio (the
https://github.com/git-for-windows/git/actions/runs/23335584918 shows that
the build completed successfully this time; the tests are still running as
of time of writing, of course):

=2D- snipsnap --
=46rom f65b3b657c36e9132624ea223c90047527edea59 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 20 Mar 2026 09:09:10 +0100
Subject: [PATCH] osx-clang: work around Homebrew's clang lacking REG_ENHAN=
CED

The `osx-clang` and `osx-reftable` CI jobs on macOS started failing
with:

    compat/regcomp_enhanced.c:7:13: error: use of undeclared identifier
    'REG_ENHANCED'

The failure coincides with the GitHub Actions `macos-14-arm64` runner
image being updated from `20260302.0147` to `20260317.0174`.  The key
change in that image update is the Homebrew version bump from 5.0.15 to
5.1.0.

Homebrew 5.1.0 introduced automatic linking for versioned keg-only
formulae when the unversioned sibling is absent (see
https://github.com/Homebrew/brew/pull/21676, announced at
https://brew.sh/2026/03/10/homebrew-5.1.0/).  The runner image installs
`llvm@15` (keg-only) but not unversioned `llvm`.  Under Homebrew 5.0.x
that formula stayed in its keg and its `clang` binary only lived at
`$(brew --prefix llvm@15)/bin/clang`.  Under 5.1.0, because unversioned
`llvm` is absent, `llvm@15` is now auto-linked into
`/opt/homebrew/bin/`, which sits earlier in PATH than `/usr/bin`.

The net effect is that `CC=3Dclang` in CI now silently resolves to
Homebrew's LLVM 15.0.7 clang instead of Apple's system clang (Apple
clang 15.0.0, bundled with Xcode 15.4).  The runner image README
confirms this: the reported "Clang/LLVM" version flipped from 15.0.0 to
15.0.7 between image releases, matching the Homebrew LLVM version
exactly.

Homebrew's LLVM clang uses different include paths from Apple's clang.
In particular, the `regex.h` it sees does not define `REG_ENHANCED`,
which is an Apple-specific extension present in the macOS SDK headers
since at least macOS 10.12.  The Makefile unconditionally sets
`USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS` for all Darwin builds via
`config.mak.uname`, which pulls in `compat/regcomp_enhanced.c`, which
references `REG_ENHANCED`, hence the build failure.

The `osx-gcc` job (CC=3Dgcc-13) is unaffected because Homebrew GCC is
configured to use Apple's SDK sysroot, so it still picks up Apple's
`regex.h` which defines `REG_ENHANCED`.  The `osx-meson` job is
unaffected because Meson does a compile-time test for `REG_ENHANCED`
(via `compiler.get_define`) and simply skips the feature when it is
absent.

Work around this by setting `NO_REGEX` when `CC=3Dclang` on Darwin, which
makes the build use Git's bundled regex implementation instead of the
system one.  This sidesteps the missing `REG_ENHANCED` define entirely.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 config.mak.uname | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index e6efd0f30913..c437accbcc50 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -162,6 +162,17 @@ ifeq ($(uname_S),Darwin)
 		NEEDS_GOOD_LIBICONV =3D UnfortunatelyYes
         endif
=20
+	# Homebrew's LLVM clang ships a regex.h that lacks REG_ENHANCED,
+	# which is needed for USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS above.
+	# Use our bundled regex instead.  This became a practical problem
+	# when Homebrew 5.1.0 started auto-linking versioned keg-only
+	# formulae (like llvm@15) into $(HOMEBREW_PREFIX)/bin/, causing
+	# CC=3Dclang in CI to silently pick up Homebrew's clang instead of
+	# Apple's /usr/bin/clang.
+	ifeq ($(CC),clang)
+		NO_REGEX =3D HomebrewsClangUsesARegexThatLacksREG_ENHANCED
+	endif
+
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
 	# Unix domain sockets and PThreads.
         ifndef NO_PTHREADS
=2D-=20
2.52.0.windows.1.12.g00d4f5e7d9c

