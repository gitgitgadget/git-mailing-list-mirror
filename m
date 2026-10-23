Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731123;
	b=BkXxiku3tNc5VlEVdM4Shk8WYZRWgKIMsfASbkWe1A1t+jJpVSbhDc54U2721jarVx7p
	 BmJadLSB1hK2i2HraCH76DDYYrZu91Slj44IEwOzgxJxeud18c39JcASSp5v2T54MV0KY
	 9nc4p52Dq059KgQXTex6dreHdnqjaktzkjoE+ujvC9NALlG9J4WVREtYr2TpBCq6ckQa+
	 YhwWcl4A9JXtjW0IvQIog3XeeGNUj/YApRwyBkF7Q7Qw610pJkHo8FjiSL6qrk+EhanVJ
	 4vIs5wkIabH5GMBxi+psGjrPIGle1HQq3KFiAm4aLqs617mP2Q1fQirOvOSsSjJShTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731123;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=8IX4rNsUDPFvwAoFfTqszeykMauRJ+AYcf5Koks4aEI=;
	b=kiQ64HHQFs8G+3lqEWFtFqYCpwmIv0L3ja/aLpbY1qza5kOB6YeALuP61w6YAxNXyfkb
	 AnRah4eV0CcJDk7xdUvLfY94zEXkVpYqHCd28S69N2xRQ2tt9ZBgyY9iBdqbmph++8fZM
	 0OvtqWzI2dSILpS0y2iijGyelAM0dKwWDP7dcajp8SAfUHmF8vemsEzbUMbyam3Httv6D
	 JYX9XclkRicMDd6q49jzkWqBCUmw/YGKWeMjcmBe/MsIWXfSu2UD6KgZT4dRNDQeF+5V9
	 1HdB2ruAQREbzT0chzkovlAzbr9TpQSqIMk/JxUQe0WQ7SOsZ295zGxl9BxqmJThq8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=YzQpxog9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=D6bccC0w;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC44606A323
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 04:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC44606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=YzQpxog9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=D6bccC0w
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 81E20EC00A1
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:52:01 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 23 Oct 2026 00:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792731119;
	 x=1792817519; bh=8IX4rNsUDPFvwAoFfTqszeykMauRJ+AYcf5Koks4aEI=; b=
	YzQpxog9qmpLDDIeDw1C18kMNMgq77ykCsDjtdgHwDT2R2bJ6WeJhSjRcdkNuLMn
	ZKvEs3kEERKqLbVXVLFysQIvp8oSA8UWIyjcN9ukze98FK303i0aCvHs+XkdhXoO
	6rSF7FOVP8kP1acaKSIYQcGp7os09mrD52fsyDNH7baT6z1ee3SHroE5zCZgPNWU
	5WgRvtL5YS0Sse2lqB/LKhLy8xwC/gKZyr7myO9EuKdFoD2y42sRY7ho2T3QE9Im
	WVBcZZZHvUa73p0x7AfucGAQKsY66FtCRMWP9NPXN7zbjvnogmyCQx+NnJ1zGVAt
	gp//EMu6F4cfYoY+WBrj7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792731119; x=
	1792817519; bh=8IX4rNsUDPFvwAoFfTqszeykMauRJ+AYcf5Koks4aEI=; b=D
	6bccC0wB8gRkkYdx9lFbY5TePGzu9/izGk/KttPfWQPSaRJ2U0RQuyY5b+IaF+W4
	Jt/yZ8j9jPuZ18o+uK/HbK1bEWTo+iZTTsmPxKO81yxgL5met48BhYDEZiE4E+U7
	L6wYrtZIPnUXYrK9caxq5eQtFi6hMoNX/MWHdC6Stmfn2l7b17Pi9sYLa+pW/WSe
	ftcrlWM1Ll9AfmmQZqledAmR/Bc3LWCOsene6Rm30JJePbNYhe0XHdhvwVrpE/qr
	3QavrXx36fsa3XiPDQC3r1RLc2tiacgoCZdev7rB5uCiudFNiJcsR5jVz4QVsmZQ
	xwEp7SKFfUNNv7SAQuFAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792731119; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RXP4mKFG13RIbRqv3NTjphkyEEs+ga4NTmJkcp5NeDy3wPK
	FmlCZUbnbAlnSHhBz87NeQGkvpOoYV3nRw1aK2xbLh6vcCVvhWcZV3w44Xb0ClrE
	02TNRWOY0uolbJz5RXb6nIvuptGXd19hZUk9GeAq2y/Qf48RJVpDwvklypoMgjvn
	zfvV6LvD6R+vt+t6ikILL8juo3Byx4Y3+eW7KGCxrXCh01elzwxaYQE6PSWMSRNI
	kYztTLRldaJWqH15NwBBSkwE+w32bCc0uFpPIOrs1lWQt1crCPjQrZWOoDF+L6RO
	hK09xu4LHTb/TFJ8adeTI0E0+gQxAeicU5V8FCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HnV9+3fjMBjXQVs6GriN0en3NshyZqiLzJHU4IUCGSw=:ASjD9q2w3fO7XqwNTAfdDAGWDvT7YLUVp6sNgnCOJsQ=;
