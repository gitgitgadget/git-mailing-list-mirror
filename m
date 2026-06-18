Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A1301708
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804891; cv=pass; b=rwmoHual5xap4bn/JoWTZwETH/WjyvyuoQOyXkEpaatJyePSKru7v8QpeqxRc4KoZFGB/ly3oq4bTJuWvvzi03rtnPal0u7VR6wIp+Rw8PLIGZidQ2YYeAc7TklgibVpX8uRX4qMSkYLrHIdNcLB731AimbkDHMAp5dj3Fd3Pkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804891; c=relaxed/simple;
	bh=w4P7MMk4SOWYrnYAOXEv7S7whYIUIw1GfQmtwlL5nzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djg/HymhhgLdNw1cgWDOdo/woLnK+ZKJ4R2bTmqwEUJ15imF+Ls36Fwum47+3zeyzc8IJ6VKVbTRUbNblx2IDL/+KXBShWcOKxHm650LaqchPHqIQ8/ITLM6xsNon8nfSwvnR7vb39OV14UTZysD1exkR/uDu5Lkw7xE18Z0hRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COPUYSTr; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COPUYSTr"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so708392a91.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 10:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781804889; cv=none;
        d=google.com; s=arc-20240605;
        b=idmJb1WqZgaKOxqvXXIzW5rADqwaNnIovIzM0iFMeZoqJzGTk0VIXwd332bgF2Poe1
         rLjvv+R4nd2iiVY1FdeBiJ6/2tJPWs9JWSewuMGL019wC2WEyd0HKYaLcnbjAJfGWg5z
         prnp7eE5bAK82d4Mpagd2/PoI0ficaYGv+wIfCaFTyVBq1wYEzm1yOnQFXCtGQJQAfjK
         0X6PYviDvLZ9iW5txjlzLDz+eKCiZ70hvod80KU24zu3ryL/FHx5eJx5wMdAp8qGa4cw
         y9kfvu6ebJDOrhstxB8y/gW0qsJOHGAgSFFdcO2J58deCflJot6hS3JKZz+phuWJkydr
         qqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4P7MMk4SOWYrnYAOXEv7S7whYIUIw1GfQmtwlL5nzw=;
        fh=Z20w9vWl/UX1fx44+Ej7ACxIpjge3I4SWZVHrF1En6M=;
        b=f6sa7sEjCAOdWJKymN+ni/X4dX3fRvXpDa1qdLmhAQTzeGZVd9wPlCUAAORZPsTLMy
         nYo2eCV285dvoT/idt4HMsUaTR+O/Nh8FNuo0ZJMVddNXziAzvknj/ypVNOjrpI1AvYd
         hZszWOHEoTxh8LVgV9w2NWiTes0MwV/EBqJzhFMB4W++kgPICHBOh2DFCgKXPcD0oohl
         0td4GtmeLFtDgokz3FKzPvFegH5O+yW+1nUJXP8Mm0lFx7X0/9LznwIzyGQG1x6zApGd
         8qqbea5XlwsS8uOsqFlZW3KSGerzN6smRUlNg0NywsSD8Ch8E5LQiuA9tTFm8ESWc9x2
         lo6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781804889; x=1782409689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4P7MMk4SOWYrnYAOXEv7S7whYIUIw1GfQmtwlL5nzw=;
        b=COPUYSTrueQZiMXD0YCq9ybURE7rk3xgaZPvXBzsKWh/1RSgNDUOQEAeLzA//9neL+
         TrpjcphaMRoo/BQFXBclc/AdCzNA3Qzu49Ygyh40iehqmYEXOSz+cV8G5yph5Arut2B2
         uQrHODDMOHADxEDtq8fY/Jx9dNh+KqN0dsSsxa2aQxWrMyFIyI4IuaeBlsF2DkH+Nbzt
         qqO4R+ma9VSLMapENqUF2X2ZA16poEj89OzpLLa2k/sOmxjAZo/dPtfcXPtrA61n37yv
         Ocl5g363hFbQD5CAbzHQ9sx3HKzsMhyeWTlskZk5FmZD3mzAaXDg3sszOleE8jE2vak6
         qe3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781804889; x=1782409689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4P7MMk4SOWYrnYAOXEv7S7whYIUIw1GfQmtwlL5nzw=;
        b=p5ztfI0CkcwhCtegq4QUiPCXYsFemLlTsEMaZPPY1n62HBftnCHuh/24/qfRx+VGN6
         VeRbvqm7/IrLAgS6CjgMi4gnmECRLhIahCgFUZZs/OzMQo9xmKiXOHsLbj1wXzKfvH9o
         RMtV2IqbiCjjLHTsCt6d1re30FcqoCDLFT2+3M+b+Hm4fsKRseN9N2PZYzhzer8wLvpf
         CNNFXLKtiYIkoe6tUp6zOQtWLrEEaKC0HyV7LAIWoiMKOZ7blsTuqDSDJ/w8qkoruN0F
         ad0V3GFHGydkrv7GTEqkioMLC4XjII9giwLyhcE6U42/pPmozuVZG1dMyeWXhP8RBraL
         MA/g==
