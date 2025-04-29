Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A51C6B4
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955642; cv=none; b=iEvB7ZyCHOKcnbiS450gscEAGtUwPRjJzFQy4YBZodCXt95aZgeLstC1PDvyI7YPXTJqZxxJRVF/StsqXqMnW1ceiWJtLezMdImlGVXXs3otZPb2/6f/POpzkdCuF+nflKBxQOHhsImq9HJgoSe4jK2VUJ7WhrKDRma7cgOELb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955642; c=relaxed/simple;
	bh=Otd3dTh7m3PfJm4DIRRR6cE14UW0hUAd4s0JIcZb4n4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Cw6ktahbQEJudqcd+GKBUgG56Uz2td/4OC2yQNoehoFUrEtjickkoFF4wtA7xEUQSUwPMj63juufWwjaZEWv/H7udhEwYviD3nrMSaZZVesIqGUf/IcFdyvt/bbrZDiJ9dmoy1AcvNLGgOLYi82RnXPbFRr6F4/wkhT1Ofn14FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=OMe3Pdns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDIpr5kq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="OMe3Pdns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDIpr5kq"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E378025401BE;
	Tue, 29 Apr 2025 15:40:38 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Tue, 29 Apr 2025 15:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745955638;
	 x=1746042038; bh=Eh2n2Ygt8IrGRv1wyUJ/DiBr+WRrh6gRkIxayzr77QU=; b=
	OMe3Pdnsb1INUTEiy+kjOZpZW2v6fLaRc4DAcj0GtuM32soTnjG4hSHUY0rdc6ZA
	O7vr6KA7h9IeSXDwHlwAGqkpSABLPSmP+82n8x2sGTmBPwpeSG6s7ChfsrG3xpia
	Bdy66rclrPUtX0BVEjTv4ldRZKyseA+t7IZOcDEqXmA1z8cFX94V6My2CSVBdY3y
	Jol9G8vo8dUU7AUWhjs3AD6n+y5WtCGtOiFML4jTFGP+Y2U3UmI3F8LIX/mX09KU
	Q1C/43qOKvUTT/fKOEOQN0nr4cJLvbnf8mp1PWh/swBWP/llBR5X26PjMclcAQEM
	IwUzj1QQUCrJobbrE6+W/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1745955638; x=1746042038; bh=E
	h2n2Ygt8IrGRv1wyUJ/DiBr+WRrh6gRkIxayzr77QU=; b=EDIpr5kqP44JWMk1g
	Ym4pTHYMe4bMN2gsye3Y8chEK5NAXVUATEy5og96F+e6x7ZQzq7Kdxupqky8VzCJ
	kjTKVLnb7U9u+IObQ6rWnDKLQJzFAXBmMt7W5LUk+KgGSZN0HdeNT3DE/5R6f0Lo
	t1inMuLM9zhpvs3DB5JrFuruab+lhSVnp39kKsHVNA3SvvaVQPme681sXURmnTKW
	mN0H11XfdGnOlkRm+6DmdyZVgKyuwJyyOAvPMhZQvNDJpqQm1JGVF+pdEUkA2vBP
	+5+44YyTEJv+NzTapUp4pQ3HAebHKNIXBMjiXl48inUX8wyT5QcqYSpu4MT78iuW
	IMQuQ==
X-ME-Sender: <xms:NisRaH7aSp5R8fED0wuCpJSHaBFRGkit1tyzuauxdc24ku8pXtGG0Yc>
    <xme:NisRaM5XSp6k5vxuWDY2IugRlOIJOVordO2qG8cjSvN8Ccsfdu6Fu0YphJrSb3JJR
    GJgG6clxLBp1iBvyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghoug
    gvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpefggfefudet
    udevledvffehleetvdehueeftdegieektdekieegtddufeeujedtvdenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhs
    sggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NisRaOfO0r07AMYU6EZz-RmyrItiilOK0w_hLVoBcY56j51QaMbOuw>
    <xmx:NisRaIIOfYzlEJk3fDcGBprnAXP6DB4ZGlI1cjGVni0Iu-6D8zTKSA>
    <xmx:NisRaLK9Y4RTT4QLW1qTnlQBAT2AXScRehIeqxgM2xJOoey1iP3u-Q>
    <xmx:NisRaBxN5LePoczbChEMQEm8tWz6F656WPcDg6x4nbk1GQ1k13bOJg>
    <xmx:NisRaIjjWz4aadFYUGwGkuTEg54ySMXqJQJwGg3NCKpeV2KL-02eVj-9>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4881478006A; Tue, 29 Apr 2025 15:40:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9ccdcf6233d5601f
Date: Tue, 29 Apr 2025 21:40:13 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Message-Id: <fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
In-Reply-To: <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
References: <20250428194048.149348-1-code@khaugsbakk.name>
 <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Tue, Apr 29, 2025, at 11:22, Phillip Wood wrote:
>> #0  run_git_commit (defmsg=3D0x555555babe70 "<repo path>/MERGE_MSG", =
opts=3D0x7fffffffc070, flags=3D0) at sequencer.c:1158
>
> Thanks for the backtrace. It would be useful to know what's stored in
> opts->ctx->reflog_message at this point if it's not too much trouble
> please can you run "print *opts" and "print *opts->ctx" here.

Today I ran on f65182a99e5 (The ninth batch, 2025-04-24) at
sequencer.c:1148.  I was never able to reproduce this
`opts->ctx->reflog_message` having a weird value with GDB today.  The
reflog was also fine.

Then I ran without GDB and I got the weird reflog that I expected.

So I don=E2=80=99t know what `*opts` or `*opts->ctx` looks like here.  B=
ut I did
find just two minutes ago some old notes about `ctx->reflog_message`:

```
Thread 1 "git" hit Breakpoint 1, run_git_commit (defmsg=3D0x555555babe70=
 "<merge msg path>", opts=3D0x7fffffffc070, flags=3D0) at sequencer.c:11=
58
1158		strvec_pushf(&cmd.env, GIT_REFLOG_ACTION "=3D%s", ctx->reflog_mess=
age);
@(gdb) p ctx->reflog_message
$23 =3D 0x555555ba0d50 "\250y\267UUU"
@(gdb)
```

It=E2=80=99s line 1158 because of my debug code apparently.
