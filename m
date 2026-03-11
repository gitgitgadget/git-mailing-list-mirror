Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BE18A6D4
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 04:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204542; cv=none; b=ctWcFQ6pzXjd8q10U+iA8tt175OAyM1n6t+PhTBtbmIcca12haVJJ+van/o2sC8c0asoZM8Rr5aUfbqPojtkeRMY8BKpGBirSJvLM9unIEFTABq/RFIS0dILduyWfnJPRi9mKD/4yTu2i+yqwW6Os5rGZV3iRCmPyM/0Dwp0oSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204542; c=relaxed/simple;
	bh=J3FxmByYH8SKZ2E8XnVOb7vPCemJKmvg8JVzfXBZN/k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hxw/05WlybuSwz64Y0OzJuvVQYATeX/y+KJI+vV/teNbO7kfi0ZwwT9geVRjRkAbhM4XmPuAnxhjrPbuGp8xBvCNl4QKq7KrWQ/H4Nto1Z5ylm2f0sFM6KpyRXV7IVLMtrT03WsWos0UfGkYpy6vb1whoWyzCCXSvO7ixGnaFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=C743C0Fs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2UiPsdve; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="C743C0Fs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2UiPsdve"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F9DDEC0098;
	Wed, 11 Mar 2026 00:48:59 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Wed, 11 Mar 2026 00:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773204539; x=1773290939; bh=w1YZVYwcql
	FxSDcVsW0ZpHxkRn3uBGv4KH55/vi6beI=; b=C743C0Fsg+CAdtdx06+9z+DivY
	p/6U09XrfmoxTCO9CXPxQ/KBCyH091XjN5GxXmVSvcObUdHMbCGnfgWAaLQV7zSA
	WsYdMqB6zhPQmtwaO5tGaB+eejhr4JYRUjZEVnZw4ashj8IixMYHyMlJZ5sn1YKi
	4t3YB3mzsRnl+xgxKcnhhtGGB3Bsh6Yic3f1CIHNTjqnzhlVZ++aDvBZH4O6aBZK
	To1rHXCOrOk2jKK4T0Tl9ajLh1FPvp+lduyhCv96ph03LiKwdBiVpAEzZxxVn1u0
	Aq5ldh0hXhgi/uwPPo+t7VmXl9f2gjG7nMPM8MUHqbezdrzkLRd9+ky9UqQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773204539; x=
	1773290939; bh=w1YZVYwcqlFxSDcVsW0ZpHxkRn3uBGv4KH55/vi6beI=; b=2
	UiPsdveKoOAlp9K4oqK0qyKOz+JYagDEY7o7J7gF78TLPG61JzPL20P/U+G+95rM
	ibRIChIuqUplUoNn5DOKEtFPib9CfwyuoqMRXrhrcxmrGF67AnzUER2DOKV64hhq
	p0oDm4ahWHdhry5Jg+d4/lRGJa6LY7NAJgoHwja5yQ9wAgDy1Nhh5tueQO90AujI
	zkyDNYesl1SF04VpZMYY2Dbcizjqsc0joHMWukQdVM2CZr7EDIrPu5YuHkOKv7JQ
	P0Vzu6CWPleI10qaMaSCshxWEuVhFTNJmyFZBHl4urD0ZhZV3xzl28YAVP7k5ias
	dB/5ROtqFslwr2u5v/z8w==
X-ME-Sender: <xms:OvSwaVTDY9YaoRk_q_YHzx3pPxzjRnDDyGi784fuRM8zwYk4CbSCxQ>
    <xme:OvSwaZl29q5AT-RGcHZWJgLEA6tHb6Ot0Zj0iUFLURcKx2rLQ_X8F7YNDNPM32gR1
    QqNBUGQX4KlJzxhFcIirqhSunZ9WvwPsWnEZAtgVtOgk-QMVXeUvaS1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdghohhlfhhgrghnghcuhfgruhhsthdfuceotghonhhtrhhi
    sgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomheqnecuggftrfgrthhtvghrnh
    epleejkedujeeuffetgeevkefgfeegvedtffejhefghfegieettedttdfgtdefvdefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghonhhtrh
    hisgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghirhhgvghrrdhsphesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtghnrghrtgesgihiphhlihhnkhdrtgho
    mhdprhgtphhtthhopehmvgeshigruggrvhhprhgrthihuhhshhdrtghomh
