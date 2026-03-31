Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5821EEA54
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950250; cv=none; b=WH4WmGPdaHNO8HrOhIwGmhxdUIWQnIuXQE5SXI+mlqh7Ml/V9JEMDrVF79GTWTgu84wca7q8ldj2/TGbUyzDZJ1hFhoaxo5qJ1Aj+kamcVE1BlUuYaIZxghlpe7/2uaZWYol8D4CVRwONwl/Bd3SrqR/U6ybIySzpnq7G9rbGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950250; c=relaxed/simple;
	bh=WHAs+Y83/Xmni4oeLLEqE7B+FCgeVyq3fOmWatYPPak=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aD7A/fbeNH1W0LVpwUY6VKoey7m9B7j5/GAgSsD0DZpWsKG3gJsDAgUoCzOI9eFEmFL6MeFC2DbFL7JxLMdyd043rcAmBTU6WxCUlOplmqf8ZtS/eIfYWQl8bZxNTFZPZG3yB0HnO/VKS+BPAAvlR9elo9wO1Rhxh53xHkDOBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPtCWIr1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPtCWIr1"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fb439299so51006845e9.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774950247; x=1775555047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aZF066zPI6htjUFYljnjBoxH/YiU3jLG9BMS9jztAQ=;
        b=rPtCWIr1U9daV/npFnb8iZ97GpjoIRxhN4u9b8ckkUbJJWfRxlEDn6V6vIemJpT9YM
         Y/1n5n7pm3V7ln+WFJhL8MjdErbqOd20+pkAsnOAg78LGMGp4SmoEeQH2gXjUFetCCEH
         qCKajVR0U1J3vejvf9o7ZqY2POH6iqZ15yu7P7JcAvyZm2pv4prrf72rpVTyP6+Xqa3U
         oZMeBkrl1ay6lo+4kAsG41BjbXHRERla+ebTfeg/TULrhynfZB8jtuSdASg3vcsEXM/L
         GZCjKzUMkNin+9Xp/ZxlNSCyix0CV1drij2Nsk3XVf4XZQEl8e2ofg9uK18rYGrfkcFe
         tAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950247; x=1775555047;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aZF066zPI6htjUFYljnjBoxH/YiU3jLG9BMS9jztAQ=;
        b=Chai86wS4SS+Ko5vuMTjG/wtZidyThyvuSJTIqtcRL4Zl+6JAd86zjxwB9CpLojkEz
         uStyg/wG4TfEo78fuRDJ61y2/MqsSOWupgH6uKP27FnkzWypEkeZ1FVRbl3+Cj60MCjv
         CRD42uXENFr8P9CH7RxNyRusOghmyxXaCX0HrEEn5Ii4Vm4XvlRxJd3qn9unS7/SXULh
         uIgekG8MxIomx8qDgRkWWGcJfs2QUge3eyV9D6Gw4XML2WFj58mnTLCXLBO3BbiYA5Hb
         naxeT+qvoLCAJkPp/4i4NWmihobx0yUEIksaoQkDDCqknQNpO/GEEcTAcltnRdYeuyMg
         DQhA==
X-Gm-Message-State: AOJu0YylAia+UiWSp4LpivqvXj1iWZxrWuVY/8YpCdZn7kaQ7YFaESly
	epePyz/O7ZrQxeodRf53oUbHdoc8FoO+zBUtAf0aDU2JyTjKL7wchY1A
X-Gm-Gg: ATEYQzxRfDZlzhx0ziDqYTq0QixM6Yv4ci5k9fuX5cFh67QiNVo0UOWObGvzXZIQJLk
	2qXq3Fl9S5MLVhiDSCLrVJi0fCZ8nRkobDqanQ8KGLS/xcAVtqtmbRsoHG6ijn26Sqgk9bkoJ+O
	P8UlJRFRwODWO9xKrs9aAiMzzV1HRQ5J0ig1+2mXPArKhW4NSF/A5iLLM3cz8ctge/mWiX4awY5
	xqNIHJra4BMGjA6Ubq79WwkIIHf2Gpxw6WMQVKf6nthG+Kj15HOU3CZgMuRB2VUzfXWcoTlsnsT
	JSyOqlvfzW/CrgXNNdddXO83ExThAUlfBSXdN7TSyjzs4mbKTqiiW5RDbCunxfo7BdwMWmOV143
	IhqnBVFZnZZLpYfRfyF150tlRlNt86yl1hMbOcEEN6CWtJDRA9tI+n+sPO98JvkaNJOxoUUlOtu
	VV/p4ze/pbYy72p2ISo09jxN09z1a7QG544uFVwS6n07ZG427qgzwFoo+U5nSiP1n+M1Kh1tUwo
	Hg=
X-Received: by 2002:a05:600c:6814:b0:486:f8d6:5dea with SMTP id 5b1f17b1804b1-48727f7bd78mr271929515e9.19.1774950246839;
        Tue, 31 Mar 2026 02:44:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a6ebsm28640905e9.6.2026.03.31.02.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:44:06 -0700 (PDT)
Message-ID: <6d099729-d28c-4c1b-b61b-26aaa6b48ec8@gmail.com>
Date: Tue, 31 Mar 2026 10:44:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/6] xdiff/xdl_cleanup_records: make setting action
 easier to follow
To: Junio C Hamano <gitster@pobox.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yee Cheng Chin <ychin.git@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
 <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
 <0cf1412d01cc4895aa945b6f3ead3b2d79716523.1774890003.git.gitgitgadget@gmail.com>
 <xmqqy0j86hva.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqy0j86hva.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2026 00:02, Junio C Hamano wrote:
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>
>> Rewrite nested ternaries with a clear if/else ladder for
>> action1/action2 to improve readability while preserving
>> behavior.
>>
>> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>> ---
>>   xdiff/xprepare.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> Oh, I love this kind of rewrite that makes it more trivial to follwo
> what the code is doing.  Looking good.

Yes, this is a nice improvement in readability

Thanks

Phillip

> 
>> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
>> index bd8baf214d..471d9567c9 100644
>> --- a/xdiff/xprepare.c
>> +++ b/xdiff/xprepare.c
>> @@ -303,14 +303,24 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>>   		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
>>   		rcrec = cf->rcrecs[mph1];
>>   		nm = rcrec ? rcrec->len2 : 0;
>> -		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
>> +		if (nm == 0)
>> +			action1[i] = DISCARD;
>> +		else if (nm < mlim1)
>> +			action1[i] = KEEP;
>> +		else /* nm >= mlim1 */
>> +			action1[i] = INVESTIGATE;
>>   	}
>>   
>>   	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>>   		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>>   		rcrec = cf->rcrecs[mph2];
>>   		nm = rcrec ? rcrec->len1 : 0;
>> -		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
>> +		if (nm == 0)
>> +			action2[i] = DISCARD;
>> +		else if (nm < mlim2)
>> +			action2[i] = KEEP;
>> +		else /* nm >= mlim2 */
>> +			action2[i] = INVESTIGATE;
>>   	}
>>   
>>   	/*

