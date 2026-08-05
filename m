Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA613E0226
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916768; cv=none; b=LUGzuX4H6CPEgi/+MGf4O2R3LQMkDWDdwLFCVBVUkPNGU7CZZifFQ83znFTEbfJUIauAiZo//iMJb8owykKgB6mymE5N9oftPfvoDdZgZGuTS7P6PPC0E1J53MK9bn2ipdGiowJU6qtVuF+CIFkikuJt+STa2YfX14J3GPk1xt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916768; c=relaxed/simple;
	bh=cN4vavReustKFt6k6FxuM/lwuGCxWzeEXCjSgSfblqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+ZYWI3Y9KLVjo+GUGna0FBsqFAi5E11keWFYSMx/VQWVE3HP5SVZiLnZCAkiAjFwHAWDnL5NxSycqK+vlNG4QFh2fz6n0bNr8+dPrIAPCnriVEPkq56L1QM56Q6D4zctLWh5ckUO1AvcOc0FLb3ubSon46tFYPqU6jf6epmSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GsiEuWQL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yqmc3+TU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GsiEuWQL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yqmc3+TU"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 579D6EC01D5;
	Wed,  5 Aug 2026 03:59:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 05 Aug 2026 03:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785916766; x=1786003166; bh=6p4ElkgyWl
	3dPJ77ojwH7cHFwOTao+zHS0J35b9I6xY=; b=GsiEuWQLT0vZ0zw028qxnxtIeo
	GlFLjaaIcAqvIedNZOEdQZ5kJkS7v/Yjlc5sTuH+zGS6k6RpxJAyfBf3ZHAGng8G
	UaeRWJ4z3qojAm6HenGpEVcFQpfD6SJGwz2YohqLLhYa6N6Moth64V4gLHFI9oBO
	DZg6CtHBlV1dytUUDbrYDuDe2OFSKNqQdcHux+uTXbZOg9mnYKb7t5Ww/82x0auD
	kcOkpa0ArnLT/9jcI2n29TRwYdV5YeJ7D+yCsrPV88OGWVYV3B3DnQvezljHg1Gh
	0Dd4FU29IkZO4a21i1/gcaJtRTjGBF1qRi6xRO1ZQLabSyaboQcH1cHSBN3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785916766; x=1786003166; bh=6p4ElkgyWl3dPJ77ojwH7cHFwOTao+zHS0J
	35b9I6xY=; b=Yqmc3+TUYnrg7XtFO+RnatvMYnEj6icKRk0laTdQYU7LtqAE5Jz
	UjYDMwt17NHL/kODLmdHY1nyC/jQrejnkIM8iLe+lLTObNyFHTEOPT3wQHHjmpCc
	bqufjsnHLcRj7i2ZZTgCUZY7Na3+jqLSQ/fYPQ8L/3WX7ZKYySItfHqzHF3LF2cU
	XoFYxRcgYL56T16SwpyANd6Sxl04wUuiS5r8QA74dbsrsWAoskxPMmHsfyh8wYYG
	6MTelpROrFBL9RPuGCmPnIzc8Kf+qQFap41RFrL84TcSqvWoAT5sOu7M6+vcev/i
	GjxaDRiSkoNchjOzxuGQu4CE+qD+7wo0AmQ==
X-ME-Sender: <xms:Xu1yakTQbFJjAxYHtoWrZOMm9VRnRNrevatO-tdYp5wpZjLf_RKZLQ>
    <xme:Xu1yakWl1QRvJaIOz99VUq1pz1ihg4SYoLMJ81SoosQ1zj4ajpO4L2d3O0vSmShEo
    ZgTveTnqR5-OQRTmV6V2NudMipHUqms6B45RwtS-fFZ_qry_capwQU>
