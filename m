Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B219E97F
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770343156; cv=none; b=T+jPjHoT3FKEBloJE0lP1vRUfus88vZJ3mb9fLPAFS/Fg8KVIqwWA2aM+sh2z8FxKFUZTcnklv9hMSAuB6IWrNJwzzpkurz8YXsqpsN9XGMHdTBFW4RxOm7wb7yOIKvBWah+Y3Ff+Is3gFQnvRarTPt5aINtS7Psa9k9QJq7Qro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770343156; c=relaxed/simple;
	bh=wr3KLU8s7QCLNv7zWVZCgWbQNMpjObT8KjOxNV1DeGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bxDAb6X9Oc2dQWC4oVCShyYMAZK3c8UT3cD7V03no5y5vhTW8NjeTJayWvc3tGA2j+gEXC/GyBh1SV5OCEl51EnVBuWd/J59kWVSm/5qg0WOH1kcSI8PIplQSXBvOop7FtAHnA3MlBW337hFD+wD7moxor+T0ich4h01W8Oaqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B8u7TfMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKhgiNao; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B8u7TfMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKhgiNao"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 46042EC056C;
	Thu,  5 Feb 2026 20:59:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Feb 2026 20:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770343155; x=1770429555; bh=Vje2QAB9VG
	957/uO8/vWNp3dEXHiMEB07w9mz+EMC7g=; b=B8u7TfMnY1AJ6XkVbNVA66o4JZ
	zzp03zIFCD/5VNcxY3SAM4R/yA0W8EVMYP6VVCihKJDurRbh4V5XKScnZZxe7xxu
	aAjH/iQOnbl8vmeGDiisBv4K1/KqFQYI9JjqgdNgfIt5eeB2ZWJH1Jt5cGNQMuxK
	rGpIXcRAx8MbvVx3LPK6LU6S0WJfLnOcsIDhaoP8DeZ2i8GFNKVTfgqRbXAOjmHN
	TcEvTaVJR6VOM5ukEV00ztlHqOuoUBtiQlX3BuB+oSpMpdTgJQWp7Mqw0IyvNOaC
	5o17A6SMhh2kQQsP912wSscsvttv38EjlbVF0V62dcQSpTr/l6fHQ/zAdzYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770343155; x=1770429555; bh=Vje2QAB9VG957/uO8/vWNp3dEXHiMEB07w9
	mz+EMC7g=; b=MKhgiNaoaP45N7tOyeWGOVeMEGk5AuAGrnHvSuhjEKQrQ+LiwKv
	Jk9MNuzfeh5EF4LMx57tlx0M+zS8J4/fmuuoTUoa6lejKTY376cDO56iijSJD0A6
	ZA4cbaxMFgLD6EioI9vZ4NByHmuilKqm4R++5dYSa53EX5E+yHQeq/R1BfwCMOzD
	7yTCEXRgNiDE1VnsS8/MOkCNZb4zmA/gkkacsXYk1lsYaxl1JwJcGiu2xl6sU8p1
	Si+BaLYRVwicwCC/6tfk+vchqqxILa/oKpN4wIVt61qkhJ2IcpXgdP6ZQGv/Svd0
	zFlvT/M3TPkSW2BY16pGA+5HaIazHPZOdTQ==
X-ME-Sender: <xms:80qFacvGfcG9Z7sbhnESMe1Lxy9NJ4IFM2GrkWCBMzTS5SD0jERxGw>
    <xme:80qFaQfHehOu8Ak4Uzgzf1luYeiEqCaqoRuWwI5y5CltnkHAf-y0hYJVLADZCD6l8
    0AsKD29OxSsENxiqGpbtOyoyCbw0Hh9l5CgbVQt-oS1upWO61Zn71o>
X-ME-Received: <xmr:80qFacwVdZRY1RUUOB9Q9YBjobFLWc4agMXoOEVJ40ufpqUQzgUsr0jp3OUrEaZtEmCX-6vwojWDpjFwA_VLxZqNeECDlBxp3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeiledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:80qFaeGdn0Aip4HRas_LOAXXZCGPt_T8k6hb2vcfNqbuiljn20XEww>
    <xmx:80qFaYyUe0I3W8-ZTcHk2ZHLllnu1JR0SwsX6MLkzzcPlbzYRJBS_A>
    <xmx:80qFaXtVuv2POckl_q-ZfUqCVuzsfXeCVqbOpnebcGYFYZ9vCi0HIA>
    <xmx:80qFad36cXAMzQpX5DLQgymLzCnL3Fnitq9th6SrolJ96SNJutH4VQ>
    <xmx:80qFaYtBVd1fAeCxPUVTfk740QNU-G1LgM845zSmC-pMPU4kobdaX4hs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 20:59:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] gpg-interface: remove an unnecessary NULL
 initialization
In-Reply-To: <8d188ce1b8994f0108b49a4cad8af425b09504fd.1770342268.git.collin.funk1@gmail.com>
	(Collin Funk's message of "Thu, 5 Feb 2026 17:46:10 -0800")
References: <a53fd33b5696487f941faace90f51153555ce8f4.1770342268.git.collin.funk1@gmail.com>
	<8d188ce1b8994f0108b49a4cad8af425b09504fd.1770342268.git.collin.funk1@gmail.com>
Date: Thu, 05 Feb 2026 17:59:13 -0800
Message-ID: <xmqq343ek4y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> We assign this variable unconditionally, so we do not need to assign it
> to NULL where it is declared.

The latter "assign" is better phrased as "initialize", but other
than that this looks great.

Thanks.


>
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  gpg-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 377c0cf49f..87fb6605fb 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -398,7 +398,7 @@ static void parse_ssh_output(struct signature_check *sigc)
>  {
>  	const char *line, *principal, *search;
>  	char *to_free;
> -	const char *key = NULL;
> +	const char *key;
>  
>  	/*
>  	 * ssh-keygen output should be:
