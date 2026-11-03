Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726656;
	b=ZCv60JbVTJOG3YmqmVs7udj05IEBupQ2hrTi5crNXxDsJ8NIbKpeSKNgVdX6NXmtcUdk
	 C1mziUqTn2ywwt1g6e8Lwz60D9MujS7uTu7z83IrfSoN0GyYZG5MMMYnA7pQ3tbFAAJn6
	 lNlWh927Z7t7ehvfJYb7tNr6QdNy2sg0RzuJxCNlSTeJON/FTwUi0p7//nfleeKf4+f7U
	 AAbZlUjVeslIxNmmDkZuqv0SodfuEe0I+zQzXTyCkeDTu2PDvxiidsiQ8yzA/dbo0QJ1t
	 PQM1Hm+kiZboVQtuHKdPEHZQF9BFKP3JnZpYUqdEVBm+QU8lxIQKkkKd/ucOZmvvWmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726656;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Lp2DVGaIdKDE93WZDPnAe+viiiSbB2+cD2cNXdUFRVM=;
	b=fw2H4kLlvOF+YDPUFWYTeuZCuFYr974FhbU2cxX6931eBkwpOC2MggSjCpmSBRMkGHT2
	 tMKVr4MMDc1GaY9W89wFi8f4YHV3Kt4Mkp4f70plUTFvBMGc+anTKGQN+/tstRpCrYOR5
	 mk2GQ0sk9DDRn/nadtJkYadise3X4M9u2uXhSr8eC/z5gvfToUK6NXhhsfmzVkjJHlksz
	 gg8Zp4oeAuGo2R69DsiKwlfGfkDhIufAFxCRgAjYqoxk+IHX+D+qxrGbqy/0VPCmYIkl+
	 7dIMbMs17QuwdYbwZz51Gy7jnmTZZpTYH/xfzmuZj97SB36FKH6wtn3WU4l/nvvealQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ibhRzkMy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FitTP35V;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A10606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A10606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ibhRzkMy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FitTP35V
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5122A140014C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:24:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 03 Nov 2026 12:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793726655; x=1793813055; bh=Lp2DVGaIdK
	DE93WZDPnAe+viiiSbB2+cD2cNXdUFRVM=; b=ibhRzkMyeQOu9uNIulyvBFmZOd
	XZlog3swkSJXE8aAm3YhUV7M2ixDsGSNjdhC4ykSjuhDZ91uqlbvDOK0chL+ndbH
	CDAIsGf6cpfX/ceZbHaQYZfiv04iF+hVHiRGoTjp29JkgpRChf9h3CTiAzNYiLmn
	H1u589grhhaW0uEy3F2qEFqJI4fm4CwQQjK9XBgNFvqgaU3bBUvF8fT3rDLnRv53
	0qXLYFModTIWpt0T26OKzzkGnjQXXdqV6onY7q/U+6QHC8W6fr/j9YhWNoQOukAT
	BmORo4PJ8EiIi1TOX8cyQtkibtUwv1Ieh4n4WhWaH1StAzD2jlXNkyNzen5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793726655; x=1793813055; bh=Lp2DVGaIdKDE93WZDPnAe+viiiSbB2+cD2c
	NXdUFRVM=; b=FitTP35VDUVkDEXPUYk0t3v8FvYo4nSVGUTEFmHAK4apFeW4pKQ
	UfXKdHIJjqht417P/0nKFPmQEG2bvur79zKAkjztmJKk3+fDSnN6rrt2/o7Hd5iw
	kEKB1Dq02iPqJkP9pUf5i2T9kTOcbcTuoio7f6BY8L5+V0BXObmR9sdul2wGmtKf
	UPHBjb19WpwZUrH79d+IF8jb6qNyDz+G6X7blgJYZaB0l7OT2yoWtsZAK9Bh/Nw9
	YhAaDGyWJ7UO+65YHKaxv/i8ob3J6D3xNshNFg9uEBQjojDdSZAYbRpy4Uxy5K/w
	jqugBM5IcfqJ47DT0PhXX47rBxr6bTP5dVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793726655; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eSKYVB9H0tFDYZxqYxldwx997Av+u0SkFWqk09VcLqN/46E
	pUXZq6Bn44wjSwcbkJz55hfhFsboATBlEcX72X4O/urGEvW59Eg3dHXlsmCR8Q4f
	0uxKc/VPgvH3D17keMhpap/vAXd4DGxq+rz8iqZa/JsbVTyWAgoi+9jExNiQUuGO
	r/McHEjfEp9X5n14pubaBcnasQUecLXd3fQruJ2lPVgoqVpOpkFMVvHTI2C7pzTf
	bwgOke0TWgP5F6J3VN2sI03j+HG9r60HV1ru250yDm4eFG/eGE0gtnmH0uzKcQUK
	TTxmguxK1nxiuMxO2wIoMc1ErypJo/BotFBXIvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8eVpWHOo7OPa8zY2f8UFxjxoxJr+lbSqKfUD3tV/kes=:7k2PmMKFhO5feArKncTQVdBf400JNqbEznDyf9SN8G8=;
X-ME-Sender: <xms:vxjqah6N9pjtFw9UuQOWULda6xmqeYXY3YbdQ-YWIoTKs4acmkxtEQ>
    <xme:vxjqat8E1E0EEF9WV0O6KFfSKC4tUOr6VxXjf4XoK0i0muS8_F8b-lvidmtCA9vBV
    4bNQF8NTWQh1tdn8vwnuAbmp7Pp1U1we-lX0gEe2plmCjTJztm-vEDh>
