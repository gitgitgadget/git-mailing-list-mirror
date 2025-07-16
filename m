Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2185218589
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676092; cv=none; b=r6HGqAlQcrp866C/+H/kL8HoPmUQIfnaTPoCtWpGPwgfQpqYRHAirG7UMO8MCicIGtKzfZPwRiVR097zK2uJYnN3l5eupEvRuTf4aSUcvQ+c6L4GVvIsfZ19abKNjQMmVF3m9R5GHuX/37GyQGRRBuwOyO9cqfSeSc/IjsRM8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676092; c=relaxed/simple;
	bh=DeyE+YqofeVpdg4Z0pjYAQzycOLYK7lwN7b0wtRtLg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bczeNVrCkeR/ens+G1vwCkIANR7Z5bZteqkzBJ6hIV6ECkArvxl1nmS5O3VADeXkSTW1/3VFVB79bAxJCW0GnMqQhIam3o0TI3q7v5wf0Ds3l8gd8Q2jw2lsuuXdMvBoAr3crSfX/MwCt3V3XERz+hXoSn+riAdqpEwDL/CBfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgmk7D5n; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgmk7D5n"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45610582d07so28732845e9.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676089; x=1753280889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qln2eAroE8a+depFb5eerVzhDRIJoP3bd2yQDuS2g8=;
        b=Jgmk7D5nfRzlGhTEXeLscFj1vAodnqpmlpQAYYHQiVXEIEFvrb2RXZk2vrP+nV9atC
         4ysxEHcOizeqwLXnXDbN27nE4NLRvWmw5DZaGOzHJxySAVrR5yaTY9rpNB2lFO5i9e5Q
         eGw2GbWMdoQuanVEJ8BoN67l0v8I8Bi2sb0EMBHNV8y2Lv/O4MYejei9YfxfiE/UcELV
         puSlRf8eyVl13H+pBGsD8s0/EDDuJgKWYn17sxqmgx+ZTP9a9x4D/ZVdBd6YgFRy6Uh/
         1TgIubj/3HbqZdvjR1JNaIxuiLlHNTs6JDJp3uPohWnOBN2S6SdbT5n87Y3dadpCz1EZ
         /j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676089; x=1753280889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Qln2eAroE8a+depFb5eerVzhDRIJoP3bd2yQDuS2g8=;
        b=mcJ9fwsi0fplsPZzPW5mK9hP1gK73sChYAgnABc+IYeUMYqdRsYVC0Vw4Kzbs8fGs0
         109xLMiyFvPJe/Pw3q4yTOMSvP3SSU0kFc0zh8mV9VYdHecMtoUiBVg9d+K41a3xJdA/
         SvYxXjvvemQuAIbtL55uHrwGj5noI+l+G7vSWJneAa+tpyvTSNY+DlIKQtusH4PD+9Yd
         ZhQlpYxqDQ6mr3p6pEdFUDnjcZsz36C2gHoLydvGUtL8eyTdF5DoHsJDOGkKeOTdPwYc
         xPELOZip+9QOjhMvjkroKUrA5XGBM2XTBKZlbq9uEB2sRLIneDlDEQI3wXA7vNrodDVN
         RUYw==
X-Forwarded-Encrypted: i=1; AJvYcCUbDp12sV7jXhBkvGjdDcju7FiJmI3qddud0ngAVadLzZ6P9tNT+U3Ptqm4/OizCQaMHKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUPnDhRBvFZhVWcIpCAXy+KsjgvoSd46FxH3j7c4mZhxNLakh
	f0bdtITGEM0oCfL7npaZxfrciVVGmjIk3b24KapzxwuX3fj+vWMRP/AC
X-Gm-Gg: ASbGncsL4aWfXqGS0wS77HLANnWQtBZuarqs6cd/USrkX5rULabCFDnHj+01Q3keped
	gO8jT+p6Cvzn6jWYJ5fqn4IuvRyIwKy13bKDXcM3IBHspPUDA7extcREXZmmgkekATutyoXKC63
	j90Wdk8Hea5uQ1UH60M2GwLmxy+1S3dBLj5E591xUlVqswS0ZtASb/kMO7HMlQ8E6WrFsprwIMW
	RI7WCiLwL5HNaf1XSBGQ8PLQqFR/+3wAq+/1AHiNEzB3ejEzz5VbgsimDZRQHzhFdGxc8mBAPNh
	kpekQknyA23DFBy/iQ2Hs1KR+UtjylJ/bBNbc3jevqvq7fhdsOMxnghdvDD34BD8G3uX38GIOfj
	zWugtGFI35RcWbYeeLRYTTCZ7VI86CJunNWO504cvEm9fIJpv1YTYKrKOXaps29j0jdVCR1cnge
	du4RoAo8l2wLY=
X-Google-Smtp-Source: AGHT+IETIS3GQas1BT+p3pSHtQV2v1hmZwZ1xwwQJOV/U5TRW/o/yemUW+4Zg2ks/SwFki2Ll8abFQ==
X-Received: by 2002:a5d:4d11:0:b0:3a4:dd02:f724 with SMTP id ffacd0b85a97d-3b60dd886b6mr2215001f8f.43.1752676088895;
        Wed, 16 Jul 2025 07:28:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14d12sm18216752f8f.70.2025.07.16.07.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:28:08 -0700 (PDT)
Message-ID: <51e75a0f-fc6c-452c-b1c3-2836d1508308@gmail.com>
Date: Wed, 16 Jul 2025 15:28:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v5 0/2] commit: improve behaviour of
 core.commentChar=auto for comments in commit messages
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com,
 gitster@pobox.com
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <cover.1752665506.git.ayu.chandekar@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover.1752665506.git.ayu.chandekar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ayush

On 16/07/2025 12:43, Ayush Chandekar wrote:
> 
> Hey everyone,
> 
> The aim of this patch series is to improve the behaviour of core.commentChar=auto by the following patches:
> 1/2 - Fix a bug which reads comment character of the comments in commit message leading to change in the value of `comment_line_str` and thus resulting the comments in the final commit message.
> 2/2 - Standardizes the behaviour of code by resetting the 'comment_line_str' to "#" when 'core.commentChar' is set to "auto".

This version looks good to me, thanks for working on it.

Junio - shall I rebase 'pw/3.0-commentchar-auto-deprecation' on top of 
this when I re-roll to avoid conflicts?

Thanks

Phillip

> Thanks to Junio, Phillip and Kristoffer for reviewing the patches and also Christian for the reviews and mentoring me.
> 
> The only difference between this version (v5) and the previous one is that I've added credit to Phillip for patch (2/2).
> 
> Ayush Chandekar (2):
>    commit: avoid scanning trailing comments when 'core.commentChar' is
>      "auto"
>    config: set comment_line_str to "#" when core.commentChar=auto
> 
>   builtin/commit.c           |  6 +++++-
>   config.c                   |  6 ++++--
>   t/t3418-rebase-continue.sh | 13 +++++++++++++
>   3 files changed, 22 insertions(+), 3 deletions(-)
> 
J

