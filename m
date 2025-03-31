Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D771581E0
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452220; cv=none; b=hX6OsNE3y9fX6mjht/k+56y4d8IorrjR/peUsXcNlC2e0S58sP6ZRPAlupBqq1K/39V+DYKJKDZqCsdUYhVcgpzSJiuPB2Xb6Dc6lzSkE9a10adxT7fkBfl8taFUXoxBmHBeASPIBv4kFxsjtDou12nhe6TexoMXpCi0vk70NUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452220; c=relaxed/simple;
	bh=WZg6N/1MRNDVi34YTyLXNMQBWh7h5d4kmSmxDYK+gAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnfie9PPszLvvt9/sK5Oq80OgT/Z/D2MybBb6YquoPUDEJIMIyy3XthuaO9/fnFg0cIBIpWIRVqiOx8uosADOD/GsdEhB2/xxtHbevcGL1BCjkkt57ji8BLOxy6apMJBm7n44VwiY4Mp6y1DGr5p3LvWySmhJRwHnRJmbTz/y4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ+M7bMi; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ+M7bMi"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c58974ed57so513568285a.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 13:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743452217; x=1744057017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLtbfSolcOO9uWAerrQUg461nhBKBYqqyd5NATM61No=;
        b=gQ+M7bMiiIGCk9KvDgVAutuCJuqhEE3b+VndOzL6D6Bf0Y7jAp74GsLiA2RxqHh5E0
         MPt0s6JvLrdsItKPEjpl1i3d0pH+8XSlWpc381DJMQlANovPQk5x6riaalBCkS3rJbw/
         Mn2O+jyLwA88b47dsjrsn/QPGlXmuIrRv3WMZTWXUt1xDmiQsnmsGz/Q+jYFnmOFf3Uu
         hogoYp6rH/H5S10xBKKI1DbvtLoJ7GRVaa3p+BFPJu/HZVCcB60XOtKaei0V0b6oBMmk
         5YyVygpd4/1Y7rhk44RayC1IaHLIZKfNv9NeVHo7ePi1qCm/X6hv9dsSWKNFrJaZc35O
         AfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743452217; x=1744057017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLtbfSolcOO9uWAerrQUg461nhBKBYqqyd5NATM61No=;
        b=uQ+49VRtCR8p5XtcevxdV587LW+hAOex4N6kuJnlUbQmHqPYWNgCfItgd4/JRpeK5t
         cG8SWGwvaLbTBmZScwAK1FLgEJ6gf9wEqZoUAN0ELw+eSYPHlAum94NU7RxlVbmZaJm2
         Fjfkprui5uwwpArUcmqKOAa3TRLH4C/H/+KicoIGR24VKzBkfLTuIpV5YjQ+qNxCy8uK
         Nuzn+e0pUPW/CF05D1NgyCtNrf9BHgdAlJz3TRuAv3ZQFJ/AwQuhNW3ztKrTm99NnTXD
         gGFolony7My0l3O+tzoq0AxVBFsQsV+th6QS12Vp0GM2EVT9UOfFcKVfE5Ieh4OZ88Tm
         qXGQ==
X-Gm-Message-State: AOJu0YwlzLQkev7bah4PtwaApgFDKyLd3b7Yk80u/USdUR6r8h/EXlNA
	Jlbtv2j8LbpJPnL3Qq2lWIrtJzlcjb4Av9+snplcpeikwh//S0sE0bCKpjHa5bI5XhTe2n3zzyW
	dhgNih00dJsgySj1hfiIkY2ueKdI=
X-Gm-Gg: ASbGncvag4S+DqZ/PCFTgRDOpG1tvJ7xCk7dAbbUFWkUSfrF/ddYhCoBzl1MA3TlO/K
	R+UePSeQ1JRTWFREWfbs4UBaIEaUPbsHL9UZ8stqZMjt0iY1PrW4qbKyHAjp3ZyJmF164A1/WpW
	mhznKBfPlexD20h7Fpewz/NUtp7ZxuQQrXbbF1qjJVIt2cPSn6GD+VHnZUMpxIF2rj1EuxIJY=
X-Google-Smtp-Source: AGHT+IFr7FXIqsESA8ifll2xo7Sn1/wn3/5sBRswuOef/gRPyb8S7hzb6ExtrqHtFlYRcztREnvs6UJTGl1TJHQSLes=
X-Received: by 2002:a05:622a:1350:b0:476:980c:10a4 with SMTP id
 d75a77b69052e-478f6c9fd0bmr5144241cf.23.1743452216887; Mon, 31 Mar 2025
 13:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE8gLhmKtV-Kz4jYT6r1NanmGdAyzd0CumVGsVnVpePQPAtnzQ@mail.gmail.com>
 <20250331-devious-woodpecker-of-temperance-b18608@lemur>
In-Reply-To: <20250331-devious-woodpecker-of-temperance-b18608@lemur>
From: MegaBrutal <megabrutal@gmail.com>
Date: Mon, 31 Mar 2025 22:15:00 +0200
X-Gm-Features: AQ5f1JojBDJlQGwqJDvA3S3QFHCaexE4evcMLfHIm8Q6hzYBXsdHlAPm47Wr0tw
Message-ID: <CAE8gLh=1bqA6UTR4wAX1u1naic2cSGiekz0jLKxWeaxBKa=xiQ@mail.gmail.com>
Subject: Re: How to get git-daemon to work in a post-CVE world?
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Konstantin Ryabitsev <konstantin@linuxfoundation.org> ezt =C3=ADrta
(id=C5=91pont: 2025. m=C3=A1rc. 31., H, 16:53):
>
> On Sun, Mar 30, 2025 at 10:30:00AM +0200, MegaBrutal wrote:
> > Hi Everyone,
> >
> > I'm new to the list, just thought it's the best place to talk about
> > Git. I'm running a public read-only git server with git-daemon. I've
> > recently noticed that my repos can't be cloned and found that
> > particular CVE which made git to verify the owners of the git repos.
> >
> > fatal: detected dubious ownership in repository at '/srv/git/mgsautils.=
git'
> >
> > The feasible solution is to declare the directory safe in .gitconfig.
>
> You can set global values in /etc/gitconfig, e.g.:
>
>     [safe]
>       directory =3D /srv/git/*

Thanks! While it is much more convenient to set it in one global
/etc/gitconfig than individual home directories, I encountered the
following problems:

1. It doesn't do anything with the other error I get, when the
problematic directory is '.'. I still keep getting that error message.
2. Git daemon doesn't seem to resolve the '*' wildcard, i.e. with the
wildcard I get the original message back which complains about
'/srv/git/mgsautils.git', despite it should be covered by
'/srv/git/*'. When I supply the full path, however, the error message
is still about '.'.

I even performed a whole Ubuntu release upgrade to get a new version
of Git, but 2.43.0 acts the same. Seems like git-daemon is more
stricts than plain git =E2=80=93 what might be the problem?
