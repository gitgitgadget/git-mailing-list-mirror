Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231894;
	b=i8mmVNtq4IUIOdId6y7HXYbR405Fme/B3rUwIrJQzxlBJFeNZ+1zQDLuOwB4j7xTbCan
	 DotNFaK4b1VGFSgySeGkR93kC6Fb+y4YWGi6HRkwAwvNXHOai0rrMSojWDv59Y+Z1g/VH
	 wzVMjsq7z6ama7WVMMJ2+k+YYn54rfw6W/d9+HxQJfqLBqhFbR9O5K2MouwZ4qiIPSNTU
	 DUGrT1L6wueVwJ2ZtaR2ndhgfXrHACVuh8MlSoeLbN5gWTvbcjPW9t5Xk3sgsKCTz3tHL
	 GHqB7f7fk3c0bbybPcOyKNXl8YQUz4i9MBkaSO5N5EZ4Or/pX8/KmkUB2OGf3y6m5mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231894;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SmvtyoH7G+HugPTPxXUAippzfHa6X4Ckcn6OOK5Npjk=;
	b=NLYEZ0bHXa7FLdySpQdFgFwhia2EPRWQJ1CPkJgc+2/whST1DkAC9N8fpGfIPgB2nsfW
	 tUGJ3iCJvy05qmvqL7OM+uD4w5hoGWV4Gb9k1cnf6L0N0LrYBFGrb2pfdAyME0xX1i32Y
	 eYFUGjXqh43ikPNdtarvfDKm91d0K8yVwYxT4xQerr+k7rXsCTY4b40yqtLy7bB6njHca
	 8dEb1c4MqZS7lfK3n5A+OLosjqXffpGkQ6y1oMx1eQtMrXRsD52ssP1v0XHq/0JrV3Rok
	 ET3Bw0smZ8kBZRGlvagIiI3sbxri24wUxRpr+FUxVoqxQxS2aoEP7Wm6ON08cV6qmXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=K+YnTAsa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ir7fP0aX;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C24606A322
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C24606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=K+YnTAsa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ir7fP0aX
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 363C41D000CB
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:44:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 09 Nov 2026 08:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794231892; x=1794318292; bh=SmvtyoH7G+
	HugPTPxXUAippzfHa6X4Ckcn6OOK5Npjk=; b=K+YnTAsaNn/28ydn3dseC4T518
	NOy1aWD6K5zucpdxMQiaUvT61AW6XvidMpsC+5dbe9sH2UAvPOVnbyWbcGgi2X/o
	o8dC2J93tbXjkXT+LV7qacfTFaTVjVriR24gUWk9eTWar/lOU8+cEjppOD+FCJa4
	bWGuXUcnRHHwzQj7MBUvaqaeUfFNubW3mZ6V5wAm7t4XkgvIBzvvs4rrHXh01OQ+
	CKq0x1+Pumq4cdvmdglY7hxgdN6P2a8UPI3cF52wddja9N4HuRQ6V75awJpv+y3F
	ACFpgms9ivFid+PodDvPcswH5DZmPbwIVoZqVIlw/2rFpSS04ilJdMCk7VWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794231892; x=1794318292; bh=SmvtyoH7G+HugPTPxXUAippzfHa6X4Ckcn6
	OOK5Npjk=; b=Ir7fP0aXhUkK4QVAkhA8Q//6SIvneEw4xH9MCmZaKLcPjYGXtbX
	T9Z0CjUi1QtRI23y/Unl0sBfUt9jCbzXf3O7Mj9ne/0osejTxFwxPGyBbjeFIW3y
	nm/sNxUBEJtd06ChTlVtUn3Tg04bJE7lyOXrueOhOg5V/ULgTTXhF9QuofZ74hhA
	knJAdmWqDsYIpD3FY/N5AlSc3B8DqvBfROBktTak+LNIsmrybQyZKhG8pL+FA58G
	BMN+QhIh4dDdLpxmRJyyjRddUyq94bX0IHQ10B1Wmg9oM8A2iD3ANxwYOIP8qV7E
	PeyjUxIE5HXTLNnooLPr1wk85EsbevxUCpg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794231892; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:MYyv1FyOdT9H4VkS5L32A9cWqxg5a2WzxdEqgifSRbvLUdw
	aZHF3UBv1i2JBervQen1SqN27wpHSiXJu+zno4WYbYO+m83uph5rky+gkhutSFxW
	CByBSeqqTu9c3J0jHFIROQvx9Bg/L7RvvsUHnpxuSw5XinmFJiPeDhbufHLRrY7Y
	qDKqdhWhQQOn921W7Z4/UJX+pfuFxoUofThZsMCMchA5Exsy/nDewoeqUgZQ/K7m
	X5WBRrKt24hLCziloKGlZiDS4h0d7j8KtOYcvhNdpfRpo7chA7e2A1SH7Z0N1h+P
	pXEDR3/FjUkRqXtO7Dee62dmssw9QDoatqhsN4A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Evbwnx4Q3leNbnRCRwWreuRb207XACkbXeZ91gI7sgE=:E1KLNg7fQ5RU2fM+T7fgg/viNmtzGmG7YJGLqWgwMq0=;
X-ME-Sender: <xms:VM7xagj3HqbeTIoSgGVPq53mcuNbIYD6xqVms6zZUcl022FaBua3Xw>
    <xme:VM7xagAfr5vwyHzpLZus3YxWucVxOF9bGCDS8erciW-zbjR5pQK9OCKhKWR49XHfT
    Devs2Rhndy9Z7k-d74pHlthuIVhhHdkVLwqcrTyy8tGS2wwAKmP0dA>
