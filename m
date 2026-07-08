Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5E3BE165
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489328; cv=pass; b=Q5123+qFOLMcjKtwDQM1gy+WdXsGUuyRgFOe0GNktq/2MT5PMZpx9QSBOmlfCTOjDAhhcfuHEzZc19M6yaHgGHZ3BpCOukVzzo/14JaNeAn4aH46shASjTW7JAsmVVZSY+daLCysJG2B3S5AEidvgn5kqGMeW0806W59U5HDktw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489328; c=relaxed/simple;
	bh=/aMK1HmpprcXSnSO8rFq4+bCa7J6faQUbTld6VeTdaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ro0hp9e1gSWAp/iR1Ptk3v0HRLps8GOtTV1NI2Lvh6mEXT/1ZlNStTpo4zkejGEtuvIrXeS3HVDIGtUMttSRlPhVyPxAq8G23qHv3otsjxmfWx4FGMlZenDHQcyLHInbfJNWfDEsI/zWnk0j0lduT2VR7y4jJ4ggWFzlZQHLqpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4WoB3F+; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4WoB3F+"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a36a1b5bb5so95950eaf.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 22:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783489326; cv=none;
        d=google.com; s=arc-20260327;
        b=YSuzoctQQnaD3QHL/dA3JpjRS7VSFKU2YQMuE2Kuy825XqSThv08V1DvLO/DYdpIe0
         L4pXfWSSE3fmw0Zp0ML/M0tgI8sl0z+DS6TdwEpWMEBsykGKIJXLqGQGdi5O5V70sBV4
         J27c+BYgec6p+3rj0DoDYN7RiRaIpxT8nPeuhSRhDnpq7+mBUFiNh4TcqrK8mPycwkU6
         hdxRUtYAXQDC9Q3n4OjIpKT3KwhI6NQd3E/V6LeUpNyiVQXxWsCbkMGRrAmjw3AUuL83
         hI241W/NUuNHHmTJXc1hgiABPAOpLHfOlc6k2orZRGQp3Tcem1TN06Fg4DX6jaQ2Uk9s
         hR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/aMK1HmpprcXSnSO8rFq4+bCa7J6faQUbTld6VeTdaM=;
        fh=0Z9goNaJSwCy7BWCSTlgpyIfkQ2ycpeeRHfiW5VBch0=;
        b=oQN9SiEP6qG7LyCFzShTaxXkQrZQNfipWxKMyEknkoHWg70lUGSKrxIkpdGCnMcm92
         opgrayTOdfseD3aB3f1io+nwnNLiJ67z9v+VfIh49helNlV5QP5vKST5ztPprTM4LEja
         3ozS7zHNk07OJARSEhxe0jdK6poFBQ4qDNWU/1pbPDBGmucsGbwtSdiqZW/K/oFKguie
         5wBX4BT3ewHmEkuPqDH5WyvRaDVZ2krI9M7uPEXNFxZ6AUdmB4BmV7WFwnAKfM9UMFzu
         SfMoAyy+sSmjVDoQF12BNeWC0E+70l4hvF5AwuBOpyLQz8/683NelqdqrYxoCnVPFp+c
         tyVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783489326; x=1784094126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/aMK1HmpprcXSnSO8rFq4+bCa7J6faQUbTld6VeTdaM=;
        b=q4WoB3F+BCBo8/3Vy1ntvbsIRX3wglgRmVfJ4gnxRoVNj6neFT6GpbiRjg/wgvrTVr
         ZPCTRpeXOBQXB6IfTtBQpiN3Lc2e1qN+ll8SHwiNo3k056bBoe53G4pKwHTpIR3poGSh
         Ftlo03W9lhNSSASZKW7/75vN2Rn8pLpM/cAJ+5TnBEonLcqx/wAsNXHS95ZOfsokJGX/
         Z8epG5Pq42YUGZGuKMm8S/+bod7THzQMEojbPXVYUZVnAI3LpMfQt+Bc881ASCdfzGaM
         vTgYI8pXFWRtNJiPp6UCHJOMXU7AIvCwHoDiu0AHz4wTSMMLZJRt2JkwMA2C7jjEtMS8
         VcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783489326; x=1784094126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/aMK1HmpprcXSnSO8rFq4+bCa7J6faQUbTld6VeTdaM=;
        b=kgoq+ON1HJ5lELiGWocYO5s+yfLo4VjvPN0VaWQlhMnIN9nczGqqvWuhd2kJEZ3DuD
         e7a9V6mcpG02xQ08AxOoBp/C8apqiwhb2PPiBidi2CzelcWyqoZUTakkucQ3tdFIYm2i
         G/VNjBQ+HCCyuuR7CQ4NgZ2/25hw3cPioLcZRb/uTwTJyDzmi2oAjTU11Tahw6WO9646
         HaYMF9uADSodK3Q5EaoXbQDAydUM4cYQtku13UtO5oAW5F8PcNsdzgvF8crN80+ldtwI
         eUyxbaVzDiV5gnyIq6s1n+tK5JiVZkePbO+hRhSevyH88Abt88sByylrYjmRgKwVfFVP
         T00g==
