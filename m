Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADF40E8E1
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697498; cv=none; b=HU3nZAEGZ9qHCbLE1AALrahc32z9FpPIP+KYuZxPkQatQwppF47dC7GbpXt6cbBFw0ZcsXIpX2Qd8uPfV8P12QquC6Z8+QqKDcouB/lHgZpUZohSmGJTdo9EqwQ47Qz6D/ukdau6rzfmwLhDrh9zFA3gLH8SsZ7zYcXgMunlw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697498; c=relaxed/simple;
	bh=y35E3FpT3Okb8Q9N9jfDe3wWWhnJpVoaHIXRCVkQ1Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uI39ZUMUGB/FW481yZ2azGxUTbrERmQmKin7nM8HOLib0fMWUAk3etMipcwxRT6383yU/GZdQoeYBB7WW+yFHMWmg10YS7h1pMA0PJLcMzF7ZN/RFw2Wn2nBLGSChVpcLegVlXV5cwpaeLnhy3Vfs/iSghUhrD6ssr9+fjLr9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lfxxKWpv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HcjiBDE3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lfxxKWpv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HcjiBDE3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B99C67A02EF;
	Fri, 14 Aug 2026 04:51:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 14 Aug 2026 04:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786697495; x=1786783895; bh=e67uW0aeUG
	20qjhxWhq+St6EiA8CTHSvaEz+b4N10rQ=; b=lfxxKWpvhbs4kSC4dGkejoj6AM
	JRNIow4MZk8vzdsm9BrrcEFHI1cukXjzTl7ocrTG888zvX5QdGsbUZBPr5xzpv2P
	cvq2PqipwV+pEiqhL4oMv1igvhbx7ZJb+ElEipCJjn7kRnhwYbPFulH4oCASDCsM
	tgytWWLOt0TTL5bnxtWrrsPi2ocNlnA7zHzfIa2XQS6oqJhUEgJikZB3QVRxfUSt
	Pm6cbz2qwE19/kxm+k29xwJFHnynxL/EluFbQ/ffdTRYFJpQv1zQuCPwa7+k2Cq2
	NiFxC3C7kEj4bmOWoaqIXOdl/6/fWu4pAmQK2GcG2EozDEY7F9yivuRMgHQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786697495; x=1786783895; bh=e67uW0aeUG20qjhxWhq+St6EiA8CTHSvaEz
	+b4N10rQ=; b=HcjiBDE3j5zb2Oz9XJLerZcbFfNP0tAE+Ijlz3amiiFCBhM/Vrl
	fiQY/HAD1P0NnzwyXgXxlKe8HsyuWJAtBJu1ZDVBg60n9kgD7kENKAtJ+HuyAeco
	yI9JM+AdJvxAWB/G3qhfEPtVwmlQcjHCuRptzQCRSPG+lDJqQ8dTpC6isIRuAV3F
	tgGnAQ55+oGql203VA/ikdthPjjobcHuHVsef1a9Z8rMpms0p9cVIwHq632mKRZe
	9pPg5IHGx7hpkAxWE2hOFWCx2fXQPHorGb3EjcJjaJAWvsBL/zufV5b47n5/N8aR
	qP1M9y1DgCxDHGA6g7OUToGX7P4Sp+oRgLA==
X-ME-Sender: <xms:F9d-aug3ogQvOCyUaPpMSH7mQ27AKNZfZGGFtF7A7tozD56HcZSNdQ>
    <xme:F9d-amc1_iJ-ddmPst0r8T0sA7RzCg6iCzoOON0TNrKEW6QTSO01TrnVhgGX9d2ba
    q20owoZabnfbmRrs7jmsdb2mMXtZFs0eLlOcGIGBGPmNyNca2BiaQ>
