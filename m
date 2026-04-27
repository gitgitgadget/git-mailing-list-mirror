Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E8125AA
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293404; cv=none; b=tIsPgpbCA0YWZduAe5u3a+mj4e5xRS4Hu1dt00HjOjv/qt2kC+Pta0Dm/4wfkNiabThxFY1mpzbJj18OdQWA0fBihhku+ZI7UyijDy+1P5dVlTkpqW4aZwqaL6TNSKzTwy86cod5iziBuqm68LP1kID01i+5QVan0BLc/tsFEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293404; c=relaxed/simple;
	bh=egYsG+2OVOyLgjnp+quckv6lENq4pMDv32lh12GmLmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGWrTz0eSOtOE97CygDZaCGgVx+AB1eLpwsiSdgYY7RC/TJA4ltHZgLS666n/zGGMAnreJS71Mu884Z0sJ1GA7vuJJADIo9dKr17GWNMGLpumzexebI+ScMke9d/5mvBkKhDa582lGd1A9fnQIV4dqnsnJlDM4t/NmHmZK5psUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnHHjxcF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnHHjxcF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb20bcff5aso955183385a.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293402; x=1777898202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4jVrpshg43kfmeM+5YXGpMsy+TyzrwZ+xQyOn4Vv+k=;
        b=nnHHjxcFi1VF1TVT7Qq/Eq8hjy1TmvBQMiBeb/NG0MPB8N1G4t3BZGRmfyhFeCHqgk
         vjaWToerBeNR0TBAKGbbrUO1YmUgirJT4jr8GyGVvMDmYfhk5eBh17anpPCv3pnOjj9J
         pQxNAtO56vuirsHmsh58HBI5jYa4wPlM418lZhKx2Lcap/zH3uI9sMUhZNsCajVONXRt
         ByeAeBx1V2nrRmBgzUY8yp7fY4RnfiTByRn6bsB5S2H0wH8hvDryC2i3k08hThJG7+Re
         46qPjmKTLzXSIMZEjeHUdbTp7J/0G5RewUMMmP8WpJSw+e0W0a+VLm93f1F30M8gprvA
         zFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293402; x=1777898202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4jVrpshg43kfmeM+5YXGpMsy+TyzrwZ+xQyOn4Vv+k=;
        b=Zqt59D9E976LVPibwXTBCBTjkicSb88xGVsr4TGhMHCwlCwyA2lQypNmy+epCpWqB0
         H8pDalr6AMUtPPW/ZMeF0NG5pFLWBFN9ohQvqaO3NrzO7w2qbIMk4czgVHg2y+C8ioHP
         POuP3/7jL5MysVdowdMsxOdJmEqVJ/Pf5i3mFbjDc9ErtxBrA1+Y/CE8cObZHHpYOGma
         i6U8qn6ZDkJjKHDgNrYYop2LKzfYVLOZMPzgYfnONvM3Q+4svbGQt8zQmRy0IVJhRBqR
         hfSaJkXGIlSC7cTPtsl0bgXP5moUcLu8TEc7bkwjCHDIYYbJ7JCL0xyxUXNvdPgBn0sN
         yZvg==
X-Gm-Message-State: AOJu0YykcsPALzZZLnWGULM3sNZUn5cHMoLyGamfGMYXsKmatv9Cvy9m
	Aqz/cDPSMKOqIwLTU8xMY2FDJwRKCXfzarcN5E5CBPtGBnCM3XcY1LkRELdsCxoe
