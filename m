Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962CA3A5440
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770776; cv=none; b=TuapU2oer2v3oBctHtB/ypzg69lbZiFnn0nOUuiS4ZNoLt5/L3DIR7HP5ba+LUD9WjiLY7jPxGyZO5Fn5+nc9YQIi94A4WR9owQKoBBEfD4b0vpleRtbjQ/xcigi9HN5ZpWfRw65+issay5Aq/D2J0TIoiWcTh0IpRmuszv6k8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770776; c=relaxed/simple;
	bh=r2cbuxel+tlIvioRjB2wUOkypzwvUT6DJN0TNPzENZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2hyrocqJwokjt7chlOyQhm47hbdW3hSgou4xwubEPiSUdJGj8psS50+RlP3N1Py7rdyBrlhkdEH4nbc24hYyYNrb7xO68LqUzwTk4JxHp6Xjz+zjl9SQvP4KP/NvHTIwNOZb+b1RLqsg4YFure4chwC67YtozcaW26gxWUwnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uNI+RH2E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIRA0LkS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uNI+RH2E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIRA0LkS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B5E2EC0276;
	Mon,  7 Sep 2026 04:46:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 04:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788770773; x=1788857173; bh=EYdaHY2IKA
	/EOBW2QAwPA7gTkJtRDzZT4/Ja7Xb2WH8=; b=uNI+RH2EGp+U78yctPLdMMw6LG
	95VwFm4MOxhrUKBOa/iGgAA2pl3743MF2RqtimCh3O/RhLS0BSlqzCY1voYdadGH
	S6qh0RXFrqcnT1arzkaB0VZUBRrk1KADUDauLMsvBPeve1NoZ41Y6uGpiQeXnxYh
	QVc31CiNo4BH2h+cRj0CrI+31B6uTO7uZ6X6yLCjXGBITu71vCrtjhmjJ48Hli2J
	X+JGTIOW0hn8jkVq9chWrK6c6dlMrlPh3G7iEYW/uIkEk6R8GFX07u67IhBPStJL
	xq6fK1KMcbxjhbDPEfL6S5+o2vPYedteVraH2I2aHipIl7JkSJV3fMex0bMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788770773; x=1788857173; bh=EYdaHY2IKA/EOBW2QAwPA7gTkJtRDzZT4/J
	a7Xb2WH8=; b=nIRA0LkSmVenfMUSrO1Bc7gQxDbFtr5ys+4sg0C59SxKC8b4X0N
	8TsV27B9tTXFG+GKuppMNhPg+dmFVLns8QfX5ySYA5LUYVgjOxuFwxqLJYY0suio
	s5Wqoi/2G0m/hXQXShxOTadexVxrepc55nE86FCxWzF0mkf2OhxwxAGZ7w6ZhDnM
	YyZy+mqcY1pBwpg8rncvgtoIrGJvvtUVm0qiWoolf4Q76hvIzi2tIoZ8n2QStgBj
	kHAUwmEcav9gkT0srz8QUKq1LM0h2jJXxPIqBQGGhvk7H3McaENVc7fwOU/ux8xO
	8bN47o9j2yb2ihhwGbgXKwdtOwW7TjV5Myg==
X-ME-Sender: <xms:1Xmeak645cVppeRYxTB9KVeOTCmoGnxECTak-JmhuA9SXagPDQXxGQ>
    <xme:1Xmeas5NfJVOqUADNkM74WRyyZLShwFh63ZFvpx86NyTOm9uTA2DUQiJvwCyrjLsp
    tBo3_1nNTi7t3vZlWqvY8siLNXBNDqBXKqGCukiUnxYNqOjKNzBnIxP>
