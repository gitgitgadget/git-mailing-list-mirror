Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E263CB
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487139; cv=none; b=jlCaC+7bEYhqVgqAcJplxLmfqaNMy5U6uJs3RumUEq0paJnmErmSmpvARCD/cWdTTstk82c0ndrPULnQx10v34rSR8G9q5no5wAIe+gyeGGJWHmmhdEp4Ehh9LH6tPXFLiMIVXXN2PHfqFsR9CA4xvVKv3i83Qsqh5ZcWmAIjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487139; c=relaxed/simple;
	bh=8AEihbiQG4bgKU1ARxszOieI/nrnpIiQmtFCtIXaV8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5BolIUyVAJri3skgi/hMJq7wPuS3PmQWd5AqmJ5WGuC6pvlzBMKTi5KhCx3v/J5dYerwgAmdNysweoERi1wYO0mVGomoefqMp9n0gN4tVhoCwZ+w6MZhmElrb6DTVLh/zOETGc4+QejtluimVVWQke1YnW5bCgopzBep479ghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2pFbsKr; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2pFbsKr"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477563e28a3so30987145e9.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 02:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766487136; x=1767091936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BJtvGsSWmcIY4hvD/MEe94dUknSX+gBI3nUlvglGUPA=;
        b=J2pFbsKrlWE1cinagH8oULA8PlMFLqhN09nsYlREOcMKxYvY1GW5aA7ufVSQti0Bp0
         hc5BJq5hweZJgBmYs+iC+BTuMMST4gtmiRDyuRW7owtH7xclcT6D/m0JkzJ3RFWiXd/Q
         WbSw38EHUe62dHbAjsf76Ur8v5P+SrY1O3LNdtMLI5P+HW44HVhZmIvBUDO5t3EO2diK
         zKF2XiF0uweJoM5KAAGXc1H1xi7MzSC5eN9zxztXlxI/c4x+6yKDIOi0LB5/w5G9Vho3
         UpK/VgCdLLYWww+lpLrTtH9fa6He7zArLl9u903T4jrY5cFb64f3gaR4u3KeZcfHnAqN
         XcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766487136; x=1767091936;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJtvGsSWmcIY4hvD/MEe94dUknSX+gBI3nUlvglGUPA=;
        b=lSGFCa1naViY1EGMdqlriVSL2MiCYPzpS8fYrRzlt+kkYhouYZ/7gI4nz8F2gmEo0+
         gHuX7z2Qn2WcPnsNmBQZ4WISSJI7X42CcTfsrlheIcKmnKWItbIQxSVcV7JPGOf4GTVD
         IPKKPNF31+nz0B/aiMHKCUUTcDaSxmR+/7UFq9+j3vpC4F07AJn/K5Vic6z7uk8+SKSt
         K4AacJnhsbtLqpEFXBe0gmG8QRJK5znboI5awXGuanTfmqWg3hCavxZ0RkWgV7AHHR44
         DlHmp02wjRGKs0+wCBGyax1OHLal/B9SyIRi03KqcA4UQffkACvhGKObW8fE0iJEgJna
         58rQ==
X-Gm-Message-State: AOJu0YzoR987kjmDvj/Yx0/02K0DIJ83AEtu6T+0CcI79NQCF4GhPQI4
	Yx3TvTGiqajbHjh4oz/SU9pfIJT4KUl1fwz7dKNFmdA5AHxrM6ap6tdo
X-Gm-Gg: AY/fxX5zEQpr7EMa7IUgVtLPgtxkNdTjsbk/4Ssvym1n14BTsEq2FiinKOffcYYczhA
	+oGeaiveNZnyHQVKmoeQ+nnmgZz+s4hP1YfNIOHfZEMC6QfXaodIUE2Bly3/kFA9jNb/H6zNaPz
	qeycgeBJ/F8xSi3gPWgs+4UPqL3+YhSwADCtIIfqepSeV/YoU0Nso+iMkjwKeUr7jFpf0xiHZLh
	Iz1wjKsQW471jEnBkMLoI24OXYM3K0ZcTZFM8d0dReHSMvI02NXDH37kE/gS56RbTD1Eo29rGQ/
	hDG0/bKBpvD0nJYqnjEWh3Lj5pQ3U2t/NkENfeSgXzA6GVHEOUZFgELb7kCNGGqW7KWTNRWXSjf
	r8gaQL2z27BdGZdSI6o/kREI3fEMt9VVyHjQm7gFY8AbaSLlFsIfxuSD5WGT4qa2Shfq2c46LXR
	nUpPs9u+1xx484QNKH1zYCkY8nETuRUmrLdscQe+48nW+2SE1DjW27KZfz/zVj913uvA==
X-Google-Smtp-Source: AGHT+IGcNmmgXIMK2xKDMbt/ukYAJSjeJ+IpLVTjz0Y7yziwQ1DkcQD/VM622gToYRH3pkGMrGzcmA==
X-Received: by 2002:a05:600c:8718:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d18b0ad6fmr135668685e9.0.1766487136220;
        Tue, 23 Dec 2025 02:52:16 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2724fe8sm342041795e9.1.2025.12.23.02.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:52:15 -0800 (PST)
Message-ID: <a5822145-5a5c-4a2b-84b9-7c061b3bab97@gmail.com>
Date: Tue, 23 Dec 2025 10:52:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] replay: die descriptively when invalid commit-ish
To: Junio C Hamano <gitster@pobox.com>, kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 christian.couder@gmail.com, newren@gmail.com,
 Siddharth Asthana <siddharthasthana31@gmail.com>
References: <CV_replay_die_descr.13f@msgid.xyz>
 <replay_die_descr.140@msgid.xyz> <xmqqikdxriw3.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqikdxriw3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/12/2025 03:12, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
> 
> How many callers use this function?  I am wondering if it is better
> to give a better message at the caller(s), rather than here, where
> we lack context to tell something like "You gave string 'ource' as
> the argument to the '--onto' option, but 'ource' does not name any
> commit" (in other words, "for what our caller is trying to peel
> <name> to a commit").

There are only two callers so I think that is a good idea. If you give 
an invalid commit name to "--advance" then it dies with

     fatal: argument to --advance must be a reference

so arguably we only need to check the return value when parsing "--onto"

Thanks

Phillip

