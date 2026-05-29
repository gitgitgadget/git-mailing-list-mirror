Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403E3806CE
	for <git@vger.kernel.org>; Fri, 29 May 2026 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075597; cv=none; b=tVqpKEnhbKY+dg7G4C+AjrL+dilSjHE/aPUrb9RL8cUuu0/L41NQ+Wa/D8JirSbkFFeFcOKTo6MzLnKCge/8QNMZWVayXI2Kxi2xRE9um/3twMXX10sCtbbhIT5j/m0a+7y/rve6i/ealOKOlB+RqPOjws4KL2Ldj+747iHa/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075597; c=relaxed/simple;
	bh=VGtVIIS6C6jx1PwcWHJOeAoJdCet7t4WJ9/9DQBT18M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=afszYDY7gAu13ZNwu5LiViP08m4DVM6hrzr89X1vItZpAGGgvKoPp0egWr2kjrYOXQ2i4/rh7q5m30vFqxVNQsXdi+2oe42ELtkMmHqMszM22+O0MvP39WFic7FVIT8sKdTwNicsyHKrnpfxiytvtiHd/WDLO9l+odYumViMCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eviYBj4j; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eviYBj4j"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccf01ba514so996736d6.0
        for <git@vger.kernel.org>; Fri, 29 May 2026 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780075595; x=1780680395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sdau+N0ft9JgLPbS9KVgxp4GUtmrFAmfqSzZGeXMkkU=;
        b=eviYBj4jP3M47iY1TTbRosg4G45den3t2gQWDMeuX8JkhpDCeTv/sODw/6GOLhy8+1
         lIoRsefK+nRVnGEocRhcuhTpDphOTxhrFP23oVSmJxRBhvKjwQvZNb4hdtacMA/9v/h8
         RgCSdqmCbasVnF0GDNj1JWSVVc0teGZtxPuaW8VaLc34HK+iiu5E1WaUEOGIEYByUrel
         hbDIMdFjRp897dMUQZthc94FuIJAhFItiNZFJYoTLz6K1PUBUkxfQKwX2J3ZH/0L3WIu
         rcUQpneuIhIz4ccf3qll6BwMUPMA5vH5WpR08gw1fqVL6ngqBLkicxRBMsn8pYKz0yQy
         5yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075595; x=1780680395;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdau+N0ft9JgLPbS9KVgxp4GUtmrFAmfqSzZGeXMkkU=;
        b=cbkjKuq53ODcKYFvtG/isQQbBCbXjxw3QU2DGvGQxygsw8j1OP/cS73bFWuymp7tAX
         X4OYz5vz68qriCoWpM3pbyVBMrRo7xFSt+BqIunnqEcYruaSvF+niU7MUP63xtODMCVp
         XcQ/v1K9RAedd4dPrpFCYnTj0hTbpkWegnVoDqxppe2wMmO3Hj9x/n1w26Rj61GSc5Ws
         jX7zqlSTodDUO0IuYiSjvwTYDrXrD6XQXgDfQvOcUAI82frM7cXOX/Qs5hpL3LcZB86l
         EaZBNL+guI5WfJo+oK0ay0L0cvyA2iIUuZVP50UiRY0o6GlTcqkIY4xnx60MaqjDRpMJ
         qbmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ogx+IrPZkJW5h2TKRb0sBw9Bt85k604rta/SWKH703OKvzvTK7GqSWXiV5SbKm7nUobE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTl7CvL0On+fznwsaQ/OiDZpyXqvy2UtWgjuixeuwwe+FthLKs
	Q1UxxGxhUmyyFOw6g0Q5MAFyMvFzwzq9WJrN+B9GLiJGl7vdknbhA8Do
X-Gm-Gg: Acq92OGWE84CRcCxdjS+Ku/yUd3jFw9svFLhbsJVs2QasrlJMxfYsOuGQa1XY4Xi3x4
	ZbpZvLZwmC4Hg1LILwMt0BGda8FtFf8gxp44wnVPC+6BA2fpQlncuL8taygmbX3C4qDfCN3jwvr
	v/e1nij2xKqiwBvvZSXwfnbAXFLMYYkLXKqU4hf+Wlurh4oNAe1KM2mC6paAaSNCRtvU9u+4JSg
	5/JLM2T8S5Q3m+UlT/OOVWsZYeXfA2CSYEjONXfAB5tJGm9Rj40rulQGgSGtym8S5ctYl9jLtdB
	hhz98f0degR3hNcCVOT9Z/R/HNSpk09flY8NjH7OMs64Izqf6a4tOL7QzM49lSLZXCU44bbCErT
	n/vHXHY0zqqXR887ZnTd5Rj/ShNjaPzaLwm+8jHO7ioXS1L/9JccATJDWOMvF9lIA9n9OEcoGzu
	n0m9SPyLmXwtJSDLFAzsEge4P2LvafurvTZea2UP1KRZx0jsTMSbx4dpYj5pnmeTSUyJzh3CsIR
	UoFBk7lXEBZ8XW0fckEsqtJ4ufDjlaDc46Bxwgonx/EYCef5T7uO6TcoC7p4g==
