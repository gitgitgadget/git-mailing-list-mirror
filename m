Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE223D34BE
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069633; cv=none; b=j73SmANZXFRFx5vNIyHQZQEwvb6lHuPv8MMfIhjGZN5HcVb5+PnmZmhjJvp37aD6i0caSGbTNeokiS49Z8UH+p7I6YSa5zYH47AE4KOi1HenGZAkBOuJPK9qssQPULlBi/1kuoopK/jSCABTN84iOC50FKDysK6oHodPaYOqiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069633; c=relaxed/simple;
	bh=Eqw8QKapj9vRWj7+q/PrPZRC4rb27pRfoINaue8sO6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RDBGSAgNa4STGkfx0mAuazsctgtVg5C5x3uwJoLkQTC0wukXCChi5qdO5qOuopK8eyiqOKbrPlGWLfD0cfBr7VupKpCHdKUlngvwYHbLuf40ggkiS3Q7bc+ZpZr2pQWBpRdAuj2JV08YA4rJFXUg8f0NGXbDIAX+klkiqM+fk6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j1fa3c8/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjkxB/w6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j1fa3c8/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjkxB/w6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9772EEC04F0;
	Mon,  9 Mar 2026 11:20:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 09 Mar 2026 11:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773069631; x=1773156031; bh=Eqw8QKapj9
	vRWj7+q/PrPZRC4rb27pRfoINaue8sO6U=; b=j1fa3c8/iR+mE7Jke1DCMf8eTD
	vdMf49BL4X5dWsNwnhg9pmy9TG228OOPEEuUV7jopjhWI4MZP1k+JDibtEVKFdMF
	yVrxrNoGBHNuW9mcTnoWpR6Psprs5ZxhfQopPeVx6VULCt2oWKNZj+Zd0Z6oe8PE
	bW7wHJmDc7l3Sqma4VunbQ9hieAoD7MXY53TEXxZUVN2q5tp1I7uAVFo81o83TZ5
	qHuc0OrT1qoJ6vBnLGAFyGyjeTCRnB6BiU/jdNpHhQ7aZtCa/ayQB1lxULwlBe1E
	h1nM49jbAbQFCX3RBHLWeBdHyjtU6DwSUbsxA+4KkqLy0CAntu1GV9SvAE/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773069631; x=1773156031; bh=Eqw8QKapj9vRWj7+q/PrPZRC4rb27pRfoIN
	aue8sO6U=; b=IjkxB/w6PgXAeNNjltI4o8YF1/oS4cule/VQldstOeeIo7EM7/q
	K6aJsUv3Hx06SzGYMmCf8hVlgiobj5sCMN3aKZYF3bKYbEMynWmKL7+349QNLfI4
	uwoICSSFb7TQnjctN5XwS/7+H95trIX8Rao94pplnJ9DQuSr7acFDve/6Lfr88kO
	/fVWwN5eo4JEOr3b/if2lpWveYetze8hWDpEcAhvjBWxufcPjjIQ1ZZgIw7h1dtW
	15OjheBrb//srCjFL1bHsePa9FZedCTJ+SYSodyRM5xc7rz0wJgPzIjjWDfEZ+GH
	dQ271koIRRIRV+/MMSGnNHEXehAP2plFzXA==
X-ME-Sender: <xms:P-WuaVNk6nQbED8Uo1qneqlWbQUaBTuqMmpHWlYjZQhsFL5Ylo7Krg>
    <xme:P-WuafZARYaA7d2UeHtHECK1-rdFxUp7aLxWUvH9MSGxjmUJdXug-csPstjB2SW5h
    RWBSPPuLx4XhNIZV7fVQb-JIc4wMA1FmXRlj33FMRv_ptXICMw-kQ>
X-ME-Received: <xmr:P-WuaRq1H8-q7jNc9D1HUmXB8SSgkJrJZ1qevY2zpIXVuFQRjgrrBZAwwyavRgc8Yst1NeMKRagXs4uv4GD4IIsGd4t-wxdVTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgrsghlohhoshgrsggrthgvrhhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:P-Wuabb79xVMCSZjFWIlMQyFG0s4WB1vMvOzGHe4m_KgATenWwsbjg>
    <xmx:P-WuaRQs5XC4QBzeVWGKnrJFj3Z9MDe3S9rnnthYoljDiF3hPr3gmg>
    <xmx:P-Wuaa49L_xLZgL15kxDpwwE7pnYVSufbOIsGHhW13wKwk9EmXJBSQ>
    <xmx:P-Wuaeygwv8N9YAYqwKsV5Z1B4wJLGY82GbcjxzEuGmY9wpKhJ4cCQ>
    <xmx:P-WuabZ6e-SxysjOUpcEQW6ipNznyGpo5dB1WqXbrI1yUuXfgoKYmgQp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 11:20:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t9200: use helpers to replace test -f <path> and
 test -d <path>
In-Reply-To: <20260309150935.578465-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Mon, 9 Mar 2026 16:09:35 +0100")
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
Date: Mon, 09 Mar 2026 08:20:29 -0700
Message-ID: <xmqqo6kx58si.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Replaced 'test -f' and 'test -d' with 'test_path_is_file' and 'test_path_is_dir'
>
> I've used 'git grep "test -f" t/t9*.sh' to find a file without the fix done as specified on the microproject information
> I've done '9*' because the ones I've found first had already fix patches.
> I've taken as example another patch sent 't4131' from Junio C Hamano https://lore.kernel.org/git/xmqq1rpodn25.fsf@gitster.c.googlers.com/#r

After studying Documentation/{SubmittingPatches,CodingGuidelines},
use the list archive to find what instructions GSoC participant
candidates have received regarding the proposed log messages in
their microproject submissions.

Thanks.
