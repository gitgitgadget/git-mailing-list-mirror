Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCB13D297
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730073178; cv=none; b=uNFqGeIvAn3qcV4t5Ebx5GGdXsng6PFrb1BhCA+/bi5m4P15qTCA4iAE6RFl01KLz+pc6Ud8+MY/ORqBq2VHn0yxRShj/grMIQq3gUXwK+lEPPCG14p4lYMbgSWXrdW/oQO0H4XGbEYjqFIJUY9+Zu8vMcOS4dzMEdNI3zGWjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730073178; c=relaxed/simple;
	bh=e++mgwhdOaIFYQLwKntrV7hUn5A6uDA7kjoANrwhSrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuNRwOPI2Xs9iU4Dm+JkBEQb16DvBod+goBSU6z09VzjJpMcwHkj3BdLWD/lK6UFxZTJD56JwfkBIhDM2i02pOsKRkdmebRiMNNxrTCCNJD82gFvB3C/Kc6p5CpTRGom3glqGvTe8Ho0g3yvfHHE5FWQ5hZNpUQuIDLEs2XZua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=X3FSnydA; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="X3FSnydA"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e290222fdd0so3229490276.2
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730073175; x=1730677975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVbb0VguX0BIzjDbyrg+jSleWKVLZNIHUHa1SowX7TE=;
        b=X3FSnydAh4q8y27HIyZYHcdpRxohlqS2kZa/4I4hjUOXSqtIbXWxJv5DQw0qHkQiyg
         5lW1yOl7Gxo+QfwQYuCogPYgJQlc/vNGK1fB7abTVZUktbKZJY5yEzuAu6DvMQuwVS8D
         qSiXbMTTyG5LXR9KBmxM4qcQrAEQoNjQ8rW2CpS7CkiohlIG14pwmHkMHuuD5sbGbHD3
         QLKkzFCgKa91Fznrcrg6aHc5V1YLHz+VgooHsdQHtpTeOznjplxVush740PwUIKxOILv
         TDad/Msil1kj84t8rlM2u1L4cRoAF6u/yP/T2dxN6/kjZtt7DS7Wy/+z6SwvoyznD5vq
         9/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730073175; x=1730677975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVbb0VguX0BIzjDbyrg+jSleWKVLZNIHUHa1SowX7TE=;
        b=ihHA/nrGzwpuBZ9r8dfB/RaO8X21VHxx0QXZVNVZKWF/jBsfnP6baj/vVGF85umrVK
         4U+ugW96yQsMmVs2LEhb5Gra/PSvRtdt+EUnaHt5I88fzQmg+7QdNKJ0SFunNKC3DtpO
         LBQjGkuDw2mawTjMqLzk6vwq0DwrGkUYMpQ1D4aRfU83r3zhDXkaOkd7Wrz3xpbCDfO6
         nrAnOEEJk+DmBGcrBeu9JkwDilIJwGvRo3IPnErXGE+HgwjozK7NA3F77YJwUm2iMYTH
         kT50DJHETpAS7tPTcw8En7wENvC2eopHh62OCMfoQYCrkaXJ+gyh0Nx4y5zmGTqC7XGv
         Qn0A==
X-Gm-Message-State: AOJu0YyRtkeNVTtkaodnVjcsQpOaA8LFqALgcllXY0+y0XsMtbS+ykcQ
	9O8LXRN4GP7lANVD1C8V5lvU9BlPhU0aylsF8XzNeRA9fqyzHtPP1cKCeU5sSaE=
X-Google-Smtp-Source: AGHT+IEV8mqEdrDwq4yeuM1hrVlHqK6xkrhC/xLBQkgVLdvJbzuPYB3HLMbEULwYKGhHBj4vudKnqg==
X-Received: by 2002:a05:690c:3512:b0:6db:e4bd:54ac with SMTP id 00721157ae682-6e9d8ad3427mr60489547b3.39.1730073175196;
        Sun, 27 Oct 2024 16:52:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bafd23sm11741317b3.29.2024.10.27.16.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:52:54 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:52:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #11; Fri, 25)
Message-ID: <Zx7SVFV1aUmU/zBy@nand.local>
References: <Zxv0SgY0oajpst8s@nand.local>
 <CAOLa=ZS3gqv6bB+gLxeYUmu70hJm3=8paJFWU5OLpG1dG9Zr5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS3gqv6bB+gLxeYUmu70hJm3=8paJFWU5OLpG1dG9Zr5g@mail.gmail.com>

On Sun, Oct 27, 2024 at 02:26:08PM -0700, karthik nayak wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> Hello,
>
> [snip]
>
> > * kn/arbitrary-suffixes (2024-10-24) 1 commit
> >  - CodingGuidelines: discourage arbitrary suffixes in function names
> >
> >  Update the project's CodingGuidelines to discourage naming functions
> >  with a "_1()" suffix.
> >
> >  Will merge to 'next'?
> >  source: <20241024105357.2605168-1-karthik.188@gmail.com>
> >
>
> I think we can probably merge this down. We can always iterate on it if
> needed.
>
> [snip]
>
> > * kn/ci-clang-format-tidy (2024-10-18) 2 commits
> >  - clang-format: align consecutive macro definitions
> >  - clang-format: re-adjust line break penalties
> >
> >  Updates the '.clang-format' to match project conventions.
> >
> >  Will merge to 'next'?
> >  source: <cover.1729241030.git.karthik.188@gmail.com>
> >
>
> Justin did leave a review, so we could probably merge this too.

Great, let's start merging both of these down. Thanks for the update.


Thanks,
Taylor
