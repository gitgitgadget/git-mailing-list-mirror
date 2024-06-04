Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C594614375D
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490948; cv=none; b=byEXFAgDVkdS8gk3G1L2+nLWc4hD8mieDDZ3AcUdzgtZkB6U+K9yP/MaxvNk3gF+2Inj4rZLjQUBTRRV4tZMXM2IthZ8PC2UQaQXArWy6rF5lIuo6Kvrr0vh+IHieL+Dus5F5DbGaeL5DIO86DopYZK0XSJaqJ+r0xTV+tYbpK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490948; c=relaxed/simple;
	bh=up4tnS9gyhb8nfCXTp7Q+jjiHzUE6VfbbJNUz9r0KYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+N5VVc0btyI0nnBX3zAGkAVuDT+YTZISqqXRsy1ReBhlGAx/WzRMDKQ90cN1upNWxJTGb/UpqFMtb05tdc8yccSTUWqP869/rDb2b2iZxoaDkvJ/zAYOma4SCyh36isviUqudFkNhZPg5Fc8ppU4tilp5PegwAISvF/nzurLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV8Jypg/; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV8Jypg/"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d1bc6e5f01so503193b6e.0
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 01:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717490946; x=1718095746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZbgQdjYl1DU3jrWpFJyERLKgF+eh2E2fJArH4jK+NA=;
        b=HV8Jypg/XSLLrHL6GZMOOEWo53aRJ7BeqqsEjypT9GGcY22Ql6cRa9gPhrvEIkV4eV
         C5pyUs8jt0OWBFPrHZngVsjLjWleMkYmBcTUZlPffm23O9/cn7qCf63FS/VGkO/3J5bf
         XAc+Ew29+yJx3BoCnyaRNVUIrK5Xrkl0uJAIw9HNP1VoeVi+99fAEZUCdAxUE9p5a2BK
         em/aCbp18gdhALQpC6kEdfKiDUe8b9uAPxdXOqMftLujG/bQLTlw8fES0XP42VbG0zff
         f7Z2/LKpKQ2+Z6BkW7Za2gVfKnIVySveCx1KNVG7G4hoIYRYtzx65o2wEXRb4NDOA10N
         1MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717490946; x=1718095746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZbgQdjYl1DU3jrWpFJyERLKgF+eh2E2fJArH4jK+NA=;
        b=Iwuq6bSjiY8w0Wb82Wj3uNHN31Ys8f+O2bT2ZLckIwYhG/mcd5AV15ufptNAIljqif
         Wh3Hop4AErvY+WdZ/HhErunA4WoNqxSDrTMxbqoy4KE7FZmq7boUr2WklAuVWCJEgGIY
         dD2ApokQwE3Y4rVaqwHrcP6xMwtdoY14629CtJw8KssxFWBFvpckM7b+jiLJom4CnbHl
         G4LZP6Wvyj8sZCg1ofFfh978+kRnyTMpi5bigytHJ6gZzfcZhjU0X7PztJIPiJNSZamx
         +IRGoNItkHWW8HWKFsevZJg8NhwyBq+3CHEWsa2VBPSrNkEpQWJ2uq435mXqRo2wKo+n
         uUsg==
X-Gm-Message-State: AOJu0YwUXy9aXXAWPqqGzNO8/LGxTCfaShkgrPwLCFFD9CK2cs7uGy/4
	NBeuFg3x2u+bFwYqw8Xy+Eu04eP5s76Nkr5CIhJYpJfQVI0Jm1FT
X-Google-Smtp-Source: AGHT+IGHGHSOy47A0asMvFYy0G9Sn3QXDLXBaRWAFbD2cHV3HoeJM92DJv2pwmGn/ONUR351YBCvtw==
X-Received: by 2002:a05:6808:199c:b0:3d1:d2fa:7f3c with SMTP id 5614622812f47-3d1e347ea8fmr15343481b6e.8.1717490944087;
        Tue, 04 Jun 2024 01:49:04 -0700 (PDT)
Received: from ?IPV6:2001:8004:2758:21fd:175:4c6d:5741:5243? ([2001:8004:2758:21fd:175:4c6d:5741:5243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025a83b354sm4465227b3a.33.2024.06.04.01.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 01:49:03 -0700 (PDT)
Message-ID: <4574e410-ca1a-495f-9835-14ee3fa454a1@gmail.com>
Date: Tue, 4 Jun 2024 18:48:59 +1000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2] date: detect underflow when parsing dates with
 positive timezone offset
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
 darcy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
 <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <xmqqwmn66zzc.fsf@gitster.g> <2d771a72-3021-46db-ac32-e008a7ace34c@gmail.com>
 <67c23773-21a4-4ad5-9b98-5e44578166dd@gmail.com>
Content-Language: en-US
From: darcy <acednes@gmail.com>
In-Reply-To: <67c23773-21a4-4ad5-9b98-5e44578166dd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/24 00:13, Phillip Wood wrote:

> Hi darcy
> On 03/06/2024 12:44, darcy wrote:
>>> Do we also want to check for overflows in the other direction (a large
>>> timestamp with a negative timezone offset)?
>> Is this something people want added? I am happy to implement this if
>> so, though it wasn't my original intention.
> I think if we're worried about the date overflowing in one direction it
> makes sense to fix overflows in the other direction at the same time
> especially as I think that the other case involves a signed integer
> overflow which is undefined behavior in C.

That makes sense.

Though I am reading the `tm_to_time_t` code now and it only allows years
up to 2099.

> 	if (year < 0 || year > 129) /* algo only works for 1970-2099 */
>		return -1;

I can of course add a check here for dates close to the end of 2099, but
it seems that the bigger issue is that some day people will want to use
Git after 2099... Should I see if I can extend this range? I'm not sure
where that specific year comes from, it doesn't seem to be based on a
limit of the size of `time_t`, and the comment or git logs don't seem to
provide a reason.


