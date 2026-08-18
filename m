Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF237C0F0
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056877; cv=none; b=oRba/TGAu8/g5L9IFtBrQVN5Vv9hT/j1eikuKx+nxijWlO0sDY2i9ZM3iP2a76JdTCNyGQFF3VgAO3iFSTNHYXoezMmjcAf7yIZwI1PUs0Ipl4vqpyxPTfRP260Nuh76yKm6lauQFF2uOqfpeh9nYWdc0XyVknJzxVBm811VLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056877; c=relaxed/simple;
	bh=n+EKvXhwuqE1b5zD5DiTJi4PNP67B9XEvFnKwLRE+Do=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WUztehpN6+yYpzcBbefhaNiyYvKPD4kpeKaNA00lIBuPFQS7V1tHgqC+fP1x+ny+Ur9QI2vMYbLVbQabJcSeWSZLyaxIyMbVrBeVNTdv1c+mj7OnE5GIuUhVZKLbE6DboZCBi9fMZUV5g9AnMQAmf+U8vsqgarbKiytTBrzxmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lengemann.net; spf=pass smtp.mailfrom=lengemann.net; dkim=pass (2048-bit key) header.d=lengemann.net header.i=@lengemann.net header.b=h8PO8GYN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUHTxGUE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lengemann.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lengemann.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lengemann.net header.i=@lengemann.net header.b="h8PO8GYN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUHTxGUE"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 82E747A01A8;
	Tue, 18 Aug 2026 08:41:12 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-02.internal (MEProxy); Tue, 18 Aug 2026 08:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lengemann.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1787056871; x=1787143271; bh=zvL5nKUJctVEmdEsy2/gVKH37Ua2kAv/
	7iyp7J7sLDU=; b=h8PO8GYN8Z6ZbV887zxBL6+NULywGoAmVnRVK7+hGBY66nuY
	gKOfMudFGvlB4PePFQfaiCR4gYgh4svVRNsb9u0e3MbL8JSCZzwIN8APltDMYMaF
	T4+2pn90m1hZkoXdK/tXoTv4kGc1C+vhajfQyE/heJD2yrhi8MViA7sOWcBH6pTU
	IZVoF6cH6XguX19KvvhahiITB8ZYLMuE4AektgcDcYs2PUEL6i/VwnVMQrhjM0Ht
	R3pa6Em6LmFuLDz1Laf1noeRHnaE1wU6jALUdLSTDxSfxeKCbjvplTytgCrGeIQ5
	1IAzYPoa4hsiQmfuwdkZYZ1IEn/MKJhgBgfgTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787056871; x=
	1787143271; bh=zvL5nKUJctVEmdEsy2/gVKH37Ua2kAv/7iyp7J7sLDU=; b=C
	UHTxGUEMWU4rQ3jTW2GKgyBnEQ3lY7vUt1AQR5q6Z5J1h7MjeBxjg2uMVhiO9c0j
	RobmfQD1FpavsDQFcQyo+TlLDVlbGzDKsqzFGTfonFmPmb9/rwsgYgpeOrKv11V7
	ET7MYwNeebwxWYjIwbkwo99egdDTCNi3T2lXgEagdHLFHHtWNaCJLVB8KtqUpKL6
	ObpJnEn50AQuRvIBC920yfBPIRvhUcW05KsSnKZLaWh7LpfM6p6FVbczq0Eiu5O/
	EJ33noEzGUGTn+EtPheNRxh5/EdchKSV6xNjaVjZrzvRE8PAqUK5+PUdxjlKK8Aw
	h3mxzj0QHAQYWrKUCexEA==
X-ME-Sender: <xms:5FKEauW7cBXC9S4k80-Gf10jf5yUo6a7YKKMiaznmzRynjU5RuU-bA>
    <xme:5FKEalaSehJqvHwNNmxcn-rNlwCEvK_x4u83wLT0XyDAUR83bERwq9Z52JlFwpSdT
    lGmHIvlVX68HZuBTMkW_gnLAJPbXdiBa5FcAs6WybcoGD9p0j4fDZ8>
