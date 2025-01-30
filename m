Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206581CFBC
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 05:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738215870; cv=none; b=l2U6E2Z9VkNV9lg7jvnS2xiGicvsJBFWWEkVWcJ/WPKf8KLZkryXwMMQ7QQLlvJN/wVXX885vkYgPyoxGoLKVkqdoaFXRCJUVJRSHcDk/3NsUZ5+GbwnRoNyAyZ3nyT13SW2xSIKl6kGp0DEIs7kPnmrjcZXl7KmVKrGzDfNsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738215870; c=relaxed/simple;
	bh=dx0c/AhEsjeDCeYxMY0YjZdZ5BrunV1AXMq1rx6Blmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBNwo4VuXeaWwVd8QrX0G/mHUkhB9dA5v2cTCAgIMkQhyt1m+RfM17WlCq27GSpyI/hc6bgAlb/PdqEuHGrqk7nSte5/zU9H4B+iFX4JvmXWbvETYg6x9TVnz1nmsvFswVbHNzEaYzGU/w3md9rtiVuC/nwPCd/JHdQdi2KVuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVHCdqdz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVHCdqdz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166f1e589cso9115465ad.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 21:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738215868; x=1738820668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vey3nGQ40izHkdmNORM3Hmeq4iKmzjQ0w/ptGghOLsk=;
        b=CVHCdqdz30LctBPsK678cslVSNq8udCIo1ylGP9JAWbLwDZHy69L09gCKREA3Om+t/
         P+4TBz9PxKxFNd4yPvfSCpLKCFTREE6755lHn9LQn8AqMowmfEgRf5N/kg6WY8L3EhnQ
         qFEG15CJV4gOpYUtdm4VftNyp/jiV05sdlADYdbNGrb9m5h+wHsgX0pcXDx3X/U90o1x
         adb6dn9EYRmeR+a0YZsx/piuMw5Ewt7BTO0KAnm+hMDkFHy0e67idlolKeqE4wOl21cV
         B3em9R7Np9JfLZD3egnVlhNHTrV7uQEPQXgpmFtmqxoCCAVOhhL0qSGK0foE3RIzuPAr
         BKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738215868; x=1738820668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vey3nGQ40izHkdmNORM3Hmeq4iKmzjQ0w/ptGghOLsk=;
        b=AFftM9Nm3bHwBsyIcqj58srajDiRKP7KmckmSScu7ugVik1j0jd1FehcPY8nmMd/Kb
         5LNDTSU5rouR+qdRY0YywtmsBFod3Hp5GXrKaYayyrsvv2Y38hWbi7MomIHHrzGTRSqg
         Pv6n2MHt1LE0oajsQl/7oftEgxiNIcVsBnCNWE3v2Y4P5JBm1/MB5CYTjkBwy57+f+TE
         2ClaHH8IxqzCGtzAALtM8/8YxiRqQP3aeD5Is2+gpAWJPe0gYl7IJ5DRSnRPtGQpNmBa
         4+GHF8Ya3nQs5bUxfWUGLvBn8nO31aX2WrIdOr7i2lzXQjteFCJXEsDxe8V3n0JyqxVY
         N1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTtt6b+4ypfBmoFKa+oT01v+UO6n3qdStHULe8AM3QPlqTXZ9BOp9MC118estIkRGqMJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvthJnLrGKeBNjAVXB549DiDvxJs7n53Axrk7t60CCfkV/CU6
	96R3F1WIM5IWZjIAifbbv/195WrCe9PoaNTfw49IoJ3QNZXZgU27hxVong==
X-Gm-Gg: ASbGncvLejSPFDSM/xZnECL3QO8g/qXtsZ1x9cO9j8q38SIohaBiYmhWMrIF3LPUi1D
	CZhYY9lXaVBkQVVdVNGnyZ9gBnxoQWYJjHL6IglX6wjaddoDEVKkyZHTAWokTj+Hat0A/9o15XZ
	8NIQzJ/DCJz5dRfXv8DJzF+nxEUjPfSYgxjKddQS4J3J6JNfU/M/LJHO4lkG4er+BGQb9ohWGhK
	tAymaVAbWat3A+i2oIi08tefXZwORE5HptXojFvRP6Qhsa3y4zWqx+TSFtZa7GYk+XLb36I3P3d
	yHEJyFzWiidjDF802bP3HLd6
X-Google-Smtp-Source: AGHT+IHymSWJuMjNq6RXRts1SP3v4DuGpkiAqWvoeDZ8fbcNWK6648nWDwdCvXZKBOor7h3zuPhq3g==
X-Received: by 2002:a17:903:1205:b0:21a:87d1:168a with SMTP id d9443c01a7336-21dd7dde161mr100274895ad.41.1738215867991;
        Wed, 29 Jan 2025 21:44:27 -0800 (PST)
Received: from [192.168.0.7] ([106.51.24.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f77acsm5642675ad.98.2025.01.29.21.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 21:44:27 -0800 (PST)
Message-ID: <b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
Date: Thu, 30 Jan 2025 11:14:06 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
 <Z44u7od-mDiKcKVZ@pks.im> <xmqqr04vzyz9.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqr04vzyz9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick and Junio,

On 22/01/25 02:05, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> I was wondering whether it might make sense to also move the list of
>> microprojects into the Git project itself, e.g. as something like
>> "Documentation/Projects.txt". This would make it easier for us to update
>> the list of long-running projects whenever a new project is added and
>> makes it easier for people to discover it.
>>
>> It would also help to document consensus in the Git project. The file
>> would likely not always be 100% accurate, but it'd probably be more so
>> compared to tracking it out of our tree.
> 
> I am OK with the general idea, with one condition.  Each item in the
> list should have clear expiration date that makes it automatically
> eligible to be dropped from there.  Another uncurated list of random
> things is not what I want to add to and carry in my tree (the other
> uncurated list of random things being the set of topic branches that
> go stale without hitting 'next').
> 

Understood. We could certainly curate it from time to time. I wonder how
we could set the timeline for a microproject idea, though. Would it make 
sense to fix a rough timeline such as 1 year or so and remove any idea
whose age is more than the same?

Also, the current list of ideas could roughly be seen here:

 
https://github.com/git/git.github.io/blob/2025-microprojects/SoC-2025-Microprojects.md#ideas-for-microprojects

The topics are:

   - Fix Sign Comparison Warnings in Git's Codebase

   - Modernize Test Path Checking in Git's Test Suite

   - Add more builtin patterns for userdiff

   - Replace a run_command*() call by direct calls to C functions

   - Avoid suppressing git's exit code in test scripts

   - Use unsigned integral type for collection of bits.

   - Modernize a test script

Do share your thoughts on which of these you find being relevant
currently. That would help in preparing the first version of the in-tree
project ideas list.

--
Sivaraam
