Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275668;
	b=PPkT9qDrHO9r0OA3M/zt/YxZ0iKVl5awalT4wpUiBYAUNi1r5CRWuQMucdAX9quWIXgw
	 icZfjMT4NoIVrs7m5+yk0E/kaNplLMNb8H+cXrDLMU+mEwWbFgFbNiFVeae3DBdN6pxQ0
	 xQlxdMB1iUnNvbysFfQvcNZ5LoR/LP1v3VYPRf+0rqPLEi0ppTq+tCIW9XJjohmNqj40P
	 ZMA4wKoUdKN7xcs1EyTmvzjNojCxhh/brId7Q4+cotB1f/Aw4D3+iAtQ52JZ4hAxKFoNj
	 GRhwLNseJWTyD/A4U24CYX7y/90lQZYDsXzcsIaWjegTdRkkaqtcoJInDjQouS6mBRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275668;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mJtRfuKxTyH8S3WZpl/pSa1ryHQQDbdv49Lrrg8rrz0=;
	b=w78bw/KJD8oz1hde3gsz76AqAlJP/0Y7M9nCGUkqEio26p7/uwgxYad7CYo7QVeYlUHk
	 FHM93K58PglovxOXwfMfxDcIPtUt5R8LIR9ixThHpmPOXMChn1h7I44+GEwZrQxJOHn0m
	 jo7MVOdBJkjWyxR6PQ+sBvnIVlTcO12qHltlW5dwv2lwCSAbAFvEIw8n0gk603oAsfQz7
	 ffna29xTNpw5tok+J8w4N7ruDcd8GAc/XD/gukjY+PvXMYklF2Tw2KRUuEN0b2kG54Z5a
	 woNL7fgd2SS6+KdBlUfbiZpk7X6eOhHxD5fot16w16wC2dpdK61ci+jXZH/QBo+7G2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=oqsr7G52;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=q4M5xZhB;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127D606A330
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2127D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=oqsr7G52;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=q4M5xZhB
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75CA57A00EC
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:07:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 08:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793275667; x=1793362067; bh=mJtRfuKxTy
	H8S3WZpl/pSa1ryHQQDbdv49Lrrg8rrz0=; b=oqsr7G52I0aMCx4ATITfF3c0af
	KVTL1/Wm3Ygs/Lb4O1+lfF4c0Zl7QMoaTqHEkJNCZRDxNf/HFd3zKdi6E1WNilbd
	wt0cpbUvdD4xoh29NhN0irmDfs/vPfr02vnOWIE33ETIaKTQGuhBgvhUbUNMyhsZ
	Wk+Jcf87CBNMZID0LtO4JGzBqM3ZyqrGlgj9iMm76/CUZjn1HyWEZZdeQtHL8Bkn
	8p2qXAx6EYqwbo9bx8dpaD6mzgWWZeudLbOTskeCDH5xH9Fi/4CqGrceqcFT5N6V
	JaX9JelQC2SkTfxtmHkqmn3j5K4Cz6/1N+LAR4v1d3yz090qmj1OhjVoh1MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793275667; x=1793362067; bh=mJtRfuKxTyH8S3WZpl/pSa1ryHQQDbdv49L
	rrg8rrz0=; b=q4M5xZhBLpQi+bhHC3BH1Zn+qFQdyzLD9zpMinSp/PmMqyZeOl4
	YoxGhLTkZRuTk/WIYvYvai2LYKW5tqVSpoDnWHpjSho+y/cDcYBoN/xZGwXWfnze
	z7S9RsnzA20xO/B4C5TAmw2B2slu9Kow/yf+qV85UQWXkXWXEo/v7CfDypvtvZWJ
	shPcXc7uDgr0uG2dHC7r8StGAFJS+vM4StJbGUG2dsyQZYafeG0H3qQAVVKr29sP
	R8v+9QTE7OMmCCYCljYz69YiNABUOXLJz4P7rhtNn0X7AotACaYaZAGlduGce+4Y
	fUwnfb96lI7va88gQJXP95jCWN+xBRQ/nng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793275667; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FOP18U9OWHAsd9dhAmm1roN5xejsnHJvZAP3AAtTabLLD5C
	MVIM9AJwIOOvDeIwpS3kox5lpkqgBlO/kGU4im3Auu/6Z+hcSlHdUVA31PgLi1Jg
	X+ZdGZBjxw83ybpz7ybRvJeL+/LLNCz4WMIgILVQZkA/W3cYdejPxjnC/UgaYSRm
	FA+14QP0lUPTFVkBaYcn9unIDkkxfutnfmfRuGHbLXyo1XuJdo9+OE3laY/s1XbX
	IzfsA8YOUOpfqqhQO8AIrv3lldxjF5SNuVaRc+CJCN/lcO0a684VS8r6eEoYts4E
	fbL+bPRTkdPfIOfZOV3sH8S7cnvT5zS6TE34sjA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:n57eTSN6idUFN4V0YMjAnVpZ4Pi5kc/R/iGYU0ZRrl8=:M1VqkKYqR23EJd9xK/YICVZ9wXIIo8I5Q70aOEkTlrA=;
