Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689182;
	b=0af23w182arWGOmWczsaoGMhEP/+JrePjvDOAWgNEScunw+K7gvB6ZVTcoJqQpkCdpFT
	 fRVSnQ/7mV01Jy1jyN5bH+6PwtxVLKWdsc5Q/SqAJg1h4c21H+S+qEFIr8x2k4f6qV4Bm
	 qyyjMrcLX/HCh3xCYlSAPVvkFOYG1r3lEcaBd884yRfhwZB7XzRCRrosvXLKLNOlg7qUt
	 NFlS35PweCH1qoyZkX3Ob+Dp2J2+caXDyDuInmy8R6tT8h/4z+rTkBZi4YwPslmk/clKx
	 VX9xIirt2tJgmohgdGvsdPA5Ch0nzUwi1iSbLvr4ttco8wC4mnWaa4iTxmuB+L89ohg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689182;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tE8Y3pFm1wcxCYrvIx/zEXJUIfjamAaCmAwxz5yukD8=;
	b=HMnrAwv04Z7Y7dXARYzliUNgltS+YhwhIgYIlcijD8yBICJVPIG/OC7oyVQfnc17BXcA
	 X8f1QFW4HJr6jPAolrZ0tzEZV9KVQcqqkLbEcTCy4fj/BnZmMqXHBXk2rQspmp8HRsmSe
	 OGj+Iwpq3cRStMa8jvN/VI46NBuMlrml55xcdvdr8mJXkuiS6CCVYN22yWJX4WQIB3XeW
	 Po2cYxvPysPF9jycELPFagFDM6+3Gf9HvMUedol0W18aNs38Swb+b4XDErto63Gj7yHYl
	 QNUBU+994c7KtJ+NtZdoGdiuYyvi0B4hOjbjfGJlxaQ2doAH2O48mKLMBOE3To+CNHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=imciL63m;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IA3LoLLW;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2B606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 06:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88A2B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=imciL63m;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IA3LoLLW
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CE607A015F
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 01:59:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Nov 2026 01:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793689180; x=1793775580; bh=tE8Y3pFm1w
	cxCYrvIx/zEXJUIfjamAaCmAwxz5yukD8=; b=imciL63mIht2tWP/BHgve+pRwN
	Byo6X6qr9hZ0Q4RwzscEij175H7dNIgQ+InV6x2KOc/n8v1DbjIY15BxxSD3+Okd
	CkQYN84z9RVvY8ETGiUV9PR1sujhAoGloJgpYtigZlyeTcs6uRXvab/tbggwlV/6
	DwGB4HN2wf9ii8ZJVc/sN2LFX/dU07tLhotRtqOZqUWwHVtrUWnSMzy55rzW126+
	K36aPApQGW0nBdkdJ8fDhWMVtJrbAyoMPnOn/Jc5qDsXfMAcjamedMqff9Xfe7Y8
	34rjXutdIW/tL80WPnehbuHqm+5ORG09mM+9mVuRjCUg9RV7QOvXpqVp9jvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793689180; x=1793775580; bh=tE8Y3pFm1wcxCYrvIx/zEXJUIfjamAaCmAw
	xz5yukD8=; b=IA3LoLLW2f5jtpdGfO7LjfovEPF8DlATrzA0hwYr3WsZXjS4vgM
	vhrKQdaci8CXzVV9nf/ZNiZGIUyqgYUzjwHa1R+RtTonXgaFDZdeJx6pJLGIHPNE
	V7OXFwINAFKoFv7h+MkorRhfl3Rw32NvPfVYfz3AYADnuehSjjx0QB2rOHX/5oWi
	jhh6yifa2eKXdbx0l4qwzx9T5ErpjbiDsAhoSmPDrN4FgvR+hliYio/4POEUOnry
	utmjFiWfu4I3y6qjcF8+gkzJE0c6zIwDleHNpM332YxCOR+v0y69VmRbepiZSTsS
	T45tvvdDKKAapApdtpoAPBndVF1BNPW/43A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793689180; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:utsKuHbK7uJ+ahiu+e3ggKdTNp4nUfTqRvQbQ6wpEuw3zcD
	R8nM6hMKH/4xcVcvxYFXlPmXrFfrWFkud4afSc24NoSPEV70z07sRTrpUVxdCghg
	hGXsJpV7vDjotBl+XNn+s0sx8oUFONL4v9+4OYUnxl76i9FGo9ej7gB3ma8HOQoR
	aKFmS/U9Wwy6ELsSHCJ0tPk3LRJCX90uE7c+ZnUyb8KQyXrITiGg6KOHYcqv2Cbj
	7yazeiqj8UD552jfNlcBQqrGAdfTGiShD9jkQdDQgHh1yioyWQnFM88LonoZ51Uq
	HVoizUYOr4b+T85kPOp2hqQu8yacQptmoOduZ5w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AXXayiZV9jzpemOQJyPgERTljw7Tk7AnjGFo8UOjEIA=:hPg2BvRXHNCO/gWupdBX3GRgSCdbNrZqoMhoKRFBjgs=;
