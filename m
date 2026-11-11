Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402974;
	b=LdnZEhT5+4aFzn4j8qihHbEQ02kecIAicOUsfRiWa2VwovGEBH93Fyud8Qlvpef8P11j
	 lskHC6SDBydYk0VOH/rejSvqXf2n8Iy0FmRGm5ismnbb7kFf7FYVl0Dt0BnY0+g8YOKgt
	 Y5FMEOKqMiRzd3/VVTffRBibfSc6eXgx7pRUzc5/Esc3HMHVNDG3kQQxku/c252QPCULe
	 YSOHySc1AtDuL5+QvzJZEX5k7qRhDsJVASZ7vMZbUF72nYETWdP6DM6MykYxeTwXXukMA
	 tUenARvaJxW25NywEpjuz2YzwZO86Jjm4+wZ/chktnZMCw0HQU6syh9KxWErSx5AN+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402974;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n2SZyeIsWaO8zPx+lU8PioOPlHTAmgllhaIg1PHRAZo=;
	b=xVMm17DkfcKjcTMl9T8xsTGYvMuIfUQMcAh6v7cplsrnmuBIrVz2KA22V7irAvkkraG2
	 IOKe06ZBtfqVA8d9U8ZdQWTKvGQ4e8t1RJZ/8b3SjYNufHqeQbcpdVQKcjZtJ4q6A9ycO
	 4LHHnOj0U3pYiL4emmsUAyS97AMx9xJXjjGEQTEmqrTb7lCXcMnORJF3znwuW4Y/VjHLo
	 3H46b2Cf+bRFmKUHXFYusTYmoTmyWniAtlNDNBFwoQpKV+VLeLtU2P29vjw+RM17MFgR2
	 ROzjG0lWtKlb7ZHXPiKoRxTwuIwcjr6Skjo4Pq3/RS1AgbhwfxPD2+RQVui2WjdtCoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=bj0cASiX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CPTxMsW2;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF7606A327
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80EF7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=bj0cASiX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CPTxMsW2
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4E717A029A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:16:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 08:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794402973; x=1794489373; bh=n2SZyeIsWa
	O8zPx+lU8PioOPlHTAmgllhaIg1PHRAZo=; b=bj0cASiXAzoNL8gPJN8aknt0t+
	jibXfaOQcKuc8Epq/KpFk5/DgW3+WUqAVUUDHb2GToNORWe8OP6fYDx3PdimCMOH
	Cq40NqPXp4oRrXh7eObtTWbxx7LnLLw3ezGAhRM5ZmUsIsOBOaO7KC3zdWdjjL9W
	zEp85OhbDERVZ4SPV2XghlFENlZkeQ93/7N1e3Rbg3i2df3voeaq3aoYe0iaywA2
	recTUQRYdPHEJXM7sFLG5oPQB3gjvumil786vfoNKmTPfTWA7czfl6lXjJVD+b22
	m3j1X1OB8yG9+7yzhGIVEi8roWlJqungKFMX2SQD5o19/Sq5yLw7tkzhBj0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794402973; x=1794489373; bh=n2SZyeIsWaO8zPx+lU8PioOPlHTAmgllhaI
	g1PHRAZo=; b=CPTxMsW21CDuyqzd282XJWy6IdeZVvAjWPqBgfvz57uS6lgmp3D
	mUGcM3L0fljSAIxcUMKwL862JtbKKoIadK8up8za8ejB52PNskF+o+GZGlOeVIrs
	HlChaUfJcujQZJkOBGGYW/wAddciRfQY3HASdB8KqbhskoFj67mOXGws216AdwKc
	m4b258vkxiVik8a6+la+wm6vNPfRXy1BAEwaj0rR1S89D8h6z1jE6qXSwE4LWWOp
	o4kBdxyJzPc5aoMGmwxPpKi0YzjPWjH5rBscNDnpEk0VcO483hGG8o6XZKlfFlKb
	ksAEySunU2vbRYml/2WOzpbmePVR/8qXH8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794402973; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:HUOx/jXeaFYQgRp71S6D3YpZ9fnIgCJjWq11b5QHaasDRlZ
	M2kNo+R3nTc/c+sYwc8V6y2LdUM8EsbuLCl9Zy+xXWBjhTFNjP5k1JF3awqqklba
	QMBGPEuIdyKlT3qAM9eBxwzCUJGv1mVPWWGlKnA05qu5KN16FjfbFDFQihZf3E4t
	OlmCopxw36GabOTJjqpYR7PBtvsMA8RZY6icKTUh/18zOlg/D3Xjm3PUdCABHCPl
	8n5n3oSSBo7fPYBYz501HWhEfg3rTcQgf7knz4nOi54lygg9zr7bqPFtP5Xz1TU2
	q96wE23Qno46O3SQyY2LQbWHlCTANPbbFsRGDeA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:o0a0tTV8kxXLvfBj/I0YwLNjUdfrhM0txZbHrcgwaCM=:oCsmlPoBGfnrlZ4IhHxOAzy3MAswO2lkVl1FINP7N/0=;
