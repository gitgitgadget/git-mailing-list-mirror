Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC03FE7
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756431417; cv=none; b=NRBQVJldNQos7mWKtGl0v41r7aW6u+D8rEaaDUhFHgTyvkCNiqZ77neSzhcdxC0eBtCOdTHtWwtlAby0gVmILVqe60HmyrFinA7qCJj8fwucdqAL4GZ4JQ6MZfmvy7MCshg0aH5JwV8UfpIVD2hbAR3Vi2XqAmZ8r2FuHJSNSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756431417; c=relaxed/simple;
	bh=Z9hRDlg7CVR9k9UJJEt3lNFys+krFyXIV3JhqIh3VH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj+SX6D1n4ynydPiskHM3MKufpol3wXuMJYjLDIqoWMtWCbLx39ceGlXKrfWAoWlpinbGXt1ned7AiTckF/92ORfQyrfVcQR2nqYQMaXnbqvp0IoNVIKBflYVbcDXCT27rQngb/lBi+TGQwaNNt41iakvwb+0Uw2qtYpKZ4Q/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ofAYsO/u; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ofAYsO/u"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-88428b19ea9so92659239f.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 18:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756431415; x=1757036215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23UoUalw2f9YYEiYIj6bQL/vI3K/2pS5xwwERHe8jp0=;
        b=ofAYsO/uFVhzClM/wGAAoMsB9+O7FZgys24Wg2GO3VcckNT34MNFPoD/g3sIng1YZl
         k9A6ATAAWzryFVk7zSlTaci7DBliYR8iPBkc2478jGtYlocPBnWnwHPayZcOeCAYFiJC
         2sD4413IsRPQIZWpGJN/ZoExrtBXEneKSMRrMKYp4okKzgupkfy4AMsb+zYT20gMEK7W
         La6BJSopNpSpM44sige+vxSGXUBdiODNw0qQyYWzfajn667AdmwD51EvmyIdVVWcthFc
         lwfOWhwPfyU0LWG5JUnLpjYlp09Fx0o6YgNlbXnHLb2A3Ag0KHktpbWV9YFsELsymiRY
         yJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756431415; x=1757036215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23UoUalw2f9YYEiYIj6bQL/vI3K/2pS5xwwERHe8jp0=;
        b=q0BgVHtgjncSTkE7cVXEyP9f5gJ6yazH2iTp5XFXkD++koYmkOi7uuN8eeeP62p/iE
         lqP/IABcR7KGuvOJO04y2T/tEgYZZ86mHWJ3eQwqr1EiAoaNuxQ9ywdOXi7vT45FX+YG
         t3D6dALr8BCRq5jaKOHQA3QeJTvXIXdX4ii8u4GAH5bFzPAfOmrDfHbw90gBsD7LuKGw
         BAF3zCtYhhtofMKIyCGr5k890jyYOYlTqmIY/+BMmsQyz/s0XZYu42fuLbm5ij0gR8d9
         Mg0ztEVjWoLau0kYGrUi9dLSDRO/TgTpXNvnlxr7G7L7F1G7scbPzBmu8uI/soRrNUTk
         /hdw==
X-Gm-Message-State: AOJu0YyGkE+XNzfD8Q0dV+jCR+fqvwVk4H0MxLnemWXiQNjIZf14JtEd
	YigodemtmjTClzHDl+ndscaeiyGrrRZEiVZPG5Vd2ceMesuAZYhzFuK/au0BJcqspQQ=
X-Gm-Gg: ASbGncv9rm5in6YNUzKvUp3YOJRCaLMS4zRXzUzBHTLYA7/CobrnpXtfHdqRAyIH+Qs
	b+oyN2l1r2f45FzqW9qqzLN5P4+mHmoz8uARhgIq1eK4JclijST6Wg4LJhMz3MLnsVqFA8MIMMd
	UXZFSOe79VkcOHNlLcdto6FId7VlDLI+fwEVbmArD2dlY5Tum8zkK4iOpyGFmyXSaLRbG1H0bLB
	pLxQcidnqElbBmaTNZqHLHE3oLTCIdZfYBIcHJOluKghxFIERxxr7ac4KZEQX94b3ViUkDzSKwF
	twguoQA0f1MGZQcHjrwG51W1OK4rSMtmPdoiibpbK4PlGhqYVFwPVathFbJIoM9KJPEwbxc4cYR
	lhT2xTfCl6JOgln3MCIanLxFDE2sMaVXyGKMrj1vzAQk7Ps83qFd0P83IUmNsUyBg3g9dJKLcR7
	m3NJ2bM9p7JkYQW0lhAuelmkVM0Q==
X-Google-Smtp-Source: AGHT+IFoK622Cy/TeUw5al/wVayCLWaFtpTEezMHwkvn6w/w6yhW6y+GaeOJUi6xcPhKjirWe//7Xw==
X-Received: by 2002:a05:6602:15c7:b0:881:8bc8:b02f with SMTP id ca18e2360f4ac-886f18f62ecmr1825499139f.2.1756431414868;
        Thu, 28 Aug 2025 18:36:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-88713e27354sm18289139f.20.2025.08.28.18.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:36:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:36:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/5] midx-write: fix segfault and do several cleanups
Message-ID: <aLEENQcWvfOC7Iyn@nand.local>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1965.git.1756402795.gitgitgadget@gmail.com>

On Thu, Aug 28, 2025 at 05:39:50PM +0000, Derrick Stolee via GitGitGadget wrote:
> Derrick Stolee (5):
>   midx-write: only load initialized packs
>   midx-write: put failing response value back
>   midx-write: use cleanup when incremental midx fails
>   midx-write: use uint32_t for preferred_pack_idx
>   midx-write: reenable signed comparison errors

Thanks for looking at this, and my apologies for the regression plugged
by the first patch.

The last four patches look good to me, and I left just some minor
comments throughout. The first patch does leave me feeling like there
ought to be a smaller reproduction, but I can't seem to find one easily.

Thanks,
Taylor
