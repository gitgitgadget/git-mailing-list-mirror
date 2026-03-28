Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61419239E80
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774717710; cv=none; b=u8bR28cWuVIs0SLBcgJqagfYBV6ErzN8QlfHJ5MnftD3ivwKnOpIWnYBDUOf6rWVbH9rwmKUE4JnMq/ymGPcEjGm4wsUViN66ym9OsOwmMOsYs57l8b2G3+kaM4p0LWRGtjhierdVMq3V+939FpO1hBwUlWaQi9MTrnRGjThJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774717710; c=relaxed/simple;
	bh=xNsNbR30lwVvnXO5TqR+aXId4C5Zz4Ytq/vp87kw1Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kti7CzLTTTfuEgaMbEB4fV5nHuKSyrE71gt6vV8NOAmPSHeS6i1hkGPeXQaWoMN7INeiRN0pYnXPmvKuXYzQTgHVloIv1B9FODGXftjk+GRbFy78bXE/hp9x6gtCMjTJLvgaoR4pNqY+otGAJ1HkmJqXCuMyxABf+W6Y24fZFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+bzjuUu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+bzjuUu"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-358ee55eafcso350932a91.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774717708; x=1775322508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqvSBBdwfCvz1oW2cWgdjD2dri136DW8oPr7tuzYiGg=;
        b=A+bzjuUuU/2csvYAIJVT2H7V44zsM22sYkLYHI3ceAOLXxw77yYopbWy/w9UBDjxww
         e6G8s7G8oE6Feii8MpQ8VAwXkeCTL1hjIKKO7vv6wXyxlxtFlbgtopfCfZlEhTfbO0W1
         tLKt88j7G14rEJxl3CHAau8CXu80zyRI3cUD1UZzQ0ZmsnL6N8/OlY7nvGG22aJVx/nj
         Mx66b7SToUOE3QGb0zEdV6dOJVUUEhiOewfguerSVFqMA41XgAPp4SQYKwfh4FYyZi2m
         WZ5V4DPkY5lfL/fQaFc8JXaWkl9+01hzBb6Hpy57GFf4IiZmS+tQgM/eUEwAwnr0Ei5T
         1vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774717708; x=1775322508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqvSBBdwfCvz1oW2cWgdjD2dri136DW8oPr7tuzYiGg=;
        b=q30LL3J/GVZNt3ykfr0AN+RBzU5PGo4JT7DLu4GYJ2hIa1ZIwTHuWzWTP63hpcK/ti
         hnR2U9j3Ngd08ptJss/VY2SaASm0BaE1akI60be2aSMxi+Y5sern3wPhfdHw8h95582d
         jTzD18WbPJ0Oy9TnHLPr2vaTG6CQb+/+82vj8akH8y07e8TO1Tz1vJoD1CNDwpaf3+2J
         20qh94lNwbKms3nU4idleJU3oWdbIb1HwkC+qJYw646XtfHgiFbz0GqrBCF0F5mXb/+F
         wGFyGjtASpaPpHFOWCTxm4WiCeuBi9fReXSnny2I1ztT1iRWBYmaj3rQlYbDzOBclQRw
         anLA==
X-Forwarded-Encrypted: i=1; AJvYcCUOIOgdcFlDVsXaLr9zrLAi0uvaQfPUpEYz79TVxNpGTRJ5P+lBzEQ3lX82efR3PyaIqgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ebWGsm9zaD+VDHo0Nhdqf8b2GeyYB+LFrkkwtNGCo1qn0dJW
	iRggL3y2BNb1Au0QRU0RtzFMevNQz8MI9UI20XMecpEugXf2FXQtsegl+mFw7qFWx1MzWw==
X-Gm-Gg: ATEYQzwvb26I2qkIjcpsm8B95dwLQsIfD7C5HJyAHzyy5i9L2VP1USYLxD/mIiCSn3q
	DI5QN2OR1exUlS44LOwx43CwLy7Vcx+4cp96H/WgTKSGI+9CpwGjHEYmVVtJWy1fpSI0O41yQMs
	aPJjKd2swOK+6gO60s+FvOr9CPF5Y9gE5rktX8H0XgdA9Zs2tgxhlfSZUW7rL34p0urnJDOP95c
	i+ooaFqWm3bSMTgHmov9iw5CbvdQ9BXbN8FXw4BazAkiDctCsHQMfNiOeuQ2unLayxjheBSVkCG
	0kvZ0CfDRhoN2UM4X5eW/mdy3AeOT1U4bDpnGUifevaQf1+MAgr1IBPpbtgRLJ1MfU83f2guhpF
	5TWsny1nLNmFNG9BgMoLQEsu/F+s2SFRNR7HK1/cQcz5OpC3rv0cBeJxwJcCi2rdM8uYWTnwAv7
	kcAJB7/Lsny4GsmzlfWLv6orzIXGkIiKVtcmLG7TYjiu/DXRsT2VCRVkOBua+Efd8azaLCQyE9b
	kGXXR73ntg=
X-Received: by 2002:a05:6a20:402a:b0:39c:9ef8:8979 with SMTP id adf61e73a8af0-39c9ef894d7mr1554536637.7.1774717708322;
        Sat, 28 Mar 2026 10:08:28 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c769179e3c3sm2080195a12.19.2026.03.28.10.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 10:08:27 -0700 (PDT)
Message-ID: <b2c143af-22c0-4266-b641-5ccdeb221251@gmail.com>
Date: Sun, 29 Mar 2026 01:08:24 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] refs/packed-backend: use ref_store->repo instead
 of the_repository
Content-Language: en-US
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-6-shreyanshpaliwalcmsmn@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260328141146.1095115-6-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/26 22:09, Shreyansh Paliwal wrote:
> In refs/packed-backend.c, repo_config_get_int() is called using the global
> the_repository, even though a repository instance is available via struct
> ref_store.
> 
> Replace the use of the_repository with ref_store->repo to make the code
> explicitly repository-aware. With no remaining users of the_repository in
> this file, drop the USE_THE_REPOSITORY_VARIABLE macro.
> 
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>   refs/packed-backend.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 23ed62984b..ebc10dab4d 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>   #define DISABLE_SIGN_COMPARE_WARNINGS
>   
>   #include "../git-compat-util.h"
> @@ -1223,7 +1222,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
>   	static int timeout_value = 1000;

Burak already pointed out the issue with the static keyword in patch 3 
of v1. Notice that it's here as well.

>   
>   	if (!timeout_configured) {
> -		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
> +		repo_config_get_int(ref_store->repo, "core.packedrefstimeout", &timeout_value);
>   		timeout_configured = 1;
>   	}
>   

Regards, Yuchen
