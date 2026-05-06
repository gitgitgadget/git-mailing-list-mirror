Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E434014BF
	for <git@vger.kernel.org>; Wed,  6 May 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076400; cv=none; b=MhmwSoyctBT1YxFB03iz0X+eIHC8awISODZ8crw/TwwQjDTLbSqE6Zj4R6Odho9IeBD+XKzEnRpJ9rlrZaHTeMt/axHfNXWxV7LlEkaD2bN0aBczII4nMuhu8yDEoVp/OuiOfYpnKUbhQtb354eGWavIgexUFiXHruMdEkaByG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076400; c=relaxed/simple;
	bh=SBoCYOqZj6Yh8TBmJT2tRYlQLwS2TiYH+TitR5doZKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=D6H9gBn48HshncuL9F3gbsTf0Rv9EnSnxVTYxsnJbSDqy9KlDW1EFNMfRLhdQqGvGGwrnlaPV8l7y1TGyvo0RxEomxm+lq067nsqJq11e3nyQYbh+Is7ZXMM9COuKxAdXk+htfJD8yvoyaaexcpdA2WT4GEihNhEsfj1pjUkyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsRmK4dg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsRmK4dg"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bc1f0830f44so178480466b.0
        for <git@vger.kernel.org>; Wed, 06 May 2026 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778076398; x=1778681198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BP8D4v1oTjTNC4GVDypnCJHf5WFNc7YpXN1irZry/II=;
        b=KsRmK4dgP5r/kM2Dv+M0162Pe6lfj54eGH/etK6Tjr7piY/Zf8WPTdtTvUij7YpAJZ
         gxiikq60sWl+/bhNK7TgJXaM5eCvTttDkh50UFYN8eitaHRop7l0DmKsQmD8bORZ+q4m
         uICFl/c8xbN6Fn099Iy76qgAV/EhwMq+VLlnapstLi45k/PL+FNSaCvBWbOfL+0S6Sd1
         Wa1/bUmjN/Az1jPZ7bPZpkM2Oh+HjFDgx2wEwBjakIxJNYK22Ik/D3boiWvGOFpFJR7C
         jpTRBwdBqNE8ZkIXH4tPpGYZDNxxzeDOTF9N+OEtskfcekf6CAD0GL7zYlZ886kqH5xg
         Vpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076398; x=1778681198;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP8D4v1oTjTNC4GVDypnCJHf5WFNc7YpXN1irZry/II=;
        b=VbxZStX3ArMtuFpEqLYtyreIfm3tVb4CHuwiW0ZvGGI9OF3GLxZSMrrPL5wx3hjDvK
         pTkjVrJ9XZFDDtl0RjTaTxKEejplcp2GY9ycIBoKUVkqHnWnuH8w8gvZaR02Rq7wYIea
         KrlYiwO2AAnimWxVLt8D7tuXtspLnl1Mu8Lo6LbFQooMKrY/WSESUSVGv/34vedEpYg9
         6Qti0ClVDTojWARfNTIYEax2XPs5m0CBMYNM997rHzlZpbdagmBJFCI/xcL7vbj/C9tS
         nSYhHhVNOsk23lhBTX0l5iBz9ULFYK9K7eLemIzFeKyDzmF8gAHZ0cYwnq7Y1mTW07rt
         yecg==
X-Forwarded-Encrypted: i=1; AFNElJ81yp/NXC+Y6KOrlhUhDt7YtY+7a42cfLy0DPeW+Id7/xhlmPqB2yklLDRgnREQ4kXHfiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgVEWhvo35+h431wFa2kXOEhZorNSnIIyAsXb3jucq7bAvcct3
	tsyu636ebJ4hMKS7eoCaMeH8L/kVZfr1dCJdA7AmyDV7N8yBTNYnjC8C
X-Gm-Gg: AeBDiev7p2w3xj/u5M6XoKFJevk1pSDrX/u8Gu8BnU9bWWzdEVarrkU7dA1LLOJO+2c
	dh6EOYsvNJ6hMgfyTbK09Ge+yi2Xsx5B62PnUyVsg6x3Np2Dd/eSZ/kaINdm3uG+pfM8hQiL5ep
	cP90FTQfKGzpQ6luLmXBRTzq1Xx9WHca5suPS4AzhWM1burhvBmvs61fhNC84QhU2gGt8PlqT0+
	L5YWT/lE1v8xeRPU0U5/6ujFuJE4rVj1CmiIS+P79yqS+xppdpHxVCOKXnJQCMnuZQbpBYZTfX0
	970irMY/8S8KQeirRagoU5q7aE2IgeRA0tjrRsw0zbl6VoJ1Ps3/t5O/n9c90jy25WVuA98HtCC
	j9gSSpphy6g2vYADuYXpq8tvBRcGrWMk+MOTW0PvXlH8Nn+Cs0IgJa+qVFQY4m5UAbiiOSd6QR8
	79ePXvyxvw+SOzBrdemLiRKEJM6YxPTCpomFl8cRqpYCvx/wnJI8FBmf95Xho4tG1xFliUJ8cXV
	NI4LJ50FAvkBAuvUjs=
