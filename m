Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AFC3F99CC
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339163; cv=none; b=lWhIBSmEzTu2pnhgkBqcyQ77gK1yEuEwxDJAchJrgJ9B2zCLPN3I0fl0xpjKy06fD1+UnYcFwbZmZ32JVLl9yS14gDAGQlgjFHxu+p+baz8hhwKrmDn7jE5Tt19h88YM9kFRPwWx0Xt8f+X7c1g87svbMcsyWOq6phYRR4hLtO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339163; c=relaxed/simple;
	bh=GJ6vuVD2F/0zZq6F5aJPw5epXwcu88HjH47F7nR/BcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVbWT5m5poakx9QCSYm4x60Dp7PkVQw4DFx0qI2u2phg3rT/o7nhVnLDcZ6vJrix3XWzVeO4j1wyV3flRvr61Ef5mzGsBWm18ObDKv0ZgPGQNqMYGl2DakcA2auF2n3F7J6se8hv7Io+e4kcdwATdqzSbHjqN+N/JkHAvl8JZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jaZtgDxA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xQPmQY4A; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jaZtgDxA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xQPmQY4A"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 211B61400167;
	Thu, 12 Mar 2026 14:12:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 14:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773339157; x=1773425557; bh=gZD1gIZ7gE
	clpQU5/wt+XGxsMXL/ThQFKp2kXqowrKA=; b=jaZtgDxApBCjaNf7eW7dsmuhAB
	w8JMWJ7/PprgORCCgDIuPnc/NmY09RTbEVKpS0Zl+tHOGsHXhfuiHgAPfh19kyG8
	g64yahq9OjV0p3LwVaM+f98GqcCXpxccP/w/h77nDKMpRYkSxXXkW6PfRtUcjfiX
	IAeSsJ/lnu4tKqltNAu61Mcp7iQsSIOB4mOQijmYaoIlsjQDOApFUGA3ZST5R1bq
	0bTY7PWiB8d3BLM1lI2d0B+uenyFHR+h/cL7ASXWM2H4Pir3jiDounPfJtXOEU5S
	DPOmyb/qokzfDpR4zlEf/ZRItMm0GCnP2REtjoLwppYsZik6qvyA4c/2hxfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773339157; x=1773425557; bh=gZD1gIZ7gEclpQU5/wt+XGxsMXL/ThQFKp2
	kXqowrKA=; b=xQPmQY4A58IbnjJDOzzMqTz3mJFB6RYTI6E1tZLg8e3kQDNd1Xu
	fUdsVx0Fcow6JnRo3vMxBthK+cn3jSFvJfEj/YMC1MWnilqWSXjtb+ONy4XeAJvz
	0Gs3zf4krzEKPXZojkIizxYn9TzkwpOix7p9Yjgclg35wduqSEz1dlqUnXy59zCy
	EB4gM0vpYkJ3cr+NfqwV1inCH1mjOgolIb8m6nSP/VS6+uSo6IJHhYSbVNzpC1oN
	DoDcPRNz7CoVNtpuHG2TJunIscVZmqr2e6oh+cDQExLWOn2dxyuwttjCJw0iAzVq
	cQnvKwM/K3XUGh8Q6wnVGvkNqaUHOnxBIIQ==
X-ME-Sender: <xms:FAKzaWBYasHkGd9PxtZdfOkP7FTdqmtOmIT16UPSpWvMnflOoNa2Qw>
    <xme:FAKzaUMin5UsDiw5mg1adEMj3sniOD0sXYLdYbbLs-F_bJdzQiVy1Z-IrZaxWW3FO
    NyBufjoT8uR8vm-EvSvQEmybkYbSmVO2V7SKLqNNSLuyLvKvL0mtg>
X-ME-Received: <xmr:FAKzaTYjEaYC6Qp5m1ZcJUmvTeGz588R4TZcrxUH4T7iY_B8pVhGoW9HxsQhTnjhNDfOb_F0ojrNMLKmo4FDTXdGakv7wP_02A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrh
    hoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pegsvghrthdrfigvshgrrhhgsehgohhoghhlvghmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FAKzabvxo0i-TSmO5Sfl0YiLIQjGdU4LNasZnS11jJOrBUeVYo0k-g>
    <xmx:FAKzadO91aE_1adR7IjcqVxAY8bUAS60LZTO7_72VKUKsw-T4m6JvA>
    <xmx:FAKzaa6DQXilNCefesvGei43S-9_Ercc8-Zd9GuG05B0y0amynYmcA>
    <xmx:FAKzabTbo2YHQaqyHZalDoxUPxACQnBBkvrHooJoAWskTaQaEAgTOA>
    <xmx:FQKzaSRZ0sLh-vLPtXgzv5j40ErD_9Yvi9dlQs6f2lR7HOIRL6bM7v_U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 14:12:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 0/4] format-patch: add cover-letter-format option
In-Reply-To: <abL6gNTwmVfQsmU2@exploit2> (Mirko Faina's message of "Thu, 12
	Mar 2026 18:45:48 +0100")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
	<xmqqo6ktezh2.fsf@gitster.g> <abL6gNTwmVfQsmU2@exploit2>
Date: Thu, 12 Mar 2026 11:12:35 -0700
Message-ID: <xmqq5x70gbn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> ..., how should incremental changes be numbered in their version?
> Do I keep going incrementally (v9 despite building on top of
> another version), or should I use something like "v7.1, v7.2,
> v7.3"?

We often see a series that depends on topics that are in 'next' but
not yet in 'master', with its cover letter describing how exactly
the base of the series should be created.  Patrick often does this,
and we can learn from cover letters of his topics.  A good example
is here.

https://lore.kernel.org/git/20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im/

And treating such a series starting from v1 (i.e., the first attempt
to make that other topic better) would be the easiest to understand.
The cover letter would start with something like

    An earlier mf/format-patch-cover-letter-format series that is in
    'next' but not in 'master' added THESE THINGS to the system.
    Here is a follow-on series to further improve it by changing
    SUCH and SUCH things.

before describing how its base was constructed.

As to the naming, I find "chrono" worse than "chronological",
because there are other possible ways to shorten the overly long
word, and picking one will force users to remember that choice.

Thanks.

