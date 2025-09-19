Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0092AD16
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287527; cv=none; b=cDBdK7HskUPo0xK6GfPd2BJ6S2g7ovud+yTWYe/r/uUzie8Ck18XppHTZ2NZlcAMo238noyEY1F1A0jb9ZgUQtXPMzR2TVhflIj6znl6k0XJBS6PXkFmOKIpJ289E5ZAWY/HJTJQvzCcEj1vD2CQolRmsRpROhGDw2ub3ak66Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287527; c=relaxed/simple;
	bh=/FxYhc02z0D30YK4Zju+y3X1rvfbgbDkRhGJdb1Kasc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mfQ38/jkpAp3hsPOwGiZBXaXAeevPpUr2/ZP2zDgV1cVsoOlppXQo2JNwTb4LdSx+a3xLl9gf1PaEgJM9+gfJaSJKgWZ1uFSNCHnpFtTjbn5FOKyUnI9KIMqjYJg6neObDWMn/fQnAB2X7g3ztXTN0MIbrBYv87g5K95aObxxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=D3mWLs/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMsE1Ar7; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="D3mWLs/R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMsE1Ar7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 32DE41D00044;
	Fri, 19 Sep 2025 09:12:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 19 Sep 2025 09:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758287524;
	 x=1758373924; bh=9Uz4jJfGqe3SayjyVjXW98RgNKZJbK+L2So6FVHOY8o=; b=
	D3mWLs/RKM/ALyeizsRjfyD3SIE6FzwtaFgdh9hUyvKbjVKBroKbHsQNHF/Ogb9/
	7qYNuvdyEBJk4dIsTifxCPDgiNO06PUF6vhdhJILK7GUGeKrTxchno4WQlqMl5bq
	+cjAuXuSUJNm5APTa3z7MXJMtXAJlYNOy2sxIqq8drsAzZIQ+AveJ0+RZ/5XhdWl
	BZlq4SddhXMfVlWf9VVSX5wWDXt81cGrQjYTE4pwcJkwZbq+1To8aklpPl8c9vbb
	yjrHkSHZLPEkrI5vnzGvc3GlKJrKYIZu53huK9rqknlXKQRSXt1w0MyCbKiDk4JT
	smBL5LpylD2TascttmIqEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758287524; x=
	1758373924; bh=9Uz4jJfGqe3SayjyVjXW98RgNKZJbK+L2So6FVHOY8o=; b=L
	MsE1Ar7OjoOOghco63FcJqqp2ak8/oMaEDyypqwaLTDfrpMzL4f+2IKuARw8Ky8v
	UBhPByTDjY6Qx1BHC/h8v6x0eQCKZJjDDX/9zYPjbhU5cptEKU+aXkT3ZXAPw2zD
	raqWxF+siWrtqS9L1FoaVuIwxEgGYW8CZCz88u/7p8lRXXNSd+frjlxy4/f0bdTq
	TvZLC9I4vJYls9MQFzJvavHhEhJTQt5CyoKqbw1c22G8gM7Voj1ZTW3JZo6Yu92i
	DjSJ+VQd2+tqYFvGulx34STefB/ASrqdVbPp+QbZ7tajC51us3nLb7+ETifTHqLa
	pAOkq/FlhKAbFLIs7ycLg==
X-ME-Sender: <xms:o1bNaHVJuQsOMF4LqdAVh9x0-VGdSXyus9M_xBLmmMlLZ0N0a99owGY>
    <xme:o1bNaPmAteueSjmixqC20SyX3WRdqkUyjgN3KC6sIHpaZr9-rtCxp-yHV0Fve36UP
    OegBSJk9jyOUx18tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegledvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprghpvgesrghpvgeftddttddrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:o1bNaE9sqLmFJQ1g_RkI3kDQcEfrk9mY836SFuG8ZZpP_-nypLoxDw>
    <xmx:o1bNaDmTOiMZAHSPOXW0tm0scuvI3sCPtgAg1Hl7E9xAGtOARS_ZCQ>
    <xmx:o1bNaG9mU9EcmFek-Qw2ggDghjvBjT_uA7P4ayO0ILDhjttrjHi82Q>
    <xmx:o1bNaBlhsSyD3MLzWa6KYcj5oEB0OVyFxmBmhh5wrsdtpuqr2_hJWA>
    <xmx:pFbNaHR4ja8ZXZfFJVqPzdGr5tXCH9bBuUfrdVpkTJ6I1atSkebygjFI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98C2C1EA0068; Fri, 19 Sep 2025 09:12:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A89VFu1tWRSZ
Date: Fri, 19 Sep 2025 15:11:41 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Lauri Niskanen" <ape@ape3000.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>
Message-Id: <1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
In-Reply-To: 
 <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
References: 
 <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
Subject: Re: [BUG] git stash show -p with invalid option aborts with double-free in
 show_stash() (strvec_clear)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 19, 2025, at 12:18, Lauri Niskanen wrote:
> What did you do before the bug happened?
>
> Create a repo and a stash entry, then invoke `git stash show -p` with
> an invalid option:
>
> git init repro
> cd repro
> touch a
> git add a
> git commit -m init
> echo x >> a
> git stash
> git stash show -p --invalid
>
>
> What did you expect to happen?
>
> Git should print a usage / option error and exit cleanly without crashing.
>
>
> What happened instead?
>
> free(): double free detected in tcache 2

This bisects to 748bd094 (builtin/stash: fix leak in `show_stash()`,
2024-06-11) for me.

> GDB backtrace:
>[snip]

-- 
Kristoffer Haugsbakk
