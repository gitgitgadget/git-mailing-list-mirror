Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753321C2AA
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774796245; cv=none; b=MVYcwLD+m7zrd1kLK0zKZaTF76bkLi2TzIrPJbRLf/kfhKbiVebHybv8Ec+9YQUfPqUoIXUZo9Gc6ecokJYphhxZXCpIb8C//aX9i4AEZm5eMIoLp2p7zs9v5ZDJSH9NUMk7YEbpd0h2I5Y+WX1GOq0OqTxdKsrQXILTyI9paCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774796245; c=relaxed/simple;
	bh=EyZJcp9ud8jJG42Qqdz5xP8IbtBRJdAY5HEfUvaq4S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNTlQeCscS0xEk0vITsdU8ql6THbSfubGSL0QJQcYJEgIToJ7RGwl0Ar3le8YYoRvVcVnajHmdAdIp66J759tyEvq3IsxpVUCfeiLaSbMXusGron8DD0z7V+KeAZ+eul1lLkAxKQLHrXIqY++zZRpKXVAeZ5UCNt0zelBGxoEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxQcAHR6; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxQcAHR6"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5062fc5d86aso34819751cf.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774796243; x=1775401043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYwEg2CAej9cmeWiE8fpg9jPFE2UaOPWImpWSe/gRMI=;
        b=dxQcAHR6XFHyvJI/26JnplpfV4ANZYtA1/DBoPFXBnu9uph7LEs6KebIqOEJ+TIjG4
         UcSPbIsi5cDSHTvdv0Qeg3jJpzmqaRp5DYC1XoouL/y6l12pi9fuvbbLjyrE/eKGRWeq
         9ccfxbh+3jHuIA/hkwAIB83SLfXKSqSYiWti610Pe0vTgujZrQsYUPGOkQunXnMCNTe3
         2zpqanB1RsgeVJgPRcICwwoxfa6BxVtvf8ixjPklCVDhgeBwolriTsBPkBAfcWES6KdW
         1Pe8pNZeQOz4DKQrODCf0rRR5DH1Ms52nVa9ExhjgWIGGEBqONpMPIJM/SiG/keDcm1r
         VZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774796243; x=1775401043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYwEg2CAej9cmeWiE8fpg9jPFE2UaOPWImpWSe/gRMI=;
        b=K3Rm5d5uSBY26b8fKE93r9lXPhduheQK5c3vSrYEBv7cg2MJShUrkgg24sAvGQzUmk
         ary8m90EWdC77EmNqeM5LZD2y6agpgTqDEisNTeX2tiefNKlnsb3RyzaLUlvLU5Shg0x
         7BV90bfVF7Td8Do0e2iNChDPR+VLEFtT50yD6r4THmDxhekDoiSE0ENVqLJwK6RP5R7r
         +j7NmTqJfS4+nDJbLrB6pa0HSlwrltqT20loaJ1sALZT63fe6eN7JzVeF7SA6GzYw6Rd
         kK36aC1WG9UQrGJZy/6AwgvVH6NbpoBhg27X1gLxvN7NeU9Po5HhrSwEe+2LlblzIgwa
         UDpQ==
X-Gm-Message-State: AOJu0YyMMs11RNE8cDvTClv4kuErPXsyfrj964/ceqcZ3CycUBgDz+s6
	ehfxsaZvivhMJoy1K4DaV8idQtY48m97nRdEubd+TOF2YweeoSRjKGMu
X-Gm-Gg: ATEYQzwCkCIq7CKi7pqXnnRRgvDtgNCyO62wQUA+hCR/IDkkHBPZFM9rXu5bTLHvYlB
	aeqoJg/kNrGRScvYANkh97N6dB+GbA8WFy93KCf9oFvxj+DkgpXysSdqN/DJwp5pUAEqYVWuon7
	XQiiNJ06JY3O2jHl/VmztSBEnJ1Rc67uQ2HSBalKkjYU596iRWCBuloSPjHNySYFaQ/8L39z1VV
	uUzvXzebDwRiVnhFvE17Tv8nGd6UVrcbZwYiLTM5lpUBkAM/z3KEOZouUCtk6xN8DykgPpZqq4u
	/vfr4X1hQakvQqMW74qJA9JyL4r6W9blr8BQ0T2JPJ83ZHI37RjIiWIh4VU+auLThujToj9C2WY
	8J7myDoZ2IZoLT61xyzBNfsIY+Vj69FRRThbA7gkOAI6RWCR/vU4XlVD5UvEEz1EN8nLiDfWE+e
	VVquq/FQRak7/JoKTM7rcIeQa5sfBHm1EXQdqS1wUGRt3oB+6VaG6eVB8xHxDgGWzxsGMkOsL9j
	G+KSBXs
X-Received: by 2002:a05:622a:488:b0:50b:764c:b121 with SMTP id d75a77b69052e-50ba3919349mr121379601cf.57.1774796243427;
        Sun, 29 Mar 2026 07:57:23 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2dd8d8esm41991821cf.14.2026.03.29.07.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 07:57:22 -0700 (PDT)
Message-ID: <d1afbb2c-84d2-45da-ade5-c86397bd24de@gmail.com>
Date: Sun, 29 Mar 2026 10:57:21 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] read-cache: use istate->repo for trace2 logging
To: Junio C Hamano <gitster@pobox.com>,
 Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
 Justin Tobler <jltobler@gmail.com>, Ayush Chandekar
 <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>,
 Jayesh Daga <jayeshdaga99@gmail.com>
References: <pull.2253.git.git.1774606086325.gitgitgadget@gmail.com>
 <pull.2253.v2.git.git.1774682046750.gitgitgadget@gmail.com>
 <xmqqy0jbhkch.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqy0jbhkch.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/2026 2:36 PM, Junio C Hamano wrote:
> "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> -	/*
>> -	 * TODO trace2: replace "the_repository" with the actual repo instance
>> -	 * that is associated with the given "istate".
>> -	 */
>> -	trace2_data_intmax("index", the_repository, "read/version",
>> +	r=istate->repo;
> 
> Have SP on both sides of an assignment operator '=', i.e.
> 
> 	r = istate->repo;
> 
>> +	if (!r)
>> +	    BUG("istate->repo is NULL in do_read_index");
>> +	trace2_data_intmax("index", r, "read/version",
>>  			   istate->version);
>> -	trace2_data_intmax("index", the_repository, "read/cache_nr",
>> +	trace2_data_intmax("index", r, "read/cache_nr",
>>  			   istate->cache_nr);
> 
> Or you can do without an intermediate variable 'r'.  Replacing
> "the_repository" with "istate->repo" would make the resulting line
> shorter already, and more importantly, readers do not have to
> remember that 'r' is an alias for 'istate->repo' while reading the
> code.

And I don't think we need these BUG() statements, so I'm sorry if
that was inferred from my statement. This kind of bug isn't
something that a developer will stumble upon by accidentally
calling the method incorrectly, but instead would be a substantial
break of the index_state structure. A segfault would be enough to
catch this in testing.

Have you thought about applying this pattern to the rest of the
trace2 statements in this file? Or did you want review to solidify
on this section first?

Thanks,
-Stolee

