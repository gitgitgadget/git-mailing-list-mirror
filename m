Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC339AD58
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732070418; cv=none; b=dV6jKDdmWdj66gEUnzQ1NdW7zyQfiCqGjtVdyvJrNvu1Z9YHiVJx8UqN7WncD3Z9J7a58y+RsWCXiG6HasMy00lgMrsi3gyQOQySSucqv1DJ0VK0i+NZ/Cc6qd7tlar+NuBfcHkfz4lYq7Z4z1WH6ApU5+LCXAFB7BnghVVHCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732070418; c=relaxed/simple;
	bh=52rrdErZSe0dgspyURG33O+L6sgnRF93GSSxPCbpa10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JV09aCypWXb9FYZVvop+hq6dDaMPGpNLIGiDF2u4xYo0anZFUbatixhGxWfKMVmawtby4gwamDRky/dtqEP8CBay4lcqmbcmTtnkQ+2qmSeyigyYg8GFk3tjnzyeMrVzWDvs1aZl4MLY93aJ9Tla+BPzWQa8VBNffkcm75P84Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NLvRrX1i; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NLvRrX1i"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 622472540559;
	Tue, 19 Nov 2024 21:28:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 19 Nov 2024 21:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732069700; x=1732156100; bh=grgqtdPbQNYiX1rsQvstNAEH/mQMtVy1zel
	5tTvTYEc=; b=NLvRrX1iyfKFX1Wl+h/y7LreijgTsl1QydU6pkCfxoIDjwR+qE6
	e/jTCXSH1OyBS/CMHoklpacCVrHuVVnRzoy0zh/5zX7Q0MZFc/m4CiCN4oEOMVtj
	BqB+IWoKy9g4uvRRvzKS+7K9IugFjElthB6rKGrEkJxUQdDWBkQdCHoC6t28ILX0
	tq0ecsfO+uR23X76zxFQmeNXQWTmQ4wh0iRiTl1eAgohbAl8wCta1R6PC82xjV63
	G6EzeeHBNdV7sZ+qQiIgKUP2X419TS/ArsVDs75Xc3e/zXABQCdRgc2P/F6ICUrJ
	h+zvfNuQ5BrwaRjo7cObiI9qVyQDMrqQ1ig==
X-ME-Sender: <xms:Q0k9Z4RwCRLOPF-fz8lEAY0p-wNL2ExG6v9QRVW9r46_Irwo7Y8ZwQ>
    <xme:Q0k9Z1ycwaJPAeT6BpelwCXAREaC1EKz9OBUzObdFEsP322JDx2Zzyr_VLfQZZyBs
    qkFYZOEQ1iF4krSbA>
X-ME-Received: <xmr:Q0k9Z12TGiPlp-Krq-EtPewQK83-dFrvWn5LoRXcOJJ-w5lWDFc2p1i_0RcSvddrsSYegcwkbGVjnLWcDxfpB7zmnC6CnYXolyLq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Q0k9Z8C4VZfact6z8KogK61fN90MpDvnyOeTSOlrgDEaU-FeCMAjww>
    <xmx:Q0k9Zxjuv4CjGsCr5x6-gFVr3tHetRHRqOfzIQ2Ys-vDQCchaU7VaQ>
    <xmx:Q0k9Z4qMqBDclaUycYJo8xEZ6YubcpLSeEi_C6dD91uwVCCVEr_OIQ>
    <xmx:Q0k9Z0hk3TMv8dTs9_V3CTvcIkTyKmU383Rj-oJIyu7h8WVq-0bCPQ>
    <xmx:REk9Z4OJSuwQUkNT-XDp5OVYPsl4DesEVPOgYW_Tta5FNSgEj1yjP_uX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 21:28:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
  <karthik.188@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v13 8/9] fetch: set remote/HEAD if it does not exist
In-Reply-To: <xmqqed36btxm.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	20 Nov 2024 10:00:37 +0900")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-9-bence@ferdinandy.com>
	<xmqq5xojgbfl.fsf@gitster.g>
	<D5Q4AYZ9WSPP.3KOENYK0R7XB5@ferdinandy.com>
	<xmqqed36btxm.fsf@gitster.g>
Date: Wed, 20 Nov 2024 11:28:17 +0900
Message-ID: <xmqqttc28wqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> Your suggestion seems to be the original tri-state configuration that came up
>> in one of the original discussions. It was recently requested again for fetch
>> to just do this automatically
>> (https://lore.kernel.org/git/CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com),
>> so at least some people would like to have this fully automated.
>
> And that is *not* the only option, and I am trying to help others
> by preventing unconditional warning messages from annoying them.

By the way, because I've left it out from my messages, some folks
who are reading from sideways might not realize this, so let's make
it a bit more explicit.  One thing to note is that the assumption
that HEAD at the remote rarely changes _only_ holds for forges and
the like, a typically bare repository used for publishing without a
working tree.

If you have a clone from a repository with a working tree (this
happens when you have two places to work, either on two machines or
two separate repositories on a same machine) to allow you to work
here during the day and work there after work, the HEAD at the clone
source may change to the branch you happen to be working on when
left there.  In such a setting, it is reasonable to make the
repositories aware of each other (i.e. the after-work repository may
have refs/remotes/at-work/* remote-tracking branches while the
at-work repository keeps refs/remotes/after-work/* remote-tracking
branches, to keep track of each other), and "git fetch" that warns
every time it notices the remote end has HEAD pointing at a
different branch would be annoying, as they would likely be working
on different "project" when they leave after work.

Users who fall outside of a typical "we have a central repository
and the only interaction with the repository is we clone and
fetch/pull from it and nothing else" hosting site setting, are why
I'll encourage folks to tread carefully when they are tempted to
make anything unconditional.

Thanks.
