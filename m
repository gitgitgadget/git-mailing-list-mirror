Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724132274B
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429834; cv=none; b=LfgIBrGPCT2ZUbnmKpOl3xNLbxu0JVh3QcqtgJRCuNQwYHzs08cK/LnuNkcpp6upXYD60Qs8pm9JY+RRxQuE4tomV+4h5PV1yPGA+2wJ3SmPyWuYmmvl6Od0TWb+4OZCIzTZE7kaxzKKJe12uUbB37U1RjqgoJPxryI9+snmft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429834; c=relaxed/simple;
	bh=i6f52aRA3s1hnSotXfysCKmd6WapTgE0wTg9TOTgDEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnhtxuWObm56wmJFHtplQpFUYOv42GxhSd1cmXC71Wspkgq+ZlouRUrJpuLRM3MSy0PeE6mCFe+MH/6jJnyotN4t+ohBw9pkGg+Hd2WwNKkpdKSL3HTqCeiQLx4TU1dJJNe3vCn203QmyUSDNJdkIC6tJbv+FLz0R86IkbtUXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SgWR2qSa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vnZHkFnR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SgWR2qSa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vnZHkFnR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B119514001EE;
	Thu,  6 Nov 2025 06:50:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 06 Nov 2025 06:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762429831; x=1762516231; bh=pq/BqtaCx6
	ZZSBDIrwOEms1ddSjNrC9QVPgGkSc4A+E=; b=SgWR2qSadKyG2EfqA78x1ZSuan
	BTeZThTlV7TDghqBcxjMrfoF/iGcjfYaUGwMmFrU+Z/f1/ZmTw6fil1FkSLcCsQd
	MVgD4dV04fMcYkzJVgjyHS9CUZAiTtFhxGQaWh2YTNNxfswxl7tgiszq+pjAe+NL
	YNNup6k0j83lPTTmcrFT4V8UVl4L2Rd7VwC8NewSjeZ2CrpZgCS0P/+ban3Hzewc
	LjD2Wq9ACMiFfIzi9LX9ffZJENY2TxZpPkBti3xUizxpaqIj6nCJ7tdMLzGYUJoy
	Epou8BYt+Ooo7pwWCERKbLXaPu9Z8GhUuviy8g40pzQ7aXeHl3/Bk8wMjF+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762429831; x=1762516231; bh=pq/BqtaCx6ZZSBDIrwOEms1ddSjNrC9QVPg
	GkSc4A+E=; b=vnZHkFnRi+pB3M9k49xWkx4T1S8jMLq1AK+0fdm4uh3PV5VvuCX
	fwVwygjw8iFKxEXZdDJkHW4zzLNd7Y38rdQ0A3QMVJXQdjGMtdgb956/j/LysIGW
	SuzTetHsfXhBNn+j39EVtsbu2+yqzG5bMyXRmVfZEZDj8/kJsdHYHfYFCySTSE47
	33eSvhqlp/uCN5UsJlNhcR2bUzVLl8sEvQuTXDYoq3avVaryxGVQ1Tb3LKDr9/nT
	mqhSuMwIGP35yLSvfQrxg2KUxMWmcHC3Qe7u7dAtBsgPBR4zB6S9sdWCMPF+04cn
	7/GqmVw9vNcEiplZ7HICDlxVaWO02Sol8pQ==
X-ME-Sender: <xms:h4sMaTKZzeRyQ7cmji-4sUP17LpKHe4fSTPdiw8JNWOPZ4g_sYpS2Q>
    <xme:h4sMaeAMctS51w74MCjnkQb_ejsDQsBwJhgQzJt9ihqvALWpL4X_4BQT0A3BYvNci
    u9VBHGkH16OghTP-IjiUf6ff7BH-0q-rOPbJDpzP5Rm0mHX_wbFQEY>
X-ME-Received: <xmr:h4sMaUBOs62ALb88UX79BjzPY88yIOSNh--BBvqMoOMO4aYSj6rc-1L5qyanDtLW4NSH4sR4cyvQRI1Qj3pmHcUm3nCqxulpeXcs37-0wxvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeijedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepjhhlthhosghlvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvsghohhhmrghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h4sMaYD7RjZbKAJyjx5UyKm9Rz6nejxKYmqZOkeFnfwqEL7LIvrMTg>
    <xmx:h4sMaXrSQ_FHy38GeNaUCM86APs1B4VxnOv6QVVjwjwc9x6Ob7hTbw>
    <xmx:h4sMaamTboHoTLKef2Z23zauWUfYAFVmIlGADg-bT5lJmqfgtVg72A>
    <xmx:h4sMafz8w3jXPl8Dug8qKf_BHSSZxNRlAeUW8TiyWrHRkJ2mDjmxaQ>
    <xmx:h4sMabS9IsY-brz0zsRVUIq7O4qeZkFA1lDQKYxXQwqx30BR3_8k5d7l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 06:50:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51d4a4d0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 6 Nov 2025 11:50:29 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:50:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, sunshine@sunshineco.com,
	David Bohman <debohman@gmail.com>
Subject: Re: [PATCH v2] fetch: fix non-conflicting tags not being committed
Message-ID: <aQyLfD_zx0ndCLvU@pks.im>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
 <20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com>

