Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81811701
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796075; cv=none; b=XUbqV9Tp+ETbybfA9nnTg3IstchE4LE7+ydMyO02ZkTTPB/lO6kYj3GRq7sqC5A1S0Dym+eAUU4oWxhk1Bm44tD4n4qTnXEn02r85ehE0y9yTdvYO+KLUC08HRtRPLJ5ED9k9uwzfUMapmy2w722dBTwczaj/dDhSQucBbo3Ops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796075; c=relaxed/simple;
	bh=eZjj2QO4oEI196jBMGNhvPpYPjCBVH19vluj5ou0MW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9ya16r7w/iQbdItzRP4/2VsqXgYsHNVeUAk6FnupQSV2fCxYsJPD2vObmXcdUT4Y6eRzteeT4ruwekqPr/i40bCWxSEWC/pIHd//UeyDvCEjGLCpbC8WNw/56YxQrLP2+a1xZOjtzoYgSIjQLEQmU8G2XQJj7OQcxlK9fphQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0Sg81t5; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0Sg81t5"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-365124888a5so5101665ab.1
        for <git@vger.kernel.org>; Sat, 24 Feb 2024 09:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708796073; x=1709400873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZjj2QO4oEI196jBMGNhvPpYPjCBVH19vluj5ou0MW0=;
        b=F0Sg81t53FAnQt2Dt0oW12hYMzVVG+6oGKmcAKJaCmSYscZQw/4ygMQBPTZZteoRMo
         MiPEivaykpddopKVXdwMbDGr1Rl8Lx0wO4ZNBtbi1SYvklSvpDMFi3tPO7fZJUC90260
         +GRlV9uGZwQH3UQjSubEers4rAnuY4EYHOr3uRjMJPONvkqwFgjVf53LdqEKdEt8ahhC
         iGUintF+M24pxnXn4M7ccw3wPdD+4IvXjRvSSOmE9JQO55R9184BSG3ChAIHFnwtb8SR
         gMa79lr9xhpXhEz1lfql3Lt9TtQS+KNaVYD3wrkabScir8TDcXwtzPfmauN5OWjyKaja
         c60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708796073; x=1709400873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZjj2QO4oEI196jBMGNhvPpYPjCBVH19vluj5ou0MW0=;
        b=oXeQWD59ZmX+xu8+sL78w6IUJLH5i4NdGYuPZUL5SEzgLaY17HBLKEuQ8WJBj+BN/f
         lMoPtPOZ5J0KZGmvjRztrUrphAQaASvJz8jWrURkxLG/XgNw6WCQYhx3xszA1Ur0WFK/
         AHHEQ5Bt0/H2KvbVhLMLNcIskeY3lnP9WMTJEuRyYswKjAKDzu2GdpPxGtLiHI+33lsg
         FL8obQAlHCrWTkfhXaYriJN67ZE2LfIGgoyMaxVAauq4hL8P5eCDv0gmrqjPzkLhzfPN
         voI4rGXZ2HCsBl30HeXo1QSY1Ff+A5GPuzPIX+7Jf+AihaXy6yV0fW2LpGYH3+6USwQs
         uCPA==
X-Forwarded-Encrypted: i=1; AJvYcCXVxPWorDA8abMmWZG/ichSnY/wzyQBQ1S/f0vZZ/TvCOdcgmMcgwBYbjbr8bxDHYKGhrgHgOcu5MQEpr0hz1zeeQuu
X-Gm-Message-State: AOJu0Yy5icRallVQChTbIXY1ucvIsNuvjrl/TBQjYKuxPg855bMBdDig
	UrmyEewqK2ciXcA4AVx1BhR3JLf8LrFt4hr8UAZN4OaWpeVfgs8O2xH5yZ5x/CEDFBcuRbWz9Y/
	ptF3pUS3zzY3cADtpn6hGVcIlQhc=
X-Google-Smtp-Source: AGHT+IGpZrHMl7ODJ1xeE1Xm954+4fgyC93wDpGFTi4SbhRIXmuoDieJw6TaP4T+lu1LWY+66QtaDGcPy5hPBj7FkUs=
X-Received: by 2002:a05:6e02:ed2:b0:365:2ffc:b747 with SMTP id
 i18-20020a056e020ed200b003652ffcb747mr2852503ilk.17.1708796073304; Sat, 24
 Feb 2024 09:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbpGzAd6FGEeTdrh@tanuki> <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki> <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
 <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com> <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
 <9cec06d8-971b-4c5d-9d85-969021b0dd48@gmail.com> <Zdb8lnUSurutauRa@tanuki>
 <B6C95613-B316-404F-9076-FAC5955B8890@gmail.com> <ZddtyZqX1ME741j4@tanuki>
In-Reply-To: <ZddtyZqX1ME741j4@tanuki>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Sat, 24 Feb 2024 23:04:21 +0530
Message-ID: <CA+ARAtoeG0hoW0=eH50SCN_weUVoLYV8Cguxf-agz62Vbbfhjg@mail.gmail.com>
Subject: Re: Git in GSoC 2024
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick, Karthik and Christian

On Thu, Feb 22, 2024 at 9:22=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Feb 22, 2024 at 07:35:33PM +0530, Kaartic Sivaraam wrote:
> > Hi Patrick, Karthik, Christian and all,
> >
> >
> > That's strange. Could you possibly try logging into the Summer of code =
website [3] directly in an incognito window using your GitLab account?
> >
> > I've previously faced issues with logging into the summer of code websi=
te due to an add-on blocking access to other Google domains. So, if you hav=
e add-ons that might block resources accessed by the website, could you pos=
sibly try disabling them?
> >
> > If you face issues despite all this, the only resort is to write to GSo=
C support about this issue at gsoc-support@google.com
> >
> > [3]: https://summerofcode.withgoogle.com/
>
> Things work now after a re-login. Kinda strange, but so be it. Thanks!
>

That's good to know! So, I suppose we're all set with adding Org Admins
and mentors for this year :-)

Just in case anyone hasn't come across it before, there are a few good
resources related to GSoC mentorship that Google has put up:

Google Summer of Code Mentor Guide [mentor-guide]

Mentor Roles and Responsibilities [mentor-responsibilities]

Feel free to check them out.

[[ References ]]

[mentor-guide]: https://google.github.io/gsocguides/mentor/index

[mentor-responsibilities]:
https://developers.google.com/open-source/gsoc/help/responsibilities#mentor=
_responsibilitie

--=20
Sivaraam