X-Received: by 2002:a17:907:3fa9:b0:bc3:5f51:7a2 with SMTP id a640c23a62f3a-bc3cf73d9d7mr453386966b.3.1778076396722;
        Wed, 06 May 2026 07:06:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456? ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd91bb82asm1354841a12.21.2026.05.06.07.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 07:06:36 -0700 (PDT)
Message-ID: <40361c53-36f6-4769-a721-88de5fcf3910@gmail.com>
Date: Wed, 6 May 2026 15:06:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git maintenance fails without meaningful error message if any
 remote is no longer available
To: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>,
 git@vger.kernel.org
References: <0f3ef394-d96a-42f2-825d-53cb475a2363@anselmschueler.com>
 <5e3bcfdb-d3aa-4494-81d6-15b0dfd43af1@gmail.com>
 <0076773f-85c5-475b-96c7-bd85c9e5699a@anselmschueler.com>
Content-Language: en-US
Cc: Derrick Stolee <stolee@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <0076773f-85c5-475b-96c7-bd85c9e5699a@anselmschueler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Anselm

On 05/05/2026 11:05, Anselm Schüler wrote:
> [ This is a duplicate message because I forgot to hit Reply All the last 
> time ]
> 
> Hi Phillip,
> 
> I think there may be a misunderstanding. My current systemd timers do 
> use --keep-going. The issue is that on the individual repo, git- 
> maintenance won’t fetch other remotes if one remote fails. --keep-going 
> will ensure that the other repos get processed, but the repo with the 
> failing remote won’t fetch any remotes after the failing one.
> 
> At least, that’s what appears to be happening from the output of the 
> command.

Oh sorry I'd misunderstood what was happening. I think that error comes 
from "git fetch --all" which dying in connect.c:die_initial_contact(). 
If there is one remote that is causing problems you could set 
remote.<name>.skipFetchAll so that git maintenance does not try and 
fetch from it. I've Cc'd Stolee to see if he has any better ideas for 
fixing this.

Thanks

Phillip

> On 05/05/2026 11:59, Phillip Wood wrote:
>> Hi Anselm
>>
>> On 30/04/2026 00:13, Anselm Schüler wrote:
>>> I have a repo with multiple remotes, one of which no longer exists. 
>>> When git-maintenance runs on it, it fails during the prefetch stage 
>>> because that remote doesn’t exist anymore, and gives a mostly 
>>> unhelpful error message:
>>>
>>> $ git maintenance run --schedule=daily
>>> ERROR: Repository not found.
>>> fatal: Could not read from remote repository.
>>>
>>> Please make sure you have the correct access rights
>>> and the repository exists.
>>> error: failed to prefetch remotes
>>> error: task 'prefetch' failed
>>>
>>> I think that
>>> 1. git-maintenance should report which remote it’s encountering an 
>>> error on
>>> 2. git-maintenance should continue fetching other remotes even if one 
>>> fails
>>
>> Since c75662bfc9 (maintenance: running maintenance should not stop on 
>> errors, 2024-04-24) which is in git 2.45.3 the systemd timer files 
>> installed by "git maintenance start" use "git for-each-repo --keep- 
>> going --config=..." to avoid this problem. Unfortunately we don't have 
>> a way to automatically upgrade the timer files for users who ran "git 
>> maintenance start" before that. I think if you run
>>
>>     git maintenance stop
>>     git maintenance start
>>
>> It will delete the old timer files and install the new ones. If that 
>> does not work you'll need to manually edit the files and add "--keep- 
>> going" to "git for-each-repo".
>>
>> Thanks
>>
>> Phillip
>>
>>> Now, on my system, the systemd timers for git-maintenance use git- 
>>> for- each-repo. Not sure if that’s upstream behaviour or something 
>>> Nix/home- manager does. But if it is upstream behaviour, it would 
>>> also be great to report the repo the error comes from, since I 
>>> basically had to guess right now which repo was erroring. Luckily I 
>>> have only three repos under maintenance so that was fine.
>>>
>>> Let me know if you agree that this should be done. I would be open to 
>>> writing a patch (no promises though)
>>>
>>> Anselm
>>>
>>>
>>
> 

