Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAB5F56E
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706978344; cv=none; b=aunqo6Fplu8wCX8Y859jhdA+tKA2wOuDaigGOpH9hFdjXd+8uDxxKs4g33w4fCPzZVoYBFGk39Wp4DO8Tx446JpfdWkZ/EUFMatqLP4R7bNra6sPHzHYSu+7CNE+mte0dj8KgRRny5jDIf4zzqxAxNLzb+xzz56nVq/F6I/061U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706978344; c=relaxed/simple;
	bh=8AXwY5kdaBWnB3jewWN9ANQ8Oj4hDo4Ki5MbIXHyork=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hplRmTNHBBxDUbAWbiHklOGUodiD8bsoh5zVtfFsqg7II6EjHET9NiRyoLMPqig8ZrotpEq49+thY1C46tdiFY35cpfa9EYA09IVrZ7OR/suAt4a48cZDieIyTxJlKmTGuYAKTVftUqhU4lBejLrWW+zMroXzBBQOEnhrEsnQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0w+uGmC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0w+uGmC"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42bfd27f586so10593071cf.0
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 08:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706978342; x=1707583142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8wVXAtjELMEbtl4RnxJYz137dxq3zmDHuEo1HnG7udI=;
        b=b0w+uGmC/Yu3i1GCav6WAZUSsa1Yp5j6GS9bF/O76DhbofkUcy7/EOdqsuJ/sSRA49
         igkIa9sx1zLHRrK4EBQdenv4chFaW3sYJeQVF8vECtRxc6bgjVgftNTiMeYkRLJ52oFr
         Uk+aJUwJSrSKAi7vEEDFVSKsyd3SfUnqVYoLi5KiOqmKVNq5Ig5leLdOvkAgkmN3DTT4
         Iurr/ReN2HVGUgwr2Y44OMXB0WGyF3/BteIUFbGdFoIUTQIh9YZoQI6x+ia04qMfuFjU
         V4L2O3u+MbAa/8Yg48h18dnXr15Yfw1cOFP4MNTGKo5Y3Peau9h5G2H+fm4QGKZEJXr1
         eLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706978342; x=1707583142;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wVXAtjELMEbtl4RnxJYz137dxq3zmDHuEo1HnG7udI=;
        b=OatcrQAtlVsDi21zGNg4TfwyHvbtD7EujMXAsFSoVoXSNkeTdryRsl+cW/pCQYdawQ
         q8JR2rLR0sfHHFN3Vmsp8diUEUYLBUfOXSZhu0auR16oTLC2ez0MMSwkAnT+s5eqa5AZ
         2nfUFHITwZPvXc0OGkwZWCnt6bpzCASdK1jMAGnqnHiAPkltY1b35EoQ5DB9ewdgoBlN
         7TmKDHDrvAcseBiRwx6yr0oMKDi3Zdmc1xM0U4StZtf4x10HfmlRvwskHkpHyb2Mz8YO
         q/yiHY6yfTEA/eAdLofvJvadgw+DmacfsgkLEdQpFR3vr8pxhWOW1VEcFrOASBCqcxHj
         oqvg==
X-Gm-Message-State: AOJu0Yz8SEwGhCcrVRQySYXPcp2iOrR27nOOcyuuZ09Xw29BdpDaZGLf
	mhWHd0NXw9Cal+M1/sXhhfx/v5x9q9uxyL4mobk8NWEPGI/cM7FvAB8foCtD
X-Google-Smtp-Source: AGHT+IEze9u8egR7ZlodSQxRSCGUkPxYsmWaXkrd+c0v3LKIBBrhtJggCIGBOoylWny1MpCJf+QOsA==
X-Received: by 2002:ac8:7f14:0:b0:42c:b23:b493 with SMTP id f20-20020ac87f14000000b0042c0b23b493mr1734879qtk.12.1706978341700;
        Sat, 03 Feb 2024 08:39:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUtzErwU3kl99frUT8Pv+rc0RLGpIt+VOZ6HjcIQzQ8iO0AMpK1o0YcZ+3Be01pSX757QqVxih4dzv8jOwUpfoM3S3B
Received: from ?IPV6:2605:2a00:9000:dead::beef? ([2605:2a00:9000:dead::beef])
        by smtp.gmail.com with ESMTPSA id fg19-20020a05622a581300b0042a554aaa22sm1929671qtb.63.2024.02.03.08.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 08:39:01 -0800 (PST)
Message-ID: <933f9867-0f70-40fc-b434-0b000b0329a4@gmail.com>
Date: Sat, 3 Feb 2024 11:38:56 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-users: email list has become spam-drowned
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
References: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
Content-Language: en-US, fr
From: Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; keydata=
 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
In-Reply-To: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-03 10:02, Kristoffer Haugsbakk wrote:
> Hello
>
> I know that this list has got nothing to do with git-scm (per se). But I
> was recommended by Dscho to raise the issue here.[1]
>
> Maybe someone who happens to be affiliated with git-users happens to
> read this.
>

Hi,

This list is hidden in googlegroups, I'm guessing whoever owned it 
probably got his account hijacked and the list may now be controlled by 
spammers trying to push as much spam as possible to list users. You 
could try reporting to Google but I wouldn't hold high hopes on any 
outcome from that.

Maybe a better option would be to start an official git-users list, 
hosted by vger, so control is actually retained by git developers?

There doesn't appear to be a lot of user-centric lists there, but there 
are a few...

Regards,

--
Thomas