X-ME-Received: <xmr:F9d-ajdPqQvtDiPU-6itett55cI3-FjLKY_EGBrUbU-4jrI8-XBxNq2VaWaNQtwLFS3Vx9sf_FfHZqpIDf_XJ_MKcpbycUzU0wQC6sSYRUo>
X-ME-Proxy-Cause: dmFkZTG3zObUeNLVKvaVuT9NRLcWNA0fEaYghEiuaa/lqTwLUZPDs0nr6XQ5Lz0+yTKjQO
    j1ZrPeTGEFuoeerzV2HpLmg4wZTUMciWHlPfTX4wbgFNSGRt+8UG0NIPSceZPoWAtH/gWC
    dV1F1wFNsjy4W3AAGmLdR9ZKfr7M/VrDKwnBrFJCt3tHozUu7Au2IwYv0ZduvmIeafkTL9
    lfsTvNi1Gx1ro0Pki6AaNt+qWS6Q/c1154ApMz64avkkoxexKtcyEP+UMKMratuZfNNM4W
    lfqf9hjtWgDqSoBKiXkE4Lj98pALxKnqckHm4fDkyo3JVFVRCT0tQWNM6JVEAMvFoToPAf
    ghrq6hlHYFsD4iRvPE6VpkcVdB1SqpPYBEnAFERNOB2Fx2UjBTJiqvHaqotwYdSIm/nMIa
    aXtrIH802bxL/nZH9VY8kO4+Ac8Bxoi0CoudnjRHLf2uUoKJ8L6IUq+uxt98Q3qzOar2Uj
    wBFpujvg98MPWEGeljnGz83TyLFrbWr4Gxc715djX4c00VGihai8wDnBhqEpJznRBe6/HD
    TPHFBwpDTjsgeqPsa5313fHBNm0rQX72aNC2uoXLvD+70n6jTEnjPUNdVFJwwIa/OgRXqO
    2PNOTxHYrXsZrHgsb6JPa1ch8m2wYlKurfe5vxp0lvhDb6mUXjnGoSP2/QGQ
X-ME-Proxy: <xmx:F9d-ag-owLW2LMSOvBj5hc0VgNmqjx-8EOg6VHTAIz6BnfGUivtZng>
    <xmx:F9d-avmDOtSvxwy5W724OS9zgcJjBhmk88ZJNGk7fFezJRuh7lq5lQ>
    <xmx:F9d-ai9omZE9vyfJqR6GSdkLe2aGHPiRnCU7NykTdnwansNzpUzfLw>
    <xmx:F9d-atmfEg0lKGMjuA62PiUtwUzS62J1Vs9AI5s3qQenDgYSZEjeWg>
    <xmx:F9d-amcGN0mMRzls310hPsupwQmLQKaIEUOqYAKs3U9WBbXna4lb8GbA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 04:51:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99959718 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Aug 2026 08:51:32 +0000 (UTC)
Date: Fri, 14 Aug 2026 10:51:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 9/9] odb/transaction: add transaction interface to
 write packfiles
Message-ID: <an7XAyQr7PrPlAGO@pks.im>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
 <20260811175415.2044235-10-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811175415.2044235-10-jltobler@gmail.com>

On Tue, Aug 11, 2026 at 12:54:15PM -0500, Justin Tobler wrote:
  			report_v2(commands, &unpack_status);
> diff --git a/object-file.c b/object-file.c
> index db63587f6d..a957bc126f 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1291,6 +1297,170 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  	return 0;
>  }
>  
> +static const char *parse_pack_header(struct pack_header *hdr, int pack_fd)
> +{
> +	switch (read_pack_header(pack_fd, hdr)) {
> +	case PH_ERROR_EOF:
> +		return "eof before pack header was fully read";
> +
> +	case PH_ERROR_PACK_SIGNATURE:
> +		return "protocol error (pack signature mismatch detected)";
> +
> +	case PH_ERROR_PROTOCOL:
> +		return "protocol error (pack version unsupported)";
> +
> +	default:
> +		return "unknown error in parse_pack_header";
> +
> +	case 0:
> +		return NULL;
> +	}
> +}
> +
> +static void push_header_arg(struct strvec *args, struct pack_header *hdr)
> +{
> +	strvec_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
> +		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
> +}
> +
> +static unsigned int get_unpack_limit(struct repository *repo)
> +{
> +	unsigned int limit = 100;
> +
> +	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
> +	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
> +
> +	return limit;
> +}

One thing I noticed just now: as the intention is that `write_pack()`
will be called for more use cases than only git-receive-pack(1) we'll
have to add a way to tell the callback what scenario they are running
in. I still think moving the unpack limit into the backend is sensible,
but now we're not givint it enough information.

Patrick
