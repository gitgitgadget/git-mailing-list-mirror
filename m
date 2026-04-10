Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCD39937C
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819114; cv=pass; b=BHI7RoXXL5ODTJdcspgySBAxeVc2TwtiI8QhhlSVCZ6sem23WRQGh5S6G1K9GFA2wzUYrJgiTsPNcMQeadX1q740AAgusCiX+b+py2U/dzDWXxv2Ph4FftA0PSwDLwTgtD2BzbYAXbeiWEUxgzReK4qNZJ6jvXLpmtMsYj1D2/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819114; c=relaxed/simple;
	bh=7AxPF6nqDV9671HG4X31x11u3/sP2uEIlXXvFCo8ewA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCi9k68b1ihqf1OhjaknBkjaPfQYf2nUgPUjVs5N71KDL3WppxdwjTK3SMGW33gmZtYn7hWsR3B8KwBDTdNekClnCQehKgFgYLt08pJHwXPbP/BJXQY4m991y11B4ZaOTVfZ8E4rJPaOIE39Y87yDWXWRgLCP3USBslLUVsqKMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNhbsfCV; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNhbsfCV"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c1fcce8f8so568464c88.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 04:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775819111; cv=none;
        d=google.com; s=arc-20240605;
        b=ROyllc+5SHdwN7lFFV5TpgPJnBKAu+wA7+SEGigkiU9MkD8OAi0JRyZBSmu6gfj9xw
         iPpllXPUnl1wEZWpgGSj334sZxYcJcauoPiNWozzSMhPnhcASC0OB4J+2wnW2tr9FTBC
         04JL3kGBzXpif2R+UhA04gzchk3/vBaE2HCxiyOGh3qxsBDJEENJ0oqHnTkwyviF4msW
         oQhv/1vL0zE2AAb5jQA/Jiya+M4Bg1fn4lcFIN+za/+S6+zwyniCZp/9kJRlBoBc9XDz
         wCAL4gcoJ5lJ6CFyVyliiOdlRs/Raa7QM1y2p0rRQuEpM4ZrziIe/WfsTcB8qeizVM+1
         GlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7AxPF6nqDV9671HG4X31x11u3/sP2uEIlXXvFCo8ewA=;
        fh=ePXSx5yacl21xM3GVx8Sf27H+w4mVnSi3rJ8TfnbTGk=;
        b=YKs5Kk7p404BPfMB4E6zcyaBeYo4nuQ6/STDQSh0Osmp4Q+q5fKeCDxbExpr/BYgip
         caVH8m4Sbr9rdO0SgaMkew1ZZVhhL3TgR8m4lX7xAkLrBtjTHJHxjpURed3xupWhBzcU
         HPOcZ5DDc/j+KJDwvYWmw6OwZdKq9cz4OuVdd8ih8nsYvU5svEZtHKaNdkVeZ7Lg6CEQ
         VwdLOO9kLPzOycHIdzsTfFruNTkaVhhI24kwBuYzWNcFCFRie6uq1n6lfVWFD7GQKCMu
         BKNMMQzkXQXb2FFGrhUk8TvzsnR4UYZ+cABAQJairQFeeVBOLNcrFEOC2OVSonXLKfAL
         3Vcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775819111; x=1776423911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AxPF6nqDV9671HG4X31x11u3/sP2uEIlXXvFCo8ewA=;
        b=CNhbsfCVZLsTluFzU5NKMVqJtSHN8z34ynAwSj4j08KlRm5/vqiFrcy06xTIt9SHii
         8Sqqqkr2v8SvJWl2FrSWeAxD2HfQroqRkze58bws3PuXCHGw+v/4isB/XZ2Ygr/jr2z3
         dqqksFsZ/rUNCXwhPVY9b5AgOFm6G0xBFvrSt3oiR5W72zbo2xeN6+vbTHsHpBNMHN7K
         2QxWpwbI1Yppt/mxHKVMrASisaBNe5GDFo7QLxKQcputGLbOFqAbuX2rVNVPX0QiJWE7
         6b+QF/IRiGriqxNssrGo5Psywf6V2IL6zybSHwgnISAeE92ATxusfclVUqXcNRWSmvYa
         +MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775819111; x=1776423911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7AxPF6nqDV9671HG4X31x11u3/sP2uEIlXXvFCo8ewA=;
        b=ppiEpNUgaG2xrBlGl2MXjqaZlIvQstcYLypa/uNXnfs4SufLWw+Nxx6zk/CkY6znrO
         xcl/TUWd6ZU1D51uhnMYPPYxU+cwXeTgFM8hlR2y7bHDGu66qOoXYoPYLviLOixt6hKY
         UFTJ+i4Vy8YCmETlS4g5ZXBz2CL+zVy9BmE5eBzYUP5oTNyp0cdt8VejI1MrlSkWDGDa
         Mfxw4lZMSQ68ao10pcY2uJEk/ZYtBnNaOr4o00ooFqQk2hlIzgXpI7ADY/eqngkSo0W7
         Udj4huEGvzvqB4IiBhC8ma4UelK6uH/x85g/LLDQxNpMp5LwdEEfn9OhRgsg2KVrOOoM
         fYAw==
