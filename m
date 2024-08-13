Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767317D340
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542528; cv=none; b=nld7PKvcTy7mF4Umf63Vc7J/j3nUUdmaa8UaoJk10nhj7GBfeqEWN2TNQvVM3ejcP1BytDbitRQ2XXwgjScbRlvN2yIQKRPofqQm53HHEBHeOitIPDm8sAFQmEObNv8MXad17TNzLsmhxcNFngRjkE85YuBNWyDNLqNDdzLThTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542528; c=relaxed/simple;
	bh=V/1Dpu8Xe53u4ajGJA9dEmgerUA/qlTSfjtW8hzb+lY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=eDV6erI0fWkEYs54EFsklaKAFdh0KB8B6p1Rpb3RUlm6D4KdZM79DIXXABM9+6pTNKXZhScftayBeddLc4avaIANqIp1GQP84NFVKDlwHmRS/ixyLOlunWrG8CFW7dsl7eo6EDkVMA/UPtqhhnzHeUODnJFROv6S3QFw93EAyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmnedGCn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmnedGCn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso1816095e9.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723542525; x=1724147325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJuJt84T/SxSfJ/s0jgMaiVopjzhxofxVhtDLVCTOaM=;
        b=UmnedGCnM0Egj5cLcNYEzpQvKcWhB06lOOzCkEyPtvoRgpVdmHIZumzWJJ2vZT9nJY
         rcn3ufgVhy5TxM2hSYJbqOhbNUFoj8hZXeXmglVf3nbdYi0b+v1DmtwOrwbppEcCMTJY
         A8H/J1hX0yyPoLw39b2bK4L0mQfaviHg1RQqq0g5KEVgWG+nQppVPw6+YsgSd+pFR5Hf
         G5tx/HghcFfiLApyrKECaps9LttVnzMv9mXANQXIH7UeuNqySdYXMzCrYP309rfeCO/k
         SlYdPmxcV6/xLVTpzyfq88Y/8cHsGIw+TPPR8YMYCrw2yJtUo7eqKdQZVZ2QUGxVReWM
         gnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723542525; x=1724147325;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJuJt84T/SxSfJ/s0jgMaiVopjzhxofxVhtDLVCTOaM=;
        b=BrFwQi+sSTpI13ao2B+L7oR/Kuwv3VWzfvg+97241JR0JDgN9hK001N5kWbs1VOwno
         jNdIPMgOiew7F3sWA5Ric8nuM+CYb2Pa7zmIUQNYaYnv8Xd2TkYhg0TmsYUzBJQ8aHmn
         evPdA7uaz/qElqybJ5MkEcxw8p76Ej192IbNCxqa7oBY4VNmYZZTop3qHGZj4ZqDdvbF
         jwGGSv+pbWBtLxiREqNKSOG93+cACXR6fOviOGEXkn2Zxe2v7d0sTrfxvMRqyiyQIVIQ
         7LYzmY4CI4mQTCZvGSQL38PaqtllSciCVgguEvIh+99kQVhGQ44xBZR4rxv9lhw+iFVZ
         HZqw==
X-Forwarded-Encrypted: i=1; AJvYcCVZhsdhcs0bU40L3Z8RQdhV4KPPaR38IbjOv7f83lB652SCHturRwOiftLx4w4dSsDM7kzg5Mk7a0X/knRppGE7ZL6s
X-Gm-Message-State: AOJu0YxmnaAY9nI7DZU15aKfLij45jUHk6ors3SYEvZMalBFnFWBVFS1
	YRRsvnyIOMqlJrOzNSSaVAlPOI3kwf1PcMo+UQOJ7zq+iWoBTXYVd0z5YA==
X-Google-Smtp-Source: AGHT+IEQP65GQk1qQLGf3PnvLqDIpWxiJvpciwcdTDb95S7cEty7ymQp8eiNIDFzbLaXeVPfzluT7Q==
X-Received: by 2002:a05:600c:1d02:b0:426:61fc:fc1a with SMTP id 5b1f17b1804b1-429d47f39d1mr27399275e9.3.1723542524693;
        Tue, 13 Aug 2024 02:48:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a35ccsm223787665e9.44.2024.08.13.02.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 02:48:44 -0700 (PDT)
Message-ID: <5720d5b9-a850-4024-a1fd-54acc6b15a74@gmail.com>
Date: Tue, 13 Aug 2024 10:48:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/5] config: add git_configset_alloc() and
 git_configset_clear_and_free()
To: Josh Steadmon <steadmon@google.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, calvinwan@google.com, spectral@google.com,
 emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com,
 gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net,
 Jason@zx2c4.com, dsimic@manjaro.org
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
 <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>
 <bifcs4ijz4gsnrfjs3naqclo7nj7ajhek6eppgaj6a27ixp372@6oariraac4rz>
Content-Language: en-US
In-Reply-To: <bifcs4ijz4gsnrfjs3naqclo7nj7ajhek6eppgaj6a27ixp372@6oariraac4rz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

On 12/08/2024 22:39, Josh Steadmon wrote:
> On 2024.08.12 10:10, Phillip Wood wrote:
>> Hi Josh
>>
>> Do we really need to add this code to config.c rather than handling it in
>> the wrapper layer in the next patch?
>>
>> Looking ahead I wonder how useful it is to users of the library to separate
>> out allocation from initialization. A function that allocates and
>> initializes a configset would be more convenient and harder to misuse.
>> Calling release functions *_free() rather than *_clear_and_free() would be
>> more convenient as well. I also noticed that the data types are not
>> namespaced when they are exported. So perhaps we could drop this patch and
>> add the following to the next patch.
>>
>> /*
>>   * Namespace data types as well as functions and ensure consistent
>>   * naming of data types and the functions that operate on them.
>>   */
>> struct libgit_configset {
>> 	struct config_set set;
>> };
>>
>> struct libgit_configset *libgit_configset_new() {
>> 	struct libgit_configset *set = xmalloc(sizeof(*set));
>>
>> 	git_configset_init(&set->set);
>> 	return set;
>> }
>>
>> void libgit_configset_free(struct libgit_configset *set) {
>> 	git_configset_clear(&set->set);
>> 	free(set);
>> }
> 
> Hmmm I see your point, but I am also hoping to keep the symbol export
> shim as small as possible, so that we can try to autogenerate it rather
> than add entries by hand.

That's a nice aim - how do you plan to address namespacing data types 
with that approach? The autogenerator would need to know "struct 
config_set" wants to be wrapped as "struct libgit_configset" to ensure 
we end up with consistent naming for the data type and its functions. 
We'd also still want to make sure we end up with an ergonomic api which 
means one function to allocate and initialize each data type, not 
separate functions for allocation and initialization.

> However, if people feel strongly that we don't
> want to add helper functions like *_alloc() or *_free() for types that don't
> already have them upstream, perhaps we can just put them in a separate
> rust-helpers.c file or something.

If we're not using them upstream they're just clutter as far as git is 
concerned. Having said that if you get the autogeneration working well 
so the output is usable without a lot of manual tweaking I can see an 
argument for having these functions upstream.

Best Wishes

Phillip
