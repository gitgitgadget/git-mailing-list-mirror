Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581874;
	b=Mo0AlHFY61amayFXirbxkhAQdN3igwKVWsrKU/acyEP5QIEJSHmR1dRPrxwMEzRhwY7n
	 1t4dM/4PIWgcU/Ru/xBeAEv0zCK33HrpRqgP0ne4u844apQ6eGP1QxZ+32OtPkm1x/sBO
	 SB4/1wmjK3ifEAWHqfbZMosg0WGoWQVLvkvIaSMLfdm/r+6uR3JgCHbifVmiuBP4+3gOx
	 TRPwyj9vRfKNr3hJrICCyj+pc+CM8FMh5fq8iXDnxt0tDt4nDxNv5AYKDSr1UEk82+TTL
	 nMDpYMd/E2G+GwIMAvevD22MmlSM5HqGIF6Q8eIPllSsZdQ2cXMqtXrzGbhelXf92qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581874;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BAvUb09pJDTcnsYOh7dS5x2Z7lUP7nKQXYU5ExsUeKs=;
	b=YpRFjHhKPftdC3NtXuibzIsi9VpXPq0QU5D54brEkOSAYK4C8Fm/9D1J92c/ecsPddow
	 P99gRzVUwGLY/nsSeRVq4+yT7IbUHXgtzHFtFxtSfEACHJYFFEkkpITY+RG04fNUKpPTA
	 o5Hg5I15dWXWKD4CaWFsjo4nSwtpSIddDgSEhmao9CfbJVqcs8B/fQVbu52ch7LYtmDSm
	 vj89Y/VYEOQHJQjCpJOIYs4Cqq9iO1kRNw+SDCU3XfXsv8ZZIHSVuVzL4k7f81Hr5x53q
	 uqw0zzBQyjM25F8KGT6uc5JaqODs9oCGJKIgt9AP2l9Z7SiuXjtbygzYf3E9S3kC4GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=TV1pKJjL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UnyuHpOy;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579A606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6579A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=TV1pKJjL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UnyuHpOy
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A30CD7A012D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:24:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 07:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792581871; x=1792668271; bh=BAvUb09pJD
	TcnsYOh7dS5x2Z7lUP7nKQXYU5ExsUeKs=; b=TV1pKJjLsOwv2BeLflygPOi1x8
	cdnw02usygMQni4ubGfk1eMeySp342W63sjaSQHQO9G/UWMW3TzJoLvIyGF9klPn
	1+9WhlngqjcHXOueCnKEqemAvGsV6czagsBXlTj4znuyD7RywOA7YxzIvyEBMoOU
	GqtHc9RbVQ5zPY4hsq0boaSelJjeLrZZF9m3+GcLvdB6gZxiP5lECN6vjGfgaFkk
	7FOx30JUP+fWusclUSm+5hAUjflL4PW3+wLB3ZPI9QQ8PbBg5x09bjcKAKD06oG5
	YDAmdwLLAFsW5LaJ/pTM9WJV96l8PBpxLNOaZaTkamz0ythProQYu+NTBy9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792581871; x=1792668271; bh=BAvUb09pJDTcnsYOh7dS5x2Z7lUP7nKQXYU
	5ExsUeKs=; b=UnyuHpOy7RdUAsLe/wA0kAAT60sC4VnueAMGE9LsqmGWKQahkYl
	pgH5h3mXRP8l/WR3yu8hhjbjBC+lwDtzI3vvh3llbqTFfWtzWGiiXIrqrmwroqiX
	FvgB4l7jeJ7WqgwAEjRw84fEcPo492IkgBXhK4PHq/kseo30qCvjx8DtrdF6sbuk
	di1Q2e7OME+N4qADV6huCXm6SJpH3DCU4gcSSNNTNZCD4/AfKDr3SepFv5/Yyjfr
	wp3AC0Xm8IMRuv/UGwDazxvcMUToxPqbKht/WTQUHb/oplbLPWs+ELqleLHAs0JK
	B6gtvHvjoozBRmPgmLtWdi0Pwb83uTEJE2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792581871; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KHblhyyQLJn0j0qUV1/DJNy3FpGsmkiJRlMQ7ExvavbVfdz
	KzwwftuP1N8lPGwDhQc+4kOh56fzUA8jB4qNRnvi7exQDQ0ePJ3yOFZLWzZwb2O+
	NLWet/PcoXQsV7n3BYCfG8Ayfk+Uy3hwsiFdml0a0C2LjjxsGZalJV0wL6p7ghtR
	xhuOaTb8ss/Tlqkj9gZXLGNpt/9U+9v4d9gHutqVZFRLFw5BcRP/uY3zc5MHpCFl
	uFB43Jh3KhDVl0rthTW5/ZtvFz0VAjgVZKAVPgbvVcoOuKeP1AEj4bXbWxpD7z5a
	uzwvTPuz1cZgl5u+q9xTi08I2AM2mmKWIa974WQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2ZsDlbwl6bJ4SwxUK0PfX5ceR8yBPIAZaM71biSM1sw=:PitR5+7XYIeNwDkt8r54Qvowei1Vd/KecS8mzP3zm3c=;
X-ME-Sender: <xms:76DYatSIKKINoBl0fgr_0HneJcg6rFdrudmxkDwiXvrV7eWG1pdgwg>
    <xme:76DYatqgzYw7chT5IaaCwFJGU75J21P-5i-PKBYzeORfNzQN0-rfPILO6jdTSXdMg
    g7Xg6C7TiKrR2ism6HT3qiVWghlLrJQBsO5GgtdVzYEX0OLlqbH1_c>
