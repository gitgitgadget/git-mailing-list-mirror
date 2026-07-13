Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A240DFBD
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957201; cv=none; b=Vpb5UrSbOg6VmBd2yYYqtbWkaUcXUB6QEwDsABtjaTuoQW8EjZ5AaKj0mpsgQV+LUO7FXKYbGhLa82/V4igOv+xlRtfF3A6tGXFVcXH12qDnKo8ZuZqJLt136eIvZHJwXG542HeLghcztE0bZxBJTU47XCM1gTcMd503tNqrvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957201; c=relaxed/simple;
	bh=GucFvmL9/PvZbzb9m20rLVD+NC752fPV1LHwC5glXys=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sZfAA84ZhfYI5Gj/TehGUKJDSKtAUbLE6dybwkVPgdyU+3BADeI2dz0KHD+AZzE/sfiH/4nMDyXB7ktv60Kv1++VVVncQ4u6fnCgt+0Fkamca7z9WE6X9D7lzlsXbW+x4xDPHmRXQ79zeXa3FjsWpQm4i6pC3F5QxM/3BIEYC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkrqJSOh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkrqJSOh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b77b150aso484695e9.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957198; x=1784561998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9V4WGz+krMrhHB7ECN1C9GjOU78qR1vzTBKqYbhOitE=;
        b=jkrqJSOhW09nP44ZrlxUQAvGJVcVqqw27vZ+b9W/ncMenDZMPJ0DBx6VYoRplnGgLU
         37/vdrW/VSlemmPyukVHY0AWorHvQ5rarW6H0uGquLUgmkYZxAfJCOhtPGCusjPGKEDd
         z2dAu7l6hU0wem6jBWBdhiUPyC9P/nO8cWi8g7xGRIcVEY2Mc8/jGSjF+45upkHnYMwe
         /o1BbwxzUbKcZGBHSGPtVJe+iPpv/yTZh16PVwJayO9f1tStWib7Aoa3bLy0WVy5TQp4
         AWTsEILvDvhIsKDJf4fU89lGQsAWooGg3fk6VrzV9mOuEbHHISVm1RzfphAvGheuuLFn
         X+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957198; x=1784561998;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9V4WGz+krMrhHB7ECN1C9GjOU78qR1vzTBKqYbhOitE=;
        b=f8y+4kXGonzJcJQQuR12qGz9cAzQ/yvBFBxNBUrzwImDllqAcSL4dQ4NtM2LxOLN5/
         3sHkSOkNi9GZbLHp7I93cgKDuHGIrpVoyvbCFDSkN3zbqK9TJfT2aMh6IkJMTWIlyyuB
         Qut539juT8SsJZwYr7jghCxW2oYheChhfQMp9njfPTLgzhJk7/7kAalocCqSZkGhkJtx
         xydFSKRsoKX8JWoRLgYhtwQlVFmT+ZCGOJuPoaZKZ1+H7tOZ1BvKPdrSnyWwO3s0VNqZ
         HWYR172dcmKCGsBeDHukfXlzDKPwDqIBiTeaYte3OsXqkpLs8zUXUQmHoVQrc+5vFqQt
         Pc4A==
X-Forwarded-Encrypted: i=1; AHgh+RoC1inioJATSKQhJ9DAzgujDZRtNkx93W9gnsqSR4GnMroXTbG6TMLTEI3ygCTShADZoDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynPB2/cTAMwOslJkw55OnmKCg9JuewZBzdg7w+oUxfT12GIDXP
	30Ce053Ev/TkFBjpTnxNo763EEt8zP8LTkgkIt3blo634pjDEiseXbLW
X-Gm-Gg: AfdE7clHoDpy5muGCJ1/TTbO+JIi+w23wcgxUP/E1pd0zI9B4G9B8jS0jMO7qG7OVJY
	jcwo1S3cfKzmRHE96k3zJ38weCGGOrPRNC05Hz+ct+KqNm3D5jmqvfCJOD4Kl+whFH0g1FUepq4
	QGfVsx5RziW4hQFgaxLCjLKn441Nl9vkZ4jT7zRC2fxhv2d0ZosaO7mQxnXDVVxBEgvC1P/ofi/
	bP3Kfh9xZs8Qaed1/nAE86vBOgnqusmasfSnmOEt0orVvv/H/GhcsCtmJga7nCQJfltHhoAfl57
	So9cvX/LMMG7rzLUMX4uKFkyj8Mm9jFx9XoI1yYfQ8jKKvbBPXZe0Bxy5K2j8pWVITBT8z3y/97
	lvePBIFQrpDtJJnJRq9JCn6JEv4WIIPHF/Oqv6rDYuvowwKlBAa8ycpp7Nlj7LJWlhGzEoGPqOr
	V1RrNnE9qLDcmo/8ExnoYQ06yaKjSPgaZOEeQ9vAF8ymhBT79Yi3bCMvUqwHZXxF48scI=
X-Received: by 2002:a05:600c:c172:b0:490:b7e6:bd1d with SMTP id 5b1f17b1804b1-493f87ecb62mr115735095e9.16.1783957198174;
        Mon, 13 Jul 2026 08:39:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32b9f3sm4133015e9.13.2026.07.13.08.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 08:39:57 -0700 (PDT)
Message-ID: <5212d968-6121-466c-8225-36b4bad6b211@gmail.com>
Date: Mon, 13 Jul 2026 16:39:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v18 5/7] branch: add --delete-merged <branch>
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
 <e35f1268-2518-4a44-9c7c-28ba13ca7b7b@gmail.com>
 <CAHwyqnU0ifHu0+GfMR9GqWKgFrTOyQn-FbUH0wTm_07nCa26tA@mail.gmail.com>
 <CAHwyqnWspUTSnqmkMyXtWuAnENDSzrRLhhUR=Ljtt1xer3tphA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnWspUTSnqmkMyXtWuAnENDSzrRLhhUR=Ljtt1xer3tphA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2026 20:36, Harald Nordgren wrote:
>>>> +     (
>>>> +             cd repo &&
>>>> +             git checkout -b mainline main &&
>>>> +             git checkout -b on-local mainline &&
>>>> +             git branch --set-upstream-to=mainline on-local &&
>>>
>>> Why do we need on-local to track mainline rather than main? I'm a bit
>>> confused what the point of mainline is.
>>
>> It's to have an indirection of a branch that is the same as main but
>> will be protected. I tried to delete it now and replace it with just
>> main, but then main was deleted and subsequent tests failed.
> 
> Digging more into this, probably the most elegant solution is to
> replace mainline with main, but then also do this:
> 
>      git config branch.main.pushRemote origin
> 
> This exposes something that I don't love about this feature,

by "this feature" do you mean "git branch --delete-merged"?

> which is
> that when using a pushDefault (like we do in the tests with 'git
> config remote.pushDefault fork') if not adding a special case for the
> main/master branch (like 'git config branch.main.pushRemote origin'),
> then it will get cleaned up as a forked branch.

Oh, so because the default push remote is not "origin" we need to 
override that for the branches that we do push to "origin". That's a 
pain, but even if we did add a special case for the default branch, it 
would not protect other branches like "next" and "seen".

We should maybe add a note to the documentation about that to warn users.
> But there was a lot of discussion about this already, so I won't get
> into this again.

Fair enough

Thanks

Phillip

