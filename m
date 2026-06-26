Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0273F4DCD
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479570; cv=none; b=Qcpu/5JICDzynC4Hyvrq0ecDM/81VX/oLMzzKMx9BYgO+ZpmmN59AmOnRn3flyigI5dcME/gZs30qWKWaHSkG8z+8rDM0i4g02109Dd6AYbCfTfQZK8dqwaHCNEmaOEhEtK1PtR7bXoG4pGjLbvhjOGyMpZKkaV1V79pXdvVlt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479570; c=relaxed/simple;
	bh=EFEOsRMeyxlhvrdM05lw6m8dAy9agjOMw5bPvNMy+ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIZ6UIXImjleeDkQoiJ6pyqzTABo+5zEenOkGn6UBC8QCB+5fRnQw3yn0BDNYySeccUo1Zha+zqPqMqy3RuXj80Mat1O+JjXecWGqhT22NONWL1ojudxooByjBqwsnvq4018E4Ukv63W8Fa3xaj9ZfJ6N4T01wPKngxc5YMwFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jymxAB/h; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jymxAB/h"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so6831995e9.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479567; x=1783084367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8dGI05z5TZplHU676w4+8p6oiw2a8Bl+67Hk87jPFBo=;
        b=jymxAB/h5QHZD543qEqcRv+Gxc1CAK5rg9GTWThz/V4g4eGj9ebzric/q9T9SRPQ6V
         7yX9MhFqw1yc3UOm1x0UbzxJn/Af9lvKRMTpJoGzG1Yp59Ly1m4YBcLlEI0rRh23PIu3
         SdSbNFaSSyjjCSPPLuf8HSi28X2ub4/hUdRI5hhrnhHtkPKHofqEURxf2NM4kVjVVdue
         W1Fvcs5L2YxXUSU7e4E2n8RkEYf0fwlPICeePfElACutyiQ0LZm/S+EPd+PvhR7pXd56
         iycSlCHT5ev7vR9LteL8K7s+BVHmuqcMaAfZyoWA8X/F5gG15fGdTuwzndGjQK391IAT
         J6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479567; x=1783084367;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dGI05z5TZplHU676w4+8p6oiw2a8Bl+67Hk87jPFBo=;
        b=UtfJj8X0WquAbhYqq5lJ9byirxrr6y2po8jSrN7CfokbhFv3vnTNKtUsiHyQ/CXoAU
         XRnSA8/vUtW+0ObUmdGkTUqUnJQ5xUptvOS7Kk2CEe4CLVhuayLHv0FPnCTlBWnHaQ2Y
         KkxLcYu/Mh8+W3T2PFQ5NZRwrkXV2zdNkqiBCbvp41atG1t7sZgfu+cuPhmHbCG13iyA
         Mcurj/JQ9rd1RzcOqiArUoCtlvfIeMnQXr+lFfgYq8PMox9GjDyF8rMHzvZlsGcgmYJe
         s2aIYQgniy5xOE7MGMaHtFKu40FbH4jVroMbu2YqG6oa52xojeANtcfTg3Mt8Of3m3oI
         qapA==
X-Forwarded-Encrypted: i=1; AFNElJ/W4T5PgOdUBk50gWZ2uzSZzw27iwEccqTMe4z9khhc3lhayqx2sHvo3MOXjbIB2IXj/wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAx+wJpJt2zK1firex9oNpqaZ7X3xm/JgtQMEeVVXKffSlWfJ
	5f2GmjU6rtqg2TqPGez8H8kQRmLkfKk18z12Tmu6OBz1xivfvH5ufzN1
X-Gm-Gg: AfdE7cnpcm+gleuP80p0Z7GHpFLwbTMwjd/NN2ttXS/zrwQsnGe9hw5ZWJWXnGUolEn
	G+H2CkNPsXwxXK24M0+DEUnElvh+bGDtjiUXUHu262jWUwGxhFgpfngrf88L93Ff+kL+ZGMO33o
	P4sRpHjHMMLlBXhsjWLUq58Bj5pt8CAaWWZ5/Yeoa1OPch/cjzGUOwNdu4ln138gbZdtN6VhJau
	ZbiS9aLti2rNtS+MM11f5inSVMzwuLQSJ3CMOX6K4WkONnj6oPN48sKyGvilpN+AMkiOsJN31T8
	NWv4/nf6hgoRHyDchVqBgXm/UQBiqT6oNIZH9fyMkqKQXbEiwPLRs3egIlWFw23QOPmOEOT47Ye
	dPl7vZcgj146W5CbSsw4BDIJyquDlp/WEp774G8BiiH99F2M7h8gZYGYKV7mhtx6xctRU65lbbk
	jx/ccspwbfJ5b5RTa/3/GxYR8OLUXSjAV8oON4uIX00e3wUQ7X3OJl6EkBvRGGP3q6kDQ=
X-Received: by 2002:a05:600c:8b25:b0:492:40a1:1e16 with SMTP id 5b1f17b1804b1-4926684a70bmr103006645e9.8.1782479567224;
        Fri, 26 Jun 2026 06:12:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c02088dsm42534285e9.0.2026.06.26.06.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 06:12:46 -0700 (PDT)
Message-ID: <4654a3f1-bf79-4c3f-b121-16bb3ab25f07@gmail.com>
Date: Fri, 26 Jun 2026 14:12:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
 <CAHwyqnWXaG1HGunztVgUdWnVogqCHRbxh8pcS5fGA6f3mB-nEA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnWXaG1HGunztVgUdWnVogqCHRbxh8pcS5fGA6f3mB-nEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2026 10:57, Harald Nordgren wrote:
> On Fri, Jun 26, 2026 at 10:53 AM Phillip Wood <phillip.wood123@gmail.com> wrote:>> >> Only accepting a single argument is quite limiting as one
>> cannot say
>>
>>          git history squash ^:/base :/tip
> 
> I don't understand why this is limiting? It thought it was clear that
> it should be one argument REF1..REF2 ? What does '^:/base :/tip'
> achieve that '^:/base..:/tip' cannot?

'^/:base..:/tip' is not a range - everything after the first '/:' is 
treated as a regular expression to search for.

Thanks

Phillip
