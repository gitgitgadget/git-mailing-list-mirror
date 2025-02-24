Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83913D52B
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410035; cv=none; b=aTOuHPL7t8w2UCJg8AyziaDP+FwtaRt3B/ORdP8VS5W3GrocPt2colzl0lwwUKsOVeHn+BhfesoaqYf+MhoYtD4pleHCz1OptBaioo0sGI8yqYdbe+D3h9E5Y3DeB2vxVznXJaBeRqEz7KUz2CGnHSs5E5vKKHB0RBqEeF/rnxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410035; c=relaxed/simple;
	bh=DEwlNTH1tnvy4PVPbUlIRTv9RI8HSdzjDxjSA86gPbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJcLb3jmxjKlSWZhHfpMV5Am9YS8uE0XKPKCiVWm9NvGl/EpDXFKuapaYzhohvq6/KfulFEDPoo/PBtMeEvGQEjztiHwmFQdHo8yoN4oENi2fa2/B02ibxZ0HKE/5k1HV9X5+VH9cRK24UARKBkRAJA871Bwl3lJBYGoX+lumas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiDw/NEM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiDw/NEM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2211acda7f6so100867755ad.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410033; x=1741014833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j2VPSgnldb1SXiFCauyGm4yW6LxwJS6vEH6dOzjadkY=;
        b=RiDw/NEM+niDml76Di2zE5mjIaVBMA5+oCIU+ctIIGksf3ygcXuAH2fxddtWplwn/i
         Jzkkm7LXnne220TrGohSXJMXIpRN7+vwumu7XXOJie2MTmSn6oIBV9L8ZDLIqbfeb3UF
         JYg2KeNTCzr523VDgs37AFFXYeDOYT22EKoPlKwUdnSDTcNmQXm+WPQJ5grvo01CB5U5
         HLquOPI4oqpB7JrBG3Nsm/JStBfI4pEIjpAC4H016fLm/g0VESYhf9/KoM4Wl0iUj+yn
         7zF+ivbbTocerl4syqi32wiEoS0+QSejcQvzz61n2H7ADnN/SHSKHCEsYblsMjBwXsby
         H0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410033; x=1741014833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2VPSgnldb1SXiFCauyGm4yW6LxwJS6vEH6dOzjadkY=;
        b=R69tuKVlqRzfpFmqXnmkOkfy4bggxbTkCbkIQTw14GYo7WquW/TdqH2ZXZeu3hFFLd
         hVPixCqrGBLEGaq4WtrUUv5NMvNTMJVwWJeyhSAGuFPL33g52YXI5cW2KaP8MWsEpJqp
         4rU27XTS7rpkrdK9tkYvamAoMWAkaVh77V71fKNspR20DEjRYz6V/Ya3FW0hIuP41MHu
         FbKmzDRYQqk2Xi8np2V/W4+cIPlERE1wkC21q5NJWDAOPZnfR+QdMA7r5Y+I6qiBvLSZ
         yWQHVPiXxSsG/bsAlHqy/hNRn7LcRl+EO/V7vASnHmtv9p8Ajeti5GX6P1Txlvf/ro/m
         RkSw==
X-Gm-Message-State: AOJu0Yyd+fbSqWLXFNySTKH27N8sP7rewdVidOHY3UzZxp0rynVpjx4f
	xHZ6OxcYdlvrCpOrAcum7EXvtsGkbgd6hMPpmN/3gZZLUzPr5+9f
X-Gm-Gg: ASbGncvGeCfJnQ5EZJQRB+aZkQmBDzPOxfhgt0rY9IZNwSTDnESQ0bQJvyfKCwOdj9M
	fAVJXcNQXgW1zuWw6GR1VozpJBE8A+ZhzFESEJKpX64I5hDJkBzl7cKwcHbCb/DBxISJAHdMUnx
	jxWZJTlKV5flAabJ9N5SnPsqgPLMpxfJWSK3nCirXKyS/UbDMTuswDA1QahhLLtCBHeuUMqdmGw
	sux0PHE3ftiWwX58RsOgzMJRCU2MgTK0QUOq8e3yO+lqPVijwWNb9Izdul7rxZCVar6P74I6G64
	VqbkE5EV6/XQZnvbN64zfw==
X-Google-Smtp-Source: AGHT+IFAuzYqOFiGr3RyViBLDiJQRLbUi8thqrDbeHxN1ROgockOANpsGfvs7drlInbHqx4NU2+jiQ==
X-Received: by 2002:a05:6a00:21cc:b0:730:794e:7ad6 with SMTP id d2e1a72fcca58-73426ce84d6mr21609334b3a.14.1740410033316;
        Mon, 24 Feb 2025 07:13:53 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7328371e36esm14403507b3a.61.2025.02.24.07.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:13:52 -0800 (PST)
Date: Mon, 24 Feb 2025 23:14:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 16/16] refs: reuse iterators when determining refname
 availability
Message-ID: <Z7yMuEzzRdt1GLRo@ArchLinux>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-16-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219-pks-update-ref-optimization-v2-16-e696e7220b22@pks.im>

On Wed, Feb 19, 2025 at 02:23:43PM +0100, Patrick Steinhardt wrote:
> When verifying whether refnames are available we have to verify whether
> any reference exists that is nested under the current reference. E.g.
> given a reference "refs/heads/foo", we must make sure that there is no
> other reference "refs/heads/foo/*".
> 
> This check is performed using a ref iterator with the prefix set to the
> nested reference namespace. Until now it used to not be possible to
> reseek iterators, so we always had to reallocate the iterator for every
> single reference we're about to check. This keeps us from reusing state
> that the iterator may have and that may make it work more efficiently.
> 
> Refactor the logic to reseek iterators. This leads to a sizeable speedup
> with the "reftable" backend:
> 
>     Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
>       Time (mean ± σ):      39.8 ms ±   0.9 ms    [User: 29.7 ms, System: 9.8 ms]
>       Range (min … max):    38.4 ms …  42.0 ms    62 runs
> 
>     Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
>       Time (mean ± σ):      31.9 ms ±   1.1 ms    [User: 27.0 ms, System: 4.5 ms]
>       Range (min … max):    29.8 ms …  34.3 ms    74 runs
> 
>     Summary
>       update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
>         1.25 ± 0.05 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
> 
> The "files" backend doesn't really show a huge impact:
> 
>     Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
>       Time (mean ± σ):     392.3 ms ±   7.1 ms    [User: 59.7 ms, System: 328.8 ms]
>       Range (min … max):   384.6 ms … 404.5 ms    10 runs
> 
>     Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
>       Time (mean ± σ):     387.7 ms ±   7.4 ms    [User: 54.6 ms, System: 329.6 ms]
>       Range (min … max):   377.0 ms … 397.7 ms    10 runs
> 
>     Summary
>       update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
>         1.01 ± 0.03 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
> 
> This is mostly because it is way slower to begin with because it has to
> create a separate file for each new reference, so the milliseconds we
> shave off by reseeking the iterator doesn't really translate into a
> significant relative improvement.

Interesting, because there are many I/O operations which hides the
compute latency. Even though we improve the compute speed, the I/O
operations would still delay the process.

Thanks,
Jialuo
