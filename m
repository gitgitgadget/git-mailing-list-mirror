Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290209;
	b=V9RxRIIu+Ul4RVAsP4Y4bcnLiCcO/9S3Yte/0t5CJMoxH03+6SHcuBu/tlmPdj0KrlFU
	 eIoHYjSrrsG7CoEgh1JYwmU5VOgeelOb+OWsOfS36tB2eHqp9mhBSdgCPAZ2N09OxkMPd
	 aVyC6XRIj3cPyOdI7QIQGvoScRONSLD6qbwYQeM1xpCzj2qtatIU5TZs+hCakZoZT3bED
	 l5mRfIKv/hXWbu489gmHh77QjcslLHTA1gdjjcUffv9VDWAClgSPYnNW3KT7YxBv1Zfz3
	 lcxUSqhzhkOY/BBB1TfSKwu7OF8sijf6e2jCS9M1QKy1JN03tqzTICiRmJa7WZDqS8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wh3jOvkxjQVSey7256AVAJXnjg/IewQJeNl63vSGwn0=;
	b=B7YC3Q5/6F5EjTIrJbLLZRD9RXShDMsn9f4WM7c76xgD6foFCC6aBszDvK0gSJ7tqILm
	 5YJJ7umJqnAP3eIh4EM3zd1wCbSe0zfxzAU6Gx/b38+AspoaJodMbWRkzIajwX52qE7b9
	 ZTt1JzXqdefCXU64uZKgURJTLMFztwOJ5E/7fD4Hs7Wi4eWq8K4nGntUmjNMpydz/5VYp
	 QXS6ZPMEhMfH/P2GLGpCw0Z2kSfJb/LRSVl6iqlxKy8S3cxOltJEPd9sdCE5kPkvypwZA
	 MqEP+Z45oOsoYaCUe61tcQyqlZiQ8RWSbod6f61BBl5AZsCyFRL+hGYzPr/g+SGfYOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOB4Wu7w;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84731606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84731606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOB4Wu7w
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so15135935e9.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290208; x=1793895008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wh3jOvkxjQVSey7256AVAJXnjg/IewQJeNl63vSGwn0=;
        b=gOB4Wu7wyP+Hjr3kzyzJ7url7gkrrrfE+bBOZJY0NaJicEL+dE3lRkDIAB8FZOrDgK
         ULUXlGBs9zGpykZmF0CnI0YqthoMgTV4mur7Hc6f/Y+oNbQXQFJfqdMe786GBoRqqTLC
         5KLgPnfhUyk04/Q+3p/Yx8ojR/ZMRZfoMlWFASMNtwZvw7zuOvnmKY1MzLOJgpVrCnKj
         ZbKPe5kV62bGeYJlJJCuTPsrRX3UAhGQq/PdDs6TtRhPhVWIV1mxS+EgEXNJTK//vVPc
         V1qA5VjVydZ2/DHtmLRrTw4r3WWryyYWlnPUrUT5GFMkmBCtCQU719n1J+26LL+XThLg
         kxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290208; x=1793895008;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wh3jOvkxjQVSey7256AVAJXnjg/IewQJeNl63vSGwn0=;
        b=COZ2jkN6zcFXdIHGRw3BstFS3aexjPX6qG2Hwo7lKk8PTwFQj9UHMJrLLkpufkXUqZ
         1NFpQtaPRYjPBDwk5aIJvI66JLpkDC71DskjvqfmU8knNi9UFIpUnPWvsfCeAPZDV+2M
         8JR2E3uRLe6kbfXNZ0opXusjUhFMp0sam3XaWTx6ijarEfPOUShuo5hC1RxoK5/kIIsk
         ClkSKJ215N58IuRpRuoqG3I2+AxsmRLwyyd86fqaVoxkXA4jZf11B4hbyytt7GfA9zdA
         zxX71pca0x65ywdpYVm5XuGt422yl8CmmiG7xxjWKFAljOuVky6Go8HxC6Jh7HsZmO2S
         S5Yw==
