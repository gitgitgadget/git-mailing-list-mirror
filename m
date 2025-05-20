Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4225B695
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763981; cv=none; b=lVlv71WF2L5B/iw66qSvVlqEbxCLDnBYSHlyCePbIJpMU5UwYT1LqjZK3sm9y8f9Mprt05wnmVisc9asKc5tnYU5M9Vtw0PVrjzwT0dCVEx1hwz3oxwE2piuVwPWQqIA+8FoTS2ksUHER4xRIZ7LSN1Gf7F4v3pmwwmMMXGR59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763981; c=relaxed/simple;
	bh=wsVtqR730eqyffGBPrpDCaxrllADdnsaDMLMnYZ3vM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyhG7mr3V5fMDTwhCG9idF053f20fKlDqiaBmtO4hugCCuFyPQK58DztqvUmb1Rln8k415FhC17wHmVZePF4vuO3VW9qObZQRF4Y8YyUtQSppghSRWZmQiJLqtS8eMVXF4AJl2zuV4QSfYSFFsVh3ZeXjtWz6bw0AxdnwaItz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TaoCtlZu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TaoCtlZu"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c542ffec37so668151985a.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747763978; x=1748368778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5/Pp4vM4buJWBo7o/BYfQqRBwL/owsMiwMzv4JLBlM=;
        b=TaoCtlZua4d+WFgFoGTALv2tBvqcCLN/0URguceFah272VgJdZXZh27rGSnBrIKlyX
         xtOVEYBiak5NRPBASQnLn078tnfJNj351sUPFao7b1AyzrNKYiiRQTHNezc62R9rwWHv
         b/67bIjDcQothIBLqGUtIXQkBUHHNEWLLTSuJx71RqkPq6rOf0AfyN1lKDVC91BGrarZ
         sdhwqNc3bcgVZ74QlNP7bM6MqcMQQ9fzO/MSK9FALP94VmkT4CcV6UmA79ZDkisA4ltl
         PO5nF+zLg6nKzve3mUxp91uhlsMLdwYmvhHm0239mYYyswfJp6DR40yf+C5HNe1rAXWz
         q4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763978; x=1748368778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5/Pp4vM4buJWBo7o/BYfQqRBwL/owsMiwMzv4JLBlM=;
        b=PWFRrbuqE7rDs3v1BoKAE5TJCj4/rR7Pfr9nhKO3AbGymO6cu6sj7PYrP3P7/IAHvf
         Yf9TrFt387MVDFnSoJ0Z/lHecy49t4BJ78Sv9btavteI+WvHyanW2iVam7CEiPNNNm7X
         vmbSIKTunO6cdK8U6dqP4fcb7wbUlj40V8pwRTQ/UGQzwgYZ2WXdRtlQcdSD5T6GOc3/
         KxSYDZeVpk0ABb0C9JKt4thHqH/Qi871Uy9pPtHjTeZRtBtJSDGHRHBgkhGDGFsDfBNu
         DfPrSOd3vsfeG4LvDOrttDhn60UtpLBW7yjdzK+p0DawiEfy9ZTSYPGyZ42t+q+BX4iL
         VaAA==
X-Gm-Message-State: AOJu0YzzRNI6VH4XJF2Xs9wM8tG3RVnGaCKOkJjTgo3IW40kNlPWqt91
	oT/l/pHCLaZ9SNTVqALJArYMvPoDuOPJI0Rl8ROOta7LkY0IYlxgqgqJLkGD6YH5zaOBY4l1XnB
	InEz8
X-Gm-Gg: ASbGncugpVAOX2L1dMUI4KR6tVe70C/6eZfyAFOB0IlDvtGm6GD+f+g1zwG4zOeJoh7
	vgTMuZWG44U3SGgJK8JcqzNbdxpltM49l+0daHnDHaiZJQxit6GGvXudkJCRqKl1VG6NSGOdgCJ
	wvuhQJMgplwAD9+9tKp2BR3HtoBkja70xLLXZ2WOfsPfp6M08w7C0zQLwvhHzGALshEDtF9cAvw
	ZP0tUYUYO43SpT5vBd8XLSRfN2NHxKvicC57V3xYHdiJvr4ZW3NX78L8WCi4WEog8wkhqQCV4ev
	ZkCNZxoacf/EzyRyvubcM4w+39zmw6/D9VZSGIt9UbIEb5TZ5okarMi/e11uQfemUp0nkm8EBsv
	m+VwWzv5baDvxYNLOPsLd4FQ=
X-Google-Smtp-Source: AGHT+IFeiEPMVQgsAUoV4qwH27xcVNuQYjzi/Bd1b+wgl7jIPlZyOC2BoMC1x+UsaMh6GKMR2mAlIg==
X-Received: by 2002:a05:620a:2987:b0:7ce:d0cf:6213 with SMTP id af79cd13be357-7ced0cf65e0mr93231485a.3.1747763978426;
        Tue, 20 May 2025 10:59:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd468ccd94sm766450985a.109.2025.05.20.10.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:59:38 -0700 (PDT)
Date: Tue, 20 May 2025 13:59:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/4] midx repack: avoid potential integer overflow on 64
 bit systems
Message-ID: <aCzDCEK7OhCYyAZa@nand.local>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <9f07da4fe71d21b14226d8f0132cd3c8600fba13.1747753388.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f07da4fe71d21b14226d8f0132cd3c8600fba13.1747753388.git.phillip.wood@dunelm.org.uk>

On Tue, May 20, 2025 at 04:04:25PM +0100, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> On a 64 bit system the calculation
>
>     p->pack_size * pack_info[i].referenced_objects
>
> could overflow. If a pack file contains 2^28 objects with an average
> compressed size of 1KB then the pack size will be 2^38B. If all of the
> objects are referenced by the multi-pack index the sum above will
> overflow. Avoid this by using shifted integer arithmetic and changing
> the order of the calculation so that the pack size is divided by the
> total number of objects in the pack before multiplying by the number of
> objects referenced by the multi-pack index. Using a shift of 14 bits
> should give reasonable accuracy while avoiding overflow for pack sizes
> less that 1PB.

Ahhh, this renders some of comments on the previous patch moot. I think
that this is a not-unreasonable concern to be addressing even on modern
64-bit systems, since I have definitely encountered packs that have on
the order of ~2^28 objects in them.

I like this approach quite a bit, thanks!

Thanks,
Taylor
