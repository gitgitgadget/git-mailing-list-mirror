Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DB3C1F
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571455; cv=none; b=q0oaPoKiyWgSfStWgfDicGyJ/QhayRpbtjY6MSrYRaHW0iU5OCDqftnPu2i2ubDpNBrozKa5fGVLvVEctVLgg+2+Dtt+yRr7lHX1lY8FMOwooLZYlKflba3JYVr8VgXwNH9DJbFxPrXRMjTElRitQkcycv6ns53OicjF4wGQ+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571455; c=relaxed/simple;
	bh=vCYK1bntiUABnAC/iFz7rzMkbT0xpWHXdFAmFUL3UMk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TBscLL6GLT7xpYuLndFLJ+sHDROPnmb/QoJiXIZciEwJeaoHQHoVSDZaA3aRMJSrStVgI9G6ODOXYuYztjdybqWjhC4F89ghbC8YKbtpsMPTahv4VqrCEqtKRsEy7yxAzuZR9TIWIeafdnFKR6kuKg1TISvK/omd6H5y1Hq71Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=QvXvpmgM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ada9Ra0b; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="QvXvpmgM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ada9Ra0b"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A7707A0061;
	Sun,  8 Feb 2026 12:24:14 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 08 Feb 2026 12:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1770571454; x=1770657854; bh=JCC3NiFVMDkdbPn/8gBcvx8+gFmpx3cK
	FMFI1TRPX0Q=; b=QvXvpmgMeCam4hDlptJMVn/k1+YGX4Hg1jUYhYioNBoOZOtb
	a4Dlj0qdOTYmG1AWVFrktf/SbQrj+BbjPD0YtilZSjVpnsrWExUHMs9iDoN0OTYh
	JknJllfrTQywLDORoKhPQo8DGl51R6m7hw7FENFZDt36XcAomxDlwQo/xVL4K1wA
	ywGkCHwi/NLQhnNU+Yl3qkESvQkA5A9CSzamC3pZbSIC9K8TDEbeCyCT1ezp7Xzz
	ws322hlUT/wCEdLD39OyTweNgoGYLUD+F7Bo7JErau4fgUtyS/sXoYbWe24kBQJr
	peKz0aRdI+bO9CeTItUExsykEVJE19EYHXA2FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770571454; x=
	1770657854; bh=JCC3NiFVMDkdbPn/8gBcvx8+gFmpx3cKFMFI1TRPX0Q=; b=a
	da9Ra0btudasXGC3PtQdnI1zOOUEsRjZ9OgbXMeWU9w30ZGeOwMNbe/z2zZ8OIQ6
	IoMXBcyjUiLvHW5+87WPslSaq1OOHU4omMPLwQ709HZWLE4Q+0ESnU3sSE8l4g49
	FrGus25Uvo5EMsnio7ViurKFMsLEo9mII3MtGqzovkDlERpZD2IJ8qslGELw3pr+
	MZpPAEWdPVx1uYmUv2PEczZeIzpWR53MixsT7TnibPr1+STTT8gCBtfFkBbONvj3
	pkjBFsPGDmm2pGzKQxl0KCGnv2HnCZMx8DXCvAyQf/c3fBZ8LYg+ncKhWXG+xy4b
	Q/yzT/F7mmRHRLQMNJ9XA==
X-ME-Sender: <xms:vcaIabVxfIVO7ZjWucSVMw95-GPaKtoqwokCuKYTt0nLTC5Yp0Db94I>
    <xme:vcaIaebbj0jmKYTb_EWOiOm1jBj0I7mSwrArsCcqwV0DsXO1V_LFnDMqXIa_YdAwi
    4D7bdntyvZNMYPDhER1POCjxJpWxbq6GUwXvbBO6O4eWkwAg_aI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeghedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepteekfeduhefhleefgfeuiedvleelvdejgedu
    jefgheejtddtveelgfelkeeiveevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegs
    vghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vcaIaY_ccKlNPRtmpGDzpL-Kw_W47D_zqH2OYMne5nbFITPPFEwysw>
    <xmx:vcaIaehwKroMreoRPJioftKThTZGE-8p555QBoB38_s-i12Z-St9fg>
    <xmx:vcaIaYe4o1hHV7s6_n_qrzMz7Qe0tJE4UEOxQGeyCcVZCQTc1V9g0g>
    <xmx:vcaIaVopiVISVkL1TyxgMy09xDahHRwvia-qqxxoTRzcIPW76i7YnA>
    <xmx:vsaIaTydDGFlZ0J6ckixzdHBHfpVaXbBwsIVv0a_aUmJOnDl2myhUHxM>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7F5761EA006C; Sun,  8 Feb 2026 12:24:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJNz-x6AxkCZ
Date: Sun, 08 Feb 2026 18:23:53 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <80e4c515-025c-4b10-8405-4363f562f37a@app.fastmail.com>
In-Reply-To: 
 <CALnO6CC997noiLAFmsy=4DCxc-d5CzaJew0Ri1x6CUtnL4kLXA@mail.gmail.com>
References: <CV_doc_patch-id_4.275@msgid.xyz> <mapper_example.277@msgid.xyz>
 <CALnO6CC997noiLAFmsy=4DCxc-d5CzaJew0Ri1x6CUtnL4kLXA@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: patch-id: add script example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Feb 8, 2026, at 03:34, D. Ben Knoble wrote:
>>[snip]
>> +#!/bin/sh
>> +
>> +upstream="$1"
>> +branch="$2"
>> +test -z "$branch" && branch=HEAD
>> +limit="$3"
>> +if test -n "$limit"
>> +then
>> +    tail_opts="$limit".."$upstream"
>> +else
>> +    since=$(git log --format=%aI "$upstream".."$branch" | tail -1)
>> +    tail_opts=--since="$since"' '"$upstream"
>> +fi
>> +for_branch=$(mktemp)
>> +for_upstream=$(mktemp)
>
> Do we want to delete these when we are done (via trap or just cleanup
> at the end)?

Sounds good. Maybe just at the end since this is a happy-path example
script. ;) (not very robust and all that)

>
>[snip]
