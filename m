Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D927781F
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696800; cv=none; b=W7tCcAE8+p5BpQ8dXOepw5rAnNxRKZwtxzH+cQQP35fPPJEw9szm4DJqaQtOCjqMvsoUm50sHRuC553PDcZr0bMUMMOQXwsWRbDx6Ouf6a9qGTV7KSbzOk6BayxF6bGxbkZpBvxwecYouLWG/A7p9ShF7fif875ypyA7MdIxeC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696800; c=relaxed/simple;
	bh=lo0eN/Zc7GwgKyh0DwMhuMgTaXpeL3O4quXf35p0EqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PY6vaYVLKMKDIlBgKZaOxsdHKJsF0Kfc60rE4DRKkEuukTP9tKuafAGL8+0gxuEpEKhUOqVQBUPiguSLhstf35IMErL80sKxHj7vZuxADd3yfTig8cIFc6wNtQy+DWuN5ni1/JodycI1gI1agYrEAuVDdZqRXj62GJ+kqK6QPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ytgw27/F; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ytgw27/F"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e609cff9927so956938276.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 14:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740696796; x=1741301596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mnu8ez3JE/9ERVOtgW6qZexSLhk5y7MxF/kxiGvMTM=;
        b=Ytgw27/FhhxYFZUCH+hsm3dT8VhSkf90M8A6Xcj/fywlZqhVh4KkgcKinhQ+1ZDgHJ
         sPrgUPMI9OwYg0VXows0zGd04CrQFktv9y7vGqFvOBTIP0bt73ERSBKXKiv2Pqpcv5J8
         F2Ep7pSaBpmuvTSmaOzH6/feA+TEnpNVwFCgGdypt3MS16y92CD/yTDRf3JpL5FUiD+X
         wMOuKExEqKbutlsqM7V7ka2iM6pFihKAlHmr3IWBEXKFywxyC5iKBPoNXxHQDk53GKKs
         nROE/KE5ZlPvvX+nFnXLwh81qa6I4Ek4RbPPetetL9r1IXRDgDyGVsFH2R0M2Z2HgKbL
         5XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740696796; x=1741301596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mnu8ez3JE/9ERVOtgW6qZexSLhk5y7MxF/kxiGvMTM=;
        b=LxYFIW1oiffGKcss9/Y1gdEtpD0BwF+7Cig0xAxxBs3hI7ERX/SfiQl0k5/kASb+s8
         70tJpE/sxg4dtSxTdEqQuXHL+iodq5W6L5tWaerhmaOg7jYUTpMPZXUCEynW53jbc4b6
         vL6X0/BKnV7sH5PKRmadh1lpyWiLwef3Aom9xrJD+KF66Gj7nOiZep51XKW7/WiQd7fU
         x7wZhCNW29dL2rbVbOxxsAVnRJ5Sf9UYSp4BPwoW/pbdc42Puh3XAcIZi19RcrTBHKoD
         vpU307qC2uClfcE5SulglLMBf+NN9ZFc7/QAsaiqMjMJIgKkNoUsKtfhJ5bdlMp0Uv68
         4aXg==
X-Gm-Message-State: AOJu0YxDP/tCL73UihFGDy8qXtN0q6Rk32jq0s43Fwi11i9DHzIMo4I2
	Zb5BYHb5aO5GAyz0ErIOYN44tkQ9MyKz646Elphc36zSAhjhk6/cP3IGBffbJmN9c3nQLTQ12re
	0
X-Gm-Gg: ASbGncuaH9vBMrYe8fBQzfMy6N0k5ByT55oMf0KE6a2a9AB9SrSHwedM4QHG0LmTmPa
	hkaq/cBu9dsFgyYx518+swzl7+jduXnAvw/bxEx/VBCRx4Lob5C9UvtUpZx19iRG2BG2SW7EtfT
	YQnwWXuvuLde9UbRaTz/bmJU6GuDgMGcvD4yOFNxQQ5FQwzXHfQ6RZ/pywoPeEnVdJ7c4bPhJ8d
	Fz4ulVeHiUSMtQKw562d3xvKOLMR6EXBSteMbMJdPAJoOfpCnXv5V4PM3dsrSH+ZIapJOylc2Hr
	0rInlt7tdPqNAaKOdIUxjawzNUNEnY+P9+1t8DB51UwE4a5U3n52aRm0eD8nrQv1Bp+3xuVkIQ=
	=
X-Google-Smtp-Source: AGHT+IHtaz6LlEmjXXJ3PJ+NCX+6siDO16ZQJXdai8KELG2PR8UhPMxk/d7TsGohdcAhAAxdqQi82g==
X-Received: by 2002:a05:6902:2190:b0:e60:a93f:2a86 with SMTP id 3f1490d57ef6-e60b2f2e7a7mr1232327276.42.1740696796543;
        Thu, 27 Feb 2025 14:53:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60b557d2f7sm31786276.1.2025.02.27.14.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:53:16 -0800 (PST)
Date: Thu, 27 Feb 2025 17:53:15 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] builtin/repack.c: simplify cruft pack aggregation
Message-ID: <Z8Ds206MUMQzqGB6@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <8564f98259727225391edcb5ab3b47dd53f00e48.1740680964.git.me@ttaylorr.com>
 <CABPp-BE9=WUv1typWB7JB4HvP04Q_Bh6h23D=LzcpsAsggQ+7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE9=WUv1typWB7JB4HvP04Q_Bh6h23D=LzcpsAsggQ+7A@mail.gmail.com>

On Thu, Feb 27, 2025 at 11:23:02AM -0800, Elijah Newren wrote:
> > The original idea behind this approach was that smaller cruft packs
> > would get combined together until the sum of their sizes was no larger
> > than the given max pack size.
> >
> > There is a much simpler way to achieve this, however, which is to simply
> > combine *all* cruft packs which are smaller than the threshold,
> > regardless of what their sum is. With '--max-pack-size', 'pack-objects'
> > will split out the resulting pack into individual pack(s) if necessary
> > to ensure that the written pack(s) are each no larger than the provided
> > threshold.
>
> That doesn't really "achieve this" though, unless the antecedent of
> "this" isn't what was described in the previous paragraph but
> something elsewhere.  I suspect your actual meaning was something
> along the lines of "There is a much simpler way to combine cruft
> packs, however, which..." ?

Great suggestion, thanks. I swapped out "achieve this" for your
recommendation.

> > This yields a slight behavior change, which is reflected in the removed
> > test. Previous to this change, we would aggregate smaller cruft packs
> > first, whereas now we will opportunistically combine as many cruft packs
> > as possible. As as result, that test is no longer relevant, and can be
> > deleted.
>
> I like the idea, since it sounds like it should be simpler...

Heh. I don't know why I wrote it the way it was originally. I wrote the
second patch in this series first, and when I was trying to explain how
multi-cruft pack aggregation works I paused and then wrote what is now
the first patch.

Hindsight is 20/20, I suppose ;-).

Thanks,
Taylor
