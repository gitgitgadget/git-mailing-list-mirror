Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809675;
	b=QJzxTOUqG6thqWNk5UfL1hFz/F6B7XAbJxy5rgnFLM/ZGzNrqggath+unnFQIAzC11m7
	 CA2+sqIC7TgiwCFDIXSrI50CaLuDCAHmZGg/gsw+XNpTSEopgE6ePKqzhQA69S/yYiUG0
	 hJHUyjtv/Yw6zZZN6WpqCNgnBwgCStsa3PWK5PeQ9QQoAF4OuoOiiarQYL2xMXYLpGDBZ
	 DMx91W8x6x33gZAg4rNytXjo0wv5QdyAwSCRonhsAMg0D8KI76dFFhjgvRoDqRTHWn8h8
	 1ov2WKFKRtwmZAtklbGHajZjyGdJoMSOrydG8QZlB4AvTlR9Hc+H3cF0XUrS21xd+vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PbXWM3jNLo1ZqwtJvPB5VpZ2GiYBvg5NG55UXdGyz9E=;
	b=AfAUi8S1L6eQofECMFDtJ4gyfoMmiAGEFEIuVHRvSkb3up6S+P+4iEuwO2DSg598mqMm
	 iwW1heSNVfgNmAH0zo3zlafu9Fbyg3DzDTThZEr+xRXvKykmOQ+f4zdF96ZCyZxazlpEU
	 xrXGWPqCOQUMjtGjccUIaepamdEnBRwN65Yv9uBEZzmMgAGkft0ldWrgGU7AyJdE5MQQ3
	 45JMS0UFI8AW5BphVUVqwASDwj0WgwD3Jd8PyyWcEu9igK4LcRwA0WoBsH76xDTCLQxe8
	 HZqYjT6xeo9Bade/u7trHAAMS1PqyQZ3IAB+e9nkA7NH6xosbJ0vA2AW8hHGhH4zgVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vXZYG0Ur;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E3606A32D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 16:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6E3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vXZYG0Ur
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso8449966d6.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 08:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793809674; x=1794414474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PbXWM3jNLo1ZqwtJvPB5VpZ2GiYBvg5NG55UXdGyz9E=;
        b=vXZYG0UrTo8wNQ6ZYtvCUf0W2Fl94jgDYHHEJhPIUYiZrFchuV3os0/zYJTueACLh2
         v9ScVY9n8ibRLyJbJ+agIJqLb2oLRMz93ZJrpLTvTl5P8NgLgSUqKCsmr3ypy1dHO8Tg
         ljisNIsdayinVNlcYSlhZrOyWqc9NNQsrwJV7dm37CgRoonV5zU++OJb1eDDE9UP4Sdy
         +Gh47q6DQcEmfypXtMHwFiFjb74ht/ytvRwVqLeibMrdK05oOg/3EHnF+ecZZCetuS5A
         fD09KUHmVmKHYiRl2+ByK5wCMkx6Amp1V1Oz7ce4G9SDUIzQzBqkGSuJICvtag44Ybwd
         kDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809674; x=1794414474;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PbXWM3jNLo1ZqwtJvPB5VpZ2GiYBvg5NG55UXdGyz9E=;
        b=tAAdmqqa00BcFM1Pq3qKAr4DrPNRXsBF1vz2AeAZ9H8m6iE4axOaEXdUJo505bEziV
         DSeKmh+r6cXMGaZpha6TU1ytHXJFk2mHfx1LAGzkPSYU+rJYPGvpciwScxI9/TXAWrNT
         Dqt482e08BVtjetX6a8f1y/9QtR7PvrC+tC7J+xC7nSprI4k8Qtp79hndnsjUStXo6CY
         wi5bCfx5r5iROwBgmkTsmFQkqFCx8fkuFxovup6NMDGbrDkbCIq2pDhsL+1pESf8MkSc
         pet9TqC7Xra2PSOnBWxzmyQbofYWpIwZOO/w3S+LTZcthfSrZpSk7jxJM19S8vjktEye
         ucxA==
