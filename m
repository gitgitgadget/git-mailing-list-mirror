Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235B20B814
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525718; cv=none; b=nDBIGi8gLMMqRBbBG/rWksj3iDIAfN9recf9aLcUT1iVXOgWjbIFUT165V9TtH2u7cDcNQZRP85Erv00mlzwI9A/ESgU6y6OW84EFU3ONaIpWNYK3dJmB8fiY3GvjTG02ofd7lGVWn0AdQBQWcrd87Dz5YrHfnOgH8rhMWMvyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525718; c=relaxed/simple;
	bh=zdu42MbOUmmGftT2B9UsvooXNchPVmO5OSSudIjIXks=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VFsvRvgD4lT/vX0V/YhGp1POeUh5x++mhTzzU1XHe6pRM/Gqd6ZGHHW7V3ZfJxabuZz3wsSfXq5JgBL+ux920jifDXAlABPHBzHDEXaBneIkqrZjhnxBc9r4vZ6AYis43pJ/3TLNMOE90A37vu57WzC3rQlvCfRJ7vV+Aa0lPgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fIqtnguU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fIqtnguU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743525704; x=1744130504;
	i=johannes.schindelin@gmx.de;
	bh=m8vXbENFQIaoWvqHdtAsl/iR7J7z+3urAX10XDjuJfs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fIqtnguU6VgmYt2wslOnv0vpwXvfm7SARfi+jzCUOFIOEDdX+iS7HTTJIOj3mtaQ
	 pkWZGDmMVWUukkK9HAO0OtVWOzZAWPMk+EfEaUWTq0Ud6gCbjymuXfsZiyuB8jwT+
	 5TPJ4WIUT0uUuWfvl8soaEAGGiWne2lcEBYqcrPXZWSiLNuZGdP02jI2Dsvbko0G6
	 Fnti+J1R5cmzWs7rHgWmUKcQHS44JhmbrIlXv3R9vgynqx6OJOJUjVB3hp//miRzc
	 H00jGpXaebq6Qq22QoAlFNBC9qBdipjA6a4mGrgX9NKttbE3Y38xVc5z3Rdg7kFbf
	 AXueeTDNodPiJ8ak/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1tIeV90d8N-00baNK; Tue, 01
 Apr 2025 18:41:44 +0200
Date: Tue, 1 Apr 2025 18:41:43 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Sam James <sam@gentoo.org>, Eli Schwartz <eschwartz@gentoo.org>, 
    Thorsten Glaser <tg@debian.org>, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH v2 0/5] Collection of build fixes
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
Message-ID: <66b9d3d1-9874-8dfd-9de9-5682a7b6655d@gmx.de>
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im> <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T5wT7j6R387DioEazbTlh5eSvq4QGjf7AH5iYGR/8pI11UPxPEV
 wLZV+7qTvACnRs2EjUb77784CmOpw3MOs53YVazOi5cDtVAqqW5gIa+CvyfqKPO+4Z8ytGL
 M/VeSrQLGO5VXJk11I+Hx/e0fLgo6pjS8WJWqhTlxr3jyUGmUczkmpmls4abmfhIWajZkBM
 7SpnAK/4p52O3TS82466A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tsTGgESDIKk=;uvxLVgu16Zl8Vlk6ldy0Ijg8JHC
 UGeDLikPv0+qR1+wa/Mnooui79jm2TlwxMCCp/00rk6vW8bCh9zKJxJGIlu52pWPWfjOz4lOq
 eZPkjQPaTgqYgEJKRlaYjJQGEXBHkzv5pKtY1hZShXePgvZqKCGIXuInJDsxdp2DHHDQ0iIN1
 kE4UWzbC+G67q4/h9j9Ufy6t2pZK98VnHBf+BV/HmeaplnMFRSmQfMBnJ1LB5OMd+GzdvOnMk
 xkM5fOMY+/yT3c3heyd3RlE9ADHosWDhBBYI2nb6Mfhu/BeivLYYQmJ6vsG9hG8mExPE3mtk3
 Qu5DCxv9YpEKU98YXkm8+11fYLSnl2hqmey+oHU3ny10uB6qTmCHz91mffxNFFVRL3/POgW9g
 yIw42bEcxUIEWG4OVVrW2iRgGsfW9qy5bt9/4Qp7JDyON4blejOHI5MMBKBTe3bIoPg8xY6nF
 JsR9JO9Zsg0omc6fIns1HbwlMkTFRaQTQ5d3dCmuczggb/vZkTqhhbrgHqlmiYk74LdHZaHuV
 HtSHN/cTmzsZplNi2Kzt+Ihmf023fM6DJ7790q+eUisZWQc4xPTsBhu5KBDsvM+BYpJJdsnoM
 +ihQ1nvZG4i6LdjlqGWJwK48j7DrDDcQM4vAa7wkuoccKrZRXWZOY43RJhuUeyOgvTsV59rFP
 vBbYrvYA0gQtUAn/odEV3U8Bk3Z8GaGroGcN766o0rSMZEw9V03ytxFqBra7WmhpOPrLqBrGP
 qiURbDKgbJAKCfCuW2xjo45/f5veOZMbpQUsyTN/+HXwBzMWileFZPyFwLh0KptonplF0fL9x
 0413DHZcKRrUNVixvbjDcVH9qgL+fz3+/PXZq2iN4FOT+Z0iHDgm4xh840UGaFIIQrlDwZanv
 IGSYG2jhUhvfa8IEKmLTib1x+83Fij+VC5uy7Q5VChzPS0Ox4Mw4qjy5UtvFofRPeVLB1m4Up
 tQRSohNPSxr9vdcTMtdBhd7f3QixfIu0r+MpLaxabyed9l2gEIlYT1VwJzA/vmWb5zGNFNZjH
 42b1IvkabqaF5zvwHm/UgaVLdGhmmUfMDH2IEtrdlGzNxC/XWBx54PWrpRaeT0Sf1DH52BZYe
 K/7FgcLSHA6xeWkwzIeWxE6iHb2F2b7y5mgNHRNsVzDhiqPgqQg365qCJncZOXF8ic0V8EBpk
 G2OnXSJkylj8epBT+L7xXx5E93SDx4CLvbuDdUJjwVeWDsdZyH/iQC/Y6ug5u7eO1WIPzBZ08
 Eag1qC0xikgvHUOkVqMQ0QTfamwSYo3MRjUfFPGBSyzO2UqUtsRTfmm5m++UwniNswarOn5iP
 6g0WYfzAMCBwf0Mh7RUZmD0dhtsc/yqXwWrtFnyXwgUEE4eGHIp86uaKfwI9Rp74Pwi+k9PXg
 n3jK9ZzIU7NRcYiBm9WdOFV/i3rl4lOh5XiHL/VPkR36bIbBdebkfu4JRZ/TbVwf4ASBhPEr6
 GGrOPL2IKiDACXUtAwIen6jU7s0OZqfA6QYQPLV8sHnIxXGYH
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 31 Mar 2025, Patrick Steinhardt wrote:

