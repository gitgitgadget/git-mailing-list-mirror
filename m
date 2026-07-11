Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C423E342
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798638; cv=pass; b=ueBq3WI0XbmuEpFLfLK+ebF8vGJr4CYq5+VnJTav63wKp5J9CEP+bWY3Sbo1BcxiizYRCuhhcCm2HE9f5XXAnW1+S+4mbbIPiIFkTY8wYOu/mkK2WG3mmnsxQ/HNb+hBfDruyowYO0Jz0NG10ttCKskU/wazNjQNvhAohUxnj9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798638; c=relaxed/simple;
	bh=/Zj6fVqDKcbM3A+90+wOBUsBpc9M2aauYBg3gc95B/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duAkUbBCKI0149lR0ydtXhHoU3uw+4q0KsRwQDzCsRzWpGD8thcckcOQM0idTj/j0gc7Ky4Jklo4y4rzgL+hz3O76kLAyUQoC6LPuWb+IFlGuH/GQsu9P+tZwQ7LuroBICP9eXYpd6yDsMbFAdTQ6YRLN/0yrbQDb1nv2bu4fY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BB21arjA; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB21arjA"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so3596153a12.3
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 12:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783798632; cv=none;
        d=google.com; s=arc-20260327;
        b=bO0ObkmEZFTEgdFAp3iWYkqydKAerAN8G9E9Edzhj+1oO1NjKaG/7Qgu3AoWqjtvSf
         YrI631Ov5pDF0H/L0EMhGJm1fdGg9+y1OWZZ0VQdNjMIoLOtLt1rxnYbYa+lpzVCj+vD
         xZiVRrhPsvQ7JBDsnwTv3u/rXkGt0XN0NhOCfx3bARRLxOVtsB7uvzIXSFu+gLotHpQ0
         pno97Sr2rE/IS3DMYh894BsSVYMtW+v76Vnl0iMVvcjSUGaHuEXRTx6vsTX/O5tgoigb
         pxQTAgUmaTcPF9LkZjI1Qn0j16XdBjuMqln0g2awQ3G7tx8CQ/5UUJ3KHbb26CeyMv4r
         TX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AkbHm1K5u6OAFqaysuk4AhQcdyDJkzg4v8txO7xC+30=;
        fh=JW9NUcRUJhEPj4qHKqT/IDGB29ZLHQdGw0xcTpDn53w=;
        b=R9XlhTloMgbcIFIvr3nzwltpYUgce6h5frkfI+7b//hxFy82nyqSy50zaq9P0UoCQT
         Tt+Ozv6ifFf6XlrjOvcg/4y0qcBU6wo3jT+D2MrW3RwXemUaIfuIbXBwehYUne2qxCHa
         WHWLQgWhqHDBZZLFM68BELAuLTUsgx6a4dROFELKvcczaSeIIEnAeeY55Tzp9FP7AKN5
         r4vH9TrXRx8+e7ULR11/vRdX30tt7ipnZyuHj8q0amyrIHFnmmxzkzpnBo6/xHhyNxpv
         xY1UGNqjN1ZDfIQ5bwkFa+RmA1RyxlkUsx6hmnkADf181cFhcy364vScp8aeb+Bz4waI
         A6ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783798632; x=1784403432; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkbHm1K5u6OAFqaysuk4AhQcdyDJkzg4v8txO7xC+30=;
        b=BB21arjAznPjw3AQyI+7EknQ1ybqB3iVUnsQpFt9jdjHgDSu2W1zBrcevDBXDsPE12
         SN+BRdl+u90ut1NpiQB3V5Glk57qA7gt7nVBNoNcj3JYiNONXfDkvel+hUBfyZqrBUOd
         0desoffYJxWTc+JjV2Q2jBCt/qre+oCsU1HQjYx3BBeK1rIyulOwueIVNGspvWiO/sXT
         xzjiq0ScoDkwXGIDGnOYQ8BJrsroZIw2LqmU5gbC8kUy2+KRC3R8vnaCK3qAik1czY6g
         yTNl5ls/fR4KBd3XqIXKEx7fXbIK2sJcS5mNsG5tWHmbpNI/OpQeAyc10CmWJrLm/05t
         Of8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783798632; x=1784403432;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AkbHm1K5u6OAFqaysuk4AhQcdyDJkzg4v8txO7xC+30=;
        b=MyKxXsDJdblJhw7/VERPwH55N5TkPo0cVVt2ht7t6+hLvnDbubzU50AbWTdtCKNCGo
         +zwSKa8KSlSpDq1VHheNNSo5bmA6mVDxx6BqXRv1rThfe5YqHdEkkVol4/aSUzJHMXtT
         kA8SWTMLjvwpkPm0PY+L2uaVcOEMN4b8eVv4qx1pG2EQPrYSzSCkiAl+yDPgqOmIS3PG
         aswGigGdjJvHWEo8+/0N6W/hUS797wWGuALuv8Y37UWjh9yKcRPRtCNPqXgkKFxHw7ob
         kLgRQMX00bmAzdA0zIuxkRZdOfpmLVnP9MftVWtBtzU831CgzkHvuFusAcel8RqhYPEP
         b/sw==
