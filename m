Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AAF3CE4B4
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941968; cv=pass; b=Gkmf0tHVSvK1PeX8bpSN2sZe9/giJ1PRvRAcpQELG+xrPittmXiQyZryAxroQ7Z6YMn8xmS9NfQH0YDRxDThG/5mWHgyKejcb6gKiLOfJJwCAgnUuciGxZrri1wyB7O/1+O1sNRD2t89apgBt0MTa0ZXoIseIIGXhbXteeuDPCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941968; c=relaxed/simple;
	bh=bslw7QYb7tNfa+yk2EJn7n/ueMoeDNz1E7HMD4QJWLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqmTvnBeEDk6eJGCOYIoFqYv90Wnd/dpuKmaX8bGCyh4ne2/W4SobLvTgB/L2D/OzfMt9bGWpj5R3Gz//fUuOptiL1BuySVKBQdBHBI4wfSjifqInKvuEOERV249mz8Vnsa3AgoNumDCoATqsYjOZzy4QGV6XtPayoGJ7brEyKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1ercfnZ; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1ercfnZ"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-41c4d660b19so1661786fac.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 00:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774941965; cv=none;
        d=google.com; s=arc-20240605;
        b=WXh18QkZCLbOIlrIPmv7VjzbMdI/BJPBC8lIrIUtJQRQ40CyiJmkmisCDWSldx30mF
         5qEzumQU8k7xMMF1Sud0//dC0iUBAJkSwbPkJhvdxmUG0mEmfwHEEBUDSt2EWIsUIpNK
         hw8d3JX/p1R6KRnVDJESmyNMzwbPCEBL0l3OtpZn2l7Ff6f1S9f6Q1psXOeTPYAy5X1L
         SR90r0rHuf5yCsI22LnLekBhl+bWEeloVqKYnQN1K2OchEi8tXq+9pEK4fy9hlbut8PK
         x1lDFCSjC6q0N9CfVqXuKnpTThe8AJrbteQxl8zAUml7BrBoJfM3X1Gczx4PR5ICjJeH
         RlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bslw7QYb7tNfa+yk2EJn7n/ueMoeDNz1E7HMD4QJWLs=;
        fh=7LqtyqQ6wrY6Db0YlukneDt8m/L4mg8KO66ooiYm+34=;
        b=eq5YaPTx58XSBSuoA/ehuWd6+nrhWWvA6sGhs5OnFl07T1+luMWAhByG+a5wRAsUrJ
         9M0MXeRpoZeDk2+PXgPnoPSceDcgOw/JRMTJCkowMtp2Yrh4+XF6LOPEqYX0HInjI/uq
         6j7rxP9mY3AmHZ6Ki1xuIwn2cGM/D6+baHAo2Lz+WXLgQxC6iJLJnJgBsoRkp4XZnINS
         oQGDmd8sPSyjwi1u9z3qxvKkKyGvFarQ+7N8znaO3JREqCCvoRR/GvQaD5KRT/K/zXD2
         cCto9JFWObhL/zCuEZhhYBGW9IeFUqeJHf48FclHaWbqoo60M7a2qy3PqWP3GALIyl7h
         2/kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774941965; x=1775546765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bslw7QYb7tNfa+yk2EJn7n/ueMoeDNz1E7HMD4QJWLs=;
        b=U1ercfnZ2/+IIKktPoZwr+Ngj18/60n0utwKJ9nilt4sqYzJp12x1BMCbtxHpctRs3
         xnTl+3PXNZOkb9mHN46OVPkBbbqMZH02Wovl6stCWeotz3+HsTt3ctF5uBpwDy4eK0PJ
         PEqQiJAMhMH6flL1zX+KAgRCvlylhSjY3QkKM40QzsYJddhGI1ZHPNVsp1SaOE58dCSF
         hlIAg+quu7uNQzj26AHdyNMmLkLbqcppT4TrDZ6L+gMTUPxRbogk5AmAZBjKaLkWj+8N
         9rFG2yylviA01F0kacvOw1PHjzrGdp4m1bZizy5une8kOJ95gptyOkJxKSVXp5WuF8ju
         3Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941965; x=1775546765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bslw7QYb7tNfa+yk2EJn7n/ueMoeDNz1E7HMD4QJWLs=;
        b=lg7hFLv8Fi2cmZSqRprI1tt715KekrYalT7CbgVYuVWVZU/R9P/tBIVdlJjbrO3HTG
         7FqkGEioIxJCk769TA3YRyV/OKjkxvAxVDymv5Y7ytelf+vcDeX30IVyjsLWWaEL8GP8
         MEBZRUsi/Y89s39HtDjwSZ4VOmN/FC+sWzl5G0BHiZ8zzHDKt6xFrIQU0G+o6ca4Hbgs
         CX7eX3hNSU6454nTKo/Lt/CLFtkDvr1QvrTyTZGFUIyEbxN3vlc5aImoBEE4VvCfNCGm
         K79hTXq6Oq1dE2OYKTBAgzjLtqRV7O8vbZDVHmfudcKqaN/G4M4+Ik8T2YqPtbVyKio4
         pU/w==
