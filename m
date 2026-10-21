Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605695;
	b=1sHy/dayiyz6fXWKCjIhmydmtRaj/ns1waEEIo5BqGydvD69PB38c46TRFOvJ6nKatFl
	 oiXO36HFMmTgKg0JSGrnVgFsEEcE0gaL1e2UQBLdFMxV9p1/IC1ig6Mr3lbMc/ZcP46pN
	 qruF2oSx8zz7Ak449Yw71rKUGwFSRQM1xQ/QoVPCq3wbGsPi9gcbr6kDJRMYeOEKxKbGn
	 WpDpfwzkHJHoCQsr9925aDn5nQEEor6mfvt9EVkPrOFWuJPzFRTqfIOVDapgjNqyD7tQH
	 X3jo0399xfvjfJ1YZpfN2yAC/k00xQ6Vw9TidgUtFSyaST+pBaTQQxf3eJ7rJamN58g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605695;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=+ucdXBqjrPgdpDPUtcceIJyftDZkOT3oEOY34DEa04s=;
	b=iEofzToGuqNqj8uLtj4sGqZHgs2IvRZMrIYe6xqUcUQ8wloVlVzJ9wcKqCpkbqSIA/sS
	 SaSYkBfcTwmgO1BNvc1J0gwcyKDNzv9NJjvT3x/QdjkSUrwRpkYirZmBTEdFkG9zFDkUJ
	 /K74BDm9BJ0Dph9y8HkyPxF0uRDdOLYsTxYP+UUjqWBAZ7Gioo1y1XcdHF+7Ojuim0gYr
	 79UEOpnWzMgfaj4QKFcDiPYoFvC4U6raM6lHwItNZcULYcHxWPW4szJ6vdfZeORpGeXoR
	 j1MTD5W85c4T16ZXP0jiqVz2BnpGg2WLz56mfx1HB+5v/Iwd3OVmSWvv8AI5rFuDzcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=AoECdIke;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HQhfeW7W;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE50606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE50606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=AoECdIke;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HQhfeW7W
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AA197A00A4
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:01:33 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 21 Oct 2026 14:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792605691;
	 x=1792692091; bh=+ucdXBqjrPgdpDPUtcceIJyftDZkOT3oEOY34DEa04s=; b=
	AoECdIkeeqsG+pBBjxQxQUXveTKBOPd5vWOtriKOpVVhiK+FfGvO20VhggGZLj04
	8vDwSxHpTT2PYmytyMqIXqrARlS7vI7Fcaw/Fh4aWsZIum3NZceldAl+IQxa6ZV2
	dxmzopObpPwGtxOL1ALSOldi1IxOXX2uGOv802JY0CbiobozyvRnkAbrRGFyqMbc
	vBdkcoROEUvx3bNlVTOBozDS6Y5cv255w/70989ia8i+EegJC4u8zP8g1jfEB8b9
	RmT/8wMtjePJt38nmjt7gpluyd9txHkCb2Sc2nXDSNRkrfuqXxB4fSu0DgVtUQ5z
	NgaczBNjr1px2QwVP8/5KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792605691; x=
	1792692091; bh=+ucdXBqjrPgdpDPUtcceIJyftDZkOT3oEOY34DEa04s=; b=H
	QhfeW7WXkWqNgMtib03INKNtFn1/J0ye3SceTiEKInMUoNvc8vkS4YksCZquSAcW
	uaL0iNevMZQMXTING3jn1XC8JkhHX7/pPk1pUf9MahUBdWc5tGviGQTaGhvYPVH9
	vV4OkxuKCsh4UXwdW6A4ApRC7rb4scddbR/E8xYH+wRIElM9nsmUsGKtJ2W7lT3W
	xhkp5X5LSbgzuKtZx4BmVbgrKHEEXaE8ZI1UXTDqy+8gbzlW1si+qsmZiNuk0oOC
	foFmSPbIAJyIxyTjeJ634te2pLLKYFOTcgr8WWYTjERLqzdHuov2fSL1qCaA88qd
	1yVEINEmQgZf/01IGoDxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792605691; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BOsgw9tO7ULAsPOmMjjBj82W3JH0VU3SAV2ZFwt0v5/pFVs
	48LPbzC5yNlz9wXD3v/6fbU5fgMeWb88ppcdcJLXFicFmP+LaqaLWBs3JU7NomJJ
	AL+6kmiGq064b+X6I6INiWkadLEx5TTCEvke2iLyLElqzG9/taR6/PjYgeLPONlt
	UBMzWhoG/EZ0626VPuLLONVLRwh4Y7yqUxL9LNK9y6cNIAg00PxWAC8wBB6Jk4AZ
	lzMmFGqWUuooZCQEq01Dp+DSfTSA4AS34Zp9lc4OsABAL5h6Z3rlr3kCyqu5ytYl
	lXYCjPSIe3T2U2OLErgth7/TUkD6tCNJTE54Asg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:POTtXTPCpDZc5LZgTVhMj9WxyFTrYCkisLZZnmJBUKE=:1bv5L/NXwWQ6EwHdbIqKxy9paBRyqHmNHnYpe79PdS8=;
