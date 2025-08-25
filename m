Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C872633;
	Mon, 25 Aug 2025 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756165012; cv=none; b=cXSTEFb2gVzfRlaGQwJZggFqpg89HTgIUraNu+pYEhVI/2i6bnFbTO1Uap9TpTLIh/TzJU3n040RRix7im3ZWg5bF/+HAmu4WZ2ue07mWO2JpxSNTZ6tKLn6GtvNhjMdiKjkEJmkMP78GZFQTs5f/7PUxOllIraEHB4t+UeuI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756165012; c=relaxed/simple;
	bh=tUMHyl4WDXzuM/+jKXzaGXQo1HjXw16WOqTqr9DIvCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eZFStqnqIZPeK3HwZEiUfwhSyZphbepnlCrF115V2QlX+KN9yvtlUklsNsRhSMv7WFuoNI1b94xBxGR1CYo2ooSxV5DGzVpBgooo/Yn2Q0gojhs4sk793FHzdUgrrXw7RYk5hL9NpCcYPniJzPKnmRmKpmbDrOtC+d9/IWChrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i/3NIVOp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZtN8DVFj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i/3NIVOp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZtN8DVFj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C9A2EC044B;
	Mon, 25 Aug 2025 19:36:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 25 Aug 2025 19:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756165009; x=1756251409; bh=tUMHyl4WDX
	zuM/+jKXzaGXQo1HjXw16WOqTqr9DIvCs=; b=i/3NIVOprqBHG6j3AYshQR2C/j
	lcn3fAX9CUqs9TTzYgs+wkuVQUVk6FamfoQ/tne7wPbQ+i/oQmSERp2WgpSn+jzc
	StQZco7PGnNlmCFi0Db/7K1IpnOVOlgTLmWx8Vl0fiw5H+g2Qp5Bdv1kNAnC7sfJ
	2cDmUE0XUFcr8oOBcJxuPOXTcoCXGAfzwAyO5R3rMf1PzCAQjLCVyD+GZrsxwFyx
	5cdt+a7uJv6dAbx1ATHQAf+x2sJObdTLdUwrq/sYCUUWcC3ri6ADaZDn90H4w2fH
	HCfGDaQxg5Iuu1my3l9JdFBcns7WdzdNZhRNkTiEgyTKUtzd/nT2koBQ1O9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756165009; x=1756251409; bh=tUMHyl4WDXzuM/+jKXzaGXQo1HjXw16WOqT
	qr9DIvCs=; b=ZtN8DVFjAHGH3psg29kTXErJVPcvEl1KewNWdKO0R/hvuEWbCu2
	VoEXbTdkqsggx62jSVtDWgRWm2rssdLb2RMFWQEB6pUDMZzGTeUQ6nPRT1UXPrgp
	Dw3GzQOsq2wry9XlDbpA0QpKQNKb5k4S4mOW8+7HiS3rxxg55ZY0CjtKyDaQ85gn
	hKNU+dNo9Cxs04zcau6KK6eTvv09iZda/Bz7LA+EdhPIgRfV+5QOgGR8Ng1hjDkE
	u54Yq+0KrOG+Pdj1S7n0R3xyFOIcEiWfQqWI3YInmKnrAjOEbaVuzpwoXsGzkc+N
	ggd9ejRbGFh/wgQx9z1PZwDakK8easCnIAw==
X-ME-Sender: <xms:kPOsaPgPVHk9xlTne0SXHQUKHvlLMC5XMdZ0hjSrmvGu0_1bvP3s1A>
    <xme:kPOsaCzthnqLqvIzZi4nZO_JnwVXdkPNeAzfpAJ1euA3C_8U09yfXPAmHheB1zwi_
    sAUnxjOnHze-mvuqg>
X-ME-Received: <xmr:kPOsaA1kzGO5VQjqlQ8CwYYM_iusrf49qSrrsk6gygNQjVXFns2Ef1rQ-SDMXsuaBYvz1lpv5jAXSVg2msr3vUqOn9FEXYjiywjvFrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshgrfhhinhgrshhkrghrseiiohhhohhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhpug
    gvshhksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhhnvgifsghivghs
    sehkvghrnhgvlhhnvgifsghivghsrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhjrg
    hnihhtohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:kPOsaH8cBCk4vpUDyPCzsHdlGwX3zCSh-7k7vu2LSSIM7aLBy8WOEQ>
    <xmx:kPOsaIrx-pwyCmaw-GcJQJZ9ZlLr_-EUMN94K0rAVajiyTj0FB_39A>
    <xmx:kPOsaJQDkyQumtEjJpo5VgIwG0ghluhiHZbsid-49YZBBASuhIZ19Q>
    <xmx:kPOsaDM04V0eGFeAvyB1vuBud6yBrKUVG8CQG5CAdvmkJG03CwC91Q>
    <xmx:kfOsaGRH073tlW8c_yjfFvHIfJ3NNZuBGXLbQnl9OQp7CAkQY2_ImpIL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 19:36:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Askar Safin <safinaskar@zohomail.com>,  git <git@vger.kernel.org>,
  helpdesk <helpdesk@kernel.org>,  kernelnewbies
 <kernelnewbies@kernelnewbies.org>,  kernel-janitors
 <kernel-janitors@vger.kernel.org>,  linux-doc <linux-doc@vger.kernel.org>
Subject: Re: git: list of my complaints about future graft removal
In-Reply-To: <aKXXkvAOhStlS2_m@archie.me> (Bagas Sanjaya's message of "Wed, 20
	Aug 2025 21:11:30 +0700")
References: <198c29e9058.119e3a5c065010.5888624019176274871@zohomail.com>
	<aKXXkvAOhStlS2_m@archie.me>
Date: Mon, 25 Aug 2025 16:36:46 -0700
Message-ID: <xmqq1poznfch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Tue, Aug 19, 2025 at 05:57:08PM +0400, Askar Safin wrote:
>> * As well as I understand, "git clone --depth=1" rely on grafts, too.
>> I hope "git clone --depth=1" will continue to work.
>
> So shallow clones should use git-replace(1) under the hood (both on initial
> clone, deepening with --shallow-since and --unshallow), right?

An unfortunate historical glitch is that shallow uses neither the
grafts (which is being removed) nor replace but its own mechanism.
It internally borrows the same "graft" code paths but the data is
stored outside the normal grafts mechanism, if I understand
correctly.
