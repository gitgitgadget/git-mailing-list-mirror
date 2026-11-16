Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814624;
	b=JGxy94PP7a1YByjiTCykB2IqSs35m4IijED/GEpuRF6+GeEQoW+rv8ZorfbHlogs6RqK
	 UkCkkicaLw1UOzvjm35plYp1dfV33AAdiu8M56lU1KM8pB1LG/aeJTf+fzEBZg90DRcfc
	 lF0jBmQgq3bZFYb9teheM8W9YSctqG+Xdy3D7QxaWHcDuMUwH+uCt4JvUdDwlG9XAr7Ch
	 Dj3bNu47XGy9G+jqJwNJBTdoN9tdloA6CchhuiSAeIGlY33Of0R48Mvzz4yp5/p84b41h
	 QQCGlgtUctZIbPXmheqiDkKJZYOhwWiqxOe6i+agBVG9HRoywZrBonV8UfmGw5rfBPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814624;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P0RwNanujnXecl+TK4iy0FjPJ6FkLydiAmr+5OK1gKI=;
	b=Ukm3ZSvcw9BGlCQ1I3mPC74Kap5XDBnpqYfxgTvxObBtQp9PZ+wXcN308dknIsdWZwSD
	 X4++fJcPYVFC30rfOqfVhaAwgtgD+Kra64TNEOPyuVwasKZ4xxXsz/yHRjXc4TyyfZgyE
	 oWCjazO6vnMSYJpK5rOEvYPNdux/b76S0ox3FJ1EA0WqDTcWn6JUdSWSZzTKUJ0494p/0
	 ytjj/HWQJglelc7CjaZs2O/0P8K5Z0o+kKjL2Wuth/FNxMi9Ex6K8054FagY8dBftZdIx
	 IpHsE51idPeBSoSwZBSy1mhYXgFPsrK9aDU9J3eTMtOgJax8OrxtLCu6D8GDdZ8yNjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Dgj1NPH5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uIp6MNvp;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D7606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 07:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE1D7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Dgj1NPH5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uIp6MNvp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2BD4B7A0184
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 02:37:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 02:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794814621; x=1794901021; bh=P0RwNanujn
	Xecl+TK4iy0FjPJ6FkLydiAmr+5OK1gKI=; b=Dgj1NPH5kCGKYCShIe3quUZWw+
	bwCeAIucwTFcbFaI4R+s7rShTIYV92Zy21DzKDUnOxf0s91lv05g2wgYJBojMxnc
	fvesJgKpdarogxJ0yPUqtcxHV9nHwh6AE74rotr7yN1rk4RUTtPx5NK76yGtYm8u
	VOdAR0oHzDFk4Nx9ETv8+8s+/FTQWTTAdYpv3wV3GMuzO+aXy11pm4gwmQCnSxCh
	uYbOtl2EFDpXAT/fHbi4rUVBL6UOpDg4KJr+IOxusDucb83Ntgamo6omVFpl4nTs
	hJKQwyuHjOVY4M5lLGu+rinJikmdSZYRQmVGW91wqzMuiaOPXK0Nxd/U0nBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794814621; x=1794901021; bh=P0RwNanujnXecl+TK4iy0FjPJ6FkLydiAmr
	+5OK1gKI=; b=uIp6MNvpSFPJiZduzcCXiC7O6G29BxqHs1rVVqpDRJqVpQoCgpr
	7K94DiGGe0EeA7viZXaMWvoOk0773EgrZvUficDf7Htau3H15SrSEKwfWc5l1WDN
	cyTvBWUvNjcmHykH1tKQiskD3RqLAwOQbyXP0X3wpXXgPnvtssA/q8NZyMSGLJVh
	drczx0mgAttzX1HgStIHWd9aGkaBJ6xpsSVw3sUQnA/vOLFs3fav5QfjLSLLK2+z
	IPnEb5AqL+OMBxFjlAJyCB1pexp0CxkAq5512gpvUOT9DHctjPT+IQVohjodaZAS
	7IJ5GnWzztPDZg+BoGFwGNEwAlZcUnjEiDw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794814621; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:WuPJ5qpe0idTLWbSzjNNf5D+K2J6VvXb4p8iOTZi9KKqPtp
	kZtyJ++uLXzP2jsIReP2VI2IEb2xf8n9A9astm+0trZpwtASTDr8WDdKsUVzLNER
	aVpHgWN/P0ydlE3ezA8EvAgCVdqy/pSUsmcWWwYp8qdInDa0WFAZsY8HsKh7zbfV
	kSNSVvJ8E/HNJp3ojQxDStXe7D9PGzZZwfUnSrJ9hLwaV7M3/hEi4fXR8r5Ku5zg
	VpK9aiecPp3KOjgX6yz3eZ232/DLDrHturkwJQZC72YL3ExFDyHlAyS0SM+B8ygH
	2FNC5CUCjbMyE2v90SO0+SoULadCOOClk38PP+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FiS+8OZHquOuORGR2HzFutfp34sbfWrG52DwaD4YUgU=:m8VXpSJkwx69gm/ep84RbTbFFvXEkrEcFLR1RdRgEKk=;
