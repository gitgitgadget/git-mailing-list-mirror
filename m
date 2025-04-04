Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633A2F42
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743741578; cv=pass; b=lu/fZgS7Sdij6bAcuAbjZih1N27gCb4f9xa00mrTtH4+C4HGZupLQdtRok5iDjLYxmzz5ru/fb0OnbPzdnK924xt+qBdb1NOPZJgOKY3fd0jQ3pnSWHRPiPgqEpJ936fl5weDL/Pf/TGzvh86dEoyRXEXrsU09et7THW6T94dis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743741578; c=relaxed/simple;
	bh=TRIGv4sjDXDkEpBcW2iUL27F9DhmxWR57dTsYUw71QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk70BNOX7A3tXfRTRJX6wqyUsd0fHusLszquoBeLAnVxSL6us7l8gD1sBUbfjWIm8L4pkaIBmEzVUEn0k4St6JI1TnMbt3aePJEVjEBUbPIltF5Xp4SJHOeIO1GzvKMLjj/zySt9PZcawm6NfHKQW4wA+ubzK/O1rQG3kN48Qr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=GgXnLwTu; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="GgXnLwTu"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5C5648A51E8;
	Fri,  4 Apr 2025 04:23:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.98.185.235])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 010E28A5049;
	Fri,  4 Apr 2025 04:23:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743740627; a=rsa-sha256;
	cv=none;
	b=mBnfumJS0OktK6mefqGTyGFqA7MSmNCIvrJS1De/IJpEaZB5yoPRiRr+EvIKHyvpsiJA2S
	Pm8EfiQM19xOW2f6dhFxq5Fm8JJx9qqjamhIsVPzEHWQtxXRJv5RZSusSL4sSGKAybrsZK
	k1s4fulsuBPA8Htf8GWm16/73mVWxIHtU/sEUBoIdOyRHSpjigmw2NIwKNk5Q3Hy2/lFik
	qTsPHC6AlLDHjfU2nm04nt92yfiyI1D54ySeRf88LFuopmZ+tvWNfForIuRX5QxbHTUopB
	uCapw1A7RKaSAsLgWpAmyS2bKuUM5NwPstexmrXy34lxh7An6FWAnAuQDZZBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743740627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=k7pyxQCfOEJUaWljcWDAhBRpvQQD5zvjvPfyBDoeKRM=;
	b=4qMlI53ME6g4vDMUztTvB1TdifNS1grFMfiTjMjA+9zey1KwwbOIq4HXYBsbVKVtKsl+S3
	SbBu60nm5WTxW/cCYFueyNVpmxPpiIZWF6Tfu5o9K7Cwj1TC2qxJWTdEGJ061ajy/Pw6TF
	BSnRxM6hXo7G/1HLWUFKpvwgzVMwR3HsPpzGH8diXIgOeFEAhWk/mX6SyMRX5eYGrJSvAf
	MJsS7/sF6KvNPAFGgkPoMe47/OXbaWUEoriYRL5TN1TdLp5ON5z9chhriJBRTnHU9rjdF5
	yf1/pGhQGcIdRbZVluUKpr0j4fZNohjNBnmDOCNYYjORpQxiCUk7IRWFGpn5zA==
ARC-Authentication-Results: i=1;
	rspamd-77c6b75dd6-q8ljg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-White-Language: 3c9221db48bb6aaa_1743740627264_1876491612
X-MC-Loop-Signature: 1743740627264:1650669191
X-MC-Ingress-Time: 1743740627264
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.185.235 (trex/7.0.3);
	Fri, 04 Apr 2025 04:23:47 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4ZTQTZ0MmKz2r;
	Thu,  3 Apr 2025 21:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1743740626;
	bh=k7pyxQCfOEJUaWljcWDAhBRpvQQD5zvjvPfyBDoeKRM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=GgXnLwTuseyb+jHPBEr8/2NVuogbl51BsHNCxLUAgNZNYj6Xyw+W1/3yypWBiE5Ml
	 VlZbWYqR53jHK/P8qkRvhPgny/r/g1XOA5/esKvb7gMT7EEH1lj9PM0BiluDfyHj9k
	 xG0xwWZugNpvbPXKM5R51orRlHajA3yqLDuHe808MOzQGOwxEdmKV4hODCHaP6qb9S
	 xtKRBAa3RCQeQnMILUzGRV3QDjdYP+b4IhL006CCBWuckIDwqk1tWYq6JFvUJZXFSI
	 mp99mIzZRwhF62Hi40ElpGCAmVEnlTR7y6yhz3o6sv+1YQ7cNDD8sXKLgcM7JC2VId
	 9OaQUOykNptyA==
Date: Thu, 3 Apr 2025 23:23:43 -0500
From: Nico Williams <nico@cryptonector.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z+9ez7kbh/L0Iq4k@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby>
 <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
 <Z+8IF67AC8gSouYc@ubby>
 <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>
 <Z+9N2REkYZhrbkzb@ubby>
 <CAESOdVCekFDxOWTTF71dpH1id_H2t9SaNo6buJ1MbvTnaENY7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAESOdVCekFDxOWTTF71dpH1id_H2t9SaNo6buJ1MbvTnaENY7g@mail.gmail.com>

On Thu, Apr 03, 2025 at 09:08:59PM -0700, Martin von Zweigbergk wrote:
> Jujutsu (and Mercurial) keep track of the set of visible heads. There
> can be branches but they are not necessary. When you rewrite a commit,
> Jutjutsu always rewrites all descendants. It also updates all branches
> pointing to those commits automatically. For example, if you update
> the description of some commit with `jj describe -m 'new description
> --revision xyz', then commit xyz and all its descendants will be
> updated, and any branches pointing to any of the rewritten commits
> will be updated.

I think I would find that too patronising, probably unbearable.

> > and even then still not workable because Git might
> > have to search _many_ branches to find commits matching the given change
> > ID.  (Fossil could have an index on change ID and trivially make that
> > search possible, but for Git adding an index is more complicated.)
> 
> Yes, I understand that it would be significant work to add support in
> Git. I hope that Git can gain the feature eventually, but we have no
> expectation that it will be implemented soon, especially not the UX
> part (the preservation-on-rewrite part should be simpler, I think).

Ah, well, Git does have an index: refs.  You could use
refs/change-IDs/<change-ID> to index by change ID.
