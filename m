Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD7322A1C
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282703; cv=none; b=elihLJpGSVx7dlJI/sQGZImLM0egdKIlMTjqyX8+YyTUPsgboHA3U7yZFlQAy8zMcNPsWWiSJjKOFSXCB1IX9uYjjgcHRbeR1Q/lhZ/u0aQzm079U2lRziPn6TPdoSz1ZR+ea84JBKtfq5P+q5QtvwpqiDDFAuFh/uJDTaHNtOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282703; c=relaxed/simple;
	bh=pL8fuweUcC3urAfvFgu9mx1px9SBf3JyjuqkN6dP2+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YjWWxCHcqnF2LstoO5AOUcUEW89IxocElTpYc7l3AuCRvR+oVHI4kITN+SzFWnNUpdxW42gsQGa5HU9yfs3IPxBoGz8t2/IpzhZcfj8ZvJD/oPuRqOL5I3K7sZaMys1xOWxL4860pYoc6UfYudtCazAjBuXX5yYzLEBqWp8hZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hdu8x3p+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXrgYE0B; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hdu8x3p+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXrgYE0B"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6463814000C2;
	Tue,  9 Dec 2025 07:18:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 09 Dec 2025 07:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765282688; x=1765369088; bh=L7UImQp0cQ
	HO9wLZRRk1d0957CvjAEu8+VrSyUZII2Q=; b=hdu8x3p+3kBVrODLDrVJGNZiIJ
	LOMoX/OwryDxInu5iFgpPaIaouInBmtG1KkmQ7IFRuB5gwcsDzav9gbCx20Urcbt
	IzIVCX/xBQdlsW4jht+Ixf3RZub66cUb7Y268hxQr/fnEoJYvaieXurWdZ72UXVx
	LBy52jONrfqBmE3poPA4LxJ/S77rebJQl3VbPWrcXFh7991aRHbBN74uvWnm6rYq
	hzpwvmo+oVB89lSyxN43F9R4NVgmUjxPey6r1gMQLAfrOWPfRZTtVz1KF78RCjB7
	mx4jrvmuoiezrAAcj91rGMyHoAhl2j4sNPG2C2LQ+SWZtGzxwSGUu0Fc5b7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765282688; x=1765369088; bh=L7UImQp0cQHO9wLZRRk1d0957CvjAEu8+Vr
	SyUZII2Q=; b=iXrgYE0Bsm7s0yUqTCgyo5k6BFE2ihlO2y2js1gxMeZbivkldQa
	LW48fQ058c/ACG2ctvnBbZ5Orhk3WrJa17r3cx090Mi0z2RTzStowjlWrNV4vuNg
	3sR8dhx3mSiIyM9i6iOhYBruJKg8KypArNuORMCfxpwsbK9/fQSc/TvfHoo0NRsk
	g1WRZ7mo0ZsV/1oh947yUgc42EEiWxj8z6+D3XRW6cblRaQ3ApjaA0m+1Y33X62n
	JqxLAW577R8CdO4KzcSprevoYkGE5NSBEKBawzIWofiRDESrnNbynCia/5PfYikK
	RiZ+PaRWLfCi0G1nEw/NYBEnbGY1MWXJlXw==
X-ME-Sender: <xms:fxM4aTucm7PxKAs3iXzdQkteSg7HDQ1OwVmZEFN9YbLnYEKvHMfNAA>
    <xme:fxM4aYLIc28NWKXb6UHFPAUGV6Xi9u8vB31TPPbMV0U-8CgSY4eQ0qnO4XwhYo1WX
    GIZDxH9wzHoxh0Y-VbqeAlN0bnPoa7nzqWHh042l2CgVVO-t1KBkQ>
X-ME-Received: <xmr:fxM4aQmGDFe8kooaQIzzRIdqvAz5GqzGN8K0gPhU-cTTIUKaxINIn0XBa2pRxeXkY_W5bGg3qKoZgAMgTZtc1cYRRwjm6vbfAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprghnuggvrhhskhesmhhithdrvgguuhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fxM4aZKX-pKQBrlyGFiw_bT7Lo9PJ_-XkNzYdaGnOUsvyps8RVH1RQ>
    <xmx:fxM4aV6E7XUBkZHQ-XALKbXp6yrkOk-2gz18vyXChSxzTbxY58ZNBA>
    <xmx:fxM4ad3u5bRV1tjlyK3AH3h1xfB3YdGSepAPBGa_DK4VsmaXUs-czQ>
    <xmx:fxM4abe4RYJOvJw-xFp4uxPzSkmnmUzNofCfXSAJZa_vhPO4eKgyLg>
    <xmx:gBM4aUvoZDqsoI50UGq_yOd4KD3XG5oocP7yOynyjtjvTJqythEwnYa5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 07:18:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH v2] last-modified: fix use of uninitialized memory
In-Reply-To: <871pl4vyd5.fsf@iotcl.com> (Toon Claes's message of "Tue, 09 Dec
	2025 09:43:50 +0100")
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
	<20251208-toon-big-endian-ci-v2-1-76b46763a597@iotcl.com>
	<xmqqikehkstt.fsf@gitster.g> <871pl4vyd5.fsf@iotcl.com>
Date: Tue, 09 Dec 2025 21:18:06 +0900
Message-ID: <xmqqpl8nkfwh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sorry, but hasn't the old one already been cooking in 'next'?
>
> Okay, fine by me. Let's abandon this v2 then.

Understood. I however agree with Patrick that rewriting

    memset(ptr, '\0', sizeof(*ptr) * nr)

to use CLEAR_ARRAY(), not limited to last-modified but everywhere in
the codebase, may not be a bad idea.  It would be a good exercise to
hone our Coccinelle skill ;-)
