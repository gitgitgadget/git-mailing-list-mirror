Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6603932C6
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734030; cv=pass; b=k0pP9whNNu1T25p8t5lD+kNgnjCAnjPKklTjoz/2ne/eQ4baG6KjC2mQRXOzfwWAXmdUwAPWMKpuFb4Q7QQgwf8RgErSwpgKsY2PszMH0FKJrtasobok2v92aAifZ5LTHMpoRyhKpbXUegT1kJUJXryW5Xk/tP3EWDiIBd9QPls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734030; c=relaxed/simple;
	bh=ktIRR/G85WodxA+gPkYzPMhINiXRmfQtxrFtBH/bLhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Juy3IiztsKVTu2ZOKdaQyKAsT50AnsYvsbpiy5oiezzOvYbH9KaAwmJT7IikqkFcZjRj45mO3fDKpD2SdZFVEIS5M1nUqzJBziDX/9ro/bkBPQc89OG1GbYbYfFWp4+OSPenKAweRhywAGqp61BGX3tB3eAEdhIReuw7fH24vAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4FYEnpk; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4FYEnpk"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a857578a8so1996073e0c.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773734028; cv=none;
        d=google.com; s=arc-20240605;
        b=gPAJkix1tWhMq/0p2y0bC7fgpZZEH7CLMQNrzEjnyb2tMk6aFEbehJ/pT1Nu3JRWL5
         Xdq9s+szeB5SGJLiNEQ1yH1mzk0nbpaG0g30QMqLS/kyeuAGkegdb1yuyWWJpxsiL2M4
         ukECNCtiq3fWRMcwvnwolX9KgPYvCmU5u3iOikEoCH0YmfePWWCw0MEGae4BdeXyTgNr
         Mx69Y7edFzDJ2W68k7cC9UEbUtfFBVTXNOTz0YiOiCYKn3Hn4VY31amLYfuwDoxwZE98
         jZXd+1IGkGr9hSq4N28iY3Ldj9XJU/ZX8M2dWt9r6khr0ebxaAZs1WVoq3g277QK6CSO
         3RlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sfIp8ns3ggHZqFZvq39g0AwQj6Po83wQ+6ZI0BqLUYE=;
        fh=v9BZO1JMr3wj2YYloWbLOz0poIXkH3JrxGaqBjZKLWg=;
        b=KFLVsTFpUQlQ01vHw5PisT6qyjSzFomI2exizBZ7MYcn7nREv6VdUG/0Z3/X7nusNP
         G0vKqoz9Bpk6JY+HNPGT7EHYFE3560/OY3KTTez51V2+eJ/0CDW1NMKtbJM7qZv8aTL7
         Xrk/E8tV5nrsnrdXj1r0+Z9sREy86JCELzdBuVNys/V3OiD6SB+xedgxcL0AzsB8beK7
         tlue7oPhrSHTg/bC8Cr2YFlBBIqTjc2c/If5o33hdRtigCNG1vXoFQb8OQSRCTGqXwoM
         hEq+YZCkG4YD81SfGifi9aur513IUw9Q7XdSAzzvXB4/aC+2wF1K9jCdCA6L0kR/ySL/
         lG6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773734028; x=1774338828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfIp8ns3ggHZqFZvq39g0AwQj6Po83wQ+6ZI0BqLUYE=;
        b=Q4FYEnpkFVNRsekXeybvBrwR6KciG4/Ks6elAaYRgQTiMhWEfbxipIHOScRntt5tHs
         kuVVK0A/sXvhVRVXzu3UKC4s8WReqFivk1QN1eqKNi09lsoCDNiC9xmIZLbC2b512vmQ
         iEYNDCBvN4D3ONUXAEaimnQgKM9G4qPax1R9GgqoWxWgeoDqFgsa7QeTpt4t+BLdjfHf
         epwc99kCbd3f2zdGe8KOs4dw64L0C05Kt0y1epovFKOeEVZ1qX5wbiGemjFNl2QzuYfW
         QbkeqpvJbB8bNzgoxwAYppWI2XX+xz417xTH6N8b3klYZNq1BSMu+fYCrKpe3AtH2Nxn
         2fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773734028; x=1774338828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sfIp8ns3ggHZqFZvq39g0AwQj6Po83wQ+6ZI0BqLUYE=;
        b=X3fO3PxQdgGPSN6ZcuUCzB+XG1tfjcxy3L9/fTcPKANzGwhd6V+MH9tOODbHisxwGt
         yao9wf1cMJ2CEA4LcJWbsbfKScExupzBb5C2HRzXNqItE3fUydP9T1QBp32QxMrfjRUL
         sJ82YiyM9onUd0LUqrDIXmX3Q8M1popxFnOPCckElHWYXHfQ5VQjk6sgBm2RhqYWYl22
         x8Bx8T5eJatMeDZzrFFt1vrWgYtdI74jOovbmj6DaCj5X/zXKatRAAMiPZkzOctIzNT2
         DcE+DLLDxRJexKR+Ru9PYL9MI9VYRH+GwLyW+6DWMKySubsFJ4of4cXm6USomw+sRcUG
         ravg==
