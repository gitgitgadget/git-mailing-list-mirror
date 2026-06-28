Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4CCA4E
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782659793; cv=none; b=ojgvyNtIeni9EqwdzBAoqEFL1oXx0g8nMHgJkyZDL8txZe+6lLn9hjt4R2U1QaM4PC33NOV4FVfjZXTKlS5+AkgmsbI5sXSFfqHkKzMCuNHg5q3KM6O3kHHw5TsN47jkVChxdkFtAXYHF0rhhAmW8g2m+LaeXUAwsah8PbstmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782659793; c=relaxed/simple;
	bh=4OYdPl/MfJ8Yk1spXqS29opOLLLcwr9qMoJgN3I4GDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4+5d/MfiMjZRAJEcBE4doFxdWDf72qhZdNSuhLpRVvZT3af22sK3dPh3h+5JHzr1iUQyzeNnIycXV810ZfGmsJZ2Zwy49DcSbplclTdoB5fe+KdWSupO1hncQDMJVwOOGWFPUCZf1I7y/yxSu/+EZCQ2EoROrwyAI0FPWXvZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7bhDBeJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7bhDBeJ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92d488a5208so111997485a.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782659791; x=1783264591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xsfrWU3gJglrxVTMxBu1uAGrDUh/ehZLgZM+nskZ+U=;
        b=J7bhDBeJaRspmUC9U/3IQMi2xLBq2Xrnjf9RHhWppTgsKIEUjTqOCRSXj7OkTyeSnm
         GdKwtTj+tAqEd4KpQkiSaU+1yxP8jD48O2ile0mQsOxQ798Ttu/AaN1xsNZNa11YBWm+
         NMvuP4ZL2dDQ7SHPUMceQ+y+OENCwBxJv3y5Amh96UcUcd01HU/icDL3aEPubuLVfnRy
         dG2UR5Q6K2E1DTF/CI2mDmPz9rEzsazgb2fIJgyMDDaVWPavGOEN1oBoGxyd+6wIH/Sm
         oFY0m0Nk3qOsDKCsPZ+Rif3CMh+7V8FCxLgPeBsAJsuZut5ZAbrMY9TDw0Lv+Q6n3hym
         niQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782659791; x=1783264591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xsfrWU3gJglrxVTMxBu1uAGrDUh/ehZLgZM+nskZ+U=;
        b=SWAQ8b5rGN17qrJDYIXQYAttIFPuBloHKjYoPXxNX74hQ/IXNlmADz4syHZ5D+DZ30
         OXV9UgYzCG5gpI5MTe1Un0auDsLOrBGCo3r+JwQpn1pnydO21ZPB9dIhuvXszWSVhXu6
         /bGP/2txJ5EtevFHjfav+lz/llUvkSnCI82q++FjMya/iLjUc+CgiTOcC5gT9+bT7+eX
         sj37n0Z6Wixumc8H+112YVWktnAsYP08DaxO19R4Ve7r3oGitIrcIL88XoBHej7xXWb5
         KmVwX/tkwbC8GGIBvKt1ArzpXr4wV70psLk+rSdmcpSiwafxVGu7C9neV/SP/OwHMdgw
         6AtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cAmQowy2+avJwAxQ0LxsAAze34IVXCNyhPa2WupS3/I3FAgSoKrgXok6UokPGyeznQ4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwb89iKuuXYRZHayR6ztOJZ5nl3wybSFLI2SHJRvO9pRhWSzdt
	b2coSNrQVLF1OOs/D5ncRFfCzsuuujPek8QbURvw4qVGaMKsYzxirAKN
X-Gm-Gg: AfdE7cmtyM11vsRBKFWS53ppsuUTSovfqHMU7rsaZt55vYzBd0gbjLhTJxvG+tHbFOO
	rharaWSDY8ddgCOxCXTNfwvqL1x57RUuTkgkBV9vW0dG7B/KEeR2rfHCPrxt4oPUGF06agrMxEH
	YoVPWxe6ki85922zd8Za/okhGuE77EwIjfPKnP5TSP8XkAs/7OHJ5M/eQ4rGQEBIGUN7hQT5MJj
	RrPw9waqM0d6fNIvsROkI0Qw8YiDPdkAgPCClar9+OUHr3L5u5/jnUQoFa8JHs6Crj/329wOcyS
	LI+d7n/LHjcEIfmaTtxa0PSx2rEp9GCPUJmWs0X5pAOIV7NUCf/vrEuVeiw0O1806/k3bpn7pMn
	gNxDJAkEfEbBdZWmH04JG3VOcJeL7L8Ns/QaM9viemYPHBqaiFrTmduQlwoaelFx3JFOC2/ok4Q
	DIJo2fr953l5npJow9Mxx5ZdoA2VJPvobq3vNVD0491JD1D0XChiJF11k62fgiq4kv9aYCthRBU
	8V/dHDiMMqH9+BTNX1HvdOyncO+3JuhlP6aKbPL
X-Received: by 2002:a05:620a:1b91:b0:91f:3793:d90 with SMTP id af79cd13be357-9293b28445fmr1967615185a.10.1782659790959;
        Sun, 28 Jun 2026 08:16:30 -0700 (PDT)
Received: from ?IPV6:2605:a601:8115:5f00:1cfc:ba7d:cd84:71ae? ([2605:a601:8115:5f00:1cfc:ba7d:cd84:71ae])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600a87303sm1807453185a.42.2026.06.28.08.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 08:16:29 -0700 (PDT)
Message-ID: <48bfdb11-2624-4aa6-8fbd-d3f894c33bcc@gmail.com>
Date: Sun, 28 Jun 2026 11:16:29 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/26 8:25 AM, Kristofer Karlsson via GitGitGadget wrote:
> commit-reach: terminate merge-base walk when one paint side is exhausted
> 
> Optimize paint_down_to_common() for merge-base queries that hit large
> one-sided histories.
> 
> When the walk from one side reaches a commit with a very low generation
> number that the other side never paints, the walk is forced to drain most of
> the graph. A common trigger is a repository import that grafts a separate
> history with its own root, but any merge that introduces a low-generation
> commit never painted by the other side has the same effect.

> Changes since v3:
> 
>   * Fixed BUG assertion that was accidentally made unconditional in v3:
>     restored the min_generation guard so it only fires when generation-based
>     ordering is active.
> 
>   * Moved generation cutoff and single-result termination conditions into the
>     documentation in patch 1/8, since they describe existing behavior.
> 
>   * Renamed paint_state counter fields for clarity: p1_count ->
>     parent1_count, p2_count -> parent2_count, pending_merge_bases ->
>     mb_candidate_count. Changed counter types from int to size_t. (Suggested
>     by Rene Scharfe.)

I reviewed the v3 discussion, the range-diff, and reread patch 8. I think
that this version is good to go.

Thanks for your hard work!
-Stolee

