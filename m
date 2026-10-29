Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793278038;
	b=adPDavHP06UinrV8YbXiVMhy4mJpOE9ItX+Wlzlj5zofUQ+YPFvpumLAlb/BV4usRx/v
	 GCZGo2jSfv+CQdztbrY2KR7MIX1zP25YJgGGVen6GU86Dhcpbo1XMvjBG43jer0Vby9vc
	 PRXDBYkPcBF+p8+tn+/yX3x6sOo6KDJODcCeE0CCFXQTvXr8V2aXldGXaD/WGWJQ3crB+
	 id91ciq7kXBdN++lktPdLDuUqrmwn34xsmmlXOI0tS7rawrecj0pLvKQUYrIvp5BH3nao
	 TYGJzE4G4smn8u2jZGCM9lKtYeg2Pni8ac8ofLT7008wcsthP9sqZLvv1AaJIqB2/7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=T3fUcMFmh710o9+atl9jikT4OKUqBTr6Ka1BPlTnx4k=;
	b=YzZjDdanpH7SO+d00i9zKMGZ1DW4DykXDlPvI0uJ3wHQ2ZbiClnURXIJ7XF39YbY+dha
	 Nz65XrDMWL3PSkMRcRrDtrxqBqiGEiW6KIG5R6LOCVr32iDC6muOffnAwuyfCikgiIpQY
	 MjDN7jIsPuS0BKrWOSzEjC3bIm302VLYeE4gZDeHP5Mul+LGwT9TemcWawGZfz71/LOdf
	 ATSk2SBB3q+Tw6o8OfMuF4S0z5PoGLsPWEr5pusVlDAdDbhhfUuhz7m4ZWyMweaSlY7UO
	 GQ89dNDtjMuLr1P450qbaKlHcU6PwVyh/ByWaECmLPqhr2J6Y0+skHPrSMr6BDx0l/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdjiWQMF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F45606A31E
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F45606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdjiWQMF
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-85a5455bd3cso1306267a34.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278037; cv=none;
        d=google.com; s=arc-20260327;
        b=X9ugi/dY7iCvPB1OGtISo63JK/MJBZB7snT/+8TNLTxByPa/rtXEUKXkGzoRwE+nwX
         dAllIMeHqu+v5FC0RXuOiA1FQ9X/3Y12P5W40OZTX5Q1R7dL7UKpN/zYXOAJK0shVUq5
         KsWiSAtmPJqQhdP+udTs/MAA/jTCvyVKyTVMs0KeN2+oE1bUUv0X28X3bRNOTuUtbqgj
         qCOijCXkae95gCqP9oOxi5aR3+ycvBcdSY9JD1VLcYzsHRxq7gExFgd87TEv8fBqmrrj
         MkVkZBMo2LzPOb7GmeRKwL3rdW7MG+daLzz/Oe3Mj6lNmBzYGIyFb5SyedQTlWsfzsKh
         6oHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T3fUcMFmh710o9+atl9jikT4OKUqBTr6Ka1BPlTnx4k=;
        fh=hIzMqH9vtF6hTCMPH1CwC4iasS4kLBtDt9YK+UGWA84=;
        b=hYuaD7uFmIO7F5EIEbOqroKhDP7+Do2IN7Mclz/FG2kKZ4PQ4i3mMh6sVXVIp9MFlH
         ENL5sMxGtI7Kzq9/F3UqHcm+iG8EmZEuLvex2INOZa5V75765G15+Etrh7AjE2RpUdST
         CXGHJ05AT6N9w8Vhr69qpRYybzjwcru0vXJ2AdLHNughzaSMiQMjnbOwSHC1zlSWG3d9
         gl92IW6YEvvcvuBvL+F5h36YneBfRuen7oK7z39NmCqmlLVXzGdljQe6KNO2yIE1PFeO
         Y4/UoBFhd8EGpuZH6HX9DLwgFWZx1uFt5RlV70g77vFJPRJhwmIsUEBaWJJ00EmFiePP
         U5mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793278037; x=1793882837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T3fUcMFmh710o9+atl9jikT4OKUqBTr6Ka1BPlTnx4k=;
        b=RdjiWQMFwd1JbAkw1j8UgDSn/BgH4L5rtAdZLppgCllhveay3oU60hpIui3u17xjgg
         0f1p+vHtqbxEiqPYrXQxICCblWU2bgBFPDJmlotrnSQrEvM653jkYJ0OLTcYQYWAUR+X
         6ZTl4ETLpuMBVfZQ+alu9wDiucnAif1JwmilW4i0K1bMEXR6RGgI+gamVzLU3yKN6Vl0
         I3OJX4jYPWYgxINL0WS9DmcHRfgSwGvueyf9tq1lA5rv5FtJJnynFxWJCsJTUE3F/nsD
         Va5l5BaS+YQjnsXk4OqPpsXO2utsrEnTt2MCFWa5rV2kKjGui4nMu2QO68jXLcxLjkLO
         20jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278037; x=1793882837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T3fUcMFmh710o9+atl9jikT4OKUqBTr6Ka1BPlTnx4k=;
        b=u4ZMuknHeWrVElOFF1tE1gTEVrhJB2h1n4iB1JXTswMzMOLVCvn8GClTvXtW/5ICic
         hTdh6+dVcyU2PEJQSpL02paGEbe3XYDr9T6k5/a03L/4BM5A+BflrG5oSa+9HMXP6M/O
         ZBRjdF9P0UShlhs7TYOrPhNyC4mjn5s9qLOpzY77pH/Wrhs7yd0ImclBzu9b4XEeTgw/
         aicL73hl+VJPr5s4UIbRBs8xzOsiz0H9gV74O8kGg+llJk0nZOKABmmM6k6gMh9aA4Kj
         UX6DLpJsWWvHsOmYVMaCzIylhv8+D3FQbqhwU2wDuSLVc4koV1f/+lkLqNE8p1FxM2tZ
         fjhQ==
