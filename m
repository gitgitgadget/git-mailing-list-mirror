Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D8174EF0
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975431; cv=none; b=k04zo7mkfiIxE0d+XVp12VaeVaRU812G6ktBrTgGMA/ZsbNUNELTThz/ptz6rY/sbEvwbvXM9+akW6KXoHbUR+GHuOjHO/wcQUw+9r99NFXc1g4hsNS3rreuhiyseh9uyG+P0AjcPpiHVWVTzujy5UQQwctQTRdsf/CEVdmJA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975431; c=relaxed/simple;
	bh=9fUXSlnivb8LTfn8bOcas0uZWhn+4j8wFiHySzSwrUw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XvA3btldnULt4+Gszm7Zkd9uKtn+IavnvfeUyIL6q//SIQ4eGA/tGGUBWjvon1YPc2uYzq/yoEwbZ0Y5v8SSNQRN9wPvRbvY8Kj5PIH5FG15iWF3iN/Cu0b3Wvf+eL9dDTu/ZK5d5NXoEnqIQ08KyovEZ7s0GZEZJ6g5H3VIkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=bSqgIDB8; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="bSqgIDB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742975425; x=1743580225;
	i=johannes.schindelin@gmx.de;
	bh=yd4aMaV7JbEnznUfo20Lsr3puirJ7qtdMHO5BfAvL5I=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bSqgIDB8GO/wEasE7dx8EcUncJ4npTQtWCgF+vpI36Em69HNgCI6Fn9270JHoEBX
	 cf9W+TJPvzo5Mq5RtkGeUVd4NHD5tktYwwZY/rW4BDhzQ5F8ddNrypQNpRE3i0YMy
	 cLpyDs9/AnJZMgp1QSMEYZbK/4TelCS1JtrIQlrYnegKr8DbSWCIPQmc4VZxlFTQ8
	 5QLKioxlEUV4VTGX4B78GOuc3/KKAY7fhornLS54JeTfg3s0qvkIN1IV89LBC9ncO
	 WmFY0dXp51Q+J7YjYZeIN01wLMdePNy9ZtusYrigmtH/EKPWO2imM+wirVo6C4/8Q
	 h3KtcKnJpZbecgjk5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mirna-1tTUtY3w7I-00bq0p; Wed, 26
 Mar 2025 08:50:25 +0100
