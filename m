Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113255;
	b=G/WYEzzKeGiDETtB4Y8IEjMIgE5J2CJji1VwTjqIVHxjcFdeAd52Xkrzbr2Ol8KqW6ZY
	 mDFfC3tGL/giGZg93MCVIudT1M4dV8Mr0GBawlT1C9/EZo1goz7sRbAkcr6NqPc4TUBqa
	 1eDXsdzQ7ceK/fDlpk0HYq2TO7kEWn++zHoBIXlVS9lzuHsj9zQ2QxVCN5cCj8XkK+JcY
	 vcMm8MH+vFnbTcYMJ+LEPxxOeg8sKtlGoxOiWff/bx7YCiISS974DsNBCSctdlahyHFin
	 xvrtW2FxBK8JMajd9O5slhTFKptPB4NEpGbNLZT2mYk+GxznQZeMDwRdfUsBW+5jMBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=owp5KVa6eA7H54SGRKt8atEEiMT6OOJiCidZmy76KnA=;
	b=IEpjJtUsHm7X+swqi3ar9Ym8d5KG+p36BnbCWCZB8L3qCOf8njJjVQI6qDeLQaPAa5v2
	 GrRyqtiyz8+M3D0PK4puxcBIGebd/BnNbVd0qdUxUW2cdU1W3zOJP0GW1YEjkwvMnGDRW
	 vM5SAOGXI1qIKD9oJlIylelC1CCj4hTVOf+X9/9wRaYsM4JF968TojwyXlH0P5TpXHDGD
	 IkUiEatALtQ/SCduCJfLlVQsdG8qse2spvMkVvkX8DkjB0sjIoEtVbiljhfkdef4WUtDi
	 udLABZsRj/LVC+n9lTk6dJoteS1lyq3CxDBWUEPkDsoLMC5ZBQXPbDAec0F0BTzPMoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtb4VFxb;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83232606A320
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83232606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtb4VFxb
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso3017254f8f.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113254; x=1793718054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=owp5KVa6eA7H54SGRKt8atEEiMT6OOJiCidZmy76KnA=;
        b=rtb4VFxbOH/c1jEzDkPb3OBD4haC3WfVA+9OySsDFnoyUQ28+o8fhkCmozFGWY1weJ
         z6MMmRO3zG2bVhxcA1oSJNyrjXLQojkMUxZlXpVtRqHDubufd7HF3hYwSDznMAvlTtrU
         w9fZ+2FCmWsVvMx9AAKZR/MlgQ130JJQfi3H9XapYTGWJeMmxDbmlItSGJrmeh8MC2LI
         TVcedT1DE78/1IAABntSQTnOd1HQvX4qZ/zgUgimcXzakkbCxafUm8GaZTNkY38zD/fW
         5pgCqlKDb3yLpZRa1McCsfDLG4buJEDOkHn82XN9n7+Gw3VfNiPRB/qrV3lBEYhoQ+D0
         Mwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113254; x=1793718054;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=owp5KVa6eA7H54SGRKt8atEEiMT6OOJiCidZmy76KnA=;
        b=nUTkEiafROqhyps+qAbSfllJsGhnotXI4xBt66vio0E8e9ywqHrd/2ifq9P/dIb+5J
         zgCs+GVxlcBNGigs0GRtBwvhIr9uHpPD20CepwHbWehLaHV+NQU99Z6BaIFHAWKMGUhh
         V28XtRJkExijUwdKyiZm4iKSPxdiqtfQjUtm22I7vV1Vnegzi6D18zGrP6SmxJ79xWBz
         lVmXfIFbRA9EIgkoaOk8Hgf85wDa3zWo3iP2+Yi7YQtbxr+eHOJyxiJnw9f3ATJc4V8y
         d8W1dcIxYv/SC3vIf5BhdMbZJCzpVbWEztaDQNgHxB+pk6Vkn6ruxvtpXKr0Ry2O4/+x
         75yw==
X-Forwarded-Encrypted: i=1; AKwUvBwnAS6Q91nQpakWkIfsd8v5LhLnSXtjvssclrCB50xt/XxhbMZEVVE9MxdvU1uKyQpJvGA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ021bOTtsuysVs0QFVpXWjDlX8IipyBq/xA2tQWsKL8sT5Usan
	QUTWvuoU0ARCUzbH8/DUgS5NzeP0M97GhvLtSXtgLijCl0zI4oQ8JLGM