X-Forwarded-Encrypted: i=1; AJvYcCWEz63sRXLy0sXDVNUk4IWIDkdes9PyFEJhhedgYa4/fyFQSeOPfn+MeHO3PH80toezTfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wdh2qcetCumhnL33MtSfE98IDqQ6iLhFF/oLOpygJyhVFlB8
	Sv24RfOdEh+/b+vlX2xc9ATn7YhFizuxFSYviEcTX/59HnpTQb4GTYujAbKu9PZvYAzHgkDWQ88
	MNeckLbbLqHk0J+00kaaBcrLgK5xjknM=
X-Gm-Gg: ATEYQzyDfTUFmyyzjmR3I7xU/xQEGUcx43G1hLndZzu86vsYVLYcBnCwFNVmu72ddDP
	mDDd8Y/11osk4Vd9jKu7vt6L2//SP2G7rmie7E+NxI3g7OAaCVb6rR7Gq2eW5tD96LsY738E7ul
	HSlbPBMAQphNdNAlUY8c1f5fUTK9DbXJitq7triYaff0K137SOveNHt+kj78srdJuxceblPK5bG
	za3JRfgXowPm6AnNAi60kbXBdFcple4WPLoTujVUfBFviKXq0Qs0EyKwU+6spiARSkPhGi3e3Bq
	iH6XLw1ttleMQYCXNM0T58t8Pr31n/qhGpS3NofRpPGpzEK2QbWmCxGXcGSLYO1MVJdB
X-Received: by 2002:a05:6871:7517:b0:417:2d6d:b7ad with SMTP id
 586e51a60fabf-41cec1579bdmr8124064fac.21.1774941965108; Tue, 31 Mar 2026
 00:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aafga8AjpxagiEJt@Adekunles-MacBook-Air.local> <acMT0zqd6SiEz5h9@Adekunles-MacBook-Air.local>
 <CADYq+fbsXVtYZcq2wB2FoyUzDdzZKJYEN2EZk1uOvdihMyJzVA@mail.gmail.com>
In-Reply-To: <CADYq+fbsXVtYZcq2wB2FoyUzDdzZKJYEN2EZk1uOvdihMyJzVA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 31 Mar 2026 09:25:52 +0200
X-Gm-Features: AQROBzAQb0pWRs6dO1Uo52IADQSMwZv5CTWHsfW_lNGrz5sqy7Kt3aFa4hKu9Qg
Message-ID: <CAP8UFD3xsMc+irB0Aiit3rMqHeSqodeKpSRRvjOKFGF-vvmx-Q@mail.gmail.com>
Subject: Re: [GSoC] [Proposal v3]: Implement promisor remote fetch ordering
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: Abraham Samuel Adekunle <AbrahamSamuelAdekunle@adekunles-macbook-air.local>, git@vger.kernel.org, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 30, 2026 at 11:50=E2=80=AFPM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> On Tue, Mar 24, 2026 at 11:47=E2=80=AFPM Abraham Samuel Adekunle
> <AbrahamSamuelAdekunle@adekunles-macbook-air.local> wrote:
> >
> > Hello,
> > This is the third iteration of my proposal for the project
> > "Implement promisor remote fetch ordering" for the 2026 GSoC programme.
> >
> Hello.
>
> Just bumping this up to know if this version is okay for submission to
> the GSoC site.
> Thanks

Sorry but we won't likely have time to review your proposal and other
proposals before the end of the application period today at 18:00 UTC.

So everyone should submit their proposal on the GSoC site as-is now if
they haven't already done so.

Best,
Christian.
