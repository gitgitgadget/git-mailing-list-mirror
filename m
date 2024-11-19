Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501C2563
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986212; cv=none; b=HXNs8TS9y1wA/6J1NLQw4LjuQxFkNLU83twQ1jW/e34o5afSjn5aIgrUkrFtHho73HuGFhnRkRmqdsC1kxRaXgwdLt44e9h3iiUrhyUHNbCXSMNmAoY2JdIN5rLJjAfWTKpEfbeooOFeKK4Ds5OUdGjrTW3Nn58cJ+e6KhSRhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986212; c=relaxed/simple;
	bh=XB510BLx/2Qi8SIuDNJAB9hlCSorbolcdQqomVdH78k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RW2C2QQ8tX6FbOWcoGOPKYtXfT/kJ3zmlDvGEeGuzOHzaCzPzLnOv7BGVVPtmumxPr+1lbnzkK3K8D9nBcqRPCwZXS2943z0ob3hllwtTbZ93huuaNb2eBvyx3DMkxorcrwgINJY3erut5jtz95SYEss11Grj9lO0i8eqClDxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=moF3jJGh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="moF3jJGh"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 966181140125;
	Mon, 18 Nov 2024 22:16:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 22:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731986209; x=1732072609; bh=Oo6KTunBb9zW7oTXAYf/OIJukTqwtRG8clD
	76vRKZXg=; b=moF3jJGhJI4h4T89AYZCXYKZ0HKP3ot75R4M/6vnMpbt6HuR6IU
	fQHoST2bqkHFiqxa4FrLf9jZvgMto5CFXtCbzvaO0v96ump+iOm5jXkF1XMbb0O3
	waXN6bUP3tx0/qVYazpVe+hlvW9f0yswESZHEbxyCqMsphY6iGZH1hZNG3OG9hjw
	6Y/VZZfUyxOUXWIK7xDhXi10eR2Urz4Ie5GzfQX3gt/5iQvkv8IE1G1uOX0WDcaJ
	YMQ1SFiV1UH7gGf0jy5lf5YmtFDrjMLwNXLmeo4XgDMnKWfapPdr6JcD49LDhRFw
	Tg0sUJbJmfbsufy6sZLD02CyCg+4zlnhNww==
X-ME-Sender: <xms:IAM8Z4OfJJDVdmbFhu9O4E3SWdA2V1KehW2EIPFl-tX5nK4zawIzSA>
    <xme:IAM8Z--4oTV1pnLbm-0JUMwUJEMQOv4VWKGf7uwL3luNKgWaC7OFW1XXafGxbhUjl
    wENXP7xD3KRwQDV7w>
X-ME-Received: <xmr:IAM8Z_TPttfoPk-Z6cnAULhqallma_FV-7tB6apjRfubnA9clbbi0-AySFhs-7KP0aQaUGYzeSJJWC4VnC6tFam6DpiYgazeK0Xb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdehjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:IAM8Zwsvf6k2w1Hh-SkRHdpsLh6vghXI1C6bBhGGZiVX8WFjyutGgw>
    <xmx:IAM8Zweu0pPPtDarua0V9yop3Xgua8VDV_pDWNpzCd_1YksZAw5ziA>
    <xmx:IAM8Z03_aDq-IuQMHUXXuX6WLklsjz0Gthu7wwkCANz02xAkKvO_AQ>
    <xmx:IAM8Z09zrcfC_AvqpAyZn4xJLS8qZEgw4TL2wLOk9LyZPNl4y2X4cg>
    <xmx:IQM8Z44oupX5R_KwXvg1pALu_xViyrSfk593pg5jyOjP4_jAGaiNs4Up>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 22:16:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v13 8/9] fetch: set remote/HEAD if it does not exist
In-Reply-To: <20241118151755.756265-9-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Mon, 18 Nov 2024 16:09:27 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-9-bence@ferdinandy.com>
Date: Tue, 19 Nov 2024 12:16:46 +0900
Message-ID: <xmqq5xojgbfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> If the user has remote/HEAD set already and it looks like it has changed
> on the server, then print a message, otherwise set it if we can.

The user uses remote/origin/HEAD to point at the "primary thing the
user is interested in at the remote 'origin'".  "git clone"
propagates remote's HEAD to local because their HEAD is the opinion
of the remote which branch they want the users to consider the
primary thing.  But the user can have valid reasons to consider a
branch different from what the remote suggests as the primary thing,
and an explicit "set-head" is a way to do so.

After such a set-up is made and the user is perfectly happy, would
it make sense to repeatedly remind that their HEAD points at
something the user is not interested in?

Perhaps it may make sense when given the "--verbose" option, or
after the first time the difference was noticed, but otherwise, I
suspect it becomes annoying to those who keep them deliberately
different from each other.

I wonder if it is more sensible to automate for these two different
classes of users with a new configuration per remote.

 - When "git clone" initially sets up, or "git remote set-head
   --auto" matches the local to the remote, we set the new
   "remote.$name.autoUpdateHEAD" configuration variable to true.

 - When "git remote set-head" explicitly sets remote/$name/HEAD
   to some value (if we can detect the case where it is different
   from what the remote has, that would be a plus, but it incurrs
   network traffic, so care must be taken to design this part), we
   drop the "remote.$name.autoUpdateHEAD" configuration variable,
   if and only if it is set to true.

 - When remote.$name.autoUpdateHEAD configuration is true, "git
   fetch" automatically matches remote/$name/HEAD to what the HEAD
   at the remote points at.  If remote.$name.autoUpdateHEAD is set
   to some other value (e.g., "warn"), show the warning so that the
   user can choose to do "git remote set-head" to a specific value
   (which would not drop the remote.$name.autoUpdateHEAD set to
   "warn") or "git remote set-head --auto" (which would start to
   follow whatever remote uses).

or something like that?

With something like the above, those who just want to follow along
would get remote.$name.autoUpdateHEAD=true and silently follow
along, while those who want to explicitly control would be able to
do so.  I dunno, but I am fairly negative on a persistent warning
message that tells the user that the only normal case is to have
remote/origin/HEAD point at the same branch the remote's HEAD points
at.

Thanks.