X-ME-Sender: <xms:nbL6anBhn7JPcVtl4wjj5m8nYUDq2aWYdOYttMTum_SY-c4oolxPEw>
    <xme:nbL6askXEMHU_a5PYzGYpAvRx6J0UxuVxU65iMB5TnONqRMa8SuIaI6JGvgkqJe8z
    iIdGfKaLoW1Hxdbavcy_GwTuMlg7W11kGoejy3NOVCNyQ356x7mDP8>
X-ME-Received: <xmr:nbL6aox0EXh59RBkvtXrK8cvnY-DVmSUZhoe3P0zJTODuJxeNooI_OrhKCMk3hZumZdjzqI>
X-ME-Proxy-Cause: dmFkZTFv5gE/QIX3ilY3AsNejXRoS+hvuisGOKjiZDL1YnPuzMtCCnWXlMLuvBlnozX2tS
    88r6GI21NvJ5PA1iC9R3pgT3Fm7F5+hWkaWcYmVRBFzMMrkTkxRYhVAX46s0F9VqY4oPSF
    aiJ+PIVZdEZujCH+UEFLtRl8cdSGe+0Xfm5E32IvBGPiz93vmX6tFqrWViU8bdrwDqxl9q
    hbPWUFp4dfqHcHTixl2q6QUQNBRJyvW5Sc5az6qQGnof5I4jz6Q3t0/1XnbNCr1J0PFEMj
    AWpOs24XOVHadln76SWDYQN2sGVuroM0wsDz0kiojkJv0Zq5IbHxoTmaORXHv7VWxqSuKI
    WA+McVeK6rAGjw+zxfhD+NKX29L0oXcHVD0eVOshNwySKrqZrz49SjnHmPejAUdB3hhUTE
    bKkIRNMs2jNIf6mOn5IHOxfvNyPKyn6THWii1Y4B2uuBuvWc1QWYsVOzFLDbs0xiWuGncv
    yPmWWZZzjoWxrQiYDJy01KobT7VZfLOy7JIy1wngSNrvI+TM+bntEXGg8kWUtbTHeiTTr1
    6kOqh4mThQeOvbGNYYgt1IXH+OQ+yb9EV4qWj+Gcilnw2YYNV4GczHyQIDxPvBxFfZjjCq
    Di5g6lmzDC56rRiRccQWGLIo2BSX+Uko1EpdDZc0QcnykDJzYjlp4Es/t1wA
X-ME-Proxy: <xmx:nbL6amSFHRySqBchtbl2QNxLVma-iHb0ebDl6J_hkdrZRm7tJcUCjQ>
    <xmx:nbL6ag8y2FZxIh6xrXpn5ExU13FWuzxFVigz05gvV2wyd_n9_mAvZg>
    <xmx:nbL6akvIkj9QLTcVv-xsm4VcRQX9DBohoA39RbJ1veuJJNQErqqumQ>
    <xmx:nbL6aoP6WSNxM5qq_fA4r4x3O7R4fdzO-NKXz0SbUdpsRaAScQW2UQ>
    <xmx:nbL6asdSzSzQ_SO_XTILnExMhvEPY7I655QCshdz9JbS7AhBkxt_-II6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 02:36:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b0bf209 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 07:36:56 +0000 (UTC)
Date: Mon, 16 Nov 2026 08:36:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 1/3] setup: reject compatObjectFormat == objectFormat
Message-ID: <avqyiXdZIFoJbw34@pks.im>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
 <20261112195740.2834341-2-adrian.ratiu@collabora.com>
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
In-Reply-To: <20261112195740.2834341-2-adrian.ratiu@collabora.com>

On Thu, Nov 12, 2026 at 09:57:38PM +0200, Adrian Ratiu wrote:
> diff --git a/setup.c b/setup.c
> index 186815c780..52a9462edd 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -918,6 +918,13 @@ int verify_repository_format(const struct repository_format *format,
>  		return -1;
>  	}
>  
> +	if (format->compat_hash_algo == format->hash_algo) {
> +		strbuf_addf(err, _("'%s' is '%s', the same as the object format"),
> +			    "extensions.compatobjectformat",

We should rather say "extensions.compatObjectFormat" here with proper
casing, as this is user-facing.

> +			    hash_algos[format->hash_algo].name);
> +		return -1;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
> index 69723b88ff..858aea62a5 100755
> --- a/t/t1302-repo-version.sh
> +++ b/t/t1302-repo-version.sh
> @@ -98,6 +98,20 @@ abort 0 noop-v1
>  allow 1 noop-v1
>  EOF
>  
> +for hash in sha1 sha256
> +do
> +	test_expect_success "compatObjectFormat equal to objectFormat $hash" "
> +		test_when_finished 'rm -rf same' &&
> +		git init --object-format=$hash same &&
> +		git -C same config core.repositoryformatversion 1 &&
> +		git -C same config extensions.compatObjectFormat $hash &&
> +		test_must_fail git -C same rev-parse --git-dir 2>err &&
> +		test_grep \"'extensions.compatobjectformat' is '$hash', the same as the object format\" err &&
> +		git config --file=same/.git/config --unset extensions.compatObjectFormat &&

Nit: do we maybe want to use the modern alternate `git config unset`? If
so, we should probably be consistent and also use `gi tconfig set`
further up.

Patrick
