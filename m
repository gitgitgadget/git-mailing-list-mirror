Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395654;
	b=tfitCg885bejtrISk1c+SsC3Ha0QhbnUAi9j+rnnwnabDM0o/0s/Hv/+/SMG2ss6sjM/
	 XLbA7kOyNJ9/lR0yezOnSnIxmqgDUsbFDGvkNiQ5KKHvJnQ2XvOEH+0450MhFb3+aEPFG
	 DkdqVi1IJQbpppWUplzGeGeujrHh8MadKrS2hQIXoCowCq/EIWNFqel/xwaB/nj5bKOGr
	 fQhJRpVscOoEQIl3Q5pk5CZruW3tn1+rSolC37dE5p1S7c7I4h8imA5/6OL7kl9O3Fjux
	 f1pvYNROWSykYTWLjbr0x3XWbHVzfZIWoXef3bHIOryq++MXPaA48ZLSNUlYK3cVexA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MgxQBYU0SqvxqW0uvAqUUsaMKmV9w5lBQ/WM0fKcwlY=;
	b=5PTCUMkkSoi0JJSDE48jZtHEXr6g/cirnTcs5UpUnKUdUl08ZCf/WHU2iFc2xn9QtA/W
	 j1dJCRwU/Dwy5Tu0O061wWmRi4R8cDOBHU3XDzd02wh0YafLPuYFPD8zvC9nPed/cfzaC
	 8AaXMkAuA4sb/c6GwqbxWp+EEzq/d3SGlBhAOluOalCyDKr3P/ZNa6KmNJZKRWevNgtEE
	 8VGOBF++s/2OxaLHIcZovf0uwGShPdoXuZqkKeyV7Nagq8avjR0GTPwmguu82GiPxZ2Jt
	 K4C38czxZR+EQIHXKpORDIBAX/PCq0+M8w/hkb0NZt10fZUW6NKdqVJfuSuP9ePOTdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RQ2ngd4w;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD4560A5BD4
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 21:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD4560A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RQ2ngd4w
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a1947498bso298152eec.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395653; x=1794000453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MgxQBYU0SqvxqW0uvAqUUsaMKmV9w5lBQ/WM0fKcwlY=;
        b=RQ2ngd4w9ZUUBF394F9J4hHGznebciX0tF/SkYzAPQaKoAtYBEaEsNFhLbsNjdmkw9
         25jbmmQ92Fx4jvCIzrFm30yTVqPHWy95Ny3uGQSai+3yIs3izzpwJJLA/R+/Iyl4KqNI
         3A5Z6XO88spnALyNHkB9hOQeD3kANdB3Q6B+t1E8eVJWOvbXg+AC+2XCJ7x/ZOh6ujA/
         AMrgtkJRan0D0gMDHYUy9d1nq0+bFziC9GuCvfnpYO4qwPQJNimOYKpxCz+sKDWy9rSH
         3QBPI7E65RusexpgqC4kGC5zCxzzeN+qwW/srosjV74YTVLXALd6qkdjuzbKoqf22G1W
         EPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395653; x=1794000453;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MgxQBYU0SqvxqW0uvAqUUsaMKmV9w5lBQ/WM0fKcwlY=;
        b=iyZu3c7Vq3MpqKvGoQZI4uJllVuj+7VNLyJ2TfTpxnQpCivwZhTFQmpIal7VoaJsuX
         UDs2mFmFrSL8jZ621GhLuXUlcftPSWFqWKaP/HtxgWhWxlNwcTWTbLNYem97I9mSSnXU
         Shie57A2QrT1K7tbf3kpAd3i7S/wMD7k9sVVqCMOCzf9KZkX5fVeoGoAXM5DP18XKCRB
         XrkK8rLvnsO1yDEiQ/RGZDwRuYhIWwm47cngfru+imyEubAdJJ6UNwYKlag9MMyI4MxT
         6Uqy1+3OzzRaCjPWHwVv4pI+fCV55IARTMzGhLbWURvzNek/4S/PI2hbB5RbWS0gRTML
         NZrg==
X-Forwarded-Encrypted: i=1; AKwUvBzIYg5drdP8VPIJUc09oSIvUZ3r+tI8ZemDg2lWtS+K8s2ARym4wMFN3b9vCWmoAoyBugQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMFvKvAUiPg5LvGntuJgnjVlnxFQc+Y0kEW0yixTUnZ9gvfxu7
	mMi1whrecYL7SaPtUj9Dt0mOGJ95JkUcgFhLWkAXB8qMhqQYtnT8iRNb
