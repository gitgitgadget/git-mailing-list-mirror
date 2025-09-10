Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7322580EC
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518327; cv=none; b=u7v2K1k6hQmqboaPSGnuxkFOU94c8qsfnA6LtM/SKoy50s7Z3bpJqyLQknU4zvypDF4bnzxBk3vKpTik5BdJAyfaUTWebaumz72PzkFzvPGFPXSaKZb1orEfJYVhTKSeVyBy7oxWR+VbpCGpFyMLYcMacKW0BTZIejscR4oDqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518327; c=relaxed/simple;
	bh=nQX2MlRX8kSH5FW+nD1OVsihiL1JnI0i0Arvyojf1K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l/6Uqj2B4sxaQjEOzmanUTu9JuWr8YTkP/M2dM12eVPT6ldnoDNLtZ393SvGiQMuE3x4TCRmYPjwpG1rKDbFu5RNYeU0RvyZTlyuhwumpASwIAjSDScKhYvCx3UWd2vg7T2nrXIjPo4Tdz7eGOvEUhYG5SAJTLbBIZ2XiuQMfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPRkonKy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPRkonKy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45df7dc034cso7977055e9.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518325; x=1758123125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YCJl6vuxkq+M7A7+SWIEOi0dRVoFA4rnVsQAI+sUP6Y=;
        b=iPRkonKyCLkjCio91F1HirwP1PvSqNc0tKFShNl8D0dn/AOdhELGv1+REDk4GjiI4j
         lG0qFCfyxI+CEniEZHDbieNjidPPHb/PCAgWWVEPKHBpeeGHYKhx51hA/AF8xr1Z9r7P
         bBgviC0Vzz3tLAeJG+JY6eO6w5qLX8zsoFEU9ag3yCha85UW+u/uSILifaj5oZyACGu/
         ql+SKRVUxcl2HxLi8ellTBbkc22kdJYHgSom3zKpT76A5MsgYBigZLYuml/uDd0A5BpF
         B+7nZwYvmELkfIBHsPBRlCQmSImzH5pKv2Vv+TEwBrv2+rJOPz0a5D1bCde9PzkYJ7zD
         4Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518325; x=1758123125;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCJl6vuxkq+M7A7+SWIEOi0dRVoFA4rnVsQAI+sUP6Y=;
        b=ldWz5yLg0RUTBXxVfppa5MApaWRTCS/GPZ7EMzYkMo7WLksyUEHrfa4el0vanq7HJH
         Bu+kgN06Q/1IyOxVGq7LBiHeWGCIueq/6GTdyIfvDHRLJHf+5DNFDqVh68L/2mvKFvQM
         mlXIen+iXDDwh57Eatf9VuseW+bNYreepQ4B+4XLrJkGKHpDghg244HIps2S0HT9Y4VW
         lmx944WX3WWf9XCbb42Cj0KvsKe4qLm9+9BQy62kem7ru3cZkL0RzsRrHJIixyxCbZ7r
         m4Z4bul+sAmn0jxs6CeiBLvzWKRlbpoKQWlUlDYip23eXyJRo47pTtsGeeX82K36SG38
         qtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWWGQbtc2PyuCbX3kYNmVqd6wBwvICWiHSlZG4QgOyasoAKShh3IoJV7afeEybuVzYE0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+3SS30Tem0LeURuRaeJWUoRCTsc3pUYFBnCcn4UiCNLFoKGp
	lD0FUaHEpZhZyEPLlEOTTRfAXFzJhzFjvCm16iwKjAbUUyqVi5gnHwkqAuPPfw==
X-Gm-Gg: ASbGncvdAcHen0Gh2Dq2UmTjg9zT4sb1x+t6AwKp0GXCNi5HcR+9yg9h+NeQBvMWmhW
	ndG7Id9+4132y+s5iJpQXtLdeuznZFY2mCzbSNka3k0yrB3D4w3urJ6CwFykjfkYXcIIbxTD58o
	mJrX6WIfyrb8yNQhs3N9hSOtK7YRkMYra545VVBm+kODnJS4tNLGatBazgwDmpGPJ35lPjM0Z9L
	CpPKiwidu9+3mT38aMYasuIYKS7+vpKjM/Tb6d3TqMMELUGPRgIxN7+5eUYDHhwi7T3AWI1Bf2B
	KLzmr7q62N4JfbgbOS7VVfLBU2Kfj1JwxvXBBC59cVVQYJLFfk5y53w3M5HIhxPSkPgKpfDw2AB
	8rGWbMkFua+EdMilO/HoqAKhdbx0Na48TVeMg+jcwxIiT6RPOeZUwZySULmJ2C1zpbWFYQdSlrF
	x2bo0eqQmxBQ==
X-Google-Smtp-Source: AGHT+IEk80mSXEP6V+5yjXw5YEXHXZHsp36buIOyfnC2ETyd79TcCy05/n/UVHFGocY2EKPQ5QIV3g==
X-Received: by 2002:a05:600c:3113:b0:45d:d403:332a with SMTP id 5b1f17b1804b1-45ddded3626mr144883205e9.32.1757518324251;
        Wed, 10 Sep 2025 08:32:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9a65sm7773115f8f.17.2025.09.10.08.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 08:32:03 -0700 (PDT)
Message-ID: <a70731d7-6886-4394-a0a9-0bfbad231a24@gmail.com>
Date: Wed, 10 Sep 2025 16:32:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqjz28v21e.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqjz28v21e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2025 02:37, Junio C Hamano wrote:
> 
> * pw/3.0-default-initial-branch-to-main (2025-09-04) 4 commits
>   - t0613: stop setting default initial branch
>   - t9902: switch default branch name to main
>   - t4013: switch default branch name to main
>   - breaking-changes: switch default branch to main
> 
>   Declare that "git init" that is not otherwise configured uses
>   'main' as the initial branch, not 'master', starting Git 3.0.
> 
>   Will merge to 'next'?
>   source: <cover.1756992089.git.phillip.wood@dunelm.org.uk>

I've just sent V3 with some small changes in response to the feedback on 
V2. c.f. <cover.1757518141.git.phillip.wood@dunelm.org.uk>

Thanks

Phillip

