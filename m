Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211738E5DC
	for <git@vger.kernel.org>; Sun, 24 May 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626485; cv=none; b=n+kgzsOFiy4nMEhwISQ2zOmyp5L1qxfYnBLxXpd1NUxajTZRaJJd1SStSTrIWMLs9H9ZfL6Jnx7EyFDhRaxvds2M3OFY5jTa9NU6qMcxd1+niPrEunmrw4qSpDC/P8Evhw5tQOCgjN93xX2kcFjYS1MT60pOEuWgWrSiBa0gfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626485; c=relaxed/simple;
	bh=STILv5nzwc+DqkMTK/2Zl077cW7DX6HLGfxKGzIixGs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aOTo7bjY5oO31MbsA5VXhxMx9ZdUpfz3/+WfI3/sMPzVXv8Xxb2CCV1WkFRphjQyl0MTakZJ4pnU1r5d7+/Lv5me5/VmYCzOAlW5dzOQi4/gZNQ9MgV/0vwJFvvssv1TDGxGaiTU9GilwUsCDlgS/EIGzFqICcI+RbKLrihCwug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LAwPI+oE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frWk34e5; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LAwPI+oE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frWk34e5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C7EE31D0002F;
	Sun, 24 May 2026 08:41:22 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 24 May 2026 08:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779626482;
	 x=1779712882; bh=VWG9IEflBevlD2anYtoLvRoFUGl4ISNIYq38BWmBahA=; b=
	LAwPI+oEglMnYcAWXCisJ/xAVJxvAyGAIRg3txehoxJZaaLkU2QALLdKG7wdr+6m
	Luy6gl7RtL1ElA2wmYw9OMjDYEXWx1Ik9rrt7aFAr8MSlKNEo+MqDJLHStFuX3zQ
	N7L9Y9rZSi3eG8pkHwdWoMj1VhEful5i2+pXUIGamtUX30BW36dStcOf3XhqhfIX
	vtybapjCKdSwoSTMPvFxti+5pD3jVMLGux/qH7KzxiTbpEGG2oM8zvHYw5a/X/z0
	NA4KLbu1uk4br53qMCzkEerCJ3Pcd6laZHXE6CtSstLmWK4ljusJXyOQXE1oXxgQ
	92E+VERYOyIPZ7HV2lvsIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779626482; x=
	1779712882; bh=VWG9IEflBevlD2anYtoLvRoFUGl4ISNIYq38BWmBahA=; b=f
	rWk34e5aYrwiHxz3RXKVghz/B4kKxMFKePiWMATsodJQIkbBEXuY5muYy7KzPX5H
	aXaEfeF2xka7vQ6s/7kRx/YcopPofkV8jA/78frIs+eFdHCuHjoaUHaxe8/iK1EB
	OtyLYVzel0H16DlC7RDu5vPnCuJ+45b1ggo7/PKCursOBI3pnwGlhTLQIJyXmn1f
	gXp0CHcvSiJR9TcY2Vz3boX1D/ft3V+nubcX03Us3I/Upshza9mLVagm8B4uSesw
	1J69jhsL4WwF9S8msUXcO5Yiy1H0BpR2ZmZ7UC5XWF6AiIMrgeA+O9xDLBj8soSS
	0T2sx2LTq9Bq/ozuXEmOg==
X-ME-Sender: <xms:8vESarvQP4ujG4h7j93UzHG5WSv0n2ugXvvq8oX3KK1vAswKtT9aI9o>
    <xme:8vESanS1phFYkHQZad3cjG_XxaT77xvtw9CCanmOPr7qtBbLB35AGeSBqHUpr3Q1L
    vfMD_yrC44xmV_2pqnzIXPPttFNxCBXjT3HlyY7I7pGKAqswpMb0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheehleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehjrggtkhhmrghnsgesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehlihhnuhhssehutg
    hlrgdrvgguuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8vESalZbjF0-LiRXZXV0VKoFcK8YAHkZaOejU7kAeMk6LBDPd9_8SA>
    <xmx:8vESaluXB5q_Rj3PX8s1z9BSyiPITQjjw5-ulxNaklmfKZXl_EnAog>
    <xmx:8vESavMCkT-XVLMR76_P6kD05ai-M7jub-cgKXuQrrdr00aGSL1rtQ>
    <xmx:8vESak6ymFoF7BOxmy3VbVrIzvRHsrug_BlkItxGYLi2N8f6Qk7rQA>
    <xmx:8vESaish76-qv3EOy2pnPVQp6KHQuiP3O2M7JPg2UMJzMeMG-3VgXubR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 653243020073; Sun, 24 May 2026 08:41:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Sun, 24 May 2026 14:41:01 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>
Message-Id: <fc1f8149-98c2-48e5-9725-08cc21696cb2@app.fastmail.com>
In-Reply-To: 
 <CALnO6CBiRefHNT6tjskCQRUOj5Y--K3okR_RFPmth6O7s1_VKQ@mail.gmail.com>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
 <55d5d53a-ec30-4b72-9ff4-c5a0631620ec@app.fastmail.com>
 <xmqq1pfivfa3.fsf@gitster.g>
 <CALnO6CBiRefHNT6tjskCQRUOj5Y--K3okR_RFPmth6O7s1_VKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026, at 21:23, D. Ben Knoble wrote:
> Overall looks good to me. Repeating a few points throughout the doc
> might create headaches if format restrictions are changed, but I think
> they are essential points worth repeating for now.

Thanks for taking a look again. :)

