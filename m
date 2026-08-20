Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343947D94B
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260843; cv=pass; b=TD1Ay6e7tV70S6nGR4D/VohK6ozQj0Y72O3qK8HV//y/rHocfkBROy47rtX5zU+kWFCUQntz0zjQ38LncfNiOq50MaYOq4EYRrgPdRvmubbcbyvZH5/gutjI9doUQP/p28ijrLHFElvT3IlQsJLarXiIdKQq6Xnzgi8Cm2Ae72k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260843; c=relaxed/simple;
	bh=EXMWK6ohPgg+b/86LRH+SWyMFacOBAmHgLZ9KrnKoxM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXobmJy7Q/T7iSfARsyfcNGfD4Xqn+MOy3693wQz4el1Q+wJ4D9FDQiYCTLim3pGEHUPgbtXZBQJIGVHBamxND38B5ti7k2PZ7Dey1sV8Ro3z0a1RlkRS+/JlnwMD3p73ivqhx2G+mr99h3J+O4xz4M/XoAjXeVpShkeh7n9ceo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imWj0RlP; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imWj0RlP"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-97bf91b2e6eso92838241.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787260839; cv=none;
        d=google.com; s=arc-20260327;
        b=eyceRksHBHQxazbf/KY/ns20BX9Uqu6kLJzM6jLRK7YugYexr8sTgw0rEwVApR+hJn
         l9gKXC1X7DXtgahcgmK+9GlySd9vYA8rT/Mo5bZzPTe9JXiE8VWVvG7ivoVbVn7EgPmM
         Q5xZBFF7loockw2g0ML0/l3ANyKhkWmpiVERnYaoKOP/fjwS/PDKUE8LNUGq8bJDDA2X
         Bp/9SG1T30E89YYG3Fm5pz6mTinoIw9EaatPaDTza3jvharclmDqZJchkLn3tTmiYjWC
         /jmhLK/rlwcFi9nT9w9XbePZ4jqIxa2e5xp3CyHHJ4CYCr2r7xD7sTO5KfOvISulcTOS
         x/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=n9NL+QQhTIUOm6YdjrOe3YZIJNPVglJghJMjrqTO90w=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=caqcLaBzrDxTJQdgY/KFfl+yzmLRke5em7TcsJFJWlMBjmdwb5Ge5nO0nltKLmlu3t
         OejhOUCHBidSNOS48Qjf4rY2UahLvwE86awV/XiWADa83yJf4l6aLM/39C3hUGCusHHs
         7uD08w1M/yTJ5viT/Aq7C+t0TQ/ragsfnO9Vj3ucsxCqv/0FzKahViRQdkDsnNrcio7p
         lR0HlijQW9dXpKZPIgrkJ9ihwJpsNbvMQjmv0XAvp+VKn4J1ev8+MGdv1HAFvFK2uHSP
         qDCrl4aPeCIFiAiWYhte31oGgVIuutBkjSSZ+w0Z6nZrAJaWvpDjc6/CdBvc8NJQcM0A
         JKlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787260839; x=1787865639; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n9NL+QQhTIUOm6YdjrOe3YZIJNPVglJghJMjrqTO90w=;
        b=imWj0RlPPSd9Ey4iQ3LtpbtAkbSOnFjmSk1ZRmKhv96OWzK4wiIpPkImz06uYpuBse
         TX6rFUNnD66e0BOYI2Ztl7jnbApy50AAWgVVIpr5K8a5x9Sp7d86rIsjOR23pnN3U/lW
         BbyZNmnBtxJDPjICwWW9ISdlL33cjfJjU2+nvUqhNLxyRyrGHE3ENS2ax7c0eJtG2/mM
         5OjGgCs7os1jL1s7AlwUmn84TCFrjqRuQw+4joen9IMYDt2Ckd7+JgSPM6W1eoqkMlXR
         XROg7AKDA8jDJD4uUOevENLXCmvu/2axY7WJZBGs13e+wpYah8szOL1NAIGiG0hkzfAP
         3MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787260839; x=1787865639;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9NL+QQhTIUOm6YdjrOe3YZIJNPVglJghJMjrqTO90w=;
        b=WK7/jWskN2bDsgKdLzmFvGCXwsPegb1fGE8PqG3vz0Yi22bPbn6gPbMGWN26ULrx0p
         XDHI7Elr2l1cKDZHpRlNRM+9ooVctKHdiH+Wo3bFFKWhnL6GPLCSr0IAXGohMK9eZUsj
         xqY4/VKVHzjCLUlLoguQwWfeeF+9AFCkXmwBHcDUKKkYOD5HwY4jHDUliD7Y67uWMPrj
         9TYoGazff0xdfa1fQLHRHNwOy/uug6q6elTHjrq0c2jdJ7hfVJYzDmauZbbIP3ozJS+m
         XwJrx+KSXQSNSoOq9QHBjtAq9W2KyVVpjGSO7D8SgEAqzgpWX6BgInhgMbHtrTDnxHOw
         P8eA==
