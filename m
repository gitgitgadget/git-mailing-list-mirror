Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B791B4138
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312651; cv=none; b=kEnoSkEqrh13LKGo2oIFZZcmebPkKxffxRWKhAx1IC8PLM5+o4JREoHO7Yxzih45UZJ+Qu/anottA4JAoW0nRQTxL3CzXF7AG+2q7qNYiDJ7E1M/LLuYfiZHdHDW0ZWjI9Y8yKZpoyCLzioe6Kw21L6w1gseXqiJf5wGa6FgfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312651; c=relaxed/simple;
	bh=NhEVjpIT4CNz16TnxdQf4x6ich9srnmMsaQRk9dMYYI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GpK7YwnfgEqxDNrBq1Djlj3Nm/DLNous46HMD2ivXX0qyj0Gp2QZFTzYAQpMi/pYmqFyg/9aeLEcGOGEoHBGdDSEFZFvhYnevWHnRu9TVbBl3M0z5NUP0TshVt6m/16Deh2Rjj+wpgDPXhNMbjdQfYQeOBqY8FEkTlydy+6NsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eUAXmDjF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zz/Cj6N/; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eUAXmDjF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zz/Cj6N/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2495F1140120;
	Wed,  4 Dec 2024 06:44:07 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 04 Dec 2024 06:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733312646;
	 x=1733399046; bh=RD7YjfKRmQV0HU7l6ns0L0bSYJgJIVCcO12PTPT6l7s=; b=
	eUAXmDjFk2XdT+wb5/WlxAwn1KaDlLweWAG9iVKYB9R/eXbw2TX1I6+znuv+eILo
	NQC1HunOUQbtfe42LVr43s+Hff8rWazgTvWEt2LcaMYnaSyMTCdtFyv83EubzS2v
	ivnlpw6vlbLvNwF7lr5qOOj01wLKWk931hmzbJH4JyV/96bcT1Ahj59y7SFukjQ5
	4thlkMEsnVI75p3lr2Mmu4PBhtjSAuRbntSx3Ew2AgSDkEWyO4P7mH44xFD21uJK
	Tng35H1hQ3X1152eb7cX1KfmBDuM3W/NxDWoB2T250fqRMYwxEXyO+AV/NkZI8jH
	Q1Bu9j8Bmr84ugVrBLeVkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733312646; x=
	1733399046; bh=RD7YjfKRmQV0HU7l6ns0L0bSYJgJIVCcO12PTPT6l7s=; b=Z
	z/Cj6N/ZXHyECtgZ9hXq6bGYbm6fpcfxnAm6IRUa4Ml9B3mGmsy568oEtBM5EzS0
	f5bQJ+zssA5nH7O3tC+krNbMEjmzX/OFJNX6v1cW/01U+UEKS/6wiB+9Y1ULQfVK
	xzWe4BCdxZjlC47hXzaK8Ld5Wzett1/8ab0xN5i0SxjN8vHe7j4th1daOU2DH7nj
	zDpqCNunlluno9c2Psl5w8QIxwVq/atmhPJwAy5zHeDxOr/9V/UGZYjdYXm6ndpV
	yaXfS5yt5J/t+MF1EMJSkuvncVzyWudB9LK6+uLn8EfHt4S1uiic2Lgj93XgEQt0
	QOn6eEbMrJDcfH53lvHgQ==
X-ME-Sender: <xms:hkBQZ_csbX2E8kUS61T_pB48c9DOlXo9AG4UsU6wEY83Zkl3vMqrFxQ>
    <xme:hkBQZ1MrjGvjR9Tdh4Rxz2Bg8cLvRsezyHrTOZdnz25C5RAW7RtqhTSlRjYguHeSd
    Ao5MkI6Z4z5kKLg8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigfefke
    dugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepsggvnhgtvgesfh
    gvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:hkBQZ4hcf5sWa1Ma0m6N-5zyjY0LP223Vk0sI7WUR17V56vOh2OMyw>
    <xmx:hkBQZw8CoCTvVlToehJT69vfnNY0cVAUpFw-hJnyK4ckjAO-9AxtDw>
    <xmx:hkBQZ7seEn4uC1__sS7uwGrMtfvrgFsqWa8qmn4INt_KrZ5ieZorYA>
    <xmx:hkBQZ_GznfRFI4KU-c5lBGUrKGzECxB0O4BVFU-b1IOF4PviUanS3A>
    <xmx:hkBQZxB3Xp_0IAwG1EWUm9xIBECh4EqEE-v58KmyI82ldKJ7oDkiBOcH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 42626780069; Wed,  4 Dec 2024 06:44:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 12:43:45 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>, git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Karthik Nayak" <karthik.188@gmail.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <cfd54be2-af8f-429f-a4c6-41f54c33c89c@app.fastmail.com>
In-Reply-To: <20241204104003.514905-3-bence@ferdinandy.com>
References: <20241203215713.135068-1-bence@ferdinandy.com>
 <20241204104003.514905-1-bence@ferdinandy.com>
 <20241204104003.514905-3-bence@ferdinandy.com>
Subject: Re: [PATCH v2 3/3] remote set-head: set followRemoteHEAD to "warn" if "always"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Dec 4, 2024, at 11:39, Bence Ferdinandy wrote:
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 7411aa770d..daf70406be 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -504,6 +504,17 @@ test_expect_success 'set-head --auto has no
> problem w/multiple HEADs' '
>  	)
>  '
>
> +test_expect_success 'set-head changes followRemoteHEAD always to warn=
' '
> +	(
> +		cd test &&

I think you need to `cd` in a subshell here.  See `t/README`, =E2=80=9CD=
on't
chdir around in tests.=E2=80=9D.

> +		git config set remote.origin.followRemoteHEAD "always" &&
> +		git remote set-head --auto origin &&
> +		git config get remote.origin.followRemoteHEAD >output &&

Nit: maybe `actual` instead of `output`?  Just for uniformity.
