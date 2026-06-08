Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2F3E5566
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930352; cv=none; b=qhEMysqx4SRL687+TpiXbRk/YIW0bu7YmdsYi5W9oRm6g/ySRy5LbG/51eFpoMqxeLzGK7veTRnf5KMz8Cd/oKQr6oCHT6o8glveEy9rgdxnbRaExXVoXciE3xnYBkvO0u2rMzYGkmifFAgV5QwoY8evcOWI4Xc6o1MDPYq0JkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930352; c=relaxed/simple;
	bh=IHUzOnELCI8FW9mCVxxr9rRNSMHYkT9CFhzzpE/T6Y8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kCj6Z2+7FXRXT29uc3ZBtGT/CbzfaDIPg2oxx9M0WDaWqOMI/HJ4yaknnAJQMGO4UMVw8a5kmvJka53DCZ8pUjllVgsYBGnmWlg0Kybr4w64W++mR4+4bYC40nZyN6fPny4gP8G30HDSVPaQ7mbHw6VP/h3KWPpgikLTeHnNF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OH+xzHqK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b1X4W8Mt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OH+xzHqK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b1X4W8Mt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CF2F14000FF;
	Mon,  8 Jun 2026 10:52:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 10:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780930350; x=1781016750; bh=I8u2gIIAkq
	ltL8XgKsJgtom5nn/+6nEKRDDPqxcyhfs=; b=OH+xzHqK54PsRQBEUTqnApIwO+
	/5HtQoZBik8mD74z4+V2d1NkqMM2vaEYYMpssN0iKJvBMXcfnuvQaziuN8XXRHj3
	oQ5PZaKSeYaM6CrkKWa9T3xdNUYwi6ab5IRVNwjruUk8Sh7swPRgC0YAZzNUG5Ny
	wzgXrGILVB3tiSmk9W7AtyV29/mMFo9YrIoBeGL8y0bjZysC1jh3YsZ7SRg7AUqi
	Qli4ZfyYsm7TfwShdcxqMbwyFVL/TISaW5oRals1goSD2Tik+YrVtZli0E8m8Rpx
	/yM+YWyThWa3OaD2JJyxIpVXmU+55vzbPzzVPNgK1WBGNVAwAcNqo0GAqDEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780930350; x=1781016750; bh=I8u2gIIAkqltL8XgKsJgtom5nn/+6nEKRDD
	Pqxcyhfs=; b=b1X4W8MtkVTQ8OMrhFDxZTjJeqbWo2nfZrChkqJCoNlMcoB6jAT
	PJzyw7VfyQ0MXxVTU41n55DN3Wm27Swr0pLgj0C6Kh3/uANV8aafLVQhVtiS0Jza
	ZMV7vOv5SlPo4igz3xllLp6jN1/BVz6tIh30b0H8Fs68eZINF8OOLMRYV9RRr2Xe
	aHAw7ca9mtckdSFhdCQraing4whewU35Uo2PN/nN8WFJSa1nhvB/Brc2Ww24/bF9
	TBWWmACDUXq38XAtwO43Cvxuua650c8TJGEAzGWW0eHje73YBZLVEE4UDOJKpK1H
	Q7ZARzjyofe2+gfebGHdMCGxPPOEo1XAfcQ==
X-ME-Sender: <xms:Ldcmag9tDv32ZXNOmSrML-aMAZ9ZPK7qoEk8_1BmwWMfryKe3hxq6A>
    <xme:Ldcmag76ZQOEqstM0e_rRa2ngYYFSRWKE0Wm7HRPHQcXcdNzfGCRKK7kOov80UVaM
    AwrPcXd3fBw8OFZGmFnCLFfYprfFjf6Ay2huV4GrL6qZEFQ1vxkhg>
X-ME-Received: <xmr:LdcmahnOdkP9yeVyhuNPWN1O7bnbNvLSHB_6HMtG4fIFYtQtOVC5ZISvTTWEuBf8R27ZhC55SLAOVlwSGu3lv_FjjbB7w98fbxbO>
X-ME-Proxy-Cause: dmFkZTEtLkhZJ1xMQsvj7a/W9/kqdFM3XCox159ah2ntOmH7qFjdpd4xJ9DlR/wnjOAOgF
    +NzGwtjPXBuzlczAJJNZXhRkRxSVVKpRAkjMbNZ4rxa3GfqfuTp1xBLehFQSeDjSLwkBky
    qeyI5hH6NzCNR6j+7m0td7/3r45NvSIy4YLYr7ZILrwCyEz23lLKmm6CHYBQIqbBXXQSky
    XV1LnY9Cd/yMBFdBtcYkBvEVYuPwl6h/PtDuidfljOE0sYFK95mv1KdfIPpCfDe3W+o0V2
    5eKozJ6uV4XsHAraJy5uDrurVsXcjp9j+8V2klZXDBnv6kiDm26yDoHfoxbyqZeEX/9RYO
    DdGJiz8Pie6W20tn5sO2eNzawWXyUI14CsxyFtJdx+xs7OgHuHV4sr1QvGTJ97T20eZ3cE
    3YZgAXcbT7ymdVf9XkYoG5PN5njaewFj/KvLG+3QmTio+P+b+dDKMK612sFZD5KJ3gv/YJ
    gRxQQDGLuXDxCaReMDwJQf0QrypSN4nb9+aHI4f6RtzzpM2JtbrR9syAjUJ5UbWrCa5yXz
    FyTQimcO9XN/wa6mF7fJGO+lboO/tWq1Eoj3U84jRMDiSMH5Y9AD6NooR6ckHQGWXjm/Mw
    QPePbHnefBhb6SXBm+qNKZE0ykvrMLut+W2bg+DlfikddTuiM8GVPGP2Nzkg
