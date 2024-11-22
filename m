Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A223098E
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275969; cv=none; b=tcE8U7FI3krzv3sQadwKgiyGQ7lkw8diJNVs/zD1LnFur+F1QQz7Q+bgHLQ0OmIUbXyVey+pUs0PjslglfLAZMYUE9baKgAbJHANWzialxywA0RVoIsxQK/0uC0Z7RnsdP7PNQefOVGjTVBxmnbTteqc2qqkO6zbMeY5EwcYix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275969; c=relaxed/simple;
	bh=DtuEYKrDzoHGCffBavMmsH6k36t9kPI/S9ut09RGyF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX1wnE18V2bnf9xrXPktnkvFtthUVfzMBwyRzIhfpU5FXwC1G31uL66BNhMJDQZVrHFf+g/Zb81Mhvtpuo2FzoaM9JlrQVIcGqM77CfcQv466bFstJNJmWMnzS2b3TOsGLMAqqbbLcYNayeQdVVUNj8JLSwMiqRIRNOeJixz/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr+kvj9Q; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr+kvj9Q"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6eed41d2b12so14048647b3.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 03:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732275966; x=1732880766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMRvU7/qr6i0oqcp5W1PEg2B05xM2WqABvxz7GrBvvM=;
        b=dr+kvj9Q8oFMu3nJ2ilMQFsOYSX3nGBXL2a96UEwQpc8mSGgJpZhN8kKGwMqFD1C8r
         m6hS9UHnuf4XLDFsQq1JdqLrhN5YDdstXMarOkZIKu5rZzgFU1Sd2wOuff/rpuzTKM36
         y+CBKO3ofBFuMYfeee94MLHKYC9rh+VzmM9hqNCq7cZo13sbBzCO1x5j6gTTFRSvUOYp
         vhzfO2U9K6pjo/zTi86l8vbFbRBRjfMGBoikm8d7Hw6QFuRrkS2Vl70UO7K4t4rk6puK
         CMRYCTZdkTVyWR3tgd+rAvqpfmtyLAd9JR5YbTr4/T+289Fvkzajwh5evLMytcFfKJTy
         WVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275966; x=1732880766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMRvU7/qr6i0oqcp5W1PEg2B05xM2WqABvxz7GrBvvM=;
        b=nflGQrOEqPQSPOH9Ks7s76uKbSDoIhpflsAU5PHHS+IlJV/4LyD32erqCurPfKFHEi
         DbUVkoJPKZSmky/6ZAb/z1Z3y3J+p5Bt/1h/dlrcvUVnwErsONsxgK9o50C+QnyuiUmA
         DFEYWDq/bPR2OckTFdakuvVrqg7dBvjp32/gDWAFDdXFZB/SgTWHuAhV2lzQaxwRycKT
         a3UQByEBPk9ooSGzHHg/zxQmIQFt7isWrcSPwoDDiucYpUulXlYgJ2sMDnQnxPK/m8WX
         kuHGuS7CRXC7H1mu1zCTWWFUFM9mjXwuSqJ6IpGlCnqwZgBsab077aGaP4jat+DSg0og
         wunw==
X-Gm-Message-State: AOJu0Yyi1Lh9XdCMX37UEkGiyC9CZElsqAOkc/Bp3OWx9c1LhhDVV/xB
	ZYq1UkStfVJbdprAONaTltn05LXUheK9k7ksz6nj0XTlqdrBH7q9
X-Gm-Gg: ASbGnctqbIGd/6aXXGfj9DRYWDwgIiKB5ooCgARzN2PDzXzDW9a74fonLnVwG/k86Qi
	nP+7MBYYG7uTIGDpBaCnVyllvC0GIIkKfVZ5OS8HvXjWLPDz1SDy8LxOaK2RdW+26unzPfF04aZ
	6pO1sYxDHEknKKa/ZxicBYNxPRpRohXdZTDLLvmi/VybVeJqhfyeCWWT8GDv/tNEgrH0xQ53Lct
	S1xenPdEDq4a/0uKO1bDVx1wbYbKVi9ZdOzlZjjEKSJd2b+T+5l2pVdXiw/ajRdhKnVsdzgFRwK
	inJFh/GIaAFHkTCdugJvz+lkB9PqK0D54/Sz0w==
X-Google-Smtp-Source: AGHT+IFSQw3HlUeUIXZaQmDXMt0n+vxHR0SOlx2AFih3t1n/t8XpyU2PbJoxzEusOQ95FGVC5//daw==
X-Received: by 2002:a05:690c:600b:b0:6e2:fcb5:52fa with SMTP id 00721157ae682-6eee08e73f1mr24975687b3.9.1732275966542;
        Fri, 22 Nov 2024 03:46:06 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:79a7:3ea7:43e7:e05a? ([2600:1700:60ba:9810:79a7:3ea7:43e7:e05a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee8862869sm1143297b3.9.2024.11.22.03.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 03:46:05 -0800 (PST)
Message-ID: <ec17fdd8-310e-42b6-bdf6-2620a84c2eb3@gmail.com>
Date: Fri, 22 Nov 2024 06:46:04 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pack-objects: add --full-name-hash option
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <812257e197cfe30bd0d3c68ea6ec0d062631185f.1730775907.git.gitgitgadget@gmail.com>
 <Zz+TKS2O/ij6GZ1f@nand.local> <Zz+nk4w+y63vCupK@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zz+nk4w+y63vCupK@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 4:35 PM, Taylor Blau wrote:
> On Thu, Nov 21, 2024 at 03:08:09PM -0500, Taylor Blau wrote:
>> The remaining parts of this change look good to me.
> 
> Oops, one thing I forgot (which reading Peff's message in [1] reminded
> me of) is that I think we need to disable full-name hashing when we're
> reusing existing packfiles as is the case with try_partial_reuse().
> 
> There we're always looking at classic name hash values, so mixing the
> two would be a mistake. I think that amounts to:
> 
> --- 8< ---
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 762949e4c8..7e370bcfc9 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4070,6 +4070,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
>   	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
>   		return -1;
> 
> +	use_full_name_hash = 0;
> +
Thanks. I have applied this code change with a comment detailing
the context around the bitmap file storing only the default name-hash
(for now) but that it can change in the future.

Thanks,
-Stolee

