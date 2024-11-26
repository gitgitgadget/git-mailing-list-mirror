Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78C191F8F
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649258; cv=none; b=EePsmDybCqb0K2b8wg3ycGJoH19CAdxqgzS892GO5biqBdh8yca6RRvw63Lq9E1rLyPZAUzKX6//mDjYWHf4HJ43MJ5Uh/8A2vgYSAFzTOdIXqJOAAlX/W6ShQ0WTMQkFzy19r2taDjdUUK4Nvh+r1/4ZjU7DNqrld1uD53n+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649258; c=relaxed/simple;
	bh=Qn3spsdi5KtKUmodvqSMTX6eprgl1RAHFWQk462zEDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tLU5XaBhqxwjwUrdGsD//P0kaKw9xfDLs6BJfk/VDwioNFZzzK93RXN0oKI8fufcLWuykb4RaY3jn1F3MjmEL3ns8gqwsGpIf8utbtP3c/3QeGyW4ezNctHqqz4mIsDPRsAPP9Az9SehPU65WcHdgqP0yUeBXNjRBrgpLk5vXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBZIulHs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBZIulHs"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DD5A1140174;
	Tue, 26 Nov 2024 14:27:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 26 Nov 2024 14:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732649255; x=1732735655; bh=Qn3spsdi5KtKUmodvqSMTX6eprgl1RAHFWQ
	k462zEDY=; b=tBZIulHs7iEHvmFr4Z37danFzX0HxZ+RKDcRef2iEqY9X+sUP3w
	SbDsvgMRgfHgAaFVGgfexSpQ5CJ0Zmf4U8u3xy4+1Xf/Im8vtqqRdmGScXSsjCrR
	SY4c2ndy0BqHIHUeTsdbGiohyDM4mE1FmiPtuRQeoVoid2NQxkCZV04Wrmkg0TPY
	n952eqOBE9JAzPdm1NX6qJnGM41K1rSJw2OApiFjuaQhNQt/3W/Dv2TQJkJE0Wng
	2JMd158mJZ6zBXIegD9Tzw+J62ok4pB49CtR6wXtcoNvSrwniU5ps7ZKuKvZEC0L
	pMNJEEVaK2vBn88JMp4pOdS/uCGy1zwnRug==
X-ME-Sender: <xms:JyFGZzapTtQPa65kjN2z_x-vRPdmeyz13duV28ZHjLEU6VvanH4v8A>
    <xme:JyFGZyasQiv-CUBBjNToFuifpxsYImkO0fUIbs5sAcRyIMS-cqX1Rb3vvxZru6pTh
    Us_pWIQgJjFUtFkyw>
X-ME-Received: <xmr:JyFGZ1_IdfCYIVtG92OAIenoCO2talcXRavLyNCbk6lMiKm7oGVNhK_wnpI5mOiUBQ7KdZeImiJ4SnvpcvH_lyqpTM8wCPtUPk3lviA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihf
    rghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JyFGZ5oWo5K_2zkErXJroPUWsd8SskiwgVNJqCKqg_ldMSGv1RMlsA>
    <xmx:JyFGZ-q_-pP-CQSWgBRlv3Gq1NnOITVJiFluxYflhahnrI2myD2zPA>
    <xmx:JyFGZ_SOzqJj0wBTxlbuHLQ2BTTRJqPh9U1CLpku2-OUyT55F2kgqw>
    <xmx:JyFGZ2qn77nolgg4Q9U6eFyylSecKis6wdov_mSot_5WFI5FXMfBhg>
    <xmx:JyFGZ_fHMB3obLia9U8zsOiZ0gRQsJEHSNjVuZDCT25EveWtxrVGAyQ1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 14:27:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] builtin: allow passing custom data to sub-commands
In-Reply-To: <CAOLa=ZTeRUT6Ex5Pa-fM1i-QbTfnmDN=o=MU_N2VFeLQwbscgg@mail.gmail.com>
	(karthik nayak's message of "Tue, 26 Nov 2024 10:41:04 -0600")
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
	<20241126-374-add-repository-to-subsubcommands-v2-1-417e0dc66c75@gmail.com>
	<Z0W3rgHQhmUxjgfp@ArchLinux>
	<CAOLa=ZTeRUT6Ex5Pa-fM1i-QbTfnmDN=o=MU_N2VFeLQwbscgg@mail.gmail.com>
Date: Wed, 27 Nov 2024 04:27:33 +0900
Message-ID: <xmqqy115x0be.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

> Could you elaborate on why you think this is an over-optimization? We
> don't loose functionality with this, nor do we have to have add
> additional code to handle the typecasting to `struct repository *` if
> needed. But would definitely like to resolve anything I missed.

I do not know if it is an optimization, but if you know it is of a
specific type, casting back and force with "void *" loses type
safety, no?
