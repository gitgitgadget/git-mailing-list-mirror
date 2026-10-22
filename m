Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694013;
	b=RP5WZxpGdIS6FE92W4Lw4v0ZkNwzdlplaals+ED2hyLcwX+H1Nju6q9VEOWAuBRu9oRF
	 6B4R6MljzdazBFqZwuXd1BUo/tRp4J0+yhAOOGt+izSNLx656pGsCpmNEUQnjUpdvvGIO
	 vV9PtYW63ZJROwaEIXB2wPMyWW0JK8BzPYRM05RYXFHmPvTS9p1d3plwa+Ttv2Wghrb4M
	 I35PJW4Dxs/5UVC2tB3G1HCcXeOU5cblx4Y9yFkXo0zSnuTnJvoTcDAu6AO9zOPL57fR4
	 je3uYEIAywRXU+/LPf7qA0Yawjsi5DEy6WMyaBYkLi6kny9hRNVtXZnFnctcmRbL4Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=obj+xdmp0YJw6D/bxnNCIi/rdJbTBgcm6XHdNEPJ6Vg=;
	b=5O0Jm54DzXKlKpiamU4u81sP1+qkqYOIzPSyndT0VToiFy8V3rnWvCZnaZSPlGYDgBlS
	 lMmscbdR6XG67T2LhaMRldvmCB8YDkI5BseWWwFa9BK5LevHuDu3C1dGrCPTpzGHJcLTc
	 UwwJd+XzVTYBazVMmrxzk1IpIhmAad7V1IIl4nr4cL8L8GK9cP+KA2kBfhyczl5F83Ycm
	 Bjg3llLLNQh/KULvAElxhLV/VvkPZuiy4fJM0047o/YWYKJiHix7QB9l+2T0YqOeXBREf
	 fWtR986IxfhS5mwSpD6kXktaxFlrcy3HueLdgf0/JF+hmcyN39sAo0QH889NBg7e/qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f6F1dtbG;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFD60A3816
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 18:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4DFD60A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f6F1dtbG
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so581225e9.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792694011; x=1793298811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=obj+xdmp0YJw6D/bxnNCIi/rdJbTBgcm6XHdNEPJ6Vg=;
        b=f6F1dtbGagSZxqFckC8q8FfL2BOHQ/Xt2oFKOnPSpuiEetMoHGkjrd1e8TYhHQ+JPn
         HHb3yMVp/AG4YygtexekkeLDoluQplbi6ZRTtTs+RNzG3Ngv+ys4og8wal/M0tgo7Lvl
         sgO37ginms3yd5LQRqhBykLVp4Q0trykp+fye8En6nX5yh8lsJKIfncWSuxee0WTomwE
         WipVfaNShl4vc7djByllReKE2BqWKARkR5DuAr9RtKTJWz61tbkLRbi12eZuk0ktKYHt
         HznUPLHepdXbZrdXNSlRV2jeh00VL/umBpXJl4r7oe2W/vTYmBz6wQiKoY3I+GrUZDJ0
         xZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694011; x=1793298811;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=obj+xdmp0YJw6D/bxnNCIi/rdJbTBgcm6XHdNEPJ6Vg=;
        b=sr411cQkgK5JI5VxL61EmO+W1P/PPihPYS1MT1hJtjMF1RNcKSYITPtGCfFaSOgsEh
         osXCZ/9ooDtROLbmsagEysIy/IHeE/Z0spcwJlzf3glJUUSmHteEsh2UwURd8RryAioG
         NBOXQDiTJhQ1uHuczMTt9oaEEbqrQV3/h2yRQEHUA3KPMl1pZgjNmYyU4UVn1grJVhiS
         4lhuGFytnvQL0RAfyc+RaMJ13W+Mkxtdde0eFdylE+waGNhLHOTU9dZU6QLa6S8/oPnC
         V4ULKyL1uSMyZcmna27mfvxbvSjXNUI+GCzWKbZueVEItBuUjSTqQdkx5iL4biuG2+g9
         u9vw==
