Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704981;
	b=UHZHYlksPVu1bvtoNPFiJapoYhlckcO/PrElsLjghcTDAjGSuDU6YEDmrahg7tkWvvUG
	 7NH9ia6Woi0jdgd1eiJI6ypwqaH61lN2jqvT5SYImso5iUcx7EQWLgUuuZo8igKltwKej
	 UNR6Z6FR+z9iY4wUIkYsgFInaM0C4l3U4YgenIAvuM1M0Ts69NlLRqKTcU/FTMAiSUDvB
	 OUx7FVHu4043bXgl980buf6OIAgeDc5w3DimVYGujT22m02H7wR1t/MbXWhgVUmc9fIOd
	 +eL5uICvWRUcN4MwZVMka6a8ZgIHKIQ5jdYu0c7coJ0l2+4uOZToOzde41zOjDtbBeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=75g3ovO60TikCRj1ehytwBO5hfzZouByeMkS1XiZkPU=;
	b=BIT1agTycW+Y/hLvqxdNhuhsq9/gov0jtlbn10lKHuJOL+lunRSJD2GeWfLA4bUHVw9L
	 NkFfzTs9c1LX+kk0U2OpnDOPButqT5jZSi/HgyuijMfS7hdCV6TXgLh1+V578cv72gUK4
	 78c5rjq0kEQd91VDpOPLwr3sUZlOSXrk1jmGxZbdZzJWSfM21KOm7BpvX1iXVx/PVBQKM
	 H0m9JN7+BfTYFKIRhvOhftPjBr1Wr4Ud06YqEfXBuYWy+OXEFxmSODdUSnOnIRMcRA11Z
	 L6VLI5nufXJQ79vyJgdyZanlQl5RbIufxwbmdSOZB3JS7qD441NAd7p7NFvbbx0ElcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xi4CZuyu;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036F606A326
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2036F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xi4CZuyu
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so59599465e9.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795704979; x=1796309779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=75g3ovO60TikCRj1ehytwBO5hfzZouByeMkS1XiZkPU=;
        b=xi4CZuyu/JagzHjQotVhrDVCJ8KPwIJycqwo9vGFyv2FF2wnYwOUNhR0n3+5MqEWiC
         METcgluuxyqs8GLJNPslkf8spjh9gc8OaL6YGu0OtmfA7YQXWh3XyoOnVXW04z7/Du2a
         1RFQNkqvQZ0cje5IIL8yAIA7prrtovGsDGaACtWvqArk6wPXo3Y8beyOKMK+zvxdaH3Q
         2O59W7ne9OiGjSI1hisEyx4bOMqavm5xsBgo5L+BXC41JmvTtHuEt7vMKPgVPgK06PbT
         f/1dBMli8icetuckvlRB9Lo2gbMeY3m/SAro4u1vM+uFZdcsb8ArA2iaqUDKPy1PvAtw
         WP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704979; x=1796309779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=75g3ovO60TikCRj1ehytwBO5hfzZouByeMkS1XiZkPU=;
        b=ghuYc/qLKr2ERK8N+rqWhqyloCadXJ5aWMnpx8fKNigp8jaA2uZXbJUrHeJBVEtyyv
         LxqPKXNXockGjXP4jMfuP1pPrMwLRk8FxW4DW6729rteW7B6sEsn1KWjoehKHD/xbDSw
         n9vSjGMkj5GkI8rzIZjzfGdY+UDnKwp+oyquB2vrGjBbmQAX5JbMfB0qIl+tveaNdP2+
         k1LOH0Jnoa/T1gXwMHpZixzuKQ8JNHTEV8HcsVflqBd07zwl90YRC3755b+tGr9/t3Sj
         BvqccYscB25LNLGF4j4EKBu/yD2mBe4YMgp9kFEJqCxXKicIkRkBG+6mumElJuEaH7Bc
         Bnqw==
X-Gm-Message-State: APuU4Z+fsB/BOc5gHEE8Z2P6IAXxDWupQKIOnhe1eBPp2deM7NOHiHSf
	0iRHHD9zK7yHg9XTAYTcr+9R22B3BSM6E6h5fk/2dJynuvUVcdrC80GxVLv2DQ==
