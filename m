Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042140;
	b=024WPWS1SD/BDbSrgn3rWlwCEi+3SLoPHcdgir7evL0UBguyS7U7IhaQc7bvCjQlp9Cv
	 U8F0s8trfVoYZr4+slyIDn+kM78DLARknoz9vtVltby9FJpVdpmLqsJ9JxLLj5qsyQwu5
	 RmZuaKp3aukSUyZVf9gJ1nQwH4Ss+lJVWEgZvMZKv5ujH5vehKD7ztFiCoBGw6DTHnHFP
	 j8qlYPXJGVzdVQ/Y8EvEjpOP2mYKowSEYbfJNTiIxjh7vMyhz2piz07TvU+qbUxsU4IEk
	 d0oJs77zj6W2x+HZd0tDlp3sJCoTrxzzPS3j/BwvN9m2L8cSUFNUp6rREG5EQfXZ0EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042140;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=vE0z7qftgN98a8+nrK9zTFIXompfp2S7xQhNRJrW0xE=;
	b=QhpPCJoMheoJAyrQqT/5wW4iZSRlo0DshZdJGViQTuhVgjZw2n6N9mEYhJSLJXoamZNf
	 EZPuglI2AKKFTb72dQSPnuMDD2S4r3rygUj6YKCu0H6Efh2mGQlaAGYpIQ8SPQFFK9qFH
	 K2W/3IQwZ/52OHU0wgFSIbDBqJNuYTVk+LFz42tPjIGsalcKGlhM4OUi9E4LYqfs0tG2D
	 OogskhKHzFA84z/7MLYBoe5VCBO0tyUtO2U8k59Sva+bSArnOQ7e41B67dHEL9kzy4wZr
	 MbgWJ5vGxAW51yMtvPEpiPidbx4DiImmCBtMzDE5gIi9D6B5BpGI7iGn09rnfDRDXRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=UqY+fGeP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=evDmQgpt;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A81606A321
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 19:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15A81606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=UqY+fGeP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=evDmQgpt
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FB0A7A0442
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:15:39 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 15:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793042138;
	 x=1793128538; bh=vE0z7qftgN98a8+nrK9zTFIXompfp2S7xQhNRJrW0xE=; b=
	UqY+fGePauDLqxs3QQkY6Li58/9gO1W9NkPol0N3APLbRXFlORVTKZ9cEC0TxA2t
	iNecKJUstlh4T+6bylmNPSp7Vc7djlZDxqu3JmuOhlNxgGBv5U8/WH9QLRZlQ6nF
	zQyqNv984NJH098NT/NzEWrn3FnJmhw8SlfZOXyr7HKclEdUHsN4TVOfmLq5bKLc
	K0oD46UFhLKFmiZNkKxayIEOPylyLRDXKkpOp4SNOK3QX3PsaOdXHC4PaJCKOb1X
	J9l/m+zX7Fpgfy39IZhRSbQHr+/Yeat1vVtaUjwZe0NClOv4rHAxVsXjH+L3EPiL
	q7Asg+cqMPQb7eft7Nk0lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793042138; x=
	1793128538; bh=vE0z7qftgN98a8+nrK9zTFIXompfp2S7xQhNRJrW0xE=; b=e
	vDmQgptndP+qXAJtkxQ5H2NrWOdcLemHQzjHMXhR4ZQKp4GjcrJLH+p1CcHhKk0E
	JoF5HsJlmwDa4pnVPml6YOD4mSc99E3OzJugRFCy/0biKF8PFhSfBfs1zFSqPFYA
	tbM5QT7gvshyA8FAn6vGRlQj1MB29RC2KkVjpoF/hkFej/AJyzjmOeiWAtlPNzjK
	a5uI3vGBhi7QOQkjEEwNRudKubKLDESO3YLyVUgRiCOB1YsJm6NDr8pACCfC33gS
	2+qz7ZHYZjRGwX0FNiRejtO2WGajnf3PFj7kFdBzUMI32ntsT1ezsaj8ZPU//j31
	/wQDerQ8fwpudybk3uLgA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793042138; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UInI9s5D/8ee/t8Rn4l76108EXYQaj92am7mB1FeUsMTCxs
	MoMCZfI8lPLQhSUOXAMcOmf3+A/sHBd+DyXdh8tHxcfVL/0zXptu3i4ipv/cckE7
	yg+YXm3uPmAzBdCHMNC6QSUTCd8pPSZFT++FoBLdtK/3M1JmOZCYkLttjd2KOQDb
	jVxFkeGMJuFFrNAfIKfkVc1og+i6gVla+jOFPHNT7/2tYqzFYLaPK1zFOj+K/s9O
	qplx0HzsugmJdc8HfhBabDmVX9mIXX6f3TDgfQKdg5T79tyikQaSZC7ayACfn6k0
	qa93hCO5qLH22cZBILNx0DKEXTa+8Jqknpoc/wQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4q+HcNvtFlNLE/r0P0sfxzMEcRm9Ke8Rd00k6lJC/W8=:DlVcnkQ9UEBU4WtYqqB/UTgvssaL88VYTMfIEkMJ/sk=;