X-Gm-Message-State: AFq9FYJewsRHhP3DEua45n9P3pUXUp3KULPfA5wwHZ5UN26KdHwuE5B6
	oSLUN/mOjxmjsisAcY32JI7nwMeOqYa+eY8c4lTP+hVOX/vn2RNrpuIqkAkqfQ==
X-Gm-Gg: AYBFou2ZVlR30K+Kpn1spzczpvG4qDoMumSl3CSnPV/Gfe210c/mRaMPxvvAkrZqJ/V
	fB4xmOn+cor/J5wvhkgyRAKKL1Zcl9MhFBTrMxDPpPUoo2T9H0KwxghtxkkBXD1u53ZbAesqhrt
	XLjKW2sPLjYsGLJB2OkyTSOZY73Ba8d5F/s6U9KXYDi0fj2O+1kVcAM1/ZKN0XjEcDcYEakYGPK
	vYDQxZRmGEdr9/ihiolinnh3K/gveyQL5lD+jrOtUSzec6XWZF80wx2iRutuhHh3cyFc6GYWiLw
	ZPBTvCQPf0R3XrphyTbcxRiaryKvoT8tfnWeMtZDZVtNAMkEErARNJ0Db18Xt6pl5TtiwLEWgJm
	9sgm0bliCtNqi+G8JwEmmqXJDsnSjBdHpSfsaceuybCmYQ1S1Buj4hBUrozfMwdKx87CGXpRTmO
	FiGvx8hHPOAZDkHl9ScTgVr5v1EAKlPJyg0X1HyvuDwGZBp5TJWDIxxyERR0ZShke9nwxmSgVQT
	A+PDpdkJyLNgrS6yKgttZpnuPUZ6Dyfaj+o+w9zASrNqYR41ukCt+d5LwyLbw0xiyJS5DsCPqVJ
	/aEa/P2F/MdTkwRM+ptYgXOopMIWgbe/Xg==
X-Received: by 2002:a05:600c:e54a:20b0:4a1:e57b:667e with SMTP id 5b1f17b1804b1-4a204a8f4famr43384275e9.4.1792694011023;
        Thu, 22 Oct 2026 11:33:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21034d740sm16689625e9.4.2026.10.22.11.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 11:33:29 -0700 (PDT)
Message-ID: <f01f4d8b-bbdd-4629-a123-40ae560f22a3@gmail.com>
Date: Thu, 22 Oct 2026 19:33:25 +0100
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
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/7] stash: use an enum for create status
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
 <cover.1792509606.git.phillip.wood@dunelm.org.uk>
 <9e27bcd676ee763ed499fb337b1497f3fe2405b2.1792509606.git.phillip.wood@dunelm.org.uk>
 <xmqq5wyvsi2j.fsf@gitster.g> <7ffce2cb-07de-4bd3-a9b4-81fd27b920f5@gmail.com>
 <xmqqpkx1hdph.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpkx1hdph.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/10/2026 18:01, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 21/10/2026 07:07, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>>    		ret = stash_patch(info, ps, patch, quiet, interactive_opts);
>>>> -		if (ret < 0) {
>>>> +		if (ret == CREATE_ERROR) {
>>>>    			if (!quiet)
>>>>    				fprintf_ln(stderr, _("Cannot save the current "
>>>>    						     "worktree state"));
>>>>    			goto done;
>>>> -		} else if (ret > 0) {
>>>> +		} else if (ret != CREATE_SUCCESS) {
>>>>    			goto done;
>>>>    		}
>>>
>>> I wonder if switch/case is easier to read for these users of these
>>> enum return values.  Some check explicitly against CREATE_ERROR
>>> (like the one above), some treat anything other than CREATE_SUCCESS
>>> as undesirable, etc.
>>
>> I've had a play with this and I think the enum is better here
> 
> Puzzled.  I wasn't contrasting enum vs switch.  I was contrasting
> if/else if cascade against switch, assuming that both use enum.

Sorry s/enum/switch/ i.e I think the switch is better here (but not for 
all of them - see my previous mail)

Thanks

Phillip