X-ME-Received: <xmr:Xu1yalcxLbrIDdljjfiu7Y8B4nfcidDT5F_pOeAzV7EB8hxt1kPochlZXFsRdWpQBIsQOGiG_oYslN2FwY7Saa4zahbWQFGj2s1XFTEDVg>
X-ME-Proxy-Cause: dmFkZTENRfhMcY8nzzQL8Z/Up8alfoL4fsoIDwMnpKlZwYzzuj5v70hSWZvwpiU+pxr+X5
    ocia2FNcX0Lo4bEayi4BH6q2wbxo6xpBEL3Oq+wRw2xBm/vkSFLCb/PneLINbLpL317mgT
    uW9m5f0X3Xli8X+tgwE9vWDmX/GbYH0OMmpHYRfZr5xJEUJZaMCj8U03fjLN/Ix4NpW6L7
    1ed3Pna68qrnWGt+Hzn8Ci1x7fehzwZsTDghWnm2py80HP1MNmLNRGczczwsuGTMma7/Wv
    H3peJg+0/HXYo/K9QZ8C74CxIMZXXj3eDm6BMVVp0bRkIsXJfGOJKUFAcBSiNeIB4JXdXV
    dR+iOrbRcToOt/XKos4+107cYyou1AbUgpV15BRt+bHL8CPdEIXmk4NUOyzoTJ10lgEdtw
    YH7hjLQ3eThTpxelyMzFyMAfCn7+PlWCuhUyxFi6mS7EX+NJP68b27263ksrfcZSDK6HDe
    JIwThwoNyxQTB8FK30L9SZwuYYLswlGAfbhRpZNqwhSZsv0R5h97WHzF9JE4HC66Gvg8if
    OdIC1vHiNomFU08QElUvPAmGLRtVmB5H3KGPHf8r467d4hkW2Dm42b1/NyEl5RCdvW3P+I
    BwkzpxX1EzHN6J1AyX5OWSdTRXa0pp/JZJJTfWRshRVoaVaofotAkZZ3amgQ
X-ME-Proxy: <xmx:Xu1yaoLhUtvd8MBSwxqzz4SfBM1vMCeV9Ost3FSvJ52opb1l_Kkncw>
    <xmx:Xu1yaiwAPfpe3JK5Z14OUZuVtUN4pOnoNi7A20NTpjkoUMhA_NGoRg>
    <xmx:Xu1yautQUryBy_TUQ5uVyYtMc1VMo0_weFM2B_RcTORxFNj_DX4CmQ>
    <xmx:Xu1yalCSak9bamVQtRBjxcCnc5DAjCqSqQa6TKaZZC6egBCWmyBBEg>
    <xmx:Xu1yasw64PxVSZMNPETfnWsjfQC2kbQ7M3AxqGHlyV6jGJ-sMa6WB_u4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:59:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98776c68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:59:22 +0000 (UTC)
Date: Wed, 5 Aug 2026 09:59:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
	Paul Tarjan <github@paulisageek.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
Message-ID: <anLtSOKqgcCrrNHo@pks.im>
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>

On Tue, Jul 21, 2026 at 05:04:56PM -0400, Tamir Duberstein wrote:
> 56cef9cb1a (fsmonitor: use pthread_cond_timedwait for cookie wait,
> 2026-04-15) limits the cookie wait to one second so that a filesystem
> which never delivers events cannot hang fsmonitor clients. A client that
> times out receives a trivial response and scans the entire index.
> 
> FSEvents can defer delivery while it batches notifications and does not
> guarantee that its queue is drained in one latency interval. A loaded
> macOS system can therefore time out even though the event stream is
> working.
> 
> On an Apple M4 Max (16 cores, 128 GiB RAM) running macOS 26.5.2, two
> worktrees with a 1,001,178-entry index timed out 484 of 545 and 297 of
> 365 fsmonitor requests. One status call performed 934,519 lstat() calls
> during a 47-second preload and took 52 seconds overall.
> 
> Ask FSEvents to flush pending notifications after creating the cookie
> and before starting the timed wait. Use the asynchronous form because
> the client handler holds main_lock, which the listener callback also
> acquires. Keep the timeout and the behavior of the other backends
> unchanged.

I cannot really say much about the FSEvent interfaces, but to me it
feels quite reasonable to flush the queue when we are waiting for events
to be delivered. And that's exactly what `FSEventStreamFlushAsync()`
does: it basically overrides the latency we have configured (which is
1ms) and asks the kernel to flush stuff immediately.

> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 4161dd8282..8e32b5ae5e 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -206,6 +206,9 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
>  	close(fd);
>  	unlink(cookie_pathname.buf);
>  
> +	/* The listener callback takes main_lock, so this must not block. */
> +	fsm_listen__flush_async(state);
> +
>  	/*
>  	 * Wait for the listener thread to observe the cookie file.
>  	 * Time out after a short interval so that the client

Okay, so we've unlinked the cookie file and the next thing is that we're
waiting for all events to have been processed. As said, it feels
reasonable that we're flushing all events before we start waiting for
them.

What I find surprising though is that this is supposed to make a
difference at all. The latency we pass to `FSEventStreamCreate()` is
1 millisecond, and we wait up to 1 second for the cookie event. I would
have expected that batching events for 1 milliseconds should be totally
fine when we're waiting for a full second anyway.

So given that I cannot verify this at all and that I have no clue about
the FSEvent interfaces... do you have any explanation why the flush
seems to help regardless?

I _think_ you're already hinting at this in the commit message, where
you say that it's not guaranteed that the queue is drained in a single
latency interval. Is there any documentation that tells us what the
provided guarantees are?

Other than that the code changes look sensible to me, thanks!

Patrick
