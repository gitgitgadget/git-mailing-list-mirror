Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E63139B
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752734; cv=none; b=SwfzelGJGL31QMRMpgcIAihcyzqPKMtOmxLznRXM4bJ/Lsj4JNUCPuWhUELCJ49u4q6jwKWNwlL5/QjCnIM0a1DReJKykIWsGvTUxUcQKhPwvin4UgO1iNld/FC+nAUlQkp39IRypxGsep699tiLmzdHlVGeO2lANjlVfRj4kIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752734; c=relaxed/simple;
	bh=W2sGfAsfLEZG34P79UFIeONizfxDxNsxf0IQICqtYE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OXtEZDYmAOBbX1FAXIBZCfRaFYfitOv0x5fSLhcXHpepjHhd7YqljprvYorBvMMANErHcJ/2116nslOBxRvNsEQ0CrMHiW2hmZGmRMsN3qNNBV5BvPoGQxL6CYY7IAnGKm0GgK0pn9L19OXlsrtD9US9VIMkUYyjtZTnbFGZCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kVP8MbXZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kVP8MbXZ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C5FB925400C3;
	Wed, 27 Nov 2024 19:12:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 27 Nov 2024 19:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732752730; x=1732839130; bh=P9UFjbVrvDj6peXchHrlZM+jYN3lOjhjSgv
	usCFpNLo=; b=kVP8MbXZfUkcvUD2XeyPBOEOvjE30vTvgBjS9RhvOL2NFlxig8D
	u85m1iPDRfdRTF95hIwZLAQSuwSCztgGIg2fcvsz4oiXT8U1ZqAo5rOX50feBiqC
	Kxs8xS7kEJ2/4GYop3rEAoFSzMGx9M3gicd7I/+Jh0BaLWpGNH48pR1WFnD99f21
	k2fCgPArBkMGha4Xy08c+iBHdk8Aiq6BYIYq4gr0lah79PKU9RisoEQ5nrQ7tNoT
	vRatJkBkv4au90lHi3kmsENi99XTBl+Les+tgDJbs7yPRHWg3bICap5B2/gi3k/a
	RLN+8gzBmGZUxms/c9N7DxmeabMypoV9Vng==
X-ME-Sender: <xms:WbVHZ_Qo1IowF4qX0InAtU8rjdMiz1TES_88ZUdCbFEugMLir2OEeQ>
    <xme:WbVHZwzEBlrl_2PwUOGhr_L4l48lPcXWuyq0Gy-eOiP-xCgnBE0WsMAeRX6-bxA0O
    EyBMSD8X0xvO7Pk5w>
X-ME-Received: <xmr:WbVHZ02ZdIMVa48_1s4S0-jF6AvvL_zrsOKs8z5RguVZRlgNoUt3K-La03mwIDMHFQ7NHlaPNGRMXIJcunM0okyLOLhp0Ux9iq6vU0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WbVHZ_DfPxiOW_M-dRd4R8qagWtklpLH-65yww9KWGQ7rtb7X5idWg>
    <xmx:WbVHZ4i954P1dl-mhAKzejwXSYqp6zE730Yk5hUVlITtyYFQhGp_Ow>
    <xmx:WbVHZzp_OohCLlmsWh6YwAQrgVT5D648ZLS9zcofXoJm_T-cVZI_Vw>
    <xmx:WbVHZzjZS5c1PJme7s6WBeNv_IYrLtFiXKgNJbm8ayNRpD2fdgVg8Q>
    <xmx:WrVHZ7PczD05v0yEwre3Qo_51LucWWq4B0UEn393aujRuz8CbGRW_cEy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 19:12:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
  <karthik.188@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v1] fetch: add configuration for set_head behaviour
In-Reply-To: <D5X7DHD1BRYO.22CU1OL6KLN49@ferdinandy.com> (Bence Ferdinandy's
	message of "Wed, 27 Nov 2024 20:20:25 +0100")
References: <20241122123138.66960-1-bence@ferdinandy.com>
	<20241127091718.345541-1-bence@ferdinandy.com>
	<xmqqa5dku6w6.fsf@gitster.g>
	<D5X7DHD1BRYO.22CU1OL6KLN49@ferdinandy.com>
Date: Thu, 28 Nov 2024 09:12:08 +0900
Message-ID: <xmqqplmgqkrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> Just to clarify, an example: the remote's HEAD is set to "master", and you have
> - git remote set-head origin next
> - git config set remote.origin.followRemoteHead "manual"
> - git config set remote.origin.followRemoteHeadManual "master"
>
> you manually set these explicitly. As long as the remote's HEAD is still
> "master" you do not get a warning when running fetch, but if it changes to
> something else (even "next"), you _do_ get a warning, that is not silenced
> until you set followRemoteHeadManual to "next".

Yup.

> Would you expect `git remote set-head origin next` to set followRemoteHead to
> "manual" and to set the correct value for the followRemoteHeadManual to
> "master" if it actually changed the current refs/remote/origin/HEAD from master
> to next?

What I found missing is:

    "I know this is the value I expect them to have, because it was
    the value I last observed there. Please let me know when they
    changed their mind; I want to reconsider my position when it
    happens, and your warning me would help me to do so."

My running "remote set-head" to manually change which of their
branches I am interested in does not tell Git anything about what
branch I expect them to be pointing at with HEAD.  It may be the
action after such "reconsideration" of my position, but there is 0
bit of information on what I expect their HEAD to be pointing at.

> Or is having this completely manual fine?

If it can be automated, that would be nicer, but I do not think a
manual "remote set-head origin next" gives any information to help
automating it.

> I toyed with the thought of rolling the two settings together (an unrecognized
> string would mean the reference for which we must be silent), but then you
> couldn't have a remote/HEAD called "create" for example, so I think we need to
> store that separately. I'm also not quite happy with "followRemoteHeadManual"
> ...

Yeah, I was thinking a value like "warn-if-not-pointing-at-$branch"
where $branch part would be a token like 'bc/set-head-symref',
'master', etc.

I do not think any of the above should block this topic.  It can be
added later without disrupting all other modes implemented there.

Thanks.
