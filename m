Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6632FA2B
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805240; cv=pass; b=VVM7ZTELFOps8YDMwUT6yER8hP9N6XTvbZ9b/S8BQBFCZGdBwYSLdleLOMQXMD5806kAC6T7VhjmHqIrxUqrgMGrmLKHnpjV4QW0n5AwSSm1t9MfJFQo9xFYA0OYhwsP36OI4GLc2ThFjCjnvTmuk1a+X5RsnWHOmmad7URzx+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805240; c=relaxed/simple;
	bh=HxUn1reR5oZCh9hV/a7Rrd5cBGnmm5IV3R0t3exinxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsoI2j/D69pbhZGKGe5DRiX0ozUAVprx8uSq8X73NdM0N3grlCVnrY4hOOlselQF+hf63SvYWDPEl4JokmTusfw+O1QWUosk8DAieBwmGMaU3XlJ+O9wIdYek02ReIdhtInJVWDPNLSGm+ov11YZeBKlDGYYEqeNgsX2zT2xby8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPPjrWzn; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPPjrWzn"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68f36e1663cso2171132a12.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 10:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781805237; cv=none;
        d=google.com; s=arc-20240605;
        b=WYVPIHPRdfxuSuonhimxy0pHcCsfwGpegTkHo1jiskpVw2OwYZ0iCNjsbNDrBeNVXq
         8mhY7MNEEQF2j0FIALd8Vwn48iPqD5mp3/Xz4fDRW2GDGwt1jqcpOWTgKiRQiT+nFkTo
         Oyf/icFn9ztsX/EeZosvJJ/A9tNLf/XPFnjmDhsgmo2rCr3QvQMBB086RPO/NLTI0i2l
         X4VVLcGqrXgmhEYbrzIdxhIt3vc5OXNx4fXIUFzkdy3177etFfnfUti5I9LmtgVC4Lzk
         GN9tI8L3xWPlZYb0UmqEIdOi0xLsTSa4UgW1D2WiWAnmMznsHTfveVWZqOynLIB0LQg0
         /tnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HxUn1reR5oZCh9hV/a7Rrd5cBGnmm5IV3R0t3exinxM=;
        fh=ItXGbS2TlLZ+KlLyBUdylSGzqedkafIIRW8bV9hJHSg=;
        b=c8EptRvuMZYsfPwD+2b7l6GHZ8kcnidE14K9OI8HL47UFFqURt1HJEaBjS7rPsok16
         vGhmIBMaES8+nul4zOShK6NGY0tPPib42XvenkB7xLXgmPHGgwubHd6VH26wgA4xTul2
         kYNRPtKuCP7NUmeuPQy5pDqCX4A5VNsx5wMSVgMKzxOcWJXEtuwDLaGTBtLLG9TvyyMu
         bYyg0g9tYL1LqPdFj+VZ5AJzaZcG2pdopSRBOzLfmyZdbDt3QzmTf8foZivZg5VzIclk
         FOjDSi7xFjzU6cLsXVtjrf7fX4Th6JVsUmQrg21cgM5TUtgqkwoJIbfBrJVUm7vjIZvq
         nFIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781805237; x=1782410037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HxUn1reR5oZCh9hV/a7Rrd5cBGnmm5IV3R0t3exinxM=;
        b=GPPjrWznR2uJ8yAWns/0L7z3IF0+GkXgMd9K+xbx5KhTZVdYTJ4yIrrf0B6snHi4fZ
         8blfw6HJ+PRAV9k5ucc/Q9kJohHGCVcbckBNEQq4y+EcRo4guQCt8BPY+hEyTqhI2kvH
         JJ4tOAzlp/YRhmPCxg4VbrQxx8qHiRtyK9bQaTvNyAWnfZ9MNpvWHPn07ntldeT6zzEt
         rRSOQ+v/UWj8X6kPLmYr7mxlIoaXRLvf6s5xwM8+23koU54/DBcD5iR+TOnWOwLIS4pc
         6x31JF04SDUrIwjUIeIT3TRqlQp2FTbphzjq/Ht0LpwCoESBEqwP6CvcWXJNJHT4EjfS
         Ca7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781805237; x=1782410037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxUn1reR5oZCh9hV/a7Rrd5cBGnmm5IV3R0t3exinxM=;
        b=MF3BMQq7nMVGJp68P4BOPVsgQZidrOP1K0vFkW362op2ITFc0bTk385ZWn7C8DFu5R
         5UfCcB5QQSbZxWug7qe04MjDKU0QYdMTT9wTE/prc59nM9sxGfA3wyZMvtuYfMRfDQW2
         cwIJnderEjwvnX3Cr8MA8OUFLGfgzaEmgqA/LpOfvWyHAspD7eLJ92iluRi4LIhxaNY6
         5VnatUTIdXiAM2p4LfWAXLUD1JWUejJy3NVqRh08Qb9GWtLE+WKpZzFtVB6cp/FjOjJ7
         +e9lCUqilw7RW6bovfTWn3itEGhf3DwJpHMwftzn113pgn1HHliHFzaTxa/X0Wpg2+40
         GPMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1dIeScDvqC+5VTV5n5qab+NPCD0IBdPr9MJ3NLhIINlekWMZvd+o1HH+EZxxrpEjGQYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvATGwiWWPq7sGYlCNpZWokpX56qxQsYnxuqAkjyGmthEss01a
	d4F5JoMFzpGyKWKYX0QMfaB+slQXVsV/Li5/OK2HbH/36979SwQNeQYTSPYzZwjJUgBrqBwIBeW
	v6Ev22bOuQw6J0+kQvJ55iDxlIDuKuRMqtFOo/Jw=
