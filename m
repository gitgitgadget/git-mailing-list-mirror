Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479350;
	b=uhjYEHy94S9gBgPbLGQ285nYWa0nF2JUgDDX+VOCEg8K3YY8CtGY+b+qncoLOw5hEsAQ
	 UIjIVymI4gZESLiReLVC/M6CeS7zRfeQQw8lLGZcYpU1UC7ltzMOezCb9ug32i4EBjbOr
	 FK9pltQ7xe/LRFQdQHJbJsr805RgOWqVVjNM5t0cvfHVH+DUQcHzDRsVqgvfKn1S3hEzz
	 PYIOQm7KAwjxVLbiw6W9n2IAwOqmEe6sUNQZrZd8cL4l9k3Y02V5IuPEMF/JVAu1SzKXG
	 veKfcwBpfmHOdm4Wb9atr/U6m5L4P9HE22NAu6dh9InR430niyYiEyCkXWuZPrPCO/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479350;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4ydyWB+US28Ue32gwNCFrFFaeaUwPypzohYWWHLqtU8=;
	b=hLadzfhUm2R65vfsSduxS3Rtg/tvwH361NcQ5ZkHLScZB6GTMjku7DKY1Q/9EjlgCKXV
	 hOMwKjUMIoNK8P1A28tSaxB/HxXP+0tRWtren03C2uIwb9G2R8LtpE3RyLbylpeJULgkz
	 JKt15uGqNzxx60GTeP6wR9fIvG+Wqi9fG+lkWPEjwAPlpD6rj7MGV2a/rq1ciXEGkhVgI
	 4Izabx38G7j4tF5Rgih2PlMscGP0CURIH29Xj/9LDeI0EvYaROBzAJIdnwBteqkmPdNfE
	 apAzwLrvmM06izEWsPSPAve/bJOZC0ICTL/G84nd35+CWLRdF/mhx/jdm2vOCHJpcmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="bxi/+C3/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Wx7X0KHx;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98C606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E98C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bxi/+C3/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Wx7X0KHx
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB59E14000ED
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:55:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 02:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792479348; x=1792565748; bh=4ydyWB+US2
	8Ue32gwNCFrFFaeaUwPypzohYWWHLqtU8=; b=bxi/+C3/odHnjpfpiNihDMi66k
	UzHToQaaiJNvyLnAP0phaU0r9RKbSz3i2Kw/gG2iyomHrMGmUcPW9OP1JHW2rIQI
	XJSUPBsWYnMb4mSZrMn85x98kA9IYvPb868ZJ2E/rNvOnY8hygnMRb3AW6yeMccr
	4mwWFgs26e+fIjQDmZUO7MT1pWFzPKPSo2K9ULTcRTPX/2OicGh3hrcoYIm6RJI6
	b/Syvk1LVt6wqllA5JgzLkEDs1Y012tm2zLAFQIdAlA+6xvBNY3ZGQND90U12zIc
	sCNuKUnmOTTLt/PRmg5fsBVK8/j5i60LfPaHDbrFGKW6Qw3m1eUNJStmcOZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792479348; x=1792565748; bh=4ydyWB+US28Ue32gwNCFrFFaeaUwPypzohY
	WWHLqtU8=; b=Wx7X0KHx0wlHFS5YrQySdLRb8fCOxpbgn+MlfPGK38VGqL16Sqk
	cZoPuBbcdBHZ+A0xXKbBhbCzenMCqtQFwLTNokI9e7y25eXqJkwD8Yw73AavsBDI
	f9bqWsIFiYT8rFAJQjUt0iegwhsGwjbjkgNNuVY+gEFseYdMIO1I1BlyAN51SHBS
	UuuQ7AVyulyCuymWRAwHEHvXTMOc/PfvA8RUawQNd0u7A44MT0aRanusFDi4uxrz
	iw9Dw1dmWs3PAFPW6lPD1ncq0BEkai+PuqGy5fALFZAqyY3gDhhpgLBd9kTZuZQC
	Wace7B/0ndxo+I1l9QnK0FHgxLQ6tBsx83A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792479348; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fLNq/1tELbHLpyJMRDiHjdhxZ01EjWwuPhe9aQAq8S3GW2Q
	uJO4cctVGP5GJSprWpVGKhpCiI7t809iUz4KUwo/yBRwaYdZ4yO3Cxe4nShCkHFs
	KPKFJ6HAjc6WB9uqCrDR3FaGKkw5eZEHHVOKnvDMBQxNF43Y2+IlUVebODiVXAfv
	KlkyZ8b7QDeeBphaeJ8pJBEa9OCHVLeXfeEVFWqi+6JdCmX3feTp6j4XFc6tsQCB
	jhPoRn8Qy2NHmxwsq1l+STvFPdKYUrafesZpDeM4usr1SjtHguGypqZrESR0uh1A
	2ScI/JYDA2KYiEWVlQE0ZC+is9B+ApgUA1YInbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hGeZvHrZjXenGxVooUPmA5b733k0tYKHrj6c9d/yzgE=:irCnrRHaB9Hv+IxN9PtaDZkO/KXGET+U7LK5A12aL/Y=;
X-ME-Sender: <xms:dBDXar_bw_ZBmzyjgOlNUQjxP3aigeTLQ8108CgJhsHJkkIXzUMuEg>
    <xme:dBDXatvJeRfFP4VlttjTifuK-ylBDkx5fqJV3NRsH1gQ2-V-SoazI6c1CyDVvnqOE
    q4ANfIdQu6r1amajAGBGTkuKo3pE-q5ps6EbQTjq2tePlGobqFbH6A>
