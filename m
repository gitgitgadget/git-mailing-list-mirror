Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761676;
	b=AL8Go6HaXE56/0nXnaHhHG64g0KFjl/uaYKi7i3I3YT3iBtfw4W5InptrzHL0IXjLUSd
	 Qg1Qr+D/oyso2j70MEg5I/pmFRRu4TJ+eQmxVoC6fxpWjibYLN4AgdP+QxpiIGYKiTn59
	 IsMKzfb1PMDQjkXsvoYi6KYKSEQr3W6tWLqxCorZ1OQXz1GNLymVX8WK78MxEPDkBWCb5
	 D3IyGRf7b6Vx3LX6iw+JmDXCivWvWEpOFHxYqSB35KRXibowBbIKgo8EAPsY6DfjZdRT9
	 J0HgNM33fn/CRWC64dgq+Vyqxwo7JovZeUfHHBxvOksfWEyZ9YVe2/lkeDOzDBjoxJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761676;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Zhr4NBWh1l431YurzklqVPde/oZ4GzRg9Ckfn8d7ADo=;
	b=trtmBqTSSmn/v3ehE1BRM/vwvUQzaTyMfxXr0wY4eGyZKu4m6arDUOcoLYFtkG8fT7da
	 VTDwm6V+mHNzqjemGC5jLCSw212oEDheTlK3aQeX0/RCyyayz5kUE10LbxxveiTjBoInK
	 eAPYUN8P396NKW6dmoUalQAYmWlLyeWJHh0wY26FTzgM3qIRm+4BO7vo0sY6psVctElta
	 spTklMnd6EWMAF/7KPX+/5LC6OA9Ks4gct2NbV21MJQOHcQE3A3eKtK0/kIjMINZWrIwf
	 445iB8B31q2KshHr+jesHRGL5IMH5ESfPIASmxxPUsHD+AD0AXxrSmNPY+Sz6izs9Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b="X17IEhR/";
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF50606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 03:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF50606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=X17IEhR/
Received: (qmail 11525 invoked by uid 106); 4 Nov 2026 03:07:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0+7OF/XLnAI5zav/1zhdzMRJf58pmahb6XV9GrSD3wM=; b=X17IEhR/5OWVBxkLu1cjOeDiFxV291cufO2Jbk+lKcdNpAL+B4KBbh2komHmRZqEHhWlmV4GqHeSRM5lRrFeH4qiMhaNuz64+JBqvs+jNbzyPYqFhBHtCXbdR/5w7dH+Ph4Yo5BR+N0nYKwdRlHoonRYe6tyOLlyGmoYVZYhH4wgby26YHWaYIKEyPLBgHUA6sUswY/M70uhjzr9/3O7TK5Wrz3TfJgcWE/rRDjfF0SarM1DDTdEYowBE6IzPGIEW6OfDv1m/wb60crwJIHFoYhjDEBUkmMTfEY1LvJ/1hhQfQflHyyPpJTaNhQnr1Kn8G1y6ciMqJP0mokMICaEsw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2026 03:07:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27617 invoked by uid 111); 4 Nov 2026 03:07:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2026 22:07:53 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Nov 2026 22:07:53 -0500
From: Jeff King <peff@peff.net>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	M Hickford <mirth.hickford@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 2/2] credential-cache--daemon: do not take over a running
 daemon's socket
Message-ID: <20261104030753.GC1492379@coredump.intra.peff.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261101-fz-credential-cache-race-v1-2-28f0bac51e11@gmail.com>

On Sun, Nov 01, 2026 at 03:29:26PM -0800, Farid Zakaria wrote:

> The fix is to create the socket with unix_ss_create(), which the
> simple-ipc server already uses. It takes a lock and binds only if no
> other server is listening on the socket. A daemon that finds one prints
> "ok" and exits, and its client talks to the running daemon. Register
> the socket for removal only after binding it, so a daemon that loses
> never removes the other one's socket.

OK. One of the reasons the original did not take a lock is that a stale
lockfile might force the user to clean it up manually (rather than
everything eventually Just Working).

But unix_ss_create() only holds the lockfile briefly to make the socket
acquisition atomic. So I think the risk of stale files is negligible,
and worth the tradeoff to avoid races.

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
> +	ret = unix_ss_create(socket_path, &opts, -1, &server_socket);
> +	if (ret == -2) {
> +		printf("ok\n");
> +		return;
> +	}

So if we found that somebody else beat us to it, we still say "ok",
which makes sense: we tell the client that _some_ daemon is ready for
them to talk to, even if it's not us.

And then conceptually we are done and can exit. The return here does the
same thing. I think that's OK, but it might be more obvious to add a
comment for the "ok" and just call exit(0). I am happy enough either
way.

> +	/* Remove the socket at exit only now that it is ours. */
> +	socket_file = register_tempfile(socket_path);

And then tempfile handling moves in here from the caller, because we
might or might not actually make a socket. Makes sense.

> [...]

The rest of the code changes look as I'd expect.

> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> index 6f7cfd9e33..8e07e55520 100755
> --- a/t/t0301-credential-cache.sh
> +++ b/t/t0301-credential-cache.sh
> @@ -51,6 +51,29 @@ test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
>  	test_path_is_socket "$HOME/.cache/git/credential/socket"
>  '
>  
> +test_expect_success 'a second daemon does not take over the socket' '
> +	test_when_finished "git credential-cache exit" &&
> +	check approve cache <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	git credential-cache--daemon "$HOME/.cache/git/credential/socket" >out &&
> +	echo ok >expect &&
> +	test_cmp expect out &&
> +	check fill cache <<-\EOF
> +	protocol=https
> +	host=example.com
> +	--
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	--
> +	EOF
> +'

I'd have thought this would pass even before the patch, but perhaps not.
Usually we rely on the "credential-cache" client doing a ping to avoid
starting a second daemon, but here we do it explicitly. So probably it
did just take over the other one, but nobody would really hit that case
outside of the race between the client pings and the daemons actually
starting.

So overall, I think the patch looks good.

-Peff