X-Gm-Gg: AYBFou2pWPj3LtOq8uuO7R7WKcgqonMctT2WcT97LzlfsbLSDwaULbv9eNPhKq5hYKN
	AAfJT1vftJX62R7DwMPXMBfDDp79MaZaKKC3mZMzEyXIh/5wzzID4ZwhG/KaHyQqEqaVl2eI7C7
	+cd00x7xlpICEkVD+hUi87oS/ZTfJoi+D7TdooPnQTWVSQkH4A8d1bcAzL0rCDzF5O1OvUwHYfi
	/U3pYmZDdt9LlvG17g01AVblDoBoOT/Oa1Y6QaJCAhbpGi1Lz6L0NEkjMqNcOqbt7C1YMVAwwT0
	i0MHdtZjtOehlQOYGeOF0XxqlENHob7HnQRH+zYsL3bIbgsU8obN7Pn9Da0sEcDaFYXupOhIML/
	Muoi7mK5ZFJknR/DnRlcOnVY0OsapeX5hkyhHj/7PUtsUKqly5tkLdgoURYqLEQ2x8zzDsMxbLF
	R3GBkeC+RHxzad6QAe6hDkp1rmwLdw2K7qLZCzgvcO7MuZxNW+Z5Zy5wyXed2ewod2QMCNrO8/E
	U2HPqDsno7p0GGDyingYJ1tJufMijMqzEbTx+m57k4tSKXN/KVEaBW2bnJa+zWlEOUzkDOdAYat
	V7BrXpxozmj1C+wpgqOE+hczd1OHrSBVSyvbAAMs
X-Received: by 2002:a05:7300:d215:b0:366:c0a2:642f with SMTP id 5a478bee46e88-36a423b3b95mr4852912eec.22.1793395652637;
        Fri, 30 Oct 2026 14:27:32 -0700 (PDT)
Received: from [192.168.0.11] ([106.51.26.191])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1easm8752764eec.5.2026.10.30.14.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:27:32 -0700 (PDT)
Message-ID: <6782fa63-1e46-4ae9-b129-a157986c2556@gmail.com>
Date: Sat, 31 Oct 2026 02:57:27 +0530
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
Subject: Re: [PATCH v3 3/4] parse-options: add early_scan_options()
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Justin Tobler <jltobler@gmail.com>
References: <20260923080928.1534413-1-christian.couder@gmail.com>
 <20261012074413.337183-1-christian.couder@gmail.com>
 <20261012074413.337183-4-christian.couder@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261012074413.337183-4-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 13:14, Christian Couder wrote:
> diff --git a/parse-options.c b/parse-options.c
> index a98b958423..c03c396aa6 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -726,6 +726,8 @@ static void parse_options_check(const struct option *opts)
>   		     opts->long_name))
>   			optbug(opts, "uses feature "
>   			       "not supported for dashless options");
> +		if ((opts->flags & PARSE_OPT_EARLY) && !opts->long_name)
> +			optbug(opts, "uses PARSE_OPT_EARLY, which needs a long name");
>   		if (opts->type == OPTION_SET_INT && !opts->defval &&
>   		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
>   			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
> @@ -763,6 +765,8 @@ static void parse_options_check(const struct option *opts)
>   		case OPTION_SUBCOMMAND:
>   			if (!opts->value || !opts->subcommand_fn)
>   				optbug(opts, "OPTION_SUBCOMMAND needs a value and a subcommand function");
> +			if (opts->flags & PARSE_OPT_EARLY)
> +				optbug(opts, "OPTION_SUBCOMMAND does not support PARSE_OPT_EARLY");
>   			if (!subcommand_value)
>   				subcommand_value = opts->value;
>   			else if (subcommand_value != opts->value)

Would it make sense to also have these validations within 
early_scan_options() just in case it is called before 
parse_options_start() is invoked?
   > diff --git a/parse-options.h b/parse-options.h
> index 589f8d9008..f39b9a779a 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -51,6 +51,7 @@ enum parse_opt_option_flags {
>   	PARSE_OPT_NODASH = 1 << 5,
>   	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
>   	PARSE_OPT_FROM_ALIAS = 1 << 7,
> +	PARSE_OPT_EARLY = 1 << 8,	/* only for early_scan_options() */
>   	PARSE_OPT_NOCOMPLETE = 1 << 9,
>   	PARSE_OPT_COMP_ARG = 1 << 10,
>   	PARSE_OPT_CMDMODE = 1 << 11,
> @@ -502,6 +503,96 @@ static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
>   		BUG("option callback expects an argument"); \
>   } while(0)
>   
> +/*----- Early scan: scanning argv before the actual option parsing -----*/
> +
> +/*
> + * Some commands need to look at a few options before they can parse
> + * their command line for real, for example because the result decides
> + * whether a repository is needed at all.
> + *
> + * Such an early scan has to know which options take their value as a
> + * separate argument, or it could mistake such a value for an
> + * option. The functions below allow performing such early scans
> + * without being fooled by option values.
> + */
> +
> +/*
> + * Called by early_scan_options() for each argument matching a
> + * `struct option` with PARSE_OPT_EARLY set.
> + *
> + * - `option` is the matching option,

Would it be helpful to also convey here that the caller is not expected 
to retain the pointer as the memory pointing to it would be freed once 
the scan completes?

Rest of the patch looks fine to me.

-- 
Sivaraam

