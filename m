Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752302;
	b=B1jb3kOVlLeDgD8GwlBWwPpVG74W4lCSVVKJUSD9yMcl7vD76zr3qpbU7KiwKFQcWnVW
	 GbdCCo/j5aim+qTnQ46kRd/RB/5OdtX1QWEs0nGblxk5J7VGp0QM+GjTmN7zirHb83t7i
	 It14VqCBfNzke1IycPdPYAft4oF+kVEWemDKRnmXdYOAJNgiwyAl6XJRXscm+ZNY2mSMW
	 NZpaUDUUw2ZzB7dk8X3Yd7cUpKqbFaO1uBDpGAov2JCAirIBy75ZJzcDMSkCyDce1Q3g1
	 GTI8A4K0D+QeDxRNCjWQHHhdEk2tEPvyi1vgJMzJdmIBfM7VcNyCmYBFB6/EXLKn4vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752302;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VeayKuQratnaMvvBawQ4ovtlroeeStXuVVTL9QYK/24=;
	b=IJVeRFAskTtP4ndnUwPcOrTlvS6I1xAlFLwr6xSmQ/KWeJ9wJf8DxryvlY5AezfuygHG
	 QEU/Y7+RA/Mt87fll2VZrGEVX9+5F14qPCUxq8Dio2tTUTGbI/6gntuRSAFSMWPv4/tQI
	 81aJHR7TFtSPNlH1Hytcu8hg56Uxn4Es/CV1BeoH9hQ/HQr81ISQ10Nu2LDx8vDYOf1KS
	 TU4/KnYJwKIH7qg7pMyLQom3Tz6uBKOocwBqCDv+ffiWwYanmfTbahozzr8uqKnU32/4e
	 F92bXhHLswjHrqVOwxbGuiotpzI7HaYA06stppmZOJd1JJCuSCI0zgjGTwJqWuxFP9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ERliECsd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eiVpPzAJ;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A1606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 10:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 995A1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ERliECsd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eiVpPzAJ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D09E61400160
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:45:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 06:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792752300; x=1792838700; bh=VeayKuQrat
	naMvvBawQ4ovtlroeeStXuVVTL9QYK/24=; b=ERliECsddmKVX6XyEYK2W9gMBb
	2DHcEJ8iNXahNGuXYKGtWbW1mRozgltlWY6ldz1u6loSB0td3kybEqDiIxWtk0YG
	KF2RlYp5lvVYbvtqQ/WYPpVjXeh3g9/VyrVEfrJQCqcuUP/gmdHwgAjySdrlNn+F
	3Wt62clBiSbnSrKWZt7pda5Hj4PKBLTi3tGHAerB03uEx0Cte/37qXPRa72VqdJy
	5fg3A7g/my4ShnV944ML7gvrnErSZntH/J0Bmb8KrPpf+2EoMfYGtC+gTVs7iN2B
	eK9pDGgyxAjgDB4mruVJGwAgOzqalR79W2QiKaGwsVqizFyMtd7+vkbQc1Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792752300; x=1792838700; bh=VeayKuQratnaMvvBawQ4ovtlroeeStXuVVT
	L9QYK/24=; b=eiVpPzAJDwfC/FInaoPsHsfLfkgKI5cp6tN7pR+W2aTWTkKfuhg
	/PyWh8e3EWepqZiHhWwop006HFeiQ3k2gD+FnbrUhITCZ+/ki/w80ZtBCzSTYr0/
	NLKNiCPGSeVVHgzi0h3GJHZgA1PmQLmt9XAuZZCn3dxkqHMA/ZOC7eHXutQw2+rN
	hhXnOv/IZ9V/jt+6AOV9O/OpGfQsiLvLbuZpUD3ezl8DZEy7xgi+4bCCBWeyf/ms
	SPlHRC5t03JQBbqS05xo5Cxf3NeYJmO6FGhNLFYCtBVgAN+GiicFL3HLb1c2cGIS
	CQDDwrJoxYMh2KgrY+IuoMkM7XZ7iy3X1sA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792752300; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KV3ztMBy0rPikY6aWUEGMViCy+bya4CaLuXqpWIBU8/cg6X
	BEmtURR9la3Zwiy35yT9IZ+9nuvftI2iay3Dx6HVemCeFwAkk2e7+nMDS8D0iuLX
	lrpxJHl0+gBcGTqwKy4Fve99685VaFhGzVXDctI4uGfvu/JqVE8FfnOY7rjuNZiZ
	GjIfMPkIqX2Sv/8jOPNYTMl+eZJIyWP58B6tUTdLdtEc51q5J9ATNvnljU+xEj6/
	ac0XvJQdWO8E5J/BlMtXZQUsePz4O0PdWjCSol11GKvCK5y3mFMpi/eHzri9yfBW
	hLio8Q3ik5QeSfAL9/0jTXyv1tMfn+rKdxd1b2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:g2DFlTImcQk18pVN/jbKuM2o/QXST/fo/zFW7QH3iFU=:sQJ+rnS84ZxUL1ul7aNco4BRoFTRuedUaz9T8+Ru38o=;
