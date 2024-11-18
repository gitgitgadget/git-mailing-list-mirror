Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E99E4A35
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892053; cv=none; b=sI/QocdqoMVcDKD7300gYd67J9FPW8a3X7ZMGc4YxjbkQFEHfwhbmd9zUri8++UlfeFhUBc7Gak3yKklHo8fQlvMjJqBuPw3vu1iACr3CoWPcChiVDszbWs15ZHYv6VeTOvBmQdLhF9ToszleZTOCL0vU263P4Xk/7Ar0XAeAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892053; c=relaxed/simple;
	bh=9GGRXUbmPmKcqp+YAjDFEzq/7kvkn6BzxZDFSEpcC5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZdKjVa5kowS02QwRz4zqWIPUqN8BVk08807UdWiD82yLsUhTgh14sC3+0X9RatL7gP9tkjXu0OwXifm69wDEPhpUIPqEf0tPw73jwjRYhszpetp2WY6aSdiGr0awBFQgEjctquaOcFUFJWQE5s5W7yL8JGOnx6Qy1ydm4hvZKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gTHIV7ss; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gTHIV7ss"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03A6725400EE;
	Sun, 17 Nov 2024 20:07:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 17 Nov 2024 20:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731892049; x=1731978449; bh=Z3Sckg1mXJduZoPG9Iw11XnW2YJSTtBF9x/
	V7+eGTlE=; b=gTHIV7ssOFPXfLNILH4DejUU1B5nG4UQY1flwi+3Lm8Kzdui7TC
	KE6QO1zLA5pvZuDNZYDZ9ukLku2NkEcC1NjaJTa47UvA3nMBduyTRQNvWUQB5Moc
	NiKNAwaSH5GtLfXad3n/YUD+N7eCj/XZrmk67P2pKqzVe0d7wsj2wR5a4VVvhFuS
	sFfzBvRsMBVuUrC3oyk0vgka5Ih98UeaMzdm+FUq/wuqvF6GgRhGEpRcMekb6pwD
	1r4OCXy9ccj7lh8z647UwvCON29pSyUr2EUvSyXLU1JjsZorRbyq9AYUiXmxiQjr
	B1Ptphsdff9N40nXQv8U9Pc/4I93Jp9x0OQ==
X-ME-Sender: <xms:UZM6Z1JK7GGG126hKSUt8F2n50ILoRFOlFcMaFyVKRyiIk9pOD99vw>
    <xme:UZM6ZxJt7-N9LhxTeYm7cr6Wcz8togqSgylT_Yykq-GNi-kxZmXCPlSpLFRy_xDSn
    By54Q_GUiaJvoGFew>
X-ME-Received: <xmr:UZM6Z9v050jEvmfcoMjAa-Zo0uTJUL9A2tahkeKFodohC72TQ6FbQnI8QSWnBZhusmnSdomPGaykGMF9pk6hyf8YTOsLzFT9bA_3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepfhhfjhhlrggsohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:UZM6Z2Zvh1k1zTATyVB6fTqmuinAHxRrdy7ldE9QuvM3wP4wywNwzA>
    <xmx:UZM6Z8bWCy_pI1O9AqCZw6Mn2UZHvZZQNLh4CEtzsjHE_3FdzEK1bg>
    <xmx:UZM6Z6Dybt7GQ9f2dI3n4ETdFoSIz11RCaf7xEO3hdAyLyutGqZU6A>
    <xmx:UZM6Z6afVkHox-i-zP1gQHxbO6v81YLCGaq0GRVMRlagSWuGaULdDw>
    <xmx:UZM6Z7yjVtVvQkXiC-13Jga9fRq_BEp3ubxkQ5WB1nY0XblfuuwIu9_6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Nov 2024 20:07:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  =?utf-8?B?44G144GY44KS?=
 <ffjlabo@gmail.com>,
  git@vger.kernel.org
Subject: Re: Trailers Containing Underscore or Dot Characters
In-Reply-To: <Zzb7aI2C2uh_nwuc@pks.im> (Patrick Steinhardt's message of "Fri,
	15 Nov 2024 08:42:37 +0100")
References: <CABpqQ_u4GG28L9KGX+HXiOv2AVAL7sckRBN4a99pCyeaQS+n_w@mail.gmail.com>
	<CAP8UFD0_+=5xmw6y5qiO22KMZhExLyZ=5HRjYphLD66vt0LLNg@mail.gmail.com>
	<xmqqa5e2ahqf.fsf@gitster.g> <Zzb7aI2C2uh_nwuc@pks.im>
Date: Mon, 18 Nov 2024 10:07:27 +0900
Message-ID: <xmqqy11hjqnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The second thing we should be fixing is that git-interpret-trailers(1)
> allows us to add invalid trailers:
>
>     $ touch file
>     $ git interpret-trailers --in-place file --trailer 'Valid-trailer: bar'
>     $ git interpret-trailers --parse file
>     Valid-trailer: bar
>     $ git interpret-trailers --in-place file --trailer 'Invalid_trailer: bar'
>     $ git interpret-trailers --parse file
>     $ cat file
>
>     Valid-trailer: bar
>     Invalid_trailer: bar:
>
> After the second invocation of git-interpret-trailers(1) it is unable to
> find any trailers anymore due to the bogus format of the second trailer
> line.

A good point.
Thanks.
