Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060322075
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251265; cv=none; b=q3i4eBAdzkMsywHG/M0U4nD07vaL7kGpUx/Ihphhk3jiVaH/xIkDR33Nhe2FBZivRQtoELt/KDGcJUZFWCuAwyvP/REmLUWYGYqntfeqiRSmGUyvR/O/rSCgZ5qv4YKV9HGXFH8xqcadcm3xLLya5LO9uuS5QQ3CQy8F3sHfkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251265; c=relaxed/simple;
	bh=pNasJztIfKWrNaXT23GgxipjdZ6yNxbnp6/1RSOUo8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bc04xTSL8Ty3vAnHvYPQjnZid41Rwm/Hhs8I21RY7SU0ci9o1wuhI1wU4QF5ivN4F5oJLRHyLwoqNqX/aqGP5cVPhTzG+ucr0nNX1m01q1fazvJjgneu+EJ8oRxiHM4a1UhCfTnRi36raWkZK441eoZVejksVjzFZuD/6GfO4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kHpXmm9F; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kHpXmm9F"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 247181380145;
	Thu, 21 Nov 2024 23:54:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 21 Nov 2024 23:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732251262; x=1732337662; bh=5K6mkOaUYEAADk86D9BV18qqQsS0OYe8GYi
	2QK6x4rc=; b=kHpXmm9FgfBEf1i7gdwsSWcw0/EG//YSbnHdd29dHGXK3sDy+NH
	MmnlYWGeyzdfK1ART2WkL+qMUblZzQGzsGXDv29oYZyK2nUJLyQpKxmNIDexXX0t
	Ehiy93Z6DAFnsXpCqsRPfxhyjktDa46nAuWcsvcp5CnzfB9D8ZOBEkFdcYzyFDu7
	ygUFY5vl9YuSeYUX4rNmqPvOtdCmekRmnrl7lEeQj14vZD2uzHV10RVzgkFabqTa
	Ws6HPzuIUu6gPX9Z8CWHYBvxqybjABEaBFA4AMpLuDI9q1UTzHzSPBCvGVzslhRW
	+2FBD58bJjKBo4YAa7aSXcR5xNtM+nRdNEw==
X-ME-Sender: <xms:fQ5AZ0PrFfibVkh9FvCqyOLDM9_FKzCJ9KNm8IAVCH4mMuXb_44r_w>
    <xme:fQ5AZ695bZbjib9aeVSPHO-lTEgKc_VulmXxvcHX0AQmBhu7CcW5xI3_NEad5pvOf
    k4eJQmrjvQuY43mRw>
X-ME-Received: <xmr:fQ5AZ7RhpE6IboBQK8g0Y3xpnamIoLVpYA8pJIo-TW7kPOl5MW21X4kQA4JLPxR8wPQfgGInGYdFp7kI3Z_qMX6Xpi8jYoVtQwJv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fQ5AZ8u9mJoZ2x2U9OSt6W9pXrpA1Fc9HslBO1X9DdYiG6RARH-VBA>
    <xmx:fQ5AZ8f19Eq1zTxAzxL4ouh3VR5izBy-E1oqFKT3ZY-o3SuxKDOnJg>
    <xmx:fQ5AZw0MeKXGCiCXRYD6yZ9i1ppYl5eZTCisVGqW_9SWULK9DcDa5g>
    <xmx:fQ5AZw9hiiPiyiTDaU3dNkc3s7qkbd2XhdRbttfqUGNc2Fic2t4LaQ>
    <xmx:fg5AZ07nVK-tz4yB4p0rbur-hjZVg8YTIWpsmfc4YNS92W6e0e_c06_n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 23:54:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v14 02/10] t/t5505-remote: test failure of set-head
In-Reply-To: <20241121225757.3877852-3-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Thu, 21 Nov 2024 23:55:02 +0100")
References: <20241118151755.756265-1-bence@ferdinandy.com>
	<20241121225757.3877852-1-bence@ferdinandy.com>
	<20241121225757.3877852-3-bence@ferdinandy.com>
Date: Fri, 22 Nov 2024 13:54:20 +0900
Message-ID: <xmqqbjy7amwz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> -			result |= error(_("Could not setup %s"), buf.buf);
> +			result |= error(_("Could not set up %s"), buf.buf);

Good eyes.

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 9b50276646..4e127bf5b8 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -432,6 +432,18 @@ test_expect_success 'set-head --auto' '
>  	)
>  '
>  
> +test_expect_success REFFILES 'set-head --auto failure' '

Writing

	test_when_finished "rm -f test/.git/refs/remotes/origin/HEAD.lock" &&

here allows us not to worry about commands in the sequence before
the "rm" below failing unexpectedly.

> +	(
> +		cd test &&
> +		touch .git/refs/remotes/origin/HEAD.lock &&

> +		git remote set-head --auto origin 2>errormsg ||
> +		tail -n1 errormsg >output &&

Are we saying that it is OK for set-head not to fail here?  If not,
then this should be

		test_must_fail git remote set-head ... 2>err &&
		tail -n 1 err >actual &&

instead.

> +		rm .git/refs/remotes/origin/HEAD.lock &&
> +		echo "error: Could not set up refs/remotes/origin/HEAD" >expect &&
> +		test_cmp expect output
> +	)
> +'
> +
>  test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
>  	(
>  		cd test &&
