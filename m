Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51741DD0EF
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840810; cv=none; b=EP+KBWmxHuuvaZoP5467hgBVSHTaoG06LXu70Ar9EviyoFhhw4cCN2tALnlen2S2nwKsJqW1ZmZgWyq5AgSUtHDh1y+HX8FtieLY3H2Kh52F/4E25uNVBbleoo1U9NALjdm/VpwZmqp6Oo1yQE1G7ocWqfZmAHGc1v48JI0eQ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840810; c=relaxed/simple;
	bh=Ti+DglXn2Jmq4ssccjxLMtn53YKgdVmGbWGVA9Vy/7E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ObzjvFMK9oe3tLxuDmXYFmpazM6t1Vn2G/Gfsif2xPfPDQpFk2Dz25rOCXjz/r/s+G4Hbp3dUMvfBXWu/hqR5oIqAGb1GxgCMByYvXFN5/TgOmq1TEyg7EoUsNhmSCS3XzNqY5XHgHI/jq8h5BJvwOjyS9gIVgh9JBcuFjiS7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ma8556IN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma8556IN"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a37a243388so1902380f8f.1
        for <git@vger.kernel.org>; Wed, 21 May 2025 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747840807; x=1748445607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7C0R7+0NH2EUHxXHiLLl79rh84HGAnn74iSZ4fXg5do=;
        b=ma8556INzGh9wFGUMgguY0+/xmPDJpVKKajuz5O4rD7E5Z4bvP7Angh3+Yn2w164NS
         TWl7yjTqCI+L1GY1BkPQEkzFkCRph7niDAeVIHmT0NGkTCLRqkBExtR/1oo4w0kUZs7P
         1D/WowEdqhzvlI8xJuM7abbT+MTwOX3UX4mU/sqoWtIrVXgxVEpb1ZZ0KpMrCD3HMO5A
         2k8/A9sWKEp5a9xo7Ur+zZVbxRV1ds/3My46mUAHQv3SoucTJAFmLYgSO+8TknjRtxBa
         xw37J2LXPloCa6KR5HIU6WLhamfkAZSVzvsRaGNF3uOPj5cyN9WTWMESQeRx57DabJ1Z
         lvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747840807; x=1748445607;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C0R7+0NH2EUHxXHiLLl79rh84HGAnn74iSZ4fXg5do=;
        b=k0MjG2HokBEvAdN86a//M1Kd/WwT8ULnE101tKmb4qeY9nyhXGw+SCTc/F/dWgmGOo
         SahzWaHFVYGz7/DfSJjeTCYOTMfdpN/iCSY6fFnjBhDVVHHV89meECkkObAW7CW1i+ns
         L3RR8bbjdoeILFd5br+3cD1tvHYdKeKQr54/aRgmPAPaRy7PEjRP5/tWQn41wTl6V8Bj
         M+HIP5Oe98sYPvKhT6Eso7Bbnsm3uvbrp8GBa/AI0lrNluU6M1uzHkOiratZb7aK9Iqr
         TcDhcO5pyT304/2s/ukUV7BJ9N3G6ucdLyHmj4oJBKk+VXI5SbdbZBREcQ5o6uywnqXt
         WebQ==
X-Gm-Message-State: AOJu0YyeE36KNps9CNZcHK3VGzZiiqyVInWdS2bp6MoweNagMAjras9p
	v6y80LgF1vXQ5S5KEuVXA8qYlF90gOyWyQhGyYT12x0/93GbcyZw4/WH
X-Gm-Gg: ASbGnct2ZVFD7sVBpbf+zz5lRryImWucyrP/EIrk53nZjJpTRCRkZQiP2rkI5yRmqY3
	6DrVKM+MfMxmPG2I8/4MHYjS2bOORZtxPNt+smCGn6JF6A6XZ2PcZrFPY3GmHBHaWo9dCbQqjIP
	iZ4NxRkNTfDoZwywQaIg5Q02pFJHnzZUIqezoJTZEn9FGrYZUkKG/pTaOg7Ntk2eVft3j0LdF7r
	KXDlDJAf4HzACz73/B9DC66clLKDiDRNhRMTrsBdQP7SvNRfDCSZMT6mP4c0HW7PqE3bjPA9Tq4
	WqlBuA9pre1I5hy9IfbS+x9zcKYpNZORdyMuGZeV+MriwiMg92eqPJ1fXdZbJuN7OFoi0mw4Pkl
	m3B9Xw7E3uYOKOAHQ3zzYHMGvZ4k=
X-Google-Smtp-Source: AGHT+IFkLdFLEoiIFawgQSQ5nAxCj81vqYxn+HxM/Z7sxunPR1kOh+hMHO2/BYTQQ/8dNrfjMqD3kA==
X-Received: by 2002:a05:6000:2484:b0:3a3:7115:5e7a with SMTP id ffacd0b85a97d-3a371155f61mr9690373f8f.42.1747840806827;
        Wed, 21 May 2025 08:20:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1fasm2239397f8f.1.2025.05.21.08.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:20:06 -0700 (PDT)
