Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637374;
	b=Q6ZW/9/5aTFOyqBvz7YOyCicD/n5FjkcvOdwS83LQuKceu7SNearGlyghjbfWq1MUi6p
	 dBNOYkkit8pCz36K/i5yeGRlcS/e9kkGHh/ODMAwQw1Wzu3IATw0IjCCZZDY99mVPjUT4
	 g0CWOjMnxiT6PW1FpX2G5XDqQr/spitnZqkxngzaw8QmfdJ1fdkzIOF9q1FKs242vPU5H
	 Rj7MW+Dd9BMWuxxPTuANRvxzXaBcrhkbdatWbSVcuwM57FhjCm7WEBXlnkxazMKxHSRmF
	 cZWnGmHwAfm6XVjcipcFmsbLxtYmmVz3UB/6jodAJC6pI2P4R+3ilcLGlN1qHAucrfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637374;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=xI1zNLTQT/XawOcx5QCMysFAyN5uGjcgJO2EPJCFV2M=;
	b=xR9F/WNwq4K5HoSMerrX5V+H9ebzC1t+D/ih6Z4oAoODcNJK3iUdhhIY9R+LyDXakWPz
	 EK0g0tPux4OwWwDyCve6/n8oLkhOnPoS7U5ibnwnCCaoal/hpZAfZsmYic41igLX6Afk8
	 PGzEMu6XVsHJ7HtrrHSU7taeVe9PebWEnKOiiN4gMGJsR70+xLPQ6ixo2hv0rWEL2IA66
	 2cmQLLLuroBGK3b8pGg98SnVbNvL8TaZAJhfoGX+/pabtDXpCdSyjVxhnUwLAcZY9lJUR
	 vBI86rezXvZnoNUwyS/8o3C2+p13E/pK2ytmPNEGyeZpR8amEfpAI7UkiEnaEgx4jdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b="ag5a/GJh";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yJQMHcWs;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1E606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD1E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=ag5a/GJh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yJQMHcWs
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 3AA3CEC0AC5
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:09:33 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 25 Nov 2026 15:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795637371;
	 x=1795723771; bh=xI1zNLTQT/XawOcx5QCMysFAyN5uGjcgJO2EPJCFV2M=; b=
	ag5a/GJhcOLS9LDLqQ7BMAQAJ6bk1eMBbX6zKEez5y+CaQrf3eBm2FwXrifZSMKZ
	B2QOjn2QL7poq2s0LttlDfuy0GZaBnzDqqnqSFF3BcKswmqk3CKqN3c05DQkeMva
	HjLIk6sGXkeD7KsuEWyUMHSMz27YGFg4KcxWuqS7DpYPBC/uxw0Vhh1ENPzk6Jc/
	na3ziPJypwlJdDFasUl5agaYXJ0MJVusaJkGCUt5+ThDCS1QBpJ/5U3Bf5/tMo1y
	/e4NujYZpEIZd6MfpA0GPQNShe8jXhHPHbjQsJrG8TZHdEWPaHd8EpxSx0ptFXqt
	2pmHwzA0LPB3HBb8DsjwhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795637371; x=
	1795723771; bh=xI1zNLTQT/XawOcx5QCMysFAyN5uGjcgJO2EPJCFV2M=; b=y
	JQMHcWscU69pinOgYLPx81veon8FoAigQHP7YsdihvXTzAzvg6gEDhF2rj2eIDZ2
	d8K3lnnUxATCEe+afh8r88wBDhuscQq96L2EZAhw7lM18H7oVXwfsltA1ri7Gfrp
	DJZHZEbXoprSxdbVdBMl02DbB8NjQakoM7A2P1xJ5hsmAW6ABgF/pdhspKYvTCtv
	pYnhcviudnv5BEhzbYGhQRb7FgpCvFL1GQnqBl8UwBVYwDMz/yXOnV1D3YgY8CXs
	hT17HM9JsZWve0+A6wRv6F32AwOHA5yQhqUynpOiFN+qY0IWAoMjNn6Bac0JyEYo
	/WP3zfBvWkqbqDKVOVD3w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795637371; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:T/qiot5Ko7nGjEvSy9Flbibl0WF8ATO/rLEuwfnPknmF7PE
	IKB0SrPFBG3zhekhezOfElbaHzVh7nCpp4RxDBa9+0pLrIq09/vVoCf44MuWWLDC
	RZcKFkNTpDaigOEvtu0Sod2Dk70KIj4aJvWg+mx+wIrI+a6TXz2tqNg5UEFspTtg
	YHOvi9xgPDOGN6ZY1a3HEk5NesQsKxAZ78+o+QqGYRzA2URveuVKosSWTrkbULtV
	wQVTZWAMH621I9l3v9lGGHXotENe7HTVGaFTPmtePkihJDRX9Mc8Og88r/w4PYRs
	LuJRmski2vNj0KbGTwe5LJl+A/Rkygup6Hx7xKA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EET6inw+VoLvQnnaeAR4sVutGVKVnSy0BQjh3F0OYSk=:TZHO6MuY5tTxtm4kulmjNSKW75CxH8b8K19PcE+DqEY=;
X-ME-Sender: <xms:d0AHayao_PiToN8xvCMcltHP7O4ApkmmppLyHypI2dUGeHmxn-G0fkU>
    <xme:d0AHawOQPNVvhylksCGqDEX2ZWz71Giglk1qxpanvdTVwcjkXz4g4ASYLQHonB_3V
    -y3jf6LaCBGIijBQBMWyQCwtKyTdlahobke7m_FAK40hx7N51rGNIk>
