Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98926E70E
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024913; cv=none; b=PbRQh4b3PmffIYEvmOSFMc9J0jXNtxUoH5vfFxYxGiIi5dwjL/fn5ziDGk05XmwUJDpOE4Liq4hbIYErqX4c9D50U2HgQEGvm/iD0S2PsppFkjXBF3mbLyujnRUUNBArj2BcWqb5vP+8M3KAa5f0HOPEp6pK8Dqz81XUpju5EXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024913; c=relaxed/simple;
	bh=nGNzWxy7HVYtiX/mZxOjrHZAK7N/8K76Cjq/eurAZF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DEYHqzdmz90NSuDg0pls2UHay0aAQE3k/O5qptCJnVw4YS14eE2f0syzc/Z7TKLpgVJrPAHPwKtCekUC6xTSLFg3kAncYMxn5eqIyCN0YrR1vuII9rQuSLfjqoaWWRdzK6Sh6b2hDrgmWqIVAxuLR8nMZy1qQKK3JMCaj7h2UOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IyIZYT5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bl1p5FIl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IyIZYT5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bl1p5FIl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C5C6EC038E;
	Mon, 24 Nov 2025 17:55:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 24 Nov 2025 17:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764024909;
	 x=1764111309; bh=nL9f2tAS+EJ5OD6pnFR9my8/0vrNyCKe1SXMuUdktCQ=; b=
	IyIZYT5rjJTw1rCTDXDE5H0aT4Tbk5jRFY6PKIhAjT5OzlPtxl6OYUYEJDH55pD7
	Zk5PP27JKmVzoTostVJBv+vHWA03rDm/trSjJRqOnci3sQvmJ7TsyIQZnoonKvgp
	VsYO5IFGvXqbXH4JAi9CnyHfwCUWK+UJsfWklUkQcHxAiPaLU6o9Ns8RbRz0rHNi
	1+MFgS/4WXp6v9DrC+f5rasbfO7VYGPQfx4Vh2s9cAiB5VZDN8WBx5K1vxG/IYaj
	U2foOeDQBwEssAOjCtFVXyJ+5j1hYftr1xWt+Vh7Nxsb2wklXpLGm2hU+J2MpP+3
	n7aNqS+CH/gMEqJ/IQDokg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764024909; x=
	1764111309; bh=nL9f2tAS+EJ5OD6pnFR9my8/0vrNyCKe1SXMuUdktCQ=; b=b
	l1p5FIlgFgpSvST0iUD60ju0KqyJjFsKRZaPhrIHIN62tzXWdCu/dBkBTXP+GrTg
	UI2FIdDhlmSe/82CIlsaM0Q46j2SPWQZMbyqJEmUZPSB5c+uMSx/zlXM6CU4wwzd
	nPZ7hS4ZwaS8uJBCgF7wP5/2kYDmycfv9UpnOBL85ophdz5Xt9LoGOimvDMbAHWG
	A4BOt5kDXX8fOBNFAMeeo7IQ2zLshsq+JBQQKTdiFxqBd7vR1yKctyN0XkjwVG30
	pIPEK8jCjXPbeeZG4/tWm6Mmt0pv18Z1HDR2IWTUopqK0hskezpwdxVf1aoz748o
	d1mklF9fIgOY50mk2lEiw==
X-ME-Sender: <xms:TeIkaajFRgOXKD2SkkHy8CA5LKBb40iN9QjuTtIPr5H3YOJFkWwxzQ>
    <xme:TeIkaTMpCaRkvz2U02ZVgn22cd0tx6KwHA782zde6XFSXdDNljHx3bweimbPP-rW0
    0UQwZB-vCyo6Mbp-3irw6-aHcK6LaBPqp--SZ1A2ALuVkWLjF0wrw>
X-ME-Received: <xmr:TeIkadoeadEYPaKPRqK_rUv3cJkMS2nfl1mzDKfZlma04Yb3wUeDu8cOENhyahBJN6SqSIQYyvbWwiLfdvWwghMNkjILvYJhzKlz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsg
    horhgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpth
    htoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TeIkad6E6nq8fi5fDoskdmN71Gfq8zt0XWwWTq3A0486j1H5IRhE6g>
    <xmx:TeIkaThKMAFtwfqEX_rz1A-B0QkFQ44QC2xCTOnfbFSTh1tcovaNwA>
    <xmx:TeIkab68wtZYZaDjoCKvt6MhsYQ6013pEKopnEnemRbAekqb0C9_cw>
    <xmx:TeIkaQEscPnB_WP7qVqA85159iAzwELkqSfGkWcA9xKPHfw2DKlHvQ>
    <xmx:TeIkaTGjRGsJCMDBEwX2UFnDhvjNnwngJG7YpadsDk0-zooosz8VVNjo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 17:55:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v3 04/10] transport: convert pre-push to hook API
