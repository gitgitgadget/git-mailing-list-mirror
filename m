Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0B13D258
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719151253; cv=none; b=UgmmXrkk5g+5ykCqbngpOhSIu8KrYOgr+t9RYNk0abv5sEP8Hy+IlZTsWi6FDuELzRGf4PFECm6ovcpW1kvGNDO0EVZVgEXycrSf1cFbBCF8FRkEfk3c4P/9eimmYLHHizvl9eMssll7TJmfInYdbwIS0eTGHWZ49qpYVu5TvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719151253; c=relaxed/simple;
	bh=jPk2VWsL9iEJYFIDIz0dVPtqidDavVl0S8eGsbGvN4k=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kspNnM4bdlYnCQIQpcboZNZ4J7EG/Nwxuvope1VPvuU+Uwz2gSeqleVceNd6kZ45rMBSknrY4DbjVQF8WeuSqO+i7fjfG+B5C7pH/kCy2B3l9k5YMYBnBywiLfdOAzDWvbr4qRDkjyCHFPd1u7YSp2c/k2cxBu+ZI3RChGXLwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjNnbxWp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjNnbxWp"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6fbe639a76so556751666b.1
        for <git@vger.kernel.org>; Sun, 23 Jun 2024 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719151250; x=1719756050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:cc:to:subject:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjxAmI9Dz/y+95cQ45EHP+i5NEsDJl1cjQtWCEka5TA=;
        b=bjNnbxWpd4QzoJxBo0DutOsx31jteRqX82YD1pPCgn7MuDUDs+tpxOPBZBaxJPgK1g
         b0tLm+jxBuwjKuIZaT5w1MrQlelMLuCUrqUBkWUssD+v/FN1TXpVf1cJfZRp+VtHJ+pO
         Ad8BAP/fzUblGcRJpVWlyQwNRP5/3/EecZ/4+3n6UWa4VWMj6JVmhykpEBPXInzL0/l5
         GAa33ho5EhBvL+9CFHlgNhJewdIzQgf/tmtofj8fjF+bTqlZ5zw8kW8/yp4xTARTyoe5
         k74WVXq8tNiiDCjgwN6Hp+dd+3lK2EPEgD/7zWsp76VVcsgoHQw24g4W1CnIHepd6Gjn
         gWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719151250; x=1719756050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:cc:to:subject:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjxAmI9Dz/y+95cQ45EHP+i5NEsDJl1cjQtWCEka5TA=;
        b=wIGHVidp/nXy0ZIG+WK8tqvAqYUICPur1/1CK5l+4ddtazHhmYAVMPkmyHM6IM30s0
         RAwuFaiYdINRh/SDfvsfX+1krnkJMMIquzhtvmo/mRGomMfPcHYbttPDaQ2a+1nT/Q54
         SA/pn3XAeoemjb91lldz9sjJCzTNll/LBd6tWsd0RHxzfoNbjlyqVFIx0BhBXcaFZ9nz
         uQJV3Q943qkaN6Q9Fi9N0YgqkAQPmCuOEzRltiom+j2rPApQao/PY07HEd2O7gDqvmKm
         N8oOZSG4AVny0oyCtpKOVQ+WMaR+T7V0f4tJ/r72TfjY0TQ3M7YlOVyGF78hTcOwpoBw
         TiUA==
X-Gm-Message-State: AOJu0Yz04Ph4zIIwzD/e7rSR7nmtNpr9bCKbsSobIe9Z2/c43Y5YBB47
	Ct3nTqhzDyhMkLaOO1PiF5vxPkxq3KFCUL0zmTaq55iqQcaUn3kypz0oww==
X-Google-Smtp-Source: AGHT+IHr2gVZHB+FO5DiWqv3AyCpBPSai6YATbGaDy8BRgsw9FjZ23E1pHPD2SpqG84gxq+Npvrqxw==
X-Received: by 2002:a17:906:ae48:b0:a62:e450:b147 with SMTP id a640c23a62f3a-a700e707051mr258039966b.29.1719151249777;
        Sun, 23 Jun 2024 07:00:49 -0700 (PDT)
