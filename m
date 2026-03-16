Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CF43321BD
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678975; cv=none; b=Qdeu+EnC7/gEr7fa0rYqTS4mvaly8UpAF6i/OXvF5JpW/Wfg4aJkHJgX3g6Ud+U+kH8wLHag617Z+Gm5QlOI7axN1p/eQyvXXhqXm3XKv14VIwlf4IpGadnVN9ZTRTcSAs775rXc15OGCWZ1bTa7nbeH04R4Cwgh9DPblX19qRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678975; c=relaxed/simple;
	bh=43JSgJLy8cEVqOR7itVchLRflR99WGifjmnyt1CLQMY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AxnkeUHU+Dm2xZdMHzLx7w2ZkltENQCxYFig5EPEI0eAmnlOZ8umDjVI+266lYpaJLsT4oKXXEmSkXd2EjTfnEeIH/RIZANKSP1YiN4JS86ctuH/jz2+R2J96KL9M03PBX0O0V7xy7iUiJJlW4W5wjRlLVly803bAXbCfCCmAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5G5kh7q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5G5kh7q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso29495455e9.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773678972; x=1774283772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHYF2awcu/e4PeHR4dPxQc5sdPMDeAYs2sL0I3PxBIw=;
        b=d5G5kh7qQUJOoBs6QC0H5vRPG6luwiTuiXEyTOM9wjFKojX1qTUqbPSKoC915Rd11T
         8lXcczsF6+8OR6ZyWmM64epFoeMbmAsZqAWW6H0b2P1WK84FwqwXzwWCQC885CwvX+I4
         0dCDhkLC4eVFL/ENCs7R8TY3q7FDqTODRLRNeNDzjTqLLbIuJStuDMzWr0nqJTAfMI+u
         MmhSPDE5WBs7OWKPIvO0ptV23274tTzx1hJWeKipS0UjtWGnJfUqpirLyri83Af03vHk
         Ws+UMkyBavN4LSKd//VPRTvCQRt4O2dWnEMejHl8Tm9APdhecrE9LYeEEG+udbZkpBRH
         7mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678972; x=1774283772;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHYF2awcu/e4PeHR4dPxQc5sdPMDeAYs2sL0I3PxBIw=;
        b=RByfnqVkDPri2X+/yInyuRDsyLcHiU2ah9Gsu+6B7d91gQLKLVFjS4WAQhKgzdq132
         XB8Zyh9CoVuGgXHl4AIRtblTtAGqaWk0S42voxZ66cl+kUdYI9Y8oOh5AcJ2JejJbb65
         mdZqAAgAdrqGVS/E2BUIbgMa/b/Zy47xZwVfUK4nkkp+es+PmRm9u2kRV0OOtGYgRaH3
         5ueskvcCgRxwfe4ScSgBECPgTm7aCzOkhRif1UxgP2rema6HFw64yce/0ZUtjALAQDUX
         srinAceMJj11TBc0C4mWqU48/C1xqqwm7obFsMKC19reK+KVzatmxcUgYr2umYumNjPF
         oTRw==
X-Forwarded-Encrypted: i=1; AJvYcCXSLSPCZB295UiQLveHUbSvxd4t78ddHp6bi6PEObGV/5OueAs3fZn+yXjlRb/35+Zkwm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpTQmJKt/X0kWH5kwPSwpVEgswu7sLTSQxc9ZdXNNp8hu8/D8
	66EIWdlx5uCn2C7DuUeP9uOfHZCqD3QRfc24P9spZyL2FM1rrLd0Ssao
X-Gm-Gg: ATEYQzygAGst2EKvFC8ZVZVfKWBA6NpiNG/Xr59lmpS3y8m0SWWX9Y4jc8p5HSjVwwL
	q/hZpURuUr4n5KjOqYMuule5RENpTDXsbdTR53/usE+1IqESFBklF2BWlUDjInEYVeli8Iq2EKe
	EeZSpnLF5QPHSPQKTt4F+mRdmi5nKD8+fhcEEMpaYIx9j4wff5o9f3mdRO0wJzsZbQKfBq+bAmK
	fT7r9l9ffDx44salGV4NnWyv+tr9WkhkGOzmS8K/Ek21fnIzn6LeytN1Bk5eCaJnm3q5u5A/mIb
	iR6c98S8EkWxUgQBZumoIqSHinPJQYkO5RVOvabz8BOkXzP/ks+KDoBUB53HnCUTRflUsfr7mrH
	m8K828DQiS+qGtHakJlps0Qp6CLoLVF8L2iFh/YEXhqUCSKHEQ2WfYG2iMnV5wRdOa4jd2L05mC
	Ka2exP7f7tDdexX3kVedqKulSMrzCxT0lIiQYjMSmAZdeISyTykyZJTZ8VE6V86ORoG5Buuvcdw
	r7fNw==
