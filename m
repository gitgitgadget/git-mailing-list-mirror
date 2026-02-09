Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E5388855
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659974; cv=none; b=kXsVcchdorKCA7IGQFOkfNGSCLQc4tjE/tnmWVKZultIRihyo2ydI/FwlFbQyoVjkU6HV2fjz+9ZVGIv7IwRXdt/mP1kNTQ5XpKJOdm4QmDJsNfDZgVbl0QhGp02HdnnnLRNsfHkhLSSh53GMlP/CPSunqy8nihg6zs1x8a+7i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659974; c=relaxed/simple;
	bh=FQUkhTO2dcSNoVpsbuK001+XfrNTiOfMaY1+HdckrCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mci92SrIFmJcfDmuI3iyVZPrFrgL9PkyYDJc4HdvD99xspUEKiWkYdS2VD9tX2gUCE7LQcHJkARsojKwWOwL6Ym46fJ8AJgImuBgnvZNALHdPHsA2CqZPWQnk3W3637MRiQ8j8rTnCwH4z6vMuTsKU1zGv836FftyIgvdM8LM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MlwNl34q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FUkN/dZf; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MlwNl34q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FUkN/dZf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 55CD41D0016D;
	Mon,  9 Feb 2026 12:59:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 12:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770659973; x=1770746373; bh=/1vH+5KN3t
	n67hbgHHI3b3gge9Wap7E8ih9SXQ3DvwA=; b=MlwNl34qVyqyQYBRg5aN7ZSc9Y
	IK0Hbb6tDJjkGbWY3iF4KUb4FXmgSOGZtWZ0ou7uLrW9QBDBkAXx2bTeQ3TUi8+N
	8UYxGlp18+MxXiRH5CudcM2sw5SJrQx17mRmQ/hwRQPteZif/okxKEvXg1J6vyoJ
	ADsTh8V9X7QAbefkdw4WkUDh+vJmi/bNm3JBKnR+TKc7VtTocz8jZBxOWvoO1lgH
	uIAv1+Ldx2iaadMmaTtoXDKo44zmgctXAzyzno85n9dJUVTuJmAFU+IlKUPRpJHs
	pWK5UgnN4FM4AeAx1ZjFF7IUZDjdc+ZwunxXLr3O/wgB5px4YAnxlUjKe87g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770659973; x=1770746373; bh=/1vH+5KN3tn67hbgHHI3b3gge9Wap7E8ih9
	SXQ3DvwA=; b=FUkN/dZfyejW6BbjwdaniH/EuTWwm/KkcHU1SEQW19r0AZZqGgI
	pKb1+c2f/jvkKkjQftXX6m/AgqLUjrrotBf0PHr/80O3m8xZ4rFNPbw+Vxc7R2y/
	CMMqDkjZORakkOJcDhj7AKbP2mB1MgYzJhpxoF6yEpiPd7rT9b4muMCQBGYa4RA/
	TYSOaftDi8fu2YJgUUB5y9LqIcnjXbtVsqcsHm7wYH0GqmT0pRZydt1aOppgKwXc
	f0nI1o1aSEbKpznywksqImbZefaWe1hXfAvi0TgVFl2eguSfGao04w/RuWgYyFPp
	PqDsAq/1cAlyG1nu4FZ1sCGVZAKYlmzdbhQ==
X-ME-Sender: <xms:hCCKabfw-olDp2cOaJyN4GjLPQJ1CIBU_tDXw39quPvIsJHdR_XseA>
    <xme:hCCKaYOo_zG4xLVsrwaObwVmEdZJ4NAww0LV-TFjBK2OC2EUcLiwN7DCkT7qiGSn2
    Pkj5Xix-gXemgw22GDd79okXZh8I1jH_lzcQE1mb-V72yBflZTE_Q>
X-ME-Received: <xmr:hCCKaZh_7luhljRfh3QijHzSvQ7rVOeKCBx6iQqwHa2NEbtF3619c1Tc0Rrr_NQWnThVYvTl1Qafqa9vJrVPxzEKEd4pRlTAiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hCCKab3xbrQWKT7XSOQPssjiivPjiR4Q7YcuNkp2O3bsmzNzZiXOyw>
    <xmx:hSCKaTjx6e2fu0g8l31bTI2ymdbWW1HQMP0m4-OyI_ndp3DQbdd0HQ>
    <xmx:hSCKabdSirm-eU9hd9kzManIPK5anWPIEO6wlnU8o81EGqEX81LXRQ>
    <xmx:hSCKaWm11MDQPaD44Seqe6jEr34t-z1oaYZ8ZzFBS0-FcepR7DT7PA>
    <xmx:hSCKaWcCjselxBcoMKsTHIHLYACTvWO_2zVNgEUXDB2CE-FC2S6x_aZW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:59:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
In-Reply-To: <c3445fa2-a217-4e48-b0d0-ad41a563c6c4@jontes.page> (Jonatan
	Holmgren's message of "Mon, 9 Feb 2026 16:19:55 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<aYkaepCu4lwT3xNl@fruit.crustytoothpaste.net>
	<xmqqikc66k5k.fsf@gitster.g>
	<c3445fa2-a217-4e48-b0d0-ad41a563c6c4@jontes.page>
Date: Mon, 09 Feb 2026 09:59:31 -0800
Message-ID: <xmqqy0l14x30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> Thanks for chiming in!
>
>  > Isn't NKC/NKD a macOS-only issue in practice?  Anything on the
>  > command line "git" potty and "git-blah" built-in commands receive
>  > goes through precompose_argv_prefix() to be normalized on that
>  > platform.
>
> If we use Jeff's proposed alias.*.{keyname} approach with literal byte
> matching macOS should already handle the normalization at the argv level 
> before Git even sees it, correct? I'm not very familiar with how macOS 
> handles this.

I may have phrased it poorly, but the above (with Peff's syntax
change, which I think is independently a good thing to do) is
exactly what I meant.  That way, we do not have to worry about
normalization ourselves at all in this area.

Thanks.
