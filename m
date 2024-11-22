Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BF18EB1
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239042; cv=none; b=Uw66Gfdrtc64OrZCTllD+UF0f0QeoXzdBQNq/YT8TdP8NFft8ON/OGnbUn/6GamMVwdsEFF69t1JW6ZhVO9z6HXFlAWzLroxsPRU5zdag2pItEUCxWQruaKnZMrsviOvPt3kvTuezoTYVnrhvYcuul+FzE4Zlcp4MHpKbn2OzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239042; c=relaxed/simple;
	bh=W+Df5bWhuRQZ3dEFX50greVJO7jPdtAqloeHeArsaxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1m+tj69JkFFtXTKdLq5VaCZSgGra7bbMFmQkD7R0dltlUCqku7i/sQ0DoPlq5RF8dg5T272eRSwDLCnR3l0Abkm6dJ1qmUeiEy2PJwvRmQ5ZFiMoVeES1cBv72Ep2pD04I6h848rhau5pMgf99kcnFTTVeHN25gNKm6whWOJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1nKGH8OQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1nKGH8OQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C69B81140138;
	Thu, 21 Nov 2024 20:30:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 21 Nov 2024 20:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732239038; x=1732325438; bh=KLtHGusNii683enLHoS9xwauLwDzhP0RPg4
	oCYbqnWw=; b=1nKGH8OQaYyj6oNv44TDKrezeP1hWlflHeOdcfbASQMEztLORLa
	o2rfQ9we5rZvd2hufwi+mM1Mj5CGQNXzLsFdgYDb0HLs5ZPll+vsBpGAz+h0MYux
	j6h4/gdOR+tHkLx53JYOOitKXP9LRchs7DSYgy+xZrwxKnJxIqp0A25mMCSc4+ZQ
	1LS3jHr/TZ/xGSzY4yhyaKnE5IAWMvMLo0+d0arRgPVVkfzfNDnCQqi38NdQu9Cg
	6l2hkHgjGE3rQg1ImwuCZZBF3q3wPy0pt12yVU49MJsORD7lI9TapMSrVTqvlejK
	wwtMrgE/M1GnW9bgoN28MWhD86g4S4ihQ9A==
X-ME-Sender: <xms:vt4_Z6FuVirdNkHWOGLe5KjRa6CkVs36dNTnGeYXKKoCBr-RnU-UVg>
    <xme:vt4_Z7Xck5Cxc60Zg12GYtiuWplJmB4NkfHTlxTD6VhHq9LpwjCwORNdwy5luNolL
    ve48BrFbQAD_w51mA>
X-ME-Received: <xmr:vt4_Z0Lve8vWM_6lEUulPlVNO4h3pYe3xqzF04uBkJWzYEo1Q-N_yDS19tFKYGqiEbYfMgwj7jr6LW7fDXTLgzUCUUgrfhmSy_Lb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vt4_Z0GXdQ60Jmgm9TS1wo8i_PKQ1iobcQ7ZSf-Bz42_REhFnP60YA>
    <xmx:vt4_ZwWRJdiQutBRS5dAq19E1PJ8v9ANVG0ZJeA15fYV_tE5ISP4lQ>
    <xmx:vt4_Z3PZy08iW6vdXUSEjAp3eHo-OkfQ644gH-e0-zTwzIK7jxTTkg>
    <xmx:vt4_Z315ysHhq2Pfe-njitVKrLlxcjYV-0YP78JffFQJCD0yq0AU6w>
    <xmx:vt4_Z3TanKVnIYQTt7DEBG_9AiPWkiD0Uxx4rAEbHqlFqh8hHY653kgd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 20:30:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] bundle: support fsck message configuration
In-Reply-To: <20241121204119.1440773-3-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 21 Nov 2024 14:41:16 -0600")
References: <20241121204119.1440773-1-jltobler@gmail.com>
	<20241121204119.1440773-3-jltobler@gmail.com>
Date: Fri, 22 Nov 2024 10:30:37 +0900
Message-ID: <xmqqttc0cawy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The git-index-pack(1) spawned during `unbundle()` can be optionally
> configured with `--fsck-objects` to perform fsck checks on the bundle.
> This does not propagate fsck message severity configuration though.
>
> Extend `verify_bundle_opts` to store this information and update
> `unbundle()` to configure the `--fsck-objects` option appropriately.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  bundle.c | 3 ++-
>  bundle.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/bundle.c b/bundle.c
> index db17f50ee0..97b70e2e51 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -646,7 +646,8 @@ int unbundle(struct repository *r, struct bundle_header *header, int bundle_fd,
>  		strvec_push(&ip.args, "--promisor=from-bundle");
>  
>  	if (opts.flags & VERIFY_BUNDLE_FSCK)
> -		strvec_push(&ip.args, "--fsck-objects");
> +		strvec_pushf(&ip.args, "--fsck-objects%s",
> +			     opts.fsck_msg_types ? opts.fsck_msg_types : "");

OK, having %s immediately after --option-name means that anybody who
is adding anything to fsck_msg_types is responsible for starting it
with an "=" equals sign, but that is in line with how existing code
does, e.g. receive-pack drives unpack-objcts/index-pack with the
"--strict%s" option with a potential value for fsck_msg_types).

> diff --git a/bundle.h b/bundle.h
> index bddf44c267..2a7b556f83 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -41,6 +41,7 @@ int verify_bundle(struct repository *r, struct bundle_header *header,
>  
>  struct verify_bundle_opts {
>  	enum verify_bundle_flags flags;
> +	const char *fsck_msg_types;
>  };
>  
>  /**
