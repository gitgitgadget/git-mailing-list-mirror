Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272510;
	b=RT6z3uPLoDp8r84Ttf24DuaKDM8yCCISdaLRV4DVlIbWAHDfnSZDoHkVUAG6/vhGNz/H
	 ELW4cM7O0UbUKKkwW34LRmngGHtLSSbWiK9MR73fQsnNsv6/39e+qHSOMQAonj5KHwC45
	 SBUFqD8l+8UOGGUc/6WBgBbCJ6Ii8bkHK82T66RsTx2WOgnJQU2hy2ZT97eXWRfJCfRa1
	 Tm2iKIIBSR2y/IhVWht6EyDpkUHHbZZIIFmN9RLAUybspnKRHETVYI94ICTSny/ds/kLm
	 OVn1RV++56a7+ap0nHlvViQqxEwhlpciWFIKNP5qal+WaBu1SZCTx220a1l+iiFDmNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BTfP7ps0oM9oVvh1+Tyuy0od+iW8gWvZyrnDp0FRNP0=;
	b=c2zVRPN/eLGweo6WLH4FJyFSGN60SyK1c7h4Oz4lhNhbwyFMYf8aEwJwmLCL8NGEXJH6
	 Xlfq5ripDnvr0lEcq5EduTtwssRozDPoPRpyypTzKvSKVvetMyHQfl1g1sunjwl0v81UE
	 ooIi75ujvjI2sdVIsUXVcxo77/21ZdC5BVSHgnHF7jsKl/iVx1CyubUQoaBBxycI4NDTK
	 2+KyEFlrsVgTM44uZawwyepVv5Yde75nx2A2sqICCJVC1QnOE02AsCXKUpDL6XwZTUsW3
	 mLxJooCEYiNOVo3hltnJ+vwey3YkCZLmNlxp5IxXXTWZ0mAG+z/2CaWuijqKoIKnv8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lCJaC9w3;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901A606A31E
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 11:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2901A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lCJaC9w3
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so18713455e9.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272508; x=1793877308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BTfP7ps0oM9oVvh1+Tyuy0od+iW8gWvZyrnDp0FRNP0=;
        b=lCJaC9w3iUcOro8j12Kr0n7zmS50rd9RGxpsVU++VavIXz+agJr0CqlFcW1xt/LE8F
         d9CQS6qUgmkraqpyp/0o66ddrMvNnHMnM511qQCcyrRVFfuK84HpfzvHnt/Kr7tw96PQ
         QuSZHEF8Ehca9A/h7oYscmT2ITjr2hCroPdSzfkB474JyddwXWHn8156kzjfaWj/OrHF
         j3GEKjWCmepO0Qa5HpmWkUHvriZlCHP/f1jr5Pm0/ZU4sqZtjCuuZIiHR3OQP+BaAnvx
         Ues/QaK7NrukViSwEHQTdZU3UawZOOGWhTZkvJfX4ux6p1xvpwLaF/AZFLYhXx05Ph/D
         Udow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272508; x=1793877308;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BTfP7ps0oM9oVvh1+Tyuy0od+iW8gWvZyrnDp0FRNP0=;
        b=QmjHg6ajRUWLgHXigEIXyRab2aLEBFvWsrvtn+TsL9Se1+Vwd/ttrYRviOzyWG6lYI
         Aj2H8sGdhEl0aOse1UGWVdsd3KcV0rL5N2gUnyEEGClEqxJjr46WrBf2AhfllblVkI02
         nhk3e1OY9AdRbGcQdXFIm+c7kj3sQF0Jnhbbjld7NEfNzpnWxfZZcgBpsKYn1gvYbDoR
         h9yvaLpsnGyMF7Y+sKWVkQMgMnDvIqoZYpVi6DErBJjZDM24IBj+xvFP+ANUlIUeE6lA
         PwkZ7JTZyYFpH4MYnbszaJ6C5J5G3hcWw43CHkrt65Q1ZrB5IkzpK9ODlQYAz4dgtvhp
         khfQ==
X-Gm-Message-State: AFq9FYJcdSIH1mrLUqBnCriDu7j6YjnFxyHn5bEgE/unIQ0L9cL5Qm7o
	2FmtErvXhSiIjJL7C1ThDu6W99BbaLEMSd+I9+unLukZxybHQyyWzvDw
