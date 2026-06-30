Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E540D58A
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782791155; cv=none; b=PJt/PAdkIPjxeiZOKg0mWAFCf6y1jUdyiU8oJ0yz31XDISUwHeBCz5tk8Zu40onPUHulAnp/vTwYPp2p8XkzmZWoZDievyWTYX/amWqRBggpnlWM8Qw4uYcvkofN1mSrE/JDokeenHT/sI2W0VwkN8ZgGhJPnqqHHsunf3qlXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782791155; c=relaxed/simple;
	bh=hZ0r5AUtRQcINMJMNBPx4XiTvo/3TJznw+mA+MXXtCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMrpLMhXhFaaMqY8iszMInzM8Z8Cd+z6RFw+jcs70RgP135lPD2zL4MSXJfv2POZI5E83mt56JIedBKx4/xJFHk5Ay1BvB1pqX05bai7iRRbEh6trjyv0UMqVHFP3D3G4sCSfhk19FyrTCyag22jU/7NyvGSD0dKRe82mGZlEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsb6vb30; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsb6vb30"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so679550eec.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782791153; x=1783395953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFGS0jKeKBDXepR3yKSmOx94tenRzDIjevhC/VcTHyA=;
        b=bsb6vb30rNoZ/NJyswxAbx3TBIR0x5PfY6dJTYkJs+oWWC7ithbuioMFBEMIQvoysF
         GEY6NGFgRPqBFuURnHmEkio0V9QCBabEspRYc3LcIvHSCjb58/QSkFxJBJrG1mGYN51n
         vsJLXuqkeD8C9705AB/OY4f0PBW1axHbTH8BkuaYtccs7VPHTtLqTGD6HfnckDcSfGci
         RBMcTVRxPmelrptBhr58XuDWVwb+7SlQoQBZOrCWBg7215HV47Fsmf642i+PYLeYpRd4
         nWjlpjxCB7PiaJUVYodrt3kbirKjIyVhlCgw85znW+dMw4KOXMZunNDMDzxJpe2kH6Ou
         KSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782791153; x=1783395953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFGS0jKeKBDXepR3yKSmOx94tenRzDIjevhC/VcTHyA=;
        b=WhvtRenX1gF4sbbc5wL+37RKP6qQR8uTZVkzxYRRmR/ub5FzfgCUcPz7iAcKOxu2tc
         C3qD6RXs0XA3iyx3NFGJKkrl+U6HKmVpYAwh1P/aiDEvFXzFZoOgkcwiT1TvDnNxitDi
         IC23EoE55sTZPqnHTebilUR5MQowB8FmrPiW/IbXy/FojJk/r0jTxFICTx8QKnPIfb/b
         0W8fT3lSGyGwWIveS6Bpin/ypBoIWT49QQNSMQqibrnRFIOFM20UBx5LWyNIU/3JjHW+
         lv53SqXRzt979Selp8EE3ZE62BImSShlBlVCJOywaQJmn4+Y+iCU82dSQI5kqnfOtGes
         Zzwg==
X-Gm-Message-State: AOJu0YxDKQP1NLET3MBUw7VIYjFmJoEAOZJczJtUk3vAwvztDJ6OLAX1
	3dtQ0jxp1sLhD4hnXAGz86GdVFxm752FhBG/nihXL1+Ez9HDFkrY898J5kCVGA==
X-Gm-Gg: AfdE7cny5LgxYR7ylYNkS7KdiOZRf0Ogk756vdOQqvL0xuiKdJEXK9v0rTYr3aB0Q/e
	RFhALEwlU3B7aGSIRxIJ+0szaj7vGZVCPIgTJWjP4jSsOTcQ91/UkkEbCodTGhyzLe1tll+MZO9
	eqMO1Lse7LK1lmQyiLhqnt51RXcxQOINV96iKV0TVVsgB5JpL8ty/zgH5X93G2n2oMjn5f1MGUi
	lVAWXdFr++6DCJsaXyuNRyXXxpDIuAxYQblIwbrVLtmLsE+Ur7JajzTg+bje0Sbvz8nJToz9fcC
	/SkYeJnpB5JJPXhcTkEIdOcj4ZBUzIsro7me2LkMCdo/HbcR7iZpAA+PM+gcvVahIRYpGMLg5zV
	LmPbtOjGS1JXoDt45pXr919JFgPhG6Q9gFRkqD27SVb38OGHDIrMgxkGD2t22CxM/SpP+62Y2jX
	uWojnvoRZnY6PGRretJRbljsGO9TdLT6RcxEXrAKpR2tr6cOXh+vR96UJRWouzDP09wls89A==
