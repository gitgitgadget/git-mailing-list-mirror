Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C640199FAB
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049444; cv=none; b=I58N24ulIuiaAEKnfY1D+b2gzEFIWcG/78ZOOEknC9H1yIkUMtZAliEWrMONZt/eyB7dgr1YLF8/vY9XnJRT0oR4rzNXOf2HCjN8WIzz26CwU1SWnEXi9saQYBY/8UvLetZOAE6wVJ3RvMnNiEqPcT0QGt+1bcMVhTzP4g6C7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049444; c=relaxed/simple;
	bh=B2ZNi1fAmt5UDyUGGbHZcsfTWG/WRLFrPP85ePotv7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O953GSkaqLrLAloxs8TAECwS7DOeMhohz3Vmyf8tPBbhAhTNDK1kd/kKKjiA0Fzig4ojgAPrWQedf4gIPNblwrMl5xWrpkXvcU3ZMdNbXGAnTx4h1QV3qKj9SdB67lhz1+PoUtx4pukje3vrpJM8vhaP33Qbmtd/c3mC5MujUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFrdjhYu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFrdjhYu"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so56454355e9.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775049442; x=1775654242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cw/gXvU+RVMF6do4f+oxAKdsAo36CfYLWA65bmhEbPI=;
        b=nFrdjhYuQnkoVumaBsNe8tQKRacyGxkGz5ESTSNn1jczKdXdsR5x/XPAzbQV7IRwa/
         ooTgnGIQSCU9L+HQT+x9bAJibdlNHxGbc3o2lIWq7z6BzxnC0k5x/opNixMYttLifMQ/
         LZGtssMRVQS+XAv95wm9FxE+DU7EIlYH4scPN2+6SmSMCaDb4T2xrjtHmLez5/Anfjb1
         etEuv2dGII1u/2A82PSUzk12aU14Sx8AjDhsI3Ic5YtmgeeeJXKRtwB22Z5NwBaNUNqw
         fXOM2qJ/Erjb+/ruyoFwexGOVJoB/eNGlUgy/i6nKotHJ3JqOPXX/RRZE4uhoC3uYbjN
         CKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775049442; x=1775654242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw/gXvU+RVMF6do4f+oxAKdsAo36CfYLWA65bmhEbPI=;
        b=el1RcClcPx5wPY7w9tUJIyHbvR0j4740wkaVPQxT969uvEEPmK7L+BxF9X0U8jW6sM
         NlX682dWV28RHEa7zSEIbp8toxaojTzipFeNRA5GvrkEJKPL73qf0JtHkUi5Nl3TAOn7
         oVCqAzeLAD1LMaq7Lp87YHxK1/v+V0L35r96o3/dSqk+X79EzN44b9T8f0WcL2EB9pGx
         dOlJrUpZQEFqefSiVEeQ64CykwH/77GSVeyS3onQHS0cHJhQ94NoG+erDHNdokxNJIWH
         EHeVxy8HuXiI9WyBxNx3eE5GmmHm3ZwuNS3AP6MeSKccfKBe9uD5GLV3iK9v2JmN+mOa
         fr8w==
X-Forwarded-Encrypted: i=1; AJvYcCWQog0yNv1He76THA6v/UtIAAhlvgrhKpbirIpwQCnWSchPXns7xZ6Qotg5tYi09ELRZMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuFqGiTnSmXqUmJmfaagQQJPf4RleQN6TOae+6mcWy6TQ91av
	S2U17Nj5ZKVBPACJHlVbR3BXpRi//zBl6mcx7E8wRnpIh2OnUH0CtRwFpBXdOA==
X-Gm-Gg: ATEYQzy7NAljnJSoarlDSYDGNzf0mtT9F19t0OOgu21xKazmmOO/FZYbCK+Kg39tOjQ
	jEMJo/lmJQolP76duyVN/8kjo2AUVKv/fsJw7GKhnlxpfCD8Mb5umBvr5bHOi8niG4OU84PfeIk
	OxonG+LEoX7mBXv9VZZOkoiFUPLxHQVvXoysmht0ljLNO6QkE/0wD8Cj4CywxkFu+N+mPcdS6St
	Xt12rDPCQal96GPI4EsWs/pBqvT1mvzcNc8MqmGrnYe8E95vnT6PGS5NaCRlNkfnmaoRUgLH9Sp
	6aqkwfPePJCElHdYbozzyRSwRXmOfCJPpWHOI8MnmycG6hPiCffspM+Wiw7DYkUWmoLmoLfCoPw
	jWA5BGZSKNyUBpgUkgysVPUDoD+b4M/Z12w9flxaazpJUOuZ7AXBBMbfTUNSy09gL8O1r6gJZH5
	HHnhSg8Asdllzwe5p/BIxeQb8fZ4TKfEbp/jfHT5z34X52ZkRL3AT5AtMJw5PEUNDWsKAZOr5Lk
	q1erWxfx1c=
X-Received: by 2002:a05:600c:354e:b0:485:531d:28b9 with SMTP id 5b1f17b1804b1-4888358b4d0mr55815775e9.14.1775049441361;
        Wed, 01 Apr 2026 06:17:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:392a:d0de:96a3:bdc9? ([2a0a:ef40:7d8:fa01:392a:d0de:96a3:bdc9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c769841sm57096795e9.7.2026.04.01.06.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 06:17:20 -0700 (PDT)
Message-ID: <14a417c6-fc80-4a7e-993d-57fff10896f8@gmail.com>
Date: Wed, 1 Apr 2026 14:17:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] skip_prefix(): check const match between in and out
 params
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331235017.GH2328529@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260331235017.GH2328529@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi peff

On 01/04/2026 00:50, Jeff King wrote:
> 
> +/*
> + * Check that an out-parameter that is "at least as const as" a matching
> + * in-parameter. For example, skip_prefix() will return "out" that is a subset
> + * of "str". So:
> + *
> + *  const str, const out: ok
> + *  non-const str, const out: ok
> + *  non-const str, non-const out: ok
> + *  const str, non-const out: compile error
> + *
> + *  See the skip_prefix macro below for an example of use.
> + */
> +#define CONST_OUTPARAM(in, out) \
> +    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
> +#define skip_prefix(str, prefix, out) \
> +	skip_prefix((str), (prefix), CONST_OUTPARAM((str), (out)))

This is clever but it changes the behavior of skip_prefix() which is 
documented as not touching out if it returns false. That may not matter 
in practice but there are nearly 600 callers so auditing them all would 
be quite an undertaking. Elsewhere there was some discussion about using 
type generic macros to fix the warnings. That would be more complex as 
we need to check if they were supported by the compiler but it would 
avoid changing the behavior.

Thanks for working on fixing these warnings, your approach of trying to 
fix the underlying problem rather than casting away the warning is very 
welcome.

Phillip

