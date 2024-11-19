Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D94219B59C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009073; cv=none; b=BdGIVrA7fZ5v8aNEo7EE6h2oaZgNo+RXeB104BHIOk2wEQZQRR9TaHmfTRknWecWU3NF4b3qLW1hEzfnhTzr9Ja9NiKQ2yzBV7GxYjaUwYiJGaSn7J58RgouEzJ8ZLLyot+aMIH0thqPqTymGlDVdrJpTxOir988Z013Z0k2FqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009073; c=relaxed/simple;
	bh=7kUqxl99/fg7TBc/RXHYgpxBG+719p5KWIdg6LoW6Cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IgzckZZt0uYG6Jg+j0GoU2mdW9wMJBFFWdjVkHIbVqbjWPD39DvtqngZWGQAAByTO2uE0sEBUO1+wJgLIyo3F9KDJhdYdr9084soqXVgUbN5cTgjXl6q6/j7biKdEJXwjgorzNOdGl89TJlkaVw42LPX6wN+NdnDapEJ9XxcoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KQEA8Mky; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQEA8Mky"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AEAD2540197;
	Tue, 19 Nov 2024 04:37:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 19 Nov 2024 04:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732009070; x=
	1732095470; bh=Md8BlKdiFYYsDbFhwajfFVn4wbj8PxA6fOWdXCjEJJQ=; b=K
	QEA8Mky+a2zu4AAkx4G3s6SatmtXIHCzCqPutyYV63qdinJE/AIeezetMBQK+XKq
	DlhX99JsvqAUZMxVGMDtWWx3vjKvxyK2Lr/XjhiqONp2bkrzIiPZFlyiIaG+YSXL
	TsEClnLjGBo4JuiLQuBw6gBCwd8wMvbLd3n48a3aGW97zs7N01dqh262KD2xnT//
	hPio1y65Hb/6cR11hOmmrQ0ZIq1JpJ8tEtPjGZDe0FwO5W5U47aIYsXciC7myfwG
	Rth4NyVT8UkGKRaUXtjNvJaC8XFv+9BfLqqarBiRygdATR93glccVfBVR0gTmUP1
	h8NwRhUKuRUgu+dIDhoaw==
X-ME-Sender: <xms:blw8Z6qVW2VUatGsFKHj_8F97SlQ8IaIf7mM102rcV5D8e26EGEZUw>
    <xme:blw8Z4qRIx1OnH4PssvxYZON_W-NJM9E2VgV7rhHCM51sGcXOR0rfuLORAqERbzfJ
    DMk9CG5CFGb-6uOpg>
X-ME-Received: <xmr:blw8Z_NLfysd7IA0tBomQygZPlDW7KxVAnRUWpzl1d41Mnup6M5F8-2zjQJNl5UqJpizs0aPzlMH5JUEC3Om2ot7NBkG5jDIgJJF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtff
    dvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehnihhsshgvsehglhgrshhklhgrrhhtvghknhhikhdrshgvpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:blw8Z54UV-ZR0VZrvOIWrPvHqrmKOkxdqTw0IpTd8O9jmH1v3bVJiQ>
    <xmx:blw8Z55_hZFWTLvupk6pYhaz5DHjejg4PD2DhEvZBvb2ZEYC1yddPw>
    <xmx:blw8Z5jmDRGv4fX6WUqzqItcLvv8vVJEqbADt_U2boUzL1zldsZ7tQ>
    <xmx:blw8Zz5Q1ZaAFhxtShkisS_-B1cS9qeJPiIENJd9ZYE736E2EddEew>
    <xmx:blw8ZzmHo3bxa5jzI1s21H-rtJLYmj-lQl9mpj_cR8lzEPhxCoAQLEr5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 04:37:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Niels =?utf-8?Q?M=C3=B6ller?= <nisse@glasklarteknik.se>
Cc: git@vger.kernel.org
Subject: Re: Unexpected effect of log.showSignature on tformat:%H.
In-Reply-To: <87cyirtweq.fsf@localhost> ("Niels =?utf-8?Q?M=C3=B6ller=22's?=
 message of "Tue, 19
	Nov 2024 10:17:33 +0100")
References: <87cyirtweq.fsf@localhost>
Date: Tue, 19 Nov 2024 18:37:48 +0900
Message-ID: <xmqqmshvd0nn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Niels Möller <nisse@glasklarteknik.se> writes:

> I had expected the output of git show -s --format='tformat:%H' to be
> always the same, and was surprised to find that scripts using this
> construction started to fail after I set log.showSignature true.

It is a bit unexpected, but knowing how the command options evolved,
it is not all that surprising X-<.  If you are using --format, you
are expected to use the %G placeholder and friends when you are
interested in signatures.  The --show-signature option is unaware of
the other formatting options like --pretty={short,oneline,fuller, so
it is understandable (not "expected") what you are seeing.

