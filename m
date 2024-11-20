Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752D4C9F
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732079769; cv=none; b=WyCyPNlqw/towff/2SHo7nHUAHdu+mA9U/Pkhxspl/KBRuLUuujKls4ua2pIjjWWMWXZcpmdIffK9jZP5LDSb+7xS9hbimkYiQCU733o6EVLAR20WcsXUwDbmHxYdcZTk3juWGlwSkIkoBd9aIoeL8XxHt02S3F+ev/3/9se2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732079769; c=relaxed/simple;
	bh=cdgVc8cNDSEavsovT2yG+q6NV8zaGCC+a2/3KP8d2fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WteJPJmyx0W9F6LJI2bE3cEyC8Vmlg/YSgnUldRiF/DqCa6J3LQf8qJ3Lwk05O19tww6Hddb+t3B+zKHcj1v2lrEkgInaIQ4Hb5kT2F0f4hr7KnootZ+SwIYoKcwM/mqm3nvT7mgyrtvrNrOoD5e3zxMb3LsGjVUJS/ECpWiOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mh+bAR0g; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mh+bAR0g"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 56A8511401D6;
	Wed, 20 Nov 2024 00:16:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 20 Nov 2024 00:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732079761; x=1732166161; bh=9yLtELVzSZCgTgF38KoSDj43rtB99Ml3Jc/
	AGVJXBFU=; b=Mh+bAR0gJ6rxXDKhTj8XASnN6Zrmv4lRKs4kGzEP7lVFeJOlTb/
	cqIq1UvOJ9NHFPmE1ZXFe+9YPwFu1BKbdG5Z/igtsnMiHca9XEqI5rSkm8EM1il3
	acsc7NIDQoURSvQeNh4h1cqvHZJ3/TB7+3ckIYgle+TbG59u9lG218/6AA6nSOmh
	wL2G5iEUD9a2acybTYCH7vB+neHr5IPM/cUlWinkzWlWR8KbtewRlZm8dc2jVws5
	8QQCPb11Y2Ye7KErRK/dykchDUEbDmYQ4cNS89hidh2ttP8hN0C2+P4dA1nUIxFy
	+aD676RyaPPxStGaqM1CLxscnQOi40doYkw==
X-ME-Sender: <xms:kHA9Z7SrhCQJYgSNjxMlcborF0T5tdqlO4sqezR3-HJjKnSVs1nhoQ>
    <xme:kHA9Z8zvpmgd06-ECqp8hIOq0SMd4Fx50xIZ3W9ZUwBdCCxP1_n81NcXarONXBHjk
    jFYqIACTI6gU0sPRQ>
X-ME-Received: <xmr:kHA9Zw269Xl3MXMtjp3qxOtYj1j3Y_W9bFMtCdpFFqqPWl-cQQauqWzkAwN_szAy554jbAzguzQQ4N-xAWq_qgsDGqCLCXsTwYRF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefh
    vfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrg
    hmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhn
    pefgvedvfeejheettdfgffefhfdtgfehtedtkeehjeeikeeggfetjefgkeeifeekffenuc
    ffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhthhhusgdrihhonecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosg
    hogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:kHA9Z7BRp8HrxwVZZEDin8tcV_8OnA-WkwSKN-2yj14mVwPx13FIrg>
    <xmx:kHA9Z0isJfLi9N8OR329LbuioFcc2uLuAXUwF86m5E4b20s8UscbGA>
    <xmx:kHA9Z_qmGbZBv2LzXOprgxZH7uxtflsNbJkxs2_CxDVWgW6J3dcdIg>
    <xmx:kHA9Z_hFBsJoxvefgZaQNypu2KzGTAgHd5-u28V7VKPx2cG-bMMUTA>
    <xmx:kXA9Zzpsrxdu7Blfc4pOrZwR6IKZVMArc0UZuviC985bN7taq9FN2CNN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 00:15:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Taylor Blau <me@ttaylorr.com>,  David Aguilar <davvid@gmail.com>,  Jeff
 King <peff@peff.net>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 00/23] Modernize the build system
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im> (Patrick
	Steinhardt's message of "Tue, 19 Nov 2024 12:50:37 +0100")
References: <cover.1727881164.git.ps@pks.im>
	<20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
Date: Wed, 20 Nov 2024 14:15:58 +0900
Message-ID: <xmqq7c8y7aep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This broke the documentation build with the log ending with
something like ...

    GEN asciidoctor-extensions.rb
    GEN docinfo.html
    GEN howto-index.txt
    * new asciidoc flags
    ASCIIDOC git-tools.html
    ...
    ASCIIDOC howto/keep-canonical-history-correct.html
    ASCIIDOC howto/maintain-git.html
gmake[1]: *** No rule to make target 'asciidoc.conf', needed by 'technical/api-error-handling.html'.  Stop.
gmake[1]: *** Waiting for unfinished jobs....
    ASCIIDOC howto/coordinate-embargoed-releases.html
asciidoctor: FAILED: 'asciidoctor-extensions' could not be loaded
  Use --trace to show backtrace
gmake[1]: *** [Makefile:428: howto/new-command.html] Error 1

I think all my builds these days (including the ones that push out
to https://github.com/git/htmldocs.git that in turn results in pages
at https://git.github.io/htmldocs/ getting updated) use asciidoctor
with "USE_ASCIIDOCTOR=YesPlease", if it makes a difference.

Thanks.



