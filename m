Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19623ABBE
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771413609; cv=none; b=ruO7Eu5hmuCw589mhMBCqXQO+gX+EorL83ORz5FBrVHpGWg5UlWo9ZF7+xhg5orF7yxr0CwgYlqEwGLaXvLIcpkJhjVPJb5hSaI5AWcrnULM9u6sUF5TrEYHlXm/yQovVPeEMpw+V+F9pku2tWncH2tTKCxWL5lHYKfK7PH/JWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771413609; c=relaxed/simple;
	bh=y9dvhLSUhvaOwdGaF3u279Ue1JdxtXJf+tmraO2IWgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/4t/dpEwz+ar6+L/b70A4S9gbtZ1oIfVxP4feuMfiBYXT9RSyYpsleV/hg/NBYzpsWVak1FSPL0KClr8H7/Qy4gcB93O2uB7SNOTE6ovZYVE4AidLhlxtByERt5VS/QViGOwFVypjk76M1mHbNeuT1iXpeutcZ5dvQokcCc/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPSXYvV8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPSXYvV8"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c5ee7aeac24so342674a12.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 03:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771413607; x=1772018407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlQUanRvkc5x5ETTbHAGFTunqmTVYrEy1gOqLtnfPyI=;
        b=HPSXYvV8ZtUAFXQ+ui0ld7kksDlcaJ5DfglE5n8CSdg2WMTNv4BCXxgrcZD6NDbdFM
         NDDX2F1Zju1R2sHoNaUTe1FrjZ0NF5KBA5t18QvAKe3iINv5UpPmbbJ5/K6hbEbCCYaR
         0d/eFFpmQjBebuO1YBt3BKvq7Vojv7TMB0MzpgE++14imwERP4vgp0HCWyg3dwH1rks/
         Dv2ds91XjHTuM8MNHa9F7FHgR90kCu09HUS86ROqRu6vE3S8upviCFUNuf5QGWCg6yqw
         4OBpWlOlsFvq99Mf2ds3R/PvG76zswSYSpdc3sLYvNiW/st1UkvG1JobYLoRfwPsf8dg
         ofSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771413607; x=1772018407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlQUanRvkc5x5ETTbHAGFTunqmTVYrEy1gOqLtnfPyI=;
        b=M5DEZVkqmz41B1Z0rRmauSyUs/9vypAxg+ueCI8Qxaa+oH6TkqwgQi/W7rQW1AH4si
         zgnd1G+RS7DnjuSCQw6SIrnCi6/qBULTjO3m1S9L4AMNYhFl8k8i+MFr5OEvC3awmUdb
         D7DroL8oAS2m2ciVf1RM83uPOY13jY4TulfTWOEGKXJyMnF1bNc45YclN1VTUP3S+v/a
         bCNe+Ox3Gr9kQmTLYQkIn83naMXxbbXySH2LJEubCLcNVcYhtPTe3AnFTeJM3XoqKif5
         IhsSrw1VfV0BNRlDW3g6PJ4HYXXkAYu/j+LRHI3N2pBCI/+19knVfMd4acDoEZbP1lHw
         3Jng==
X-Forwarded-Encrypted: i=1; AJvYcCWIqDsRZoJJlL+83URlDqTzRM5cfOzMLFV4f0ZHjNLacOwd4pucuCp3pi48JEsPxpMQf/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfB/kmqJji/+ZjPkiZWeJGkHcinBCENcTkHzOewPF/7dJc9ejU
	cAKRh4uVwAIHymRw7syuuNnp4jOWTElURZNQt5ygE251agE/WxCsv7oa
X-Gm-Gg: AZuq6aJdh6k4VGnDqYLkptW7eWzkaLraC3PJH9qToWiSIQuaDMW9mWynifK1X1Zck/T
	WGfJPMKFD8M9xLmc05mnHa5lNJN+4niPYT/0yjZd86hJBef7/j7EW+sQ5zdQkAWDdclVdgVpfFG
	4hlBIc2qdRviys9nfBSz3X/9LfPrRkbrQP2f9r428/zEDYfCadQ4sxtJWa56BorYxFn3INb5aE2
	JL6clEFsNtGPpo+sHKDzAaiPn96QrzhydCTS/HxyMEiV5n6fhl4PShnO128gTRZEP9GEer8h+zB
	TDi7eXeJuutzbHUwJlGqqb+FrUCAJ1CAwgKaVSMDHsZyV68LNHHW08PEZ1Vh6SzSVzHx+eVBzOm
	0Z9+RKY/WA/fGKO+Ymx9dmI4gJVPSczwTCDlalDJA9tD331UOAPhnSwuEVr1AclrMvWht70U/V1
	PkXPbH2QBd2vp84GHfEf3Fbk0j/eY=
X-Received: by 2002:a17:90b:2789:b0:34a:4434:cf87 with SMTP id 98e67ed59e1d1-356a763e9e7mr11347268a91.1.1771413607539;
        Wed, 18 Feb 2026 03:20:07 -0800 (PST)
Received: from [192.168.0.106] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e537desm24856729a91.4.2026.02.18.03.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 03:20:07 -0800 (PST)
Message-ID: <5db39190-da1b-4807-bc2e-2ce631d7815b@gmail.com>
Date: Wed, 18 Feb 2026 19:20:05 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] setup: allow cwd/.git to be a symlink to a
 directory
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20260217084124.150366-1-a3205153416@gmail.com>
 <20260218051850.164972-1-a3205153416@gmail.com>
 <20260218051850.164972-3-a3205153416@gmail.com>
 <CAOLa=ZSAjDbC5bM+XvNwXW_WLWDiPfzAgaB+gHR6+DwhMW3uEw@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAOLa=ZSAjDbC5bM+XvNwXW_WLWDiPfzAgaB+gHR6+DwhMW3uEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik,

> But we don't really do this no? We were calling `read_gitfile_gently()`
> before and continue to do so, so there was no change regards to calling
> `stat()` here. Or am I missing something?

Oops, It seems I mixed up the changes in previous patches. I did make a 
mistake.

> But now we'd die. Correct? Doesn't that change the expected flow?

Yes, this is a regression I missed. If 'die_on_error' is false, 
encountering an error like 'READ_GITFILE_ERR_INVALID_FORMAT' should 
return 'GIT_DIR_INVALID_GITFILE' rather than dying.

So in v6 I will ensure that we only delegate to 
'read_gitfile_error_die()' when:

1. It is a happy case we want to ignore
2. It is a security case we MUST die on;
3. 'die_on_error' is tru

Otherwise, we should fall back to returning the error code as before.

Thank you for your time,

Regards,

Yuchen

>> +		} else {
>>   			gitfile = xstrdup(dir->buf);
>> +		}
>>   		/*
>>   		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
>>   		 * to check that directory for a repository.
> 
> [snip]

