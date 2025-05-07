Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446F1C84BF
	for <git@vger.kernel.org>; Wed,  7 May 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746613572; cv=none; b=GpBHgO78P5bFdBedroQ1Re0meiMgfOxUec5+LGjjXBjIaSmz93BveVQ/aVyc+IcntlZylEaQOWyK1hbTHtlo2E+9FGeUst4Ui9RIgdDvM90y34PKPiu66x5D9syCKjHJ4UTwFHLyGEgcCXbBdw5LrgHz6ZIbxoG+UPD2ofHkOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746613572; c=relaxed/simple;
	bh=GJb7zbUqBMx1ASG3MKqQ4KZYb4kLzs0DZQ+Etdhu2JY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F3wx/iPZSL5SvLsMVibG89zPHH7Os3EcT5cGJfETO2oMcVvGBC25VdYRSLXvQxTBmlJ0k0ZzTvdbYgU6wIjk4GGl8Hismx+nBsfuyA+5c4BQzuQ4hChHav5bGwb/lz13teFx1nfRvun6uvHSAFSXgXfRSRQH1Z3c/Nso3ihYJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFVZvE+V; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFVZvE+V"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso45474285e9.2
        for <git@vger.kernel.org>; Wed, 07 May 2025 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746613569; x=1747218369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/SqDuknGOtNJM/ziLbfIxCarMRj8SXjF4mEqt1oNkLU=;
        b=RFVZvE+VXtHOy/kAJNS45M6qFIpett3vt2kzJc5A+7XLj5VUaDPc8zj31sDU0jYwMY
         0UOSZp5VPVPiDqLpbVMWjluKkiZhm5Ksn9HONsoeE7EAqfXUThCYTw4WstkoFmZhF49D
         jaavftNZGTHD7OnrSsKuozFuzRPbC3rnUnBpg5jsFYDmPrY14bSuBKl1kKswCfB1EOKj
         MqQwkLN/tGbvsttA1h+B6SgxbeH7TugUvfpXj9do7oES2KsXUl8eu1ssSI8fhh7fpNRi
         Aacsm5YQW1l4PyTbnM4yMZ3CRtOPXnIzzMeUSI5xSiEIVuSSiZ2EF+ZFhbJbuGv3RTGC
         nV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746613569; x=1747218369;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SqDuknGOtNJM/ziLbfIxCarMRj8SXjF4mEqt1oNkLU=;
        b=Fxsc645Pf3srxbIbkUMU+n2jQACQpw/NHXJlbOqWEsx7eV04105yfjurPxFU/8Y1xN
         sU4v5/DyFZtfiSHhaCF5Pih4zy1RaD7i6QwjLj7r0/s7lg3Jrgdvzj513bAKwY7eL9OV
         luWMSTjoz1xkqhE9HNBrkXhtpfE/OXUyGHXs+yBj+ZSmlwHZhEMKm4aO5ZVJFvBkJ8Wr
         UF7ydqoAzdKuqDQvXxDMR6zAgJ17TVw5pXIdNKlZISvhHGp8K3sLYK88HmOQ9zfdyU6D
         93Q/T1fioF6sbtLzDQy5PRVAGLXAE33OvHM15Gdy78B7fCxDaSs7ovsOM2XGo0239jK1
         xZVA==
X-Gm-Message-State: AOJu0YwNOuRom3yVYsugJY+B6Qo+W+QrldbOa0+fBufUCZs+yJkmZPrd
	+H7DM40r/QVKX/b3a8qMCnBnRgDvN7BnuqR8dMTu6uw8sQ5A+UZiv6b0fQ==
X-Gm-Gg: ASbGncsLoy3gvpsKDNeWyGUaD6H/flVFm4yAhb9Eo2su+buMKZnHJ4X4eMsgBxOMaBJ
	gRAhwRieWYQ+ptPOaIkGP0yXpdTuBIhL3ukszuamwYW5CUBtBBBsWmZYYI5pLlSILGq+kZXgVjd
	JppRTngVaTKxIUz5SUFF1sETM8U45clNG4T5PzBhlN8aBsbO8So8oZZgS2LIw4Ez3SQ2o37Wixu
	scMytl9J/7ghRTmxPgZGkx+a9Qr5MjHA62OIImWoakpaJDC1uuiIyFeLBb3Ab5pYecCFioQ6SHm
	YcK/moxH0R4nLJ0ASYlA/LKECpiRTS+YdUKZ0Kxy6tJycZKozXXHRBFlgE4/wcD5+KjwU1NmENc
	Y0925ryf7oR86ICs/Xa5sH/M=
X-Google-Smtp-Source: AGHT+IHFqQ0Eo/EbML+V/xS0Tqe385D67ELM37ZStU6qw96AaMjJhKUmEt/sCW0y7MJLAD4KTbUt5w==
X-Received: by 2002:a5d:47a6:0:b0:3a0:9050:cd03 with SMTP id ffacd0b85a97d-3a0b4a3f37dmr2311753f8f.47.1746613568745;
        Wed, 07 May 2025 03:26:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b494a214sm2343860f8f.25.2025.05.07.03.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 03:26:08 -0700 (PDT)
Message-ID: <0c4721c6-9ca9-41b4-a2aa-39f521d66426@gmail.com>
Date: Wed, 7 May 2025 11:26:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rebase, am: add --reviewby option
From: Phillip Wood <phillip.wood123@gmail.com>
To: Li Chen <me@linux.beauty>, Junio C Hamano <gitster@pobox.com>
Cc: git <git@vger.kernel.org>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5aceb00.fdc2d9ff187843.3547183335386278718@linux.beauty>
 <xmqqv7qdk3yl.fsf@gitster.g>
 <196a97f45e6.ee3375ac536926.7531113088063277926@linux.beauty>
 <48b86c85-bc39-40ba-a2b3-67de707dd798@crinan.ddns.net>
Content-Language: en-US
In-Reply-To: <48b86c85-bc39-40ba-a2b3-67de707dd798@crinan.ddns.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/05/2025 11:17, Phillip Wood wrote:
> Hi Li
> 
> On 07/05/2025 07:46, Li Chen wrote:
>>
>> Some projects require every commit to carry a Reviewed-by: line
>> for accountability, much like the kernel requires Signed-off-by:.
>> A first‑class option keeps that workflow “out of the box”; otherwise
>> people need to define an alias such as
>>
>> [alias]
>>      rbr = rebase --trailer "Reviewed-by: $GIT_AUTHOR_NAME 
>> <$GIT_AUTHOR_EMAIL>"
>>
>> which is functional but less convenient.
>>
>> I would appreciate your further thoughts on whether a dedicated
>> flag(--reviewby) is acceptable, or whether we should drop it and rely 
>> solely on
>> the generic --trailer interface.
> 
> I think adding support for --trailer is a good idea and if we do that we 
> don't need --reviewby. The existence and implementation of --signoff is 
> largely a historical artifact - I'm not sure we'd make the same choices 
> if we were thinking about adding it today. Different projects have 
> different requirements and I don't think it is sensible to add a new 
> option catering to the different demands of each project.

It might be worth thinking about how we could extend the trailer option 
so that it uses the committer identity if there is no value specified 
which would reduce the pain of adding things like Reviewed-by:

Best Wishes

Phillip

> I'll take a proper look at the second patch tomorrow.
> 
> Best Wishes
> 
> Phillip
> 
>> Thanks again for the review.
>>
>> Regards,
>> Li
>>
> 

