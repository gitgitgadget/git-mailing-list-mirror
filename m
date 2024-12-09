Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E521506F
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731146; cv=none; b=p80sKM37Km0T4IyZLzu7W5xD4yhLtDqkLx6/9m+kCI5hE+h99DR7F1OJz93MjXQpxNnfgZX7nafEQF6RLdckp5W8REIC+P/sG3OgcYe4zS0HhclAiHa0ztZtfpShEGKezCpucHTmPoq1flURKJORuEfTTaxRTXm9qWd0ENe0d+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731146; c=relaxed/simple;
	bh=7S0BgxwMsW2UQBc/iaSTQcBFTClQEeECv5xMt2+DeSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NXbO6d72M9nAJZtUHSnvxUvPyP6rEJYZDXVs1xIncVdol1b9BHXp9MDDdGCp6vo5cXAS/MXJqjXXwZMR/5tDsdtt3rG0n3srCWxgV9Mhev6LpVgHUvafZyj4M9YVEkwC5AmRJkIdY0gn/O2vQplhzLULGFMIPsVq6D+OJI4pmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBmheWt5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBmheWt5"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6563114013F;
	Mon,  9 Dec 2024 02:59:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 09 Dec 2024 02:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733731142; x=1733817542; bh=KcGBO5Nf/u+teWJzpmLUPq/gJkmqlXrv9zC
	drDK7pFo=; b=tBmheWt54KMuJ5TJPzwtm2ut91JbVYXX/fepy8hnqvuGncY8vW8
	V69KlkcKLNckU2Tv5yOarPLLvDiyQJU8Qa8EbeFUz8NdNojNUGILQhtFOF2KrEJw
	cNP56UcAKusYBHhtFv3NN1FrE1Dnwx0ropYgQ6ZFwKzQ2BqroG4fXUBJ+mo8Qg4j
	xcL85s2FMY6jrd1l8f0SX2+lDJojG+vtTbuORohC3JQVFE+RE+J12Kz1DGqdWTJJ
	10869tqnIQUWl6OaB1qYuxtlqgq4kCpv1djW/crHpvyGLwn89UNMhMJLbr4meFiO
	WLeAB5C7N99D79TYJ9XEmaEknGp8DYHQKBQ==
X-ME-Sender: <xms:RaNWZ9SBEUZr7WHHEr7DGDrU2zyLJU9ZkIhDdcjMThfDhXpBWeDV4A>
    <xme:RaNWZ2zbfl-Q5zuY8x6TiYxdeJl3pIdLXKV5Eq88YwL5nhOjqB3drpvbrAkYImloM
    A2tORRaxgyk5XIRMQ>
X-ME-Received: <xmr:RaNWZy3NFokukYkLeCM3TSN1z2_jb0yMRdcb7b5DzX9uO19VxfPIWk2MGNkv0FcpfHb-ed0the-EyAc_JsnVVh8Hp0zVrhLSDb9B_5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrg
    ihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:RaNWZ1A2a0s3wxm6RGMM850xebrwdZE3gkYKHUKa1HRlWWidiwX7Tw>
    <xmx:RaNWZ2jEdR0jPWc8SwEXaNhMO9JHaBZzEtsMoZmDEH3tRkzPDwG7BQ>
    <xmx:RaNWZ5qsYBrK2nlKd9xsWW3AoKjJ0VD_1aWqVzvCrAMjU-oj8MXJOQ>
    <xmx:RaNWZxhr0TKr1ERVH9ra4egpwaSETYs3IJmQckaJ7o9PHiP5qyaHgA>
    <xmx:RqNWZ3Zhjrf9_otrdkiF542-hPOeMaoef_eSY5nFDKrjqxD35kxVlX-3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 02:59:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Taylor Blau <me@ttaylorr.com>,  David Aguilar <davvid@gmail.com>,  Jeff
 King <peff@peff.net>,  Johannes Sixt <j6t@kdbg.org>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v11 25/26] meson: fix conflicts with in-flight topics
In-Reply-To: <Z1aLT-Hcq2iMWH11@pks.im> (Patrick Steinhardt's message of "Mon,
	9 Dec 2024 07:16:47 +0100")
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
	<20241206-pks-meson-v11-25-525ed4792b88@pks.im>
	<xmqqikruswtd.fsf@gitster.g> <Z1aLT-Hcq2iMWH11@pks.im>
Date: Mon, 09 Dec 2024 16:58:59 +0900
Message-ID: <xmqqplm1nv7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I have the following change queued up in a local patch series:
> ...
> What it does is to verify that test suites wired up in Meson are
> up-to-date, and if they aren't `meson setup` will fail and print all
> missing or extraneous test suites. For code it's a bit harder to do as a
> lot of it only compiles conditionally, so I don't have a solution for
> that yet.

It would certaionly help those who build work "meson" to remind
themselves that they need to make matching changes to Makefile world
when they update their meson.build files.

> It also doesn't execute as part of `make test` -- if we want that I'd
> have to implement it via a separate shell script instead. Which isn't
> too bad, we'll simply have to agree on a direction. But the logic will
> execute as part of CI so that any discrepancies will be flagged.

And catching a breakage as part of CI is a good first step
nevertheless.

Having said all that, with a longer term evolution of the build
systems in mind:

 - Currently, anybody who is working on our codebase is expected to
   make "make all doc test" succeed before even running format-patch
   and/or send-email.  But unless you are testing with ps/build
   topic, you won't be checking "meson test".  The same is likely be
   true for CMake (I am not encouraging folks to send a change that
   is OK only for "make" and deliberatly breaks "meson" and "cmake";
   but for those who are used to build with "make", having to _also_
   check with "meson" and "cmake" is additional barriers.

 - The ideal world, at least from the point of view of those
   advocate ps/build topic, should be that "meson" is treated at
   least as another build system with equal footing as "make".  With
   even longer timeframe, the effort may even aim to supersede and
   deprecate "make", but before that happens, it has to at least
   become build system with equal importance.

 - In the longer timeframe where many more folks work with "meson"
   than "make", check implemented on the "meson" side to make sure
   that "make" world will not left rotting would be helpful before
   we finally kill off "make" support (if that is what we are aiming
   for).  But until then, I think the pay off would be larger if we
   helped "make" population to avoid leaving "meson" and "cmake"
   builds out of sync when they update Makefile.

And that is why I suggested "make test" as that is currently what is
run by everybody.  It is like &&-check that helps individual developers
with their test before even submitting their changes.

I am unlikely to run the check locally before pushing them out,
simply because meson build is not yet part of my everyday workflow,
but even after I made it part of my workflow to check, in a sense,
it it too late.  Once we adopt ps/build~1 as a part of our official
world, if a developer, who builds on top of the 'master' in the not
so distant future, does not pay attention when they touch Makefile
without making matching changes to meson.build files, I'd want to be
able to scold them for not running "make test"; otherwise the
process will not scale.

I also had to wonder if we can share the common list of files and
have both make and meson worlds include them from the same source,
but if the eventual goal is to migrate into a single system, it is
not all that great an idea.  After giving up on one of the systems,
we would not want to keep a system where we keep a list of source
files in a separate file (possibly in a separate syntax), which is
not how either world would normally work.

Thanks.
