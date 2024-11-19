Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0AE33F7
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984883; cv=none; b=Y6okFiU4fzK0khXVPondogob2lRtZq7SWebBBoU4zbdkT6LpE0HfdDAZrdXldHQvX8Y/7gCPGo7ou1ipOWwLm3AylZmLsxndSz8m7Sym0+2agNdrdRDrid5uq2eqhY4kZotNGUWpLQyOR6YtEHffP77rQSQLd5A5zCyTBr+dri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984883; c=relaxed/simple;
	bh=ceZJVasX1sXsU8mho5WKFvWxEwtS2rjQQP+F5Y24YbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dtO4FFMchOeaUNy/VriQpLd+X6FYWrw75/5u4OkhTswDq6SrPrddwTMrcj38G925loy+PDtA6U88X8Edp/md5ukvBJm4Hll5A7eqnTFOuU8D7hPPs6ZNAzxuDu15WBVpsulOdZteu9AVGlAQb4hRYTMb8qEOD4wpljd5q83al7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YblvG3OM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YblvG3OM"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D781C2540137;
	Mon, 18 Nov 2024 21:54:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 21:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731984878; x=1732071278; bh=ceZJVasX1sXsU8mho5WKFvWxEwtS2rjQQP+
	F5Y24YbY=; b=YblvG3OM+0o10R2y6FjCMbWGGQzeAw8Bbkl0xkFKJ1yq+qZuj9j
	hj3Al4BRATvsTQz5nqXbz9CMT0dKG29SgVX913/MCBzN1WTQ9QVrAE4a/2C1w0/H
	iPGrCk/Yw3w+3rjS6TYUpsCbVOY+cTaab/9kUIn6x31/wcJ1dCL+1Y0BLBt6a+Fa
	JBXxh4r1wpscwtroXLdkAqUFMLSER+91qdfdIBf56HJQkXiAgVNqYmUZn4dQzzle
	DYp8Hgz3+tAt8efxYhiZ27UfEfab7iHbZBwnI9ahJdqiBA6E8foKOmFipeePVJqh
	2eSFBI0pDV1IVI47WDpLhK/4pQ46d7bVJew==
X-ME-Sender: <xms:7f07Z8r46havSKNQJq2TBhmckLX8DN4KdrUCprBCzOq-gLPv0_-pTw>
    <xme:7f07ZyqGv6tNS-XANMUC9f7dXOKixYlSm4FkurNZ2mWyws9C7fsD-oRoT3PGVyF7r
    BheUWDdZv0Jv4Dj0w>
X-ME-Received: <xmr:7f07ZxM0LkWfLBWShvep9wEYTxBzRlQdfa7mrqTM4wN1INKqovp04KMvJOdnWE88Vwi9W7Fn3dL_Ro9S2WR6KL5Kfdy3eUAzuzVb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7f07Zz6q3LehlmOJuMHWykQ-ANBZRCbehcKQD9WjE9dQqx5TbH2hAA>
    <xmx:7f07Z770U3slMU4nzYfh9eDm1rZFKoKsj6bh6AJptLElDDREhX4-hw>
    <xmx:7f07ZziFsNSfVAYgJ6vCFRLNa81tyXtEEj-6qtn9BpIwA4wg0tS9sw>
    <xmx:7f07Z16aFvliTPD3uYugyF6sMz1jpROweB2EJ5oT5LvQmQ7jZoqSGg>
    <xmx:7v07Z4HWiOkz2xhr0FfHrQOHYQQaXc0A3FalAOv-p70FDbb3na63wNr0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 21:54:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v13 7/9] refs: add create_only option to
 refs_update_symref_extended
In-Reply-To: <20241118151755.756265-8-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Mon, 18 Nov 2024 16:09:26 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-8-bence@ferdinandy.com>
Date: Tue, 19 Nov 2024 11:54:36 +0900
Message-ID: <xmqqh684exw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Allow the caller to specify that it only wants to update the symref if
> it does not already exist. Silently ignore the error from the
> transaction API if the symref already exists.

Because it is not even an error, from the point of view of "create
only if it does not exist", checking the current condition and
finding that there already is one, this makes perfect sense.

