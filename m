Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFEDEADC
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765067652; cv=none; b=KL9qQzuskjOI2V3j5DDSJNgAAEVioKm60tSW86yGzH7jnTtvbR1vVjJPOV+9AM9lX+H1tV1Mjg3f6cJRlQ+X4QqMj/FtOTWwRKGetBn2B/OwoJhcVmuQa6ecU3uysHBp6dXlYqkSgS5GhLB9mBYvfRBn4c5vTecpmMh6oA7+ToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765067652; c=relaxed/simple;
	bh=sMlckUih76gOzgtQeDYx33dEt7lCkeb9J3j5nwXz23E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2XnTTRQvK6o0/vMMoUr19bAd8AnbQ2Y+o0xwCK1KYHENf7O5e5gVkT/qfNG8EsXAW2OsdxTjG1StHH+CQhPhiD+yRVLx/WoFTHIhEZ/I+cRaDlv+rEzozhaeFgFyo5Nei8IOlnkbcuoY36J7pugs+umL9a7sWpnw1IfuHWyDqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUFqEJf+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y4DynfYS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUFqEJf+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y4DynfYS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DAC1EC00C8;
	Sat,  6 Dec 2025 19:34:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 06 Dec 2025 19:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765067647; x=1765154047; bh=3PrIT/MP+p
	i1g5qxPGuXtxS93D6hclxHwRFjAbXEhDI=; b=AUFqEJf+2sQwVJz9xeZaQ1tdRE
	Q2FlfJP9zVL9SSlQKZHcZNts92OBBpb8x4w1ZF6g3Q0N7dx3nD419wBQ/Yave1J9
	IY4BuyoY9vb+T7RKcbjuu+PKOtgXGEDNKvvgKh4fQf9MA59hyLtPZxKnNkvZcxjg
	+Woq5ICxgyF3LSH4BpKUHZrX163+gx9aNXX67RIpySrJEZEDm16YkGUARcr61yvr
	/uiUa3fTUmysCpyi3rGJJfv2JYqmIEGCFUolAHtx/xjSMsSqKkKI07sXk/onvRYP
	buYSAifqKcn5AIErIaa4Jx9cDVX0RAbkHsSLdg/w8RLYHUeuCkGUZW6bqhyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765067647; x=1765154047; bh=3PrIT/MP+pi1g5qxPGuXtxS93D6hclxHwRF
	jAbXEhDI=; b=y4DynfYSuUV1YhUvO/WZbdALNmwb5wg+JmWsZgxDHBLeQQqh66T
	vynKV+TehXYJVZGDSwwUiw5YJRpiwf3RGPVap+BOer6nWtyXmArfHS+gAYJ1y8TV
	LbXpyJusDxxY1itk70qurccSntu/+3K74W+iGlDiwy7GbBgztwTkYwkTs0dYmm2F
	d4hMO7lyP69aoedwhMFaFNqD8fbqkQ0XfMCr4GYV03P5wbFXd4BvacE/6Hlpa9M9
	t4RYYAFdGSQ6YIuBJqzF4xqh2NdTOGxCm6CHsAk9o1oM+nrTW6Ul1Q1i1LiIwRvz
	v4PVXCQrz9xSwyBs2czb6C1t0JzE8KP0fxw==
X-ME-Sender: <xms:fss0aaoX6YMWfv1Okv1qtCfprKwRvFQXPCCNX4gx3qdZAX8Y6hzxZw>
    <xme:fss0aXvKomA1sRt-K9rCLlZAjE3tXXc2eiCTJLMRivxSe3SYzveP9q9mkbq8CwV0F
    FzT2CCfbPGAvsyq2BBWodiJeAJN1vNZUpniQDvOnPa7jDuEAhg41g>
X-ME-Received: <xmr:fss0aVZ2K04r6MOJn7zyE_CE3xThbyLigNhQJqMdjVf8maa2EeuKcxfmX23pHDS4ydDrXW6I-uIntNlnmI3panXq6T_k5IBMNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgrthhthh
    gvfihhuhhghhgvshelfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrthhthhgvfihhuhhghhgvshelfeegsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fss0aWbEA3WwKbpGTakDhqQwOquwEdwVnfOt0Jglv5NBqC5g8yWUgw>
    <xmx:fss0aenRVN8AxpAkN2p4LlVOsRGlw4OdDE-DsDhjgexs14GL4pRJcg>
    <xmx:fss0aR20OL3Xqn-UKPZAtHK5bdcSD9jLyF2YAZ4Q36hJltc-70FXqw>
    <xmx:fss0ae0OdjZH_X96gTjp0Et9qHkReIATMN359YuursW4As6FKu68CA>
    <xmx:f8s0aefrkr3aPYhuI-zA4XneOE1QbWpjxSvJwVIpHTUr_NwBCsgVQCO9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 19:34:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Matthew Hughes <matthewhughes934@gmail.com>,  Derrick Stolee via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  atthewhughes934@gmail.com,  johannes.schindelin@gmx.de,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 3/5] scalar: remove stale config values
In-Reply-To: <aS88bnmZXMZCV5oS@pks.im> (Patrick Steinhardt's message of "Tue,
	2 Dec 2025 20:22:22 +0100")
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
	<8783db6153875deb52aaa354da189ae611de1057.1764607847.git.gitgitgadget@gmail.com>
	<ciegbs72xbepxawuf42pne7eu354ntbok5e3p6jxcuyddvaea2@6ykt3iej32xt>
	<aS6bCU19x-QM84tp@pks.im>
	<zbmzxqckpmf3h2sc7g3zvrhcyur2kmanv5uz6nyd2lgmi2it3b@i65jeyvcvqqy>
	<aS88bnmZXMZCV5oS@pks.im>
Date: Sun, 07 Dec 2025 09:34:05 +0900
Message-ID: <xmqqms3vnn9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The logic around this was introduced in 2a9dedef2e (index: make
> index.threads=true enable ieot and eoie, 2018-11-19), and the ultimate
> reason for it seems to be backwards compatibility:
>
>     index.threads and index.recordOffsetTable unspecified: do not write
>     the offset table yet (to avoid alarming the user with "ignoring IEOT
>     extension" messages when an older version of Git accesses the
>     repository) but do make use of multiple threads to read the index if
>     the supporting offset table is present.
>
> Older versions of Git complained when they see unknown extensions, and
> we didn't want to expose users to such warnings.

Not "Older versions".

Any version of Git should complain mandatory index extension that it
does not understand.  And any version of Git, even today's Git,
gives a note when it ignores an optional index extension it does not
understand.

> That makes me wonder
> whether it's time now to revisit that decision -- it's been 7 years
> since then, I guess that many clients nowadays would understand the
> extension. 

I do not think 7 years matters.  The only reason you might see the
"ignoring" message is after using a newer version of Git that is
aware of that index extension, and then reverting back to an older
version.  As the index file is a purely local matter, it is not very
likely situation to begin with, and when it happens, the user should
be made aware of it.  Not understanding an optional index extension
is not a breaking sin; but being in such a situation, i.e., the user
is using older version of Git than they once used to use, is a note
worthy vent.

So yes, even this logic was introduced last week, if the only reason
is to avoid showing the note, that design decision should be
revisited.

> The only (documented) downside should thus not be that important
> anymore, but the upside is that reading the index would be faster if we
> default-enable writing the extension.
>
> Patrick
