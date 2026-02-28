Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321011DE2D8
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772314235; cv=none; b=FHYO8iV+U/eCCxtxEhE1EcRu2UzhGYechc4QyWvusVb5s+ZtGalOXDT/SzS+0ZVEYPlo+RSAUwthZfHLcuZfU2gRmh8NXi+ZjALvhqjZDV8HKK33+GoiH/z94EXpaIsVfKnYmM4hg9u6ccd5GaEssBXha21s0VwfycMnUk7OVLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772314235; c=relaxed/simple;
	bh=vpwBbJhC0WclyJ+wzHyvz9zxYb0TzRlIinb8XcHaMZk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WLTdxzsY0TaE0G2PFDmA1D9le7JH4dFDZz6thI29IHbkP3qZ7OMy4LEI5KC1KmlTtL1fsSpPPCNzbe1ui6hFLk9lud4MlFgtFNPciNZwzjMVstka9L375cfTzVB9grqUWtLTJEAZvIvjn8WtTiY1fgOTIKuN7pzxaPFtoNygEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z2M6njra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kxXpszgn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z2M6njra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kxXpszgn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E2AB14000AF;
	Sat, 28 Feb 2026 16:30:32 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 28 Feb 2026 16:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772314232;
	 x=1772400632; bh=IlRuo830p8Qijg6U7ojLX4lSvMan4Kq+xk+QYf1WNvk=; b=
	Z2M6njra79VBVsxpWnm2psgCeVIlBFTwxTLoGk6fgjxX575mJZdDLXMBExdVzveH
	ndxEcc9HISAgtXctJkdmVXPseosFh5UGGHVe3KCLVeiw+qvnPGA9kv1W9Sr/YSYy
	8j5UeBqDe7YnAicV8RZXvZwp0EM3Vn+jdtLt3AHNCyETYddu6n/Y9CJlRDLaVQys
	YN0+wDp1QM5r9s7OFamIxeJ/Hw6ztObBB2YYjl3Ds2brVmjBO64z5KL0mqir8MpT
	IwixU2Hy4UsFIyjZWqjMQ5G9p/j6tQvbOmBRTaRqbRlBbsfZl/9kYiEL0qVN5Kjv
	nhBVB+BAvoszac9UH0eevg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772314232; x=1772400632; bh=I
	lRuo830p8Qijg6U7ojLX4lSvMan4Kq+xk+QYf1WNvk=; b=kxXpszgnYV20+Be7M
	SnmBgjxQDRtlkcGboR0WlaRjM0bv8n69z87HlpupSiPlYgWnsczyN2nKXXS0DG3u
	q2iWkrdDdtO++mnmyytKzFmhp2ZakaBlJvgLVvESR6WNUvquA9rtotpkCjlL47zi
	oWI12W+Cb5Ke34zJdjEX0YD8+TZQa39DVPu6L40djgUBNmW3ozGCuqPRvlUyMyUD
	wfuLGnL+sdJFM7kkiDq79nIiihOJLRThIdOcbKGyhI3XBt0YLjHrlA2WgSI6cect
	tBW+57vD4aprTi1/8zpDlSFk0u++bKdxWm2TOmrrCcImEZ/nTa6/D/UXLyxAFzkH
	GfJuQ==
X-ME-Sender: <xms:eF6jabAtLm0sEV8j8kw2uSvu4SETWHlKA95VZAKT7Sdt7SJ1aB_qXqo>
    <xme:eF6jacVnhJMGH8xX2m6z3-aTgxSlV_hsYNs1SX9Fq4DXnX3uNcBN3-wYSlhVPFJya
    2Ms_SD3r841pCrwMANCR3DGz4Ww1JCOmFKVVoX31TbpxGUGY08YwOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedvleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrshhtvghnshhgsehmrghsthgvnhhsghdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eF6jadtgH8R11exS_Lg7MNghcamaBc8kDEKAVGTyYvbzDivDhCPAzA>
    <xmx:eF6jaUZIHw4YYjiekW73EpVRMDLyuz0LwsdUPt2dsrhjQDcHY7i2qw>
    <xmx:eF6jaYUnj1ypsQG1MMCEiSrqisKjc3Y19T1K4Duo_J-WKpQvvBPgQg>
    <xmx:eF6jaQ49qWgGzHxV4n894_d_lBCT9pILgXWZJlx2oMv53N7Fsw-4Jw>
    <xmx:eF6jaZFtR5Hu_TDRSUvR70SzV-aCH-LlXaHUUpGIiS8RSVOH4uLMe6W8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 184CE1EA006B; Sat, 28 Feb 2026 16:30:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzthlaOzFtZc
Date: Sat, 28 Feb 2026 22:30:10 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Martin_Stensg=C3=A5rd?= <mastensg@mastensg.net>,
 git@vger.kernel.org
Message-Id: <af273fb9-25ae-48e4-ae06-81424383f54d@app.fastmail.com>
In-Reply-To: <de1a96a4-c38e-4200-90a6-2b87139cdb47@app.fastmail.com>
References: <de1a96a4-c38e-4200-90a6-2b87139cdb47@app.fastmail.com>
Subject: Re: whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026, at 21:22, Martin Stensg=C3=A5rd wrote:
> git version 2.51.0 told me to let you know that I still use the
> whatchanged command.
>
> Please keep it. Thanks :)

This command is being removed because it was supplanted by git-log(1) a
long while ago. Both commands use the same machinery, just with
different defaults.

You can replace it with `git log` in this way:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).

You can also set up an alias with that name on Git 2.52:

    git config set --global alias.whatchanged 'log --raw --no-merges'

You cannot do that on Git 2.51.0 since you cannot alias builtin
commands. But you can alias deprecated builtin commands on
Git 2.52.
