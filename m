Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEBD2E6CB3
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992074; cv=none; b=tzthujmkW6j7bDpjOUwg9T7jj/9sjs5U2wqer/G2Ty+OMzPfzZF0wRDF9UCeEknVujte8OKLde7QUIkMUMFLXYIwVlS1hFnf9GA9oBw+sOAovOzv0Hcd9Js30Yh6t1gZVIV7I+LAd+q19vS1/VjS3v5akqUX64UjOMPRTetoc2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992074; c=relaxed/simple;
	bh=c0KZlP2yYCCqRoWdh+reyAAvnC4+7SkYITndpdojjAQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jT4fl4p2kuzVZ8BmaGmqwcwqbaW7m8Lx1hChh/vLFPWzhEG4iGMaVW0Y+/KjWkcGp2UgPorKi4N/ZdFE6mb1NSckA8kByx6ufiHj2l64mS0qk4fOJldC76Z1HhYSVxBNz2snKFfnJG7gL0+8Vf6ujcjIXKZDjqLpmcbxp5y38vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=p35DxA+2; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="p35DxA+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773992070; x=1774596870;
	i=johannes.schindelin@gmx.de;
	bh=SqyR8Tr/rf9X+G5XnLtg4QHU9/kiK+O7za29ccyQT3Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p35DxA+2W/5stnCmdXiyKebemPdX3gxqsVK8vg99Fi9nZDsaHJ4rf5MNBrtsF6K9
	 hrNEJSpHLImnZrevsaP+AIU8JuINlOhOCwPm/m0YrXDka4SCz2CPoLR2aj8I1zOxz
	 aY21/n864c/g3B5AAg4n0iHLoQCbilMcJXE2PJLp52SuuKE/z5gm0umTv6vEEI2X2
	 Q/juno0YI/HlCiLRaAmdOEarRYzHs5eimtc5U7pe/xOPb+UDNXEW/MHrUyTqKe1AC
	 zDSGasbGKjeMCvB2+t0tWhV677BRYOH81IAyuUxfSsFISFy7YkcmJJpzpruNaNBLH
	 KZ6J/G0VOv8CK/nnkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5eR-1wKCRf0Pen-00RzEV; Fri, 20
 Mar 2026 08:34:30 +0100
Date: Fri, 20 Mar 2026 08:34:27 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] regex: not all macOS platforms seem to have
 REG_ENHANCED
In-Reply-To: <xmqqv7ergud0.fsf@gitster.g>
Message-ID: <3b0be017-2e6c-d1c8-0ed8-88ec4fa66e38@gmx.de>
References: <xmqq8qbnigxp.fsf@gitster.g> <6cd35848-a234-40dc-bb87-4c2cb7eff52c@web.de> <xmqqv7ergud0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1689328199-1773992069=:30610"
X-Provags-ID: V03:K1:k6vZwNTnA7H5Rkp98qNCFCN9hK64d8V2Udy9jzSMt+ydKlfd2c3
 vNPwHGy/NYrZ6w2bP/hFGopjfDhNSUejCJUU4WnAzhKXGkV9iwuchBaGl1rUKJac6ApuzVW
 fSOPzng2LkGCYlif398MuO8Vs7yEztmzkBVny9IBUl+HWHcw0zrCgPoeB2hYn0OL6O6XjF+
 sEa9SSivMKP8P8QwittfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oGFpo3g8CIA=;7TvBC2BrUwE2D4v07FiJW5yBS7F
 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
 MC9WNdgo3mztzqpWi1fyX1cQ==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1689328199-1773992069=:30610
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 20 Mar 2026, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > On 3/19/26 11:37 PM, Junio C Hamano wrote:
> >> Earlier, 54463d32 (use enhanced basic regular expressions on macOS,
> >> 2023-01-08) started to use the REG_ENHANCED option when ERE is not
> >> in use on macOS.  The build seems to have started failing on
> >> macos-14 CI jobs at GitHub, however, as apparently not all the macOS
> >> platforms have this flag defined.
> >
> > Interesting.  https://en.wikipedia.org/wiki/MacOS_version_history says
> > macOS 14 (Sonoma) was released 2023-09-26, i.e. more than eight months
> > after the patch.  And the oldest regex(3) man page I could find also
> > mentions REG_ENHANCED:
> >
> > https://man.freebsd.org/cgi/man.cgi?query=3Dregex&apropos=3D0&sektion=
=3D0&manpath=3DmacOS+10.12.0&format=3Dhtml
>=20
> Well, I have no idea where this breakage came from; it suddenly
> started in today's pushout, and I do not think we have made any
> changes on our end to cause it.
>=20
> E.g.,
> https://github.com/git/git/actions/runs/23315793655/job/67814861386#step=
:4:301
>=20
> In any case, in the same CI run, a few other jobs on osx- that uses
> the same macos-14 image seem to be passing, so I am reasonably sure
> that the posted patch is a *bad* idea.  Instead of forcing us to
> figure out why REG_ENHANCED is missing, it would just hide the
> problem under the rug, possibly breaking a random regex tests that
> happen to depend on the "enhanced mode" working. X-<.

I also hit this in Git for Windows' "ever-green" branches:
https://github.com/git-for-windows/git/actions/runs/23325790048/attempts/1

THe curious thing is that it only hits `osx-clang` and `osx-reftable`, but
not `osx-gcc` nor `osx-meson`.

The breakage coincides with a runner image version bump: if you expand the
"Set up job" step, and within that step also expand the "Runner Image"
group, you will see that the succeeding (older) jobs use 20260302.0147.1,
the failing (newer) jobs use 20260317.0174.1. The change that strikes me
as most likely to be the culprit is the Homebrew bump 5.0.15 -> 5.1.0:
  https://github.com/actions/runner-images/compare/macos-14-arm64/20260302=
.0147..macos-14-arm64/20260317.0174#diff-5c04a529d3c8adf7a5f23afe544071dad=
1853e281c9c7b44cd8d626b6c57444dL35-R35

Now, 3 of the 4 `osx-*` jobs use `clang`, only `osx-gcc` uses `gcc`. So my
money is on a clang update in Homebrew disabling support for
`REG_ENHANCED`. But why is `osx-meson` not affected, it uses `clang`?
Well, there's special handling for that in `meson.build`:
https://gitlab.com/git-scm/git/-/blob/v2.53.0/meson.build#L1347-1350

  if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') !=
=3D ''
    libgit_c_args +=3D '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
    libgit_sources +=3D 'compat/regcomp_enhanced.c'
  endif

I'll continue looking along these lines.

Ciao,
Johannes

--8323328-1689328199-1773992069=:30610--