X-ME-Proxy: <xmx:LtcmarG8RIYxQ6kYv-oj9N_vksudiMJAxtuddF9FX8sx7tYvBa1uog>
    <xmx:Ltcmag-hRVWgfjJqu5ccHV8_4oGXinLnLr06PERcgIQ_EgSTtTBVaQ>
    <xmx:LtcmakngEVBwEWSICxNebPQAe4c9sblgTaYFw7D6PLvIjFqmPoCK3g>
    <xmx:LtcmajAwNQgHOjgc2DdKzaYlY2lZQBToFX0DJKOHMNn3r5Jtl4-RzA>
    <xmx:LtcmatDsAUWigVZlQiBT4o-yuPOoDR0HzOX1zV76qmd6N-nWfLjh49od>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 10:52:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: eric.peijian@gmail.com,  calvinwan@google.com,  chriscool@tuxfamily.org,
  git@vger.kernel.org,  jltobler@gmail.com,  jonathantanmy@google.com,
  karthik.188@gmail.com,  toon@iotcl.com,  chandrapratap3519@gmail.com
Subject: Re: [PATCH GSoC RFC v12 03/12] cat-file: add declaration of
 variable i inside its for loop
In-Reply-To: <20260608-ps-eric-work-rebase-v12-3-5338b766e658@gmail.com>
	(Pablo Sabater's message of "Mon, 8 Jun 2026 12:14:26 +0200")
References: <20250221190451.12536-1-eric.peijian@gmail.com>
	<20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
	<20260608-ps-eric-work-rebase-v12-3-5338b766e658@gmail.com>
Date: Mon, 08 Jun 2026 07:52:28 -0700
Message-ID: <xmqqzf15w0cz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> From: Eric Ju <eric.peijian@gmail.com>
> Subject: Re: [PATCH GSoC RFC v12 03/12] cat-file: add declaration of variable i inside its for loop

"add" sounds a bit strange, as the existing code wouldn't have
compiled if the variable were never declared.  What the patch did
was to move (not add) the declaration of a function scope variable
that is used to control for() loops.  Would any of these work?

Subject: [PATCH GSOC v12 03/12] cat-file: narrow scope of loop counter
Subject: [PATCH GSOC v12 03/12] cat-file: declare loop counter inside for()

> Some code used in this series declares variable i and only uses it
> in a for loop, not in any other logic outside the loop.
>
> Change the declaration of i to be inside the for loop for readability.
> While at it, we also change its type from "int" to "size_t" where the latter makes more sense.

Curious single line that is overly long?

> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  builtin/cat-file.c | 11 +++--------
>  fetch-pack.c       |  3 +--
>  2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index fa45f774d7..c060fd4800 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -726,12 +726,10 @@ static void dispatch_calls(struct batch_options *opt,
>  		struct queued_cmd *cmd,
>  		int nr)
>  {
> -	int i;
> -
>  	if (!opt->buffer_output)
>  		die(_("flush is only for --buffer mode"));
>  
> -	for (i = 0; i < nr; i++)
> +	for (size_t i = 0; i < nr; i++)
>  		cmd[i].fn(opt, cmd[i].line, output, data);

The loop limit "nr" will not become as large as size_t because the
caller passes a platform natural "int" to the function.  Wouldn't a
stupid compiler give us warning on comparing unsigned size_t with
signed int here?

> @@ -739,9 +737,7 @@ static void dispatch_calls(struct batch_options *opt,
>  
>  static void free_cmds(struct queued_cmd *cmd, size_t *nr)
>  {
> -	size_t i;
> -
> -	for (i = 0; i < *nr; i++)
> +	for (size_t i = 0; i < *nr; i++)
>  		FREE_AND_NULL(cmd[i].line);

No type change, so the result is as safe as the original.

> @@ -768,7 +764,6 @@ static void batch_objects_command(struct batch_options *opt,
>  	size_t alloc = 0, nr = 0;
>  
>  	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
> -		int i;
>  		const struct parse_cmd *cmd = NULL;
>  		const char *p = NULL, *cmd_end;
>  		struct queued_cmd call = {0};
> @@ -778,7 +773,7 @@ static void batch_objects_command(struct batch_options *opt,
>  		if (isspace(*input.buf))
>  			die(_("whitespace before command: '%s'"), input.buf);
>  
> -		for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
>  			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
>  				continue;

ARRAY_SIZE() is some arithmetic over sizeof(*commands) and
sizeof(commands), which is of type size_t, so this is better than
the original.  Use of size_t i of course is a natural way to index
into commands[] array, so the result is just fine.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 120e01f3cf..f13951d154 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1388,9 +1388,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>  	if (advertise_sid && server_supports_v2("session-id"))
>  		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
>  	if (server_options && server_options->nr) {
> -		int i;
>  		ensure_server_supports_v2("server-option");
> -		for (i = 0; i < server_options->nr; i++)
> +		for (size_t i = 0; i < server_options->nr; i++)
>  			packet_buf_write(req_buf, "server-option=%s",
>  					 server_options->items[i].string);

server_options is a string_list whose .nr member is of type size_t,
so this comparison is perfectly fine.  Ditto for ->items[i].string
that is a natural way to index into an array.

>  	}

v