X-Forwarded-Encrypted: i=1; AFNElJ+eDosw9sLfRYhaLZESKwx9GR8dUQjJOA5i4D5gdgQZ9Qp/4gt957d/UImqpz21qdQ1USY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkRgswv+n6aG6IkQrNKMmdGKinGCHLh/kgBA0/FdqBARunxDL
	kywedWQfLNNXAoFSS7gvR/6DTH/RGC1WGUcdzqFmoiW0WIy6oy8PY/AOU7OPGHitEovEwqkx53C
	imqGG8Vtv0Z2GbqycOmp5UZtbRyHldYg=
X-Gm-Gg: AfdE7ckZQ/uwylWWOyqLV/mc6w9Mkg8Z+DrH0Tr08UTOg3/ArJRQQ7YU06tJuReVwqz
	Mkw8wv84XEBUeTM0poeEnJrntEMbnTvBLuQVIe9sqwMRXHg2VVmhAS9esEJuCDIHg846DmyCxRw
	21DFCMBsw2hVRam+jgSmmlUSNuvQpVrQWmAmVbRptF4cMXMvS+ICudW9PU0x6HkoOn0NqBXu3ZO
	eXsJJzx+NsqmHY5NH9v3gMdpvNVP0P/+09UJgdF8Q4YluneoJYt//R0gszl2rn3XOkBC422R+qn
	4EyYIP/5/Oyr2aIYSnXNbT2tHBMJMlC6OuKvP6HHieVa/iFo7JGGngHMYJHhGrALe/SX8Q==
X-Received: by 2002:a17:90a:e7c9:b0:36e:2106:dedc with SMTP id
 98e67ed59e1d1-37d160e9acbmr374311a91.22.1781804889523; Thu, 18 Jun 2026
 10:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
 <CALnO6CCNoo8y2V5KmE0KQ6qDurZELipFowcr=ZpZ3ocVB-uLjA@mail.gmail.com> <CAHwyqnU4xuw9ZDjarWKKua_s1Qywt07GyP1kJO2HM+XQTcE8hA@mail.gmail.com>
In-Reply-To: <CAHwyqnU4xuw9ZDjarWKKua_s1Qywt07GyP1kJO2HM+XQTcE8hA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 18 Jun 2026 13:47:57 -0400
X-Gm-Features: AVVi8Cd_YfIasOr27yCJ61nIUAEX0suzbKPYDKdspG_R7aIlJlDHHKAjWihVB2s
Message-ID: <CALnO6CAVHAt8wDMNGabY=krpOs4=JNUXYrhnNdKKcyJ_heMaXQ@mail.gmail.com>
Subject: Re: [PATCH] checkout: add --fetch to fetch remote before resolving start-point
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harald,

On Thu, Jun 18, 2026 at 8:36=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> Hi Ben!
>
> Trying to shore up some support for this topic. How do you feel about thi=
s now?
>
>
> Harald

I haven't followed the series too closely; it sounds like the code is
in decent shape.

I stand by my thought that this could be convenient, but that's not
much one way or another in terms of how it fits in overall with Git's
vision.

There are some conveniences I recommend universally. This one requires
caveats, as pointed out by others, depending on the project, so=E2=80=A6 fr=
om
that point of view I wonder if keeping "fetch + switch" as 2 distinct
steps is better? I truly don't know.

--=20
D. Ben Knoble
