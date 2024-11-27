Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284EA1DFDE
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715167; cv=none; b=BjWrCD6g8T+y2X1/tgbgNyse/qyFE5K7E3jEEqQm2RtNzL4T/l9+YqfiQ3ZAkxPHYv+ARHX8aEqIVGf0FwfYoeTJ1D2Re8AItHE9EfPELILlPsPfvZJxr/3WDUypIAQyRMV6kwja4ZgjHkbdfRGmigbUUG6NYzsM5uBz25AlWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715167; c=relaxed/simple;
	bh=//KMp1IIXvp/otl4KyXciPcPCHDKNcvi9xp8WvupDfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QpZ19OGlgY87hnOGI6dLwMYb8nVsspG3kk8csDvCyGyfKhRmt4AmQ3wIPy+m6XuG7SLz9rNtmTD9MLf111mJWZh2ZGrRizLebN18jrjmqxF83Ud/1G4T2p/df8DtD6TOAS7eGH+I37dRWsx070YnBTywDHeSZd4+1n256I45kE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=57OGtyHZ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="57OGtyHZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id ECDD911400EE;
	Wed, 27 Nov 2024 08:46:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 27 Nov 2024 08:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732715163; x=1732801563; bh=M9ZONQ565BSNOVpfwoQXIaGbOT9VigrjrFZ
	2V3ucce0=; b=57OGtyHZtslerfBZeyNu7rfEOe29YNff3+yfCpjk2RnRImqgEHx
	RqafztRzVqZ5OFxM4JwgPveN8PZZvbzNMxJtU2HCrXMkTbqcej7fa1MhZw1LegMZ
	LBr07BEYns27acCtCNou5bIIjE6HBjQhcz+W0cH2xb92ma5jBp+MEbVMD0DKoftd
	vcCCs9hyCdrZ3cNLxRlnXI/09cvzp5pTm+vDIdPR5UY0tlFUSJ0355HviInkx8r5
	F/d/2o42ST0Y9e4gikc3zrKPt4G7q3eCIw9xr2gOG4sRpobMOjkhqceRh1Qg/rB/
	wAwr9X4v/+BkEk814gEZFGxLmv0y9sXdC5g==
X-ME-Sender: <xms:myJHZ43VWqRLour5BF-KvLOvZCgFxzJx0Y5285mCkP9UsHZcJhk2mg>
    <xme:myJHZzG3ewLpCw4BSoFjhunSNmBHX8MTQGOYIN6mZ3QRysFVQNJB_M0K0NLJ7RYTf
    KbUWP8XeGdUEz2h9A>
X-ME-Received: <xmr:myJHZw5ez4vBShe4FweTqhWwMD61xwU4LWXUnKGTcXomX2cCv4ZUkpE42lIewIoiampXciop1cIMy8AFpmBUtoO41QceBfiomF3YZC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:myJHZx0Ml_PN6fhn4Ckb8S9Wf570Z55RdIoR-JqNoQISiIjzTJXnfA>
    <xmx:myJHZ7H6Mfmg32-9ltwTWRN1VWhK3ZM7vE1MSTi-BoT4a0GlzFa_dA>
    <xmx:myJHZ69flRswUBGUgP98jmbI3a4eEt2ZbyX6tU-RCC-4HkT6pmLOyA>
    <xmx:myJHZwmJglx3Bc7Dm2dW0vjaLx4J6C1uNP2_xt6Veab9awduHgK3_Q>
    <xmx:myJHZyBuq4ExUjqiW7hqseGORk2PCfKV0nINcQdg__dzm-qmYUbj5jWc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 08:46:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v1] fetch: add configuration for set_head behaviour
In-Reply-To: <20241127091718.345541-1-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 27 Nov 2024 10:16:25 +0100")
References: <20241122123138.66960-1-bence@ferdinandy.com>
	<20241127091718.345541-1-bence@ferdinandy.com>
Date: Wed, 27 Nov 2024 22:46:01 +0900
Message-ID: <xmqqa5dku6w6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Introduce a new setting, remote.$remote.followRemoteHEAD with four
> options:
>
>     - "never": do not ever do anything, not even create
>     - "create": the current behaviour, now the default behaviour
>     - "warn": print a message if remote and local HEAD is different
>     - "always": silently update HEAD on every change

That seems to be plenty of choices to please many classes of users.

Except for the one that I would want to use myself, which is "I
understand their HEAD points at branch X right now; please warn when
they flip their HEAD to a different branch, but until then please do
nothing".  That's somewhere between "never" and "warn".

> @@ -1603,6 +1628,8 @@ static int set_head(const struct ref *remote_refs)
>  		string_list_append(&heads, strip_refshead(ref->name));
>  	}
>  
> +	if (follow_remote_head < 0)
> +		goto cleanup;

There is some "magical" value(s) that is/are negative; we will find
out what they are later.

> @@ -1614,6 +1641,7 @@ static int set_head(const struct ref *remote_refs)
>  	if (!head_name)
>  		goto cleanup;
>  	is_bare = is_bare_repository();
> +	create_only = follow_remote_head == 2 ? 0 : !is_bare;

There is one more "magical" value that follow_remote_head can take.

> @@ -1626,9 +1654,14 @@ static int set_head(const struct ref *remote_refs)
>  		result = 1;
>  		goto cleanup;
>  	}
> -	if (refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
> -					"fetch", NULL, !is_bare))
> +	was_detached = refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
> +					"fetch", &b_local_head, create_only);
> +	if (was_detached == -1) {
>  		result = 1;
> +		goto cleanup;
> +	}
> +	if (follow_remote_head == 1 && verbosity >= 0)

And there is one more.

> diff --git a/remote.c b/remote.c
> index 10104d11e3..5a768ddac2 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -514,6 +514,15 @@ static int handle_config(const char *key, const char *value,
>  	} else if (!strcmp(subkey, "serveroption")) {
>  		return parse_transport_option(key, value,
>  					      &remote->server_options);
> +	} else if (!strcmp(subkey, "followremotehead")) {
> +		if (!strcmp(value, "never"))
> +			remote->follow_remote_head = -1;
> +		else if (!strcmp(value, "create"))
> +			remote->follow_remote_head = 0;
> +		else if (!strcmp(value, "warn"))
> +			remote->follow_remote_head = 1;
> +		else if (!strcmp(value, "always"))
> +			remote->follow_remote_head = 2;

Use something like

	/* The setting for whether to update HEAD for the remote. */
	enum follow_remote_head {
		FOLLOW_REMOTE_NEVER = -1,
		FOLLOW_REMOTE_CREATE = 0,
		FOLLOW_REMOTE_WARN = 1,
		FOLLOW_REMOTE_ALWAYS = 2,
	};

or something?  I have no strong preference between "enum" and
"#define" myself, but moderately strong preference for anything
symbolic over magic numbers.

> diff --git a/remote.h b/remote.h
> index a7e5c4e07c..3ceadac820 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -107,6 +107,15 @@ struct remote {
>  	char *http_proxy_authmethod;
>  
>  	struct string_list server_options;
> +
> +	/*
> +	 * The setting for whether to update HEAD for the remote.
> +	 * -1 never update
> +	 * 0 create only (default)
> +	 * 1 warn on change
> +	 * 2 always update
> +	 */
> +	int follow_remote_head;
>  };

Other than that, looking good from a cursory read.

Thanks.