X-ME-Received: <xmr:1XmeaodCph-7IEGzGOzTUo0pJ2Scbo5OaRkbhqnSI0JHf5UgjMEtiQ>
X-ME-Proxy-Cause: dmFkZTGeztIkjRDaKTUxsGf4uHWC380LwAX24z1HpKyDd7QQXbdktCpd1gdmyrfl24GGh8
    6x6FnbM1DgCufyDgw52L/saASXlJg+rLfuursYV3fy2EVI0dvBWJGbRYlRHvvrDay02Uyr
    S6ANA4+UZH8Wqh2leTpRsnRo+lTnAEskxyl+Q2yBCfoE7+AQ9AwfwdlxlOZfcwCHqBjrhh
    qPi7wvfWtd79N5NsnWT1zv9ZnWu/5QvBgW5geE89w+Llu36Oqo90UHsd/wlAGkyVCgQ9+Y
    1J04RCPe6AuVsN2zXBEsXjTXLXRUZXWRlUaAGDHEHnJINUQDDJbSPkgCyN81IeqkoWfoJZ
    8jV6R7RKgDSUkWFbFU5CbE7shDQfa0XJ6QnKBNiLeF4sQAhJZq6H3bzwVvfwRF9P/TM6GI
    +vq6iqmv6t18ADVp2xMGLQp2vQDSJ5nC1DoQCdQJQ48l31pWwpgMoe6XmLjNS7w4n5kz2a
    b63ye7nOfABb44uFHrjcSncaSigT+aOUgENIDu0glkkxl+tD0RwJ1Nt+Riy9KdaXr+4Pn6
    Zm3U6BudkjvbUtVsHAGsVgk/XvpInCscCRAsBC8WZeIcLrU5AG6qEVf3CgCqO7glKoEHaa
    hi8wcy4gJUSNycse8jAfOh399eviabJhnMHxB+2QBfaphtm3KgpeghJf3eSg
X-ME-Proxy: <xmx:1XmeaoCrIxluHyYz1X5UpOJ__JeB4JWWRcr9oMHtete7brbEUXvgfw>
    <xmx:1Xmeaj87hocWh8tqtBUxc0DMiK1xYGjWpGh5JRF8SY7pc3iHUIYiRQ>
    <xmx:1XmearIhDNx6HtJgqi8orYaKqnoT54mJJJUyP8SK-cCOSz2wlMrtmw>
    <xmx:1XmeakhYc4tcpGXwE5oaOU4SO76IKrsQQ2NOW3tbagh-NM1mxUTa0w>
    <xmx:1Xmeag5UF2sf57D3J12C3EJTHfJObog_y5ms40kOCK4u1MkHk5QclsI1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:46:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dcd54f2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:46:10 +0000 (UTC)
Date: Mon, 7 Sep 2026 10:46:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] doc: Make asciidoc bullet items separate
Message-ID: <ap55z8P8i2hqddAL@pks.im>
References: <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>

On Mon, Sep 07, 2026 at 01:15:57AM -0600, Brigham Campbell wrote:
> Fix conjoined bullet items in maintenance asciidoc file.

Not, probably not worth a reroll: it would have been nice to point out
that this is in git-config(1). E.g. something like this:

    doc: fix conjoined maintenance strategies in git-config(1)

    Fix conjoined bullet items for the maintennace strategies in
    git-config(1).

> diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
> index da8be9f812..c778ab09ac 100644
> --- a/Documentation/config/maintenance.adoc
> +++ b/Documentation/config/maintenance.adoc
> @@ -41,6 +41,7 @@ The possible strategies are:
>  This repacking strategy is a full replacement for the `gc` strategy and is
>  recommended for large repositories. This is the default strategy for manual
>  maintenance.
> ++
>  * `incremental`: This setting optimizes for performing small maintenance
>    activities that do not delete any data. This does not schedule the `gc`
>    task, but runs the `prefetch` and `commit-graph` tasks hourly, the

Ah, indeed. I can confirm that this is misrendered when looking at
git-config(1), and with your patch it indeed renders correctly. Thanks
for this simple and obvious fix!

Patrick
