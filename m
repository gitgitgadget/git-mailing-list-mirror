Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404443;
	b=KLwNVZhbvS4BkHu0pq4cazBcQDh8p6gNOKt/gzlk1fySaCH85p/6FfW9fBfjwzhDBc/+
	 qxmeo9INS5m/u7o6sZoIXcDvMuDOsJbPizwdHJxSeyDLMwFrLaMCUNTwXXzvJTlTYsrdy
	 6LyfktmkLJgvqYtS1JC9xw8sUPvd2FuzF+Mr2fHltilOYvGzV99HkDGUYBw8/ouXWcw37
	 7AXyijU00IFgBKRWRmane718Qtmp2swEyYukGTKUvpyGPZiKFuRo1TQRYzGEa92T+8EK6
	 QJHAvodAb1FWLhUc+6IzHnmiPl1YmSBgPiGcgrmqcrdXC1Vh63t8WrSnUjFU1PB2JDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404443;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/nyToVMJaphi3XX5mikamdLYfNQ4cJA022y3PyBsXK8=;
	b=lz2VNLKEV+PGdKjGt8E2Gexub9WCjcYAivy01VsG/5/SP7DdEqNMm7feAWeq2xZ5U5Qk
	 xobdr+xe5Kua7rOYtPpLqkxyABNm76Uj7KgtJVpcIth4EeGxDZxmHedAs6BvBdPnw0+zn
	 44AaZOScKADyh5+mChExpXUtlHt2QbGXqoWC7Csh0qYD95e+q/kW6IWsMsvx3qSIEs7+v
	 hDtb6KRGtAVeDOYGw7dmggafF+KnbAHaq/KfwB0xcos+7Au/9YYjimm8r1nk0gjASo8gf
	 jBIoafTsOfvYLSNN+F01f0Hqf02m94Sk95U8yAqSw0CN/rWPnS6oVsENmFaQ2biN+9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=kEB0Zr4j;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KC0Pee0F;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26691606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26691606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=kEB0Zr4j;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KC0Pee0F
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71B587A026E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:40:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 11 Nov 2026 08:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794404442; x=1794490842; bh=/nyToVMJap
	hi3XX5mikamdLYfNQ4cJA022y3PyBsXK8=; b=kEB0Zr4jLaur+ZN/5h5kAEmGez
	jWx3JYd6sRVNocGdJDrXYCP9IRF+4JxeXzq0sPGDOVEHkmfkPwq4EvQF2Se9CloV
	EatZi1aaKuzAlkvYR40QJVaUzYLLC3rcttnhma143jYY+vVQ0wMgYjU1zaY+Cx/B
	UdOv94TWKHuH5eSwxmXWNuP1gIauk9ThC6khmxmALedxGQoUrbLE/XLjMGX7Yxe/
	bbNhvcLX0yJmxw8sWBuDaz6lbabtfDc7nwCIlJ2XC+GD+Z0WKZyIwYmnnOg2/i3O
	x2+DkKTakIMB3K+F2Sa2XnUhprgUCMq1/fjWlEG5wy5HGLpu2uBUf7QR8yXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794404442; x=1794490842; bh=/nyToVMJaphi3XX5mikamdLYfNQ4cJA022y
	3PyBsXK8=; b=KC0Pee0FAIxnlFUnnV3vgVuR4unkqpjD8KPQnUJUxnv5AoCTxZm
	XC877U+lncqah25VUsVAbXpEwPJEzi8dumLSvqYgt6sRaMBr4gqrQqXYfvVlEP0i
	bsVD0vC9wRgU1YXoI282Kg6YVVJYtuGlgd0V/8/oRV/X1xj0Bwa+XbzGoKH9sCFe
	Ftaj+2zWRJlxXqbVmgpcVB8Y0OanXFIdwFZ91W+rJQfOclQLOgpFYmmu6CfVNEbk
	w3Xoxo7PQcvQsVasPoOnNb6T6rVNXJDs0y/QD0qdLgbQTLvcRiwstiIZQO/TbSA3
	8is0xZmSKLSsalqdXgilKM7h6V9zQ27Uq5w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794404442; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:O4e6bbWWEbHWNpIbP8Qfb84kPwfDIgLRbfonGmMigpqUbaK
	LCTOxbZbfSbIcbk04qOVrJAxkm/Ki9RNEUr46Mo1nuQvj0reKxYV7NiKzM9ZC5PL
	EvM+B5oa5wh8/PPeRsXAL3pPfFO7K3kaHMqzgtOIxQ8aVMiKuGiejZfa2+4yV8jT
	YBmGamrhLfhFNAxnssQ4JgdQ+d6/mGqn9diAR2kZTD+DQO8rVOPRtILdHbtu0cIk
	4G4bO+zb7X/bMZS6+5z6pjJCMuPAV20AbNAKsYaiE38KFepn/mm+Eesr9ADYWQQG
	qTCXSXaKF6K9byfy0YZUmRpAxRYG/E5eEdg3u/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:546Sk4f4Uh8tbn5dIP2UVP5gywKr6aDl2lVCvjZ+F2w=:LKMRXffVYEgIxtbI4BcpFFCVftO1hUSksB4oITHt6jU=;
