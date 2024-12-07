Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7780BFF
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733615018; cv=none; b=J8BBEuVCoz/63mL/Fz1k7OWGFz2l1xSj+Bjqro7/Ybjq/76y3GnlIkbXN78ZJCFbb3hXJGe2NCH6KbaiKSA7fdAbZUhj7LZTjf9qL+So90xfIFRMFeiiHOPic6wsU94lnc3wz6TCEejf5v3dnIql0+b68BfWvdt4iEBwO6lyoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733615018; c=relaxed/simple;
	bh=KFRzUePSjkHUWvCQaejr6jJxXEzIKElnweKJvPzZ/LA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=egisEksstt2tWLbiOuuxNp08EjX6IrPeujhkknTLhOigdKRnBZOWrsiqy0FaTnGrfAA8y3pihIoFdTjNKq5vGDsDKNrGbYDYWMAIT2gt/xG1N4QermjktPImnQIDJh3XPddJlMvRcukcxVphDEzw+ALp7IhCI6+mniJ7YXBOMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pm3E7IfT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pm3E7IfT"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADFBE114011A;
	Sat,  7 Dec 2024 18:43:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 07 Dec 2024 18:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733615015; x=1733701415; bh=zRaS+yn8kozzPIiPylAQMkBIKUb3QY8IpEm
	BWMSnfM8=; b=Pm3E7IfTRZEz/5Go/I155ThhGPE682aBe8i5XhTijtiDqEKdUG9
	JOSt1yTLo3OFvW1UNieY5f+7NbwNdKpOCu5Swjke1dOA9KbDY5VN8czJ+nM0G/7G
	yymdw/UWYhWWz0oBb3d3PXollzPMsdYj2BZ24CP19x205iO5gBJ8+W+d1AMJKP0x
	lfZXnAgIZja9TNs9YEYOyJMUHBX691uDiXEncc9KrW3o9O361Wh4ZRZFCSXHSM74
	0La8lPMpWVNxhT93/6pEOzuCgthOJLx+hz+8NoX6dEeBPegRx2HcRP6uXh3MXvtG
	DTs2A/3xqLWLbAL9ToQ2/zch5ELmmcHU+Dw==
X-ME-Sender: <xms:p91UZ6_Qwo8CpXJ95vBJiN8fFxAIfnmhNKMNc02Cw7uwRxFPf_aXyQ>
    <xme:p91UZ6swuqj8e6li1qjLn2Eib1MoKoybYGCg96tuZIWqYgxXcMJT88Ke-V86xY8NR
    n_8vl50voqiXmUxGw>
X-ME-Received: <xmr:p91UZwCzBD5xUzfQY3XWQAd1K96E1fq_BsNJ3xCU42-5_pBysWiEyzoxRS7cRET7IBQL9zEH28hbZEMzDTm_6iiAZnYhPCmYxZIwUb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedvgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohihvghluggrrhdtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p91UZyejtemrBUGfi6O9wqOuWlWXKUbM_ETPP6MNxsHR5AzbXbcxZQ>
    <xmx:p91UZ_NFIylrhXQOae5FEHSMDjTnYg4ymDbnOhvUHSWOg8110vnogA>
    <xmx:p91UZ8m2x-vgGq2AmC_jYOazRW8nqQkj_q_AOqpED8bpRZq6QBTgPw>
    <xmx:p91UZxv7KhQAdi2A2eHB2eccP_eDYcEJctieb91Ws1WQlTXTkqeRzQ>
    <xmx:p91UZ61bc4KQ9bAMrmZxYm37xAiZaHrd6Oj5SbAspQBRJV7FXQLT8Cq6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Dec 2024 18:43:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Roy Eldar <royeldar0@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-submodule.sh: make some variables boolean
In-Reply-To: <20241207135201.2536-2-royeldar0@gmail.com> (Roy Eldar's message
	of "Sat, 7 Dec 2024 15:51:59 +0200")
References: <20241207135201.2536-1-royeldar0@gmail.com>
	<20241207135201.2536-2-royeldar0@gmail.com>
Date: Sun, 08 Dec 2024 08:43:34 +0900
Message-ID: <xmqqzfl7rrdl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roy Eldar <royeldar0@gmail.com> writes:

> When git-submodule.sh parses various options and switchs, it sets some
> variables to values; in particular, every switch that is passed causes a
> corresponding variable to be set to 1, which then affects the options
> given to git-submodule--helper.
>
> There are some variables are assigned "$1", although there is no reason
> for it; this was actually noticed in 757d092 for the "$cached" variable.

Wearing devil's advocate hat on.

This can cut both ways.  If you are doing a thin wrapper front-end,
when calling into the underlying machinery that has its own option
parser, it is often easier to write and read

    submodule--helper $force $cached

instead of

    submodule--helper ${force:+--force} ${cached:+--cached}

In addition, when debugging such a script by running it under "sh -x",
a typical construct like

	if test "$force" = 1
	then
		... do the force thing ...

would appear in the "-x" trace as

	+test 1 = 1
	+... do the force thing ...

if you force yourself to use "1", but 

	if test "$force" = "--force"
	then
		... do the force thing ...

would show either

	+test --force = --force

or

	+test "" = --force

and the latter is especially useful when you are wondering why the
"--force" you gave from the command line is not taking effect.

Having said all that, as long as the use of these switch variables
are done consistently (e.g., consistently set effective ones to "1",
and consistently set ones that are off to ""), we are OK.

Thanks.
