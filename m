Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29001E5706
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737398491; cv=none; b=SdV2r9mNcMYaMYYCZbwAaNQHe3oMHX6gi5QWTQ1oQW2r9u4msqh3qZNhUQnj7ZtkONXI5kfOHiP60WUD/HyeXgNMh2YAK+FDEK5qay//vIv4nPn9mFOwvqj9RFIoIFCS3QzH4bwu973e2HOLWOaZpQW5FfPF2usa+rZDjN72Eto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737398491; c=relaxed/simple;
	bh=+VEJOSqWH2/nD0Xej6BO3hGipXvltOCMSpRA6sCtcOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9LJDwiKRaSZj1ZkxQuVSOnB3nBORurXKiiWU16NWPhlMFYhXOe7cMieM6WiSQBIPFi2bY3iVIdTxh6veb6lWQtJLoo9vyN+VLWIOj92j00HCqGW+oTxQemVKFhhOEgPl2cDBaNzHvlIYzxN7Z2EgwONuX67w/Ee1fNCvXtdqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8eacc4194so5335396d6.2
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 10:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737398488; x=1738003288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKMX5GYEflk+Ps9URN9LmELjxSu2jy7ua0HOeKCLHh4=;
        b=ONVtpl4VNn+O2N2J8z90azeo5ULRH31YeU+PvC3yNn+xccu3dRMgvZqKPYWquxXc49
         gf4Fwqi7O912aqO+ndI/edR/FvJd1SOI4u9LGFGxi3ONiswlByWdmwEax1X/XS9unNK8
         PLt2zBKs9UDFOQPtoUaNIkC+CA1gMw3stM3RgjGfEhYc90Mw5K8o6IYQukTysb5a58ZY
         LlhJ0RfcC6atOeckivkZ6Hwa07aKW2NpO6ZFJHKAVIciMPAD/silI7jMf1/OhfbHa64/
         HHMHFST63kdLJzbJobsnOsJVSn8Ljg45FeVPYgomRsb4MeOPpNvCffc2b/RQMVhKm7Aw
         /Z6A==
X-Gm-Message-State: AOJu0YyzhiG1MF+2RRVTBGVpM8DcqOkFrsLwtsB+EuFXkF4BkqTJzBjW
	3xlCSSEAt0iinHTEyKg7LASQ7Wl/ZqkcgWKhhEsmTrr3sbc3Bc+MMoTqnLMUIlCZ+4gv2pHOyRc
	VElO/KkMZbqz0uZSxQtfwBVhxV8U=
X-Gm-Gg: ASbGncuyC5XnHkwLOhMC9yreYMDZo6vioPZgHoz4F9UAgLSlCd510MYnBDspFphJ+OA
	s2Ys9IeECzAFFjTCpnZJnWONBUgUeB8LMxeqZxfxoDFB7tJL7eQ==
X-Google-Smtp-Source: AGHT+IFLWRw/P0hoEFLkygdRwAWAvsfk8rJYASeHvguY4kJInAMipeMnjcligdAA9xfhGOkJHqlFDkmOZKEG0i+Sgcc=
X-Received: by 2002:a05:6214:1cc6:b0:6d8:adb8:eb8c with SMTP id
 6a1803df08f44-6e1b21fdfe3mr82358856d6.10.1737398488635; Mon, 20 Jan 2025
 10:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-7-usmanakinyemi202@gmail.com>
 <CAPig+cR6oCLw5h78NTrxDztTCLn4eseidk7wBc3JgVzKEE3+zA@mail.gmail.com> <CAPSxiM9Vm7DxDeneTvWLYaZnPK1Zpk79xfcH5US7-+R39v-i7g@mail.gmail.com>
In-Reply-To: <CAPSxiM9Vm7DxDeneTvWLYaZnPK1Zpk79xfcH5US7-+R39v-i7g@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 20 Jan 2025 13:41:17 -0500
X-Gm-Features: AbW1kvbdCbOYhDibjpGpBvcH9xZ0UgLKC4WRSb2k1ptaNnEdNO9L4_LBuZtZAu0
Message-ID: <CAPig+cSE=2jZvTUHsBnRRMizC3pxRwyud+TGDV7iw=QNmFmycQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] version: introduce osversion.command config for
 os-version output
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	ps@pks.im, johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:17=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> On Sat, Jan 18, 2025 at 3:14=E2=80=AFAM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > On Fri, Jan 17, 2025 at 5:47=E2=80=AFAM Usman Akinyemi
> > <usmanakinyemi202@gmail.com> wrote:
> > > +       if test_have_prereq !WINDOWS
> > > +       then
> > > +               printf "\nos-version=3D%s\n" $(uname -srvm | test_red=
act_non_printables) >>agent_and_long_osversion
> > > +       fi &&
> >
> > As an aid to future readers, please add an explanation either in the
> > commit message or as a comment here in the code explaining why Windows
> > is being singled out as special.
>
> The previous commit which introduced this has this information,
> can we do some form of referencing ?

My main concern is that someone looking at this change in the future
-- who did not have the benefit of reading the cover letter or the
review discussion -- may have a hard time understanding why Windows is
singled out by this patch. As long as you give some sort of
explanation, whether in the code or in the commit message, then you
save that future user from having to figure it out on his or her own.

So, your suggestion of referencing some other commit may work.
Augmenting the commit message of this patch with something along the
lines of:

   As with the previous commit, we skip the tests on Windows.

may be enough to tell the reader where to look for the explanation.
