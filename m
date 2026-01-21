Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF5328627
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768992238; cv=none; b=P8p2LQU5oPQNgjI3oiKM+KeJkCNzMRqhyeEJjMMDVlLiKwqUyZjFW13+nsOI/BkOqkJ137wM7jqAVpUpVha0+r8+QZBxNhWxPSveOZzcHgBColfvrvQolSF6Mxc0yd1t3rycE5p0MRSWRxEcUZqB26exXZ6+/MpiyaLoiT6nTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768992238; c=relaxed/simple;
	bh=mp2DVz9Dw62U64xYcBhQi5yHjBuE/FGzx9nMK6WpShg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsqV6EeO0rW2RBPIt5lns+2nVP2N9Cj5iBZc+65Z37nmEsy677Cc8QEl7uV4zWEb/V+w6MtVaRleuS/GvNBpZb2F5V74s0nGN+YYHn9IZLn/SvtmNRksbjp1ZpfKmBXeVgEIDC24n6V/PxePpivUy4p4NYGonVLDHRKRMp++B/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhULJ3Lp; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhULJ3Lp"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47edffe5540so55845095e9.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 02:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768992235; x=1769597035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1K+wFqJFKLAMAuYNNX4ASgtf3dgCEg1SUJ8dIFSIcyY=;
        b=GhULJ3LpwvuMmLJMw/ILZS2RnKiweabhdgnnjBVb6o38auQgjiaZ0uunU7N1B5Xz53
         XEEeyel0GAKuoUfxj37KafnYWY41wVGZ2k/0p269Mzaq2BdZUIFedCI3nD7RU5V0fLo1
         SSuwG/KjJtuhZi8ebBztrzvRW426xj288pDUD/tBVCW0vAvpyJX6Hq0IZWPgIyrxyAyP
         uNv1cYcXOOx14coKRZ0vRwSj/Dbb+we7mlNOoVwU+c+gfOXoq3lE77xEIU8kuR+XDbnY
         0q8bkCTxQLYu/1kOQji/dZPZJFgx4mGJuoGMfNfSzeACdjOaOmF7Z7YJXvylLlCFHLmd
         Dimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768992235; x=1769597035;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K+wFqJFKLAMAuYNNX4ASgtf3dgCEg1SUJ8dIFSIcyY=;
        b=MN2zZPsrLDTJQfZVoUt1vUQ7zsfSD32xgQNiSUV7cBryZ/H8lxe1rvcikbAIb3tlBK
         oWlsRE955GhMigpQUI68Z5eyrl2UuUlGdgGXxh7dMaYm4OH2zVJtzTj+taA7qDkQx5uz
         kBFl0DTzqpkh/NqieMY9Povg09qOvlp5o2ftqu82Q1HU938mtX2UDrZ4GiBUFLq6eaEB
         leysx4RRAZAu/66kIkh/UpJ7BRdXN19PAdgyBVrqmeMqulVh6HdxyzCbFH99KULMp0l6
         y4xeHkClAz24LZ97Z6ZszCLslIOkcbLzdt5LWHQMozNjc+hO9FIlMvNIF63SWPC852B0
         QVrA==
X-Forwarded-Encrypted: i=1; AJvYcCVbmJjMeqZx/C7lWEbZP5pPFHvKzzgCQePpf+gnrzyyOBDKZhMIjtLUpsOTHDOzM2QQiK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+B5HhlaZMfXz8wFfp6qSRhD+A4xe2lsX7o7Gii00faam8Vouc
	JNjiMn3CiYEjZpf+/JpZZ6crYtJVW2GMf0kqHT4HC8jlO8tyWsKcpfvT
X-Gm-Gg: AZuq6aIn+QKGP0HSzY8DM4Hg66lGosNCTu780L1u7F+tQkxbPMiTDuQf6FDpf+7Sdph
	RBk9dN9UFNM1LOgHo6MJsvTbLee+TREp7yAnvNCZGn79m8q2aeCFYXImLV2w4DiZBtXY662Z0OO
	GZzU6eeHEx3KQnfpzi4VWmQOh2VRqz29b4dpwzoD8s8KpSDi8TUSUiNk5HeMsCWY2FeNoqKwS1I
	ktZAPIGoj5BNobflYQWa2M7nezzYxFVGmQL5o/BR5szYHkSYp6cbzRLhcXzKNhKzkiYNrl/Vcha
	uzT3KrNpuoXJS1yQtbxYYYWGwJrexR3TlYr6Bi0P6zyJvJgWr48/5LLb8AuPvI7NqzkA3Frh7o4
	h3SEWU4WI4OAUcoiuEzigC9Pb51jI8YwsR0fgEWGyPWVwug+7dyeHjgdfcfzVeapHLVEYZNeHIf
	AHUyRPi90XOGKLJm6w7t+QegoSz1KMrDG9qjmSkvx7d11Oz4uvFEYaDHoiZiVTtQNNlQ==
X-Received: by 2002:a05:600c:c174:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-48041635211mr47668915e9.33.1768992234733;
        Wed, 21 Jan 2026 02:43:54 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e879537sm304836025e9.5.2026.01.21.02.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 02:43:54 -0800 (PST)
Message-ID: <e259aa7f-9290-4305-af92-88be6ab08a1b@gmail.com>
Date: Wed, 21 Jan 2026 10:43:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] mailmap: add an entry for Phillip Wood
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Git Mailing List <git@vger.kernel.org>
References: <f10c3f680d58ca0abbf795ae8b0f2ad14ab85419.1768906910.git.phillip.wood@dunelm.org.uk>
 <5a4e7da4-d295-4beb-9f37-b2ce4e10df35@app.fastmail.com>
 <xmqqtswgywb4.fsf@gitster.g>
 <20260120192424.GA3295894@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260120192424.GA3295894@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/01/2026 19:24, Jeff King wrote:
> On Tue, Jan 20, 2026 at 10:26:55AM -0800, Junio C Hamano wrote:
> 
> We do apply them in some places, like shortlog:
> 
>    $ cat >>.mailmap <<\EOF
>    Junio C Hamano <no-such-user@google.com> <gitster@pobox.com>
>    EOF
>    $ git shortlog -1 -ne --group=trailer:signed-off-by 3f051fc9
>    Junio C Hamano <no-such-user@google.com> (1):
>          doc: patch-id: --verbatim locks in --stable
>    
>    Kristoffer Haugsbakk <code@khaugsbakk.name> (1):
>          doc: patch-id: --verbatim locks in --stable
> 
> As you noted, we don't necessarily know that a given trailer represents
> an ident. But we try to parse them as one (not just for mailmap, but for
> stuff like "-e"), and if that doesn't work leave it as an opaque string.
> That all comes from 56d5dde752 (shortlog: parse trailer idents,
> 2020-09-27).

Ah so the mailmap entries I'm adding do have some limited use, but they 
don't work for git log.

> I _thought_ we added support for %(trailers) to handle mailmap, too,
> but...
> 
>> Or perhaps your "Yeah" is about "we've talkined about doing it"?
> 
> ...yeah, I think this is the case. There's a proof of concept at:
> 
>    https://lore.kernel.org/git/YW8A5FznqLYs7MqH@coredump.intra.peff.net/

Thanks for the link, I thought we'd discussed it at one of the 
contributor summits but I couldn't remember if anything had come of it.

Phillip

> but nobody ever took it further (I do still run with it as part of my
> daily build, which probably enhanced my confusion ;) ).
> 
> -Peff
> 

