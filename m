Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE58564F
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963316; cv=none; b=frwTCda3ESkP+IxqQE0MBW1MVCaZ9ty/pzMN/mol6bC5MmduuoVL8PyGXU/GdJWbiZHjlRfGx8OHpK9VDHdJUOTUmj6QGBnewnOy+mgfAVTUjbojGuxWUO3EkzaQAeZzo6UP14Qan35+0DUsTNWwwXsyPQ86xf/WDdvp4LVWGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963316; c=relaxed/simple;
	bh=ulldsRR08FdCH1/hjeC/GMyp9o0GNWyp6qWKmz5zr6E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c3QDNjST0ailYsdgJw8PHePPY8E/aHyycnBDYnmi0tSXDzjzFzQySEVTAbbKPt3FYlH4KxNIVl253z7xxnDQnn+SdOUAi2NTNbbq2qMtRAhEgdFWimD6cNmMnRqxOIZRZaEbs9HHwhr9UK6nEXsqLX+TT5QtB9l/zIheLIkcAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiQVQO1r; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiQVQO1r"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4146f2bf8ecso1208885e9.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710963313; x=1711568113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HjaiDwru82QxNRFwSz/y6144C+PqrW7NXF4UP9NOzps=;
        b=CiQVQO1rulIo3QGc26FVsJFTjgLqDykan15RPJgR0Z8gF5fSm8NAMOKVBKyamiTTeG
         qlDzEwuK2nEcNHa/QC4C0sU+S/lg63WJ1zBqf2c7AadMYAxVbU506zPRFZgK9I0vC7kX
         0HDGKJfcGb+6LMSE+iZ/4Y+Gs2+Y2mT0c9XsmpkOYEl1bumif4KWHIYFmvu4XXUfcNbj
         H6JibK7PFq9K2mNIN6aE1jchV2j8S69ESXvgh9yEDMoQPYQ/6Qs6ct1ilURyuxxtoG59
         CfGkZ0gn5rZzGVo4NNa0TYGXSfBNk1EK9Rzbayj97u7/wzebsp9pc1+2FJxwnSeTcN1r
         CN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963313; x=1711568113;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjaiDwru82QxNRFwSz/y6144C+PqrW7NXF4UP9NOzps=;
        b=b3F8HdUyFYf07+Y4fIjldBNMLvxjLxLdAbm26DggAzBAfJwibHAueda74jP1sQUnLA
         Jeaga5VTLv0cmpSrp4tSws+S/mhY5BzY9BgLO9wB7LENdjzT3uUwrBR+Gp4M2Djv/ex7
         QgHdDan4+h7ff0RJL9jUVSzm4hnAMnaD0I+plFxMNLQWEPHQG4hf/zmcn/p7zABmA2Ju
         awAGZCbaIG6yYyp9f+ZmCH9/RdOkPCHsKp1b9DwIY4E9CH7/n0CpaXInl7omzFp6FrlP
         AUv+rG7UEXXhHik99CDeiMFT69kYFzcEdjHH2XWXm4lE5dk+e3hMdQvBA2cjtHXM7do4
         Vf0w==
X-Gm-Message-State: AOJu0YxNJYCzeyKHCgxEPCZNmwsyY/G93oIPPKDCWjszUFJKpI7V6vK1
	09k2sdnw8w8mu8mhRrMaPlPywdborMPwf8LGPVbq7GhNUXOAOWN3
X-Google-Smtp-Source: AGHT+IE1MxjwlMrOBQYZZwc+zOx6B/0KArFWk8Y7ktr0cL9CsL45yPQ6Y4+op9hZw5BMb5JihydE1Q==
X-Received: by 2002:a05:600c:458e:b0:412:dca9:aa83 with SMTP id r14-20020a05600c458e00b00412dca9aa83mr14915657wmo.21.1710963312835;
        Wed, 20 Mar 2024 12:35:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b0041462294fe3sm3128592wmo.42.2024.03.20.12.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 12:35:12 -0700 (PDT)
Message-ID: <507f8792-5f79-4ab3-b328-abfbc5dbffc5@gmail.com>
Date: Wed, 20 Mar 2024 19:35:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 7/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, newren@gmail.com, me@ttaylorr.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240310184602.539656-8-brianmlyles@gmail.com>
 <d7c926ce-8a2d-4828-a3b0-3c4a9bcfe92a@gmail.com> <xmqq1q8edpb4.fsf@gitster.g>
 <CAHPHrSfiMbU55K2=8+hJZy1cMSRbYM77pCK8BdcAPHLvapHO_A@mail.gmail.com>
In-Reply-To: <CAHPHrSfiMbU55K2=8+hJZy1cMSRbYM77pCK8BdcAPHLvapHO_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian

On 16/03/2024 05:20, Brian Lyles wrote:
> On Wed, Mar 13, 2024 at 12:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>> phillip.wood123@gmail.com writes:
>>>> +Note that this option specifies how to handle a commit that was not initially
>>>> +empty, but rather became empty due to a previous commit. Commits that were
>>>> +initially empty will cause the cherry-pick to fail. To force the inclusion of
>>>> +those commits, use `--allow-empty`.
>>>
>>> I found this last paragraph is slightly confusing now --empty=keep
>>> implies --allow-empty. Maybe we could change the middle sentence to
>>> say something like
>>>
>>>      With the exception of `--empty=keep` commits that were initially
>>>      empty will cause the cherry-pick to fail.
>>
>> That is certainly easier to read and much less confusing.
> 
> I agree that this paragraph is slightly confusing. I tried this
> suggestion on but found it to not sit quite right, I think because the
> two exceptions (--empty=keep and --allow-empty) were not part of the
> same sentence, so it felt a little disjointed. How would you feel about
> the following instead, which aims to be more clear and specific about
> the behavior?
> 
>          Note that `--empty=drop` and `--empty=stop` only specify how to
>          handle a commit that was not initially empty, but rather became
>          empty due to a previous commit. Commits that were initially empty
>          will still cause the cherry-pick to fail unless one of
>          `--empty=keep` or `--allow-empty` are specified.

That looks fine to me

Best Wishes

Phillip
