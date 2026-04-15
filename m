Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589231B80E
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245685; cv=none; b=HFAL+B1l2h9NmFO4SSrL+N6HcYYHj6nF+TvrjIIlWRI9TloNClnFB/lKYGe+bLkQP5o3NgGZQlJZvNzIkAB4EGvEvAu9JDmuZGbJ2uNzAiEpKI9VqnQnX5EuAeIC1J2TJ0VEynOgvYS9dlhrrdo9m4XNCF0GexiRPVvSAR1iKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245685; c=relaxed/simple;
	bh=0hyC9Vhot5aZgNwLPYitfiRfiayt3GiXFu2tukMvfcA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BN61BKTWAPQIF/ipcLGxU+4gdGVXT0TDeO9dG3yx9U9gNnJR1ujrFIWc4zPIYgwOUrMiA1qErdSv+8GkNFtDOHL9m+hs+RqJWl7t5vWSWhDSalvOgVxe/uDzz2JqMKpaQI9qohhhoN8jJ4i+qkxlFrq3FyPF9JPTQXo11A458I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkRpxqvI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkRpxqvI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4888375f735so64739665e9.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 02:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776245683; x=1776850483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mF9d+KVqV8bp7pLABiIKWZG1WtbNYftxoeF/V3eDfTI=;
        b=VkRpxqvI4LsiZAcA1Mc8yubobq8BHowyYsRtzJllfhLkRe9Pd9uO3maFS+14gulqRd
         GBTT8AvnWncNEmrePRMi1qVnVXTKqJwUaAe6iaNEZMTGwRK+m+ad4zmTBEMkZ0cNexa1
         +xzjZLpjJ2ZTHHYDgUNxvlXPDS4PaJ34jSUBfySAf6htoyvjw6ZdfMUS552WYtOiHQv7
         Xsl53wsCxJ/HWp9XyTokPE67LcEwFme/ByNaQi7Qe+dSlS8Lqnvx6V+fjzjxUCey9GpZ
         mrZiGc2ZkzExmOky3vVFEiBy4oUG1EL/KBNMo0yXQOhaZgXMz4Ax5Csq7sBQ6opaBwwz
         8wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245683; x=1776850483;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mF9d+KVqV8bp7pLABiIKWZG1WtbNYftxoeF/V3eDfTI=;
        b=fCljSOYIJU4y359+ATSYOvpiDNSX1gZKnuSbPoW8f4i330i3KDbFGCoetScXem0q0O
         URm2XYTxQvGJovO3/2KKR3SwXJX3O5BRvGcsKM1rTkarbFJNjez5PJ1RiQ49sorKcAbw
         fl2oFtFNt/I2f+Li5fBfT9tm+w2/kDVSwwnIhieTBKf2/EUbMkzA7yy4PwhqaqTv5cyJ
         uXmd4uCYZ2NUkZAKnFT+cCt4ACR/PKoB7zetQgpXr8vVt5G6wAaDPefibXVJxNyBV285
         H5Ar5/+uhV9ozj/FYhn5aks+75uv7qENJrbRNpAD+rCpuAJ7N2n5/y9dczjaSVu6hsq1
         k8bA==
X-Forwarded-Encrypted: i=1; AFNElJ9lV6kVtfMlSQ9ibiKGSbPc8a6lOLGZ734JTFdI4T4Jqfa/FIrt5uKTftqZqpuFwJqpKAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHVbP/syPok6tMlAtluw++Y2k1WSrgmVbiMuBd2iFTpHp4+Nm
	ligWVQDhJZZzFuxDf5zacSNCdbxvb7MVxjNEyq+Mo21Bfrotz7XA4k7r
X-Gm-Gg: AeBDiesV9BNdjJlha28MQfyRdggkeK3xsqNMXJzMSjARxLoU1AaGNEmr2WtYQ8xIfzS
	qW2QXvH0plTDORq/LiAGc+TVBeLNKx6P2j7JOvkxrWkCQUK0oAP/3Fb4tf+XraW5ssFoAZlICAz
	BAXe7zrGhkzj7rqjVgxWD3AH9r3+dqyBhYpf5+lMs3O/KJeltD+f73HHrcnsuUQcHcQj/WZLx74
	oVC36Zf7JfRN8ARdqd/BIGU98OnBLvIPHyWZ8fKRsn+bFlym3ZP5TgfwXcMgLC/3RR1QjUAM2AP
	xfSaB8XyfDvlSXIL+XC7K7GXCkB6ugbvgzjhB+N0hI0uKeGT06M5mQp2RAyCWvPJZTRTzEARziD
	FHMrUxM9k8sT3gg+aLlhcm2u9kYBDlLZfHo/ozVXTlOslr5tGg5Ldx0Ji62dNA01Dwr4rOF2adT
	RfeYekD5NyuNGdhE5LYbe1eWvAx1Voc1coMKa/zJjRb87/4BC7fy1Chgd7OJF+xznXHkefgegrn
	bSu+5BV53vosg==
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488d685b577mr242980625e9.21.1776245682775;
        Wed, 15 Apr 2026 02:34:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3e89ddsm3469246f8f.30.2026.04.15.02.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 02:34:42 -0700 (PDT)
Message-ID: <538fc297-d09c-43c1-8240-d1680fbec4cb@gmail.com>
Date: Wed, 15 Apr 2026 10:34:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 peff@peff.net, phillip.wood@dunelm.org.uk
References: <d5a47638-545b-44b3-9da5-803c06b3f98a@gmail.com>
 <20260414200827.51072-1-haraldnordgren@gmail.com>
Content-Language: en-US
In-Reply-To: <20260414200827.51072-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/04/2026 21:08, Harald Nordgren wrote:
>>> +test_expect_success 'apply with custom conflict labels' '
>>> +	git init conflict_labels &&
>>> +	(
>>
>> I'm still unclear why we're creating a new repository here. Our test
>> suite is slow enough already without each test spending time creating
>> its own repository. There doesn't seem to be anything here that requires
>> isolating the test in this way.
> 
> Yes, I want this too, but I had some problems to get it to work. Found a
> way now I think, but the cleanup is not 100% trivial (this is the only
> reason to run anything inside a new repo).

Normally the first test would setup some commits with test_commit() that 
creates a tag so you can just use "git reset --hard <tag>" to start your 
test from a known state. Unfortunately setup_stash() does not use 
test_commit() so there are no tags. It would be useful to fix that by 
adding a line that creates a tag so that future test authors do not face 
the same problem.

Thanks

Phillip