X-ME-Sender: <xms:2abfamk_NgazDBZ_gYZ3AyGz4QBfoOga25i19-jFRMAsWJcm8S4GFg>
    <xme:2abfaoopbMCXLv9LgFOj_qwgCwRPPoscsVKT-kGLDYPM-WnOhCH7l36sESOL1T3hL
    pV1eeQ29IZ7FdMBQ8Hvbrxy-CbkSlWoP7E8garsW6D2PEbIkNYR7DE>
X-ME-Proxy-Cause: dmFkZTGCwt8/qhCssCZTec0IBz79+GdNcFxpyaESQMN5ENLeePRfwXxj1qL1R/MllaAhon
    +pJ0z3A4tGdYeZYKCN0Kh8/NnunpL60oCha+Y95gWgmZs4MSeqpB2IvBxzRL3JCTzpYBJW
    FkoXsPclEPTt7Jk66VPwrwo8ZalBVnxJvz9jqON/y+cZWbQM34lWxYAgZWRIP1uUc+fXo1
    AZEQCAJZ4h/s0pjNeTEwm0+PnMCOGdbVCAVfj/x8o6lECR22G1WIfFSReZHNNSYHP207xT
    ChqqmWB4a5/eemrJSjy4NjhTvao0FFZ28OA4LEG8BhWu6oIpbcLGOEprSxNwku75Ui35QL
    S89tL6K/FMS/iF4x69zb75bLjfEGMxT/49iaDqqhRjg9zQu/++H+j8A3UB5QqntPTacmpC
    wue/DHB9rocThupgrub1wLSzh/hfOt2sZEXngarMzkPh5s5T1uQJY5VHNumSLbmEfwptzq
    kM7u3k10C+c9C2TzMC2pKjUS2esB2vQxRvwmns22Dw1G5SZSK9ay1EB9pRAbNVOM/heq2t
    ZnLNdDXoTh0Ny3ianer9SdyhOTBZfF10LAUSkOavPAJR1pN0bikqZLWTaYgS4WCGFWIJo7
    IxFtcMdv7Bduuqp2fSOwZjG6Y8/g5XZ2Mdrh3lby306BROsd30C+fNMzeMYA
X-ME-Proxy: <xmx:2qbfauL0dnEkkN30d1eQbp9hbrUfIf6xP54Qg97mQygqb9APl1Q3cg>
    <xmx:2qbfanp6onGoVDrCsiDCXiPiBLtNglTOODTq06vF5qYwDXPr9F9d9A>
    <xmx:2qbfaux-xUW64l1kTahLhCD_J6_n-KNS2ZTHdeVU9pIAflK6DPx2Gg>
    <xmx:2qbfajNsq9L5NJE1KeSJXEwO1rcQtK774vson-UVOP8GEcD3xAYc5A>
    <xmx:2qbfapVSiIDliNWBsS9b2hPgli-ej4Tf4BM9Z0cEfn50QckXFM7dqVWL>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E310C782738; Mon, 26 Oct 2026 15:15:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ApuIcoGem8Go
