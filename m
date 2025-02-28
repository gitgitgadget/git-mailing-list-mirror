Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC31EF36E
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758758; cv=none; b=m6CWmh7zoaE+7OGJk0qUhF+0wsrc5D1JaWYULNrguAFSQMIVq7sfMkKlU+qOFQbeaoOpOAO8AjPnrjOaYHjB5DTLhk4CfYqwQgk1ReiiQxjZrRqFAY25LieLWtfiqvA3hh4bjOZ3okxr0R1+xoHTpFM6/4kWcjvZTcq1lNkQf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758758; c=relaxed/simple;
	bh=s84LlCFYe5M8j63MR0kUVN2a1yCSf3D97rYxb1MxWyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbJ4Byxn2DC+fBReNHSbWVnbKJbRk+vjOoSYQDwx2zYJLbnKyyCSbXHKzsE95i22vd+3TsbdJptZC0dDApXcIch2bJU0wF9UEOo26NK+pVHjmvD4hF79LKdGRFWqd2ma3m0IIGPhgskxxQQrRFujca1s2fYcL7ndTXY04NcIIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHbEHM1M; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHbEHM1M"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f768e9be1aso33090227b3.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740758756; x=1741363556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHjIpeEHyIE8xNwmF0TOCgAFZbgMhlPBNHgyOGE8tTI=;
        b=gHbEHM1MvXH7zuDLVse0XFjQa8SPaHC4QWhIhQ4eCpULDwXpu3ca5M2XEJNzSXmrh4
         mXCgKFqnerPqKg6b62q0Bs1bjt9czPWCdNgqtPn7XDycPQsonuadTy1FMgKE5dz5K9XV
         sxJkFdKcB8+unj7W32vHZkqvH20u6uW5ftAD73BBAwdKhBZx3Kwyx5BdtpaMDaFZXCUd
         vkWPpB1qfYDFkGDGpZ85i+TUyePOppPwsPUhdn8bUrwov6/Bphcdh9yV3tnWRg+pm8Nh
         M7YTD3xzkYFxNspQNWjJj+6hPwRTfr3iGzIUHza0qNaAHdP++gFIryS/xIysU8LJImvD
         XccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740758756; x=1741363556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHjIpeEHyIE8xNwmF0TOCgAFZbgMhlPBNHgyOGE8tTI=;
        b=xR1/9+ez0oZ/4BWapt1h7u4chPo15qNyBBN45VfBtD20nHGo4gj96GtnlwCMKA+/h3
         oxofWy7eIGZiUpqWkn1kW2EMM0ovlKQ8WsOATWvzzTBNWML0crUZJGM1HgYVj7D4mt6I
         m3OQXszdrVzLH28k3h88PlYW5kpmsdCLozZb0RdIwyxz+/gWb1o6lsIJ25IaUz60WfpB
         B+nTdYzMyBe21r0qVp3B6eUaFySFdz4Zk/Qba7mkKsK4qEbjAZnbZa0zcXv9Z/ZdFsg2
         UMziVOWjzgXK8otKSIdFF0rWBO14THqYEYF+rOb79p3Mai9+WtbaWH2IkjMQrsoKkcK2
         8InQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzbQ7cEGqHHvYoBnPo/DMKMF9HU0/YLgyN5Byh5oqyC77HM05HlyzkYl6YFWBs8YpLvKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycxGz3J6nVlV322kXOhTDFlnjwTudM3tKuIVjTJMYgQKBTINcy
	nRvluDlfiXPI1EaPsVMDy7VUZbkZdrJwyLpScMw9OktXv4XhshUGUKyVLSE7F7Pbr3Y5+gLq/xo
	8DssztrJS1hGliCntlZMLRYkLkRw=
X-Gm-Gg: ASbGncuwD2vJreEJeWYRUEVTiMH95GDREipuR7JIXsXLS1orddOyn2bVqQUD/1echn1
	tXDytIAmjPYqmn/fI6N7pcXPxbJsNjWAIVMuOXOM+7OMSsBmINcN9kcKSqDLmrbCNH+EYep+z5h
	3hW1LLGb+EeaDxQ+3lSg0Grto9S10=
