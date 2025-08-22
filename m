Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D332ED85F
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854065; cv=none; b=CsihVP3oeh5RY+qk1tWpsH50ock3Lb+rEKmFV9r1iNiKTBJnhct7JCgF1bT1j+zwYwRhghyuqnuPxOFbtB/5tarvTi1cJzTa3gYcxq0S3gkbBsXAmN+/CME/SpyXCQB+5pVNJpNezX6au1Ba2xf6bOotzn/KieEPaR1mVUwOxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854065; c=relaxed/simple;
	bh=kahszb17MHjKcG8zETEYEduaLepXKrM4of+9S2nmJPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/DmG6/5zmwa4wPJBmr+SR2TKmz4URM7F5zcUF5IDvIKmJwJjaUnc3w2ERqNxz15QnVdICXIrN+L+j1s8FNQ6shr2T4ESSm8XkQzfWlG4BLUTI+iMror+HJbEASdcaGdzNdtuACtyH8RI1jl44FJb5GjpEP8SnPuE7iWvTVZfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYpXdumH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYpXdumH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so19696635e9.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755854062; x=1756458862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUJCrYCkfuIOBruj8/tiolepUrhnGMAUwdcOpm2zUdc=;
        b=TYpXdumHw11RYuLYil0ijFfUVlmhd889qDeaccRmHS+3L6fzctaWyZ5yt7VxSy0/y6
         7mXyWld7okj5EbqHOSxdSSwpS8QpBzaFIcV7mA14/Ri0XrVC4ZJ11DfFyWG6Rqt6i/IM
         m+rVHEhFM8g2zXzW90WP+GnM4rPgdXwrh0qEJG4XIW6NeaySKvEWPpMKiiqcpUT8E574
         78Vj9c3nmM+F3p/5f8BQRajVknF68fLU4r38NQB33bazBhAB7R3BlQamEiToj4+6/oBF
         5hEeWt6nYHrZ3pRwHY/mJIoZMDAnX/xozdm2NciXLr8rRziLZN4HWBnfMpjrFeCbEZaM
         EH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854062; x=1756458862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUJCrYCkfuIOBruj8/tiolepUrhnGMAUwdcOpm2zUdc=;
        b=Qlp+8ZBPiMAgx+re55TIvxHaVzB/NjvgoNAyO1TFa5qeMFvB1Lmjubq4t/779pmk7F
         lL8MUSzBJLUekJH0t/GHXFsGPXIVW+YO8rGO5tkl9dHdXPslWNGLZ8f+tgq5hmyDCXAN
         srix7o4f8Fhq1D19hVUZLzlEQu3F0LFwKFaFxOHJbZkJt+KWNfBnmMylF7AmmmfOD5V1
         ZwqJODTCdk2aGS0EK1FtAXQ+iJSuNGiGoKm6ErgITSq2hjNXkueltf186fKOntXT/obp
         ZTu5v21o+XbduXmD4SQv3lMf6YClU6BeNfH+JJynUZPlgGJgh0E2WNXuR5RkvivdSYLk
         d4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCXKSAeqYTCwYzKhYNopTQtYO/VrNP7fH+aDg4yoIGrGOqmEszaPePiCg2fKVeBs7bmaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsFCJDpYKRrpkaqefE2pXN+uVTtsCU0EvYeTVNpsMCtu2hgDV
	JarPCZw1yjUVPfNjaz9JcKEnWwDTgPPdzI+wJo0q8IOu1xH9t0eb0NR7
X-Gm-Gg: ASbGncv4C74kvE0nPrIKLMPOGC0O4FPT7OJx5A6hWdNlxnNZd47mg+CHNzLnuArcQUQ
	YB8QYbEjUHVEUsEmDwFCsZvH7kjGIbfaStoWHBxNtHeM8WPMdu2i1XeO+6tkgdYpmXdJ1T+LNNw
	UIjanKD2xI36pCrdVXsvgCfbtJI2kZejMIx2KqEPOrJlaEPhZHav6GXiPQlDBMbHsSgUWSilkgz
	AsGaXecYE2EKXJvKjLOCqiLQ6p7mhL2nGXOcYlAgVkKSTZOQtRx4N+OJSywDwUrcx+msxlK+a+7
	clRb6sgWqaiiwMFJORpD+MDqZKzVp5tC0IutXqJJMi/u3lDCPK2UhWcCOsK2jj8rjrwQHiFpNjI
	6aavxhrU2K+Co6a3eBMPYT9c4eRUVTOeMoBjJT1kAfdyCrK38zQtfzn8yRq0LIgazMimZq3FAmu
	g2o1GnhWh6euqrxtTU22bjo2asahcu
