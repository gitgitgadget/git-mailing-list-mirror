Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3417993
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917261; cv=none; b=KQvz0xd8BdiWS0KDEvzD3BwXiqYC5WbkZjvLJ0wVZB8Z9adj3AgB6ytB252ZigRuYTRz2Ufkq9qFQnSrQABvAWsPmjBWg58VJ4waMEoRuWwUOm1Z1RqvBOsPzyYwkWwNe7tiq+WnVbrI2fSQ+8XSc1feC0z/iWZYLkwWL3/QYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917261; c=relaxed/simple;
	bh=pRuuPty+S5Mzr9ifBXfOqkOFRHgFf870N9BsYAnsKtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngrUnQaGLhSMktraWM+asz6sMqHvTAU/x2weo9X15vgDtw4gJvtbi5hSBvy/htjh5rSS12Dy7aXqqOiM61rF5FxGnX99o0ThP/Jd3OiZV5gIlL6vUZw2Hia1CN5z0YCpeeECbLym7DVIich7IMdosKZPvOrE4zL2jSV5QcMXNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IPFmPKkE; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IPFmPKkE"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e255b5e0deso3879177b3.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 18:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727917259; x=1728522059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=waDxr7Uhdbvbx99jf809NDJEXyZXwr5Ioo3Q5IOG+dg=;
        b=IPFmPKkEGeI1JKSsQKCHOGkq5Ns4aKSpaJRu2cqNiQSNiKOnZFWdYCZZacxbpDl68V
         vf4ibcl9+qrayI0TaKpzc19PWNGUzy61EWD4zF67MWNiCaAYPm4uljQBzP5zXtlqzEJZ
         UqMRpvemZlVSQZN8KhjEB/he6Z2OnWjHA74/3tIyn7kwGiixltqyl0XxTP9dnUmDei7G
         WVeqhJyL5S/QGMyOxn9YgW80AxsrgSfzIiMZrfezQu/2NcQ9hZBlHllbBqtsuVzZGSv3
         2LaOZcaizgLUiBH6m+OCTgm8YYp10fKN4qmZe63PXo4DhuKNoYGkyKbsFOv1Q5YHEgE4
         HLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727917259; x=1728522059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waDxr7Uhdbvbx99jf809NDJEXyZXwr5Ioo3Q5IOG+dg=;
        b=n1BSsX1yE/ua6Rnc7fIXjASD/atWNrjiaUWsHWMfJ4V7TN4CN8hlSNj4A9pr0lTSP5
         ju+bI5LZuNj70psHaCzZrP+mPA5p0V/HgSzQaf9GJ4KkckgyJ94jgoqYA1gAqJDYUTn7
         3bBJcEKRo/K37G5R/Ff4PyRW4VCV6G0XmGCQ6lpgsK6p4CPIW3QemZGoLQiJ6NY+xDnx
         4E2kXHiPPyeG8qvpjZwbI8KVmYHPAo+ZU45vJJKV7rowXd7TTXlxuMfm6Tp1bnXgyu37
         NZwgQ6tuHUy3SMEGLp2QYkQA7JkTs+bsEe46PozR8GiVOGm6r9otBzNPV9jIfJHVoi3E
         B5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE3tgGPq9HnLw+NXrylE+/ubo5Ta/5FuLgAfMD61RY5oP1x7PXsBuS9f8KugTs517785c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFsx9Qs87nRAeOj2Y9BO1W6znKE9/pEiAagz6nI9C33DQ1Bc4
	rBe0VT+BrzZxCZ6eG9WeRS87w/KIon4ufhKOyAiLPPL9e/VAgocosqAK14NUlDfxmqg1jiO5AP6
	UXDs=
X-Google-Smtp-Source: AGHT+IHgiwyJkdzUVDZW7CB/S65JAeigW3r6Gsr3CUBtb+5Z5xEJ+sYe9Qm3+8yaep0rh87YiGo9Tw==
X-Received: by 2002:a05:690c:ed6:b0:6dd:fe1c:4f8 with SMTP id 00721157ae682-6e2b536ae90mr10720207b3.22.1727917259222;
        Wed, 02 Oct 2024 18:00:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bbbb7838sm233197b3.20.2024.10.02.18.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 18:00:58 -0700 (PDT)
Date: Wed, 2 Oct 2024 21:00:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (v2.47 regression)] hash.h: set NEEDS_CLONE_HELPER_UNSAFE
 in fallback mode
Message-ID: <Zv3syfwZykRtJYQX@nand.local>
References: <20241002232618.GA3442753@coredump.intra.peff.net>
 <Zv3huwCNuqi5C8Wm@tapette.crustytoothpaste.net>
 <20241003002140.GB3486271@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003002140.GB3486271@coredump.intra.peff.net>

On Wed, Oct 02, 2024 at 08:21:40PM -0400, Jeff King wrote:
> On Thu, Oct 03, 2024 at 12:13:47AM +0000, brian m. carlson wrote:
>
> > On 2024-10-02 at 23:26:18, Jeff King wrote:
> > > This is a regression in v2.47.0-rc0. As mentioned above, I kind of doubt
> > > anybody will hit it in practice (I only did because I was trying to do
> > > some timing tests between the fast and dc variants). And it is almost
> > > tempting to leave it as a wake-up call for anybody who is still not
> > > using a collision-detecting sha1. ;)
> >
> > I think this is a fine fix for 2.47.  I have a branch on my remote
> > (sha1-dc-only), which I'll send out after it passes CI (probably later
> > this week), that removes support for the everything but SHA-1-DC (except
> > for the unsafe code).
> >
> > I don't think there's a reasonable configuration where people can use
> > Git with other SHA-1 code except in extremely limited circumstances we
> > shouldn't have to maintain code for.  The code is open source, so people
> > who really must have maximum performance with all of the vulnerabilities
> > can patch it back in themselves.
>
> Yeah, I feel the same way. I only happened to try this because it was
> the easiest way to speed-compare different implementations using
> "test-tool sha1". ;)

I imagine that you both mean that non-collision detecting variants are
unsuitable for the "safe" SHA-1 implementation, and that the "unsafe"
variant can still be driven with BLK_SHA1, OpenSSL, etc.

And reading the patch at the tip of brian's 'sha1-dc-only' branch, that
looks to be the case. So I'm in agreement with the both of you ;-).

> Possibly that helper could grow an option to use the unsafe variant,
> though even that is probably not a high priority.

Yeah, that would be nice. Though I agree it's not a huge priority.

Thanks,
Taylor