X-Gm-Message-State: AFuF++kA6aE39+990UW4SmEFADhNMuGCyahX9V/mkesONSDyjRSYPSWl
	v6V5T9xTNNz+YaEJLu30R5Zw6IWlg56t93EOenL5j0EYEbKACllu2zQBXWtxNm/KWMgYH6HkViL
	QgwXmeXMpFRTplien2Gp5N21ZbHAjHyE=
X-Gm-Gg: AR+sD125AHpnmh2hdDxg3FxEm3VczGCFVbp74EetrdGSlIErUfQ+RE0+GCq/e8F0XoS
	t92Wm4WjnkFa9KT2DugY7Mpg5x3kiQiuOShPj4mkryQyjkuGcLqMJw5+23jvn6dTV75b4oboyaM
	9O/rDTW41ZZDbTvBWIiVSaWAPA6n4o0uHig/tXN0OywkFk/lfEAi8r8A13JJsgXTBynvi0IVlcq
	qhHMrx4WI/nQcvfnfOQaOYNyAVMKQ++CKC2/Un5eMVv/EpVc0DytUhWl3u+DWsn+TvfyyzwVrRm
	QaHC5pN6ch25U55nRXdB1z1tmp7HNegsspV6n0IFDmAC8aLSC5uKJNjoQwZIP2oBzQhn9herqOX
	d/jNtubGXCA92hfGLCdLjipdNNBMI0CwD57Oz49YgEpapbQ==
X-Received: by 2002:a05:6102:6a83:b0:778:459:f0cc with SMTP id
 ada2fe7eead31-77a62948509mr738564137.4.1787260839430; Thu, 20 Aug 2026
 14:20:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 14:20:36 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 14:20:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aoaV1GBPWwvTsYRm@pks.im>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-1-6bf5305d4e43@gmail.com>
 <aoaV1GBPWwvTsYRm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 14:20:36 -0700
X-Gm-Features: AcwNN1V9TepuiKmMAgYRSi59c1f5xneSMlz_v2F1NOqUjWORHtBEl0Jl-vwxxEE
Message-ID: <CAOLa=ZRPwdsWNV_YUDNmUY2J839=SbkBbtqrbfgBxjDVZ6PrxA@mail.gmail.com>
Subject: Re: [PATCH 1/3] reftable/stack: remove `REFTABLE_STACK_NEW_ADDITION_RELOAD`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000074b083065981171e"

--00000000000074b083065981171e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 19, 2026 at 03:19:37PM +0200, Karthik Nayak wrote:
>> In 80e7342ea8 (reftable/stack: allow locking of outdated stacks,
>> 2024-09-24), the `REFTABLE_STACK_NEW_ADDITION_RELOAD` was introduced so
>> that callers of `reftable_stack_init_addition()` can also reload the
>> stack if there was a concurrent update made before the lock was
>> obtained.
>>
>> Then 16684b6fae (refs/reftable: always reload stacks when creating
>> lock, 2025-08-12) updated all of the remaining call-sites to propagate
>> this flag to ensure that we always reload the stack whenever there was a
>> concurrent update.
>>
>> As all calls to `reftable_stack_init_addition()` inevitably propagate
>> the flag, it is safe to remove the flag and its associated code and make
>> the reloading of the stack the default flow. This makes it easier to
>> follow the flow and simplifies the logic.
>>
>> The only exceptions are:
>>
>>   1. Unit tests, where we explicitly do not propagate the flag. These
>>      tests are now modified with the new status quo.
>>
>>   2. `reftable_stack_clean_locked()`, which was propagating 0 to
>>      `reftable_stack_new_addition()` but was then manually reloading the
>>      stack after. Here the new flow will achieve the same, while also
>>      allowing us to remove the manual reload.
>
> libgit2 uses this flag though, so we'd have to adapt it, too. As far as
> I can see though all of the calls to `reftable_stack_add()` it has pass
> this flag.
>

