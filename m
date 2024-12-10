Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880A1A2398
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832815; cv=none; b=GqZnqDqYe2zw8Bm9YA+uISeeQnw/4Oibf4GJnPf0qnv2sQk5ucFhjywRPQgrvojs+VFd+7/+BGkSUzXaX1CjESSY5sYL9T8fxpwWmOAaU32sqTo7E76/K3gsSHQG7dGu/4BPZPcCGZxhrgEOj3ifvAWgizpter3MjaFz6nUtnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832815; c=relaxed/simple;
	bh=EJ/dzygDHrnYB2egmxgH+zcEQFOFkkDYQ9Lr6spcORo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cXid5swxqFKlwtredJBlBuOosFpZZvPkdK6kBMX5Z0R8HehxEpUjp8CLIx4Mkb1Pmq19oDtwJAVVDvvSo9/oQBsLWLPYNixrDfTZ8mSEp8C1z36vhjkFbORMZCLBOaS4kQGr9REwQg9Z9deoRZOR0xU3CtJduj2icNgTPAAhjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HlJDk5fp; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlJDk5fp"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29416254018E;
	Tue, 10 Dec 2024 07:13:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 10 Dec 2024 07:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733832812; x=1733919212; bh=rH5366aYwyqwvgJSxOl+QhYHRS3g/w99bkZ
	pdUQRGs8=; b=HlJDk5fpescMGnva8W1NR7vKWvMuJ/KR7f4Q7eIDv/APE+QHNLG
	87UvkneS1rChANhxIDt+e4b3xpgJi+p40D7kizJVmgugWvzkt80YTJSaySGqebvS
	nTHvrcYD6IgapRkjpDfAOsb98V33YgUpxLcmOy5d/BoQJDvYA5UGvrQ9K2Gxp0Zr
	BpJpM2CrETLIOZK51sr21aLYSoPPJSFK711ss+dgMXUeLPGKqOs3YviWB2bIc2ED
	c+4zaqIUgZZNZnPDRl9ClVWy3f52xp2hoS1e9B0TY1Z7npMXsPBGrfUJCOZe676K
	D+Wg3A/WZqICjsx+/QoFKcwbqDlIhJzLTLg==
X-ME-Sender: <xms:azBYZ5vd-CCtJI7z681Sa_0qHNMs7VBuk8Ccd167C-YTUOWgyqke8Q>
    <xme:azBYZye56Z06B6mMekCut2GsVJJafrYW3aVS436gbj74jouuJ4GWq1-WGrH91AMTJ
    e5mGKtwoskQUI-1tw>
X-ME-Received: <xmr:azBYZ8w3MbJD3TcWwtnb6q6QLdXniKbExOTmEMTauVsh463dMe6dD-nO5fp22x5lEsvqv1m52Y5rRC2UsqMV4ipWfEF1fvUyG2UE1Yk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegthh
    hrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:azBYZwN2CbSHGz92zcA7kMW0iPpTOu-7TxIlx-sD0X_qUsaNAOrttQ>
    <xmx:azBYZ5-1FcmgZ0sY9ifiLNFPxsAscfHOUmIzc79ZaW7RD5bamywLlg>
    <xmx:azBYZwXL5fDDxKRnFEdAW3M8N2dLyrIfb24PS7gFr_CV4HT1y9HMsQ>
    <xmx:azBYZ6eAd_edpnpbsfKjo5DEA5Hl0jzGYB48VZLfOHNp_wkB9Y8p0A>
    <xmx:bDBYZ8l38ZdjFsf64H6qUNF781JXcr8QAs5Sq4FsHEMBQX7r3KUXZBLB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 07:13:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/7] refs: add reflog support to `git refs migrate`
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
	(Karthik Nayak's message of "Mon, 09 Dec 2024 12:07:14 +0100")
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
Date: Tue, 10 Dec 2024 21:13:29 +0900
Message-ID: <xmqq34ivlora.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The `git refs migrate` command was introduced in
> 25a0023f28 (builtin/refs: new command to migrate ref storage formats,
> 2024-06-06) to support migrating from one reference backend to another.

This topic pass the tests standalone for me locally, but seems to
fail 1460.17 and 1460.31 when merged to 'seen'.  I'll push out the
integration result tonight; it would be very much appreciated if you
can help find if there are semantic (or otherwise) mismerges that
are causing this breakage.

Thanks.