On Thu, Nov 06, 2025 at 09:39:25AM +0100, Karthik Nayak wrote:
> The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
> updated the 'git-fetch(1)' command to use batched updates. This batches
> updates to gain performance improvements. When fetching references, each
> update is added to the transaction. Finally, when committing, individual
> updates are allowed to fail with reason, while the transaction itself
> succeeds.
> 
> One scenario which was missed here, was fetching tags. When fetching
> conflicting tags, the `fetch_and_consume_refs()` function returns '1',
> which skipped committing the transaction and directly jumped to the
> cleanup section. This mean that no updates were applied.

Okay, this is obviously broken indeed.

> This also extends to backfilling tags when using the now deprecated
> 'branches/' format for remotes.

I'm a bit lost here -- what does backfilling have to do with the
"branches/" directory? The backfill is supposed to create tags that
point into the history that one has just fetched. So:

  - With `--tags` we fetch all tags announced by the remote.

  - With `--no-tags` we fetch no tags.

  - Otherwise we fetch those tags that point into our history.

The last behaviour is a bit more on the esoteric side, but it's
described as such in git-fetch(1):

    By default, any tag that points into the histories being fetched is
    also fetched; the effect is to fetch tags that point at branches
    that you are interested in. This default behavior can be changed by
    using the --tags or --no-tags options or by configuring
    remote.<name>.tagOpt. By using a refspec that fetches tags
    explicitly, you can fetch tags that do not point into branches you
    are interested in as well.

The following test demonstrates this behaviour:

	test_expect_success "fetch single branch without explicit tag option" '
		git init source &&
		git -C source commit --allow-empty --message common &&
		git clone file://"$(pwd)"/source target &&
		(
			cd source &&
			git commit --allow-empty --message discard-me &&
			git tag discard-me &&
			git commit --amend --allow-empty --message fetch-me &&
			git tag fetch-me
		) &&

		# The "discard-me" tag does not point into the history that we are
		# about to fetch, so it should not have been created.
		git -C target fetch origin &&
		git -C target tag -l >actual &&
		echo "fetch-me" >expect &&

		# But with "--tags" we instruct git-fetch(1) to fetch all tags, so we
		# should now see it.
		git -C target fetch origin --tags &&
		git -C target tag -l >actual &&
		cat >expect <<-\EOF &&
		discard-me
		fetch-me
		EOF
		test_cmp expect actual
	'

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c7ff3480fb..d5aee5af10 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1686,6 +1686,42 @@ static void ref_transaction_rejection_handler(const char *refname,
>  	*data->retcode = 1;
>  }
>  
> +/*
> + * Commit the reference transaction. If it isn't an atomic transaction, handle
> + * rejected updates as part of using batched updates.
> + */
> +static int commit_ref_transaction(struct ref_transaction **transaction,
> +				  bool is_atomic, const char *remote_name,
> +				  struct strbuf *err)
> +{
> +	int retcode = ref_transaction_commit(*transaction, err);
> +	if (retcode) {
> +		/*
> +		 * Explicitly handle transaction cleanup to avoid
> +		 * aborting an already closed transaction.
> +		 */
> +		ref_transaction_free(*transaction);
> +		*transaction = NULL;
> +	}
> +
> +	if (*transaction && !is_atomic) {
> +		struct ref_rejection_data data = {
> +			.conflict_msg_shown = 0,
> +			.remote_name = remote_name,
> +			.retcode = &retcode,
> +		};
> +
> +		ref_transaction_for_each_rejected_update(*transaction,
> +							 ref_transaction_rejection_handler,
> +							 &data);
> +
> +		ref_transaction_free(*transaction);
> +		*transaction = NULL;
> +	}

Okay. Do we need to discern cases where this is called and we haven't
managed to even queue a single reference update?

> +	return retcode;
> +}
> +
>  static int do_fetch(struct transport *transport,
>  		    struct refspec *rs,
>  		    const struct fetch_config *config)

Nit: it might make sense to have a preparatory commit that extracts the
function but that is otherwise a no-op change.

> @@ -1826,6 +1862,10 @@ static int do_fetch(struct transport *transport,
>  
>  	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
>  				   &fetch_head, config)) {
> +		/* As we're using batched updates, commit any pending updates. */
> +		if (!atomic_fetch)
> +			commit_ref_transaction(&transaction, false,
> +					       transport->remote->name, &err);
>  		retcode = 1;
>  		goto cleanup;
>  	}

Hm. Don't we also have to unset the transaction now? Ah, no, you pass
the pointer to the transaction here and set it to `NULL` in
`commit_ref_transaction()`. Makes sense.

> @@ -1848,8 +1888,12 @@ static int do_fetch(struct transport *transport,
>  			 * the transaction and don't commit anything.
>  			 */
>  			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
> -					  &fetch_head, config))
> +					  &fetch_head, config)) {
> +				if (!atomic_fetch)
> +					commit_ref_transaction(&transaction, false,
> +							       transport->remote->name, &err);
>  				retcode = 1;
> +			}
>  		}
>  
>  		free_refs(tags_ref_map);

We now have three different callsites where we commit the transaction.
It gets better due to the newly introduced function, but it overall
feels somewhat fragile regardless of that.

Thanks!

Patrick
