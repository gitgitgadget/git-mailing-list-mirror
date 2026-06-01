Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A06346A15
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357994; cv=none; b=FzwiyHdYRQ6K774BhwRvqrwS7xX2cOqoPFyAlj+ctXmCi+bEeY7i1+KiVh61B20y9HSFwjyJijuUcCa2WeK9yPXlpd1Ug1BwH3eB7kkR+fA/Wn3HplMWxXPCAC4gl35g9PL0WLg+mWJe3Su/HkEGbull9UdjFeoJ3VPy0vJMdlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357994; c=relaxed/simple;
	bh=A7ZNF5JS3LVkIlKtv9B1313/mquu2SJ1v9bn0Q4C/h4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BvJmBh7BrQOgJdxLIhsY/gtCeGsM/nJsdF/aao94DQMdC0bx2rHuRMGqeik9LBrKKFFj4l4UjjdveQAHxnlceCRvOxzTUPnlfD+vxDPRnkV54A1XSr+5EFrrSSgbsL+KF/RtT2ZZ4cwBIViw3zjsgjDa5ZfOKdJpK1kPIOLga7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lum8Ej86; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpT7h3mi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lum8Ej86";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpT7h3mi"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 0CF6E1D00085;
	Mon,  1 Jun 2026 19:53:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 01 Jun 2026 19:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780357991; x=1780444391; bh=Dla/WpeQMu
	waqUd0VX2Krnf3XHgmtzrWjcdnqsSkC8w=; b=Lum8Ej86mB+jlyQN9He9Er3XEF
	6mSrZ+I1v5nDUh/sL4KTjkIe7HyMG82/GZhGLQPrxKg3Y05lCoJVVV99pnqyeXRi
	p5BY0lSqwNcgeHg2tLkJEqXlbwzQtCtuSCajmiJKAH62yuhS4aWjMPAfqbI9DulF
	RoDqNs5r4VHUsTxBuoz4fzX4icroC86UcwT7FGxImPl8CGlgqoats2cYpSUtcYmR
	ShwcK0U6SVJfJMVLLued1o4ZukYTEeRczfmhwzRDyF/fCzmwOL84WEbX+UGzEUht
	oFFvSHpG50fj+OH2D1ebx4nctOhmL6PqJE4go/cLXaTy9hBIIqqOl+ocLnWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780357991; x=1780444391; bh=Dla/WpeQMuwaqUd0VX2Krnf3XHgmtzrWjcd
	nqsSkC8w=; b=LpT7h3mih3BTkrY4dB4pz6N32NEzANryyvivbMpVqC8YQA8nQNX
	0ms5W0nbtib/ewLLjyQkYsqyT2dPDOQfJq+x2QKfyL9b6rPubwbhc3I2Mk2oblmL
	a939SKabSLnVibIgv30CQvRpAdF+Hj90JuhF3SfVfUjbWs0960d3Z0K6H8rJWJ5x
	bcAJUro/VRoIEvabiSv4+LS8i5wrtGMJDjiuQx8yaiiSloacVHo8QbDtcfZAhCs1
	y2YmMqCRiIBH0PicU0SiA7A2T9pzQkfUBrDvtZFxnKJXuRjl4zeh9pBmHYp4cBQo
	PqF/K9QutnWBib6JyD2R3S8/giiZhCBA62g==
X-ME-Sender: <xms:ZxseaieYiT4Arpu353n_4DiNbvoy98WAguAIg_mTb0ElxKSUbMWrHA>
    <xme:ZxseajG5aXA_Bx_Okt5gT5i0KytmRnX3-qpDBuZriDr3K4Br-U5M5BZDmttkrzAXH
    5ZkMxypIqAy8TUeqbB_3T3Rh7fzsg7cuCiiaxIb9kYCzXOR0iV_xw>
