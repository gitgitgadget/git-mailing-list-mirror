Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198000;
	b=bd4OiGkst6Go5Qox3uuhiEpZ/QsTD+Xav+7u/6WkEHPFNKXXRBfYFd8CRfpmnyl999vA
	 lXAYn5T/qs59HUJ9Vwg19AourMaXcM+7Bm3TXDKXTxrX5uYkVHHTMIbYFgAHRoMkxA49X
	 4WQmYFzvhgOXmhC1qm7wGuizadBB60KLyRdTCNRF/pdUkcLVRCe48J9dLJhqdiTJAr3gR
	 kDj2CV52kGLWIdUvC4WET7AF9pq/rp1OjZfAhYmHbCtu9rfBE7ifGJ0jaZsdSQ00YRmxU
	 YQKF/Tuwwvy03yWPq+6jmddP875YEhNTubHqvwkGZcS0jOSHOlHtMtbNIpD8Bt14Rpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rQyeMXTfVVSKAygEC7rCSkZ7Jf6Ew489JajaZ+PduHw=;
	b=oSVXyPWP4z/tfMWA/bGGAeU0xrSVbwaukQAoahpWRYZExOptXa7bSt+c1MNPHNv+cL48
	 vGa6pKCmusM9AesJii908F2eUUCYswZksL4NwAGGhP7PXX8hvCt08G+43eYzlNX2qbMwO
	 WelA/jUkTldpv5EURd5dzVF9FShHrN2LunMDORbgxJgyFQo4FAKpTLDBEY7VB/2sWvbwX
	 dwbwwGIwJNvfbsGU1XUMcmO93xx7eviejPdOGHW8O6iDacBvU33hv/Ef5dJUevLEIaRq6
	 KeVMl9Ntg9TcBmV64Z0ceC/DRHRvsRFcDRlMRy2GN9njOhwBF450QH5+cvFSNiCOZtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r/Fwu1qk";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA335606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA335606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r/Fwu1qk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso8975655e9.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197998; x=1793802798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rQyeMXTfVVSKAygEC7rCSkZ7Jf6Ew489JajaZ+PduHw=;
        b=r/Fwu1qkJAWtec5Aatc/WbBjuEM1jSxjkggPNDF5cnM79acwy7IceITh+JHowegrwp
         5dRxCw4DWh3U2gixz7liyTKbKvMlL6Iuk0D5HiohrEnMVFquDBFFdubiOSerVBDezrYi
         16bSlvv4ejOxLXo2JDsXkOXy33jpdZG9TzlxuSgzwfOGhdL2+W/GesRdbApo4TUmkJxA
         bWtmbIxQJgaHM991QvJ03zoSzNyKMsAKm/DHLkh1XXvO8v9p4hhc15wLKpB2F+eemCqc
         wahxjD/h8Ooh8Nt+h41V9mmZcOHqXQmb1UGZEiVT0tpN3wcp5Dz9VOmE9xpVg2sdpEOk
         oQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197998; x=1793802798;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rQyeMXTfVVSKAygEC7rCSkZ7Jf6Ew489JajaZ+PduHw=;
        b=DYHLUmRN9hAIdEJ0zGNkoJsRWxY/F5tInHeumoYovaCrYK2TVW9Frly5rmq2oaAukR
         6ufTdtRmV+uW9ooMc/ODFBqFlMN9YmEw5VMsDXn3JCGJmlNs6tAhC7+k96XunMwQ2bR8
         5IpJSZ/15n3bR9WpamIf6pqHLl9M7IfQuqnM3A7tVbrU0HT8lpkRQ5d8aZv4H2qUC68O
         Ta0CabbVVD9W4e1Ow0NuKbmobfgxPY96BSFSKPh2i7bRjJWTv+WnQOephUrsjn9KLRaI
         UaR6RfoHRJZVM/NqU3q7h+eyNJGHcGF+hdccdKQC+lFGUfWsU/G25kjBog+tqgmRUkP+
         EpPA==
X-Gm-Message-State: AFq9FYKYGmwR1wAqGqCMF2YmircX8QYD65NxA7LQqvcES0H9J++tPt1J
	z8jKj5cKHRwVH26qQRr4rajRqr5zGKmRm9b9R+I8rYSDJMbXPw5xREAh
X-Gm-Gg: AYBFou2SfdmMhsh5bpVq65ImT/o10eNW1enJyOq4hhWJasOX1NGZIxi56Q1TXhfpTCN
	KW2SRQiG9JT0SGLnI6GXEm7gQ8cvP5NI2esgxADJOoG22+o4tpNdpreiVu4b8s5zYakIAcI0toz
	5w1JgoR3VPurardZYvIVsbaNTq9eAyEiACq2BEo4pafFLjRajnbiKfGCn/5CgawzU1zOQzCJHHg
	FUxtnubTzD2VB5okD0J9e7JLvNbzxj/LzzBqmhmvWbwne+ygGwUvAOGQG6edI+3c1fweDGR/lhB
	2ahXyVS3BbFmrJQsuzHOPpQJx7bVoMfVOr1MKFCZfS05IjYf2fkZXcw04HjBhB5LqDBr3jejLpW
	orMAVWSSGpBR663F+bRf8oJKViWCrTXRxA2oQXBCyy2jIDGVq8ruv/dtC0KC0pFDWmVt3VxJJm+
	h6LislskuZZL8gfvMeogC0cD+YdYGml30mgKJJN2nR7nvFfjbcr3Uy6pmr3oyyd2eQW4gGN7sF/
	iFe+vyUbamcyyZu9r/0G9g58uyxoJh/hDCEn5rsbR2roInbCi5dRWzCZIC6EAfmHQhaVA03P+w4
	tqQLT7jn8hSu3pTVasPa9/euamgNdB0WtizsTEq7YZs3oKjiVK3+sP+vjJFeNfSFLzqrE7tJ2zD
	NMWOl8Bo=
X-Received: by 2002:a05:600c:19c8:b0:4a1:df52:3e36 with SMTP id 5b1f17b1804b1-4a967201e9dmr56758085e9.27.1793197997961;
        Wed, 28 Oct 2026 07:33:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a976010d2csm50074335e9.2.2026.10.28.07.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 07:33:17 -0700 (PDT)
Message-ID: <617fa828-387a-4f4a-bc85-099ca691bca4@gmail.com>
Date: Wed, 28 Oct 2026 14:33:15 +0000
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
Subject: Re: [PATCH 8/8] t/test-lib: make feature-testbed job more accessible
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
 <20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
 <20261027212349.GA774120@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261027212349.GA774120@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/2026 21:23, Jeff King wrote:
> 
> IMHO this whole thing isn't really worth the complexity, but if we are
> going to do it, should it be "make FEATURE_TESTBED=1", and then that
> enables the right build knobs, and test-lib.sh respects that variable
> coming from BUILD-OPTIONS rather than the command line?

If we want to be able to recreate the CI job locally then I agree a 
Makefile flag is a better solution. I seem to remember Ævar trying to 
add Makefile targets for some of the CI jobs so they could be run locally.

Thanks

Phillip

