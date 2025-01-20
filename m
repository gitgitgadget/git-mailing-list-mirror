Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380437DA82
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397062; cv=none; b=hU8AtRMTgeu61YUwsN+8bl6uzKDxklGEJ734wD00IGXxB1JLLosQeaZKdOSCRGNuYnyzWC/34c6Drky0zsf/4rh/qXM+0bKWYf6opYAODQq7bPH3ArbOhwWVyiGXHVyKKUnZtdzfbAHb12CRv/WW0rqfcld8anjK0Jhrv5x2+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397062; c=relaxed/simple;
	bh=32S024zF8FlvZTbz6fGKFQ81hiYVA9kUGumqEqeiA2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRIgHXmvYaXqdsCuH5c37NoptPQZy8djnntNHuoHes7Srs0HQyrc8Rk31fwIU74DeiYEne1xg+JCuzZxO7+1CIRcLhZkovC/gsWxu4dCKCWGHFQpJyW5i8RW1WJuMLQYy+5FnGlAiw8HFDSh9xeKBxh17nxEJoUVmIAhGtHNNe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrOg8Uch; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrOg8Uch"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5162571e761so1541918e0c.2
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 10:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737397060; x=1738001860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDCt4SIIM+ed7zxYuFvfsB65UXlcoY7SColV2C7ISxU=;
        b=nrOg8UchHu+Na4R/T7sBQ216MnieX/HwZ2Y57oyilYGE3PEm7GaGPt+bVwIT3f85PR
         wFULL8I16XPSDpHZhEliSPzzrS6vH/MfsUJgVbN4eLHihVfn6HUMNU0Gs/zwmUtuyPAx
         Vyl29rGdVw3a719/PO0XLNzcAMrfWbU+GozMEuFyDhRVVcZ78KO5Cd3sTqF9rg00zeME
         MZmCP0lDytwbyNg/fN22qFOeE3zTxoLD5GkZvH69lYGXLj1dlkkehUV5va1O5ospktq2
         xX1JEWx15hLWIuzkSPSp3dXEqjs/HsCTOHeI2/cN44pUSjfyMhdygiIMx+3ARhtMLwCc
         KF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737397060; x=1738001860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDCt4SIIM+ed7zxYuFvfsB65UXlcoY7SColV2C7ISxU=;
        b=LEHGxIW6s4E8oLUu44eQQWjM7rThDKIuXk+z0sMBKQYyB+drAuszEuoMHsO62jAGvG
         B54lvJNVpSkaFUptNIpGLIfBiYnaiYn1xpLoRtLNGuno8E1m+4I3/dOVGphpRwgKqRU3
         QdyLSi8DdkhNiwzoE5o86VJdhCzifsbRUgasYueHWqMOY03UBPyFhIC/Rd6dxm3Mhbaw
         Vwudyt+HxkOSJTYW7gjIWCEBkDG2yqQ7mYgbpohRJkzJjHoHLKEtFB+LgCzjhJSq3AGh
         puvKHlx9FEOJrUNG+JdWZsvbcuO3nB+FzEAiKVZN2iWbDjjDSmxqD06ogjz2qex7lVBJ
         j9fQ==
X-Gm-Message-State: AOJu0YzL4LW0pewwcvvczNutIbmIlIvt+ocS0nFKA7kwvyZ+w+g34zPf
	6UP85QBuFkyg5O/o1PIitjRv3rb7FHoPENCVrrs4TIJySuIwtJF9Vo8T9pFqNKbPNo63VTG6R0B
	XAZ3kYamUFTUF1/g2cyfuJcQ5Ko8=
X-Gm-Gg: ASbGncsLGbl7NES++SK1IVVUGlntIFsb7RxS0h/4H8LgWHICRa9IpniIuUUOfYYLFke
	4VmDoe0jwo121EzZ52Jgp7Lk0HE4biu+mguJZlY61UI8CmNzxlM8=
X-Google-Smtp-Source: AGHT+IEkeWRwxOHz4WWyilOl2oP/NHApOGE+Y1M8yzmFuZnHjRVePapMDOp2CFJ6IIshseRf/5xRBCUQB7N2ucbyF78=
X-Received: by 2002:a05:6122:2109:b0:518:859e:87ae with SMTP id
 71dfb90a1353d-51d5b2c385bmr10782146e0c.7.1737397060015; Mon, 20 Jan 2025
 10:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-7-usmanakinyemi202@gmail.com>
 <CAPig+cR6oCLw5h78NTrxDztTCLn4eseidk7wBc3JgVzKEE3+zA@mail.gmail.com>
In-Reply-To: <CAPig+cR6oCLw5h78NTrxDztTCLn4eseidk7wBc3JgVzKEE3+zA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 20 Jan 2025 23:47:28 +0530
X-Gm-Features: AbW1kvaL_lDdLi4d7i-PMr-Iw1egBx1DJVzRqvPxfu_i0xML6_e93rKEwb9mlfo
Message-ID: <CAPSxiM9Vm7DxDeneTvWLYaZnPK1Zpk79xfcH5US7-+R39v-i7g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] version: introduce osversion.command config for
 os-version output
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	ps@pks.im, johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 3:14=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Fri, Jan 17, 2025 at 5:47=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> > Currently by default, the new `os-version` capability only exchange the
> > operating system name between servers and clients i.e "Linux" or
> > "Windows".
> >
> > Let's introduce a new configuration option, `osversion.command`, to han=
dle
> > the string exchange between servers and clients. This option allows
> > customization of the exchanged string by leveraging the output of the
> > specified command. This customization might be especially useful on som=
e
> > quite uncommon platforms like NonStop where interesting OS information =
is
> > available from other means than uname(2).
> >
> > If this new configuration option is not set, the `os-version` capabilit=
y
> > exchanges just the operating system name.
> >
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> > diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.s=
h
> > @@ -150,6 +150,34 @@ test_expect_success 'git upload-pack --advertise-r=
efs: v2' '
> > +test_expect_success 'git upload-pack --advertise-refs: v2 with osVersi=
on.command config set' '
> > +       test_config osVersion.command "uname -srvm" &&
> > +       printf "agent=3DFAKE" >agent_and_long_osversion &&
> > +
> > +       if test_have_prereq !WINDOWS
> > +       then
> > +               printf "\nos-version=3D%s\n" $(uname -srvm | test_redac=
t_non_printables) >>agent_and_long_osversion
> > +       fi &&
>
> As an aid to future readers, please add an explanation either in the
> commit message or as a comment here in the code explaining why Windows
> is being singled out as special.
>
Hi Eric,

The previous commit which introduced this has this information,
can we do some form of referencing ?

> > diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> > @@ -53,6 +53,35 @@ test_expect_success 'test capability advertisement' =
'
> > +test_expect_success 'test capability advertisement with osVersion.comm=
and config set' '
> > +       test_config osVersion.command "uname -srvm" &&
> > +       printf "agent=3Dgit/$(git version | cut -d" " -f3)" >agent_and_=
long_osversion &&
> > +
> > +       if test_have_prereq !WINDOWS
> > +       then
> > +               printf "\nos-version=3D%s\n" $(uname -srvm | test_redac=
t_non_printables) >>agent_and_long_osversion
> > +       fi &&
>
> Ditto.
