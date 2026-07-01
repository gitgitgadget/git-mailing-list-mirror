Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511EA3546ED
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915697; cv=none; b=A+6IMiPVKDa92mpc5FuyvnEohDjrSi8n72qWwUIBllgBkQM/4STd0Wjmwc5F+jmShcNPVCwD+Fpko0PzaaY2pNTZPYHeARTWE9NCyPKDqe6K0GnBGFXq1LJDGTCbBYHvO+B33raN/FNfYzSg4dbG1GTVI2GmlE38zDRuVBt8Ca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915697; c=relaxed/simple;
	bh=Qw4TTtNWs4KBQ6qSmajjcC9dPjOiEI2v7/SOzQIhMXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EE/YyXO/w+xHM5FbFbgnZvr4tEQTtQWe1agqCMprjwOe26OYF5wB5joFAs2goooXA2uAA0GmnBt8n3SrYO9eNOWy4CNjF/aUgkTuJ70+3Vgc1NTw9MFoIsn3/V54Z3FKaM+6oZqqx4P3L2jqI9JRGa3s1aTz94iYYGCTGWIq8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U91KEh18; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U91KEh18"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c029505b389so263575666b.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782915695; x=1783520495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyb7qxG5PKfPGdFSNknglIS+W/ofy+77B6iO31l1FHc=;
        b=U91KEh18chgnUTsRMMv55XzOsMbe3eIQXIwu4rhDvoXbnzK8ry9nNZ14yZzpYukfRw
         wWofTkU/nsNr4wZdlu0zUgpyt1Bp+ejPOrKZuHlKV9+27GcY0+dLXYGWGuMO1JVrRxbg
         StwEGG6a/bz5/zHOoiTNUhVswQDYjAj0TdYJtTCPIAEEWh9Nwkb/P3xESwJG2VSnYEAX
         7UKPpAKmiT9KnqFg9etG48tbDp+hn2RUjcFMMnMY7QNfl3efUQf2k70Lnm9vPlPAXztP
         NvLFbIL/Au1UuC5csvnQJzscR9BcFdGfliN5wxdp3wTlM789Yi48LZ/RN1x4BD0xdQfp
         0Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915695; x=1783520495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyb7qxG5PKfPGdFSNknglIS+W/ofy+77B6iO31l1FHc=;
        b=Mh+TxM+bfXngT5XGHfeKS6A8BpMO4N74cs0NaiNMLlO7PEmNiC1Ko94udYOVBEYM6m
         THY8JDsZfnmS9k60i4CKWXLDAaMEUwWie0bzf4020LtjH23rvCxq+at5V/zlw+V1Avyp
         AVA8IB7gv1CgSobrc9CIFMPvdl6s2ZE7Wif8kvF8iX2NFVNUTLk/SLEoqckTYWWHtiY9
         etk+rsZsEx7tvcjBFI+BrvUVljrJH2GTscGWpNoRkbBpRLkshVk4NmyJ9sh1WViX9t2W
         Q5zdjF7zt0ijhAYonky3N5XoSdu+WBLEzK/GaxL1oRkwTVqh/H+7dJpoBiAiBytsUa6t
         fBiA==
X-Forwarded-Encrypted: i=1; AHgh+RppGpGz18cCgjxeoGviTeFmr7uAs49ALYYBlYCr1lUXn2jfnx/aPsS/5x6FHC8Gxdokvh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+91c0QksYgnQ75D/Z2Shee1B+GEN8SuXO9TsDZUgrAeSrOqA
	Z+PToOk8VYVFvJci2oOi9yyrbyi2tFrD0vSNG1Ma7kRw/HUlxkQxzMuD
X-Gm-Gg: AfdE7cksKpJ4afxaP8LWGBmzP97OrPGObA0f/s8Tu2tuGEP7QZRxiLXjXWRqnq+ZiUT
	p6ov5MGOsmpuha3Yys0ZW+OgOJ5LQNti2u+r0HF+ecca6ktr+wHcHFv2npu7cllRbsInTFtHNpH
	SDnS3aXg1sIfwZ6dY3UlVKVNFblIS54ZtH0oXmY/mhkO3sh+rpJYJN+0b1jQL3ovKYNsJxcht+Y
	GWmguwDp2BEPm1hQ1dK2BWpJ9B1hQ76+4l0XyfD3E1EiZgIcKQ/4Hjx42ATxX2ij8rDFO1DofYT
	kHS1b29+rqfJ9jinXfCxFp5aMq1ewc6SIdPPqihVmSCYpglvcwYT4ZYGCd+1vxa3e++p5ztRyMq
	V2X0Yjo9bM85ImAd96j2ROeoMNSYSrXLB/c2EOL4WcVID2NNmWx6yW9VdTzDk3pZ9LZBVUELtzJ
	Aru0D2W8W2gVWtGRFZ/ZsRafBSjlkbm9CdWs/absI5iaWFjmU6CDVbRe11+g==
X-Received: by 2002:a17:907:c786:b0:c12:a4b0:3c6b with SMTP id a640c23a62f3a-c12a4b04f0emr87465666b.16.1782915694558;
        Wed, 01 Jul 2026 07:21:34 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f0cc57sm285749166b.40.2026.07.01.07.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 07:21:33 -0700 (PDT)
Message-ID: <1b261cfd-c9cb-44bd-a3a1-e653b2cd34ad@gmail.com>
Date: Wed, 1 Jul 2026 10:21:32 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] revision: avoid leaking bloom keyvecs with multiple
 traversals
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20260701063538.GA2579765@coredump.intra.peff.net>
 <20260701064052.GB2580331@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260701064052.GB2580331@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/2026 2:40 AM, Jeff King wrote:
> In prepare_revision_walk(), we convert the pruning pathspecs into
> bloom-filter "keyvecs" via prepare_to_use_bloom_filter(). This allocates
> memory which is then freed eventually by release_revisions(), via
> release_revisions_bloom_keyvecs().

>  static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  {
> +	release_revisions_bloom_keyvecs(revs);
> +
I continue to support the obviously-correct and simple solution to
these leaks.

Thanks,
-Stolee