X-ME-Sender: <xms:EzfjatV4U5e7cVu-io2ESx_KtFNaBKc6OUSDJg33ZpTaALoGN37uTw>
    <xme:EzfjahQS536T3zQflSnncaaEjOZadMR7yyCur0OTdUBfq35-RBLTWsO4bMR64-ED3
    U90VblOZZXMZNbCizmccjtlzAhrtMKmn934QwoJIqT6Q9jKyGPgbaI>
X-ME-Received: <xmr:EzfjajMF1O27cVnAbo-4-Vg2nHh6KRVUDsGP1r3vgeHILgt0mMrF8g>
X-ME-Proxy-Cause: dmFkZTFhZvISiZxrO6L/h5aDWRb9nJoG/5xJB96iKkq7HXwMMaRoA0CQQoJIM0FvcJ3cDG
    mcMbHD30AqIHNh3V0cosAPvVpHv7WYh2bXT3ec1B3fW/D1k+RVOamXbwzVH0kylQC61uq0
    afIgyJ+lMjbqlc8pq4/lFKTgUA7w+vHMmUjRn1DQIG4MQSb82RZeLUNcRIhhTtv0dV4U9J
    r42BtjA/k9PRXp84dFUsm/XzietttaDrcwj7KhspYjBVgRIg1C3Epo5hEDn2N9ClFlRUeA
    Ju+AvGAkLpCDxBAg0uauTtK0dRi1f5KJtGkAf/KUjE0hlhNbcmf12s20fgl6w+is++NKXh
    SB2dMbnLRjAgildcKn3HjCyN72SEr1JXrq3it9CK3XvhsX8iU0Rzz+Q7A95iVDMkb8ndOW
    FuVEOX4QCiwJKXZeY9VDiCKT5ShiaxvqTDKrWzD/p0gVw5wmEmAueC3qjSHwmV2j4/1dAB
    z+dFhU30wR5bQk2xlbpe5/3BKfUa2ZIB7866RIW2nIWijcNRASkp7s6z6X0B5AzwRsJb1Q
    cHMO+6vmAu08hWxcHb314QZzSDmEG5EDxORnNu1VLyEBX5HCTik297N5wOd7L7X7S/Jbpw
    GUAngfmAlvqgfYKnc2E2dD+rJMLsgagy6wg0iBTAIxB0wzWNh6/SpCUJBrRg
