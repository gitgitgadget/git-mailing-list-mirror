Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956038DC0
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732501762; cv=none; b=HQqnXrzWJnpoFzhYW53srseCDcTDdT1DitsRKwOh9ysqs7c254ahxkq8q4FBijQU2YP+bJClHNsCw4lq5ABv4WjlI1W8Fu1Gj5s7THwvBG4sP1nmJ3Xu2++VblTUmMZ2tbu3YZKu81u3v6qUiu1tqVSX1NUU3+l0Ge/b5KAsSXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732501762; c=relaxed/simple;
	bh=fdRWixSvo/RfA0bpnOItpMNhu2ekbaOLFig2QW2jA2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ku9vT2PNv6iZ7JrMMPk6NfASeFQyAxHfiwVaFBXAEvNqGiOROw8Yb+z4piXZHScgETmgcOBhcL74UPH2+aCwx6vshmDgwyB7jYwVUh4hdD4xiDLljSzQm26VRZtV3gojh99xG+ND3biNL7xoGG2euaL52pTUrvo02K8yiMBT4js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAD2jyFr; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAD2jyFr"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A433B114015A;
	Sun, 24 Nov 2024 21:29:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 24 Nov 2024 21:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732501759; x=1732588159; bh=TOOziClSUXHzj4VL1KJaleWKXj4ij39k2wm
	fFSXb2oc=; b=MAD2jyFrd4OTUeCO6fH1NPdgJ3WKfSnps8LecMJnPjXTqf1vhZT
	pSxDZzlHAN80AMn9axF0Cnrk3PR0bNFHIQjF527twSm1Q33HpPxy7pKe3pOz6xOz
	h0Rc8QhCDqZnySsuptDIFdwISm0HG15HMvTqAe2RhG++T4ACKG4AayX9i36G5PTh
	aH20e23eInzNzHgnF+ldoReo3C2MuOpXHUFIAW6qozGhH4EeeVDyDnCqG519R5Cz
	FYNkFT4i3Oand7MriIBeyoabxoLpHfDYQlXJGLMKSpM5xzCHfGFgGRFWYauC3MPH
	BKPvHQydYik7MI+KPcIaa7vlImzMTtslLRQ==
X-ME-Sender: <xms:_-BDZxc3Q5jky6Xq8c8fib-d_-8Zhyz_jv6tZTf2-Bu8IqTOjEqukA>
    <xme:_-BDZ_M6Rzu3zHDLwkYJt3RfP5pRt_g1ZiQWmZDmj2GrMVsoW0lL7408Yslyv28p4
    FQvN1M3PmXdT_3VTQ>
X-ME-Received: <xmr:_-BDZ6jDrkUAQIzXMDzbUZu6W5jdlGaFHqw3zWcSBFgz2bMCqUNer_xmliZ3fHTk5L6903ivPsTjJZjKS8Ynygu8eHR2zyqvBfEIpvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_-BDZ6-q9QLLT2ebhhKK2ypidLc-y8DfveiWimRL5CMk5FDMvlsPyA>
    <xmx:_-BDZ9uqilHfrn3Zguk0s36up0Y3DijC198FUygwCAFDw59kNg3VcA>
    <xmx:_-BDZ5EdVjplFgJz4s3noGebMme-41kjg5BrTjXt92q4tUMiTP_Ntg>
    <xmx:_-BDZ0NuhKcTrb3CVKW40VzGNLh7vCaQ4yJOJGUY6yILEbgji8zoNA>
    <xmx:_-BDZ3JiLro2uKxyCQB4vPFkygdI3vNdrHi8wXmUHnNiRrf8itK9pqwY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 21:29:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap.c: typofix in `find_boundary_objects()`
In-Reply-To: <20241122154437.GB1738455@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 22 Nov 2024 10:44:37 -0500")
References: <cf49115db4e8dcd406a17c946659c2eef3ec6045.1732229420.git.me@ttaylorr.com>
	<xmqqiksgdrv8.fsf@gitster.g>
	<20241122154116.GA1738455@coredump.intra.peff.net>
	<20241122154437.GB1738455@coredump.intra.peff.net>
Date: Mon, 25 Nov 2024 11:29:17 +0900
Message-ID: <xmqq5xoc82rm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> There are also two curious cases added by f18b512bbb (bundle: create
> filtered bundles, 2022-03-09) that set tree/blob, but not "tag". Not
> sure if that is a bug or not.

I do not think it is a good idea to single out bundles, but I can
sort of see how it could be useful when making a partial clone that
does not have blobs. `git pack-objects --objects=tag,commit,tree`
might want to be driven when preparing pack data to populate such a
clone initially.  Unifying these three object flags into "all the
others" is tempting but would close the door for such a tweak.



