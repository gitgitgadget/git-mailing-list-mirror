Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5C14B07E
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934202; cv=none; b=K0PbkluK5FCpbR3XGxsXYCXR3dXoeeyYoSXH3pDS+PysYLBGU+CyB8oEQBAzS8qAN9wEKKyrmKj3lv+I63oWR/D6uLw1VBp4ddVIp1cqXbTbgmwQKubCvIyrldtm7v1Eecn5DBtZxMpmPAVySXrOIzwBXHBsJLVcqAezS61STaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934202; c=relaxed/simple;
	bh=K3ybIxDVK1KP0MciO8CjjIDac2//9zuse6c84RBXug8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F+F8hLFuh9qhXuiAL2e9Fhepgm+wIs8wPcFth2WjbD2fWiUpXHX+zn78QPti5skpVLWI0B+tGdrAxg+nlX8aQ5K2nhIAmjX8a3l0eKGAbB0PsNF8aTOtgX4dlX/zhTxy0peLW6DYLad0rQd1nFxl9uIxBMUr9hU3b0xqA/C5pOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nSLRZvv3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSLRZvv3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64ACD11401C6;
	Mon, 18 Nov 2024 07:49:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 18 Nov 2024 07:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731934199; x=1732020599; bh=iKyBAxU7YqFJBAbzmdvDnQAl/ScFeFNl38M
	PPuxWtfg=; b=nSLRZvv3JL0ozgz2tmz+TmYp3K5XKtI7F3GiYc9lWGfBr9EDPbh
	a+X5876QhZnGJcMYzfaeFe1FDXurgwKMmfQqfh08NAgTK/o6/9VmshtFMIobZCzc
	Bw/YKlkE+XKaaNwleOpw7SMkLx7X4zFB2zECIB4+ASSza5zj1ACrU2ultoDw+Tkz
	QIu4jWGrs3qnjEKD45MZXrDK9U5gsAMyye9a6YEwMZX7JjrVpmFLXXKr59lNbGft
	NhMxkbFzW9VuL/yByb6ZQBuOv/NUf49KzK91QXE4bZdRh22VV0YwmS2PC1RlGs84
	fa26NRUaBSX7SZ+KHx/aDyKZngqF5oYgS2A==
X-ME-Sender: <xms:9zc7Z-mZDt24htbg9InryBcsb6bbJoH6yJZFj8MCyj_nAp6jidXsQA>
    <xme:9zc7Z136QHbQNIGVPEi2A5PcAEw4uOubXr8PHWSI1Xy041ubESfDbAukHkqSiDPbv
    97U44xupd7Ty5mFSw>
X-ME-Received: <xmr:9zc7Z8p_tiXXLcTHcipbzW_rSNNfyBuL7DTup8wIgm7TQPxnLBS2rP_syHrAaPsELtlajugAzrq2OIX1vaMjM_yOV41Vjr-gvDT5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghmsehgvghn
    thhoohdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    gthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:9zc7ZylRn0S8d1CaTdwvUyQ6roOKhWSvSEIkDd0Dbxb_0MLggP4XEA>
    <xmx:9zc7Z80o0PYEXHNAFagzo46skkJv4725kpAFitk4-hyyXKvKL3ULHg>
    <xmx:9zc7Z5spLP9G93UZqy2gzN6Efz-UrTeb7Q1rZMjLKw968HaQ3coydw>
    <xmx:9zc7Z4WKsIpwQDlwwD8jNvemM2P1TaGlDAGGNMrgnMpqRfCNkS6XQw>
    <xmx:9zc7Z9LujN9gh-dyTO8V0zzfppEOYWNh92D5cHR3xAL3-oUF76_jNyR4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 07:49:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Sam James <sam@gentoo.org>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Chris Torek <chris.torek@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/6] -Wunterminated-string-initialization warning +
 cleanups
In-Reply-To: <ZzscKHq6HN0pThV_@pks.im> (Patrick Steinhardt's message of "Mon,
	18 Nov 2024 11:51:20 +0100")
References: <87wmh2o9og.fsf@gentoo.org>
	<20241117090329.GA2341486@coredump.intra.peff.net>
	<20241118095423.GA3990835@coredump.intra.peff.net>
	<ZzscKHq6HN0pThV_@pks.im>
Date: Mon, 18 Nov 2024 21:49:57 +0900
Message-ID: <xmqqbjyck8p6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Nov 18, 2024 at 04:54:23AM -0500, Jeff King wrote:
>> > Here are some patches. The first one should fix the warning (but I don't
>> > have gcc-15 handy to test!). Please let me know if it works for you (and
>> > thank you for reporting).
>> 
>> And here's a minor re-roll from comments on the list. I was able to
>> reproduce and test myself this time; the patch indeed fixes the problem.
>
> Thanks, this version looks good to me!

Thanks, both.  Queued.
