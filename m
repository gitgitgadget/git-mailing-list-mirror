Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61197322A00
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558183; cv=none; b=O1+B8K8NmGizP/s7GHY70rJIpEjdhJ/O3SLGfZ5BnFrID8LXypoYEVkO0uL16OTTzD+14hMiUsFeA4gMxwKbXTC/q7uf7ywNWyF4YtJ9eb8K1lFmZylba5siBNo9luywAcepzzRrDECOcudI5tW//BFD+y25C8eKm76JvWH+yzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558183; c=relaxed/simple;
	bh=Rn+sG1tb+L5B+0odHd6zaPsOymGdsw2bLLpf2l0F64k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kS1de0kZsuzMJ9F+y0lGsSTIy4VvzXQX+8ZnDWroKKJa10SGnALq+GPDq9t5n7J2vo4QJwLv19XW8Zy3hO6vnh08NBwYnK5aFOVdKKTLkxrhbK1Ku08OUFUvzeL21aZxEj6B3P8LrzhQYcFVr/WtFOZLZ34vH+LU8JwtYzsoMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egg4M6BR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egg4M6BR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cfc085395fso157711385a.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774558181; x=1775162981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZTmavDFbJGDIjrBbFwXLrLXfGqW8eftNGZPaeZ+Fms=;
        b=egg4M6BRQLjOCu27qVkOf3vembHafVY5fAPTeMPpmdlPmrmxxnJbA8LFXrBeEDPtNm
         9ZO7oHSRLz2k6KQGAd1jIF8h6LEeo6DgRIfjxm4xPTRFQ62ADp6eyPfMFb2lVh+FdlBx
         wIEydTEUc8DHQ70+HeinIO7VBP1zsJtpULNJnRvm4b3UXDfxaIHMIu2UJe96tIybNAUk
         N1qcSB6kYIoEg0QuBqZ/q7ANJxEI18+u00XfqgRSfnfuzgH0RvUSOUDoHYP8Kr16qOV6
         tygTL0aS6+z0eQVxbi7WCDcNmJJuge7ysQsrDsqJjt8WmIhtqzqPVFKtRPanzwo6X+Vr
         NCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774558181; x=1775162981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZTmavDFbJGDIjrBbFwXLrLXfGqW8eftNGZPaeZ+Fms=;
        b=H55TPKYgsRpDrjbGMIA8A3eH09mjfFaJE3TdkA0Sz5fvrfUORs6AgKuzX5mgToYs6M
         L0Stg/GsW26+yc/hDYl0aYdyjLyzIIawZBTSTSvaeiNlKFJJlwKidf8M+t8xSvq+wiS9
         oDEHzdgumb9CgIl5PMfgQUVJT909CpkzEJjf6UBtfMXkKoaWj6UHnRt2v3nqkvq+nMoU
         7Yb/YrXEWBFDdfaBjLiT8s+IaUqSmJIe5aXJ0EcC0Oo2zDFGhRqHIAr/MBVhkb8zcc6L
         MhcxEWLQ0DQS9GIZhGx+ajce6daoP2W6aOcB7K9j7rAeJvoLFiHiBMCaiWvbPvxsj3vg
         xmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn9zNOI1ayXgslR9wiJJdEc5AFDKiT11rYzwIhYcFlgWoh3c7NpCJJUWND8eh5wPh+PTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTaOHmOtHdw8871dc72yfKodIvxHTLwihoBZSomYjR83N0aj7
	3zx/Oa7j5lILyZqCp6izn6FsYiezW6xuZkANXluu9A6JdoRwMFnwDmob
X-Gm-Gg: ATEYQzzk7BVSoj+Ec4AWZA9xUEs5uxAg8wXukcmFU/2ThyZqWGEhryt20rizp7giR36
	rMLWwHib8FssQl87F6c5PQGQHSNjqWx7YcRrKP+zrLrXmnPiydOgbn63UZbzZy8+57WXcioeH7X
	pa4P6TXMqiL9blr9LtPiKt/BRCo+Ai0njR95wpWKVhlJclUFz3OmAXVtzVDdtbP+nCERqBsdSEM
	B1GbkKEuIsMLyhz1AR4qHRuNeiR0J1sFctS3mCy0voS6EElFmqhU0dbipW0CVRVCYcQlwx7ywv4
	9cTf/VXbeZF+6cpIjtK7QyA7TXxhuPaHInyRLjQs4RPqGHHdmYfzvK6k29UK4EDge3TQzSAv7cW
	diOGJRkRgI7Luql9zy00T3GF5v5bjNwWYX35i/t/gNFIhLOwz/0Vf4aXn7V2gTJ3TmCEib7iBFL
	Wv1xjTuTepjd6nm+fub66TLDrPoDJZV/KSdeNIrdXpQqUVQBaCKp2KbtsUki7UlIF+zG8phQ==
X-Received: by 2002:a05:620a:40d0:b0:8cf:c08e:5f43 with SMTP id af79cd13be357-8d00101cbb8mr1282793385a.63.1774558181210;
        Thu, 26 Mar 2026 13:49:41 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4cf112sm330580885a.23.2026.03.26.13.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 13:49:40 -0700 (PDT)
Message-ID: <2b1a7624-d9cc-48b1-a224-646cafabb359@gmail.com>
Date: Thu, 26 Mar 2026 16:49:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] repack: mark non-MIDX packs above the split as
 excluded-open
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <23cb9f33dbac735feeb4fa9b5e7676ab871e2c94.1774482701.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <23cb9f33dbac735feeb4fa9b5e7676ab871e2c94.1774482701.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/2026 7:51 PM, Taylor Blau wrote:

> diff --git a/builtin/repack.c b/builtin/repack.c
> index f6bb04bef72..4c5a82c2c8d 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -369,8 +369,23 @@ int cmd_repack(int argc,
>  		 */
>  		for (i = 0; i < geometry.split; i++)
>  			fprintf(in, "%s\n", pack_basename(geometry.pack[i]));
> -		for (i = geometry.split; i < geometry.pack_nr; i++)
> -			fprintf(in, "^%s\n", pack_basename(geometry.pack[i]));
> +		for (i = geometry.split; i < geometry.pack_nr; i++) {
> +			const char *basename = pack_basename(geometry.pack[i]);
> +			char marker = '^';
> +
> +			if (!midx_must_contain_cruft &&
> +			    !string_list_has_string(&existing.midx_packs,
> +						    basename)) {
> +				/*
> +				 * Assume non-MIDX'd packs are not
> +				 * necessarily closed under
> +				 * reachability.
> +				 */
> +				marker = '!';
> +			}
> +
> +			fprintf(in, "%c%s\n", marker, basename);
> +		}
>  		fclose(in);

> -test_expect_failure 'repack rescues once-cruft objects above geometric split' '
> +test_expect_success 'repack rescues once-cruft objects above geometric split' '

I appreciate the brevity of this behavior change after you
established the new building blocks that make such a
concise change possible.

Thanks,
-Stolee