X-Gm-Message-State: AOJu0Yyq7zZAwyjbZq8xTmR++e4ME+Av1njEU9Kby6EekE6cLRE96p/x
	ZsBVSL+sFrBC2yXS1UaizMYGhQbrhodaJjeNnSQ/vKPUxGU0VE6RiFrbGveXinolbl7XuEH+4Bj
	hNqsjBF28j83Tp6IHiTbNbuDCtNrRIdrI2C3e
X-Gm-Gg: ATEYQzyQigzeRC6yNPiH2wqbDoU6FaTcn1y6JEYqdPEIJdNdwqLKO0nYutdqXuboCY6
	orzcTK8Rfcrf/v+MnvKFWmNruDSh7ixWPdCWC1c7Ai9HPn+TkTYoS65dwM6qBZ7wtBG1VB3siCT
	no6gWBKj+Oa/1FPY+O/L8U5NgD9WDni3g3lilkkJDYoYK2qo3Au/VohHMWOE4nUZRNm/gvoDqa2
	Auww+jITIX9T9+zFULhjfUXmC8NGHnUTGAUie+EwcAYUS3HX8HU6RIR+NgFhSddjg1xBKkJ+3VQ
	/KoqXS4=
X-Received: by 2002:a05:6122:a17:b0:566:fe6c:e1c1 with SMTP id
 71dfb90a1353d-56b627f3979mr6626491e0c.3.1773734028049; Tue, 17 Mar 2026
 00:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaN5OPgoGANYlabu@Adekunles-MacBook-Air.local> <aafga8AjpxagiEJt@Adekunles-MacBook-Air.local>
In-Reply-To: <aafga8AjpxagiEJt@Adekunles-MacBook-Air.local>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 17 Mar 2026 08:53:47 +0100
X-Gm-Features: AaiRm50QYszfoRiSJKZactlGeFxpYk8y9V__5yuCGHg1H0TO755ve4uNBlEerDA
Message-ID: <CADYq+fb+MdpUTgLbcfoh380jiXi8HCZZbKaxgZDtb-rxrxC9zg@mail.gmail.com>
Subject: Re: [GSoC] [Proposal v2]: Implement promisor remote fetch ordering
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 8:35=E2=80=AFAM Abraham Samuel Adekunle
<abrahamadekunle50@gmail.com> wrote:
>
> Hello,
> This is the second iteration of my proposal for the project
> "Implement promisor remote fetch ordering" for the 2026 GSoC programme.
>
> Personal Bio:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Full Name:  Abraham Samuel Adekunle
> Email: abrahamadekunle50@gmail.com
> GitHub: https://github.com/devdekunle
> Pronouns: he/him
>

Hello, Just bumping this up to get reviews for my GSoC proposal v2.

Thanks
Abraham
