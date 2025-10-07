Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDD19D082
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869849; cv=none; b=EPhua8N9qPOBqHKbstPCHWRa34u1mUd2IOMq8u5wGi/voOleUl0BZS3jkta9Q+4ndpLKe68xI2Vd0OkZ6rlSIxmrv9yhPMnv8bikDUf3lTcdScmpVwGXSQi6KHOq54mCfx0Vomj84Zg5phWZm6ePaOq/HiqjNzy1+jrOIHeOwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869849; c=relaxed/simple;
	bh=Bt1VyW/1jFTtQu7Wym6O8AHCKerMlUGbVsVe2OM44Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyuK1Mf5UIMBbZ1GaDTUUKBcvKzVVAsctvbSylD0+mcThVoin3fNaEDbw9UydC6yFG7DEvs+yuoNT9C6Kpn1q0G651G16CKsYcjKg58TwZVCZfDlb+gIau6fdWzIu3qJbAoRKOjcIqtOa9S0+7XPPDiM0wEcS/1X6IxBmA4sVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TQ28luDT; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TQ28luDT"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42f5f2d238fso18185785ab.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759869845; x=1760474645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHjUdN23KCZxnlMLa5/nPMMDbVxOTzSaP3vGtmz4J7w=;
        b=TQ28luDTFiKRgM6H3jtd6b7SRQTrHqPTBQdQEq4MoUYEodR40e5CwOjVFUMYNZxmzF
         y95/u9/9p6tRxn1TpDN/L1BNlo05jQX0i0/zOcoksBkO7TWD5+WS/SSzvRqGk1Gjc+yY
         ZHg5bWNi+ycANEqxKrquHDyazik3RopBSZjATL29aLDHop58OIoM5fgHDicWb1meE9sG
         0MQjDjF6QDxa/lnQ3oNUFtr2Waz82Oql6WtqM4huKaoP6rBPSA2QD6+9LNTux/WgLvq1
         it+hkkNQylAy7pRohVPlFS995feerMQjK0mIK3iUxjqwu70sl2l/K+80bDhTBE5Jivw7
         dYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759869845; x=1760474645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHjUdN23KCZxnlMLa5/nPMMDbVxOTzSaP3vGtmz4J7w=;
        b=FMuZ6GVkg4qZFkeyCuDqOVi5Akn228iSHfkl43AxNqXPR290rKwRLTSbohggnQI1n0
         T0mjE66L3cUeCtlqWqBtigU52u2YXHXx5PcHw9mZ41ybv1h9UbeUf39R6WTSUPeb1CxJ
         plPwrn04ETCLQSmKOqlDYzcsMz1UaK6lT0/seE0ldpJiUmJsY64t1cI/yoK/LbweGqNJ
         xEmMqjwQL6RxLZidw4LSXyamKuxrL/SUVdHch+5tCC3/gclJL2ZihjMum10iED6F4MAV
         d/jQIcn5GA1RnohFBTK5XsdDSWFtjn35OsQPf1IxwA0FqCygD4CpowPx0/URvAmZ53In
         D9Zg==
X-Gm-Message-State: AOJu0YwK+44enMZfSPsgDxpR6JlePDyu8q48wWFDT8XaYwIGRoYv/32m
	NTN4T2lC6Hwxg1Wi8NuBvfi00a2mu+g3kKFgfGk1qTmH7ipoRG6f5ApBxraAKz19OGY=
X-Gm-Gg: ASbGnctWTfItC6txMr9qoopBjux61tRrv9jSTvPtJL0lN5az56CJAZDjwbdVftJdxUg
	zYuO1CVnxnGzRsH6ObWSgElnDGmKOlf3CboQSW5tHcyVf+2aGfhlOo2PUvxwCYlHEm32G517l+0
	NYReyg/kmDnca968m9O6BkGzgIFiEtc+y75dJsmT7JI7DfDst26Shqt+oUOLvTgkc4h8DeIrHRO
	yxKWu4JCVWZSaW2pnDOgha9IW+drjneMPwN6i/bXvuMjesEjpj6XQBjCLjJkxAvKC8RcJewDqD8
	BTtdcs23JabAMSBW7adDZGeaKsyac2usj6ipnvqwf9IGhyRXLKqGiNotQKPjraBOPl9+txeCUSZ
	Q4cr8PYBea8o4QPjea4dNmGbbIst6yNjS22+/tzB90pMfJBeyTJ//F0KBR8T3PVtF5nm/Td/0wh
	d+hteEyA+dEpw65qj3JOr4kNWHBFn1MBM22azdul7i9/hmF2+kcg==
X-Google-Smtp-Source: AGHT+IExwONU9hpWxpZ2zfW/2IvfRa0kfeuumAI5jMu6z11slUqPReRaA1sG7uiPE4iSKZBkZg+6PQ==
X-Received: by 2002:a05:6e02:12c1:b0:42d:7e2c:78b8 with SMTP id e9e14a558f8ab-42f8736cdfcmr8008145ab.2.1759869844983;
        Tue, 07 Oct 2025 13:44:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42d8b28153asm70154785ab.20.2025.10.07.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:44:04 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:44:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 00/49] repack: prepare for incremental MIDX-based
 repacking
Message-ID: <aOV7k4cPcuhC4Mzz@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <xmqqcy7a5gnb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcy7a5gnb.fsf@gitster.g>

On Sun, Sep 28, 2025 at 03:58:00PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  * This series depends on ps/packfile-store at dd52a29b78 (packfile:
> >    refactor `get_packed_git_mru()` to work on packfile store,
> >    2025-09-23).
> >
> >  * This series is split out of my local copy of
> >    tb/incremental-midx-part-3. I suggest queueing it as
> >    tb/incremental-midx-part-3.1 ;-).
>
> Both of these comments are very much appreciated.  Do we say
> something to encourage these in our developer-facing documentation?

Thanks.

> The points to stress are:
>
>  - If you are not building directly on top of the recent tip of
>    'master', mention what topics that are not yet in 'master' your
>    patches depend on.

I think that this one is covered in general by 0a02ca2383
(SubmittingPatches: simplify guidance for choosing a starting point,
2023-07-14). The language added there is a little more generic, since it
suggests mentioning how you constructed a base branch when a new topic
depends on >1 other topics.

I would imagine it's clear to readers there that "if I am describing how
to build a base branch which merges in multiple topics, I should
likewise list the topic branch by name if I am building on top of a
single one already in the maintainer's tree."

>  - If your series is a part of a larger effort, briefly describe
>    what your overall direction and grand vision is, and state where
>    in that grand picture the current series fits.

Not covered.

>  - If you have a short one-line summary for the topic to be used as
>    a topic branch name in mind, do suggest it.

Sort of covered by your d255105c99 (SubmittingPatches: release-notes
entry experiment, 2024-03-25), but that talks more about the summary for
RelNotes purposes, not the topic branch name.

I'll send out a short series to add some more guidelines to cover the
above in our Documentation/SubmittingPatches.

> Thanks.

Thanks,
Taylor
