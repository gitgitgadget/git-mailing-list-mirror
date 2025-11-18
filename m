Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D903195EF
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476238; cv=none; b=ZOsuRCAcSzWBQW1/73BvG/wGZuFFc0EEXTaC/9OPTLvLRnoXjmf6qsaKBaWi5axncMuCYzNVkvxZwg5X4aAd7B/+oKVtsQ9rCzpIvza3yYM8sco1dL8+afGDbD/jIG17WCepLmUKWG/+PeXRVBC4eRWvkwQlvgeTgV6ChKYep8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476238; c=relaxed/simple;
	bh=6VjGobYGF9Y3JfHuSY7cqyoBSbbjvj1YuIkTzYHRZ2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TicUxZsoKCt5f3AULEWTH96Y5joxGPw+3ASPx4A0MpHfgBXFXgJj0HQthwXhLkd49zwKBktvCRIedWIyidcV1jpV9xgubeff+ttNQytAgzpV01ERpGHU8bpMQbi0rS41arvBUdmgZWO6fC/ly6u1BByeR6ZNKdLTnle7dAGQr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j50XEeNL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j50XEeNL"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477563e28a3so38500165e9.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763476234; x=1764081034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WZve/GmOLokaL2Hk6XyegsySTX4Z7MNzOz6Fx0Y9ub8=;
        b=j50XEeNLm1vwxcc7i1r8cNO0fJAvI8CJn7ETCnwkeFdLwwcsgYRAKZA+YRNn6lcV6s
         /vVOj2SDDCa47wrZ3KmNIE+OsGNTwzSBosFNFsfY4GrdrWrws2ECcxoeZ7QPlzLJXa8/
         2FMm3DSTxV8Y2LhIY41RauRXKfrEWmuboqF7S1Ov18UqXcVZ34sZH+XczK61Y4Jc0GZT
         IzDXuM+6uSH/ESQbwXBkXyW+XgU0kR1Wlfi1UXYWhBE8tzs/uwVPa4+eEoafHCaN+BLO
         U4Z1bR5Wq+LH7xeUsbAegeDT7QVlxIcc/hIlSiIWAIVwv+SYyNdRJeZ8yNNhccdkmO7K
         vKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476234; x=1764081034;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZve/GmOLokaL2Hk6XyegsySTX4Z7MNzOz6Fx0Y9ub8=;
        b=hbrr0ADNGksz0vN5r1DiUwkV2mStar6SBVPZHMXnKKzagKLJT/Dl+MOMo5LpBazLOo
         2vAuxnXgLr/ueXxhYpHI0ptCjOaUPuhmwYRed5DaqhnXgib91AsPA04FasjslrgBoOkL
         HjbpAnOx9/o1kWvqFBLf64ehM2DrE03sM9VyiSq3iYexkgXD1YuJyDFplPjopMOc4P0S
         Y6h6LMlggjW4aNBWV7QU72Ad0T9jiX2lqedzWVDndf4kEouO1zIge7MUehhzj9FpdcnO
         xbW/hHSI3O0xJtT5BJ+QI9Ont3Xjp+8sK+6dEff9Cw8vCMVd15ZNv9nOxH+TuXhrlJW6
         gGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKWPcO+0hGAg2BXPqSJuuyrYFsjKe9YlCnhm+mUVc7FTEUNcBH6GCf5o8aG3QvuXYhcTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wByB06T+GPSpwTVj9PzBAiPfWM4Avn+ok3oRKYCtOZjIlGj0
	SgivIKUi2U6CFFF2Xm8PFdYo4OE+y1h1BG8TqaUwCMlzJCGRhGZnk+cEMu0TPw==