X-ME-Sender: <xms:WnD0ahMsYm-CBzjahWfMy0BPEMRK1CXv7mJF9WlTw2fndY_EvEoL3A>
    <xme:WnD0ap91fZRRMsIPcdRQgAcwheEML5aJqd18o-dLxAqA5wIdcutDnCnH3WIDmLgHR
    oUtbYXxU5_Ys-nt2h9qca0GuoHuVqwHO84yY7Awq0d1-_N39hay9g>
X-ME-Received: <xmr:WnD0at7k9HXqtU4qbiHriTvw3icF8FwOqGDMfIb5Ex7CAxhYkoHE2QJtHJoDFsB53_9Qbw>
X-ME-Proxy-Cause: dmFkZTEvq/vxjaEoMBDTcC76AWqfUYmcWfsb0LLr8ykCMGzPqeXbsZrBfl1sLes/sb8lju
    JWcrj4HHLtQtUXEPLbWmNdstbwNDpVenQa9dVoPQSsc+AR9eeu17S5ZaKE9d+co6il/I5Y
    7lrA6zKRfqDS0HEFrvLU2K/AqqhUBLJlgdC6+SyNdQRQw4nhVT+JDsBjAcgk4Ri2Sn4eoo
    f2SPSzjrh73kpMQzNNNLdlPgVk8Deg8hpl5hn24mrkD8W1M6O3M0X0GxJ75E/iRdFJds1K
    VI2dKGRoyVgcY9l2svlDHZLB6u/KEIWHO9ZAJGVzgoAch0futgMRlbpCl6LcjKhY5Kl7DD
    v+AlPafQp6E7zR2pTj8eGIOCMFX82fHbxBN7v902GsHyH/PbLf1zsN5h+rjQUtXuQWJW84
    64q+P2Obt3noW2MZk5VMMFa8G+NPqwXr1GBoChMeHmfwxKkudUNma7NZIr7K8as01g2Xhp
    tKpiaecuuQQblTR+P1ydkv3Qkw38HDyCfZ/JEYt2mLLeBY7zKYoeiVp5kkJxy3j7AooeNy
    yKFpxEy5e6WyUOfEmC3XwNvmvheshUmXixPOGn+B1HfKSt5Qg4KFGjIUPjl3EL9XB3yKW+
    8bIyHwdi9vzrGqnLfpmnCqw8Xrf1uumtuCZXxJqZsvqCTFHXFgkYEzL3fTGw
X-ME-Proxy: <xmx:WnD0ao0vZ-cAc36tLWDEIfO89MpO0TRL5jmkpZ0Q5K_7xL6iMaxOzg>
    <xmx:WnD0asBqakElfQMbXI4njOP69SyKMFnajXDIrSmsTfeSXoZHl52NnA>
    <xmx:WnD0ai3fz_w47gKmjg-g45WIynSMFWk5C_rvsqoBPtyNgmaJ0H_eyw>
    <xmx:WnD0ausmFQaX-4BkoTdWqQkgRUG2zpAr4QS767I_JsIS_LZbGdMYRQ>
    <xmx:WnD0aj9w2tmS0pOm_OBESzw5fq8Ssip7ocB2i_pWbQWAFbFzN-hOdByU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:40:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e7f111c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:40:40 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:40:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] object-file: move logic to derive loose object paths
 into backend
Message-ID: <avRwVQIxOofJln28@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-2-fbbc86c29693@pks.im>
 <1161ae1f-6639-4e27-8832-3771f73f5e79@gmail.com>
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
In-Reply-To: <1161ae1f-6639-4e27-8832-3771f73f5e79@gmail.com>

On Tue, Nov 10, 2026 at 06:58:34PM +0530, Kaartic Sivaraam wrote:
> On 11/2/26 16:50, Patrick Steinhardt wrote:
> > diff --git a/odb/source-loose.c b/odb/source-loose.c
> > index 96fc2ed213f..0f29162d752 100644
> > --- a/odb/source-loose.c
> > +++ b/odb/source-loose.c
> > @@ -18,6 +18,27 @@
> >   #include "tempfile.h"
> >   #include "write-or-die.h"
> > +const char *odb_loose_path(struct odb_source_loose *loose,
> > +			   struct strbuf *buf,
> > +			   const struct object_id *oid)
> > +{
> > +	static const char hex[] = "0123456789abcdef";
> > +
> 
> The hex[] gained a const while moving but that looks obviously correct.
> 
> Rest of the move looks good to me. We didn't lose anything. One thing I
> noticed is that http-walker.c no longer needs the object-file.c include now.
> So, we could also include the following in this patch:
> 
> diff --git a/http-walker.c b/http-walker.c
> index 13730a2784..05c0262810 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -9,7 +9,6 @@
>  #include "list.h"
>  #include "transport.h"
>  #include "packfile.h"
> -#include "object-file.h"
>  #include "odb.h"
>  #include "odb/source-loose.h"

It still needs that header at this step though. But it doesn't need it
anymore after patch 5, so let me fold that in there.

Patrick