X-ME-Sender: <xms:7efaan0aqaUnQBG-qdwRNU6884dvijKi6RvNOJNHxXsrLaQSyMRsf-g>
    <xme:7efaag5plyPgQAtGrx6_tgAx8YJiSOqAg8-3MNRst_84f8oKMh53R7aMKOl6Au2R8
    OxNgqwT9Kd3PrX13x3V1nCDGQr8Oxs006NHBAi-qhHCi-ZQmIon_w>
X-ME-Proxy-Cause: dmFkZTEPtYfmU5vG73c6jhdJx9fG87hq00nZnemtAtZOkHZZJgqQ1H4/Th1V6uQ9H8Sh18
    dOnleGBQLVe8+9uC5lnf0jEdiTNPKV43k/nrwLd3zKO/zZueCMvZW/0YsQg2TwinwnKnKv
    yMZoPvnxz7pSTBLxx+VwLQ0yoHltI8sluKLEEhSMYKr+oOZmSkL3zeRB9jso3hkPGeo+5h
    yYkeRoy7G/O2TY+xhmHQuqEh4hIlrIjD8jy3LNM/aMula36XsmjqSae1iXRdgJ2wxEaWI6
    vCKAA95VFgCCIJrsMK5zvECO57dU5ci14X5fjTXGbgL0/jhT47/FZ4ihWof73S47sq+qUc
    5vL0r7A0SFRyEZWipy4gZ0l/8Bmyi4Ja6IkURpMye8AZg1Hkcb9A1iAHaBsjz8hWnFGEfZ
    FA3krGrGyOQiqf29L70JSUOFXoBUntYHbs9FyZL/o2gGWcezwQnRoNXHnXwXgjUkx5vMhz
    1HTnjvMBamOeGdD6B9dg61QNAKqceGiH1Dr6WoJqRo/Gzj2/jPm8v9ZIeVN4f3aymY3VcN
    nbtDJCfdNjePN76aZwS3gfj3MPZ2N84fXicTjNksUhGPTgILcHY6zmYYKe5ZiGuikjCQQ1
    tRvLbkCm3nEzovP2vj/PdFx1rMmtBQhaOXXbLvnoS/WqWa/6xYR1k8lZb5Cg
X-ME-Proxy: <xmx:7ufaaiyLwMfJkQRYcRsXebuXSAPFOJQ1hYt53tOLlxBZYngUp5Jzqw>
    <xmx:7ufaamBNX2fwnVz_BANmCMMrdSKUAqFGQP7sRsO82qCL75ZI2S5Vvw>
    <xmx:7ufaanat-aGKleCbKAo5X-Lj2AkoxnKNJzn00F_nDpYS206Yt94ChQ>
    <xmx:7ufaamhggJCLqPg-HVh2fASB5yRKUJI26WqrXJyw3tHf5pefCB507g>
    <xmx:7-faajJPDFLV08Wv3UyqR-5BeBWQrHy5yq37AbegQfADyPDq3AavnlK1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CA75922C009D; Fri, 23 Oct 2026 00:51:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 23 Oct 2026 06:51:35 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "Emily Shaffer" <emilyshaffer@google.com>, git@vger.kernel.org
Message-Id: <37eb49ab-86dc-4d62-87bd-7e400ea13e30@app.fastmail.com>
In-Reply-To: <atqTWKaRQfvH0Xbm@fruit.crustytoothpaste.net>
References: <20261021200341.378978-1-emilyshaffer@google.com>
 <3fe1dc57-5bb2-4e12-8876-a4969e5201cb@app.fastmail.com>
 <atqTWKaRQfvH0Xbm@fruit.crustytoothpaste.net>
Subject: Re: [PATCH] Documentation: propose community voting process
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026, at 00:51, brian m. carlson wrote:
> On 2026-10-22 at 07:29:26, Kristoffer Haugsbakk wrote:
>> On Wed, Oct 21, 2026, at 22:03, Emily Shaffer wrote:
>> > As we discussed in the Contributor Summit this past September[1], t=
here's
>> > interest in taking a formal community vote to decide whether and ho=
w to accept
>> > AI contributions. The topic is of course a very contentious one, an=
d I don't
>> > think that we're going to come to general consensus the way we have=
 on most
>> > other concerns in the past.
>>=20
>> The vote will pass. Those who work on Git at least once a month work =
for
>> tech companies. Those tech companies are now AI companies. The votes
>> will happen to drift towards agreement with their management.
>
> I do usually work on Git at least once a month and I do work for a tech
> company, although I sent my first patch while I was in university.
> Despite what some people might believe, I don't parrot my employer's
> company line from my personal account.  Even when I'm speaking for my
> employer, I don't speak in ways that I don't personally believe in
> because I'm a person of integrity.  To the contrary, I think most peop=
le
> who know me know that I'm a person who calls it as they see it.
>
> I think anyone who was at the Contributor Summit or has read my emails
> to the list knows how I feel about LLMs and how I vote as a contributor
> will not be influenced by my employer.  I do think, though, that this =
is
> a reason that votes should be secret because that prevents people from
> having to prove their votes to others.

I was not being precise. That was about being *paid*
to work *on Git* and with some regularity. And it
would only *drift towards* agreement with managemt in
the aggregate. A further clarification. This would
not hold if the group of people who work on X
is small.

I don't know who or what =E2=80=9CDespite what some=20
people might believe=E2=80=9D is about and I don't care.

Sent from mobile