X-Gm-Gg: ASbGncu2z+D2eWqJ2bPE2PYiJPcH4jLh3uPQeesFe4M1nAazArAhpJ5+OrB+PWgCe5l
	zwMcW2r4bdh8jtpHyPqAknNwc2xKoHF6btqQddNPPTslUgq0LQWrShFoA63oA6FzaXymvlWXqLN
	WDVSy5SfH3X+nsyckM2dHkHzAPtpBygmcm+x28OdbMqgK/D4TIh4t065r8QI39mVQcVSCktLkZr
	0GeAv6gH4FCh2Bn0wzsO5AN8GjCaFHdHKjYvbJa6vxTZoOTFz6RlJ2Oa0KKIpY8VMg4mwX0RJTj
	fNH+c/86qV/WC9nYQ9jtrR+cBupsZhENnvhkf1S3hep2upnROKl+hYFC0H9DqtPzP2lPCGBL2vT
	jx6U4FCR6CRr6kO1OLnwyjZajuPGKfuD/S61NApbk82vjeU+GEetEtehFMlDCypaMwKxAkhQCF5
	jmKFKKesGI2Lz2TleLZo7zX/JZusuvcxohlVoJzuqRuad24Pmy3xoorYF8gb1zWLa38N/gkImI/
	w==
X-Google-Smtp-Source: AGHT+IGnBKst99LUpx2ufXr5Zsay77ChyUp/Ogp5VOYw5jYxIg7c/scg+LRqDs76UeZfkR5L4Qo9Ow==
X-Received: by 2002:a05:600c:6908:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-477af01997amr8346405e9.7.1763476234277;
        Tue, 18 Nov 2025 06:30:34 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm32560364f8f.24.2025.11.18.06.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:30:33 -0800 (PST)
Message-ID: <ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com>
Date: Tue, 18 Nov 2025 14:30:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/9] cache-tree: avoid strtol() on non-string buffer
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
 Taylor Blau <me@ttaylorr.com>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
 <20251118091218.GD529192@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251118091218.GD529192@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 18/11/2025 09:12, Jeff King wrote:
> Let's fix it by just parsing the values ourselves with a helper function
> that is careful not to go past the end of the buffer. There are a few
> behavior changes here that should not matter:
> 
>    - We do not consider overflow, as strtol() would. But nor did the
>      original code. However, we don't trust the value we get from the
>      on-disk file, and if it says to read 2^30 entries, we would notice
>      that we do not have that many and bail before reading off the end of
>      the buffer.
> 
>    - Our helper does not skip past extra leading whitespace as strtol()
>      would, but according to gitformat-index(5) there should not be any.
> 
>    - The original quit parsing at a newline or a NUL byte, but now we
>      insist on a newline (which is what the documentation says, and what
>      Git has always produced).

I think that sounds reasonable, I've left a couple of comments below.

> +static int parse_int(const char **ptr, unsigned long *len_p, int *out)
> +{
> +	const char *s = *ptr;
> +	unsigned long len = *len_p;
> +	int ret = 0;

This is signed which means that any overflow is undefined. While the 
existing code does not check for overflow I think it is well defined in 
the presence of overflow. It also means parsing INT_MIN is undefined as 
we parse the value as unsigned and then multiply by -1 if we saw a 
leading '-'. We shouldn't see any negative values apart from "-1" but 
given we're changing this code to be more robust in handling malformed 
input it would be nice if parsing INT_MIN was well defined.

> +	int sign = 1;
> +
> +	while (len && *s == '-') {
> +		sign *= -1;
> +		s++;
> +		len--;
> +	}

This accepts any number of '-' signs but I believe strtol() only accepts 
a single sign (the standard says "optionally preceded by a plus or minus 
sign") so this is a change in behavior from the existing code. I'm not 
sure we really need to be that accommodating here.

> +	while (len) {
> +		if (!isdigit(*s))
> +			break;
> +		ret *= 10;
> +		ret += *s - '0';
> +		s++;
> +		len--;
> +	}
> +
> +	if (s == *ptr)
> +		return -1;

This accepts "-" as a valid input, as we're tightening up our parsing it 
would be nice to require a digit after any '-' sign.

 > [...]> +	buf++; size--;
> +	if (parse_int(&buf, &size, &subtree_nr) < 0)
> +		goto free_return;

This isn't a new problem but if subtree_nr is negative we end up trying 
to allocate a huge chunk of memory. If that somehow succeeds we then end 
up calling die("cache-tree: internal error"). The existing code looks 
safe but it would be nice to die() a bit earlier if subtree_nr is negative.

Thanks

Phillip
  > +	if (!size || *buf != '\n')
>   		goto free_return;
>   	buf++; size--;
>   	if (0 <= it->entry_count) {

