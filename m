Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219493;
	b=TzlHQGDELYCadWaVc4hp3a+nB0PykS2DRmvCpj9SicHX4H82nAoOnSB7yEq0llPZKpw/
	 9ZeZs7sPpe2CsaZPpeKp+NIpIArh9j3s95MBO/oSvv0hzzbeFwLv6OlFMtjVTwByRHeU6
	 PliMZowIuAoguFJRiOB1pa+NQr1uryeqr7XhnYpf1RlZ8SwpRZVpSBG2Mo4tfituSWUrG
	 r51GiifRdgDL7wXnF+tCpobDDiqj+iInoMHwxLRLlmTgcZ2sO97d9ce7AKiGk5+/Xf+pA
	 9BzUQNrN/oDg5nmWK6u21Ug4BFNBKW6oeL9JzbOyWHYqnOI0c0L1845ZW3+iK26TD3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PrVC/Du8lhFA0pa9QqHWYOpibgwGL2faJ1NFD4ifmUk=;
	b=pHG9RxqrA4MQmo0uzqbn7KwV1qbskRTSVFYVuNV30LGpdo3k8qn01sf+4CAdD2nsmUo+
	 i7YjeYlV2kq2+8Yz4P0mTpCZ3XZ/w7LjtyONRILP8KPMCNq5deaXgUi8tfg8TTnIqOTcE
	 s7apqVNCHXuYt5vfDko4Y+KCE1nS8jr8PKJO9YSKXg6tZEdRTYuGIm9O+Tgho6PjeKCRn
	 4Y28QL1oZypO2PciFXVkU4vYYsfYfwvUY7Erjs66dujP885Xl/W6shBl5Me4HDbz9OWKT
	 GPeKmxktygUJJkebaJv+Q3mZP2B3bW49nwnEZmwJxfBun/SUryaHIBwsn9Gc6x+gIIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UZXEWsH1;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED95606D82D
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ED95606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UZXEWsH1
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so10231975e9.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794219492; x=1794824292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PrVC/Du8lhFA0pa9QqHWYOpibgwGL2faJ1NFD4ifmUk=;
        b=UZXEWsH1JeaTb63+jiKTl5SMgrrnjg0+Apuw8qa2VBc9coQi2GQf70w+6e3ExSmzun
         jI/3E1wSDhHpx01vPvdMDzyitzZr4FIZTqfB5x+jsfmMnH2+I8gHkasGeodax6DoI2bU
         uFtVo9DL+nY7eqFcYnvTVKTG3mcgOdIEZiOjGRZRZd6n9TzoM9zPV1W7YeDAbSqW8TzV
         D5XtoDgl86BRZLHZGvqLJOshVQ1b0CfmapF2ljG4chmIfbnCNVrTJ1xFedOnKUWs6dU0
         5mdm8n+JOZ6Za/ulsXMmsYvARuddNEIqEoBt/EvZPbq9YuwU7qaNb/YhTCFvLTBPTqon
         QpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219492; x=1794824292;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrVC/Du8lhFA0pa9QqHWYOpibgwGL2faJ1NFD4ifmUk=;
        b=WIgkNacETS9Zho6bNrD5qNNGxSGX5/Dhpv+RLfHmdcYbqgBcYquKf3wwguuRhuJIK4
         H9c6HmMx5Muwj59Li/eYpBVsFYihjgX09ZV+lxYB4yDsnktw2Ydt8DXVJPWonzRR3GRr
         ohyLtFWu2gNF3AdP7rHTUyvfNBtRoVQiPEVRf4T1crNrKXGlsWWU9GeQEoE/rrfSUBDC
         hb7u3x4dO64m+vqY80j8Z6jmRoXAiWpZTwKs86eWq2LjSeCgBK5OLvp2GtD1GyDmofNt
         WuQ1Jws3cpoJZd+8JCbDSOcV6PoCPGlpHYcjAi/BmEHD2J1Qx9oZ66R4i8AmazK5Zyhl
         o75Q==
X-Gm-Message-State: APuU4Z+7KuHv8RzsDssJgnV7M3l5xH5uQbEMFQfJv3rW3dvOZnMXEKu8
	0zaNwXwz+eLYTvax4KizJF40Btt6YwPHpxyNY9mkU4jhSrPH/HktJPEf
