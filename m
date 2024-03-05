Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21FC537F6
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629315; cv=none; b=S/RsW17zBdcYUczaIuEWVfE6vgxmTe4jUTF5SUZpMD2O1pempfzVT9ooQWU6Q3EUCs3JmnrnfSFCWIbPnWBxkkM2X00SCO6ZJd8Hrtqv+SnAm/Cb4D5D10aW9jHQuExHOc7wMuNWdG+vWVoUXgQeMITaNmnjhEcsTBxnq8eWQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629315; c=relaxed/simple;
	bh=2yqVI/bIsH3Llp6+7MIz65Hx38XQf75kQwZxlZBEiRU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=l6tfVJDlO+vvPRqQpsev2WNmxSbqDpAW1gu5UR7bjKhRKQxrFXPsqaBZ9ioUTVIDKxsiAXyQVjZ+C+QwbxJ0/9PRm2KRmciZin7nJz3OA6AunnbsW/uf1SlSuz1vp9Zo//u47jWqnkpkvt9JLCvmWblvA18NOXpNdsaYGnxjLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=bgaUupZN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTgvKeDV; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="bgaUupZN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTgvKeDV"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id BCFAC18000AC;
	Tue,  5 Mar 2024 04:01:52 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 04:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709629312; x=1709715712; bh=tEfhO80Sp8WlMV1LQ7c5KCsknSv495AM
	WImNymK2fhU=; b=bgaUupZNjz5MEjVZJGIYF/qHcy/SYPiZDAuLK0nb2k2A6B3G
	kW8ME0670AhbY6TRJdo00R/S/ic4ffN4mdKMIXltdPKK+LRlovfieVcasIvMtqIY
	ayuOxCrIl1C/Va7tBQ7y8GO64ZBT/xFLbZctWAcL/rJTmn9VR0Qidm6siHbok8NO
	Si5CxNpZYixf050Q5i6cKw9b2EXlRSJhYAbxGm9B4ARa/ejzP0QvF0gsoxlVspSm
	jzp7H3t5uOK0umd13Tzs+Y6YPIXF620xyp2JB2sbfjNrJviKQxi+Se6uSOyj9vXy
	kUYXE41raJX52XS408viprCdkJVpvEFsFnc1iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709629312; x=
	1709715712; bh=tEfhO80Sp8WlMV1LQ7c5KCsknSv495AMWImNymK2fhU=; b=j
	TgvKeDViK/hpfdrhWcXLhtUFE3qM137BogmW6WGweSwQYpb4a+vvcBX0R4o7ZB8Z
	QATKVr3B15OZ7CukfBBUoQsBrx77VTCWEacL88G2S4H49qkJkehq83jmxgABd6Io
	RnayeO2ToWgJQ8E0IHyp6u9dlPphaN7mTUmtGFNUdCS9ijC9GIQNBoUhwFZr0eeS
	bHupzUBruYxW024hapAgcf27vhD7dDaZa4BO1QQIEWr8U6BE4bbd4ziAkreMw5CR
	eLAL3+KVrao6ecjG5ARiX8mr4/r9MGo5WFWrtLRjpu5IQm4rALkxaPUeou2/eJpc
	sZDsK5yhz8nV4D9aFTpzg==
X-ME-Sender: <xms:gN_mZS6PgiRkWTTHvKrLn_f64_MT75cW0UlOt64j-BOvuRLRMosdiH8>
    <xme:gN_mZb5mmALpcCj2l5cdDPJDk9KVSghTJqG_egyODJkaYJ81HWP-xCzrnwHcVl2Cp
    d33gvJLhyuMMtv6tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:gN_mZRfLunkLTudMyazEtRXRTRlPa8J1rhnRt_SymTgqV51ODLKQpg>
    <xmx:gN_mZfKOFhfFhZCwj5q7JV8Ui424u91IS8UicnvHUzfoUDnjjMCNMg>
    <xmx:gN_mZWINZPhbEiWTB4C_PJ7phRgCP9Tu0VcuWuWTtwp8GHUZbshXoA>
    <xmx:gN_mZYjGAQ8eX6JpnAHdoLuBnWW_b7kqoWKpKu7GTPuyVldjtT6dePVbHxA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0929015A0092; Tue,  5 Mar 2024 04:01:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
In-Reply-To: 
 <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
References: 
 <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
Date: Tue, 05 Mar 2024 10:00:06 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Manlio Perillo" <manlio.perillo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Clarify the meaning of "character" in the documentation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tue, Mar 5, 2024, at 09:43, Manlio Perillo wrote:
> The term "character" is confusing: does it mean 7bit/ASCII character
> or Unicode Code Point?

IMO it should say =E2=80=9CASCII=E2=80=9D in contexts where it is restri=
cted to
that. Otherwise UTF-8 can be assumed since git(1) handles that well.

> As an example, with
> git config --add core.commentChar =E2=80=A2  // Bullet (U+2022)
> git does not complain, but it is rejected later.

I think this is more about `git config --add` not doing any
validation. It just sets things. You can do `git config --add
core.commentChar 'ffd'` and get the same effect.

> A counter example is using UTF-8 with "user.name", where it is handled
> correctly.

Yep.

It will also handle UTF-8 in cross-systems setting, in my experience: if
you generate patches with git-format-patch(1) it will handle UTF-8 that
ends up in email headers correctly (it needs its own encoding).

It=E2=80=99s quite UTF-8 friendly.

> I sent this email after reading the documentation of "git diff
> --color-moved=3Dblocks, where the text says:
>> Blocks of moved text of at least 20 alphanumeric characters are detec=
ted greedily.
>
> In this case it is not clear if the number of characters are counted
> as UTF-8 or normal 8bit bytes.

Alphanumeric characters (a-z and A-Z and 0-9) are ASCII. And one ASCII
char is represented using one byte in UTF-8. This already looks precise
to me.

I=E2=80=99ve never run into a case where git-diff(1) does not handle UTF=
-8. I
don=E2=80=99t even know if it really needs to =E2=80=9Chandle=E2=80=9D i=
t per se as opposed to
just treating it as opaque bytes. Maybe it matters for things like
whitespace and word-boundaries, I don=E2=80=99t know.

--=20
Kristoffer Haugsbakk

