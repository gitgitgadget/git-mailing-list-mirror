Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAC3A3E86
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835488; cv=none; b=AKYdr99DPkuYgkLaJmYprl7yRKVIAhjeStRa0CVDjeL/XutUNIsDahN7kOYlUUEWNLPTsrBfVdRCY2+5Cz8zB7OmT5X54Q6om/DHNrfEG2ti+BZwBDGPvi3lQ4j+IQGnQ1EBuId4owTAyz75nZ4iFkXvdXgI/8ihSLgpRkiOKW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835488; c=relaxed/simple;
	bh=jIwHfZaCUrG/h6IC3x6zirCo2A/k77S9nG36VxW55vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC9mRI5oMPhJiGiPjnop8u7W164y12JUVrEhgUwD5I8VoG7J1+QYM56rrhaOf4wj6pZHL5impiJfzw9EkAwNmrtyzhbwZBWD7G0PnCbSO+B4AyPwSCYTRs2wPmRnplhsgkYExyG9gOeEsmjwNS1p26XIf9WyziaEy/bV3Og5qf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OULaZTY3; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OULaZTY3"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dbcd92eda5so1610613a34.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835486; x=1776440286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Hi6tHwroFBhdAFN2HIOuzFwpLkNK+9JF+KvPmOk8GU=;
        b=OULaZTY3NsUQ1bJgJ3uhFlSDB6i2Gc71cEqaAZc03uvHRl3pL02B7lXPEFNO4RLni7
         8G5L3NBNC7eLRs5wHlyWHvpPd/0HnUpuqskEQm01HvXvhG/+j9LYy2ATYmL+uKkL4GK3
         oyhb0ynANJnK66ki2XU2hSDDb11JIkYNEwaSmOPI6RNSmoZNDe3+wjrFt/9H3ZDuqxj9
         3TuzYWMGU3rEu5fJ7xDwnIYYYOmE3rmbxoMmmxaH2P1Uax7BsPAJ7upX+QYoMT0mV5Vr
         ATENhgJxOV31JSP/1DCOfVkHTmT+hQBhasjW7MWc514aCULfe0iSC0nG0FtMsWaJkENg
         GjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835486; x=1776440286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Hi6tHwroFBhdAFN2HIOuzFwpLkNK+9JF+KvPmOk8GU=;
        b=MnxX3slsT+jvqyWWRRW/W8UA+kRuucA6Xljq81RnWTwR2QkeHBFVpDOHF9lwSXblPz
         /AJKswFQr+bZp+lUwc1LnnnyVg0QAJQ2Trr+XLQiyunbOGYxsugg1wJDNADYeFuGGBmG
         uABKZCSnXe401W6HiVKhuTs+cxQNB+2ifqDYD/YYXxP51EJB+eqKudI8Yq1ktWhLjsOT
         ZquHDbSwk7seWJq9vqAy1JamZv4b2ETLM618t2jJobQ11bviuq+m1WmNTEonmlUSWn++
         AbIxg4Lu0p7gZQ2KYUlpeVT/S3cXtJgCp7Iro7o/Pf/rvYOsZmeaECmiapY9ShwGISzP
         nZMg==
X-Forwarded-Encrypted: i=1; AJvYcCV070fFSci4HxT5n0aQSbmPJTgUdMzZKvDLbmGmTbDd0+23L42nuSFYOKx3lg82kCyAoX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLb4RvLqto6r5/JlNFh0Kt3VG/XSifN+aJpTy6cqgmFXkWk+r
	VeUdJNFomtVAz5iUnrjrPtcSCUEu0Diic4LV2ZqyzfMpWYyi1GdkcI9YauV0+w==
X-Gm-Gg: AeBDiet2iIeCDh1ELRzbKhkyF/6jAs/aBW3nIBuT3sQzNvhU5YvAaqYVWFjeGZ7NsXi
	a67ZqNhN16YrxZgK15e1lRz1ye0WV/zVLn/9RpF6Vp7PNWih/Nl5tHM+7nDLhgzpKusffeKMryj
	701BnlL7YFQ02gfe+To0jTxZINoLze4QQVZTNb6sy3KSEcQt2d3zPnVVkkjC/0Olh4by0vTGQKO
	nnK+luDMAb2PYJwmTKJZNKApPZuiIl8MdMWS5kP1n6B5/sH+cvJNwsJbKFOz8KSxXk38CDIdFPy
	qcgHUPxZyFqIfpqk4qhzI1FoyBW0Z1DoxO9pnaeBKSQ61D3FotDuX63zsQfDLD5Z6NpsYdX3IGE
	LYRe0MUAuyEK1hQxrBvkbJnn8S4zqW/N0X96wi+Zgx26/BNh6mA+rxgyoppy+IkJDH59hwcnorh
	skg5dw3euYBcfRD+DY
X-Received: by 2002:a05:6830:82a7:b0:7db:b7ae:ef05 with SMTP id 46e09a7af769-7dc27c67c51mr2538385a34.4.1775835486197;
        Fri, 10 Apr 2026 08:38:06 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2660ef75sm2148957a34.10.2026.04.10.08.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:38:05 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:38:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: drain remaining response on invalid
 bundle-uri lines
Message-ID: <adkOJLfxs8TNGRjr@denethor>
References: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>
 <adZ6yyGsoyjm7t0Q@denethor>
 <adiZTBH_70nrpiHe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adiZTBH_70nrpiHe@pks.im>

On 26/04/10 08:31AM, Patrick Steinhardt wrote:
> On Wed, Apr 08, 2026 at 12:49:48PM -0500, Justin Tobler wrote:
> > On 26/04/08 10:58AM, Toon Claes wrote:
> > > Because bundle-URIs are optional by design, I believe the changes in
> > > this series are sufficient. Also, the series [2] takes a similar
> > > approach: have the client gracefully continue in case of misconfigured
> > > bundles.
> > 
> > I'm still largely of the opinion that a server-side fix should be
> > implemented first. Unless we really don't care that a server may
> > advertise invalid bundle-uri info to a client, making the client ignore
> > the error doesn't address the root of the problem. I don't see a good
> > reason why we would want servers to keep doing this anyways.
> > 
> > To be clear, I'm not against also making the client more resilient since
> > a "fixed" client may still try to talk to an older server that still
> > misbehaves though.
> 
> I think that addressing the client-side is a good first step, as we need
> to also be mindful that Git is not the only implementation used on the
> server side. So even if we fixed Git itself to not report garbage bundle
> URIs, other servers still very much might. So ensuring that clients can
> handle these gracefully is a good thing to do.

I think it is questionable for a Git server to be sending clients
malformed bundle-uri configuration. Do other Git implementations on the
server-side exhibit this same behavior? If so, or we reasonably think
they could and just want to be safe, then I agree that adjusting clients
first to ignore invalid bundle-uri configuration from the server is
reasonable.

Generally, I'm of the mindset that when a server is sending
malformed/garbage data that the client doesn't expect, the client should
should be more strict and error out. In this case though, since there
are known affected Git versions and bundle-uri is an optional feature to
begin with, it probably doesn't hurt to be more permissive.

> That being said, I also think that we should fix the server side.
> Whether that needs to be part of this patch series though is a different
> question. Based on the proposed patch you posted it seems to be trivial
> enough though, so maybe it's worth it to just add that in as a second
> patch.

Ya, my main concern was that a client-side fix would mask its root
cause. As long as it gets addressed though it's fine. I think it would
be worth adding to this series, but if not I'm happy to send a follow up
patch to fix it too.

-Justin
