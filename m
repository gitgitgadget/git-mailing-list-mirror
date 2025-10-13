Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0252D3724
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373772; cv=none; b=s6/bo9in1ht5vDtfp0UUy/7lumOjGFV4gS3YthdoPB8I9VExgmizNcMGvb3Y0E0wUYVURshXeH44ElNFe3138JQEX/BpTSj6ZnTmG2adp+1xWrJp3ghSnvD0lGxPoJUVXJj0dPONoxbSjUYO7FX8ltHFjXjGf7hMCdjvJetYfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373772; c=relaxed/simple;
	bh=NLTzMOD+UXRW376VhmEyelZpJgnIzHZBzdg5sp09G78=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FM2mx++PQZvOEu+l17uENXmgbQU8ZJh/BlIckfeQ7ePYQiB3TwN0/Ub+c35/XAFjQ+RW96WtUVctrpQvHYXhhVyGh4QtyPxOne7WDgxonpLH/vrZMqjSkZpvEtV0Hahq8slJNuE/a54RPT+04/cPPUmjrZ89FgtSxnEBzNccMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Pm92EEpq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gtT2aYtP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Pm92EEpq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gtT2aYtP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE7657A044E;
	Mon, 13 Oct 2025 12:42:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 12:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1760373769; x=1760460169; bh=6NfeGayrjmytB5QU9cjyJSFu79STJ9xK
	AfLEFTCM5II=; b=Pm92EEpqXVALNp68zq+rFw/U2vKKt+jVRX6miSK5iuJdCZ/Z
	8ltzx2mY3Egtci2ocxtGmssJKaOZAV9MYHbXyfxjPutgm7eq4N1LeiXzkYszdBSR
	yuumR8O5RMjOVPy9S2ypgsfjIrm2Bj4k9glNHKJEzjYzNLVw+ipTeI27pPZUhvzB
	GI4MBp+5QhaMdv53aKddcz5sj5KqTnzifzTpOKdnfdmpOa0i5O/TRWIQx6a2aCow
	mv1CQVtyIue6xu4iRvcy5DWP02kXJtRd+orDuoaNNfSw5SQho08Vg4KT/HtVYPPM
	LBfMx4Zwpwpwfg+S+6rxaD3weG4XirCsC4HILQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760373769; x=
	1760460169; bh=6NfeGayrjmytB5QU9cjyJSFu79STJ9xKAfLEFTCM5II=; b=g
	tT2aYtPxlbyjlR0wuGU4Ogjs5IEUkc75o1WINqjDHaTN5bO940o8q3fIvQNCDKNc
	7FSNlUbIJyhFZBg2URpuVZRNKdPcZ7i+TUIk6GhMm/3yqOhPdChvPplP3TAvDP9Z
	iCXHtrm+LRffypQ6BXrV0kfnSEgK/kB4f+pqujALB785287eue9a8hehohixQiwo
	QVrR7g6hU4HpMnT7XMa/KREOHuEWJ76GF7AsZD6q2d2bNTYbN6jQBlhBEAuYcCr/
	5dufT3yK7r/4CR4RlLDHD6KsrcUB+L4xPYLpn6cDc9JkoXPCo8SupvLP70zo5HlO
	s02BFOOhd9OlEXkaFI6Xw==
X-ME-Sender: <xms:CSztaCyJrxTwtopofwmzV9WAFx-5KM_VCefFwzNBrYpfSNRRjcon_4A>
    <xme:CSztaJHDGfyj-Gw_CEUdDv2B_mS1G6zwAwlmFSX74Lgrjut04kHy7FRcDk32N3NYi
    NkQ9VAn74bd01M3j7vyDfJqBy7rhvGs0pE3QmKCzYsZPt2lM_REZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CSztaBYK5FWW3f6Y6xfTOGKEeEEZRGgrq7cbpl4NWg95I-yDZKO7zg>
    <xmx:CSztaGMdkKyMu466sfAz4gdRblRlSh7fTmOUv23lVmETmpYMyOh0Bw>
    <xmx:CSztaOaqSJJN6UUBrfbVWtcHnGLJ-hgYNiq8CueLDg6Ffx8v7Gopvw>
    <xmx:CSztaM21GeE3aI2d7MPe0LW2PzGXwBWkF4rydj82hk8ltTeqG8p9YA>
    <xmx:CSztaD-_GzFy7Lw5kPyajnFe1Qz4xg-nT40viypM3awcWKVecKaArRx2>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4781C1EA0062; Mon, 13 Oct 2025 12:42:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvBFpqMSI4bk
Date: Mon, 13 Oct 2025 18:42:28 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <ccbaa98e-7223-4c75-9844-f0025de9f84c@app.fastmail.com>
In-Reply-To: <xmqqcy6vb0nw.fsf@gitster.g>
References: <978261e3be4.1760043036.git.code@khaugsbakk.name>
 <xmqqcy6vb0nw.fsf@gitster.g>
Subject: Re: [PATCH] doc: patch-id: convert to the modern synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025, at 10:50, Junio C Hamano wrote:
>>     This is part one of a multi-series effort focusing on this
>>     documentation page. Technically that intent started with topic
>>     kh/doc-patch-id-markup-fix, but I published that before I learned
>>     about the idea presented in <cover.1759873165.git.me@ttaylorr.com=
>.
>>     So this gets named =E2=80=9Cpart one=E2=80=9D in the cover letter=
 (and maybe on the
>>     topic name).
>>
>>     The current plan for parts 2=E2=80=935:
>>
>>     2. Various smaller fixups (many small patches/commits)
>>     3. Mention the two config variables in git-config(1)
>>     4. Make it more clear that you can feed multiple diffs to this co=
mmand
>>     5. An =E2=80=9CExamples=E2=80=9D section
>
> Quite honestly, this smells like making a mountain out of a
> molehill.

Got it.

> 5-patch topic that focuses on improving a single
> documentation page is nothing unusual, but it is very unusual and
> awkward to handle for a topic that focuses on improving a single
> documentation page is spread across 5 separate topics, each building
> on top of the previous one.

To be sure: I=E2=80=99ll abort the plan if it turns out to be worse for =
the
reviewers.

I can make the following amemdment right now: after this current topic I
will wait until it graduates to `master` instead of basing the next
topic on the merge to `next`.

Either that or everything that I plan to send gets sent in the next
topic.

>
>>     Why a multi-part series?  It started with the idea of (1) emphasi=
zing
>>     that this command can take multiple patches, and (2) making an
>>     Examples. But then I saw other things to fix. And they ought to go
>>     first... eventually I ended up with many commits or ideas.
>
> Perhaps then after you built up the final shape, you'd need time to
> ruminate over it and possibly reorganize to find the best order and
> organization to present it as a N-patch single series?  Typically, a
> collection of thoughts presented in the order they came to one's mind
> is much harder to judge, relative to an effort to tell a coherent story
> that moves to a goal.

That=E2=80=99s a good point.  I will rather scrap things and recreate th=
em if I
come up with a better order rather than committing to the existing one.
