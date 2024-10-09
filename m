Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECC18A6B9
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505267; cv=none; b=a3bq5ZjDkePhHaev1HFkWMo/aE8ocBR2iXgHqS0RhtXpNBK5qjCh87vLaLqmktwyHP5PjWuWUFpBklvPZYN6WFMyn3u4NgLvnyeCXObXc/upbuPJvjwjS7WhkuqjhI1Xo27u63Z787KiBIUUXj0NkFcsSQn2wEWh5R2iAmsZR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505267; c=relaxed/simple;
	bh=i05yK5JTjM51IGCZ+OxYuBVdA9s8uNc0HxXcnMYilcc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qvFL3Mny/35vSoF9H2eKxky8WScdOTOwTW1MA4vL3kwkRlyXNS7G8aNOVVmrS1FK1CTDXbkdVsLRTsv/nFTFnfL0r6vV5YjYZzKBUonqs+EsdDSJQhA2L4loBMPEU/dkEsCSiIETc08AOjuM69Nk7NdpZfQmucAzCKzpUAFSlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=e4YLZqhs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwnBWLhE; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="e4YLZqhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwnBWLhE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A4C01140061;
	Wed,  9 Oct 2024 16:21:04 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 09 Oct 2024 16:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728505264;
	 x=1728591664; bh=++13A3uUfDNhhDRYim7/MSapAQIsRyIqb+443Z4mvQs=; b=
	e4YLZqhsExK5YxCHhOzBQEMHsMfmNewIgLyXJTlprHFHa5b/C6vKG1zBZwxvsPps
	nhjhecRwV8p5+nLOiV0aGscJHfBTYx8MwHfaGJSpcDUpKQ88nZOr+lCqDRpXRa8o
	xtrO1eVPF3z2t195UHdXKUDEyZzRNBYBKxSfC8Q5vbPf0GEDyzpYwCJHKhTghC72
	IQTTcLTcN1b66jUlpjY67Sv8pUyNjYAbNW3+3me+D22AucyJ6Bcs9biS8SnMMZ/M
	vzGbtU2bsqw0bt6duEYfRqQn7q8gU0e5blHNzZLGzER9YrVyLJm0AcUQVzXnOnch
	AZIDEFU01cjV8+umJBVLjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728505264; x=
	1728591664; bh=++13A3uUfDNhhDRYim7/MSapAQIsRyIqb+443Z4mvQs=; b=D
	wnBWLhEDV6fEa0eA3sZqlaIsk8xaXkpG9PcBmQpLP6qs5YJX83Pjl6OCzvmEYbaU
	n0nqNw1GZ52gZYIwv2a3tmGTLgvgjLXXOI3HecXF8STlNbEwO3EX8+fajrZSfqTJ
	0LMUOl97wlbtc736+EwyN/Yo7KkLRAisL2WTDbAXJFwOhfXJ2dA42799VO9K4AsO
	aKegUEQX0wghYruMFIFxMEn1XMPWmxAtvCVTiZ6wwRdiVtCbsGXfPAW8TKqzGoG+
	LkVPb/Ew03nF3UFn3OQ4hxaByejuGGZJGh3qrQebN8VaDtJ694OhIUAh0BKvoRx+
	wmfREEAn/jdBDr0r7K6vw==
X-ME-Sender: <xms:r-UGZ6uZIhBQ2OtWZGZm076vauxDYIh_0hosC2noCEYxVA1LHzmVhB8>
    <xme:r-UGZ_crZTB4FvO12OBPd-p6sPxcHyF0G7UwdO4WHdayqKaJodiFYR1PqCo6jc_Kd
    CKHWC-W6ZidkYLtIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfevieeltd
    ekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhithhh
    rghshhhokheksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sOUGZ1z6pzFSK6hIH7ZjGQwfo2GqXWbknEqDOfcLDBhXyjgep07O2g>
    <xmx:sOUGZ1OtJ-krNhrd-1cLGoxGswWZ7nsEmwHpSNVv5TMw3A3yTeJbrQ>
    <xmx:sOUGZ68iZeoL4WoT56uzD0pi9U0bWdZSoTuayW8_N18hLVC7gOE5nw>
    <xmx:sOUGZ9Wac-bZrffV1dmGHtW4N6h4JaCfDEM6XbEBcskf-yFXJUhPgw>
    <xmx:sOUGZwnwGWj94XZa6jEfIme-8YavRg6B4yKnhuGN9Ryrg_TMQzga5yeX>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E4AED780068; Wed,  9 Oct 2024 16:21:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 09 Oct 2024 22:20:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Amith Ashok" <amithashok8@gmail.com>, git@vger.kernel.org
Message-Id: <6b1f434a-fb56-4699-a03a-069a1da118ab@app.fastmail.com>
In-Reply-To: 
 <CAHoc8a8b2o7eJULhoF+5VM15ickjRY_f=WBmpPsG=0kwrx1CfQ@mail.gmail.com>
References: 
 <CAHoc8a8JQd=c0bD5Yneg8R7tEjETyns-yyWjP=V3TTn9R48Nzg@mail.gmail.com>
 <CAHoc8a8b2o7eJULhoF+5VM15ickjRY_f=WBmpPsG=0kwrx1CfQ@mail.gmail.com>
Subject: Re: Fwd: Git bug
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024, at 20:04, Amith Ashok wrote:
> Hi ,
>
> I wanted to report a git bug that I encountered today .
>
> I created a feature branch from a release branch before my peer
> committed to it . My peer committed to this branch through the lower
> branches of auto merge option to this high branch .
>
> However when I do a git  pull I was facing the issue in of the files.

What issue?

Usually a git(1) bug can be reproduced with a set of commands
(reproduction).  And some part of the output demonstrates that there is
a bug.  Which could be:

- The output itself tells you it=E2=80=99s a `BUG` (code path that shoul=
d be
  unreachable)
- The output or behavior is unreasonable or unexpected given the context

Then you provide it here in the bug report.  Like:

```
BUG: this should never happen but it did (<file>:<line>)
```

There=E2=80=99s also git-bugreport(1) which you can use to fill out such=
 a
report.  That will record things like your Git version and other
relevant system info.

> I tried multiple ways to debug this but ultimately found that the
> issue is with got itself .
>
> I took the a fresh branch from this branch (post merge of my friend )
> then the error does not occur.
>
>
> I appreciate if you look into this . And if this indeed is an issue
> could you fix it and you acknowledge my original receipt as the
> findings to this .

It is standard to credit bug reporters in this project.

>
>
> Thanks
> Amith Ashok Chugani

--=20
Kristoffer Haugsbakk