X-ME-Received: <xmr:VM7xatFAVKHM1It_1_Y-ks_qpGn2bFr_r1ERMQ0wg2Zz9IZut2t7nStT3OvaqdULtv3zZb0>
X-ME-Proxy-Cause: dmFkZTGEGi5g1kwPJEd80aLcl8ROEtmBRwm5rvetvJ3Ka7sFW4HdkICIw9d4nsn0VWlW9i
    9trlO36uyYsZmgYoVYAYhna2o1sUiy7TU4M/7V4WhF3kOk1e+/PrvVY/k8PXe+yAiWw8QZ
    cknhvCDZSBHQdo9q/N4uil7rz7Ywjg/Mn0Qs+kP3g7ovEHI9wbrA1rP86iIeiAqzztf57D
    P3N3Pg0rxR59O8gYty+elIFAdznLuCnEaGgVwojLAweqbgS1h4sP1o/aELTpd7A8LHAsUN
    o3ugxVmINeDRext5Iu018zSnxCrG7owyMfG16AtGalE12EWrPvAGrWdQOlBTEkxsEdNGT8
    9+15v1QUx4A1WeRWoulsGya5dfFRuSSGvERJk9GIgeaUKJ2njIXD/5u/ZRXtMyEaiZgxl8
    cD69OBWlmAmAsGNF6j0HDMp7lfiMBsvyB83wAJmUIBERPdlYi4P4Tpm6YKb0Myp0c1aRRd
    gDbv1NwGUpH/5KpDhMyII3I3aFLyFmPSyiC9hXjGIWktDLy/zQUcNDJAjPkOzhxbz4JUWJ
    8gCZSz2I5DI5fVuwAj5N//8RoFIXJG//aytUONfgJFr8e6aqBcdJ/rSO0c0w3hkUcnHfKo
    RArEz4rMieX+M/PCnFGB/E4nRKxq8vlZX/oHsARE5yrGDkM3ktyIHyEAmMKQ
X-ME-Proxy: <xmx:VM7xagJt5zoUJLXauRvzxGGOnflmHCR-3mA8voh6BAiJreZGVCO-5g>
    <xmx:VM7xaplrkucoXiM0eThY7dUbAvPKqxFnteNDUUwiOWWQjLypCMiqKg>
    <xmx:VM7xagSUpVPkjvAhWYIP8pe9FbS5jhWmnZpoej8znGL6ZHj0WOKLIQ>
    <xmx:VM7xajKxFtT0IjzhRokb4CrsaAAS4jsyS-v4rSFYaaWW0atBv-m2LQ>
    <xmx:VM7xanDv0Xb9BztC3HU8PskJkRH1mKQqx1MICJOLOhXnZy9JYFknjca8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 08:44:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1c32a39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 13:44:49 +0000 (UTC)
Date: Mon, 9 Nov 2026 14:44:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH 2/2] odb/source-loose: fix existence checks for newly
 written objects
Message-ID: <avHOTt_PEJUKq9Dy@pks.im>
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
 <20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>
 <20261105194314.GB2898829@coredump.intra.peff.net>
 <au23Hvzp09yrym9s@pks.im>
 <xmqq5wyalzi2.fsf@gitster.g>
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
In-Reply-To: <xmqq5wyalzi2.fsf@gitster.g>

On Fri, Nov 06, 2026 at 08:02:13AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Nov 05, 2026 at 02:43:14PM -0500, Jeff King wrote:
> >> On Wed, Nov 04, 2026 at 01:16:35PM +0100, Patrick Steinhardt wrote:
> >> ...
> >> So I kind of wonder if prefetch_cache_entries(), along with any caller
> >> doing an OBJECT_INFO_FOR_PREFETCH check, ought to omit the QUICK flag.
> >> It would mean that the normal case of having missing partial objects
> >> (about to be fetched) would cause us to re-scan the local pack list, but
> >> that's not _that_ expensive, especially compared to the fetch we're
> >> about to do.
> >
> > Yeah, that's a valid point. Honestly, by now I'm almost urged to just
> > drop the QUICK flag altogther. It's a source of bugs, and the longer we
> > look at it the more cases we find where the existing users thereof are
> > buggy in specific edge cases. We just recently removed one user of
> > QUICK, and this here is another dubious case. I wouldn't be surprised if
> > we could find edge cases for the other, remaining users, as well.
> > ...
> >> > We could in theory fix this by flushing all the loose object caches
> >> > again, like we used to do before 5946a564cdd. But that wouldn't address
> >> > the root cause: the cache would still be stale unless somebody does a
> >> > non-QUICK read for a missing object. Instead, fix the bug by updating
> >> > the cache whenever we write a new loose object.
> 
> OK.  At least this change hides this specific failure mode.  Can we
> include some documentation that we may want to rethink the "QUICK"
> thing and audit its current uses (if we decide to keep it, that is)
> and move on with this change?
> 
> 
>  odb.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git c/odb.h w/odb.h
> index dd85b880a7..61ff443d46 100644
> --- c/odb.h
> +++ w/odb.h
> @@ -386,6 +386,9 @@ enum object_info_flags {
>  	/*
>  	 * This is meant for bulk prefetching of missing blobs in a partial
>  	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
> +	 *
> +	 * NEEDSWORK: rethink if QUICK is desired in this context.
> +	 * cf. <au23Hvzp09yrym9s@pks.im>
>  	 */
>  	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
>  };

Yeah, that'd probably be sensible. But I wonder whether that comment
should rather be applied to `OBJECT_INFO_QUICK` itself, as I think it's
way too much of a foot gun and I'm not sure whether it's ever really
sensible to use. But I'm fine with either variant.

Will you squash that in or shall I send a new version?

Thanks!

Patrick
