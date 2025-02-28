Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6E28E7
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759558; cv=none; b=ON/JPJusJwYPuFsV4NXMpE6Pgnc0Ukya+6c0WRCf2TZnsbqFuKTP7qAL1UfQ+LlkYa1hVU0rm+jJPIuut3iIJd+0X+xM8fgAPeH3ZTHEPvE8qFcJ0wCHLdLH/w4EM8j6cZT95l0lt8ZZEcJR//OrUea8zWaJV9kei9tRQkNjIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759558; c=relaxed/simple;
	bh=BrHPH/Q5ly2P9jF4xlnMSUUi0+5Oab2Nx/si8eSQUaQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XkcQWPUvlroUbubZhjOFxZzucqg1CBzxbH9Z3M2HWKBgzR2CD1epFajVtqWngfVrWdzWOdKtfLDBHduuK+oF36vv1zRdGYRR46c5lLK2H85FVWziwcGgpfd/wvkLgKG5ptTTWBllw2fgcRJCRPRuK9lctKWmre8oLZpX27AeCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg5xJK4P; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg5xJK4P"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43b5859d1f1so14693065e9.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740759555; x=1741364355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7e3frfcRrUEB9ajlDwo2MFAyVZKotBFGwXdmvjlWZQ=;
        b=Cg5xJK4PsDJJDWluST+4A7TLGB+3lTg7Dxk4S+OCEbC+agW8/prqvy5crKQdL85lzO
         X6ci0y69xdZrooVnhWsO/ZTQCB7Pd6DfxnZ9qx407CkM36lx7EjfI+wYLbWfVivdyqP0
         0nJTl9vI+E+PpvAfLkM9jW2sQPZGGOktZcGhmOmltN7z4xlK1YmqtcHV674BQTUl0LtD
         z0JIe03DjzZFUgdtms4XB468P6Pg8VvbX7iYpnjLW331cRQLry6A9cALnsJAiT8za8dB
         SZnNf9kLMA0VLivLDqMwYEaUazft0zw8PQHmIycY2N3i7p96o2xb3exfHfpF6KvuXkGQ
         mFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759555; x=1741364355;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7e3frfcRrUEB9ajlDwo2MFAyVZKotBFGwXdmvjlWZQ=;
        b=Vi8DidZ7zL7R27/soV42MNqU4vrNHQ5FCrU1lTEr0VWw6h6jSAYrCwNiidn4J646P0
         +gu2hHdd17Ov9c5z3/J3AUg03B0lfun4XMxCSR+8j2CtOw78S39wog2fkGky1NG1IrCp
         JKiJwKSbknGMigR1afKHJ+ydtT+0iWvzpfxa7SQjbMnlYDRuzigZAedLiTN5TA6sNcbL
         QXujqGGoehFfgjqx9gx+PC1C4FIXpQ8OVpBxvtcv694fUTiqPFd6eP3Eh6M6aQSELCe4
         HcjMIhmi5ZrAs1dCR2rUW+DaqFIPUxCOJHpL2deHhcrolPlyv8DGCdWF3vZf2WOMkraL
         4qXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNd+CSkf148wEz3GuT9ihzCM/Fvj78NM2Y7JXN3slDyElCcckDwh4X3/45n05fVsMM/us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNspocIOvyaXewuiMXIdMMbgZPY8PaPtGljCUTIX2vDE601yce
	7rWp0g7+Oqy5e9tRUzeF7lHHwQzHMyfdMpZyxLqfkt0lq6mzGADb
X-Gm-Gg: ASbGncthjfLSivw4pZ1PqYCxK0fT0HQRpwDAL8wO+qVihdJMOjTavO3CAgqgtcILHPl
	IgypEUl7AT8o/G/WwnSHbIz944os8LclspKcoUntlwW2eVGBXo7mLJXSNLiLF29U29M6QBTxstb
	hIGpzeNZ+qBmTW+B8x6z1BnPevAJW/kxqFf9lkWHtmm2v8Q9xOAxxCLu1wXcccCm28BH9LSvPzf
	tZLNKFI99On0yCBRtr9uedyQVm3Y1XMDyXhqMS0ppykIKgrjOs3WyCOy3UV/8ZCU8XsgqzzWQ3k
	hE4yUiKmFa911AzaRoFQ2BlpFd2NOJHiDfLChIOP3zshpZCO1lUbjEHzeBCu4+s/a0qiuf/TCo2
	N3wRJ
