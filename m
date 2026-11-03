Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692880;
	b=JF6N/sX3I6kd3ls5aNWe4owFg6vfAus4MNTMU+xbT8Fx3A/3n+iPpPk2SzjH1d+EsoUR
	 J8ZDc76C/5gbeiZIGHDQRSsh/BNa6Rl1+BrceymiC7dtlbsmqrIClJygzFYrKD5u84k+n
	 UBCGDwwATpEWzBGYO8FdI6MTflbG+ctA5G4GFqKhg7YHNr32WuFXPKxYX2lbp8X8aA2kH
	 +U4gcXvEOWD4nZvLJuI2P0zmVqwE/w6B7nh1B63Ocm/wCkPH5ZCYnq9w/6ckiJqDbd9pv
	 w6Sb22kodeoeGNUKBuBwD8s3pYrDwZrW5Mzu1J1yiN2ptuZBGuXnNTh/4Ek804oR0qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692880;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ehwzOpY+5iVE3j6WVm2TXcLNJINME3okxxCBbLDAVE8=;
	b=O0wnakoUWoyL9YZIXV7eWcWyPBJP39miNx6STtw5rXEAb0W+v6sFQEO4KRAi5+ildCZK
	 z8EkWLaHMkWcSjOnsXBuV+2QxGjkLsRilyHyCDe/ua+4j/HwkP5rquEHn2PMJrjX1+qR6
	 w5F4z8F4CHylhnNnZu7bWFsHyrB9COvd9sZMMdP3PDzDrZSqvxdReWV5mexng8Ovg5PqM
	 d03zsTVZxnRrddqKtKfmGwNjic03hxy1uDGMY6aKgkHpqebUSMPL13fJgB3l5isE7yjqS
	 NjsBH8bKJyOdL0yc9w5SKr6NeBlfJGEgHjC62KXF4+b2p4JQR1IwUxzZ3PmHWoGyE8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=LuuHQnCE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JTep0TxT;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF11606A32E
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AF11606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=LuuHQnCE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JTep0TxT
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5BDD87A0062
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 03:01:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 03:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793692878; x=1793779278; bh=ehwzOpY+5i
	VE3j6WVm2TXcLNJINME3okxxCBbLDAVE8=; b=LuuHQnCEH3e9nhvdqIxUoGa1QS
	f6cVYqUKnh6KogfzoYg/y/kCFWUP64lpWbtgSxdiRolIWpKeO+wb2U4N49t3xgf3
	ffvkpUjB7KFGyVdY6Y3V/uci88WU/5mPVQxW9Nfqj9oHwz0dlPrFfqxVFmAQXL+w
	IBgDebqTWDq+YxwYUn+G9cnQPqBYcKNTlB2PpGEQGr2eR49fAazC0vpxY8w1RNue
	+d9JQfZyj5WDzhqmCb3944Tyg/a9sKwOg4rsdcXa/C0NhWVIYrVF0egriD7Owb4v
	HWR5fL12cH4ReZ3T4dtZZ0WNesXSL+S7j2PN/eH5JLglClmBg9qSOmQS08Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793692878; x=1793779278; bh=ehwzOpY+5iVE3j6WVm2TXcLNJINME3okxxC
	BbLDAVE8=; b=JTep0TxTQt04UNxNFrEpI6IabM7oS2u+xqCw8ia+gSjuiTNvip+
	N6+KbQ+rgY141NKrspI0NguFg57ocg/yym9ykKaqznkETihrt9r+5tT0PtAxhlbU
	KP7daibF9p55qS68b0OEU9xQZkFp1kd1ubsfanp7V9OE2MzO53D+sKdz7BMojF0F
	hIef3QKivRbjfFsyltkb+sHLnPObjoLIyTfWRNqaQ/dQeyEXzTdc9xfYr2NDTUtd
	ZhXirGNggJmPuO1uglefadvV1yopzmVwSD3nmO8FlF10F8Kyouac5OLsOG0XQDVh
	mgXORCH8KUFM1YSIYSHauGHALhVTN+MQpxQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793692878; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:0PitDT0s/qG8u5aiT3hrglw3IXwZM1RSwS/lO71Q7njZFba
	XepnqcHmoEPOCJbTS297ReNyGkabqRwMzFYalFZbjrynPzM6NlPnNnzHzKIohnAy
	nI23ass8NK3TlY6pGEzb9eztJCMs2w8fTfDtUW6aT0PHoB6qIZKic6hDL7BJJ8m7
	CEIZGddqoL6WUXm6QepHvS8ivTs8CV59h1Hpx8xQb6Ewzs/9XDi6MR414NWkDzl3
	y9xJFZlDrBYi3p+2fu6j5abE/dEhS7L/AFGrLfsIUNpfc0sNajFX+H7aeZZYJ0nn
	OPJMxWh3g9nEu+/+Uz73BLC6gcivHtTAGCVd0lA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:q8ymcYiYtNlXMcvQ+oHzFbqnE1qC8WUxwhRh/ckwL8w=:6JYDcodP8FEHHZA+YAyZJTXtrH2cdmCmG9iw4SnQxes=;
X-ME-Sender: <xms:zpTpan4SEpnh2OS8UxdkM0Xaid7Q6IF6-y9N5dTXM-TVl38gskBB4Q>
    <xme:zpTpavIXRbglcPap6jONy_-qYVrKNdWlYYqqarP7kClnQDFAiDN8lH4xTKIW5MPwt
    vD1TF1ALd6Q6cW_VAMsJxCmgovOb_e6NsLu9mfDlZAiIRxVtoVUww>
