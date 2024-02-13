Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826706088B
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856568; cv=none; b=Kc+ClhLlKcK0d8bPE4Kz9zKIsdGmNGeQHzRn8TbJA7npyQF2bKUNmpTzn8rBt1y8pKB0fAU50IOJgS6NvhIPaBkpAZqF7JzP+DTwI/Q/FR9gZNTmPS0OY4/JetKYCdzeh0dGsEpGFTc/0ZZxmcVzWY4JT/6o64bmzjSCcqUI+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856568; c=relaxed/simple;
	bh=K9D4qGuuA1Pd2OZ8Xm7w1unlLMJ+//w1S3I2+iF6HmE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ejoWgn7zgqPB9YyEWLXac21VfvHNzmMUQUOLM1uN+YXQ/m2m7K6a2dlgP1u6ELFS+BVZafJaXOpoBFElVlUMK1LwDUUFSOZvJjuOTc4fNbwAM+ADiV4JGmjSHovvzar8QmUuWrNYlrTe7T41Gt5DSUQ1wJ4KU6Qf9pe/ZVoaO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=UAw19nUs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5Yi6Yvh; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="UAw19nUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5Yi6Yvh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7CDC618000C5;
	Tue, 13 Feb 2024 15:36:05 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 13 Feb 2024 15:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707856565; x=1707942965; bh=riGmIVSAm6efDbezDr/xl5mpjEH6gXk1
	dYLL3jcrByA=; b=UAw19nUsN+G0c71AFKqX0AegUoJLIGpCK1A0MhiqvLFB6oUK
	KDMg8bKvkAY8W+H8jl2qaMCkHji6nMCOsKFdkPIxf9kyS8cfQx2ertpbriZAt6rD
	+NaP2yMpicwqFqFUIpQXsEryNRIlgt8fmbObkuIu8ahddP968m/aOZCBIXCR6yGi
	IVhcAVWe2meAZT+dPqR9cPEXQ/xKtDQFmexyVhBjzhraF7CoNGbyQFzsCSHO5m+g
	C4xzFWcmCqnKiwzJRx2T+OXvP4cm9jaOvjXicATvjaSaalIkplD3Y82BqTTxFFNI
	A6+SEmj+irRqkaAIy6MZoGm1EL7yCYawgpi4JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707856565; x=
	1707942965; bh=riGmIVSAm6efDbezDr/xl5mpjEH6gXk1dYLL3jcrByA=; b=K
	5Yi6Yvhsxyy6gqh18fk85LpeVUc+uKlSvixbXomO8z08BIUmXYeNVK+Ea3lUh60w
	zQe+aUiSyulgR2QFQm1g7xU0tJO8yEkbiP55Kj2LPXZQC675CaqHIWWW/DlYQquN
	hy863/er1DngTziwRT8zfu3kl5Zfqj1O0kLiGAkqAykfwCvMc17QjF6oCZ1B25K9
	0wMrtVFljKGrEPUXXhHkadyvTBR7Df3T5YVXXa1e+R6mx7v3hqyXZ6Nw6nhtTqZU
	PERaZ/Cr2zD6a6Rz3GBD14ww3Db4/c+C+Yxt+HxS6crVK84Y8z5YOiqKV4/Mmk94
	SpxMB3EneW4Et4F1LpcvA==
X-ME-Sender: <xms:tNLLZWO4FpNdKiKs05LozztNV-cTErB8fU3nrmIx6_iEDDIYGhnW-2g>
    <xme:tNLLZU-Qjyf6uzgeiZ0mQoDoWBdaWdUPAH8fITVX_P-HerWN8Orh2nie1FLvDZH1-
    pdUY-Ii3nAlQK6-DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:tNLLZdTD-1U46PqnYmx8JPeWaPGecCPXM6JVNB9TRJkGkH8SpoDV9g>
    <xmx:tNLLZWtFdnLpHYrTCo-APeYC17hA8dnGeX-cPYwRSsVChWIKoZmecw>
    <xmx:tNLLZed0oQO8slIbFI6GurNAmj8k_QjBDrFGFmhvPRN_HeoJuJ_AFw>
    <xmx:tdLLZfqXmdq-hbSHMgBhFIgiPlicGmgRvoqoPPwhytGi1DFmSdeqZQjwR_U>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B927C15A0093; Tue, 13 Feb 2024 15:36:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6446a48c-4b9a-4095-9083-071f95ce3b84@app.fastmail.com>
In-Reply-To: <b9ca1ab7-f8f6-4fe0-885a-51728d9ec708@gmail.com>
References: 
 <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <cover.1707839454.git.code@khaugsbakk.name>
 <9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
 <xmqqcyt08fa1.fsf@gitster.g> <69f60c3a-ff47-4cb9-a229-6c5a36e7d9fa@gmail.com>
 <xmqqle7o5f34.fsf@gitster.g> <b9ca1ab7-f8f6-4fe0-885a-51728d9ec708@gmail.com>
Date: Tue, 13 Feb 2024 21:35:44 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] column: guard against negative padding
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024, at 20:56, Rub=C3=A9n Justo wrote:
> On 13-feb-2024 11:39:11, Junio C Hamano wrote:
>> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>> The point of BUG() is to help developers catch the silly breakage
>> before it excapes from the lab, and we can expect these careless
>> developers to ignore the return value.  But "column --padding=3D-1"
>> invoked as a subprocess will show a human-readable error message
>> to such a developer, so it is less important than the BUG() in the
>> other place.
>>
>> There is no black or white decision, but this one is much less
>> darker gray than the other one is.
>
> I've checked this, without that BUG(), and the result has not been
> pretty:
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 37473ac21f..e15dfa73d2 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -529,7 +529,7 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
>                 if (column_active(colopts)) {
>                         struct column_options copts;
>                         memset(&copts, 0, sizeof(copts));
> -                       copts.padding =3D 2;
> +                       copts.padding =3D -1;
>                         run_column_filter(colopts, &copts);
>                 }
>                 filter.name_patterns =3D argv;
>
> I can imagine a future change that opens that current "2" to the user.
> And the possible report from a user who tries "-1" would not be easy.
>
> But I agree with you, that BUG() does not leave a good taste in the
> mouth.
>
> Maybe we should refactor run_column_filter(), I don't know, but I think
> that is outside of the scope of this series.

Thanks for trying that out=E2=80=94some very topical testing!

I will take the night to think about v4. But I will defer to the
reviewers=E2=80=99 judgement on the scope of this series/change.

(All I know is that it can be tricky balancing such defensive checks
with readability and maintanability.)

Thanks

--=20
Kristoffer Haugsbakk

