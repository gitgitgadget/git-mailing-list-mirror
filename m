Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493452C21FF
	for <git@vger.kernel.org>; Tue,  5 May 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975176; cv=none; b=ZsoiLascxYtbQ1u4TTXontrsF+Vl6m7/GwJxY/oEUv03lfEu3MXMlo8DulEn5gw4dp70m4/5urZVPLHOroxzvy5TSoufgCMgizEsP4N9sFCwNo7amUX5IW2P8N638yGuMILEqhxSJXjM5RsJ6j4aFsGkL78xg1hjid8CaE2bTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975176; c=relaxed/simple;
	bh=P9YpxgPBwCjV3xm7oyE3G+Y6TWl6yj18+ahP6URzqLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XzJS5IJxZMpQFtZwmxuJHMCDgqSbd0P8Le0osWKlU7+WMR5tDgBv/Xfepmk+ez7nynC0/g1wRbIV/WYHtYecijoAZvs3uxt15a5/cKxYr9iu+mpC2Mp/ouQBZFyjNCKZExd89eZ79s+V46nmGJY5OwwIMik30WrVHvNdt/bGHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oli8Cno8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oli8Cno8"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso5612681a12.2
        for <git@vger.kernel.org>; Tue, 05 May 2026 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777975174; x=1778579974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x0h+L+DoPIHt3JIyDa0yrFePJecuGIdRdI5RsJS6U/s=;
        b=Oli8Cno8nAhszlncImDIbwnZoq7z/e8q4SwL3sbQKuRTmpDWlttLK19V1wv6KVrvzO
         CqChVVzbDI07IGE53NbiILai3nITOWI9rrWXHI4z3oY+zPa4k4ajqFZiaszI8wWjbCaJ
         1RxaT/tGLhsDEhjaNhW4Qpog+di9K8VeSC8GP+H5VoJolb3joZACQuN5P3TArbLp+d8f
         5b1iuwl0GwXX4f6YGpWSmdbn0NF6dipI0Wi8SiB01frOAThQTwwobJDRKZf9L8c3vfEk
         wyvqCtC/cp+ToSANEsx2HclSw0vT2H4qJOV9u4R0e/yKyWuwHusLfm5g/aglDArRxhYO
         2cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777975174; x=1778579974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0h+L+DoPIHt3JIyDa0yrFePJecuGIdRdI5RsJS6U/s=;
        b=AAMSE9etvOyLA2jead1gIoM3tK2mJei27ebj+VnmGNFwwuxcu9XTyt5Lqnu7AWugbF
         NZCWppn4AUS+clM0bJg1YzI9TF41U8/XG89eU5qC3/7G+E6H/Fv0GzERvfmyfdxZYg8q
         YuJXvxvAbOK81cDybKuEx9YLp/AwSdLc37yW+fKr4vRB/v+IESaVJ9Dx9PiE/tCn/9OE
         /msw4f2atgGaibg8nJdkMT7gM5rd+XpLKJwMJH0VmE2Ic/L02gak7dLiZuLDyzT2VgLn
         fRmJp+CaLB09Am0M8TLL6kspOoixWZRmE6/R6WbmyUMi5+pti1XnSj6VpUgNQbJLFdaz
         NsHw==
X-Forwarded-Encrypted: i=1; AFNElJ/SnWLhZotYEHwb/Sx1Dq44a+gmOHWg6TKmcFT8EyVVz1d4w/JlUdau3ngCiY03TBt1rDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbdPs00ZfXOV4Vh83AjV3XsosWwItv/4mb3hMjUQP3s/yPfvP
	e/b/G5vMLOsO9+27S8EQZlMcAKmistO5A7FralKYjmcj1FVF7MphI5u8
X-Gm-Gg: AeBDietyF3Uwzg5VxzVfr9oTi3pK/reylNJ11RyCdka6cny6VeKqjGZ5ppTVVzQP1k8
	WeIj2mNEL+BCv2WZxr5VHdPfjSo2YCj7J349bvQL8HS+tO2WE8Xu1ywXXWy2jk4LU9IS7IE7kL/
	v/65eHbrIumUdX1mO60G8yXFsKpBVhnV6QHVP47Fjg9loMVLzKrUfdd2Na0Xg1rCbTzTkycYJGf
	cn0OArQFxRZNsxI/QEDb1tZ4BjM1ihtcC/QVg8/UqeXf5FtSVI+1U3R9XXxuXSZiYvVR6Ev91ao
	3FaqSJ+xFgZiUTyHGgJF9K5o+mWIepVatafvMFKeGnRNY9DbQ3V8Hq2QAaJabGvFguorURO3+5S
	1QHoT4SHiKTJqUXeqNfOEryAApG9TLZVaGaNVizag9x89+XXYFmfzkuqYn7RHcx0dCeJb4F3hQB
	RUlXMN69ZRRHh28ZvRbtNQ1DiN9wU34mUfQBKkjlSE0wOGZmx+h7koLpSUUvEvpUlrB7hU2ntZb
	73499oQ0Ly8dsGjIhZB/CgcnQjmXpBL
X-Received: by 2002:a05:6402:46c7:b0:67c:4e1b:9131 with SMTP id 4fb4d7f45d1cf-67ccc1822camr918304a12.21.1777975173437;
        Tue, 05 May 2026 02:59:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1706:1a01:60e5:d619:d6a8:b2a? ([2a0a:ef40:1706:1a01:60e5:d619:d6a8:b2a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd90e0f69sm280151a12.4.2026.05.05.02.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:59:32 -0700 (PDT)
Message-ID: <5e3bcfdb-d3aa-4494-81d6-15b0dfd43af1@gmail.com>
Date: Tue, 5 May 2026 10:59:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git maintenance fails without meaningful error message if any
 remote is no longer available
To: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>,
 git@vger.kernel.org
References: <0f3ef394-d96a-42f2-825d-53cb475a2363@anselmschueler.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <0f3ef394-d96a-42f2-825d-53cb475a2363@anselmschueler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Anselm

On 30/04/2026 00:13, Anselm Schüler wrote:
> I have a repo with multiple remotes, one of which no longer exists. When 
> git-maintenance runs on it, it fails during the prefetch stage because 
> that remote doesn’t exist anymore, and gives a mostly unhelpful error 
> message:
> 
> $ git maintenance run --schedule=daily
> ERROR: Repository not found.
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.
> error: failed to prefetch remotes
> error: task 'prefetch' failed
> 
> I think that
> 1. git-maintenance should report which remote it’s encountering an error on
> 2. git-maintenance should continue fetching other remotes even if one fails

Since c75662bfc9 (maintenance: running maintenance should not stop on 
errors, 2024-04-24) which is in git 2.45.3 the systemd timer files 
installed by "git maintenance start" use "git for-each-repo --keep-going 
--config=..." to avoid this problem. Unfortunately we don't have a way 
to automatically upgrade the timer files for users who ran "git 
maintenance start" before that. I think if you run

	git maintenance stop
	git maintenance start

It will delete the old timer files and install the new ones. If that 
does not work you'll need to manually edit the files and add 
"--keep-going" to "git for-each-repo".

Thanks

Phillip

> Now, on my system, the systemd timers for git-maintenance use git-for- 
> each-repo. Not sure if that’s upstream behaviour or something Nix/home- 
> manager does. But if it is upstream behaviour, it would also be great to 
> report the repo the error comes from, since I basically had to guess 
> right now which repo was erroring. Luckily I have only three repos under 
> maintenance so that was fine.
> 
> Let me know if you agree that this should be done. I would be open to 
> writing a patch (no promises though)
> 
> Anselm
> 
> 

