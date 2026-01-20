Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6A3AE709
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896238; cv=none; b=Gb6tlyez4jQtoJc2q+4bANKG1ncCxdNj6rOBrOvKEqYOnp7KM9c1B5nyZb1wIvaMlWwiiRFq18FmBCWO/Yt7NLblw4MIOQZiAplOMSSnSfqKBnTvjYEyWh0P9Fb7xbcwXxxT8FWyLUAfsS1IFJu8nbDMdp8rrcq0vWjRooHj+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896238; c=relaxed/simple;
	bh=/MoetB+nkfG6uOnt1TO0GYrkw9xU+2QLd+uDn7HZfCM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VYaQ9uF57QEQtkdkHo7bD6u8ktQP2j1Wa9x67C8eoyQdRMgW7Eu/AEUiXo+VcMBee7Acz+iqZEUoIrxemiqsIkfV66eTa0+dfD7tvN6Mdu7tV+OappyNdYBq/zWT4VZbb+Zc+SMFhIjafGBqzjBjmVcXP3ZjdE076b0ZCy4f42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pFIL7tXl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LD9dXosG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pFIL7tXl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LD9dXosG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 890EE7A0009;
	Tue, 20 Jan 2026 03:03:54 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 03:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768896234;
	 x=1768982634; bh=98CR7NbQEx6qT++/aVqZB/9n+baR1XlnnxtQdEBq0EI=; b=
	pFIL7tXlxb1tMiMMSHj8QWL7tIHchbW3ogPZiPDk93LoC7F5G5Fjsoiv6MTBgt0x
	j6ZpCFEpp3V7jCHwQuxuCoL1PAlj+EbXmV9DcNRskhor2iZQNxBWhtNfEFhbsMYr
	DhD2mgPbKpxEmApCkKcX+OnNnFxXZJ/M0fnNbE7HUs3AerGas2+IAnpD6cFh4WjA
	4udf50Nw7XooG0eLdSC3/E/qt8ldECJZ++gcxOu6Xkj5W7Z3rLYY9Lp9RnxMnAFt
	NohTghgHg0Pzq+y6qHnFAxjX23n1RDv33GXc1KTsF/PPKh5hOQEVXt6WEFgCt2+q
	2K2dqdD0tKHS+T6amKwR3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768896234; x=1768982634; bh=9
	8CR7NbQEx6qT++/aVqZB/9n+baR1XlnnxtQdEBq0EI=; b=LD9dXosG/Y4Mt5xIS
	BzNKAcCAs92JO6n3/Fdh8bzf07NWGFy3nyQXoOtaPsa6p7jaBUFU1SzEb+U8QAOh
	QdXgFDa7BeklOKGfypykXk6l1UP81+zAu6sWFxEduzHq0TH9hnh9Qv319MjzL9Gh
	Op8jRdpS0JZj+4OQDjCtm8QDne08ZUTnV9pTP7vl78/OKSjOFjbyDrZ+OtNXFhnM
	c8iX7a1dLTm1Qt3AHOW1V66OlBifbZDeyG1zh8II/v+nYU/i6aVlZmLanQ1krN3v
	ZNPOpSVrsX2EzQ6ksLol2eLxy2Wf/l83Xq83gq3iV/J/L/01yZWnq9guQMT1APCa
	Gy+pQ==
X-ME-Sender: <xms:6jZvaSjDDNeeCxhcl81WBT45V8e2sKtmP1-1TL8klH7yA6VDyL6ZNt4>
    <xme:6jZvad3bM3w2zdvvqs1uXnQBD1xbpKTBEZ3VoQSrRpCeZJ7aohTYkxe38GSZ21tz9
    OBuwprj79ySRynbTtSokRVZRPu6XzhcED1Yc-TvR2OIotsGgXk50uc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthhshihmsggrlhesrghtlhgrshhsihgrnhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6jZvaVNELh1OquvikgYh6-gQYIV8QP_-OkROzYHQMukm_ToTVqqLCw>
    <xmx:6jZvaV7ycxxREYM7uZX4UIE_7PsctcgyeYxDxtpf9BTek6WuTirVmw>
    <xmx:6jZvab0jjSXZWBOlTbnC6Ylqkttz-dpcytIIUWbLFTZif5GaZO6z3g>
    <xmx:6jZvaebwB0HYTBFR6NuNr6feo-6T0dzdpZsa-_LG7KUfWKo0y50O1w>
    <xmx:6jZvaSO6kIVwZeANdY9wFOavNlAXnAnjxJhAMPupLl-lTrzJ8G4qmwlV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 35E991EA006B; Tue, 20 Jan 2026 03:03:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADgqMwkW5fw3
Date: Tue, 20 Jan 2026 09:03:33 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Stepan Tsymbal" <stsymbal@atlassian.com>, git@vger.kernel.org
Message-Id: <913c7904-1f31-4d76-bb4e-178ab94f0e71@app.fastmail.com>
In-Reply-To: 
 <CAM8dTE=RciNHyyyhtprjXL22deTrzj5DKcBsSiAt0jFz6Az8JQ@mail.gmail.com>
References: 
 <CAM8dTE=RciNHyyyhtprjXL22deTrzj5DKcBsSiAt0jFz6Az8JQ@mail.gmail.com>
Subject: Re: How to get failed refs with new 'git fetch' behavior?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026, at 07:19, Stepan Tsymbal wrote:
> Appreciate your time and effort on developing and supporting the tool!
> I hope you can help me understand how to work with new behavior
> introduced in 2.51.
>
> We parse output of =E2=80=98git fetch=E2=80=99 command in Bitbucket - =
in automation
> that synchronizes mirrors. And from the output we see what references
> were successfully updated and what failed.
>
> In 0e358de (fetch: use batched reference updates) =E2=80=98git fetch=E2=
=80=99 started
> to use batched reference updates. Which is a great improvement by
> itself, and required the change in 'git fetch' output.
>
>[snip]
>
> Reproducible example:
>     mkdir first && cd first
>     git init -b main
>     git commit --allow-empty -m "initial commit"
>     git clone ../first ../second
>     git switch -c branch_path
>     git commit --allow-empty -m "another commit"
>     cd ../second
>     git update-ref refs/remotes/origin/branch_path/conflict HEAD
>     git fetch

I think this is fixed by the topic
kn/ref-batch-output-error-reporting-fix:

https://lore.kernel.org/git/20260114-633-regression-lost-diagnostic-mess=
age-when-pushing-non-commit-objects-to-refs-heads-v1-6-f5f8b173c501@gmai=
l.com/

The output when I use Git v2.52.0 on that script:

    ...
    Unpacking objects: 100% (1/1), 170 bytes | 170.00 KiB/s, done.
    From <path>
     * [new branch]      branch_path -> origin/branch_path
    error: some local refs could not be updated; try running
     'git remote prune origin' to remove any old, conflicting branches

This topic is merged to branch =E2=80=98seen=E2=80=99 right now (678fb95=
5 (Merge branch
'dw/config-global-list' into seen, 2026-01-17)). This is the output ther=
e:

    ...
    Unpacking objects: 100% (1/1), 171 bytes | 171.00 KiB/s, done.
    error: some local refs could not be updated; try running
     'git remote prune origin' to remove any old, conflicting branches
    From <path>
     ! [new branch]      branch_path -> origin/branch_path  (unable to u=
pdate local ref)
