Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959F1E25F9
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759961054; cv=none; b=OQUOvegUCIgmNStvOhDpAwf2HzmD+3xRzq+uXopZDKUmtsVZLW4LuJG7l9+1DZ3tl4yEOSJeBIriw9Xxq3sJvKdq6QW9x84gl7DkildM9TWPN7ZPWkUvYeCT7ba8TvOuUr+KS47Rm3EDIZxz8z2DSJTj/SIlpWKbHa2tCMwgoxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759961054; c=relaxed/simple;
	bh=wQ28f/Yzofn+zqHPlBZ8wkq9IfOpdgAFbz9CJruehck=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b9Ke0MDML6ysejgcDTk7UVRmBxLEHXx8QsP1oofB4B9sf1n6IDUJZphWogxYijpI3FjC5qK98+b+wHmByNzn0tpCxnys1ZmLQTZg15Tq9TbGhG5N8Trr03buYScJ8byktxk948g1t0GJeD37JDzYw0Cl2g7Kt8EY5C3u7lR1YVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nBsPrtLr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VfNJf43k; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nBsPrtLr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VfNJf43k"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B03B7A00E6;
	Wed,  8 Oct 2025 18:04:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 18:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759961051;
	 x=1760047451; bh=iYP6XaTAWF0UGWdd6Oqxup9rsJH0INzJ5KiICuR8Mzc=; b=
	nBsPrtLrTaPTBLc7I8tJ6tKHDNqvq/7zL8z6xlQabPicUq6ccv4KH2gznmjkdcTn
	K9QzgzlsOvY/gHGkKXMjhUKcL5ufeXBBk95KPggHH110G9jxwAzD910EFhJFirOv
	fmhKLGAM7yA671seZ2TaEz3U/Ldag4BxS+5TDCny4CJaNCjvZBSxnuAe1WiFqPIX
	nvKbEl8EPq7wuxVhv3/n6bSNffSLpspI1lK0Bu7wk9JJ3AGVxiZEGjAMj74kzHjD
	K2r1ZDhzUbLz90jUGoULPGzeEGGM7GHR8oFOqJdgb1WTSF3iLuRocotoBtTSq0yA
	XQwHVOXZ/7H7dsYsmNzkQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759961051; x=
	1760047451; bh=iYP6XaTAWF0UGWdd6Oqxup9rsJH0INzJ5KiICuR8Mzc=; b=V
	fNJf43kfe/zttfJPpyH6/niviqa1/c/HvhN/COzCZwwCm33FbSSCrzM7Cs9U1Z1b
	41mk7KpRncTzARmWh52IwDhaXEYOKeEO0+1YcBNTC8eHk5K0EZ6x0DzntzgKBEzU
	lufqwljAL45UhFGCQoqpxHE6ROZIVdIW+VHC3DrFQ+6RCRq5eX/0g6hK6EglY5Cx
	TDCEHGuYhbPlYzzbn+yTddYT+I2p08r9I+/yHISZMU/YcJIe85ajw732uZxelrtQ
	LR46svgrMMsATi0BbhC1dwhewR3r4vf+MTj+ANNYTXG4xO9vNtlPqzWc5oeCvuKX
	bg+UzY5jlrnzUwvOwCWuQ==
X-ME-Sender: <xms:29_maCL2oO_eB2q2a0GltgZXnIaIBgPK_YEi87XvjIDLDTHW8xw5Xho>
    <xme:29_maE8skuO_Kqr151NT-qtoDvCaJiub3Cl88m5sJbB2FxIPW0hdePZoJY44-8qA0
    ku-zqgJHupQ9YHsbCnVq42uJYSgeJDlo4wi_7f1LAQoQr0jnwhmCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:29_maKy2TtEKlhewp0I6CDDUYFp2fC29XFrXUoX4_v5xn-6xYgvNzA>
    <xmx:29_maEFdUj4YjarniiN-f2LyO4Bl4COGxXYFBRQrq69CXlH5Cb--SQ>
    <xmx:29_maGxQB4wKbg3boAXrU3xXR4RpEdd7m0Zk1-AcEO2Bj6F82WoaKA>
    <xmx:29_maNuThEuKQaJjvGM3vEx-9cddlzTT-7QrzKtBTcB5ixWcw1nlcA>
    <xmx:29_maE7b5FwLnxNFMqHb9cmcGiDnMnMl03-FI08vRk_TFOjTOxHiVhMV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8F4BA1EA0062; Wed,  8 Oct 2025 18:04:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtAKOKhqNxG3
Date: Thu, 09 Oct 2025 00:03:51 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>, "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Elijah Newren" <newren@gmail.com>
Message-Id: <f201f901-0816-4d13-81b5-8e0470bd823d@app.fastmail.com>
In-Reply-To: <aObWkRSU5TO9Yvcr@nand.local>
References: <cover.1759873165.git.me@ttaylorr.com>
 <d7931dcc4380757cfd4c6f24b5d746da2294f40b.1759873165.git.me@ttaylorr.com>
 <85dbe67e-f252-4548-910d-4af29939806a@app.fastmail.com>
 <xmqq8qhlf777.fsf@gitster.g> <aObWkRSU5TO9Yvcr@nand.local>
Subject: Re: [PATCH 1/2] SubmittingPatches: extend release-notes experiment to topic
 names
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025, at 23:24, Taylor Blau wrote:
>[snip]
>> > But it was noted[1] that the-topic-summary doesn=E2=80=99t seem to =
have been
>> > used much. That=E2=80=99s not surprising given that the instruction=
 makes
>> > the-topic-summary blend in with the rest of the cover letter and do=
esn=E2=80=99t
>> > signal that the author intends for the first paragraph to be used as
>> > such. This patch shares the same problem.
>>
>> Oh, that's a new theory.  So you are saying that authors may have
>> tried but I (and others) failed to notice?  It cetainly is possible.
>
> Certainly possible indeed, but I am not so sure this is happening. At
> least from the series that I have looked at since this experiment was
> introduced, I have seen vanishingly few examples of contributors
> following the process suggested here.
>

I had a look and found one cover letter where I definitely tried to use
the-topic-summary:

    The documentation for git-bundle(1) now prominently covers `--all`, =
the
    option from git-rev-list(1) that can be used to package all refs.  A
    "Discussion" section has also been added to address the naive backup
    strategy of copying a Git repository manually with cp(1) or some oth=
er
    non-Git tool.

    ---

    The part above was for the-topic-summary.

https://lore.kernel.org/git/cover.1731768344.git.code@khaugsbakk.name/

The merge commit message and the release note entry:

     Documentation for "git bundle" saw improvements to more prominently
     call out the use of '--all' when creating bundles.

Contrasted with no judgement.

> [snip]
