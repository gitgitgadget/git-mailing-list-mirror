Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233E72634
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560807; cv=none; b=bXpma3JKI3PfKtsXKp7rKgvT4N4eZlSjCZ+8ZrqXwScxwiWZ5uGZNvUuyBPOWnbRhnlgfILeXVtvLSYSsNRn54BMH/F9MeZrOzAaamcI1I42FsriyogqGi6W9qnAhqrzhWE6S2NstNxN5Oz87At+GTce6Mgd/pFnit6OG1FLGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560807; c=relaxed/simple;
	bh=BvrPAdDy6ixo6DwQEG2wHg1UeodKs5YVVad/SlHK0jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWGqmwAZY5rPzk/IMZxYD8df3J8ojc2OKcvIXmKITCnG3tYjuCghRKF4SqDd1vbtw0hAma2t8RPB2THyoR3I2OnWypfZXsTBGJaeLhudpUBEgbMSKqZfRnp/PZb8nzeypJVJusY6YDt1fcnkicgn1aAYR7PlFQq/O6qbdSk6dow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4rfk2/v; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4rfk2/v"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7086dcab64bso57078047b3.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560805; x=1747165605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGqI/IyThqo/z0rgFHr9eJmmujmawVlSAbTvp052tWI=;
        b=G4rfk2/v7p/qEoMQAbbLutrHB0nUwFTudh1gaH2FE4AUKF00aswtzlz3LdM227uNeo
         tSVtTdDy8hMylI305vgyfogtlXb7Uf/v7kBS5poMySeLiAau9M2m6FmgGF3/74kFU1Xf
         Nw53TshwL4QkhH2gUOOdbbJAlw0AQ4N3I+nxph6xuc0BK91xH38h/KaQFPrW4UIQQy9a
         gTh3LcWEVDAbr0Yx5zWkyfYeAT4s+pLf0OQwAPjgptTwL9961pLEJ5Dc3XZpJIM9i6j3
         ewQrC0QWeKJciEF1OBK7k0TqxN7/UspzFPsj79QsgS908cojoM+M7mXTwiZ7PIFtW0G3
         kruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560805; x=1747165605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGqI/IyThqo/z0rgFHr9eJmmujmawVlSAbTvp052tWI=;
        b=GYespbvIXI8wrv/ikxqGGHOrFNtwkrJRycw9S4TYZdxMAs9SKCgaWvUVkedcnEMchi
         HXP9AEahOj8nw42ULJsNDiAMfvL7wmB23HPegG1/EGkRK3UnanXmEyGoVF2cBh6UM4rC
         oDyqU1hGkL61TSTcK4GBmyf5TmoX7kGLmlCMVYGxtxeoVCOMyO8NNM2ngEw9ag4upLBA
         88LlCZ2VqE7N88Dv0CRtlS/+Fe8QF5+dtQ06qjda2PkbyIfmvl2ksi0YTVhD1y7H9B8+
         KQmDwZb1JVMAX9dNEUzCJV8+h8MyuhruE6DpgzAN38MDHatwi1CSxfYzDzifIDmkmqmP
         yjhg==
X-Gm-Message-State: AOJu0YwCe7/k5oDHA5LUUCYK9/eKhbvUVUgBwTbbJw/seSd6f0wopkHi
	Amk96YJnAWuvefCFsjL0tCvyWZjGX3ARTSJf5HWCPpfxBkkQ6WmV
X-Gm-Gg: ASbGncvn0JVYPBOl+XLRykvVUlUPOyXwK7KoqXV2MOelQ/Gyawecx8d6B3i+vABFocq
	u80ZVVJ+y8K5ivFEJZTt1f6UO/m3Me9ZntKiyTBkdxHiwJ/QLGsVrn09oeDop4jJP/QYD9sQZMi
	aTY/WLCnPvUXKc94ndemyrUc3udBcr281HQs2GTJemTAo1ADCTyHBzti5FK52yMUCr+02v9CM3O
	k3ELx0XjJ76Jv3naHR0d6pmmZJtf6eEvXZFsU1UzuwwlNns/jqfGQfRUsCgrZoBTyHQl53/F9WR
	XYCQ7EiT40x2ZZKPXJyKkAHbbWtBTgBggKGJRTmuwODC3lTgp7SmX2m6DCZlL1mC3ZO8AdMdC4u
	xLFU3hAothLpOIOZbvFTPBcJL640m
X-Google-Smtp-Source: AGHT+IGYLfeYqZUohs3fRqAi3uRIzGGmDwOfgCWaSVXWImz+SX9R+OtNNtCyEu+qVgGgcTEqFeRr6Q==
X-Received: by 2002:a05:690c:3347:b0:708:3a47:3d2c with SMTP id 00721157ae682-70a1da010damr11849037b3.13.1746560805205;
        Tue, 06 May 2025 12:46:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c414e4a2sm28803547b3.53.2025.05.06.12.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 12:46:44 -0700 (PDT)
Message-ID: <ea342443-2c71-476d-ab45-86cbe711fec7@gmail.com>
Date: Tue, 6 May 2025 15:46:43 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] pack-objects: enable --path-walk via config
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <dd66a5b46f2ef52eedea323df891a2e24fcd48c1.1742829770.git.gitgitgadget@gmail.com>
 <aBVYa9SzXk7eguIz@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aBVYa9SzXk7eguIz@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 7:42 PM, Taylor Blau wrote:
> On Mon, Mar 24, 2025 at 03:22:44PM +0000, Derrick Stolee via GitGitGadget wrote:

>> +pack.usePathWalk::
>> +	When true, git will default to using the '--path-walk' option in
>> +	'git pack-objects' when the '--revs' option is present. This
>> +	algorithm groups objects by path to maximize the ability to
>> +	compute delta chains across historical versions of the same
>> +	object. This may disable other options, such as using bitmaps to
>> +	enumerate objects.
>> +
> 
> Same note here as in the previous patch, I think it's fine to refer
> readers to the git-pack-objects[1] documentation instead of repeating
> yourself here. (And it removes the risk of these three descriptions
> falling out of sync with one another).

Sure.

>>   pack.preferBitmapTips::
>>   	When selecting which commits will receive bitmaps, prefer a
>>   	commit at the tip of any reference that is a suffix of any value
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index a6b8a78d42a..0ea85754c52 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -4652,6 +4652,9 @@ int cmd_pack_objects(int argc,
>>   		if (use_bitmap_index > 0 ||
>>   		    !use_internal_rev_list)
>>   			path_walk = 0;
>> +		else if (the_repository->gitdir &&
>> +			 the_repository->settings.pack_use_path_walk)
>> +			path_walk = 1;
>>   		else
>>   			path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
>>   	}
> 
> The limited diff context makes it hard for me to tell for sure, but this
> takes place after git_config(), right? If so, I think we can avoid using
> the repository settings machinery here and just use the config API
> directly.

As I'm paging this thread back into my memory, I internally thought
"obviously the test demonstrates that it works..."

> (FWIW, I typically think of repository settings as a way to expose
> config information to some part of the codebase that doesn't otherwise
> have easy access to, e.g., a static field that was set by a git_config()
> callback).
> 
> Separate from the above: should this have a sanity test to makes sure
> that we read the config setting correctly?
...but of course I neglected to create such a test. Will fix.

Thanks,
-Stolee

