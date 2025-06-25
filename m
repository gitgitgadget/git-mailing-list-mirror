Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59A1FC8
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880134; cv=none; b=IKcWH+FoxSRSoWhnRwrOf9viGfvyBHHlJwLe0nJsF5mT8Hq2APJzSwJ6IJ9UmDnWC0FCcr4C8hNeyqlenfxe2zPG4Y6WsjwX8EYp8J/Oq9T+Nog8mULZ1sULygaPqaq1YMQRxhrwV27mBONtoqPaGbp8NHsLhAgF1AXik0+lmcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880134; c=relaxed/simple;
	bh=399NIasFpbS4PqXZh2hakAqhTcre5uyf2XEJh2T7G4Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EROZ89bGrudGhJsanRx42ifhmMFzJzJaHx6byNkxtke2TFnaZb3SYhJIUuaSfLlR0hkpOu4ZlismE6ciZUxe3LaQo1YwisKmWwtSsUnO50K6NX8fH5fSIse4FNH28xkYzy+Mub/YJT0cW5b1e30c/alae361Gj+aqtYpHbNr4sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkRRH0pM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkRRH0pM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so1374515e9.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750880130; x=1751484930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDPDC/C7wr8Ff8ZYwcaBJv83nzGfZ163beTj6T7PP4o=;
        b=VkRRH0pMPCony+HNcc4PfiI2N+4gFg9dHlec9O5QhYdepbYe9xnaLqjqq3iRoRVRa7
         jBJnw46JHQZ+cMju5HbB5KURO6IDIZbOOmtYUHwqkpPPQxBCirW8wQXldX10x9yov5gR
         hd8+yXIM6SgywVQ+x/8VutSuD6nqgXgm98uA2IwMiRgBRnDYOhWLgGIb8MTDicJLYR8V
         8UQUVFpMoTQRTXFCg2PCtU1kiI+bYqJqfI4QiVsT5SrWlLK+EGqWAwzbmum1ZfTG5W8S
         bM75ehwWP1AlMM+Arsp4ixryeoiF6cUEjfNlKTOEZDnqPTRbbDSTeBAdX/LbSLOCiRmS
         Jm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750880130; x=1751484930;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDPDC/C7wr8Ff8ZYwcaBJv83nzGfZ163beTj6T7PP4o=;
        b=Go9KUa/iVRS/+bW+jiVePX/wwFQ+jzVxf+vrtd3IOCDx7jVtAU28eJ6grGbNlNMNtF
         /gE9UwJ36bG++7rNneDdNkiAwW4tFiKYu1AN2YGNn2oM6TNP3HdGdPL3cU2b0/egCTqr
         8nBWJGpyTg7vWFFdk+2SaOozle86KQVpSh2nu2e6bowlnHq8csUF/QS5g6Z3F791nM8c
         mu7vhzxVj60SdicHGhpiSQBAmProtRgRtCrz8kQQoLLgdJPu2ESISSQM3mWSt07kL7tO
         tWOgxDqxuBlIGm0d5xbQznIi1h5RX9ksFFdCi9Oz+JgnSRaX+eVkTKvlh6qfCXTIAqTs
         1qTA==
X-Forwarded-Encrypted: i=1; AJvYcCXsL3kR557L7D1su2EuYIQ9uRfH7CzRucS1d6xAGOET3vD+tHuXfJiVj0D7fC/3q1f7FYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVE9L5MfsW8MUpbIhWjb+eFjwyGX8nE+dzKL7UHLMXpo64bFXc
	AvE9n4zRleLrNtMbPrRpbkdgWzqshaFO5PTyqAiIW/Ldowuv3nZS5Kuz
X-Gm-Gg: ASbGncuO6NGlSgAWe07wBF3ks4z25kkLcAvvBLNmn99g4p1xThBK42egMW3TA6kkq8k
	peRD3imBm/9Lb37/Y589ODIJHxcFtQqEDA1cc5TpjRNUZNX6unB5dK+1/4xWB9rECEmG7gkjcXb
	kPw3aKktVglO06urtGUZ+gimfC5BoveCcraF8B85rLhR8FGAYC5bn9PmzcwSmMR+r6ewGRbnRvU
	H+MxPFZopDuUKav9Ww3JIGCbqp8qGmEN6J7BtBDc7C9+mIvIFroiSTxBoz/7pPq8rpW949JjeBL
	kro9U90P9saqFLbX1y6jd1AzJPT8iMijBgm5buQ3PakCqCXdL1s12ou2IThgvOqAc6fdaXKZlM3
	iW/t/NYBe/SF5SDrmNvL/5UB017Igjq8sL7pWNQ==
X-Google-Smtp-Source: AGHT+IGePgNM7j58nrvt5addXAV2ZQOuUFSElzW1uQsBHhw4HgPr/s4w19GKNZG9y1MVbd0BYijKsQ==
X-Received: by 2002:a05:600c:4454:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-45381ab0477mr44038255e9.8.1750880130063;
        Wed, 25 Jun 2025 12:35:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f259dsm5443306f8f.50.2025.06.25.12.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 12:35:29 -0700 (PDT)
Message-ID: <c314cd2d-8fdd-4386-bda0-881ff87d9204@gmail.com>
Date: Wed, 25 Jun 2025 20:35:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] daemon: explicitly allow EINTR during poll()
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Chris Torek <chris.torek@gmail.com>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
 <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <907a79d1-da2e-4c8e-963f-05c6e313643f@gmail.com> <xmqqo6ubx00s.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqo6ubx00s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/06/2025 17:24, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 25/06/2025 08:35, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
>>> This series addresses and ambiguity that is at least visible in OpenBSD,
>>> where zombie proceses would only be cleared after a new connection is
>>> received.
>>
>> There is still a race where a child that exits after it has been
>> checked in check_dead_children() but before we call poll() will not be
>> collected until a new connection is received or a child exits while
>> we're polling. If we used the self-pipe trick described on the
>> select(2) man page [1] we would avoid that race and would not need to
>> mess with SA_RESTART and so would not need to introduce
>> USE_NON_POSIX_SIGNAL.
>>
>> Best Wishes
>>
>> Phillip
>>
>> [1] https://www.man7.org/linux/man-pages/man2/select.2.html
> 
> The principle should apply equally to poll-based service loop, I
> presume.

Yes, you create a pipe, add the read end to the set of file descriptors 
monitored by poll() and write to the other end of the pipe when a signal 
is received.

Thanks

Phillip
> Thanks.

