Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5C212FB7
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714026; cv=none; b=SyVnised2wEF8nGMIi2SRanMJ9kfCv3/n1rV1DEXf4tfIUUmg38BBJwEpY2utokaX/yX0m6DpZMjo6+aVBeeF5bMCs0bmNh2H94ZGbJvZqAvAdl5FIQ1hBomJEN2M5DzMl/PAdt2xB7ijzS7odOwmUvJWxdvPgQszoquBzxWQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714026; c=relaxed/simple;
	bh=etBTMBHUfG0KkUjwbnPKlLudF8nniy7uS05eKDF4gas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm8AjR/5EVY5pu5VGnSMLmPIgei3jU3HDiKXbW8UrhTIOeeGHbaw9avLoLohvKrYdZMGVyM7nk/3lR017T3Qr+gdspu2FGsoMbcU3XpsClBFHyZqkD5VqMcVj6uArTHbNZEBjgsXXJLLXZDsRJOltalw/BknDENxKsCdSV3jIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntYueqZk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntYueqZk"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad1b94382b8so130235466b.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749714023; x=1750318823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUQjOIWczyYnPHcCKJniK/yEyCLGstlfgHzu6zQpE8E=;
        b=ntYueqZk/BF4bNmGpA55pX1qPWB6+DeoKAycJKnUGnu3t+Q14i6onTYraKb5F77vKE
         ZALFn/Gl3+HIPwGopbP15D81qTfY14DT2cNKW71FLOP+S+1lomueamdQN5DxCL1LzuA2
         B5iXVzi+nqA2DQ0x23L/3tBIJhz8J45H2PJc51mHv0+3WZO8SqHsyAlEBKkquPBbxBDq
         z4NNmyCXIUTaNdeV1PAz9UzTkdgbx7H8wHrwYlYbB4hLphTtJ5OrrsOx0821jB036CSB
         ewscEmxIC3MJcvmkOVUeQYQ/CeFFw5ZCfK5KrvenOfth1vBKt20jZLPUxbONfHieRQST
         g6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749714023; x=1750318823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUQjOIWczyYnPHcCKJniK/yEyCLGstlfgHzu6zQpE8E=;
        b=O6Zvv5Omndy01pKCwqV45uI4GIkNhgTDR4kNGe7/NbZ3dWrmXFxRYyTsVGBZznWfw1
         gHnZVXn2tX5GRtTAxGf0BJNjGfxGfgqmH/T4GNLvP3wsnzb37jiM3IrAMXk+s1xcHVY/
         fJBkNHt89MAVHbxCljRizagNWV+PUEtuc3VKYho/TOWOwBjaOhaa+jEjYsMbawNp28Lj
         zGCaV43KEa5TGvbb8t7Xv2JuYZDvOE7bZCbelO5AMOQpRkjpDD8I0eLmZQymKf1WttdO
         adNcHgL26BWbTC4zuLVuaNNcUQddNb6YZMKh0+yo+Cgomhc6zW5Q5U1OufbSStRGStPV
         RhWg==
X-Gm-Message-State: AOJu0YwaF8w+r/YseM2m41uutYFoSfHxweq/44o8P/3UNIgEPt0AQ62h
	Le6p39lQVr2cCLwhK3ubUCFXab9CFvOb6SxpRFVJt2mtTxipterZn5ouVGaufCJF1TyxeqeWtQC
	0zqBHaNiynmyiy/hw9EMLHSm1sRoasbAubQ==
X-Gm-Gg: ASbGncuF37E/H3aGZJrm5fdsRFzoldHgp4q1Zvdn9NhJFVfJ/0mBaRT5we8hr9edTS8
	QBjUC2VCbF56ngqiFPDP70dxWbVo9T2GLpBt+zccKkdwwkqnCbWlND5AJPiqubQ8ZrDJMYaxPP5
	EjtNeVtob5ej71wgZ9OnXRBP52aSvQSa88DcyOBE/7W4PTgQ==
X-Google-Smtp-Source: AGHT+IHYomXl2mUP36Cm0WshpM5nNxrHi5DL6jAfCOgVkr/FLGm2oiqdWsVCU2vwLbdFJahJ3OmE6pugg56UgG/6wrw=
X-Received: by 2002:a17:907:3d4f:b0:add:fa4e:8a7a with SMTP id
 a640c23a62f3a-ade8971d93amr533203866b.34.1749714022531; Thu, 12 Jun 2025
 00:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqh60mger9.fsf@gitster.g>
In-Reply-To: <xmqqh60mger9.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 12 Jun 2025 09:40:10 +0200
X-Gm-Features: AX0GCFvUS0a00dG_s7Nr95G1jYy1pycZSLRteHG7_OrsTe86IQGc8gu57Q9Lvj4
Message-ID: <CAP8UFD34VpH7qQb2HwVR-YqcBbM6-Mo6ivdhcgN_DbLi0LT3zg@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: let BSS do its job
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> We have mentioned this in various reviews, but I didn't see it
> mentioned in the CodingGuildelines document.  Let's add it.

Yeah, thanks for maintaining this document!

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> index a0e7041c54..4d1d52aa37 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -315,6 +315,9 @@ For C programs:
>     encouraged to have a blank line between the end of the declarations
>     and the first statement in the block.
>
> + - Do not explicitly initialize global variables to 0 or NULL;
> +   instead, let BSS take care of the zero initialization.

Looks good.
