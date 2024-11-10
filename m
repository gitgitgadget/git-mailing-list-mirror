Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89954224FD
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731275127; cv=none; b=jYvnyWwVC/i2Onw6KOm9oljUNkg7IPvb9mPhrw3NamWV3k9lZJEqbVdOMPgt+/S+qlqLjWdeeKQsx+piP0gEaQeYY99kP8GFnDYKEDmbGc+EjQeaRaj3dxQpgOAmWUji/wECn0uv5TnoYrXENAMeEuA1NjlPESfVZjnLwvDfSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731275127; c=relaxed/simple;
	bh=Mh0CahSHxGqH1e3I864LwgZNzY+u77IKiN2xm2oKkq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ajO6qNtqY+CGRQYvNfWrLF3LizMxiG4MjgBd+UM5Su/QQsqIcHRbD7BVgbykB9sBXEWwt2CeVubgcBjdRZhLl7qNCXck3U/6+qv28iwOhPropMZmoCtqJZvTT5S2VD7xlXL3cTGZEpciEHgv+y3+c9xjQ13yxEd6widwZaO6i/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHgUmhGi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHgUmhGi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4319399a411so37149335e9.2
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 13:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731275124; x=1731879924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HJ51iQRZeb3T4N4RcUFirkn0ZU1SOMJz+di3/DpDhI=;
        b=nHgUmhGi0+D7qNrYjc6itwAOp0e+eoZkxTnG+vQeCpL5kFunafKgGCpCWZBaU8ZttP
         VpKj9F0W55K9/s49RsirZgM/OxzzbTNgIsOwvsQOkuPQ9m7xtN8m5ZfwPmu0FxsW+P1v
         OHEl5/kN/csOHI7V3mQJfa2aKJLD8sU/K4QeS7fQk5X4sCgFhQ6a+nV/RRBUM3T0/TVL
         mi0QeTaAa1yWbgxpOV+04oviAXW1w/qW2RJ2yrn0zFEnGezIOWYrB+tIJkIzsVwvIQZO
         RtNYeolZqVEbejyc597FdYUTrGzC80/2h7GUAgyesn4pPKnocAACdnBky9yOmo18YS4H
         SnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731275124; x=1731879924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HJ51iQRZeb3T4N4RcUFirkn0ZU1SOMJz+di3/DpDhI=;
        b=QEBOqjyPXidf7ozpwqtp1PNq3fDjQVteV2ZbUVJc5sT3N/IGNE4LLE8HyFbsuVsqkb
         FNat1lITfvARXS+toIVwisRkFC0DEZgA+8fPh8UfCYidR9hdAtXzdhqfWH4tNzJp039r
         BKP5eaZgCQHxXCAaVBwZy0aNX98FGHcBzSC1d4jRU5kqNWVzDgsBTOB2scL9DyJu+rVh
         p9XvH5sTg4f2Ybfch5yFyZNXow7faYEo2kZP3uamsw9NB/On0Vxw8doJLdb/oiYYKE0R
         lDTCwKMyUA2Y6JutWAbwH89864Z8Ah9DtbPNpNo4sm2Hvl6kDRXFGp5oh1TRFfrdrzIN
         kyyA==
X-Forwarded-Encrypted: i=1; AJvYcCXXPpNh83q7asfRExp/ZulFfhLhqvkf4E0pib32h1pF3kmrnaloHoi+4Zui/iCnAMMcPIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAKidYqCyNZSjW/UDQuuNMWTOk1+iUuZKvW14k8fp5sB3XCg+
	Zbxn+XEa4b78Hoye0UbSLRLDSonVwSSa/x5/cTEyzw+SfvuTX/6H
X-Google-Smtp-Source: AGHT+IHeVrhUXKxKe1cJNnPNtHaeF+Od5vS5iytjafEMKQ2Nm7Tx9XbNzkftfKiI/9XAzXhYQoSSbA==
X-Received: by 2002:a05:600c:501e:b0:430:52ec:1e2b with SMTP id 5b1f17b1804b1-432b751c1d8mr89065855e9.29.1731275123659;
        Sun, 10 Nov 2024 13:45:23 -0800 (PST)
Received: from gmail.com ([178.237.229.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa7397e4sm188691665e9.40.2024.11.10.13.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:45:23 -0800 (PST)
Message-ID: <df95ded8-2068-416c-a4cc-2dd564f94e6c@gmail.com>
Date: Sun, 10 Nov 2024 22:45:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/26] split-index: fix memory leak in
 `move_cache_to_base_index()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1730901926.git.ps@pks.im>
 <88e727407242248173f1e0f39d7b85b681234f4a.1730901926.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <88e727407242248173f1e0f39d7b85b681234f4a.1730901926.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Nov 06, 2024 at 04:10:52PM +0100, Patrick Steinhardt wrote:
> In `move_cache_to_base_index()` we move the index cache of the main
> index into the split index, which is used when writing a shared index.
> But we don't release the old split index base in case we already had a
> split index before this operation, which can thus leak memory.
> 
> Plug the leak by releasing the previous base.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  split-index.c          | 6 +++++-
>  t/t1700-split-index.sh | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/split-index.c b/split-index.c
> index 120c8190b18..cfbc773e6cd 100644
> --- a/split-index.c
> +++ b/split-index.c
> @@ -97,7 +97,11 @@ void move_cache_to_base_index(struct index_state *istate)
>  		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_pool);
>  	}
>  
> -	ALLOC_ARRAY(si->base, 1);
> +	if (si->base)
> +		release_index(si->base);
> +	else
> +		ALLOC_ARRAY(si->base, 1);
> +
>  	index_state_init(si->base, istate->repo);

This change sounded strange to me.  It's like:

   if (si-base) {
   	discard_index(si->base);
   } else {
   	ALLOC_ARRAY(si->base, 1);
   	index_state_init(si->base, istate->repo);
   }

OK.

>  	si->base->version = istate->version;
>  	/* zero timestamp disables racy test in ce_write_index() */
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index ac4a5b2734c..2625ac44889 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -5,6 +5,7 @@ test_description='split index mode tests'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
>  # We need total control of index splitting here
> -- 
> 2.47.0.229.g8f8d6eee53.dirty
> 
