Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BF3E638C
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919249; cv=none; b=jpNZvS+o2KuFFtMGkKFxf87hnU1fqgR82Nm37Ou7Esw32PScMiDBSVZ5POWqr+0nvcjHbP1wn5tDGAfk+0kQx0sFOfjc0dgiYLD2gvBAyt8gycTNLPmPczMAfuhqOFLjD5qnYBYzA/eMo/8ieLD8P6s8p79UmNZCvLoUKD3pS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919249; c=relaxed/simple;
	bh=c4YAZUwkK8fkHKFU/f2sPlzW3kLAIlZcsg/r05rgl8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsFKMwUoV06O0S0OWouVoo5osizB+L5imEJjYLdjP/QQ0yGyCmj46PywMQHprRjcatIsgg8p70ULhf7L2rciVTsQxYkHOJWsqxloGD0iJTpODyEzS17C2mFWSJUik5XBZRLm4lHiQo/yT6Jn1Y2rHX2d7QElfTlSkjYmrgWefjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAyGIM80; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAyGIM80"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d736211595so299760585a.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919247; x=1778524047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/yJKQNwOx5jDnikw9jQ3E/+152ax/ARzoaJzkGPWzo=;
        b=rAyGIM80zeCNNPZ4zHi/DWlawVCFLCJyExD32wIpFtXqH+1kGeRgtqulpJIGHF2dOe
         7ipe2LPpuHtk8YZxuLmoGgLOz6GVbqGL1sGIMdeXy74wMDpcFKBokZn1KOCIy43MCsjC
         RtOuCTtnA9hSF47+JJXL86Um2joWBay3viLkxDvhpjmvOvktuN5QosNicMPb0eUJv6OF
         VzXLcx2XxLVf/vgZSmKdoqAVSSzg7LW812Jd2XVYfvi6/+U25qlE2vesnOYcDYvq/UFA
         55guKglnFXeRTdjmbtnmHKzgYr2Tw0cIxYo+A0D7H0lf6J/nfWDzqQRrEM2OmBqMUJQz
         utaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919247; x=1778524047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/yJKQNwOx5jDnikw9jQ3E/+152ax/ARzoaJzkGPWzo=;
        b=N2goRDko4JyaqnWQjtUebqh1+vq0de/JRh5ahPaAptEfVM4IMiIfrco0VTiKL5i0J9
         ub0Rv/AfP0JySZlke5YVbwa1n7fN9SWuPNqbcwHOAUtAWh/o0BarHQSgQtcdk6+zh7ao
         FGHGmQfYByM4CDGO91l6mVqbFDIooSOyxK4Iq+tk5xvCjcUZIgjhUyRR2g9WbgZPEal+
         TETkiTHeqOMlvG+SLZ4VRqLPtmKmn5YSBRc0w58D8MoSm/i8CFGWqsjJn1DkZOYPxgZz
         8YvgG8tTNBgT0jRwqtzUnb/fpmMb7EbY/KPf+agMNcqhbxsvjdIdFE+OsS40iIQGZSOH
         LGpg==
X-Forwarded-Encrypted: i=1; AFNElJ9EShBaEt7H5XR+jdccpbePrmZYgH2h+wcxY+KFmX+ozu5QNmaDc5vtgs+MaVeuhiZeHcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTXCk+Du1uzJ1h/4Du+Fs9VDfYcl7auKavtmRNF2xh6azkBJr
	nlkgFxy1cBoNbbdA/mpN8BCz5084n4ayYUrUlGCbpEjSF6wA2wfg2AgO
X-Gm-Gg: AeBDies+TxUAs9HviGk9meMmg8VYZ6A7Qd18UzIVKEc/dwhpTDoPvzbZDC/oadLFHD4
	xOrD91m8es5ppz29Q0e5cUmFAwwM/QSiiM20kDRAzCN/bK2KjGDbpX7j+o2MyIBqGqvM0mG1X7j
	AufL6pBjD3KFgVjBBAmZseFSWfLY8jrt/6YPA2QRbxJnzVaw22kB2LtlOYYPbLcx0AN7L8ijEoC
	IAP83Gpp10tZDkpUpCLXYq61K4DqKwP6YS4kXCehO5O/RFRvEsCWodr+ie3ktZG16tlKP8rx9Fk
	iPuga89hyLu3PvH2w/j6axUon12UPGusa2XiTmNxUeFez9JD337RjLS2SOvB6YHzShunZFyNgw2
	UhfKKypXhDmWOozbg+uYDv9FMYAe2f5qlfGn1i0uPy9crA+oA9EBUBRMcTiwmMny4ag6UPegW1t
	ySitQTM1iBj2Yldc09URPLc8AteQFft9873TyBZiCkg2wbs69eVNzB9V3RIp/Ph8UiO3obYnhtL
	gCY3trskO9wL4IWlSg=
X-Received: by 2002:ac8:6f1b:0:b0:50f:ec27:5d05 with SMTP id d75a77b69052e-5104be42610mr182924071cf.10.1777919246820;
        Mon, 04 May 2026 11:27:26 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5108429202esm85120021cf.14.2026.05.04.11.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 11:27:24 -0700 (PDT)
Message-ID: <a382fcdf-a9c9-4caa-8be4-163c7bcbd64b@gmail.com>
Date: Mon, 4 May 2026 14:27:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] test-tool synthesize: precompute pack for 4 GiB
 + 1
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Jeff King <peff@peff.net>, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
 <29b9a74e915e6200ac2b4d98e446c1e73964cbd2.1777914508.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <29b9a74e915e6200ac2b4d98e446c1e73964cbd2.1777914508.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/2026 1:08 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>

> Benchmarks generating a 4 GiB + 1 pack (3 runs each, SHA1DC on
> x86_64):
> 
>   generic path:   88s / 81s / 140s
>   fast path:      14s / 13s / 15s
> 
> On CI, where t5608 currently takes 200-850 seconds depending on the
> job, the fast path cuts the pack-generation phase from minutes to
> seconds, leaving only the clone operations themselves.

Are these numbers accurate for the patch position in the series?

The previous change replaced SHA1DC with the unsafe version, which
gained similar performance improvements. I'd be interested to see
the numbers for both enabled at the same time.

Thanks,
-Stolee

