Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34920A5EE
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743791291; cv=pass; b=XqAUyKAPcHZKO2rXbh1j0X54xvAP+AkqrJKOBOdqwyHI/5x+/6vCgfNi2bJoQc9RZIihXzzfL1LHST1lAtiZ7WqSKn8MyTXXZmONbsbS6F6e1CSP6r5h+/jhcQF8F4qK9vbw99EY5ZCAlBwTIkfKDMlE1mZ3POj84M/+QpZo4h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743791291; c=relaxed/simple;
	bh=0dVLwRGO9iIpK4AAHOLiqjzY9d9KBPxdR5raIoUkXd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckKeJYeow9mEfWIHkPKX1nOVR+rg6Hb8iaZkXkfiKN5swTT++qjpH+EiY0g8SE/UKAP0nmi22PFZCpHkYFfhpAZqcPXM2VATZvnxApGdAQ5MhiTAki3o6/74GC2BDRSCyyg/DCh0612+CH3+j8t25LhZVfG7F+5sRKuZqzEqDHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=mrjDZefW; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="mrjDZefW"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E18E382BBF;
	Fri,  4 Apr 2025 16:04:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (100-99-84-17.trex-nlb.outbound.svc.cluster.local [100.99.84.17])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6BFE682CE0;
	Fri,  4 Apr 2025 16:04:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743782673; a=rsa-sha256;
	cv=none;
	b=iyeioRH6aspZHauVHABSPWKhEqCTLSrvdU3qBO/sc0aEHmTRT9OCj/b20+ppuylKWJOnzc
	hZj0G73b0GGhRK/PFFwFpRefMJyox6N8nRDpAsV+lnRfJGXieGnK3ofpmoLjuJulRG7/IZ
	sp1di632Ii0a6UYT72wG7i9xfROmPVEPNDFO1SJDDo8Uv2h2R1xXYfq5vwJuGwMOOdPlgX
	BY1Jo+PIo0kQBSvchqMq5JhYJpSuvsWiR2fN1hxpghXIpct/c8iLW4oiNp/Yf4Uy2Rff4A
	0sg0kjuGCHfF1TBjlXlTqG1NI81rQ9XkkowfBZm8bI3yuSZQuQ92Mw0UR5fP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743782673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BOa5wlH/VfJn1zL6H4Zl5mz+k7Lwx0UPzxY2VZOh2S0=;
	b=XTRakF/vcretQHtSIvTtFXv8D6Fl+yiyooPfHSGUXaNIk3g/CMtd3yPtOjh+wGZ7YZr0a6
	eeBHG46R/v+ZF/7karQ3GIDxNMjH1/DCGDCf+O9ts/S1/e8JsQ1tYeOE6Jw6Y0vNOpfuUd
	DfRmjqfJN7mnPY4gDhbnrHY/eMjTQXZ97ZA3EFNQ+5r/tDTWZx8q/8aY7DPEJaDaEeO1S0
	fr02i1Zi6bdvXRHVbbCq4Mf3PeoTszS/g+JJKP4i9NLIFtom5V7fAh5qq41WUIr9QIPFpX
	iNk6zd1sD3qzqLiSXEVdtCpm5xDsnfHOwm0NA9A4flxyzSOMj9cxSWwZ3i+19A==
ARC-Authentication-Results: i=1;
	rspamd-6c88b8f79f-gltg7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Well-Made: 4620023b74cf2ccd_1743782673732_1599714937
X-MC-Loop-Signature: 1743782673732:2758946519
X-MC-Ingress-Time: 1743782673732
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.84.17 (trex/7.0.3);
	Fri, 04 Apr 2025 16:04:33 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4ZTk282hkBzC3;
	Fri,  4 Apr 2025 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1743782673;
	bh=BOa5wlH/VfJn1zL6H4Zl5mz+k7Lwx0UPzxY2VZOh2S0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=mrjDZefWZBZFNEYRgx95DEhGLCLtt2PQkmw4NpAVq6Bt7lR4R4asqk/FU5H1bToG3
	 GmVH854sQS/MTWFR0V1CoplXBcnwtYHUr7vRDrJrIwHE7uU109fxMV61Q8QwU+PnDk
	 sR1mwP8KO3ID1Xqx+OPyGsggjh4vdsDaCsN41sUT91a3EY3htL5fexF5/jrUlLsxeu
	 gq2pZ9BHdBndmhzObnIiUDHtjEeSPI49uqrlmDTH6f6HbWXWQlzshuEOA+n0AYw7bG
	 74yLUdHgcJNAQGdJEUOXCtkDSYwPptxw83zAyPJDmIYlbVa9KWg12zeLAik7tsAN1h
	 iadTsWYbo/XMg==
Date: Fri, 4 Apr 2025 11:04:30 -0500
From: Nico Williams <nico@cryptonector.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Martin von Zweigbergk <martinvonz@google.com>,
	Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z/ADDp/mIzuOofYl@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby>
 <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
 <Z+8IF67AC8gSouYc@ubby>
 <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>
 <Z+9N2REkYZhrbkzb@ubby>
 <CAESOdVCekFDxOWTTF71dpH1id_H2t9SaNo6buJ1MbvTnaENY7g@mail.gmail.com>
 <Z+9ez7kbh/L0Iq4k@ubby>
 <Z--nnOhsUCaqo45z@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z--nnOhsUCaqo45z@pks.im>

On Fri, Apr 04, 2025 at 11:34:20AM +0200, Patrick Steinhardt wrote:
> > Ah, well, Git does have an index: refs.  You could use
> > refs/change-IDs/<change-ID> to index by change ID.
> 
> I don't think references are a good mechanism to track change IDs. The
> expectation around refs is that users can change them basically at will,
> but it certainly does not make any sense to let them update change IDs.

git meta (a separate project) uses refs named refs/commits/$full_hash.
Users can always break their repos in a many many ways.  Using refs is
fine.

> Furthermore, as we have already discussed, change IDs are not unique,
> but refs can only point to a single commit ID. So that's another
> mismatch that we cannot address.

Oh I agree with that!  But I think I've made that pretty clear by now :]

However one could have refs/change-IDs/<change-ID> ultimately point to
an object that lists the commits with that change ID, and then that
would function as an index for non-unique change IDs.

> I think caching the information in an auxiliary data structure would
> thus be a lot more reasonable. This could for example be part of commit
> graphs, but could also be a separate index specific to change IDs
> themselves.

Sure.
