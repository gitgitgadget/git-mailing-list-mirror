Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD126CE2B
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209859; cv=none; b=DSJrS0jjMzJPQ5rencH8NpHiI5PJWEqDZVhnJwMskAf8KVzy0moUDkLhtyBZPHRnJMeXXt5uO0mTKejiqylOGAH0WTD9GD14wkxwEsESUst1LG+zF009ol78ozScKSJIuiHsupL3c/SqDR9Fj56UqsT6TzU2/DFsP7aThZHrS98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209859; c=relaxed/simple;
	bh=/x9NPjps5lA3adWVucrGVjvOrRMeDBWI9bWLmek7/00=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PP8NuApg6zQo7RkVjbJGoLUsx0FL4SK6jAJdYMUOMonfFMKyZSfpHQVis5Je6CWv8AKcdUVZeFF9+a/8u4s+b/FWnVnq3FggKox/0ldTpDQErn7KEmkq7Y/6Rw7vOHzXZQX/Vxc2qjouNQwYGGBjIQB9JnizbH90gu8A9NAfk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZN49mn1c; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN49mn1c"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775ae77516so55535405e9.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 08:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765209855; x=1765814655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qe3O6pDnKUyhr8btgT5h56v7Ph5e/s+AEKmeJNLIGTM=;
        b=ZN49mn1cPauoaQZtU4pXLpC4PcsleLKie0viintLh3DjBBcxQfarJCN3+jGKHUxXKJ
         ej70L1HJroY35GeGEF9qnvAnn6Dlvm88mgX0lJkvYOoXRcaH7sTU04+LUC/pMCOfKFtQ
         EHB4IVuPYs0eFVKcZTTPGukk4CAXEl1gZ7DC1WViq7nH0yl+mvsc6uY8ukdlSbsNAIpW
         WZd5dSd9g1lwWFGMKtxgBW+sApQ950ylNjShQZ3XtS4M9Tmf59qkfDpAnNVkcfG14CCt
         VhpQ5l84bQ5BGCHKVTMy/anivylzg7kT7LtUqX+rHxfWV53htUAr1lo8knbYz2wj8dj6
         xDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765209855; x=1765814655;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qe3O6pDnKUyhr8btgT5h56v7Ph5e/s+AEKmeJNLIGTM=;
        b=EwHqtOMDMpRHtTAM8UXJg8r5OG53GyuJ6omgiXkzHUPysgTN5jaaJSYYwQIQmSDCou
         BS2Y76ygdD7FY57CX9wlsI7M/bCllqCEBjCREAVi3baWLseISnhPOGVPYnjV4/mwaf7X
         JI7MTRmlO59guLom0QPHawcZv6tlmMVd/o4g1QVlWx3u7rERcYpEkVah8H7TMBLjQOOP
         vBdlnEx25XMG16LLQHArAjEnDqlqQxDaZaLfToQXd1V0XfoBBMg4xxBxjwTosa95Fyzu
         jaWQYgdbLPSyIlHmYu0JgsSxVrgQQXvRs1lCuXQUQBXEdPXCdDyaujSzHwH8UCGgLfzu
         +kxA==
X-Forwarded-Encrypted: i=1; AJvYcCV6HmUXURo+bTXGSTfPmBCp7zmwwUHndd0jH7G/WwXSWxfQG4tJmnaGlYVi+OaS4mYlVSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6MBvwDYyX+/5q2y8p+M+bPu01T/MsuXC6EL4AkMJdcFdGHZq
	s60ytg5yNDOmG2wzqjWFACjl3imlbquIj3fYTMluPAvNEokdWOwx7zjHRBPMyw==
X-Gm-Gg: ASbGncsqAT9S0W9HK+vkx/IzmsL5Vpm4k1LZ3kULA7Rl23apicJtmk7oVu+otVVu5Vb
	28ZRNGQjNydjlNsJIsCNLCkmt3vCiHWEMZgkzmtPX748ucMlpH6aZ39NHfMcpnPKD1Y8yaaMZUx
	pWyIbbzenBLko1ly4ecrD4DIWhtp6C+Fj4GvJ7ZtTTZqHnOH5n2/9/0pQWLMe3u8NzC5Mrc2QoR
	US5MRGjc+fj+cJrRWLzgKBnsLtyxqU+m/j0TEyYsZdxXml5755hgfFIlxVMcWwZd+vBEbQJo3Xu
	sq3zo66rp2bwK2U9o19jcYexe7K3NL6Fli+oLLMsHAYjjtuKPJygQhi4/r+aWxTQVSqoO19BqcC
	DRMQcqy22I7GpjrHL/2exhUAQ7Uf/OMCwcwVKbwk9/FkUXqp5wmZuTTawNuQGecH+FTFS4D/RC0
	/5SD80ibBLQuemN3qgHzdXqjaP/hWjl0uolx1tTey3mBNOVQetnjOAPho+yjGo6cQ=
X-Google-Smtp-Source: AGHT+IHYPLu2REN+QOBZTRein4b27zTwvPiDFe5QDf2GgDi9kwT6WOnqXwEVMnCLy9OmU3vKT90PFA==
X-Received: by 2002:a05:600c:5955:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-479cc3dea92mr56996845e9.26.1765209855182;
        Mon, 08 Dec 2025 08:04:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331af5sm25443903f8f.31.2025.12.08.08.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 08:04:14 -0800 (PST)
Message-ID: <b52e18c8-7533-4359-bb23-60cf25ca1694@gmail.com>
Date: Mon, 8 Dec 2025 16:04:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
From: Phillip Wood <phillip.wood123@gmail.com>
To: Kartik Agaram <ak@akkartik.com>, git@vger.kernel.org
References: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
 <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com>
Content-Language: en-US
In-Reply-To: <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/12/2025 14:30, Phillip Wood wrote:
> 
> Unfortunately I'm not sure there is an easy way to fix this.

Maybe we should skip the fork-point calculation if 
remote.<branch>.pushurl or remote.pushDefault are set?

Thanks

Phillip