X-Forwarded-Encrypted: i=1; AFNElJ9sEtQJ1+nSdSFKb3pGee1GLupPrZiHZ6YitCIhNEBhk8qSq+Azg5zRpkf3Hna00PeLvW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKhQi51WdDLgUtJ9i2Vww1gXL1eD/JeWvgDCgPYIAgJdaEcM1
	4sZRPC4kJOgQ5OrZEainTb4Z6ISgP3bxvCydtjyXGeo33IuyltYSxe+GG93LGsKjQ4Kk88TKWsS
	EZ806XCAZEjVhsUVEeH1nJNrobY3f/oU=
X-Gm-Gg: AfdE7cnwn2TvkxYq/yi8pulX/NJQaradp2VxPM0gvuv96UoBAJd0Ill0IHMBFRvpDzL
	Y7bd+nF6ifILEcfHGACAEQC2EdKwXfJCUIxQKDqrMkCH8bTRAprDPkmIOF5+Yyn+DMQb6Q6R9Q4
	vkEFCwnb5kOZY4gL36slB9LaBBYUbzLsUlDD+A5HLX3MPgHP2ZkiTJ5yrQ6jGliC2ONCYApgpvA
	yby8qfc7OOHT6ukQQK6bLerRTrqfLTs7/bYfDmkChA1dja25CYIukCoSCa+94mOStCS1gz0pFa1
	eZS2f7P/IE/PZfolDljCRoaaGjOlzjtJDwcjekh/d7P/WOEHwLimPuSqRplC/FUyzO8iodOsqcn
	OIjSEhe20LH6p99w=
X-Received: by 2002:a05:6820:1c9b:b0:6a1:82f5:b009 with SMTP id
 006d021491bc7-6a36da33c50mr918718eaf.13.1783489325676; Tue, 07 Jul 2026
 22:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2QwmJ8Z7hZHk9SofRsprvAR3B=UXUkeyy7i4uofRi-xEymow@mail.gmail.com>
 <ak3fr3avEmt-UJf7@wyuan.org>
In-Reply-To: <ak3fr3avEmt-UJf7@wyuan.org>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Tue, 7 Jul 2026 22:41:53 -0700
X-Gm-Features: AVVi8CdSOP5zwTLI3tP16A1VgGCFaPaHPyexi-ac42aa0qxqaXpLRQM7NOU1WrU
Message-ID: <CAC2QwmK2kFBNRT47i4k-zBK+b0PFezLFbx0eO8t7DqT7tTnKhw@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: abandoning a series
To: wy@wyuan.org
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 10:27=E2=80=AFPM Weijie Yuan <wy@wyuan.org> wrote:
>
> Hi Michael,
>
> By the way, off-topic:
>
> I noticed that several times your replies didn't carry with a
> "In-Reply-To" header, which made me confused about the threads when
> surfing on the web interface of lore.kernel.org. So also, I cannot pull
> down the complete thread with b4. If possible, you may check your email
> clients, though all email clients suck ;-)
>

Argh, sorry about that :(

I think my workflow for replying to threads I am not already a part of is
flawed. I usually control-click the reply mailto: link on the message in
lore.kernel.org/git. That launches Gmail then I manually craft a message
and send from there. I will spend some time investigating my workflow
more deeply.

Thank you for the helpful note!