Received: from [192.168.1.69] ([93.170.44.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560746sm304835966b.156.2024.06.23.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 07:00:49 -0700 (PDT)
Date: Sun, 23 Jun 2024 17:00:39 +0300
From: serg.partizan@gmail.com
Subject: Re: [PATCH] Fix default font scaling
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Message-Id: <3LDJFS.N7X2NCO8QRE9@gmail.com>
In-Reply-To: <YY2JFS.UYR26AJBROJJ3@gmail.com>
References: <20240615085345.47278-1-serg.partizan@gmail.com>
	<5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
	<Q1B6FS.FVKOG950Y3UN@gmail.com>
	<abee589d-5bad-4376-ba91-3bd611936983@kdbg.org>
	<N75EFS.1X38FZPYSV94@gmail.com>
	<0c845460-c211-48e6-af93-a0b483817420@kdbg.org>
	<3M5FFS.HXL15VW2HPOG1@gmail.com>
	<506e1f16-ac02-496c-a9dc-414726c1c37f@kdbg.org>
	<YY2JFS.UYR26AJBROJJ3@gmail.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5; format=flowed
Content-Transfer-Encoding: quoted-printable



On =DD=D4, =E7=D5=E0 23 2024 at 13:11:22 +03:00:00, serg.partizan@gmail.com=
=20
wrote:
>=20
>=20
> On =DD=D4, =E7=D5=E0 23 2024 at 11:13:53 +02:00:00, Johannes Sixt=20
> <j6t@kdbg.org> wrote:
>> Am 21.06.24 um 09:18 schrieb Serhii Tereshchenko:
>>>  Thanks! I tried booting into Fedora/37 with the same Tk version,=20
>>> =7F=7Fand it
>>>  indeed does not have this scaling problem.
>>>=20
>>>  Then, I downgraded packages on Arch to 8.6.12 and 8.6.13 - also no=20
>>> =7F=7Fproblem.
>>>=20
>>>  The only version affected is 8.6.14.
>>>=20
>>>  That's probably a bug in Tk (and there's quite a few reported,=20
>>> =7F=7Fmostly
>>>  about "tk scaling" https://core.tcl-lang.org/tk/info/1de3a48312, we
>>>  don't use it explicitly in git-gui but on my system it is set to=20
>>> =7F=7F1.3)
>>=20
>> What is the best course of action now? Since this change does not=20
>> make
>> things any different for me on Linux+KDE, I am inclined to pick up=20
>> =7Fthis
>> patch with a modified commit message and code comment that clearly=20
>> =7Fstate
>> that this is a work-around for a bug in Tk introduced in 8.6.14. This
>> would help users who upgrade from an earlier version of Tk, because=20
>> it
>> does not look like a fix of Tk is in the works (or that the issue is
>> regarded as a regression by Tk people at all).
>>=20
>> Suggestions?
>>=20
>> -- Hannes
>=20
> I tried running default git-gui and this patch on macOS 12 Monterey,=20
> and that version does not have font scaling, so there's no problem. I=20
> will ask around and maybe find someone with latest macOS, which has=20
> font scaling, and see if there's a problem.
>=20
> Patch does not breaks anything, but produces a warning due to system=20
> fonts being present in 'font names'.
>=20
> Then, if turns out this linux-specific problem - i'd limit this fix=20
> only to linux. If this affects other platforms - i'd filter fonts to=20
> only include those starting with 'Tk' prefix.

After more reasearch, I found this:

https://core.tcl-lang.org/tk/info/dccd82bdc7

This is x11-only bug, which existed for a long time and i'm suprized=20
we're seeing it only in 8.6.14, because .13 and .12 are using the same=20
negative sizes.

It is also fixed for a long time in the 8.7 branch and not backported=20
into 8.6.

https://github.com/tcltk/tk/blob/7c3e2ff815e23cc6ac1ce9891ca659e709776ea4/l=
ibrary/ttk/fonts.tcl

Also, you may be not seeing this, because your distro may have applied=20
this patch:=20
https://sources.debian.org/patches/tk8.6/8.6.9-2/font-sizes.diff/

With this information, i'm more inclined to making a patch for=20
ArchLinux package. So, it will fix every tk app, and not only git-gui.

What do you think?


