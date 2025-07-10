Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6928C02A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189983; cv=none; b=F3smuw5dfaZuldiYO5bJq+PJXlVTd7tgXLNv9gZaN/KFjYs2aajkXPj/c1qZxTiKB3Al5tiy2Tc7ocEigGDYV8RNd4n3XqdteFR2QWfmx7PQg0AC7FMmGgNFmh/SRRapK838dl8GqdSpCef0j8CF2t4s6vGlNYe2g1Rq0pDJT+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189983; c=relaxed/simple;
	bh=WQ/+M805VPMqR9HkRiYnY8kPN845JDQq5LDD878BWvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Atlc2+qPRRtg2QG/HKwB2jF6xKxbowI54MK3igMVLmj2a7BlrPqTJRnBInV9KTek4IqQfsuAmAn/EbsUhXzlX1Al2EqiIqFMeoXf0RLGNgEfKNR4hbutrNvrnuHU1n1cPczYSqzvDs5inzVg0QRcSwXCQEfpOwS+18Fgkg16Zjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7kqtARW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7kqtARW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so589180a91.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752189981; x=1752794781; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBN77VG/PjKE4KrutNgnTohGBpbrJJPOBvgQh8RP3ZQ=;
        b=c7kqtARWjPrfkM1zqmGll5l7AO4CrLVf+RxKNV95iBzQ+3Z7+RF76BQ0JAI82/U+Az
         T3EsNEgj6Ggdz6KiE9T3QJ9oRR/+OFJtPxZ5p14HsO4NI4s9fE10G5C+uGMjAp6FYabA
         EbU3XeKZqbiW4JxGNf+CTn2/FNnmGYXUgkoWjBoSBNPH5I1nG+LxkeZT1lh7RZXIVyWn
         RkDIciUsVMYmyb02DA+Uj4o2HjPIjZe5wMqLdLjfgVkL2LmPn4K3+JU1xE5qweoBUI6Q
         mT3vVN7x4yjFaWRKV8+dQS9/KbVHEbB38oAN9d9gwg+VDYp3BSft+Eqx0fZaJya3B7GG
         +3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752189981; x=1752794781;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBN77VG/PjKE4KrutNgnTohGBpbrJJPOBvgQh8RP3ZQ=;
        b=VaBt1FfGjZBwjKgJgpEhoN+nfYBn5/oZ0j4qP8HuYJR5TJiktf/yVvdsAydwGZPhXd
         1dPOSTlJD2E2zQ5Q2h9+DgB8wgATG4v/ACpadSfeQ9rlHz7fZBFNU/9IFhgPKuXNjXYa
         KGKM2kpA3wB94mlJxg0+V+WT8Ri4piMw0bmPVIVVD3fvDL5JJY3JCFdisw5NEh2mFudv
         8hkJnfcZKb8Xqx7uobnZVs2arj8HBE8qQkt66Q+GYg41l2ZI+RGv+IhXjyUKsoqUUSMh
         32m6S6cOJsnZSZkFKiQuxIAn+Lw/sg20mMcxyXZ/JHhjZ1FxFWV1TFFP5j8ihf96RhPz
         iQxg==
X-Forwarded-Encrypted: i=1; AJvYcCWngy3ax9axOHKthd64MexxOeKUZCd5d7hCFtYols7yd8vOj+mN1nBI0NANEA9H4UjBEis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXflwTkJX3JxgSb+Uwuhp1uGgEuHBdK6Ra/DIdqLXGFHu3MUC
	FwFvMp7f46jOxBQ50k1WiKRO7+OwTMKRphbpHOaldcTjzZg4wD5nnCmx
X-Gm-Gg: ASbGncvJqhq/Nbte62lVD6mjMpOui+jgCGUFOkENc2IrW1hMlRafbTbL+mSM+/li7F8
	k7c+A1Y8Ki45rsnCHh2GB15Ayp4GB80bH+yq784KCG2LCJFyN2o35dEATRYzj15OOZ72btd3Tni
	Wx3ayTS+8oqC5Q3ymo5kXRbAx9lmXv4EySeT9YV7HgRaMpt9YUj4JgH698KKxTmv7Sruj6z6NLt
	4eweTwvXdyKbHYL/wI99BLJAssQUFTLdLvZSeWKm/mK6Xbc0P/WwU+Aonb4MQMFDeDtdpD4diqH
	p5qeufGMJ/p8shzNtMnJbAvglELMVqENxmuz+E4dp25e94oVbLTbvGUjmmL5g/MyUCn12+fK9p0
	ZmhX0JjRWApdWyTbem/M+FOMgxOUpURcR+7kcrMo=
X-Google-Smtp-Source: AGHT+IGqEoNAI03UWfkMynCWJBebwfCO7cGwx4A61BLwQfO5b6ecmCnf4nmppCpkh7CowaNj9tKxww==
X-Received: by 2002:a17:90b:1d84:b0:312:db8:dbdd with SMTP id 98e67ed59e1d1-31c4f54963amr516870a91.28.1752189981435;
        Thu, 10 Jul 2025 16:26:21 -0700 (PDT)
Received: from XTHCYRY1WD-Collin-Funk (redis-162.tisch.gvad.net. [207.135.66.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003d2e8sm6541063a91.8.2025.07.10.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:26:21 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 0/1] Filter C and POSIX out of Accept-Language
In-Reply-To: <aHBH0nRLPxBg2HAj@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 10 Jul 2025 23:08:02 +0000")
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
	<xmqqfrf34qdb.fsf@gitster.g>
	<aHBH0nRLPxBg2HAj@fruit.crustytoothpaste.net>
Date: Thu, 10 Jul 2025 16:26:20 -0700
Message-ID: <m1h5zjk4pv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm not aware of it causing any practical problems for people, although
> I could imagine some cases where it could, in theory, break things.  I
> merely noticed this in trace output and thought we should tidy it up.
> If users are using the header and expecting a localized response, this
> will make it more likely that they get the one they were expecting.

I feel like it is a bit strange to only exclude "C" or "POSIX".

I think the correct behavior would be to accept any values, or convert
the current locale to the closest BCP 47 language tag.

But as you mentioned converting them would require a database of all
tags...

Collin
