Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA621D63C2
	for <git@vger.kernel.org>; Wed, 21 May 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838606; cv=none; b=CYmDAP41zVEK2efFMfZZ6NNUjafuiZcIy4rvOtMJpE1vQXASqNxD9Ie8WwPSlFximKevHOamnsWG7lxKwOvIEMOCQFMuC6zwlnOjIyEEh0zLaPpPMOm3g6xQR3yoFegOFNz7GQxLGvdCGg0YCiKJEZ9ALUrlSpjzCKlkNqLmQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838606; c=relaxed/simple;
	bh=aGdMhogMBILI3cBXR24ehiOpsJzdTZ1R3vf4C4lQPx8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BkX+SW5cR1L69Zpi6NR82w0kvPkZEfstlIhXLtcnkQpYJJmUy76U2gBX75Joh70wm1wb2DBpOsNI4qz/O6ic2HMV01+1N1nFth4pdeVOCASDv5xllk4GnRE8yaDr2iUaIah0B9ev7FFiMFWSN5HhUX9zCAWxSCUeJI4B2cHOASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=mAdDAxa7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t0Z3Fae0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="mAdDAxa7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0Z3Fae0"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E47F01380123;
	Wed, 21 May 2025 10:43:22 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 10:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1747838602; x=1747925002; bh=PyxbwsjMH8A3ZtLBHH21CkgqS5T+IYXz
	aG01w0Qv1A0=; b=mAdDAxa7bm10RqJyT1KbbKTopPcO2P0SaYcE3ISpd5Vp5f6L
	CUGNVA7sBwP3hwfRb0ws9+P3JDo+8ly4bzHFZ0ncSC58MZvmoTrtYFFtabq8zcS7
	aS07FYLeP1rBr+yQWyS94w0YL1Aju5OnIJfb/zCPhagpGaOcf9Xj5eJKhkeKQDxV
	UQ7eCQzuNwrp5eXwsEw3giCDbDZcR/eNw0trTyc9OtAqm1fhorvBkOa6oC4UfH0w
	iNkr4GTQQDx7EonSw7/T4VI45z79kZQTWipGnaYL6HNGsbdrqymFcATFucD38Hoj
	Wt4Hfivf4lvJwfCq0KNwmNhF/cT+WiW24YbVoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747838602; x=
	1747925002; bh=PyxbwsjMH8A3ZtLBHH21CkgqS5T+IYXzaG01w0Qv1A0=; b=t
	0Z3Fae0V0lCnzY0yqafzizBZva48O2d03cxZjhRxWxYfVFan2ezq35PF1eXxGP0L
	8vJbkL9abARHT95DR1v2amMGoF5qtOYwLV2qQbvyJJ5jaOGucFjHMMpc5T1bEBXf
	FLb58rCOScN5VCBiaGYx28IT+muMXSnahXd9UopJncG0h86+wfOaB9YtMW1ojZO/
	zw+yTpuu5db05IJneCLsgICZOLQS5c83E80fKakmoy6qwodRR9NOhmH0Vu1rbkh2
	Wj2oFU+Pua1Ekn6I1Kpe+kzYKf+FGiwJxgoOfzBR2qVSxo3d6RD3lR1JXgSnCops
	tDaB/JWBe81ZjtU9ZZ8hw==
X-ME-Sender: <xms:iuYtaMJfT7ScgVOuMsGShawclOLWFgwapb4QKS53LmVLAxECKmPFBpo>
    <xme:iuYtaMItouCp4Iy1OWwDX5Y46zk7uD-WSXn2ZHLWLDfPQe2yusYpPASpQOPKDj8kJ
    pljwvgwVcaIesXniQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhep
    fdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgsh
    gsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeet
    heeiveffudejlefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iuYtaMsfYrxIBKXVCAyYjS3w3rBkyrWgVDDBdXxFJK78zET45mu3Kg>
    <xmx:iuYtaJZXX_w9VLhaLW8bMskPi42xTyiJiqq-gfj_MIEijzPmZDx44Q>
    <xmx:iuYtaDbT1CtEH-4DAYi3ML3oB4egkLMYbSeeCWiuv9aA9N7YaGsNog>
    <xmx:iuYtaFAOD-o_hFJU50v3XyQR1KythBD9vTvLNTvs3-J0jF9_A83PPA>
    <xmx:iuYtaPTT7pY3DFd1UKoBNjYu1rO7P-Fx0DfGz7wg8Muawch4rxY7n54n>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87219302005F; Wed, 21 May 2025 10:43:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tcf134e764ca1e58c
Date: Wed, 21 May 2025 16:42:15 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "Teng Long" <dyroneteng@gmail.com>
Message-Id: <d4491de5-9482-4bd1-9fca-dd960a815f51@app.fastmail.com>
In-Reply-To: <xmqqsekyds2e.fsf@gitster.g>
References: <cover.1747763769.git.code@khaugsbakk.name>
 <d2b6864b7072faa2c804c98ce7758b666e11f00b.1747763769.git.code@khaugsbakk.name>
 <xmqqfrgzhzbp.fsf@gitster.g> <xmqqsekyds2e.fsf@gitster.g>
Subject: Re: [PATCH 3/6] doc: notes: split out options with negations
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025, at 15:14, Junio C Hamano wrote:
>> Together with the post context lines, it is unclear what the default
>> behaviour is for the command.  It is not a new problem, but
>> hopefully the remaining 3 patches I haven't read would address it?
>
> I guess this was left unresolved after the series, but it is
> perfectly fine to leave it outside the topic.  Somebody else may
> want to look into how exactly stripspace behaviour works by default
> and how this option affects [*] and document it here.
>
> [Footnote]
>
>  * IIRC, we made the default to strip, unless the message came from
>    an existing note in which case it is left intact; but whoever
>    does the documentation update should check it.

Good point. I looked over the options for any ambiguity but missed this
one.

I=E2=80=99ll fix it on a separate patch in the next version.

--=20
Kristoffer
