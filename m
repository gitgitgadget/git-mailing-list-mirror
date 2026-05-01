Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CF40DFBD
	for <git@vger.kernel.org>; Fri,  1 May 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777649421; cv=none; b=VK9uCmRir9as3ElTbECZ6YMLWmpS7FqdVU5tphWwIhMhve2NlCu1UdUnIm2QK2U+zbgLfVrTR6BjdQBUNLwXKQhR+rLw0MZf9GAJnrc6IIXQ3SOB7rzwmGo+dp853zZUp75FL783lyb81EFF/EEiihjuZ1s+bNSnPzJCgAe8Ebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777649421; c=relaxed/simple;
	bh=TqIqu+uC8I8rOMYSaPyzK0fRCjQJt/tLeeHVawbANe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yc56W9nd8evzE9mqN9rkbLgKjiW7cHEJCABCoaVHSsL2kp0Jt3cdalWz5bxGs2a3LND6+PPp88AfkvSg9qhKIM09r7Wt79tldKlZUHXrfRiwe1ljloXFfmV5STNdsjZAIQlkQM9S+70MOxcW0W/44RqwfmDCIWiUubMW/6vi5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SctsdEi0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SctsdEi0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483487335c2so22222195e9.2
        for <git@vger.kernel.org>; Fri, 01 May 2026 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777649418; x=1778254218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DOTbaKLINHbwSIfs8lZQZSU8xfKg7WibHVN8wf6amkw=;
        b=SctsdEi0QPoT53oOFYS8Snl7f7P3aGgJFlu6GICaKtoJUQ54zSLQeJrL6q7FlkLcVD
         urYfCD3Wbbk3/nZHq3FRr9PWUG1p1RxMdve5SFqJyENkbN8XH37KBHQNi+aWudDCGPsB
         QBbIWiSvAP/cc/tmO55ri1h8CLHRXy2dwbI31yVasBYyk8azRZdHHEyZPPGsX+IbMsLG
         oQ79SrHsERIdZy+B1rqL+BXs/DzkgVm++YcZwXco01EL+8sdn/yQT6Tggd0VL2k0X0ku
         GmNKaMtvomfguoP4QAazR2q7zdxyGPa2E++GtJpAJYj7LyNMBa6g3iiIkNDPcw5HXM32
         cSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777649418; x=1778254218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOTbaKLINHbwSIfs8lZQZSU8xfKg7WibHVN8wf6amkw=;
        b=EyD8wKA43iYR4ZpfD37YFq4ZYYPPKtt+dHtdNFl5q7pUcpc+Oz9RKz76ivkG/aF3CY
         DUW79c/ltnYgyROV2Rloolss3ZQkUPjmNlRjA6b0sPO6oz0qw3i9PKEVg1DyTwgCA936
         RhHqYU5dL94/d7zBWLM4z5RWQxIZ4YPJy65pw/NmMs+QKQqIxPjUSnJIZtE5cpUEj5AN
         dZj1RTjpl5Qw/hUGUBdrdwmf5RD+dY+7DutCvbN1K1maCSz5Et5fBB8IvE07ZnwaddUr
         5JwLNlbwb2tShek0DWFnp9yuzgAFivtQBluXkqs9r3F/PHuJAJgXIO0v4IkHn+/Ix5rm
         d8Ug==
X-Forwarded-Encrypted: i=1; AFNElJ+VM/7Vfk82bqJRA/C+3Aa+dOuqinkGFDRZGrBcuLxHcigUyKkmVsczpCIzblM+LaPXVgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7J10ng9F3NlhZlIJHMknYAr+kKNfkMjXS+NZvX9fLHCm6cla
	wBZRDsqB3zM+QzYtmScZvd871jpa/L3vmLLVu9Y4hN3wPHNZZkgQ/JPgsLjk8g==
X-Gm-Gg: AeBDies++p4YbW++dJYQhRekuXAwHja8UaetPQN/UbLmsZ9NsINrywXYCC8WC0RJ+01
	nBHRYBNq72pCMVXO8bUe7ErZXw9pJf46SqvtnqQOFe6pGQDSvasD5Gla+kxVVIzClr2KZZ5J/5S
	a+Ah5WfEg3izfEI9yAj5Q46CPQVwp6/P1wdxdjkWw7uOf46lNRKhsa282f+AkHJKDq9R7WF0iZv
	Jakrqydk4WSnWlPNbGDSlIDbtNgvrvq6dq6mWXA4k8ez/cdtX5zkS4TtLiUF7eubgDvZ18l46Yf
	3GQuIvIBXTz1S53yS+WwzbqNstyvTLp9t9uFXRaRHs69pHjZZxAgfwmwoYUCBalYux3UMWBqyHY
	RZOHYMK/T+CTl+OqxlaDl+iG79e71WnpFCr5BmYF4oCjC930SGEXPeLjT+mmhAOSWs4e+g+47SD
	sLaB6DISIukH0INZJBLHQkOMIMOaezvW1wk68TxVVH0nEnmOCBGD2uxzffXm0HyEiIpZDySgmiF
	PAmmF9GweEx28fhg08=
X-Received: by 2002:a05:600c:4683:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48a8452de80mr125802335e9.26.1777649418344;
        Fri, 01 May 2026 08:30:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456? ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef92b6sm21358125e9.6.2026.05.01.08.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 08:30:17 -0700 (PDT)
Message-ID: <026b84f4-7052-4d5b-a9ae-c2487569d1ee@gmail.com>
Date: Fri, 1 May 2026 16:30:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rename/moved status unreliable in ruby
To: "sebastien.stettler" <sebastien.stettler@proton.me>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastien

On 01/05/2026 06:05, sebastien.stettler wrote:
> 1. What did you do before the bug happened? (Steps to reproduce your issue)
> 
> when moving ruby classes between namespaces they are marked as new files and the old
> ones are marked as deleted
> 
> if i only change the class name it will mark it as renamed

Rename detection is based on how similar the two files are. Looking at 
the example you linked to below you're changing a file that looks like

module Math
   class Calculator
     def add(a, b)
       a + b
       ...
     end
   end
end

to

module Math
   module Calculators
     class Calculator
       def add(a, b)
         a + b
         ...
       end
     end
   end
end

Which means that git sees that every line has changed because the 
indentation has changed. If you want git to realize that the file has 
been renamed you could move it in one commit and then add modify it in 
the next commit.

Thanks

Phillip

> 2. What did you expect to happen? (Expected behavior)
> 
> in the namespace state i would expected it to be marked as moved since
> nothing has fundementally changed
> 
> 3. What happened instead? (Actual behavior)
> 
> the file was marked as new file and the old file was marked as deleted
> 
> What's different between what you expected and what actually happened
> 
> 4. Anything else you want to add:
> 
> I have demonstrated the behavior here https://github.com/billybonks/git-rename
> 
> Mostly i would like to understand what is the expectation from gits point of view in these mutations.
> If this is considered something that can be improved i am happy to build out more test cases, and help with implementation.
> 
> if not, understanding the reasoning would be great
> 
> Thank you.
> 
> 
> 
> [System Info]
> git version:
> git version 2.47.1
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.7.1
> zlib: 1.2.12
> uname: Darwin 25.3.0 Darwin Kernel Version 25.3.0: Wed Jan 28 20:51:28 PST 2026; root:xnu-12377.91.3~2/RELEASE_ARM64_T6041 arm64
> compiler info: clang: 16.0.0 (clang-1600.0.26.4)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
> 
> 
> [Enabled Hooks]
> 
> 
> Sent with Proton Mail secure email.
> 

