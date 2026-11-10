Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327200;
	b=ACUiG9TSia7wFs8RpbjdP9H/8F5Glgr1vL0IUiFdRHRZCupuLr1VJiaTe/dP6kReLF8a
	 nLJSQ6LuCRdrBc4ABpSaTLyKBGrFe5DAyWMbXWHf2kq8hLmzrxnOWoYl2wW901aasPbEV
	 pGPUz63vvicBP3azL8berwWYT5tx8z0G22iU2ZykShJAQBkYgYvVpY/ESukS1P/A151Dh
	 EO8qBQWjA8/TU7i4XrsfgCAWJYHp11tU5CydsDgtaS2+7w6e87voVsxOQ1DfZw+aNYs3D
	 EQGrIFi3gN+xQHlkun+IHXFHohK9KOmwABkQVP3x0pebNzaGzWybYjumbIjI4ejubTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iO3pUuP+38mjKSp+IhUynyU6R3zPy8xjdrnva2/pdek=;
	b=An0i6OFyYkynVq25keYnz9uruaGP/hlQpwt9GaILn8UF6Xtg2R5reTEenIxtyGOfXkkO
	 QuzM2UkTUs20mfkT/qTKJDtfl1pT5IbwkW2lC6bF0gxFLYTRIsM2adDaLVDh/+YJWdQuH
	 zgaJqxX86MfbYyoD3u9hMkJpl+1LodW3ENbp+U/uq2bBVALLR2+jclB926qv9CKbRQ+aC
	 iXk43tGuqKN4srCObek+Dg1XTFy0ja6aLVRpGfwzJGsGcGRSpFWwAM4BwVZFfUVJgsyAQ
	 54BC7Gs6iLU1OGDcMY57BWf+31AjvgTA3gnodlYK1fSOMl2wJyp12OZvJLNS/hLxNqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0XFQSKE;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A6606A331
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 036A6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0XFQSKE
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso1540429e87.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794327198; x=1794931998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iO3pUuP+38mjKSp+IhUynyU6R3zPy8xjdrnva2/pdek=;
        b=q0XFQSKEU/F8DetMnkMyBQCvov2o4btUOtwjWM65UgTl2PWKLhdESX3OtUCxldRQJo
         wR9z7Fj8QcOCfr/fx84K5R+JZLHiMkRpHx6dbLr7B76V3rvgRWSyzRMwic4D8/fdGhUY
         hBNA6Of1dPK3Cayextg2ztkuySazw6GSm4Jz8y5mmK2sq1ONxL+YVBL4M42atslVrvIB
         M/zWR5ciP0yyPU22L5Jo5RSzjnyYdLby7etActN/cRyAIY6m5cVLuk+S1hwul0u4gJ8q
         Y8K6sD1XIli5p6DiOTALXFzlv2cL1/NLp9l3nun2RDzm9ouiDHZ8E6oQtz6hBRrtSfmw
         214Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327198; x=1794931998;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iO3pUuP+38mjKSp+IhUynyU6R3zPy8xjdrnva2/pdek=;
        b=sj0x9NkDOR+JubiG8cOdvLVZsDd6KCslk4bwqs/3ErxuYpIHm0Yzn3KnrSRa2HRkUv
         f0uK04OZ51HfM9rwJquifxdPrq6LxjqUE5o+RcsQnmtF2jJiz9t7MLNNfulUSCauiR1U
         gHFAsUifagkxv86SJOnSOuvj5oczAuv5PSnz1NnzpqM1jHLz8LcPkfu836ziEZA1ToA/
         t7bIbRjcnBLQPN2ZXmLPf0A0XfYCxRi94kdxDFK8f+JlyeU0d5Y9xW+e2rmyl/4sF7MT
         sdboQUqNmI82KNmagWSVV+apd8ee+UMkZ+gNQJ3smJsHKjv23aHvjFAI+3h28BxOlLbE
         pSqg==
X-Forwarded-Encrypted: i=1; AL+hErFciTuz27s4KSDNWqtnzXaOVMWD+Wrl/K5ki9JbPFpAq1AirRY6TQ4d7PrEKXZe/VY1KaY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+0DiNRCCr2k0Kd2MiKQ1okjefAWizifsgyEGg+2v3BNwgYOj8
	GiOtMXhAF/BGSYFRrF/thMYy8V7YTGhet1nQSZNP0siclp+pdHr4py4Z6vPB3jx1
