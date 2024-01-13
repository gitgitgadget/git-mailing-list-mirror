Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE240A2A
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthew.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthew.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthew.nz header.i=@matthew.nz header.b="M+yz1YKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iuPGAoff"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id B6A525C01AE;
	Fri, 12 Jan 2024 19:45:45 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 12 Jan 2024 19:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthew.nz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1705106745;
	 x=1705193145; bh=31elmcOIDY8kSYIt7kgA4rEW138e8lgEutoWI6fSjg0=; b=
	M+yz1YKUkNs5bDpeUTV1OmItuULAIc+tK+nTBig//beNrVGigoEUpVRA8tIYOHOV
	hl8McNT5s4GUf3P0BaC5/oJnm7QuZnNej40TBBA3x6lKH+Q5vFrKJgMnqTUR+Xtg
	+1LWgFn3KxITm68ck8IkDosZmzkaaA0PbpemWeal0SSXIgY1hazH7gmWZtxwWrqX
	gVtXWSfLp7Ap/Ja8cTN7SunPTCnRTofnbNjxuPESn1Dd9JkDlLRNpQJZ6LT+2ttK
	NF+z+1wHMfR8aURhZ8lzC+I+I0Nc9hLqYhYsgJ1KDRtwmtyytRkL2w33p6tnCWgl
	vQcv/nW3ZuNdd0CNqrwVIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1705106745; x=
	1705193145; bh=31elmcOIDY8kSYIt7kgA4rEW138e8lgEutoWI6fSjg0=; b=i
	uPGAofftsQqnEW4MT+1UneHsuq8AmGj5CYnzuXLCVP2ZYyQ4yXP7Y/tD4QYgk2f6
	duT7TBEIxzo5XWteeZGr5dW+US1pyjlCYqnfzYjax0f6anZ9pH9Qwj2GMZGgbTUo
	AwI6a8EBImW2wsI0B+DxFPoRvdEfsYLRBbi3qjjGpKxbnjMmGuo+3b0O9UcEy4Ou
	45feb+ZmLwLq/GkHbyH2kGaVl1olLCApjzwycCqvOqHwc8DBQ0tc/U7FLBVAc/al
	zV4buwcD0KbnFOY7aw/kkN2kJE1fhqGwap4smPKqjOzrDztvP8TJ4W24TMwWpCwT
	mapS6vHzfbUh8MZXMzTHg==
X-ME-Sender: <xms:Od2hZdeaXNp6VB86iNjnjGXlcZpq5LgfksylvlSUGjpTW6YZkN-J9w>
    <xme:Od2hZbMztaSpzNCCcA3CqqJdCanJmcZoVBLMBA1GUR6fPTdL01mJMoPpv2LsC0ule
    siWlS9XO1DpWAf92lc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfofgrthhthhgvficuuedrucfirhgrhidfuceohhgv
    hiesmhgrthhthhgvfidrnhiiqeenucggtffrrghtthgvrhhnpeekfeejudffleevgedvfe
    fgffelueeludffveeljeejgfeffeejkeefveejudeuhfenucffohhmrghinhepghhithhh
    uhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhephhgvhiesmhgrthhthhgvfidrnhii
X-ME-Proxy: <xmx:Od2hZWgt_sfN0xQhJVd7488phXNSvDqgmqJOKN_Kw52dja1fJqZlsg>
    <xmx:Od2hZW8xyNR61AGGYAJMxHf3X9sXebJ21Jl8W3MkQSLQI4t3rtDxRQ>
    <xmx:Od2hZZuKPobcNOOXCpaMiUAToInoDAPyUHTU372R5rA0lG7TD3iy2Q>
    <xmx:Od2hZe4JG9z0dXmYDg3kG2Ff5O3iCeREvk4xoV2pk14qoxY8pO6Jkg>
Feedback-ID: i00a146f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DC24F15A0093; Fri, 12 Jan 2024 19:45:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf59af5d-1a59-41bb-b693-087b940e266b@app.fastmail.com>
In-Reply-To: <20240112073136.GG618729@coredump.intra.peff.net>
References: <b59c59f6-29e1-4d67-bace-13adcc108454@app.fastmail.com>
 <20240112073136.GG618729@coredump.intra.peff.net>
Date: Sat, 13 Jan 2024 13:45:22 +1300
From: "Matthew B. Gray" <hey@matthew.nz>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Help: Trying to setup triangular workflow
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

> This push step is rewriting your upstream config. Do you have
> push.autoSetupRemote configured? In general you wouldn't want that for=
 a
> triangular flow.
=20
Thanks for the pointer, yes have both push.autoSetupRemote and
branch.autoSetupMerge set. Turning these off has fixed my problem.

With neither option set the example yields:

  @{upstream}: refs/remotes/origin/main
  @{push}: refs/remotes/myfork/mybranch

With push.autosetupremote=3Dtrue set:

  @{upstream}: refs/remotes/origin/main
  @{push}: refs/remotes/myfork/mybranch

With branch.autoSetupMerge=3Dsimple set:

  @{upstream}:
  @{push}: refs/remotes/myfork/mybranch

With branch.autoSetupMerge=3Dsimple and push.autosetupremote=3Dtrue:

  @{upstream}: refs/remotes/myfork/mybranch
  @{push}: refs/remotes/myfork/mybranch

> Though I think it also is only supposed to kick in if there is no
> tracking configured already. Why did the "git switch" invocation not s=
et
> up tracking itself? When I run those commands it does. Do you have
> branch.autoSetupMerge turned off in your config?

If you're interested in looking at my full gitconfig it's hosted here:
https://github.com/heymatthew/dotfiles/blob/trunk/softlinks/.gitconfig

However looks like taking those out of global config has fixed my issue.
Thanks for the help!

Ng=C4=81 mihi,
Matthew