X-ME-Sender: <xms:-P3YalDG4wV5BqPS3ILSVH_34x6U1wEeu4d3ZiclTtJ2CqSbRQaE5Ew>
    <xme:-P3YauUjdjOFuEklS4vALf0vJmdEMJ9I86_QF-DmLBcf4Ox5onA1_dUM1eYscWONM
    C0UEQG-Gq_GQB8rDJ7Kdx-UKcPjkiN6OVIhOoCLpqYi94XJE7c0k9M>
X-ME-Proxy-Cause: dmFkZTF/nN8jmscYEha5KcEcQPK84k6NjuW/8IO7FJCELWKOEQK3v6gcaiBt2AIasHfMQ0
    Q3fxiudzXUEYz+ezsoGaxWUY/SH9fP+vk9wcdqG2Ofhwyl4wSJKJreYN9rsmEN/5tflMA+
    Zg9s4+3151nXIxi8vzYeB9udB0s1DURd8qPLkMTnSPLgEQPfKC7BGpgZD0J33uX+EjnSLy
    xf0h+buICemDbQUjlxXbROQzLQXfNXM9aMNSVl/hUZlMKAweMGzE3UFCogwvrpRxO5Llzj
    Pth5Otp12nazBs1/TJOwBUep75+8NGxAC48a9O4Y4h46mZGdPFpcFvJszKBC70kp0MMTiD
    7Rd34K9mIFq40aNRWuIWHqdAJtxla72DNYkTV+b/GMtVPLd/rJylG2+PDuZsaBuoMBy/qI
    FojcBycFuUM23D5+LXPxr7VyCQEELiUojPRMlWKg2kbECIw5cnAz8pA7zyDihIo+RbRJWe
    BogzhH28xzj0MCQnTtY49WLaW1KobUg0faXHYdFwuYJTRCY0EJW2Kqxk12451n+wreCOHG
    oINhVlNmc9A3Gr4+IwQkUEc1/d5MxJqmZL3Zmab5ZfKKUtPYrpgYOObdV0x/oPn/Lb6MGo
    qVZB0AyEtKJPelSy3hFLmsbaPiVwarNVU22NHc68LxYq/J8i5OJ/SoLSw2gA
X-ME-Proxy: <xmx:-v3Yavq-5XIXeCyBWmFP64DmQNZKFm1zlKiIUfP0TOBPPOG_vBCPQQ>
    <xmx:-v3Yanf6_gi43x6NEO9GtN4hIsQ180oAM7sKN_VktufiQ4Nm1DYX0w>
    <xmx:-v3YamrEjK5LObywUU_IIugmr7CbbQU-Phu_lyQKKs8TkFrgXWmJXQ>
    <xmx:-v3YagErtRbqj5aFseFteLof6b1z2mSEx3OmQmZnHeB5IMSWElvuQg>
    <xmx:-_3YatNY-95HBsCkbgzNahwgeHgr4YODWUB1qaGuLlUXba5vpPJCDZg4>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9BFEC22C009C; Wed, 21 Oct 2026 14:01:28 -0400 (EDT)
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
X-ThreadId: AB9N__B7nd93
Date: Wed, 21 Oct 2026 20:01:08 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <ab05a3c1-9da7-498a-a9bc-d586414ad0ec@app.fastmail.com>
In-Reply-To: <xmqq5wyvq9p8.fsf@gitster.g>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
 <612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
 <CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
 <xmqq5wyvq9p8.fsf@gitster.g>
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026, at 18:50, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
>>> Is there any interest in continuing this series?
>>
>> For myself, I favor making more of Git's documentation accessible to =
folks.
>
> I do not know about "manual pages", but making this available from
> "git help" would be good.  It raises a huge question about what to
> do when Git 3.0 comes, though.  Are we going to change every section
> and rewrite them to say "we used to do this differently before 3.0"?

See me and Patrick=E2=80=99s subthread: <ar0OicAaDipYx-xU@pks.im>

You could transform it into a section at the end for =E2=80=9Cwhat happe=
ned in 3.0=E2=80=9D then introduce it with

    These things changed in 3.0. They are written in the future tense
    [?] is reading about what will happen coming from version 2.98 to
    3.0.

Then you wouldn=E2=80=99t need to change any of the rest of the text.