X-Gm-Gg: AYBFou3Vf7ijCkki1E4jSx6yirHOQGvwZfdOsHXHskQa8fYxPQGk9AjlyRhyHNJYJvV
	eqXZzmKLbhRX8l/DyP8AMiuVHEnvzPWunU7FSaRRB9V7JvwBlgsXDMCru2VXFK7mTbLtLIqlxOH
	iw2xZRsksWg8yXP9KCoVo7o+MvPnangLyO59tWPUL+s1Dp9gitLjre3EDX79psDxp7BGvQpKeEH
	UoF+BjksP0ypCu+sU0L4fWkPWdEIdWMV73mFCnQCGHFPbKZnnE6GGodve1jM+E+a3YFkFGJRnSm
	mZarBh65RV1DCLCrcujtsrdfJpWd/Ua9ubmz18+eP93JdM1bweksizs3Q2trjA2iyMzEXhu7XSI
	lb5nL0pvPETuIdFvBvKwcYgP5OMhUElIXuuu76SPjYde918lvQTaT7fm4MalCd+Yaavl1b8LNFh
	JoOFhQKJCjTc3mv8PrXoRM8nuxSME/ejQoqcmm2y4GWErVjDK1BaC55Ndu9SBzXvOZ6BllALUB/
	zUour2rXwHLJOa+GSv3mGGvTBz021oZfq9FQEcOgPovDKCL23HH00IaVqrKXC+aWnqAPMt21FV5
	qUab4Hu5N84PuKCQ3HrkdG//dV1BcHIdFhlO1iSD4hYSskmoaqLSjZmvfl10wWLcFQ==
X-Received: by 2002:a05:6512:1153:b0:5bf:f81a:4ac5 with SMTP id 2adb3069b0e04-5c156e9f597mr999395e87.29.1794327197898;
        Tue, 10 Nov 2026 08:13:17 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157baf5aasm495247e87.48.2026.11.10.08.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:13:14 -0800 (PST)
Message-ID: <24939fc5-53aa-45b6-9e4c-249c5989b42b@gmail.com>
Date: Tue, 10 Nov 2026 21:43:09 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] object-file: stop including "odb/source-loose.h"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-5-fbbc86c29693@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-5-fbbc86c29693@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 16:50, Patrick Steinhardt wrote:
> We have now moved all functionality that relate to the loose backend
> from "object-file.c" into the backend itself. Wrap up these refactorings
> by not including "odb/source-loose.h" anymore and instead include the
> file explicitly in all compilation units that require access to it.
> 
> Like this we can trivially identify exactly those files that still
> depend on details of the loose backend itself and that thus require
> further work to become truly backend-agnostic.
> 

A sensible thing to do.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   builtin/pack-objects.c | 1 +
>   http-walker.c          | 1 +
>   http.c                 | 1 +
>   loose.c                | 1 +
>   object-file.c          | 1 +
>   object-file.h          | 2 +-
>   setup.c                | 1 +
>   7 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ca3a891dfbc..e53c69af31f 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -34,6 +34,7 @@
>   #include "object-file.h"

I think we can lose "object-file.h" in this one. The code seems to 
compile fine without it.

>   #include "object-file-convert.h"
>   #include "odb.h"
> +#include "odb/source-loose.h"
>   #include "odb/streaming.h"
>   #include "replace-object.h"
>   #include "dir.h"
> diff --git a/http-walker.c b/http-walker.c
> index 4f50dd9b8d0..13730a27847 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -11,6 +11,7 @@
>   #include "packfile.h"
>   #include "object-file.h"
>   #include "odb.h"
> +#include "odb/source-loose.h"
>   

Ah ha. Looks like I was a bit premature. The http-walker.c change I 
proposed in 2/6 actually belongs here.

>   struct alt_base {
>   	char *base;
> diff --git a/loose.c b/loose.c
> index d6a2bb5ba3c..64cd6f1c3c1 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -4,6 +4,7 @@
>   #include "object-file.h"

Ditto here about losing the object-file.h

>   #include "odb.h"
>   #include "odb/source-files.h"
> +#include "odb/source-loose.h"
>   #include "hex.h"
>   #include "repository.h"
>   #include "wrapper.h"
> diff --git a/object-file.h b/object-file.h
> index 83d3f38a540..746356ceb51 100644
> --- a/object-file.h
> +++ b/object-file.h
> @@ -4,7 +4,7 @@
>   #include "git-zlib.h"
>   #include "object.h"
>   #include "odb.h"
> -#include "odb/source-loose.h"
> +#include "odb/streaming.h"

Do we really need odb/streaming.h? Code seems to compile and tests are 
happy even without it?

>   #include "odb/transaction.h"
>   
>   /* The maximum size for an object header. */


-- 
Sivaraam

