Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8F343D93
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627576; cv=none; b=oQOs9Q19GBj8jjEw4Jzbe/AiGyBidKq6tzAQaMXo6lTkP2xLwzQ5S1M3CjFgFl+DfmW/2KRM4ycpR1RlTycUUeaRgx3Q/DzlmNRzDNA1M8Cr7mMRGyebPcqh74awXBRfP+7aOOTHURkx9INOHUgwXsxjDdzRsXlI1MFmvb1H3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627576; c=relaxed/simple;
	bh=DFgPGJFOARuM27vq+U2CSa49BCugaHTC537XazUkTSk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hdZZWMPrI5zBd/p8ZgCsig+Vm0mxXFzO8sMfXYvOm2UaF5aZA1ATFxPz/IpVfAFKoE3CHevJT9ScprcBNhBzNzA+LkZCuWt8LgEWIlnCoi+NFkFU+XRmMel/ed0LQzMKkVthAa2u7Yrzooo5hDnUJugpX185MPlZlRlUhS5X7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=B9ccmyQl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cOc/AHkF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="B9ccmyQl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cOc/AHkF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9F8C140004D;
	Thu, 16 Oct 2025 11:12:52 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 11:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1760627572; x=1760713972; bh=qtSs6/CEdVl5EBy3Ejh+Pm2LTMOB/nLy
	DZrcWGdWdqo=; b=B9ccmyQl7SEEA+O6PVjZANM7WRKLQzIl8H9/mopbo0F7lLsX
	PH8IfkuGJ6ajbJw/QQfpOBuOFAJvFj4JQnUfEtzX8H5wz6y/2zwoSwYHfwhScRAK
	1R1ApwBtXxMlpbMnlisOftYqaRQzz81/iIwCCNXfckZ+a1gADSNT1Zqrn/FCo99Y
	pLtfash/Jk8QzcCvl4ieTbJwyBaS9XQBxs3DNk80Tce7KK6Osl3izu0szUR7x5d3
	lovPlsVqgEzUpQgieamo9Ru5zmb5VG9PRHlR/rSLI/HTg3XdPd7TsFkXf8jgTYtG
	TGsr/i4PKfPbYrC8W7G+OQjfV0fbXBwIjVuHrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760627572; x=
	1760713972; bh=qtSs6/CEdVl5EBy3Ejh+Pm2LTMOB/nLyDZrcWGdWdqo=; b=c
	Oc/AHkFh1agcJ3nNXMYdZXB53dwIKJp1cBG+PorUQFEhALCsOjz5IufH4I0HEqav
	6jZnzauI5llouf8wMJf9QdPmjqXtKZ0y5uaXPKa/4wZTAL4z/spB11lKq68sL89m
	TBSPeROBNL+LncB0jrZtoj7t206IvYJClVJa1bpWJ9wZUhK1WMJZeMldswIc+6KZ
	ldM1KpHsrOp72Mxmddu/yLsHcikB8iA8pALpz3fVL1YG0cQPFTbCe+Fze8Dlgazd
	owPOzLxoXLs/6yR0620bshQI9wBSsZcYakkBxAR36+cItjFcLdC2YvM4HTlBirls
	+dbesgUmAlZ/EjyLfj5AA==
X-ME-Sender: <xms:dAvxaFbDt5firwUOklo_XAqBvQRsjp1GEMJPeOODfAcZda-VYOJog8Q>
    <xme:dAvxaHNDlDVEDHpnJwyTmlz-MV-6pnngq3jX_ehjkAC7lyUy3di7xHFeMLVKnyiny
    0p8xzhUbK_7cLXQqCFwLFvwYHPnrM5ls2S7jTub00k1tLT7B8wbqXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeiiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepgffgueetkeejudetffeftdfgteevleeltdeh
    fffhgeeuudeiuefhkeehffeufefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhr
    ghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dAvxaIDfn3VXkH_bFj5NhPm8V7l3uAKUFRcyjHYEVx3H0HN9yyXfYA>
    <xmx:dAvxaF93dRCxv0jpQrkN_bHJbYx4FUCNqM4at4bpy9B0jQejMKAcyA>
    <xmx:dAvxaPFAwoDgdKM5-EC6_Q9hCJiI5hV2bjMcYoco9-xYKwecBVjTMQ>
    <xmx:dAvxaDMTZ1AhOjGS3257Kz_ayhJzipln4VAzMTWnpF5T04Bs5SBvJQ>
    <xmx:dAvxaG2G0R0ahrVbBvO0eQPhP7d421Y5vn1_7Z9fDEKMjCLEkuwMI47c>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0639A1EA0062; Thu, 16 Oct 2025 11:12:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: And9clSpnOi7
Date: Thu, 16 Oct 2025 17:12:30 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Johannes Sixt" <j6t@kdbg.org>
Cc: git@vger.kernel.org, "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <359272c8-c19d-4480-9902-fb092e2635b1@app.fastmail.com>
In-Reply-To: <52fd63c0-cd43-4ae8-af3e-f3fae02eaabf@app.fastmail.com>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org>
 <52fd63c0-cd43-4ae8-af3e-f3fae02eaabf@app.fastmail.com>
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025, at 16:13, Kristoffer Haugsbakk wrote:
> Good afternoon Hannes
>
> On Sat, Oct 11, 2025, at 11:15, Johannes Sixt wrote:
>> Am 08.10.25 um 21:45 schrieb kristofferhaugsbakk@fastmail.com:
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>> This option has legitimate uses but could create a commit history wh=
ich
>>> violates the assumption that commits are strictly increasing in term=
s of
>>> commit timestamps. Warn against that in both git-am(1) and git-rebas=
e(1).
>>
>> I think that the discussion has meanwhile converged insofar that we do
>> not think that the option has a legitimate use case. Rather, it was
>> introduced to solve one particular problem case (that is cited below),
>> but with a solution that was misguided and not well thought through.
>
> Okay if this was the cited example:
>
> https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a2=
47@mail.gmail.com/
>
> Then we can clarify with two questions:
>
> 1. Is the use case itself reasonable, i.e. abusing[1] git-am(1) to
>    pseudo-import commits (modulo the committer)?
> 2. What is a better way to achieve this goal? (assuming (1) is true)
>
>    It seemed to me that you might as well use the author date.  Unless
>    setting max Unix time would be better?  Then at least you will never
>    manage to apply something on top of something with a newer commit
>    timestamp.

To clarify.  My plan for v2 was to deprecate this option for
git-rebase(1) but not for git-am(1).

>
> =E2=80=A0 1: Since this is not what git-am(1) is designed for
>[snip]