X-ME-Received: <xmr:zpTpagt6SmMs-_NCTRymnPWHvF6hf32A6WQQuMxUlBaUZMnLjbADvw>
X-ME-Proxy-Cause: dmFkZTGohUvRIOQRnm96HqDsmycmc9NfNQ0PahCCGPhwlMhYdBIJRJAWgGQII9a5kw+L5x
    4NcEOTDAsfDGjAdH7LrisAnNIqzqlfqXu3kPvt9Uvc+m1i3kOxg274XdYzSkRBBBrVDPQD
    j0F49ReoAGXOzCPmFOcMsC5AqcnaP8v3QV4s/L7+HaGvZULqE9gR5TycUMScLYLkmMjAbv
    6n1lZbvRsIhYBGP++OhCKXdrp4rjfIFinPz1a/zaqMy2Em0ta1ovYml9J21Z9UxCIBvnek
    uHJheUIYFSgTaWKbvtqdn8cDjVWgi/CkYE8ieefcyZxJFaW7mYcoPfr8SLrZeMfck0WuaC
    OWitDXqBj1Ej+eSrSe20RtiglukyinyQqH89Evtr1wEMbXWijaL6LdYiZKI+bYen7xvcTU
    s+huYgAtDXunpDTKtPtF1ckjm5d9sWNrDY1Gxzq5XsmZkay89ldlcJgLGuOEGmGgnGM8Ul
    bUpxd9vxVMsKDDa6zj/tKSXJ4f47oprQtHSv6wmDLIUe0BCsN5oH2OwK8vuHm0HiRaPH5H
    bk6hwjxW26BUQ/vn4goD+PwGKZ+VNyD/F4q+GXafbiSR05qgwQN8JOIXKbZf/47E9rr25J
    8Ip56OsSYYhRah2UDYBGJs+H5FHQwV84G97x53reQzrNDdAHTuc8258kBqgg
X-ME-Proxy: <xmx:zpTpauJGL8uqhXo5NOamO99LcRnAlXMIoYvaxMk54PVVmuSN5E3vVQ>
    <xmx:zpTpap8O3ZhQJNkEEv44B4EI3dkLwCach5iED8WQeRuim5ZRkrVGVQ>
    <xmx:zpTpanxzI2BhBsH5Lw5ESOPqDoo8x2lkDuBYPXlpO0CLTRtM4paYZQ>
    <xmx:zpTpam7vAzvm7OOla1hUCVcCWglQ66BDREYfnRtr0kMglrh9VHFvHg>
    <xmx:zpTpag4tYkpCsbNIeOwaVdZKjhFNOzSYPpOB8ETfVCSgqR9sOzx1NVDK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 03:01:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75170568 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 08:01:17 +0000 (UTC)
Date: Tue, 3 Nov 2026 09:01:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 2/2] credential-cache--daemon: do not take over a running
 daemon's socket
Message-ID: <aumUyl6MQa43OFBs@pks.im>
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
 <20261101-fz-credential-cache-race-v1-2-28f0bac51e11@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101-fz-credential-cache-race-v1-2-28f0bac51e11@gmail.com>

On Sun, Nov 01, 2026 at 03:29:26PM -0800, Farid Zakaria wrote:
> When no daemon is running, two "git credential-cache store" run at the
> same time each try to start one. unix_stream_listen() removes whatever
> is at the socket path before it binds, so the second daemon takes over
> the socket of the first. The first daemon keeps running, but no client
> can reach it:
> 
>  - the credential its client stored is lost;
> 
>  - "git credential-cache exit" does not stop it, and it keeps the
>    password in memory until it times out;
> 
>  - when it does exit, it removes the socket of the daemon that is
>    still running, losing that daemon's credentials too.
> 
> The fix is to create the socket with unix_ss_create(), which the
> simple-ipc server already uses.

We usually write commit messages as if instructing the code to change.
So: "Fix that by using `unix_ss_create()` instead...".

> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index 0dfa11e2ec..de6720c276 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -231,12 +232,26 @@ static int serve_cache_loop(int fd)
>  static void serve_cache(const char *socket_path, int debug)
>  {
>  	struct unix_stream_listen_opts opts = UNIX_STREAM_LISTEN_OPTS_INIT;
> -	int fd;
> +	struct unix_ss_socket *server_socket;
> +	struct tempfile *socket_file;
> +	int ret;
>  
> -	fd = unix_stream_listen(socket_path, &opts);
> -	if (fd < 0)
> +	/*
> +	 * Two clients may each start a daemon at the same time. Bind only
> +	 * if no other daemon is listening yet; otherwise leave the socket
> +	 * to that one, and our client will talk to it.
> +	 */

This explains what you do without giving much context why you do it, so
this comment is somewhat useless. Most importantly...

> +	ret = unix_ss_create(socket_path, &opts, -1, &server_socket);
> +	if (ret == -2) {
> +		printf("ok\n");
> +		return;

... you mention that you write "ok" in your commit message, but you
don't explain why that's the right thing to do. So why should the daemon
pretend that everything was alright in the case where it fails to start?

> +	}
> +	if (ret < 0)
>  		die_errno("unable to bind to '%s'", socket_path);
>  
> +	/* Remove the socket at exit only now that it is ours. */
> +	socket_file = register_tempfile(socket_path);

This comment doesn't really add much value, if you ask me.

Patrick
