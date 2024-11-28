Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F733FD4
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732774024; cv=none; b=G638/UlbdLvaux5kIS75QXVbmY2gbp1lTIEu7HsDApA1v/pAu6mq/pqUZ34oqp3HVeZ20gznPBx/7Dmfowo6kOd+LLJdANZCTpQERas9OzurFJiznmwVtB7Vo/r+U5rsf/lrG4Kabsd9uqrL68ThPlx6xvHBvME8+BWzlBzZAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732774024; c=relaxed/simple;
	bh=2T/KJdi5iq1UxPECpwP8TKyBFPYp9SuqX4L15zzA4+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LrgrPenxzn9ZUOOnKuLNbop6pFQmJfskZxq7dATvvGmBAGNvH/q7v9bAOYEoxDwuBgo/H9nulRtRPB5I7BCGon2q65vT+jqIfDtUYvB85tmZIUGg8PrvfA2bDeK5bmwy+fPDNEu19touVTkl5Vt7xf2yotSub8adqua7+X54mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZSaSiILn; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZSaSiILn"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9ACF1140106;
	Thu, 28 Nov 2024 01:07:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 28 Nov 2024 01:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732774020; x=1732860420; bh=+5FlIghnThyby3Op6TlLfB7UaVKCQZjQ6wR
	FYt5x87M=; b=ZSaSiILntanm+Q/TW8A79IyWhfBbvnnopnNWORlYf0wPvOciT3X
	7MmDhpUs2dc8xm82+W/ymTN3a1zrGwC99gl3snVkeAwRcUdK15Y+KkmUtC9babWb
	4sV8gamswsV99cVO8moyJckPTL45ZFdXm4KffDo2WEaLpk+cYFZvBVmcfojSoYg8
	BGhsxQJecIuRQLQuwXCkqcdbjplPyUAT2xC1JPf+NzXHixNRWjBGe0286aToKflp
	yuzDhOmvAztUoGis1qcd2rUpSRF5zrF2d8oDQaox41aRlRqj0PYjm0YP0nNBHA5Y
	sHeVifNYdVVYS/UFioyEsUk8/uyPbfok7+w==
X-ME-Sender: <xms:hAhIZzcf-3HmW6ppzX4RnUYYkdTswHuPKBGf2GKGG8UqxrER5SerQw>
    <xme:hAhIZ5PQoebPwkCpLr3QgRKi6G3Ic7kxsj8pUUhjzF-ifvyvYaNMeUFRlNWANp_91
    i_Z_exDMFeUzB0l6g>
X-ME-Received: <xmr:hAhIZ8g4Lk05Zv3-ea-PHjcfF0Gr3rz1MyERG2I0z1HMHKIJTlI6tiR8SEJWrgvPGuGeMoJpDaIBiBHAVSNM0Nqy2dVZDUaTMcIae9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdeltdcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:hAhIZ09J9XCXnZO9I1iSonyaoAhJD1WMgJAeB3PgcfsOTwpWlv4RMA>
    <xmx:hAhIZ_v0ZMvp6nT0hkGUzgiNQrbiEi8Yz3LirU5KNcjUN8gBzqblyQ>
    <xmx:hAhIZzFtYFDyaMWjHc5St5mxhKGxagDJK_JKzoJi5Bm6Gmb7-N8ZPg>
    <xmx:hAhIZ2MV8nQsDtyAMP0cI9TGUEIwt0MQWF_qhmg6DIEeyldRE7vp-g>
    <xmx:hAhIZ9Jbu40D6BfXzHO9EzKLKleRJMIkCWBbL6RE63x1RKs4bm24suiE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 01:06:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
  <karthik.188@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v1] fetch: add configuration for set_head behaviour
In-Reply-To: <D5XKQVYAZE2H.2SRB9JJ8GLWA3@ferdinandy.com> (Bence Ferdinandy's
	message of "Thu, 28 Nov 2024 06:49:09 +0100")
References: <20241122123138.66960-1-bence@ferdinandy.com>
	<20241127091718.345541-1-bence@ferdinandy.com>
	<xmqqa5dku6w6.fsf@gitster.g>
	<D5X7DHD1BRYO.22CU1OL6KLN49@ferdinandy.com>
	<xmqqplmgqkrr.fsf@gitster.g>
	<D5XKQVYAZE2H.2SRB9JJ8GLWA3@ferdinandy.com>
Date: Thu, 28 Nov 2024 15:06:58 +0900
Message-ID: <xmqqiks7oprx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> Hmm. After a bit more thought: running `remote set-head` doesn't make much
> sense if you have "always" and makes a bit of sense if you have "warn".

Yeah, after "warn" tells the user what branch the remote points at,
the user may decide to match.  Or the user may decide to flip the
remote-tracking HEAD to something unrelated.  In the former case,
the next and subsequent fetch will not warn, until the remote flips
the HEAD again.  In the latter case, the next and subsequent fetch
will warn, until they happen to change their HEAD again and their
choice happens to match ours.

> So
> maybe one thing set-head could do is _if_ you have always it could drop you to
> "warn" and "warn" could also include a line not just about following with
> "remote set-head" but something like "You can either follow with set-head, or
> you can turn this off but still get a warning if origin changes by setting
> ...".

Hmph, if you've been happy with "always", if we notice that the
remote flipped its HEAD, we switch to "warn" and the next and
subsequent fetch will not warn, until they flip again, and then we
will keep warning.

If you do not want to follow (but still monitor origin), the above
would not be sufficient, unless "by setting..." part gives a new
choice via your .followRemoteHEADManual setting.

>> Yeah, I was thinking a value like "warn-if-not-pointing-at-$branch"
>> where $branch part would be a token like 'bc/set-head-symref',
>> 'master', etc.
>
> Good idea. Probably shorter though like "warn-if-not-$branch".

Sorry, I wasn't offering an alternative I thought was better.  It
was "we could do this, if we really want to avoid two variables".
But thinking about it further, not having to worry about two
variables may be a huge benefit.  If you set .followRemoteHEAD to
"manual" and .followRemoteHEADManual to some value, and then changed
.followRemoteHEAD to something else, you may be very likely to
forget unsetting .followRemoteHEADManual that is no longer in effect.

>> I do not think any of the above should block this topic.  It can be
>> added later without disrupting all other modes implemented there.
>
> Ack, I'll send a respin with just enum fixed for now.

Thanks.
