Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E638756A
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739251; cv=none; b=HWHAiqvXrKs7SyaxyMRwc+pygtMmCmjDw3aB+mlLYpouElMwDL889NongBK+akbv+yyo2EbH3EntLevA14+EwSOVf0sdz6FvsY84tYn6ApKilNNBsqYyJD5M9f1rKoUqqej2iLN3pIfvvtVX2OP//77E/HIFjSebTK0WgfgfWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739251; c=relaxed/simple;
	bh=rA1pp5olzIR96OPDo0/DFHkSQOfbbsuAjADnpfIH7TA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j5HZxGOoQBTVVYl/MexP+VDfCtVKg8HDOMW5ETaq510UME0ta0wFqLqAtg0AktYqsvqBNglFd8IEJWNG5DNU6YpXtR/hv+4ZeHWJgGGNU0ZzC5Awyegq5vDZMuWJ/PTmY5E1vxhvdrr3DvMjz6OzH36s4SyFXBaIcamlx3ZPRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=fDLewJk8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j+IgioXW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="fDLewJk8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j+IgioXW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 055187A01EC;
	Tue, 10 Feb 2026 11:00:48 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 10 Feb 2026 11:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1770739248; x=1770825648; bh=IBdL3ERvqQ7GygNnyMjFP3lDzLIVlW7f
	a4XgQVc4gEQ=; b=fDLewJk8GV6Cg3YWssnyeSxxvxUgcCLuhlNLS+iB1TmxbAbH
	G3mHZYwXBNKBrUUep22Ea+/JXL2wv7kWa9iM2VJ6T0kmQnW52j14Z3o85RlMc3XD
	2IJYOF3osjX9lZZwWQkOeLxRKYWL3vdxad5s20Y+bfYRfDDBwBZcDI4obL+jL3GY
	tvLkiR9vi25PKslrFuTOATcTODLZXSuGNgH52+Dg6pbD5KYHy3DcIUbUQoe/jaS8
	beqZRRTUnNKbsGXbfmf5541EfJw7uaxNuWSe0HciPTT+lnyWmbrYCFGHYt/WOjIK
	7tWBnr573wzfIFLIJ+n/xu+hbkCGHYjKwGuc2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770739248; x=
	1770825648; bh=IBdL3ERvqQ7GygNnyMjFP3lDzLIVlW7fa4XgQVc4gEQ=; b=j
	+IgioXWr1Cx5ohztbGdjK6AsuRb+wVNpA4mqVlvsZuYyK1trYi1rmY9U5qzXeSdF
	EdOfI1ERkW39909lyi0d3QoWL3t137XZ9W3aYZQdzBVhDuabdRcnNUmXpvmLNXx6
	DsQGjQKrQ1UfVSrmINdqmaNUPS0V7pdXkpc6XYl7y+iGwTLJmBs1gyi4+K6Ueyx4
	BTtPPlW/3GhsnoETzOMqGRHge4vGetzv3mupRZrMykFHz2TKuIHOJEuluUXQ2C2U
	tKwa00tjyoEigGqlf7EAlzA4rl3M4N0MRcLyCDGMfnY456g7zk269l4WVW8PjvA2
	We3Lx6YkudtkkjPZ8+oGA==
X-ME-Sender: <xms:MFaLaYeWavFJsME_BL-2CVYmRH2v3U0fIw6MUUesvB6TIA4x7rqpbdg>
    <xme:MFaLaVA1oj9kgypYE1dlj5vbYKYkYNpkaTxnXHk1yKz11-ebRaVoNTHj2rND9qcm1
    rrZi4JGTRzdy2m0WdMIBb2hqhL_MPBujdV5Jfk-m8Z55splig5JkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhessg
    gvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    seguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhuughgvgdrphgr
    tghkhhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghthhgvuhhsrdhtrghvsg
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhgvshhthihosehstghivghnthhirgdroh
    hrghdprhgtphhtthhopehsuhhrhehrsehsuhhrhehrrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MFaLaSsiTA7DyByzqxoaFgutgCXTIzf31mUcRz7t3BlKyXexdgLYIg>
    <xmx:MFaLaX7kYlivO0_8diRbtZ__J3khtS7bMbkaXa4TcNjnbokO2olEnQ>
    <xmx:MFaLaed5kyyvBJOkxCDqwtk4M9ygMx79034CRZYxD-lxYQU_auHftw>
    <xmx:MFaLaUxYEKVcLCuMMm1ns_HGdVhFW2-H_BNddV5Pe2V_0KAA-EyzyA>
    <xmx:MFaLaefBHW6TcFvtD9h4zVgXbnDusyDTK0BHLyznp5uS-DuNkOsjqn_9>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 380F91EA006B; Tue, 10 Feb 2026 11:00:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2LExlyUAPtc
Date: Tue, 10 Feb 2026 17:00:26 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Phillip Wood" <phillip.wood123@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: "Matthias Beyer" <mail@beyermatthias.de>,
 "Christoph Anton Mitterer" <calestyo@scientia.org>,
 "Matheus Tavares" <matheus.tavb@gmail.com>,
 "Chris Packham" <judge.packham@gmail.com>, "Jakob Haufe" <sur5r@sur5r.net>
Message-Id: <64649b1c-d3c8-42f1-b176-27f3fe8b6e46@app.fastmail.com>
In-Reply-To: <7e6a19c0-332c-40dd-8aee-f6dd9324bcfa@gmail.com>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <format-patch_caveats.281@msgid.xyz>
 <bf5d1e84-2a59-4e1b-a524-c8b251dbae70@gmail.com>
 <c70adde6-e3db-4a46-bb29-a19d7aba8c7e@app.fastmail.com>
 <7e6a19c0-332c-40dd-8aee-f6dd9324bcfa@gmail.com>
Subject: Re: [PATCH] doc: add caveat about roundtripping format-patch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026, at 11:57, Phillip Wood wrote:
>>>[snip]
>>> Is this last sentence referring to diffs in the commit message being
>>> applied? I don't think there are circumstances where the patch itsel=
f is
>>> not applied correctly.
>>
>> I tested with a line like
>>
>>      Index x
>>
>> Yesterday and got an empty patch when running git-am(1). But I couldn=
=E2=80=99t
>> reproduce now. I must have made a mistake.
>
> Oh, if you use "Index: x" (with a colon) does that mess up the patch
> application?

Sorry, I think I made a typo. I did test with something like `Index:
something`. I=E2=80=99m pretty sure I did...

But now I=E2=80=99ve taken the description from git-am(1) for the
delimiters. I=E2=80=99ve moved away from trying to explain each case.

>>[snip]
>> I don=E2=80=99t understand? It demonstrates a markup for code which d=
oes not use
>> indentation.
>
> But I think the markup is a distraction from the problem which is that
> the diff is not indented.

I=E2=80=99ve dropped the code blocks in v2 since you don=E2=80=99t need =
a code block to
show indentation. Or code fences.

> Also calling it "Github MarkDown" is unfortunate as we try not to
> favor one forge over another and many sites support that syntax.

Sure. I can just say MarkDown code fence. Such a code fence does not use
indentation so it=E2=80=99s clear that we are contrasting with the MD
alternative of just indentation.

Thanks!
