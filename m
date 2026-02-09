Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1D2BCF4C
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648506; cv=none; b=Yp50g+fWT2smLKhEHMzEO0s/y15dxZLuutY9QzCfvSxYaNAd4p+VrKMGYUtyMZUySWOrQ/2JIuLMJIYCmHh9ZeVJY/HJLD6qycByb7X7frZ4o1yIpWHlJ5NJVgizA3szQY/PfFMVSczZH7uIMEXjrZZ+w33OMVm/9Bh3LUPrSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648506; c=relaxed/simple;
	bh=SPnSmDT7e+gvnSQuIl5RAm+YH5AdcFISJFdByOpACSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz42R33Vpn5Cssx/4eu2cvLx/D6VVDS9hsvnU5oBV3z9A+jKUW/Fz5pu2lBX7puozMDmmjqCXCwDHB0kCrezfVS3B6yjDPS4NPhdYj8C58GUacIO+B6zlnyRyHrBJ+kOwm1g67K/5oL7cU4K82WPAfaQyFOcfwNPo0YkpXE3pFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULYuGu8o; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULYuGu8o"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c70ab3b5fcso426062085a.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770648505; x=1771253305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7r913E/FVNXvj81dXSIxEWJ6quE3SbfxMCNqkagdEU=;
        b=ULYuGu8ofsH+1OCWox49vW22CT8b+UIj+1kBiMSuvUDrfTxPODbJwLhCDyMqS8nl0t
         Blukij3zneJhs9zmpRNYTt57v0Q15wUeIkvAptk0kC4ImlykdwDYCEtagq87VwjdSQ2P
         IaG5x8qxBO7wVZ7MELpV+Q4nb9COTeheRzu1VxQn79ZjLm7U6fnXBG3kOFb5lqi3HZFD
         xyIQQTQII3GJODyKMANfmuNfU1et/HpQ7oQFk5enSVXaxjTWo1cOLezblUK0wsT/KJV9
         gxD4jftEpbXybTK5kcGyx/AyhMi8vOuxba9mCT+53vZx0oqx3Qv+KhRc1dkG9UmLngB3
         YPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770648505; x=1771253305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7r913E/FVNXvj81dXSIxEWJ6quE3SbfxMCNqkagdEU=;
        b=D6uQa63seygZBwwVcIREmOovCb0nyHvnPb6/pv+7ZXSNqaYyBJNo/GrdOwt3JnHWC7
         hutPEdHhEY9bbkYiWWuW0zU+k/LdFiYi8maS5T4yRfq5jGJNUjGQ1wE4I0Wo/HgRVRuA
         T+2nv1YskPahRb4pNcX8+xa8JsIjgQ4ZHgrcmOquAnSkhjx87BIda6mwX7oj+Qq+kN2g
         nMule3AqGsAkl6cwL2v0O9xAXGdJzf1NflOeNICCaCCxof3Y0Zjudm1q/U22CiHxHhnh
         KNB05dZks1bji+z8pePUYYHr63UcV73JV3tVb75wvT8SksFxjXZaknHdibHjdalzTlGe
         JHoA==
X-Forwarded-Encrypted: i=1; AJvYcCVothj/q8GtxNRbXktKazPYI8aUKD0ewgYCpnngL3gabS05N0uyxSpP48y60dSuedg7T7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Td4vPC3UYwrYTJ6I9gDzJiHe9Q3r1aDvNPCG7h1XLybSVprm
	KJWiGENvMYD6bdErkB2heKhwq0gYROz04hCHQDXZzXCYVpuqh1qi9P3P
X-Gm-Gg: AZuq6aLoUyNGN6+IKG5yqqdFOt7YY3Wi+xWMqMP36m3sB4v+Bapm7YXqg0J6euS+pZF
	G1WdmMCzlyR7sPt3u//AhZZlEhiQd2YZnJhOPAR8vISE4jinHHNkdPDZAJbxhGxqiqHWwDf+V17
	DuHTBTqbgkNYMSz/6XNeVemyKMgD3YdnyGqD/6qU8NvvJ864SA09JDgRxuoSDmcK2HyG5BKBt07
	X8HrM6RNVCnGC+boUNCf3ZeWWDxaZSMslkgvB9SM5r9/TLez78kB2vGdjzOuk2tWMpceqYRujbI
	Tq7YYWaeoejRqEOMANjp0O9GpnuUC7AE2RMaFZIMokpvZpbWqPUUTsWiWO/uvSoW0ciUYuFfy15
	WbchbJQcJ/EOfK1js5u/bpRzBdFGVaPJecLzQkX6EXu8eg0L0pktWwIJi0RSLIt0fTz3MfHr0uv
	dN2pJQkAMeoEyuTPBpTuaR1PJfhgUSALsFLWvXPKxWpOOtBxQbpc0WHWllzXZxUBBPiYLS
X-Received: by 2002:ac8:45d5:0:b0:506:52e2:e6d9 with SMTP id d75a77b69052e-50652e2e9abmr67280451cf.54.1770648504851;
        Mon, 09 Feb 2026 06:48:24 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5063e6fdb02sm75219811cf.14.2026.02.09.06.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 06:48:24 -0800 (PST)
Message-ID: <56c1a7eb-a645-4453-8024-b320c1ebd55e@gmail.com>
Date: Mon, 9 Feb 2026 09:48:23 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] trace2: add macOS and Windows process ancestry
 tracing
To: Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
 Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/2026 11:05 AM, Matthew John Cheetham via GitGitGadget wrote:
> In 353d3d77 (trace2: collect Windows-specific process information)
> Windows-specific process ancestry information was added as a data_json event
> to TRACE2. Furthermore in 2f732bf1 (tr2: log parent process name) similar
> functionality was added for Linux-based systems, using procfs.
> 
> Let's teach Git on macOS to also gather process ancestry information, and
> emit it as a cmd_ancestry TRACE2 event.

This is done in patches 1-2. I notice that there are no tests validating
that this works.

I see that in t/t0210-trace2-normal.sh there is a scrub_normal() helper
that removes the cmd_ancestry event due to compatibility reasons.

I'd be interested to see if we could enable these tests to demonstrate
your changes here. Of course, Windows, Linux, and macOS are not the _only_
platforms we support. They are the only ones we check in CI, though.

> Furthermore, let's refactor the Windows implementation to align with the
> Linux and macOS versions - by emitting the ancestry information as a
> cmd_ancestry event. We keep the older, custom data_json event type on
> Windows for compatibility for consumers of the TRACE2 data that use the
> older event.

I appreciate this compatibility approach. I mention in my patch-by-patch
review that we should eventually drop the old mechanism, say in two major
versions.

The code looks good to me, just a question about the testing and some very
minor nitpicks around recursion and strvecs.

Thanks,
-Stolee