X-Gm-Message-State: AOJu0YzY1TgW5czzEpgkM0JX2GuK61SSPxhx23n+04gYXQ1FnWXYnr3e
	K9NMabk2Xeic0CVeL+wbwhQqOBOXaD+v+msiHnjSvP7b8YKEZZ+JElwBTP94KEi/pEJBEX7cj9z
	WzxC+rmw/Rq4QSPRuKIi65tthZkrjbqY=
X-Gm-Gg: AeBDiesr3x5Wn5KW2QGpNJyXwO9MO3/vFa4ygjQCA9BEwLhYg+kdWqJGFgo4vABf2XQ
	5M4bgnSWmKhM3GzeyVckyselgaDqd4mjwmTTVYOWs8V5E3X/6cGsUh9Ey0feNwrvaYi9IcfRo5p
	iBn0cMVRnvObtdsHllxG+JFHsO7dpfC5R6Kk1P3mrJJW5TkhJosppTe8VF8/qtWfOYeKvBaEHUC
	vMP8BdAKJek+QmA9o7GAuHrw6O+bYgi+lBQLn4heyVpR1Y+QIj7juvV55rv12L8DFXMymdbh1Ac
	iqfV8v8aawbAk9Tag16a0fQJ+XGgJyeQV09gZLbaXNJEpcMNdNUGKWmeS8nNY+FoleBn
X-Received: by 2002:a05:7022:2528:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-12c34eec8d0mr1714047c88.29.1775819110755; Fri, 10 Apr 2026
 04:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7207a7f0-3806-4ff3-a3d2-2cdcc23f913a@gmail.com>
In-Reply-To: <7207a7f0-3806-4ff3-a3d2-2cdcc23f913a@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 10 Apr 2026 13:04:58 +0200
X-Gm-Features: AQROBzBC_OjWE11fljqpVBEMQPxsKWKTCdL8WcpzWYcFtBtsesKOZM3q2vvHrGs
Message-ID: <CAP8UFD3QhuO8JWpLeQXVQRXRUSb0P1zoXeNvhyf=vsS-EqP1rg@mail.gmail.com>
Subject: Re: [GSoC] Call for Mentors - Help Us Welcome More Contributors to Git
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git <git@vger.kernel.org>, karthik nayak <karthik.188@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Justin Tobler <jltobler@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 10, 2026 at 5:01=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi all,
>
> We have great news and a small challenge =E2=80=94 and we need your help.
>
> This year, Git received 19 GSoC proposals,

Yeah, 19 valid proposals from applicants who spend time working on a
micro-project, on a proper proposal that they submitted to the mailing
list and often on a number of patches and reviews.

> which speaks to the growing
> interest in contributing to our project. We have 5 strong project ideas
> [1] and are working to select as much candidates as possible (at the
> moment we're capped at 3-4). We're constrained not by the quality of
> proposals, but by mentor availability. Right now, we have only 6 mentors
> (3 primary, 3 co-mentors), and that limits how many promising
> contributors we can take on.
>
> That's where you come in.
>
> If you have experience contributing to Git and can spare some time this
> summer, we'd love to have you on board as a mentor or co-mentor.
> Mentoring is one of the most direct ways to grow our community =E2=80=94 =
many of
> today's long-term contributors got their start through exactly this kind
> of guidance. Karthik, Ayush and Chandra are examples of GSoC
> contributors now turned into community members contributing outside GSoC.
>
> Even stepping up as a co-mentor makes a real difference.

Yeah, and co-mentoring can be very little work.

> We also have one self-proposed project from a candidate this year [2].
> If anyone is willing to mentor them specifically, that would be very
> welcome.
>
> If you're interested or have questions, please reply to this thread.
> Every additional mentor means one more contributor we can nurture into a
> long-term member of the Git community.
>
> Thank you!

Thanks.
