Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C42594B3
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948080; cv=none; b=CMwKedbsXbDHr3yTGwC2FKAX30xtHi+nYBSNEISs8l3B2a5o0+kYp7Dt7naMt5Bvk+TObqyycf6aFLVns6enPVMbgxG8sU3sD5NTKqR0IvzuqDQ0DGF3/wRap++mYbhpRVAbJUuF1fsIFMzbATdAUJCfwvDB5QORadHim/MBCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948080; c=relaxed/simple;
	bh=uOMVEBRoyOyxxx02MdpKFg5jTzaP9bdOAtk13vfUJHA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PJRlvd/gJ78w3EqPwyQw1YEK7pYJU1OlAtiv/OomhqBh8lo5sTErfB35PB6kaOVo64Wxyoe9wAbQDkYZrWtRZd4siq2Dn69ODsdJcXfU6UlHDxrTIKNRkGI/Iqz4oUIMQgseqKP3Se5zZjscOx0p5u5HQkimGrRxwco5Hnip5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Px3d/Yxn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GiE//a2p; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Px3d/Yxn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GiE//a2p"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47FFB25401B8;
	Wed, 11 Dec 2024 15:14:36 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 11 Dec 2024 15:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733948076;
	 x=1734034476; bh=uOMVEBRoyOyxxx02MdpKFg5jTzaP9bdOAtk13vfUJHA=; b=
	Px3d/YxnLwqWg/0ucaIATWsznbq/+64qt+KPHMOX6pB06TXC7DRy7y9pijlo/nFL
	bN6R2aJbhDJGJn4V5PbPFrW1qm0jP95jABrSasigd/RfMkFs0JwgI2uFF3sEjTJR
	assLGSRiNmtvW5M3yd+ngjTfQirpm868GAvlU/ZZDALOl+d7F+yrnuwjnbO8zLm5
	2Lbk74fT1vhlFljJXosQXG7u2p0nGQwDAwDnhYOHSxuyzbUchShkc0nqCw7QSrkh
	NRB5UXngJgeYwQt64qLa6sbkC9iI+pG5fAMCi6qyqswQpl7Sxe01X8+xOYIkuO/w
	Xhrb2X18fVp8/YOQVC+PEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733948076; x=
	1734034476; bh=uOMVEBRoyOyxxx02MdpKFg5jTzaP9bdOAtk13vfUJHA=; b=G
	iE//a2p3mgilUn6moR7wrQq0zz5BZF5oWPTGFN1FA3qn7Up8ylzglakkt7oYWuBh
	gyZqgnDeHu9v2jRK0tkJoke3+T6qGMBKZNCVag+xAeEzXjkSeV0gVW9VNUGdLqDE
	69PmBfNo37wSCM8YRaulxi5oKSZ8yi2JQXu0pquW1n4G/CEaQiekvTfQRV2xk+SR
	9Jr2RonCBW1G+eaJBpnDsUQ6BJ16Isjjyzduok+it7iKeYiCA3uoHYaN3jibwC+L
	rG0D+8ARf++zYfJ6utNMvCH1XWB3DBdB2wFhLLB/UhC6uo4RV52jEceTPg6+nI0+
	w93HmWc58A5wSsv5kk8lw==
X-ME-Sender: <xms:q_JZZ5bqBbqwFIHC4uZBupWpXyUjjJFyCi5X3dJMqc5iO2Mup_APfqg>
    <xme:q_JZZwbChSOOC4NFW4qQAfuk90zKjmWZMPn-9aRXpRqTjQdIsNVhQU5dDk7v7ZBx5
    6TWeEraTpmkYFbdVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepleefjedujeffgfeludehgeehueeffeeftdfgfeefveduueelffegkedtle
    eukeeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpd
    hrtghpthhtoheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:q_JZZ79YLVUNiQNhPPQUa369BwN3oc7uiSi-svKXSgYPhnHLWuug_g>
    <xmx:q_JZZ3rPAblNNk40SsN0Jki5AmhjKAVaPo1cz2Hj67zcI-uQe8-JtQ>
    <xmx:q_JZZ0q36LKAL9Pykcy2w2jvotMwp1J7sw8-n-pFNuqmkisUgN80aA>
    <xmx:q_JZZ9Qi4eZifaC1OTfbUCTPO1t0LMfHgrMcn8XfOJT4l1YE98lqbA>
    <xmx:rPJZZ_WO8zHWgnUDJXlCtd3wLwzi8TQ7kRuEABFa_hs92Wkt7qmf6bgm>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B241E780068; Wed, 11 Dec 2024 15:14:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 21:13:19 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>, git@vger.kernel.org
Cc: "Denton Liu" <liu.denton@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Message-Id: <4e8d3a75-0128-4d03-a429-59b7588f80b4@app.fastmail.com>
In-Reply-To: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
Subject: Re: branch description as a note?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024, at 11:39, Bence Ferdinandy wrote:
> Hi,
>
> so I've been wondering about branch descriptions being just a local
> configuration. The only use-case I know for them is generating cover l=
etters
> and request-pull, although I could imagine maybe the maintainer uses b=
ranch
> descriptions for storing the - well - branch descriptions for the "Wha=
t's
> cooking" emails and the merge commit messages.
>
> Now my problem with the description being a local configuration, is th=
at
> I often work on patches on two different computers. I can easily share=
 my patch
> notes with myself, but not the branch description. If these could be p=
ushed and
> fetched like a note, I think that would open up some other nice possib=
ilities
> as well, like having a standard place for MR/PR messages for forges, s=
haring
> proposed merge commit messages, maybe other things.
>
> For my personal issue of sharing branch descriptions with myself, I co=
uld
> probably just make up a convention for myself, say using refs/notes/br=
anches,
> but it would be nice to have this built in, instead of the local confi=
g branch
> description.
>
> From usage perspective I could imagine a new `--branch` flag for notes=
, which
> would tell `git notes` to operate on notes attached to branches instea=
d of
> specific commits, probably stored under refs/notes/branches by default=
. Maybe
> add an `--edit-branch-note` to `git branch`. And of course have the op=
tion to
> use this note instead of the description configuration wherever it mak=
es sense.

See also this project idea https://github.com/gitgitgadget/git/issues/438

Which also links to a 2019 thread.

With +CC on the participants. I hope that=E2=80=99s okay.
