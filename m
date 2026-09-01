Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820424756C6
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255122; cv=none; b=iacDUBwfeNQ8s+IyvsNj7QVyFvZBpvDy7KPdf1VGReqkq/sSGzDveP+i76rMObsKUY6tfq95BM/bvxFQY7tlJ85OLpW1DlP2cAYOd47sQ4hJ54Y7i/87cK7o7X8kgRgC1g67p6vjHwPabYIwmzT8/IJ3BZFmZIJ2Co+0hXwcRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255122; c=relaxed/simple;
	bh=avYr/1/W7bORIgB13Xp0zYpsWP90Sdxa1vNB7e9xIK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9C0bpPk+ITqd7dLk1K1rU552iqU4g4UlwtauNmrB509p8DtL3hmOzBVlDHSRHn41U9deohh20dkyydYw76nHQnBIbJ/JwBis0AWhIdVhsAG8Q9F5Ma3bkBB1D3XyCkGplrinlGiHdecbeOOa9Vc8fy2HdvsgwLgvCHpBnpyC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgXRe9yZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgXRe9yZ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c169ae1cb26so131258066b.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788255112; x=1788859912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BsEkjK3CIox/Aw8ZpglaEBxYMqZcx2RqSg6e1wkzA+Y=;
        b=LgXRe9yZdW6Ld+GsPYLrr+5iZUDvQNA5ifbOLSwyqP37Cl5pb1vZnPxzun9S7/q9j/
         TDmseHnySPXob4LII7wYepUNwiB1weyLkHUP7edyBRyByzx3Avcj+EeCT9trDZXjUP/T
         IkYkG3zKcVrvgxqNtrbyuSHp0a7N0zUfEoyk4Vza4GKv7IylKpL3tg+K5GjX6rAqn0n6
         RAZDKNWERKWakf3w2djUOEJTcgEWz1+dWnxjhmubhHS40yUBrffr0yXKM9PeUSH8hUJR
         FIWSgw5QLWiG7DHNsJ3KZ/ZBUZD7Y5B3fkZeJiUYoWh/RxZ2QC9JxDHiCtijoYeCF4c8
         bg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788255112; x=1788859912;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BsEkjK3CIox/Aw8ZpglaEBxYMqZcx2RqSg6e1wkzA+Y=;
        b=KPTFd8ZKUl/UbzAYlIpAdmyERn4bD2dYAduIC3yM3d0RgVl6FHiTiAaHP8ciHYNnJV
         r4EpZTCAuLKD+IUFzWUkEsaRq2iqg6rgELkxgCti+JdetPdOyokmDisI/GzlGkIWOK2v
         3TjmMvq8Zvl3z48I+2JqOlZpLpoSvR8t+TTFaJUnHIGQBT5eO0kEKnYZsuLVWb2gpNNw
         yl/wcteLj6+Dst7/rv42tkk/u7+9ZOIpAFrbz6+Ymos01/TMbJCTJd6PqYVqBXTbxuab
         4+q9PzgpuP8gc+yUDJ4+ax8dTGvchJSqAKP/1HlPYRLo0e915U2iVRyFHG/4gaHjQia4
         9c3A==
X-Gm-Message-State: AFuF++lDVNrVNu1uCPQcj+qJ8rzKa0Dzz1FxOisToacn923ffnPIugfj
	veL1FCl4HOszyb0MFDPGJZMcKPF4cHNQ0vp2o8Siq6ZOGozcjMq0YbNR
X-Gm-Gg: AR+sD12XDJ+vGAsvazwtg8B+9fXoH1u4bVm4SmIe/vCqOvx44Fimg31tWCYx0oAMPvt
	GZu5gqrujdOxX5l9g4fdNvI+uAhsED8m2RUZki38Gk8xF6OnIxJEX3s8T+inzzPZnPI1u9IgXEM
	qsY2qrzUl4QXG+M/f+PP1TKjewqXuJghduNILWt7G7GRrxU+nHlr9vzk9CORFHaPS1sXX11zKmp
	EEALTSypSCXE08nZ3nelI+ztw+Cynkfvbb4qAXNai2JS+zD7N6x/UbKUgivjYhly9GYU8njlY6n
	8WkL1AVpxFoUN2GFfCIVzWpBwbnKsiy8D9wEXfoduLwysF3lNNYkvFtBykCnTV5fv1vl8PA3n0x
	vUwRZVhLu8gRfJU6E7uWSCU3YjOQQotn/sDnfg33USc93ac27Od1Ftvtb/Z+u8+KRYZ8Z3N56O6
	Dq4Dl1xmH8Td9VCoLDc/kFyxiDX7Pahxv47W/l8R/p18sp/FuNHE9d14R6zIeDWYsIS9tL3gR+n
	XPIMPjbPs2RTvDFdCHGudg5Mek77WsVOP9RWpg6FxCIXD7tGBgZhg==
X-Received: by 2002:a17:907:3e16:b0:c25:5159:6a25 with SMTP id a640c23a62f3a-c25b90ffc27mr240671266b.6.1788255111899;
        Tue, 01 Sep 2026 02:31:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f249468sm545588466b.56.2026.09.01.02.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 02:31:51 -0700 (PDT)
Message-ID: <af051ecf-0d94-4dc1-a6e5-0184b2b6e1f1@gmail.com>
Date: Tue, 1 Sep 2026 10:31:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] checkout: print blank line after autostash conflict
 advice
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <pull.2364.v2.git.git.1788177601572.gitgitgadget@gmail.com>
 <xmqq4igaxl5t.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq4igaxl5t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 18:19, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index 65afd100d9..5ed9ae86c4 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4815,7 +4815,8 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>>   		if (label_base)
>>   			strvec_pushf(&child.args, "--label-base=%s", label_base);
>>   		strvec_push(&child.args, stash_oid);
>> -		ret = run_command(&child);
>> +		if (run_command(&child))
>> +			ret = 1;
>>   	}
> 
> This does not look like the right way to have the function return 1
> if the objective is to do so only when the spawned "git stash apply
> <oid>" process fails due to conflicts.
> 
> [...]
 > > For expediency, it may be OK to assume any and all failures from
> "git stash apply <oid>" come from a conflicted stash application in
> your first version.  If that is what your reviewer recommended, I
> would agree.  But let's help users and future developers (who do not
> necessarily have to be you) by leaving a note that this code is not
> doing what it claims to do and needs more work in the code.

I think if the objective of this patch is to tell the caller whether the 
conflicts message was printed or not then it is correct because the 
existing code is too caviler about printing that message. We should at 
least tighten that even if we don't change "git stash" (which I agree we 
should fix at some point).

	ret = run_command(&child);
	if (ret > 1)
		ret = -1;

would catch run_command() failing and stash dying or being killed by a 
signal. Then we should change the code below so that it only claims 
there were conflicts when "ret == 1" and prints a new error message 
explaining that "git stash apply" failed when "ret == -1"

Thanks

Phillip

