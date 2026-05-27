Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292F271464
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892611; cv=none; b=XcUH3qMWoVPBOesyjgoLkvA7m7xgeY8Jyu+BhYJbtB0Sa3n0w8qF4jkNQVh0AYXxW5oKEYVCItEO8xKzdoAp6Aby9DYqq7UwX9Xduf/zH98lkUZ2btTbsMi3o+qsPAiZ7x84eaneR/K/tVtUn23uMcdVO5IQeBgK/1QvJBJQjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892611; c=relaxed/simple;
	bh=9bKa6XVnigWr3hxiRy+fsTp5f6s7qwXUlJF3lXdHCc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf/zujtdCml8IbG7ejCdoxU/WO7z1hjWRN8ojh1FBCCOOy840GHj4mIWwwH44KlLENc9nRRGzMwWn2t0l6unsYN8N3UcxlI2K+p4fhLQqLsE8B8SEWjjAG/jgthz2+s8+dayQRa9mTbp1QM4p9M/n6ObmjMjPuLsxf0ExRPdiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UCE3VKr+; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UCE3VKr+"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7ca947f9b00so111832927b3.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779892609; x=1780497409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bKa6XVnigWr3hxiRy+fsTp5f6s7qwXUlJF3lXdHCc8=;
        b=UCE3VKr+jP51fnT68C+ycI2uGgjLBNxbm53j4SyqPtZPl9wEBFq45TlSQ0G0dQ1UIc
         W8gEORiky99EyagtT6hJtYKoSPKaXGR98ZxlJmFDL+A9ru6TILMGKTxISxAd+I23RlVU
         I4cf7mI8KVjujPJBMDE2pK3ue+eJrhz2Cx7uMd2CoOzHSMCGD+7OlNi6fi9uj3a4RZLg
         2db0dcPZ9Kt8FvOgpUIa4qTB2Q3dQ53NaodT9i73QLFbJWVfHOiQXeCBC7/rkDHLjxm3
         2fgGBvHa3FvxTiLOu5zIIcK96qiBviGo7onL3motOipcHZIDgukm0NmTNBtElL+5OHpK
         a03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892609; x=1780497409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bKa6XVnigWr3hxiRy+fsTp5f6s7qwXUlJF3lXdHCc8=;
        b=LzKXiK2YkKipJI/qF//V6IMXXT2STB7s69dw2+MdWgX3KcYpZCsDZlDjJNy4z0tIh9
         1TSzpgu7E+9hzJO7VgonvmBEkzKF4ACsTyE68AK+GA/KyVSBy2VpMT60cd1dUzC8FSzQ
         mBjbV2oBY7a8pJW91k2h1S2d0w3FmPuYd7dlsz1qoZVZVEllSV+YzHzKoUWnA47Pmjqv
         LTl3Kk7IaEu2sZAC94g/1JEv4T81X9uYXlk3LinJiR7RnWVsOU7gHU8YG50XD7gVR4yp
         w3dPCqxX1VgUus2gDun00qDtHbHzL4MgfC9Ek2pGKhJ6Yx5UToqSpEZug6ejX4oYggv0
         txpA==
X-Gm-Message-State: AOJu0Yxom0zgjR/2DvdMElYcvaJWDfdFRCrdDdQj0pgFZwZIT4kdMCh2
	R4DKXxrXDd9RDZG9M1bMHTndlZjy6PHyUMNs8f9Lt6uZitFncjiOrLgBFPdnAIeuZ0o=
X-Gm-Gg: Acq92OG4IrgiOJW3QXyHH5oSJr9KPHN7EdEJiZx5BE1m7CkMhje3YuIUPS3+A9wTDmg
	qpJKQ1m6lJEX3PXTWjCQbRjWQgzsghlHTkMJPKHzWo4wijAML/BLggBs78ANElLa39yHjpkM1l2
	GKoM3U8NRT6RTKf0OmThv1MM8dS6pfStQITwXutvasMQ09N1IjJ3dQuvdP5lOSK9sPJI5eXx3dT
	PEckBTkYWX4VYpuH4wFYQPm/CKCd+i+4RjyJC4NtWVqGb0C8Q9/NyIzW/hbmASUDSkWkqB4lZTM
	MZ5Dw4p32d8zxKDAqW5WmEHqaG6/3no2PT/DTRCz3mljEV0XHyRLZMw6X/VKLwaZKUxri/f6jIp
	KEVk1Pqk9GjTKll/v/BsSmJELzKk5eKA0TwfXdDlRpOvTGShhzKWyd8Y621otkX7A68/u4Q2OBj
	rymzCTJfM0Xm7NInTSQWaDX3BWqfeMj/0u4hDua9sPy+p+R7OZ33C5uBBqZhSfZHc8c1m3w75+m
	MDAh8XTFoRGdEW32uCFzuED2h1sFNoh8LINwDxsVNFJzsPUHAXs7QYHfQpqbZdJlYN1PhP8du7n
	1CnCXWMgzG0ikH2O
X-Received: by 2002:a05:690c:22c5:b0:7ba:ded4:df53 with SMTP id 00721157ae682-7d3356dfe00mr235741577b3.32.1779892609046;
        Wed, 27 May 2026 07:36:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38be2dc79sm76880587b3.25.2026.05.27.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:36:48 -0700 (PDT)
Date: Wed, 27 May 2026 10:36:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/8] pack-bitmap: check subtree bits before recursing
Message-ID: <ahcBf8jQ2iqP+Lme@nand.local>
References: <cover.1779207127.git.me@ttaylorr.com>
 <7d6d1cec0dd2706ba176c7fa070da46c98155018.1779207127.git.me@ttaylorr.com>
 <20260527090348.GC981444@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527090348.GC981444@coredump.intra.peff.net>

On Wed, May 27, 2026 at 05:03:48AM -0400, Jeff King wrote:
> On Tue, May 19, 2026 at 12:12:39PM -0400, Taylor Blau wrote:
>
> > In the previous commit, we adjusted the callers of `fill_bitmap_tree()`
> > to pass in the bit position of the tree they wish to fill.
> >
> > This commit makes use of that information at the call site to avoid
> > setting up a stack frame for fill_bitmap_tree() entirely whenever a
> > tree's bit position is already set.
>
> OK, this one at least has a plausible explanation. ;)
>
> I can reproduce your speedup on linux.git (~5% again). I don't love that
> we have to duplicate the logic in each of the callers, but there are
> only two sites (and unlikely to ever be more). And it is only one line,
> the comment notwithstanding. That seems like a good tradeoff for a
> multiple-second speedup.

Yup, exactly. There are naturally only two callers: one to handle a
commit's root tree, and another for recursive calls to handle subtrees.
As a result, I'm OK with the duplication here.

Thanks,
Taylor
