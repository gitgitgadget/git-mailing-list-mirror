Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759961F463E
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868997; cv=none; b=ZQ5aiNvedJPX+3mSHZaPISneGkYTkhE0UBEi1t+7FJzZd5SRcMr/0vm/IF5QFjf1nTGjn1+ymzZFb/Co0abGPxd5Tj3DhUS6lx4rqqd5BWJdz3i8BJO1kPzwuHHABDSn7zdr49uS1wPoiMnrGE+iAqeyjC3o8xSY8BET+pxfs7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868997; c=relaxed/simple;
	bh=x9VNFzIOL52v+3bnlSipY+ErbVEU/+K3IcF1avyQle0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBkdakpMHPZx1qY/pZcoxbc61Qpj6eWoQ33Wn7srRafdk/I/JECZ89rFooYWy7ai81tQfBebO6uCN8ZeMQDmlTbiTN8s69rIoVSt40/bZfkdHXeGMnUbwI9K9msI8l/HoPD503MZF6b7kOPV6Mw2vBcc01TbfiLW3O8xYmzdQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Apm33BkF; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Apm33BkF"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso571941339f.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759868995; x=1760473795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9VNFzIOL52v+3bnlSipY+ErbVEU/+K3IcF1avyQle0=;
        b=Apm33BkFkvXQVv8eNVSex3AWS7o1aswXxgUnuWhj0Bco9Ghn5PCtHU8UzcreJzWsuh
         ADxdseahYSSiVz5NvJQnHUkYCotk7OlDaAClqQJsxcsyV8qe+OBq8zXQEGiQaLyLrkAd
         Kh6VSvSEpH76Gj2zs2q47dirhK/hWDr9nLTXY8S2IBjEBzq0Pk90xGzQb6spmR4UtBnp
         SHy2NpUwiy/NSKbhzJUBIfUrucND6Yh9RczMlVd2MGX5qPdXhNN0fbQ5O9Fz5ZAN/t6O
         gdHQujsL6JiQ3fvw8fnJ0Pm0n7GlbN9HpYO5MsV1+bujOEiHR9+ffoyR6LIpzLinJacF
         rIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868995; x=1760473795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9VNFzIOL52v+3bnlSipY+ErbVEU/+K3IcF1avyQle0=;
        b=SdtLYVauYGZv3YKISgg0+M9YhT+RArWG3/gwkowSRbaNQJhp+CyRmKHHz3a2TgjOk3
         fhFTC3JqILzMG9+rDda7w89BJ4Tps3Ly6Q8e0AIlvqJAB4eILPprC+rcUOZrQW+Y7lKq
         FcF+x/6R7m7B0BVXiVaBY52trlcj7E8v3Unw0xa+S8qu35kr7v/qFyIvknsYpo7Nniz0
         eY2iOYiGPyKa7v2lcKx8r42Cj8uGmKklWFNLg2fzXfr8h58eDcEE0CWrcFQRkNNKk+te
         /4E2DZcJuT3avZcjh7K128sTMA3XYf0pLbKiKs7vO5AczwYCU+UXAkLxaPktefwcxhLV
         rz3A==
X-Gm-Message-State: AOJu0Yy56bfaH30O5vahybFvRSXO3ktr1W6RIPehPr1ujSBZkR9WG1Uo
	8mga7ee9aIlHLPV8Fd8X1adm0acRFfVnpPRNo52pp2Aq8UkYk2YIBFYUnHvMj2LFIr4=
X-Gm-Gg: ASbGnctZ1OCDHWPL3zNvR0GD1PARwifFVDDFfGDXkhBRIGT5sKvsCGylDRib4zKk391
	WIQFX6CWUUNdpFSAk65wOJY4ZByRJpQOgLMGeIrvHMHqspw6of90ObIeXnfwMNUVrrxWZqyMcpT
	oaNg//yt2zKdIyG/YVRg2UeOu+jQ+4JTJbyEK1M7R2EROPWyYE0vo+R8MH/PvutiFjuoxo4zM6V
	Z8pvUh6GFjlYxSHwhvi8aCsLcCmhQ7E8WGTGsUa+fPmwyU2ihXKw4ODtOeXWbO54SJMqNqTd5ap
	FWgiyCVXg6oAxPm6Lemu31/HW28Er0dTdAzTuKl5MpwW4w3JkEfKCSjF/ujgJ6Ho5BjbrSgKoqa
	Qz8szbaP8IwUlsslgzOo5tC2rzlgAfAvVsAS9uWyb7g+KYxnp+nYAR+9Y3um6AUN9pILL/1D+JF
	Ze6VAf7cT/7EgKOR1wZcMgcusY1AI50b5f3X3DwEm/2WqHKtyj5+Wg+cS2deNC
X-Google-Smtp-Source: AGHT+IFgOlu0VQy3k97Kr1nF07vdN2ob2oLKCv8SpHkUe0UIQTzEXiMjyWQuyUGj79UE/A8EJB4TXw==
X-Received: by 2002:a05:6e02:214a:b0:418:3b13:d810 with SMTP id e9e14a558f8ab-42f87369997mr7672865ab.9.1759868995319;
        Tue, 07 Oct 2025 13:29:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42d8b2a490bsm68379295ab.38.2025.10.07.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:29:53 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:29:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 22/49] builtin/repack.c: pass "packtmp" to
 `generated_pack_populate()`
Message-ID: <aOV4QBV8J+71Ikk4@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <ab0dc6668339f24787dc80d2dc05f0d31cfadae6.1759097191.git.me@ttaylorr.com>
 <aNsUkenrDY8YHgBn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNsUkenrDY8YHgBn@pks.im>

On Tue, Sep 30, 2025 at 01:21:53AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:08:35PM -0400, Taylor Blau wrote:
> > In a similar spirit as previous commits, this function needs to know the
> > temporary pack prefix, which it currently accesses through the static
>
> s/accesses/accessed/

I think that the original is correct here. "it currently accesses" as
opposed to "it currently accessed". I have read it back a couple of
times, but it is entirely possible that I'm missing something ;-). LMK.

Thanks,
Taylor
