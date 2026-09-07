Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104364BD103
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787486; cv=none; b=Ft2xvi7xlISmzqR90iadl5NFZqAM96loSQOEQZmsfc0sFEbRw1KhfgzgdETEIlEqtVf0m4F07L+sQljKFCKgcRRyxdWvqscrL2z8HMwSaoOeeDXzu0A5WCZ61nmnZOoeoUTle/9+159mOJPYjTDeRpEYkxTYKLVHUtovVjro9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787486; c=relaxed/simple;
	bh=KIca0Td1frChRPJlYDM95e4TrHBvSPUR6c9pdm9lZ6E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pNUCf4sZQ/UA+pEjivbIMdQD2RzPf7vjU9pbhk8eYtfB0zZSRd83GD/y03Bo50HPtLq2/5or9J0bg4y58Qa4pXEXwJeunIZfbTe93jCpDzm35S9I6VtFvxqW9t74GwOK7abWlnt3IndYMLmalKVq98hdkPvaG7MZyZQDr5uGvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON8vQBQb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON8vQBQb"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2533d83e3bso593087866b.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788787477; x=1789392277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Z11wDs15DD9Isnj0SXoysEL+LU9An4N7zxEq3TxjGI=;
        b=ON8vQBQbk9X9i83T4kH9VUflT+iDXxsl0rG91XzQkm10CKcMmwn7x6xosikGEr3Ii3
         OO1f+KLnwr4rUXNCix1O39Yd1NwLr1KKwVHKcOl3xCLPzquUOqtQ7bFUlBs86+uU55HE
         9sv1Te8BnKsU5u0Qo/ShBAP2hVtGawBOPHGfzxJZZfVbn2Qw1ST6Qqse+uZkyzfDNOnh
         qOTPdN6pFQB3alUMtwE9s5gHOCUnpknIFDvRc0NC8dyR6rjSn8Pxl+AMZ3XUKbPF2rEk
         vdx/WWMWusadQl6MkdzK25+l9Z2AnAtYlAEzFlaYyZDD6InYvEfYeqTeMjkAj8AVntay
         Y6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787477; x=1789392277;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Z11wDs15DD9Isnj0SXoysEL+LU9An4N7zxEq3TxjGI=;
        b=OVQhti+LJ4QRpoXogOGtvJ26iA3T8/dc3WyzIRW70CtMpvu5L8I4vW8o02RKb9KjT3
         VUUO/sOGQTAiK1mEIkFqImqw1F1K5UfR7zzfbtbK9iWojcqxDvEzlFtJPkkg8gE3v+az
         7dWX6WgO8byVP9kbgw1plAnfndqI8scUUX+M1/InCTGH4ouUi3KUy4ELDpUwdnwI8tm3
         Z5FbmkuFz4wFyCogcn0WEfWW4VPjqrcNyt18Ws5JYg51QOP7Gf5HD+KQKBHMWfKUYqaN
         huwJXymJI8NdVynQLgYa0CnhuEud026BcjaV00mboHOWIqKLrs+lzKgfQ7tkX26CnnPP
         GsZQ==
X-Gm-Message-State: AFuF++nsWvuDi+f5UkhO+vDICNnyet1meovR7ibgmFwfGKZ+D76R5t3c
	E6QaqJ22OA/ak250UasrzNhGffwD4sM/VmyjiT8A8cLr1mdh971a/FFX
X-Gm-Gg: AYBFou0SWDXuH9rOJ8LPhksqJaSoW8cdPAU1QBa5mDAawwy7Y1cyYfpSdsqdJVTBvBi
	gtDnfodR36/0H4iqjNG7+mNYhE0+SIfet/gSpCKXN3qgx+DragLzG9LJWztOqXsYjy6i6lGX//o
	8wIq+jjlvSGTGuS1m7PFFsKROu809ZJ7viv4meqH7eniwyHVHH24QZwGK/1d9uui/dZd3BxZdLA
	SNYUItRFoW8MgVAUzF8kI3OuNNJO+cmt+ps7+ryMDVd/Ez/E4dZtnjWgFwm9ZgPn5WAa0maIEOF
	doZl/MH1ywQeMJhcPrujtBfNbLMfEDW5yvi0BlJT5fBbjA4hnuFJW/qittot7SEi/in2uJnwvng
	c5UUZ0AVBnwta+GPp39mcKi5bpmC/jeBX6LGVGZS1dQwOJOGkV5rqxwABHVNYHR/CU+ZCPA5tsO
	5OZWJ9MgaKuGfqY7rgaP06aQfN71UreR0RVCPNO6GS6l7F1UBNLfUFG3Ejqg71TYadali7yvu11
	kAn9jvchDNYrf54os0W9oTtV7hnl8Et4D68XrvEL8ycp/9ptyAjHTI=
X-Received: by 2002:a17:906:c107:b0:c25:ec7a:a488 with SMTP id a640c23a62f3a-c260c9780b9mr1609508066b.1.1788787477084;
        Mon, 07 Sep 2026 06:24:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a9cbbsm476351566b.13.2026.09.07.06.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:24:36 -0700 (PDT)
Message-ID: <b395ea0d-37aa-471a-a70a-6b2c278ad64e@gmail.com>
Date: Mon, 7 Sep 2026 14:24:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/3] config: add git_config_append_parameter()
To: Patrick Steinhardt <ps@pks.im>,
 Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
 <ef8087e80db18c511e31dd9c7dd6ea3d57dd543c.1788537086.git.gitgitgadget@gmail.com>
 <ap5yT0sOtLQQa4AY@pks.im>
Content-Language: en-US
In-Reply-To: <ap5yT0sOtLQQa4AY@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/09/2026 09:14, Patrick Steinhardt wrote:
> On Fri, Sep 04, 2026 at 03:51:24PM +0000, Thomas Bachem via GitGitGadget wrote:
>> From: Thomas Bachem <mail@thomasbachem.com>
>>
>> diff --git a/config.c b/config.c
>> index d9019e7e6c..e0bb29b53d 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -450,18 +450,24 @@ static int git_config_include(const char *var, const char *value,
>>   	return ret;
>>   }
>>   
>> +void git_config_append_parameter(struct strbuf *env, const char *key,
> 
> Nit: callling this `env` assumes a bit too much about what this buffer
> is going to be used for. I'd have called it just `buf`.

Are we ever likely to use this outside of GIT_CONFIG_PARAMETERS? If not 
then I think env is a good name because it hints at where this function 
is used. Isn't the whole point of this function to allow us to append 
settings an environment variable?

Thanks

Phillip