X-Gm-Message-State: APuU4Z9rg7Gd7X0hOf5FuRQmEG3PIpQbcBsSaAPgO/D1yBnBmGp+nuAR
	Y6BRVjwu+7BWI2Me7NGgnfRaKf+PPTp0gbnSaHgsGlmxnBu1h9wmLY/Qwwt++A==
X-Gm-Gg: AYBFou3OM4qeyg6YpWTi0IolyZynEG0BT3A/6rzTNf0fRcLMFoUdnyDVJq11WdZeaoE
	Vg9jaAh12WcZvthwN6WoMPL5A2aEY9KW62+0kyimkd5eJKD4LOzEMN7aJUH8DGaQpvXKv0yGYWo
	eyZCJnaDuyFTl1ElKxYyxXRGQtAMTIpkpdlwtj/bvW+EcvT7NkSe0o1ufOmalXHD3IxIY5zv9VC
	vAyOQywVjmJXNAi0RmmLbyfiA6W2lSIl2DiMXLaTf2T3bMewcO2DZmIyVBMNDUiJBdg6Ao+O2O/
	5DtIo9bU6tBPZ+lUAM+q0EFCjt/4ds/x/q207pYO0YiROQf2jQKjdXzF1uOM/occd/xcYwJ2ZAa
	6LDjUa3zVNVtq59irlozhpyMcenYmwtEaOvsAcAdNrjzvXJCdtVDsRFHc3zAz7lXdQqmmeczn5n
	1smfsXLFguXSOwY3aNFcLdxtXThAtK1KZT6KI7IKeHdZj+bfaDfEx7/UTqk4VAyxEA3VmrbEL1I
	RcCGB2SBGycrX3f21BK2t8dP56jGtzmS1tfvdDAbvW072Bo6oi7MExg6azUF89vOIQMINfY3hos
	2Dr2d/kPLDuW+zSyeM+TxskaTb7u6rsCKK8TXMnbRtOEANGpbEsImyNUYkMlcwuJYUdICrMPbxK
	z99AJiuLVZBCEfCiLGPUzh7CUpX17I9ZXOcgYylIU3iPfIDchrQPgt45aeFc9Q5RjVIOdLPt+4t
	W1q3hJMtwqv8xHDy++Jqm1OEjqa2fKcTif1qKebp772RS8V0aqi+jg
X-Received: by 2002:a05:6214:311d:b0:91e:7e89:c8fc with SMTP id 6a1803df08f44-91e7e89ca54mr46237286d6.47.1793809673512;
        Wed, 04 Nov 2026 08:27:53 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e896f09e3sm12488206d6.25.2026.11.04.08.27.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:27:52 -0800 (PST)
Message-ID: <55e14977-dfc2-4acc-bc71-a91915fa251f@gmail.com>
Date: Wed, 4 Nov 2026 11:27:52 -0500
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
Subject: Re: [PATCH 0/2] odb/source-loose: fix failing existence checks caused
 by stale cache
To: git@vger.kernel.org
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
 <CAL71e4ONN4OQUZ2S==0TRWqZgA8ogT0smRL3Rk46voTm+0Tihw@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4ONN4OQUZ2S==0TRWqZgA8ogT0smRL3Rk46voTm+0Tihw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 7:57 AM, Kristofer Karlsson wrote:
> On Wed, 4 Nov 2026 at 13:17, Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Hi,
>>
>> this small patch series fixes the bug reported in [1].
>>
>> In summary, when git-merge(1) writes merged blobs it may be unable to
>> read them back because the loose object cache does not get updated.
>> Consequently, we may think that the blobs do not exist locally, and thus
>> in a promisor remote we may perform a backfill fetch. But as the remote
>> doesn't know those objects we'll fail.
>>
>> Thanks!
>>
>> Patrick
> 
> The fix looks good to me, and I verified that the test fails
> without it. My own local fix is logically equivalent,
> which is a good sign, though perhaps that biased my review.
I also think the fix looks good. (I haven't verified it locally
like Kristofer did, but the test is good.)

Thanks,
-Stolee