X-ME-Received: <xmr:Zxsear1ypLMcG6g7BbiiI1ZLUFytyfL82inGjewV-JnLxKUFWpUfeGLhrysO73ahPlzJChgopUmcy4pRA3J9TX76P511ZqrUknny>
X-ME-Proxy-Cause: dmFkZTGbV07Aqy/Tm6v8ArqDjwXkL5Nd7mBLKvW+L18cQywILbt1BwGEvYlvomnGPtJOsN
    4VVFGDHEwWVnZBHWX3SD1+Df5J7y6Azv/ROs0WsK5/o1hO8reAplqZ9ujNeY6AQKyCXf8L
    eQ5aCda50JyGzb6Ba7n+hNW+SGOzPX8KDrU+t1JQb8SDH6isq2Skkd/uNeSTSYhK6OLRDH
    DuwmRKNn1cIPRRzDyXc0CWaO16MqOPHekrG1wHqLfkoWnez/Gxn8x9OUKHx7IHdPiFCQXN
    KjwoojJKvYw4EHrhcJoFLzgtWAVPFUC+Be9qLW5W11xyljvJSJaUFpPVkzMnw7VpLCy1NR
    jnlr0sLjqX3TxN7TlkgvPZUTBvVLJ/rs9WEJchMCAx126QJ1PBJaUNHfYBvBauZ5Lwdazr
    XNSQA0OvmJj6M3JpUrqcK3d4m9WDiTMnASgYbic9HBZ1vWyT2F1ktxzAUnNGS1aRBwGmMD
    0Z7e08e62LzzzQ22XmMaQrZTkut71ToS5A6Gttv4NsUhytFmV4pVT/TMCHnmP4RxSy82f9
    J++wVrbua/zGLg2dOnqPKlMu1pGAy1sK5CFMdovEfi+KymajcHPbpuB4kxoZj22Pv/9OTI
    O7WuEGgfERsrg2F9yMdEN3f9O6uxdLAwuphZsw26IKzTzbvJ09ADeOza9GmA
X-ME-Proxy: <xmx:ZxsearnS922K_-8UnaCR4HhKOgwpptFeBZ8dMlQ0JBp1OrY6bmTCHw>
    <xmx:Zxsear-reF_LW_N1JOOVU8vYsnNlP0RD6HY0VFVq7uob0E7_xyp8Ww>
    <xmx:ZxseagoUvwp6tvgXwZOKmef83-ZXiv9gBvd30KthV_4J0ROrqAmSiQ>
    <xmx:ZxseaknMzboJZfzFiWeciy2pZjZEyUC-kl4mcAEMt7I2MglBGX44_g>
    <xmx:Zxseai12ugVZo54WmOXoiuEuxqLadjFWMbLe5cmYWIDq0TjbV-vbmrCH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 19:53:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4] config: improve diagnostic for "set" with missing value
In-Reply-To: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 26 May 2026
	19:21:27 +0000")
References: <pull.2302.v3.git.git.1779697995418.gitgitgadget@gmail.com>
	<pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 08:53:10 +0900
Message-ID: <xmqq33z524yh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int is_valid_key(const char *key)
> +{
> +	const char *last_dot = strrchr(key, '.');
> +
> +	return last_dot && isalpha(last_dot[1]);
> +}

None of these are valid configuration variable names, but this
function would allow any of them, no?

    1foo.bar
    1foo.some.bar
    foo.b_r
    foo.some.b_r

or does the caller reject such "key" before calling us?

> +static NORETURN void die_missing_set_value(const char *arg)
> +{
> +	const char *last_dot = strrchr(arg, '.');
> +	const char *eq = last_dot ? strchr(last_dot + 1, '=') : NULL;

OK, the intention is to see "foo.bar=baz" and guess that assinging
to "foo.bar" might be what the user wanted.  eq here would point at
that '='.  And ...

> +	char *prefix = eq ? xstrndup(arg, eq - arg) : NULL;

... prefix is our own copy of "foo.bar".

> +	if (prefix && is_valid_key(prefix)) {
> +		error(_("missing value to set to the variable '%s'"), arg);
> +		advise(_("did you mean \"git config set %s %s\"?"),
> +		       prefix, eq + 1);

OK.  If is_valid_key() rejected invalid variable names correctly,
this would catch $A=$B where $A is a plausible-looking name.

> +	} else if (is_valid_key(arg)) {
> +		error(_("missing value to set to the variable '%s'"), arg);
> +	} else {
> +		error(_("missing value to set to a variable with an invalid name '%s'"),
> +		      arg);
> +	}

The distinction among these three messages does look reasonable,
provided if is_valid_key() gives the correct result.

I wonder if it is too hard to refactor existing logic (perhaps it is
used in git_config_parse_key(), no?) to give us a less noisy version
of it that we can use as is_valid_key() here?

Other than that, the remainder of the code changes looked reasonable
to me.  Thanks.
