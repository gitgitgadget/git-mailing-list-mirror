Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934B2170CD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190810; cv=none; b=nEc6No65Wx4R+AwpiFWx3mcOqiJLA0QYEWqfHbVNRNOnYIQUSxQtY6pUg8qYFjz15ryGPwe1V7c8FLyX+4tOPiwU1eHSI0+6pGrs/QgDkRlhfUXgWeyvVAzsuX+CAlS0lS481CULeBygXMftTiglXLjLZGSm4wVchaoq4JsTFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190810; c=relaxed/simple;
	bh=7+Wd6bBAxn6hsr6IgHaP6ECQPsO3udxrw+4T85yETY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ4/WBgKTl80/dWqlfNx0HQzjzfNPISNqOnXPKaW3rEbxOkLMGvdyGcXNfNnBj/hsjb83y6dNg2QYgO8J6uB5fsr8hNexKTriScaQ22M8On3yfjgBrVb06beWUoxmD0w3JoFQqfE+RtXOs/gLy56FOoEwcNe5nfVc/DE+VfjeC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mKO6STgP; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mKO6STgP"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e29047bec8fso1987411276.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729190808; x=1729795608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWsn1KyNyE1MnoRAvXSlZW4Qz3hrzFfKFB4LMg1ogeg=;
        b=mKO6STgPiHSX0dvVkXH9JRxzJeR7uYhir4Xdz71cexYQ4qHIus25CdsJR5OG99Oiz2
         CN2LCBOKf+jFTt7qCbEje3PDWRgHJ7sdxdZuwlaY1j5hz9RWO/F3nM5gjYshCMeG7SjY
         19udQrEFawnF4/FAP7Lf7gONFi1zKqiHubwt+XwKfy0ECfcbA2y8NUsKn8XItHZeAvFl
         Fv39S0WzM8xId1hTfIZSs761eZUSU+zEi1mLgwKlHwek7w3505CU/QdoenWnD8yi+f3P
         Vnp49JSjY4QVQjk4t2S5VjRsQI+sVbQFL+JwevBEyykH1pa/T60gXOYuFhc4lE6DrOFR
         BuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729190808; x=1729795608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWsn1KyNyE1MnoRAvXSlZW4Qz3hrzFfKFB4LMg1ogeg=;
        b=Qn/e5LeeiPm9Ld13TL4f+YwcC+PORgRBsR3edK5OMzV85ZQYVOshBrvVSmfbb6yVkA
         IjktAE1AuuXYcffU8a+XVwBhkbV4PrGgf2+sphCNppXa3m5ZULxcY5tOsy6TaEf+UYR3
         bYrGsrPSyX4I8OxEL3ZeuwMKKL0ZdTW7edVd9woFpG9R/adhwsZ4jt7ic/xN31PFSR8H
         QM/wbNsZnBSELYmSaSbpMT+XU00CPJzTfw7lNus41MoHI9aRPLS6f43JH6gT74noiNCW
         tb4MiuZCVqVw/xFNe6oVdLyNoKrSgahjFGErngtotSc5Ju8Ji/mxv76S0Wd1h0UEywi1
         es0w==
X-Forwarded-Encrypted: i=1; AJvYcCUpvKSgkLNTjggBCeguP1k4ZZhN39AfzYNnt+uzrUBUJ1Z6nBP249joCY7Akth3sBOGh74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIb/BlDlKjtsuKBTm1wnjgJaxlDwBUaQEwyChLr/86axUCD2O
	/f5hyu4pb3l+ucQkARqM57wDgJgmKZwlmGeD3QKqHzhyKEy0NM/c+oi7if1Wz8g=
X-Google-Smtp-Source: AGHT+IE5+d2z8ydtam32K98kLBJtqTwfzOE/G5U+UduJY7j9XhkIjyFEVeg3uuuP35Ag7jALqtamlA==
X-Received: by 2002:a05:690c:7090:b0:6db:d02f:b2c4 with SMTP id 00721157ae682-6e5a3d5b9f1mr39327987b3.7.1729190808064;
        Thu, 17 Oct 2024 11:46:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5cbdc3esm12478447b3.78.2024.10.17.11.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:46:47 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:46:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Piotr Szlazak <piotr.szlazak@gmail.com>
Cc: Jeff King <peff@peff.net>,
	Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	David Turner <dturner@twosigma.com>
Subject: Re: [PATCH] upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
Message-ID: <ZxFblRri8Xo/lGsK@nand.local>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <ZxAttC1dQUllR76m@nand.local>
 <20241017023735.GB1858436@coredump.intra.peff.net>
 <ZxEr4+sb4DfmtrKv@nand.local>
 <a328b6d5-e604-4517-b041-59db19e1f66c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a328b6d5-e604-4517-b041-59db19e1f66c@gmail.com>

On Thu, Oct 17, 2024 at 05:59:46PM +0200, Piotr Szlazak wrote:
> On 17.10.2024 17:23, Taylor Blau wrote:
> > On Wed, Oct 16, 2024 at 10:37:35PM -0400, Jeff King wrote:
> > > > I think it would probably make more sense to write this as:
> > > >
> > > >      data->allow_uor &= ~(ALLOW_ANY_SHA1 ^ (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
>
> Much better! :-)
>
> > > I think we have to treat them as a complete unit, as we don't know which
> > > bits were set by independent config lines and which were OR-ed in by
> > > ALLOW_ANY.
> > >
> > > So this case:
> > >
> > > > Stepping back a moment, I suppose this is handling the case where a user
> > > > writes:
> > > >
> > > >      [uploadpack]
> > > >          allowTipSHA1InWant = true
> > > >          allowReachableSHA1InWant = true
> > > >          allowAnySHA1InWant = false
> > > >
> > > > and is surprised when the final "uploadPack.allowAnySHA1InWant" unsets
> > > > the previous two options.
> > Yeah, I think that you and I are in agreement here.
> >
> > > is the one that Piotr is thinking about. But what about:
> > >
> > >    [uploadpack]
> > >    allowAnySHA1InWant = true
> > >    allowAnySHA1InWant = false
> > >
> > > Right now that pair is a noop, which is what I'd expect. But after the
> > > proposed patch, it quietly enables ALLOW_TIP_SHA1 and
> > > ALLOW_REACHABLE_SHA1.
>
> Rather not as config file is parsed only once:
>
> https://github.com/git/git/blob/15030f9556f545b167b1879b877a5d780252dc16/upload-pack.c#L1368

I am not sure I follow... upload_pack_config() is invoked on every
configuration line that we see. So the first time when we read
"allowAnySHA1InWant = true", we take the first path through that
function you linked. The second time, we take the else branch, and
correspondingly unset the bits from ALLOW_ANY_SHA1.

So today that is doing the right thing (it will end with the same bits
set that we started with). But under the proposed patch that behavior
would change, and the lower two bits would still be set.

> So as suggested I will prepare a patch for documentation, so it will be also
> clear for others. Should it be done using same thread or new one should be
> created?

Either is fine.

Thanks,
Taylor