X-ME-Received: <xmr:76DYarLrG6ruEusYp7lotRM7U4Wit1saHMsWMc3_FMHAJXUrCp-vmw>
X-ME-Proxy-Cause: dmFkZTEfCUuF4Qb+27eZhqIByhoUfnIMgRkQWxXGPIEnbuO59Aa9xjSv97tTMVF1y3GNrW
    dEm1GCoBnz3WnCriv7it1Tb9I/aJfAQ/GJYIzCpvn3CYSsxfop2zY2UEjCYGIIWa5RZ/af
    +bIuZeR56QSe9PuFsUmxZWgMVpatZP4NngpNJH7nM0TSAR2zOtjFvzs16pEZtkRGcArdA7
    dJ4j6Pz7gTkAWQbdkhBxa1N2sJZ6MJnI3G05A6YUMeoXT0VsW1HMt1PGGIZxPLEKy59Pq0
    d+sxmLjmJzq/1h4hCm8HaVX3kppZcfj/0JMvmQjL36btzxaghEfAdo7PtVisDFIkSHXJaS
    pqtV5QHU2i6KjBg1NsnHY4lpDgDiMig5p0KJyKE40BjocIkGcbXQl1kt79wUeTVsJwP7dt
    5fxcgK7FCGJ03xwbCT+Db3y8lSOwvJfYX2FyBTHrVO/zJ1zfUgB9MUpqGdk4zWJ3gN6JTu
    3VP3/tM111KWepkYnIkx8WJUHZ2Yh8+TnDiSy1rJp51fXA2qnoPeF78YGFI5r7yJcGDT/7
    O774htIqzP/a1mEN8BEP5Akz6XPyfxEO2JnqUnUXKCOe+XIhDaC5kZ4OWpiikWkcvFG0b9
    BK+TGJxnCeVJhnfHkHRzqim7564TNMGlPWwEUvq+KVZ7w3pdp+xokdZLgLgw
X-ME-Proxy: <xmx:76DYagpxXq0kzkYAotfoTCNYJOdq__XWyrRNVBxZALis2srn-ED4pw>
    <xmx:76DYajzaEsEj4itIBxWLITilywcgk8rRN4Y-N0xXf4IDKGEPSjidgw>
    <xmx:76DYakMtZWDGnmCjfXSYyjBnyQmgKJRkUfAPFRXAnqqb9iZ2bp2ejA>
    <xmx:76DYao6_uxvIYWWTC7EGq3uK4oCUGn_yY6_lP3k_Gquve6M7ZKysZw>
    <xmx:76DYagFsQmEqdA2w4ijXpAevTsHjSM0KsM6BucB7QbDySctr3GaFjLqO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 07:24:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 445c2f10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 11:24:28 +0000 (UTC)
Date: Wed, 21 Oct 2026 13:24:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] odb: use size_t for the length of objects to write
Message-ID: <atig6fUHbPqYdzXk@pks.im>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
 <20261021101640.329990-2-gitter.spiros@gmail.com>
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
In-Reply-To: <20261021101640.329990-2-gitter.spiros@gmail.com>

On Wed, Oct 21, 2026 at 12:16:37PM +0200, Elia Pinto wrote:
> c6a4629e32 (odb: use size_t for object_info.sizep and the size APIs,
> 2026-06-15) widened the read side of the object database API, and the
> write_object() callback of odb_source already takes a size_t. But
> odb_write_object_ext(), odb_write_object() and odb_source_write_object()
> in front of it, as well as write_loose_object() behind it, still take
> an "unsigned long", which is only 32 bits wide on Windows.

Sometimes I wish that C would give us an easier way to detect such
mismatches. It of course does have optional warnings, but enabling those
now would probably lead to thousands of warnings.

> Most callers hand them a size_t from a strbuf or from odb_read_object(),
> which silently gets truncated. The most visible case is index_mem() and
> index_stream_convert_blob(): when "git add" or "git hash-object -w"
> runs a file over 4GiB through a conversion (core.autocrlf, which is on
> by default in Git for Windows, an eol or ident attribute, or a clean
> filter), we write a blob made of the first "size mod 2^32" bytes. The
> index records it with the stat data of the real file, so "git status"
> stays clean and nobody notices until the file is checked out again.
> "git hash-object" without "-w" uses hash_object_file(), which takes a
> size_t, so the two disagree on the object ID of the same file.

Awesome.

> Use size_t throughout, including for the size kept by the in-memory
> source.
> 
> The existing "hash filtered files over 4GB correctly" test in t1007
> only hashes. Running the same with "git hash-object -w" on Windows
> shows the problem, but needs another pass over a 5GiB file, so no new
> test is added here.

But wouldn't it make sense to add a test? It's a rather serious bug, and
the existing tests are marked with EXPENSIVE already anyway. So I don't
think this is a good enough argument to not add another EXPENSIVE test.

> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index 868e723c81..ab7173cd2d 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -10,7 +10,7 @@
>  struct inmemory_object {
>  	enum object_type type;
>  	const void *buf;
> -	unsigned long size;
> +	size_t size;
>  };

I really hope nobody writes 4GB blobs into memory :) But despite that,
this fix is correct anyway.

Patrick
