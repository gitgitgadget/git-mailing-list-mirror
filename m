Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E0A14F9CE
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792278; cv=none; b=ln686ahO6glG1SrYZPEyzSPZtWHaEzDe1ESNGQY6CoiGhdVFRVpHdUafY6/sPYLYNFznDAW6+s9unyPjtznnYl352TMg3MMcFDQNEsiXt4YRhO5JZCOYLlGckr6/h2BclCWGHpgGQd2EytCXtRPyT3uhC0iFP1fisWfdu6I+gSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792278; c=relaxed/simple;
	bh=l97EPJP5H87HgSpCVsZZf146Z0cMpn54VPYlCMY0cRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sazuwHKkaJrP1geY3cTghNIAiUQeKDMs5J6g86YQdDwZuSetC2TR04qzZQTDxGCEICXrGe90VJP0D2jIpivP+Nfe1Ihns5K+5e36aLe8ezgsX15KHzBpQuawPwHSVT+QjQ1djhB9gB19V30vCD98z6nUfPRAAgUe7qU5j93qYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gh+7vyvl; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gh+7vyvl"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b5254f9c32so1327143eaf.0
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717792276; x=1718397076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDJ5BjTbUqPas1zRW7B2ZW/nJgOWb9Gbdlx3z1AsTYg=;
        b=gh+7vyvlp0ru8r5UeV2NVemDCSkV4obv7Ib58ia12k/BD4+fOvV+wsqDbgW8jlDB9N
         P7HxLxzlFAUdHdhPI1t+TOKByksZ0Dv+LdkYqAOTwvUkBpsB0Vo2jSoiMcN/lRHIoyyJ
         PFqmO05qU7S/6K0vZzGcMIev13SzG1Jy540CAcUVfWB8FiK62q1TwH6JWeBCFVjzZoMZ
         efckKxHMHmNfcuMZhhOnwpL7hNAlzYVEzNuWNUbRxJ6H9T5D5YsUMnYUBoUDJMZWHGsC
         opLP42p4eRNnpcLUkYpHLg6+6Exc6PckvYEn9bWLd4I2UvAcYTzQM01gNbjsRpfvATSG
         aG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717792276; x=1718397076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDJ5BjTbUqPas1zRW7B2ZW/nJgOWb9Gbdlx3z1AsTYg=;
        b=bzCVNt8UV4F7lFOyzL4pHhUAocEbWvxG8Iyhf7hQ7dwIjjrHhJ2u2+pRwRygYc8Bc4
         NdGMHdbPdh7IwoYCjDx8F5wawTOImvM4mH0mG7W9yfqbwTR8yRy1dXxPIncBHpAgfH6D
         /fw7CaEcv4efIgqRZpHyns9McqL2gpC48PewVcK79umuZcR4YLeNLwxP75znWot0PaHG
         Ra8cMp/b9mJ938Kz+/YbBrMUX/sPFIWDIibG1PqxJVzy4vYa8CG7YN/9tJ+/bfpvUkn4
         W4OZpwe448EypCDW9R+Gg2OphoYnNsMgr630fiByRp+gMGoC1hs/NQRNWbO5G65NfN52
         VQ9g==
X-Gm-Message-State: AOJu0Yyul0wEEX3NU9VXM2HgpFdDai//mZbFA7dUJkaYbndzb0a3W7Xv
	HkNjJvfFqdiMU9tQYPDrGPN2+XLppQV05UO7v6wod6aMK0MglR+LF1yL4ot5XA4=
X-Google-Smtp-Source: AGHT+IEAlUmXZJhtSmqrYBr2y35QTr/54axveAMi3cmtj4S3eA9Q4qwtCxj1OWpeL4mzf85XEHXQlA==
X-Received: by 2002:a05:6358:9105:b0:19f:1d66:3ba1 with SMTP id e5c5f4694b2df-19f1ffaa1a8mr385408755d.31.1717792276222;
        Fri, 07 Jun 2024 13:31:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038a72a35sm15185331cf.29.2024.06.07.13.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 13:31:15 -0700 (PDT)
Date: Fri, 7 Jun 2024 16:31:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/19] midx: incremental multi-pack indexes, part one
Message-ID: <ZmNuEinqUV7DJQKQ@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <xmqqwmn0d4dc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmn0d4dc.fsf@gitster.g>

On Fri, Jun 07, 2024 at 10:55:43AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Part three doesn't exist yet, but is straightforward to do on top. None
> > of the design decisions made in this series inhibit my goals for part
> > three.
>
> Nice to always see the bigger picture to come to understand where
> the current series fits, but the above is a bit peculiar thing to
> say.  Of course there should be no design decision the currently
> posted series makes that would block your future work---otherwise
> you would not be posting it.i

Yeah. What I was trying to say was that part two actually exists, and
works in practice rather than just thinking that it would work without
having actually demonstrated anything ;-).

> The real question is rather the future and yet to be written work is
> still feasible after the design decisions the current series made are
> found to be broken and need to be revised (if it happens---but we do
> not know until we see reviews).

Indeed. I'll make sure that before I push out a new round that the
rebased part two still works as I expect it to.

Certainly all of this could be avoided by combining the two together,
but I think the result is just too large to review.

Thanks,
Taylor
