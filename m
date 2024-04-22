Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6AC45034
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713827045; cv=none; b=mhomah/KagV6inqj6jcV9eCAr4sUD2dD4DoXs61DB5/8P/fIN9E/GVr4vKSMK0Pr9xhGR4nMOJ1MXzPBf55bDT9o1RCP3/YNzEGCC9Wzb6E4Ylsd69soOgRnFnth0EKWBWvA9ZP8gfWlvIbU/zlZOO3nhsKUHC0L12DNOkK+XEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713827045; c=relaxed/simple;
	bh=tWFf6biBqFuiZOYa0m+Q1dNkFaLW06SF3hV88zYJz5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FW0KePfde/yBEsn17sp9qCfpUJOLCnPIst/9w9UCQ0i7BStSW4PKseo2pkOyQ59xa3uqvOUrwKJUJHjeZUQYwZwkuAM3QCIcv+iHs5ZERvpXXVHYvQoeXuGmgk6gBZL+VAgIsnim7M9Ko0h3LK1HU3qHZsmukTBU/a9mUP3FXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi4bFOgp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi4bFOgp"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-344047ac7e4so3510618f8f.0
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713827042; x=1714431842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NBBFqXEEHyF/ySWsmsq7Cj1pby+uS8kZpID8fPG5rSc=;
        b=Mi4bFOgp0ygL7kiS3PjtfCPRTa7PXSgmt+J104c8f7Cg6uzrd5XdEd2v1fgezfJPIQ
         Yv5ULVZq7G/Ho0EXfkzI+eeevbdomj+5lnDIOxgKN8thknaogdoYV3mSRei0/1Yoxh2t
         yPBNKqNgEKeEKR8Jl7MdQHwMCmYXU1z9HoY68nsrRztqnQREqDW+OgHbF6VjQbwt0t5y
         +4S4qbNi7ByJEcSD+qaVDTnwlgoRHJaRQfslnFdCSrV18Hco3Tf2nkxxLKM8QssIQb5c
         1JMcfsIZ0aW+h6VaqLF6fscAwTi9jTndQTDSm0vLopLk4e64PC3ipc2yWOvLPRdDL08H
         FfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713827042; x=1714431842;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBBFqXEEHyF/ySWsmsq7Cj1pby+uS8kZpID8fPG5rSc=;
        b=xAJbNgRvYgP9/hj4Hp4SZN8M2Txbodly5R9Cte512Nb7wL6n8l3PHc5UnL0feWkEuf
         SpA9RoHQMzUbbGlNp/eRbn/O2WcfbCAUdBgfwA9uuc8QRI9W5dKD4MvnBFxv/UKlpQiu
         Us8hw9kXd7IEtFtDRiAsVEymavimXc8jd7P1hCXRT7Pap6m3aPkRfN1jPmMTU+69BGam
         3KWbgrJ8vDPie/uZBefO1DPldj2QJd5R5PiBCVjIFSUswcHqvVaPV3ByRDApZQVegx8q
         lJe/yh9gs25Q4Nw7yLrRf0eCPlxR1s8N1qj57lzsD0x9D++Zb8ILjrDaGeSIlRYpDIFz
         AOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE6D4WyETYWXweQHhIqmtOIrWsKQyCmeysXmtq1ehhc3GMYPbvcL98zt6VJSEkRVNScmBjt9Qk4rFrXQC5zX305j1z
X-Gm-Message-State: AOJu0YyelT+gdG7zo1KsOyL4vXQ9KvlOjt64pP4ZymKOc/iGp9jyL3Mv
	iH+bzBwhTDSwYunAkiaon/l5uu4hJ8/EWOPrQFye9dpwcVp5dQURUu3BNQ==
X-Google-Smtp-Source: AGHT+IE1dmyPgudk9j8/0zBK9Y7vwKzH87zaYIsD0sPBnzR6rAQSj6Mz7r1pauFxOmI/JvqCGbOV+w==
X-Received: by 2002:a05:6000:50:b0:34a:68aa:e242 with SMTP id k16-20020a056000005000b0034a68aae242mr734762wrx.0.1713827041919;
        Mon, 22 Apr 2024 16:04:01 -0700 (PDT)
Received: from gmail.com (247.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.247])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d6207000000b00346f9071405sm13091328wru.21.2024.04.22.16.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:04:01 -0700 (PDT)
Message-ID: <effc5e33-562b-4545-a58e-0c6e9a10ad42@gmail.com>
Date: Tue, 23 Apr 2024 01:04:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] add: plug a leak on interactive_add
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
 <a886c086-4b2e-4d41-ad40-b3fca20de42a@gmail.com>
 <55f1da17-6f07-4b25-9cf2-0de69bfb5005@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <55f1da17-6f07-4b25-9cf2-0de69bfb5005@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/24 5:43 PM, Phillip Wood wrote:

>> Plug a leak we have since 5a76aff1a6 (add: convert to use
>> parse_pathspec, 2013-07-14).
>>
>> This leak can be triggered with:
>>      $ git add -p anything
>>
>> Fixing this leak allows us to mark as leak-free the following tests:
>>
>>      + t3701-add-interactive.sh
>>      + t7514-commit-patch.sh
>>
>> Mark them with "TEST_PASSES_SANITIZE_LEAK=true" to notice and fix
>> promply any new leak that may be introduced and triggered by them in the
>> future.
> 
> This makes me wonder if we're freeing the pathspec properly when using '--patch' in checkout, reset, restore and stash.

I haven't checked it thoroughly, but I think we're fine in those cases.