X-Forwarded-Encrypted: i=1; AHgh+RqB7n55qHG3dmSIl1HJqK9MS0rGCgUj2baCszW65IYbWc7JyWXptCtBOJ4sPbaw5GK/PIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoRY9RT8Xw77bGXId04MjLnFE4upQObkbU0wiXeS8AMLSDj25
	bDpqMJMdrcdn+Szz7TL55VKg+3b1BxrOaoIMy536UIMnrQC4yQtV2p6TV/AQddK7jVLzEWcV7qT
	F6bq2DpoVmgwedP/UIKsT+dxhvbQDDWs=
X-Gm-Gg: AfdE7clD9sowGERMIjSrgvdVohHasPcHnfUZQb4yEZPk/gqEZCWD2rv9ofm8WdWhm2X
	XxojgUot3wxGmjBJc6NVEHjfZG3wqQ50ZVY5yMTdQiUAObmFI94ADQB6ECWugr2+/n4oAnx8O+N
	GKu79QHGz70Tkhh89XrTXvXot24nyOQHz98VajOD7B298Vya4g0pVj0ej622UWOl8U7WTDECwGu
	ReX1P8J/+6SHg+z7k3IlkgtVdpmmq14LwF70M/aYZN7qUCqX/DXgyGtIk//33B5gu4tJ79F
X-Received: by 2002:a05:6402:5190:b0:699:728e:48c0 with SMTP id
 4fb4d7f45d1cf-69c5eeb867fmr1690242a12.0.1783798631513; Sat, 11 Jul 2026
 12:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com> <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
 <e35f1268-2518-4a44-9c7c-28ba13ca7b7b@gmail.com> <CAHwyqnU0ifHu0+GfMR9GqWKgFrTOyQn-FbUH0wTm_07nCa26tA@mail.gmail.com>
In-Reply-To: <CAHwyqnU0ifHu0+GfMR9GqWKgFrTOyQn-FbUH0wTm_07nCa26tA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 11 Jul 2026 21:36:35 +0200
X-Gm-Features: AUfX_mxmotIEypov-KKRfXt_SNVjaLQm0MnL0tz9p61JnEO4vrmpqKwvamiO0AQ
Message-ID: <CAHwyqnWspUTSnqmkMyXtWuAnENDSzrRLhhUR=Ljtt1xer3tphA@mail.gmail.com>
Subject: Re: [PATCH v18 5/7] branch: add --delete-merged <branch>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > > +     (
> > > +             cd repo &&
> > > +             git checkout -b mainline main &&
> > > +             git checkout -b on-local mainline &&
> > > +             git branch --set-upstream-to=mainline on-local &&
> >
> > Why do we need on-local to track mainline rather than main? I'm a bit
> > confused what the point of mainline is.
>
> It's to have an indirection of a branch that is the same as main but
> will be protected. I tried to delete it now and replace it with just
> main, but then main was deleted and subsequent tests failed.

Digging more into this, probably the most elegant solution is to
replace mainline with main, but then also do this:

    git config branch.main.pushRemote origin

This exposes something that I don't love about this feature, which is
that when using a pushDefault (like we do in the tests with 'git
config remote.pushDefault fork') if not adding a special case for the
main/master branch (like 'git config branch.main.pushRemote origin'),
then it will get cleaned up as a forked branch.

But there was a lot of discussion about this already, so I won't get
into this again.


Harald
