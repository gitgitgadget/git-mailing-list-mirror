Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45035335562
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245719; cv=none; b=NDlNvlxVpOPoGK08x3h4nYsSQvQtAeI2+a2rxtms5f8passMIV8m2XJippMlZnhtMbscI85BKG7hVUDeqfD9Hxjmp2r+In3SrAUCbyCAUFszrDrqAiXrMj60+QEy/OFT1E4VrYqtt4pH4BWCbyj0FoocCSmGUi8aUgSfyOfgRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245719; c=relaxed/simple;
	bh=vSaY+wrKRmpMc6P86YbUBhWbhKrwLpC1uooGlfWkYz0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FPJ1y3UNSHzy96lGNCffJZ3Xe9xEBxXVp7ldEfW6Wi7Q4WbmtAgxZ1JI3EqNBVv0Ijmlpk7IRKpeu/qcdSCmd6q9RvjbR50v8jRZv6qRh1LYoENSaPp8GMwdcrxqiQkBB9LEUuDJ9m4Mh1j4Y24vY7d6EIHkHt9mO0fTO2J5UWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mROGnz6A; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mROGnz6A"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso107639325e9.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776245717; x=1776850517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDokZDG7krjZARlidrQwa4lD+K+eWTwhpwoJ0DVtNYc=;
        b=mROGnz6AH8m/hGneFxE0emLnDFFTLz9m8X5etM1lkeYdBCRlalxZC1tSmU5ho6ZH3z
         Og0ZqHRme9r+fIKnrunaFiFt53it3n8HgLJMt9T7cvvY3awoq4FK7vcIpbRLvE5bVuOF
         ik1WQjac/s9DDgy9Q87pfz+8mRfxgTbBK2ypMd+l2GdMrp/kpeN+x158RnKod94Jhi9b
         TxbcF9AvqBt2u3bVTLOU9DLgZ7+mwSKn9JlHm0Tn57SJK+TiWtyMPkfFiitaTFHNWWoL
         SYNjO/XIztJ0HkXl0Kp8mhvoqYVNr1qT0UG6BZEhRNTCEmebDnntSjH9Lh8EzHHGy45g
         5OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245717; x=1776850517;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDokZDG7krjZARlidrQwa4lD+K+eWTwhpwoJ0DVtNYc=;
        b=sd1swVMuJ7e8SXCJ+LyE9+5hqoT6pvrRc8bq492MI0hB8KPKOAUUb83NgNRjgx2dGQ
         0fUbuP03aX8Vxqvf5hR8/Pba9qG4erAdprk1UBiC/5ua1XYWBTSrRLlSpXy2t8xueoir
         OVnF+ut3ntSVDCd0lMsZYZhmWshw5BMLZ1ArDa9d57Y6zSIQx+q/+zOrveXEKO4n7wG0
         PEGtI8PWr/+pNO7y4RlsHJ2h1fgWNMDMlmwpqliuzJdfYgS1gGTdgiLIFmujqg0BbDxs
         NJ94SOj6i+T31Y//+6GYSBDK5KYY7HY/58lm7pEQFhOOrTXPY4c9fvtL9RIvhz/QkprI
         nbsg==
X-Forwarded-Encrypted: i=1; AFNElJ9F7Sjpaar7qK+ziP6vb/V0QZkKNXXFpYqdpQalz8ao3uCplSu/wCxl8/+WDmCSJ5/TSJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8b6N9Nuf0ZSgPtlQ5Y7H+1hNgJ/n78dMCDzlPiEhPN19czhv
	OGzyzuyXJaPsYnpYHO9HBkniWyT+ETmT+K3JQRyes/ok9+yslNooEes3dI5MPQ==
X-Gm-Gg: AeBDieuNDGVs+fqpPDaZK6jzToSt8lL0WSwiLpMnLkuKMGyRbY4th6whzxbT0un7k9v
	X0hOuu1u4qqKT3cAaCLm33BrJVGQer4iMInSDBHHhsrDpwk0LDpkZpuSgJTTXFVSPZ35tgHf/ew
	y9/TF4D+q433AQeB/XiksF2iVIUYGnJ/uvZvkE9ZD6tbYPpmkyj8bCrCXC2V8F0p6JPDpBJtQn3
	fKoUZstK78oCngHWn9acZMB4IKopjwwybXOgHOGAEf/xkdcvOOVTrNzimqCQlk6epncI9BE26hP
	ULzs8/UdVu5Sb0iAz48N9P4rX7N4jwTgOK9jKtLFeuTwS9BWAqTTwMs8p/NU9tZLjHNofu1sBlV
	QBPXJ29AXcr82glZANdjK3G03+BrzvcFUIALgrxyWppQCHF1rtZohmdVqtIxlUqZhH55O8Mlhwi
	3YEKJ3uT2EyQMwsrmYEwI52F1OxHpH2Bq41sSCa+pqnY+mftkkLJFLxA4z/W7QyZFKvhorCtOI5
	LY=
X-Received: by 2002:a05:600c:3b24:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-488d6872ed0mr292502375e9.25.1776245716616;
        Wed, 15 Apr 2026 02:35:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d665sm3726031f8f.7.2026.04.15.02.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 02:35:16 -0700 (PDT)
Message-ID: <b7e4eec5-bd2e-4652-bbb5-f2a2d0709280@gmail.com>
Date: Wed, 15 Apr 2026 10:35:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 peff@peff.net, phillip.wood@dunelm.org.uk
References: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
 <20260414200640.50910-1-haraldnordgren@gmail.com>
Content-Language: en-US
In-Reply-To: <20260414200640.50910-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/04/2026 21:06, Harald Nordgren wrote:
>> The changes up to here look like fixes for an existing bug and so would
>> be better in a separate patch.
> 
> 👍
> 
>> Sometimes we return "1" and sometimes "-1" what does that signal to the
>> caller?
> 
> I just tried to follow a pattern, I'm not knowlegable of how this return
 > code will be used. Futher down in the file we check 'ret == -1' and
 > turn it into 1, so maybe 1 is correct?

But you can read the code to see how it is used. Tracing the return path 
of merge_working_tree(), the return value get propagated back up to the 
top of the call stack i.e. cmd_checkout() or cmd_switch() and used as 
the return value there. I had wondered if we were using the value on the 
way back up the stack and doing something different based on the whether 
it was "1" or "-1" but we don't so it only affects the exit code of "git 
checkout". That means returning "1" is sensible I think.

> Do you mean to drop if from my patchset, or just make it a separate
> commit within this series?

A separate commit in this series. As "git checkout" without "-m" can 
also carry local changes across we probably should do the same there as 
well.

Thanks

Phillip

