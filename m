Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3F55E52
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785782; cv=none; b=KFpVI4Xz/iXnHoP/Lgde8CWllOVTzW++kPshn9jt1boCUSFPVzcAb7H4vom84T/dpbbgJumA6oNXr6jSNYTNxhcPnNWOtNvyLTNpogQUy3oSA4/MIV21LlbSEirAMjPwyO8uvwQ01etfeKebAGqADUdKOrb5k6p1F9u2oju11tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785782; c=relaxed/simple;
	bh=jGV9l3RS8gAMoNuCe6CzEqHXPE7dyhFklOWep7I52KQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=KOXpre78Ox3UBzJUt8HJUsJW/yBCncMvK67FkVCerrxDnDvDPL+3EbLZqcnAbyahoAZHkZdz9qHOf9D1YUv6mHuRY87yjusGT+ztNMq1W9Xw4Ie6RHpZOHGhsklzicyumOxKEARA94yhQwtmpeuL5FeHrZzZIZc2r+cToUUPO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=f4tfzn8g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+czK8nA; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="f4tfzn8g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+czK8nA"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1169B18000E7;
	Mon, 18 Mar 2024 14:16:18 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 18 Mar 2024 14:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1710785778; x=1710872178; bh=ANzI6AVtKoxFUil/mXlsybpDLCOoWZKH
	1DTbXiHJHUM=; b=f4tfzn8ge+a6VxRq/a/9MJV376ZB9jFrPRM/3f8/U1+DVFMT
	u1kgLwCH+P26R2gK/2VbELM+cJlxVQbKcqZGVH+A1Sl/Yq5KQvkyHwZst32opPog
	8/mjt+kPwdvFxRjOAj97MiPl5MRUHnfkUhJCo/VMmzc2Ud3eFiMOxFPlS+mdCunS
	2ELwBeXVd9Fslpq9ykThNAARzAkzW1JIqZuzFDQjERIhWLfhV3gYcEmdrPsPCMWG
	0yQ0XxLyzKUh7iWOoFU3u5EM/gCWajhsmmiRAtRNf+k46EBor6CodDq4R1ec3Vct
	xN/9M2YVuBHZOmKREtiMIbvbsr7RtekpUzweTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710785778; x=
	1710872178; bh=ANzI6AVtKoxFUil/mXlsybpDLCOoWZKH1DTbXiHJHUM=; b=e
	+czK8nAuG5Kx1pgkrAfgl+UW0XCJc+BulTMqnNnWzYMLvMFInBDf87DRyje9AbNf
	ry3Aos4qXQVrSlfKO/fkORLgAtThG1TPYOp5WHPV1M56SYc/qtoZA2Pef1qVtgwc
	UFoBwR8EU2wCcCwMK5PpHFQmXbFGof9QQXr9Zips/Aq/uBoySe6YZYDL4NsKzoMI
	v4vU4bNMAbqk/2e6JCiqI6nmCbXdzd8OgJa9W1pPt2tzFQJ1oIhDMGSzNWkUy01p
	cff2b2umw+WDwTdnEtyLahmNGMsCW1IELQeDg6/YaC60ORv4dCcE6bPkdWCRW+By
	m7tl8zK7JOgZAnX2Q936g==
X-ME-Sender: <xms:8oT4ZX8TZcvfr-RctKsxoIF6wXC2JTGxLRvHNfwDtXc9JkQWBd1roVw>
    <xme:8oT4ZTuDl8y3elfySxO9mRaCh4NgOEaPx0hz7TotA6EIyjf_Nh2igreGTmXRgW9xm
    v2Y90Q2vxlXN49MfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:8oT4ZVA6LljBHEScBcAFlqDNvVFo2VAS0cgrsHMnq-H4-UP6QZoidA>
    <xmx:8oT4ZTcgtnrUWFJXM4VN1DS3GJts9wH_P5wQgyG824-8DpaKRBJrkA>
    <xmx:8oT4ZcPldIFwUlFss3ip9hdBBFoKQYPFoHm-vYfnxpODqMrPWSUPLA>
    <xmx:8oT4ZVmi3Y-8wDb25hCZQVyDUhIxodc7s3b3m5uq2ttttpk4dZR-YQ>
    <xmx:8oT4ZZqYvIlOgzH5Xl1XlCZM1bdW4pbMoWXhAghaW0090QLfJhVsC0M03kM>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 44C0A15A0092; Mon, 18 Mar 2024 14:16:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6a16989-cbcb-4558-ae3b-350437fda7c2@app.fastmail.com>
