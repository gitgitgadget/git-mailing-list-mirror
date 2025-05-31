Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8E20E33F
	for <git@vger.kernel.org>; Sat, 31 May 2025 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685179; cv=none; b=G2limeiDps1DBreriaSVJtgeCT8J7q2L74IA/YzVdxpNjti4EXth5IjFWsQZ/l5CMuHxX4ufUEv9EGqs2sf1VIHJt08LgxihHNrWYwlpRYkcLkNW/AYZfrOLN42FU5GQbYyq6h+JcE9t6Pm0X5JxUicUH3j+GgQRfvAblWLsKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685179; c=relaxed/simple;
	bh=CUSr3ooBZcNtWgDtHCXmhjUzp8rfcZTN/AJkhbrM2uc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K/jguGmj1QF4SRvX8SJEGxNQ2GO3RF9fZE8FpDzyH+lKJ9W8OC4dW9P3g/qzomKyFt2k57Jr7czWXAwTQdOuxJvmGS2f1j8yfVferRio9E9Q4/mLZwZBB52Fs36ZHY472GSmzl8hSE9vUznVRVFFv71myu71dEm0OR+QXZVttaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=k1xgbd97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtSifwg+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="k1xgbd97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtSifwg+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A167725400E7;
	Sat, 31 May 2025 05:52:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sat, 31 May 2025 05:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1748685174; x=1748771574; bh=AHFHwL9kI6ZfEQMVxG01f4AfbksutrWP
	1EW+/YLQFng=; b=k1xgbd9767pQjvIE7XaXvQh+cIn+JqTURx0qP+UlFtxo48Gn
	AATwvVLzN4sOv5F0cNuaFR7deJR7kLbXEYx0hpBNs91R0bCIWecoO38yG3NKftbr
	1e6F7VWhJBuL7LncNoppYJQIQLkXgASxFzdGf7YNeNIdEqDTDq8YcPy3cOBIccGK
	0VkE7XxCigB/hXvdNgx2+4yKv9oKZ33hWY5hJSlxLpNGR+okcsHEfTDGoEVv/Rrg
	v5PounVitOe5IelLDu2qq7vQD9aivte/Y3kMh0Y0RrTVfRX/zWHupzB41zY8ytnW
	VvV1QpkfCDM+bxSfKv0qYcpAEqsL/9MksRASFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748685174; x=
	1748771574; bh=AHFHwL9kI6ZfEQMVxG01f4AfbksutrWP1EW+/YLQFng=; b=F
	tSifwg+eKFtZGwyDoTyVcWyqp7iANRFBb9wYsrMiKcHgQYWhV6IlludZEt08pVUn
	lK34OiCdPXawYoSws4O6AkYsOdkNQWxDiKG1VCoKxUY88kQQPtmj5tuJ40bBDJTW
	BP6Vk2QmbhfpBzE90IwBiClADVDqpXRiJfO0ezyUeaRJv4NKhGC/UXD4E9hkI6QV
	GTJvZbztJTwlxvs04ST3NUKpFAFb0hWxeFSRJqO1Y8xRDQ58iyhjqw9e0kK46l5i
	iWxyOAqyImuwyHh0ta08Wn4+AdkeqA4H1KsftnN5esGnXEl6zTBzfby1jKrytlot
	DUDUC6lFANgxJnc8TObqw==
X-ME-Sender: <xms:ddE6aGNTcV-KaxboOcEBPggvxDdHp7sK1QuPZbIPMgmdidV2I-UFbAk>
    <xme:ddE6aE-PZXUNBdA8I2E-o30QDlz9EF-nZMud1Dg_4fkDjmJGXt1aUMdtUZ6kfVmtB
    wsueTQjxDQSnBDx0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefudehleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffr
    rghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudejlefgudffffejleffff
    eludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:ddE6aNRWM9Ezm2d2oBG2xu0Cse2__u49QRwD2-Lzg_YfNVLhd2h1ug>
    <xmx:ddE6aGvcMVseUrJy-o-1bFookloJa8Qumcfso7wA7FsQojWJDTN8_A>
    <xmx:ddE6aOe_KtkAu7fKCagTeJ19uFQl0UYhOYrHYOKuvtQaEOB5PxysuA>
    <xmx:ddE6aK3bd5tG2SDXtLcRuSw4quS9-RZRLmpcU5PLUYGL8S-2r-LKEQ>
    <xmx:dtE6aMXodAUQGXjfkdveUnvsx6J9hzWXDE89IGrDjna9KWh-VvxxvV-Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D0471EA0060; Sat, 31 May 2025 05:52:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T55adab7ef7b76081
Date: Sat, 31 May 2025 11:52:33 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Eric Sunshine" <sunshine@sunshineco.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Karthik Nayak" <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
Message-Id: <a2a50127-6ab9-4d8a-abcc-b1a741df293e@app.fastmail.com>
In-Reply-To: 
 <CAPig+cQiw03qfwwE9Md+LdKeS-6BGx0M1+0YYDUDXO9UPVo+wg@mail.gmail.com>
References: 
 <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
 <CAPig+cQiw03qfwwE9Md+LdKeS-6BGx0M1+0YYDUDXO9UPVo+wg@mail.gmail.com>
Subject: Re: [BUG] refs: verify does not work if there are v2.43.0 or older worktrees
 w/o wt. refs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025, at 00:23, Eric Sunshine wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> Subject: [PATCH] t0602: demo v2.43.0 worktree problem
>>
>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Even though this is a bug report and the patch you included doesn't
> provide a fix, you did craft a couple tests, presumably with the
> intention that they should be used by whomever fixes the problem. As
> such, I'll give them a bit of a critique...

Yes if s/should/could.[1]  These are reproduction scripts as patches.  So
they can be applied and show the current state (first test is
expect-failed, the second is expect-success) of the code.

My previous reproduction script with the git-clone(1) is inconvenient
but either cloning or using a worktree is necessary in order to truly
reproduce the problem (as opposed to simulating it).

A `-subject-prefix=3D'PATCH THROWAWAY'` would have been in order.

On the other hand I did write the first test (the second is ugly) as if
I was doing a quote-unquote real patch. In that light learning more
about the proper style is useful for me. So thanks for the review!

> Overall, although the first new test makes sense, it is not at all
> clear to me what the second test is checking or what its purpose is.

The idea behind the second test was to show a case where it does work
with old worktrees.  But simulating the old worktree didn=E2=80=99t make=
 sense
since it looks just like a new worktree when there *are* indeed worktree
refs.  So it just ended up being confusing.

=E2=80=A0 1: As in troubleshooting and fixing the problem, not the final=
 test in
    the submitted patch.  The test is unlikely to be good enough for
    that.  But the patch is signed off on the small chance that it can
    be used because why not.
