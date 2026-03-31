Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7D374E7F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951854; cv=pass; b=nrGbEH0csTUk8RjoxLv1H8ncauSLmr1kII2phFQQTGSZH1OSOdFMMb/9ZAptIlxRCVltt6UjJhYvgHz7rApfCeCKciUmJjNcOnuvPKXJaQkyPKOeSN9pQhIZcMKJuOYAlqpmNi+x4f69kj1iI061gitpOxgXsYOiShvkTFTg0EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951854; c=relaxed/simple;
	bh=pDuumcCPBinmrV4qDdcej9noyTCijGcw6pL87ffRnWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nvgen3ohC/73BUg5J5pFGYac1G9zbCwoLLSEnQoz2di4CBY0733Jt1/FwoRHoPutYBnOjNgGrXZk170Z6nnUxt7t9T7LuE45HPXonXq4GnzTDtT8F2mu1FRg+WFN21IuI8P1nOIWwqpUo+2bjYd/t6wp3VkG5PMlFqzDsVxjxZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPcytAFY; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPcytAFY"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso2116205e0c.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774951852; cv=none;
        d=google.com; s=arc-20240605;
        b=Xyr+nQcQk3Z8Og+np4fjdq1zXDSrb4RGh4n25zpn2lw9JACWWJ73rFkKo3lQJp+63r
         /lhmYFSl5MXkLQgJBzucZbtcFx6Y/9mOs/xA08x70GOYvfR8nACJZjX1ISazj7Qa/FKd
         QfsJfuh8+fdyJiMOeFKCKIvJJt/kbd7N/07eSErFvAkxBEJMYKrbJWeat3G9/mnCigny
         hZJdENnQElx58tLcBtH0eHiGcUe4qbB0re2IVjYK70lHTDZ0gmUCYgMegxGEGDmnuvm6
         tl3PuEn976XI4AcpWU9Yo+SkM4oZ3/FFxIuGTgPXc5zXaXezkg8G8a3KgLnPg/3FVkPI
         K0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pDuumcCPBinmrV4qDdcej9noyTCijGcw6pL87ffRnWU=;
        fh=m2oaRB3T1+1JqKWYoAJfgD54oHaF3IPNat9UweSvYgs=;
        b=dXcRoJuF8R6zNZYunMvbTq0VGWRbQsMWPGR5dja2/zzEYOjtUzc7+zDSC1v7IRAXZK
         dSX7VPIdx+DHQyu56+hazZPcYCkBX0V8/V+/gGd3eKbAHzopIYkcWxPuugYZICDBV7wB
         c5gpug8g+WWU9eyWuohSQlNsNf7gDLiKqt1XWxxjkX0IgNIxJrgGpQwZe4lCgbuXf1Ii
         iFkAl3AQBftjtlgQ0Ach1oQZqyuMIlmeYA39nsLN8LheY2QxmeMdxQaSptdfgDtKi7dk
         ooGHJTyGN0Fsl1/Hx98hw9A7vX4BKNn9H+FPzEcV0XZaD1l5ECSLHfT5UqntPWmYvGed
         /ELw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774951852; x=1775556652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDuumcCPBinmrV4qDdcej9noyTCijGcw6pL87ffRnWU=;
        b=qPcytAFYf1Bo92LQ6neHJ4NUOn0CuBFdIgwQQrP1MXPDhw5HbnaEW9NhzmPsR0c4Fg
         lnd7+mprazCTxFYqwyt2U5NzU9JjQDCxnDHLCmlwaV5kISYKIyTy2MrrSj1qfhr4p3zH
         am+3YTUUciAEi6fARZTAFdC62eQc5t6oUKUSi/Y78FVeRv2006yLi3uHbgJ9nn6eyeX/
         XCXSwp8MtPmb5R93GySgsl7qyfOOz1R4ZabKXbHhRYRABUbWG4XSDks7e29d2QjmOjvi
         HYL3/Quui4xvMxk74+RaxQhmChjULrOhIpYi1ZX6YYcoaBQeTkoiOl2gG1A7AYoBB2eY
         Zzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774951852; x=1775556652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDuumcCPBinmrV4qDdcej9noyTCijGcw6pL87ffRnWU=;
        b=FqW5z5A5KPuA5mWPhq7nqBODMiIx/vaGB+W8aJrBwjdN6FIM3c62b90ro9c1R7xPXn
         PBu6Je/S8gOuyyVJ5goad36qIdzXBDAOnsBNDv0DS7ZUtDKqehhsWornlC+W12SsYQ6O
         wGKdTOmPOAIqPEY9//F2UD4Ppw42v1r1hdfnahrgXbQKdLk6biEUy97WBUo5NPYDKJuu
         g0AZyMsC/LPkSMQ0hGEYXaURfa6iRP4WNT/zeOvSFgsquZdkq1aqo5oEXplWknYNfzCf
         4K/eBBha3+1oJ5q0D4HIuZwGlnV3MNzSwGHzFxkCklycdi4Gl2T+F6D8SqqDiZJNO7nR
         b5gg==