X-Google-Smtp-Source: AGHT+IFbrK2wXHko1x4xdwgb/oZqoTdf3wcrbDZxGUWz009+B7xn82d1QQ2fyB7uJOiHU0Pra5hrVQ==
X-Received: by 2002:a5d:64e8:0:b0:3b7:910d:8054 with SMTP id ffacd0b85a97d-3c5d2bb09femr1842369f8f.11.1755854061530;
        Fri, 22 Aug 2025 02:14:21 -0700 (PDT)
Received: from [192.168.0.103] (otg185.internetdsl.tpnet.pl. [46.170.84.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4f77e968esm4773848f8f.21.2025.08.22.02.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:14:21 -0700 (PDT)
Message-ID: <acbb5f69-98bf-4eab-99ea-08b3155ce9e2@gmail.com>
Date: Fri, 22 Aug 2025 11:14:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc:clarify which remotes can be used when contributing
To: Junio C Hamano <gitster@pobox.com>
Cc: Daniele Sassoli via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
 <xmqqms7vc8mo.fsf@gitster.g> <363ac6d1-8444-4d48-a66b-51ea139f4e87@gmail.com>
 <xmqqbjo98zjh.fsf@gitster.g>
Content-Language: en-US
From: Daniele Sassoli <danielesassoli@gmail.com>
In-Reply-To: <xmqqbjo98zjh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/08/2025 22:16, Junio C Hamano wrote:
> Daniele Sassoli <danielesassoli@gmail.com> writes:
>
>> On 19/08/2025 22:19, Junio C Hamano wrote:
>>> "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>    https://github.com/gitgitgadget/git and open a PR either with the "New pull
>>>>    request" button or the convenient "Compare & pull request" button that may
>>>>    appear with the name of your newly pushed branch.
>>>> +If you're using https://github.com/git/git as your remote, you will need to
>>>> +open the pull-request from your fork, selecting `git/git` as base.
>>>> +
>>>> +The differences between using `gitgitgadget/git` and `git/git` as your base can
>>>> +be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
>>> Looking at the table, there is no advantage to use git/git at all.
>> Most of the document, including the "Getting Started" section, points to cloning
>> from git/git. It's only when it comes to the gitgitgadget section that we
>> mention gitgitgadget/git.
>>
>> It's true that there are no advantages of using git/git over gitgitgadget/git,
>> but I would argue that the disadvantages are quite minor and definitely don't
>> impact someone at their first contribution?

First of all, thanks for taking the time to review this series, really
appreciate it.

> Even the disabled things may be rather advanced features, wouldn't
> it still impact them for them to stay to be on git/git?
>
> Those started from git/git have to learn what different things they
> need to do to use GGG by reading this extra piece of documentation,
> and then if they plan to keep using GGG, they will have to do this
> extra thing each and every time until the end of time (since your
> preference is not to teach switching to GGG/git from git/git).

I think for someone's first contribution, the most straightforward thing to do
is simply to stick with what they have setup so far. If someone finds themselves
doing this more than once, I would imagine they know what they're doing and are
not beginners, so can figure out to switch the remote themselves.

>
> I have no strong opinions as I wouldn't be the one who is doing
> something extra every time, but I'd rather see our new contributors
> having to spend less time to get their work published and more time
> to polish their work into reviewable state.

We're trying to achieve the same outcome, which is why I'm trying to have the
reader follow the path of least resistance in getting their patch to the mailing
list. If they then find themselves contributing regularly and realise they need
the more advanced features of gitgitgadget on a regular basis, I'm sure they'll
figure to switch the remote themselves.

>
