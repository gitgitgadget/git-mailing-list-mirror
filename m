Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7C2E7372
	for <git@vger.kernel.org>; Thu, 28 May 2026 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982137; cv=none; b=Ce+2xeTk/h29cNG42H3SVwAo5ZcsaEPljTCoUSqrmloIN2S0ByF13RzDggeiV0GyMDBpyV0Vaeu3TpLk/upxxLl5YKHKXeGVlZY3iwxT2YuGDZiF5xhBBnJJMlc98y3/K3DYIvSM4sygnRXearzxnbJUb4FjxEHnpA8uk/kO76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982137; c=relaxed/simple;
	bh=/GCabf1iUdzTxKe9rIciUOchK9C8fRhIQPJx/ZCUchY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtUaXewj9O93pipFfRh63EVFWEGiOlJuO8lEiKzJXLvf6CV8ZeGVcRRLydZWeeD0QBhQu0DF7qqJjY2iamIgbwbc+bNzUpBtkOaRs/Qyn9dpF7xGVRggiXwFtdbHg8dWpEVwZW6wDeOnMloOyV0I3SnJbJtmwvpQ2+WcvU10c9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnCNGoEP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnCNGoEP"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914beab9a08so466332885a.3
        for <git@vger.kernel.org>; Thu, 28 May 2026 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779982136; x=1780586936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wA0KhmLvIrpM1iELunY0b9FVkLyxINjmeg32K05QEsI=;
        b=hnCNGoEPwt+f31XJSQJYNKElXL46myESe0npmRXc+eVFfTq84C9Nkh9WoXp2xlZQiW
         6tfIkzJzMtgn691RG139vwGtVSBCmDwDXqk4aUU17SRs+Hc14voYvfqROawew/CTZcfZ
         URsfacvJBDDtjaqrWkdpBqyOvdsY28Ntz32w0TrsYml/76yMdehcaZ5ErQwnmq+nZvgg
         +UrjqcHWp1PLrlZ2g50odWtzv+TCrqdbNQMUdWVR5CcZF7XOeQ7PC5Ioq8jK4ITaxtJq
         /jdg8hDiVaCqCqUap8MH1izH+9mgA3a4AvMov/nyz8qBjsU1u0EgF3O+pPgTQk/yb8PW
         xoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982136; x=1780586936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wA0KhmLvIrpM1iELunY0b9FVkLyxINjmeg32K05QEsI=;
        b=Fkwn8cUqt06YThSi+95JJgcJ5IRWYrQ1u/5rVmED2UrCQL/PLqX/YEuogp4BjGy+Vt
         3jlV9vRRKDf15To8oIgdtqCyP4Tu4DN5Ed+N8p4FiXLSdCz/5E4qCYNzPZc6mnVY64vB
         19ieA+xZvIs44fyb7FD616PO7N1k9jPPURuyNYMG7LxgepoI87chtfHR/aI23T7/Qa64
         neOeNK9s/4ACxFrYoE6jIjovrCoxxbSkfSMXYLMpcjQs5t+H4vNtwNAK7hOs70lIoZJG
         aF1VBQPdPbcP43PD4WBAcHL0NZeAkgPtlcJzwpxIvlpGWmmpB5JcQ1M0NrKwCC0w76UF
         pIqw==
X-Forwarded-Encrypted: i=1; AFNElJ85rcD6CT6mKyNMlklm0wTlAf8ZD9234RjqVN1n8Lz71AC20Wq2AWDSOM5DkFr01soKeJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwybzpQ1ET5E5sFwyqfwn8wydFv162WQj0kZAcqaQhruat2Dy7p
	hXcd0Kb9hxmzz5UU1dgh8u2o+ry30QoZcm4pvsg5Er/GYhTVw23KjQxs