X-ME-Sender: <xms:rDrbak1CEy4E2VmgrHs63NI6FBQUUSyK0fjufCoU0GU7YvTVh6775A>
    <xme:rDrbal9P7evJjh9YnGGTpKmKuWU3PMuAtQ4ocx_dcw-9vbYLS3jArFhFUT7VqqvJi
    qGjXPh--mZaTbPjXSxRoeN7JopTEqW9fgxLcQyDVYXwe7qQaXtlBVM>
X-ME-Received: <xmr:rDrbalO4ANrbWRkO9fcyjeoBGOO9tjv4BiIncvSfvORDsi0POmkeW_vMbWw9VXqiKHOshg>
X-ME-Proxy-Cause: dmFkZTEjjrPJQntyh28FIVoPxF/a5cNtkls5A0JYrtIxOR9TYf0m719KxWhnHnSrSrs3/c
    jB14yy3ZAoC5WApUVUkgZB1PKzXArPw4mw0D+1iETFUCdUPPEhJLXu5FAVyLHKLGb0f4Ih
    aKUZmSt+M0V4QZKjUH96G8C3OwYXME50LMaq/2kkjmvr6mGwB8Z8o4orT97CecLUMktSgO
    ORmW0Vhb8dVKo+q3WI0ZNfADNfY3w5HV3S4eiEgc//OheBkeK6dZSdH0T94QaBMki7qnZK
    kYW68HmEYmQh4kfGYcHY/+bnxvuaZHqoXEXCZpui0IoJEGcAEkKqh+RBiONSoWS7Zqatno
    z8KAqXXao2eDErji4vVg1Zi10qaqGv9Oc97zEeKcMqfZrf0ISmztT0q/lGDXG2ng0uD5dG
    lIqtIXvIakll1EKxsgIGcm+BZmqWPipoTYywFw1h+hFx8gvlTAJf4GkYTZaQFeUduMwLle
    eoL49+ooW4REHTYTJQaeIzT58AbEWbAgvFDWjqGGB1exiD41H+f10cSZSw8GL7HhljFaat
    KGPud/Meo0xStrnUQtxL1mljDsD0bUZxbjTIxeV5Wlt+1C++kJYOonM2LxllL9O9h3hzxz
    SxJrJ9UlpgiJiQeiCnnAXnnvD5cHOaO0Cq6Gp/jQZMwNQ8flIDVpNBY9No1A
X-ME-Proxy: <xmx:rDrbapc3DuRyZz8W0HSYcWj41AWImzajQqToeg1I-PMQYKzWay0ukw>
    <xmx:rDrbakUSSUbgWGqaR6oV0ar6BGpKF9-FdyauVuzclRMXjpLA2--wBg>
    <xmx:rDrbahgfH0XrWMBqxxsAiZVF1LzPcuInobSgDKov6KAtPNMBALE5sw>
    <xmx:rDrbaj8ViTTpQ25mYj1rn6NbdpZTM-1FFX7aFUU0ogLG6UNR53grxw>
    <xmx:rDrbarwg2Wrd7EWclULdc9FZt7pvrrcRiWgrlGigyVopSH9RbBzv47Tu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 06:44:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9827c792 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 10:44:57 +0000 (UTC)
Date: Fri, 23 Oct 2026 12:44:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	jltobler@gmail.com
Subject: Re: [PATCH v3 0/2] connected: fix the connectivity check with
 alternates in deepening fetches
Message-ID: <ats6prUg8edTtUgY@pks.im>
References: <xmqqy0btz3m6.fsf@gitster.g>
 <20261020075536.49286-1-iwiedler@gitlab.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020075536.49286-1-iwiedler@gitlab.com>

On Tue, Oct 20, 2026 at 09:55:36AM +0200, Igor Wiedler wrote:
> On Mon, Oct 19, 2026 at 04:12:49PM -0700, Junio C Hamano wrote:
> > Your patches are not sent as replies to the cover letter of the same
> > round, which is not how we expect the threads to be structured.
> > Please study how others' patch threads look like.
> 
> Ack. Thanks for the pointer (and the patience), will fix this on the
> next round.

This version looks good to me, so I guess there's no need for another
reroll just to fix the threading. Thanks!

Patrick
