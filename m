Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1EB1863F
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988375; cv=none; b=gdcbSsMCir1sZgVGG93R7v/iiLuOQNHD5hnEnQrY+Z7H3M/Z6clfV7OSvN/IIWKDOioywGZWWTyPNhbceNhr79RsByjSarOenkAAnBzrbqHVhXbVNJ3vUv8IgnoRnNsIObTBj/AU3qM5KGlrJv+j1mAS5cSbqGdVrt74TtqKW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988375; c=relaxed/simple;
	bh=8hOHGbsW1ZweE8bG61QEFq367NA749e8oJ/7QWhkOBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r/X4TUCzZbkFWQ9+l6WY0gGr55iwo1lXcu0AZscuyrL3GdA7H3ZTTMuiQZU/r14/YUuqFqO8Ep6Fx7yh2Ki6UH6aW0fqF/N3C7qv22AVfgr17i6SKhdCHyt4wQXm2qC0U4gUHmshNVdtC+Hh5bzkJ0xU8K7PISOF1lrqQrDFiMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDu6+51M; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDu6+51M"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 357FD2540190;
	Mon, 18 Nov 2024 22:52:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 22:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731988372; x=1732074772; bh=ggPRBZIS3Tspfg1BgQU6n1z2ZW2FUGt3VSF
	GKCb0824=; b=SDu6+51MAb/NK5yxFeNFGxxDe31KajqttcXA3hsW3cgGHGBDfaK
	0Pnl6AFQVP0LOe3bw3iGy4z4xxlBBasLkG72k0UCtKSNauhs2mW1Tbj/OXltWazx
	pXbCzvusKMMER36VnvYe5Ue4ni0CS2gf+27eRjrTowMBZJpMwf8FemdAjPLNgS7e
	2Q7KbrX6oDfW7OhOW8kmUwEtHVQOJfOhCKJutJW31tIVK1jx3tlBm/FfOeMM3Wi+
	HRyJNIvn3ZfaIduBvX3J/esX1LyvRI4+29Gab/Mo+E9ipB0JB+Eg6bXTQ3cQodbq
	Ys9tIoHfWbuwHzjR/i+2IQUtyNXzDM0uYGA==
X-ME-Sender: <xms:kws8Z-JiiB2X5Q_4AwbUex8RllW8d_OusuR3HT1nPcWky-YzvsQYRg>
    <xme:kws8Z2JCN4i3sXHSdQ9h7DPxfBO2uTSislXIGNAImtYzqrh9ZmoySXyEvu9DPudhs
    H12kAvu55N8hFk5rQ>
X-ME-Received: <xmr:kws8Z-un48pVVULJhNWQj_k3B24JNsEI5_mjy9-LdanwcAMm0dmFUoQp9_gZ7pDtIKgnvEifGCshEtdBUBBx9TS1b2Jpgh26tQ2F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepihhllhhirgdrsghosgihrhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kws8ZzYNU8exL315Yu-Snh6EIMWZGnFLi4zhqOqTLEOMheLvKQd27A>
    <xmx:kws8Z1boRroPSgcmeD79sY6qryIErNJuOkDH4t2dFmI4JtwroGuGEg>
    <xmx:kws8Z_DMHEnwUBml6ewVl-JRKeC8VoL8QNn27V9XtFAzfHFJQrnDHA>
    <xmx:kws8Z7ZzQIGK3zD8AUYcsRgXtLxsmGhTIOP1W20b-JEQiQrha0d2Aw>
    <xmx:lAs8Z5HgV-SWfsV_iHEkuCrVo4VEYOpnptEVh7BOODRUDhdxW-pljgKx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 22:52:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Long names for `git log -S` and `git log -G`
In-Reply-To: <24458598-ebbe-41fc-8517-457fa65ed481@gmail.com> (Illia Bobyr's
	message of "Mon, 18 Nov 2024 15:56:30 -0800")
References: <24458598-ebbe-41fc-8517-457fa65ed481@gmail.com>
Date: Tue, 19 Nov 2024 12:52:50 +0900
Message-ID: <xmqqo72bev71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> Also,`diffcore` docs says:
>
>> "-G<regular-expression>" (mnemonic: grep)
>
> I was thinking of `--pickaxe` for `-S` and `--grep` for `-G`.

In the context of "git diff", calling "-G" "--grep" would be OK, but
in the context of "git log", there is "--grep" already, so that
won't fly.

> `--pickaxe-grep` for `-G` seems like a reasonable alternative name for `-G`.

That is probably OK (even though "-G" is not exactly what the
pickaxe machinery wants to do; "--grep-in-patch" might be closer to
the intent).

> Not sure what would be a reasonably short alternative for `-S`.
> `--pickaxe-occurance-change` seems too long, and might not be as clear.
> `--pickaxe-occurance-count-change` is just way too long.

Giving a tool a meaningful name is an excellent idea.  If the
meaningful name guides users to the right way to use the tool,
it would be ideal.  Which means that to name it right, you'd need to
know what it exactly is for.

The -S feature was written to become one of the building blocks of
Linus's "clearly superior algorithm", described in [1].  Linus talks
about "where did this _line_ come from?", but the algorithm is more
generally about a block of code.  The expected use case is for -S to
be fed sufficiently unique block of text so that we can efficiently
detect the transition of occurence count from 1 (because wee start
from sufficiently unique block of code) down to 0 (which is the
boundary in history where the block of code was first introduced in
its current form).  It detects any occurence count change, but its
primary focus is to find a transition from 1 to 0 (when going
backwards in history).  Its spirit is more about "finding where it
appeared in its current shape".


[Footnote]

*1* https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/
