Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858443C1094
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343983; cv=none; b=VyImVMzClu9w+prl8ygRh1PH/i5UizmzHWOyoR/U+uR8vafeS9zzyJ1ojLW44fJRU1D6r0zFlXUFCcTWjcjokv3PH8ZUVwbrVqIoo/SkDT2+fwXQFGPrW9O/RUb3EoQT5DfCJ7q5VHiCqaIrqlzTP+od7RQhA3AzARokDSVJejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343983; c=relaxed/simple;
	bh=gWsq956xsCgAaAk9nj7ZgRGmr1t31UIiKC5yhFXM/e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7XiJl4PawKemqDYzV6acgxH0/5tOS3q70Cq3Mf6oSPtG5JVBdZ7zdPxOzBBYK13NLZRjM8aG4/uhk7LRXmSUaMof2Ipk5oCuQMWsB84xcNzJW+KMvsmttgAmo9qkrZqwT9md6wp3nDys1ZxEzHDO/GlwWWWS0lcOGv/qoPdmiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebGk00QK; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebGk00QK"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ee1f9bso4064295ad.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790343982; x=1790948782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ERzC83gdPBwjgnJ3amHXp89m+SrHuWEgaiw3vICEI8=;
        b=ebGk00QKk3/RE7hgAQgSeH6aMPjKBg2Rh8rPMWS1YDQnC0qtYwiNg2ab8xIA85rxMa
         Bj8N7mCcLRfKexY/nN8lK3QCmFyfixUSJRNHAI/fITHy0q20Fk2rE6wc1JwUvx3ascex
         33klWF3nBhf8q/2M0zhR45PgyaZNH99IPpemGJA835T+aPZSHy1/kJFFgga15MA0gRqy
         Rt963EDZiP5SQGzvSuBL2ML5FEWxhzR75Ph5xYCdYHhIEOeLag5z8y/Tl1fM5yEXOS8G
         L+BnBW1naewAF5/NY7D8TCBIHzm59oZl7om1SqnVj5/Nl0TBru4+NdO6Vb38FD68tyBD
         lrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343982; x=1790948782;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ERzC83gdPBwjgnJ3amHXp89m+SrHuWEgaiw3vICEI8=;
        b=NTXASNMOBBedaLh+4zn6ezkQtY8wVrvz0UgE30GUJWyGWPT4BfNa/3YpW+PuExSnKT
         tSYVlR1dbqWxr7md1ijPcN0mRnHajxhXhQDYdAn+2GqZhukKZgKTR9m08D3L+w4JIJ4+
         ulodhsuqHZX+iRQrNh7Jo0Ry/xuCscOGKGUrcHqqLBas/lBRo1AywH7FZusTLtl+4J7f
         +TYSz64MLDDlmCNAUx1sbviF6TAP6QzphNDVlqdkgIDCGLzggadoExK/ahtHO7Pe485N
         8noyBtjDVm8YmFOu+giKwYAzzKS357SghjIPAI60sUnrlEcNZw9EyATklh7KjMHXEOF2
         MXhQ==
X-Gm-Message-State: AFuF++nb4qKTbzyIY4ombulXc1Ad2L/4a3WNiSZhGsomo/YjujtVPBUZ
	43gg1WxanUEEjHnQt2PogtSgoWS3EXgjKdsbY6Fgi4iWkJ0S0qBA5DIW
X-Gm-Gg: AYBFou2xiNeHkG25HTDXOCzgLLi6/CB7Gt2ZtsjkhrdsP7q37pZsE6fPGK8VdqtO24w
	9kMSy0hdOec20NkL5VEUy1q575RmPIjXwUgAcg0c6CEmzYQnIP/r+Np+4SWaARXFNOiPsAsRqhF
	MwI5UTunZfKiiCcMduQa4PssK5NoW62VI5HPjAoYM3LFy77GueGK22bpZ38X5sdWXfEUm77zqkj
	fN+RxVknGefRNhepB7qrAlypK/knD6txaK0jjrVN8GUHtjd6EiId6RYQhCZ+TjkFpl+NOJrq9vW
	kzprYUcPn7AIF0qWIJXrTpGeARoV/zD+89YK2aMJ2JXn/L6jiXYGD3tPCwR3UXx/Q8h0GNpJaDC
	rFgXf8m1Ys9OzpQ9NoDu+//X1oWvLLg/JoGJoLINUzPXiXJa4f8VvlD8fBXTKJFvBJVWpJ4rnGt
	SUw5P0UYV+kFQ0GAJPpdykjjzaLqBWGEc2Qjb+/1OHvoVE9pZ+fsHNjQNx0tGlL/3YYjiW5/teP
	HNp/KVFojPdxw==
X-Received: by 2002:a17:903:46c7:b0:2df:99ed:4ac7 with SMTP id d9443c01a7336-2df99ed4c7fmr8903405ad.39.1790343981864;
        Fri, 25 Sep 2026 06:46:21 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dfa1d4f93bsm723855ad.70.2026.09.25.06.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 06:46:21 -0700 (PDT)
Message-ID: <b024b447-4c63-494c-8ffc-f700fb3c7c46@gmail.com>
Date: Fri, 25 Sep 2026 19:16:18 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] t0009: add tests to cover more error reporting
 scenarios
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260924120502.2642141-2-kaartic.sivaraam@gmail.com>
 <xmqqjyoaz4ig.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqjyoaz4ig.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/26 03:38, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> Introduce few more tests to t0009 to cover error reporting scenarios
>> when --git-dir is used.
>>
>> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>> ---
>>   t/t0009-git-dir-validation.sh | 36 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
>> index 4cba478e50..244dc07c0e 100755
>> --- a/t/t0009-git-dir-validation.sh
>> +++ b/t/t0009-git-dir-validation.sh
>> @@ -74,4 +74,40 @@ test_expect_success 'setup: .git as an empty directory is ignored' '
>>   	)
>>   '
>>   
>> +test_expect_success 'setup: custom git directory with missing HEAD is rejected' '
>> +	test_when_finished "rm -rf parent/empty-dir" &&
>> +	mkdir -p parent/empty-dir &&
>> +	(
>> +		test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
>> +		test_grep "not a git repository" stderr
>> +	)
>> +'
> 
> Why subshell?
>

Good catch. It is unnecessary. An earlier iteration used to cd into 
parent/empty-dir. This is no longer the case. So, I'll avoid the 
sub-shell in this test.

-- 
Sivaraam

