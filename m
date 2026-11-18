Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973656;
	b=vQd7WVWs2oV8c9DZ5tLL2/mnUVt3no7j8vwLK1pUxWh/ZTsVxWSiK5M1G70aS5ZuvRaN
	 qUV6wmn6ZX2PAhjLrbP7H5fCXmv4xlFGF1+Z8inunt8b6viitQu2u0Dw7NVXxtA0sOiH2
	 e/eNpepqG2Z1CE4U697Gpg4k3T/bkSlvzf5A1F6iGBt9DQ9lP7XBElUMlZ0CXaUCHj/6D
	 npco+54Odnc7GzMOp9s3iQKZ8o2gUlu3rX6ra5d5k+HK+6zfDQ7nJnfq/MBuM+LncMGjP
	 LZB71PsOlSUjYHGoR/IbqAKqUMxrs2NJkiOpXT8xe+dpCPZQbgOT+leKkC7RxUR32vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973656;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Qu6NXeOv/LBTrfc42UQ3SI4OROb/6SolEjxAuZIfsK4=;
	b=xVVqqU6YoijR1zU3W2jc1cvyTyvgcwfkL0UT8j4rG/L9bRQWWEaRpGW107b2Af4xtoRs
	 i7gKP7LZpPTt6AkHEe0SbxiG28l/DVKjaG6B5KfF7okCi15OwSvP9VmbcYWdzncuPhFmp
	 W25fJW8wOZHKWVd7A5ciVjaLYyFdzxrGNKa6ixPCRe6kxm5DQfFIWwjlOY6vmYgINvFe5
	 b6OXmBlbHo3xcPFXzY31DuYrf5xf99OoUPnJ9WG5kA5qo5FgvdIHxS4NO78lX42xXTfI3
	 HChumkBJb1/AAqnZl0e4zXV1d3Mot3w2iF8Y59QocOCDCfzvprhulnx/8mCiKPIgD2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M6lrkaa1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rM32xmg1;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207A606A332
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 03:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7207A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M6lrkaa1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rM32xmg1
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C49757A0281
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:47:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 17 Nov 2026 22:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794973654; x=1795060054; bh=Qu6NXeOv/L
	BTrfc42UQ3SI4OROb/6SolEjxAuZIfsK4=; b=M6lrkaa1GVf6Tz3jx/MQVyv2nk
	VwJR79sZfx+ZqDOvXIf8SDuu5+ipZMiN9rq25mCDNExgBj+ILpy12x0paIk70Ed9
	MMtmCtQ2Vu/D4eJ56XYdniG31ems4eKtBiIWv6J9vX+pZVotEBDM2AuLXuwBeA7q
	UWs6R1aARHUEnOaxGBQM3mcbZXRRJolNkVp5eETCIh0ROj68Q+pXUHbB3E6nN9QB
	tRztPD0SPtAMg9yBIDgSTIR8H2Te8udOWXXyHzrgX47AlsQ9KhOKjRqwHcNZAw/r
	NS9dLOilsN/3QsRG1IwGPzzIJdOtyO5Pni7dE0NSoXyTNc6zsJASUlH0QcrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794973654; x=1795060054; bh=Qu6NXeOv/LBTrfc42UQ3SI4OROb/6SolEjx
	AuZIfsK4=; b=rM32xmg1FAZgEOkxRUgEUobuV9Lym2AzjixDonKSMhQ0xpp02L8
	m3JCyPBlfZcjLnR/1abILnMkHg4+UwORvklhNxjX9fU7n6cMw9jU2bT7lFDuLXHv
	kJYJr4QhQlJG2UIoaVOvpPH4keLqEN8WOo/6j4efxolkhHnbdvcky1SBnuNmMHQT
	XeDQ4iisSndAQUO+0ztA6vjJBRkq0yRA/9XQH1S/8dRa46TsoqGd70Zw92q1ORh2
	ZNUjQK/DFBIC7zZao+amj+YhiyTyiOqG5GlxVuKDyr6N7z7RV+lFbtG+KmE7PTyJ
	5Lbrlbsggx6XMI/p9rKHdpMWYIa6RvRkn4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794973654; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eIyZtdq+F4Lm/v4y6pWSyOEDBQ+fdzag8hP4ATSTDYlbsNk
	3zGHquFnI/zfSpiGg6RNktZGmP42CW+NBfTFEZNuCc6bwaAkTpdKB8gAMq1sAYQT
	guXn6UB/sPi0Lu8Crpqjj17uEkQviRVvxfsLD6Y0BFrjdvUuARpN8kpA4slm1SCz
	U5bVrw7PxdM69ekcxAHzOKGAxu+5szGswBRvVSfcjt3/JrwWq6i38sHifulvDP7l
	5nNfzC7IFxxQjSDcOXMz8c+jPx8U00Rxb3lLUmz5qTEAqBMYTuSaUkgjxZ4a0nzD
	RR0TjEP0CbVBE2ByOhBlrZ2N/XnHoH80amhvcLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:f+lVqDmf+/d9VwpUt7+RwxfNTKUhfMxyPzqNqMXUX5A=:prPld3ioO0flBAukxjIOjeuRbdAHPnnzWeXlWr9DY5A=;