X-Gm-Gg: AYBFou0OjyIL9B84XDvTBFpg4fxNUEwQxDbPQog7FgnxVcOD3yrYOJyWHETMPqQMTdg
	hi9sr6tfueOTfyGLOK00mfGeIlw6yEK8hE13C6jJz096Fsui0yPs1pGDxuxRLZ7gILZtwR2K2MR
	8UCinFs0YZZ/c18HosyWd3kaJ5aqI1ZvcDqc6416lW0vknlrizxVW+Ul2K1MhUUePae0TREtMd2
	KxzX3Q2jXIyoF66KWPjri3OGwUt9bA4uXgjxsLlVO5V/PY7buJwmpadBtIbktH850lUMKDMxr4M
	RHU5M9fkf8fzyOgckNrMhu5Gywxhq0ypzVXmik9knykYqVowLYmqTxrA8nH8ilyHgZrekZQAIKd
	vmXtA8+jX+9KE6NOaV8u3d8dKo6Jwds5VCRCgNyC4qnJXHMGD0EHtjZZqInqxtqPVP4yWEo+09H
	ZJVghNLrUHzoudvX2hBJwbsRWfBFzYgvK787Kb2z+KE67FipSy1tbLUBwWNgXPr+V5zn+N1kms0
	e7e26tPko2Py9u3qq2q7pCjQwCpdq11gXjx0p5EDI3q/Th730J94JOn5TyfGMAc/YAPGWUjzePD
	K62Yv+LYokIwlvpPSa1MTH5i9QoEMq2Lpu30fJfgrG0F1sDuxC3Vg66mi06lhkRFKCuBhxXHCw3
	NKvHrUA==
X-Received: by 2002:a05:6000:1787:b0:490:ac98:c0f0 with SMTP id ffacd0b85a97d-4958bfc94ecmr7352613f8f.48.1794219491778;
        Mon, 09 Nov 2026 02:18:11 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186eb9sm8837302f8f.35.2026.11.09.02.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:18:11 -0800 (PST)
Message-ID: <bf54db39-d10e-428f-8c6d-b444f37cce81@gmail.com>
Date: Mon, 9 Nov 2026 10:18:07 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Jelle van der Waa <jelle@vdwaa.nl>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Harald Nordgren <haraldnordgren@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
References: <20261107193020.583215-1-jelle@vdwaa.nl>
 <CALnO6CBarutmydfmHDM=y5yfUCQY5SxKKcoCrd0NXCuNVkDuJQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CBarutmydfmHDM=y5yfUCQY5SxKKcoCrd0NXCuNVkDuJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/11/2026 19:49, D. Ben Knoble wrote:
> On Sat, Nov 7, 2026 at 2:36 PM Jelle van der Waa <jelle@vdwaa.nl> wrote:
>>
> 
> Anyway, my point is, there's a lot of possible meanings for "verbose",

That's a good point

> so maybe we could use "--commit-verbose" (blech), "--diff-in-editor",
> or some other thing that smarter folks than I will come up with which
> clearly signals what we're about?

Off the top of my head --show-diff, though I'm not sure that's any 
better than your suggestions

>> Other git history subcommands like split, squash and fixup could also
>> support --verbose under some circumstances (without --no-edit for fixup
>> or only with --reedit-message for fixup)

That, and supporting "commit.verbose" is a good idea

Thanks

Phillip

>> I would be happy to work start with landing support for --verbose for
>> git history reword, ideally with it also supporting the "commit.verbose"
>> configuration option. Further patches could then add support for other
>> subcommands where it makes sense.
>>
>> Jelle van der Waa (2):
>>    history: drop redundant strbuf_stripspace()
>>    history: add --verbose option for reword
>>
>>   Documentation/git-history.adoc | 11 +++-
>>   builtin/history.c              | 61 ++++++++++++++++++---
>>   t/t3451-history-reword.sh      | 97 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 160 insertions(+), 9 deletions(-)
>>
>> --
>> 2.56.0
> 
> Thanks for an interesting idea.
> 