X-ME-Proxy-Cause: dmFkZTFGiAOsmRyGqmdlhfSnWGW6lbiva4cIRnS8Bui5JanvoeTsqfwqAzaN6CZ6cO1hjO
    yvWzVzcr4Rqw8KDybkGduXm+jc9esL9LH3b1HPNKFlokLIkZC6mPZYX5Ld2zVW6bpje2Ld
    9mycA6lHz/h1PtrmTCgA94p78zM3Tj8vUC3ucurqSz7UlWIzGRcsFzlB7KxoYBOwugSFcr
    u/KRvZ8vTcZ1G0+uYQ341aM0Kzou6ANZ0t04HLkafFSDsQZJ9JsVEfMH/GWd+Wu05wJ0os
    24hvRtpvibqQbzpePtkRIf4DeaZhryy6ymGXHrQCtiym7/0BSgqYxXrWoHqR5OVlIo8XP0
    gpm2QODMcybrGeE3PEvlkgZ7eh8fDLWl4Z8G7h8PWuaaORwnNwnDNqg0ucLeNTnoxy/zFT
    oz8S0kEfduCm6Dj6a3AEf3hlXXIahb3CUrM0g96pKyjRuB+259bD3kF/vT+8XXnKnI8yYP
    Dene84ISClk4TwnJjXg2nclw7VkxqRBWp21G6a01Dr1OstEbKjb40iv3uhcYU0va0j5jnc
    /kwI5rxmglpVPZsFlepelJtdPHMyFrBnvT5Ndjv69qLK2oQwvIr6htUxPo8cZxjL+4DVrS
    1uXk/pfo7jOoQGIkcbsZjcO9H5z+aKX+eh0ZGOgchxcCbQCzbaVwtbYS8s6Q
X-ME-Proxy: <xmx:5VKEar87bdTKwj3WFBXSKWSZ7V-UXUpAXct-LlFzquPaeJy0sh1r-w>
    <xmx:5VKEalgYZCWWz2u00Hrc3OMWwel9TlACl6X7Zfsa7a5dS5b5E8YC8A>
    <xmx:5VKEajej3ke4w0eJiUrySRp1ki4gwvWAIDfvl259qByzR_X75CDPfw>
    <xmx:5VKEako2uRfNjY78c6SiO-9LlpDQxf15esknvfq1ykha_ykISVoogQ>
    <xmx:51KEaszyEEN7vSmmGt09i5nTxKQzRBnc670IPBxSaare4wdeqYTOwxCT>
Feedback-ID: i6aa14946:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2331122C0078; Tue, 18 Aug 2026 08:41:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqhX4vTKywgV
Date: Tue, 18 Aug 2026 14:40:47 +0200
From: "Lutz Lengemann" <lutz@lengemann.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Lutz Lengemann" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <43bc34ae-451d-4270-84a6-bbbf8de80115@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCWADaQycF7XcCFLDgCVtkTAsndKykAWzNhPqVAKWYGzA@mail.gmail.com>
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
 <CALnO6CD9P4+e=YPdKaLfSBOk-H3_ir64pBP-qMKNNvzUNqunXQ@mail.gmail.com>
 <CALnO6CB1vJ7RtBzTUSJSfYtfH+W2MZCFEkqNWeBXbWJ2r3Pdyg@mail.gmail.com>
 <a6a9fe7c-e46d-462f-b3b0-7ae6c2d52fe4@app.fastmail.com>
 <CALnO6CCWADaQycF7XcCFLDgCVtkTAsndKykAWzNhPqVAKWYGzA@mail.gmail.com>
Subject: Re: [PATCH] completion: zsh: support completion after "git -C <path>"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Tue, Aug 18, 2026, at 14:13, D. Ben Knoble wrote:
> No worries! Hope you enjoyed. (I didn't see v2 come in anywhere, but
> I'll keep my eye out.)

I pushed the new change to my github repo, and then the PullRequest here was 
updated: https://github.com/gitgitgadget/git/pull/2155/changes

> > and --git-dir and friends are spelled "--git-dir=-", which
> > accepts only "--git-dir=<path>", not the "--git-dir <path>" form.  I can
> > send patches for those separately.
> 
> We were discussing this recently in some threads about Bash
> completion, and I think we landed on "gitcli(1) really prefers the
> stuck form, and so do completion helpers, so let's stick with that for
> now" ?

Ok, sound good.

> > I tried that and it works, but it changes what -C offers, which is more
> > than fixing the completion after -C, so I left it out; happy to send it
> > on top.  Two things to watch out for there: the accumulated path has to
> > be made absolute, as -W with ".." gave me the directories of "/", and
> > the accumulation has to stop before the word that is being completed.
> 
> A follow-up is fine with me if you decide to send it (and if not,
> that's fine, too).

Lets see if Ican find the time for that ;)

Would really love to see the change in git, makes me a bit proud that I 
added something to the one application almost all developers use.

Regards

Lutz
