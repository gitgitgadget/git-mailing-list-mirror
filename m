Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E00147C79
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216361; cv=none; b=o/gw04jGzDyKX427fk7DlQgSeineAiHVhHsODz8L+rPv0db11d2cwUk/APNcBDdrienAhVvnshoNVGbJ49uYOKSUk4EqkTgU5WilhnK/Oc4StpRXC9oi2UxR1OLpG06vVDSwO0dMyWU4nUAumNPWlLw71AgedSII+Rd/086AMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216361; c=relaxed/simple;
	bh=qS88rI2UwJ/RkGCzYb1HiN7T0/J/zEi8w7Ou5EW17tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOhllP4Dtob6iTLGkURqgL40S6vQSK/78fY65aubn324wcyHtkcaGdPdogw8YHAZhChzFLRx/rV1ZfYBaBxA2rveVMtFCfQpY7fZGZw+1V5NhNhkbmdTKoZedwlvNvEdVFpijCVklXzjXNemUkXTzUbKj7lEOBicnFHkJxUyp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uD2XNqwv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uD2XNqwv"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso5852148276.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727216358; x=1727821158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfA+jtog0xd+acArAMaZrMaZ4Ao6Z37JBk+vxnjkNws=;
        b=uD2XNqwvxEL7nbVVedl5KJ0X5Zh9nK18Pe0cpzH0phizBeRX357LHHp4h95l9x8GFE
         s+WzNU384tug7prINYQ2LBqlavJEKd+xfFhvhq00vFFSs8CJH0NwI4ZFaeZO4Zj2alRp
         c9aAFG4oZfegSl08IPBcMtO+EJoC7n8phop5JxVBKyTeZyCYnkE5PrDTSg03VtROBgR9
         5f1LOZGBE8NIUyMMfZcWEaN6Ko+dGg0nHE+aAF/XvKM0UoaaMArPJiucj6pa1AKjK7Cf
         9GMRkWGOysJZmaUgOVpQBtXqElZnf/w7icMzxKG2MyLd4LCX/k67KhO9ZpA+bXco1XDC
         uq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727216358; x=1727821158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfA+jtog0xd+acArAMaZrMaZ4Ao6Z37JBk+vxnjkNws=;
        b=Wqu7ZO+KJqhecG7K/cvbWfDXo56ZP+YKjRh1gAUvwu9pmmY8hanIhpMK07Cdd+s2h6
         Hc/Kyl7Vq8h/mm/TX+p7eL4GfcTKZLJ0DI5HVcJqQRneBo4LUSpwCTja0Qfb7TgOhi/v
         uYNGuxGVzf3jYSZcfEgB+0NSscwos5O7RkoWCf+azvyqTWFOVFxqdUt+w3ZGV6AqcMUl
         yYJUfrAUHMYWXXG8AQlaCv5T10E6jjc4wNGDBVJrd/ztyJgIG0w9D1bebyukNldoLmrj
         GawSavYBT1eu+/f20Q+3KrTuQ5cx7m0niSvhx1doioiEpktR/pFksbyZD9RrRN3+lENW
         QzNw==
X-Gm-Message-State: AOJu0Yzfs7S3u3Qw47rFGZtusgFv0b3tiNwVn4jo/q9zePh+dbjPr1D3
	ZyIIDb5LKlgcw4tjmNQ+v0BVpzliY+34vnYSEPILCkbHzDvw+znoURwaBJFJSJOgGsDOM95gOdc
	fPFM=
X-Google-Smtp-Source: AGHT+IGFiFYWwpongEvQqKSUvjBTQQoRo346h5ca8sqHFwItuZ9a0m6GzJhy5snX0Gwg65LeS+47Uw==
X-Received: by 2002:a05:6902:2004:b0:e0b:efa8:18b6 with SMTP id 3f1490d57ef6-e24d98f828fmr687095276.45.1727216358215;
        Tue, 24 Sep 2024 15:19:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2499c732d0sm399038276.55.2024.09.24.15.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:19:17 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:19:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: git-scm.com is now a static website
Message-ID: <ZvM65LqtFW8f9uqC@nand.local>
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>

On Wed, Sep 25, 2024 at 12:07:05AM +0200, Johannes Schindelin wrote:
> Hi all,
>
> almost 400 weeks after Matt Burke started the process with
> https://github.com/spraints/git-scm.com/commit/60af4ed3bc60 of migrating
> Git's home page away from being a Rails app to being a static website that
> is hosted on GitHub pages instead, today marks the day when Git's home
> page at https://git-scm.com/ has finally moved. Or actually: yesterday
> (because I took so long writing this email that I ended up sending it
> after midnight).
>
> This was truly a team effort, and I would like to celebrate everyone who
> contributed:

I'm really excited to see this change (or really, lack of change,
because the conversion was so seamless and faithful to the original
design).

Thank you for sticking with this for all these years and seeing it
through to the finish line. Congratulations to yourself and those below
for all of the hard work that went into this!

> - Taylor Blau and Jeff King for endorsing the work enthusiastically and
>   suggesting to switch over already at the end of the Git Contributor
>   Summit that took place at GitMerge '24.
>
> - Taylor Blau for assisting in the switch, taking care of the DNS
>   adjustments, and in particular for taking care of the rollback when the
>   first attempt at switching failed (due to caching issues) allowing me to
>   catch my train.

I just clicked a few buttons ;-).

As an aside, I am really glad to be able to spin down our Heroku account
and for the opportunity to save the project some money. We're spending
about ~$60/mo USD on Heroku, and I'm glad to be able to put that money
to other uses that will benefit the project.

I haven't yet spun down the dynos on Heroku, on the off-chance that we
need to quickly get back to the non-static version of the site. But the
rollout has gone so smoothly that I doubt doing so will be necessary. In
a couple of days I'll go ahead and spin them down, assuming nothing has
changed.

> You will note that the site looks pretty similar to the version before,
> and this is of course intentional.
>
> There are subtle differences, though. For example, the site search is now
> language-dependent. Searching for "commit" when on a Spanish version of a
> manual page will find only matching Spanish pages:
>
> https://git-scm.com/search/results?search=commit&language=es

Sounds like an improvement to me ;-). Thanks again for all of your hard
work, Johannes.

Thanks,
Taylor
