Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561530;
	b=aIcI8l2SebFAkG7A9osXxzjRQQpHsfjzY7qRmYeVM+ZSomGJfN6oBO6yYBmOAy+lV5Lw
	 c6w9XcvuBq3sfnvqlgX1iaBrv7xF0e522crmnY1hIn/qPi5wgiDcVmInV9mQYfFO8nVwX
	 bONQOWOnCYTT6xB/0MuDfAhTfhGH0Zjiiz/W8TVUpz33yLC/uEeTBJGJ54jkVzmnHnNLB
	 K/kWs0SLxqOIKzxsqLxxIIcRpfm25qUUV8cqcM1+N92xh6lYhbUW3TchohcEJn1N/QLTO
	 0GYWJknenMLDh7fFTeDmSwyzH5ShNKV9zmAOrsVIj9PtMbWtFv3WZ30U4EiTkDoAiog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561530;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7ZJjCymuEwSprPuw290UC+qs/QJXhQ7ny0jzSb+9hVQ=;
	b=HiAB0yAZpXt60c88Jtq8yEJ8+n9aSjkWdF3vVbyWtqLfkfXKTtRDKPsDbQl+7RwiihRr
	 5Ik1isrOb+wcG1sEBOwLkucFW2oOzRz5GkCZhiVuLnDDgLR2JNqf3xQP6OkPUhhwcsHAt
	 GcEtfIcjeXRFlcy4v5krc4y/AdxQIYMdoEa777CFgCVHGeNnIcBwl/Rl4ruuJ2Wt0BfHL
	 +ChkWgYlun3mVYSQ7iARSoQXSsda350eo7OxBKeQArC6PJu4mWKl6792hHlxypHqO3WXB
	 OwbTSKyfcr90UPp/aXY5rhmm3eNlYHC7BXihRcU+quHZVt4xkjw9XNGEMhWbe8h2Vyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=tfrlejnY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="GSQ/WysU";
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09929606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09929606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=tfrlejnY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GSQ/WysU
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 09BE81D000E7
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:45:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 21 Oct 2026 01:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792561528;
	 x=1792647928; bh=7ZJjCymuEwSprPuw290UC+qs/QJXhQ7ny0jzSb+9hVQ=; b=
	tfrlejnYHZJ5k1/Tb7qKePaG5AHBjuq2AH7iqHk6iI/NAcSiUlpFYfsCS+bp2BVj
	AS+QAFwDoUnElZNeD5LQDYTpKu7TkvPJJMb4hxa/k+JlBd5+G5sT7xplduT6aQm2
	vu0mh1ujiRWGzSBja4QpKdJvDNz5faD5dfysPF0+NfywM0l/rD+2e/nyN4G99BGh
	xSU4YW6oDviak+362rKjLBYYLy6z/Ofst3DF0/8LPoFMIrJntjR6hDTejlMAseyU
	KngPSW6irFebxfRM5h9gOwmdaWw62cqJMeKxpoit0Ai70S+qdIsk+OGADNBpsnhn
	E6Kr5r/ZP9nZD6Q2l+BxRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792561528; x=
	1792647928; bh=7ZJjCymuEwSprPuw290UC+qs/QJXhQ7ny0jzSb+9hVQ=; b=G
	SQ/WysUQGRXZLvsDXx7R1o1LHcEHACPKlXBPZZ+CQbus+QR7MSXqkol9Cruyh1Cd
	HNRzVLYyefdwN13BOp3nz6hX91Wqu3pGHyyxZSShc6+wctM6STC6qFLNhXOLWBJJ
	dazhFLGaGTtZuWhF3Q5mSvo+I9vqDcoMXI35ehUVU8JQ4AfxkuJSgHYBPqjFrGnV
	uWy2JhF5KPU9A2dRDWafNlUETt2jPUQBrtVuwMHpzKZhnwZACSUNombyoCP2vt8j
	5hC6DctH3ZLoyDlZ9JKvCQfaWPyG1bVLR0CWh9wFohTEzMhBmgjZWbvfZh0oUmAK
	vKNPAa1+9HAMUqBTEIsOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561528; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PDremiCT5G6rnfrhgVWeXLKC4H7jX8sXkxlEMzVlTvQxII5
	abCQxgRYeQod6Qzd8xnM0TZnKU5wFCXw3QeC8fqtoAIvU6LjiTfMHn45OiuG7h1e
	VNgJPuht933nYTyQVl0yQ2yVxuhJ3FFmFoaIEm0X9TJZdWQhTSEEmPlq2vtBJCan
	3UbDJgzX1NTfA/2/ILNtiOJ94nvRlOHSOpyu0bQrNhfKipQNztzvSSxPkCdGA0Q+
	xj0enFLY4glMj2srG2XzI5S5HEP0zh2shB+bnKNbLEm1HycOGcJh0dylFZkahOaI
	iPN6N1Bg7pB9fx4dAdzxb0NqPx4fXXy3zyCSCHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iE4ovIZlspZD89uPxnUPGVbcMTOVBlRC0JJsgTsazYo=:KGVN+GWBsPy/9cEbIp4iPgSeQL8myYaGYO4mHVEROVs=;
X-ME-Sender: <xms:eFHYait4-Oy2JPiwOCF8_cl6vOZvrarkXlxm9Wit3pBKT--k0Kepig>
    <xme:eFHYau7DN-VzZbE78khX5aHw6njFv4dsgYkRscFOiYsjjxUSE-6dkuGdNjcBd8R_O
    sB69oIuAvj59EpHjy7GGP1YUmVUDLYjPIvgk2CLD0Au2KufXyHiJcs>
