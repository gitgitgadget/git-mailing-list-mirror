Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B094854E0
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282770; cv=none; b=SwanpFlYceNyQdNjvpIQSFjFNDjWujlDDApZiW/Qgu/ofy4sL3v3ZGic/MK80/UW+MB6iH3HnIjh7g5jvph/mADXglU2hEcnddr6M0ETByNonalKLLWv94TnI5bETVnaEyhF/3fOTEas/86khL2eElbaPMWulwK0bkFcu4hKkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282770; c=relaxed/simple;
	bh=4WkkeHU4Uvu8XTBURfju/q3/jIfoCKpGWYmJxC0Ltvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHd76iQ0+0XHsHi3IXmjCsCnophixkhQNLB3sxCV5yDvRFSBj4Zarj8TApJt73LC/GLzwWet4I8TNSQ9FfotUa1D1jYISJJD+JjNum3lH+Lk7LK3SS7LFJPqsX0JNmz+STcBpYT/Ealg2hO/UdZH/kcyvOVuhxmT+7EGtSRVyzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSpFK/Mm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSpFK/Mm"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90e828b309eso1273146d6.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282768; x=1788887568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=unCO7qme7pTnXPquEKOUwPrcZuX9YYPGO0tBjtiPk04=;
        b=MSpFK/MmCPvn6tsgb+1mev1/Ho3V+Nay051iDaxlFgunLxeDvNvxs9FdiTEgI02UpW
         b14y4eiaAqziRkLkGqsjk720UDu9kaFsDEw5VCrtfHUx8I5ZkOy6n4+FiCwIcKlpBItt
         4/h7wN8cqrORVCltXSZEqGcwqM+Jh1qAO97Z9v4pfCyeyxFCrqg6eFti8X9JGl5LHhlf
         vOZ8wrVDDisKDRzWTRUpW5+yCMiRUv/mCOJZnwGyIysS8yQeFXEh8KhZ3w5N1tHCbiks
         iTvTBqcDO3SaL5vctoym9BpQa3ZmLVlArAJpbufYC9yARwQCWIzKQQeZGmwmAGdbUI0X
         s2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282768; x=1788887568;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=unCO7qme7pTnXPquEKOUwPrcZuX9YYPGO0tBjtiPk04=;
        b=WFi9+GrsjY4AhIQXftoxgepsz0BAg7oTX4u+tMV/zh/s9q5FWwNJc/UBRkrEB19blq
         ebD/Pi4XaK/j2TV9ln4h5pZCOEakwb/TQh44KCw8XuXxztRivkzZbFNd26ZtBACXXn8J
         4azLoYKCZN2qFvgkH9IitPg4PNCU25eClsQPx98i3VWfvdusDsazbwtYUr2QEwfwGTr2
         UV6pIyBLriX6JgEF0AZa0EUJrDxZ0SgpHjGMH8hAkD9XGGms2hwwKWZemMtP6FnXL4p7
         99/sbW6UBBg5eWzRTT0/XTEjkEMUR/wJp6551JenyDPkQ2SkoCaAnv2uQHqC/0wf7UHT
         1lgg==
X-Forwarded-Encrypted: i=1; AKwUvBw7NU7kTWE8cD4wQngRHsd7NLMPoFgUpgr9215O3j7dNDTPRGBay/O1WtGE7XVo5mSKTss=@vger.kernel.org
X-Gm-Message-State: AFuF++kVme/C/QiVxIaAvt2KqOqELUTbISkc+Tbk7U1kMj0LN7mk18MC
	10DXFBKPIbRTZroKIkyLy2GnL3WuDNPhUwWdx1813zHjbgO4n8XjJ8XF+Tx5+g==