X-ME-Sender: <xms:XIbpao2eQtXSxY87hbXTXiHhc2vJeriPDSZ-cAR5kGpw9aYxY6jR8Q>
    <xme:XIbpamxxPQ-HPGayze_TPUAgk7bSqF-RYRxjXgT0tVFnExN8udTFIBFfDG_hMSHkI
    cVOjb-XaTtwyAH86y_mQHQnkiaMNIBbuJ32ZwBo4knR34FddmPqEQ>
X-ME-Received: <xmr:XIbpaqutYzG1Gg9bmRjRaPXYXRQm_DaCKDnHW8cFptsreeBwNPxogg>
X-ME-Proxy-Cause: dmFkZTFBhgGgNhsYcwAimRbtfIT2erpjoR2bQFHRwCzwPmH4WJCfDkDxBuyk61DbC9gIqs
    pbDZMXy4chJxHuhmvwXcZK8vJWitVesPkQ66vGAa47xcrkJra8bdNxRQH2bfH6pONgSUJP
    RagT1UWWrTE2bNEIPjxbRXo6gfnWhuxdFItUN+XpZnuEczpsbk6Yy0qk+Gxlffezbd4Goi
    /PL4v4152OY6OR86cegieBhuUBqjl5f0sVti4lQCMB2l4BomOGA7fmaBGC7RARiRnEov5c
    Y0ArLyevoVuiCnqFuo+QxYOVmmGhWkx0BmE6DS2Qz0X2fzduFpRKlek64JDhVc1OWGNjSE
    U0Cl1SMRzwuujdxBE1MvvzOAMdnTCmvKSMTm5WdhU/R+A/liGMGICv0Q9R195MnpXTwZNE
    qCsoNspR8WAbyuiZHNBLUANLd7XgCFkyz7CGrZBJeUavbWva4Ri0rW3GjQI2cuO+d9pnxX
    44l/GDcb76JziE3ogMYpvoRkzQqT9ISWliLmvxM/UsGNMF4skVUOApJgvI7kTa/F76JSHD
    r7GH8kpInJLlIq4CxJ8ujqU0dm0VJP8sdSGD/WdzEOiMeMfD8sYhbTIEFYarUIJIQCOnwz
    Ob+n44BYkb9vrC7G/hx09tX5WDRdiJw3rE2v2iw6U5Ddq3kfxQcF/h5225sw
X-ME-Proxy: <xmx:XIbpaowDCt3a-vnJ8lS76pOxfl_5We2QOALgnSINoAl2zQD_vxh3Ew>
    <xmx:XIbpatAZ-S8S0AizcC4-zELcpLOoGPeia8yLvq8MkpYYOGz7qqxULQ>
    <xmx:XIbpamf8MPXk_tPoayQOCYhdrJ8AbarnfmJpwaihkoy7p7WfLRouow>
    <xmx:XIbpanl4nHfa_NenH4jdpNmgrMgeM3YY1azMpb_s4e6FSMebWYtWcQ>
    <xmx:XIbpav_pr2vwi2ZHQmb0L-hKwb8yxFD8H-REZ8sv8ELCe-Azon9hL4Y7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 01:59:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7682cf85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 06:59:36 +0000 (UTC)
Date: Tue, 3 Nov 2026 07:59:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] convert: use size_t for text statistics and ident
 counts
Message-ID: <aumGVZKfsCvdZ1T4@pks.im>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
 <cover.1793352943.git.gitter.spiros@gmail.com>
 <84e9e38a3e63a2b135847471a13ea36d37bd64d4.1793352943.git.gitter.spiros@gmail.com>
 <auSDKKHJONZjx2LX@pks.im>
 <20261031101619.172770-2-gitter.spiros@gmail.com>
 <auhvUm4VwXyWNhsE@pks.im>
 <xmqqzevrgfb0.fsf@gitster.g>
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
In-Reply-To: <xmqqzevrgfb0.fsf@gitster.g>

