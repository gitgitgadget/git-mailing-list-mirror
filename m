Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC31DD0EF
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840846; cv=none; b=Z2tlf8re56CDMP4kqUZDKJjCtsNiva7EBGgfWOrqS/aD3fMflFsHdyZV+zKy2b3mO/jPCzYFBrTDpB7UAefOB+eCbHN+iREdVUyafx3eluqcMZLGFr0O4UNCcFjs+424H4qU9LllnvGryjnvcLejCkks2Rmp9r1cRItqQ1JgMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840846; c=relaxed/simple;
	bh=vdlSCvuUjSnnEq3HAJrtYVWvj+OOm+nwJjfxzOP4S3k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SQzwlGXag2ItGPIV3Pdwarn0CzD+VDJ6HttgbAGnx5Axc1GUXJijDY+l7w53iOFDHoLhOp2lef4/Up7+ra2HhpS4Z0Wbf3/n0dZ4s7uFh1ba2fcU1r9foeeiH/3r52SbaKxYk6a5N47+thji8etsc1oVPBCsN5j3j96huXi3Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjloZAf2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjloZAf2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0618746bso56476555e9.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747840841; x=1748445641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmSY0RCKVVkJmYh9pn5cpKj8UrbDfZOt3UV13E3ctMs=;
        b=RjloZAf2omwfon1q9EmzBSbgD5UqUrKRQvUHGQFvyinzeXKhaPDupRaSioxV+Yj0VQ
         kFUPQQ6ewot7kluFlCi4MRsivZyb1yrMJoHvhMfYg6lZqnceN/o9uihRWXzP+plviZvn
         y481ldYOA49iTzCzu5+7s5dJm1aTnAewUd0/QGMRB9YFjz1U8d1koqG0fNFq2DyUShZZ
         nOyLK0kgDx6XimBI4S2cDJzIZ3xjv5syv/Ph+wD3Zs3jASpHLBZQmlTlb8aiHLCejXAF
         mDKeryl0/Dyfblw7l8+eOOkwN9bvp4dKrTfJf1+BellE1l3oUZ5ymfuVr4M1wIuB5EHm
         1XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747840841; x=1748445641;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmSY0RCKVVkJmYh9pn5cpKj8UrbDfZOt3UV13E3ctMs=;
        b=dazKNHNnRTauF7TbWv2yQs+9DPZkxk3ZijcJduRl08psmRzgSD2z6jaK7nji8RjtyX
         +ng8iQm8r5qsprYpUpI2jp3SSP86biRjVAf/DWN9Fxx9iSTiYBYTx/jUTh7LnB/hTv73
         FhcHDTMMY6MFdNZUEcBaIkmmlhTijhER+p/Wp6YvwlMcrBS/JG0eEUAVzYDIzpvBjuY9
         83WpMEG1KK3f1i9JfSCphNHtaExAmIHh52zrUK+l/xxrpnGa+WO9ODAXvV07kdQUcyUQ
         yc+mknSjIa+RDIVXZgMuVkHYz5NsPe3cXZmkCuQu4vJhcYGI6qWQRLQQtDFRYObKtuib
         5cQg==
X-Gm-Message-State: AOJu0YwWQpRNMwKC6PmxHW5ZoZAZeZlri17YPLuXZrFHqDrhUxPkeFON
	3bqfjEQe7oOs9unOJrt39sJNIghdRqPGKkiMPR+gXJGgZaM5oY3+ZFDD
X-Gm-Gg: ASbGncuQGPIB1IIeuI96RW4uAPyqFafroV3+dbMytUaHmDStW88nUG5EgbY5q/AVfBc
	FA2PCW3lgPXaYe9VWOsT/MZqHwvquvwPIDTVGy0p2oGN9WfJVNNSDoNea2bjus3ZGmeoBRRXh+N
	9ax5CDei8hCgEc65ttFRQRHSD8Ybd/jVfSp6kCAxqUwJh7loACOA0RiYrFzyGUZYSg9U7ELTBRR
	jfb+PSF63D2p5B7Ao58Gy9aOaRcQkiTPXlIHSQXuZJhRMYQTqX8GjnhQu1sz51cpuwAQPtpe72X
	jOLrBt1E24Rr4rijsEAfEwElNaSbUoyKHhQgR4rFF/O3ZeqUObFRwy3Ztq5/5VA/6W5wvllUFtu
	vgkzB17do4P1L+6Fy2Sakf6NBJaQ=
