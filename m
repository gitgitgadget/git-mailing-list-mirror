Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBD1D9688
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149455; cv=none; b=QGWrF6lRBS+niyKbsLN2VmGpBxtGeKwiJ4mF0luHoQDiA4B1VTkXMpJU0h4ZOVf9fvWg+uw9zKM+Qg8L5FZkqec7T9GTI2DUxGjrOhRCZF5qrdvpfzoX+e9y0odbz9Uxs7X10VMLUQAVDW/KEUPWb1JKivXBt+UmQke0aGNNU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149455; c=relaxed/simple;
	bh=CBJ5eWBERrpt8rM0sLTGdr+kL3yGnGgV6UHednkvZEU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=damam5egEMyAMURjFpKD2HCBCenw24or+RO8+OIYsaM3MeQgXkrQmx4e+vtMYSvvBiIenYqcONgmYF38ZCNnxT7Hy9+/Ai4aVp0q2PH2o0SdX/exW8ysPTunFAkWsLaXsnwJrQ7uzg4XXRHwxST6n3dJADhWSlt//ZmLSnYv6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdjrgrVI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdjrgrVI"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so3094737a12.1
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149452; x=1740754252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSi96ct+rc7BrATXJV/uP214bhYegeh0FsQhASxGpoE=;
        b=JdjrgrVIpyG8bhuDzJAlm3Zbe0HmQH6/9DYj7u0E0Wqj2pY/bws1GIGohVAXNtmfpb
         TK+EeC2Shm2Q2S7nPaFJsWZUG6smXyseqWEY7etmVwAr1yivz1fIlL70uD0EsH5ajIAK
         N0s4/LcBp07uLwEEHYn0dipNj2sYlZUf6vkz8axQIBlnWbbl6tnMUWCX3EAHOUfeVPwo
         KyOSEcoxoxEwijJlnONspOZ63MPfhvEyEXDcwQlbwAaKczRP4k8ca5oyNkrdfws7ED2F
         uc8Y9VIaIit2VluFaYcfNG6zfcyYPJU3R6oFI2IPIoEWRe/dXhmdiKFAVpxoGjEJls5O
         cUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149452; x=1740754252;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSi96ct+rc7BrATXJV/uP214bhYegeh0FsQhASxGpoE=;
        b=q3rCNmWAXkfjG4S43ZC3dMz9dutDKNORrEqjMPCdFDMX4jHIYdZjbatWVMYNoN1knh
         4kTvNWp54fB1vT3+oUU8pd3wDSe2JunaFn2CozEeUJLxPfD7Imn/+/tn7CptzEmwYRBu
         yhAwe7EK+Vo/Mt88yteqFJhMfGNOK5tSNXyDIbb7jrvpgplGCIwTFSuQnP8qOxrSr19t
         E9ljmNu+aWc9GtV96nvHZquq9nqJPpkscXAyUsEQDa7sLM+90oF2V5udmUif4PYILGoa
         A/dL6wisnhstyBNfWx9cxxDuM9as1sV00I55M23b5J6E0vz5eR93wKfiGOBoIXmXeCUN
         0l4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGNIQUoEV0FaIRgghqqntAFHza74i8TbYVALaCON9Stet+oTCr8iD3CejQdmRB7L1lIAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzj50gUSH9z4ZNspLyLmiMKkZGb1017BRbWxShH59Zu2KmHpkB
	RCNlbHt1XdOJG+jR8UK/TDZRGQwEl6t7UcnKyP7iDsPszghm2wbi
X-Gm-Gg: ASbGncsqwQBp0sqWeM88VAz2sfiVzwXXYbxB4NTFy1x4BmB1QBLcivz4mhpSmXJYPGx
	Elx682lK0pv/MT5XQQH5+Ep8M+/5EDiojKTRqx70mOItZ+r2yCf1Kfv3WEk86qYNiRbb5ZPny1f
	5l6EQxFbOgbm6VZheHfk0HBjsgFYus37Ssp4pJxlPIOfZiahxOiEU4SGdDg4HRW4a5ubdcPC9um
	iG8X/paYcrJx6PvMfoSTF9qptbgmabAM214ZRnpg6LmPuSsYZ6d1/pq54G3ChZAPa4101PsNIPX
	63J9aDP6FzNhHKDDraAGhhSgs/rTEYNJuQz+UG7ze2Hr5z6n6/0b5bVjK708HGcCjMvLv2+Cacj
	M2IXG
X-Google-Smtp-Source: AGHT+IHoCKLEwWQM9hHxWyjM9AoT0peDJ5slTfENMPgtBzAO10N3nRgj5syh32wgdz+acYB1pcN1Ng==
X-Received: by 2002:a05:6402:430a:b0:5e0:8c55:50d with SMTP id 4fb4d7f45d1cf-5e0b7107111mr7009848a12.14.1740149452317;
        Fri, 21 Feb 2025 06:50:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8209a2cbsm1190418666b.133.2025.02.21.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 06:50:52 -0800 (PST)
Message-ID: <cf6c2567-2aae-4539-bc39-0cb9efd310cc@gmail.com>
Date: Fri, 21 Feb 2025 14:50:51 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] t/unit-tests: implement oid helper functions in
 unit-tests.{c,h}
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250220082959.10854-2-kuforiji98@gmail.com>
Content-Language: en-US
In-Reply-To: <20250220082959.10854-2-kuforiji98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Seyi

On 20/02/2025 08:29, Seyi Kuforiji wrote:

> +static void cl_parse_oid(const char *hex, struct object_id *oid,
> +				       const struct git_hash_algo *algop)
> +{
> +	int ret;
> +	size_t sz = strlen(hex);
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	cl_assert(sz <= algop->hexsz);
> +
> +	strbuf_add(&buf, hex, sz);
> +	strbuf_addchars(&buf, '0', algop->hexsz - sz);
> +
> +	ret = get_oid_hex_algop(buf.buf, oid, algop);
> +	cl_assert_equal_i(ret, 0);

These last two lines would be better written as

	cl_assert_equal_i(get_oid_hex_algop(buf.buf, oid, algop), 0);

So that if it fails the message shows which function was being called

Best Wishes

Phillip

