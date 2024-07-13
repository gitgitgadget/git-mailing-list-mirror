Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7994A3D
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720877238; cv=none; b=jdJPWBwtS2rqCaAXOUB2bO+2ho5kTi4NY+8pul441erEAWF8b2krSXbHqOx/HILw4X9+6MNIbH0YPnX2130SsaigYKdgZvPubi0KXRnxcY8DPriTJT4buV+pqQrHnvY/DzG952s6Pg5D1yuZOaIMOK1XEdvJOagfZBltbDS1Aag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720877238; c=relaxed/simple;
	bh=t7GjW6KOVo60b6ZoRKIvbsVDAN7tadDQbjGYAJEWOK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWmmlS465atHEavUvUmaPDbP+vIAUO+as7T5aciffkp1lnE0xnO9AzeEA2PF61wzHvMhXs3shWtwHLnpUNAWxQZZ3BP2CXO5V17UVeqhAQJGQGtktLZwxph0baNWyXzZha63vYdAot5OuE/QPis4r2/dAhxgTy+30p6ACvoB33Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRvf982y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRvf982y"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so18960155e9.1
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720877235; x=1721482035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2kmSnJYL1b1VGITrlNF0u2OQhqQnK4yOqoFKniefjpo=;
        b=YRvf982yhzZPEYrO37fJtLegM8aiKas3GmzneQ93UzZW0ODsYH81k8RzQ/3c5QNxsB
         4hF7P88YgPMZff1/PZpNo7WyQ/WjsTuH5jhiudhvsaVjLVye6ug1dbXto15h5Ysdvm3x
         a6GCNfPJVWQ5dSAUHERHaHgJAMexf5lmU3rxPAoSwkbbqyLcL4f5fop/QNOrjfDd3Q1O
         fETYwAZLhnlRTiNRul6Q0alGx9A6RCV7umZfzIVp6W7EKupj5T1ipMMq12HIJYuV4rsJ
         EmEyBT9ocSfQtzVkgma64PlyJwA4xHNN9Z9erZCCZfjdCWVJpj/bKJsKexcCfgezbwgp
         ffpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720877235; x=1721482035;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kmSnJYL1b1VGITrlNF0u2OQhqQnK4yOqoFKniefjpo=;
        b=gbyJFSPA60K+BCriR0AXpMr0sSY7BI1KobKlsTkCyIrC90GdXvK7nqWmnCYIIUqNy4
         rp694Mfszkbev3FZd+D3JDX08hCNHTguPznrZN162My4wJjdSk6ogqIXZUxBozb9tFdC
         J5SaK+pSwPpUwuL583BI/exkwbHBIsYBJlbz156o8dxJLseTjUhKXyqVo7y/tltAQbFC
         /ejeQ6fP7V7X3IF5EaJDTzUUCqToYeIitkrn2H0lnDhAmvEOPmAcD37xNFxjakzk1s6H
         oWk9+Ea+4HOakc1xCbSVC3feHk65fYkOcySTY2OTF4qeuPHpk3m/hv0qa9dKFwns5A0E
         hDpA==
X-Forwarded-Encrypted: i=1; AJvYcCUVkXEB/R3oQ46epOg/nxogSxgwlNAov2VXguVOfX4wwLHOSlPw/a6ltQ0MxYNrahjpsTcXSmtTMywesATJJVj6BgEQ
X-Gm-Message-State: AOJu0YzActnLLLjkSOMMt7T4qM0wR5PTghgTK5D2wot9cwADuw09+9si
	KMCTXDHiZS/4PpaUDJGslWiDi+GgplzhIgXvhRvPfYARoTNHVLOh
X-Google-Smtp-Source: AGHT+IFDOFud1xUD+FuVcLgw/lyWQZiYxlZUHomcOVtq6gxiMTFc2j3qEn0bLxHa6GBMzUFmIOWmIQ==
X-Received: by 2002:adf:f288:0:b0:367:9851:4f22 with SMTP id ffacd0b85a97d-367ceadb1bamr9199231f8f.58.1720877234833;
        Sat, 13 Jul 2024 06:27:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db04748sm1386609f8f.102.2024.07.13.06.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 06:27:14 -0700 (PDT)
Message-ID: <954d67b1-8819-4bfc-ae10-f04beca5419a@gmail.com>
Date: Sat, 13 Jul 2024 14:27:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 Git List <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
 <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
 <97390954-49bc-48c4-bab1-95be10717aca@web.de>
 <8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
 <6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
 <62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>
 <69ec31f8-2cac-48c3-a513-0f7f21607c88@gmail.com> <xmqq8qyblwpn.fsf@gitster.g>
 <xmqqa5iot01s.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqa5iot01s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2024 16:34, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> So, perhaps test_if_XXXXXX() but it is not quite clear to me when
> TEST_RUN() wants to return true, so I cannot come up with an
> appropriate value to fill the XXXXXX part.  If this is about
> honoring GIT_SKIP_TESTS or something similar, then I may suggest
> test_if_enabled(), but that does not seem like it.  So...

TEST_RUN() returns true if the test has not been skipped i.e. the test 
should be run. At the moment the only way to skip a test is to call 
test_skip_all() in a previous test. In the future I expect we'll add 
something like the "--run" option we have for the integration tests.

Best Wishes

Phillip

