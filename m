Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74593AA1B8
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743081; cv=none; b=gtEDvp7W/fjFPIxfzRwJBqNLPHf1InnBA7nGEQAOTYP1xBTpGx8xtWlw11a4+BA+jmRX8NVnypxZq98bhYhbVL07at4z/POCgff2REHKEz9QtpvzLrYo06HjPTuJMCFeS30axmGRxEik+gYjT2XXGr8cxjsDcOe2xbIgBTswzr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743081; c=relaxed/simple;
	bh=ehM8GpAcbskDY0cEY6s2wimBBmvfGCz+okuXKsQX6Rw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o8ab3+VZrUis8K8/wTtFQrYfQYsSJeLim/5QTHK9Qpvz1XLy39cNx8dmldGpOtclJT+pH4qLUnIfCUb1aCbgBNt3vjIbKgVyg+krsoJRGVn5rcCiFrdew6Vgtl4YKnxjzOlbN3MJLXas43HRRzYq/8StpVKZTgb1TL+LR96kdu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GctzyPFk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GctzyPFk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso1441843f8f.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773743078; x=1774347878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1iAfh180UQdc2QJQTQkyPxz3oy9gYWjUaTkFYbCyOqg=;
        b=GctzyPFkSAi1HDKriu3238AKVyNrKwtPAq72NDTMqcG6A2OlO049QFnEJYfxWC+lBt
         mdoq6XCXTE2dnioZaWDZlvy5BgH5flx8vWcVCVkj/9zl0nd7RPMBVmTqohiVopC7Ef+J
         LxX9E3Qk1W751ir+5ma4VHxdmVQPPKo+HiPwVrBvPG2L5QDLh8bRH61j00d3InPLQSko
         6vHBLrq2iwDyvg+3bA652c4K0i6A3Eslc29hM8kKuF5bQVwcUKagzn+tzSBpkcKIi3hZ
         AUIEC+VOw+y7tJ5JePJFZ0HE+UpZL/phJNfU+XxInS7roPxTHFpNCHKQewZ26gWBhRFB
         iINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773743078; x=1774347878;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iAfh180UQdc2QJQTQkyPxz3oy9gYWjUaTkFYbCyOqg=;
        b=OE7oo+4pmvdchgZqDwoHpm6kWGKppICGhNH1fO2JJ8ajRyF+/fPXhJ+pHAuwRDcA1S
         anipKzwN3Eqmi/C0XychtUZkfJCrwGnXD/r5D8qZhtecP4iSmw7Sa/0gpJpETHfaVDat
         l1N2nikF2um2oaVW5A/tHYX61H1RGpDEOw/GwkMrOB6fOkr1M8Glo/AKa0Q5afLBaG+i
         YflJZZAP43A0FNXaB7vSmoFpJEugZRyfDNdgkAiQc02D/FG0HmHvQ3Xzxw/xtl92in/l
         bSuOsFO86EsISKgGxSgQJJ1qfOo8isfdbJCRuDn/LA3OTAWGxZLZPq6vaIt4R7XYuxYX
         ll9w==
X-Gm-Message-State: AOJu0YxaLYaAK4MoVrRGFjlPLpuUsuDd3TfBKLhfs+5mLmny7dG4kfcn
	5JHqyiKTtWEue12xQU3agI6WVtk0EOLkjZcoD9UO3xY1zEIX/htQPGrw
X-Gm-Gg: ATEYQzzwml+eo+Nlo+ltf5uE89Pckso/xuQC7JRsFqEv2PLCklLL0426hiRzeL2YUuc
	Nn4M71cEUELeI1/a/7twiCedm5oI6ebLcMafjTrufgGSsnYSBS0nZM7lYKjpwAbK2NUdzrh0kBi
	0/++FZmbVTyv3roPQgUq5LyFqfzIosmctCT+n+ZSxFxLR+hXOFOI0glip4J+dJFUko0ICn0Q/NZ
	jsE/5mzR+4h3u3yr9jv7xi+zySE2YKuuZhXid5oW/VaTV7nI4+dNTAtS5A5d+G2dvl/TnZ+HkyI
	V1F2+0Mvs74NJsF/OsUfo4/hPZxwOoHtg/Pya2MDflPvNrAoVAF9N3HMWwdVkPHvCgaU3sKHQAu
	WC701bZSXcoCNNhQI6qfTd6OvcrFctV3/xZZwj/08BUHicuSFaR2sDwZ9Ffto2VjoGGbXlT60c9
	J5W22eMIvcaiOuWiKk/ofa61zADCPqMyHuZTdLmBHlvJ+JWyGy5ztfnBMUDDFFoj9SibbYMEquF
	hQdQdb/t9H6tqCA
