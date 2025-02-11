Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F2260A31
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292715; cv=none; b=lIR3v77cJ6C+IG6SY8Sui1bRMyTq8DldqcPHmLRslzaZZj590+B/QPLO2vwv0J957AZ+25Di68qEARHwK3tkYw8OpOkv0ahM0GkCYC/crPOdb/djMBD2Htt8HgLQd9kNlaW21InIRo2qKoR8j9D8x921DpM6ldPaTeoFC3hVojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292715; c=relaxed/simple;
	bh=ZoFWrF7onSkuKI64a42dFIqnS/VKT+mjMTQhrmbSZAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXeYJ1fToVwDjCmX2qaBrQ7RPnsokqbVu1vSMaGpylUNceji9sZAgmHw+LpMCYxnh+nVdmhPwacnR1rKq5CwG55tGgIq1VBber+BxTW02umAh2+1BiuGonOzyUUrl8p+AvzQy6O8nqYOnm/V1VG8qWAhSl4KRJ98YrfPT7rkato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8RE2qrK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8RE2qrK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-438a39e659cso40686045e9.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739292712; x=1739897512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/lZHcVFyEIkA9RS2vyh7wLWNCBs8hlOs27DP+5pb4HA=;
        b=j8RE2qrKR3SqwQV4rgcmyEy3J42d+J3qjKsTeb9pjsImvbJGavMIPBGEk/+Js/h/4m
         n9X70awn2VCVwk64LcL0O+FCd7Svxi3wLeRnXmY9L6bex1GbGTP44ehwZhFFZ08BazE9
         HjGiK0cxJ1vRbFIWt10Es3MlB3jOXqpOAUEJBygDYD7g8H9lNKMLqdPTOp/CuCihCROg
         KwfmHO/04OSNhQl6CER+XCdABEcxTOAholdrePNY/6/3YNn5CX99uI3VoI/C1RMyMJCZ
         Su1wtMZrKOjPrfTXKOwaLnDEsiQPgmNlzd+6M+A9XIaPUSDrWMndg9umIIibOOLdK0TR
         s/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739292712; x=1739897512;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lZHcVFyEIkA9RS2vyh7wLWNCBs8hlOs27DP+5pb4HA=;
        b=dmmIdGrXGnZ5HW3TO24KDlSDR0jCf5tK71prHPsQ0U7lfvIlZ0Re+SmOvSN5oU0AWD
         8pfffJzROyNVr0CsZVgTPQ5ov9livr9c8cEc5IMO2FE8v4i0gbwEh0OFbAsLBwszAxAH
         Y4xZYzFWb5pWONEgDh3sdjGJ5RPFwHHPHa1drwcWxQHsllnlVuuEft01lS3Noib1jSGo
         sSmgDYW/w4oMz3CpYdbTI5wJDYcPxUNZKsV+fEJUHtgLVJrjXESxNPoFu7QjER//ukHK
         VstaRSzUGgpGnxARl07FH8UC+WBXZZuspBbFWwSHsxwdTVHcvQ5pBmnMf7ypPz4yi3Zl
         Zg8g==
X-Gm-Message-State: AOJu0YwUFp4m+CEkHY1cWL7OoIeSBy4wDQGwSQItFQ8SUJeNY+OtaYiC
	XUjN9c8cbnrudF9hWjiJrgI/M0Ix5NEqd0liSfrFmXCV94hWqx/S
X-Gm-Gg: ASbGnctIzjZqJc7FYrlGZNmSdyPQDcxZw50kK+rtOdN2Qo0gpUg64o9uiX6z9+KJHW6
	49bhRCysEcwU5aHK/TjtNci3nVNLQlwpAaM+bDecMR8dUq94AkAw1JPTaA2FD/yaI4hX1+4s3MD
	2sk+shSW2RAKzeZFYe8CS2UNPsyxE3z+n9nk/flYXEuDi0ydr9mQmxuNuS8aAQd/1JZX68fYy9K
	AkGIOxF8esQ6aYlZL8zwyoZbdyJt5EKDTx2uu8AzaIoMC9HMOGtCEDcLUFEUNRZxRO597teJPEj
	reoL5Bw49w/UuiM2HElOYxYex2WgDNwaZjJaMOJESklZvnONnWROmRZo8ZTaWnlHgDM6dQ==
X-Google-Smtp-Source: AGHT+IGVX33pvNncU5LapW/aPbKJtlTXFJ7rXALpmsVzXW8c9H2Se0wQwXFVh/J37slv8g88kp4TZA==
X-Received: by 2002:adf:f702:0:b0:38b:d9a3:6cff with SMTP id ffacd0b85a97d-38de917fb9bmr524903f8f.16.1739292711816;
        Tue, 11 Feb 2025 08:51:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4ebdb8csm9721882f8f.55.2025.02.11.08.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 08:51:51 -0800 (PST)
Message-ID: <1c6e6e0e-5d99-4842-b76d-b57f7c6855a5@gmail.com>
Date: Tue, 11 Feb 2025 16:51:49 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/4] quote: add quote_path() flag to ignore config
To: Justin Tobler <jltobler@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, christian.couder@gmail.com
References: <20250110053417.2602109-2-jltobler@gmail.com>
 <20250201201658.11562-1-jltobler@gmail.com>
 <20250201201658.11562-3-jltobler@gmail.com>
 <76390e3b-e749-4d28-98a5-05db7c5fbcd3@gmail.com>
 <ksta3edbxwkl62u36xif63q4ebux5hdaxkbme6v6li5v3sgndb@nuu5yyp5clbk>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ksta3edbxwkl62u36xif63q4ebux5hdaxkbme6v6li5v3sgndb@nuu5yyp5clbk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 04/02/2025 22:39, Justin Tobler wrote:
> 
> You are correct that it isn't neccesary. From a previous discussion, I
> initally thought it would preferrable to have consistent output for this
> plumbing operation, but as you pointed out other plumbing commands
> respect core.quotePath. I'll drop these first two patches in the next
> version.

That's great, I'm afraid I don't know enough about the rev-list 
machinery to comment on the meat of this series.

Best Wishes

Phillip