X-ME-Sender: <xms:1h_9asmFr7w5f46mkDN2Z5qSVnaTsAUmNblhHXH-K-PcbAp3mNtYvw>
    <xme:1h_9aitzZ8cf86nrTBT6HqEwEMGG6vZsscYqrI6tWMIpXC4Qz6XdQXFWSpR3Qlz3d
    v5m9RdEyObHvHIt9cBzr4zOT7_VlG4jFffgL1CCe9Ofa2d2Hy0IkMM>
X-ME-Received: <xmr:1h_9ai8-O_FbSEhXpqUNWcnvoSQ3-hSDLOXqkZXgIQwRdK84C20uuuXaSkCo23zZ2Aog6oe3D3n6WjEyho-ZCHOXM2mWC7pcShm_>
X-ME-Proxy-Cause: dmFkZTEgPNr65On+fiOda+NFq9mUIx7QaJSrQgYWabRxJqnzGbYqQA/pRGnhnaZ5ooEhER
    dmZa8w3ASpo0AwujRqKAHepZK0JBgZjMje+FHCFfV7vNAkjuleke7US9zBFP+/dQQWyirF
    2OOpS9Xcb/mSDY+1CmP2J/bdVEZHGxqpxPEYeMbHYuCVU78cKqYlzVjRnXDlJ/85rc0P3I
    0M0tuPpK/iIYeUZMPVf1tp3/9ORXgAz1SUNOTTpqeSjV8U0KfFVvgw2Ml4R1LBdyP0zG76
    ZNIdT6RQLHvqVDu/maT+/AUuzgVpoJrKFNQW8wRNt/sd07gmzn/ZWxDf2a5wJ8BIYWGAjC
    Ym/2aXx5tKUiSAqKDtTN9hAaiFoxXyG7HZz58cPUzdFqhus+intF0wszrd3hxC4nRZaBN2
    +xVhw7JeJ0WBTzJqEwCYgaATjFOflrhHyj7lFqg5rTsMyoRoICP4DhUUxgf7/vz2zpAjzz
    fjTlyD5FhMeJ4yNaTU2vX+FuFK4bywU0wzVHNeDaYXdxJJ3CnILiGb8XZLhro07BdYhctH
    qL4ISh6UWZbf3FNt3RFGZrQozqzRuNVhmj2BiIV1+lNx5JRTEQCboX/Bjw5FutQa+iKBvl
    Z/IDe+og0dszIh5V5IzyzpVuyN6fgxUUrzShi+pqgbXWAItrNrSKXJmkVpYQ
X-ME-Proxy: <xmx:1h_9akPeDIsmSM0KIdkeSVwsgj3YKyDq06RSmbr9mWG0FpSV4zkljg>
    <xmx:1h_9aoGRBPnlbm3phm3j0GHZdJGMlVmVq2qdXbN8_JhfJTq8AO0NQQ>
    <xmx:1h_9aqQzlCZ2668dMsaQ4Q3aOeWlRgToq6oZ9XsUiwGm16K3mqSkCw>
    <xmx:1h_9atuc6LwrWJ7cCVdrGUnQHnpleOWvlN4VtbOpV0WZ1qTXjf4cjw>
    <xmx:1h_9ap2C8B-AcNUbI31h4jRlUAQcmVNiZKrmE8_jyRo2NblvM-WjOL5k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 22:47:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/2] tree: use size_t for the size of parsed trees
In-Reply-To: <0b1d1c5668c89e3329e246d787ec80a161bd1dac.1793357680.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Fri, 30 Oct 2026 11:58:23 +0100")
References: <cover.1793357680.git.gitter.spiros@gmail.com>
	<0b1d1c5668c89e3329e246d787ec80a161bd1dac.1793357680.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 19:47:32 -0800
Message-ID: <xmqqh5he94x7.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> struct tree stores the size of its buffer in an "unsigned long", which
> is only 32 bits wide on Windows, and parse_tree_buffer() takes it as
> such, although repo_parse_tree_gently() gets it from odb_read_object()
> as a size_t. Callers then pass tree->size to init_tree_desc(), so with
> the previous commit a tree of 4GiB or more is still truncated on
> Windows before it gets there.
>
> Use size_t for both. parse_object_buffer() still hands an "unsigned
> long" size to parse_tree_buffer(); it is shared with the other object
> types and is left for a later change.

Sounds good to me.

> diff --git a/tree.c b/tree.c
> index 53f7395e9f..d37b9bc7b1 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -172,7 +172,7 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
>  	return object_as_type(obj, OBJ_TREE, 0);
>  }
>  
> -int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
> +int parse_tree_buffer(struct tree *item, void *buffer, size_t size)
>  {
>  	if (item->object.parsed)
>  		return 0;

The only caller of this function, object.c:parse_object_buffer(),
has its size as ulong.  Even though this alone would not help
end-to-end, as a "one thing at a time" step, this patch may be OK.

