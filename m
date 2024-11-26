Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D5B67A
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732597527; cv=none; b=g2j8QxPTQR+SErQsOFG5XSkApf34iefexJkWHUbSN3piG6ripYPC7+c/k8f5V8YkpfXNIVfx3017u9Q/+9T+LeHs8r1ixdSTqSoBen3Qd5mPe6HIPS/S0ulfqqdLhrQDDdBXM/900lz8GtDBC8BQtW6hD1nkj2GEV/cgQhOTSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732597527; c=relaxed/simple;
	bh=Lio8KfsMF/U01nCaW0FiyjrZhlF1D7t2tcHemTpDBUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1o+NZtJcI45VRPba0SERe5pm6TQqcnmWrDeQWiUrYTOU1MMTc0FgNUGvKou7sh44WAJxZrI+DC3nDneIzD1Exjwcnu8y3GIEaGICmiBnzLBcuxVM6NFksEw+nRXDXTPs7G8cfpD4VSFXUv7ABw58DRXOOuQTITNawGdcU1F+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bW0cb6rZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bW0cb6rZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8493A11401A7;
	Tue, 26 Nov 2024 00:05:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 00:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732597524; x=1732683924; bh=Lio8KfsMF/U01nCaW0FiyjrZhlF1D7t2tcH
	emTpDBUI=; b=bW0cb6rZKcIcn44tblQ0Tqq+G0MTnI+od8HCDpDmrl7dVtXeln6
	gfzFiWIzx2qVRXUqCLo195yy6bBPEcL5xW34dHyBQlli4OTpwgHVyoHrOcmnTbyO
	P5lLIBi8ABwUv/10h37BSJOOg6IBYPxm8W5FrCxcQznFfMWiA39JY/VzK9EocYHk
	07PJnyudyLEXrXtW49m9u+6sVMmQICFgUJk+gvpCexbiZvsQ6/peMuPS8TbiGd3B
	viCqJHJOY+Tu0jrvQeSTz0UFT+CKpjvjs4npB0vfP0M01xY3FWSIKnNpJIQ3gwIX
	NZ1iqUaw/zSMl1iNDwHSDoGp8lcnkIudJMw==
X-ME-Sender: <xms:FFdFZ1h1768kKX3S5fgyyPd2LTRDnoSCXPZj53LzcZ8aMk0KtKzGug>
    <xme:FFdFZ6AieNG0T-yw4tKhHl4U7G3RplZzA8p7InfTq0O1pTObyYrWPpVYRwjFDrdiG
    BM7r1qpIyXAiAnYAw>
X-ME-Received: <xmr:FFdFZ1HWIsKm4idt19YNT7jIZXEeJbCAF3Hys9qaqCBce_PwZEuS0We9RFahT3j9bjdv_Y_wjsZWEXFEhT5hbkZYQZbqmtW8ssWEh3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegsvghnnhhordhmrghrthhinhdrvghvvghrshesghhmrghilhdrtghomhdprhgtph
    htthhopehrrghvihesphhrvghvrghsrdgukhdprhgtphhtthhopegsvghnnhhosegsmhgv
    vhgvrhhsrdguvgdprhgtphhtthhopehjphhoihhmsghovgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgrshgrhhhirhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FFdFZ6Ry8QrqOScljsmNLoJWfHU67m5UsyhYarNtrNYmYqUoGoc6hw>
    <xmx:FFdFZyzsQLlxbkxiZP3tX5RFuxE5v4ImGT61jlukUcBfr3fpbB0gDw>
    <xmx:FFdFZw6zSpZ0_QrXi-Bpmt4Tnv_j2pCfORoBbqO17idaIcA7T9-K4w>
    <xmx:FFdFZ3xiMsJOgiJSUtpoowFxI1J4JnDaEzo24QR2IL4HRmOrSIBatA>
    <xmx:FFdFZxn150Q-4_zLMxLfdGdFOIJBab7I3jOkKlM9Thr7wMiDv-V_M0ij>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 00:05:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Benno Evers <benno.martin.evers@gmail.com>,
  Rasmus Villemoes <ravi@prevas.dk>,  Benno Evers <benno@bmevers.de>,  Josh
 Poimboeuf <jpoimboe@kernel.org>,  Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 0/4] perf improvements for git-describe with few tags
In-Reply-To: <20241106192236.GC880133@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 6 Nov 2024 14:22:36 -0500")
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
	<87bjz0k17c.fsf@prevas.dk>
	<20241031114210.GA593548@coredump.intra.peff.net>
	<20241031122456.GB593548@coredump.intra.peff.net>
	<20241031144351.GA1720940@coredump.intra.peff.net>
	<CAEQVFRFWT02QTL7PTf84p6AAferijHx8L_Tu6ON1H7U=iEdb3A@mail.gmail.com>
	<20241106192236.GC880133@coredump.intra.peff.net>
Date: Tue, 26 Nov 2024 14:05:22 +0900
Message-ID: <xmqqldx61t65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So here's the series I came up with, which starts by adjusting the tests
> to be resilient to the later changes, but also to show the existing
> failure mode.
>
> And then the rest of the patches add the performance improvements we've
> been discussing in the thread.

So, this did not get any comments, but I had a time to read it over,
and did not find anything suspicious in there.

Let me mark it for 'next', this time for real, in the What's cooking
draft I have.

Thanks.
