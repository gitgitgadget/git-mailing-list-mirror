Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28AA412BF8
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182118; cv=none; b=auhKJMnkfuNeLtuo+o4QoV2givOYJDE6pqf2FAuNkB0PcKmvGPfn59cg8YZyklgbeurTfjyl5shVV5QncbtC/vvJ5aQwkqEpa90KBA2fx0ZH4Phy6sHMHZ3VgjQoK23TUXIMhIq+VRIj2KiUTE05WWqoqxmpTN+BBgSUYkwbBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182118; c=relaxed/simple;
	bh=Pb8kcO11l1l1TIB8gKv65SAn9YgxIgseXPwbVQSieHo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BXVAq9FpenYQsXzNYU24pnRBjdGaejDt0BRGpoVjZogpRygVjyIPdF2sSRFBVF3EEtGjznPcmW5NCf5G83EgFiPHHdw+QQbb+bf3fdo9YzHmi+ZN6B9xIIjSXzoQrKd7+I5KCcHUYbHtBZwmHmj5ATocamjQk5cZD+TOh/sJjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qewrFPzh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qewrFPzh"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c25344a8c6cso458744766b.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788182115; x=1788786915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XigRSuOX7u8fiIiHSOKO6kuoG5Tbb+YM/F7awfu/4G4=;
        b=qewrFPzh12ok9JOk/u/sW63XiGhWxPOMlG8MsktLssX4uvXcYC5ZKWFQEMOXtXQMNG
         Bgyt4NY7qA8NzqBdyLGlD+xI9sG0+n+QTKsiYl+yiOn2z1FnTAccMoXtjbDrn+MTv5GG
         /dyRyskhe1VYIlv8jU/GSo6d+Hit8oMZF1Y9IOTEOhw2FeHg6ITP3osqVju/03cIM+xg
         MqG9kt3Y4BqTOklplgANLKmyj4ZUTl7VZZo4Lmad9P5VSaGlvhALnvTkVpKmuKJYyaCh
         W40boA4BcfQWy/FmXcooxIOj7aP1wQgAlfJD3DAtVNlqhv7l20b247ibzAj+hc8OwzeX
         qb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788182115; x=1788786915;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XigRSuOX7u8fiIiHSOKO6kuoG5Tbb+YM/F7awfu/4G4=;
        b=E6G8Z9wQkvmqO6PwDzB+CZ2618JYQpxOkYRljoqUa9M5hH4aT2aTEogpkD7K6gDgrB
         wm9T+peDyCHmDfyEP4D7uMU1LrCChErTwulfwzR4gnY111jxMwQmradq4Zf/LK/t0bL3
         Qq8P/pC2R1MYoIpyrQZ5jb05K6bekERPO6A6anE/Dt8vrtWwWhIotGE08eKn6Lhy9bZx
         PdcC/hk0ToietyMXYCA5hz6AwRbjbry6WmiGVY+G2e441RLiQTgamUUSjVvnCRvEgick
         bf4uZSO1nUWhPqLrOHSl1SFc0lBFU5pqn4Djkp9Ugzwb88eJSSO+++/oLJL/ZIFoJ5y5
         f2Cg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6MdJCiK/KYqQXeniFg+9zZtSMAeuDPQ8i/V890BmcXRVHYO07wZYSkyyGj/KJQY5I7gI=@vger.kernel.org
X-Gm-Message-State: AFuF++miCDvco1+Ew1b0b1MWk33/Pts+krbXhoaQHXjTd4BiXKniBSUL
	oNzFV1khYCUzu0p8syBY8tJ422nZWNgrt+Zqmh4eh+lQLvKQpLM0roxH
X-Gm-Gg: AR+sD13G6oBwXnSohNZfQyYYKH9HipcjHLCfC9e+UrdWwzCc9lW9hHpFGzaJMC3YrQy
	8h2tuuaspbs4AxbprcGvBcHjBxSeToQFfSidr8NLneaiUQ+z67dT+zF5pipj0LShNJ5XjC03/Iv
	pGKZvxytJa5+Jv6gaIkF3NVYvGr7pKNSb89UYJDpeaSRPNH+iKVASZ1AqIE82rrh3C1jlbvn467
	4EdIH9lIr64VSxHoHu25FA+NE3rZ1OitCOiQYz2ki+SBrR9L2aC8tzavPnPmjzVk1aKfqxMD0fx
	W3qQIugX0go0ShOPFgjTGQS/rgqU+5jK9QEJem3cH6o8g9SP8agtNdivwPl3dU51J50aDod4Ql7
	kjS5+LpoB146BlA2yhJMouibCFqXTkJQ8egtaFGh6ji4wg43gQe4rBqlf+Dfbl3NjtUUxNXezgI
	GZJQ9RAQLy6dbJR1M4Pma8zn5itcnvGll/JjGRaLYqZPxHSdksQBaLwZZ2xqQbFiWJKRstzeYwX
	srMdNYtxS8Ec7dQnKxLnYT8vDPA9gBsXEBhZ7CcBIkj
X-Received: by 2002:a17:907:980e:b0:c20:f529:2d6a with SMTP id a640c23a62f3a-c255721317amr1601372666b.22.1788182114766;
        Mon, 31 Aug 2026 06:15:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b2074sm436234266b.38.2026.08.31.06.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 06:15:14 -0700 (PDT)
Message-ID: <4813f6a6-69f0-48ff-9558-6339949efdd3@gmail.com>
Date: Mon, 31 Aug 2026 14:15:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] sequencer: teach autostash apply to report conflicts
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <b501b5fcd0b9dde65c1ce358e2f4014dfa340c37.1784993669.git.gitgitgadget@gmail.com>
 <ec6c3986-94ab-4692-a4c2-47569b77e9ca@gmail.com>
 <CAHwyqnVDBihNE8+tbJheO3R5TgfBUgqLHRx=zDxwT3btUi2NZA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnVDBihNE8+tbJheO3R5TgfBUgqLHRx=zDxwT3btUi2NZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 11:18, Harald Nordgren wrote:
>>> Add a conflicted parameter to apply_save_autostash_oid() and
>>> apply_save_autostash_ref() so callers can learn whether applying the
>>> stash resulted in conflicts.  Thread the parameter through
>>> apply_autostash_ref() and update existing callers to pass NULL.
>>
>> It would be nicer to use the return value to indicate
>> success/error/conflicts rather than adding yet another parameter. Apart
>> from that this looks good.
> 
> Is the int flexible enough to separate autostash conflict from other
> errors? Or should we introduce an enum here?

I think a tri-state enum would be clearest - the callers are only 
interested it "stash applied without conflicts", "stash applied with 
conflicts" and "something went wrong - could not apply stash"

Thanks

Phillip

