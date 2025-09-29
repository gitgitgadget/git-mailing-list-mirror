Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4A2E8B86
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140689; cv=none; b=B9pKNKGk9itpp/qLbDntlzL2+665cJbaHfP7cPyiLecmtpQ5S9OxNm3CksDdjv9uP+cCDEFHhaes+g1vfftQ4lB47QjZ0Cblp7hZlbh74yHp+KUkCNXIthhglCPCvvxhulhctX5WoDe/fwki4g785/MHfhPSr1HdyXKNM4VPGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140689; c=relaxed/simple;
	bh=y+y+O8cj1sembAGlq8Z238euMKxPfywCmF2rXF7BlsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uB0rQr8LW6vrSL9fi6srWe5D8wZwy62xijUHGf5+VzlCqvjFKnVOEA6mq6+Cy38mxbkItCUshNjOtm8jTiZ3EThmYrHDJqATWp9De6ZvEjSvoUsxazjscO9tZNsFYDVp1YxJoxpQAtS0MQj03/pLjI4DTgG5mNP2v8gGj64uas4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq2Bsr8P; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq2Bsr8P"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee1381b835so3709325f8f.1
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759140686; x=1759745486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qPOgUJSOTUSXByP7u+2y6eBMEtJFNmmKv0x9SShkL0=;
        b=Aq2Bsr8PRpn34m0AEcH0BrsuDWlZJExk42QmA+m1OqXmWrB3qGyin40ZGkM4EzHxRm
         74gBsc9MA3+NndEIv+xUpNN05vTrF62ukEGM4wIaWOMwLV84cPahwKJh+FCpu7y/1ApJ
         QfhpH0h1vDCV9s2FWfACGSxl8VOqroSNq5N6N45aNlyg0cZuwKJEmcWivnrR8+fxEwzS
         LRZOl+HaT/NfrwMgCbrsiKziVfn+swp+z9G/I5Mn4udu5q5NAkCnpTlvDpOO70+3kk2U
         CRScpbRaxCdq0+W/s741XmssVP9pjl1RT2JFeukCQNP06gm+42YN2IGzUoHOtH7pKIm6
         3WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759140686; x=1759745486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qPOgUJSOTUSXByP7u+2y6eBMEtJFNmmKv0x9SShkL0=;
        b=t6kim9CEiidgJfdztYKs4Yp8QPG+oFmhE3SmPz41c2SxPZlSiNUi3eUwgNbtEc7MOd
         GaQIcAxrjEGNDsf1p8hpNSXq60fn1r+Ko19rurNno6xtX+ARJeDGkTbwILU/5QkBjEh1
         zeEYI8SoHgZjxh/6BMFinE6N3oIgfdWsOWWKjez6ibcqthY4Uf0+qc0gCDnaSNyjPoF0
         WzeEXd1mDCgXaJO5lCbBaEGWGc1po9IZgZ+rwEt52KtunGwTku1javQ1lirnYyXUCQzY
         3KLSN9d7hJ25VFhDrSEM6zfV+443/Jr2P4uu7lNFM+eKhrxlVBqm+2m0okoJcgJPN0qt
         ox7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgIHKt7OYRS+OTahj+J/+ZncA3d4UiQiRpc/9VO53u1tgt//arHIcWdP2PW8iQ9TGnc3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUwxY5R+poB4APKpM64ioYemSPpHVREWlGq7rO2raPeMc8UiV
	7i6yVkVtdYhTdgdNbecMf22SZcm3r8SAG/3iTY29xfi54gYdd/0y5aGd
X-Gm-Gg: ASbGnctvHnQ/F1KGLAiicJPcJbq2adGL5gU6nGURMH7df/haa1VxdADyWfhsR3BBGJc
	eUouB1W8qcmf5fr/blwBmLb6AB46LGR3+sJZOARkCPRDEaSnTPD0fJDTkGZ80eHKoC95dvj4GUI
	Bo3DTjDmAteG6jJZAhLSPHONvwgKN4r3pBEQ5vQ+xo2p4fqwxYAzAg27PPsJWqprLZh8av+dyfu
	2XnKqtAUlQ8NwP3m9MKn+UzQxzMEjx2XkCPNycTs9lgpRFz78sDJwtHOXTtpUWbKCyc2IlF8Jzg
	cf0TuNZygGJHnUP5Vatdlv+UdMGpnxCxr3nFCrEvsinqxVqT1gbPtPqwWM7bOVuB7/uwUYTmNbl
	jDhM61WNz6U9LqjMqX9Hmf0LVHFqC9y46zznsg40a0ZNeuEc=
