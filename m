Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44277156222
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786113; cv=none; b=LVPRBHU6n2DdMwmrRucBEaiQ5nn2qMNZz1kRO3RKlTkJIMQ6LzRU1T6EuTzWdTUMyxTwT799qYCYWQzD3/+tp9Xs9yFRSsVVjEl+45lk/PNbbt2e8kteSJoyrU8CsJfmy4evIXj6vR8tpJZ1VltrtyFjsoWDZA9VEaJXvo0mKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786113; c=relaxed/simple;
	bh=NkorW+QmR3abWfa2CXxSoigpadcOtNT8wHXU2xxcSVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AFxmZcO2qc1pmL2jBT3pHS1UZKQ+pjCz4i6e9Elu2/sc51qQb1MsRoMSuILTBW3zq1E1A3RDskvm36GRgm1OLA9mvUdejfCkUZdHs2rcic42glfN/yVghwXG1v1JvgTu8OsW5jpQya0Ez4ixOJgqXL3vcAuZbTPsqIqOBSyXdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIIaGyk9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIIaGyk9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F2C10138025C;
	Thu, 28 Nov 2024 04:28:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 28 Nov 2024 04:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732786109; x=1732872509; bh=mDmcm1ljl1QJkFyl+1it8QVIk9KRpGGM4vm
	SpMzFFiM=; b=eIIaGyk9PB/otiMp0g560c1kirgVYGCAnqaVOC5C8QcGIxRjH+t
	UQk96PaCsZvNCm11FY5qG48nZlGQquAIZhCz+NiWP+Sg7fjuM05bAju9YvLLxfVR
	QbCMGib72OXrgigyTs60pgXi3+UfjuFeySTKm+AROcKkj2WrtN9sjfvKP/c19mx5
	lux0ZW+HXeW5diljr3aDzkYnTREUKmwHZy7xncVo4dD8EGfQLBDMRId7owdPPvLu
	ecKQ/DMfTuRR0dEjA6Zx4HRAJCP7ykWHNujM7NPThx3CSoWpnLH+vCwz1ZbcCHSN
	aQFoNFm5nQuf5gloWt3SzGLe8q7TeX5+wqw==
X-ME-Sender: <xms:vTdIZ8vBS9t2EXYpGcIpfsNYA21tUHOtGmINDixQcLgVKdPWk3uSIQ>
    <xme:vTdIZ5cBeGhkl3v_5QLAFXVh2VsiqXHLzUbFJaKrTFI-zVU6m351jQbZktq3z2DYw
    -ZJw8xduX3I788DSw>
X-ME-Received: <xmr:vTdIZ3yvGq28VqwAdlk2lQa1Vr-K-1gSgJuL9cJsvUvaoe8vZveKjrL38CEJ6gHnlCpFa1kB3ePqTBcWDALc42zCvvSqXsBwqNFrIcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vTdIZ_OLOUHVeU-88z9AE_mpLcKlBj99RYh9krfbRT6EyhmJnSB15A>
    <xmx:vTdIZ8-shHNZsUsAD7RbfrvLaeC8o-vyzqrq-DW_z3cXQ0xMauIQxA>
    <xmx:vTdIZ3UqerRiaZ9pW_6lnlO08lCggvyGP0wvXri6P1WDCGNJBDN8tQ>
    <xmx:vTdIZ1fDoqZD9MmVGAAM5xzZkYJZDJUt4bS4Ilh75DSmXQHk8D31mg>
    <xmx:vTdIZ7mqePymsEjHjfvoJJsIQzHIinpJIAgjfxksi1GtaqKKLDjUM35U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 04:28:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] CodingGuidelines: a handful of error message guidelines
In-Reply-To: <CAPig+cSXGreymhni_J8TZ56rp+VZB_Z7ekaRtwFdxE3a2QWS5w@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 28 Nov 2024 02:57:03 -0500")
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
	<pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
	<79f6027b-123c-40a6-975b-1c6053b9391c@app.fastmail.com>
	<xmqq1pywvmhq.fsf_-_@gitster.g> <xmqqa5dkqjmr.fsf_-_@gitster.g>
	<CAPig+cSXGreymhni_J8TZ56rp+VZB_Z7ekaRtwFdxE3a2QWS5w@mail.gmail.com>
Date: Thu, 28 Nov 2024 18:28:28 +0900
Message-ID: <xmqq34jbogg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> + - Unless there is a compelling reason not to, error messages from the
>> +   Porcelain command should be marked for `_("translation")`.
>
> Here you capitalize "Porcelain" but below, "plumbing" is all lowercase.

;-) I think that is how we spell them in our documentation when we
contrast them against each other.

>> + - Error messages from the plumbing commands are sometimes meant for
>> +   machine consumption and should not be marked for `_("translation")`
>> +   to keep them 'grep'-able.
>
> Using the same example, `_("translation")`, for both the "should be"
> and "should not be" cases may very well confuse readers. (It certainly
> confused me.) Perhaps mirroring the example of an item earlier in the
> list would be clearer:
>
>     - Unless there is a compelling reason not to, error messages from
>       porcelain commands should be marked for translation, e.g.
>       `die(_("bad revision"))`
>
>     - Error messages from plumbing commands are sometimes meant for
>       machine consumption, thus should not be marked for translation,
>       e.g. `die("bad revision")`

Thanks, that is much better.  Let me steal it verbatim in the
hopefully final reroll.

>> + - BUG("message") are for communicating the specific error to
>> +   developers, and not to be translated.
>
> Okay, although could be slightly more explicit:
>
>     - BUG("message") is for communicating a specific failure to
>       developers, not end-users, thus should not be translated.

The way I read your rewrite is that the "communitation" mentioned is
between the program and the user who saw the message.  I wanted to
say that the message is seen first by an end-user, and then is
communicated to developers.  And not translating is one way to make
sure the message is not mangled, and stays grep-able, during the
game of telephone.

Would this work better?

  - In order to help the user who saw BUG("message") to accurately
    communicate it to developers, do not mark them for translation.

Thanks.
