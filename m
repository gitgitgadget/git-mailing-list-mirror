Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F62F5B
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763218545; cv=none; b=Sv9dv2M2Z+voBUWHFSVFdOBG09+K+AiJXR9EdA0cukkUEMSg+d+PjGmeZND6QCGgHijDMpwSAi3jcUYeQEuIH/T1IxaiGcmhogZrkHpB+nGN5Dmc/0mTSoKS6eiDjdjU1gX8TMgecznyIllBEHUD7Kl6ZW7+VDSekABB14uADAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763218545; c=relaxed/simple;
	bh=JyZl7/n+pi7cb1ntkOm/E9qsRIph4N1JlMi6Tmgo/uE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gl0oUkWeoTtIpUdxu7j8aUZwwo6YaqU50lJZHG6oiw75n8nbc8/8ISL458wRKaDgmffFLMt/VZTEFPHX6BVTuv2qAfNQvuvWNIzfZhe9b6YzRaFb8OQKG+Zjq7IAyLQxkOxbvJEW3wt0PdIyLA/j+mtbPW5k+OZ/wtBiJxL+p0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nt2Wza2Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HDNXor9n; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nt2Wza2Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HDNXor9n"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9ACD7A0166;
	Sat, 15 Nov 2025 09:55:41 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 15 Nov 2025 09:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763218541;
	 x=1763304941; bh=JyZl7/n+pi7cb1ntkOm/E9qsRIph4N1JlMi6Tmgo/uE=; b=
	nt2Wza2ZafhSHzmuzwkeBhBVZbebYRDaSKJIlEj6arZUeNu07jleBJjXYhm1geLz
	SmiknLCKe/oV07PD9+bbIuiOEv2jntltqjVQFSFgElm4TJY/23w2L9NeOxa2Nkml
	SEKoJU3ja4LjuyKZWeCbFiEDUVe4tBLbuzgpIUyte8MzpBhw4aakjLTZTlksMkw2
	TY/h6flSRLcTNDhZo9gp2F+JAJRydjodKA5/SATJ6pb2K2X0R/Z9qjH4UyPypz/c
	eo84hT5BB7p8B1eXTpWB34nGzJ+Ae5thIiej7HPZb1nQf4Ay0KYPvkrqfKvKIN2s
	YQ0GOtO4Oal1myEVpMJA2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763218541; x=1763304941; bh=J
	yZl7/n+pi7cb1ntkOm/E9qsRIph4N1JlMi6Tmgo/uE=; b=HDNXor9nTY8ATT87o
	V20FPI2dF0SxXJwrnsRXjNtG1byKKl0r8+Igf5+u/E3rFLZcIRelIstexAwtgxAN
	dhtExFYQBvtritkBSz+jGEOKP5PbJmiDrL6uiGhJw4VJ6tcu1aQPFSNb6gCpgg7w
	SaeAvV6AjgnM5k+wpKRGT5S4JSM8QQn2OWEmma5b4oVYBhPXrjLhDlinOrM075Wj
	JoWpghYPy5W+++CwT9Mh06lS9mJdkZ5RUq78iGCRbLn7ZJUrFzRa4eraClaMFHct
	yToRe3UcC8llLEp70BuG+cOPFFIe5nzly9eIn2nCz/p3SWYsKH1ZyUtgSJSp930y
	+YxPQ==
X-ME-Sender: <xms:bZQYaSvMAVBqFKR_rxaQh3h9DOBcUNMRtwAjb9ohy-d6X87y_WzJxdE>
    <xme:bZQYaSRkZQtX9Y5vqS_QLJIP_kSRbfn_L0hjvxyLIe5vaiTnUcnveCxiYjsnA9UBK
    6JL_DoZw0YuaywaopRZ-nnaMSpOGydc37Og9Xvv0eR7QjxV6AhjmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrghnghgthhhirghssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bZQYaRaU0_JQMlgPd7uqjUfLnfcNuTgxOp7TvzVAX9VRZ2O-JPB8Vw>
    <xmx:bZQYaWUaRDswDqoZeQkiGQUvBur72GcV6Ggv-k1BHt-ANB8U0uoAjw>
    <xmx:bZQYabh4mEAM4sXZqNftbtunSI3CUZykNUFywbuqEj4CtziqZO1M6Q>
    <xmx:bZQYacWhmPR2OgML1c2-PqqVSMKLoMewDPVifkYr3iYFzov0s2m3ng>
    <xmx:bZQYaXA5sIZWcVzb8XQxwcWCijDkkCXe8HAdzTzW9Yd-Le9MTQQgjCf6>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 50AA41EA0062; Sat, 15 Nov 2025 09:55:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuDknOoYLkRN
Date: Sat, 15 Nov 2025 15:55:17 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Chia-Sheng Chang" <changchias@gmail.com>, git@vger.kernel.org
Message-Id: <1855f0cf-f682-4972-8e3a-91470480ae87@app.fastmail.com>
In-Reply-To: <87ms4o0yuu.fsf@gmail.com>
References: <87ms4o0yuu.fsf@gmail.com>
Subject: Re: I still use git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025, at 04:16, Chia-Sheng Chang wrote:
> Hi Git team,
>
> I still use git whatchanged command.
>
> Best regards,
>
> Chia-Sheng Chang

This command is being removed because it was supplanted by git-log(1) a
long while ago. Both commands use the same machinery, just with
different defaults.

You can replace it with `git log` in this way:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).