X-Received: by 2002:a05:600c:4514:b0:483:78c5:d743 with SMTP id 5b1f17b1804b1-48556709e2cmr217835525e9.28.1773678972340;
        Mon, 16 Mar 2026 09:36:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6ece3sm96219045e9.29.2026.03.16.09.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 09:36:11 -0700 (PDT)
Message-ID: <564a8207-6a96-4f42-b0bc-807edafff330@gmail.com>
Date: Mon, 16 Mar 2026 16:36:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com>
 <xmqqeclpi00y.fsf@gitster.g> <953b5842-a4ae-40f6-8cae-c4f81239c903@gmail.com>
 <xmqqms0awcs8.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqms0awcs8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2026 17:17, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 12/03/2026 14:40, Junio C Hamano wrote:
>>>
>>> Perhaps doing it this way would make it more worth doing?
>>>
>>>    - At the beginning of branch switching, ask a new helper function
>>>      that takes the branch we are switching to as an argument this
>>>      question:
>>>
>>>      Do any paths that are different between the current branch and
>>>      the branch we are switching to have local (i.e., either in the
>>>      index or in the working tree) change [Yes/No]?
>>>
>>>    - When the answer is "yes", save the local changes to a new stash
>>>      entry, and clear the local changes from the index and from the
>>>      working tree.  If not, do not bother with stash at all.
>>
>> Can we avoid the extra check and stash if the user passed "--autostash"
>> and unpack_trees() fails because it would overwrite local changes in
>> merge_working_tree()?
> 
> Sorry, but I couldn't quite figure out what you are saying here.
> 
> My guess on one part of what it says is that an explicit
> "--autostash", we should stash without second guessing the user
> (i.e., avoid chedk and stash).  But then the latter part of the
> sentence "and unpack_trees() fails ..." do not quite parse.
> 
> If the user gave "--autostash" and we check with unpack_trees()
> dry-run and find out that a normal branch switch will be interfered
> by the local changes, then we would stash, but that check made by a
> dry-run unpack_trees() is not an "extra" check, so, that does not
> work as a guess of what you are saying, either.

Why is the dry-run of unpack_trees() not an extra check? I was assuming 
that it was because we do the dry-run and then do it for real after 
possibly stashing any local changes. That's why I was wondering if we 
could avoid the dry-run by creating the stash if the non-dry-run 
unpack_trees() failed. Looking at the unpack_trees() implementation it 
can fail for a variety of reasons, only some (one?) of which can be 
addressed by stashing local changes but there does not seem to be a way 
for the caller to determine what caused it to fail.

>>> If we can sell it as an improved implementation of "-m", we probably
>>> can lose some code that the current "-m" implementation uses to do
>>> its merge; we'd be instead using the "unstash" code paths.
>>
>> That would be nice but I think "git checkout --recurse-submodules -m
>> <branch>" currently updates submodules whereas "git stash" does not know
>> how to recurse submodules.
> 
> Hmph, I do not do submodules outside what we already have, and I
> certainly do not do "checkout --recurse-submodules" with or without
> "-m" with local changes in our submodule.
> 
> But does "git stash" even need to know about recursing into
> submodules for this?  When checkout recurses into a submodule, that
> checkout that is working in the repository of the submodule can
> handle "-m" itself, which may stash the local changes made in the
> submodule, no?

Oh, because this all happens in a single command then yes, I think we 
can. When I wrote that I'd been thinking about a recent question about 
rebase not recursing submodules on discord and what it would take to 
make "git rebase --recurse-submodules --autostash" work. There we need 
to be able to retrive the stash in a different process to the one that 
created it so we need some way of tracking the stashed changes in each 
submodule.

It turns out I'd misremembered what "git checkout -m 
--recurse-submodules" does at the moment - after testing it, it seems to 
simply nuke an uncommitted submodule changes rather than merging them.

Thanks

Phillip

>> It would be nice to teach "git stash" to recurse submodules but I don't
>> think it is completly straight forward as we'd need to store the object
>> id of the submodule's stash commit in the parent stash.
> 
> No, let's not add more commands that take "--recurse-submodules", if
> we do not have to.
> 
> Thanks.
> 

