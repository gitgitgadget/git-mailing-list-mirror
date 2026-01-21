Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ABD313277
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012076; cv=none; b=em/zZgop/D1xHBp9JaYyNczh2fk6CI7x4O5n3YonDOaGDmUjJJGHDJyeuSU7Qs976Gc7TltyAf7yqX/ny3P5P+tkraGVcO1Mt97PqpU9yWll0UCN3Bj+iWlzG07gnZ1yrCKoUBn9ei7v8/OnR8SbWVlHfJCa57AGZOMOj4U+jvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012076; c=relaxed/simple;
	bh=ZSY0TjNNNDP1MfqtS7w7Jy/4NtBru2dyDGJn+PB7qPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=tRA6r+/NL/2jcCWvXZMeT5vneEEslpoqbV3ARq7f8hIaFIydHF+CFWrhxFM+hY6iQY/nZEtmJMRXM88MCSXqn/2Ql4fRILweQ+MNwuzjoiRo7MW9wPr4FMhKmwo+M+kJPmUu2qgaSwcScv2ileTpy+R9Q6c66zY7pa/fw2P+1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkJhBobS; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkJhBobS"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801c314c84so335395e9.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 08:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769012073; x=1769616873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3ULnvsJ2qpcpXfCPidD2V6gUaRuDeKNRhlot348Ljps=;
        b=EkJhBobS80OCMY6kGCWq/adIWed5guMLu+10YJWuk2LVlh/rNJHuzfXHtQk8M2waL9
         riY63/SxlnDdrWGQhijj0F2DezytQSkoxq0S46OH746GYvnKQFHyWcQSyoizStY6yWIh
         e3on/mdvMaYqJ8bXEJGgVcku2lUCb8v9swbz7ytEHKWQ8uZyzS1j6hq0Yo2yIQPullpS
         eUXGlaD8U7g6dZnxn2FIeE75KEWk0WkIoIs5rRs9N4dKiD1DIjhWqx7C1FyKE318URx8
         GfxTBrMATscLPd/SvTYBrTwRxTRoZRhT0ZcUWacz+4Z0gA23swZiuNHlJTau70U/Uw4V
         kJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012073; x=1769616873;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ULnvsJ2qpcpXfCPidD2V6gUaRuDeKNRhlot348Ljps=;
        b=RibTB8KDB0TfyVZ7EjR3hcf40eoZBoLr5ihVHDzoJdvgM7q3SToxTzbwGAFDIusYK7
         EuxhdQPw3pMrJ8Ytkz+//owlNUbqeUT4EhArTk98mrmDE1iwhIvKCycr27MC2kJ+HJSx
         OCJmLOpJIRlbl6gq9eB+ObyoB2BBjrojYME9YZ9yuO1vjs89MeIKhfZC4UdSOLt2BMAi
         VxH+Sn/uy91OFLC3VEa2jCrX5OX2JyNBcGmOHqCyvhetiHA1XXZNqcTip9zQc47StqWR
         d0surl+M7UuYLbwomYzX24mSSeW2tNeuAmw0CHWtsceWGZL+oKPH3TWx5dR83MxDAVU3
         JzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiLjS+en+64EzKT9lIki+Q+5WBt1SGbeyS2pnzuzTlsxI7Gi5N2COVHKPl136z3ixjgfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeW+LVk/N5UmAMY2hrWQLhMrOGG/ftbkNrUDe7yFxMlPkndjFx
	f/ckGrREQ/1GlEDGO5YABlw+tk+eArnPLm20bYFFXoZgokIiCoM7pEiK
X-Gm-Gg: AZuq6aJywmti7z+JG1yO0KDf2YKooDopzE9C3OKV/v/ERrz59oQszjL0AiXJ78MhsQ7
	TJLsXaEjPAxykAfbsYYlTElB/LnqjasBTf3AvgCcJv/gPW4OyPtAY+te/FfbQb7IdPSCGzxv8v/
	Dmfo2k36gUfhWbyuMm2RpwZyHVekWJI4JNiMLS5Px7ILP5yXtEAlZDpCLifBnzf4QttKMZUxxW0
	RRcnekl6LjqCVIjLQQdNZe2m4yatz1w9rcE697kRvjWitFUPiCOHz1o//4Ak1LOpCVirzFxMYsT
	15nXVqpUMtGVQob2gMAZbsqbeRiCDrH0Oc2zbflfWl+MifDVWClVqhK4P8iKXYY4IEA4Iemzg7M
	BnBDI1Qu6RLA37663I4s27PbYQHuqLZQFZo7cI+gI7DcHLYtrXmwc/kgAFTefHGAdAZgiJRjpyn
	LLi4n4KI9tjq2C5NBxE/9ly6MNxqRloV7KTcf4ShbMVzksDmt18pxSGWBJqe9xht86gQ==
X-Received: by 2002:a05:600c:3486:b0:480:29f1:120d with SMTP id 5b1f17b1804b1-48029f11458mr194310005e9.11.1769012072571;
        Wed, 21 Jan 2026 08:14:32 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428acae8sm375155475e9.4.2026.01.21.08.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:14:32 -0800 (PST)
Message-ID: <8a3f0711-2bf0-4991-82b3-b452c892a999@gmail.com>
Date: Wed, 21 Jan 2026 16:14:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jan 2026, #06)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqa4y832ok.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
In-Reply-To: <xmqqa4y832ok.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/01/2026 12:10, Junio C Hamano wrote:
> 
> * aa/add-p-previous-decisions (2026-01-08) 1 commit
>   - add -p: show user's hunk decision when selecting hunks
> 
>   "git add -p" and friends notes what the current status of the hunk
>   being shown is.
> 
>   Will merge to 'next'?
>   source: <aV_IGCld5T_dBxTs@Adekunles-MacBook-Air.local>

What you've got in seen looks good to me, the string is much shorter now 
and still conveys the current status.

Thanks

Phillip