X-Gm-Gg: AYBFou1/7lBaIzkq2a0dHpZOmmhHiz1G44Bc8DpTTrwlX1MeT3buc95KZtcoKSAdWuf
	mbmWuZ5Rgsj6lkwM1iMCp0+2Tvlqbj8eCyJc92e8IL+zchcA1N5Oq3LAnlnd2DuSx7imTuq2Abs
	qXrTmhlBhIrojmKaidW0i5MygwcLmgVZUUvXOYiqNAjMSraxyozDkfOoBAxG4kjBfntuB1256MV
	3Qfv3+/DZ9kM+wo3YKxP1zidX4FsiJNYnOkQfrcEEGFe2eWRozo3UYK8aECx6t52B78SGK9OAXl
	BaTk/urIRAQzjsJH6H/U9ZDX8HecEx4jQ9XWUy3+2PrELxunVzYdlJ/sfYalpL6JHr7cWGwbK0h
	HEC+DdYBn9fTata1DmF8UHj67vwfQymzKKOcmRglnGC7W59qAaCl22W+djRei2rN3vcEQ+DYxXC
	ttX75sbj5gh0DwKyGTaPCZ50WQkMJUpIvJkUORch8DIXSiM5pdJw6zXesamZXJGocKWWqgURyT/
	q773GjnRRDIbcS17jHmsjpDDh38x2I6tV/DJQgb/7xQdSpwSNIZmSZpkTq+dJqWYFBeCxNxvVQU
	pSGVUXaJIJici6Jm0qMVRv2ucF+FcWidjw==
X-Received: by 2002:a05:600c:5246:b0:4a2:150f:1609 with SMTP id 5b1f17b1804b1-4a35ac91c79mr200549135e9.8.1793113251472;
        Tue, 27 Oct 2026 08:00:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm320264085e9.1.2026.10.27.08.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:00:50 -0700 (PDT)
Message-ID: <e1d49985-0ce5-4411-aab7-11d90969363f@gmail.com>
Date: Tue, 27 Oct 2026 15:00:48 +0000
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/8] ci: consolidate test variables
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 27/10/2026 08:18, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series consolidates our test variables as a follow up on the
> discussions in [1].
> 
> The series is built on top of 37b3475fb53 (The 9th batch, 2026-10-25).

I looked at the diff for the whole series rather than the individual 
patches and it looks nice. The changes to move all the job dependent 
variable assignments into ci/lib.sh and the removal of the 
linux-reftable-sha256 job while maintaining our coverage are very 
welcome. It probably makes sense to disable rust for the sanitizer job 
which is aimed at checking our C code, though if we end up with more 
unsafe rust in the future maybe the balance will shift?

Thanks

Phillip

> 
> Thanks!
> 
> Patrick
> 
> [1]: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
> 
> ---
> Patrick Steinhardt (8):
>        ci: consolidate setup of test environment
>        ci/lib: always set GIT_TEST_USE_SET_E on Linux jobs
>        ci/lib: deduplicate test variables by pattern matching
>        ci/lib: merge switches for specific job names
>        t: honor default ref storage format
>        ci/lib: add another NO_RUST build using glibc
>        ci: don't override initial branch name in testbed job
>        t/test-lib: make feature-testbed job more accessible
> 
>   .github/workflows/main.yml |  3 ---
>   .gitlab-ci.yml             |  3 ---
>   ci/lib.sh                  | 34 ++++++++++++++++++++++++++++++++--
>   ci/run-build-and-tests.sh  | 44 --------------------------------------------
>   t/README                   |  5 +++++
>   t/test-lib-functions.sh    |  2 +-
>   t/test-lib.sh              | 25 ++++++++++++++++++++++++-
>   t/unit-tests/unit-test.c   |  1 +
>   8 files changed, 63 insertions(+), 54 deletions(-)
> 
> 
> ---
> base-commit: 37b3475fb530c14109211faca33716a173db61ed
> change-id: 20261016-b4-pks-ci-test-vars-consolidation-8d0c6a53ca28