In-Reply-To: <20251124172043.1650014-5-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 24 Nov 2025 19:20:37 +0200")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20251124172043.1650014-1-adrian.ratiu@collabora.com>
	<20251124172043.1650014-5-adrian.ratiu@collabora.com>
Date: Mon, 24 Nov 2025 14:55:07 -0800
Message-ID: <xmqqy0nvujlg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> Move the pre-push hook from custom run-command invocations to
> the new hook API which doesn't require a custom child_process
> structure and signal toggling.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  transport.c | 95 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 51 insertions(+), 44 deletions(-)

So, this completes what 01/10 hinted at when it created a
generalized interface modelled after how pre-push hook was run.  We
used to spawn the pre-push hook and fed its standard input by
calling write_in_full().  Now that is largely encapsulated in
run_hooks_opt(), but the application specific processing (namely,
what we write to the pre-push hook, i.e. the list of ref update
status) is given in pre_push_hook_feed_stdin() callback defined here
and given to the run_hooks_opt() call.

In other words, the mechanisms are very cleanly separated between
generic machinery and the client specific processing.  Nice.

How and where does the pipe we are writing into (i.e. hook_stdin_fd)
gets closed when we are done with the child?

> +static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct feed_pre_push_hook_data *data = hook_cb->options->feed_pipe_cb_data;
> +	const struct ref *r = data->refs;
> +	int ret = 0;
>  
> -	strvec_push(&proc.args, hook_path);
> -	strvec_push(&proc.args, transport->remote->name);
> -	strvec_push(&proc.args, transport->url);
> +	if (!r)
> +		return 1; /* no more refs */
>  
> -	proc.in = -1;
> -	proc.trace2_hook_name = "pre-push";
> +	data->refs = r->next;
>  
> -	if (start_command(&proc)) {
> -		finish_command(&proc);
> -		return -1;
> +	switch (r->status) {
> +	case REF_STATUS_REJECT_ALREADY_EXISTS:
> +	case REF_STATUS_REJECT_FETCH_FIRST:
> +	case REF_STATUS_REJECT_NEEDS_FORCE:
> +	case REF_STATUS_REJECT_NODELETE:
> +	case REF_STATUS_REJECT_NONFASTFORWARD:
> +	case REF_STATUS_REJECT_REMOTE_UPDATED:
> +	case REF_STATUS_REJECT_SHALLOW:
> +	case REF_STATUS_REJECT_STALE:
> +	case REF_STATUS_UPTODATE:
> +		return 0; /* skip refs which won't be pushed */
> +	default:
> +		break;
>  	}
>  
> -	sigchain_push(SIGPIPE, SIG_IGN);
> +	if (!r->peer_ref)
> +		return 0;
>  
> -	strbuf_init(&buf, 256);
> +	strbuf_reset(&data->buf);
> +	strbuf_addf(&data->buf, "%s %s %s %s\n",
> +		    r->peer_ref->name, oid_to_hex(&r->new_oid),
> +		    r->name, oid_to_hex(&r->old_oid));
>  
> -	for (r = remote_refs; r; r = r->next) {
> -		if (!r->peer_ref) continue;
> -		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
> -		if (r->status == REF_STATUS_REJECT_STALE) continue;
> -		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
> -		if (r->status == REF_STATUS_UPTODATE) continue;
> +	ret = write_in_full(hook_stdin_fd, data->buf.buf, data->buf.len);
> +	if (ret < 0 && errno != EPIPE)
> +		return ret; /* We do not mind if a hook does not read all refs. */
>  
> -		strbuf_reset(&buf);
> -		strbuf_addf( &buf, "%s %s %s %s\n",
> -			 r->peer_ref->name, oid_to_hex(&r->new_oid),
> -			 r->name, oid_to_hex(&r->old_oid));
> +	return 0;
> +}
>  
> -		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
> -			/* We do not mind if a hook does not read all refs. */
> -			if (errno != EPIPE)
> -				ret = -1;
> -			break;
> -		}
> -	}
> +static int run_pre_push_hook(struct transport *transport,
> +			     struct ref *remote_refs)
> +{
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +	struct feed_pre_push_hook_data data;
> +	int ret = 0;
> +
> +	strvec_push(&opt.args, transport->remote->name);
> +	strvec_push(&opt.args, transport->url);
>  
> -	strbuf_release(&buf);
> +	strbuf_init(&data.buf, 0);
> +	data.refs = remote_refs;
>  
> -	x = close(proc.in);
> -	if (!ret)
> -		ret = x;
> +	opt.feed_pipe = pre_push_hook_feed_stdin;
> +	opt.feed_pipe_cb_data = &data;
>  
> -	sigchain_pop(SIGPIPE);
> +	ret = run_hooks_opt(the_repository, "pre-push", &opt);
>  
> -	x = finish_command(&proc);
> -	if (!ret)
> -		ret = x;
> +	strbuf_release(&data.buf);
>  
>  	return ret;
>  }
