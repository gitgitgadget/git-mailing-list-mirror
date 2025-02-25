Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216211A23BC
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502126; cv=none; b=Of+ljfOu7Px9e7WOKSjE03QLpxc1iusZCqESc3hLhFgdi4KWKMZwOpzJRqM8CMKM/P4MuCBUqSFMSic8o6o8W/PbN3q/+NmdTt2h7apiQqbMZ/ar75IbLY9MEgVeK68KquUx4mpgiQ/atH4qdff/KfyiacSgA8YHBhh4k+so0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502126; c=relaxed/simple;
	bh=jBoHaS5Q5rQCmz8CmduNS5Lxl1FpxONokGQxD5Rso0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trsMbMcQb0vfvyr/vjhqIewS/rVqEbjBN5IJtJ+W5Uj+NXL9YRIkLUDTeMDcfkG7STzXzGHqjZPbx32Lg/YGIoD8t/13FcKRhqMT+Oy9nVtW9RX+v9bnYCLa4n3EtSi04DzW9p5vLIDSJZfaVscm8P4wWDY8LtOyESCc/ySf67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiMAZkw6; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiMAZkw6"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-855a54f83fdso483735239f.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740502124; x=1741106924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvR9asQb1trJMSY3BDVYL0SPohoPU7zlO6ewWvferb0=;
        b=jiMAZkw6ZtIz1HWOZ3iZ1O0G7REMEJLR6DAweDzJaQTOpeaFw5quLMzHxvmxQoNBVR
         clWuOPE4yuuOtu8nVtJdOfnj00jI8EeOvdCCbbfvRxhoP2s5mq0CZxIv/0yv+Tb0e18n
         Qog+2PxDk3/a5S2/nDxtMDV4zdD2+NewRZCj7Scf9sDvkZknr3W9xZBLaZy0ARJbaoiP
         sYoYgI7zGWflJKatUDeS9AMes8a3dlE4fu8GMMkpABWLVJscBKy/8G2lDBfKAVHXd1Xt
         0GK8K+YIdHMpY4kQ1rVn8sVN2X4fwmJhYQkwVlUNs7V4huyPN8Ny9+wLt4GkqHvqiRSR
         2mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502124; x=1741106924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvR9asQb1trJMSY3BDVYL0SPohoPU7zlO6ewWvferb0=;
        b=Gs+WnqByA3slgoTf91AtSVMZPB4+57G9ZlXQMgNCu2HRKGP3l55DgvB5Vzz8z5QPJa
         tHMDLmW2Fd82agSIjXbd0FOg3hlt7jzyqty8bxsJflGcntRoIoq4glivDESjFn77rI4W
         wqh9upKw4z23c4Dyn/SydSpEcjfehbyeaC57gDjLYTaBYK5+VtJoeie2AQljnzunop6x
         jww/khGNx938wtb5XFzZroVPQ6NWC0Ua5C4D1uzJ4AFwsgDCySbba0D0h8OWxqUGBJ12
         WEywDj5x/GLWLO7E1pNYaP6tSH6SPOliRwaaMxxrEHfg+Tdb2s+xXGMvyS9xM2QRZuuD
         uBRg==
X-Forwarded-Encrypted: i=1; AJvYcCW1UtIHRZJdJmbJitlXg4ewjTFDcMUiFa72IVljZsxfmEkqAdQAL8tHTA7Y+1T7PXkewsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5edinn9/LxGKZ4g1sfZQsnhjoy+kkmsBP8OTd+PZkbeczYhm3
	EiDClqDVOlS7fEmRKYhqgj8eWH2+c8+zVAO8h0Nq9BAXX5419GirCiQjl1ug15bxdXoR8HUwpYj
	h+3OgdRkTIAyCM2bJ93om/Se1qWw=
X-Gm-Gg: ASbGncvP/ARylqpl6X4Ff3Wn+oeVwv22m6B1DGkeNZ2XdICNoyRlNILbvztjln0vda0
	iwOdxVfZxr4bLPTk2ZwTsHYkgzeAMF6o7Kvnih0QVSaTjDxV8YoYrA3X+DiGYs+jqgRAWiPLkVd
	lpxoyYx/Jf6vRz3Itb1K+gnR7EgiT/ZDBHtGwRT0oq
X-Google-Smtp-Source: AGHT+IGtasNny/IQkdJM7j1YOShJpiPHrI6fp5zytUJpRttkW8tugMn1JHYj11jhZNgHwjt/pTjjP8Q6nrLDUfMSE84=
X-Received: by 2002:a05:6602:1694:b0:855:c062:fca9 with SMTP id
 ca18e2360f4ac-855da9cf3b7mr2221453239f.4.1740502123974; Tue, 25 Feb 2025
 08:48:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210430232537.1131641-1-lukeshu@lukeshu.com> <20250224142744.279643-1-christian.couder@gmail.com>
 <xmqq1pvn6zvg.fsf@gitster.g> <CABPp-BHOvCWd6mMg0WdR4O5TfZS7TWtRCQCYPLnGpo5+jNHy5w@mail.gmail.com>
 <Z712Z0zGQD1zkdkZ@pks.im>
In-Reply-To: <Z712Z0zGQD1zkdkZ@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Feb 2025 08:48:31 -0800
X-Gm-Features: AWEUYZmx-BBOU9AVZOs0wuLGa7pylhrrRW_K3B_oZYnatGrm3bAijooNf96wZMI
Message-ID: <CABPp-BHDx4YAjCqWX_VUjHQQ-r1iDbw7UcUgLXtt1ZAJjNXD-Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fast-export, fast-import: add support for signed-commits
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Luke Shumaker <lukeshu@lukeshu.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:51=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Feb 24, 2025 at 11:35:00PM -0800, Elijah Newren wrote:
> > On Mon, Feb 24, 2025 at 9:01=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:
> > >
> > > Christian Couder <christian.couder@gmail.com> writes:
> > >
> > > > Luke Shumaker sent the first 4 versions of this series in April 202=
1,
> > > > but it looks like he stopped before it got merged. Let's finish
> > > > polishing it.
> > >
> > > Nice to see an old topic resurrected.
> > >
> > > > fast-export has an existing --signed-tags=3D option that controls h=
ow to
> > > > handle tag signatures.  However, there is no equivalent for commit
> > > > signatures; it just silently strips the signature out of the commit
> > > > (analogously to --signed-tags=3Dstrip).
> > > >
> > > > So implement a --signed-commits=3D flag in fast-export, and impleme=
nt
> > > > the receiving side of it in fast-import.
> > >
> > > Nice.
> > >
> > > I haven't thought about this topic obviously for a looooong time,
> > > but I wonder we may want to have an option, which is independent
> > > from these --signed-tags/--signed-commits options addressed here,
> > > that allows the person who performed the import to attest to the
> > > result by adding their own signature on tags and commits, whether
> > > these tags and commits were originally signed or not.
> >
> > For what it's worth, this has been requested multiple times of
> > git-filter-repo, so there is some desire for this feature.
>
> This is also exactly the usecase we have been reviving this effort for
> :) We recently hit such a case where a customer was basically unable to
> use git-filter-repo(1) due to commit signatures, so we wanted to help
> out and get this patch series landed so that the issue can ultimately be
> addressed in git-filter-repo(1).

I'm confused; this patch series doesn't implement the option Junio and
I were talking about.  It only allows existing signatures to be
carried as-is, as opposed to resigning all the commits with the
current user's signature.
