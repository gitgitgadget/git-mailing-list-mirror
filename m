Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BAC2C870
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409494; cv=none; b=qzWNuEPgsp8/VSeApCWihhY16XuQ9U6VPmYpma6Wkr/zwxMqv9he2Q+j6j2jYunMgwj3mseimqgWU1Yzxq0O7OSzGScbUN/11FnPxEuP4KT8gFOaeA0qS12I4ZikQmfsihjovWkENoe6IrH5AsZ+ER0bgolqxN1Y7rYvrbarcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409494; c=relaxed/simple;
	bh=zn1HkOD+oZ1nHAxl1xq0HYCf5A+YoSSmUoL6SYpUrXQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=RyevnR4u/i2oWQ1+CD8EoHPf4yaySHkQxqXQcDdd0M03cHnx7UKlD80Fe5oPQ+LlW5KC9xiH5QmyEBfA6x3/g143nA5LmM0qpk+xWpeljqL50fJjGBLob1u3bp7jGZmt0KpU/Rbro45m05O84pKytZSTfzoDcU6jcZwJN0zeFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=PzxpCgk+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPiZ3IiS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="PzxpCgk+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPiZ3IiS"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id E9FE913800B2;
	Sat,  2 Mar 2024 14:58:10 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 02 Mar 2024 14:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709409490; x=1709495890; bh=3T5EOzVi/vxpnQs5m11aJP6DjV2J3iYo
	GWCGNPjRZ1Q=; b=PzxpCgk+wSb8BNKClT9N8/V4T00b4Uu7uMBeCmpaO3e1MMgC
	phE1a4kpoO40DXu0O0Pc73L4QT2CyXSUHUVVcIPiZDhL3PVrkyVqVAWHBSq3UFz1
	+GMPupoVQYF5e7jpm8lLZVSpJg0hRl3zF0wjTwp0sgDWCAx5Whj0P+0m3FGlOc8p
	touOOuCeb62t+eGg8xhVfjlpHriAFZHSplLGfIyelxCw5wPeJuPVMtOhG3iWw31I
	1AAdZBjFP+Vjf8pyCShhAZbwkgdWcIHHbt6yoClvqdhPm2Dc15Ug3TR0eThOvZ6b
	KtIVmUDHxjEEcRHzqSulu2Lc/9BVhzoiGyj3GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709409490; x=
	1709495890; bh=3T5EOzVi/vxpnQs5m11aJP6DjV2J3iYoGWCGNPjRZ1Q=; b=q
	PiZ3IiSKOEm2iuozmNjy9sidCfFP/+QaF5IZ4SRlzOVhU2n6CzEHqAAkrz7l55gt
	PoYIFYFR+ThY4N81z4hMgxCilsgGUT0Mdvn6yPZ8ExtA//v+YVPW6lcZA57/51gp
	K5/upUSPgZY2VNEp0N0ZV6WLx157PhoDZ3scL7TLjJNmOV2lO2xI/7xd34tuMQmq
	ZN97QTV/eiWYfr/LcWdriI1U4R+tMpk3ZLx6Aj5D2Alkk7hEHujhBLAF6oDfw3BF
	OY9m1aCy5bP7CKM1YbWrVrDYcDPd7hO1eWnrj+js8gbJRTxcSqVTSS3N1Ss7359k
	dG+jDlFBan3NT56Rbqf3g==
X-ME-Sender: <xms:0oTjZY-vms_KGKezVoR_4JD1A6MCTZA8MMgv_PLXJDD3V97772uswU8>
    <xme:0oTjZQtWYYCM46BLL1hClKhcYE_UrDcVaFtMmgIpvrlEaUz5S6I_T2fd6uY0SX_Gb
    5EzPOucqJ9voqN4Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheefgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:0oTjZeDcQ_AOXDezfj-ylhZfyHkULZ9_S2S65-70b3IJ7e2A-E_euA>
    <xmx:0oTjZYe3uWjrPy-pd-2u0MlTpXj9p5-zURklFoYUGfBPZThVS0CBdw>
    <xmx:0oTjZdMyrvCubQ2D1EgBkzIlotBzKguFtI0uHC-iKxAzr4YBHDZelw>
    <xmx:0oTjZerzVtmGK1OZ_eFM2Neq8piztpYH-9GP98gyq9tbdIK8_XKPBQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 82E1315A0092; Sat,  2 Mar 2024 14:58:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <34bb249d-4a4d-4cc7-b737-bb18398341d0@app.fastmail.com>
In-Reply-To: 
 <CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com>
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <xmqqedcszhty.fsf@gitster.g>
 <CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com>
Date: Sat, 02 Mar 2024 20:57:38 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Karthik Nayak" <karthik.188@gmail.com>
Cc: oliver@schinagl.nl, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Mar 2, 2024, at 19:02, Karthik Nayak wrote:
> On Sat, Mar 2, 2024 at 6:03=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > This patch series adds the diff.wordDiff config option. This mimics=
 the
>> > '--word-diff' option of `git-diff(1)`.
>>
>> Is it even be sensible to introduce this configuration variable in
>> the first place?  What would this do to users who set this variable
>> and use third-party or their own scripts that run "git diff" under
>> the hood?
>
> This is definitely a good question to ask. I'm primarily not a user of=
 this
> option, and this patch series was more of to start this discussion, ba=
sed
> on the request. I'm comfortable dropping the patch series too if it do=
esn't
> make much sense.

This looks similar to the discussion from a [stash] topic:

=E2=80=A2 Proposed introducing config variables which change how `git st=
ash
  push` and `git stash save` behave (what they save)
=E2=80=A2 Concern about how that could break third-party scripts

Like here it would be opt-in. But the user might have no idea what kind
of scripts/programs that they use that happen to use git-stash(1).

(That=E2=80=99s at least how I read the thread)

I guess the concern might be worse for git-stash(1) since it seems very
natural to use that command in scripts in order to deal with a working
tree that might be in a who-knows condition: just get these things out
of the way so I can do what I want.

=F0=9F=94=97 [stash]: https://lore.kernel.org/git/xmqq34tnyhhf.fsf@gitst=
er.g/

--=20
Kristoffer Haugsbakk
