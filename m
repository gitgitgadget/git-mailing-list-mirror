Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DFB3EDAA6
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076971; cv=none; b=gGwsmpYa18dt0gqPC2gaEz4F+cb+kS8Cq9x4oyTu5/WyQwUXYz3UWMUPewp60jdX+cyNSsF96Z5vd26HDZJTTcP8D3SVmAjYd1KEZMPVCZSdkaZaqwByY5TUm2HmJ1AErxdn9Q9X5uZRC3OCMy08C5IFnn0Jo324z4n/DJzVYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076971; c=relaxed/simple;
	bh=rEvH/gMHKS8ALuJuQCvwrKdJ8YzDzKVT5nj5KCvEy3w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oy+KmtqPxe/M5ZZRI0VamdAfMTsPX4r7KX8aiLlOEjuVPmue5OMqOmB+1Eqg4CTMRFQbD8nq5lRrxE3U9Z8fGafmAuA/1QK6gVa/tBCndWcjWHRNeBoCntpEbSLSGyvAtqE/ncrqSr0HL5GW0XdG+4mgFqVOkO8CQmiNsIZcvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMtXvffi; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMtXvffi"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so5937115e9.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 02:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769076967; x=1769681767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJ2jk5XVWqiMFTX8fNcLVJ5+N5XKboMzWQ9CIkNM70s=;
        b=GMtXvffibw/h//07Q4e0lPCwMzZnA87MhouV1kMB1oZoCq5ORcMBMXLx3LY+x11DPA
         1H8qDFaSeKcO6WnGpfvXXM/Chd6FLGYqD7UegvppycALnQm5muo4FwssULmoWo1UHQeE
         bG393CAu9R2/oKhZk6Qm5M8zQn+2yBnIGohy7/FMrMy8YdQp3WcCEkNdBUIvy898SX4u
         MTadWhF7XibEO1z1sjbQvnj9DqypAYRWL23OS4sEc2qRz8yX/SRbH7LNjmSCP60sPDhU
         t3eK3p4wIhw6n4u2FX1iZNUDIEpd4tLXNIb4TEakCwsi1qA8yIHdEos8EAKVBQ3fWbO0
         YJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076967; x=1769681767;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJ2jk5XVWqiMFTX8fNcLVJ5+N5XKboMzWQ9CIkNM70s=;
        b=tfIIdLBVwtxoHTfgMMRBqNZ3WvH+APbV041pSDHp+xAYS75VgvC7gApZqCUFpVTQQz
         AaeBiqNZA7GtVE/SRWVAjK8Im7KD9bO6Mrrut49Nay4aaaPuD+Z1jgq84sJE4INR61aU
         0UG1ZzOun3nn5aZK8asIr2w+O71lisyUHcqnW4l96GDiRVyBJ3r/if5ZwYpul4e2TSKK
         5tVWnE94tyEu2iSo/6o/yNmcblToOfxN96aLcCzK1QukvAhU+/xdMCV4oTVrhwdpPmUS
         Y6P5iP1BNKMuzSg2pz0BA/v1++xd7ffdgyXxWDztLEa1Akfk761Lru97uHDS2JhXEnUL
         WKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB0ukUntuVchUc/oL4XuZlcLhbyEwfWcah3SY6pHIN4/ZN7l12s0fdkJF1L2dazXbArOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxrx1be2InrWT6hLc7k0knBDWJochwkawNma+m01xLsm+PkACf
	Fq4b/ciwoTIhUr82IXivZhKu7pL3Zz+gun10+P4wCR3Ed28Sgvh84PJv
