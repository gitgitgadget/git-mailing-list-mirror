Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7213699A
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025384; cv=none; b=op+vEU04PjhOpuDEq042d6glwWXfsV+hyKzO6r+WYNh+VyJgaD6l8A4OSCzWwpNK6ImYW2Q/J459pr0UKebT4LKcF1bvNNE7UDT5MusbvRJtiYlIopcGFTjyWZHcNclEfS+jqY1Aa+hR/sygZBauJJQW/S5n8dJ52dh74qmPFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025384; c=relaxed/simple;
	bh=wd/hqb/chrThfFRm9GwdUCSj/avNjxUpRk9ar1wYpJE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aLF7FR+HJtuLOA94vl7ZIsOEccVDymIcA6w7XrIW3qPH2coK2w3GEhlM653uYzC7QB2So6ttdlhV/ih185O9hXx4lRJDqhrBk1LCeI2E+4SQQ1u5yWlMccq25xq8M7OOaKHK7yiynTMtLyLxKp8oi0NHnUKXC0gPvkOmR051lAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=huNW0ecI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHF2GrJY; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="huNW0ecI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHF2GrJY"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id B8F9B1C0009A;
	Thu, 15 Feb 2024 14:29:40 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 15 Feb 2024 14:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708025380; x=1708111780; bh=FJ2qUiRxOSA6D/vz0j5DEYfRGqQcHywm
	Ioq8yzKUa9E=; b=huNW0ecImeoAkPuIkPn9OYiGUs9F6E6pCtmJCjpTdM/Vkt0W
	nVlpbGdGIjJ45TW00oly23YKM20FvOGrZftFDXjxLlBQeIkBnuUTqHN3Jo9++6cI
	VTxoXFiybmqGQd8Ch2rCer7ZnULSs/7DjReB4Gnz98x/LuSYU4F7mIATv9fW3/S1
	jsexcuCP/WKtrO8ksifsjFq93hbQlgxIbpMBFkXxp5t8KDO+iaS1Cb5vjB+7N/hs
	C1qjjpWzImUgFK8V6T/z0Wbu9c6Y4eZqwf/otQQ819sXUhnQIrhcJIBMl2cxnXNV
	6Eg+u/NCnXCSiRHEj8gnhZQICjcsjkATxVLQkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708025380; x=
	1708111780; bh=FJ2qUiRxOSA6D/vz0j5DEYfRGqQcHywmIoq8yzKUa9E=; b=i
	HF2GrJY0pO2kFU3KQV+/lRvBJNnu1orcXxfdlJTbswYJNNpNWRnP/8vGbdIO7iXi
	rh0LFCdmKnq+LLwqPTjsni5rlGvuMndNN9In9m2v7Z2nD6rqYsMP7CyJqJOoSHqF
	QY1ItHUif7vyFZ4q5HnTUHvpnOqGo120LOmGIrmrP6rPUSFFsyEBXSnaKsax2QG7
	+z0c8xMAxc1Qa6ApU324Hcbel3bLjXHvdgHbsA6J5ArCSFn7pdh2nOCtqcbt+zYj
	jFGewYj7CKJCblRRKXrSLpo+LuDdUhWGBvAcPcRu1W1MDUtGXVZJ6ewtjPBalMnz
	Jx80xvJWC8OGsTN+6wiBw==
X-ME-Sender: <xms:JGbOZbN7PD27eXuSiMJgfxHxftE1m8fkNMojgQgi6QsJqkFZyQljXx0>
    <xme:JGbOZV-Z3fR62BdVHxanoMcwkI5_IHRe8sdAQmjSnAGVFZPu2mSS1r6p9VmllOkU7
    HsBlqRaKaNTOcslqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:JGbOZaT_GRd-fQfkfw1LpNamMqlvkMv51NzC8nWKKOsBSLIUYXsNLQ>
    <xmx:JGbOZfuc0lltWBVt1jNjmJMflwbV8DuTDTMmcrlkvfyhD3-W1Jpu0w>
    <xmx:JGbOZTcdXhUvwQRa6FZDoeJmDuew3Z3B_gImBFbtS9qkVc9BALC07g>
    <xmx:JGbOZf4WNDY29V5lvBqmUtnI1EatuXYP08AqOg6fmFW27cLlN37Y12EC3ns>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 00B8E15A0092; Thu, 15 Feb 2024 14:29:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f9ec6d31-7158-4381-9701-06fcb33f2e83@app.fastmail.com>