X-ME-Proxy: <xmx:EzfjanR446hTZo0N0Z_PxvQBv3B_nDUoTsCPswZxwLuk2-Dqf6dwQw>
    <xmx:EzfjaphQeFD185v33L34IBBttJPSteqlhbFmB-G1k8ULo7XsiGMhoQ>
    <xmx:Ezfjao__8gYbJdZZpzp7LlKWctopjFDpCOdx0tzVgu3lhqTw9zaEpA>
    <xmx:EzfjaoHA7e4aA38O1RvRlX6XwyZtHXiddfXGypJMkOptis5j-Zv6ag>
    <xmx:EzfjaijSF0BTthHA1-Qfk4x1VWkCX8zOZYRNCm0T3IJyJxYQPVTxo-7z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 08:07:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5eec9589 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 12:07:43 +0000 (UTC)
Date: Thu, 29 Oct 2026 13:07:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] bundle-uri: use the passed repository for refs
 and tracing
Message-ID: <auM3DGcWTL5OdRnD@pks.im>
References: <20261028093455.76247-1-okhuomonajayi54@gmail.com>
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
In-Reply-To: <20261028093455.76247-1-okhuomonajayi54@gmail.com>

On Wed, Oct 28, 2026 at 10:34:55AM +0100, Okhuomon Ajayi wrote:
> unbundle_from_file() receives r and unbundles the objects into
> it, but reads and writes the refs in the_repository.
> fetch_bundle_uri() also has r, but uses the_repository for its
> trace2 region.
> 
> Use r for both.

Okay.

> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
> unbundle_from_file() still depends on the_repository through
> fetch_pack_fsck_objects(), which reads fetch.fsckObjects and
> transfer.fsckObjects from the_repository's config. I left that out.

That's fine, we know that subsystems may still implicitly depend on
it even though they don't declare `USE_THE_REPOSITORY_VARIABLE` anymore.

What I find curious though is why you didn't go the last mile so that we
could drop that define from this subsystem altogether. There's only two
sites left that use `the_repository`, and both of them are trivial to
convert (see below patch).

So shouldn't we maybe also fix those cases while already at it and then
drop the define?

Patrick

diff --git a/bundle-uri.c b/bundle-uri.c
index 1f1683b52e9..abdb99f4375 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -285,7 +285,7 @@ int bundle_uri_parse_config_format(const char *uri,
 	return result;
 }
 
-static char *find_temp_filename(void)
+static char *find_temp_filename(struct repository *r)
 {
 	int fd;
 	struct strbuf name = STRBUF_INIT;
@@ -293,7 +293,7 @@ static char *find_temp_filename(void)
 	 * Find a temporary filename that is available. This is briefly
 	 * racy, but unlikely to collide.
 	 */
-	fd = odb_mkstemp(the_repository->objects, &name,
+	fd = odb_mkstemp(r->objects, &name,
 			 "bundles/tmp_uri_XXXXXX");
 	if (fd < 0) {
 		warning(_("failed to create temporary file"));
@@ -383,7 +383,7 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 	return result;
 }
 
-static int copy_uri_to_file(const char *filename, const char *uri)
+static int copy_uri_to_file(struct repository *r, const char *filename, const char *uri)
 {
 	const char *out;
 
@@ -395,7 +395,7 @@ static int copy_uri_to_file(const char *filename, const char *uri)
 		uri = out;
 
 	/* Copy as a file */
-	return copy_file(the_repository, filename, uri, 0);
+	return copy_file(r, filename, uri, 0);
 }
 
 static int unbundle_from_file(struct repository *r, const char *file)
@@ -773,12 +773,12 @@ static int fetch_bundle_uri_internal(struct repository *r,
 	}
 
 	if (!bundle->file &&
-	    !(bundle->file = find_temp_filename())) {
+	    !(bundle->file = find_temp_filename(r))) {
 		result = -1;
 		goto cleanup;
 	}
 
-	if ((result = copy_uri_to_file(bundle->file, bundle->uri))) {
+	if ((result = copy_uri_to_file(r, bundle->file, bundle->uri))) {
 		warning(_("failed to download bundle from URI '%s'"), bundle->uri);
 		goto cleanup;
 	}
