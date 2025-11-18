Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E842EA46B
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495553; cv=none; b=i+sx73YjrglgDy9diB/dEZq4miQzclr/+FK4TrFJwdukZB7b/lFWZvQJ/srgzTf+sIIaLonqiMS1ZemY68ADq3tqFx8bjKDctShMHH1xG+wicGoiAJ1dh5RJrgqJjGHl4CvUcGlFYROulm7Bk2v8xPjz219ibW+ZYpjuWoGd8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495553; c=relaxed/simple;
	bh=pJCvSmZvbEQy5M7opgZG8gDr7mEDV4KGWca1mvjiumk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YrDedojf35FoPVMlJPaNxGt6yBWLlawj1I2/1BD8YDfQR8AXqQhUa+FM79y3kg6NAns+WvcP04ZZjn6YqhT2GsucaT64+nx+H/jZPr4l8rmESuqxr+9SGZiRVr22kTUNonzgzEQloP+8vM7DeIeT6M4BpfKr3J011MYO5af3h9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GE5XKzjx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE5XKzjx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso1028885e9.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 11:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763495550; x=1764100350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R6WYnefDiDjz35+ImZwATWmaLlkyKaVktXWg8wQ7JeQ=;
        b=GE5XKzjx2uoxH5gWJnf+ApRaCFAizlqYL5tqzQ1CwsnetCbVc/JAB3zCYYNeTpr2qM
         Wv8IrINGAIZpRUWWLSETfkYXNWcNspgeiw0XMuC+KsplzuaL2e6kvI7PxEicNgGhr+aW
         d6xaJN0Uj82lq5SGmOptx0B5+nPUbEXBjpk9AoaULhdE5BI0hwRt3jyVq23Vo1uhv4yz
         MLoBlq9qrwxM9zN0zjU63JEp/PnYHC5YXsejEtVHHA4t74aqvGX+147mqP5OOcq2613N
         eE37EIpvS5f6oquswAsyaUUng4BdmTCJOnOYOvdWWURhtoUH32pUo7O8+jg85R05Angb
         kLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763495550; x=1764100350;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6WYnefDiDjz35+ImZwATWmaLlkyKaVktXWg8wQ7JeQ=;
        b=NaleuLI/uDZeQE7Ny8Vkd1ZhHvWyJgZrVXUDM3hrljMWdBsK4k8mvO8poJkknwveff
         Is/Ta26cgpzIHJAeiwcvZVNh3zAba7xltXlVLXKJ8j7ubodN0jY9dZ6eg389lP4bSUC0
         VEv6mx+sZ8btGZBexzeSgHjoYdIXYVTPHXKZWgEnGzGYsc7FdIJGRt4O+v+sactofTDp
         ZLnfHboOCswlK4xspcGqB05tOBieefLhyGSWOqHh0QpL1Q7QLq0W8qd5TL/hvOybtNi5
         39VZA/wgfaVpR05OZD1HIX9yzjDAdl1QrUpW3orAL3CqwQa1ALtsH+tX5WDaow1+Yg5N
         mIcw==
X-Forwarded-Encrypted: i=1; AJvYcCXJCRcqACiUndT/PQtATcu+XzCo53fD3fqOr/osO4jA8heiGNOirjbjwDjamxSuE/gaRuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pkZHnHheXIBLT0pJ+97AuPpfXsTyhgyU8FWkJTzvhNQj5ZSe
	70LNHdrkuMK/YxqFtVh7pPhfqtrh4x0CyWmqd7gKwMtngNyrcB9U3b9N
X-Gm-Gg: ASbGncsc/5MDdXK2Ewfo8YKA5Q8s5e/2qOvZmR9Au0C/Gpbu08NRkLaBHkCEuUkNiJS
	SQXCEWulUxV5pR9ODkTORcKUtRptAyr63ppw/X1BLzD5P3l3aqF5J8G3vfyOLts803Gr1eu7wA0
	nvbsVGDuf+mLMTAg+We22vOm6yUgLgTbutCuK+2+vXzYsw2gnz2E3lX4Tidi0E2mPE5LNsKOOyQ
	1I5QKIlFEEyTOn+HC05s2S6/RivNYo5L+yY11UR+154n1fawv4iSnEWguapGjQ3pGAn7abWBgw4
	eIDUNwkhyZjhPDrJf3yONAmA6sNYWlOhSv+8ReiiTQF+8u/jV1fu+SVzvyqrDmSbvIrRHuxy17L
	kOune4DojYwo9YIXBVYAubiiTmiYNNkBCW0+jHVUoR0g3m5gXHwl/PCZhuAT49CHUE63w9mM/ZJ
	hDeLox6SRE0ZiIy2jrdBrhUju/wHkOVbQXbVHsHokV6GLE/I4N/5KExEQnEmoQMIG6Haf82qKS7
	ixFOQ+CK9Wd
X-Google-Smtp-Source: AGHT+IF8tUyLMzTC+cALC4xSY8vGDxJC51L+fHztnXnZ724ZxXxQqxVCC47PjHOzLS6hAUdD+ilgEw==
X-Received: by 2002:a05:6000:2c11:b0:42b:47ef:1d7a with SMTP id ffacd0b85a97d-42cb1b99553mr87005f8f.20.1763495550199;
        Tue, 18 Nov 2025 11:52:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm34033614f8f.0.2025.11.18.11.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 11:52:29 -0800 (PST)
Message-ID: <cf524772-f919-4286-a9db-eb26b87b5cc6@gmail.com>
Date: Tue, 18 Nov 2025 19:52:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Interactive rebase bug involving merge commits
To: Bailey Muckel <bmuckel@32bjfunds.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <LV8PR17MB74355C21BF9542254EE8E82BADD6A@LV8PR17MB7435.namprd17.prod.outlook.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <LV8PR17MB74355C21BF9542254EE8E82BADD6A@LV8PR17MB7435.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bailey

On 18/11/2025 19:15, Bailey Muckel wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> I ran `git rebase -i --rebase-merges {commit hash}`, then changed the
> command for one of my merge commits from "merge -C ..." to "drop ..."
> expecting it to remove the merge commit entirely
> What happened instead? (Actual behavior)
> It output the statement "BUG: sequencer.c:2695: unexpected todo_command"

Thanks for reporting this. This bug was recently fixed by commit 
4d491ade8f6 (rebase -i: permit 'drop' of a merge commit, 2025-08-06) 
which is included in git 2.51.1 or later.

Thanks

Phillip
> and remained in an interactive rebase state until I ran "git rebase --abort"
> What's different between what you expected and what actually happened?
> I expected it to act the way it would if I deleted the entire merge
> commit line: remove the merge and keep both branches of the merge
> otherwise the same
> Anything else you want to add:
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.49.0.windows.1
> cpu: x86_64
> built from commit: cca1f38702730b35f52c29efd62864b85e85ddcc
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.12.1
> OpenSSL: OpenSSL 3.2.4 11 Feb 2025
> zlib: 1.3.1
> uname: Windows 10.0 19045
> compiler info: gnuc: 14.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
> 
> 
> [Enabled Hooks]
> 
> 
> Thank you,
> 
> Bailey Muckel (he/him)
> Data Engineer
> Building Service 32BJ Health Fund
> 23 West 18th Street, 8th Floor | New York, NY 10011-4676
> Email: bmuckel@32bjfunds.com
>   
> 

