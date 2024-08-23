Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898E13B7AE
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399981; cv=none; b=bvBJvOdI6Oi4WgahjpFknXrOhBjPzISVswh4h+RSubvnBR8WNCZGfbCzBeL4444yQZ5M7daSQ0hXXGXpJVOWNqOYLS76Y+N8u8aRv3iLTnCDxLeD6aRvY7Z22DXdsDLRNYXluiKHipnrCiMvg0zhUVw5Fc5hzlHZbgc7fgKqb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399981; c=relaxed/simple;
	bh=vn35JuO5vUlfgMai4KoYthc9sIFO0sZvB1yiChUU538=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uN58I49AAV1Sxz2ZZ2DXJevvtUooKW0HN8dLMt8RIyRKL07YPssV2y3TVhnu33fM64RIUOkHWZVACgqnY6rVUSIreNEWGeHEp+FeXbjrNquySDkOHgff/zsS43CqQ/0Y2Oo/0jDeqy43Ldi3ZmtYAfXmQJBB4GdvSkCP8j7Yx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enUGbF02; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enUGbF02"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-201fbd0d7c2so15768785ad.0
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 00:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724399980; x=1725004780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfUU75Sjv2eYL6hYDVpLu86tgYk2SzFQrmuVXiJ2oOs=;
        b=enUGbF02WbjwyDY3I0umzPFncsbqAVHFdnUIESxP/AWWgeSCfHsnbEYRaNNIQQH2rn
         ybl/S3R04jAW31I/r/+SdzapiuOAWvBEGr7Gy/LLZVo7UOBc0mrYcbrFG+fn7GNhBiuP
         74j4OrcjjAL2t5wGlHUPLWooyVIVfOp1l8atG0KK31HLwbeY2UT5Cr4w0vNMBG/xSv3d
         iuJeX6MEsLysbHrD9+Naw6rJK8mw2bGsTRd5CiLRjKAD/mv+tFsI0dSYhpb0RKrpPtBz
         7EgLuAKnaRC11G1MUnvyxh0ytKgKFCPc7a0G33niNdpQaVIP/k3AS3b/1LSzvu635yOy
         hD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724399980; x=1725004780;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfUU75Sjv2eYL6hYDVpLu86tgYk2SzFQrmuVXiJ2oOs=;
        b=B9yU3JrXi/XebPvifFSAKco61wzM1REnju1KHsBxuqUblSXxPyGLH9OsOzL6BGf6tS
         kAGDwGZ8S2hGEcUXL8evVU7Ppa/V9mEAes3x26jjKRU6ISScFF+tBSg8BOUgP6hJivtn
         A3XpvSyV/xWGl2FyV01dLFYLF7t93gJ7Rst2syxbDVZ6XnX04pKKMrijhXDiS/4LLHli
         dpysjJRMk0og5N27IpU2xtBZ90ad77J7huFcW0JNZFIWnb5aOHVS8ZlW7CTrrVWCtUKk
         Yn826CDtsrh8L3zEtT2HFp3Ofy7FMGJ3DUl3e9u4epGSCHouGBeIjFmBkQpvyiml3ers
         mmdQ==
X-Gm-Message-State: AOJu0YxeQX2exQh3tZyK4gM3sYjilqSA4CMKoBafMI6BTmbSot9Ah41e
	2WJ3w8WjdbkWiUUymHlvdl7AylNzvY3HCuZXGAnZ2Ht0RGNKK5Xb
X-Google-Smtp-Source: AGHT+IGQC37h4yKuLtzPsR1/geZlmDQ9QNIRHhDCnI6ZNMDlCf9jOaR9mtuLHrvD3RxY3TYuEDDG9A==
X-Received: by 2002:a17:902:e88b:b0:202:54b8:72e5 with SMTP id d9443c01a7336-2039e4def47mr15583925ad.22.1724399979590;
        Fri, 23 Aug 2024 00:59:39 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385be090bsm23199985ad.268.2024.08.23.00.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 00:59:39 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <35777445-b86a-42c8-93e0-99ac225c11ab@gmail.com>
Date: Fri, 23 Aug 2024 15:59:36 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
Content-Language: en-GB-large
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
 <Zsgh4LacdOt8N69o@tanuki>
In-Reply-To: <Zsgh4LacdOt8N69o@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2024-08-23 13:45, Patrick Steinhardt wrote:
> On Fri, Aug 23, 2024 at 01:20:41AM +0800, Celeste Liu wrote:
>> Commit 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
>> introduced this typo.
> 
> We typically do not word the commit message as a continuation of the
> subject. The subject often becomes invisible in many contexts, so it is
> helpful if it can be read standalone while providing all of the context
> necessary. So mentioning what is wrong would be welcome here.
> 
>> Fixes: 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
> 
> We do not use Fixes tags in the Git project.
> 
>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>> ---
>>  Documentation/git-config.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index 65c645d461..79360328aa 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -130,7 +130,7 @@ OPTIONS
>>  --all::
>>  	With `get`, return all values for a multi-valued key.
>>  
>> ----regexp::
>> +--regexp::
>>  	With `get`, interpret the name as a regular expression. Regular
>>  	expression matching is currently case-sensitive and done against a
>>  	canonicalized version of the key in which section and variable names
> 
> This looks obviously correct to me.
> 
> There's one more thing I noticed: the synopsis for `git config get` says
> `--regrexp=<regexp>`, which is clearly wrong. As you're already at it,
> would you mind including a second patch that corrects this?

Ok. I will include this in v2 later.

> 
> Thanks!
> 
> Patrick

