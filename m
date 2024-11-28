Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A57433B1
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732764349; cv=none; b=nOr3kMunpET1QGRVanFYI+my/PRerMvEbHeI6C6O+pRLVlEwenEqrqpCFvV2WVD+2GhOm3VWH9MmfRocxkQGY1gJr6LKR54ARnVge4ltUmdSeZ8r4dhPh0Udwo3Hmi8yFpnBBSSwwna0g1j+QPACTI7exXBc4xxbQYnSllRqk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732764349; c=relaxed/simple;
	bh=1FUz0iL8mKXK+zBuggQuP7KjXCHuRGgGVK17tSnvvWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahdcLVW2igmTvJLLug10kfmSt583dk9sXlalYqrWVR1QPwU/Ageb+HI4L0Xj4cAcDk0hpI8GB3x82EumfeXYCx+E+ZJe8Jnm42DvP5wbbSp2Kpi92HpX/31r0b9nz3y/7AGmJoHZn2empDDrLUKcs27E82z+Im/piCOEF8ILdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2pWzMhh; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2pWzMhh"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FF8225401B8;
	Wed, 27 Nov 2024 22:25:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 27 Nov 2024 22:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732764346; x=1732850746; bh=Qc6C+Y6yNL0jeGkzYOs356hbuRs9Sz2hgvc
	7lv2BeFA=; b=O2pWzMhhG84+iebS6BS8Q9SsQpOqPT68gjC5N3gJ4JtmyRl82cC
	1OwgSy5aQb47GC1F3umz+ygGKyjcmwIgzUzgqH0WAFoFRDqwLIuzyE78JQrrK+De
	hBhtKTjaRDjLlsj9KKn/i1PiSseDOPLqa+yYJMdbKa+AT9dbU3LTH1J1qWGVRBmk
	k3t9db7sZjznrZWmUzyX/Pqasc6/bkNVamiu0J+8TvZG+1b0pXknKbjo0iYkRaqK
	O6ONpIkSWYGtrPrCXUWNIqZvzScRDbjo+SLUHl3f2CpVULMcYrxfDOhmNN1KAzeg
	CDmbqjrVYt4ZGKLi4XS2xeZh2DEVucu5HZg==
X-ME-Sender: <xms:ueJHZ0zhNi-WfVH-Bv2XJ3drlIjqQAIf8fR14VupfIHrZs6GorFGUQ>
    <xme:ueJHZ4RRzkrMHRVgEgEfpdc70oMTl6Ga15EZq6y2F_p1danVvCDh9sV_HlJom4XFM
    vhpG_jpz2KRvuexHg>
X-ME-Received: <xmr:ueJHZ2WlJcyBMD8ofrewTDqCbA7GC39ZiuOljTC5AP-QvYuPXOPrDfGVtJ1WiiDnr_11fNjBGruyDC763ekPDdh7aI7SlRZCKjFzrQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdehkecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:ueJHZyiWnxJlH7xbliRdbK5ecTO1Hh35ZjkWoPoRztRgm4hHN-kuIg>
    <xmx:uuJHZ2Cj_qcPrBRG_z5W02q421Kdo2GlTjlj3rCIYhrx_83RL6xEBA>
    <xmx:uuJHZzJsmqsj_cDzJ2MDuMf7Y_S3R87S6KIvICuRUnzgTHV-9e1ksQ>
    <xmx:uuJHZ9COqlq20QhKJvKvxVXi8_FuWhEbYmoV6sTHW8oZxn8aPtc9dg>
    <xmx:uuJHZxNm_Z6wYUxbWS_mTKfFQN0C0K8Wec3oG8NvKRf0LqCfIpRJ0_4A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 22:25:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] fetch-pack: split out fsck config parsing
In-Reply-To: <20241127233312.27710-4-jltobler@gmail.com> (Justin Tobler's
	message of "Wed, 27 Nov 2024 17:33:11 -0600")
References: <20241127005707.319881-1-jltobler@gmail.com>
	<20241127233312.27710-1-jltobler@gmail.com>
	<20241127233312.27710-4-jltobler@gmail.com>
Date: Thu, 28 Nov 2024 12:25:44 +0900
Message-ID: <xmqqed2wox8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> For `fetch_pack_fsck_config()` to discern between errors and unhandled
> config variables, the return code when `git_config_path()` errors is
> changed to a different value also indicating success. This frees up the
> previous return code to now indicate the provided config variable
> was unhandled. The behavior remains functionally the same.

> @@ -1866,9 +1866,9 @@ static int fetch_pack_config_cb(const char *var, const char *value,
>  		char *path ;
>  
>  		if (git_config_pathname(&path, var, value))
> -			return 1;
> +			return 0;

So, after getting complaint about a misconfiguration, the caller
used to be able to, if they wanted to, tell two cases apart: a
misconfigured variable was ignored here, and we happily parsed the
configuration.  Now they no longer can tell them apart, because we
return 0 for both cases.

> -		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
> -			fsck_msg_types.len ? ',' : '=', path);
> +		strbuf_addf(msg_types, "%cskiplist=%s",
> +			msg_types->len ? ',' : '=', path);
>  		free(path);
>  		return 0;
>  	}
> @@ -1877,14 +1877,24 @@ static int fetch_pack_config_cb(const char *var, const char *value,
>  		if (!value)
>  			return config_error_nonbool(var);
>  		if (is_valid_msg_type(msg_id, value))
> -			strbuf_addf(&fsck_msg_types, "%c%s=%s",
> -				fsck_msg_types.len ? ',' : '=', msg_id, value);
> +			strbuf_addf(msg_types, "%c%s=%s",
> +				msg_types->len ? ',' : '=', msg_id, value);
>  		else
>  			warning("Skipping unknown msg id '%s'", msg_id);
>  		return 0;
>  	}
>  
> -	return git_default_config(var, value, ctx, cb);
> +	return 1;
> +}

And a 1 is returned to signal a "we didn't see what we care about".

> +static int fetch_pack_config_cb(const char *var, const char *value,
> +				const struct config_context *ctx, void *cb)
> +{
> +	int ret = fetch_pack_fsck_config(var, value, &fsck_msg_types);
> +	if (ret > 0)
> +		return git_default_config(var, value, ctx, cb);
> +
> +	return ret;
>  }

And we catch that 1 and ask git_default_config() to use what we
didn't use.

OK.  If I were doing this patch, I would probably have chosen not to
change the value used to signal "a misconfiguration but that is not
too serious so we'll ignore after warning", picked another and new
value, like 2, to signal "the key is not something we care about",
which would mean fetch_pack_config_cb() would call "default" only
when it sees 2.  But with the current callers, and with the callers
after this series, it is not necessary.  If we need to accomodate
other new callers later, we can make such an update then.

This step, together with other patches, are nicely done.

Will queue.  Thanks.
