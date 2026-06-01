Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE221146C
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321690; cv=none; b=RoplYyYcDYSRnWri1zUqOyLzoOHKpLtjSY49nic5drmu48Xk4fErYtNiJv+x2Bz9VPuWuDNrEYTUtzcHM7YWzYiXIQUuCWNPqMb31hoRU9iKinkHzmDEIDthOawiBnD/DhCoKflFAanEMtA4ESrjZJ9ai4S8+nI2+EoLUeSKv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321690; c=relaxed/simple;
	bh=XaCaZ2s8CgStStdXwElUJHyqmuxWgdZrOnoWy6Nidog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TazeqmN4K7MSg2WVVfVy6LmcusQtGKALsEhkIHNdLK9BUrS4M7ZsHN63CAzjJ91GfGdmKxXR180R0uagH1Sk0HoMTNJeZY4AgavBoPvxNHI7nTP2TA1zMOdlxPx+HlV0TpkNlDulaiw3uPWloNsqRNEaxZ/adynGCMi2X8AHgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwofkLkk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwofkLkk"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eee266c6cso2884200f8f.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321687; x=1780926487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=29HFkdVvnrLG2mRXHqdfZpGoW4vw1+fH0pbItGivqS8=;
        b=mwofkLkkiQR3qhYnhNmPk+dIwO2bns27Kvt9bB2bn/hyg95CntDyghXqjGH75DmjGG
         6R+cttSbuCB5b1rQFBHku4T/1xmWJZgYK5EfKMR6wx9vXK+NiWllFBUoBbaZFW/QN/HE
         VhDHKjYvI/Idst0wOlmMbyEq4B1f+QyfX/ONRiSlAxS6AS0XuDwjxJy4dKP2qYRx+TT1
         sSJQ5At5jGwdv2e1h1V8wG8eVbfxKQ/HwK7ESQJIpqNEZKR/bumlwdnETSVbofenuFkv
         0IXP75JMeWvkJ8TatB7siH0ffZVUch/pJHH8pi+oglkhikLRDtsDlpY9YSHlrhbEUBZG
         oepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321687; x=1780926487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29HFkdVvnrLG2mRXHqdfZpGoW4vw1+fH0pbItGivqS8=;
        b=tPu9SidGrY1xssDQAp2OECE/HvrrLEgiQosqaztfFSIc7W79M/QJh10MRI4mTbGAtu
         kR2sGKgzXQqHhgytX1YlgnLXm1aBHnLg+ALqHpPcKn3W9N/YO/LeTVNOjlug2H7BRm1A
         pvt8T8nJKsB4jwZO05TMDQBU8kc8k9tdJ7DmqrFuRfgbsbZ4Mpz+t6SFXrOrLOj1oS0D
         cNSr84L2HjRuW/nX8npoqhK+AT4othCNX+ELc+jFFEz+oad3ogKLPGmC/Te7nSy7SJ5d
         4/M7msMFcizRxOWnZA+EfREC9ddM1zHkY1lxw12vkwaeYVpmoQjqFXGFBW2kIW0n9TJO
         AnjQ==
X-Gm-Message-State: AOJu0YwrCXlocSyNjCqGKKMTFIW7FqTvnAWRi+mrflpWcPfFgKx5H6kU
	h7ilOpA0xkD4MFyGWK+3I+Fe6BfUog/MzI75mXLUd2JN4Pi3tZSCNwQ7BS/6/Q==
X-Gm-Gg: Acq92OG3nAQKqr/i3NcFYKceN4YU8vmcklZwJqcKmj2Bje906jO97MAWaE7AUB6l2Ug
	isZhfsUs8A6twetgbQCfKOF50CwB+riZWw2PLphT3JKQ7+H/qAy6KyatK0QVJuJbF3iPb2rNTk4
	lRGhL+w1xsiLInb5B0IVArmUNhSc1Tkn1uZ9LMrO8pn7vRSfX88Wh9rGSbE+m4x146SwGLiXA4W
	Ar/WIxdDgCtsthfQYpzCIVSFKBWromEKBcytk/4ETo8iI4E491OLpmvx8ysLrOZeb9PwJJppHbl
	4dQixWQJ8wg4ddUvl0eZ76H9XKwD8LlZkBhU9utiWmbsX2Y2mrzoCO+Lza6fc/vpLC9sm7e6uAp
	XBVlRZ3iqAhsrYIga9aKV1m4DeZtrIzPlqVouZCUii2dVxPbEYlvsjGnYBt6NTLgEDbxw0+4yVY
	UFtLdbhSJQAjjxseMexVc2w2ZItcMugt2cZxqAB2/a33TANg715KbcZA0sNZazC4OMbsIOgtyzD
	SY110b3Pt/ejg==
X-Received: by 2002:a05:600c:4f08:b0:490:5149:a242 with SMTP id 5b1f17b1804b1-490a290d4f9mr170043625e9.5.1780321686781;
        Mon, 01 Jun 2026 06:48:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c123406sm101906375e9.5.2026.06.01.06.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 06:48:06 -0700 (PDT)
Message-ID: <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
Date: Mon, 1 Jun 2026 14:48:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
To: Patrick Steinhardt <ps@pks.im>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ah12uk7IFxS92OR1@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/06/2026 13:10, Patrick Steinhardt wrote:
> On Mon, Jun 01, 2026 at 11:31:46AM +0200, Kristoffer Haugsbakk wrote:
>> On Mon, Jun 1, 2026, at 09:56, Patrick Steinhardt wrote:
>>> diff --git a/git.c b/git.c
>>> index a72394b599..6bf6a60360 100644
>>> --- a/git.c
>>> +++ b/git.c
>>> @@ -591,7 +591,9 @@ static struct cmd_struct commands[] = {
>>>   	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
>>>   	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>>>   	{ "init", cmd_init },
>>> +#ifndef WITH_BREAKING_CHANGES
>>>   	{ "init-db", cmd_init },
>>
>> This can be marked as deprecated.
>>
>> 	{ "init-db", cmd_init, DEPRECATED },
> 
> Ah, indeed! Added locally now, thanks.

Deprecating this command seems very sensible to me. As well as marking 
it deprecated, do we want to print a warning when it is run? I imagine 
anyone who has this command in their muscle memory is unlikely to be 
reading the man page on a regular basis so wont see the warning there.

Thanks

Phillip

> Patrick
> 

