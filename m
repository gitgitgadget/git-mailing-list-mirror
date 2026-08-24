Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92320381AF9
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596512; cv=none; b=og/Uclswf95abDVLG40wr1xfRqaJP7vZmIcqco2YtKQDS2w/SubiYBbpNzhZ6GTuxSxRJfKxdATHTZQsxzMa59BOHe0NkJrSY1+7qroY3SKE8FJrXRu3XHNTo78FS0JAUDstdkvK7I3mVp/sWh7om5iYtkcQKH2vonKwLhDUorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596512; c=relaxed/simple;
	bh=Dw1xosBxLNKXu2f6WELztg6TqFb4oC1bMmq83uqFz8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaAQNCQQjfnCoIUQs575l2Pj+UOwNA/8QT0jC+pDTPwq+wZ8kbDk7icyDc6xtfBLWQTgXzlEXV/Lw+ZMJNlLVG4g9t0K72yYPHayo2BWHr5QMojKk6qcJCB7jKYB8qjZlZKsuR92bj4jTKIxOIy6KVuD6TIMf27ZtXTYP4YLTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg1P/GRC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg1P/GRC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499a4d1d7f1so20644225e9.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787596510; x=1788201310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8rdUadd/J49dt/K4tcsv6hK3VRuRZ2ODypqV4oZBwOM=;
        b=eg1P/GRCb+ayxFelJoXw7RbjbZz3tOYSmlzKFXiCEmlxGBzmp0JFbkIMn+kOu+Xi+4
         5Iwd4lFjd8xRqFz8qV/4oAcBQ+kpIIw5cfOswEPBpCdA01n4tA032t2ZNSB7/+ykIzCx
         YpwbLcWgapcYqNZIWDo6W9Et03dDY8uXsgo1EE298+g5X156iGxVka47zs7FtHQ29E5/
         if9oRKgYOQM6P9PPlC2WCLlNzXqzZlBrfAZNW68k+ogzchDuD0PZh2BhgH+nfHKqI8tP
         GQrj/DTZjJr26GpSuo/Sdrb5/ocUgHGfDwwocw5kMQ/vUGtW5JO3Zmkxpcq/FsYkJmCE
         YpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596510; x=1788201310;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rdUadd/J49dt/K4tcsv6hK3VRuRZ2ODypqV4oZBwOM=;
        b=T61m0iBGzm7v4MWCdgNSXqQ/cP12Jkyg/Ht9pCxeAVn14t7A5viScgl9v3ESaXftOF
         rrkW2iJ3WoK3NkDVhbJYOB5EAmGv+I/BdjAOWmcKDSybtH2GJ/+Z8i9WErp9bl0fDp9R
         w8Y9sJIMARB6EHSloyBORk8nlQIFj8oaLxe7AwKWedNZfslfPEqmspBSNWjFQVwX55ia
         yYxSkAYhwt9/BjlKy0whPV+A3BDRzcAVhNmp7+SXdqovc3qLMXP937L7bnMU+TP6RL3x
         iJ4SEkFlSQAYH1w8tcZKGSaii8eS2I3D+kPyHZZeojH5qD8pU3gka3Duio+SIDS5qSQu
         uAmw==
X-Forwarded-Encrypted: i=1; AHgh+RrGi2ISCYFcA79E+GlKDgKPKOpTY1gjnzjb9BiKa1m4pB7YXC6vGHm6qH+lEzZzFGBqksY=@vger.kernel.org
X-Gm-Message-State: AFuF++nA/ZLLke3HLCoFcNmN0pkiIvdgJB+AVVbFLWKfl6rIPcjMSy/J
	8aMxGsvafkrduXPhE4qBmBBW2r8aoOkPL7MqklAjWU5U85bY1il2JlGQ
X-Gm-Gg: AR+sD10wkfxXFBJtqW55A81b7yEivU9k/mYSCfhKsxJDE11t3OXCCL/p2mO4LccwhbZ
	Zxh/28Jjv2ueIBOgqadtKoLnzpZzZl4XdSz+jAC7Vq+vuPbMKENvsNOJpfAoDSzcQTXPhwLvoJ+
	vJtUJppO3qKNSQ7qta3x2yOZaHme8xLemy/9/py79yoP4hVTue7sV5mFaalCHyu5bzZjE8NyQkI
	jiQvMZAUAT0uMNg1j/oMuWFcQTZ2Dhw7WoV3dtVkhrDrECd8gnTxuxal1nDKoNAgGlRBa3YofoD
	Zjb2LDVNPH60ffVLv5YQ5jq7YVWSKhFdXhjStgTXZvTdIUz1CZJfxTZiUGp19sZtwYnlqCt0R4L
	GqywttKtdwZu4nEE8BGyqcL/IDFjC9v/Y7QTR9H/cmVYAsccfAsSrF7mNXNhE++fEZfxh1Jj8uG
	P/XzPXwJkBlexaRqRu3Y3A5rUyXmono3UHAMmxg3JVqHd6rpqsE+9+Po9+4qDzKwRyBSwDdhSao
	RS2IN2+i1FJllWNxUOM052Q9sXD1kNU4E+ygff/7+E=
X-Received: by 2002:a05:600c:5486:b0:499:a277:e8c8 with SMTP id 5b1f17b1804b1-499b8464cb8mr330882955e9.13.1787596509623;
        Mon, 24 Aug 2026 11:35:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d65c326esm1642545e9.10.2026.08.24.11.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 11:35:08 -0700 (PDT)
Message-ID: <9b5d2c16-3e95-4e3c-8cd9-9c25842bbb4e@gmail.com>
Date: Mon, 24 Aug 2026 19:35:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] t1401: check symbolic-ref exit codes and --quiet
 silence
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Nikolaus Schuetz via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Nikolaus Schuetz <nikolauspschuetz@gmail.com>
References: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
 <pull.2204.v2.git.1787264402361.gitgitgadget@gmail.com>
 <aoyBxOCdAq3qeAvW@pks.im> <xmqqbjarqswj.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqbjarqswj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2026 19:23, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> I'm still not completely sold that this difference is intentional. As
>> you mentioned elsewhere, in one code path we use `exit(1)` and in the
>> other we use `die(...)` to print an error message, which returs 128. But
>> that to me feels more like nobody noticed that those return different
>> error codes rather than an intentional difference in design, so casting
>> that behaviour into stone with new tests feels wrong to me.
> 
> I tend to agree.  The choice of 1 would have been more about "we
> need to exit with non-zero status" than "we need to use something
> different from what is used by die()".

I'd always assumed the difference was to allow scripts to distinguish 
between an invalid option and the ref not existing, like "git rev-parse 
--quiet --verify" and "git show-ref --quiet --verify".

Thanks

Phillip

> 
>> I'd suggest that we either:
>>
>>    - Continue not checking for the exact error code.
>>
>>    - Adapt the `exit(1)` to instead be `die(NULL)` so that we have the
>>      same error code across both code paths and then verify that both
>>      have the same error code.
> 
> Both sounds very sensible.
> 
> Especially the former to avoid overspecifying what does not matter
> in the end.
> 
> Thanks.
> 

