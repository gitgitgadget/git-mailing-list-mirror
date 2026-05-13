Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11214BC016
	for <git@vger.kernel.org>; Wed, 13 May 2026 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687574; cv=pass; b=U0ApthtMNNzDcxs+aD2SjiRgxhUwhFGSp3jqQaKZrxDOSyjm80j/Qmr1N4S0vufikvYKiy5pbPxbhVxtG4S3LvLGPfuLO/SDNy8/1UQMjiXstJun4mQSyoN9YXdx+xfDCtTu9Ojxm8iMM49sHc5qZYrnYI3j6fp03TQ0azvhve4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687574; c=relaxed/simple;
	bh=c86NZNVHpMSn3GcyFI6ly1wCSUJ2QhABVo2K+ar5pvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzCNtX/woxHJHqLIfDYmBn/kQ8j0XJYaDmAOj1a/+BvNFa19NkhtoATjQ+uhH3DVo2sOICLaZpuHbgBxJr9SVcGqgDUUpHyfYsEyxGr+/7uXJr19vjDwSqB4qMxBT81rmXSvK8pJqV/qtskY84j/+76AY3ojn60SzX0aiYhjkmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8vwlQS7; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8vwlQS7"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so5229764fac.2
        for <git@vger.kernel.org>; Wed, 13 May 2026 08:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778687572; cv=none;
        d=google.com; s=arc-20240605;
        b=KFpfY9+0aCKLCQuVXFXMeNpDAOESfSXnxW67HNQ3P3pDKIk6RKuXUXaNDYDB9cWZ9L
         9PgtOIo+vPkp1rFu1QF6TLzEYb5jBta1m3ceacXhPaPQrvg5LeJc/9BZUVWqXVNSkXUi
         2vX3tV35edAdsp8ZbFffGjcFFrV1e98iTsxLNDAdcMuZYNx3OJC6F3tSM1+AWdhqEwCR
         iwsIKG6lYjhO44DZADo3Df9Dt28jjKzPxxvJ1i5XWGqrfn71Hmfs2x8ZxaH5Xclmvxqy
         oTz0iRy4DoZ6e91+ZLeSbFYLDRbUdOej99kJCpRNvsiCD1BZut0sCdxZKdHjdePxZUN4
         sNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lpi/wL7F6xDwTzWuNJJB5pGC0xlRIFes337Heq6d9/M=;
        fh=pBxRY8ocromI21gM+WBSrdXI6Hv/aj0i3fpYhIAoWYU=;
        b=EPSwLvS9Bu30eD1mQUXoyiERSAe1jgL0dDuDDKUxw/xBpUvRFI/Vk45+d+nBhobQ7C
         FS5zhxH07rgH4uy4LArcDuKAI/LxHLfeNoNxop9JPTjORPO+JMa0YlJJ1sXSvV8493EE
         3sTrDrsrCEGmCfX2uznjqiMGEIsga5ToZ9hrbz0dEd27P3k6yDC/kcmLfYnhLtWp8o20
         1JYkDUFwfjvN0Celx6hlmk5gIlPTTg0zzD3ZUadG44gXgOWi0B1+c55DgY3gY3uHnRjI
         NWMMWqspOb2UR+VFDXR7u2BMBxPxGWwMwnTxtBxv98RxAaA4B+dy2ito8BhY7iCEHezj
         Uuyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778687572; x=1779292372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpi/wL7F6xDwTzWuNJJB5pGC0xlRIFes337Heq6d9/M=;
        b=V8vwlQS7mFMbqIhWmOoECbZcCi4BB08q3DJUXEFZ1UZJqf4j2ANaLT6n4lpCzJGbeH
         80urap6sujKm/ToEEf1CNcub0SrBX9aRP+l5DP7eQO4gm77RdVxJ0bABMvcFLHO1PZoV
         wTJt89MMdU+CILd7X6s/NR7CA3nsouRXsSG7ciaGaNl0kcdEsvyD6mlif/wlx+gOweda
         2scycvx9XkjZ7/uvHXvSCOXBbrFAUM4RcZcCRidxhU/cOdbIEcAGZtZaAGavNyoJtYzx
         Gu7/nJ+/hw4tafeLDr3XIiNDLbdK/h85Wj17RGk5Ag0ntCHfxpZphjQ96TVTq52z30E5
         OzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778687572; x=1779292372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lpi/wL7F6xDwTzWuNJJB5pGC0xlRIFes337Heq6d9/M=;
        b=LQJ23cwMy/eDz0e0wAovsWe27qosLP1RiiLrn1nBU5Zyzzn+h5o548/HHgnH2xGBgD
         2k/mhrQ/4wyveswBWm9Zea+BE72wd/5T32srDjvnW0vGqofmLxVEnvELsiXngCxJlyBd
         h6G5YRytANPSQLY9X63znSZgDMVYxATNcxduqCAxl4NkLAgqu8d+mmjMLORs8YiHpN+8
         vEKQdUk4aGv62oiXnR4x6vZd+nkl5zhQF3i6BUgGH7+0o36ojIbB4XA2iwtueba8rt7p
         VUBlv1645I/nMx24mbxz+WKmrLwsXWcnxxO3om/0tV0TgAbQb/fMF6NdkZ16B5lJAj1A
         Ye+g==
