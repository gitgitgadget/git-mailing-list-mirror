Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885D41F5E3
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138919; cv=none; b=B7OXv4+5XGg0KNEQb3nEbpOdW9B4dOnzP6pO6ksY9v4G8o0aJJPTSYJfVEYAzGJ0oL3n4CgbYvtELhJqBmSgIMH2B82TUl3HqoEawaobwAdmbvYHB1DZ/lGQ+gXp3yF4Wr8Q+Vq5JWS5YT5avr/JJ91jVEuQMavbjsOz55rqlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138919; c=relaxed/simple;
	bh=c97uh1JjSqHNQ9gGi/XacaMDvnd2Q37iU8q3wkTPohU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=I1XniSnztEDz+l0qrWaB28UeeNH9FEmxbS6DTOqwKbLicoRoxC1KwoQLPnc4ycqQhs5G0sBH4NLzIoMLNSeabu8+RyZ4AY9UAMPgzRIgGWQt6+AA0fFLP9hjV0HxmhmvDRlsMmYcUD0bcjay3ARPAhG434WxTHNPDpL1zv5Wevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHGPwCQJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHGPwCQJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f431e317so18441255e9.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784138913; x=1784743713; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AZXZVgvp7wlpUFZOFoDTDagPrdH+4f1Lm/Z0ioDzrSQ=;
        b=tHGPwCQJCmMAiKtummP2fxKxD/wAHuN3dKHTFYWoqSTVULEZDaFxrvB5QgEYrNqDQB
         APh/e9eu938rygcSg3jfWLQdfXi3+ZYVQyXJIOj3Ivr567LMGoj7iKKkz/fREppImA5P
         ZwNWWp/hocZySwOwsICRPSgF2Z8rwlw/tsafMdfsoyE/+scumYD6dwp23y6VI2ljZxPL
         i14sBnzryNbfILQ+AFxZUcgVZYMl6CNHFiN91LDIa7rieMh0Fs7unMXfxu3j/wk47ixi
         NSRmVmYf9tey+YWAFRwfLl77EoSsusYYEqDyMrjfMf6WryhidXORHZmB/lhttpk5h3EN
         6xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784138913; x=1784743713;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZXZVgvp7wlpUFZOFoDTDagPrdH+4f1Lm/Z0ioDzrSQ=;
        b=cl6Ht+aE8Ad1KqIm0uJZeWVwQaQl8uj1a9I2cAYTsGyWNuPuv8+cdexSZ2CZSOCXGs
         OJzPTAW/UJ/UYzNPi1ds3hRt7d1S5TgZuCR5xJ/2mmTiJ2d7lOn36ZD0VkKobbobpj/Z
         Zl34KS5q06hFvnFTg2gysAe8nBxfqI7RceIslxPu6TaZ2sXI9TqGMKjJChGpsumlkA7v
         t8rJ1ZBxaapFKLPHpbmW3AIGooUquLOEUTPIdqG+geihHA7KBdtd3JPn6cO/1BodTCK2
         99ji2/VVv0PTCFa5X+IKFBfBOWyrxkioP78K/FPUTd8D0tqFVtmdeZEXCZDsduaOqa+K
         DKPw==
X-Gm-Message-State: AOJu0YyFYVF7O8ZQ2MldTeVpfYvyemYyc9UszhjdD1UFtJRUFTx6r00g
	pDLncxqi8SUDfkSxyM/51VT+eiB//TJOUBm4uJv4viriAt3IOSejTAli
X-Gm-Gg: AfdE7cl954Yulai6YSfcKrIkpSdr1fnJy8Vx0yiiXWFKwR+skDOexLmxxBjokCO980Y
	/xMljS9GOf8LAByaaVD8dDYha27T4dBfye6CfkSqn+aQpKJxnPEs0MBh7cQaZbfT2T2xRspHaCj
	PR5PpxND1tgnjktq/7vWcDLctr5JVFG37jrBTlzCealy5hSxQDVs9uwt3YvpM6gLCTuL0hRBERu
	UkO5qxqqZztQjrHqNRK4T7Sqsf17S5Wj9RemKLsvWMF8Y1Hki1Qmug0JbCrLD7Bs3c37VXAy31g
	TQ6uIUUDHR72GfhF9WeXyI+a2emqYEbtaZYUpqupacBpC56w/pfdchsESwJWaeBS7Z03OGisHlz
	xV7LCcuGrRQC7g0Ya7WdVafTEqMN5VzGUMcswRbT9E4ebKLLKITKkAtZbZ1XTF1ywoKkshvVDrY
	7jExELkAfeq4bubPWrg//Rrhsgaw/cv0R6hgJlmC0zyqwwnCrJlq6Zt04EOzU+2vcPToSfr9OAY
	EGttblLfwURmZMbyj39/Qlgl9jgLwlYzqf+h3ydOep1mEuUndg6ZA4HenJ36o1O+xEmTa2erjbW
	zGnw7abewQFYRRe3hs0WqaPaF/hh0j/tZCQygiDKNiYEFLYdqAUuRDdR9a6y1cinjcgxgAWB4/S
	0PqQA
X-Received: by 2002:a05:600c:8011:b0:493:c0ec:9a5f with SMTP id 5b1f17b1804b1-493f8818045mr197827955e9.19.1784138913077;
        Wed, 15 Jul 2026 11:08:33 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a63esm18562531f8f.9.2026.07.15.11.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 11:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 20:08:31 +0200
Message-Id: <DJZCGKYT43SW.BJZSQ8TO1GF@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <chriscool@tuxfamily.org>, <eric.peijian@gmail.com>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>, "Calvin Wan"
 <calvinwan@google.com>, "Jonathan Tan" <jonathantanmy@google.com>
Subject: Re: [PATCH GSoC v18 10/13] transport: add client support for
 object-info
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260715-ps-eric-work-rebase-v18-10-34d7adb051bb@gmail.com>
 <xmqqpl0onp5d.fsf@gitster.g>
In-Reply-To: <xmqqpl0onp5d.fsf@gitster.g>

On Wed Jul 15, 2026 at 7:22 PM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> +static size_t parse_object_size(const char *s, size_t *res)
>> +{
>> +	uintmax_t uim;
>> +
>> +	if (!s[0] || s[strspn(s, "0123456789")])
>> +		return -1;
>> +	errno =3D 0;
>> +	uim =3D strtoumax(s, NULL, 10);
>> +	if (errno || uim > SIZE_MAX)
>> +		return -1;
>> +	*res =3D uim;
>> +	return 0;
>> +}
>
> Since size_t is unsigned, returning -1 is a bit problematic,
> isn't it?  Perhaps this should return a plain 'int' instead.
>
> The sole caller only cares about a boolean "did we succeed or
> fail?" result, and more importantly, the actual size parsed
> is already returned via the out-parameter.
>
> Thanks.

Completly true, when I changed this from beign strtoumax_szt() I must have
been thinking too much about size_t.

I will change it to return int. Thanks.

Regards,
Pablo