X-Forwarded-Encrypted: i=1; AJvYcCW/3DQESdEPSmINS1YoyWn1VcKaH9c2lyX19hhPzt3T+Nu9iBrJxzkyLtyk7sC24oYmkP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywepi0DpOAzU2vxvrg204NyaWwe/t5II56PFdfT6ue50pPw5qCU
	nE41izb83qKlYILwM7386dPnq+y+F8mcNjQAjv6MQ/588hoJh65J7UN+klX+dY0X/aPoXs8nMkp
	pvvBOwusBsNfH6Xc2s9KI+sYRKOKUJZIv2YY0mO0=
X-Gm-Gg: ATEYQzyoWGrmp6Fc/sNQuoqcm9cNA5rHtqBma3coNfZ3q2NMoTERyNtzwxmQEXJakPU
	WetMBKbkrdoTAej7Kyk3R9MBAjyU6FEGSouzNFioLQB3P05v/Dm43nNCWGIlROuwAZjMnqIRsfj
	Qx4+/gP6tzs1F7qh5D+qLtPHt9myufrEdr5olMFt7yMM0qwrnpaYELhtweW9tvHSJ+6yfbHeahb
	aWB+pN0PZNPR69zw9Zw1zNQaXTKlg2j8sUV+DPZ33KwNNjpn0cFbm29mtx63IQhHoG1uKpE7ytW
	n+Zmu4/h
X-Received: by 2002:a05:6122:1824:b0:56b:95a5:da18 with SMTP id
 71dfb90a1353d-56d4a5f8b95mr5433328e0c.10.1774951851697; Tue, 31 Mar 2026
 03:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aafga8AjpxagiEJt@Adekunles-MacBook-Air.local> <acMT0zqd6SiEz5h9@Adekunles-MacBook-Air.local>
 <CADYq+fbsXVtYZcq2wB2FoyUzDdzZKJYEN2EZk1uOvdihMyJzVA@mail.gmail.com> <CAP8UFD3xsMc+irB0Aiit3rMqHeSqodeKpSRRvjOKFGF-vvmx-Q@mail.gmail.com>
In-Reply-To: <CAP8UFD3xsMc+irB0Aiit3rMqHeSqodeKpSRRvjOKFGF-vvmx-Q@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 31 Mar 2026 11:10:51 +0100
X-Gm-Features: AQROBzBmY-ApTOjpBi04ir7zrvfvRctm4XpWoRoZ8qgcmuG5ikwUbPU0UOgjLi0
Message-ID: <CADYq+fZGtWz62U-ur50_Ee+KvA0BPvXPPQ1dNwsx0+qxPdydHA@mail.gmail.com>
Subject: Re: [GSoC] [Proposal v3]: Implement promisor remote fetch ordering
To: Christian Couder <christian.couder@gmail.com>
Cc: Abraham Samuel Adekunle <AbrahamSamuelAdekunle@adekunles-macbook-air.local>, git@vger.kernel.org, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:26=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Mon, Mar 30, 2026 at 11:50=E2=80=AFPM Samuel Abraham
> <abrahamadekunle50@gmail.com> wrote:
> >
> > On Tue, Mar 24, 2026 at 11:47=E2=80=AFPM Abraham Samuel Adekunle
> > <AbrahamSamuelAdekunle@adekunles-macbook-air.local> wrote:
> > >
> > > Hello,
> > > This is the third iteration of my proposal for the project
> > > "Implement promisor remote fetch ordering" for the 2026 GSoC programm=
e.
> > >
> > Hello.
> >
> > Just bumping this up to know if this version is okay for submission to
> > the GSoC site.
> > Thanks
>
> Sorry but we won't likely have time to review your proposal and other
> proposals before the end of the application period today at 18:00 UTC.
>
> So everyone should submit their proposal on the GSoC site as-is now if
> they haven't already done so.
>
Thank you Christian
I will do that

Abraham
