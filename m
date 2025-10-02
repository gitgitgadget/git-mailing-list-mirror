Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27C2F5339
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393313; cv=none; b=cE8MysTB0YnGt4s1bOe3/utTeWySFEXREjqRh3q3sTN08E25t9NNiPalA2iXpbWJc/F0mc+alPTGAVOskwhT+WU2DjKS9g2EpeiclizEzDpYuq+r5jmu8agn1XToUFgBa8v8gQG5/1XwzRZQcnkd+HrEja+t9+75sGMAVpHGRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393313; c=relaxed/simple;
	bh=YzHJR4ZM1IMzmChKhwLu3CrEn1aPuzcME05Rs+PVi38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOxCsfRipYQyKbRhPB+9E/gSUEtPh2nNmGbKWbmW981WPMTF7Q+NK9gs1kQyUy9r6oIdCOJCUBVDkO+3sRGdkkVmMKifLEtd4B7zd7DaO/s4loRSAHn43qzqkUdXCVig3B//ZMHKtJjXoyqmfjsrLKoD6lE4nw/nHqr/cqtclzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt4/UTz+; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt4/UTz+"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so8976015ad.0
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759393311; x=1759998111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG47L7vRG+77lifxyRQrscksMafWYBZ7RxsE9W3Wg58=;
        b=Lt4/UTz+WHuLJQBqzY9ck9dumZ7lsHe/g6dA0Jluy0lQazE0GF2yDhz0G/uR3sq+lb
         E8VewCKRaVRpyT0EVVU6dScJuHnOoxK9e9Z2Xns+9IoXJsSQ4DheyNug/FN2teRBnlYE
         Ath1C05eqTTUSubWJWJg6LFBFH7IkTuL9Qoje9wyi1SglL2So9Iq6SbH9H+TItskkXH2
         8DO7BkosSGpBulBGeF3DQtUlaCpbmkw0b9zWZ7B/0NE4Y9JL3y9rYFkVsrfjKv/ZWhvW
         m4/ar4yXu2qzcyyp8Vs2bRhnyw+8PBMX6UFVeFJh29NsCVETMWWC5w8YjAFULPHtSEjv
         LU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393311; x=1759998111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG47L7vRG+77lifxyRQrscksMafWYBZ7RxsE9W3Wg58=;
        b=W4V8mhbleNtClB/k7//kw4Wl/6xjONBNwZWkycSRm3/HaaOBPsY4wejWFl6RHjBORx
         mI3GfpejlizKsjn7/UU0dJDAC3ZRGa8D0knMuuiiEOz+3LYvj+2JqaPzda/mBNfbk+4b
         PkPuLOfuPUlCv1MPi+vQfoc8LKqYF2jaiXh7ymzsATMhmtNJwmUZTlIoifskmNXCFZi5
         yl6FwDsAAMz5S7gJIYAs8IPo9/cgJOWaX6budpze1tXa0lieyqv6LU5Y8DRLRqFiYhOo
         ehWm18Tq86nh/evAbI0tksefQA1uk5PDtzCSrpuYXC3GC/hBMbl6C6FFEUngKeN7szOY
         bqcg==
X-Gm-Message-State: AOJu0YzUGgWQWjfeU21xyy8/qzG3zEkPsrIZcLzsvhPZooQh6x4vGyIA
	UlembMCd1WwWoiiqOBO0XNbHU6Gr0ERu0fHp3TKK66aN84XDnpuaC4IjM76o4lJ6EoEQv853P3u
	8D9Pzo3HJ6Ue3V07nGceEEptorUJ87k6W457gTLU=
X-Gm-Gg: ASbGnctPp1lXvXaBkwHbq/dZd6apco+RlGtpXqoBGuuXUOPkoGfv6nbGqLWgvqR7LB9
	EkRjk7yB6VRKIHU03wndjHTBrsnYYV7hAT2oWlC40LZH/SEbB0nFsjL+/LSXp6Apku5FDFRWsv1
	Dzcf8er6kVGiNujtlVz8MJlOFdJ4iuHM27/091DH3pEXULySpuauM2Z4NTRr97kqGBU92cxB3ez
	nNqx4pYBvvzA9Mwc74iwnaOiV1A26Dfliz4GOjNa38OduOIaHqhDM1FgT+dLgxKEctFDWBBKz4=
X-Google-Smtp-Source: AGHT+IHP0h7DIOa4QiM51fGkcdSZPZwdBjGE7U9NslMKiuhZ97Oo1WdSZQDqNgM4H0EWGKfbC4FhPoWc6XWeLJ9H5HE=
X-Received: by 2002:a17:902:c404:b0:277:3488:787e with SMTP id
 d9443c01a7336-28e7f28e07emr96455175ad.12.1759393310909; Thu, 02 Oct 2025
 01:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMWvevK2CrA_2mJC-O2HDKag4EaDVrB-0LiqQk0_gKrRaSR_ew@mail.gmail.com>
 <CAPSxiM-hkh=X4rf6QvGP2JnHvP-UJQ9mcmMon91avv9AaLB3Bw@mail.gmail.com>
In-Reply-To: <CAPSxiM-hkh=X4rf6QvGP2JnHvP-UJQ9mcmMon91avv9AaLB3Bw@mail.gmail.com>
From: Vedansh singh <vedh2o2@gmail.com>
Date: Thu, 2 Oct 2025 13:51:39 +0530
X-Gm-Features: AS18NWBb3DlAZlfRmozFB0yU0SGpD__9xR4J0tNLTuFBBunnqkdfl6JxBvotBp4
Message-ID: <CAMWvev+ZumUqF1hW9qfJ7o=_t-qwB=wko7oL8r3UFC2xmr0WgQ@mail.gmail.com>
Subject: Re: Interested in contributing to Git
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you.
I will share my next steps and progress here.
If I am missing anything, or if there are other approaches to
contribute more effectively, I=E2=80=99d be glad to hear your suggestions.

Thanks.

On Wed, Oct 1, 2025 at 10:01=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> > Hi Git community,
> Hello Vedansh,
> >
> > I=E2=80=99m excited  about contributing to Git.
> Glad to know you are interested in contributing to the Git project.
> >
> > To get started, I have:
> >
> > Cloned and built Git from source successfully
> >
> > Begun studying the key documentation: CodingGuidelines,
> > SubmittingPatches, and MyFirstContribution
> >
> > Reviewed discussions on the mailing list to better understand project
> > workflows and community norms[Past 3 weeks]
> Good progress so far.
> >
> > Currently, I=E2=80=99m exploring suitable microprojects to begin contri=
buting.
> > Once I identify one, I=E2=80=99ll share my progress and submit patches =
for
> > review.
> >
> > I=E2=80=99m looking forward to learning more from the Git community and
> > contributing meaningfully during this application period.
> Yeah, if you face any problem, do ask, the community will be happy to hel=
p.
> >
> > Regards,
> > Vedansh
> Thanks
> Usman.