Date: Mon, 26 Oct 2026 15:14:53 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Richard Kerry" <richard.kerry@atos.ai>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <a8dc2d4e-bbe3-4190-b889-d9f1355e8d2d@app.fastmail.com>
In-Reply-To: 
 <AS4PR02MB8336459DD1A4537A43A5C724EB612@AS4PR02MB8336.eurprd02.prod.outlook.com>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
 <xmqqzew8wb3g.fsf@gitster.g> <60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca>
 <AS4PR02MB8336459DD1A4537A43A5C724EB612@AS4PR02MB8336.eurprd02.prod.outlook.com>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 26, 2026, at 12:03 PM, Richard Kerry wrote:
> Hi Julia, Team,
>
> There was a request earlier for notes from Windows Git users, so as I 
> am one I thought I might respond a little.

I really appreciate this, it's (obviously) very important that the tutorial work
well on Windows, and as you can probably tell when reading it, I haven't used
Windows in a very long time. But that shortcoming of mine shouldn't mean that
the tutorial deprioritizes Windows users' point of view :)

Also ccing Johannes.

> I use Git mostly via a GUI app.  I do understand that documentation for 
> Git proper needs to treat it as command-line as all the GUIs are a bit 
> different.  I think they all work via the CLI version and all that I 
> use do always show the commands, so I quite understand that 
> documentation needs to be done like that.
>
> However....
>
> Windows users don't use vim (or  vi).

Re vim: I'd love any ideas for how to make it more clear that using vim
isn't required in any way to use Git on Windows.

My understanding is that Git for Windows asks you to configure an editor
when installing Git, so maybe we could say something like this:

  By default, Git uses the `vi` text editor, which is extremely difficult
  to use if you're not used to it. On Windows, Git for Windows asks you to
  configure a text editor during the install to avoid this problem.

And of course it's not just Windows users who are not comfortable
with vim, there are many Mac and Linux users who don't know it either.
I'd imagine only a small minority of Git beginners in 2026 are comfortable
using vim.

> Windows users don't use ssh.
> I'm sure neither of those are completely true, so please no-one write 
> in and say that I'm wrong, but I think a lot of Windows Git users won't 
> do so, and will feel such mentions are not aimed at them and may take 
> it that the whole document isn't either.
>
> I'm sure I've read somewhere that ssh is a nightmare to set up on 
> Windows, so a first-class mention of it may put off Windows users.  It 
> might perhaps get a note that it's for Linux/Unix/etc users only (or 
> only-ish).  Anyway, I've been developing on Windows for about 30 years 
> and using Git for about eight, and never needed ssh for anything.  
> Https is all that I've used for GitHub and BitBucket, which you might 
> consider likely to be the most common servers users might see.  And 
> bearing in mind that GitHub has on-prem versions that may be found in 
> corporate settings.  I'm not sure how easy it is to set up a local Git 
> server by other means as I've never really tried.

I think the idea of giving HTTPS instructions is interesting.
I don't know if it's possible to give vendor-neutral directions for how to set
up Git with HTTPS, but if it is I'd be happy to give it a try. I'd love any
pointers or suggestions for how to do this.

> Vim I think is very uncommon on Windows.  The only editor that is 
> universal is NotePad, but I don't think that would be used much for 
> serious development.  I use versions of Visual Studio but Visual Studio 
> Code (no relation) may be more common nowadays.  For general editing I 
> may use emacs for historical reasons, but I suspect that's nearly as 
> rare on Windows as vim.  Something like NotePad++ would be better.  But 
> then again, it isn't universal.
>
> In short, if it mentions of someone using ssh and vim, I immediately 
> think they are a Linux user, and I may tend to skip those parts of an 
> article, or even assume the whole thing is not aimed at me.
>

This makes sense to me, and I agree it's important to be careful about
how we talk about SSH and vim for the reasons you say.

I think a lot about how to make sure that the Git documentation is
trustworthy and credible, and when we suggest using tools that are
unfamiliar or not commonly used, it reduces credibility and makes it
more likely that people will leave to find information somewhere else.

>
> Kind regards,
>
> Richard Kerry
> BNCS Engineer - Media Competency Centre
> MidCity Place, 71 High Holborn - London WC1V 6EA - UK
> atos.ai
