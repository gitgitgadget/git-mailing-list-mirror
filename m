Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59872C15AB
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204880; cv=none; b=EfdCUkV8Xz8pv9t2eWCkblrrePZtmvSpJjIlzQ8H6r4k+r/2EFbsw3d9FpAsXTriBTDHybZqEpsa3s8xldo3ppW+dedTiQQCJYy4WoDgLUwBlIFBs4IpdTPiP5cXL8JHGdAQ7Tgmw2K+IadjVu4oL5GRcYSJFYVXZDZoW/TIoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204880; c=relaxed/simple;
	bh=S9surBzAOyqlXh3epjM7NtQWlw4eyai+fKKsVH8jNZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LV0XwasruJnpqWnpaaWXz/vR/yZmNldxWLr0b2xCIXdZX0zWcSEhGkGhbiwpBv6aT1vLnGL63YjAqmlE7EoMvGzn/IKLuJmPAfVc7hwv/BQGNEyXmxYVj6Nh5zbYbx/hNWNgPzlrKGX95K5Ck2Us3sfTsP0t5TZuWSzSXY7dLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDttmJoI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDttmJoI"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824ba13c49eso88357b3a.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 07:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772204879; x=1772809679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFLGhKOEcQJSCAFLp4QxPkN4+JY5yD6XKgCplWN/mrE=;
        b=YDttmJoI3wJ0wMQi7v+tEjbvn/ZCNLlgMH+hT5mPVJsli/99cjfqVBmGtWBdBtlrS6
         1H5iOGScMnUnbuA0rkpkVjjO7pKj5Cc9sNg9sSOaZMOf8A7SNkWR5Nd6FXIOIm9uicSF
         eUpIYzkLyGwK6We2y2snm4fOmUmlL+BoXVYQ4KTY/m7ijCV+wgctTZVGuEiDnk85ssPO
         0BV2MUhZoGy+ere0HB6t+7jMSiC5S4xalfAylid1I8RmPAj6+SuoX4KTsCkSUqFKV4jT
         MtWg8N98Xi1KDqVOfR3BZ3S47ttY/y0yr0kaFxOpxfgHTSgpl4QQXWYO9dz3keFsUaWj
         A9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204879; x=1772809679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFLGhKOEcQJSCAFLp4QxPkN4+JY5yD6XKgCplWN/mrE=;
        b=ezSL3EB1z27PdP6lrEcs1+cjM4D9OhyCGZarty7Hf321ajrpMawG2zt3t4ZByxH0Oo
         yHNPDvloTXoUaL6Vb3mmcyuOxmw5MkfRZlZ/pUuWVAzSuzdzcr91L7aGj9rmTvgcAuz4
         50ZPaYRW84QX4ovo0Lxz0PLG/v2cC/c0pWx5FpYoiHEWGXwfXUb3GmLCQk/4TFXKQO2u
         L4XASIvwFBAbfdPTlp0W2iubQkxGRRhFuBbhk4Yy4kMjL4DoahxpcIVCnouGBLw9Gvt8
         c2jhLVanbar/Pc5Tk9zxbAqhjL2Q35wYPWmdWdwsVqruWvuFFa9cSiE+fFcXaFFS8C4k
         Ikew==
X-Forwarded-Encrypted: i=1; AJvYcCV9WuarSftsfaGnpYSDsPIJ2ev/uGV5nToAK6J4JSQrFRIdXtPI6bPyx3vKP7IYehJMkS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6oKSyKuZ7AClBFw41Hb6rzzjzUIrsfavZzD4jLyNb2EhZUtjf
	oSul6ZQvgwfpcuADkUQUkiP24LzHsc/ULRn57s9KITkdnSlNf7p2VlwM
X-Gm-Gg: ATEYQzw/kl+b7tqdaWvakUeKvnOvJbW3elI59pYN8PrQ8MqwmqcqSy+Efiv6kOYd9i/
	AdeXU6upFW6CFXvpDKHjqLPL42uuo3JdowKtwU1aLAm7dduXVdFuNI8fFE1bJUszEfo+nIgGRz2
	4D/tdcIJYPPr6VwYe4JPl4OmW2LBijc6EKqQzy55RpP9wuh9ainKo1UrTF3+ajwt/kEvD2+sLhX
	mcZC05L/282IIjG8rr6w2u/eO1vge80g66+YxKtcgYafr631unTJhl5ijzQBKDGXmztBy3gaO5l
	CazOpYmJ29BRUGuggWcLZy2d+nl/iRn+XMZGNYnUUXwJmSHHnmBsiG8m1oUcM23b4fbpKv44WWx
	7NPflxubZ1Giv5GpvaxrnHGsunprK1NQl/e26NMcSqxAqq4P/Mnkf9mSGA8A30pftR8EBUgJIsW
	kHACGIExcG+WuSnrEX10RxdpvsTqU=
X-Received: by 2002:a05:6a00:a474:b0:827:36ed:c6ba with SMTP id d2e1a72fcca58-8274da1b3a5mr1288533b3a.5.1772204878628;
        Fri, 27 Feb 2026 07:07:58 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a010996sm5221547b3a.44.2026.02.27.07.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 07:07:57 -0800 (PST)
Message-ID: <86cf5f3f-1459-4281-ae97-24f2d834e099@gmail.com>
Date: Fri, 27 Feb 2026 23:07:54 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][Draft Proposal v4] Refactoring in order to reduce Git's
 global state
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
 <5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
 <1d43d1d0-bf6b-4806-834e-89f545fab766@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <1d43d1d0-bf6b-4806-834e-89f545fab766@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Phillip,

Wow, your reply is very detailed. Appreciate.

> There are four steps below...

Yup, a typo.

> Note that as settings in struct repo_settings are lazily parsed, it is 
> only suitable for settings that are already lazily parsed. That means it 
> is not a suitable home for any settings that are parsed at startup by 
> git_default_config().

This makes sense to me. So for variables in like 'git_default_config()', 
their startup parsing nature must be preserved. Will update the proposal 
to explicitly distinguish between these different lifecycles.


> Where a function only needs one piece of information from struct 
> repository that sounds like a good strategy.

It's much better to pass just that value down rather than passing the 
entire 'struct repository', right?

> Although `editor_program` is parsed once, that happens in 
> git_default_config() so it is not lazily loaded and making it lazily 
> loaded would be a regression as if the config value is invalid we want 
> to exit with an error early in the process, not just before we prompt 
> the user to edit a file.

Oh, I thought it was lazy-loaded. I completely overlooked the user 
experience in terms of a delayed fatal config error also. Will double 
check the source code and rewrite this part.

I'm delighted to see more people reviewing my proposal. I've truly 
gained valuable insights into Git's design philosophy. My sincere 
gratitude to you.

Regards,

Yuchen