X-ME-Proxy-Cause: dmFkZTFf+VPMu+w55COezYy+TgZyOJx52UWeC7kW1mZQSN5jAeDF2T3hCmPZgtt6WyMMf9
    VPRuN/c7fNAUwBM6pM1wujsLE9a/hmzHMQ+yvhmIi8nwhXi/2eaIp2xmChefnwnuJJ5m7E
    iElATK+aumzepJGtbklA6W0uM59BC3I0XNpHAet9s8ErjOrgX/jBg8NfYR6iYLOe25U3OO
    W8dvr5TdQrxBEe1EW+k86xHYT0HiCDDYUvR1cbnArSCdhcf6vY8mhBpJ6pJijIbjLp9KQu
    7+BounBrjT/oeYenL1KdwwThea4hgZnfktErvKGwN0DvW9Re23JAbYIQOi1sqCTYJ5tYCS
    Jg8tSfDlvAb0R8Fbip9hKTkDzrTcwmEmJpQrjHaqZT85pzblm33VskqXOhFbXHG98uy9dH
    UUXX/u84NMUDScrJIe/Vm6SUCkbHCjUCgOieDHwo2c1yaEdbbvqoNlR0HidpcaOgs3x4YK
    AxgS8MEuUdzgWvjzaAYoGbAgdY27zjYRcPl3Gl1r2Wz0q45NpZfznG1rIOQBdFnCtgcVVh
    DoYtMnXQuUNRpy/O9uiC/6f9djOZijusO6DcZS4uzUr67TZr5dHqcx3PVfe0d2ExO+VU7/
    JKnVG7efURWrHRIHo46MmAFcKhIim6jHPb0pzQOgqdmoMv5SbJo861sNjEEA
X-ME-Proxy: <xmx:eUAHa3_rPWxx05Bzvgm-62HuhQEyy73DT8Wi1Le4qt7XbozT85irEQ>
    <xmx:eUAHaz3glv0zj-EgvKPa1p3Cn3hy_4AcEXCFrTYef9H2TuWyJouBQg>
    <xmx:eUAHa89Rw5JKyCnKxjZ_GBKdXCsii4qJ0N78fNi1dYSmC6ZhKlsEHw>
    <xmx:eUAHa7uPrEgMGBtvVNk86NTA1NqITuvGNcnbwo7rqyUlYiwqS1BcNw>
    <xmx:e0AHayGqZXENA83o8xDJAG77KjZuvCO1S1wauiwGp8vQTOZXQ9WKDdR3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E47C522C009C; Wed, 25 Nov 2026 15:09:27 -0500 (EST)
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
X-ThreadId: AkCwORjixZW3
Date: Wed, 25 Nov 2026 21:09:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>
Message-Id: <b9ab8baf-0b87-498b-a37c-64af0d06b9be@app.fastmail.com>
In-Reply-To: <608b25cc-6ec8-4f0a-8eeb-863ed44bd0db@gmail.com>
References: 
 <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
 <b8c40805-90f2-414c-ae70-e2f79a19170e@app.fastmail.com>
 <608b25cc-6ec8-4f0a-8eeb-863ed44bd0db@gmail.com>
Subject: Re: [PATCH] var: add GIT_COMMENT_STRING
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026, at 17:19, Phillip Wood wrote:
> On 24/11/2026 15:02, Kristoffer Haugsbakk wrote:
>> On Tue, Nov 24, 2026, at 11:37, Phillip Wood wrote:
>[snip]
>
>>> diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
>>> index 5f240eb56e3..04aeccd7aa6 100644
>>> --- a/Documentation/git-var.adoc
>>> +++ b/Documentation/git-var.adoc
>>> @@ -130,6 +130,10 @@ endif::git-default-pager[]
>>>       The path to the global (per-user) configuration files, if any.
>>>       This variable can have multiple values.
>>>
>>> +`GIT_COMMENT_STRING`::
>>> +    The comment string used in template commit messages and rebase =
todo
>>> +    lists etc.
>>
>> This could also mention the config variables and git-config(1)?
>
> I had decided not do to that as the point of GIT_COMMENT_STRING is to =
be
> able to query the comment string without the user having to worry about
> the intricacies of the config setting or what the default value is.

I don=E2=80=99t agree about it being an intricacy. The concrete name lin=
ks them
with no doubt even if they would have diverging description for example:

=E2=80=A2 String that marks lines to be discarded on save
=E2=80=A2 Marks the beginning of a comment. A comment is not part of the=
 saved
  commit.

Granted that is completely invented...

> I guess saying "see `core.commentString` and `core.commentChar`in
> git-config(1)" doesn't really do any harm but I don't think users are
> going to get much additional useful information by reading the config
> documentation.

Yeah that is correct. The link isn=E2=80=99t worth the space.

> Perhaps saying "as set by `core.commentString`" would be
> more better as it does not promise the reader that the config
> documentation contains additional, useful, information?

Yeah, this sounds like the sweet spot.

>
> The documentation for GIT_PAGER, GIT_EDITOR and GIT_SEQUENCE_EDITOR
> mention the relevant config settings when describing how we determine
> which program to use, but the documentation for things like
> GIT_DEFAULT_BRANCH does do not.

After reading just a little, I much prefer the verbosity of `GIT_EDITOR`
compared to the terseness of `GIT_DEFAULT_BRANCH`.

>
> I have added a note to the documentation for `core.commentString` that
> the comment string can be queried with `git var GIT_COMMENT_STRING`

Sounds good.
