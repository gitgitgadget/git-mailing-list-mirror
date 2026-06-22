Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209D3624BC
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122230; cv=none; b=JMA+Z6sQeETyM0lIhWcimWOy4IQmi4ruUEOs7PPtXbbVtXn9XrY/ldWot6Mex6DC0hNzBs9dFMFZfEKtEA2Lv7UJgdU/1dz9I9g5jaQnbgsJIuJ4pCFkLF6MPUBXmd1qhGFV7il2FPM6z32z2Ipqe6Wusyt8+2NIADeF3vQceC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122230; c=relaxed/simple;
	bh=3tdPr7hHvbBbHLKuQouM7aHV7OfrdWRLF1dNrgEmsSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwSaxUUDDsYjLDTeODtWucTbXo6fhHrgnv49ZW7i945260mHTg/QWPBMPbIKcwXNmmTz2seM9JLsW89Da7a0HOrIRCnYyuejxEcpxixWhOXeacPiMYxgAheaabq8e0Jl/Zz4RjQ3IHWG80xr1W3I055enIdfYuOepUr+ixxxZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCM6rN7M; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCM6rN7M"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6978f1eeb87so2061247a12.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782122228; x=1782727028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNsJeEvMFlSQQ59fg+9OCrUZilyKFex3YLPPU7NcOMw=;
        b=XCM6rN7M+bDAX7Gnk9u3NWx9TCiPBWThQa8O3CRU3AJMkLSq0lB3pG+xuvaR/m8SkR
         pejNuA7ezv/pcvBtGtbSctxAhoy0wCgLFpwCbUpOOUSncItpjECQcKx//7n7vnSlplmg
         LLLMZUnH4fA8qBdXl7ayggbdA177+XKwE+ydBdAdSlfDyfT+6p9s4U5DpHlwiZpSaU9f
         4L4Ha3va4FT8nZxeYwLAFmiZkz2LoIgWxuQps1sYgNXIwDtnOwKZgDjAYnWMD00cly8t
         oXm2WvJH4OHjUJ9ZEV0A68bpPiKDbc6lHgAKpA2MPDO0GYcjME/+KCBWoWsTQM8CRYjq
         /5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122228; x=1782727028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNsJeEvMFlSQQ59fg+9OCrUZilyKFex3YLPPU7NcOMw=;
        b=rQAeUTyh2vGUeSTUIjGCG3fAF+njQPl0JBhqUa5Gpy78aeiwkULYJiUaYmGFF0a11x
         kzxrfUtcMFkgYxnBsxQOkBSfYSoGSwPhrtzVT4diR+rEyZg+J9+rFFiV8pDEYG66b39C
         Zf61xOnKdS5Im9Ord9/n7Cyu8LVgtKhLmJIaK+9luB2NFkEZlBHxuWIYRzGwqPEdOXbZ
         AJVON+h4L4Sd6dOpLnIZTpJSctbRKcB+qwnlFy57L7DShkGmTlqp5fXVQGBYx2TU40Kc
         Bwv3fj2OaHb/AS6XgdM/0ikesKJjiKwhExjdcED5MHh/vZwkrBK2QRaCduesbqo9DPVv
         SmGw==
X-Forwarded-Encrypted: i=1; AFNElJ8Vp4EWrfryjdLY4hhGDrt3/+wnOfwdDvj0+NZq7ECdIzYPfplt1HTTpw16UlhvPZ3SLGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjAf5lpbpLZEDA/1ywSDsMEaUe3TRBBhGiL9XXy+kqDxVmavIR
	Ay/kxAGx1tOUHjUL9yRhYx0ha00g54bL0FhcegojzStEVVaOMKmslbrP
