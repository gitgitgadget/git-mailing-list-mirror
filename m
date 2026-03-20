Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43272335571
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992925; cv=none; b=rDw1HwdVQqo/PbRDJg7z+OnakUF7/ycf+UhfxXNW3ZPXZyYoLYb5HMxSdEOdU8NuHUZUfnMxKDbEMmy7Ybv2jYyHgUuBAupyJRMN+Yove3bNanH6H5Sg1nflBuDgIjelOfMk72VB031bjs2hXUNWKtpEtnqT12vjpTsT6LN+iB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992925; c=relaxed/simple;
	bh=2WL7hWRCxZmZeGGRNG6LfCNtnGfYTvWP2yukxQz1Zo0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GIqSKWvE1G93AEvDKsS7UVvPyjK7/aU9PztVmeOPlgE/BOKdwcNKp/tpt8fHcLYBVBHm0Nz65yDRClfG0T9AhHEk6IsJUmQVyY8C7ErfxDc2XSLEXv3lEu6BPNMOeo3RyDBQI2btmhi9DbTait+fredrZna/q14MD1IvDBI218I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=PEI4Nsre; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PEI4Nsre"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773992919; x=1774597719;
	i=johannes.schindelin@gmx.de;
	bh=uRfaB30Cjw9Ton3uaHW+FR7DZdIo9S9xCzWT0yXECAY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PEI4Nsreb8gYtcjwqvRkGxfQ3qgf3AF0+w3yFdpWWvLwKcLlSp3dvPSKV2g8xD/s
	 mpYc8JFLh5KNgxzpLoG8VrMclWS53dvgbtoC+O+qBdUSVKnBFNos4zd0lmX51aXgO
	 /rNJwUz77bZIKkhB0vKpgz+kAuqvY/nsdbSSoT2HiLQOTDV6SR3tvFuP0X8I67izd
	 6dPe12Q4iHmsj+nMNbqEfvAypQHPdzY6VlmECpZu9vjHm2R5vsYH0+ZFJuHXIPCD8
	 W5hJ5xPwKGIPkZsLTg2UmnOF++aoapm+VBDuplY8tAvT8NJjBXGMB6ZFTAmgkIR66
	 aUUSAoMVe+T5mqCzaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1w4JXh3bIh-009lii; Fri, 20
 Mar 2026 08:48:38 +0100
Date: Fri, 20 Mar 2026 08:48:36 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] regex: not all macOS platforms seem to have
 REG_ENHANCED
In-Reply-To: <3b0be017-2e6c-d1c8-0ed8-88ec4fa66e38@gmx.de>
Message-ID: <f08f7097-fea8-6dc6-ef49-da0bd5ea3c01@gmx.de>
References: <xmqq8qbnigxp.fsf@gitster.g> <6cd35848-a234-40dc-bb87-4c2cb7eff52c@web.de> <xmqqv7ergud0.fsf@gitster.g> <3b0be017-2e6c-d1c8-0ed8-88ec4fa66e38@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-353865510-1773992918=:30610"
X-Provags-ID: V03:K1:C0tHYNqPHzb0kB5pEDvS6hDCftEA7b1Nh9O+BCHw6DHRkmJCrwt
 3nkCO7N1A1sGlHL5Wq4jyIxCBCRd27WGxY1AjI3eHlK/ppXFiwBlmWmbPm86qK9k5G63Jy0
 +rfix2d0yYxnkIxC0UIt4myCQM/EYDCqVPqVYbaeKDXKZbBTACMCU8WBelsh7rK/5cSY17x
 Z1N2j/C0DZj9/9nOAJ9Yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HkGnz/6ewog=;lGmWQtOMITFPs0pvpoqJtmefyW/
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-353865510-1773992918=:30610
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 20 Mar 2026, Johannes Schindelin wrote:

> On Fri, 20 Mar 2026, Junio C Hamano wrote:
>=20
> > Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
> >=20
> > > On 3/19/26 11:37 PM, Junio C Hamano wrote:
> > >> Earlier, 54463d32 (use enhanced basic regular expressions on macOS,
> > >> 2023-01-08) started to use the REG_ENHANCED option when ERE is not
> > >> in use on macOS.  The build seems to have started failing on
> > >> macos-14 CI jobs at GitHub, however, as apparently not all the macO=
S
> > >> platforms have this flag defined.
> > >
> [...] my money is on a clang update in Homebrew disabling support for
> `REG_ENHANCED`. But why is `osx-meson` not affected, it uses `clang`?
> Well, there's special handling for that in `meson.build`:
> https://gitlab.com/git-scm/git/-/blob/v2.53.0/meson.build#L1347-1350
>=20
>   if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') !=
=3D ''
>     libgit_c_args +=3D '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
>     libgit_sources +=3D 'compat/regcomp_enhanced.c'
>   endif

And it looks indeed as if the `osx-meson` job picks up a difference and
works around it. Last week, it detected `REG_ENHANCED`:
https://github.com/git-for-windows/git/actions/runs/22920658960/job/665178=
62315#step:4:168

>  Fetching value of define "REG_ENHANCED" : 0400

This week, it detects the absence:
https://github.com/git-for-windows/git/actions/runs/23325790048/job/678465=
94275#step:4:173

> Fetching value of define "REG_ENHANCED" : (undefined)

So there you have it. One week, the `regex.h` headers defined
`REG_ENHANCED`, the next week, they didn't.

Ciao,
Johannes

--8323328-353865510-1773992918=:30610--