X-Google-Smtp-Source: AGHT+IFOuvDifMsYn54t+9nbzNvaqrtJQA2v3/OKb1yFqnMMPHLzaIfR0WWR7kgQ+YAQmClirNW06tt2dhQW28kcAAg=
X-Received: by 2002:a05:690c:4588:b0:6f9:5a36:577d with SMTP id
 00721157ae682-6fd394bcb05mr112188967b3.9.1740758756177; Fri, 28 Feb 2025
 08:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXAcUxHp3LnyqR=NM0coh6wG-1uy4GB3FdeZEg8mPHu-vt0bQ@mail.gmail.com>
 <CALnO6CA2j60gpPhUjxOY6_q5WdU7MHoL1GLDN_AVwWVNx_JddQ@mail.gmail.com>
 <CABXAcUwHd2Rr8iOZ7F2k5DGiBNH87pwG3oyRWLrP40=MgD91-w@mail.gmail.com> <d7b1416d-d201-400e-a0eb-b9e526f740ab@gmail.com>
In-Reply-To: <d7b1416d-d201-400e-a0eb-b9e526f740ab@gmail.com>
From: Clement Moyroud <clement.moyroud@gmail.com>
Date: Fri, 28 Feb 2025 08:05:20 -0800
X-Gm-Features: AQ5f1JovsaS9zlUUH4_nL3oLL0SMOcfAltbS_TNLMicL2nlBTeLTNGcltSYZGBA
Message-ID: <CABXAcUyWu3zi_iXrSoc1ymZCYtE5u4+JybJp2TiCCJA18T-4CQ@mail.gmail.com>
Subject: Re: 'git rev-list' commit ordering issue
To: phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 2:59=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Clement
>
> On 26/02/2025 22:30, Clement Moyroud wrote:
> > On Wed, Feb 26, 2025 at 10:58=E2=80=AFAM D. Ben Knoble <ben.knoble@gmai=
l.com> wrote:
>  >
> >> Is `--topo-order` of no help here?
> >
> > Unfortunately no, because it'll look at the ancestors. I get more
> > commits (400k+ extra
> > commits in my real world case) than I have on stdin:
> > $ git log -1 --pretty=3D%H 2025.2 | git rev-list --stdin --topo-order -=
-count
> > 417776
>
> This seems to have lost "--no-walk".
>
>      ... | git rev-list --stdin --topo-order --no-walk
>
> should list only the commits passed on stdin in topographic order I think=
.
>
> Best Wishes
>
> Phillip
>

Hi Philip,

I wish that were the case :) Per the docs:
| If the argument unsorted is given, the commits are shown in the order the=
y
| were given on the command line. Otherwise (if sorted or no argument was
| given), the commits are shown in reverse chronological order by commit ti=
me.

As soon as you specify --no-walk, topological ordering is disabled. I
_think_ it's
because it will instruct `rev-list` not to look at the ancestors. It
looks like a new
in-between option is needed, where topological ordering is used when the da=
tes
match.

Cheers,

Clement

> > --
> > Clement
> >
> >>
> >>>
> >>> Below is the system info gathered by `git bugreport`.
> >>>
> >>> Take care,
> >>>
> >>> Clement
> >>>
> >>>
> >>> [System Info]
> >>> git version:
> >>> git version 2.48.1
> >>> cpu: x86_64
> >>> no commit associated with this build
> >>> sizeof-long: 8
> >>> sizeof-size_t: 8
> >>> shell-path: /bin/sh
> >>> libcurl: 7.87.0
> >>> OpenSSL: OpenSSL 1.0.1e-fips 11 Feb 2013
> >>> zlib: 1.2.3
> >>> uname: Linux 4.18.0-553.33.1.el8_10.x86_64 #1 SMP Thu Dec 19 14:28:01
> >>> UTC 2024 x86_64
> >>> compiler info: gnuc: 6.2
> >>> libc info: glibc: 2.28
> >>> $SHELL (typically, interactive shell): /bin/zsh
> >>>
> >>>
> >>> [Enabled Hooks]
> >>
> >>
> >>
> >> --
> >> D. Ben Knoble
> >
>