X-Gm-Gg: AZuq6aLuQ0soSkGTEmMlwZF0J01zex8O2NwoozO2wjhQejrrllewctOms7ZLEGZLejs
	98EnQTBQSoREud0gag/yGIFQd3aNCKj96OPJIU32GnAR9LYWScjzYScZk+0mWpXg3/dot1gHcsZ
	+RKvW6P3uTvdQMnvBSDLBXrcehugT6jfbd+oB1fH+qe3AqVXEE9RwJ2JihyhejNfrLl5PdReKha
	gYeRlj7ZgwZCkjFl1Q1tVFrJaaKIAO2sklTdh+aOFCY6dofsujf5UVOsVaMWI48Ve7dgw2sfW9W
	bPBNpk91OI6shKmdRskObbotoQ9aiQ2aw1eSjif79umYcB00gCys1k14SgKuekwQU99kP8f5dZs
	bM0nCaqh0aNRg2UBIBWkcKhwA2YzDQ1Bu7Yt0uZA6fquqRvh7iiH19M47edOfrBsiiD3IM72ygS
	wjBLfV7MsK/zjp9MVRdde+0d6JEjamszEd+Z8bPdiZcra5Y5acupnPsnZw0ehzeTEvMA==
X-Received: by 2002:a05:600c:8b64:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-4801eac0f22mr277923715e9.14.1769076966367;
        Thu, 22 Jan 2026 02:16:06 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm84112605e9.2.2026.01.22.02.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 02:16:05 -0800 (PST)
Message-ID: <8f7ec565-f91c-4950-91d7-781a31d6fb6e@gmail.com>
Date: Thu, 22 Jan 2026 10:16:02 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 03/10] xdiff: don't waste time guessing the number of
 lines
To: Ezekiel Newren <ezekielnewren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <53e4840c1653772379dc8d5c883b34717b81ac43.1767379944.git.gitgitgadget@gmail.com>
 <208da094-8a5d-4f16-b42b-5d5204576b5f@gmail.com>
 <CAH=ZcbCbz6MB9-9Ehskk2+27GMXXewmAzRcGyN_bBi8s5Ksxjg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbCbz6MB9-9Ehskk2+27GMXXewmAzRcGyN_bBi8s5Ksxjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/01/2026 21:12, Ezekiel Newren wrote:
> On Tue, Jan 20, 2026 at 8:02 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
>>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>>
>>> All lines must be read anyway, so classify them after they're read in.
>>> Also move the memset() into xdl_init_classifier().
>>
>> So instead of looping over the input lines one and a bit times (the bit
>> being from xdl_guess_lines) we now loop over them twice as we split them
>> first and then classify them in a separate loop. It does save some work
>> not to call xdl_guess_lines but it is unclear if that offsets
>> classifying them in a separate loop.
>>
>>> +     for (size_t i = 0; i < xe->xdf1.nrec; i++) {
>>> +             xrecord_t *rec = &xe->xdf1.recs[i];
>>> +             xdl_classify_record(1, &cf, rec);
>>
>> We seem to have lost the error handling if xdl_classify_record() fails.
> 
> The error handling was not "lost" it was deliberately removed. 

That's the sort of thing that needs to be explained in the commit message.

> The
> only way in which xdl_classify_record() could fail is by a failed
> memory allocation. On the Rust side this would result in a panic
> (panic means something different in Rust vs C) in which case C could
> not possibly recover.

There is no rust code in xdiff at the moment so we don't panic on 
failure. In git we'll die() because xdl_malloc() and friends are defined 
as xmalloc() etc. which die on allocation failure. However anyone else 
picking up this code and using a different allocator that does not die 
on allocation failure will expect the error to be propagated.

If you want to stop supporting other allocators then you should propose 
a patch to do so, not silently slip the change into this patch.

Thanks

Phillip

> Also for operations like Vec.push() in Rust it's
> assumed that memory management functions will never fail and if they
> do they crash the program with no chance of recovery (unless you
> account for panic unwinding which is really ugly). It seems a lot of
> arguments about ivec and my xdiff cleanups are "We don't do things
> this way in Git/C" I'm aware of many of these arguments and I'm trying
> to address them with a more specific answer of "Yes, but that's not
> how things are done in Rust and all of this is to prepare the code for
> conversion to Rust and some things shouldn't, or even, cannot be done
> the C way in Rust."