> this small patch series collects various different smallish fixes for
> issues with the build systems. The intent here is to bundle all of them
> into a single series to make it a bit easier for Junio to keep track of
> them.
>
> More specifically, this series:
>
>   - Fixes an issue with handling "-Dcurl=3Dauto" that I spotted recently=
.
>
>   - Replaces Sam's "sj/meson-test-environ-fix" [1] with an alternative
>     solution. The branch is currently in "seen".
>
>   - Picks up and massages Thorsten's patch from [2] to fix generation of
>     "gitweb.js". The fix has not yet been picked up by Junio.
>
>   - Picks up a cross-compilation fix for Meson [3]. There has been a bit
>     of discussion with Peter whether this is the proper fix, but based
>     on Eli's feedback it should be okay. I'm still open for alternative
>     implementations in case anybody has suggestions for how to do them.

These all look good to me (with the exception of the cross-compilation
fix, but only because I am too unfamiliar with Meson to speak about the
correctness of this patch).

>
> Please let me know if any of you are unhappy with the way I have given
> credit. I'm totally happy to change authorship or adjust trailers.
>
> Changes in v2:
>   - Drop the fix for Perl-less documentation builds.
>   - Pick up the fix to use correct environment in our CI builds.
>     Johannes mentioned that he wants to eventually get rid of those
>     builds completely, but meanwhile this is a trivial change to make
>     the jobs do what they should.

More precisely, since we are now spending around 9.5 hours of total CPU
time for every single CI build (completely running over the concurrency
limit of 20 parallel jobs on GitHub even for a single CI run, with the
obvious congestion when there are parallel CI runs), I want to drop all
pretense that Git supports CMake builds on Windows (or Visual Studio
builds, for that matter). It's just too much of an uphill battle and I no
longer have the will to deal with it.

Thank you for reminding me that I wanted to work on that patch.

Ciao,
Johannes

>   - Pick up the improvement for cross-compiling Git.
>   - Link to v1: https://lore.kernel.org/r/20250328-b4-pks-collect-build-=
fixes-v1-0-ead9deda3fbc@pks.im
>
> Thanks!
>
> Patrick
>
> [1]: <310a34bace801d288e369c6a01a8d04ffc4c3c06.1741975367.git.sam@gentoo=
.org>
> [2]: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>
> [3]: <20250303-pks-meson-cross-compiling-v1-1-73002ef6432e@pks.im>
>
> ---
> Patrick Steinhardt (5):
>       meson: fix handling of '-Dcurl=3Dauto'
>       gitweb: fix generation of "gitweb.js"
>       meson: respect 'tests' build option in contrib
>       meson: distinguish build and target host binaries
>       ci: use Visual Studio for win+meson job on GitHub Workflows
>
>  .github/workflows/main.yml           |  2 +-
>  .gitlab-ci.yml                       |  2 +-
>  Documentation/meson.build            | 12 +++----
>  contrib/credential/netrc/meson.build | 22 ++++++------
>  contrib/subtree/meson.build          | 20 ++++++-----
>  gitweb/Makefile                      |  2 +-
>  gitweb/meson.build                   |  2 +-
>  meson.build                          | 68 +++++++++++++++++++++++++++--=
-------
>  templates/meson.build                |  4 +--
>  9 files changed, 87 insertions(+), 47 deletions(-)
>
> Range-diff versus v1:
>
> 1:  4bc8060a975 =3D 1:  3e9137c2d18 meson: fix handling of '-Dcurl=3Daut=
o'
> 2:  4365cfc4a4e =3D 2:  7ba983d446e gitweb: fix generation of "gitweb.js=
"
> 3:  02d6ae13dd2 < -:  ----------- meson: require Perl when building docs
> 4:  fcf2478bd82 =3D 3:  33cd3e490eb meson: respect 'tests' build option =
in contrib
> -:  ----------- > 4:  1cb210c91a1 meson: distinguish build and target ho=
st binaries
> -:  ----------- > 5:  3172db10a10 ci: use Visual Studio for win+meson jo=
b on GitHub Workflows
>
> ---
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> change-id: 20250328-b4-pks-collect-build-fixes-b5a6ce086b72
>
>
>