In-Reply-To: 
 <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
References: 
 <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
Date: Thu, 15 Feb 2024 20:28:45 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Kyle Lippincott" <spectral@google.com>
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy operations
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Dragan

(I=E2=80=99m adding some Cc from the previous round)

On Thu, Feb 15, 2024, at 19:42, Dragan Simic wrote:
> Move the descriptions of the <oldbranch> and <newbranch> arguments to =
the
> descriptions of the branch rename and copy operations, where they natu=
rally
> belong.  Also, improve the descriptions of these two branch operations=
 and,
> for completeness, describe the outcomes of forced operations.
>
> Describing the arguments together with their respective operations, in=
stead
> of describing them separately in a rather unfortunate attempt to squee=
ze more
> meaning out of fewer words, flows much better and makes the git-branch=
(1)
> man page significantly more usable.

Excellent.

>
> The subsequent improvements shall continue this approach by either dis=
solving
> as many sentences from the "Description" section into the "Options" se=
ction,
> or by having those sentences converted into some kind of more readable=
 and
> better flowing prose, as already discussed and outlined. [1][2]
>
> [1] https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/T/#u
> [2] https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/T/#u

Since this is a one-patch series, it wasn=E2=80=99t clear to me what =E2=
=80=9Csubsequent
improvements=E2=80=9D was referring to without following the links. By f=
ollowing
the links it looks like plans have been made to improve this man page
further. Maybe the commit message could either state this intent more
assertively or commit to it less (like =E2=80=9Cwe might in the future=E2=
=80=A6=E2=80=9D)? So
that the links become supplementary information instead of seemingly
filling in some blanks.

(If I read this part correctly.)

> --m::
> ---move::
> -	Move/rename a branch, together with its config and reflog.
> +-m [<oldbranch>] <newbranch>::
> +--move [<oldbranch>] <newbranch>::
> +	Rename an existing branch <oldbranch>, which if not specified defaul=
ts
> +	to the current branch, to <newbranch>.  The configuration variables

I had to read the first sentence a few times in order to understand what
the =E2=80=9Cwhich=E2=80=9D part was saying (which seems to come from [1=
] by Junio). How
about letting it trail the sentence?

  =C2=AB Rename an existing branch `<oldbranch>` to `<newbranch>`, with
    `<oldbranch>` defaulting to the current branch if not specified.

=F0=9F=94=97 1: https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/

> +	for the <oldbranch> branch and its reflog are also renamed appropria=
tely
> +	to be used with <newbranch>.  Renaming fails if branch <newbranch>
> +	already exists, but you can use `-M` or `--move --force` to overwrite
> +	the files in existing branch <newbranch> while renaming.

=E2=80=9Cthe files=E2=80=9D refers to the branch configuration and the r=
eflog? People
who read the man pages might not know that the reflogs are implemented
as files and get tripped up. Maybe =E2=80=9Cto overwrite=E2=80=9D could =
be left
unstated?

Or maybe I just misunderstood this part.

This patch also drops this part. Shouldn=E2=80=99t this be noted?

  =C2=AB , and a reflog entry is created to remember the branch renaming.

Right now it looks like (reads like) the reflog is moved and an entry is
not made about it.

>
> --M::
> +-M [<oldbranch>] <newbranch>::
>  	Shortcut for `--move --force`.
>
> --c::
> ---copy::
> -	Copy a branch, together with its config and reflog.
> +-c [<oldbranch>] <newbranch>::
> +--copy [<oldbranch>] <newbranch>::
> +	Copy an existing branch <oldbranch>, which if not specified defaults
> +	to the current branch, to <newbranch>.  The configuration variables
> +	for the <oldbranch> branch and its reflog are also copied appropriat=
ely
> +	to be used with <newbranch>.  Copying fails if branch <newbranch>
> +	already exists, but you can use `-C` or `--copy --force` to overwrite
> +	the files in existing branch <newbranch> while copying.