>>[snip]
>> @@ -81,19 +87,25 @@ trailer.sign.key "Signed-off-by: "
>>  in your configuration, you only need to specify `--trailer=3D"sign: =
foo"`
>>  on the command line instead of `--trailer=3D"Signed-off-by: foo"`.
>>
>> -By default the new trailer will appear at the end of all the existing
>> -trailers. If there is no existing trailer, the new trailer will appe=
ar
>> -at the end of the input. A blank line will be added before the new
>> -trailer if there isn't one already.
>> +By default the new trailer will appear at the end of the trailer blo=
ck.
>> +A trailer block will be created with only that trailer if a trailer
>> +block does not already exist. Recall that a trailer block needs to be
>> +preceded by a blank line, so a blank line (specifically an empty lin=
e)
>> +will be inserted before the new trailer block in that case.
>
> [not strictly related to this patch, but while we're here=E2=80=A6]
>
> Even in context, I find the original (and new) paragraph somewhat
> jarring. In "the new trailer," there's no antecedent for "the
> trailer", so which new trailer are we talking about? The previous
> paragraph is about "<key-alias>es" for --trailer=3D"<key>: value".
>
> We _could_ move this paragraph up one, so that it follows the
> paragraph on trailers being appended when given with --trailer.
>
> Either way, adjusting "the new trailer" to "a new trailer" might feel
> better to me. Other suggestions welcome.

The paragraph about new trailers originally came right after the
separated-by sentence:[1]

    By default, a '<token>=3D<value>' or '<token>:<value>' [...]

    ------------------------------------------------
    token: value
    ------------------------------------------------

    This means that the trimmed <token> and <value> will be separated by
    `': '` (one colon followed by one space).

    By default the new trailer will appear [...]

=E2=80=A0 1: dfd66ddf (Documentation: add documentation for 'git
     interpret-trailers', 2014-10-13)

Nine years later in [2], a =E2=80=9CFor convenience, <token>=E2=80=9D wa=
s added to that *existing paragraph:

    [...]
    `': '` (one colon followed by one space). For convenience, the <toke=
n> can be a
    shortened string key (e.g., "sign") instead of the full string which=
 should
    appear before the separator on the output (e.g., "Signed-off-by"). T=
his can be
    configured using the 'trailer.<token>.key' configuration variable.

    By default the new trailer will appear at the end [...]

=E2=80=A0 2: eda2c44c (doc: trailer: mention 'key' in DESCRIPTION, 2023-=
06-15)

A little later in [3], that part was split into its own paragraph=E2=80=94=
and
expanded into two more blocks (source block and paragraph):

    [...] <key> and <value> will be separated by `': '` (one colon follo=
wed
    by one space).

    For convenience, a <keyAlias> can be configured to [...]

    ------------------------------------------------
    key: value
    ------------------------------------------------

    in your configuration, [...]

    By default the new trailer will appear at the end [...]

=E2=80=A0 3: 6ccbc667 (trailer doc: <token> is a <key> or <keyAlias>, no=
t both,
     2023-09-07)

> We _could_ move this paragraph up one, so that it follows the
> paragraph on trailers being appended when given with --trailer.

But going back to commit [1], there are two paragraphs that talk about
how =E2=80=9CBy default=E2=80=9D the new trailer will be appended to the=
 end:

    By default, a '<token>=3D<value>' or '<token>:<value>' argument given
    using `--trailer` will be appended after the existing trailers only =
if
    the last trailer has a different (<token>, <value>) pair (or if there
    is no existing trailer). The <token> and <value> parts will be trimm=
ed
    to remove starting and trailing whitespace, and the resulting trimmed
    <token> and <value> will appear in the message like this:

    ------------------------------------------------
    token: value
    ------------------------------------------------

    This means that the trimmed <token> and <value> will be separated by
    `': '` (one colon followed by one space).

    By default the new trailer will appear at the end of all the existing
    trailers. If there is no existing trailer, the new trailer will appe=
ar
    after the commit message part of the ouput, and, if there is no line
    with only spaces at the end of the commit message part, one blank li=
ne
    will be added before the new trailer.

These two seem to overlap? They both talk about appending. Why does one
talk about how specifically <token>/<key> and <value> will be treated
when appended, then a later paragraph *also* says that it will be
appended?

Here is a draft of this part of the doc. I have tried to consolidate
these two =E2=80=9CBy default=E2=80=9D paragrahs and be more explicit ab=
out what =E2=80=9Cthe
trailer=E2=80=9D is. I have included one unchanged paragraph before and =
after
for context.

***

Some configuration variables control the way the `--trailer` arguments
are applied to each input and the way any existing trailer in
the input is changed. They also make it possible to
automatically add some trailers.

Let's consider new trailers added with `--trailer`.
By default, the new trailer will appear at the end of the trailer block.
Also by default, this new trailer will only be added
if the last trailer is different to it.
A trailer block will be created with only that trailer if a trailer
block does not already exist. Recall that a trailer block needs to be
preceded by a blank line, so a blank line (specifically an empty line)
will be inserted before the new trailer block in that case.

More concretely, this is how the new trailer is added: a `<key>=3D<value=
>`
or `<key>:<value>` argument given using `--trailer` will be appended
after the existing trailers. The _<key>_ and _<value>_ parts will be
trimmed to remove starting and trailing whitespace, and the resulting
trimmed _<key>_ and _<value>_ will appear in the output like this:

------------------------------------------------
key: value
------------------------------------------------

This means that the trimmed _<key>_ and _<value>_ will be separated by
"`:`{nbsp}" (one colon followed by one space).

***

>[snip]
>> -a group of one or more lines that (i) is all trailers, or (ii) conta=
ins at
>> -least one Git-generated or user-configured trailer and consists of at
>> +Existing trailers are extracted from the input by looking for the
>> +trailer block. Concretely, that is a group of one or more lines that=
 (i)
>> +is all trailers, or (ii) contains at least one Git-generated or
>> +user-configured trailer and consists of at
>>[snip]
