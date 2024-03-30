Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D21208CA
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711805762; cv=none; b=SqSMBHcnkjCnOY1Kcy71BuvGntxwvnGh/e4D7HaLrBjMnZuVKdZ0Qx/VaGNUQHUJx5/7JegaQrXZM6+woAD6T3HaOjxAtT4R3n2YaHgAqeIkaY2ILsR4YQ96Rh5QAlXAinQFHzlfpkUghQdZVQPEfp8PmaWLICt8Q9pmTfDPPgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711805762; c=relaxed/simple;
	bh=/oAh9XL17fr1ULT647Ynjc8bNbALzoM9ru14F4OJIWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alk7MhZbMMDL4Ks69PjljwokMCKWmkQfAQFsHoqmil9v7fk0uJYrlWvyDwsMExWoRWS7UX6lr/8Q06atb8vrK6w3dwdMv7oPJBB/jCevdZeLqd9/WPYxz6JDtTArhhyC5cxs3Su+rgeIrg1cNMVqBIIGsDRjpINzF16NmGVhxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPm+c8IX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPm+c8IX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so21388915e9.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711805759; x=1712410559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWAYCn6WwVb8tEBNn4zWG3yQLp6uKzeO3ovPx8MwGsk=;
        b=QPm+c8IXOEDaUFVdm1d0mpkkI518s9lzQ15JMSu6F7DrLZOe/bYEMLxbo/hGdmQwAQ
         JIFDQVbGUQb7u5iBJK+FTRAEy3TlT7GPW/lJgfFyu6HIbbaC2Q518vRQNP4NnjcvQO7x
         FmUGeGC32D9JM/0LTZNIP7rIVjDNKHAXp4j2gt8bGZtfxiK5OEijnxRIr9Mk/mg2LvI0
         /X7yjN8SxRgIj4dr7quudHjUksrhaVE7D3sb5GM/cdhE4/H46MbAwf8VAe/0brzwhASh
         Xg7yyGp1dpBntO497aRDdwg7bMvLmBFDuOnFFiPtx0Xpy3z6I9e+u3iUrJNHBokYYugI
         9Xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711805759; x=1712410559;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWAYCn6WwVb8tEBNn4zWG3yQLp6uKzeO3ovPx8MwGsk=;
        b=Qp2LVJzo4/kSUOawetYk+SWpzOVoS9oO7JnXPMVqa00DcTTX2ckueL9cyb1WLfQp61
         5nS9Eh5rBhmmFuyA5EEsUugfDg7tLYiCTLFcI9qwiwctgnDBCoRWJpH6v5hPVPgtgx9p
         G5UiWzhU41z8DtoPGeKoWwt809Urje6SNuVZJFSv6xTz0yQdrvnStOAwYlryrZmlcTce
         D1Q7EbLthSu9/+WW2kzVARGinImQ2bOijUG9zAMN3PsPoaqv3FrafoKPnnXHnPg6nemi
         BpD00QUVAQBzrRlJPyo64Okf4WCcL0EvsQHTGphhHj1/z1kbk+9RQfDI396Wm5177l0Q
         xdsQ==
X-Gm-Message-State: AOJu0YyLENpI54Ex/8MGxOOP+81f0IDcue2jw0lXN/kjDkuT7MPkxXFz
	qDXZFTVlK6gdzOFL3lwtspfkAi2qVpKef7dS/RY9jbBJuW2bJ4R9lYh/59zC
X-Google-Smtp-Source: AGHT+IEHf9S9LPJea9qF1Nf2zvKGTBn94yySSO+Z2bwRmG4KzIQkz6MzQ6Qm72k5dCYfkALh26ao2w==
X-Received: by 2002:a05:600c:45d1:b0:414:8865:bfb1 with SMTP id s17-20020a05600c45d100b004148865bfb1mr7383984wmo.8.1711805758721;
        Sat, 30 Mar 2024 06:35:58 -0700 (PDT)
Received: from gmail.com (40.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.40])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0041488cfd0fesm11608464wmo.28.2024.03.30.06.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 06:35:58 -0700 (PDT)
Message-ID: <df826861-2938-4652-85ca-c81254af5b2b@gmail.com>
Date: Sat, 30 Mar 2024 14:35:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] add: use advise_if_enabled for
 ADVICE_ADD_EMBEDDED_REPO
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
 <0e38da05-efd6-451e-bd8a-b2b3457c0c75@gmail.com> <xmqqcyrczzv7.fsf@gitster.g>
 <de916779-3c0c-4cf0-b78e-d0536c65af0e@gmail.com> <xmqqjzlkygvh.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqjzlkygvh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Mar 29, 2024 at 12:31:30PM -0700, Junio C Hamano wrote:

> > Good point about the naming.  I'm not so sure about the "only once"
> > part, but I do not have any strong objection.
> 
> I am not sure what you are not sure about ;-).
> 
> If you are adding a test for a feature because it is not covered by
> existing tests, and if that feature consists of two parts, it is
> naturally expected of you to cover both parts with the new test,
> unless there is a strong reason not to.  No?

Sure.  However, I was not seeing that a whole.  Only testing the advice
message seemed sensible to me.

However, your proposed test covers the whole feature, and it shouldn't
be too challenging to modify the advice's text if we need to.  

So, it is better.

Thanks.
