Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79447FBFE
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthew.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthew.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthew.nz header.i=@matthew.nz header.b="NrwDWJ1b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5frfY46q"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 814043200B3E
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:24:20 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 11 Jan 2024 21:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthew.nz; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1705026259; x=1705112659; bh=bMGRVY4DgY
	c0jo1S4Th6oO7cgU1TRZ2ASgZjAmXVU9g=; b=NrwDWJ1bggZC8HgdaY5ZBj12vR
	fFvCDwhM8zTjnAGwrtCWu5oxlz4WTrYchlg5R2k+spUxSMaKe2ntHOKZJj+Pwlrb
	o0ewxNMyOQmCfBHiDcjb/4MMVBEkus4pn1qYAHVk0Mu1DEwlL3XTAd7NFVFy5cX3
	ka2fDP/F4IkP3KBGFsjaO2Hn5+gOsVD1Td6IfvyUU7TvyYQ1NFOg1ebpKH4eNFwZ
	nnwuq/wovYVvGUyrqm4hkB6hGrUZLPneWlM+26DC8+ezQzIpPTlh4nzkjjm9pfcM
	u1GXWiGhPLPfqbEMWjj24nIHilGlsU5kZ0Sm+dQ66Bh73IaDVmJIWuHBv1eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705026259; x=1705112659; bh=bMGRVY4DgYc0jo1S4Th6oO7cgU1T
	RZ2ASgZjAmXVU9g=; b=5frfY46qfczXZLaYnlLXT/f7SQGu5Uvr2iXYoxpxhaPp
	kmVR978SdD3jFcyMWcv+891zrp+8B5MmUfxxBpFdJMJLnLEgy5t1TA8uA5SfhvPB
	QQO4/MT7V8Dj+E78eaS9r12iIJ1yg8PcLXnSZC6J1a3uziAZ+FSkowuJi5kN4oq/
	K3qKZq+ix8pjtZQKtoWgkI8zzR0tCjhOfuX1UGvERBIFdnA25M9C7zGNPwEDyIur
	IUZBNCG9qVBKTQ4eH/Z0aM+Ww7ddwFiG3yz6FDezuaob0HmYKiJ4ho9fXP1NupPh
	vD4pXCiCS+PrMC72W477dVFOwrnwn+rLXETj2xn9Cg==
X-ME-Sender: <xms:0qKgZRpw8962AD00J5REtyZ6_J9ZkOUjvbmAmWXwhMbB5VoQ4cSDzA>
    <xme:0qKgZTozTNDlG7SEh4vc0Yn0fLmwjeWgFIVn8d7ZIqc1amVd7PXtHKlftSKGiRGDJ
    9mYhcM9JnN2VRhy2LY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeigedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdforghtthhhvgifuceurdcuifhrrgihfdcuoehhvgihsehm
    rghtthhhvgifrdhniieqnecuggftrfgrthhtvghrnhepkeffueehtdeifeethfdtfedvgf
    egleejffdvuedukeevteejtefghfdttefhtedvnecuffhomhgrihhnpehgihhtqdhstghm
    rdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehhvgihsehmrghtthhhvgifrdhnii
X-ME-Proxy: <xmx:06KgZeNDUKOvdXoRCSXy5TE3mmQIYMozr9Jha7CGnTyVhdmoveQHMg>
    <xmx:06KgZc5FUlpERfgnKlIoPlIK4HrhN-VD17IZpC6Vc1HhkgwEIDsA4g>
    <xmx:06KgZQ6R6plFp0sM64TdDKvFyowU3WZD3XO-iIjAUmiufU8Oxbz21g>
    <xmx:06KgZSEEFNa29644qcD7WHi1mY1W_73EiUpNEQ_iCDviAueCNteTCw>
Feedback-ID: i00a146f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D59E015A0092; Thu, 11 Jan 2024 21:24:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b59c59f6-29e1-4d67-bace-13adcc108454@app.fastmail.com>
Date: Fri, 12 Jan 2024 15:23:58 +1300
From: "Matthew B. Gray" <hey@matthew.nz>
To: git@vger.kernel.org
Subject: Help: Trying to setup triangular workflow
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

 Hello

I am trying to set up a triangular workflow against a fork. The example =
I'm
using is documented here: https://git-scm.com/docs/gitrevisions

Here's the example:

  $ git config push.default current
  $ git config remote.pushdefault myfork
  $ git switch -c mybranch origin/master
  $ git rev-parse --symbolic-full-name @{upstream}
  refs/remotes/origin/master
  $ git rev-parse --symbolic-full-name @{push}
  refs/remotes/myfork/mybranch

My setup looks like this:

  =CE=BB git -v
  git version 2.43.0
  =CE=BB git remote -vv
  myfork git@github.com:heymatthew/dactyl-configurator-fork (fetch)
  myfork git@github.com:heymatthew/dactyl-configurator-fork (push)
  origin https://github.com/rianadon/dactyl-configurator (fetch)
  origin https://github.com/rianadon/dactyl-configurator (push)

Here's what I get from running the documented example:

  =CE=BB git config push.default current
  =CE=BB git config remote.pushdefault myfork
  =CE=BB git switch -c mybranch origin/main
  =CE=BB git push
  * [new branch]          mybranch -> mybranch
  branch 'mybranch' set up to track 'myfork/mybranch'.
  =CE=BB git rev-parse --symbolic-full-name @{upstream}
  refs/remotes/myfork/mybranch
  =CE=BB git rev-parse --symbolic-full-name @{push}
  refs/remotes/myfork/mybranch

I was expecting @{upstream} to be origin/main, but it appears that @{u} =
and
@{p} are the same.

Am I doing something wrong?
Are there better examples someone can point me at to do this?

Thanks in advance :)

Ng=C4=81 mihi,
Matthew