Message-ID: <a87e6f8f-e6b3-4d91-8b0a-312962819eb4@gmail.com>
Date: Wed, 21 May 2025 16:19:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] midx repack: avoid integer overflow on 32 bit systems
To: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <cbc5e69b908cef3800569abe79cb9c107f72bfec.1747753388.git.phillip.wood@dunelm.org.uk>
 <aCzBvvZDS2OFJ30h@nand.local>
Content-Language: en-US
In-Reply-To: <aCzBvvZDS2OFJ30h@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Taylor

On 20/05/2025 18:54, Taylor Blau wrote:
> On Tue, May 20, 2025 at 04:04:24PM +0100, Phillip Wood wrote:
>> diff --git a/midx-write.c b/midx-write.c
>> index dd3b3070e55..c7cb2315431 100644
>> --- a/midx-write.c
>> +++ b/midx-write.c
>> @@ -1699,19 +1699,23 @@ static void fill_included_packs_batch(struct repository *r,
>>   	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
>>   		int pack_int_id = pack_info[i].pack_int_id;
>>   		struct packed_git *p = m->packs[pack_int_id];
>> -		size_t expected_size;
>> +		uint64_t expected_size;
>>
>>   		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
>>   			continue;
>>
>> -		expected_size = st_mult(p->pack_size,
>> -					pack_info[i].referenced_objects);
>> +		expected_size = uint64_mult(p->pack_size,
>> +					    pack_info[i].referenced_objects);
> 
> Makes sense.
> 
>>   		expected_size /= p->num_objects;
>>
>>   		if (expected_size >= batch_size)
>>   			continue;
>>
>> -		total_size += expected_size;
>> +		if (unsigned_add_overflows (total_size, (size_t)expected_size))
>> +			total_size = SIZE_MAX;
>> +		else
>> +			total_size += expected_size;
>> +
> 
> But this part I am not totally following. Here we have 'total_size'
> declared as a size_t, and 'expected_size' as a uint64_t, and (on 32-bit
> systems) down-cast to a 32-bit unsigned value.
> 
> So if 'expected_size' is larger than SIZE_MAX, we should set
> 'total_size' to SIZE_MAX. But that may not happen, say if
> 'expected_size' is (2^32-1<<32). Should total_size also be declared as a
> uint64_t here?

By this point we know that expected_size < SIZE_MAX due to the test in 
the context lines above this change. batch_size is declared as size_t 
and to get here expected_size < batch_size. I'll add a sentence to the 
commit message to make that clearer.

> I wondered if it might be easier to count down from the given batch_size
> instead of adding up to it (requiring the second
> unsigned_add_overflows() check). I tried it out and got this instead:

I think you're right that we if we counted down we'd need one less 
comparison but I'm not sure if it is worth the churn. In the diff below

     factor = pack_info[i].referenced_objects / p->num_objects;

can only ever be zero or one as factor is declared as uint64_t so I 
don't think it works as-is. If you're happy with the shifted-integer 
approach in the next patch I'd rather just stick with that.

Thanks

Phillip

> --- 8< ---
> diff --git a/midx-write.c b/midx-write.c
> index 48a4dc5e94..f81dd9ff6d 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1671,7 +1671,7 @@ static void fill_included_packs_batch(struct repository *r,
>   				      size_t batch_size)
>   {
>   	uint32_t i;
> -	size_t total_size;
> +	uint64_t remaining = batch_size;
>   	struct repack_info *pack_info;
>   	int pack_kept_objects = 0;
> 
> @@ -1695,23 +1695,23 @@ static void fill_included_packs_batch(struct repository *r,
> 
>   	QSORT(pack_info, m->num_packs, compare_by_mtime);
> 
> -	total_size = 0;
> -	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
> +	for (i = 0; i < m->num_packs; i++) {
>   		int pack_int_id = pack_info[i].pack_int_id;
>   		struct packed_git *p = m->packs[pack_int_id];
> -		size_t expected_size;
> +		uint64_t expected_size, factor;
> 
>   		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
>   			continue;
> 
> -		expected_size = st_mult(p->pack_size,
> -					pack_info[i].referenced_objects);
> -		expected_size /= p->num_objects;
> +		factor = pack_info[i].referenced_objects / p->num_objects;
> +		if (p->pack_size > UINT64_MAX / factor)
> +			die(...);
> 
> -		if (expected_size >= batch_size)
> -			continue;
> +		expected_size = p->pack_size * factor;
> +		if (expected_size > remaining)
> +			break;
> 
> -		total_size += expected_size;
> +		remaining -= expected_size;
>   		include_pack[pack_int_id] = 1;
>   	}
> --- >8 ---
> 
> That reduces the two overflow checks down to one, and avoids the need to
> introduce a uint64_t-specific variant of the st_add() function.
> 
> Thanks,
> Taylor
