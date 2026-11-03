Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702776;
	b=sLoIeSsqCe/Kjp6dtSnTGrMCQZEyOHwbpGpU0wsryqIqyDdcEYKyhcb+JSdGRnyfDbZo
	 zwWLa88DNZnPC9e8xd8ZWV6PeMMMRYh+bd1yi58t/eYZ1U6xISSWJZ1tcC/TL32ln6T5b
	 eVN4MkvdevLiI4rG0fX8WON3M4/B+6u/ru/nOBonsmQKsvtJR9qbuDAUtZGBW+d+73wM8
	 qHFG9IJpOUBVsxuxV1SQkJ0WgQyRohSxHcgI8Ys95ezB+3AE/9NKGrF/cL1t91ftIbbef
	 l+0Tfng8/xlkgphZvpxnpMNGapNUd4knL75H1HMVK3aSvQO0HpP7JGtCCgcZ5UCQExQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702776;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=8mNJFbG/hVBfTHkXNKTQS2Fxh32zxoLEJwd6WAAk7dI=;
	b=yRtrbTXcXM4UHrCnUHjUzsS0RUaN7RW7rJNUKbMUIpkKvnvgUk/0fhsjZMcaJHkNw9wh
	 vcmpfsM9spx2riQYbyLYGslL6xKLPCyK4SQ5mA3vsqovP4Dihif8qeAhZXcm0IyrNc+NY
	 +sKqZH+mhrOy29ugjxgA9YbPcOIvlO1jJEvW/RRc/N8wGMAhetJRCw/aSDUUloG/GzeL+
	 hd59LeflF97oRHwKKa1IxevywXBIUfR4NZqbesPbhScuOAsfnmUZpGrnqvVohK8KDfaAq
	 5cMovPAuEG1ff0XmvkgDoImuJAOnZVTTLqltWEm+hwTV9YYKNdmCEXKTamXVXGJ30Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=hSnfZO+3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=X2cPYPMn;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5CB606C5AE
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5CB606C5AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=hSnfZO+3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=X2cPYPMn
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1ED3014000F1
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 05:46:15 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 03 Nov 2026 05:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793702773;
	 x=1793789173; bh=8mNJFbG/hVBfTHkXNKTQS2Fxh32zxoLEJwd6WAAk7dI=; b=
	hSnfZO+3MsCHTpswIRhZtWWKgbk8HRadSgv3f0iDER20IMdBhaAkc5BBzG+K1cKT
	2+QPa81GW1Mb7hweiBJlLivbg36Klzw6TslcjXY5I6EHf7UGkRBVFN5fYUu3DvjW
	mbui3f5Wj5LPjnbFB53AmESDMkWqkVwOTcsflqIhP0oaMTWWXK5Kl55AJkwxLvT9
	hDC3YAwNHj3IlZjONKHFoxXUGr9W2QqiEjCEEM83tyF5MMLK5vR13xEGCOVO1Ybf
	8FGMY3ocLKI0/tpQ+pKGqlDGkDMzaDXa7eYelnc/uYaN/bdbjd+NtPCdHE/xg5uD
	tgWg5U5/raO8CjOyHuAczQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793702773; x=
	1793789173; bh=8mNJFbG/hVBfTHkXNKTQS2Fxh32zxoLEJwd6WAAk7dI=; b=X
	2cPYPMnFZAnkhZQrTr6F9COo3ErcqZFPiYHHh+35G5mtE5KbGLihprJgjFS3FhvF
	YmhJAeVXyzVjgS8cTuIAnfZlpqtWju/EJBB1f8brmXSUEtly+8q2/4KFetJbcr8y
	Ahq7uYiK0SQM8DtDDZC0hRnGwTHI4o6hvECGtTyKLiuRr6x3UI9tE8kRNuylKwCg
	J8hfU/Un2bjMHl9xR82/YSpFaUKXohAPo2VMEP+1N4V1pcTXAG7wwaFUIgMLzXkj
	BJBwP6mu5fV8Tc1yBqTj5KGHJoQA+fieme01RoZ+DTLMU4wVy9AbYMoOQ/T3H9QR
	6H88fnDMiqP9smy965/tA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793702773; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:VQczwyLpBULcCgJpVLpDbAPrZIYx179pjA7XnQy+ww4pYAz
	RYVqEmeFtcIAA1BOEECTO14aZH1nWOrnJihzSSq6/XKH5/9A00P/oFh40XcG4UYN
	h/sQpGKh5KjsUedBzxM0aHHxiP1gsVltVvsuTsos/STWbK9UDZeHRhbR2gjhUVRe
	ug+BxAsD3i8QEHQHfntPXHBivWaLz8EYG7Jqo8o+49OUWPOGCuaFG+kI1FIgn2vg
	81y9Pk5lwSx9bp1n/rCPahUaZP6h9rUzQKp5G6/yy0svbiehH4CPjLh7bmXM/Ms8
	C1cbUtaN8+daaVVOVDBYXNn6WdZYJx1ohQoGpvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5O9uvOnY5E4PIoVPfGrLYvHfkk2kvKCyWsqhOW+ySWA=:Ok0TnssYqOxYMuinqAolEV/i9d6PiJjw4vJtkgW1dDA=;
