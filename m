Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204820FA94
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274991; cv=none; b=bLwCcAch7t2btuEqgehnrmUo7KPrUEmYOSGbtKs6lc80vqZagq6rE2whWZQEM1sEViJl0rVtMBhbKxag7QREvK2dhJYBqn7wgz9g0lQJ0/6ntzKDLSaF6kI1cpN7zbBJuIB3YnGl4trBZM51nu0p8mmaINPhrMEJd44LTUKy1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274991; c=relaxed/simple;
	bh=BbX/vXQixa1lcSXMJUcsGDvaAhY24KDUcP3ngCQbPaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8Qm3HfBESn8hzRnfrXnGj1sLGkOtfr4RlABr/8QzXffiWX2Zzb3/hJQwoICPBGYZcWFHQIf8aP92Y3UzDdwBUBS+icbaSSmPfVAynfbQZhgETqOxlCL2uB/+WNLAT/1iKOagWynpJLvhY1IjPFv5zKndBZM76dLHkHHRRM0U/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Za8hxHc8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+6Qa9CP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Za8hxHc8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+6Qa9CP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F4431140214;
	Wed, 18 Jun 2025 15:29:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 18 Jun 2025 15:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750274988; x=1750361388; bh=KbcsSHWyB/
	iq012iJlrpR3+0KIaY2q4pJ4cqbhWe/GM=; b=Za8hxHc8EpRUoAYfRKtG/SJaiW
	azrfz2Aw2tbhxmwtFP9zPBek+O2XBIfJHgjPKkTH/QZOOEiYj5eW9F2hy8UAZzHs
	+bGmG4kvT4ilJlwBPvPDmaHZrgRi2655LsPYkJMphrmNt9xnXbV/FbrxyGgMtELq
	+ykJB0LMOncIFMN2NMk+zXwfwxaVV21/BLe27W5KTwQEB/8gsjAka4ligQs5CMTj
	HogU0tOKVwuRssmX9oZfkZsL2jmLBNGFMIRlRQEgqQc/IAjJSBr1akbk4m3n9y/1
	751Wplh50b4hkU1Elyxd63zAZl/QDjTe+VN1ToRanuq//9VoC+VOyGw2yeLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750274988; x=1750361388; bh=KbcsSHWyB/iq012iJlrpR3+0KIaY2q4pJ4c
	qbhWe/GM=; b=F+6Qa9CPqKrefdC8VHBjCtKWk1vo/rUdbHh8Ubh9J/iHNf0Yp9M
	JD6/jS9JeO5+j4rItNsRBT4s3oalslY4lCa26xNmgm1QZkdLnNYj7HCmgSvIhCxF
	6Xll/VU9qSx3BpbOw1ByJOCEtzba3gc+DGfScxU6mt3ZArHndb+tkMrG1rVwMwzy
	KIZ1S3rg3srHG7vadveenDz+TzYGek/wklHS5v5NKwTsXtrswMaBaXmO0IrE6ND2
	TVCVgwpr2he8exXRZYyQy+FEExjPVQbrUTXSVVjrzY8++6yWOAiArgXkmlqnDuMV
	L/lsq0VO+ovmhTDRUlydIkHwYbslSQHvN/g==
X-ME-Sender: <xms:qxNTaBdRSTxswtNj8V1-LR596am2v8AKw06ZS5zC9QXopiMszKFMCA>
    <xme:qxNTaPNMPIV5dhnYkecLm5BSskAh7LnJLJmFTrbHrCevi-MI_KG1GU0jgKZfQIEdx
    IqGT0-gZn0WVEm4qQ>
X-ME-Received: <xmr:qxNTaKhtM4mvhcil_0N174pR9Kz3iLoXo2h0-Bs1RVbHBR_IWGZK7E_DcbPgCnqxGQ-EWkZtktCxNh_z0jmG4ezRpEEZturAAWtP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefgeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptgholhhlihhnrdhfuh
    hnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qxNTaK8MLqs6aQHRSr3Icves7RVqtN----Lts5wfMPtpt7UD71lWbA>
    <xmx:qxNTaNtkmPH-HTWUXcUKcnWOVkP_wo5dMrb2FTpz9ehx0729kj3fxw>
    <xmx:qxNTaJFPSi0TbsZQQMSNZizRpQncUi2krfVgNs2VbcbHxeSEbLHo8Q>
    <xmx:qxNTaEO4aZbHg03RB0QPGPOQclwzr5OwJ2MO6yd7i5ahrCmG8b-U1A>
    <xmx:rBNTaDeKgubFrjxT1ry1JJ00ZIs5U7bZKXt8xQy8ehFAl381c8ZlBxSk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 15:29:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] cocci: do not directly access the .d_type member in
 struct dirent
In-Reply-To: <87ldposxyk.fsf@gmail.com> (Collin Funk's message of "Wed, 18 Jun
	2025 11:31:47 -0700")
References: <xmqqbjqlexzd.fsf@gitster.g> <xmqq4iwcgbzb.fsf@gitster.g>
	<87ldposxyk.fsf@gmail.com>
Date: Wed, 18 Jun 2025 12:29:45 -0700
Message-ID: <xmqqsejwetli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> In "struct dirent", the presence of the .d_type member should not be
>> assumed and the code should instead use DTYPE() macro, with possibly
>> a fallback check to determine the type of the file.
>>
>> Add a rule to catch direct access to the .d_type member and use
>> DTYPE() macro instead, except in the emulation code paths that work
>> on platforms that do have the member.  This is probably not sufficient
>> to notice the lack of necessary fallback code.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> This change looks good to me. Atleast it will catch code that fails to
> build on niche platforms, even if it cannot validate existing backup
> code.

I do not think it is necessarily a good idea to allow building a
binary that is known to silently misbehave, though.

> Reviewed-by: Collin Funk <collin.funk1@gmail.com>
>
> Your fix for the 'git diff --no-index' looks correct [1]. I'll build libcurl
> on an AIX machine I have access to in order to test (not an
> administrator on it).

I do not think you need libcurl if you only want to test the diff
--no-index change, but anyway, thanks.
