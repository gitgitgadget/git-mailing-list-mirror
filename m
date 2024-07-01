Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B068016D9BA
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862561; cv=none; b=PIjWUv3J+IiuqDvt3TmSOaYXHGdl/GnOPrOq8PVehuila9ZxvTFVg4oCTo6ojVbsevOlP4N6dxF/mZjpinYHauHv9q+CES/RGDlRWpK+NXIZ7M0hBdE580nbEQ4c6Q1VYLGHvb4dh80Fg+dK7RwZ4fUxSELW8gI0di/2PGUrMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862561; c=relaxed/simple;
	bh=MF/F9GXIifAAH5cG36G25pV8L56mLjadYUUFZshh5I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWRZ7K/8koIxGxNTl1dG43FxWnT3oxnAxoeEKl782g/rFDkZQuTsnUC7+Z2zRsUhoWdjhVuJGcy1wXpzJDTPiij3MK+O6tjXwQ9Subzwm3BpmVYaQf0Jrv2n3MALpIpzSknpEUbHnAEDOwjZe11/z96t5jxzWGAhuApb3Zb0mNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBWoSkNC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBWoSkNC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4256742f67fso25008625e9.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719862558; x=1720467358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzK+YBkcvx7qtnr+AkTek9mzAAx4kMVUfdEo7xCxH7I=;
        b=IBWoSkNCX2SNMbdP/GExYh7Ohef2MhMcG92zOTrFe1YutSpMsc/iHhvYT8ALQJFvk8
         1RLvtswz0HHAEeSWFdYcsbn7UA+/Ug0SKakc/J8AZHyuf6H4YYPS75zZmciETCIW84m8
         qYsrcHbBGLkx2N6PdprEzH0xe86ufwGR4blNyiix1aihs/YwGin5vW1oxMy7AqEwH49M
         ZfeUdaWqPU+9+epqFgHfD/jyIRpVAznugBapaarplN++lm66nr7QRWnJX8GqgQiDet1r
         rydDdMlKtX/e7YPDxKR2YTdaqakQDlq6ca1Ef8o/yNOzm5okTHJ5OfxRJ9DCN+okmulC
         A1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862558; x=1720467358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzK+YBkcvx7qtnr+AkTek9mzAAx4kMVUfdEo7xCxH7I=;
        b=DZQs7NX/R9y57Eel3SkeokJIpFymUxz8rfKqo17qj5L/wH4stnwupxpjyv1zODW5n3
         0p+EHadheOGAvhmVZgLndrNxQRF4xPT/aeJSDE7oOdY/bLREb+XKXO0sEwgSMbYzLvRI
         v/XRdcjwlN+0QVBVUumCuMxqELsAWhZUBns7leHJWXtY3HFkEMBizh+glaHnFiMvzznf
         6yn1Fp4zdA5wnjxlF83fd0BOoihm3cwMkTMJARGPPFQoiTWeJKvTHZAtXk5wWCTYPfBq
         2WBPuxhzr9HXzDHD3dsgdN6HbzznATk+gfva6kC6YMPLfVZAI83eK2lDupeOKhxz1tbP
         qMxw==
X-Gm-Message-State: AOJu0YzeXjNZ9l6OxZkjtUueBa96deIQJoauCe/T5hsNZTT0DEmTrRCj
	KXRlSQNVGWzjXk+vsV5burta9Ex7A1UXosRegDocMunbhaj4M0aB
X-Google-Smtp-Source: AGHT+IGJy4lUbf+PWVldeq72YoWYfQrYLYRuq7jSHzZouap6tI3r9yrqIK3Ieu7Tv4rAWLBwM/wmyw==
X-Received: by 2002:a05:600c:4707:b0:425:8392:49fb with SMTP id 5b1f17b1804b1-42583924ad3mr22922595e9.16.1719862557978;
        Mon, 01 Jul 2024 12:35:57 -0700 (PDT)
Received: from gmail.com (82.red-88-14-59.dynamicip.rima-tde.net. [88.14.59.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256d664052sm155919955e9.27.2024.07.01.12.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 12:35:57 -0700 (PDT)
Message-ID: <7ef69875-b18f-4ccb-be83-e994315636bd@gmail.com>
Date: Mon, 1 Jul 2024 21:35:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t0613: mark as leak-free
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
 <20240701035759.GF610406@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240701035759.GF610406@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Jun 30, 2024 at 11:57:59PM -0400, Jeff King wrote:
> On Sun, Jun 30, 2024 at 08:46:38AM +0200, Rubén Justo wrote:
> 
> > We can mark t0613 as leak-free:
> > [...]
> > I'm not sure why this simple change has fallen through the cracks.
> > Therefore, it's possible that I'm missing something.
> > 
> > I'd appreciate if someone could double-check.
> 
> I'd noticed it, too, while doing recent leak fixes. But since Patrick
> has been working on leaks and is the go-to person for reftables, I
> assumed he had already seen it and there was something clever going on. ;)
> 
> I also get a passing result from t0612 (and I do have JGit available, so
> it actually runs the tests).

I have no idea how JGit works, and I didn't have it installed either. 
But after a quick test, I can confirm that t0612 can also be marked as
leak-free.

I'll respond to this message shortly with a patch to fix that.

> 
> I also get funny results from t4255, but I think we can ignore them.
> It's known breakages vanishing, which I guess is just some sub-program
> returning failure due to a leak and changing the test results.
> 
> So anyway, this patch looks good to me, but probably we could squash
> t0612 into it, as well.
> 
> -Peff

Thank you!