X-ME-Sender: <xms:c7vpaiZGTAZQ1OTtAdZIKAqe2VSfRho1UojmHez9pLYPeYB2woHifYE>
    <xme:c7vpagPWFrAoJH2cXyficeaOtFK8uStpq1DSAB8BqItzV8SigWVYqsErI5v3HURVL
    gy-1RJf2MQ04ad0Sxu3LaH9nsE9RJMux8ccaTcCrT7EDruF6Pc7vPM>
X-ME-Proxy-Cause: dmFkZTEUs+wKssLfmbMDkWtCLzGsGY+voSIR0zD0UpCUg/gmc4mkKwawtU/dve2ZpOZa2i
    d1+BLODPF/YA74VRS6vHfV2eSIcs4VmuGXNtlg9ulkMWKbzEvikAl8tQHoqGMQ24CspMrp
    Ji1WdL5y67qeJ0r3YslNsuwRH7Zi19yXqw5yOeFXJ793dzMGSmm/mK4C4os3ofKjL9WASy
    0PyoEu13D4E1G1yGCoVVSblizN2UD3GVhOKbSZVvFq+kEZgxHJr1c1iEUXWzZioTDUlgR/
    Qw9Qlx6tB6TuY5paL58qpk7s3xM4tG3s2VpwzUTP5nLzWr6u3UhejMDh01Uw6m8wjzXlGK
    7pgYXuI34v/K3FqHv34/CqxMLv07lahzf8qRq7nWgiUDBQKoiUt7zXH8Z7+lkexq2zUlL0
    SzkxCgYEuNTKuJZ/jv9FyHmaLrPNfC3/o2ahCEt+MAQsmNdZv6ImIStH6rAu1Jfczb3qwy
    fW/9LNUzS/Uw/ND0GWWTBBioDmZjfoc1xc0LIy8s/fPSoDCxPsqg/d5VTtZfRWNbKxH5wR
    x8Wmf/l/0lp9j3v3064QstaU70DNph1NXg7FAkeNdP30MJRL+hHJvyVX/Kc7LnP3FDEWIL
    riTpSF9BZ506OmlzOLYTeI448MCgH5Dx+R9usYC3SH1/iA712GuoHZD38osg
X-ME-Proxy: <xmx:dLvpas2b8FlwSFdhC6F4YtlZHhCD0XMUsmlq_zbmEKCWjZsX-ikJPA>
    <xmx:dLvpau0HM8cXGc8FXK4rFxoKTVf-Hq21h8GbLEMQ2x9hEwfGvVtDVw>
    <xmx:dLvpan_Jtujj3l7QhGmeLz5WSYvMvsQwYVRBwosXukw1HZyKoC8M0A>
    <xmx:dLvpaj1mgTw3w5kuMw0qut8JDT0KPmm9UCRzoXN5AepdjcQxvwVXVg>
    <xmx:dbvpasSSrY9Y8VsJgUUBqybkR56y_sZ7zWITTamZfGiMQsUl5vdjmW3h>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4134C22C009C; Tue,  3 Nov 2026 05:46:11 -0500 (EST)
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
X-ThreadId: AA0Zomq0_rWw
Date: Tue, 03 Nov 2026 11:45:51 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <528139f6-db92-4061-be0a-88d4c376d252@app.fastmail.com>
In-Reply-To: <2A1E1423-8C1B-48FA-B1BD-DBD422748623@gmail.com>
References: <78d4b7c0-3a3c-4d4f-a9f7-4a6f7618ad88@app.fastmail.com>
 <2A1E1423-8C1B-48FA-B1BD-DBD422748623@gmail.com>
Subject: Re: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026, at 17:49, Ben Knoble wrote:
>> Le 2 nov. 2026 =C3=A0 05:51, Kristoffer Haugsbakk <kristofferhaugsbak=
k@fastmail.com> a =C3=A9crit :
>>
>> =EF=BB=BFOn Mon, Nov 2, 2026, at 09:51, Junio C Hamano wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>[snip]
>>>
>>> Second call.  Anybody?
>>>
>>> Unless we see some volunteers to give it a review in a few weeks, I
>>> will discard the topic out of my tree, as 'seen' has been crowded
>>> with topics that have been collecting dust without getting many
>>> reviews.
>
> Sorry for not getting to it :/
>
>> For you all=E2=80=99s information, what was originally totally unrela=
ted
>> research has made me doubt whether this command is needed.[1]
>> git-diff-tree(1) cannot do what this command does right out of the bo=
x,
>> but it looks like some modifications can make it a replacement for `g=
it
>> format-rev --stdin-mode=3Drevs`.[2]
>
> I saw these come through, and I=E2=80=99m not sure where you landed.

That git-diff-tree(1) just needs to learn to optionally NUL-terminate
diff and log output.[1]

I looked into it after that and the code has turned out to be too
difficult for me to make sense of.

[1] <238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fastmail.com>;
    https://lore.kernel.org/git/238e5652-e95b-4d44-a900-e16aa6ab81f0@app=
.fastmail.com/

> I was mostly interested in the stdin filter mode that turns hashes
> into references; is that supported by your alternative?

No it=E2=80=99s not. `git format-rev --stdin-mode=3Dtext` still has its =
niche.

>> [1]: <ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fastmail.com>;
>>    https://lore.kernel.org/git/ce69d94e-7329-449d-b3c3-47d4f3aa608c@a=
pp.fastmail.com/
>> [2]: <238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fastmail.com>;
>>    https://lore.kernel.org/git/238e5652-e95b-4d44-a900-e16aa6ab81f0@a=
pp.fastmail.com/
