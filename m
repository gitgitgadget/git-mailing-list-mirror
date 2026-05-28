Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D4433F5B1
	for <git@vger.kernel.org>; Thu, 28 May 2026 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950977; cv=none; b=frFzHc+EjmGwGzAPToYUxe5CgbONnpfxfbRYyDjU+3lUpPQjs4UG7SHp+KD+PJw4GVFYpEmc/EjZwSHaqjEATJ2AXx8lFqxv5L5updfTu8wF7iD7yHx+/c9Dy7FTQhur/zMlgui9hZIsYIIODGXUBVvFsggn//G71tOYRmD5M7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950977; c=relaxed/simple;
	bh=ZvVienpvYZgdUgJhxpTsksMvzqkYMNyHFt77yk2SncI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gvgZdEcZD3VNQuay/gAIg8YjQK8E3UfQBP6yLwhoNxXfkR8o92Wb05yj0HWxdZ+cdtQOxS7Sz3+FpMdMWgtenWeOhzG+BErnpTlxaXjJtQ9Me8jzjRXwj6SqzRHLyrzpdjIHwBd/b6WvJJXEVSdlHpTv1xA7dzp74+xggTDjmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q00DyM7M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rdSEsYNg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q00DyM7M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rdSEsYNg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E61B57A00CD;
	Thu, 28 May 2026 02:49:33 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 28 May 2026 02:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779950973;
	 x=1780037373; bh=QfyJiypnDaNbH1Yx2CSeIgpnNgEpavC1Z8co6fpUd2Y=; b=
	Q00DyM7MC3Pza1AHB5bSV2bbjCCWc36nlq8MKwocDXcUToM7kXjdNWpLJxNl+n+X
	UXnR0jGsFshXW16emBl6ChP5KeJHR1kq7yReNwGvyOwDOC6xVgBSB8BkyQpvyLBy
	hZRVA/3kn3ovJ8OobPIepPK+okmv7HUJa4jUOu6hL8Y/WEnFfjZA4mXbZsFfBTYg
	if+Bioa7A/aANYxaoW8XxZviZZQlSy5fh5BFKUsY/4fhJ3XDL3ZBWiqsEssUvZUA
	rxJGiFX1kNtQr/Wr2Pss0eAUb+d59ZpiLZA/+WbN3PKjpoMdpl/iqyUMtMxELwVp
	qgqZZ86/oviItYJp/kna4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779950973; x=
	1780037373; bh=QfyJiypnDaNbH1Yx2CSeIgpnNgEpavC1Z8co6fpUd2Y=; b=r
	dSEsYNg1xfSKTsq8Tdu/tK3Ex3ODmG4MEo+n2gNHQe9X/bo/npliLuGauwNszero
	DSDzOPPxLGfeRKILGszktJFzJFJK3L6Awl72u3cnfQSwqGmsqMq64ioya8oVpFab
	r0GRoVVA2RGwsCV145Pr2IU+gG3fY5VbbiHusPn8qmgBRs+B3P4nlhtGflhQv+zL
	DBYLoSbK38sYMXaupRT1YbkeVV4ussZuEGMlwYnuHwpvN8ca+v6GqXT7Ci1lPzPZ
	kcpdtc11mVhZfaw3v0Th0/DGYdO2qBbhBgMRKhHjMKVEL8sLqNhKVcoXwpkDSk46
	7plGbHaOm+iSmEtvytlaw==
X-ME-Sender: <xms:feUXarwnl8V-PNX3RkU0tIjOBDxtC8qN0XBqywwxNRt6ddRrNib4kWU>
    <xme:feUXauGm7XNDSYGbsz9vBwz9uvE7CNR1x_1dWksuxgwM4Tr9INPxVUgkw6lxRRdCR
    XgXzNjhhP0RRSZ_JMxKHQwfxNEU6MNOR0HwhA9yZ-BeKQZT-pCR_A>
X-ME-Proxy-Cause: dmFkZTGowEytxKZgFgYKs6rqlkCoJwwHYxpIBSIJeUcoyHwzaDO55qkZPIJqNQCdRvXGlL
    jPhqkKaXFg6PE7v4ph8z+CG55EEh0UndHqpS0ifW6o33w6dDU772OCQYnzoENtIxseU7oJ
    /kZd5jjvHvlEU/fp6Dnyh/z9GebfUeBpEaCkE8TGAriM63xcZRT23mY3qt/PIgXiTH6kqf
    gmYLRXy7hEo3KXiSpbwZUye7nEbH+csjQwD2C8unvRouza3GX53IkmYMz3EDm3WcEer0jU
    +cV7rpovJ2RSa2zX1ywWvHkddxOgO758AC479N5e6rxQ/FE7MksZIf1lWoMzAUjsRAm5hO
    5JpJVgm7ctIiXMJIdVzSnwUeLOPGRADmtiA8zr3FYq8sJg1km8lK6PKTiO4NCE8WajtwNX
    7tHxy+EOe2qnpjvxbecR7nV+pvoZw8078vZzLvtHL3fRzlkNxkaz93zMnpVreEwu6Ewf/F
    //cdIxEmagn1qnlea2P/GqxbMPU2x5sihXZNqKNt9a09CP8lEBKQ1dUu5UNXwLxllyJkvm
    j/74mn0bnSLm3R0u1onDL4b1clwL6FU+/kDfDthRdRTt1/m8EQF/7sv0jRzw9tIamYLFSM
    Su0FDjXg5PQ0mbZQry1wjPUSIp/eCYIIFLFiwySXK2AbDcMf1Et2wvttxnFA
X-ME-Proxy: <xmx:feUXajPmh4LueyFqR_1bUHiyM9scGvKAWHmVYsqEWVNFyOOE7jPy2w>
    <xmx:feUXaltZfQas_wfpH1O6Ir-9wdCsfkbVjBRnvj4xK4hilIX4x1lCsA>
    <xmx:feUXalVJ7BWv9x90PzGALVZfaM0-R8-YyoySRemgrPvU2VkOVfI0PQ>
    <xmx:feUXalsYa_o3y94amhIPjNNZv_ewgosUJ0GnM5LSw2PeC14VLSZNlg>
    <xmx:feUXaqEegqffXW6eUHmeyJsfsHe-cZzXNDI2NWq50v0G4ifJlhlSxU1B>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F7143020073; Thu, 28 May 2026 02:49:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASFEtOMnCjPo
Date: Thu, 28 May 2026 08:49:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Message-Id: <ecf0e826-759a-4922-acf7-94abb689856e@app.fastmail.com>
In-Reply-To: <ahfRdFXJf9SRaz5q@pks.im>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
 <commit.h_replace_deprecated.715@msgid.xyz> <ahfRdFXJf9SRaz5q@pks.im>
Subject: Re: [PATCH 1/2] *: replace deprecated free_commit_list
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, at 07:24, Patrick Steinhardt wrote:
> On Wed, May 27, 2026 at 03:59:25PM +0200,
>>[snip]
>> ---
>>  builtin/history.c | 4 ++--
>>  replay.c          | 2 +-
>>  upload-pack.c     | 4 ++--
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> Heh. Funny to see that I introduced the new functions, and that I was
> also the one that continued using the old ones most :)

To be honest with you that=E2=80=99s the first thing I checked. =E2=80=9C=
I wonder if
Patrick...=E2=80=9D x)
