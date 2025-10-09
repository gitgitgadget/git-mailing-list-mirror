Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F025265614
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042846; cv=none; b=UajcsO5iEDdvc/33/JdIsENWkS/CiDj1E/fAezLkOQUxBaYBk+8nAA4lwAnPnjtPYfeaF+QjzcNgXpuZcYiMLA15sGuTNVhF3sy0Tv13yAAvhvJXa2YHgs4lDk5VpmG24MGA2ttRNCuF85bQ2f8uXUtoc8HRSH25xCc4jSfUnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042846; c=relaxed/simple;
	bh=p+dn/OMmDYb328VlH7HNbmf7Rrw9EXfyR9Oh4bfbaXI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EGruX/AZiOAAMeJ4X9y1LH4o5Sy11yLXz9654nedou2u9ppEWqn55kIaEskaJB7pX0+UndlZDyxbRq/3njgz9oxCFh14aA5N3yjGl1fiV6wmnhhscEup3SIZfa6rAFlIdLZ8LO7ijL/OykpAfR3ShHYLPgeN/xXxL6EbBNZFAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=G0fmydoP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XwO1iLd/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="G0fmydoP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XwO1iLd/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B7FD14000D6;
	Thu,  9 Oct 2025 16:47:23 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 16:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1760042843; x=1760129243; bh=p+dn/OMmDYb328VlH7HNbmf7Rrw9EXfy
	R9Oh4bfbaXI=; b=G0fmydoPozG67eKd76jWrOG4ANCoGyLfeF9l6VMFp2kFa34R
	G1McJJKTHjBQUFBUo0UGbt23tytPCBEKhfPsFOMMOkVKGkWuF6zi5/XMBZL1c9A6
	ZmmpqGcjIR/Bko13QQA5+xjoqI/TGgD4qecYTw8jllEY9ph93XvQjMXDweu1XRpM
	/BHtAixNNbgk2YiCmdrdyUrKh/y0pUXDsVgs8YQKkUMom0A8rFYFd3zCyKJFAigJ
	KU+VWQCLi9HHmojXCR4sTA/8mJzsou4OwsAd1UubnNIFitBLsUb6EXBy49Lqj+6B
	qgGsFVf9ST1me9/ueTQIQucqfscJeNtILzFwWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760042843; x=
	1760129243; bh=p+dn/OMmDYb328VlH7HNbmf7Rrw9EXfyR9Oh4bfbaXI=; b=X
	wO1iLd/XxLQoqbmdfSqRxyoj3sF/whap/C5gm9wuzF3h4XHwnvZDbYK/7Le5Foy+
	H2CLoCd1PqVdFb+qc+d18XqvaffRx1UhCfcUR+uNiAUJEdAEQVZUILZ/ISna/Q7m
	J62KOwNJF+7uZ1AGpseN0ie3naXWQrEjaaTDDJOI6ePf4BXR6LaN9x1PmFFF+4p/
	UO9uNVx8+4tntBs1XGTFJhL2C94oWSPtc05a6u2zX15YU+kUU3lbD0NnCjLnCoLd
	vbX2wluvjY0lZM4OR9H0tWbUNZ17BqPuXuRTAYjFqw1vLc8RME9oO9TRswFygFdB
	AaB009KD/hJtnIlN3tz3A==
X-ME-Sender: <xms:WR_oaP5A_kPPVfpiB2ntF5xnAEn8kuRsQMClTkX0uD29lUfa0tcZNSw>
    <xme:WR_oaPuzXGspW_eDC0WfFH3gyQGXASpmUsRmjAcLevmpQnwdFavaDSCyOWa6vNoOg
    1q5WvI2HGz6lWbvBAye95kT8Xa3mKpnjXvBWw5iOIsdXjfG70E13g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:WR_oaOh-iyC84INp_rQlGD0kjpdseOcb7kw0DEIVnZaPMTTPQ8Bttw>
    <xmx:WR_oaKfG36vy7zbbtSt5ONZ2hxyT_tgJEnrdyelUf6f_d-GHM3s2EQ>
    <xmx:WR_oaJmyoLbbCEQPkFoaMNNq16H9sBsHPzW7lDbUjx5TSphY-tLB8Q>
    <xmx:WR_oaLtnGpH3BZEYZx21KS5TxDtjZ1xWM9-Gt62sLyybhr433x7TiQ>
    <xmx:Wx_oaLXchnHhVMQFo0az6z8UGsBJTjKuZFqJ_tMiSehvRHBTyayKi81x>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D73B11EA0062; Thu,  9 Oct 2025 16:47:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: And9clSpnOi7
Date: Thu, 09 Oct 2025 22:47:00 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Johannes Sixt" <j6t@kdbg.org>
Cc: git@vger.kernel.org
Message-Id: <91ddb8c2-ae3a-4b13-a23b-e5cca172ee09@app.fastmail.com>
In-Reply-To: <aae39545-461a-44f0-b01f-bb40b53b1858@app.fastmail.com>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com>
 <aae39545-461a-44f0-b01f-bb40b53b1858@app.fastmail.com>
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025, at 16:31, Kristoffer Haugsbakk wrote:
>> We should maybe think about deprecating it for "git rebase" though as=
 it
>> is a lot less clear that it is sensible there. If you're rebasing a
>> branch then there is a very high likely hood that the upstream commit=
ter
>> dates of the commits the branch is being rebased onto will be newer t=
hat
>> the author dates of the commits in your branch.
>
> That makes sense. If there is no use case then it should be deprecated.
>
> I could mark it as such in the next version.
>
> Anyone else have an opinion on this?
>

By the way. I thought of adding a stderr warning when using this option
on git-rebase(1). But I don=E2=80=99t think I=E2=80=99ve seen that used =
in this program
before. If so, why is that? That=E2=80=99s more in your face than just a=
dding it
to the documentation.

Is it about people parsing stderr, maybe..?
