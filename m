Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418D2E419
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626579; cv=none; b=M8NEwuLZSR5tkPq0udD+Y6CwRoCNnvcoY1GZb/OtT2HD2arXRGkq8HkgbuDwmgGL93YVcP4ePf0yAQNlU4eA6WZe36c4dnEI/8EPIfb+P9E5yuOVsImvL40NRYAdSROO9D+ETihZRZL6S0zVZeAeb8Kj1A9n17finbpXOT4WlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626579; c=relaxed/simple;
	bh=O+/4tfyNLrjbNzfkvoQJWbLmX7unfFsG0ga1byroQu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BtHdL2TJety7lQhOQ3MTcvefx8g+VdRql84v3mtfjOvlXeD7BnHfT7BAGKjnPgD3atpBGA70S/kAU20Mprax+x7GcMmzPMc/4fepIfOkYxoX/6DlGhou8Yym6jZ3EcRW18Aqxymv+AVUExQrvh52XX7klNgbllaOCL7tFFxFGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enKJ9Svh; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enKJ9Svh"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so9517251fa.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711626576; x=1712231376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3UYKgzikhJP+4YrRyMtv28foogxB1w8Yzyxsm8LFsY=;
        b=enKJ9SvhvAlhX7XJH0AfAS/P0q1Q/mjTCoAyCeV4mfNE2xMixOTagMLeBe6Faiaf2C
         PEX8JlktrD0ltA8jZXSIUBe9/PCz73x5lTQYnw97fhaOcLEgWhG0PoeAt6xea7b7wITE
         teOZvfWMBLNwdSgIoBeasG19IKhDCdMoTc1rQUHKGUVvaAi051HwqsXgO126vyHj//jK
         i1mA6/Rx4+J9uzAR6FL4aS4LffijJvbGlArlkkjqAOq9iXhgtOrzQMJrW9yHU2Xxobwg
         UMEQBrzlDRQ4YjbUFj+twcvs7LC65w4RG8oLJnWsePfBKAicYN8OYyyXc61P38hL+jSn
         +XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711626576; x=1712231376;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3UYKgzikhJP+4YrRyMtv28foogxB1w8Yzyxsm8LFsY=;
        b=RsZTzL8JplJPSx0tMjnyUEwSj7DdnrRBlavRVwyeWxFLmwQa77hZwCWnu/GUXcFaDg
         nJfc/+HiN0MIcw0BljJEkQuttHs7BwdYYaMLyrqAvAR6IXI0ZL+U+tkIwYKGNd+wW/jJ
         VJnAh6LddBySYue24NAbDxaZ5HJvxe5IwTCjTdgWoRQEn0GRETVHl5jC8qleZNxqGs+N
         htTH4bjVWqHUsDyneNMhkKq44GW05xsG9KB4BX+kL/Ac2NGcWO7y2nFbCupF9/ZqXwxW
         lbgTGB2NXM3D3Hjk5kqoClGay1Y5vGvpAXpPMiSu621DebcSGNCgnc5vIfYzubxEzUo/
         FqiA==
X-Forwarded-Encrypted: i=1; AJvYcCWK/I7vOEQj08NkOnt50QUiJ3bof3l8PS4I+USsL4Td+sODIDMPpx7JTcqMphoxa+elHfWVc5/lEMK+Je97LJAREk3y
X-Gm-Message-State: AOJu0YxHtRcmyOUG6w2YCijyHKhmfYaoVQ9CMe8rkCZ0+DDgnLPqFsSf
	3GzwmsxgTqbjtRsV0MPmrfyhplWFtXnY583xpY82NAAukM8krW0R
X-Google-Smtp-Source: AGHT+IGxXJbf3/k5wlEP+JQio3V7LUAN8j3P2/QCI7bXuHAr00WdZwuhiPVsHZxeocQd2QtA5ymzMw==
X-Received: by 2002:a2e:3209:0:b0:2d6:d852:1757 with SMTP id y9-20020a2e3209000000b002d6d8521757mr1976101ljy.39.1711626575456;
        Thu, 28 Mar 2024 04:49:35 -0700 (PDT)
Received: from gmail.com (220.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.220])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c42c900b0041497707746sm2004397wme.0.2024.03.28.04.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 04:49:35 -0700 (PDT)
Message-ID: <8d226216-9a80-471e-9d7b-3ca8d21c1e05@gmail.com>
Date: Thu, 28 Mar 2024 12:49:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Update message_advice_pull_before_push to mention how to push
 after rebasing
To: zhang kai <kylerzhang11@gmail.com>, git@vger.kernel.org
References: <CAK_130T8sZUZAuvj4x7sB278kVL7ARaBv3Pg2djQB45O+7xKTg@mail.gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <CAK_130T8sZUZAuvj4x7sB278kVL7ARaBv3Pg2djQB45O+7xKTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Mar 28, 2024 at 05:54:13PM +0800, zhang kai wrote:
> Hi all,
> 
> Our team uses git rebase a lot. A common hiccup we noticed during the
> daily work is that new devs often didn't know how to push properly
> after the rebase.
> 
> When someone try to push to the remote after rebasing the branch, the
> push would mostly fail with the message_advice_pull_before_push:
> 
> > Updates were rejected because the tip of your current branch is behind\n" "its remote counterpart. If you want to integrate the remote changes,\n" "use 'git pull' before pushing again.\n" "See the 'Note about fast-forwards' in 'git push --help' for details.
> 
> However, in this situation, pull will "invalid" the rebasing. After
> pull then push, devs often will be surprised by the merge/pull request
> containing diffs that should not be in this branch. In this case, we
> often should just do `git push --force-with-lease`.
> 
> If we add a message like "If you just rebased your branch, please
> consider 'git push --force-with-lease'" to the
> message_adivce_pull_before_push, we may save devs some time figuring
> out what's wrong with their branch.

It does sound sensible ...

> If this is acceptable, we'd be
> happy to prepare a patch.

... but you should better expect acceptance after sending a concrete
series that makes the objective clear ;)

I see that we are using, in builtin/push.c, the form:

	if (advice_enabled(XXX))
		advise(YYY)

It would be well received, I think, if your proposal includes a change
for that, to start using the now preferred advise_if_enabled() mechanism.

Of course, this is entirely optional and does not need to be done in the
context of this hypothetical series.

Thanks.
