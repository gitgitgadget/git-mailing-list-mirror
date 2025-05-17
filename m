Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464821EB18A
	for <git@vger.kernel.org>; Sat, 17 May 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747489184; cv=none; b=cP11RQ31TOWfptEnxYjbKgGVp1NDhOfh7MZYMJYcVh3ojZkYJ8LFwAprDvgWbramXBy6I68aJk9iSMd75BScrhiPW5II3eF3Lypg7RnsW6IX20hlQAAxYvghUnz2UI27poP6Of1M67PykqR2ndn2vXC/RH7WxcShZGbxDbIjd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747489184; c=relaxed/simple;
	bh=o2611DMiSkABUc9azuPY/mIXYq8vLVDN4Yzza5gMd7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quVRFdLLnkm0OKossEwEjs64UogOvNj0ImWf8/+MO+7JmlgYiWsug9h4JlM4jY9vu0U9ujISx7YlGnQ9MpXBCIigPXmZuBUhTBqu2oOo6jtGXVsY+LHIPpNMO1ahbHIWLr4uov4zYGq3c+HNB4RkCSpLX+izIgNP6mULh5uvGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drm0Dt82; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drm0Dt82"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso28611265e9.0
        for <git@vger.kernel.org>; Sat, 17 May 2025 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747489181; x=1748093981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wNZkL0gJixQ+M4yd9h8ai/njuTzbER+3pcJoBYQV8QA=;
        b=drm0Dt82cEx6zgk1uOa3zHLGeJgKoiATx8xA43lHJCHMijSYM+wKimaMnywJnAbkDQ
         ABghTk3wcbbYBNScbb7epliJGZA83H1Yfh34pNEo6juCa0Qh0BhLXgRguiQfZqkOZU7y
         CWt5G/W9fRlmBJO3EIvVRpNOz1Pgvivacu85ohb5KjgdZDPsKKdG+958nH6bPfEJTtKm
         G/6TLenRGal2derCkhC6XSO/xtzFmzJVX+lLe9Plg06tIg5/NRrlomfvXkLz82nkELUK
         hDcKOuC3eer/rvaKCYsyzVSXD1YZ4liTTYakgTy9B/iId2eCsgax07yr8+La2XGCm7cb
         A0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747489181; x=1748093981;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNZkL0gJixQ+M4yd9h8ai/njuTzbER+3pcJoBYQV8QA=;
        b=K0+e1BdYYQJYlxE9dYkp83yWSOJrNDBTxFOey2jO6enECmUDvBCz/pmv3NO2bnn4+/
         TGz5sybkrZQRSp4IvIa2tEJAG7FZKr2DqRPTDFO9MBxK/QtMMzyEokNlNuCJG+hTNayT
         TEqirWTLEuHAu2yloYC7yWicXphMJKRjbbEvaanlejkYoEIMxWOhpv36QuU6F+4ul4ao
         lbfktV7DYzgpmGjiUHJEcidj3aSV5LlsvxKE3OSLBXPd8+BuVuhg6X6ilJt10H1ryzJ+
         lJNb8+DMO/L+5mObUtzhhI6sXRyz/gfM5O3H9BFXXOjIzsBJuCWU9pEe3EOOvkF1HveF
         RJLg==
X-Gm-Message-State: AOJu0YxPg+TfabCVci7LTmak3m2WCIAjXbnoey2D5FHHm2ivTAITpq1S
	822uk02hFQV9wn5R2IXVw+lQ0nRmW4xaMCrCiwhQq5uFJdD6E9zzaqoO
X-Gm-Gg: ASbGncuQCuYSTiARZe6aABo9u562Yg1eRl9po9u5CyOQwKvRtII53A0cg9NcKfUqbl6
	fqQTeVB1VEA7x2iaQnWuIuAW/Ym9bXUCsqgq7J01PJuPgnuAZpl/ak3horUG6Idbvg8n9nErXxQ
	Oc4TZO6AxSy24A1mUL3erR0+yh+4Y9uVnqvMhU747LWLc+Zt9ptA1Sq7QLxY6Ev4WdnlRdlxK7T
	7MqUkQfv6TDFlL41fDzqndmW/L1aAYEtlK4Kg10BR3Q7ZK0y/COpr09cHNcujy3phtb0QcyNdPY
	AcKdffR3ANJL2HdQiC8KrfKDuR/Kcg6FJ0hB+qbx7/1ljS6pFVA59yg3Nlh/rJkwU/R/gBdSqxk
	gg7lzK/sW4vvPeNrOBnDVD2klqnc=
X-Google-Smtp-Source: AGHT+IEyxoqLR0RcTQBSkc3aS1Nc/e0JzSnEC9dSA6fu0ezeDPKMS+mmHzEUTDm8EpW4opQs2eFp9A==
X-Received: by 2002:a05:600c:8889:20b0:442:f44f:66f with SMTP id 5b1f17b1804b1-442fd672542mr47175155e9.31.1747489181298;
        Sat, 17 May 2025 06:39:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd51531dsm70231325e9.20.2025.05.17.06.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 06:39:40 -0700 (PDT)
Message-ID: <a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com>
Date: Sat, 17 May 2025 14:39:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Small patch to add support for MPTCP on Linux
To: Muhammad Nuzaihan <zaihan@unrealasia.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
 <aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
 <BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
 <aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
 <4YPEWS.J5JRNETKLXF1@unrealasia.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <4YPEWS.J5JRNETKLXF1@unrealasia.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/05/2025 14:10, Muhammad Nuzaihan wrote:
>> I want to point out that the kernel and libc headers used to compile a
>> binary need not reflect the actual code in the running kernel.  With the
>> advent of containers, people frequently run a different operating system
>> inside a container than they do outside a container and thus we need to
>> consider all of the possible combinations.
> 
> In that case, i'll add a check for the OS that git is built on with 
> "defined(__linux__)"
> if that helps.

As brian has already said I think it would be better to have a Makefile 
knob to control this which defaults to being on for linux. Take a look 
at the various USE_xxx definitions in the Makefile and config.mak.uname 
for setting default compile flags for different operating systems.

> Also another check if a socket is supported by looking for a return 
> value of
> "EAI_SOCKTYPE" (not EINVAL) and fallback to regular TCP if that is 
> returned.
> 
> EAI_SOCKTYPE should work across different UNIX systems as this is a 
> posix error code.

That error is not mentioned in the documentation for MCTCP on Linux [1]. 
Please make sure your code checks for the errno values described in the 
documentation.

>> On the Git list, we try not to assume that everyone has read all of the
>> technical documentation about a subject and instead we explain, at a
>> high level, how the change is and how it's supposed to work.  Your
>> commit message should convince me (and everyone else, especially Junio,
>> the maintainer) that your change is valuable and should be applied.
> 
> It's just a small trival amount of code but anyway.
That maybe so but please make sure that the commit message explains the 
reason for this change - what the advantages and disadvantages of using 
MPTCP are and what steps you have taken to make sure git continues to 
work on systems that do not support MPTCP.

Thanks

Phillip

[1] 
https://www.kernel.org/doc/html/next/networking/mptcp.html#creating-mptcp-sockets
