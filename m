Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DF4315D
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732665638; cv=none; b=hBhdE2eIYkzk4rSv+rINSLPj7grYNDxpn/Ay7DkAejOuSakHSnMdETPN8RdxKTAFbWi2PJ1tWVEiEklSinYCugrD5raBNdlXrc2t1GwhbQ/yVQfruEhFCB6LG32TYRifuIkmS9RJI89vu3++WWYgf+OF3IWBnjD27bK79LJkJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732665638; c=relaxed/simple;
	bh=b6kSoOlPAE1biV9f/FUUmOOPy29jbyleVtu5wvITo34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZ+kUNkXT+NLJGaUI3tOXHz3e70JBv7kjMwOrg0ParL1sHHnY8JQHWJlQ33FC7zWo9JEaXibjxgpfkzva7BdJXT9NJR2nz1WsPT4qI3WlchREWD9awHD9BZRjGc9qFCu/De683wiHrgHi9e5WeHRkCrB9IgC2HgVqtCHPOfLFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4Sf08CoN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4Sf08CoN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D30C21140241;
	Tue, 26 Nov 2024 19:00:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 19:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732665634; x=1732752034; bh=zZBAp4HCnaCRuQSda9q++FgIgjrdLuGHe1p
	Rk/L/a+s=; b=4Sf08CoNgQ8rMItlf9GYjX/hxDMOJpQWgUWxl41+EXkhVc8Jd5Q
	4o+Tjuy1XvYfM58zOo6TCCGfLAIzgW/X1uUi7fmNY/tJB9+bdlA4QHccCHUcA+pa
	L3XaRUGdcgn2oKGn1kPc6lzMiGU8LnTkpDH7y/tmL5Q2BFxpEo+FXZjAUIM//AWx
	yGDalVdqcml1BXghhIGLe8nGPFW21D9Aec6riodmp9JCapSaAQg3JD27jUp6boYa
	ZSzL3M/jEEU35zx/4kEKLtUMH5msLSf5WH41WVbxL5KRgufU1CpI4f5jxz5knX9z
	CFqhMjx7w8K6jLdpQks+PTziEJUHOEMZDsA==
X-ME-Sender: <xms:ImFGZ8HvH3r8pnrY3ha4zMTHXc4d-sNXB9l-huohnE5dh_BbdKJFHQ>
    <xme:ImFGZ1WX4lzfiqDxNVUdY99P201gUZMv16JMhCO7HdL6kxyC-vB1hZLydgYrSgdOR
    Gcq6I14U4fxvnIsig>
X-ME-Received: <xmr:ImFGZ2IlLVCkKO5-dWrrFA0iNUuJUVsCJ5-sKyoyE187QX_wa8gUsuvKsep4v-PEMbx_td-5pnVYP1O-CSJQ3mABSwNlieAiS1XQEB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeekgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpedvvddvjeehueffheeludduiefgudduteefteek
    ffelteeileekgfeuudelheeuheenucffohhmrghinhepsghrrghntghhrggslhgvrdgtoh
    hmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtth
    hopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepphgssegurghsqdifvghrkhhsthgrthhtrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ImFGZ-FiCmphZMafwPS1meG02Ae5ugRjvePk4FNOL6pHlMegfpX_rQ>
    <xmx:ImFGZyUE8vxWLqHp6HbQ9Fd2nPi9QVacCcT6157iEuQIeJ6hJXsqAQ>
    <xmx:ImFGZxOex4tn2U0J2hzupL1u71LOa6TtOa5Cd6vOUZ33VyMg9yRA5Q>
    <xmx:ImFGZ53xJIL_wpo8Ka8gYKgOWlopWgaO2ofhqHhnJXnn8U2K-RkiWw>
    <xmx:ImFGZww3dnzadntWrRtD-2wzX-qOekAGOfcgdgrfcvdRP3ljca6MbcnR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 19:00:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "Peter B." <pb@das-werkstatt.com>,  git@vger.kernel.org
Subject: Re: git support for "xattrs" (extended filesystem attributes)?
In-Reply-To: <20241126224124.GB77402@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 26 Nov 2024 17:41:24 -0500")
References: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com>
	<20241126224124.GB77402@coredump.intra.peff.net>
Date: Wed, 27 Nov 2024 09:00:32 +0900
Message-ID: <xmqq4j3twnof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> There are some third party tools to save the information in a separate
> file within the history and restore it on checkout.

Ah, you're right of course.  We are extensible that way.

> I haven't used them
> myself and some of them are quite old, so YMMV:
>
>   - https://etckeeper.branchable.com/
>
>   - https://github.com/przemoc/metastore