X-Received: by 2002:a05:7300:4342:b0:30e:d6ca:61ac with SMTP id 5a478bee46e88-30ee13e52d4mr1493441eec.34.1782791152894;
        Mon, 29 Jun 2026 20:45:52 -0700 (PDT)
Received: from ?IPV6:2401:4900:9159:2e5d:6f5a:66cc:9f0b:a7a? ([2401:4900:9159:2e5d:6f5a:66cc:9f0b:a7a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5aeb0sm3317750eec.3.2026.06.29.20.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 20:45:52 -0700 (PDT)
Message-ID: <317d0f7b-469f-4456-8808-506e17de264d@gmail.com>
Date: Tue, 30 Jun 2026 09:15:49 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/history: unuse the commit buffer after use
To: Jeff King <peff@peff.net>
Cc: Git mailing list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
 <ai_KWo9o1Fhc6OFs@pks.im> <20260615172946.GD91269@coredump.intra.peff.net>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260615172946.GD91269@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff,

On 15/06/26 22:59, Jeff King wrote:
> On Mon, Jun 15, 2026 at 11:48:10AM +0200, Patrick Steinhardt wrote:
>> Huh, curious. That seems to hint that we're missing test coverage for
>> this specific scenario, as our test suite doesn't detect this leak.
> 
> I think it will only leak when the commit object has an "encoding"
> header. See below.
> 

I'm quite sure this is not about the commit with the encoding header. 
More below.

> The first paragraph is accurate here. We'd generally just get a pointer
> to the buffer cached in the slab, because no re-encoding occurs. And in
> that case you _don't_ need to call unuse_commit_buffer(), because you
> have a read-only copy, and the slab cache will hold it forever[1].
> Calling the unuse function will be a noop.
> 
> But when we _do_ re-encode, then you get a new buffer which must be
> freed. And that is when you have to call the unuse function. And the
> reason it is "unuse" and not just "free" is that you don't necessarily
> know which you have, but that function figures it out (and frees it only
> if necessary).
> 
> So what the patch is doing is correct, but the explanation is a little
> confused. We see the leak only when re-encoding, so we'd probably want a
> test case that triggers that. Which I assume implies rewriting a commit
> that was previously generated with an encoding header.
> 

Thank you very much for these insights! It has been helpful but on 
further digging I think this is not about reencoding. On testing and 
digging further, the leak appears to be happening when the commit that 
is being reworded we get is a freshly allocated buffer from 
repo_get_commit_buffer. I'm still trying to figure out how specific 
commits get cached in the slab while other commits don't. I'll update 
this thread shortly once I get an idea about the same.

Meanwhile, if anyone knows offhand about this, kindly chime in.

> Now back to that [1] note. Even if we didn't re-encode, we'll still hold
> onto that buffer forever. It's not a "leak" in the traditional sense
> because it's still referenced in the commit slab cache. But if you are
> going to walk over a million commits (like git-log does), you probably
> don't want to hold a million commit messages in memory at once.
> 
> For that you'd want to call free_commit_buffer() when you know you're
> totally done with it (again, like git-log does after it finishes showing
> the commit). That might be the case here in commit_tree_ext(), or it
> might happen later (I'm not familiar with the git-history code).
>
> But note that you need to do _both_ the unuse and free calls. If we did
> re-encode, the former is needed to free the newly allocated buffer. The
> latter only drops the original buffer in the cache.
>

 From my understanding, I think we may not need free_commit_buffer for 
the following reasons:

- The leak was only being reported when the commit did not come
   from the commit slab.
- We are not going to be reading too many commit objects into memory in
   this code path. Hence freeing the commit in the slab isn't strictly
   necessary.

Kindly correct me if I missed something, though.

To conclude, I think the change that the patch proposes if fine but the 
commit message definitely needs updation.

--
Sivaraam