Date: Wed, 26 Mar 2025 08:50:24 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/10] clang: warn when the comma operator is used
In-Reply-To: <Z-OWp0NkjrMVQieH@pks.im>
Message-ID: <9cd9a690-1258-d96d-33c9-53a3b0f346a1@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com> <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com> <91f86c3aba9d19d5df11661675fd6c2cc049e191.1742945534.git.gitgitgadget@gmail.com> <Z-OWp0NkjrMVQieH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Xx1tzzZqRs4DxogcnJGfezJAn86BnYLgKcv8vJSoZgpee1dG89E
 Icb8Hwgwo2ztWVkbBpvshyM4DmjT/3/GVcDgZBBiXSJSaVCex7g1Xrwhe9I59/yLsmW5t9C
 MkqARdC2V7Ib0GRMQS73ZdEeuZQ6Hem4dgpVQrQM3zTEQ08jEDOpSx24dHP3a8VIv2FRbI3
 6rgqlfdHVa/miAmJbNwqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rZWTX9CpGII=;SoLBxC0nAm9NvV7wLnUxfsyhtd+
 G3eBKPsgwcDbmW9Ma8GHjLmWawgBv/yqkZlhE+kAqE/IOuhyyi1MnFc4mtJB+oDj9AawHnF4E
 1Rs0L2lS0HDcWLoHtmxCWohHY5phjDrHwo4uDqva7ZnEahzC5ztEXBuvjoNC8EEUXTQ7uBROv
 IavS2L9NcA5MsLuZD9eEF+HedH6l6tvnriKQ8m80wBXkOVCGsEfzROeowYy1EwD4nu8OrMIbR
 Jnuy8cysH3+wKHHCUsRcp3d1E9cTx1cxAv0iWmgp5JAP997D+lOQLjKX/hietDotH1zut1sa9
 m31EjHTAJrloCn0Mj8RscxkxZHA593YsFDcm3Gk4TbMqivGBRldbgmeASsu98LAHOrTi89/w7
 NTfK50dZz4r3muyXgipWNHpL3IsLwysWZZSruY+sLs9/a05PvxGbOPKSGyvPTdDjdglDVLH4q
 mju8uvHPXFNRtjPGojAlUyd6mDnOGnkm3a7zGXGKA4Y1FBgSLM6E5mO8IsSwQgZaKgZ8FsUom
 ugav6T6TJX+05G/12fdEXT/PVGyoNbTcGYE641jybJVNJgbMiqGhJ+yxf3x3Ex1/wtjZCAxzG
 PlQuLrNbXs7hOEnuovQgHCBFG9qXFDg378zjM+FrAgB804KYDhK+hMqUc3OQKvKf9NKP+43z+
 O69lEHXaiWKPkQOxOpCBAn4y8p97oxOIB1kVUiHDCu5tmisy5gXSOdtqJWe1VkRoqypUnzYv2
 YR8TS9iMxjnj/E76X215jcxQ5B0VKm56HO01aKC/nRSBv/9IZO1dLugiZ1yrLt0P4ueF2DsFF
 Yr3mQOEiJIAVJWa2UYbzjEujT3mpuHGxUBfuMStO2rox4f5Uc5E6vnMhsbYC0RmKL+H2vjIHi
 mvTYSsxXYchM2vRF+8bLma1w6XuUdXgmn54FkwsJTcb/9mmgtJHxDYcpimTFExJGG3K+XzOUN
 K+ZYjbT+4a7htH3Jz72h31Eud9MxxQGyqQNVpGw1m79jxk6D+Tz88ZUkXj18cx5hiu1HSabav
 fsSq/6JqdVv/RtKE9prCwKAY8jyZqv9bo4Mub8Bo9oE4+34cXpfZnkidUg2Nn7KZuMYLql0v3
 Yiu3zQNVYqpcz4hrfv+7w6Z01U8bZyPwAGXngElzCyS5DtTv04ovw3qPr5No6met+G1QVnHT3
 IozMyJl3yTZJMzHYowxnTVRH4zsFlIOMpeJpsnpDpksVvJ6sTx0LbIeRlas8ZJRQmJsbqtjpQ
 4tbxfGmDes5Hx5//E0BOgv/VP4VkTOKvKEwqJB6I4N/Vnq6mvPN+ZgoFczAHWlgly91BO2XJL
 DmXcG0kAg63rhP0nnVyBv/3PcimEwP16+SrR8x/qVUNx1Igw2eKjIAGNwltIEy0HkR6qIomrs
 CKnxuwJYaXh+8PEkD5j2cRzrTrQwMp2wlLyy+IsqWn788EJ+PpxDtdbItiC4DPynUgFnjUmtj
 SeQ9UikFlCmkh/1/hbPeUVcguVPJAgvTTJKQm+AeQJdHNqO3T
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 26 Mar 2025, Patrick Steinhardt wrote:

> On Tue, Mar 25, 2025 at 11:32:13PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When compiling Git using `clang`, the `-Wcomma` option can be used to
> > warn about code using the comma operator (because it is typically
> > unintentional and wants to use the semicolon instead).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  config.mak.dev | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/config.mak.dev b/config.mak.dev
> > index 0fd8cc4d355..31423638169 100644
> > --- a/config.mak.dev
> > +++ b/config.mak.dev
> > @@ -40,6 +40,10 @@ DEVELOPER_CFLAGS +=3D -Wvla
> >  DEVELOPER_CFLAGS +=3D -Wwrite-strings
> >  DEVELOPER_CFLAGS +=3D -fno-common
> >
> > +ifneq ($(filter clang9,$(COMPILER_FEATURES)),)
> > +DEVELOPER_CFLAGS +=3D -Wcomma
> > +endif
> > +
> >  ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
> >  DEVELOPER_CFLAGS +=3D -Wtautological-constant-out-of-range-compare
> >  endif
>
> Let's squash the below diff into this commit. The loop already makes
> sure that the compiler supports the flag, so there is no need to special
> case Clang.

Okay, will do.

For my curiosity...

> diff --git a/meson.build b/meson.build
> index dd231b669b6..a7658d62ea0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -717,6 +717,7 @@ libgit_dependencies =3D [ ]
>  # Makefile.
>  if get_option('warning_level') in ['2','3', 'everything'] and compiler.=
get_argument_syntax() =3D=3D 'gcc'

This `get_argument_syntax() =3D=3D 'gcc'` condition catches `clang`? What
other compilers that aren't GCC does it catch?

Ciao,
Johannes

>    foreach cflag : [
> +    '-Wcomma',
>      '-Wdeclaration-after-statement',
>      '-Wformat-security',
>      '-Wold-style-definition',
>