X-Gm-Gg: AfdE7ckw4LA8Nf9ttAS1UuSWSQozecMBRQtlbH0xCEnvpdR8HAPCwaSITeB3WXBF5yl
	bSXCA712a5yBGIAuz4myuFDUvLmm0kpMPb4IJvZ6yQjWNcl409s2RsbK0/aHzXzpAFnXf4GRRGb
	EbHnT4g2M3URMBS0Z3gJbAWgbzlH9PdZKPP8DBh/hpHaiAndtTeheoarMWMTwSFIdMjOBpoc+2m
	uGbtrERtkSe76V8JqJ/uWp9cysf+vgDtRexWn7utF5awIj/5cXLdvP+M5DQYF4USDEafm2u
X-Received: by 2002:a05:6402:1599:b0:67b:cd1f:9cc1 with SMTP id
 4fb4d7f45d1cf-696edc5a4ecmr200951a12.6.1781805236899; Thu, 18 Jun 2026
 10:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com> <f68e2a11-02a5-47b9-a01a-458eba821c37@gmail.com>
 <CAHwyqnXRo=P5Zihs6s7Uh8CrYCO7mjyeZ5nAv9JqYbGH0RE72g@mail.gmail.com>
 <5829103e-d357-4880-b295-fa0d9f4a2c62@gmail.com> <CAHwyqnWFM2jskm6soEu58tp_TgO3fmuODD-yTiK6-4Hpv8SMLQ@mail.gmail.com>
 <feac3d8b-e291-48e8-ac73-3b1f5321799b@gmail.com>
In-Reply-To: <feac3d8b-e291-48e8-ac73-3b1f5321799b@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 18 Jun 2026 19:53:18 +0200
X-Gm-Features: AVVi8Cc_lKLXP8U5LusAjhJW_y-F-vvUt_4HaQ-aPrLSI9r4OvLcGg2YH8O0nQM
Message-ID: <CAHwyqnW-rizVteUiPB_dVRBm3c8NRAV4TP5uPd9koL38sokW_Q@mail.gmail.com>
Subject: Re: [PATCH v15 0/7] branch: delete-merged
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> > I received the same feedback from Junio before, so I'm not unaware of
> > this problem. I am trying to slow down. I often prepare the work as
> > soon as I get some comments -- I'm on paternity leave so I have a lot
> > of time when the baby is sleeping --
>
> Congratulations - I hope the baby is sleeping at night as well in the day!

Thanks! It's our third, so hopefully we got the hang of it now.

He sleeps -- some of the time.

> > then I actively hold off on
> > sending to not overload the rest of you. But at the same time I think
> > it's valuable to keep up a certain pace. It's a balancing act.
> It is worth waiting for the discussion to settle on each round, I'll try
> and be clear when I've finished looking at each revision. I'm sure other
> folks would appreciate you looking at their patches and commenting on
> them while you're waiting for feedback on yours, especially the GSoC
> project students.

That's a good point!


Harald
