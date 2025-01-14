Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75A20F094;
	Tue, 14 Jan 2025 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889093; cv=none; b=LYJNAd0uSuMMTWgbqtK2LHGKM8/lqYv/JrLTrBz2Kkuil+sTgx2bvQ9BcxADwH5ScXnB5olX/KcPBhm9IGfihi/k5pznZUQ90lrN0xklF3bXwxkQkpJ5OQUEqfIBkxDuWp1dCfjoKmPd/WzX/hZJS7rtmreF2og4Bcw5zCjbuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889093; c=relaxed/simple;
	bh=oxXvRfmDeHDHTsvvjzZokwSe7qaRD91WecrftNRpfZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1n6nNUg2aS3p29adqjJC+zHBT1kwyTKHaUfp/MBmep/EkrEeJJ1i0TuJOmNgx3VZCPqV+el9oIBMjOXqYGAK96vS2M4SEXSCeZSfgTl6IM9oCiss+y/X+jjy1lRYpm5FCYUp+M5luAQ9hzrHK/xrrFffPWaKgJ0KzHXDdrw79I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nx1CnSin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ede1uQzn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nx1CnSin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ede1uQzn"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 659E7138029B;
	Tue, 14 Jan 2025 16:11:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 14 Jan 2025 16:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736889090; x=1736975490; bh=i7njYwqVa+
	6+QOBrZoYdqbiB8ximbBk8rm9Ca/BIHb8=; b=nx1CnSinnaUO20G3W8Fed1o+Oq
	8LTAbN3GmcJcfe5zmg+/XgDBuYOpdtri4zOkarozjQGov02ehMQVPvEFphJxwm8+
	khhz0XWs/aJ9+//4fZ5/UKvxLi3rvZWZjpFuTWLjnRHvZyvPMKQvFqnndRGRfi1V
	u+4E2EJASF81xZAi/TUbph6AlxB/7KlBJ+W+qmCVUHCTEWbatGsVWCdaq4dGweCt
	+kCAxL0iG+OJlUdpR+oqtgduEX/6Vld9b268JrPcowigSueG8M8IrUxJuJg92kZz
	upB29Mo0UDwffovS1cV4t0n4FJCcc5/NXeBwvoHkyQOLSpxaDAfGkNtOFYkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736889090; x=1736975490; bh=i7njYwqVa+6+QOBrZoYdqbiB8ximbBk8rm9
	Ca/BIHb8=; b=Ede1uQznBEQNa8NpW4buY/qvMWpnTmBn7g8qASm08MQzoU3ZOed
	77JwOxN1HaAPEhRMf0FR9s9xRsK0GqRYkvndyBW5q4Woe1kUvwagg71EGrzRin0b
	QxNSQz7KxZfUknPOpOdZgBcRLp0DtDMJ5HfCZioIGh5JZOgs0CCNWQE0bZvuJDZy
	dNQh51rA5uBeC77CL0TCjoFlrL80sstd4uAqOc4YJxdq7+Lpmy/ADLQ4Doptr/TF
	P7EXtNdUrmcIx0v506L5EwXsGcz4BJHm2ZfOG8spxRhrq4SpVRLbo5mDAnuBhAjL
	YgAM5he8ugrD8Ch0TCzyV5F6ajwVK/o1eGw==
X-ME-Sender: <xms:AtOGZ1pi1hu84VOrS9swXq1Y_2vgvGtEF_dDQ7RAcexXWtDs654ROA>
    <xme:AtOGZ3rYknUbOyQ-TdGhCruLsBs-5CqHAAqSyZccz2W56WzFtXNAGLuG31UKwDwHS
    dGgm-9YZGe0F2f5PA>
X-ME-Received: <xmr:AtOGZyMg3FFTe_1nP816QgYVpcwJOx1r49Wgj8UNJ4fptA5A_shY8EIo1NzyjJBj0YJ7hAwkTQQF02WRreU9NgNysARWrM3zZUft>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvghrshesghho
    ohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:AtOGZw6NwN5_sVcCX6ejI8Dh-TDym5F5L_vRz4sjBvgH-U1xf8WoNQ>
    <xmx:AtOGZ05n4j-QUmquyzjgPg8wRAOxmb4y9OLkhPdROcPcW-tpjvLyEg>
    <xmx:AtOGZ4isBP0VhBuVpfBaUcI_fCFjmzaEh6dwtaK0pxW8wewU01hJDg>
    <xmx:AtOGZ243_V06BF5yVvKc-6NJajrGRD62bcx9-drirz1KjblpFMe8tg>
    <xmx:AtOGZ-TQHfrLyBum2-4aNFt795x_5S0jstQ_kcaYvzZ5Eb57EPWB4xJg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 16:11:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  Linux Kernel <linux-kernel@vger.kernel.org>,
  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.48.1 and friends
In-Reply-To: <4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de> (Johannes
	Schindelin's message of "Tue, 14 Jan 2025 19:44:14 +0100 (CET)")
References: <xmqq5xmh46oc.fsf@gitster.g>
	<4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de>
Date: Tue, 14 Jan 2025 13:11:28 -0800
Message-ID: <xmqq5xmh2j9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> my apologies, I only realized _now_ that I had forgotten to update
> `GIT-VERSION-GEN` in v2.47.2, it still has `DEF_VER=v2.47.1` (but all
> other mentioned tagged versions have a correct `GIT-VERSION-GEN`). I am
> very sorry about that.

Heh, mistakes happen.  You do not owe _me_ an apology.

I hope I did 2.48.1 right, so we should be OK ;-)
