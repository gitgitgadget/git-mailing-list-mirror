Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE52D3EE0
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510617; cv=none; b=ZR+kLJqC82engosVn8CfiH7FlklE4w7Eop83Dbl0fi6rSf6uWfKkbFHMx3u68H8D0R4bGXkM0dKDDGd0tdq7S/5uPrDB53nITyS0VIYLvjrFL+huFgGoRGvCrqEwHcg2oWn2JP/ZmC4WXnNBX9sNsXBcXqpUQpyDouRtnVGHIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510617; c=relaxed/simple;
	bh=A5pe4Khli19wpguQx212M29uk5MFvrlt0Q7iM93PWA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gpe6wAlmlw63y0p8PNEikAdoV1BDhkUwm3szR+Iou0Ib0K1kgeSE2MkRqsK1cCgvkpyc2FlpvxDO6/kJ4AbFwTKGxxfyTOXgJiYo5zF3LLAtslNPwVGt7RhB9duYoK2lyoObGQ/qbsxH2LlTDkBc4/SGAiHcaG+8Dr6n/wpZpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8mmPCU2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8mmPCU2"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85d5cd6fe9fso232144285a.0
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759510615; x=1760115415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Z6q63xYcFLxyvxtCpfUT54zXjFAP0xk6ZfWsPxdh/0=;
        b=h8mmPCU2PRxxRmVEUzWKS7zgnPDXZv5fOScyQlpPunffqWZzA01lClD4ELHD7hkGOn
         ayHURBmrvJJFTOfOEvah1/1jxZxUIUsf0EAucbaF/C6HNSxwGmqLSKaH7IHf9PIdLxTR
         RT5/7ZPzVxjRBqBOgJGx6IznFT9E2rjR6Gvbgzl6/qVhO4AhvwgX6iKqP2u7CSc2/pbI
         3AMF76UUqaSW3Sdd3sDuiZOATZ8U25aZ441XQwpxLzJtkF6cSR5uZwsoQRNC+P6e3D5N
         QPUDZ2gmAR1v3zmiKEdxRVx9skAB8+eCsaH8ebCjnkSjQ9OZGl0RYsV2j9t68yZKzOCY
         JsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510615; x=1760115415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z6q63xYcFLxyvxtCpfUT54zXjFAP0xk6ZfWsPxdh/0=;
        b=rd3GjO4cQsrpm5Q+udYAhXHbBCEheDi7Rbu/wVWJ2zzENMu2OJBiTnpZf0/KHVXNBJ
         Pc4qCcohKFUNsXPydJlZGw9ezTjMMpOcR9Q2x/V27gQ85kmCwk+4svkeMRTxxGk6kX9m
         ft0y41iJIMRCDBosUsZVyy9dr7iggiP375W3GYsfmczK8m1bZHg1H5bRNSmoPB2YRx14
         J1p3z3w4NojK6xZQUe2N7fooGTt2JDwKrpikRoacvhF7nZlNpF0CteruyNE8oVAMKivH
         ukVHmGLuT1ILsWUIC+aMzi/X2rFLn+4pPuYrFfLZU1SGTMaOGZEhM1D9n1G/W5jIcz0C
         zuwg==
X-Gm-Message-State: AOJu0YzW6U70B+uBz3I0JPNBoy5ws10wd8EIPuYRyINE2/t5HHCKh49z
	ugJNUwADY6Mluypc3HB5e6jEL640CSbOu39z4k5fBzErJwKhLwIa5liW
X-Gm-Gg: ASbGncscR9mC6CaihdNWWZYZYIFast4Kfy8hMi22SFZ/JW+8t40nWmJGw9HnReBEBnM
	06D+IpbYDc22GqeNqINwPfOXjWF3asmejHU15iCq/wGrNJ6ISDLwfbI5+oXYhXVmvR0L5NHPLrU
	42sNUzNdWP6aiAOSC2SvFiPAhLy7CseeVfoED/CtXKIp3yEvPqcw3Ic+lwh89qrcwgiIrjLIfNN
	1MM3Uo+bVCt4uAJQxwXWHCQymz2HFauTq7Xqea3nQqHhxalAcv40wKD3yfUOrcYRaL6xYxz3H7O
	RqGYxDS92M7LZSUVvZJmey7EOsgochyk1dvfxpsYXREeTOBgaQk1kwEdm456C8GDLEKS8RVZ2Yg
	mT++PIDHDcRjEzuZPMstOuseTYVUk2eZgb1asdgnRFEKZc9+4aF4YRGbXFPegOzjgBkU4UPKwG7
	3fu6Vmz22deEeT5Yc7rqm7uw==
X-Google-Smtp-Source: AGHT+IFDcNk7jx1BVG2J/D8n3o8cvNN5kJFjbNVTv5OciIVINTV5paEuhEbSiqFxixTsNOVGqezZLg==
X-Received: by 2002:a05:620a:2a15:b0:878:4b36:bd2e with SMTP id af79cd13be357-87a3adf1dd0mr483427085a.59.1759510614729;
        Fri, 03 Oct 2025 09:56:54 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b1:2f00:91d0:6b02:c27a:d0c8? ([2605:a601:a6b1:2f00:91d0:6b02:c27a:d0c8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87778650910sm456951885a.40.2025.10.03.09.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 09:56:50 -0700 (PDT)
Message-ID: <f9b2235f-5043-47af-907f-9c9ab3f22a51@gmail.com>
Date: Fri, 3 Oct 2025 12:56:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq5xdx7qx4.fsf@gitster.g> <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
 <aL67U0-tw7O-y6_X@pks.im> <4e67fb02-bbbb-4cd8-9892-6f65b4f82b26@gmail.com>
 <aMFjGoPhGsRCTihO@pks.im> <xmqqo6qyfijl.fsf@gitster.g>
 <aN5gPoPC4WEYw9CF@pks.im> <xmqqy0ptw8ns.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqy0ptw8ns.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2025 12:49 PM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> My intent here is mostly to allow us to swap out how exactly the data is
>> being cached. During the Git Merge I heard from some JJ developer (I
>> think) that they also have a pluggable cache, but they approach the
>> issue differently: instead of making the cache a property of the object
>> backend, they instead make the cache itself pluggable.
>>
>> I think that's a worthwhile angle to explore. The cache would still sit
>> on the repository level, and it wouldn't have to care at all whether we
>> use loose objects/packfiles or any other backend. But in theory, we can
>> still swap it out for a different representation as desired.
> 
> The idea to allow these "caches" being pluggable to the system
> independently from object store or reference store backends does
> make quite a lot of sense.  If there is only one that is plugged,
> that degenerates into the "side data like commit-graph and
> reachability bitmaps do not belong to a specific object store
> backend, but are defined over the objects known to the repository" I
> was talking about in the message you are replying to, I think.
> 
>> Which overall means that we can defer this to a later point in time, as
>> we can make it pluggable independent from making the object database
>> itself pluggable.
>>
>> So I'd propose to merge the first six patches, as everyone seemed to
>> agree that they improve the status quo, but drop the last patch that
>> moves the commit-graph into the ODB sources.
>>
>> Does that seem reasonable to everyone? If so, I don't really see a
>> reason to reroll at this point. But please let me know in case I miss
>> anything that needs addressing.
> 
> I am fine with that, but let's hear from everyone ;-).

I am also fine with that approach. Thanks!
-Stolee