X-Received: by 2002:a05:620a:44ca:b0:90d:501c:50 with SMTP id af79cd13be357-9153d99a08cmr98459585a.26.1780075594537;
        Fri, 29 May 2026 10:26:34 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:c106:3544:a15a:ccf6? ([2605:a601:9b88:8300:c106:3544:a15a:ccf6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532626961sm270044385a.32.2026.05.29.10.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 10:26:33 -0700 (PDT)
Message-ID: <22a7e32f-f645-4f00-bc5b-6b4309e483c2@gmail.com>
Date: Fri, 29 May 2026 13:26:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] pack-objects: support bitmaps and delta-islands with
 `--path-walk`
From: Derrick Stolee <stolee@gmail.com>
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <a708e23d-e0c2-48c9-86e9-1227f12edd53@gmail.com>
Content-Language: en-US
In-Reply-To: <a708e23d-e0c2-48c9-86e9-1227f12edd53@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/26 11:28 AM, Derrick Stolee wrote:
> On 5/27/26 7:18 PM, Taylor Blau wrote:

> Do you have any end-to-end performance data to demonstrate that these
> changes are effective at scale? Are we still producing packfiles with the
> pack-file compression and now with .bitmap files? How does this impact
> the performance of a clone or fetch when using a bitmap index at read
> time?

Here's my attempt to use our existing performance tests to analyze the
impact of this series.

Running p5311 against the base of this topic and this topic with
GIT_TEST_PACK_PATH_WALK=1, I get this output:

Test                                     HEAD~3    HEAD
-----------------------------------------------------------------
5311.4: server   (1 days) (lookup=true)     0.02   0.03 +50.0%
5311.5: size     (1 days)                   6.8K 124.9K +1730.9%
5311.6: client   (1 days) (lookup=true)     0.02   0.01 -50.0%
5311.8: server   (2 days) (lookup=true)     0.02   0.03 +50.0%
5311.9: size     (2 days)                   6.8K 124.9K +1730.9%
5311.10: client   (2 days) (lookup=true)    0.02   0.01 -50.0%
5311.12: server   (4 days) (lookup=true)    0.02   0.03 +50.0%
5311.13: size     (4 days)                  6.8K 124.9K +1730.9%
5311.14: client   (4 days) (lookup=true)    0.02   0.01 -50.0%
5311.16: server   (8 days) (lookup=true)    0.03   0.03 +0.0%
5311.17: size     (8 days)                 37.3K 186.0K +398.2%
5311.18: client   (8 days) (lookup=true)    0.03   0.02 -33.3%
5311.20: server  (16 days) (lookup=true)    0.02   0.03 +50.0%
5311.21: size    (16 days)                 37.3K 186.0K +398.2%
5311.22: client  (16 days) (lookup=true)    0.03   0.02 -33.3%
5311.24: server  (32 days) (lookup=true)    0.03   0.03 +0.0%
5311.25: size    (32 days)                 46.5K 197.2K +324.3%
5311.26: client  (32 days) (lookup=true)    0.03   0.02 -33.3%
5311.28: server  (64 days) (lookup=true)    0.24   0.16 -33.3%
5311.29: size    (64 days)                  1.5M   5.1M +239.8%
5311.30: client  (64 days) (lookup=true)    0.42   0.35 -16.7%
5311.32: server (128 days) (lookup=true)    0.49   0.29 -40.8%
5311.33: size   (128 days)                  4.1M   9.8M +139.5%
5311.34: client (128 days) (lookup=true)    0.86   0.65 -24.4%
5311.38: server   (1 days) (lookup=false)   0.02   0.03 +50.0%
5311.39: size     (1 days)                  6.8K 124.9K +1730.9%
5311.40: client   (1 days) (lookup=false)   0.02   0.02 +0.0%
5311.42: server   (2 days) (lookup=false)   0.02   0.03 +50.0%
5311.43: size     (2 days)                  6.8K 124.9K +1730.9%
5311.44: client   (2 days) (lookup=false)   0.02   0.02 +0.0%
5311.46: server   (4 days) (lookup=false)   0.02   0.03 +50.0%
5311.47: size     (4 days)                  6.8K 124.9K +1730.9%
5311.48: client   (4 days) (lookup=false)   0.02   0.02 +0.0%
5311.50: server   (8 days) (lookup=false)   0.02   0.03 +50.0%
5311.51: size     (8 days)                 37.3K 186.0K +398.2%
5311.52: client   (8 days) (lookup=false)   0.03   0.02 -33.3%
5311.54: server  (16 days) (lookup=false)   0.02   0.03 +50.0%
5311.55: size    (16 days)                 37.3K 186.0K +398.2%
5311.56: client  (16 days) (lookup=false)   0.03   0.02 -33.3%
5311.58: server  (32 days) (lookup=false)   0.03   0.03 +0.0%
5311.59: size    (32 days)                 46.5K 197.2K +324.3%
5311.60: client  (32 days) (lookup=false)   0.03   0.02 -33.3%
5311.62: server  (64 days) (lookup=false)   0.25   0.17 -32.0%
5311.63: size    (64 days)                  1.5M   5.1M +239.8%
5311.64: client  (64 days) (lookup=false)   0.43   0.37 -14.0%
5311.66: server (128 days) (lookup=false)   0.50   0.29 -42.0%
5311.67: size   (128 days)                  4.1M   9.8M +138.6%
5311.68: client (128 days) (lookup=false)   0.87   0.67 -23.0%

It's important to realize that even with the test variable, the
path-walk logic is overriding the bitmap logic in the HEAD~3
case.

What's happening is that the path-walk mode (without bitmaps)
is computing a smaller packfile for all of these cases. Some
are significantly smaller, but only when it's a very small
pack anyway. The bitmap case is faster only for larger fetches.

I did the same test without the path-walk feature and both columns
looked the same (as expected, no change due to this series) and
the data matched the path-walk test's HEAD column pretty closely.
So this shows that adding path-walk to bitmap-focused efforts is
not a regression on any of these dimensions.

This test was for my local copy of the Git repository, including
all the forks I fetch. I hoped the results would be different
for repositories that have data shapes that struggle with
name-hash collisions, but microsoft/fluentui is an example that
I've used for path-walk repacks before and it had similar data.

Do you have a good feeling for why the path-walk feature doesn't
make a huge change in these test scenarios?

Thanks,
-Stolee

