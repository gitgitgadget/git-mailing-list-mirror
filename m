Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563225B0BB
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914013; cv=none; b=jiv3G6ABXO7IzMH4X+7QzlMcbMqTIe3ezXj26NcY6DqUDwROXBusZPYRPZFPlz6wSYembStXwOOZLc5o6vId4wIf+EvgCif020YcdpifGmPOTLkvxIhRoN+ftL9fikZpp7ZCJMx1SzSu7rJ+WsgkxXeqCZcAyR/f5JrOCwrWr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914013; c=relaxed/simple;
	bh=dbWDZm9K/ejst1JNUxDgt29y9+tfl0OLbyEXvt/wTms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H57rj23TvnKFtRGfOa4KqsKjvUHegs9VOZeNJ9X6F0R9spGWL13qNZvz+8hlT2hU8m6KjwZEVhAm8HYVogV5XOPCzYKMLboHwKue6otTSwJQNme7aEKWNL7jxZLR/JtxIdN4nQsGc+S7H/whLeqEHTtXXfuDu71H3OX7eFeLjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIroZLe9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIroZLe9"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c0c68aa31so4760991cf.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782914011; x=1783518811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHlN6PITeO6N48AkIjMSM4ZaySfarItS1txWy7CXLzs=;
        b=bIroZLe9CHKS6h7/4pTJypphU0Js8Th/Z1W73LFGx3H3vbVc9CB8Wg8WlvvRMexg5I
         2Ib5FQtVbBZQZStIX/Z1dTotKCr0BCb/LxxC+E7maxUB1D3m0Rp32e59d7FFzPMXBdPK
         Xv5SdLa9lmE+v0GME4XbiWejx/BCOzJCQR5rlLk2tUqUTGJq2MjEzVy8jUUpj+J1GShm
         nW9jkeM/6KX2MWIi1XJpJeyF4Lcw/6k1V50F7UqrM4J4CPNqyhe/WsGFtWsOmDgRZc70
         yL9g0mUSxq1+JTCKyARpKmT9MJI3J3PtxEdZJr1IRsam9jlZAKtdl0YmXJoC2klnaNN4
         CQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914011; x=1783518811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHlN6PITeO6N48AkIjMSM4ZaySfarItS1txWy7CXLzs=;
        b=OzmjaImkxRMFe/7Yq2JLtIxbrn6UKUDdtM9bvaji4BY3P9BEoXQ69joPg4+GHYS2aC
         TsnEF/mgQOHyPUSVN33ilzShEn2lVS3r2PZIuh1zCeTXSdW+WUGBePl5k4SBM79NPc6y
         y3ynEiyeYeZXdnJ1IBO5xPsLyKbUq6W+PHHadkIKtE3Us/JvgmxfvtPm1hv0kWJfXGs8
         xRD1uJ4O0+ZDbXruTkzh3DbR6MuUsj8Smv/YKUZuQE+LYjo/f0VDheFY73F9qXJctBIR
         d1gnqoYHDS2IenKIlNkrjbwxbCDBGFPdM0QtKIXqtdOahY7GGIaxTSYbGl57zJg3ttAq
         NLCA==
X-Forwarded-Encrypted: i=1; AFNElJ/uorY3veWpQPhYcQfAq3TTsWf3xT2PBwqXTEi/1uWMNBWt8U6rvaNWMZaweuQFH9cdJZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQiRIY4pXMoVktEDqu9WjcssTljTdV+cWHaXHfmycEJHAdq2qv
	vU61BGNpA45K8f02LTFz4CX2X6OnYAG7eqKaXsmwgLIwKxcQyn1d2Q/0
X-Gm-Gg: AfdE7ckPLm/KKAk1mE/ISQNO29vKnUo3E4o8m5khkO9KHJTTfpU/m1kJ5hv0JWPuJGs
	bVxSpWNJsRVjJGZZXIgXHFszOHCRcaD9q3SQJ9jgnUhQ1eUN1OUANdNFJXl39HeEBKp4MQsOkmn
	/u5WgYUELfpLqZvOL1DRIJOL4RZbgxy11GD6m+zhV/O/kgZpv4jVPZUUjcK1EAd32renYLKY1MZ
	vk6mTULSHOVGZuiRFq7xSjdgq1h+4GV25EQk+FRCQ+ex8HRmSI5SwMWEicvREAERFKduTZytZr5
	/xw81MbhDru2/ObjVIvMd1Fd9oWij8PWpx6Ew12ZM2atnimpO/YII1LXoWG20dnh+NOQRNJGK+c
	AEEa54eIDO0yjXrEdgmRl1yd6RjPBizPQ808aEelkWn6u/idXycfjcQSFOaTKZqioSMBHudJy30
	nPajsmeH/hReb3IsYTj9+IoWvM6pl0LIKOQGK3cspMQRQ8FGG+knQ95ssXSw==
X-Received: by 2002:a05:622a:1:b0:51c:1e6f:5c5e with SMTP id d75a77b69052e-51c2af1dc26mr10630351cf.55.1782914011117;
        Wed, 01 Jul 2026 06:53:31 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a2f6ccsm44938591cf.28.2026.07.01.06.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 06:53:30 -0700 (PDT)
Message-ID: <f7384ae3-bcd3-4191-9ff9-1ab86701c762@gmail.com>
Date: Wed, 1 Jul 2026 09:53:29 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] bloom: make bloom-filter slab initialization
 idempotent
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20260701063538.GA2579765@coredump.intra.peff.net>
 <20260701063942.GA2580331@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260701063942.GA2580331@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/2026 2:39 AM, Jeff King wrote:
> Before using any of the commit-graph bloom-filter code, somebody needs
> to call init_bloom_filters(). This initializes the commit-slab we use
> for storing filter information. But we don't want to call it twice
> (without a matching deinit call in the middle), since it overwrites the
> existing slab pointers, leaking the old values.
...

> This patch takes a smaller and more direct route to just dealing with
> the potential leak issue.

> +static int bloom_filter_slab_initialized;

>  void init_bloom_filters(void)
>  {
> +	if (bloom_filter_slab_initialized)
> +		return;
>  	init_bloom_filter_slab(&bloom_filters);
> +	bloom_filter_slab_initialized = 1;
>  }

>  {
>  	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
> +	bloom_filter_slab_initialized = 0;
>  }
This patch looks like the right fix.

Thanks,
-Stolee
