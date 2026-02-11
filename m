Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779427FD56
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831169; cv=none; b=AmX99+0JR5LF1PrXGwFmqezPMFxQAC/X8a5Qmk7zCCwLAYW3vxkz2goFmQUis0eOA9VhIhyTE/dfTn5N09BqpIGlugvuZwsroGgBMWMdR/HfS7uMus2QS8fkkErjnum6cCf1ZJoOmR/pWClpUAAOJUI6sXJB/PFNE4o01AtuUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831169; c=relaxed/simple;
	bh=8V32opJyqwzX5/sZZMB8pypIkmF+/XCKaVlg9Ke9RQc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JcJeGU+odIUUuzDVe0c9UMw07+fEhqydeL7k8nITxZrivC2fcGS7jl/Ao+EV0F/47japt7YKli76mtzAHJESbWnfpV0Hmc1LbJA2kvbB9TOntY8FYIBXJ12g38ZQKYMgTt8HrSC4Olmn5P4timPPHS9ij4ONoltN70M3vLmGzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=dh6qzVi2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pw8oQ/F/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="dh6qzVi2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pw8oQ/F/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDF3B14000AF;
	Wed, 11 Feb 2026 12:32:46 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 12:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770831166;
	 x=1770917566; bh=UQm5LfJ4JhO1cTwsBd1gBuac4Lv2CqFbclyJnXxfCWI=; b=
	dh6qzVi2652JaG4NfhDAxb5eIeuj+BVfW9od0Q0OpNkWKhdrv4zV73XOylhRFXn8
	SzMUx6r47vEyVGQoL4bWg5wuuK7b27Gf0JCwdpIIGNFKZlOin3R8WvH5ua9inHbn
	3A35VxU94Cf2kKzvOq4aSKEjI3yi2d/9CzwzUr7UDglfdqiQvQ0GPbyHH6xn9ZaY
	MB1qDxGIh66Jlj3xxHIvsDKjIUwkQW8+gAx3SOrf9ksdnrASpYbIaUmokLRjuKoS
	rchi7EDIW5FbkNVj2NvFw5CPnisis4NzhgBU2yix5wkICl9K/IiRY8eavPZdrCRD
	CjwcUHox6RXRC+M+TSqbkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770831166; x=1770917566; bh=U
	Qm5LfJ4JhO1cTwsBd1gBuac4Lv2CqFbclyJnXxfCWI=; b=pw8oQ/F/vdaWbFpEU
	fl6NQWsLPYs+qvMi5tKKVXegAqWN0PgObDHSxA8LHqVe28Uc/YI+l03FvXCI2gGD
	0PA6rlPhEdDQf3avaG3/0wkroAhsuFlrdPPLquHQpcoOLiRsrsmi9zpMCIC+aIuJ
	GUuPTvsZgVNdO2+RE7qLCAaHdcCEALvoQwWqU7Eyl/Q9OuLLUsHXgACYCT6ewgHC
	RjDZrdGXQ/hAWyJLYYRWtqeeWuFLsvrekTDvCjsLes/+VkqqZl1WdgxZNElFWzqS
	PQwaZJ2TboqfTOtmZSZAS14kRIxVBVbhkObhBKB81plqktZebi8/zpSzZ+VlLuw+
	dgmiw==
X-ME-Sender: <xms:Pr2MadfEwMUK1CjrjFry_z5KonSey0RWennN5BhDCOt5l-nwsiSxbkk>
    <xme:Pr2MaWDNrycJ_sR6TIUNcM7ZQ98HvMbdrK5dbS5Qwdh5rzd7vBnkfcUMMN0tXd7HQ
    bHYaZxW3AdEt5sh83uekrwOPM0EQyAGCNnNk3lqVlGcIBjQo3kXpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetgfevveduheehjefhleefuefgheevuddtuedu
    feeifeelfefhjefhvdetleejhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehk
    hhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Pr2MaTbpwNWk3D-A88mebJxMgMUNDcH2j1FSpQy5O1zLej5r_E6g9g>
    <xmx:Pr2MaaJTPA-PjWz2cgbdRv7mWKGL-QwtM5ls68wjq3nGwPPDWXXPgg>
    <xmx:Pr2MaZCjjK9VWCJxc6ZSxbR81hae8VEyzBlxjCAuQyENyJNNbBbZRg>
    <xmx:Pr2MaXqFJs3VA5qJad-jmCxL2r7MTb8_Xlnh0YipXC6MDUYItRbaMA>
    <xmx:Pr2MaY8XtXHtN418rrviS84NF9CNcokinku1p4UhBHI9R0Bxq7GMiyLH>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B816A1EA006B; Wed, 11 Feb 2026 12:32:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AS5hoZxEI1Uc
Date: Wed, 11 Feb 2026 18:32:15 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <1a05ca33-dda0-4315-970d-b61a3f48a8f4@app.fastmail.com>
In-Reply-To: <git-am_gitlinks.322@msgid.xyz>
References: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
 <git-am_gitlinks.322@msgid.xyz>
Subject: Re: [PATCH 1/4] doc: am: normalize git(1) command links
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026, at 18:34, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> There are many mentions of commands using inline-verbatim or
> emphasis ('). We just mention the command themselves, not specific
> invocations like `git am <opts>`. Let=E2=80=99s link to them instead.
>
> There are also many such mentions which then link to the command right
> afterwards. Simplify to just using a link.
>
> Also remove =E2=80=9Csee <gitlink>=E2=80=9D phrases where they have no=
w already
> been mentioned.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>[snip]
> diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
>[snip]
>  Valid <action> for the `--whitespace` option are:
>  `nowarn`, `warn`, `fix`, `error`, and `error-all`.
> @@ -205,7 +203,8 @@ applying.
>  	to the screen before exiting.  This overrides the
>  	standard message informing you to use `--continue`
>  	or `--skip` to handle the failure.  This is solely
> -	for internal use between 'git rebase' and 'git am'.
> +	for internal use between linkgit:git-rebase[1] and
> +	linkgit:git-am[1].

Jean-No=C3=ABl, regarding [this]. This change adds a lot of self-referen=
ces:
git-am(1) inside the git-am(1) doc. Is that problematic?

[this]: https://lore.kernel.org/git/1a4060f1-6607-4b50-859d-927642eb34df=
@free.fr/

>[snip]