On Mon, Nov 02, 2026 at 12:16:03PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> You're completely right. I used AI tooling to help draft that commit
> >> message, and it definitely shows. Fair cop.
> >> 
> >> To clarify my involvement: I review the code, check the cases, run the
> >> tests, and take full responsibility for what gets submitted. But the
> >> wording here missed the mark. For v3 I rewrote the message myself,
> >> keeping it much shorter, focusing on a single example (lone LFs), and
> >> dropping the heavy-handed explanations.
> >
> > Sorry, but is this reply to my ask to proof read what AI generates and
> > make it sound less AI generated repeating the _exact same thing_ that I
> > just asked you to change?
> 
> [*]
> 
> > To put it bluntly: behaviour like this is what will make me ignore your
> > patch series altogether going forward. It is frustrating to me, and I
> > only have limited time to spend on reviews. So I will much rather spend
> > my own time on patches where I don't feel like I'm talking to a meat
> > proxy, because I'm a (somewhat) social creature that prefers to talk to
> > humans.
> >
> > So please reevaluate what you are doing here.
> 
> Sorry to interject but recognising the name as a rather long-time
> contributor from the pre-AI era, I am not sure what answer from Elia
> would have pleased you.  Instead of saying that the initial work was
> done by AI, and that the human involvement was to sanity-check the
> product of the machine and tweak the messaging to reduce the
> machine-generated look, what do you want to see in contributors who
> work with AI?
> 
> My question is not specifically about Elia's recent topics, but
> would apply more widely.
> 
> Also, I had hard time to parse and understand [*] above.  Did you
> mean "I asked you to proofread what AI generates so it sounds less
> AI-generated, and yet this very e-mail reply of yours is doing the
> exact same thing I just asked you to change", meaning "the message
> I am replying still sounds AI generated", or something?

Yes, my issue is that it is still obviously AI generated.

> Thinking aloud and letting my thoughts wander a bit.
> 
> A contributor lets a machine generate a solution.  Then he reads and
> understands every bit of it, writes a description of the solution as
> a commit log message from scratch without looking at the machine
> output, and from that message writes the code change from scratch.
> It is more like using the machine output as mere inspiration for his
> own iteration.  I would imagine you do not have an issue with that.

Yes, that's totally fine. I wouldn't even mind if they didn't rewrite
everything from scratch. The important part to me is that I need to be
able to recognize that a human is involved. But especially AI-generated
messages have a very uncanny feeling to them, and one is very often able
to tell them apart from a message that is written by a human.

For code it's a different story: AI is very good at imitating the style
that we use in our code base, so my take is that you often wouldn't be
able to tell apart code written by AI and code written by humans. So the
only useful signal that I have left to identify whether an author has
invested time thinking about their changes is the prose that encompasses
the code change.

To me, this means that commit messages are becoming more important these
days with the current capabilities that AI has. Commit messages are the
one place where the author can demonstrate that they understand the
change they have submitted. So when the author submits a message that
"looks AI generated, that sounds overly formal or bloated, that looks
like AI slop, that looks good on the surface but makes no sense", then I
will push back because I get the sense that there was no human involved
that understands the changes.

And that extends to messages that get sent on the mailing list, too.

> Now, which part would we find problematic in the above sequence if
> the contributor "cheats"?  Perhaps he scans the machine output and,
> without understanding the most crucial bits, can still describe the
> outline of the solution from a superficial reading.  He passes the
> code along as-is, together with the description he wrote with only a
> superficial understanding of the problem area.  When the patch gets
> submitted, it would not look any different from the work of the
> earlier contributor who used the machine output as inspiration to
> write his own solution.

The pragmatic stance here is that I find none of that problematic: the
moment the author can prove that they understand their submission by
properly describing and explaining it I'm okay-ish (well, assuming the
code itself is of course fine). As said above, for many submissions it's
almost impossible to tell apart code written by AI and humans because AI
is able to imitate coding style quite well, and consequently I won't be
able to tell them apart anyway.

Now there's of course nuances here, and I'm still quite concerned about
copyright for AI-generated code. But especially for small contributions
I hope that's not going to be a huge liability going forward.

> However, if we later ask deeper questions when problems arise from the
> change, the latter contributor may not be able to provide as useful an
> answer as the former one who understood it deeply himself.
> 
> But that is something we cannot easily tell just by looking at the
> submission, so ...

Yes. The moment they cannot answer questions or where those answers or
the descriptions of the change themselves are very likely written by AI,
that's where I start to question the submission.

Patrick