X-Gm-Message-State: AFq9FYKVHxfZWlTDYJ03YEa479MMpgEaZB6Y9HPuo+eSsRA7wCWFGwlH
	Rhr++NSlUKO6S+8oZaU92B8GiR8BGbtg3EgxcE34ai/2Yi1R+numlRw/W7HtyFoXUNHoZVV77mq
	h6RD72Fa5PX4TReRN36AFms/ajUgZpVs=
X-Gm-Gg: AYBFou3kxJIQYa38lG3mClTN3pDELr8fkRNHZlI4dYyauCDjbNbant14ShoU4MHSPa7
	D2UQUozPfFjajlQVnL5hUFIkwY+loF4sPDoSAiEUQj/IhYNIh3Q1ASPm4q24/spUJWEioZJYSGb
	QMSpBr7eh/1WfhEVAX3Vkguv3XGm6siC68j5S+weL23FBgvtf/MABaJ9wt5IS3CGNKW4hCkkkjf
	avfdLql0iH5kzyKVCM+qYNxWVh+Uiz1PykjYQ/jxZPggLk4ZVaugsVKKPEi8zZbGz0lYumopvsR
	KPqJsREqtBADzaUwzqsUVtsfDKbIonpLjPCQYxAHNAfMuRzrkSR7pU1znvilBnOkt7lb3KqLTcF
	v3anFin7HBDEfANTVbSWeN5kp4TMBXi/4uS2Iqd8gNUeoJnYz4+Mvll/yNe9S8D0TH5JiAXpyKX
	vsD1ffvAKlDTZ7t0Q+hPIDzlhZc4VkkQ7AS9HyTow5cVlQKKRpfM/JXS2ql0CeGYUlf4XzE6rsm
	fhE8SVSddd9xyfgGP29Dw==
X-Received: by 2002:a05:6808:11c9:b0:4d5:27da:a498 with SMTP id
 5614622812f47-56383482facmr3688380b6e.50.1793278036705; Thu, 29 Oct 2026
 05:47:16 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028093455.76247-1-okhuomonajayi54@gmail.com> <auM3DGcWTL5OdRnD@pks.im>
In-Reply-To: <auM3DGcWTL5OdRnD@pks.im>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 29 Oct 2026 13:47:05 +0100
X-Gm-Features: AclHuK-qYqLS2f0TjL4-AbYhCvHCbKoMZMRMKbfOKqVH7jjXssqKsbn-p9ZS0Pk
Message-ID: <CAFpMFfAB3_LioY5zwwfbnZMnX7Upkmrj=+Zi-ku2CTbmNUr98Q@mail.gmail.com>
Subject: Re: [Outreachy PATCH] bundle-uri: use the passed repository for refs
 and tracing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 1:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> So shouldn't we maybe also fix those cases while already at it and then
> drop the define?


Thanks, Patrick. Yes, that makes sense. I applied your diff and
bundle-uri.c builds
without USE_THE_REPOSITORY_VARIABLE. I'll send a v2 that converts
find_temp_filename() and copy_uri_to_file() too and drops the define.

Junio, please hold v1 from 'next'; v2 will replace it.
