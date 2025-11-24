Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7D2EB873
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763973492; cv=none; b=d8/I76T0KvsIweT53ojAKEBf/YAwMpVW7WDLIWZuMsX2qDOBarUcAGP/QgjUv+Xz2fvMcxrBt/gOv3Rh2bGF5tAn9dfYBrF9Zr7SbZc/iqVOJJggrW7krNZXn8tbXGszZsuAHEoja3L0v+3Y5ZYxBj4DQNgPOB5CP08D6ABgU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763973492; c=relaxed/simple;
	bh=FRG9Qt1h+rySpdBt2mhlrM+Byl5cnYHPg1bZyVSrSz8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RjpZ13is++pWA3zFbZovcok2kcHPqyQuEG+cUrXN3VoFpvMYikQm5pIp5Tht6ThJ8nZF8gsNAB2ZybwQQmMv5u5gmq+pat6P0aqq4wEbha7Ov5KI2RF4KzVKgDFpvYZoP2bjJmJ0Nh5xDBpNSJTk4tb/f/n1cnRMIpWmEG003M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PRxXM5xT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxtGU5mb; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PRxXM5xT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxtGU5mb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 51B821D000B7;
	Mon, 24 Nov 2025 03:38:09 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 24 Nov 2025 03:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763973489;
	 x=1764059889; bh=ptJ+mOe2+mg1kS1uo3sXorwODmp4ZHL4UJ7JpNv+t44=; b=
	PRxXM5xTIcZm+syEel3DrQH6kPLvf2+AaOTNb1FD3ZvKNH2KN1+f7TQKgKMbch/F
	Vcvd11p+402tGzSzeE5hK+yZLzrIxOwGC9Mf+gnRrzrO4Q0mqCL31XaIA7HZHofp
	++Id/ClffcTPqyVQ71hRNF+aIbMzW5bHPCTAXhxyssXLxCzz0jxZDuYBxu7XGRZ7
	flNTecVQ3XWc7sCaUk8Vu2A+HlT61G7zvkXq6/Z6fbYd3YAqJENTyhNK1h/YfVHz
	EPheOnQlx+bDYMZFT+JKZKidoIoKOsT7UHIS6LXN9nzXla+gy94qN0waa9Yvf4q+
	ejCf6mWtUcimKl2lqFGG/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763973489; x=1764059889; bh=p
	tJ+mOe2+mg1kS1uo3sXorwODmp4ZHL4UJ7JpNv+t44=; b=JxtGU5mbVElqUkzdL
	TFvt07FVbYYEeOP7V8Pfx1vovL7tTvpYkkvra30yq3vMd6i9OzHKwvjiD8xOZuRY
	GUWt4nCrRmBT1pq6hEny76QmgW5RAHJD/S+x10hHeX2MXwe7g3K6a4BDllbRLPEI
	dXY5cBwvYtOud4C43U0LEVooHzt4TL2kXPm4CDylidLENBN85QuHSup6N694v6bq
	fL9bgk0alYgeXW+/zcC4IVkbDkwWEt8P/BIU9YvjSN9YAIL3pbUt5K78JuBIzmRs
	13GLxzqNU6ex6TSAWD4JNVq4VXXPYh++YeI6R2xPwu2wK7G4wICTxN6gAMsh2aO8
	Mq93A==
X-ME-Sender: <xms:cBkkaX955GHi1ge2LpJG6dDgURD8Y3S3HRzXZgGCVdMoNv81Z8IxZuA>
    <xme:cBkkaeioEvJd3uomIQOunRC3avD7vnrkRSGSBjVV1hlnuHsOQ50Xri8mVho07KiZ-
    yph1c7ix6JBXPYeiyc4VxJ4BUP4LF9F3yqYBROBrO4aLiQ3ukTCjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeejvdfhjedvgfev
    hfdvjeefleelteffgfeuhfeihfeuuedvfeevteekteeugfehtdenucffohhmrghinhepgh
    hithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrnhhivghlrdhhrghmmhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cBkkaWo-zEwuNnCjzxI0WSMEkHy8A0TXT1NU-9eFi78JhQRnEXpEDg>
    <xmx:cBkkaSkYnNCfoE2QtzqgYxwZDE8Xrsl938fFonN20bjle-c2F65FHA>
    <xmx:cBkkaSydvc1mF3c-f26GUSqRgp00hDiro16f6z80-kfnt-Nn_GvbSg>
    <xmx:cBkkaSlfGZ-_VQl2I4FjdjKlnHz6cBFYcmjKxJwmBRQ3oZeRKwAKug>
    <xmx:cRkkaavuA2cR9DQfXz8S7id3-U98gi61ZoaUfm4ZbJRT8YlVpDGG-6Oa>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF4691EA0068; Mon, 24 Nov 2025 03:38:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyBCmXXV4mAc
Date: Mon, 24 Nov 2025 09:36:23 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Daniel Hammer" <daniel.hammer@gmail.com>, git@vger.kernel.org
Message-Id: <26c59938-45b5-4dcf-924c-49a3d354126b@app.fastmail.com>
In-Reply-To: 
 <CALrqSpeAiSU5JtdePf1Haygd_a08AKu6iBrO-LZDjcW8KCqJLg@mail.gmail.com>
References: 
 <CALrqSpeAiSU5JtdePf1Haygd_a08AKu6iBrO-LZDjcW8KCqJLg@mail.gmail.com>
Subject: Re: git whatchanged deprecation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025, at 23:00, Daniel Hammer wrote:
> Regarding:
>> $ git whatchanged
>> 'git whatchanged' is nominated for removal.
>> If you still use this command, please add an extra
>> option, '--i-still-use-this', on the command line
>> and let us know you still use it by sending an e-mail
>> to <git@vger.kernel.org>.  Thanks.
>> fatal: refusing to run without --i-still-use-this
>
> I still use this, usually multiple times a day.
>
>
> The flag approach seems unnecessarily heavy handed, when amending the
> documentation would have sufficed.

This was added to the documentation in 2013:

    New users are encouraged to use [git-log(1)] instead. ...

    The command is primarily kept for historical reasons; ...

The version you are on (2.51.0) finally said that it was deprecated.

The heavy-handed `--i-still-use-this` is meant to alert users (who may
not read the updated documentation) that the command is going away.

Breaking changes overall are documented in
https://git-scm.com/docs/BreakingChanges

> As far as I can tell from the documentation, this is just shorthand
> for a(nother) counter-intuitive git command.

Then you know that `git whatchanged` can be replaced with `git log
--raw`. Well, a closer equivalent is

    git log --raw --no-merges

But you can keep typing `git whatchanged` on Git versions 2.51.1,
2.51.2, and 2.52.0 by setting up an alias with that name:

    git config set --global alias.whatchanged 'log --raw --no-merges'

> Hope this DevEx regression is reversed ASAP.

That won=E2=80=99t happen.