Okay, that should be simple then! I can send in a pull request when/if
this lands.

>> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
>> index 5d22d84e80..5d224f8079 100644
>> --- a/reftable/reftable-stack.h
>> +++ b/reftable/reftable-stack.h
>> @@ -58,22 +58,13 @@ uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
>>  /* holds a transaction to add tables at the top of a stack. */
>>  struct reftable_addition;
>>
>> -enum {
>> -	/*
>> -	 * Reload the stack when the stack is out-of-date after locking it.
>> -	 */
>> -	REFTABLE_STACK_NEW_ADDITION_RELOAD = (1 << 0),
>> -};
>> -
>>  /*
>>   * returns a new transaction to add reftables to the given stack. As a side
>> - * effect, the ref database is locked. Accepts REFTABLE_STACK_NEW_ADDITION_*
>> - * flags.
>> + * effect, the ref database is locked.
>>   */
>>  int reftable_stack_new_addition(struct reftable_addition **dest,
>>  				struct reftable_stack *st,
>> -				const struct reftable_write_options *opts,
>> -				unsigned int flags);
>> +				const struct reftable_write_options *opts);
>>
>>  /* Adds a reftable to transaction. */
>>  int reftable_addition_add(struct reftable_addition *add,
>
> We're already busy adapting this function anyway, so do we maybe want to
> fix its name to `reftable_stack_addition_new` while at it?
>
> Patrick

I'm assuming you're talking about `reftable_stack_new_addition`? We
could, I could add another commit here.

--00000000000074b083065981171e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 986c177f1f74093f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSGI2SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1BxQy85T0VaUmVVd1R3R1BqT0UwaWJ0RmMxKy94Rgpya2Nqdjk4YWJH
clhPUGpoazNKQnR4UEdZc0NBTmE3WWFUbUJiL2IxbTBQanU5OVBIZkk5S2VsbXB6WWovRk9LCjdn
SFNYbkNrL3RsdHVudXJiZ091SEFaWHNrdlNQT2h0MTlzU2tZK0prNU5WRFVlR0FDUU43SDN5UU92
bU16VHQKZWZjZm9TUWlTdFU0STE3RkNZRmRRSzJKMi8zZlBkSkRmdWZKNXFkd1d3cS94S0hzZG5Z
RVo4ZmJpVjdmV0pUVAo4S2M4Unk2VzZwM3JkVGxUcHRRSDBvNTlGVkR2Y2cyRTVVWWw3QUFhNmdQ
UURkZ1ZsaVZBbm9uTFVDOTAydkdNCmRwK2FHWjlwUWNBM3NHUXZxdzlDMjl0ZEljVXhEMDI0T2Rk
Wk5PeXZIa1JvTEMwK1RGKzJyeUh4eHRzNk1DSHoKWkY3Tmo1MFpaVnBzVUVrUUVYRTV3SnE4Y3Ji
TjNkYkFKVWRmR0F0L0dwRDM1L09NUTRsYlhhdG5wZS9aNGZucgpaZW9tMVdDZTE2Kytac1o0Tlly
RDJ2L2xiSkI1T3h6d3lOU2lsQmgya0hGU1BvdjVqMm5VMk9Oc3ZKUVltcmIxCnB1M2F1QTBrZWQx
SnB5cklaTVMvY21jMnlWQ0ozWDUrMTE4Q2grcz0KPVU4bisKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000074b083065981171e--