X-Received: by 2002:a05:6000:26d0:b0:439:b6f1:cd8d with SMTP id ffacd0b85a97d-43a04da7c89mr29944289f8f.28.1773743078186;
        Tue, 17 Mar 2026 03:24:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm39424217f8f.36.2026.03.17.03.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 03:24:37 -0700 (PDT)
Message-ID: <9c915043-02da-4823-b4e7-d2a340c0373d@gmail.com>
Date: Tue, 17 Mar 2026 10:24:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/3] worktree: remove "the_repository" from
 is_current_worktree()
From: Phillip Wood <phillip.wood123@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
 <cover.1773591528.git.phillip.wood@dunelm.org.uk>
 <075700a22568913988c9fa8e1ff49db1a1a5b606.1773591528.git.phillip.wood@dunelm.org.uk>
 <abezeNELL9SU8v82@pks.im> <9e3b59d1-58f3-476c-9c7a-3ceffbb71810@gmail.com>
Content-Language: en-US
In-Reply-To: <9e3b59d1-58f3-476c-9c7a-3ceffbb71810@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2026 16:22, Phillip Wood wrote:
> 
>> I have been staring at this code for longer than I want to admit, and I
>> still haven't convinced myself that this is not a change in behaviour.
>> I think what I'm wondering about is what `is_current_worktree()` is
>> actually intended to do. In other words, what _do_ we consider to be
>> "current"?
> 
> There was some discussion about that in [1] where reviewers were 
> surprised that we needed to call is_current_worktree() here. This change 
> is consistent with the rest of the patch but you're right that it is a 
> change in behavior as at the moment the "current" worktree is set by the 
> worktree that the process was started in. In practice we only ever have 
> a single struct repository instance per process so there is no practical 
> change in behavior here. At the moment, if you visit a set of submodules 
> from the superproject by forking one process per submodule each 
> submodule worktree is considered "current", but if you visit them by 
> spinning up some threads in the current process they are not considered 
> "current". That seems to me to be inconsistent as the process started by 
> the user is in the superproject in both cases.

To add another example get_worktree_ref_store() checks `wt->is_current` 
to see if it should use the ref store in `wt->repo` or create a new 
store. That means that if we use `the_repository` to define the current 
worktree we'll end up opening a copy of the ref store in `wt->repo` when 
`repo != the_repository` and `wt->path` matches `wt->repo->worktree` 
when we could be using the ref store that's already open. It is a bit 
like the bug fixed by 1339cb3c47a (worktree: don't store main worktree 
twice, 2024-06-06) but for multiple repositories.

I'll re-roll with a bit more description in the commit message but I'm 
going to be off the list for most of the rest of this week so it will 
probably be next week before I post a new version.

Thanks

Phillip

> The "is_current" field was added in [1] without any discussion in the 
> commit message. It seems to have been added to stop the same branch 
> being checked out in multiple worktrees [2].
> 
> Thanks
> 
> Phillip
> 
> [1] 750e8a60d69 (worktree.c: mark current worktree, 2016-04-22)
> [2] https://lore.kernel.org/git/ 
> CAJZYdzhG8h3s=Ep1fuGbam1cWhYkv0tW6tQ7pBGGj+fj6=Nrsw@mail.gmail.com/
> 
> 
>> I would consider the worktree "current" that the Git process
>> has been invoked in. So if I pass a repo other than `the_repository`, or
>> if I pass a worktree that is not the one that Git has been started in,
>> then I would expect the function to return `false`. With that naive
>> assumption your change would be breaking the existing logic.
>>
>> But I have no idea whether my assumption is correct or not, as
>> there is not really any documentation of what the function or of the
>> `struct worktree::is_current` field. And having a look at a couple of
>> callers doesn't really make me all the wiser.
>>
>> It would be great if you could shine some light on this and then also
>> add a bit of documentation to either the function, the field, or both :)
>>
>> Thanks!
>>
>> Patrick
>>
> 

