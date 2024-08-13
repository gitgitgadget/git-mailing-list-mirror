Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FD19470
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543319; cv=none; b=P5P6v1ZifbzyfXYdE4h6M8emqaLKUTRAUjSlxiMrONlMBGFD7DdnBDP4UaGVoIXtZH2oxqgei2V9Um4AYvmsPNyaN058l18Baf6IrB/8Rc3ErQRyExv4To5Mi6CvLH9qxv341mupJC/aT/YoFdTE3HU+/DNjyaD0pJmTs3mo4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543319; c=relaxed/simple;
	bh=cuB1kkS7dmN51MH/ss3P4iYP18piJfpRI/pv7mhHjIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uVNe3Zk/7qHoBHtF9kd6ZaaWRTgaiQXpnL0K+pC4swOvCodWy1QWwUVU4UGha8L/ppiGa9g9QgiEnu3GPmP4N7vt6fh8U89xLabmPpvAmtj/kAMAQsEAHAyWE02sQEIfGU5sFvUvQW9uNrk9fo801atGtjMDMFMn1X/zj98cVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0cpy2Lc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0cpy2Lc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e1915e18so36628395e9.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723543316; x=1724148116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mPRkOX6CI0rgGysPEhJroO8EbfBP2yLVDatiinoP0OY=;
        b=H0cpy2LcWHgKN2EtcuEcRWuqoUMgkIPHTsbzGLnq4yJF8ZtWKPNwcxOntFQlP97BMl
         JZPAa9qgrsrGX3yPVowUFMEKgo1E0LfKXqBMTiNsNQAPpSdYNbMc2NhWftH4JWDnTnMQ
         Ufsx8AWJx7M5f5G7zonOn9q5J59kjd54iRDsz0xXueD0xZ/yIbEaV8IQsBtIWM92lu53
         JBYRmQURxfYyWUe/nnp+F2gHv+efTCtg1TS2YjX8PJoGZG5aM61BOFaSdtuEy/8UYnQf
         SIeueb1WHp2bSmosP2xNYT5+HVDJva7kSRjVQ0gsl9BbC0jIaCond0Qvg0AzoNC9nmZP
         w7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543316; x=1724148116;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPRkOX6CI0rgGysPEhJroO8EbfBP2yLVDatiinoP0OY=;
        b=UPk8hNwG7trzKZ2ASBglZkRBdlQf6B+mAk/v7PfepFc7jmmMF/4RizyA2B/lxFQqfm
         7rmY12dWhbDxHXGa1Zlo76g7aW6W0OTgNvjEg1mZy1/E+2Bw1cwydden6/ps0JlBHqzi
         X5BK0WMkNVQKbCvSvplYSaFKDe8ljEbPL5SzU3uVRkQMQAGtf8/CCfB0PwoKI9KtK5Il
         /VOleYX+b1s4y69lNVz97f8xCk/q5t5mK6rrIPRtNCpvoG/+mfXj+p2yUIU2z6wSZeo5
         r5T8SV3c22GI6Ory8A8LPPCpohnKljRAomxoMJWtMPtiQgOqoD5zfR8dleklbDRnWrw1
         sV3g==
X-Forwarded-Encrypted: i=1; AJvYcCV8hbk6IksQEY6XgSpNu18OgERvHO3hR9dNl4/ZXKbOa8iGTe529IHh23LeM6dqsiCE8IpH5xW6d7Voyy6+WAhdTy/f
X-Gm-Message-State: AOJu0YwIPg14DdlPRYSOWMTnW071nIfjisDbT3GZUyz8cdr5H030oFgD
	19kaSrBeRxdKHXkM81VCihWLEXt8Sjm3r5XRsAz1k+zR8vJWLfvcsgly3g==
X-Google-Smtp-Source: AGHT+IHNFYHkb52NZ11CDYRE3AdMIihBqtLdssiJpgvv5zb9rr6v5D0ZZZNT5GKwZv6IlwDI28MrZg==
X-Received: by 2002:a05:600c:4f0d:b0:426:5cdf:2674 with SMTP id 5b1f17b1804b1-429d47f5c0dmr24089445e9.4.1723543316145;
        Tue, 13 Aug 2024 03:01:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7b1505sm216912005e9.46.2024.08.13.03.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 03:01:55 -0700 (PDT)
Message-ID: <61ea41e7-d525-496b-aa2c-f605b99fc3d5@gmail.com>
Date: Tue, 13 Aug 2024 11:01:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG REPORT] `--autostash` rebase + pre-rebase error ends in
 corrupt state
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
References: <17ea26263cf57664.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <17ea26263cf57664.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 09/08/2024 20:29, Brian Lyles wrote:
> If you perform a rebase using `--autostash`, and the pre-rebase hook
> exits with a non-zero exit code, your worktree is left in some sort of
> invalid state. This is reproducible with the following script:

Thanks for reporting this. It looks like the rebase code was written on 
the assumption that we only write the state files after successfully 
checking out the commit we're rebasing onto. Unfortunately "--autostash" 
breaks that assumption as it creates the autostash state file much 
earlier leading to an inconsistent state if the rebase cannot start. 
I'll post a fix later this week.

> You're able to recover from this by using `git rebase --quit` and then
> resetting to the commit you were on before attempting the rebase.

I don't think you should need to reset HEAD as it should be untouched. 
You can get the stashed changes back by running "git stash --apply" with 
the oid from the "Created autostash: ..." line that rebase prints.

Best Wishes

Phillip