X-Gm-Gg: AYBFou2uUmN2AcVaC2g3x3jqSIb+5urtye5gqjYzXh6XjxhmQOkwZUKmI/g7CvWS+Gi
	C9N6mB18m2TJej6HgG9yRm80n2Ein0vPY4CxJOas1Fb37UfVNERYpONdNVO1JgMtMBkWwMTCbIq
	Cc9nqH2Ta+DPedAJE6z/1HQ5octh/F7SWUXm2wDWjs3J4HSEuQ3/t2AAHaxNxAfgfPm4+B7abui
	Wv9aiCXIlw4I4ZuFxEagTtoQ1OJWLuY8yPpMJ310XGkm7i3AZ+8o4t2o7YLl4GwdWt1+QFmrD2y
	7wNGtoAGis9WiOXOd2D6L6lGH1PJttgC6FGMFo3M//NbFIiWDEV3hAOOHPr4T+sgQWrsijCNCl2
	/XG0aQE0I52rrxJoc6VaQMpTXwsbgov3WA5P/UnfjiEvfVpRDP0wTVg6OQKRltBJJqChFAexT9A
	wF5O8I7gaieeIDmBUToNMKZvjBX9/y/RYAhQ+hb6R45OyV1DYodX0U9fyEy28c0cyjeVTE2Rs4Q
	6QcwsZX0p2K2DLfmNREuTNw37+HLZ5qPA3Rre8HH3yFCc7OcHtMFtHDNjzWz11n9DOyBZ8r7Dv4
	LRyTSgM3+h6cPGRCWjYf2NShwKuO8jJgn/yGeoMVIRV363v9e4KZRBiqDftKosObSLzB89T205A
	7qYhrbCqbLA/3h6csogbEb3G3PJHq
X-Received: by 2002:a05:600c:3b8f:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a9643d381amr125623655e9.2.1793272508320;
        Thu, 29 Oct 2026 04:15:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f41895fsm51419115e9.5.2026.10.29.04.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 04:15:07 -0700 (PDT)
Message-ID: <d18d98c9-08a7-48e1-8a6b-a43aed05dec8@gmail.com>
Date: Thu, 29 Oct 2026 11:15:05 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the same
 signal
From: Phillip Wood <phillip.wood123@gmail.com>
To: ian4hu <hu2008yinxiang@163.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
 phillip.wood@dunelm.org.uk
References: <3f939144-d4b3-4bc5-aaea-16422450d638@gmail.com>
 <20261028144736.121433-1-hu2008yinxiang@163.com>
 <0806471f-957a-4f32-ac33-c00c25a46033@gmail.com>
Content-Language: en-US
In-Reply-To: <0806471f-957a-4f32-ac33-c00c25a46033@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

A couple more thoughts ...

On 28/10/2026 16:39, Phillip Wood wrote:
> On 28/10/2026 14:47, ian4hu wrote:
>>
>> If you prefer the thread-level fix, I am happy to build it: a
>> git_pthread_create() wrapper that blocks SIGINT/SIGHUP/SIGTERM/
>> SIGQUIT around pthread_create()
> 
> I think that is probably the safest solution (though it does not help 
> for threads created external library code - I'm not sure if we have any 
> instances of that). I'd be interested to hear what others think, so I'd 
> wait a couple of days to see if anyone else comments before spending 
> much time on it.

We have a number of places where we spin up a bunch of threads to 
parallelize some work, for example in preload_index() we create some 
threads in a loop to read the index. In cases like that, where the loop 
body is just setting up some per-thread data and creating a thread, it 
would be more efficient to block signals before the loop and unblock 
them after, rather than blocking and unblocking each time we create a 
thread.

>> - leaving SIGPIPE alone, since it is
>> a synchronous signal and blocking it in workers turns deaths into
>> EPIPE
> 
> Does it? I thought that happened when its disposition is set to SIG_IGN. 
> Blocking a signal delays its delivery until it is unblocked, it does not 
> ignore the signal.

To clarify, in a multi threaded process the delivery of the signal is 
only delayed if it is blocked in all threads. If there's one or more 
threads where the signal isn't blocked it will be delivered to one of 
those threads.

Thanks

Phillip

>> - plus a sigaction()-based chain that masks all signals while
>> a handler runs.
> 
> When I wrote my last email I was thinking about blocking the signal that 
> is being handled as sigaction() defers the signal that is being handled 
> unless SA_NODEFER is passed. However, sigchain_push_common() sets the 
> same handler for all the common signals so it is probably safer to block 
> at least those as well as I'm not sure all our handlers are reentrant.
> 
>>  I would then drop this patch, or keep it as a
>> separate last-resort series if you think the belt and braces are
>> worth it.
> 
> I'd be inclined to drop it - if we're handling signals in a single 
> thread that should avoid the issue.
> 
> Thanks
> 
> Phillip

