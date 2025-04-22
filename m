Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18125CC4F
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360454; cv=none; b=l0QCpErFBiIwTLolGwV7BYvLPECQf+7gfgH4jr1NBZVJ8rDvRTjHt2lB4zdPPfvTVv1RQvsYEjSkaspRqykBLiWI2QukYxerbKR6KsQUdbuf7t9n+xT/xvHxofjBSK6zvKPsEok8NNUe4dZCxmOO/aXBsuxxWmsY/zf3I20NyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360454; c=relaxed/simple;
	bh=XuCoj0XTMRgBV4L+upuRQ6HkLVJnZLkbhxEmEkHSSvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YL/POGRaeZYVZJJ76itPRmASMwi2UKYc2afEqh6nkTuziz7VqpiYJ1WOc/1aaKAGAj9mpVBmbvQA7AeLofQsEKD6zCVAQ5Xvwn8HrUSmluN+FuHA4IXqUm4TZCNKY+m11SjdohrZVAj8q9Pbv5d2ytzafSpUl2sHj6WEWSEoRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LIgFisXu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lhWFipl/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LIgFisXu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lhWFipl/"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47ABF25401C8;
	Tue, 22 Apr 2025 18:20:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 22 Apr 2025 18:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745360451; x=1745446851; bh=/cYOxkZRuN
	JWaG+QVCrlrSqpUYhnSNEU/azEHSFk4T4=; b=LIgFisXunZqwOguwyZQbgHQoqr
	4DoiDjXp8eckrt3XpqXDiUdfWrD8/4nplgJaI4z0JBr7y/R06ZJ9rHZeGTOsExa8
	7scGVaxs4qFm3zsTsDEf13dgYtycyHUF9phLYIxr6/yTxfZoAyst/Qv6uYoQt3S4
	3ip8vdQ2b055DWaS8KWTSbpRoru8OP7dcjh3abneUWwtQHY1Ef2rpKjyHm+rPf4M
	DPwfQTg0nJxsFWqORAFsFQksXUHpvbLHiQ0BBnEUwhBM/uWvKUAymYtu64Mmr/hw
	4q38QBUv/ZGUN90vOkVlDdlTMpVe/jFJD9KO2dO8FatIbgliI1VSu7f4QV4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745360451; x=1745446851; bh=/cYOxkZRuNJWaG+QVCrlrSqpUYhnSNEU/az
	EHSFk4T4=; b=lhWFipl/KvoO9/U9sGfc5Ofh/+KC+iaZq4obY6++3TtbuG/K7Zq
	42IsmQWVVZjXdY6JSjXaUmUBNDm4CvCuaeAInv3+LA7XKqIQ5sMA57eXtukoW+10
	xHGwTSnFjsjCtieWC6KnAEEk1ZfRXPet3OmxljMKgEBrSYAqrAJGpjX4h6eBBSSY
	M5SnVdz52jYzF1JAhDjGGbh0hlaBtrjfkYeimxk1drZXewjEwwpH1FjpLnawIqQD
	an2L5bQawV/UYv1oENEmU19DPrFKIGcLo2OIkqrNpK7k9wsPGa0nYO4Gy2BLOvyG
	XuEuW6ztI/+N5YusVNUjn3/0PTDG8F/E1dA==
X-ME-Sender: <xms:QhYIaDOuEZ1d5vUJ-DP5NKED2Fq25aGNaj6lUN_3OjZR4M6zMqy4yA>
    <xme:QhYIaN8ZA9wu9ntgn1c3yHZEWPrM-sMZZqvhLy6BY0ZfC94dTxvWvNv1-uJs-lJDU
    Y9TsmCO8ryPI26-Rw>
X-ME-Received: <xmr:QhYIaCS2hKlnrvAS7qKzfn57Q35qBCJ-Vf9DTmdSFQgN0uv3y7X77HqHvRCOWLFjEnJelaC_RZthZ00w3ZKIWNCd6085_Ly3XP8N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghm
    rghkvghrshdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepfihirghgnhdvfeefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QxYIaHtROc8kaQ6GCO6IJWnSzeER0DLI0x6_cHMW_9vZw6f2Ooj_qQ>
    <xmx:QxYIaLf3Q74UUxgfQb7MQbbRBkz5oq--AraRHIGxiGbTi8j3nMtgfw>
    <xmx:QxYIaD1_GaOnWICD4Gweuu2smHs3Tycke79Aq-gn6b5-A6AGj0nRFw>
    <xmx:QxYIaH-MBf83mFXjC3b0GfMSsnPVtakAE89V8IZGoFCB0zc9Xflt7A>
    <xmx:QxYIaDaTEfgmYOLirwth1VFKa8c2dGFHpSohPaTZqLkxjE8Gh1byiTml>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 18:20:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v3 3/3] send-email: add option to generate passswords
 like OAuth2 tokens
In-Reply-To: <PN3PR01MB9597813722A475923ED1C036B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 22 Apr 2025 15:23:21 +0000")
References: <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597813722A475923ED1C036B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 22 Apr 2025 15:20:49 -0700
Message-ID: <xmqqh62f3kji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +--smtp-passeval[=<command>]::
> +	Generate password or OAuth2 token for SMTP AUTH. The argument is
> +	optional. If specified, it will use the output of any password
> +	or OAuth2 token generated using the command specified.
> ++
> +Note that it will override any existing password specified using
> +`--smtp-user` or a `sendemail.smtpUser`.

If the argument is optional, we should explain what the behaviour is
when the optional argument is omitted, as well as how the given
argument is used.  You are doing only the latter, but not the former.

Shouldn't the "command" be mandatory, if the option is used?  I do
not quite see how these invocations

	git-send-email ... --smtp-passeval ...
	git-send-email ... --smtp-passeval= ...

that do not specify the command to be used is useful.