X-Gm-Message-State: AOJu0Yw8YfPJC4h7QZjEXb6nfiq0M4A+yfjOjGtYiJWDmoJyeByFM/Rr
	Odn/hn+1FbGGdAxo1+kmMh+DBv41miC18y8xoBcRQBttwg4h3zRJhN5ZgGX0pTJTMKmxd8sAxOt
	dmNXSD2ZRy2bScXsGwJGf/kG9K86NP15oZp4U
X-Gm-Gg: Acq92OHl7Eh5BA9okpwn8wU2dsVmfn0IwaHnsrLH9o66t20zIk3OnB0oPPUQgDcqtT5
	2/uQIZT71PjQjeQ61CKf8TQiwc+kNww5W4whYeKV4I8czzGdDhEL/+iplqZ+Tag6NSkO6Yu80zV
	Xt8JGQ4Tm8QxA1LinUaZgPixqNqnO+JpDdb1wJu6XVVqmD3DsmnOE1XZt29w6oDfhLYwGouG4Tn
	A6isOvaqnSmPBbTLrbn9TEj9Ct0NVpSXpgh6jLaFb/i6Vy5k2KcvQzC7x+ZrQ+uUBck4vo7aROF
	N3NleigVmJvYvReFLOj4aY4Xnz7EKbu9MRRXAd70
X-Received: by 2002:a05:6870:d690:b0:417:3441:6c54 with SMTP id
 586e51a60fabf-439ce3fd2abmr2218430fac.27.1778687571605; Wed, 13 May 2026
 08:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <20260512211707.GB1516810@qaa.vinc17.org>
In-Reply-To: <20260512211707.GB1516810@qaa.vinc17.org>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 13 May 2026 08:52:39 -0700
X-Gm-Features: AVHnY4JBSQpuMUxFe6D-Cx8XD6uhajnD7mBweKVDG2msjcfEeiHTP9iFXuI0IKI
Message-ID: <CAC2QwmKxiUczUdsb6H7_fnxSwZJS6SAh_moL=4x-FGNNpvm6xQ@mail.gmail.com>
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: Vincent Lefevre <vincent@vinc17.net>
Cc: git@vger.kernel.org, j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2026-05-12 21:17 UTC, Vincent Lefevre wrote:
> Yes, this would be useful.

I've submitted a patch for this:
https://lore.kernel.org/git/pull.2113.git.1778686956622.gitgitgadget@gmail.=
com/T/#u

On Tue, May 12, 2026 at 2:17=E2=80=AFPM Vincent Lefevre <vincent@vinc17.net=
> wrote:
>
> On 2026-05-12 13:56:19 -0700, Michael Montalbo wrote:
> > Maybe something like this would be worth adding to the docs:
> [...]
> > +Word diff works by finding word-level changes within each hunk of
> > +the line-level diff.  The line-level alignment determines which
> > +changed lines are compared to each other, which can affect the
> > +word-level output.
> [...]
>
> Yes, this would be useful.
>
> --
> Vincent Lef=C3=A8vre <vincent@vinc17.net> - Web: <https://www.vinc17.net/=
>
> 100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
> Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)