X-ME-Proxy: <xmx:OvSwaY94YiXJKFhyXq0I1brDxQqonKF-KYQxF24-CSfPgGEJPDRA8Q>
    <xmx:OvSwaaA-_2w8uSmmXKRLFFD9tNuFvwQ9lyTAGJUp2rX_SCNC2V0Fwg>
    <xmx:OvSwaVQ555w1mKx5Bcnu9fBiHVFoAYTAnlN6YUadSv-k-qJrQZYaBg>
    <xmx:OvSwaZv_lMzvPSnKWhtG7I7gqPr8MZhawQye3TB4A0paOZ86WqPojQ>
    <xmx:O_SwafYNZ9dKCh-BvAlmFpFfMJI-sDQldCAq6csRjHmujZHXBzeAW_GD>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98E3A2CE0072; Wed, 11 Mar 2026 00:48:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX21AeLsmHX3
Date: Tue, 10 Mar 2026 21:48:36 -0700
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: "Johannes Sixt" <j6t@kdbg.org>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Birger Skogeng Pedersen" <birger.sp@gmail.com>,
 "Pratyush Yadav" <me@yadavpratyush.com>,
 "Marc Branchaud" <marcnarc@xiplink.com>, git@vger.kernel.org
Message-Id: <876fd32d-3965-4587-b567-399787741247@app.fastmail.com>
In-Reply-To: <40ccd060-e6f7-4130-a25e-3c2f65df8eb7@kdbg.org>
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
 <e17f094f-f869-4cc9-b59c-091b7e61a021@kdbg.org> <xmqqms0jti24.fsf@gitster.g>
 <40ccd060-e6f7-4130-a25e-3c2f65df8eb7@kdbg.org>
Subject: Re: [PATCH 0/4] run auto maintenance in git-gui
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Mar 7, 2026, at 2:37 PM, Johannes Sixt wrote:
> Am 07.03.26 um 23:01 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>> So, users that are hurt by this new change are those where all these
>>> conditions are true:
>>> ...
>>> How many could this be? Not many, I guess. The conservative safe
>>> approach would be to treat gui.gcwarning=false as an indication that
>>> automatic cleanup is not desired.
>
> The option does not only control whether or not a warning appears, but
> also whether garbage collection happens or not. When it is set to false,
> then in addition to squelching the warning, garbage collection does
> *not* happen. The option is on by default, so if we find it off, the
> user must have set it explicitly, a clear sign (IMO) that Git GUI should
> not do the garbage collection.

I see your point about not garbage-collecting for people who haven't
been expecting it, but on the other hand, checking `gui.gcwarning`
would not help the people who were achieving the same result by
clicking "No" every time.

However, it seems to me that the conditions you outlined are very
unlikely. In particular:

> - They configure maintenance.* to do more cleanups than the default
> confituration (which is the same as `git gc --auto`, I think).
>
> - They never use `git maintenance run` through some other facility.

Are these not more or less mutually exclusive? Why would someone set
up maintenance to do things, and then never run maintenance?

Given the above, I see two options:

1. Assume that in practice everybody wants auto maintenance and
   `gui.gcwarning` is set because they were annoyed by the dialog.
2. Assume that some people do *not* want auto maintenance, and if the
   `gui.gcmaintenance` option is unset then show some kind of dialog
   that tries to explain the situation to the user and encourages them
   to set `gui.gcmaintenance=auto`.

#2 is the safer option, but is rather complicated and involves
bothering every user for the sake of strict compatibility. I assume
that git core itself had to make a similar tradeoff when deciding to
enable automatic garbage collection, but I don't know where I'd find
that discussion and perhaps it's far enough in the past that the
rationales are no longer relevant anyway.
