Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A223BCEE
	for <git@vger.kernel.org>; Thu, 21 May 2026 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404497; cv=none; b=TZ+MVVDoc/jP13+VaFDOfHDxhhbLkZ6RDivX/n8MDCdQOWJHRIlr8TmWtQNb7N0T1wpxPIuHVIupHiXn1sRHhy5zFU3pVlVlwyRJJupvEFEtMduFUL8l0+VD7VfUqvA8jqGTI/Aq8VlhC1vbNYTTfV3ySSb+4lq3QVhSbWOM3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404497; c=relaxed/simple;
	bh=OzPGEOY/YLhQPu3krfNNi4lxykSFNLE5mXdhMZZeA5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gex9tSWpEgpIpq535z4cZZOEdKkxlacEq0S1GQJa9wPLfz/rY3oIopw8otwNlljYENPN18MRsRpP9ZF4c4/2ZZQzVPtHnMCxOOe/Who3RkQgOkWQx/dsJTS7mUMi+FMPSpXlrVXGg6xQBZRiP4Jbe6jtnyyYFH/2R95i5l4n1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwcA0ieV; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwcA0ieV"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90b2fcf90a0so932031485a.1
        for <git@vger.kernel.org>; Thu, 21 May 2026 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404495; x=1780009295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZo26mnXJRmGeUybyvVV7kec9kVqRtBoQFuOcfIIfag=;
        b=TwcA0ieV1PJcRG2BR2TlIzxpP8pg39VhMxx6iMounY4rjMRwcitHSzPCaQryNxxPYY
         9a4gmf/FAauOHVeI9NvZ+YpNZfNaEEmonYcWq8HkA2vY7C7OajJy0xXqPdBwJ6uZmANB
         PkhCRCX0bKxeNgruwxmkEGgtV6k/vCMMFPZCSbRuhhpwVSYsZqCtj/2BGTFQhBGFFnJF
         VUc+XV8MJOnZupRoopqwoiVukeqbX0ib/dhMsfPkurxFGsoR98CbyMzt5rrlhjLUlbZv
         cqZ5Q8LrzZcDb+UdHaqAtUQ2/SflK898dIYan73lDpGD2A3Jbixz9NPm/Vx83vl2dooH
         EAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404495; x=1780009295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZo26mnXJRmGeUybyvVV7kec9kVqRtBoQFuOcfIIfag=;
        b=bge3ukb3SVtfF2Jp5JUa5TA7J6i0oQ4WzvvqubCioZAX4iyrQ444+RnATv6z1OeXYb
         KFLhLGgx/jqzLABVn8nZP8N3U6iqEFmiLPaMhO8M0prkyROXRlAo73Rq9a27Qno9vt8/
         UyZYcRUHNfKYdIgKML9t99kWdzKHRSsPgSnnw080MZqE3N3Ax2JndBn4/UHcfJtQYGkR
         jN5mrh/y+/mxLm+ZfHnxxqzT6wY05hP9eEePiQjRH/G1yK6p/Qb2N0b3Mfkqi+qYG4bq
         GpvEPdSVP3lo/DyjeT3Rz4O5aAhwF0Sqkjdb2dPJPZ6hUfBZkWiwm6isgb+yBdjVCpIX
         Ot/A==
X-Gm-Message-State: AOJu0YyhUlUYlRxZsznt0inTqEqvTcuvU+j9PvJKQbyujun4VxFAGuQK
	bYxEFUss2AlxXeap4Z+3gQ+l41jTs2tlmb6GDCdy13TqP+PDmH0+0IFQ
X-Gm-Gg: Acq92OFn0Ds5IzAm2oTPQfI+LVW7bIa32KdmIS5wlZ/JxDtCNttg1fgIchjn3mh8vK+
	Oevp0sy1ElkI030s3/t9JHrxvCdsJAOq6PvUxOf849+2X/EZfj4OFvK06HTwQn1+gCuLP+cDKWi
	U4w8Bc5qZLuK2+z6nBMig9NgNwSTpRNuvKZ59/od45pua/1iNB6fEm7dGQ+RFoFhwOWCWNRQM5D
	1s+wiEaWqQfzVQl23FA2H151dYeeAi69alyH1zgP8VCbIDaWIwDXM2S48fSddJtzgsdPvRIyO8U
	6WKQ3zAsMuphTVWC4G4YFZqkKYL7iYyyCmNXPXHyIYOsz1j8+67bXg8A1MLZp9tt6sVnV+PE3LG
	OkU76VI1zB1QBs9LGp34kO8NL6R/J7nLfX+7tXg1NWUHNxgXYAWoUcAa28mjf3wGQ6opki5/Pju
	V0x44cU85kCCQkcah4T+vox6eFher6aRAGP5yOhpqYGZZkUtOApzwBT5uvtyg3u9JnwxqVmPYJS
	SqYa/KWspApUoP5fPOHzSYcgwCuxWw5Hr2qFLBbW+/wC/Gl
X-Received: by 2002:a05:620a:f0e:b0:911:e11e:dc0d with SMTP id af79cd13be357-914a23a301fmr675413885a.24.1779404495083;
        Thu, 21 May 2026 16:01:35 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:b19a:969:106e:4f95? ([2605:a601:9b88:8300:b19a:969:106e:4f95])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914b5dca753sm31637685a.21.2026.05.21.16.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 16:01:34 -0700 (PDT)
Message-ID: <4d7a75e9-8260-4e33-a786-72e0aa3026ae@gmail.com>
Date: Thu, 21 May 2026 19:01:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] pack-objects: integrate --path-walk and some
 --filter options
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 <agz3/ZxZZHBKofR9@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <agz3/ZxZZHBKofR9@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 7:53 PM, Taylor Blau wrote:
> On Wed, May 13, 2026 at 09:18:42PM +0000, Derrick Stolee via GitGitGadget wrote:
>> UPDATES IN V4
>> =============
>>
>> Thanks, Taylor for the careful review.
>>
>>   * Several typos are fixed.
>>   * The performance test is corrected for issues around piping Git commands
>>     and made more robust to the existence of submodules.
>>   * BIG: The tree:0 patch is significantly updated in this version. Taylor
>>     correctly smelled a problem with the new logic to emit the /tagged-trees
>>     object set, and that signaled that those trees were previously never
>>     emitted. I update the test to demonstrate that changing the data shape
>>     (including tagged trees that are otherwise-unreachable) doesn't change
>>     the test behavior, signaling a bug. The behavior change details all the
>>     complexities of visiting only directly-requested trees under a tree:0
>>     filter and recursing on all trees in other cases.
> 
> Thanks for the new round; I gave this a lighter pass since I had
> reviewed v3 in detail and the range-diff here looks good. I focused in
> on a few patches in particular, and left a couple of minor comments.
> 
> My main reservation is that the "path starts with a '/' slash character
> when directly requested" behavior feels brittle to me, and I am not sure
> if there is a cleaner way to express that.
> 
> I'm curious what your thoughts are there. I think barring that things
> are near-complete here, though I did note one issue with the t/perf
> changes (that is my fault for having a bad suggestion on the earlier
> round).

I like the suggested change to t/perf but I don't share your concerns
around the '/' character in the path (I go deeper into why in the
thread).

Thanks,
-Stolee

