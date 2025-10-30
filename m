Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41C22A80D
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832370; cv=none; b=SqtB9wNmpyFVvVzAekuW0IgBfvR7hwYFmPjtApPXr+/zGouGSQS12BHfOxV70dKxwtNsIUOaL+jyD0uV3R1+UNFZcVHzxPTJjwYArBja381sc5FVUu2nfh1ji0Pd3IXR70meq08xboTk77VYMrJJHt9UBidZshbv4Ntj2DS3ch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832370; c=relaxed/simple;
	bh=sWWNiF9h6JWln3jVQTzZ/sdyPtidu6AQFCgdF5lQJQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L04PekfhFRkxJqDHmY8iyS0MXzMBVHxLj21Zpo7GhKMGe8owJe/jTqSEPa9xp0CHw/wX9JN+7rfOyAq8bn0fWHyjUew1O09/IVnwMrcNWfIsy/7PEkR4UnK5sZ4HXVFvgKTeVdT57qWBq+w6WX5BPwz9jXR7JknFfeIQbzmdyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft/sILdT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft/sILdT"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so143867366b.2
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761832366; x=1762437166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWWNiF9h6JWln3jVQTzZ/sdyPtidu6AQFCgdF5lQJQw=;
        b=Ft/sILdT5BPu6nIUsH4I+13SneX1ijHpYeAidB51kn++gbs4CL2QlIzJaeMQlLECrN
         hZC5jahSAAu+x6KuKrqFWVPOHq+0SV7nHFmotI7c+2c9qvVVIl2DS4M9Qknpv6le8iEW
         7hIHwdf50yZMMExuqYM8N4RC/BfqPI5AgCK3xCGV9J/RWwOaRZMhMxDqBJmqq9jegpXz
         entZchr/XAuKSM18d8S2T/wK3V1WvGpwX/W4MfFLzvzfreZ6ohsVjDgKPslC/DOUYtrk
         vKRk649LV/9+Bv4GOpJNzNi/2hJWTNaYBAX17hvSCK7uPBzPiZmPDqZ9ovrl3O7q4f/I
         dDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832366; x=1762437166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWWNiF9h6JWln3jVQTzZ/sdyPtidu6AQFCgdF5lQJQw=;
        b=tT0GBfPxtu4xCDTDpgg5+yZh3TkOzjJ7aE4KJWR4trASvP0nl/0aWaSxLT5QJgEFFw
         dsrSnBDHks5fGP5c0Ken1d5FStjlZ4qsxGG4BGWMsy+xbLaqqKrxWVqPSOkxFraUE+L0
         GCnArvCS8Kwehjtll+hwtdVZhaZDvKOaxzEvrOBVPUk2WOQ9Z/05dydRgXo0zLKi8fwa
         uEAEtHZFWIy2h+BxXSXLou8GiMunFpv2sYQTM9flbnElBeQoFXem7yL3OxFhqe7317cg
         psf/Y+LrzdT3XbDYI7VFVWEKPfGUX4AC7FqwU/so965bB5z0dY5NBBUBiHsaSa0DwLdJ
         jjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT7efIo90jpWkS4xnbLyE6vEoC8wjOOvT5Vfmq8q3wLZZh7bzTpALg03jGRvDglwqXHNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbP7Qy34wr3ENDczovNCii6eywATdFy5O+KZVdPhbX5rzWMBo
	6yZpSJ0ZP9QJzI/Y4Bly3TaqsRx65YWVemcTjkrb/yCKrwwMgM0wBunDAfQD4Kxbi2o1r0tLIe2
	h3Is0z3tDiDrgm7+di2tjmEXiZHx4bco=
X-Gm-Gg: ASbGncsR9Zk2oW0y57Ush4rrI5tH/NkEiWaN0LCZJvXb3UKnl0Go0KB3XpthhemHBe4
	9ILWM7WoTHy5uYH90JXoctecYD2UBE2ttyNnJx3E5u5VX2UlfrNus6/DMNaNeD08wvgR/6PFt7k
	wn8j6tazSeUHqJGYuY9FDPzJ6/ji8m9W0mjeH9j9lLomTN8krvhoskacXL3Dm8j6eAyT0GmLucc
	ua6sBZH09DieH7cqUynRDfHoltIaHm/7gt+wpAgzHGaPTZfg5DOx2WK7jW8LJGoHq5tXS801uFK
	kHNMR3L0Yll95fBbyMbMZ4aH8BovcQ==
X-Google-Smtp-Source: AGHT+IH/xRdlpYQpJ1zYIGx5AEXJPU6H7zNrPPSZ3HqHdooJ5TPdTzWlWjGDBYppha2M3C1FVVcdzo0HSpmKVK0SidQ=
X-Received: by 2002:a17:907:72ca:b0:b3b:110c:d343 with SMTP id
 a640c23a62f3a-b703d2e4318mr602981566b.8.1761832366448; Thu, 30 Oct 2025
 06:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6psjq2n.fsf@gitster.g> <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
 <aQKVByfUdYHSEcDz@szeder.dev> <000201dc4925$2cdbc450$86934cf0$@nexbridge.com>
 <aQKgxfZ9WQjyrhpa@szeder.dev> <000701dc4933$9f79c670$de6d5350$@nexbridge.com>
In-Reply-To: <000701dc4933$9f79c670$de6d5350$@nexbridge.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 30 Oct 2025 09:52:34 -0400
X-Gm-Features: AWmQ_bkNjEMPdsyj4DxYWxbsdq3_hlYshrF85RwtvpuK8BGJsHN7jan2OBh6STg
Message-ID: <CALnO6CAYmtDmfk36nX6TCCaV2c=8J0BXv9eN+L=j1PU=gPmJUQ@mail.gmail.com>
Subject: Re: [BUGS] Git v2.51.2 on NonStop
To: rsbecker@nexbridge.com
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:25=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> What appears to be happening is that the Make environment is only using S=
HELL=3D/bin/bash
> for the outer processing but not the inner #!/bin/sh of t7900. The system=
 is using /bin/sh
> as specified, which uses ksh, not bash, which is the trace above. When I =
run the individual
> tests with bash, the error reported goes away. The problem is, with my ve=
rsion of Gnu Make,
> 4.1.2, the SHELL variable is only being replaced for the command processi=
ng of each
> recipe. Once the system loader sees the shebang of #!/bin/sh, /bin/sh is =
used as requested,
> and fails out. This means that I have to remember to manually run each te=
st that fails with
> bash instead of the default. It is frustrating and now adds hours to my m=
anual evaluation
> of the CI/CD results.
>
> The trace above is from sh, not bash because of this.
>
> With Frustration,
> Randall

Is this the only ksh-induced failure? And if so, what is inducing the
failure=E2=80=94is it something the test library can work around, or is the
system {k,}sh not behaving portably here?

My preference would be towards making your setup "just work" assuming
there's not a clear contradiction of portable standards somewhere.

--=20
D. Ben Knoble