X-Forwarded-Encrypted: i=1; AKwUvBxg4YiFpouguEgP+UHH8ZNFjKH6oTWZBvdy9/Tx0G9LcovJ7uMl8GHAcZFV2SuTRYQFuGU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJGGjpfC/Ki4dOq7QLcLk9pGsFiMiULZF2NwmwB8kchH2T+xum
	LLJJuA5XIMyrjyoW0epFXQQZvCDii8uUCM5EGZarImXNFhVuJ1AMHR9c
X-Gm-Gg: AYBFou14aVLCULCrl1QWKNFUAe9fPjwTfaw62E7wTOGJd1t11ChVc55IeJxQSJ2LH1u
	NmDvxxPOYElRUbuM5z5RjCJGvwhwsJyoyAeFne8MW6fZzfWoMiFA7xX9w2c4QqM5DNA4CsBev+b
	TH6iXxt979kqqiAmUk0vZyKwMDnW3+kyzX24n6G8H/E/cbqbJcZSTuUVhKFn8kBHTHoNUfA3BuJ
	CAEKAb/mhXP++ybBmG2xW1Mk7jI0s0j7yUi4iSM2QKArGXv3bso+L3eadgIPTYlpdjK+o6sTAWr
	80yN0CxgkMf/yLIp2QaJrFcIU7QXQoqLFFtsC2XXa2dj+V4Db2ay7NyqDCrYIv6Qcz5C6iRNS7v
	P4sHaMfFpSXLBtTbP++pY9HF0ZE6mGxGbidJppLj0Kbeh2LhNmoFPRE/QyxgVNPyVT3Hz5hz2K6
	ppWZvT2gdfLb3YvTZVzxYpUyilrpw3Dfpnu4kkkpsuczOfqIjWCNUeu2I2qP+5duUUrhsUAkSR4
	otp1lSGgDyTlErbo42gZxScLtT8M5N0YHj/D6y7ImdODymqpZQmjcwKu4fJUCEwQazkNG5lnyb1
	9ZRM0PHMI6JYXNSWurLvCiERYklVr6S85MDZVfssH7P3kATHeb5LXl2Ti0xy//EmvCFHA4QopBE
	EAKX7H8z+
X-Received: by 2002:a05:600c:4e44:b0:4a3:2f35:38aa with SMTP id 5b1f17b1804b1-4a967f84817mr132858325e9.29.1793290207721;
        Thu, 29 Oct 2026 09:10:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6deafdb5sm185117f8f.0.2026.10.29.09.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:10:07 -0700 (PDT)
Message-ID: <ef4874c2-c619-4773-9399-08c48503c3e3@gmail.com>
Date: Thu, 29 Oct 2026 16:10:03 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by
 branch
To: Ben Knoble <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Jasper Mayone <me@jaspermayone.com>, kristofferhaugsbakk@fastmail.com,
 git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
 haraldnordgren@gmail.com
References: <d0051192-8e86-403d-9aae-b988883ccfd9@gmail.com>
 <A0B73028-E3BF-45CE-8468-AA9B022C41F6@gmail.com>
Content-Language: en-US
In-Reply-To: <A0B73028-E3BF-45CE-8468-AA9B022C41F6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/10/2026 14:23, Ben Knoble wrote:
> 
>> Le 29 oct. 2026 à 07:14, Phillip Wood <phillip.wood123@gmail.com> a écrit :
>>
>> ﻿Hi Jasper
>>
>>> On 29/10/2026 04:46, Jasper Mayone wrote:
>>
>>> Is that change in behavior acceptable? A script that reads
>>> %(worktreepath) would now get a path for a branch that is being
>>> rebased. I think that is a fix, since the rest of Git already
>>> considers that branch checked out, but I would like to hear if anyone
>>> relies on the empty value.
>>
>> I think we can consider the change in behavior to be a bug fix.
> 
> If we’re doing this in order to usefully feed it to worktree-remove, though,
> do you really want to remove a worktree that is mid-rebase? I
> would think that could have work you don’t want to throw away
> without considering. (Besides which, would it show up
> in --merged=origin? Hm.)
> 
> I suppose I would expect remove to fail without a « force » flag if
> the worktree is mid-rebase, but still.

That's an interesting point. I agree "git worktree remove" shouldn't 
remove a worktree that's in the middle of a rebase or bisect. To me that 
is a bug in "git worktree remove" that is more likely to be triggered if 
we start reporting the worktree where branches are being rebased.

Thanks

Phillip