X-ME-Received: <xmr:dBDXamqqYp4U6rqzbkNqDoFXJ1VjzizmlC9OP4C10Is8y6ZSQrIC61CisA2Tb-SWNuETBA>
X-ME-Proxy-Cause: dmFkZTE8QBTUqeHPgMuRdAdH/qid+GroaHsSXXQZKbAnOjgj5P0Ed7FvESHf+KlETyuqw0
    cARzeHAfA2eyaeijU+I4OJbB9ep6pjoJPqCntYofWNWsbf/KlddDdlbDDVhJt+i/hW0gXv
    eQvmjnkOIQCSR+LJ6xgEITZQmscIIbVzX9lfKzdHJzwKoAvlEorrjQd5Sjyac/mX1ToN3d
    zm+cxKMVZkxkznYknaMR2CFQBz+EMdHfcbzMTZ9uia9VpYf0xh3O/khObW86PnDLrsCU32
    D55oDSfAkckXcJoXu9yWOR47bF6tbHZ26wR5cKXqL9HU5lnaPpTN1cZMoPBPJm8zAzjnnl
    3bJq4EABn2L6cmDND1jfD9FWxpBTICs3SefePV2YfWusH/htIB1G4Z32y08A1lLMqIresY
    XZ/ptoLYzllZTvlux5WrnxrGiYkrHo8s9dRHg/hSN+oMY0GgNNzVj7wC9J2pFQX93TH6Mt
    77Gqan0vDFCZUh/2cdoq5kQYJuI6xjVWFQu5CZQqvvJh4rKBCyPfvL75iiu7XfNAkvicXe
    sEbXXxK/alAlULlD8cE5q/z5d2+X/IiCyd+Wr+VgigCJ+QxRnb6lrWN2GJoj+fSKb0xjtI
    HlOYSIMzd539o8IGUBiOLJCEPi22xmvQJk4mRyPzN6dPfgK48j/e9ejVtikA
X-ME-Proxy: <xmx:dBDXaikUsELTOSj3ESSLpXgKFvhIkCiiAX_2RnFtGukFcsDojiomWg>
    <xmx:dBDXaizpp6RUmFIGxENZsDovM2OUrCSBMS5hQsf4K-PfsZSzETNPTQ>
    <xmx:dBDXaim7I7FCGLwc8uc6_CaIE5oyCeqB16EFVNwXFVxNYW9KxP6DnQ>
    <xmx:dBDXajc5vnmlGKQ8XtkSL-oqtvtP5v2HzcPi5V91qHKsRO6xrnylpA>
    <xmx:dBDXapq2sn5Ihu9Vde1i8pUfWlx1WN2iPJnmMlNQH_VqpKS9tK3YAlal>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 02:55:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c76930bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 06:55:46 +0000 (UTC)
Date: Tue, 20 Oct 2026 08:55:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] init: show absolute path of (re)initialized repository
Message-ID: <atcQb_V69vvKnxoF@pks.im>
References: <20261020053932.1274210-1-m@lfurio.us>
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
In-Reply-To: <20261020053932.1274210-1-m@lfurio.us>

On Tue, Oct 20, 2026 at 01:38:47AM -0400, Matt Hunter wrote:
> Since 20e38cba3926 (setup: split up concerns of `init_db()`,
> 2026-09-10), git-init produces the message:
> 
>     Initialized empty Git repository in .git/
> 
> instead of the previous
> 
>     Initialized empty Git repository in /full/path/to/repo/.git/
> 
> Prior to 20e38cba3926, the code producing this message was in function
> init_db (renamed at the time to create_repository).  In that context,
> the git_dir variable was updated by 'git_dir = repo_get_git_dir(repo);'
> earlier in the function, to set the value used in printf.
> 
> None of the discussion [1] around the original patch indicates that this
> change was intentional, so address the regression by similarly using
> repo_get_git_dir in this code's new location.

This indeed wasn't an intentional change. I also confirmed that with
v2.55 we print the full path.

> In this case, git_dir is referencing owned memory that is later freed,
> so declare a new variable to hold the used string.

This sentence doesn't add any value as it simply explains parts that are
obvious when reading the patch. I'd just drop it.

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 374ed3a74706..a2628568ff6a 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -248,18 +248,19 @@ int cmd_init_db(int argc,
>  	create_object_database(the_repository, NULL);
>  
>  	if (!quiet) {
> -		int len = strlen(git_dir);
> +		const char *full_git_dir = repo_get_git_dir(the_repository);

Previously, in `init_db()` we always assigned `git_dir =
repo_get_git_dir(repo)`, so it's clear that this change here does the
equivalent.

> +		int len = strlen(full_git_dir);

I was wondering whether we want to fix the variable type to be a
`size_t` while at it. But maybe we should just keep it as-is.

>  		if (reinit)
>  			printf(repo_settings_get_shared_repository(the_repository)
>  			       ? _("Reinitialized existing shared Git repository in %s%s\n")
>  			       : _("Reinitialized existing Git repository in %s%s\n"),
> -			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
> +			       full_git_dir, len && full_git_dir[len-1] != '/' ? "/" : "");
>  		else
>  			printf(repo_settings_get_shared_repository(the_repository)
>  			       ? _("Initialized empty shared Git repository in %s%s\n")
>  			       : _("Initialized empty Git repository in %s%s\n"),
> -			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
> +			       full_git_dir, len && full_git_dir[len-1] != '/' ? "/" : "");
>  	}

The changes look obviously good to me.

I'm a bit on the fence about whether we want to have a regression test
or not. It feels like a very specific thing in the user-facing output,
so it's a bit dubious whether it's really worth it. But on the other
hand, folks like you seem to care enough to make the test worthwhile, so
maybe we should have one?

Thanks!

Patrick
