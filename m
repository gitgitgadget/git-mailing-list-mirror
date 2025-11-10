Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D22FC866
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786538; cv=none; b=LG0pAxImp0L/UyrIw3MAgw6K1Uls4sLGm5gfFqo4LoqzL/z4S0iB5hAhcifrn9XcW8ZS5O34v0NiV1NlgDj7c2nY5d6r/TpiFtSgeMua3WPrmK9j0b+USHxpBY8ym7eDAJO7mOFy0eDiOhsEB+PRgTf/6lTLWcjCGyqrZOC99nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786538; c=relaxed/simple;
	bh=Msm1h+iCh15JRRG01rc062eSp2mxHPR9siWmoyJGZ2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=E70noGNc9YiUVPlYwQ2o3DEw6ndhMXsl3mDb7igf09Ggbb8WG50qIJSKrm94ec8/lQCAzObScLbTmhMtGO56kphT5vQYTgYFHMEs37QFH6+DAyupcM0qIiaZy0p+Giz4Kmq9iYfMCBrEHkiQKGO6/yLcbRecCU8GQstcW3smnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4Q8278M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4Q8278M"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477775d3728so15187975e9.2
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786535; x=1763391335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNnRMN6roz6jRO9thp37HLWMwZCMYAoSUkQuUp1D/Tg=;
        b=F4Q8278MgTTuKSAlYs1wBhKnHUAw1AklftFTPhOKGHcGBY0zcCMLMFEpuSr+Aq7jcQ
         WbpSg4/kL8yzUC1fN19gU9zGrTm/J9zSAA37voeQZsoWaMUeaadWzGy3uITfvIjQPtuu
         gm2T2PLZLTQ/el7on5HkXfRHZqecLrx2Nr0Iq6x9jUBtLOWO/17FYIn/WXwoMDd4Klwp
         EP3xrFnSLzozmCpUvcL1EVgSLYtil4rXMu6Ap+3Iz5P/jcrACeumarkT/7xGjL0+7pBm
         0caUZfmjbgKfA9EWnoR2WNqobLgQH0UUGfxgGwLXXmN8kIM85ZPMvPMBUgNvYQW72iUE
         9qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786535; x=1763391335;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNnRMN6roz6jRO9thp37HLWMwZCMYAoSUkQuUp1D/Tg=;
        b=MQ8GOU4tEjjP0c0qlk3pslVZNFxh6eWaG/sEgTaHXghr1ph22x2tkpU5P95pTt38g4
         uz8+FF7SsJP+2tKCjh2uiQMibT4g5l3AaOO/D7mQuFFe7ciaxRZxsVuldQtLedt/ivNC
         8GDWX/k3FJqc1hSyD4CFThTwpP7CLRYC2huj3AZaEAJO+tLhPMsxhUIq9fcCZSxB5PmA
         EIogj/9yTWxPvC13d3T0AtUUBQSuQy9SuOMvWPq9reQJc/zWMNkKo6NIfR3Z42A1tNC4
         b6YCVccI6dWVUD+iTzsPwEeNeQ1WvkGUPu3DcwPRNIImggbRiYe+tsOzTdBRjkIKKoFm
         nrIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5uPY79TX4Yx2eOZJTLxpEP4ML0eXAw/q3oHvnmKsX36xalnBMWPEiukhfGa8kK+RZAr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBaOZOBDFH7ZTAi6XcGOHTaefnXhox9JhNf/F/a4DSMKHX01j
	EJWhXrqfL8QWQ85Fwd1hTU2qw1+L0JegV9ThBFbzfWRp4/Qr8a7pGpGM
X-Gm-Gg: ASbGncvNkrjKWDM5zOLrAonQRcj0DANLbYM22LngwtGp1q/k8IIFv00JqKMek7eEHWT
	nBLtTgpWij6P1S8zBBclfSA9FOAU01cIZM7sOG8LPwdqF9mIUdj/Qu84xQ7jXOm2pByRegcryh0
	xeMAYaw0tVnxYRqn8iBh5WiQmNKOz3y3PniBR6HP1QwBGhGZ6LV1LjXkjdDijTwpvTrmGAi99bP
	O0BZI4zSI/4gU6zQpz2f5lwX+5pmzc5ndI7Nj5SRbggfxGwBcEcNM3uPFKkuErIAkkTcb6PJKC/
	Js3cpLX7IQhx4khonmPBgWbKPD7AH7PA2rI4agIhwGL94UI8MwvfUT4adM03Z69FFje8haXRozU
	1qAALyXRmFJTeTyIxVAgzkwNKr3cRficX00wgC/y1u++BW/6RR/vlBUI9pjEd8c9eghOmmG/PXO
	EDjsJK1LncpxjIG+FZPa8FJt1b3zWLpQyUt4thVgxepYN+ACVO7Hbl6+L4icr4iUI=
X-Google-Smtp-Source: AGHT+IHfbXPxLSS5BMYnFdJeROWmVagCZXaFZ3Rhyphe0oLeP1JUT1A5XP9UF0TTKlFb/j7DrBaDpw==
X-Received: by 2002:a05:600c:35d1:b0:477:7d94:9d05 with SMTP id 5b1f17b1804b1-4777d949e90mr25026225e9.35.1762786534664;
        Mon, 10 Nov 2025 06:55:34 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763da0242sm111343375e9.0.2025.11.10.06.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:55:33 -0800 (PST)
Message-ID: <e14d2d1f-f147-49dc-897d-87f0fbeaa275@gmail.com>
Date: Mon, 10 Nov 2025 14:55:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 12/12] attr: enable incomplete-line whitespace error for
 this project
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251104020928.582199-13-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>
In-Reply-To: <20251104020928.582199-13-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2025 02:09, Junio C Hamano wrote:
> Now "git diff --check" and "git apply --whitespace=warn/fix" learned
> incomplete line is a whitespace error, enable them for this project
> to prevent patches to add new incomplete lines to our sources.

Makes sense

> -*.[ch] whitespace=indent,trail,space diff=cpp
> -*.sh whitespace=indent,trail,space text eol=lf
> +*.[ch] whitespace=indent,trail,space,incomplete diff=cpp
> +*.sh whitespace=indent,trail,space,incomplete text eol=lf

Do we want to check for incomplete lines in our documentation files as 
well? This series does not update WS_DEFAULT_RULE to include 
WS_INCOMPLETE_LINE so we will not detect incomplete lines unless we set 
an attribute.

Thanks

Phillip

>   *.perl text eol=lf diff=perl
>   *.pl text eof=lf diff=perl
>   *.pm text eol=lf diff=perl


