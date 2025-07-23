Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572D227E077
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263628; cv=none; b=eTJGslmwO51uCzDQVglwkaJQF2DO6t3Q9xZjxc3loXqwunIeeXdFAhF8X4wrtMTDT3k/SSrmx0M0+PNCUrccbhWrS7WVtp2Ewu8xRKTEctpH+wtMDz+YxSX36V7Fds8zb3tTowls0whxZIIKQE0XUNji7PiBhINj9RH1B0E72l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263628; c=relaxed/simple;
	bh=B6aMBQWYuL96fqGVvU8ESF0BYPgy+qR97rbGJDyxjQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhfRC+ak7NesWHykfj0VuqlTYqBWSUkKECbNou5oiapn+qep7HFPxc2FVpBXfhFvKwCZMgPOJprmeo2QM1LQHigmpxJMNehfpJji2nzV9jKaIEhZ0mpJO1wSx+ZVsAPIUBJg2kcAn/mCKBOHAYLLvoNVmavGGCBCmF958/6IbPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCmPEl8D; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCmPEl8D"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso52053225e9.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753263624; x=1753868424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TLh58dAIct5jRGHHvKY9aH3f7KblyzX2SCA31GW9ttE=;
        b=OCmPEl8D79P+kuyOGWXP1ddeT7uz10P7fXPfjZxynn1zAczSfZiMebFGZi8fj7p0lN
         ZUeIn6dzC96VrIJNSSAtqkrEEETVRaQP8ZtTcuyloZUY+xWp6b+0oST3TBH/ClwcsS7k
         1W3+/MtR88vPlkLJtMNMbWAIMVKwp51sjU1mgl0T7Z6El066ac2Nl3KsXCew/5L33XFS
         rPYi8HSzApvARSfE98kC4YJEYCR8u0L7Iy5LWwFyhaulOKhP0CaWmCW44Z6ZS6eCxP1H
         XUCj7q8cs4XeWFwBWwWMTWeyt17b2cgIIi2+vqi7PDbgTWrSmAjRoveyS8FP0XUEqnTI
         bOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753263624; x=1753868424;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLh58dAIct5jRGHHvKY9aH3f7KblyzX2SCA31GW9ttE=;
        b=rheCuq3Va3/hMdGL+t21OkQEtwqyuELoMd/FFha6LbTCnZnw0+542opG2yBmE62Ew1
         rbzF/0u3x1SMGMg2sht+hK3NBZYc0QU4TRX08ROhCV1xsMq7AmhEEa+elGMnlpA8+wwc
         /obZww00ak1jCwb06S1vCJLIBIw1RBgNjX/dBoUrRDYRBh6TOWR7ne2MyDsWDROyfQhv
         vqDRNStAq9ZXiI/axqLS6kHCzfOK9jskeRc/6TEV5tmWE7uQFvH5S3RDqqgsFob3bcrB
         dYRs3uhqWaBNYeWwNidO9ncZPCiwS1/5xvCbzMK/FMpsjcpmSjjFuNgQYxcF/Uvf661i
         nPwQ==
X-Gm-Message-State: AOJu0YxsKsK7qIneIqjylGwfgZ/LMbhTBfIimKT4R5XBfUdsCon8Ttpd
	0yCLNdVCFa6El91Uqz5lYZ9DS+Nrq3Nv/Imj1+jwHj4Y8GCfzjDb+BkH
X-Gm-Gg: ASbGnctNhD2HbvciwgihDZUrr/+QRCybA/UqFupCP0K6GFapiEH739xISYv+h8zAQwf
	3UT6AusvmcZZs3I7MrfkF7nZitRRzN5niOJV36D0Yj8wm2/rIvPUApWZd6z8ndzKzGEUJ8J/aOX
	5zqnexCd+WgEnqy1fQ29KE3iXVxZ73zHADdruYFqStlIZkZW4iR98LegUYulFOC4c+gSN1RzMxK
	KTghrC/8/TcOG1VaZVVfUbkro0DAL9FwadTb1lkn9svG+43seFjcGTv88r4KFdrkJslLKbXEz50
	YBbb/B/IuoEzn3wqURifFKIADrhg8xbCN2BEVIv3mChiypK8nn9uZvRvGKsKq+WwSfmbJ+s6Kgi
	/I+dDGBq2EHLW5YsIiTvZsEj+1bdJOoYbOnJoyVUMSQ4iFnvKQl/XH2EaVG9bwy68/yq40amfgm
	w9
X-Google-Smtp-Source: AGHT+IE0rFD3OGAyAbL4zcouSdUoafVK/1W34eFEKkQz0QKsjsv3oEB+zFvUpXNydbF8EJhGmarQlA==
X-Received: by 2002:a05:600c:8b10:b0:456:1121:3ad8 with SMTP id 5b1f17b1804b1-45868c9d357mr23576825e9.10.1753263624411;
        Wed, 23 Jul 2025 02:40:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c952sm15816416f8f.86.2025.07.23.02.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:40:24 -0700 (PDT)
Message-ID: <f1d3c903-b7c6-46b2-b911-0ec8c2708c8c@gmail.com>
Date: Wed, 23 Jul 2025 10:40:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jul 2025, #06; Tue, 22)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqwm7zpxzc.fsf@gitster.g> <aIB0lUS8OTq-oPw7@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aIB0lUS8OTq-oPw7@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2025 06:35, Patrick Steinhardt wrote:
> On Tue, Jul 22, 2025 at 05:11:35PM -0700, Junio C Hamano wrote:
>> * ps/config-wo-the-repository (2025-07-17) 22 commits
>>   - config: fix sign comparison warnings
>>   - config: move Git config parsing into "environment.c"
>>   - config: remove unused `the_repository` wrappers
>>   - config: drop `git_config_set_multivar()` wrapper
>>   - config: drop `git_config_get_multivar_gently()` wrapper
>>   - config: drop `git_config_set_multivar_in_file_gently()` wrapper
>>   - config: drop `git_config_set_in_file_gently()` wrapper
>>   - config: drop `git_config_set()` wrapper
>>   - config: drop `git_config_set_gently()` wrapper
>>   - config: drop `git_config_set_in_file()` wrapper
>>   - config: drop `git_config_get_bool()` wrapper
>>   - config: drop `git_config_get_ulong()` wrapper
>>   - config: drop `git_config_get_int()` wrapper
>>   - config: drop `git_config_get_string()` wrapper
>>   - config: drop `git_config_get_string()` wrapper
>>   - config: drop `git_config_get_string_multi()` wrapper
>>   - config: drop `git_config_get_value()` wrapper
>>   - config: drop `git_config_get_value()` wrapper
>>   - config: drop `git_config_get()` wrapper
>>   - config: drop `git_config_clear()` wrapper
>>   - config: drop `git_config()` wrapper
>>   - Merge branch 'bc/use-sha256-by-default-in-3.0' into ps/config-wo-the-repository
>>
>>   The config API had a set of convenience wrapper functions that
>>   implicitly use the_repository instance; they have been removed and
>>   inlined at the calling sites.
>>
>>   Will merge to 'next'?
>>   source: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
> 
> I think the only commit that really needs review is the last one that
> fixes the sign comparison warnings. As long as people are fine with that
> commit I'm happy to have it merged.

I think that commit needs a re-roll c.f. 
<2b914b60-3417-4a49-b545-3109c9a05257@gmail.com>. I haven't looked at 
the rest of the patches but I like the general idea behind this series.

Thanks

Phillip
> Patrick
> 

