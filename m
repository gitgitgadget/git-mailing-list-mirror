Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33C28C014
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440720; cv=none; b=ABwJriINXOvrxu5tN0YTjipzLddcrYQA6GPS4Kpn2xb7/I4nnavOjpGnjiycGdIM80p3LQ/5MR85dTrZGhmgdzuUn6KEOg9LgUFSp2HrUkQM7pOQWsO3fognULItDik5J+mH6Gi4nj8JJNw/o5Wxq2AkERSOuIiGlUotaHvqx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440720; c=relaxed/simple;
	bh=W5swdjfAuezAr+saCuXTNJeJsEOoQOWNDyxd4fRkciA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8EStKzO/Mj5OIGRqn6CyGoDE3jolBHWMsR76H2VHeOp7UFShEMnPA+9TjpMJwHViIBuBkR8n9vAiTHxKfaN7+JgQqrTK5nUAVzgHn0wFBRczEXvQVfMZcb9aTTZlXsjSkthMwb2P3dsb2OxKTqbP7oxbUNlSnnlkVpLYuNdyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ht9TD2Kz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6xu8PC0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ht9TD2Kz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6xu8PC0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B8B561D001BF;
	Mon, 17 Nov 2025 23:38:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 17 Nov 2025 23:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763440716; x=1763527116; bh=vO5ZxX2ZUm
	WFawPLv9C0yay8Q8t/yPhpm5LubI+5pzA=; b=Ht9TD2KzMf/vHgoZheRlaBzPdO
	1e8eEcrLHA/Loo5Dcg7X/cQLZBnBgCCBIpj01LEMgg8vZ+F2Wbd0ZYvdsqkuJkBw
	GhZJo6NvPBU1Uzg257qYHRkLtdFdYUHWuEVMLRUnKSZ4dC0qpi6CZMI3YDnrZVst
	EEjD+u9PxBDFepXmfAkLsxQYhkOe0wbPyxxd1Zjhf4q+jSqIw4ZVou/RcFmbDe6Y
	48yMTOxxi64dne76ZxCx05kckE6mQf51UZO5jm77C/8vsO0i2bQufohDmU5EJDrM
	fQlZYPl04TvIag1MYs+i4VzPTmUq0AU0lBJgoI970Gy/2rAWC7oCL6KfTHWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763440716; x=1763527116; bh=vO5ZxX2ZUmWFawPLv9C0yay8Q8t/yPhpm5L
	ubI+5pzA=; b=b6xu8PC0X7/+VyAOx5SYPBIVjHHU5mYmGa8FBoovPUm/Ixh8JAE
	fYE1xLkG/6QWm7ZIvPNwGzeXKFwIjBYKJ573AmjxnVoN9bac79LKsuGcxLL3MsnN
	XNtb+/QwmNM50hgu+GkHGm6209RF4Ux83+duoMJgKwdeAn+WPLaFCRCB9ueSdEPB
	+O6cmGv+4TPKkmUjeGdL+ls4TsJSoNvtLoPWF4gTTkB5Knc24cn6olO7kGagBuCB
	J6gm4xI4FLEJO3UVZXbDR30jsSqddg0cvmYBC6NVVvivGCXOsgaGlzc3abL8SIcD
	+4YAowi5qEirWfaKtsl8+tVszZ5oBP5qgCQ==
X-ME-Sender: <xms:TPgbabY23nmBY8WswJkXck46a2LS2p84kLpvIYFTNsEwnujXlg5E2g>
    <xme:TPgbaZfK9Vrj2h5vvGI0HlJKdz0o3qeCwEmFEDX1-i7W3YaYG45rTO-nJav0pKYCG
    PyO2zkCh1BSBs2sbdeb6VIpvPJCEBAfuikvYLB6_XgQaW8Xu-E>
X-ME-Received: <xmr:TPgbaUKqa9eIJAepxHjq7Bv2ScIxeSr54sMs17mQlCA7zKuEX4XR9kVv6I2NP8g9hUlh91inU-OkJoo5TgKQigd-D1Wmd6hmPvhH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgtohhtthesshihmhhpohhivghsihhsrdgtohhmpd
    hrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepjhgrhiguvggvphhj
    ugdrkeeludegsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrhihkrghrrdgrthhhse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TPgbaeLnjxnZfgsGuWKkhH8ukWbTYFwxBAa0Gdw_cm9qgYbem_EnNg>
    <xmx:TPgbabVVMRVbNu_YTkmQQX_9vwM3wxDhaG7jsD46jlX0rMeu7Dwglw>
    <xmx:TPgbafkZljKKtu0Ubt4tNPn5L0t3k7bt649kN-ey1qe8UDlk2ihFHA>
    <xmx:TPgbaZkVjseMrd1ES0Ut6tncj7YN9JwYg2Wu1yadMSQBNOzoV89O9g>
    <xmx:TPgbaTeFydscXiXI9uuLK1R0Cxl77sfDr2oWuxNVf_F906PPbLTiIHqy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 23:38:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Scott L. Burson" <Scott@sympoiesis.com>
Cc: Johannes Sixt <j6t@kdbg.org>,
  Jaydeep P Das <jaydeepjd.8914@gmail.com>,
  Atharva Raykar <raykar.ath@gmail.com>,
  git@vger.kernel.org,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
  "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] diff: "lisp" userdiff_driver
In-Reply-To: <CAF5LJ4CMtEaJgDYRHXvCTUm9Pjpv2GAsMQN9D-DL-Ric3ADMXQ@mail.gmail.com>
	(Scott L. Burson's message of "Mon, 17 Nov 2025 15:23:19 -0800")
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
	<773d3233-c890-4df9-8f7e-32ff8a48651e@kdbg.org>
	<xmqqbjl2ee8t.fsf@gitster.g>
	<CAF5LJ4CMtEaJgDYRHXvCTUm9Pjpv2GAsMQN9D-DL-Ric3ADMXQ@mail.gmail.com>
Date: Mon, 17 Nov 2025 20:38:34 -0800
Message-ID: <xmqqldk4ez05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Scott L. Burson" <Scott@sympoiesis.com> writes:

> ...  The greater
> potential for false positives comes from the rule (in my proposal)
> that a left parenthesis in column 0 is taken as indicating a top-level
> definition, without even looking at the following characters.

I didn't respond to that part as I didn't know if you were serious
or joking ;-).

> Although Lisp dialects certainly vary, I have not seen one in which
> standard indentation practice does not indent internal expressions;
> certainly, Lisp mode in Emacs indents them.  And, I think the rule
> really does need to be that broad, because top-level forms don't
> always begin with "def"; indeed, one can put any executable expression
> at top level in a source file to perform load-time initializations.

Exactly, but the more important question is are they considered as
the beginning of an important, and sematically distinct, block, just
like the beginning of a function is.  I am somewhat negative to the
"anything not indented is a beginning of a significant group", as I
do not know how well it meshes with the "(defXX is a beginning of a
function", when they are used together.

> One solution would be to add an aliasing mechanism to the
> driver table.  Perhaps there would be other use cases for it.  If you
> would consider a patch along these lines, I can code it up.

It is not a particularly interesting part of the problem, simply
because as the first approximation, we can just advertise "you can
mark your lisp files as 'scheme'".  A more interesting issue is if
we can indeed come up with such a superset of patterns that can
cover all Lisp variants that matter.
