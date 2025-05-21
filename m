Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30C263892
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833455; cv=none; b=psOnmPOdzuQ78OUGwVEcEgxJPOWJezH699wwzZxtCnwULC0WQuGkf4QEuXdYVq50RndCf3K2snUWWyb9gIfWdzrm7aMXqCJDydd1xhj2f1ONjKECyH0uH/dDCnYEl1uMrpnbFdaXOr5r90qAbdiVeI3R9PWMTte7nJE7EPL22sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833455; c=relaxed/simple;
	bh=J4eDrTYxnAbiIWhKsjETDE0f+M3SB2OIFy7N/LWsuCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZBFAD26xcUKqv/66iQAWEoYp6qzKcp91c3SD+aMs+zYkxri6PHn2d2UMSLYaLmnhzchbLQjpZDD/SlzTg3ZEWZI3451SWhm5MgNw3YLW0hT9pRDtaYD20WKidj0bk4lLxF7hG2p4OqNFKsJGjUwU3x4oVBeMVI/mMkb7wYH6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rgbQFPqx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWYg1llk; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rgbQFPqx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWYg1llk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6336113804A5;
	Wed, 21 May 2025 09:17:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 21 May 2025 09:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747833450; x=1747919850; bh=gl3aMm19WU
	/Z+3UH8deHPmWLhyDEfKZrbYjjn71noAI=; b=rgbQFPqxHot7yCFC1Kw/dBJ3T3
	X2WKLmgrkb4E65rX++iFCa6VFs1hW1ByuFLXHQpF2A+r7RQqjM1BPs8Kog5Jlije
	r4GZPlv4ziab+QYz+nkmfx6lp4RCyuqBe9AOPSfmSYNe37ButcFc2OEwTRjXxQbN
	txqpxyWMb3Srrg202LqnMYv1mrir3rIYXmWNJni8yw06vbp1QsU5riFmdjGaJqEt
	yxARY8Gh3uvI6bjdxj3oTsbWvBb4xrCVPvvEOhJW4Ojssex2g7XSmk0mIEeFxGqm
	sNHAl3mMMA49tnPJuO5hMZ9lcE2Nl0Dekqu0qU5kd2y7mV57LpANpbDyE6Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747833450; x=1747919850; bh=gl3aMm19WU/Z+3UH8deHPmWLhyDEfKZrbYj
	jn71noAI=; b=XWYg1llkDaEthbc4OmwlNWUzCvtIAlMzkC+5FIFxarWrM2X8fP/
	XEphkgflah3UBecXxVFLGxqWrxaJU4rm9AX462qeQ9oKi6za/kAJ4GufSGKPLAJm
	vBcyFvDq8REROleiQGYanDzItznXvDE7YNWcZhvaouN4fTuB4Su4KHFZdbwmSQUP
	Gsc8og8ZuiW84m2eAKuiNykuMe72VFYD7HdnH5N+Yl8JoKjGU2Wu2h1CkKVBvyob
	pxTjYTf/utX41qpcxwVbTRzgz8vOmHNoPd3JDqe2KLqLqZOBUOSRV4AgLVxT9Gtu
	oMeiX7XuiqlMMIn91rIrOEubLacXFVBsdvw==
X-ME-Sender: <xms:atItaP_sMk91pGzqpM3zqcDDhkNgMEwvPi5NxTE44JyFOfv57_miSQ>
    <xme:atItaLsepl7P7p0KmRPfm57eaZJPQGumtc2sq-QNqI98zMizi3H4-Q7DjIiUcz-em
    9yKWxe96wT4x_oRRw>
X-ME-Received: <xmr:atItaNBvGwJyYbVMEsKH1PWbgb28vzRwJk8iqMv6KW7-fYOpvI_MTnfL5NOn-R9FusQRZgD_E0_uLgXg8QfIuO-O1OulkawRZkCz13nN8pLl-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefudekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrug
    htuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephfehtddvhfevledvleef
    hfevfeegueegheffieeuffegieegteehhedufeefiefgnecuffhomhgrihhnpehnohhtrd
    hlohgtrghlnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:atItaLfnxkRXpGWZaCdBZAz_5SVp5ChYlhEDRjhSXghGELyMCMqtjg>
    <xmx:atItaEPX1oezd_Osi0JqHd1FIlEb6e1Gt6WwxMpuqdrzO3uQZPxzZA>
    <xmx:atItaNl1iujElh_pZrX07tae3NXyvyrS7Y5Dc30maF8JX3Iln_Eknw>
    <xmx:atItaOu0fq0Uk7u3kmRnF8sADrLQjEBIJv-Uzvhimo3Fc1VhXWJsXQ>
    <xmx:atItaPBUcgnW2Hw_ehhVuJz_fNcphLQogbcJwYqlUVlaXj64uluUauHq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 09:17:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a4ffb9d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 21 May 2025 13:17:27 +0000 (UTC)
Date: Wed, 21 May 2025 15:17:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
Message-ID: <aC3SZtwQSt0mSVuo@pks.im>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-5-ben.knoble+github@gmail.com>
 <aC2OaeLYJQAOE_S1@pks.im>
 <01301fa6-eea7-427d-a61f-5cb8dac99afd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01301fa6-eea7-427d-a61f-5cb8dac99afd@gmail.com>

On Wed, May 21, 2025 at 02:07:25PM +0100, Phillip Wood wrote:
> On 21/05/2025 09:27, Patrick Steinhardt wrote:
> > I agree with what Junio mentioned in a parallel thread, especially
> > around Git hooks. The expectation there is that those may execute other
> > Git commands, and that should typically be using the same execution
> > environment as the original Git command that has been invoking the hook.
> > So refining this patch so that the mechanism is opt-in probably makes
> > sense.
> > 
> >      A slight tangent: I wonder whether it is even required nowadays to
> >      adapt PATH at all anymore. As far as I understand this was a
> >      requirement back when people still executed dashed binaries
> >      directly. But nowadays scripts don't really do that anymore, but
> >      instead use the git binary. And that one doesn't need PATH to be
> >      adapted at all, as it knows to listen to GIT_EXEC_PATH and its
> >      built-in path anyway.
> 
> But don't we still need to change PATH so that hooks, shell aliases, git
> rebase --exec, git bisect run, etc. still run the same git executable that
> started them? For example "/usr/bin/git -c alias.g=!git g --version" should
> report the version of /usr/bin/git, not ~/.local/bin/git which comes first
> in my PATH if git doesn't change it.

There's two parts to this: PATH and GIT_EXEC_PATH. We do have to adjust
PATH indeed to contain the location of the 'git' executable. But we also
add GIT_EXEC_PATH to it, which I'm less sure whether it's actually
needed.

Patrick
