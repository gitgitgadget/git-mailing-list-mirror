Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9094048CCD
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891740; cv=none; b=OmuVVeUlr4pK42IvAsNFtzo4nY5UMLUrDZpxicL/zGGdhv3tY5Fkh6gA82slrHxnbiYILpSloHnox7gWmsRlSabfSlFfAcApAvlzSpapKRta9PBR9gKPd+fOf59X2jNKKojDA1dsydNLKmouDb0Q3gzM2cYYSEOJP2UdaRkyakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891740; c=relaxed/simple;
	bh=aM75mfuP9dcjzelurNZbhl0w9XajGRQUuIecf7nQm4U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=CIZkba7VHZgv7XhqMFqJagjvo1FISGUltM5in05Q4KN+qat397jn8JXIS5G0dLnL3n1oWcY/6BThPS/4CMek9G62etTy5pbn3Ozq9Nni16GYh5aZyTY66Cn1Qc23uYE9QEYz7XpscyWS0168B6i8y/iyZ+ZIaymZ7o4GUS7y2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=U74yZ2mN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YmSkOqoD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="U74yZ2mN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YmSkOqoD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 82BAC1380118;
	Thu, 20 Jun 2024 09:55:37 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 20 Jun 2024 09:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1718891737; x=1718978137; bh=mf4a3BdFznfWPa5+548olafRvaBVU7qX
	Ar7uTQciH48=; b=U74yZ2mNhla77hJB3L1wfi8Ra+Jv448eAiW5NM+eCjWXSIb1
	/wZJmpTMsnkkxKUKQfj1SJ+m/T2jd/KxCbx4BTgdSuYegD+HBGvN1uQ6mlv3VDg5
	TXSDk8jFikyqP1gF9BmVICgGbDX1x6K53XfuC1Mr1vCQ/n2ZuRI83HuZgts8RrkV
	Ez7S7PUdDqzMegcXIwrX9bHelnpMtTBf4ejoRAyjUC1dKRujDcO7Z8xvdmNXzRCC
	YlgDKmD3hlfD4BcLaXaRYJHtjjINnjnkWG5eOZULjtErZwR+96Tdl8tATsW6gfSt
	4xr503Aw8FmzPvFsV6QjM2V1El10sM5IijTc/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718891737; x=
	1718978137; bh=mf4a3BdFznfWPa5+548olafRvaBVU7qXAr7uTQciH48=; b=Y
	mSkOqoDHCFSz+PNeuluUtsBmGiAnHDF6DIsYmSofm9+AEygTMW6aeTyfHPh5TENq
	XE5hS/ulz7+b6RlkI7LISqv5rYionc3hPsPr1bWI8Mz8tWt9Q5BU082POE1/F5Ic
	16fZ7H38i4hGz/mjIN94iYlG2z7N1QqtmXAyS3PNRfs66cjEP+TtjrUfNJ4r80VZ
	2l3ajqCDe4Yf32rROHz8nNGwyNC/pMriTgPbul5nuFFPIv9HpPFxvFkiJ1PTt7NE
	3d3vG/JKr4hBdaVPulgpPWjOoUG+JYHBGRQcwYKlYQWTfB6pG1V4C59NwvBCO3A5
	rWP2O7svyCr+WM9DRPKHw==
X-ME-Sender: <xms:2TR0ZrvGCsFhsbAlGEReo1yU70WTzhWK2Bu3tJHTH1D3FqJHy-Z-uMM>
    <xme:2TR0Zse7fIa0BSuC4QTVbtfvvutEkBdbCir_q2bY87r4VtGTRAuMcqzdTpt-zRLn3
    3pk3Omwoz0Pu15TuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:2TR0ZuwVpfitRYtBrniXIo05252szDF9KOJxVCQHIOUfQhf52TMnxQ>
    <xmx:2TR0ZqPJb1IHYjcQFYTdU3uuvenooAaPuXkSkDhD5_znLo7Yu3cy4g>
    <xmx:2TR0Zr8QSQH152fY8tYRCfUwfa3PoJSwpreeMoAVH0TqxVWlNVc_Xw>
    <xmx:2TR0ZqVXIsQby50MDvJkeCJvC7wTD1nwvdDWD_ny3y7x7Wih_mUzww>
    <xmx:2TR0ZllGi4uuSqUD1kKStbZ9UEPCRzQcgth1l3YKLQ1YhLS5eZzTd17O>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 30CA715A0092; Thu, 20 Jun 2024 09:55:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <665f77a0-f301-40ae-ab94-2920d15fcc8d@app.fastmail.com>
In-Reply-To: 
 <CAG=Um+0LXVRHmvKdTB9WHJujjh9agK_ZHdv45ffzMsqX65NLVw@mail.gmail.com>
References: 
 <CAG=Um+0LXVRHmvKdTB9WHJujjh9agK_ZHdv45ffzMsqX65NLVw@mail.gmail.com>
Date: Thu, 20 Jun 2024 15:54:00 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Shubham Kanodia" <shubham.kanodia10@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: Git Maintenance does not register multiple repos
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 20, 2024, at 15:15, Shubham Kanodia wrote:
> When I run =E2=80=94 `git maintenance register` to register a particul=
ar
> repository for maintenance,
> it appends a new entry to `~/.gitconfig` with the repo name.
>
> ```
> [maintenance]
>        repo =3D /path/to/repo-1
>        repo =3D /path/to/repo-2
> ```
>
> Now, since git uses the INI format for these files, this would imply t=
hat
> repo-2 actually overrides repo 1 for maintenance.
>
> This implies that a user can only register a single repository on
> their system for
> maintenance.

Imply? Did you test this? From memory this is a multi-valued config, and
multi-valued configs are sometimes listed by using `=3D` multiple times
for the same config variable. That=E2=80=99s also what [this] email says:

  =E2=80=9C The 'git maintenance [un]register' commands set or unset the=
 multi-
    valued maintenance.repo config key with the absolute path of the
    current repository. These are set in the global config file.

=F0=9F=94=97 this: https://lore.kernel.org/git/5aa9cc1d6b93b5ad3d66ac01a=
4518a91ced39bcb.1664287021.git.gitgitgadget@gmail.com/

I=E2=80=99ve never seen that git config uses the INI format. I=E2=80=99v=
e had the
impression that it is a bespoke format that simply looks like the INI
format. (But is the INI format even standardized?)

I have two repositories registered. When I run this:

```
git for-each-repo --config=3Dmaintenance.repo maintenance run
```

Well, it doesn=E2=80=99t tell me what repositories are being manipulated=
, but I do get two of these lines:

```
Enumerating objects: [=E2=80=A6]
```

So I surmise that this command is being run twice.

--=20
Kristoffer Haugsbakk

