Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCC1FB3
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147438; cv=none; b=urQXChLefV0Qh4j02RdqEWnA9+dTlK4FD1r3aPPsG7DCwxlcN2l4KqO+/roJ6lP/VGtsT4Z80PKImUXEdvALSecSDCUGITMfnGmkN23+ueimAzjTUS6C9xScjtbKJZqbzJ3Ra1sM5FVGI1vAODKI7lnsXRJ/ju3H2z4CHj3gDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147438; c=relaxed/simple;
	bh=46BsXemHGZqmcn0H0udfJbMHAz8a+xzQuQfIEkdpNQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tA66lRpIiMjH2zmxVQ96OaWPtXKXCpAO2onN7ZwUDlORZMq9ad/2NlEQW15kLWZ0dGhDaQ2KWWiVCtbjIhZxb4F+TdniN0TZej/6f6JQbuW24lwQUxvSD0bgsq5HEPaWVltQvjmCSOhRwyvTF2ocsPbJ3j3ZRf1HlRfmASxuhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSSSCfam; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSSSCfam"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F665254007B;
	Wed, 20 Nov 2024 19:03:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 19:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732147434; x=1732233834; bh=FAORQuRebGuzHlm/PGflBhA/66TeFMVVw3w
	THueIyp0=; b=fSSSCfamAYcjAs356OFI0zyAmIKEQlLiOmwl9C/JGZqdj6u4Cbw
	ah2Udx/Z39/rqCRxHhaD8vO6D+MYKSbsMJawtrzunWB327m8z8T/A9U1x4AjI7So
	1UFzra+EiUK7v9J3xlvK58OqDCkIbXUoEQ8FnZ3oIXWiygzuC4hfmMsvZD30fSv0
	DJmUPgU0dD30/QqJrBK95PD4L2y6NrvCvbWzKPMFV+98xD1Fme5hSfmbwiHG1LpN
	Mgg9S5B9iKMiQZRXwYStNlwi/yokMLvLkqGfiRVuzT+z6kQQYqm1aa39X2Fo/Vw6
	mSbjY3fO6b9XLZ9rV27t456YFpwkPQjxQww==
X-ME-Sender: <xms:6Hg-ZymbhLG5l2Rj4gUsAH0u5ChgpIV0_qVe9GGyqSOynuERGS9qaQ>
    <xme:6Hg-Z50Cn5gWqnxaTf6jglehnpowI3_sDHEkWrcFQASvJIh1mwQUBra6psXJ21qrX
    -nvC94dV0JVtKeBQA>
X-ME-Received: <xmr:6Hg-ZwqDKV52btr9yZuRyXfx56u6AWFa_PmqA_L5OhimePClwZp7AF18ouGP66HrU0vu5nK6fp2dtQgE_y5rM_4Y-PYcK_KHcM1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhi
    hjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:6Hg-Z2kzgyH_eMlCjDSH1N8cRDqAPCd31DaMV2VtVCGhayYNIXRHgg>
    <xmx:6Hg-Zw3-HNRQftZXnJDXMC_q-MM3YyS8R7LjQZh8pJJGDgiSYaS4DA>
    <xmx:6Hg-Z9t1elfQKEy8KSRH16iifI7ifcsnqg5Sh8als3S-ObEVRWvseg>
    <xmx:6Hg-Z8WBiEeGYiJtaoUEFWk__8txR_-LLfmgGDpqitCKUWtKrQFfKA>
    <xmx:6ng-Z1u11fBu8SOonfkYpWpl2f2y67LgcEF1tPw5U8jO1EigDI_F3cmq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 19:03:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Taylor Blau <me@ttaylorr.com>,  David Aguilar <davvid@gmail.com>,  Jeff
 King <peff@peff.net>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 03/23] Makefile: refactor GIT-VERSION-GEN to be reusable
In-Reply-To: <Zz2vkNtvoKayaZyT@pks.im> (Patrick Steinhardt's message of "Wed,
	20 Nov 2024 10:44:55 +0100")
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
	<20241119-pks-meson-v8-3-809bf7f042f3@pks.im>
	<xmqqjzcy7ehv.fsf@gitster.g> <Zz2vkNtvoKayaZyT@pks.im>
Date: Thu, 21 Nov 2024 09:03:50 +0900
Message-ID: <xmqqfrnlh2qh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I suspect "%cs" is more in line with the spirit of GIT_DATE if I
>> understand its purpose, i.e. "this is the time this version was
>> recorded in the Git history, with the intention to give it the public"
>> and better than "%as".
>
> While I agree with you, I'll leave this one as-is for now because this
> is preexisting logic.

Ah, then please disregard what I said.  We are not _fixing_ anything
that is not broken in this series.


> But I'll rearrange a bit so that required
> placeholders are only wired up once they are actually used so that it
> can be seen where they come from and that the rewrite is faithful to the
> original logic.

Sounds very good.

> Yeah, being consistent would be nice indeed. But for now I'd prefer to
> keep this as-is because we'd otherwise change the version schema used by
> CMake builds. In theory we can use 4 numbers here, too, where the fourth
> number would correspond to the `PROJECT_VERSION_TWEAK` CMake variable.

As I only write vX,Y,Z with three numbers, any fourth number a build
system comes up with has no bit of information.  So we could consider
what we use is 3-number scheme, and supply a fixed and meaningless '0'
to whoever wants the fourth number.

Which is essentially what you are doing with the "split $(echo $V 0 0 0 0)
with 'read A B C D' construct" ;-)  I am fine with that as long as
we have a shared understanding documented somewhere.

Thanks.