X-ME-Received: <xmr:eFHYarJIrOpzcrJ4SCdJ652ti3vG-vIRXU1Qws5jRHpOPqWFzqG1VQ>
X-ME-Proxy-Cause: dmFkZTGpyN69Zqn2iFRHZ+DIM4dknOquD/2g4w6sW8kgwYAFHqIeetb4mlKpgqpfJgMM6K
    8IZ9zTvs3lR0OEtCTwcuN5L9PMkpBTB3528ouu9Q7qyFcL6QO2KVdX+RleVJ2hIgmzVyIb
    SynJP+KrQgV0DnOPX8uaQXn357h6nchp9dv5pqDyYkDXosxwVWemIq0llEvzWtDmX+AeE5
    EofNf6O/HV7GHmux6byUBk/V8L61/IT7O3S7JRL/UfRcIinAyQV6uKxF8HdDtHVMVKfIRH
    lyU/f3s3EV2PtAPvMcgokK8YgKjN1N4j96WbObbPG57I95f8shiP3Gy1y0X7fk7qKO4IGO
    GeQ0tEGPnEKk31mE+fwHxIS74LbZy6UslL//wE1FGy07FH+nijXPdamtvo/T98RTZCN1SE
    OWFkoJHMdpKrTR5yJlz9kXJUUvrKXK3Kc1stDviKzaJwmj7uIPEeiByeG+YcNB3qpnh5VI
    2Eu3RpXHc5j4wLG0CxLum/sAmoE6EEd4cTlak1ae/yIwJD4doqnZw7x80BldSNRtdoMwGf
    WKxn/eF30VIQKAJjJKdF+bjCCeiN8v+BbtdyxHhiw1+Umutq7TM5Nzac3OxDHdfWHsw8Zw
    g7h+0QpdBvSk9UC2CTQfo89tBqTyrJVfKVcwPpPW3/rzpa0RKaeLuA8gcHGQ
X-ME-Proxy: <xmx:eFHYam5jjf2ozFRUyZCo3dqH0Rw5zVTlQyTRZqYSYnYe-9MOk0hxUw>
    <xmx:eFHYamylUXTVhB6cHKW-4tlTMgAyC9kZmLCoUCBPI1MT7y2M4s2yZg>
    <xmx:eFHYaib4gxMsiD53_7pfwLGGOo8OwpwQfjSwzt-FCyev0eI8uUcUJg>
    <xmx:eFHYagTW_QQ0EbDZFe-qRbXPIsMeCwjpkOpzhO8vcN2HHkB7TmXXBA>
    <xmx:eFHYamil7PPFW0Ev6gOkVevqf5vL2u_4P1J__oogig-0TsrEPO-pVPMj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:45:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 029003f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:45:26 +0000 (UTC)
Date: Wed, 21 Oct 2026 07:45:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2026, #06)
Message-ID: <athRc1-tSEVgBupp@pks.im>
References: <xmqqbj8tckpu.fsf@gitster.g>
 <20261020185101.GA6367@tb-raspi4>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261020185101.GA6367@tb-raspi4>

On Tue, Oct 20, 2026 at 08:51:01PM +0200, Torsten B=C3=B6gershausen wrote:
> > * ps/pack-check-bigfile-threshold (2026-10-14) 1 commit
> >  - pack-check: fix bogus corruption report with core.bigFileThreshold
> >=20
>=20
> That does fail here - the read-only files was not overwritten.
> Patrick, can we get this extra line ?
>=20
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh                           =
                                                             index 16cc5d5d=
cb..a19bb27db7 100755                                                      =
                                             --- a/t/t1450-fsck.sh         =
                                                                           =
                             +++ b/t/t1450-fsck.sh                         =
                                                                           =
             @@ -544,6 +544,7 @@ test_expect_success 'rev-list --verify-obj=
ects with truncated loose blob' '                                          =
             cd truncated-blob &&                                          =
                                                                        blo=
b=3D$(test-tool genrandom one 5k | git hash-object -t blob -w --stdin) &&  =
                                                          obj=3D.git/object=
s/$(test_oid_to_path $blob) &&                                             =
                            +               chmod +w $obj &&               =
                                                                           =
                                                                           =
                                                                           =
            # Truncate the loose blob such that its header can still be    =
                                                                       # pa=
rsed, but reading the object data fails mid-stream.                        =
                                                                           =
              =20

This diff is quite mangled, let me untangle it:

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 16cc5d5dcb..a19bb27db7 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -544,6 +544,7 @@ test_expect_success 'rev-list --verify-objects with tru=
ncated loose blob' '=20
 		cd truncated-blob &&
 		blob=3D$(test-tool genrandom one 5k | git hash-object -t blob -w --stdin=
) &&
 		obj=3D.git/objects/$(test_oid_to_path $blob) &&
+		chmod +w $obj &&
 		# Truncate the loose blob such that its header can still be
 		# parsed, but reading the object data fails mid-stream.

Ah, right, that makes sense. Makes me wonder why none of our tests in CI
hit this error. Weird.

Junio, as this patch series is already in "next", do you want me to send
a patch on top to fix it or shall I send a new version?

Thanks for the report!

Patrick
