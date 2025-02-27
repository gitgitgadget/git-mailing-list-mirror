Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD41AF0C9;
	Thu, 27 Feb 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689759; cv=none; b=Ch6nkkG96lpfY9i7IUrCs7TF35N3NXtTDAd5v/W7taIeexP9YbQa+yMqiFdAZOwoYhD4cRYI9EIz3oz6IUL75GH6mrl9xCs/Bn7XduCBexvgVGqt3XR8ETcSnqh2YOIY7D8gT11mtiaSXB/yHWoqKCjM+pC/DOJI3qwmxlNXTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689759; c=relaxed/simple;
	bh=F/i/isJ6O2bGeyBqx6CHsiqDYU0svHd0SD4mP0ZIFLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vz3JBkGjfV1ntM5pE8RQI/be7W+aZ5JmKsmDrIn+ddOMGpkhe3fOspFr3h9NLrJWkebYYEo1hsyDfx8xktCDP8geXcQVHbL+ockcC+BFwZD121tRKbaViWLVO0pKuDecWkl//0ZEfhRJBkN4npiGKa7XxHAW26vtHuD28Ze6mQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KKsjRBXz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nn4gtP3/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KKsjRBXz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nn4gtP3/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F3CD425401CA;
	Thu, 27 Feb 2025 15:55:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 27 Feb 2025 15:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740689755; x=1740776155; bh=6/UIZ1sw3J
	8SGxSjdI7WfUROI/5uL6NXwzjBHBjt9bs=; b=KKsjRBXz5elLkRwBK+40mtr59I
	OsL6a8h4ChPAFxWs3rQIjzHXgzxcgBNpzS95M1tZfp3rAO9pir7Te4YSwAB3po8C
	yhdBPa79yry02XhohtbIYx0KGpAtNUoImeVPiCL+KmuC0nff5FwL7bbCmT2ZItRZ
	plu9onEhA11rtIg1uqaiN1o9GFmJzWbCbf3gREGhYCMSIVmI/Op3XrUNeMTRlW5x
	VyWCNPprRovQ4XmcSHi/gUfbXcS59eipXHEolcSoHOs/a1YxpBiWVxVihIn8HwTH
	C7khfiXjpbHNliVAfgqg0UChjRb9nZLtIptXAT5vs/LijufSFEM8KcRrD5bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740689755; x=1740776155; bh=6/UIZ1sw3J8SGxSjdI7WfUROI/5uL6NXwzj
	BHBjt9bs=; b=Nn4gtP3/BLE9sWUJQ7INEGRwDESOxjnhCymy2UXbaJiAVzguqlD
	LPxPTabfnkwkvA3EMt5ZYLeOpEEVbLM5YFxxhCwKvMbt9CxiwcgcNyqya1MifcLc
	Whx8pOP0fMoVgoOnCz+9hLJ/hYn4xL+qOsoITmffEu9RolV303CQGmtlVfeGPknv
	AgQ446svISx1ud75WNRdUtnDINvRczp4bt26B+SWwxH826rpwh57zAOEuwIKDWPh
	y24fyNobg8kbascnhYRs4LZRj26yaEtOPmQMcA7g0+Eh/TSnhRdoZVWO8ilodf63
	XXi4ShjtTGfz0chi71WtOz1AEF8cam1ILrg==
X-ME-Sender: <xms:W9HAZ--3jVvlNWvr-ppRYXSaU5RT0XQg3mB1lmEjq89wY4PoIKq_Gw>
    <xme:W9HAZ-sm4mgGZVqzIxhm6q5jLdA8LOGIhunkLr4SogIXFRIQBIYs-UGkqSe2AKTCT
    ALxvfB5EoVMSZwdsg>
X-ME-Received: <xmr:W9HAZ0AMRnlODzAWQA7so3fwOrQnUSP8_FGQm7-ALKK2P8X29OAqRzf_bj1D_UYW5EM69mzanuVGuT8SJG23SIUm9aAMTQPI032U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrh
    esnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvghrshesghhoohhglhgv
    ghhrohhuphhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:W9HAZ2cjuKHNEanUUpnYWlNzsVzKrSHatXxLN6koM8ZSaSM2b_x7PQ>
    <xmx:W9HAZzNhbXyJ2oBTwVWLci-o6XAKKT95m43Btxi2HtrxaDY1U-5O7A>
    <xmx:W9HAZwnR0JXQN6KUkH09FZ8OesWwbxAcjzBdrUUw3N5HWHyZp45AWA>
    <xmx:W9HAZ1uooFoGU8UDmx2bJOopjA5Gt_7tJt5QbcUcdgh1k2uEczmsBA>
    <xmx:W9HAZ-3nIdGIwqvFq5ymyoup_dlc_N1ltPlaQ5U20pRcPqlqSsCvjnca>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 15:55:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>,  "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
  <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git v2.49.0-rc0
In-Reply-To: <028c01db8949$ce664b70$6b32e250$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Thu, 27 Feb 2025 13:59:56
	-0500")
References: <xmqqzfi8bljk.fsf@gitster.g>
	<028c01db8949$ce664b70$6b32e250$@nexbridge.com>
Date: Thu, 27 Feb 2025 12:55:53 -0800
Message-ID: <xmqq7c5b6rae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On February 26, 2025 1:37 PM, Junio C Hamano wrote:
>>An early preview release Git v2.49.0-rc0 is now available for testing at the usual
>>places.  It is comprised of 326 non-merge commits since v2.48.0, contributed by 65
>>people, 15 of which are new faces [*].
>
> Looks good on NonStop x86. Built/tested with OpenSSL 3.4 and 3.0. We might build with 3.5 if it comes out in the 2.49.0 cycle.
>
> Thanks,
> Randall

Thanks.
