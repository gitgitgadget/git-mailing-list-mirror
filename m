Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D89DDA8
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705750283; cv=none; b=KYDBFRqUd1FPiNep2aKW+/WfS/e1ZkYafauDSnBKjGjpCEFyBQ1x+bbk1mvWSJEHLGpW6/adEo3cPql1oBTuqP+p0nfu14R5Hk+yMPXh+WDqPvSsdVSH81k9oinC8tr/sFdq6VU425YorDfzTxsxuzhHe6+owEBjm4r0U4GoXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705750283; c=relaxed/simple;
	bh=22Am5Oei2PMkPlv0OL9hA+7tWLA6bXa12m1GJqchkZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dc8Z7AiGtUbrS1AxyWm7jwKKuPdZlNYX/DfiYuhL6cZWUfX2//wYOEs5NUKMMb1ZbddxtO9zdkUTQHmxmPOuvOBj/0YM6ZranMGGA5oQiUEBiw7yzhoYMWQMQ3vg+e0LrC1shugM4+L7trHuZB0aMVhmuABjOikrFsjiMwBCLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+1bjEwB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+1bjEwB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e9ffab5f2so13487155e9.1
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 03:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705750280; x=1706355080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHPq+Nd8k1dEJgb6Mxh1O6FmeC3x19lKWjzuLcokECk=;
        b=i+1bjEwBmrkUSjAfQJElqf/oLNojVJ1LV/5duoLbS9dwZBK4453KdN8tYrTFZiKL/2
         pndcDBKzNpTns2rrp57TzjVlaVdsFYC7Fj3Gc4c9ZGblr8RF6tbiXMamrBAj6kR7Zs5H
         m4aP+8VwmQ1kSZJAsxpcXhc9bwQIV5H1tmHB99l9pVJxJfrTS6wE0fzj9ATuIUHtSmot
         IATV5pwb8IkYWgQoFZuIy6xVADfkIlNNlhHE63zHyiEkAcVa5rk6y56vENOx8WdK4B6W
         DxfZpeiYmE5vUAHTRTA4k/1QQyXa/rOlM/1I5/N2LAPyrJxMyQI6dh+xfv+k3AwRPD8/
         JwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705750280; x=1706355080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHPq+Nd8k1dEJgb6Mxh1O6FmeC3x19lKWjzuLcokECk=;
        b=u5INilbZgaqsruwSD4Ppdsay0z/c0c2Yo16x365gEGf/v4bc0mYhRg62FEMYfLEXWj
         Wvt3qjjWdgf8g0g25PTfAjZRHZFu7ZaguMAIMX/fyCGcOPVT1OhdjMldWgbSpg3vGtJN
         CIDSfCbVGqy8iuEGb9/W6fWxrxL3grK9RPH9BGcaqT0mF+0Bs7k74frPXyt/cj2+Ew8c
         gpoRvosGj++GkUKwSGXAPzr0X+IEZ4KPsriF1BEgywEnX4dynBWIHxSKeY6NtTpBDgBg
         t38MaLChL+ASXYR3RxYDfs74cecuA1k+OdJZIziO2iSk+BIcE6FeD2JfSe5bQSx7LEsc
         kNfw==
X-Gm-Message-State: AOJu0Yw4jOlXGyu7egCx56/l16ggsWIXxPa6oedHNcwI7mOLaC0D1dEX
	6frh121OAvnQ/zOoAh9noJ2QVPAhFugnfYXdzOHaLnBMsuD/zL+V
X-Google-Smtp-Source: AGHT+IFfUlmmzZjWxOpv4XnNIYF3vkvDWS5N/gAbhOSMMmC/ixDjOf5ASaiK4s6nrmXmKtHnPctBMg==
X-Received: by 2002:adf:ef8b:0:b0:337:c261:532b with SMTP id d11-20020adfef8b000000b00337c261532bmr790192wro.117.1705750279486;
        Sat, 20 Jan 2024 03:31:19 -0800 (PST)
Received: from gmail.com (195.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.195])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d4645000000b00339281d98c9sm1402293wrs.72.2024.01.20.03.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 03:31:18 -0800 (PST)
Message-ID: <6a27be56-9d52-46bf-8136-5f1c42379fd1@gmail.com>
Date: Sat, 20 Jan 2024 12:31:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
To: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
 <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
 <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
 <a97b03a305a7b8b95341b63af1de0271@manjaro.org> <xmqqil41duov.fsf@gitster.g>
 <d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>
 <20240111080429.GG48154@coredump.intra.peff.net>
 <5f322b3e6053c27dda58ef1c1f025d11@manjaro.org> <xmqqil3qsdkv.fsf@gitster.g>
 <bfded0571f133ffc1612fcbca1811a43@manjaro.org> <xmqqwms6pf72.fsf@gitster.g>
 <dd82bef87fd82f7c4bf7cbff5f873141@manjaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <dd82bef87fd82f7c4bf7cbff5f873141@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18-ene-2024 21:50:23, Dragan Simic wrote:
> On 2024-01-18 21:19, Junio C Hamano wrote:
> > Dragan Simic <dsimic@manjaro.org> writes:
> > > On 2024-01-18 19:26, Junio C Hamano wrote:
> > > > Dragan Simic <dsimic@manjaro.org> writes:
> > > > 
> > > > > Perhaps having both options available could be a good thing.
> > > > > Though,
> > > > > adding quite a few knobs may end up confusing the users, so
> > > > > we should
> > > > > make sure to document it well.
> > > > 
> > > > I agree there is a need for documentation, but we are not increasing
> > > > the number of knobs, are we?
> > > 
> > > Perhaps there would be one more knob if we end up deciding to
> > > implement
> > > support for both approaches, as previously discussed.
> > 
> > But that would be just one knob (which I personally do not quite see
> > the need for), not "quite a few knobs" as you said, no?
> 
> I'm sorry for being imprecise.

Hi Dragan

My original motivation for starting this series has been fulfilled:
Give the user an option to tell us not to include the disabling
instructions alongside the advice.

The current consensus is: if the user explicitly enables visibility for
an advice, we can stop including the instructions on how to disable its
visibility.

As reference, in this thread two "global" options have been reviewed:

 - To take the disabling instructions as an advice in itself and as
   such, as with the rest, we can have a knob to disable it.  Affecting
   all advice messages.

 - A new knob to allow the user to set the default visibility for those
   advice messages without an explicit visibility set.  And so we can
   take on globally what we now take on locally;  if there is not an
   explicit visibility value but there is an explicit "default" value,
   we can stop showing the instruction on how to disable it.

> Regarding the need for that additional
> "global" knob, I think it can't hurt.  Some people might even find it
> quite useful

I don't quite understand what "global" knob you are referring to.  But I
share with you the feeling that a "global" knob might be useful.

The current iteration for this series looks like it will be merged to
'next' soon.  In my opinion, it is a good stop for this series, and
maybe we can explore that 'global' knob in a new one.

Thank you for your interest in making this series better.
