Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712EEEC0
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811792; cv=none; b=ROZlP2C7YIidyjLIGxSIq6lFzihct0VW+VF2shzSiWQ8AdDbeKFoct6g7amv5fQmn1SvUgWxWHwNKmYGtMh7ga2AbnqRMUPMlVs3JNYioDMbrArdTb1nmkEtQl3seWGbPEmrFR+kiamuiiaEKm2IhhgwH3TxfIuE7M2Yb4eMfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811792; c=relaxed/simple;
	bh=2exQYaE1VeAmhPh+m6grel+zb5f8Tm+bbXmXl4Ir8q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuww0JIu17YyBv1HgDSbc2BcOb5GnYy6H05SpsrErl4mCQ0BrtDxHbN0b4aFx2gWOK8DTmYwiD32zimLmVfsdt0E7+54BuFWZvUeP+6F7OT/REGbqB4XaKxS3CRP0rbZsnnGJtEu5a6CCHWV86abKMzIQBAiWe/R0duaQZnpcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eG2jGo8X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N4bwcN4t; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eG2jGo8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N4bwcN4t"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 557AFEC045D;
	Tue,  2 Sep 2025 07:16:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Sep 2025 07:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756811790; x=1756898190; bh=8axgvb3qDQ
	l/n2akT8dszHd0/g1bBdfCIQfCKAAnVeM=; b=eG2jGo8XukDqIGU3Q45P7+0Tfg
	n1Ly2VSU7YcbpuuVAUVXBxCmcmv+8qN8beepTyNgtEb126cURB0hegoIKPLzkxxh
	E8vb1aoaivZdba2DUKQzjkcg85yQNfWEL6mLXIi8/XqVgoY8nMhDqOKW6d95HUI8
	r7pebBwpx0GRsz22aTitF314Qkyz9+9+nqpL5eP0KYSajqeWk1xlxisfpqhVkY5G
	sI7a4/ckpb0dAmpAAe2sLWu+gK68IHraEP4QP1ExF22R06bw1Dau7hx0Q14GyQRF
	WaAJLX/EPKtRw/BKgoEeuDPCzB0BfDKE7tceKnOjDkprhVo2H1V4la2rxt2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756811790; x=1756898190; bh=8axgvb3qDQl/n2akT8dszHd0/g1bBdfCIQf
	CKAAnVeM=; b=N4bwcN4t2k86O6PJLXLAlGESaKJ2LEzsIvQct29BuZJyzp/Usty
	QDNQg9RdgOa78Pq2uX9hpemyW74w2Q5RjozuOtVpk5XqL4a7o+WT8epktZhRtlEL
	TPV44zFoC+6wlxYaT8AtqBbLlh29bmVd7ra8MJMzNN3+pQBnadp8RVKUc6IJEwUi
	i7+xcpOVx1xnnFcQg0reF1mIS1cVLNNq45oHhUWAgXEtq7Mlsj887Orhe2TwJxjY
	xfB1IsyOo2WlDiW0D2Xdh1iKbMPy5sWcYeqSTNtOaqzPEbFl8zSRWeMAa067zwC+
	Aoei4Fxassm1YC7h2reB14CYE79oBiiVx1A==
X-ME-Sender: <xms:DNK2aP-rORmFenf99EZ4tA7VomdwVrEj3zVsqw6Vk-vnCfhYlmCfaw>
    <xme:DNK2aDXO4DbRjWgk2_v2HwXby3sMXronhlTYOBCeR0NpMQsDtCmCk6XAWh4ihPoIi
    hekm2GBD8dPRXPcQg>
X-ME-Received: <xmr:DNK2aNNxoHt9sASUd9BpYxKdrYzcDpzX3a_U-jSrCc6N0VMsDR2s5ONa3ZAxHn52maii7t3RWUFR12q8EibeXV0jEOkVpLPkaYuto16YqDM2cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevke
    ekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorh
    hgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrg
    hmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdrmh
    gvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:DNK2aDfu2Rjmj49WgydHnutcamIe0Cjpoc_C19QxgfjceXHtcg785Q>
    <xmx:DNK2aEx-lXNmtxOKV61rPLyM1VSch8wGqfhczW2k4NcfxqrQTV60Zw>
    <xmx:DNK2aMiqKarByKypAT5q9pNvYySx7rVv-Y3yIkPBrkyWVm6O0FggWQ>
    <xmx:DNK2aJ5a3sVM_AwSVsIipI_1mPdrhX9x6DN2DpUDOdGd3R9izmuWVg>
    <xmx:DtK2aMvF6xbtVwnxt8iw71nRHdXM-swfNXebaKZ8oVd6-VhTk1rZKM4H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 07:16:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e579995f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 11:16:22 +0000 (UTC)
Date: Tue, 2 Sep 2025 13:16:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com,
	'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	"'brian m. carlson'" <sandals@crustytoothpaste.net>,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aLbSA5KsBdD4wW_B@pks.im>
References: <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
 <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
 <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
 <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
 <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local>
 <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
 <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5xszf91.fsf@gitster.g>

On Wed, Aug 27, 2025 at 01:22:34PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > (As an aside, I mentioned in my earlier email to Randall that I have a
> > suspicion that Rust code will have fewer security issues than C code,
> > and so the likelihood of needing to backport a security fix from Rust to
> > C seems lower to me than having to simply patch old C code. Time will
> > tell, I guess.)
> 
> Just like back when scripted Porcelains were rewritten in C, in 5
> years, when a lot of the existing C code is rewritten, who among us
> would care to backport or "simply patch" old C code?
> 
> This of course assumes that these platforms that lack Rust still
> lack Rust after 5 years, yet still matters to the users, and the
> vendor does not care to support Git themselves.  Maybe one of these
> three conditions would change and make the problem go away ;-)

It will definitely require additional maintenance by us. I think it's
reasonable to say that platforms without Rust won't get new features
anymore. But when it comes to security fixes or significant bugs I think
it's less sensible to say that they're left on their own.

I proposed this in a separate branch of these threads, but we could
counteract this by declaring the last major version before we introduce
Rust as an LTS version that will receive both security and severe bug
fixes going forward. Ideally, that LTS release would continue to be
maintained until the gcc-rs backend is ready for prime time, which
should alleviate a lot of the portability concerns.

As Pierre-Emmanuel menitoned in [1], the backend is likely to stabilize
next year. One or two years of backports for that particular LTS version
doesn't feel too bad. And if it does become more involved we can maybe
also distribute the load and rely on maintainers of impacted platforms
without Rust to help out with the backporting.

Also, all of this feels like a significant shift. I'm strongly in favor
of adopting Rust in our codebase, but I think we should do so carefully.
So we might take it extra carefully and say that Rust will become a
mandatory dependency in Git 3.0, where the last release before Git 3.0
will become an LTS release.

Patrick

[1]: <7bf054a1-0196-4ad8-aaa4-a432cd2c93a5@embecosm.com>
