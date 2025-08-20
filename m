Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E4235BE2
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664468; cv=none; b=XdAnXa9byIIXnfHx6XQ6EyzDpuRT/gUY1HAo87xEuEO4EZ2iR43VuJweA+25M00NVIxeTywNcjYxHr7Eh+ssyPzyDV1L/DEECK1vbnyv9kUE3DgII8RRGn1RazYuknT6WFNIltYKZaqMX05V2wqlty3BdVIjEU10lrJkH8R9KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664468; c=relaxed/simple;
	bh=UT5KkLHGzFcLJ+1zr2H12Pf1qKdvUcXm5rspCv00hEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gClW5MIw4P+0eYevTzKB7Rha7CZtdTH89m1U2WC4yRTNgqm7yQA0wXZQKKbPAa2qq/owtg4a0LlKu1BTsehjrEyeMa1gec2AoCNUdO3aGJAXXhIhBkUeX78fbHUwdD6u4ytjZeSmtPI33HGkbuEZ8/FGOK5LpcbNb5CGFTzydn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hX1lxwpl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HcjBueKX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hX1lxwpl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HcjBueKX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7B6714002FA;
	Wed, 20 Aug 2025 00:34:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 00:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755664464; x=1755750864; bh=rilzwC1gqt
	yhXabAZR+idnrHQjW6tqrkxNyFx8I/MaQ=; b=hX1lxwplhF2Q3bw/qybQqpB+lL
	LwCZlaxNmcnwV73qYUbtNqXEuwNPrJc4TXKzQ76Va5BUveoB0rHhcbOEf78acdIZ
	dVcfCbY2B4bDVQGkMJWVwUWx2MLIEw+FO7i0LSzCozZUdqDkTuUAhm+4STvsx+54
	yUDzlQnXclTWZ6pZUFovj3C6nbOkUOVctyHZKaSByvhr8CZxviyI2IHmdw8ZvlRu
	cZSuCit+TfmR181MAzaY2bQg19LR3UXhVq+kbORzmaduH8PRQQsYRcgl246XX4Qp
	bnrw1UadYdRaycg7QC5RqEuFRpWUaVDmzmEQf/gEfnIk2HHtlr/LhYJYl13w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755664464; x=1755750864; bh=rilzwC1gqtyhXabAZR+idnrHQjW6tqrkxNy
	Fx8I/MaQ=; b=HcjBueKXltJiW01mP/3m8hyjq5ggRsFpCyb3TNfLMQHhcx67vJI
	KGMrtYafKP3E5vUBifmvegTDuJIytIF4y0dQLETJABLweCNVghVkNvEjNPo7Tf8d
	6YKJG6/DsDnVWot7MuLKP632Q0g/gyTtdsqk88pWxqsdMho8LbHvqjoqlu/HpWU+
	spfZOwWwk0iZhjxtq3LnMc0t2EhDdlxruFDfNxEpk8Bvk2zUmTa7dLZA1TX/sGa0
	jbvloX6ud5/KEYgQuppaUeO8czE/zTHq+JvUSiJOw7HG26ItgQI2GuY8QDrNyn8Z
	1r77OkrkZaO52bJnvufighYzAO/BdmeHL/A==
X-ME-Sender: <xms:T1ClaPeP9W2GHwGL8ZR8rECPE7xlNQPEyl3DDKCYSEtqURwqu-_ksw>
    <xme:T1ClaNqQXaMS7DRDE5sFPsQmrQzCObFgx8RM6iQxWAQDrOd-EJekGc3zgzXefZQIE
    SYpTcqOU64vSepjdw>
X-ME-Received: <xmr:T1ClaI_43xcC1y5TRMfy2u-7F04be3DTTgou7m1reiveg7grNfFQL8_cA5hGsjuv-9kD9ZINBqgvt5VjIhKYhiB2TTR0uztjAvTh_DktFwEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphhrohhphhgvtghhvghnghesshhtuhdrphhkuhdrvgguuhdrtghn
    pdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvth
X-ME-Proxy: <xmx:T1ClaBce9---1N3WQsibkjUcmCAngeeloXrEPskKVzqYaTUMrUbo_Q>
    <xmx:T1ClaKKYpG-ltNJozXI0IaLKMs74-2d3Dy8l9sQRbv-ovQCUaIBRbA>
    <xmx:T1ClaJj_lql6uYqtP3WRnKsjhevoKRk0SZevzyfw4icL6-01pPzRsg>
    <xmx:T1ClaARo201jWgmPhXKAI2qFtD2TLLO0MQwxjexvz2E2jGEHt85XCw>
    <xmx:UFClaHyyGaLx5DIZnYkJEXieCRpl7ryIOXc-8zrGMu_8QdklJH0Kputi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 00:34:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae3c942c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 Aug 2025 04:34:20 +0000 (UTC)
Date: Wed, 20 Aug 2025 06:34:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
	Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] describe: handle blob traversal with no commits
Message-ID: <aKVQSNgYgt2RO8hd@pks.im>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
 <20250818210312.GD1024556@coredump.intra.peff.net>
 <aKQwP01nulsquhzi@pks.im>
 <20250819165947.GA1050577@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819165947.GA1050577@coredump.intra.peff.net>

On Tue, Aug 19, 2025 at 12:59:47PM -0400, Jeff King wrote:
> On Tue, Aug 19, 2025 at 10:05:19AM +0200, Patrick Steinhardt wrote:
> 
> > > I didn't include a test here because it requires corrupting the
> > > repository in a way that is only easy to do using the files ref backend.
> > > It doesn't seem worth carrying a REFFILES test just for this oddity.
> > 
> > True:
> > 
> >     $ git update-ref HEAD HEAD^{tree}
> >     fatal: update_ref failed for ref 'HEAD': trying to write non-commit object 4b825dc642cb6eb9a060e54bf8d69288fbee4904 to branch 'HEAD'
> > 
> > But:
> > 
> >     $ git update-ref refs/some/tree HEAD^{tree}
> >     $ git symbolic-ref HEAD refs/some/tree
> >     $ git show
> >     tree HEAD
> > 
> > So that should allow you to write a test, right?
> 
> Hrm, that seems like a bug. I thought we insisted that HEAD point at
> refs/heads.
> 
> Ah, no. We did that in b229d18a80 (validate_headref: tighten
> ref-matching to just branches, 2009-01-29), but had to revert it in
> e9cc02f0e4 (symbolic-ref: allow refs/<whatever> in HEAD, 2009-02-13) to
> keep compatibility for topgit. :(

Well, that's certainly from before my time in the Git project :) I guess
changing semantics now would be quite risky. Reintroducing this change
feels out of the picture, but an alternative one could think about is to
validate that HEAD always points to a commit(-ish?).

But ultimately I'm not sure it's even worth it. If people really want to
shoot themselves into the foot they'll find a way to do so.

> Still, I'm not sure it's something I'd want to base a test on. Maybe if
> there is a big comment that says "It is OK to invalidate and remove this
> test if we ever tighten symbolic-ref" it would be OK?

That sounds reasonable to me, yeah.

Patrick