X-Google-Smtp-Source: AGHT+IEeNfAtqZyiwM3nXhnWS+tuVT6f4qQu8+rVZfGA/B1TZ8VR1+e9WKtb6BlxlCUeQlF5ySrEug==
X-Received: by 2002:a05:600c:1f8b:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-442ff0392d1mr181213845e9.27.1747840840697;
        Wed, 21 May 2025 08:20:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f24b6471sm73480575e9.24.2025.05.21.08.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:20:40 -0700 (PDT)
Message-ID: <00b03411-3a23-474a-bad3-c0c7a12d7802@gmail.com>
Date: Wed, 21 May 2025 16:20:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] midx docs: clarify tie breaking
To: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <29769df1c601c77031a27f3b3e5b571d5d7d043e.1747753388.git.phillip.wood@dunelm.org.uk>
 <aCzE58GaA0uviPSs@nand.local>
Content-Language: en-US
In-Reply-To: <aCzE58GaA0uviPSs@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/05/2025 19:07, Taylor Blau wrote:
> On Tue, May 20, 2025 at 04:04:27PM +0100, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Clarify what happens when an object exists in more than one pack, but
>> not in the preferred pack. If the user does not pass a preferred pack
>> then the pack with the lowest mtime is chosen as the preferred pack. For
>> objects that are not in the preferred pack the pack with the highest
>> mtime is used. "git multi-pack-index repack" relies on this behavior. If
>> ties were resolved in favor of the oldest pack as the current
>> documentation suggests the multi-pack index would not reference any of
>> the objects in the pack created by "git multi-pack-index repack".
> 
> This commit message could likely be shortened since it is repeating some
> information from the patch content itself, but I don't have a strong
> opinion here.

Yes there is a bit a repetition. The thing I wanted to get across is 
that "git multi-pack-index repack" relies on favoring the newest pack if 
an object is not in the preferred pack.

>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   Documentation/git-multi-pack-index.adoc | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
>> index 631d5c7d15c..1f016b2f682 100644
>> --- a/Documentation/git-multi-pack-index.adoc
>> +++ b/Documentation/git-multi-pack-index.adoc
>> @@ -40,8 +40,10 @@ write::
>>   	--preferred-pack=<pack>::
>>   		Optionally specify the tie-breaking pack used when
>>   		multiple packs contain the same object. `<pack>` must
>> -		contain at least one object. If not given, ties are
>> -		broken in favor of the pack with the lowest mtime.
>> +		contain at least one object. If not given the pack with
>> +		the lowest mtime is used as the preferred pack. Ties
>> +		for objects that are not contained in the preferred
>> +		are resolved in favor of the pack with the newest mtime.
> 
> I think the clarification here is good, but the structure makes it a
> little difficult to follow. The above reads to me like:
> 
>      1. What does --preferred-pack do?
>      2. What restrictions are there on the pack?
>      3. What happens if --preferred-pack is not given?
>      4. What happens if the preferred pack does not contain the object?
> 
> But I think it might be clearer to structure this like:
> 
>      1. What does --preferred-pack do for objects in the preferred pack?
>      2. What happens if the preferred pack does not contain the object?
>      3. What happens if --preferred-pack is not given?
>      4. What restrictions are there on the pack?
> 
> I tried to write something like this below:
> 
>      When specified, break ties in favor of this pack when there are
>      additional copies of its objects in other packs. Ties for objects
>      not found in the preferred pack are resolved in favor of the copy in

I'm tempted to say "are always resolved" here to make it clear that the 
behavior does not depend on --preferred-pack

>      the pack with the highest mtime. If unspecified, the pack with the
>      lowest mtime is used by default. The preferred pack must have at
>      least one object.
> 
> I think that the result here is a little easier to follow than what's
> proposed above, but I am obviously biased ;-). If you think the two are
> equivalent or mine is less clear than yours, feel free to ignore this.

With the tweak above I like your version

Thanks

Phillip
