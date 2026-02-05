Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB32F362D
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313485; cv=none; b=nKfMr3IYKAf/PcjGpMe1dcLgKFpASuL6rMTLTqtSU+2s6guJRkoTj/bT/2zTU+7eQh6Fhet1SOSMPzPdxz+iYKAsFZZDkzHrEdZ6HmKYW3JIRYB/HT9AM9cyCc2z2u+frqYQ+YyUf6R8ZFqZNznuYyb8QV0vY51YIAaHYM5sYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313485; c=relaxed/simple;
	bh=6CV7z2uHO1P4cJTFL0HymR2DThSculuzJsICWXbkH3U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oGGm1DCq+YWeERodQ3jiAroCPJBnQoBm2/w3s6OC6Gk4c3ecwLilb8feSDFSPcJIWAQwpfJBbBXS/wN9Iw96yzSldaT0dByUVo6zy1B3EBh6ckCof1pRcv2pJExpy1bvzisu4y0lncpKD3mdjxZWWBx8ZYVQhCsIWPBQbAnYTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gtwF7fZR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLVzyMj0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gtwF7fZR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLVzyMj0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 66402EC0231;
	Thu,  5 Feb 2026 12:44:44 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 12:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770313484;
	 x=1770399884; bh=aMwT5A4j3+5MFG4AB3FCtt+mpWTRUOeMrX4nwLuUKaA=; b=
	gtwF7fZR7EQkpLBzoqny14U85Q+lalG3qSz90yvsGNawhRpXGQ6RKuKJ+UfLweDq
	X9R5iq3ZdyEFanPyJfK+AVsqxjj80S7So9T2nZzwZNfrkrIxm5I8iWOvma431XcZ
	QRzYMxc2ikMZmJ9yNpfi+YwEJaIdjcocR0G8c/SlkUT1Na8Qq6eobjZV2j428m+O
	8jpoIrB1g2vJdep81PwV7sVwoBeopWi6nlGpw7aQlzC0syxTtDeKpnzYn0S/XhvZ
	4Y/ofCiLWqUqM2Iv/68c1BZcdodCP8pgOCuuUgrazYeUqOQV/Nw5K2A2C2EFuLZd
	Thi2OcWfrTRJq7cbtOqEXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770313484; x=
	1770399884; bh=aMwT5A4j3+5MFG4AB3FCtt+mpWTRUOeMrX4nwLuUKaA=; b=h
	LVzyMj0KvkDQmWIK0JHHevjJBv8rprXIuStXMGdGGAdgY1LvsAOSJiCbdFxXcsM6
	0MltUpdLJodO7XWwKeOHPnid75vb9Q7Ori+0Lugte3pylY5g9P7e9K7npUxc0wQF
	fLzQNm8SWZ9H6huLldbxrU9F29gbD9n2O8rCvWPV3hAFfXpSCuAL/Pczz5Uzsja+
	BSP/V5+HOO6HKnyn9t1nUKOl6gt47dVAcy+pzw9cvusOHSW27rrC8qjvwPx2r5DD
	ORqOxLBMGGNLwzF6NdGk5DuQwPDyt0gi9KW6myfX/B1/7NrKdXoxMy8ESAhnOUwM
	vMDvyMe/HMe7X4RfLq+aw==
X-ME-Sender: <xms:DNeEaQbCj_9tDPWUScw1wZV_0bmFxlCXMq3_93yQDybMmEoRfA9tGNs>
    <xme:DNeEaWPUneW5uim7G6qFztM5XPVITKPsmoP539yU-p4Yi07vwh753_JkKPnZGAe2j
    5kpYj_rkhGa33g8zMXSfD4oKF-bvHizCEmGlG0VinYwxVU-QR2WuCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DNeEaVDu-2uzqk8WsiPIYc1WOstEABnISHoO9b1Qyrv1mU6gmHqhaw>
    <xmx:DNeEaRVmQD22Y9cFU_ygsBMm6peMWKQys_1T3RDn5Bj5JqVckzbsdA>
    <xmx:DNeEabCKv-42gmgzf5oirkY3X71Qobg_BBKcHxn-1zMsGVek4wzQoQ>
    <xmx:DNeEac96_oZPfPcoJychlvAgwzgYYXCM9d1lPcYHV-YlmOxvivevNw>
    <xmx:DNeEaYgYKp-8BhDYARiAIHiDOEhD1kE_Jwp0fprvyB3e1JTeZ2z4BIEl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 460651EA006B; Thu,  5 Feb 2026 12:44:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYkm7GZ-qd47
Date: Thu, 05 Feb 2026 18:44:23 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <e3f3fa17-fde7-45a0-8474-aa25290ff1bc@app.fastmail.com>
In-Reply-To: 
 <33faa3f134c81761631c34600477dcbf82e619e5.1770214803.git.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <33faa3f134c81761631c34600477dcbf82e619e5.1770214803.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 05/11] config-batch: add NUL-terminated I/O format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026, at 15:19, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>[snip]
> +OPTIONS
> +-------
> +
> +`-z`::
> +	If specified, then use the NUL-terminated input and output

It seems to me that using the imperative mood for options might be
preferred now. Like:

    Use NUL-terminated input and output...

See: https://lore.kernel.org/git/bcd6fcd1190fe21c667b5253a4a33b833e65860=
9.1769462744.git.gitgitgadget@gmail.com/

>[snip]
> -	line provides the count of possible commands via `help count <N>`.
> -	The next `<N>` lines are of the form `help <command> <version>`
> +	line provides the count of possible commands via `help 1 count <N>`.
> +	The next `<N>` lines are of the form `help 1 <command> <version>`
>  	to state that this Git version supports that `<command>` at
>  	version `<version>`. Note that the same command may have multiple
>  	available versions.
>  +
> -Here is the currentl output of the help text at the latest version:
> +Here is the current output of the help text at the latest version:

Innocent intra-series typofix.

>  +
>  ------------
>  help 1 count 2
> @@ -102,6 +111,48 @@ get 1 missing <key> [<value-pattern>|<value>]
>  where `<value-pattern>` or `<value>` is only supplied if provided in
>  the command.
>
> +NUL-Terminated Format
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +When `-z` is given, the protocol changes in some structural ways.

It might flow better with =E2=80=9COption `-z` changes the protocol...=E2=
=80=9D ?

I don=E2=80=99t know how usual it is to say =E2=80=9COption <x>=E2=80=9D.

>[snip]
> +static void print_word(const char *word, int start)
> +{
> +	if (zformat) {
> +		printf("%"PRIu32":%s", (uint32_t)strlen(word), word);
> +		fputc(0, stdout);
> +	} else if (start)

All of the arms should get braces here.

> +		printf("%s", word);
> +	else
> +		printf(" %s", word);
> +}
> +
>[snip]