X-Gm-Gg: AfdE7ckLaHIxOvYocqxftZIlIh2hbv8wvQOvxmLNQXY1m4TuAEzObx52pA3ohhMmJzi
	u163Qlt0hbTBA/GaPqwkSRrlKXjZK7fQ1jvYZBbD3l0IhkZ+evDdcqElVzMpDyIXo4Hf57KkadJ
	eEhcOVM8nsZB0eR0GvZ123oyKCvW9VpLFr3pQnsBL/efpl2ib01z8vB7Hw5f5AtllrEnh/a8aJ3
	uy0qAgqyzOAudpr3aSKkIU3bXeeP1uUZ1SyiRKSJssOIpCwC9+xBA/zlZYgOlYou2anQrHShzhY
	WwomwrbceJPNiyy1lBabRmW/Q5Mbkd5kLOyiHpe87bxIOM0YDboz2jalyX2AOAxOfxFG0Z9tXrt
	IX0ZXF807qR8qU5oQ2UahU5u7rM7xTSJ28WSLdircy+wdjDI8T0KQjUV528b/p6YNWrwT2Ndi8k
	y1iqV6JrVPoAE23B/ZSWiuyaQdbaJtmIrXZrLkscnlCZV/1VJRONJkz3eG85qAB1wz+SGMRg==
X-Received: by 2002:a05:6402:3488:b0:697:be0e:4b72 with SMTP id 4fb4d7f45d1cf-697be0e5347mr931943a12.1.1782122228042;
        Mon, 22 Jun 2026 02:57:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:33f4:2760:38a0:c4f? ([2a0a:ef40:69a:b801:33f4:2760:38a0:c4f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be64ddasm2787411a12.28.2026.06.22.02.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 02:57:07 -0700 (PDT)
Message-ID: <ddf37b2d-29b4-4a3c-b7d9-b681af028b24@gmail.com>
Date: Mon, 22 Jun 2026 10:57:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
 <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
 <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> <xmqqh5mymt8i.fsf@gitster.g>
 <xmqq33yimsdp.fsf@gitster.g>
 <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
 <CAHwyqnVce7NKft9AEyCUnR=S_y1ygiXjhf-qmJqmi-tuUXcw=g@mail.gmail.com>
 <31172867-5577-4c1e-b8b6-425ef9fe44e1@gmail.com>
 <a3bd3514-dab4-49b6-a210-bc7b8ddd701d@gmail.com>
 <CAHwyqnVQwK1w9ap1-e=ii4a-BVOZ=oQtCdkTxB=TJF30kNaZoQ@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnVQwK1w9ap1-e=ii4a-BVOZ=oQtCdkTxB=TJF30kNaZoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/06/2026 10:37, Harald Nordgren wrote:
> Hi! I implemented this in v17.

That seems to preserve all the upstreams, rather than preserving the 
upstreams of unmerged branches and clearing the upstream setting of 
merged branches. It also builds a list of upstream branches rather than 
just pruning the set of to-be-deleted branches in the 
refs_for_each_branch_ref() callback which seems a bit wasteful.

Thanks

Phillip

> 
> Harald
> 
> On Mon, Jun 22, 2026 at 11:28 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 22/06/2026 10:09, Phillip Wood wrote:
>>> Hi Harald
>>>
>>> On 21/06/2026 19:46, Harald Nordgren wrote:
>>>> Looking into this more and attempting to implement the logic for
>>>> re-assigning the upstream, it becomes quite a lot of code.
>>
>> Having re-read you previous message I'm coming round to the idea of
>> clearing the upstream of branches that have been merged but cannot be
>> deleted because they are the upstream of an unmerged branch. Is that
>> easier than reassigning the upstream?
>>
>> Thanks
>>
>> Phillip
>>
>>>> Maybe an easier way forward now is to avoid deleting these cases. We
>>>> can always add the re-assigning logic later on without breaking
>>>> backward compatibility.
>>>
>>> Not deleting the branch is certainly safest and should be fairly easy to
>>> implement. Adding an option to reassign the upstream later sounds fine
>>> to me.
>>>
>>> Thanks
>>>
>>> Phillip
>>>
>>