X-Gm-Gg: Acq92OGgpvxn7KFnGVmqcS+pNR4LGIYSzqkdUqD76IUFw11NA8W24HL6tFswZNJb+9B
	+/RljcAkWSvqvi2F1sTpsIQ1C/5tinMgWYkK86k2uqi5ARzNhM+2YAot+jdYc0uI0Y4XBQ0ySDW
	44mT6EzVaV4MB/PJRx/1PBQTddhrs5XFM4O6jNHzA4tp+mG3HhhrPwGkhKVCQINCsr2UNe8Awgp
	S/bnR6Of4u/OWG07GC5tIywJxQxFdTyRx9zJ2/qfgPEQ5drBD+c42/sQRnmH5eGkNub8FNx7kjf
	TnPzWlPjiXg6RkFtzuZAJ/gFqG1JaudT0tCyQR9SRP8grcyV1grq70cBppfQ761LiUb5DBkvQkw
	/LlGH1G9PMdetQO89HJt1f2JYVWot+g2EKggcMBglmnYjqmUSjccIicdExNtKh/SOKzIghaFb40
	tFJ/sQmUARH6KH+qWORijdFIppcRYKedEZbF7mfp6btDi5eeNDYWWJ7wUeXhKKsPBXrgqOJTPYj
	nhwI3UozUQQ5p9WU9hrKka9Q1oJ9cAc6pXIc35mI2Ny7qxPKh3n8Y2vTIN0KA==
X-Received: by 2002:a05:620a:45a4:b0:913:7bc8:79b4 with SMTP id af79cd13be357-914b49f711dmr3948288485a.51.1779982136026;
        Thu, 28 May 2026 08:28:56 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:4178:7958:947f:ef4f? ([2605:a601:9b88:8300:4178:7958:947f:ef4f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f870c37dsm847436385a.19.2026.05.28.08.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 08:28:55 -0700 (PDT)
Message-ID: <a708e23d-e0c2-48c9-86e9-1227f12edd53@gmail.com>
Date: Thu, 28 May 2026 11:28:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] pack-objects: support bitmaps and delta-islands with
 `--path-walk`
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>
References: <cover.1779923907.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1779923907.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/26 7:18 PM, Taylor Blau wrote:

> Here is a trimmed-down reroll of my series to make `--path-walk` work
> with reachability bitmaps and delta-islands. This series was originally
> an RFC that was a companion to Stolee's recent patches to extend
> `--filter` support to `--path-walk` [1].
> 
> Since the previous round, Stolee's series has graduated and incorporated
> the filter-related patches from my earlier RFC [2]. What remains are the
> three patches here that implement support for reachability bitmaps and
> delta-islands under `--path-walk`.
> 
>   * The first patch allows `--path-walk` to use reachability bitmaps when
>     they can answer the request, falling back to path-walk enumeration
>     when they cannot. It also lets bitmap writing see the same commit
>     candidates that the regular traversal would have shown to the bitmap
>     selector.
> 
>   * The second patch is preparatory, and factors the
>     delta-islands-specific tree-depth recording from `show_object()` into
>     a helper.
> 
>   * The final patch teaches the path-walk callback to perform the same
>     delta-islands side effects as the regular traversal: propagating
>     island marks for commits, and recording tree depths for trees. This
>     gives `resolve_tree_islands()` the same input in either enumeration
>     mode, so the existing island checks can be reused unchanged.

I've applied these patches locally and confirmed that each one passes the
test suite with GIT_TEST_PACK_PATH_WALK=1, which helps to confirm that
the changes are correct (all existing bitmap tests create and use the
bitmaps with --path-walk unless explicitly disabled).

Should we add GIT_TEST_PACK_PATH_WALK=1 to the test-var CI build, now
that this is going to be more commonly used?

Do you have any end-to-end performance data to demonstrate that these
changes are effective at scale? Are we still producing packfiles with the
pack-file compression and now with .bitmap files? How does this impact
the performance of a clone or fetch when using a bitmap index at read
time?

With that in mind, should we update any t/perf/ test to cover some of
these scenarios? I'm running a few with GIT_TEST_PACK_PATH_WALK=1 on
my laptop as a test, but it's taking a while. If you have stats ready
from your local testing, then that would be interesting.

Thanks,
-Stolee