X-Google-Smtp-Source: AGHT+IFQjdcR8TY7yXODxh8LEKSzolT6IMieqVNTrGtgKvqa95nhqlifl/ZF3abUDNec9nfRzwgGUw==
X-Received: by 2002:a05:600c:3b23:b0:439:98b0:f8ce with SMTP id 5b1f17b1804b1-43ba66e60f5mr35852685e9.7.1740759554979;
        Fri, 28 Feb 2025 08:19:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73718e2asm63133565e9.21.2025.02.28.08.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 08:19:13 -0800 (PST)
Message-ID: <d2c934cc-72be-4aae-8661-3331d3936219@gmail.com>
Date: Fri, 28 Feb 2025 16:19:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] add -p: mark split hunks as undecided
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
 <43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
 <xmqq34g79e8k.fsf@gitster.g> <618d4a61-7480-46b7-8563-221264290ed1@gmail.com>
 <xmqqikowejmb.fsf@gitster.g> <180271a6-eb0e-4c15-9916-b2ab5760f4ec@gmail.com>
 <xmqqjz9b6xr1.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjz9b6xr1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2025 18:36, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>>>> Currently after a selected hunk is split we always prompt the user to
>>>> make a decision on the first mini-hunk even though it is marked as
>>>> selected when it is split. This seems inconsistent and confused me
>>>> when I first tried splitting a selected hunk which is why I wrote this
>>>> patch.
>>> Hmph, so there is an obvious alternative "fix" to the inconsistency,
>>> i.e., after splitting, move to the first unselected hunk?
>>
>> We could do that but I think it would be even more confusing than the
>> current behavior as it would make it harder to change the state of the
>> mini-hunks. At least with the current behavior one can use 'J' to move
>> through them immediately after splitting the original hunk. If we move
>> to the next undecided hunk one has to know where the newly-created
>> mini-hunks are relative to that.
> 
> True.  After all, going back to an already selected hunk and then
> splitting the hunk is a clear indication that the user wants to
> visit some of them to change their state.  Moving them back to
> "undecided" (not "deselected") instead of leaving them marked as
> "selected" (which is the current behaviour) looks like a better
> behaviour and I wish I knew about the possibility in late 2006 when
> I added the hunk splitting.
> 
>> I'm not sure either. I dislike the way it works at the moment and find
>> it confusing but if there are a lot of people relying on it then I'd
>> be reluctant to change it.
> 
> I share the sentiment, especially the latter.
> 
>> Unfortunately we don't have any way to know
>> if anyone is relying on the current behavior without changing it and
>> seeing if anyone complains. Given it is a bit of a corner case I'm not
>> sure whether it is worth spending much more time on it.
> 
> Given our user base has grown quite a bit over the years, it almost
> is a given that any change to existing behaviour is a regression to
> somebody.  Certainly a safe material for Git 3.0 but I do not know
> if it is safe enough for 2.50 for example.  The strategy to leave it
> longer in 'next' did not work well to catch potential issues for
> another topic during this cycle, but we could try it out again.

I'll drop this patch for now. There was some talk a while ago about 
adding a mechanism to select "git 3.0" features at build or run time. If 
we add something like that I'll resubmit with this change guarded by 
that feature.

>> I can see the problem and asking for conformation before quitting
>> would have been nice if we'd done it from the start. I'm not sure it
>> is worth the disruption of changing it when one can re-run "reset/add
>> -p" quite easily though.
> 
> Yup.  That matches my assessment of it.  I brought it up because I
> see this "selection should not stick across splitting" falls into
> the same "it would have been nice if it were that way from the
> beginning" bucket.
> 
>> I guess we could add an opt-in cofing that
>> eventually becomes the default.
> 
> I'd prefer not to add configuration for tweaking such a small thing
> (this applies to "should selection stick across splitting?", too).

Perhaps we should make the confirm-before-quitting thing a "git 3.0" 
feature as well?

Best Wishes

Phillip

>> While we're talking about tangential issues it would be nice if when a
>> user revisited a hunk we told them its current state. At the moment
>> there is no way to tell if a hunk has been selected or not.
> 
> The user came back with 'J' or 'K' probably because the hunk was
> skipped in their earlier navigation with 'k' or 'j', so users may be
> using it as a workaround, but I agree there should be an indicator
> for the (unselected, selected, undecided).
> 
>> Related to that the help for 'J' and 'K' talk about leaving the
>> current hunk undecided when what they actually do is leave the
>> current state unchanged.
> 
> Nice catch.
> 
> Thanks.

