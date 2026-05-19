Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF430C608
	for <git@vger.kernel.org>; Tue, 19 May 2026 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224636; cv=none; b=eDKw3OtQotW4uRL99gvh2kj3dbFawRBadPud08WijLMOfmYpPOqcmqEpqNxkqlhyZYE0+h4s2ZwhYwe0XmtEFPzEdX290S/vtyka+8RmcvxQ69I+nYfDo2KLrZIPJrErrbJZNfkAW6DFt8ybTrQmRA7/dCrw/QEoF3/51Zrlnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224636; c=relaxed/simple;
	bh=C5P3ok7JgHkiK5yuJRr+hvpEMLZ/TddeQW/CBaqs4Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGgWCarlWjawD2YZY64aBz+tRdnE1QEHrHnt1Sk6tcbZySBX/I5X/jUbz0z8hm5/sTQii8K6Mx5SQmLCwvzWyEr3Ok5GM/0Mk3i5zt4+fYW052sHJymmX7Mxxws7iNt+0DORNwPAMB24T5pIDZpMDHMIlCcAl4YKZM+uIZuALd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=tFg2HhiY; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="tFg2HhiY"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 70DA9B00535;
	Tue, 19 May 2026 23:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1779224632;
	bh=C5P3ok7JgHkiK5yuJRr+hvpEMLZ/TddeQW/CBaqs4Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFg2HhiY7kRV+gzh1GpAhIxiFd1Wlc5bH4g6kbpyestGeOQ0w6zSsYKGsetZVslL1
	 TouVUBGrwjZWnRo3jv6Jr4340UD+tHegXeNcyNfFycdZCFOtswCmtJ4/LyPNta6z7h
	 OAdxpI4lxjE4Mi6DxFgSr3wkCi5VOL2xe0/n4OwqYT/iua2RP02aFV2mlHyP3Q/93t
	 swzwkVqnpj3pZD15c1HuwDFJTo1Y68o/X/wh/naNbGHAmpEjyyv2sMope0+L8mN9BG
	 UUwfAY8wcRqoaXj/XWnTKyvZhDgv2e5mZmrimYXWt2w9GaFL85tYJ5hQozNLHjIdjg
	 zQhPO/ySfqvZg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] doc: convert git-bisect to synopsis style
Date: Tue, 19 May 2026 23:03:50 +0200
Message-ID: <3044460.e9J7NaK4W3@piment-oiseau>
In-Reply-To: <87tss5wjpp.fsf@gitster.g>
References:
 <pull.2117.git.1779049615.gitgitgadget@gmail.com>
 <xmqq4ik5d0le.fsf@gitster.g> <87tss5wjpp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 18 May 2026 04:10:58 CEST Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> >> +[synopsis]
> >> 
> >>  ------------------------------------------------
> >>  $ git bisect reset <commit>
> >>  ------------------------------------------------
> > 
> > and
> > 
> >> +[synopsis]
> >> 
> >>  ------------------------------------------------
> >>  git bisect old [<rev>]
> >>  ------------------------------------------------
> > 
> > were a bit surprising and confusing.  They are not exactly command
> > syntax definitions (which is the SYNOPSIS section is about), but
> > examples of usage.  The one with '$' command line prompt feels
> > particularly confusing, as the prompt is not something that the
> > end-user gives, unlike what we write in the synopsis section.
> > 
> > Other than that, this is quite exciting.
> 
> Well, my local test with asciidoctor did not barf, but it seems that
> the documentation pipeline run in GitHub Actions CI is unhappy.
> 
> https://github.com/git/git/actions/runs/26008649802/job/
76444895183#step:4:4846
> 
> I do not know what the differences among the three environments
> (counting your development environment---only one of which fails)
> are offhand.

Thank you for pointing out that the test fails with Asciidoctor. On my debian 
testing, both asciidoc.py and asciidoctor pass. I can try and revert to 
paragraph styling instead of block styling.



