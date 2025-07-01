Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E2472601
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405440; cv=none; b=nefqf/+dteyD87NaRKxN9hUEaukD5QM3wamJpRwImh4SYtXYzkKwNH5m2YGBzng4QisHIg4UqEHSNrOE1OyCNWczrrhwIMwRtZcAo3XKnPaWaoIf2vRBaKIhj/T6B5Az3ZmLWf8HRH/R3IRPGXFFEGqzxPVxcvOLNqoeikf6MbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405440; c=relaxed/simple;
	bh=l6QR301gOHYUySM/xh2jBmWSP6qMz6125EZeYi0GoHM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P+nvORoh8iND/7pmsSPZBscyOohY3kd8lv7c226lSON/NuAB94d6ZODGE8GJrn8fE329zHTOgs2cx+UxXsD2dreZ8Y89rQqM8ZFXDFZ0bLCfZu/NyQ/armoP3HkaRRc3WhyKCudAzOZfhbAaxVZwZBmOw/GZzDL+2WWdIgIadWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HPI7bzb3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJPWQIKZ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HPI7bzb3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJPWQIKZ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 55BDB1D0017E;
	Tue,  1 Jul 2025 17:30:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 17:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751405435;
	 x=1751491835; bh=3aZWjDGEtklogbV9ckaKBH12yMWwWQNDlzEB+IOus9c=; b=
	HPI7bzb3jOgyA+nink+yss2qtlXqVtzLcGW+3ilWtD+uPAAgYKHY/culRea4I7Lw
	LEY+cC7nrVlEXJrsbe1aII/rxlPsQje7iA3vE4+ZaGPEcn2KbYxZRFkLZm6uEmzH
	56wUMgudsns4WKw3ocDTperU3/JAGFvLrYFcghkglAHyfaSCR4h0HOSPcGG22zaz
	lcSTdg+pk3sixx8lWglklJhPOK96tjVrNeADbayxGTyIf8vqIbTDDMe6Xiamq6bI
	w/pD4Zwxz+iYiRN6kE3perIk0RTN6CzKhVPPqrGF+ZqanR0HMJOEXZL96Oi9ineO
	sxk5kK4PxrQpW4xFf1VrAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751405435; x=
	1751491835; bh=3aZWjDGEtklogbV9ckaKBH12yMWwWQNDlzEB+IOus9c=; b=G
	JPWQIKZMdibCrw8E6Z19KPKD+2bncq/Kr+DY4ApVXJzEUl+0lU7JP9oWJKisa3at
	I/CtXMiOJYPmPyWJn0U87pnukaSUqJChmCiiNrLfz3DpsxFQafCwnKSDuL+nT9Zf
	sYz+V6u6zXQCc1pK7vz4q0321Ahps3Wl88K3UmqQWCYJW/TDl3c/fRGts6ZNookH
	Wr/eIoEul4YuPySdfsPAzTGHn1jhKRo73aT7y4o2xjdlO33mCfM6UyAsWaPV9zxE
	fszFbIF0vD5ipcFH3iwts04SJ46vwm5jeM+wbokol56uu1qFvZYRvOKwhS8Vnhxq
	KlvngTbS6VILjPXlX7shw==
X-ME-Sender: <xms:elNkaNZQHeNVES86I1m8jUZgWQHfgyQg-cwiD4lXS3MF6SXN-Oa8Xk8>
    <xme:elNkaEbLWWuTW6V_JhvOJyXXPGM14ENUuY68sjLx3pOZZpXQgX6u6wZilgtq1L2Sl
    gQwUKjaP2z5GibkHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeelfeejudejfffg
    leduheegheeufeeffedtgfeffeevudeuleffgeektdelueekieenucffohhmrghinhepgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:elNkaP_IxHG3bl_TD2IBWqsj2Ujw0tSBLi1sxmPE5d_d00-X4ewWpA>
    <xmx:elNkaLoaVu-NIwbvsUJP-Ss9hqyyExZxRnnniLRJhclXx1WBOAk3pA>
    <xmx:elNkaIpBaG_ziu0GThr9DJsgjUZiV07CTEE8sNG2Uqdm1Yh6xRIiHQ>
    <xmx:elNkaBSAZLJHFdEA4TGla2Mo0FgmKTUzxldN8fDbcQ_lqrYv2oZPrg>
    <xmx:e1NkaMwkKh5WaQjsp_3CuaA-W35H1y9jGX2gnZj2ytzMW7PE2EZhLD94>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 79A8D1EA0066; Tue,  1 Jul 2025 17:30:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2f1a40a58e1f4414
Date: Tue, 01 Jul 2025 23:30:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org,
 "Jeff King" <peff@peff.net>, "Taylor Blau" <me@ttaylorr.com>,
 "Derrick Stolee" <stolee@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <d93c9199-80b1-4834-bfbb-8263a80d90d5@app.fastmail.com>
In-Reply-To: <xmqq5xgbk4d2.fsf@gitster.g>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com>
 <xmqq5xgbk4d2.fsf@gitster.g>
Subject: Re: [PATCH RFC v2 0/5] Introduce git-last-modified(1) command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025, at 23:06, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> It feels like the command strays a bit from the usual patterns to me.=
  For paths/files
>> that is.  I like this:
>>
>> ```
>> $ git last-modified -r refs.c refs.h
>> 062b914c841329a003f74e1340ea5178391274a6	refs.c
>> 47478802daddf3f9916111307f153c6298ffc0bc	refs.h
>> ```
>
> I am not getting this example.  Unless "-r" stands for "reverse",
> the above looks totally expected.

Sorry.  I meant this (withouth `-r`) and that it makes sense.

```
$ git last-modified refs.c refs.h
062b914c841329a003f74e1340ea5178391274a6	refs.c
47478802daddf3f9916111307f153c6298ffc0bc	refs.h
```

> I do not see anything unexpected.  Have you seen "git ls-tree"
> output without -r(ecursive) before?
>
>     $ git ls-tree HEAD refs.c refs.h Documentation
>     040000 tree a0f7113f63a19b70dff14bfd9f8f82809f5068e1	Documentation
>     100644 blob dce5c49ca2ba65fd6a2974e38f67134215bee369	refs.c
>     100644 blob 46a6008e07f2624239139cd8b2ff712545f07d3f	refs.h

No. That=E2=80=99s my blindspot.

>
> As I understand that this tool was written primarily to implement
> scripts like repository browsers showing https://github.com/git/git
> I do not mind non-recursive behaviour being the default.  After all
> I view it as a plumbing.
>
>> I have to use `-r` (recurse):
>>
>> ```
>> $ git last-modified -r refs.c refs.h Documentation/git-last-modified.=
adoc Documentation/git-config.adoc
>> 3691fe72d927658ae77ade7fe967544fc6739e67	Documentation/git-last-modif=
ied.adoc
>> 062b914c841329a003f74e1340ea5178391274a6	refs.c
>> 47478802daddf3f9916111307f153c6298ffc0bc	refs.h
>> 0fbe93b36c05bbf4156c157f27998938ce312265	Documentation/git-config.adoc
>> ```
>>
>> And `-r` with a directory like `Documentation` will recurse through t=
hat
>> directory.
>
> Totally expected.
