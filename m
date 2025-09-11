Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F41DDDD
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628973; cv=none; b=TvgMV0pV/9RDYUiP5ZQXvZSrhk3BvmuPjDB3Alpc4RQs/rDPi11UBjrQPdqIdVQ2Au5smFgSPrjdweox59gJ9OsmKjLi4JKDJqwtGjMHjLHhZy7GlOaziZk6dqoqLR3j3D7QEwg3xIPQgIDV7wG1fTUkNWAv0xuC7JVQQ02njaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628973; c=relaxed/simple;
	bh=QK9wkCQRnGylrkJ71jyiONZT78k2zj8xsKAfYFipKuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG2S7dEB2ycsDzw07NL2vp/7fOgmFAABmbWsUWSkBurqeWqpvpqlktSJj4M5g+86dmuFM6q5wdRPiIihHz6uW8MgJVXdTZs1xMRX5S2ivB7lIeSEnE0RkRVmpnTw5s6TBSwHkFfD8S3Am7MdpcBJkHPPPQYKs1y0kKt+grFT0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=D6ptbnED; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="D6ptbnED"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6161de657c1so848568d50.0
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757628970; x=1758233770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DU5iroZnQ1E0vguvVKdXpdC0fKgEo/0UH/3SKcYm2rc=;
        b=D6ptbnEDJ6uUi34+f9ze0u8IdjGuzJK/M2HhwR78tne0omkAS9s9ytgSCnek4ASp4Q
         WpfnJT4kYYMikYgFu/Vaq5kcELNrxCdSFmuqnhRYa6YyvMvCtn1niA5NenwvBdLnQXAE
         ceUDpjLX/rtvw8BKUl79tSp7GqF9cLRpmaUmr54Cio9WRk8b5IdHdivtz0UpaGQKMXqD
         LaSIAcVI9/oQH/uXXKfbLg0eeBPi0cTb786Dzrki0uqleUmhWfVKCOVYp7C5hpIdKUPw
         pnBEby/C9P+OG7o3xSfmmlXRmBFZyHUuiHD9+3sGCbozoJJxHUMTm4arBQhIBI+6j1sJ
         EDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757628971; x=1758233771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DU5iroZnQ1E0vguvVKdXpdC0fKgEo/0UH/3SKcYm2rc=;
        b=p4BrdtDn0emOoU0UnG9mPI6vuqne7Jh60DtgWo4URIN3KvSJtdmcWQw3FrZ2mhh3ob
         bGHt8czGNaCgCvH/9ko5hnQNs1itA1IlHDTsg3VwVZcmsqvN/jY+Tmq/COMQQw5jvHdI
         y/tAu+2U1m4czUwp++vZcmy8F0VG3E8UNieXVlxtg7xmxN+pEgHG8cjbozhd2YUGBsP+
         nmbf1z8qQLN7DTEl0i6Yw0YmjZMyVB9fLfg3pxxpmsdweAWJ8/RkgC+ClPnUIfKaTYbn
         RAa7UwKhgZ6cIBjaA+a/Q/KwNDwFeC5waqt+9FwbQySPi4e75t/Yb6LekLaQMpiCTgoZ
         Hdqg==
X-Gm-Message-State: AOJu0YwWrQ/FGqvsHl7N4YiL7ZDpmeCNbZ9PH1G2eWW4MNSwXKFs4EP9
	kTcjvdoW+1tvYKUZ9HrZfUb6msgpZScI9CB7QvhJYH/2JcRTGHyqpa/OKs6IQBoTr3Js8+JhtZo
	Iwhsq
X-Gm-Gg: ASbGncsX6Nc6Yb+RoBFvCx4+0yOu/8eOQI3QfhMa6XmoboYw08dwydt5lkzCjDSv4MK
	DW/UllcZSPzzrcPzLiZ8P/00c0dJrfzNX71+vctUnPZUSy4SiRU7VFcSTUe1zfWa6ctwetpipi8
	9JmTKzBJCY1A/VhFw1q9VEUX3CxscWT5xsPEkvcVcSg+4yB+m8TnoiZ/UK5z+JNI90TQWNNh3h0
	4rsTAlxWnEwh6FpaScdPB5KbchuCf1w9DYhQ2qalI04kbB9n+5yq9BgLLn4m4AmsDyzzzssqW0X
	iHinLqXaQjK/AfDOeisFMK+8v6YJSko1B80qHTK7RAIGlzTtFsCDryF3BI6w7XG020B67tns5cA
	tqad0048lUo22dLeHFMBrgu23UBYj0uHfU2G2L98rWUyPGs5aDrSb1OoUt+AzRqbxy8N6VcwqCw
	3a67oEcTRZxxC4Fi1iHSkuB09RpA==
X-Google-Smtp-Source: AGHT+IELGcZXVHWOMqiKUr4RoKXIqEfAd+U2IzeSaQhKoLJs1jU2apCB/tQTLyi6f+OVswYhpx4OJg==
X-Received: by 2002:a53:710b:0:b0:607:42ac:aaa1 with SMTP id 956f58d0204a3-627235eb4fdmr791015d50.37.1757628970631;
        Thu, 11 Sep 2025 15:16:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-ea3cefe14bdsm849400276.4.2025.09.11.15.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 15:16:09 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:16:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] revision: drop explicit check for commit graph
Message-ID: <aMNKKOo+BsNxGKgh@nand.local>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <20250904-b4-pks-commit-graph-via-source-v1-2-d932c2481e1a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-2-d932c2481e1a@pks.im>

On Thu, Sep 04, 2025 at 02:49:56PM +0200, Patrick Steinhardt wrote:
> When filtering down revisions by paths we know to use bloom filters from
> the commit graph, if we have any. The entry point for this is in
> `check_maybe_different_in_bloom_filter()`, where we first verify that:
>
>   - We do have a commit graph.
>
>   - That the commit is contained therein by checking that we have a
>     proper generation number.
>
>   - And that the graph contains a bloom filter.
>
> The first check is somewhat redundant though: if we don't have a commit
> graph, then the second check would already tell us that we don't have a
> generation number for the specific commit.

Makes sense; and we already inspect the commit_graph_data_slab
regardless of whether or not we know we have a commit-graph, so this
clean-up makes sense to me, too.

> In theory this could be seen as a performance optimization to
> short-circuit for scenarios where there is no commit graph. But in
> practice this shouldn't matter: if there is no commit graph, then the
> commit graph data slab would also be unpopulated and thus a lookup of
> the commit should happen in constant time.

Yeah, this should be a few extra cycles at most. I think it should be
fine.

Taylor
