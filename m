Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEE47AF5E
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231304; cv=none; b=Txh3xMtf/H+ez8Coilmi79bchGSKe+ST3zsDxJk+Zz7hn+5SMZtl0T6vVY32ERDWu9sdKoGseKyjpMyB2Avz5fjwHqax1IvYUN0OMQLgEIwwHnynNhuIjYeoiY1LwH1xHWsWmqX/fBuVDcQz+JhjL8HWsKHJnJnOs7kEYuWFqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231304; c=relaxed/simple;
	bh=xwQh5wnoxyoQPHE1+IQ7t1BvKKlqcA2k2kDR+HqlRws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxzrYU8Jl+Mgv5wa3pYE/a2v8JF5gwU+KAJ2I5wIKrM8/6QZYKxsjwgm7LqhTuFhucrltQoZ4eO1jMFD7lGl/d69gvme0k0cStzzv6caoe81DX/ZyeXPe83pw/lm+vPbyU6X8H9T+U7iec5dnhP9SW03929AADUs1vPmooF5oeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDfGZGCM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDfGZGCM"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-896f8feee14so33437346d6.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 14:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772231302; x=1772836102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrYC2MeKVw5rNcfF5632JkWuAOqX1ZPzNCUkGnwDDHw=;
        b=nDfGZGCMdvss5y+5lVmn8WciLj3fiv5EytfE/bBMoewt4J2eXICXcFvLW8i++Cfm+H
         5QO0cirTc+rdAZri8m/7Hgmcx3IOjCRxggmgj9kdYWNbzlK/qz1BwDRPkzalZUK9pbje
         djVbJWgnCUO+2Sz+4XgIjtSXupOz+WGel51q5Q7f3osBDOGF3OtATTb40OM4hTd3q4jQ
         rC4vqgwpqKWwQNxvICEuPrbuvQiGb7IDdDGD4wvEV7GNv/ZvsKMi8CfnU8D/YE8Qv8pC
         nmOmisP4vPaM/QO92MqJJ+GcUa25ibZM9ezeezLc1yH0N7MNbtHzq/YCMKacn4tUHjT2
         P+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231302; x=1772836102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrYC2MeKVw5rNcfF5632JkWuAOqX1ZPzNCUkGnwDDHw=;
        b=NqXh9fxfI5TD91Pie04TwfZkTNGkMDGfbK/2hqTCaSFZR3/mS2KvmkWSSdVwuPFE4Y
         fY2uGMbEBjvhJZC5ea6xCDggsCXRiMLzLLXstltXr7FTloVYXL4EAbHrZL0tKN4yY1Es
         EjO9tPaLSSw8fu+THUSW3zBx1Qnfg7bqaEfCDMVvzdRi5bp/2gNGeTq+osVIYLvbRDxD
         VquL9FlSBRCB2a0T66qwNciijNwsPgKNnUOi+jJjjlQQoFDueG5ZFxITuaYMimLKDA9U
         mht6vgO7BVnU1A/8dV2AIO3vVIm8W9RNcSDnYvRddzeIDJEk+W6F+/hJN6yUr3GYDvSb
         tWxA==
X-Forwarded-Encrypted: i=1; AJvYcCVpxYXS2g5Tl1mdFmWH7u/XIuw8GAoNRn/V+ZoWgGxCZowrYLwzg9mWufVZgHPjqAms/Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrPGchDKsBvBBvLfoGbineVvE0OZMMJft1kgD8UsBioosiIft
	IJPFCazUOwKl74v6jXj1MUkXMwFN4fD+zFvk043HXG6KerRrzZNkOykK
X-Gm-Gg: ATEYQzzK+fBST65jEWD3eh09EkW6+85rX8HowgxVIRQZn+W0vhmlwl9nQCC2wrUYAwV
	l+hpFepb/QO7usYY5peGi1z7dg/Bhj277xN8e+Ku52woOoBWY8UJPCyauNYjyI54yNxvEOtCYIB
	XIiWVhs726++kuQqTj/nwC9AdUPzL9Mhs9IUfWdQSwW7uIJlHdZ5cDfth1Ij9y5c1vzrl+ODasP
	NEOHqOnqq/2IE6l1kSHIhFqpeKJYeT0bupPi/SHAcTlVMspeg9JP/A6JP2YSkxqyCeZgE0xiMpa
	FE03J/wRuM/QyEKWVjX9PsxrFirOefRUkH4a2IlaDcyRCvWFHvifmY3Db0bpqCMw4jAY4Zj+6qZ
	ezD6yygp41zgmn5x28jKVJmifQbUyUiaxUqOKqGWhT/+yeok/iw8ehgfcbL3JoS364UYtO3A29B
	ywDljNPPv/h45sqzhfYDfdc9LXB9M3o/eGCGv8taCVd23dHbgyEZyeG0Dr4ffl3Lsn8gxLEa8tD
	rXJ2zATpDlLUj9aU77YsQUOJv6l7ombTKSzYHlNarcjGTNxqlw=
X-Received: by 2002:ac8:5ac3:0:b0:4f4:c080:15e5 with SMTP id d75a77b69052e-507526ba3f9mr55634931cf.1.1772231301898;
        Fri, 27 Feb 2026 14:28:21 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:98d6:9ab5:3ba7:b962? ([2605:a601:a6b4:9c00:98d6:9ab5:3ba7:b962])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c73a320dsm52825116d6.52.2026.02.27.14.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:28:21 -0800 (PST)
Message-ID: <3d574b51-78e2-4850-81dc-5c55b9562c02@gmail.com>
Date: Fri, 27 Feb 2026 17:28:20 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Jeff King <peff@peff.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, fastcat@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
 <xmqqv7flervq.fsf@gitster.g> <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
 <20260225131344.GA2139176@coredump.intra.peff.net>
 <08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com> <xmqqsean4gsc.fsf@gitster.g>
 <1ee5927a-c90d-4a4b-a468-5be3644481bc@gmail.com> <xmqqqzq6otx7.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqqzq6otx7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/26 2:41 PM, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>> 		 * Note that the following options are not in local_repo_env:
>>>> 		 * - EXEC_PATH_ENVIRONMENT persists --exec-path option.
>>>> 		 */
>>>> 		if (strncmp(local_repo_env[i], "CONFIG_", 7) &&
>>>
>>> Minor nit: !starts_with() lets you avoid counting bytes yourself and
>>> hardcoding "7" here.
>>
>> More seriously it should be looking for strings starting with
>> "GIT_CONFIG_", not the name of the preprocessor definitions.
> 
> Thanks.  I missed that completely.

Same! And I will try to find a way to test these things to ensure
these mistakes are not prevented only by careful code reviewers!

Thanks,
-Stolee