X-Gm-Gg: AeBDievpw/yDGh1T1GBgCTkszF0M0Yfnfkjvbey5DEqvnDIJGMkyuOHAVtSDPQ1kFdJ
	rPDLhd6pZS725K9uAYbef09Qi+fwQ0AppaRXbS0cJuUghbPyZIt4Lapu0e6wswUoRedhDSdmFJF
	upVNbr4/JOKj69DRp+vrmI7FwzyaDYMb/tj5lzPgXZM9jpuT0/XMVk4T/UyZqA9BOLlo77LW0S4
	tYzzmanOqGSEZ3cGtBikDTJy+ctNFH8/IXHegCEOgTYwMQMcTmSTotzUkZJTlgZRtviVkSsK4on
	nTUU4PSZhEusFQA800dJGrEj9gDtRCby+v8pq0DT4nycvLHSPtu0CMvZYMbtvhnUyPmwy2fXaa1
	5974GC53XfPfUhAmZ9STDP59mrSWSMrYEQQwIsPExFqPTiqfbmRduA9NoXllp1TDUTCafxCklWv
	HXQ1BwND4ON0MdOCqcrqcIOIrVrG0cdr9KMuw+H00tP6tbrCEyGjaYwC3+8zY2ZV/sm+obBbJB1
	w+/7LwEZhI7WDyA3vs=
X-Received: by 2002:a05:620a:19a3:b0:8d4:aa50:6877 with SMTP id af79cd13be357-8e7912c472dmr5626504885a.30.1777293401643;
        Mon, 27 Apr 2026 05:36:41 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cc559sm2642433385a.13.2026.04.27.05.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 05:36:40 -0700 (PDT)
Message-ID: <c19a0e29-1218-4239-a362-df514153b5ff@gmail.com>
Date: Mon, 27 Apr 2026 08:36:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] index-pack, unpack-objects: increase input buffer from 4
 KiB to 128 KiB
To: Junio C Hamano <gitster@pobox.com>,
 Scott Bauersfeld via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Scott Bauersfeld <sbauersfeld@g.ucla.edu>
References: <pull.2282.git.git.1777058098756.gitgitgadget@gmail.com>
 <xmqqldeb9w8e.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqldeb9w8e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/2026 6:21 AM, Junio C Hamano wrote:
> "Scott Bauersfeld via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
>>
>> On FUSE-backed filesystems every write(2) is a synchronous round
>> trip through the FUSE protocol (userspace -> kernel -> userspace ->
>> back), so the 4 KiB buffer turns a clone into many unnecessary tiny
>> writes with noticeable latency overhead.
>>
>> Increase the buffer from 4 KiB to 128 KiB, matching the default
>> already used by the hashfile layer in csum-file.c.
> 
> Quite sensible reasoning presented very nicely.
> 
> It may probably be a #leftoverbit but these three instances of (128
> * 1024) may want to have a common symbolic constant, like
> 
>     #define DEFAULT_IOBUFFER_SIZE_IN_BYTES (128 * 1024)
> 
> in a bit more central header file.  Especially for the one in
> csum-file.c where there is no symbolic constant used for that
> purpose.

I also had this thought. Would environment.h be the best place? 
>> Testing with strace on HTTPS clones of git/git (~296 MB pack, 5 runs
>> per variant, isolated builds from the same v2.54.0 source) shows:
>>
>>   index-pack pack file writes: 72,465 -> 24,943 avg (66% reduction)
>>   total write() syscalls:     310,192 -> 259,530 avg (17% reduction)
>>   writes of exactly 4096 bytes: ~40,077 -> 0 (eliminated)
> 
> Hmph, I would have expected more like (1 - 4/128) ~ 97% reduction.
> The difference between that and 66% is coming from where?  There are
> inherently short writes that do not utilize the new larger buffer
> beyond 4kB?  If so, another number of interest might be the number
> of writes smaller than 4096 bytes, perhaps?
 
One way to reword what you're asking is to measure "number of writes
not using the whole buffer" which is basically going to be "the
number of flush events from the application layer". Every time the
application intends to flush, the current buffer is likely to not
be exactly full. I would expect this number to not change between
implementations in real experiments.

The improvement here comes from the reduced number of flushes due
to buffer limits. I see that this can be measured in the number of
system-level events, but what impact does this have on the end-to-
end time of 'git index-pack' or 'git unpack-objects'? Is there a
t/perf/ test that can demonstrate this improvement for a variety
of real repos using GIT_PERF_REPO?

Thanks,
-Stolee

