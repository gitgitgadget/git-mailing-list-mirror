Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7A329C69
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525889; cv=none; b=WXnjDY7uHBdMoAlZodptD7cM224WwrO5AZdFvcKNgvKoLQvjTJZYst+KNE8rfw3mSjoZ9Yo+rEq/Dn617ZptsnmA1JXv5xzXPUme50qKITn4ZYZElE+tLv+Nos5RkEq1HcZZyirYMrkxAZL82ctsOLn7OJqwdYTCqCf7lVcBCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525889; c=relaxed/simple;
	bh=aDf2m9L3oSKvEbFTeMkfqkCSNGvXa9C/m8tnRMp8zL8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Y3NIdFygsIQcoaOPJ/oNY5TMesUlgKmmDhxYIJa7XgSNnIE+HpeQlGFfjkuwWf6stkoZZb30ZGDJ2qm1941qzK9ePGtWli3xCEWpDpz/MrSC5xkXBPkpShBu3pULJMRdWrB/Ta08+U2HhGn6TZtIJ8YijscBWWJUjerfxNW8A/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=X6ufsrCB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5VnvdO2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="X6ufsrCB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5VnvdO2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 48177EC01CC;
	Fri,  7 Nov 2025 09:31:26 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 07 Nov 2025 09:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762525886;
	 x=1762612286; bh=cxmsKD0z0DRwa4RjGTjhv/HKhVm+0B+/rZLPhD3Vvl4=; b=
	X6ufsrCBiLodvq22nQBkVDNh+/y1JYGkp7TeqmN+sLQpWjNmuRNHEzE2R7vnJquJ
	mBfYhQ478kHVQjGMSjBhXCpPSoy+/ZvLYl4prpA1UlVK+Swa9hQ7t39wgwkDFQs9
	kJO4HEB8jf80Aqw+rMa5nh4KhHokuQOaP3oZeFwf6ridHduPo06Er8ARX0+i7fXJ
	LHi3QVyRELZXjdUD28q5hsFh4/oqMzmBGPegueDwkAog2ChHo4rDlIoiHH7eAomE
	Lt0AQm7z9hACn7h5JWkq2Mdxnzd1sTIWcprP+C4pLzXvA5TvAZACrbdu1m9lxC3d
	Mh71U5BKpgVRgldTInWi6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762525886; x=
	1762612286; bh=cxmsKD0z0DRwa4RjGTjhv/HKhVm+0B+/rZLPhD3Vvl4=; b=a
	5VnvdO28QgQJf1ZM6/D2uBuUdzSyW/qsh8JO2FZ9iYll9ajdz7jbU6yncNF9lPnf
	EiWv5j7I5dO7nGW6fMsl4weTxHEb/dsEU05FLypb2BvuNxODBF5FNrZHnYwPZdLY
	5qj2uJf0XWDl+1k0EyOpIGWVkRDNIQTh1HLzQnrYy9nOpXCZiceAfxIAyiS0nPzz
	nITdhEfvdKc/G9c03q2QK7vrEQYeDRh5Oe6BE3BBJWajOaT/hPhqbpeP9h28VJSh
	coHiDwbtGkPjRuCtnbL5vv/xNr7yko0oLs9Ybq7XUBUCGv9RMllzkJ47l/DrttAV
	tfSN8a07VmCdRGtCORzDQ==
X-ME-Sender: <xms:vgIOaUTjeTS5wLq5rrOPblAGWIHQQz8T9XDoznt4iSphJxJghMtNoqA>
    <xme:vgIOacmvUzDz1q33q_pFc45beDgc9z8zoABzzvh8Khxgx2uoMHy_Xt6ulC9TGUwvo
    BdwQGEhXzb9mSrNtgnkC3IbdKJp8OrsyAYZi6xQcItVakMlhb0r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepjeejjefhfefh
    iedvfefgvdekgeffffetgeegjeeufedufeehtedufeeuudevhedunecuffhomhgrihhnpe
    hgihhtqdhstghmrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfhgssehprgiglhgvrdhorhhgpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vgIOaW-j07xxn9EEtAmeLisVZhTu7zDM2RtMbZNHvTzGdOlTg8p9Cw>
    <xmx:vgIOaUqZIJ8lgAaUi7ARdcegd1Wz4BgGCo75jIHFbFlxLZbLS1toWA>
    <xmx:vgIOaTk-mHCas3RQQVT9-Ey4uowmzc9lqluMf9tOLG1hxUZ4we0eJQ>
    <xmx:vgIOabKf3SDgRDqR9JjGodTdJCGHsCYA2a2FkFYOHUWu2NBa26czIQ>
    <xmx:vgIOaeL6uCSGNrZJstuZxOE5WUtWRzTTqRNt3jwL15--wcAZZD9Yzazd>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EEB4C1EA0068; Fri,  7 Nov 2025 09:31:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Awswnt8A2oaw
Date: Fri, 07 Nov 2025 15:30:46 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Franz_Brau=C3=9Fe?= <fb@paxle.org>
Cc: git@vger.kernel.org
Message-Id: <8883dc77-5894-4d9c-84d3-c29a434207d2@app.fastmail.com>
In-Reply-To: <20251107151620.2663adc25fec743cf1852d32@paxle.org>
References: <20251107124041.d6aac4345e89a9ac092c59e3@paxle.org>
 <671d53bd-952f-4849-9e5e-910e49d4c4e4@app.fastmail.com>
 <20251107151620.2663adc25fec743cf1852d32@paxle.org>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025, at 15:16, Franz Brau=C3=9Fe wrote:
> On Fri, 07 Nov 2025 14:11:52 +0100 "Kristoffer Haugsbakk"
>>[snip]
>
> Thank you for the additional infos and the link, I didn't know that! I
> suppose when it's being removed, I can resurrect the "whatchanged"
> subcommand via the config's alias mechanism (git wh<TAB> is just baked
> into my fingers at the moment).

You can set up an alias with that name on Git 2.51.1 and 2.51.2 today.
(And later Git 2.52.0 (soon to be released).)

    git config set --global alias.whatchanged 'log --raw --no-merges'

You cannot do that on Git 2.51.0 since you cannot alias builtin
commands.  But you can alias deprecated builtin commands on
those versions.

> Might I suggest that for future deprecations instead of an annoying to
> type flag just a message like "this command is scheduled for removal in
> v<VERSION>, see <URL>; use "git log --raw --no-merges" for similar
> functionality"

This is the current error message on Git 2.51.1 and later:

    $ git whatchanged
    'git whatchanged' is nominated for removal.

    hint: You can replace 'git whatchanged <opts>' with:
    hint:   git log <opts> --raw --no-merges
    hint: Or make an alias:
    hint:   git config set --global alias.whatchanged 'log --raw --no-me=
rges'

    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=3Dgit%20whatchanged
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

> for future deprecations [...] is printed in addition to the command
> still working as before while it's there? Similar to how "git pull"
> informs users about the rebase vs. merge options in case of diverged
> branches?

The thing about git-whatchanged(1) is that it has been deprecated for
twelve years according to the man page. But the man page didn=E2=80=99t
explicitly say =E2=80=9Cdeprecated=E2=80=9D in 2.51.0 and earlier. But t=
hat seems to
have been the intent. (Now it says explicitly that in the man page on
2.51.1 and later.)

This `--i-still-use-this` thing was only implemented (to the best of my
knowledge) for commands and functionality that have already been
deprecated for a long time. So it will not be used for fresh
deprecations.

>
> Anyhow, thanks again for all your work on this extremely nice tool!
