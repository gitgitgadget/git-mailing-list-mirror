Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF653FE7
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754368741; cv=none; b=YeVRvx6SwMbDMXCcVc4cKbE9+YXjkhb3PuNQj4TvEJFUEmwueABHpGGUMhwUzd/4YFBtPfIwo3oFY1XeEw5ULuEjni933CiwZb2JMezUOOmT99BQ7pUPeFjOoNkIjbracupr+FrQ03txyjko2Fce1ZZVTqwYZF91DB7ztBbZVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754368741; c=relaxed/simple;
	bh=ypXQ1pR43flC9IAXreMSI/ZqS9eyPzoFcGPziA0ZayM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgqTqV5yAYhZJlsosqUCaP2F26OjcQAEfqExI/uQ+x9IJoe+tAf+UDgrbB+dIcYJfMENJIyTvN3zTtpj0c5fy8qknlWOH6AWGoprvEpTOrVvxQma80U9UrIWGRDCWYLRDtj5dO+A91KRo6NyVmkGRxWhHNOdWvb9qUDkdOCltoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YBl3tlfs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lgQp1/oP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YBl3tlfs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lgQp1/oP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 30B5EEC02D1;
	Tue,  5 Aug 2025 00:38:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 00:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754368737;
	 x=1754455137; bh=hknFOm2Txvhs3vbSjJ93HU7t0W18lQ9vYwvlEQ/MNdY=; b=
	YBl3tlfs4CnsPK/9PZ5sDcWORjA7VFTHCFhVB5FWK2E/3GIaTz3dbAFM1pQMGZrk
	LDJ9sNt9AD0Oq1+ZaB7efPzW5hbVXX6WedaLLkBXI2qWEAb/VJlUkK1FD2k/IYQa
	GoAG8vlFPs+KKXOcoUFiajZKZPNNkknrixnj4JoD4gvfTYg8E5CrvShgoMhr8i7d
	Nw3L5OjHURpbLJU7et1N01fVFduMtwNXj5eUqFvIS2w+kt0zElR8j198RJRwVJKY
	bRBnHeHqpgE1GmqAzIW2+I/6lsSLGz4PWJe6IAX1+ue0moXy3vh+xRiH8y+HnahZ
	1XeKi/yavE7dmvuTNWCTPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754368737; x=
	1754455137; bh=hknFOm2Txvhs3vbSjJ93HU7t0W18lQ9vYwvlEQ/MNdY=; b=l
	gQp1/oPM+CVZ7gRj4TtjaY3yXUkK6rt3GWhITAhILaFdovyxaXwDKnfekIlWEqoo
	9hjz07QAx3PwsR+t1NLlBGGXhECaCyFkFtxOakzIR2k0FzDRSzzg3EHd+P6Jqqrv
	ho2XAcqJmhXrja3X+QhoKC+DQUa/lDM3CgIzEVovDNMvosa0qkDxF3bNlhWa0drn
	GSjvHcwDB8rSuj5PuDbNRVAji5FRIpHbcJNaFIpkYqqQbRLgrOG8/hxHhQlFjJDh
	OTdTMjwUEQr6odPczuIjCdW9AXHLsJ6Bc/bg8iIsuq8Rs/AQkS9BTdOMzBQPY023
	1RLODdzefdYANCejmOhAQ==
X-ME-Sender: <xms:4IqRaPlDSBIxY3oCegatANeQAwGa3xKVB3R5WFtuv3cSQOt3K_mdvQ>
    <xme:4IqRaGGv4IH5F9wdjieXfFEj_fUH0RGUB1J8rnfuOhkX-IEWaX0dVpC66i3QnepER
    qbOzrIBx0SGHPm5Mg>
X-ME-Received: <xmr:4IqRaPFVct7l0odneHyeM6QiajeipGq4BX-34s7zIZjDElsK3NENhGrB4qrinKcO5aVCK57Ji8XiH1Fjq0qM8MCzhR-ksHcV8gRp6UY_mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:4YqRaDOZchI_m4XCldG_UUPcttlXQaqJc_MOXZVxnZeyks-1wTjlww>
    <xmx:4YqRaOGNBFC04uxBrCS5RYI0NtiHWMWcs2simu0qJuHaXPPOlN4jaA>
    <xmx:4YqRaKOYp4DqG8827fITErksvt3tuDeGYNPkdEACrnK-St5PJjuQfw>
    <xmx:4YqRaP8v8c1BRIcleLYkmyhWq1uJWrVkPTpsSejilN23KKM6_rH9aA>
    <xmx:4YqRaKA3jLiQ1l4IoVdHebwCWCG_vX-WAgqz6-CURCoZ8TjGrqymI2p3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 00:38:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e7f9ba1b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 04:38:54 +0000 (UTC)
Date: Tue, 5 Aug 2025 06:38:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/6] t6423: document two bugs with rename-to-self
 testcases
Message-ID: <aJGK1afGLkNAQID6@pks.im>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <bda42aa85cf4f332ef60aca1a8937ed4b868fa87.1753197791.git.gitgitgadget@gmail.com>
 <aIx7OEX6AEqNsIHb@pks.im>
 <CABPp-BEUFaePoJx-dn9hOE6r7mQV_W_6QF2K1sJJ2uXeL81rdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEUFaePoJx-dn9hOE6r7mQV_W_6QF2K1sJJ2uXeL81rdg@mail.gmail.com>

On Mon, Aug 04, 2025 at 12:15:15PM -0700, Elijah Newren wrote:
> On Fri, Aug 1, 2025 at 1:31 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Jul 22, 2025 at 03:23:08PM +0000, Elijah Newren via GitGitGadget wrote:
> > > diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
> > > index f48ed6d03534..69de7a3b84af 100755
> > > --- a/t/t6423-merge-rename-directories.sh
> > > +++ b/t/t6423-merge-rename-directories.sh
> > I found it to be a bit weird that we have this conditional here.
> > Shouldn't we expect one particular outcome? Even if multiple outcomes
> > would be techincally correct I think we should expect one particular
> > result, but we may add a comment to explain that different output would
> > be fine, too.
> 
> Isn't that exactly what I did, with the note I'll copy below?

Not quite -- you do have a comment explaining why you relax the test.
But I think it would be preferable to _not_ relax the test but still
have a comment that says that the outcome isn't quite clear cut. This
would alert us if the outcome ever changed and thus make it way more of
a concious change if we had to adapt the test, but it would still leave
a future reader in the know that a changed test outcome might actually
be okay.

Patrick
