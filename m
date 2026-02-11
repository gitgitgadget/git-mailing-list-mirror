Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C330DD22;
	Wed, 11 Feb 2026 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824638; cv=none; b=pV/LEW1qpBkTWolT0DnzyvvDLXsGHITxzCnShBSDgB/omeLLnkvsBnzpQRGUEmtg0B+/JCVw06EwHThi2K6Ie4X6WSfTnjasZU3aPgasmvtldYrMyI+fV5kl8Qfb2+di5X/Zmhj15zKUfRZ9NTK8HGARfPwtLYngeFddKD1pMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824638; c=relaxed/simple;
	bh=sOjpaBGaEI9wogZqbwVjQXovrEu2YNYdYffaIwQciJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0xLCa5a/u7akOpGJy1EcCavrlG1x1i4qZMhAGsxJIVWUXf/kljcK9wFg8fMQaTBjOvFUcm9m2SBYrTlrkEbv1kmzrLEjro6ArsOdK6LC47WOIm/KvhOKVrDHjgTsqUN0UswVpGH65AiKAi8fm6+DMWSZivJIK4a0sw9nLFu2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iyMhqxuK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qrFLGKMj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iyMhqxuK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qrFLGKMj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BAF2114000BE;
	Wed, 11 Feb 2026 10:43:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 10:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770824636;
	 x=1770911036; bh=XeLTB6PnAWwhW4H3RkaeiODjEYyCHXzmYRybX5V/Fwo=; b=
	iyMhqxuK8OLe6eyV5WOQf4a/CNZAJAXhoTuafg+5vHjxgmBgg8ok2Jmp4LgE+Nux
	LI7RiQaw1MypJWvdGTOxO0MXCipQWgMCIUkOaISvXAQq1vJR58vfcaOD1N82RYgp
	5F4tbvj2wsiwRPonJRzvS2hYl/vni00f+P+kAH1fXts3jiGbV8ksQS+xSM8/NqHG
	vorWAJLtzZyM4NhNRDgNT5eWxcZBX5ZPHmSz+ViFW7ep3dOgk3CugV5amQS8v/r3
	59uRZ0XZk8vrHX/Zo8pnrPyLzWf2X+cevniAfAbvZ0dHYu69pmm7x2F4xnfWmfw2
	roqlfNMpZP/j8mJaRxvOzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770824636; x=
	1770911036; bh=XeLTB6PnAWwhW4H3RkaeiODjEYyCHXzmYRybX5V/Fwo=; b=q
	rFLGKMj7uKU+wpXim+Wz5k2KTyA+tC/YOCikiIa5gR8FBHwIK/hQAlVxDdyqcgvb
	OKwWyLVs4uCEvZ9NvtKL3n3jbtL+XQNz/pZh0k9bteL3rPHCDozYP1MOSXapvc6q
	3VdTzpumvMiMYnQ7DK8rr//7iJOcmzk3iqmOZ1y8MME/5c483D1qmEpuMKKQeGXj
	KQxgaGNlgopY8X6XuiGA4Mh9rY7QWx7bn9gwvnB+nOD/HJ8bnxSyiL0g9mZhAy22
	lwFTgs6vcj/wrpT80NQHK96r81rfT0YX+10lQ7TbCmGw3UBHJl52F2X7j6SEh2s+
	9z8GpzGQecEQTmqE65Zzg==
X-ME-Sender: <xms:vKOMaZUYMlviDKxiZBFkC36NIu-U8p7-UbEq2UuLHte9d_gNNi9wKg>
    <xme:vKOMaaTDdUSHGAMNgEl67awCPUX3g9ebrekJ0PZXWf7AbAFlcWG2ReupUZIOqJu1z
    vYWhX_cXcZkcaaBc5goWl5-n87Vtz5mdZioGIDx-QM16WObb_zA>
X-ME-Received: <xmr:vKOMaTl5zs604948jtM5w0SqDDK2eXXUWBmPgsw_yThTF9bZGzoWUNJQWV_-WPFjDgPmjRAbtzcW67wu3JDUM8cIZwVRYM1BGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhedtvdethfduheffudehudeitdevvedvvdduffelgfffhfdtueeikeeg
    vdeghfenucffohhmrghinhepnhhophhrvghfihigrdhithenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghlgieskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnrggsihhjrggtiihlvgifvghlihesnhgrsghijhgrtgiilhgvfigvlhhird
    ighiiipdhrtghpthhtoheplhhinhhugidqmhgrnhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vKOMaQ4zrA8b-XUAzO1mn8K0H-i295QjrSPfMYStyNEdUwE5W4VJjg>
    <xmx:vKOMaZis8gpUjSNxlgF-P64ZkiJEx3sHR8JpRK9CWTQziNtEx49ZKw>
    <xmx:vKOMadEH7SqRKTEGeWG0UzJmfXecF7hdmG5q5jRAcL3y6l8np82Akg>
    <xmx:vKOMafTXKkKOGtdjsJcTHUpeQkRj_2jjD1q61h454Pm5odIn_O0Dfw>
    <xmx:vKOMadxZ8tjXwdfTmvYmh9LGnan2YSZ52gZpgjNotTP3rjZObEGBI8Rb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 10:43:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Alejandro
 Colomar <alx@kernel.org>,  git@vger.kernel.org,  =?utf-8?B?0L3QsNCx?=
 <nabijaczleweli@nabijaczleweli.xyz>,  linux-man@vger.kernel.org
Subject: Re: [PATCH v2] futex_waitv.2: new page
In-Reply-To: <20260211073553.GA1867915@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 11 Feb 2026 02:35:53 -0500")
References: <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
	<se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
	<aYpg1XelZBzpw4ZL@devuan>
	<rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
	<aYtAknObJpjszCaj@devuan>
	<55bd6ad3-cd19-4839-a808-eceae802d3c8@app.fastmail.com>
	<20260211073553.GA1867915@coredump.intra.peff.net>
Date: Wed, 11 Feb 2026 07:43:55 -0800
Message-ID: <xmqqecmrwais.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> On Tue, Feb 10, 2026 at 04:54:02PM +0100, Kristoffer Haugsbakk wrote:
>
>> An aside but `format.noprefix` is not a boolean like `diff.noprefix`.
>> It will be enabled with any value.
>
> Huh, that's weird. Indeed, the code is:
>
>           if (!strcmp(var, "format.noprefix")) {
>                   format_no_prefix = 1;
>                   return 0;
>           }
>
> which seems just wrong. I cannot think of any other case where the
> _existence_ of a config variable determines the outcome, rather than the
> assigned value. So I would be inclined to call this a bug and switch it
> to use git_config_bool().

Very true.  It is surprising that nobody noticed it during the review.


> Technically that is not backwards-compatible, but I really think the
> existing behavior is just a bug. It was not something intended and is
> contrary to how the rest of Git works. Presumably nobody noticed because
> why in the world would you set it to false in the first place?
>
>> Is it standard to indicate this with the existing “If set,”, perhaps? Or
>> should it say “enabled with any value”?
>> 
>> (+Cc Peff)
>> 
>>     format.noprefix::
>>             If set, do not show any source or destination prefix in patches.
>>             This is equivalent to the `diff.noprefix` option used by `git
>>             diff` (but which is not respected by `format-patch`). Note that
>>             by setting this, the receiver of any patches you generate will
>>             have to apply them using the `-p0` option.
>
> We usually use "if set" in the config documentation to refer to options
> being set to the true value. So I think the documentation text is OK and
> would match the code, once fixed.
>
> Kristoffer, do you want to produce a patch to fix the code? I feel like
> finding it was 99% of the work. ;)
>
> -Peff