X-Gm-Gg: AZFdTZfAmO/nmCGWjPtOeNa25rh3MBxeI8BA6Xpa2stSJQRXvmpeIvg1PfmUtSEP01K
	urxVnrdiFRTd1YchObvVHm/K0WR5quFVI0T2htDfh1MicagcbmT9DuvAsTogF39F+U5fltZf/lb
	SA1KI5OTdM3qo1zQ26GPfI7CmHSNzh2UQgqQ5O1zKsKRAGGCZZ/7OzeJXVxL0FYjhfJ92+lIbBw
	gogr4brioah9j/y8GJS0wFNDh253IH7XhKZw0qteYjK57u03LtUvCZv9/emHKALiEO2edZaVmZf
	AqiETKfQyqAwBWtpABPObh7bqc3Xa8tv97icek1meKMPo1J84dClCKCh7YECpROr+2oJH/27uk5
	4uTzZ7ZavlAyhYDWQTkruapjFvJP4ZPCn1ekpZByokzKhobZIcDBXgZE9Ov/rYXs/c+CnLKgMfI
	qfr+1YjXECpzA57BvngU1duaZzy4ke+nIqw2pEduTGCIMfjgUMBpePTjWy1EcZDfzJeLLEXFQ41
	2iWm1fMqI+S8tKVa6wcq/zZPQHhnRrgZMSJep4qRIJSh4f5nM9Vf1JLaXu6YPjpElWvRoTBBAyt
	rieeX2s/iGoAshigWdM5ax+zn2Ue9gsKtR41W6xtlRDHsAWyUyrWqgmqpY16dtukRJGiHUVVu64
	IVDR+EB4=
X-Received: by 2002:a05:600d:18:b0:4bb:abe2:bbce with SMTP id 5b1f17b1804b1-4bbabe2bcc5mr33491945e9.29.1795704979312;
        Thu, 26 Nov 2026 06:56:19 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm589785075e9.6.2026.11.26.06.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 06:56:18 -0800 (PST)
Message-ID: <607d6273-14ba-4005-b038-3778ad2812fe@gmail.com>
Date: Thu, 26 Nov 2026 14:56:14 +0000
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
Subject: Re: [PATCH] config: make the suggested "set" command safe to paste
To: Ben Knoble <ben.knoble@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
 nahidhasan141400@gmail.com
References: <pull.2457.git.git.1795632875345.gitgitgadget@gmail.com>
 <02A50A47-A048-417E-9D1E-0C12D8FB1476@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <02A50A47-A048-417E-9D1E-0C12D8FB1476@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/11/2026 12:30, Ben Knoble wrote:
>> Le 25 nov. 2026 à 13:54, Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com> a écrit :
>>
>> ﻿From: Harald Nordgren <haraldnordgren@gmail.com>
>>
>> Quote the value when it needs it, and put the command on a line of
>> its own the way other hints show commands, so it can be copied
>> without the surrounding quotes:
>>
>>     hint: did you mean:
>>     hint:
>>     hint:   git config set status.comparebranches '@{upstream} @{push}'
> 
> I wanted to bring both folks together to figure out: should we shell quote
> assuming a POSIX-like shell, and do the current patches
> work or not on Windows?
>
> In other words, would we need to do something different to
> behave sensibly in other shells (fish?), or is that not a target worth
> worrying about (GfW comes with a Bash environment)?

Ideally sq_quote_buf_pretty() would take the current shell into account 
so that it generated different output for powershell, cmd.exe, etc. 
Currently the output is suitable for POSIX shells and csh (though this 
particular patch does some post-processing that removes support for 
csh). As a fish user I agree it would be nice to support that as well. 
Fish recognizes \\ and \' as escapes within single quotes, so we could 
support it in addition to POSIX shells and csh by always backslash 
escaping backslashes as we already do for single quotes and exclamation 
marks. A prettier option would be to only backslash escape backslashes 
that are followed by a backslash or single quote.

> One other thing: it might be nice to centralize some kind of
> automatic quoting for suggested commands.

sq_quote_buf_pretty() is intended for that use case, so we already have 
a central location for that logic. The output could be prettier though, 
in particular in would be nice to avoid the redundant pairs of single 
quotes at the beginning and end of ''\''hello there'\''' so that it 
produced \''hello there'\' instead. "'hello there'" would be even 
prettier but would take more work.

Thanks

Phillip

