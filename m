Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA165914B
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928283; cv=none; b=NuCXTW7d9GdSAGU9NGf7eyJeDnjsgUZnc+44nWEepub18BNpKpy2XuPmvutqLr7DpgFNY4/9dnDdD6WxK17pd9AjufRpn8wXWQUEK4+SV81tNOK5PEami7yKByohzG1ETesG5D0ecExKmh8+A9Zm6/TUAoYqs4Mgb7C3zkVx6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928283; c=relaxed/simple;
	bh=Tj0r7ABwxq8XA9PI0F9CvdGW8dXA7Npg/sSCd4He/M0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Yl7KWnh+e32QsYX6HU8brvOTcjbKUeQGkyGm7EBrsrmad2Ra+oI0BKegXwBSfy5eUmNOFiPWNKYrkrCZ/8WhPndR/p/iCxp5ipkg36qE9KYxVOwxeTp1uMxtWX+K0gzfeR+di5nJlPNeoixkxDE/0sYSDIkXZEolRVXp5bdd0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc4NOXBT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc4NOXBT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-417f81ef284so4752915e9.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712928280; x=1713533080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILwjXphpxX8d+Jl5Ui9FOtdoo4SjnF/je4VGfsGCvPs=;
        b=Nc4NOXBTdhF0LMF4lZJG5kPZylb9FUJ29MQ8G5avfJcSOBHFwqjgeKORl1xgka/NBb
         tOZsFRN3OUqyver6h3BYyJGPckxlb3cD4QOY/mMhwTb3aFn+AzyalUD5UUJiiD2UorWt
         rxnhrljS8LuqxPaCm8z8Na0qMCCTcZbC2i0xLEUiG3pSxjXxixDLDdqLWfzwpnkdMgMc
         W2JFrmmhehvBr5swiXhEP3KO68lhEx9A0RShscqO4uyoN7cs+1r3b1r60JEHV98Qy1ss
         XpTX4iPoiDrqFbokpTKtvaPGlMkGa0W17EG1p3nVdVmIUl+A4kAcRy+KOyYY0iAkTu7M
         pXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712928280; x=1713533080;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILwjXphpxX8d+Jl5Ui9FOtdoo4SjnF/je4VGfsGCvPs=;
        b=dPRMoK9RGeyF3WYmN6nOzvfMiEedZyHey0YWc+6oAg/SXsYkU3OHlsI2T1tWcrE2+V
         mFPKADbNzWFZdRo/PAukrhr3GhhTtcKFjb3FUibbP9/aji6yxbmaJ6OmiaSu9GY+f4rE
         MgJ9E74j6JuHUFD/i+yBHpP8JN7ib97EpaBkJh+KheTAFTFdBVwEDmrZntJlsIGrM+65
         T9QhkRMqGozV1/7BtDKVYdNXJC4JgI1Za040pCF0NKB9coDP+P9Zm5l9SKSSnv8P0fGJ
         FE+sK72ixz0CJjo7GjAfBgRanhtyn7ak7lDppKEndIPGVaXYjv67Z7fjegDNpLYL5g3K
         JOsw==
X-Forwarded-Encrypted: i=1; AJvYcCWCL/iYhMuyjBbsNpSruOMwvLhbBt/elwc/qxPmEaT8rqH8YiJzDAY3a/AEK2g4RMBhsm4543pi6C9oWNeRO5E+qDY5
X-Gm-Message-State: AOJu0YxADP5PUro1QGw1r2HaGJJMDTWN/JEjjusE9+G5fI4pJ2qPfdM/
	BdE0q88cCN7N2yTEw7+giTM9Jehpd8odsszKdOnfE7LQK1qefavh2f4aNg==
X-Google-Smtp-Source: AGHT+IGwc6zpfa5lla8DbP3W4aPxJ8YBGDoil00eSjXNLdZqRri5+JUp63ZE05fTAz9RnsWo5nO8+A==
X-Received: by 2002:a05:600c:4e91:b0:418:5ac:39cf with SMTP id f17-20020a05600c4e9100b0041805ac39cfmr1276846wmq.35.1712928280275;
        Fri, 12 Apr 2024 06:24:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b00417ee784fcasm3333372wmo.45.2024.04.12.06.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:24:39 -0700 (PDT)
Message-ID: <88bc0787-e7ae-49e5-99e8-97f6c55ea8c6@gmail.com>
Date: Fri, 12 Apr 2024 14:24:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase -i: improve error message when picking
 merge
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
 <fbc6746e0188ed7b69c238935ec85b69112ddd79.1712585788.git.gitgitgadget@gmail.com>
 <xmqqle5n7ajt.fsf@gitster.g> <1b74f6f9-f4b9-4909-82b3-26f19b7a1347@gmail.com>
 <xmqqpluy1f9e.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpluy1f9e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 09/04/2024 20:56, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>> +		return error(_("'%s' does not accept merge commits, "
>>>> +			       "please use '%s' followed by '%s'"),
>>>> +			     todo_command_info[command].str,
>>>> +			     "merge -C", "break");
>>> OK.  And when hitting the "break", they know that they are supposed
>>> to say "git commit --amend" and then "git rebase --continue"?
>>
>> Yes. I guess we could add a hint to that effect if you think its worth it.
> 
> As I said elsewhere, I do not deal with non-linear stuff using
> sequencer, so I _may_ be missing something obvious to the target
> audience of this message.  But if I were dipping my toes to try
> mucking with sequencer and edit the todo myself by inserting a random
> merge commit there and got this message, I would have probably
> appreciated if the message were a bit more explicit _why_ I would
> want to use the 'break' there.  Otherwise, I probably would be lost
> sitting in front of the shell command prompt.  If it were
> 
> 	'pick' does not take a merge commit.  If you wanted to
> 	replay the merge, use 'merge -C' on the commit, and then
> 	'break' to give the control back to you so that you can
> 	do 'git commit --amend && git rebase --continue'.
> 
> that would have given me 70% of what I needed (the other 30% is why
> I would want to "--amend", instead of just taking the result of
> 'merge -C' as-is, though).
> 
> We can formulate the message in such a way that a succinct first
> part is sufficient for people who know the command, while the latter
> more verbose and prescriptive part can be hidden behind the advice
> mechanism.

I'll re-roll with a short error message plus some advice. I'll have a 
think about adding advice for the other commands as well explaining how 
the "merge" command should be used as well.

>> It feels funny to call error_merge_commit() for a command that we know
>> supports merges but I can see that would make it easier to extend in
>> the future.
> 
> Yes, I think that it is just a sign that the function is misnamed.
> "Gee we have a merge commit, please tell me what you want to do with
> it" is what the caller is asking, and the error messages are side
> effects the caller does not have to care too much about.

Sure

Thanks

Phillip
