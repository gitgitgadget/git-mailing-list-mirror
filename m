Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1536FBF0
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768704383; cv=none; b=rAQlDp7VovyWVkoZVbxeRfp8pFgD1mOUWswozJaJf91k6nPmBR9tN7Nc3Ugw7ffsaBfzoQegxaef6+MuUhgUBB2DOoqfBKgneaH0gDfWbrkqKQv87kSBhIe+xqOBNDwr922QkDXNAuRekDMKD8tpyYH8nZ9ciSdNFWNeOk05D5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768704383; c=relaxed/simple;
	bh=pYKkOFmAirvstYa6fpEG5Bm4i1tacbok91zLzYs7C9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5VVCmywFiTJeBqsUAdFNq73VtON8ynl4AbL79JexpODWUpaCeSn3woBeMUElR612/rzpWgmTFyijTmLjsSGsG5WpHUsrbGIfH4Utjua4BJMHOzGRH2+WW8h0UMknaKsHHBf79pBZBl03I4wdO75L9GmeD157k6NIKPIOmUGeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5Qb1iSQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Qb1iSQ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-502a98c66f7so14624081cf.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 18:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768704380; x=1769309180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8nUc8T5ZAM+zgv4qugzcKL3PfxvNiwG25s1CRcxOO0=;
        b=J5Qb1iSQ2rVOy6r80X0U+w2871rin/PAGN7DnqWTkfx96Cjxva0RpCNldU0T5K/EdN
         OjraKxCPAFezVCcXYA7P5c9wtTdeftkB6et01TN+TF3FAWBTj6jk53X3UQBvO84ZCMZB
         IUV7WhAKELmElQ17jmuF/SSgIxZTR62n5GKeK35UAMOA2l9iUxonDaHLfqT5XLHTvV3B
         cma0QMrVtWE6WNPfM+H1tpPDn/MHJN41uiHmKkYqKjVzfa/aLeQu6nbDrONuRcZq0MeX
         priz5H3f++tU7X71kaCXR/mLH8vCNXtohHbdei3iKtQ9IM43I3LihvTy3Bh2HAr8Ww97
         onew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768704380; x=1769309180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8nUc8T5ZAM+zgv4qugzcKL3PfxvNiwG25s1CRcxOO0=;
        b=IsGfDSZ9Q3mETXmHYlmxYaPyZpgIzkIRKzG9y4sGUHkrwOWSy3qnxDzS7V95LORRro
         AVtIZXCdu7UilM8OUbCJMjvoKT8eQJGHiKXt+xo+HnwGPWBr/jLBBCM3sjv61DTS7Bxq
         PtpM5t8YD1Pn8e7ckdMfRJ+sCaZ9L84c7HUr3Da8Rt65n0QdlraSON+666F8OTfMFa6G
         1cRN3Yy8WmlfEEVp/C53GNcbkscX5lYT9WI2qD64y7/zNCGTDICUSx+rq/GMDNURXUG5
         JaL6NQdUUoYzm562RS2V9vUZofGSUvdJXKswK7KLt7NKjKwCuo8l/+pz7IwBUjygpWQw
         NVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAdZ2Kl0YgtaVStePmpdNodLfTmO9YSiSNtfJm1NaYrBYxdJfI97mA00MuIIzKiV5zNiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHhFp5GbDHhml+2/f/F0Gy3IAZW6srcKRnLYGTai7j26osNN2
	Xi6W6i3/WLBsCKcdHcIWyo2qOx/BPPUgr29pSH/cU+cZg/qNj6xvj7UB
X-Gm-Gg: AY/fxX6LOsoQlFdhbXkvjT73zMi6SfWf1xHxgUpkqpeDvkyK3FIXWyvoy1fc/pLFolj
	ddXqYGCbMnDRbYd+cZwbppt/6N3hJjXGiheDDo4HKlVq9s7hNqclfRxSeUMIoDjwokbX2HQA8R6
	zx4nmoMsq4SfQ0Z2I10JgTB4IUhGAKIlDBlJF364RcOJtwqE27Ih7xXk7ohwoX3rm/xFBpy8Ifc
	Z/Zz9I7oHj+kVOiNw1Bj5ygjO6BsOJ+cpMWJcPJCqmy7/iqHgXyz4gqqqM/Lm7aZj++e5H+tF88
	xA28S0d4EyV3ZmVz9vKMXZmlGpkfEOgFJKo3xAWpdQdipRvVpGK+KYtSanBgKDpI2Td1MbUFLl1
	HhR9Ke1HNiZMRQTLKkeooGBCY5G8JBZOVaKedT8F17Cn7EL8gsTkw9JwkAe+XOlDjCaKjXarpqi
	fT87k93O7vhB1WuqKakQ1Ly/dbO2iCRLLkhis/7yRkajD351KbJanVIpmCUjFrRMvv/p6Q0r5G3
	Wn6ZV+ZpwUYlI/2aXe6wKjMGeQzqrJ/yA==
X-Received: by 2002:a05:622a:11ce:b0:4ed:a7ba:69c with SMTP id d75a77b69052e-502a17dbec7mr123192911cf.83.1768704380437;
        Sat, 17 Jan 2026 18:46:20 -0800 (PST)
Received: from ?IPV6:2605:a601:8119:700:1eb:9803:eb2f:8b98? ([2605:a601:8119:700:1eb:9803:eb2f:8b98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1ef9347sm49087671cf.25.2026.01.17.18.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 18:46:19 -0800 (PST)
Message-ID: <c5631f7d-72ff-4876-9b68-ea4a70fde501@gmail.com>
Date: Sat, 17 Jan 2026 21:46:18 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sparse-checkout: optimize string_list construction
To: Junio C Hamano <gitster@pobox.com>, Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
 newren@gmail.com, peff@peff.net
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
 <20260115130935.93526-1-amishhhaaaa@gmail.com>
 <CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com>
 <fc14e0e5-93bc-4805-a20d-d2aa4eb87ddb@web.de>
 <CAPvEtrdQ7LB4p0_yCg+ef6fsWSHwxA8C1uX0SJbfnV3vfQHD_g@mail.gmail.com>
 <xmqqy0lx8ojt.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqy0lx8ojt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/26 12:17 PM, Junio C Hamano wrote:
> Amisha Chhajed <amishhhaaaa@gmail.com> writes:
> 
>> It was assumed to be safe under the notion that our entries are not
>> duplicate but as already pointed out, our entries are not unique so we
>> need one of those two ways either insert or remove_duplicates, this
>> can be a trivial question but i wonder how are the tests passing by
>> removing these lines, i was actually researching about it.
> 
> ... suspense.  And the result of the research was???
> 
> If the answer was simply "we lack test coverage", it may make sense
> to add a test taken from Peff's earlier response to increase test
> coverage, perhaps?

In addition to adding more tests to t/t1091-sparse-checkout-builtin.sh
to cover these duplicate cases. To demonstrate your quadratic perf
improvement, a test in t/perf/p2000-sparse-operations.sh or similar
would be good to add.

I expect that the test you would add doesn't matter too much about
the data shape, but would look very different from most tests in
p2000. You can make use of the constructed repo's directory structure
that has nesting directories with name f1, f2, f3, or f4.

Here's something to get you started that I haven't tested myself:

test_perf 'duplicate sparse directories' '
	(
		cd full-v4 &&
		
		for i in $(test_seq 1000)
		do
			printf "f1/f2/f3/f4\n"
		done >in &&
		git sparse-checkout set --stdin <in
	)
'

That should test the logic with 1000 identical directories, which
should be enough to have the quadratic growth show up.

Thanks,
-Stolee

