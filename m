Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E21DDA24
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657147; cv=none; b=tT3C9mg3iSd0JRnGfnyuuWEtOqlaH8a8Xik/1gJK8oboFXfb1qhwjpYPrEnoHLsYHF+hRRUrcP/vyS+uIviU44m4t4GbN/OrEFA9+nqACmMpgUKv4M3nFENnS0nbc257XAKwD5m+3lraLG0cbgRjtTvaXsaSnxX39pQMyqJz3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657147; c=relaxed/simple;
	bh=9BQhwIo4Y+d4stivHr7POV5Ix4p/+49y/XlyjM8DsTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7Pac8wWQv6UGwefcORTrJlvO5fwWyvZ18XECoynaNHQ+13r24f0gfj6JSVMPvCqMVDlUTlSUTvqa3MCHLUVByfC9XloOOqWTnUDjY/fT/fc7CeXdbz4+bZ8L3Yc77TFdQSn7kSr1A5d5tZ+yfa+vhiXJrW3ur5JyEgDeBrDSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NY9POrV0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NY9POrV0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A27B25401E3;
	Tue, 26 Nov 2024 16:39:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 26 Nov 2024 16:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732657144; x=1732743544; bh=9BQhwIo4Y+d4stivHr7POV5Ix4p/+49y/Xl
	yjM8DsTY=; b=NY9POrV0DUnLkCKlV5d5q/mYpNxTR+IS9UoGJr7AEYV3Vu2NymL
	vn+OZWS99DjNmkA8Weuhanfapw6e45Wb/8q3yO1Za8K/nF2EtgyJ0ISN939UEePh
	GPj6zZBecUT7BOjouS1txY84xoOu3p3umTPfMpy0Oaqg0t7M2tEYr+b+l99Gcf8l
	xYAFsysuR5QwHHwuj8Q2Wn2IN3atTLokHTsXWt5KEC6Rf6JqJbyBuE/yo/AbRIPH
	FpZn69hvmwG+9Pls94PauPgFO0OUJxp13n54RG28D4Vt/tgIAdK/8U/u48mdSDNJ
	fmuwzotMg2oi2yVQdGqmTVZh52NFWU8dNag==
X-ME-Sender: <xms:9z9GZwrGBTi8EDybhN1JIWI6cKL_n8V7oTd6UkM00hyiQZ879UDRbA>
    <xme:9z9GZ2pqkI97OTuvdnG_Smq3CY6e3IQb_cXBRE_h63ksX-BQ151SmvA6zAQ-f7Prs
    8r_70t4DPhKOwJM9w>
X-ME-Received: <xmr:9z9GZ1PjMN0PKcbz8xUoUatT4I5mFV29e9e-9eCQR8uxW7kxmjKnfyzCwaLbKHpRePfbNjhydZhsj7uRSwQUt3nNT_5OHi5xUioNdB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfhgvrh
    guihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstg
    hhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:9z9GZ37IdOkHx-3Xr_Ipq5hKcguP4FypN87vdy04G3uOpa2QFJ8fDQ>
    <xmx:9z9GZ_5VRqfjsuwDUBENayjo4a6AtxvzzpvB7iE0ohyyEGTuwR8EDg>
    <xmx:9z9GZ3htQ3VQvDkb0KepwVsq1QK0kNi6jO21lhdV9hxogONkUeEO_w>
    <xmx:9z9GZ579TO8LlNhwJEwkR3qaArQMulQAT7F_1fiEXhyUFRJIEi9BgQ>
    <xmx:-D9GZ8EEZWYMFVJH_6UlHm1gD69dPGXZNjliemlWrpWZdZfsXKEkCo8n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 16:39:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: "karthik nayak" <karthik.188@gmail.com>,  <git@vger.kernel.org>,
  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>,  "Taylor Blau"
 <me@ttaylorr.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v14 03/10] refs: standardize output of
 refs_read_symbolic_ref
In-Reply-To: <D5WESFCCZ463.3RFWANEKVGBOU@ferdinandy.com> (Bence Ferdinandy's
	message of "Tue, 26 Nov 2024 21:56:23 +0100")
References: <20241118151755.756265-1-bence@ferdinandy.com>
	<20241121225757.3877852-1-bence@ferdinandy.com>
	<20241121225757.3877852-4-bence@ferdinandy.com>
	<CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
	<D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
	<CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
	<D5SPDJZAM5K1.24R4JYB0WNTSF@ferdinandy.com>
	<xmqqwmgs6mxk.fsf@gitster.g>
	<D5W75LQ6Z44H.3LKJ0OX40QKVQ@ferdinandy.com>
	<CAOLa=ZQ-ZeM4Lk0=ojx3f9RebRkVCX7w4KUKHphZoxUa5Cgfsg@mail.gmail.com>
	<xmqqh67twypb.fsf@gitster.g>
	<D5WESFCCZ463.3RFWANEKVGBOU@ferdinandy.com>
Date: Wed, 27 Nov 2024 06:39:01 +0900
Message-ID: <xmqqa5dlwu8a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> Ok, so `git diff --check master` at least does produce the output for me, and
> now that you mentioned the exit code, I checked that even though I get zero
> output from git log --check, the exit code is indeed 2. So now I just don't get
> why I don't see any output ...

I was about to say "perhaps you are accidentally giving a wrong
revision range, like 'git checkout master && git log --check
master..'?" but then the command should exit with 0 for an empty
range, so that is not it.

Do let us know when you find out why ;-)

Thanks.