In-Reply-To: <xmqqh6h3jzp1.fsf@gitster.g>
References: <17bdc28ea2b88503.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
 <owlyv85k2gts.fsf@fine.c.googlers.com> <xmqqh6h3jzp1.fsf@gitster.g>
Date: Mon, 18 Mar 2024 19:15:57 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: brianmlyles <brianmlyles@gmail.com>, git@vger.kernel.org,
 "Linus Arver" <linusa@google.com>
Subject: Re: [PATCH] docs: correct trailer `key_value_separator` description
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024, at 17:02, Junio C Hamano wrote:
> Linus Arver <linusa@google.com> writes:
>
>> WRT line lengths, probably 80-ish columns is the (unwritten?) rule. T=
he
>
> Your patches will be reviewed on the mailing list.  If you keep your
> line length to somewhere around ~70, the line will still fit within
> the 80-ish terminal width after a few rounds of review exchanges,
> with ">> " prefixed.  That reasoning is mostly about the proposed
> commit log messages, but the same would apply to things like
> AsciiDoc sources.
>
> It is true that we do not write it down.  Perhaps something like
> this is in order?
>
> diff --git i/Documentation/SubmittingPatches
> w/Documentation/SubmittingPatches
> index e734a3f0f1..68e9ad71a1 100644
> --- i/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -280,6 +280,14 @@ or, on an older version of Git without support for
> --pretty=3Dreference:
>  	git show -s --date=3Dshort --pretty=3D'format:%h (%s, %ad)' <commit>
>  ....
>
> +[[line-wrap]]
> +
> +Just like we limit the patch subject to 50 chars or so, the lines in
> +the proposed log message should be around 70 chars to make sure that
> +it still can be shown on 80-column terminal without line wrapping
> +after a handful of review exchanges add "> " prefix to them.
> +
> +

There=E2=80=99s also `.editorconfig` which says that it should be 72
characters. My Magit respects it but NeoVim doesn=E2=80=99t seem to. May=
be worth
mentioning since you might not need to configure it yourself for this
project, depending on your commit message editor.

>  [[sign-off]]
>  =3D=3D=3D Certify your work by adding your `Signed-off-by` trailer
>
>
>> text files aren't really meant for end-user consumption (that's what =
the
>> manpage and HTML formats are for), so I think it's OK if the line
>> lengths are roughly in the same ballpark (no need to worry too much
>> about exact lengths).
>
> Yes, too.  And it is one way to reduce patch noise and nicer to
> reviewers, when used moderately (i.e. removing a word and making a
> line to occupy only 50 columns when ajacent ones are 70 columns may
> still be better than reflowing.  Leaving only a single word on such
> a line may not be reasonable and tucking the word after or before
> one of these ajacent 70-column lines would work better in such a
> case).
>
> Thanks.

My interpretation of this is

1. Commit messages are flowed/reflowed to 72 columns
2. Code is reflowed to 80 columns (enforced by tools like clang-format)
   =E2=80=A2 See `.clang-format` and `.editorconfig` (kept in synch.)
3. Source documentation (AsciiDoc) is reflowed to 72 opportunistically;
   not every time (in order to avoid diff noise) but when it feels like =
it
   makes sense

Maybe SubmittingPatches should mention that last point? If my
interpretation is correct.
