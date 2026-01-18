Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2A500972
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703972; cv=none; b=poHnuJdDipJBlrpwZ/0TY55dz/8Mp9jzog8DFFB9E1J9zZV5lLykd1SF16O7mArjK17MnFNC8U2lAPbfBIoFpnLMsZcVPfH9NZlnuBfN/l+KMYwk4iEHcllGbb+dubvlPiB3W6UI9UxyuS8zFZY5ZEOSvx4ocfKGtYzpGgObrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703972; c=relaxed/simple;
	bh=ufFvg7q54JVW8gU8UhM18pv8SAO8cUGrIY/+yLyLtOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUagMvx/rhUzkD0eNpLihbrT2cvvCVgyUJiu3+8tOWz9tnq98y4vMRuq7cm3rVZ3TnRs0P1zaqqKE3Gq9gTomGa1KOxtueYziHn2ysgGH+nk0bSBlaOKSdgfU+bHX9nDQqz4FHyBL26/2nZRFGjZw2N3Xy0K2gk3QnsDWyth6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBt9QXQ6; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBt9QXQ6"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c5384ee23fso366276985a.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 18:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768703970; x=1769308770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFDplqX5YhrXjoGx7VyRo4bS/iP6A5DS6zDtudVRUR4=;
        b=LBt9QXQ606c08cv+I20Zg6YSkzcVyazu6J+nbISTEJvnJOGN3upCjEAeT669rzReCr
         FudoEw+eYzxV+X8oHdggPc/lXr21Nth10a/X+SV3YCnfRjZ8bo5kMCSrJveHY3aREJEr
         9IvPiBW5nppjXZIItUptRfqBK0zC/KKlFk84V+csDSblNwOgWQgq/EoFQizd+AMwGdb/
         h7jRGH9mrgXGF2wCwtUlpyzspc7rOZUsM4hwLeBToy5cNrrpigN2Vqt5mRExMhKT6z/H
         CbQEg7UBh3Qk/uU6s3gUkDyphSlhfpU3DAGZp86fDkeBH494PLWg5n9SREMC94yxoBuU
         KaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768703970; x=1769308770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFDplqX5YhrXjoGx7VyRo4bS/iP6A5DS6zDtudVRUR4=;
        b=NDdDDCh89DuEScQNBcrh9KD+RFUcylmrJ3rjDtBHmHQP77BsCb9gokwdUjfRhk8Aig
         kY1GmaGj632rUXrm3CinY1xEVayJ8ejpYazjXQe3s9aN7EcTF/0vvocfPgWzvcP3ydkX
         vuIJ7Bamk1W3eGEgn9rTUpo3k22L5qj03NGtAmO19BRvUjfu6F87UYvSTdqNRXlvliy9
         BQTQCaxWF4Pgh7dJuJnuFM0fKeRS9XyEs8xO/7aOgPa1fbp/RNmvxKrkhmHHo1/lWRxj
         T8NwBL7ZfjWGzAopj/ZfnF9YCVN9V42iTiC5DJoglmcl4zv21cDMBkVqjB5v3LeBQfT9
         lsOQ==
X-Gm-Message-State: AOJu0Yw/XcLxHVHtj43hMEIvoRaorHRAjXgusX4WYsYM94BkRIZtvEMg
	VlZ6FVyxKZPxrbjP3L+ggrgLxl4DR0pvqXgwLpo3rIPKYgJXctGqnNGH
X-Gm-Gg: AY/fxX6Y/v4LbuyJItyj87U4HZ3/UECjLESffO+Yxdgh0QHwm0SWVGm7hR2EtariWcE
	FyECqqv9Yue/O6PexSdmkNoUq5GBi43wfIoIOXTlF1zD62UK67NiOIQCY/XCO73v7l/+fjIW6V7
	UES1dYg/VJufU6mMab/tETOK7jDvBWGkwMVIXx8AeHZW6Y/G0j1OHhU2i7OqQ+c+H8r4IO/TNYW
	yP7wNlxs/CmqxnGzgqFZ+7yN9m3AqACn423ijVkxmkaeZYFmA/Pn26zEkV38O4fdG0+a/GykUmQ
	CNvUaFUl+tDwZwZAC0m8R90qjzO5nHir/D4DsYgMm7AkKkKC0pFVeO46IhUR6ehh9K0rR4E31Lo
	LS2wJIMKV0Mwg3DeCLQku05kF4U49/hq/fQThBYTx1qBL5U0bXYRmAL86q2zmaXujOooT7akUGf
	IMSL7eOHqhfnSJaoNRgJs4X80nv4FVbgvHfEVFPEssSk//1PJagKQyjI/3uQAv7VqXWL/qhywQw
	pxGBQTrqYQATuWBuCbzFZ92tz6dEqpGdg==
X-Received: by 2002:a05:620a:1729:b0:8b1:adfd:f850 with SMTP id af79cd13be357-8c6a68bb3d3mr1047630885a.18.1768703969755;
        Sat, 17 Jan 2026 18:39:29 -0800 (PST)
Received: from ?IPV6:2605:a601:8119:700:1eb:9803:eb2f:8b98? ([2605:a601:8119:700:1eb:9803:eb2f:8b98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6027c9sm59609196d6.13.2026.01.17.18.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 18:39:28 -0800 (PST)
Message-ID: <9394755a-18db-4efd-b7c8-ce38eab57f04@gmail.com>
Date: Sat, 17 Jan 2026 21:39:27 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse-checkout: optimize string_list construction
To: Jeff King <peff@peff.net>, amisha <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
 <20260114213551.GC1010080@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260114213551.GC1010080@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 4:35 PM, Jeff King wrote:
> On Thu, Jan 15, 2026 at 12:58:03AM +0530, amisha wrote:
> 
>> Improve O(n^2) complexity to O(n log n) while building a sorted 'string_list' by constructing it unsorted and sorting it afterwards.
...
>>   		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
>>   			/* pe->pattern starts with "/", skip it */
>> -			string_list_insert(&sl, pe->pattern + 1);
>> +			string_list_append(&sl, pe->pattern + 1);
>>   		}
>>   
>>   		string_list_sort(&sl);
> 
> Since we already sort here, I was quite curious how this came about.  It
> looks like the _insert() call and the _sort() were both added together
> in de11951b03 (sparse-checkout: list directories in cone mode,
> 2019-12-30).
> 
> I'd guess it was just a typo/brain-o to mix up append and insert.

This is exactly the case.

> Doesn't the same issue exist in write_cone_to_file(), too (in two
> separate spots)?

It would make sense that such a pattern could reappear in other areas
in this file. I see that you have caught a few more in v3.

Thanks,
-Stolee
