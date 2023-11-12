Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0F6FA2
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9iVdg8e"
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6973D2D59
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 01:15:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32f737deedfso2065089f8f.3
        for <git@vger.kernel.org>; Sun, 12 Nov 2023 01:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699780530; x=1700385330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdnm64CbKFFINh1A5aCCDMKcerA3eFC658QW6Z87Vx4=;
        b=N9iVdg8eKZPf0gTJYlCvMwVt+luu57J1y0tiTrkJmCFmGGBHs6EJV2BE+jSKpz6YlN
         NBf+5yDIkB49Tp97O297C4+y8fW44rmCB3R/ipj3qWrzzH+YkmDve9Q68txK+kFBC0lT
         JrT9CN4/p4O3q6bJ069X8cWsiyolHg88mhfKjyK0FrqxW4nyCaXcnsfwRVAIz1cCYR7r
         NCOaSKVWXU/yNjUOsd2Oi9padob76bBp1LcNq3Y0WXKi85WpJ9+hiG9ZmEMxTwRj2xfK
         LHz/BKgvAl8ujnoFFR9DxWcvj6+Hmf7vMq+NgzRy48aFVJEcWLTtR1NRylQHNCaXrwYl
         qknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699780530; x=1700385330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdnm64CbKFFINh1A5aCCDMKcerA3eFC658QW6Z87Vx4=;
        b=Fgc7vkgQ9aYFDXWOLTUhZKU5az5UTEqcjcrYy0wPjV5sdnoQ7f+lGPo/SJw+yXrUCU
         gOD1JB7oAaGsGBUP4nbBG5cMDaJQIj79hgYduG9lBGhCbeFEtBO2475TqCBqmvVJ5iKp
         v9IPaIJ7+OoIgrlb1xIFekHXlFiEuDfIbL5q9Jqjmh33yjuzPu8h8iU4nOy2sspfAQdZ
         E1AX+Koz+zveIb2Jtu52xfkhy+bTp4TD8XfkVS6//gNR07J+rPhrmW3rD+KOpJJ0ng91
         ROHlnyT8fVx8RZx3sn3zNLOpGL1W/FpBEhZulY8pm0Svumc3gQov0z+of223isYxW9gA
         gcDQ==
X-Gm-Message-State: AOJu0YycaI9uRPtIvmldZXKXq7BjyHwAh2Zy4Eq/WPBnxMOS5arsKQBr
	8IUF/vRiNK49nVxcuodTF64=
X-Google-Smtp-Source: AGHT+IEgSUwSO13Go5O/3+d7ObxNzTWpiVd5ksLA2G7f3CixDB8zugjwEUguYHxGXQ+0C3GYYRjHOg==
X-Received: by 2002:a5d:6d07:0:b0:32f:7bd7:9f1d with SMTP id e7-20020a5d6d07000000b0032f7bd79f1dmr2311626wrq.48.1699780529614;
        Sun, 12 Nov 2023 01:15:29 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id h9-20020adffd49000000b0032d8eecf901sm3022010wrs.3.2023.11.12.01.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 01:15:29 -0800 (PST)
Message-ID: <859a0c38-b7cd-4d6b-a4c8-c530fbe6e928@gmail.com>
Date: Sun, 12 Nov 2023 09:15:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkout: add config variable checkout.autoDetach
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, pclouds@gmail.com
References: <20231111224253.1923-1-andy.koppe@gmail.com>
 <xmqqbkbzo6ba.fsf@gitster.g>
Content-Language: en-GB
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqqbkbzo6ba.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2023 06:04, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> 
>> The git-checkout command without pathspecs automatically detaches HEAD
>> when switching to something other than a branch, whereas git-switch
>> requires the --detach option to do so.
>>
>> Add configuration variable checkout.autoDetach to choose the behavior
>> for both: true for automatic detaching, false for requiring --detach.
>>
>> Amend their documentation and tests accordingly.
>>
>> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
>> ---
> 
> "switch" was meant to be an experimental command to sort out this
> kind of UI ideas, and I think the fact that it requires a more
> explicit "--detach", where experienced users might just say "git
> checkout that-branch^0", has established itself as a more friendly
> and good thing to help new users. 

I agree, but as an experienced user, I nevertheless prefer switch and 
restore over checkout, because those are rather different tasks, and 
with checkout you're only ever a small thinko and errant dot away from 
losing your local changes. If switch and restore had existed first, I 
don't think anyone would be asking for mashing them together.

Incidentally, as reset is similarly overloaded, and restore can also 
replace the forms of reset that take pathspec arguments, was there a 
similar plan to factor the head-moving forms of reset out into a 
separate command? (I realise there'd be little appetite for that after 
the switch/restore experiment.)

> I do not know how others react to
> this kind of proliferation of configuration variables, but I do not
> mind this particular variable existing.

Thanks. There's also the checkout.guess variable as a closely related 
precedent.

Regards,
Andy
