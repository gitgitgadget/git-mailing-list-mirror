Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C61F5E6
	for <git@vger.kernel.org>; Thu, 23 May 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488641; cv=none; b=CJMSIkQ9339vHUBqCCLvwbjmtZn1viYwsImUEO6ow9UinL33EVLEWgWNmyaKqXEJD0qAZIGlEThy4mxLRRMq5dLMniukhBC0jhiFuSqbpT4owgYOEOOtcYvE6JFo4waDtrfV+SArlJ4hzcmf64o3MW/Zq2oBCOMpihNs+Nqu1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488641; c=relaxed/simple;
	bh=T2S6PUh+1rZMjWkeXA1IKU/lplrYjpv7KhXp3gnGzkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTrWt9tN0QA9GWJ/GQggXBt36JAYeZ9krUUKSY3W4z+Jj/RfM/FXr2exWCmgp29em+AwwBwjMs7Tck/oQBo58FtAIyAOs0wfEHrPoIIS1skphtQO8wT6QvLxPRunk+qZouS0R9rT800M/Rmd13DRu+1ptOv1Bxx8xYjUxcvtqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=liUh81lq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="liUh81lq"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ab975abb24so3784996d6.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716488639; x=1717093439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6m4lnurQb83vC056e+UC5LFyTfJLjp+JELXY5cfZN4=;
        b=liUh81lq4irYhKHxhYSE2xJaDReYyoMwcd0SIyzm5eqNbE9xNKXfXZbhagU2E7KC2x
         80zEi1jMQHn4jvBnGw7wQrKsPR9H0jCrC6iay2+7GXOQy1a0+Buz+Y5PupNshmAyKovO
         pdyJhf04IQKOmmJU2K35wKTAgOjaYTqM3BZkYJR6KM9xZPLA9PIi+ZcAtQlBhKEoM14g
         g3AkUQFv5NFrZ93L0DihCZK/5kH2rC8be1t69iljySUh7v3/nIPQxcJo/8UB0HDrC1BA
         rzcLBzrPLCwOdZ8Z2Wm2QnjOkMIo4EedNIGg9mnDoR7N+w5KT5eUtmBuE9VmQvrp2t5Y
         e6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716488639; x=1717093439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6m4lnurQb83vC056e+UC5LFyTfJLjp+JELXY5cfZN4=;
        b=uELD37pt4db5Oc/dieuyS7/b/ePh4zS6O4Ih8jxWlURFr6/COy281y17Ee4kCDz00F
         /odiNwKcScNMQD9aBkV8tHwncW28NvzRq6qnQHuEUWiQcDlLKyokSm91W9T1I3LEPndY
         +T7YFCN3kyzd+bwUVSVgze1iBMdUmVhywmZHKb3u0S07Fvwp+dOAqKMtxZ2qYWsdw88m
         aucKpPP5LYfxVDPSMs4IrVO9xKVvdc86qt2qplyl1IxL9ZKUY+j1z+aYOdZPrS8fjMuK
         KJIC+aW+/684jmb8ukSQPUcM+qPJBF2PkkZXIQuw/w7yoj1X22Dt120YiftdRKm5pOo+
         DNYA==
X-Gm-Message-State: AOJu0YzP31R+MI2KvaLnEbVHD/ejozfpguQX6w7dBPopkc+S33+rWhao
	AR8v4accqCRmh6NHDhThyyjAeh7Z8aGmNlHNQj1BY8wmBEn+wLq497o66Xm9RAw=
X-Google-Smtp-Source: AGHT+IEGlhkev145ZE788VJPHpuMZwsHF0UA7rbG69w1OhV6ZBOcqxxxwOPF3w5mehfBoFV8PI8zCw==
X-Received: by 2002:a05:6214:4a8a:b0:6ab:9b4b:adf0 with SMTP id 6a1803df08f44-6ab9b4bae95mr6335936d6.5.1716488639013;
        Thu, 23 May 2024 11:23:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6aab86b0e55sm42066816d6.85.2024.05.23.11.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 11:23:58 -0700 (PDT)
Date: Thu, 23 May 2024 14:23:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 26/30] pack-bitmap.c: use pseudo-merges during
 traversal
Message-ID: <Zk+JvTSU671BiouV@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <41691824f78818f3c70cad6d02cd7f66d12c68c3.1716318089.git.me@ttaylorr.com>
 <20240523104837.GE1308330@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523104837.GE1308330@coredump.intra.peff.net>

On Thu, May 23, 2024 at 06:48:37AM -0400, Jeff King wrote:
> On Tue, May 21, 2024 at 03:03:03PM -0400, Taylor Blau wrote:
>
> > The basic operation is as follows:
> >
> >   - When enumerating objects on either side of a reachability query,
> >     first see if any subset of the roots satisfies some pseudo-merge
> >     bitmap. If it does, apply that pseudo-merge bitmap.
> >
> >   - If any pseudo-merge bitmap(s) were applied in the previous step, OR
> >     them into the result[^1]. Then repeat the process over all
> >     pseudo-merge bitmaps (we'll refer to this as "cascading"
> >     pseudo-merges). Once this is done, OR in the resulting bitmap.
> >
> >   - If there is no fill-in traversal to be done, return the bitmap for
> >     that side of the reachability query. If there is fill-in traversal,
> >     then for each commit we encounter via show_commit(), check to see if
> >     any unsatisfied pseudo-merges containing that commit as one of its
> >     parents has been made satisfied by the presence of that commit.
> >
> >     If so, OR in the object set from that pseudo-merge bitmap, and then
> >     cascade. If not, continue traversal.
>
> Ah, OK. This is the high-level overview I was looking for in the earlier
> commit. ;) I think it is fine here. I just hadn't gotten to it yet (and
> I think it is much better stated than what I wrote in my earlier
> response).

Good, thanks.

> > [^1]: Importantly, we cannot OR in the entire set of roots along with
> >   the objects reachable from whatever pseudo-merge bitmaps were
> >   satisfied.  This may leave some dangling bits corresponding to any
> >   unsatisfied root(s) getting OR'd into the resulting bitmap, tricking
> >   other parts of the traversal into thinking we already have a
> >   reachability closure over those commit(s) when we do not.
>
> I think I know how you made this realization. :)

;-).

Thanks,
Taylor
