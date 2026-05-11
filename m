Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE97081A
	for <git@vger.kernel.org>; Mon, 11 May 2026 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778465189; cv=none; b=Zzj1olWeJFUfGCFSqIf4MtLH++HD/sVFQUdbVb19g5/cP2pGzX6UmQSvHni7/hXdoFjF74D6paCBd/Oe0MzFUlkJy5fEplEDRw/KoEiFGKe7zzqCVGGIImtT/SFoC5v2xzR5IEGgZvtKE6sej0Kys0x/EDdG+u/Pbvc3jwaGhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778465189; c=relaxed/simple;
	bh=VuDMcIRz98R0WeJSJ7n5DF7xuMDOoC3zaNiJOAszXnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ce0txN2cPyMq8CxBHcuDSpHYATFNry55oIMq9eyYlSTXtLk47oV7uwBYmWtndlHJNpqGVccXj4rBp1oGD/uEk8GSkkIk9saVuzk050NRT2Sc1ezz8ENAQN2vLxlOLgdWNbYDOeBBmP1JxKwSMut3xC8HxfJ6yffv3f/zPbNOx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cByCawfD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nQT8RTGy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cByCawfD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQT8RTGy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E6A87A0087;
	Sun, 10 May 2026 22:06:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 10 May 2026 22:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778465185; x=1778551585; bh=HfTVxLugwB
	Y1ne9+X90eDCSvfKNy5Yy/rDh0UMBWKj4=; b=cByCawfDkZFLpk3+hfSbsSoUs6
	hm8wRgiTqx1mjyIgjRSvFMZ50Gl48gPBTJYb3r2mdkuJXHpHMPf8X/f+99+lmH/L
	jB6Js/Q6jcIBAK34zV7dmu3y2Pok1nN6Zw1PWXeC+6KMFInQQ6V4wdBfVtt088+J
	vhwQiI7i+qfqRSLXOHtkMNpljlIikmgIv9eblakPOsjVxzaXocAZyf7LnZnrcAPy
	Xfhc5erCd006c/HD+JwUWSyTEmqWqteqVO7+AixK9Alofw3H8VicnVCPYbfE1Ecd
	TKx8tHD8/njNnnaFZI+bU8tdbT2Z8MXLiXPTmlY3gxLgYGT7bQ2MDrtDJMFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778465185; x=1778551585; bh=HfTVxLugwBY1ne9+X90eDCSvfKNy5Yy/rDh
	0UMBWKj4=; b=nQT8RTGyt2IHCoqFXzAjYpnAUQDySJWDka18RDSf9wsfwGVrvUw
	Nkq69HJiray7cESjnkqydn/jeA6XSjqyrac7zyYXkvEhqrZyIfYNoWveR63QE7CV
	jP9wcCpkrLU2BLx82v2zLqG00WZ90yp/v6kbNdQ2/U2vRhE5lGW0YblBXLKOK4Ic
	ALpY+ycMI9TfFBLo08PuzlbTys/I9d0hvc5vYdL9CmEO1CN9NRdWa4qkjq6Isunk
	OfSTtTiZuUuXGaYPO5VcmTd5hS3UyAuS15atmXHBIN3BoJXdIEJXssZs4TMh+de5
	MPkDYUbDjk4rEuRBTUQf6k4TuAJm4rBE2Dg==
X-ME-Sender: <xms:oTkBahVfskQSF6ABamZ7xbDiY5c508KMk8v4BK_JNa3JJGR4DeH3PA>
    <xme:oTkBaoka6sEfa0Cga7m_DwXLDulIOh3Rm3SXa0M5bEOz6W_e3Tquf6Mu0nfIa7mx6
    Ctj6ipC2xpQMQ1kBXvVzOEPSnKzD0uaPmsJW40M2qbJIQGgpqKzmA>
X-ME-Received: <xmr:oTkBaiZwupY_c-vFMyCo67aprD77cQ8fC9XMnury8cqLPJ-_lSmUvmAqO3tYVy68ZgRkZJXpfCCPV6JRDVm2VvAI3yQSZ0BPeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghv
    ihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:oTkBajPyS96OTdyZAWiapMnoFbZCjo9tJ8XeIoyM4idPuy2zrfYUoQ>
    <xmx:oTkBanYnNRBGvtBDAbkr0iQMOSSoCDrIm-CgOyvYUC2p6mTphRLaJQ>
    <xmx:oTkBah0fdKu61CKJlM3NlSf_aVeM3wBQxchigDH8v_Z4HHQsorfcqw>
    <xmx:oTkBatdgDLFbf8T1x_-EY_OKEeoOdfKR_BBc9sTTFg-4fhY4mFBavg>
    <xmx:oTkBaoaRi38lKEJ5QQjVgqXKoxNqn8D_hjlS9_j3AOSo0OiRKogjtaQb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 22:06:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3] doc: clarify --follow and log.follow for git log
In-Reply-To: <CAJ-ks9n=DcwqyP7K_q0Ki6_3_+o5=558FK1DKr0+VyiM7q69EA@mail.gmail.com>
	(Tamir Duberstein's message of "Sun, 10 May 2026 21:28:48 -0400")
References: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
	<20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
	<xmqqik8u95yn.fsf@gitster.g>
	<CAJ-ks9mPzCr3obAw5cE071GNjzy_ZLzF4mQdnUbQY5H4WPw3sA@mail.gmail.com>
	<xmqqv7cux0q7.fsf@gitster.g>
	<CAJ-ks9krzLO_+O74omAfeVByUBh=rDGSVSarf5PGwkdWepzubw@mail.gmail.com>
	<xmqqh5oewz6c.fsf@gitster.g>
	<CAJ-ks9n=DcwqyP7K_q0Ki6_3_+o5=558FK1DKr0+VyiM7q69EA@mail.gmail.com>
Date: Mon, 11 May 2026 11:06:24 +0900
Message-ID: <xmqqwlxavgwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

>> Doesn't the current text for the option
>>
>>         `--follow`::
>>                 Continue listing the history of a file beyond renames
>>                 (works only for a single file).
>>
>> pretty much cover that, though?  The configuration side is a bit
>> more verbose but essentially says the same thing, I think.
>>
>>         `log.follow`::
>>                 If `true`, `git log` will act as if the `--follow` option was used when
>>                 a single <path> is given.  This has the same limitations as `--follow`,
>>                 i.e. it cannot be used to follow multiple files and does not work well
>>                 on non-linear history.
>>
>> We do not say anything about what the feature happens to do when it
>> is given a non-linear history whose branches each rename to the same
>> final name that you start following from in the more recent part of
>> the history, either, and stop at saying "does not work well".  We
>> should treat that case the same way as the case where the user gives
>> a pathspec with multiple pathspec elements or a pathspec that
>> matches with a directory.
>
> Sorry, I was unclear. I was saying that the documentation should be
> explicit about the cases that constitute "undefined behavior".

Ah, I see.

I am not sure.  This is not the only case where we have left these
unspecified things unsaid, is it?  I am not sure if it is worth
singling out this particular case.

Thanks.