X-Gm-Gg: AYBFou16/OqW/tiu7e+6wYvJvsUi22GJWPJt2/XiySbZDojDHb4MRbLeCuOgDNqswo0
	Ed16rDX8ioyIXMkNhKvS8YNfRD5FsKyZHgcEV04IEsZWgi4o4i0oNK6t3xmy2rrpu/L9h0HuhXT
	0j7xHzeSI/8VGzv6HTZu1Exm+h6aiTSjOkBdTuGJ4dYOPEXthQODAkzUIq+wAFSKMOy/19UPy3n
	UzO1Op6MGmbUImXzxb8j8xKWSAeTj8jSI71qSTmpbNUUor1dkz/cen5cOgeuBfwM+sItSW89Ngh
	NylmKau9QSpqo3ZeQtMOlt0Z5n9mEGQN0kHV34OUoHLmklEpsy+neYzT3Oksz/EFazFZceoVaqd
	Swc6UJBxtd/dlw03vl9/rrierRxZf0u9QMLs5waJzqozEVoQKtF9RyU3Zlhmo6hMGNJX9eTSKNo
	C/LQ7cj9dGnwKgKvyoWn4nQpzrgM0Gf4o4A04qamkZGusdvZ4jjOqXeylTqGro8Wgy/FlOooumX
	0rFlwqxQRPeQ4iiDa9lDIe1QahT/Vo1IEStudyVqnoAP7WpZBDxCgUiZeAORd9Onvcwz0VOyZzI
	9pCpSWwcMJ2402Ge
X-Received: by 2002:a05:6214:3f87:b0:90a:807d:31ad with SMTP id 6a1803df08f44-90e929943c6mr142139306d6.26.1788282767566;
        Tue, 01 Sep 2026 10:12:47 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce8769b76sm104247326d6.13.2026.09.01.10.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 10:12:46 -0700 (PDT)
Message-ID: <2729941e-c682-42dd-ac82-9d59c9c9668e@gmail.com>
Date: Tue, 1 Sep 2026 13:12:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] packfile: recover when a multi-pack-index names a
 removed pack
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Jeff King <peff@peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
 <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
 <944945ab-dde7-41e5-af92-fc520485fc53@gmail.com>
 <CABPp-BEK8f4Dh=3z-Q768iBV-d-wdpXGSKhsfFacGwHEFabZKA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BEK8f4Dh=3z-Q768iBV-d-wdpXGSKhsfFacGwHEFabZKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/1/2026 12:47 PM, Elijah Newren wrote:
> On Tue, Sep 1, 2026 at 8:26 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 8/29/2026 3:00 AM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>
>> I'm late in reviewing this patch, so forgive me responding inline as
>> I discover how it works.
>>
>> tl;dr: Good patch. LGTM.
> 
> Thanks for taking a look; I wanted to point out two minor clarifications...
> 
>>> +     /*
>>> +      * Recovery for a concurrent-repack race: a stale MIDX may still name a
>>> +      * vanished owning pack even though the object survives in another pack
>>> +      * the same MIDX covers.  The regular fallback above skips MIDX-covered
>>> +      * packs, and repreparing the on-disk pack set does not reload the
>>> +      * borrowed, cached MIDX, so scan its packs directly for the survivor.
>>> +      *
>>> +      * Do this only on the second read, by which point repreparing packs has
>>> +      * already had a chance to find an object merely relocated into a new,
>>> +      * uncovered pack; only a genuine hidden duplicate reaches here.
>>> +      */
>>
>> This comment does a lot of important context-setting to show
>> that we are in a very narrow case: the stale MIDX has multiple
>> packs that contain the requested object, but the "newer" one
>> was deleted without creating a new packfile, so we need to
>> look at each contained pack for the object from its pack-index.
> 
> Actually, a new packfile is typically created, it just doesn't have
> the object in question -- and doesn't need to, because a pre-existing
> (also midx-covered) pack already has it.

Thanks. That helps me understand why this can occur regularly
enough to be triggered in the wild.

>>> +     if (midx_result == MIDX_FILL_OWNER_UNAVAILABLE &&
>>> +         (flags & OBJECT_INFO_SECOND_READ)) {
>>> +             struct multi_pack_index *m = store->midx;
>>> +             uint32_t i;
>>> +
>>> +             for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
>>> +                     struct packed_git *p;
>>> +
>>> +                     if (prepare_midx_pack(m, i))
>>> +                             continue;
>>> +                     p = nth_midxed_pack(m, i);
>>> +                     if (p && packfile_fill_entry(p, oid, e, bad_pack))
>>> +                             return 1;
>>> +             }
>>> +     }
>>> +
>>
>> This is hopefully a very rare case, but it's good to have
>> this "fall back to O(num packs)" situation.
> 
> It's actually a fall back to O(num_packs_in_the_midx); on developer
> laptops that's probably about the same as O(num_packs), but on busy
> servers constantly receiving pushes, the total number of packs often
> dwarfs the number of packs in the midx.

Thanks. You're absolutely right that I was not specific enough and
in server situations this loop will be very short.

Thanks,
-Stolee