X-ME-Received: <xmr:vxjqauoqxxISLS9t6QKZ-3Yuy03sFVxfeyPqAVnBeXk3fSxY03XOlf0tfOUCNFjInGZ0D7bYJfeNp7sJijgNk3omEb0q966FH6-Z>
X-ME-Proxy-Cause: dmFkZTGzAANFv//H54Rh9WxPy4AB5cx5twbWPvBy80ahnsyUdzzrVaSkk2xgSbAzIQRzpu
    H8It6HkyaGAZmiXiH0sTEouYRhhWrF3rkNAM4jK5tN327VaWTR0egdfOFVrDMelKBR+xmR
    s7Gfr+4F7Rndk3eysbmNONqNazYf0imqR7l6kVew1RVVg4rqizHeMgufQUsRVNIPBR/Yj8
    Ft7bDhn4rKtF52ChnInPlrXUrj7ARkrZQoy0W7cxWGYeRGVcN1F0So4eClZPfiOmFuM1iH
    Tt3/rVyOWqL72QlLyJNEOsr40W49918es257XhRvtpMRu5s1hut8Q8Ae3eT60GPjRvNdbD
    fSuBxwRaK5wFOBH4M4DK7OL1hdDEh2+VRB/BdKNMIHjC2i3OCo52Zec8IYcvBOth+bm4ZT
    1iFpKc7je5IPnSX1OUIGv1xYN99m9VjY3fkbO0d373ikInFYxmmlQpZPWxBXbZ6uldj50c
    24MybD/N5WbtxPhRhhA/Fty6VmXwJU3EU+gCPlfyHTlshycIEOkfBxqG7EWMApqJUinzgr
    aYj+jUaVBKDhuB4Uzkt/++W0c7UXa+YZReNEtWSWtcUZZFYjEK04lSzH0O6U4/UIj7iY7P
    c2dj5K0HKx1Z1mA6aVfXX1LgiJY1w0qqE4Uv0rY0TBFnNwAMg6K9bJFdO6yQ
X-ME-Proxy: <xmx:vxjqamqf_N_Yd3ifLWqbR-rNw-cYJrAguCu_3tIIK8V9_lg3x11aJQ>
    <xmx:vxjqap2qv19KrhWXB2DehHCqN3i7ID72Mx-h-07gRi2E4Ifn7GRcrw>
    <xmx:vxjqasGwWEe5S4Iu2sWtsIowCauaUnnH9_p8_IDzxvSGYLOn2Zfgxg>
    <xmx:vxjqasH4P-KRpaeLuKYlQCORmlKR0owcr3GrT5Es0WMBzqS6N-OxYQ>
    <xmx:vxjqajsfKE9GXBpS0mw3aGEtTWKjYyRGmhBc1TGtNJgaNX04iFS58Ibl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 12:24:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  M Hickford <mirth.hickford@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 2/2] credential-cache--daemon: do not take over a
 running daemon's socket
In-Reply-To: <20261101-fz-credential-cache-race-v1-2-28f0bac51e11@gmail.com>
	(Farid Zakaria's message of "Sun, 01 Nov 2026 15:29:26 -0800")
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
	<20261101-fz-credential-cache-race-v1-2-28f0bac51e11@gmail.com>
Date: Tue, 03 Nov 2026 09:24:13 -0800
Message-ID: <xmqqik2dakw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Farid Zakaria <farid.m.zakaria@gmail.com> writes:

> +	/* Remove the socket at exit only now that it is ours. */
> +	socket_file = register_tempfile(socket_path);
> +
>  	printf("ok\n");
>  	fclose(stdout);
>  	if (!debug) {
> @@ -244,10 +259,11 @@ static void serve_cache(const char *socket_path, int debug)
>  			die_errno("unable to point stderr to /dev/null");
>  	}
>  
> -	while (serve_cache_loop(fd))
> +	while (serve_cache_loop(server_socket->fd_socket))
>  		; /* nothing */
>  
> -	close(fd);
> +	delete_tempfile(&socket_file);
> +	unix_ss_free(server_socket);
>  }

Is it sane to mix unix_ss_* API with tempfile like this?  For Unix
domain sockets managed by the unix_ss_* API, isn't
register_tempfile() unnecessary and architecturally undesirable?

If the daemon exits abruptly without cleaning up its socket, it is
entirely harmless.  The next time a daemon starts, unix_ss_create()
will find that the socket is stale (is_another_server_alive() will
return 0), and it will safely unlink() the stale socket before
binding.

E.g., fsmonitor--daemon.c calls ipc_server_init_async(), which is
implemented in ipc-unix-socket.c by calling setup_listener_socket(),
which in turn calls create_listener_socket(), which in turn finally
calls unix-stream-server.c:unix_ss_create().  In that function, we
check if somebody else is listening or if the on-filesystem socket
is stale, unlink and rebind by calling unix_stream_listen(), and
continue.

By invoking register_tempfile(), the Unix socket would be managed
by the tempfile API.  At normal exit, delete_tempfile(&socket_file)
blindly unlinks the socket file.  If the daemon is killed abruptly by
a signal (e.g., SIGTERM), the tempfile API's signal handler will
similarly unlink the socket blindly.  Doesn't this completely bypass
the safety built into unix_ss_free(), though?  The API deliberately
calls unix_ss_was_stolen() (which checks the inode) to prevent a
dying daemon from unlinking a socket that has since been taken over
by a new daemon, but delete_tempfile() has no way of knowing that.
It runs first (or runs in the signal handler) and blindly unlinks
the socket, defeating the safety check, no?