X-ME-Sender: <xms:nWr0ajy2_f6wobIY8kRW2QccgiwduxfXsBQHoIPuhWxzlu3tMKX2kw>
    <xme:nWr0ahQfpGOV1kLJkmhe8io8OHsoGFSIAoD3qrNOBOSB7sC85K0Q8A3i5ejPCI7E-
    J6dTDkYHLMn5NwvhoT6hPmDLNdW8MKaRnWTV4myH6u6AhbUH7a1idM>
X-ME-Received: <xmr:nWr0aq8phhNbRKlfVtpKbnxP34GOOJTGCRVej1w478OxUGtZZAxFmjU0SvuO0h192a94ag>
X-ME-Proxy-Cause: dmFkZTEm/uCKfwiF/+k5PWvNLwtKkZdpszZpJrwYkZaztWeaibZrEudOToHTKjijp9aa29
    mFtS6j6UI6GIH+FA28ukuIIHBL1mTE6eI1XHpb+Nst01yaVJDeDdIbKXLm7aphMO2YHD0/
    FbHgNCJ3t2U1sK56Z9jGnOzVF7wR3MMx/jZerPFPqdjqEGENWd2WyljOQ/UvxTa2kYTAhG
    qyy8DTnE4dBX0sXrdpEM7h//QM9Xy6a/MYiAq1xzbTbT2ih2GbdJ6Ar0RFdsNgE8dxFB/F
    Y7byPwnrsyBaqEEiwDIAXBTR+BU+pBg7kzmFJ+e8MgIaJboZNNnw+946cJ99iT8MppJms9
    oWQHZ/vFhefnrXo8QDQ5l3ZYsqjtE66WIDDCRfYHa6ctfs8pL6edAWtfCVF1o3GHb085rl
    u30L8/yDKsySfE5eE3vvqCbZ4JmV0kUGgRI9Kujb1sdOdWeWksBSX3PDdZKyzHPkCpFSeS
    NDAa1Mc5IwKliGZFfp4sfJaP01SP94bS9uLdhwv0z3+Gf5fUE+d314hJeKC+ilV1vljTwX
    01HY69B9zyYusxwu4mKnzs6mcZvGpeb+NHHMoUNRafRZa9dhGl7J0WjxYDH3OnvTSCasTJ
    0UnCh9Qy3FvlPqAnv1fnhoGprXdEcDaOVWeW7rnzAUaXnpSR8l9VKnQjGPSA
X-ME-Proxy: <xmx:nWr0aopCwTAz4mv6X5t_3UwJBM1e7e8QBNBAYiBnf1Q2cyvV0rXJ-g>
    <xmx:nWr0annOD1F5G4vE07pGJKOsSsI3ibN4BsituKe1o0UHKrGo0Pr3IQ>
    <xmx:nWr0avKKX5pP6eb5gnoemGwVnbxXqI6w8FzQGVPNE8qdoV04axqHCg>
    <xmx:nWr0asxHMGBXJvyXEW0bSFil4j3XqHxDprgzJCiQUcglHkoPbk87Hw>
    <xmx:nWr0avi0dACHHzr7aQiWxzlyUvLo33nCEXjqkkfYc4oi-IdRgI7q-eBE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:16:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 853cafaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:16:12 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:16:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] tmp-objdir: preserve errno when directory creation
 fails
Message-ID: <avRqmRR29QSbj1k4@pks.im>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261110002251.2007617-4-jltobler@gmail.com>
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
In-Reply-To: <20261110002251.2007617-4-jltobler@gmail.com>

On Mon, Nov 09, 2026 at 06:22:50PM -0600, Justin Tobler wrote:
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index 5307717354..4b91d86787 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -148,10 +148,13 @@ static int setup_tmp_objdir(const char *root)
>  {
>  	char *path;
>  	int ret = 0;
> +	int saved_errno;
>  
>  	path = xstrfmt("%s/pack", root);
>  	ret = mkdir(path, 0777);
> +	saved_errno = errno;
>  	free(path);
> +	errno = saved_errno;
>  
>  	return ret;
>  }

This whole function here is somewhat pointless, it's only really
required because memory handling would otherwise be awkward. That
could've been avoided if its only caller had a single return path, but
it doesn't.

No need to fix that as part of your patch series though, if you ask me.

> @@ -163,6 +166,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
>  	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
>  	static int installed_handlers;
>  	struct tmp_objdir *t;
> +	int saved_errno;
>  
>  	if (the_tmp_objdir)
>  		BUG("only one tmp_objdir can be used at a time");

This could've been a local variable in each of the two blocks, but okay.

> @@ -185,8 +189,10 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
>  		chdir_notify_register(tmp_objdir_reparent, t);
>  
>  	if (!mkdtemp(t->path.buf)) {
> +		saved_errno = errno;
>  		/* free, not destroy, as we never touched the filesystem */
>  		tmp_objdir_free(t);
> +		errno = saved_errno;
>  		return NULL;
>  	}
>  
> @@ -197,7 +203,9 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
>  	}
>  
>  	if (setup_tmp_objdir(t->path.buf)) {
> +		saved_errno = errno;
>  		tmp_objdir_destroy(t);
> +		errno = saved_errno;
>  		return NULL;
>  	}

Okay, both early returns are adapted in the same way. Makes sense.

Patrick