X-Google-Smtp-Source: AGHT+IFZXl8cSo5mENFgbcJGOu3n/MClPtT/RN/c8OxbAw31DjJ94SOvHmi1d3Hoz/3GUYi0500J9w==
X-Received: by 2002:a05:6000:40da:b0:3ec:4fe:860 with SMTP id ffacd0b85a97d-40e4cd57776mr13702296f8f.46.1759140685387;
        Mon, 29 Sep 2025 03:11:25 -0700 (PDT)
Received: from [192.168.1.194] ([84.64.105.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6921b7dsm17393349f8f.42.2025.09.29.03.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:11:24 -0700 (PDT)
Message-ID: <991b43cb-72bb-441a-bd42-2091bb31de06@gmail.com>
Date: Mon, 29 Sep 2025 11:11:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c to
 hook.h
To: Adrian Ratiu <adrian.ratiu@collabora.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-4-adrian.ratiu@collabora.com>
 <f408e46c-650a-4632-9628-cf817e393e7f@gmail.com>
 <87zfahmcqi.fsf@collabora.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <87zfahmcqi.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Adrian

On 26/09/2025 16:53, Adrian Ratiu wrote:
> On Fri, 26 Sep 2025, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 25/09/2025 13:53, Adrian Ratiu wrote:
> 
> I actually thought about putting pipe_from_strbuf() into hook.c or 
> someplace similar because it's a generic utility function, however this 
> is the only hook which needs it, so I've left it in sequencer.c.

Yes, I was surprised that was the only place we ended up needing that 
function. I think it makes sense to leave it where it is if that's the 
only place that needs it.

>> Why are we running the hook if there is nothing to pass to it? 
> 
> run-commands has a ppoll loop which calls the stdin feed callback 
> (pipe_from_stdbuf in this case) repeatedly until it signals reading is 
> finished by return 1;
> 
> Now that I look again at this code, I made the mistake of assuming it 
> needs to work recursively:
>     1. write the strbuf
>     2. reset the strbuf (return 0)
>     3. next callback sees the strbuf is empty and stops the loop    
> (return 1)
> 
> The line you're asking asking here is actually step 3. :)
> 
> This all can be simplified by writing just once and returning 1 
> immediately since it's just a simple strbuf to write to stdin.
> 
> We still need to keep the pointer null check though, just in case.

We should make that a BUG() I think

>>> +    ret = write_in_full(hook_stdin_fd, to_pipe->buf, to_pipe->len); 
>>
>> This will block until the hook has read all of the input. Unless the  
>> hook drains and closes stdin before it does anything else it will 
>> block  the parallel execution of other hooks. 
> 
> I double checked the write_in_full / xwrite implementations. :)
> 
> Sorry for the wall of text btw, I try to explain as best I can.
> 
> I think it blocks only if/when the stdin fd pipe is full, which can't 
> happen in this specific instance because the strbuf data is small, so 
> the write_in_full() call just writes all it has, then returns.

Oh sorry, I'd forgotten this was just used on a short buffer, and not 
used when we're rebasing. Good point, it should be fine.

> In other words, the most important aspect I think is how much data we 
> are writing to the pipe in every single callback call.
> 
> The idea of these callbacks is to write small chunks of data at a time, 
> then switch context: it's usually the child hook processes which end up 
> blocking for their stdin input which is fed by the parent which 
> multiplexes between the parallel processes.
> 
> Of course, a balance needs to be found: I've noticed, in other hooks, 
> that if we write too small chunks of data in each callback, we 
> unnecessarily increase wait times for hooks.
> 
> This can be seen especially in hooks like post-receive which can get a 
> lot of data: if we feed one line at a time and let's say run-command's 
> ppoll loop adds 100ms delay between callbacks, then from 7-800 ms we end 
> up with something like 90 seconds!
> 
> Of course that is a pathological case and the solution there is to batch 
> more data in a single callback write. I've actually batched 500 lines in 
> every write for those update hooks (we can do more or less).
> 
> None of this is set in stone and can be changed. What I tried is to get 
> similar performance with what we had before these callbacks.

That's great, getting a good balance between not blocking for too long 
and doing a reasonable amount of work in each call to the callback 
sounds like a good plan.

Thanks

Phillip

