Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65673E5568
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432169; cv=none; b=Q7Fb7Cq9UwnLRAHIHx0+mzKxWR0X8+rzgY6c0hkZbL5QUKP/P9Egt5qYu/YomotKS8++d7EvODvAAzpA0gytWvL4QwhkmAbgYgPTWQv/dEtrJaoV5oHxx8GwP4QEDiD6ylqxsdUHWZsPmOQxCVC9vv7bSxo9PRUAcPko73Ndyik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432169; c=relaxed/simple;
	bh=6wgxyCS0EFQU4lFk2PpSbPyYvV3ruh/LynlhRcBZXbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi9jpWjwcviCtLVUsHIwf1LLvBmn0BUY6+8gx5QYmAhPZ9j8PIRFVR178N7ZF0/Htwne1gguUqxlMbMMRhe1at2bqnkMxruUDpaDKx2vo7rSxQFsEn3BtuthgydXp18uLHMWY15qxP6jhdPtkS382ajNa/cb9TQZrXVORUGSeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PkvhAqjb; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PkvhAqjb"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6647bc8f900so5753055d50.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1783432166; x=1784036966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LPLSL2ObRh6Hnlq01NPIhi5PtwVi10P09m8ry0iwLA=;
        b=PkvhAqjbv+zIkiHRxniYlR5JngE6KV91llcGYw4UAKkdNZmujn4bp5M2IGdKhvxfzQ
         rkIKqD0OV2sRh3ub3nJj2SP0BMotqId10YHgacORZNNpXMlsk+QMJLim6ctRRMNFziFG
         jfJOzEeSr7sgwW1oFrOeTKKI9VBDeDZGKV7+nxGePPGMtcqguQ4kbi+uuP0JD5aX2IJ1
         0FX8UXpdTJeU2eyZJ4BEww9qf8IpbbA4b/AjVmDs852UNOauyDJIQMQRCH3qJUi81BgR
         qbYZsgotAkp+YRdRKK+AoaC+kCdUdRVqwZe0oVy6LXao8Uh4guInzHIF+qAZ2TN3nQF/
         CTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432166; x=1784036966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LPLSL2ObRh6Hnlq01NPIhi5PtwVi10P09m8ry0iwLA=;
        b=aG7JNhsU4M+2WA+Fq4qnsa8zTLGHhOJVg78LeGTqBmxkRseIg6OWR9Wl8g4Wq0o6k3
         qlxTSYevP/lgecTGTqDtJMd4NCGx6bsRDwnOw2KpnclL8lokrCELN2lyx4kfiRi1vuK3
         q6v6BAjFxx75YxQXEnWNH5GzI90lS+jOSy/rkPZSX39v/tgeJ3AMqJvRO2PmLX4pp+0C
         tRGg4++qouNATU2ADiCSwXKQxGxkVU8wDNKMKbMzJd+nSR0Pe/+9Bv9ohn7jvo8AruLU
         uHcuUtX+tACEjGiXrr4SdWkJlhlYyK7DMp0n5zNT/kcoAOkPpIZ3FCwRnVbIBnV+sgKL
         idVQ==
X-Gm-Message-State: AOJu0Yyub3G9U19CeRI9W19bJYWcD65qFgYpiz5L1k1rYbD5bhG8TLPW
	hY/tpmcByU7yymdzLw0mEr2W7C5/BOF3Vldyc9tVvZ8il4j9A9aC0KMCKCo1SvC04VM=
X-Gm-Gg: AfdE7cmvO2jWSsrlrMi5CTO9+h40YglB0whXmGRppdZVjcdZoxZ5xRrU3LKNU7r8y7h
	WTfPF13QluHZsHO4VoVmDQdm2UeB3Ev665UYBVwCaiG/jWkpXLLzdJGIevWPSwcAmwBT80zsOrF
	ghLWaZ3KolpDg0A308dXzQRxXtpGKo2mz0ek4WvMSKAur9p/gj2+jm3P79iyipphWadAxMn6f1H
	nNVwy4bjzkYhu6P7zUzopbgZbpVqjJSOuhbPkAxXt7foonI3t4mY12ZYRAKG+C626xhOduC00TM
	UPE4s2qi9NAH9fomqteYRs7S7tj2J/mtvdN++ZXndJ6u1Y/Mam091mvYaD2Ca68VR06gHi6ShsL
	oDuvK4S6LRnjDplqFVTTjMOFV7JHFH85J2OiCTxz3bLTFIBRJK6uk4qZCAvnfBNu/7Nh7PwG66O
	ghrvqaSrVR7ux7sZAsuG2w9/SVmnT/lrjPs3JpuMkSkdHHUI/27Ao3jYd6x+MW1I4t5sIMGaiM7
	HFIxGjaikke+ewDiFl9yKUETx5+qSn8oe9Yc+7KNfTaiViddDaWlWD8AUiF9fkBRk0imyr+bLA+
	rzbv2g==
X-Received: by 2002:a05:690e:b81:b0:667:9165:8d00 with SMTP id 956f58d0204a3-667916592a9mr906113d50.66.1783432165634;
        Tue, 07 Jul 2026 06:49:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667877a8fbasm883614d50.8.2026.07.07.06.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:49:25 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:49:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all
 chain layers
Message-ID: <ak0D44nhSH/98WYD@nand.local>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>

On Tue, Jul 07, 2026 at 09:59:43AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index 4e39a048c4..c2a711cceb 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2610,7 +2610,7 @@ int write_commit_graph(struct odb_source *source,
>
>  	g = prepare_commit_graph(ctx.r);
>  	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
> -		g->topo_levels = &topo_levels;
> +		chain->topo_levels = &topo_levels;
>
>  	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
>  		ctx.changed_paths = 1;

Looks obviously good.

I think that there is a more permanent fix, though, which would have not
allowed this bug to evade both its author, and reviewer (me). I *think*
that we may clear up some scoping issues if we removed g->topo_levels
entirely, and instead stored it in the write_commit_graph_ctx struct.

I haven't thought through the implications of doing so completely, so
it's entirely possible that this idea is bunk for some other reason. But
it was the first thing that came to mind, and so feels worth exploring
to see if it might have prevented something like this from ever
happening in the first place.

Thanks,
Taylor
