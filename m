Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267852;
	b=kWr4VabmRybFX3ZJXnp0DVw17tmHElHvVymM9J1YrqRkRuiK8vN2jKjiIwY8mAzbpQw1
	 hmfIEADHUaIUWmw/5pwWFVHQH0b2Plz+GoiOZB7ajGubzhO9LpRNz5LgXBqCZ+CHvLrz4
	 hqRi+0q0QDdGPXhtZl81bu1iH6nPB761HXta/0sRpJ4jnhVl+SLLXXn7GR6kGN/Az2vH0
	 SaVSDuMu4J9mdvRVBh9bI3aTwAu/4VEA3fR9cqmamFU2Ap2FRAdky0g/KNbwZwPO4kt4E
	 iBF56UycnvskK8aTA+06Qf5mwCPQIqyGZ7HkvwdifKDK0VyDKY5rpWlHNQql/Mbjz4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267852;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=SNrMIMypnkUgrFocHZcYOx++w5OyGsKTQifRjpPyDJw=;
	b=h/R6ae/yZTTFN1YBMJMdAunnCzdkI3gYmxszBxKbZ7/tkFTVJHKpvuNlMO6xjMiiDCCS
	 3GX29mG0FSVLhUl1/R0IJ7dVDwfUWl6c2OJzdOpiPOt8YoMHiFbp3Fw7C0f2CxscgNRKW
	 mJmH+fJcoQER37/XZfN2syCrX3+Kf3wFDIkDjkoOSDELZUTPGaBUVDDBN50LhxGbuh41c
	 foJdUouyZRMyG8qQJkOcjPrISXM0OBMk+xdF+X4K5gaDycWCuDZc/C38z0CPAX1bagk4g
	 dFACTwowMwj+oRJrtY9RlobEshK8Ts77XhC8plB4J2Z/xyutmG6gWlitw5gfvB+358w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fXnwkUui;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O7b4grlq;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF26606A327
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF26606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fXnwkUui;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O7b4grlq
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A7397A00FD
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 05:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267851;
	 x=1793354251; bh=SNrMIMypnkUgrFocHZcYOx++w5OyGsKTQifRjpPyDJw=; b=
	fXnwkUuiUJ1SSCeqFnMrUGZLCRYac2S29J1T6vDT+VG5sikUGV8rx9SpmliEYyY2
	2Wno4fVSdVtLwfBvC3g4sICbVx6jfMXRp5TBcZLYqRt6ECuJB9GPrgdIA5KxMQDP
	Pk/IyBoyqWncUIjUobMpnGt2RDve3Ti4YqP/vLbx23sOj4+fYXysgZ5DNSIkum2P
	CWIlGAEjI/yTvbT+G4yNtCvJSe/LU0mzUu189lVAysX2ZlN1ZZIe4WtfQr/T7Qqs
	G9mTW7+wStmmRJPmF6LolTanZYhS1nuTwM1Ulr08QSpet01OjuhrMpp8W+Be6joj
	ok2kceZ/jNjxh9/kNY67bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267851; x=
	1793354251; bh=SNrMIMypnkUgrFocHZcYOx++w5OyGsKTQifRjpPyDJw=; b=O
	7b4grlqrMna5Ff0rj1PB7e2m2HDLVt7L3hU/DY3Tk9oR6NqUtnweq1yjnnP4WJ3j
	LCvJPU1SAO+p8nhlOu84vdlMq3e0EUcSjs/8nchgHxMsYWgK94hyvPQn4BG/6aNm
	0aJwKPik/aDERrpUHcpF4oFN5/Jpv0AnBkkO7+S+6M+GVh0/RxZbBlXOPMs5Ju4V
	soV6G54tHhK1ZXniEUPWhwviozsuQe6KCEkk0Cv318Hph31vJL8izjG9sT3/PKlO
	zMzlVSsRPM8z9IEJvsYwogdBux8rUNRpT4WsCY8iGVKNPPTbAe55p5833hBZLpIM
	uDvXygMU4bjCIN4/uOsvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267851; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pNfpdnhw40ipJnNRudTtOVnKyGBD+OHm6bMU16KOkgksERi
	fMM+mXMojUa9FGxIR//AGAWYfO+c5SJVr45OFsMNnpoqX4tH+DJsy570mhVaCGiI
	mzFo37s0x2TbI3k5cAwRzD2lcsxmStx8kZFPXOiheF0P3bIkRoBOYSArFtvFFxse
	Rem9AJQPtRFS7ImE/YoPf19uVqzj6uW1XQToo5x8dXbjQTeJflH2Tw57Knp2h8fr
	ENWPyqUzDWRyXZaJH3df/AkVo+OdSGkjIaHEfuZep5c+yOrC8+4BblF3PPUHVg6g
	H5XqLEjevAofYuIQOhA+AvAaa5JASaM5GoyCuVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:W9W0d+vcWb6ANz9yRtYxquuj01oFjb2FHOll7znk25c=:L6nbvgoq6E3JZUwQ1mWdjORtgyP7dVfZhUxuT0ZsmvY=;
X-ME-Sender: <xms:ihjjagP6cFXNTK7PRFncvM7XE7EMZmOREDKgeL5bRgXk_rH4GvojKQ>
    <xme:ihjjauYcT6ioj-UDBdEK4YzapXgEGYjTIvM1m7ZsnIJWWZWQUfZyQyVJUdsDoS0_U
    F6ZHRg3rOkPdwa1BvZEOGfeR5pkcPbnPyCI6jWTzBlSEI9YtBkj4s4>
X-ME-Received: <xmr:ihjjakr6KwrKOaigqmSwWgTx3fgn2gVhGORmP4YIbwmw6dQe1SMJZg>
X-ME-Proxy-Cause: dmFkZTGgtAjKRSYXe+EVyrfENplT63RuWFqYMuYhxn9Xg5mCWm6ZwU0qxbhO7CGVNqDjW1
    AUvMZPeWfTZl+YgWXj8EyHsZJPPgDKgtnUmHglE2kNhqRNre0rRP2YmJd1S0isSYCISidG
    iX5jioMBwZPX5FIm8JRnCfr400GNpSLm3PZutv8z3sJS3SVSYZmKPyUyrM0SOd2+3E+qvY
    0WcqY6/cNKoosD2VRW0hy0VU6apb3S/vT2zstdEWuOHTjkPMtOKqW0Jo+X0mK2y4oTF7FD
    E79RA2JWhJN39LmmFqUcOHNcXlSBKXPhvUXGPsNgw6PAaOkfi1Q0SZ5R6l2JcGLZfGKZS5
    wGKNgOK8K3575hNENtHJqbbK7x+eTfW8IqbpQ/SKWeKdsskAx1FkOSSKCxxfvDhmds0qMT
    ap3TDdFL3/mvCxybV/RynVXcLdUpfsJtRCSR+DhmZBr30nn2jq+OTEFflnkCf4bl990tg9
    UQnoqVQQUJInGUBDSDSPsME7tY4vDVIJbZKpp2n+653cFlPtUEWyIWqRvQDdu9140ICimj
    ZupIbz2SyJFCjLmGMW3V9IV2qXs5PwytaVhdHt7m3ZNCaYRYui49fGohdz2L/JsLm8x+Fu
    f3LJijghoQR8iZyvEOZN0gSqClLFxKes9mOawLGACYDnzfX5jX+hrCT849jQ
X-ME-Proxy: <xmx:ihjjaiaRmqiBYVGusOulfbOdJVFfPiVdR8dtf9awF6nfq3d-WN60Cg>
    <xmx:ihjjasRsodUsQc5-ZdPRJPi_7iS9yGb8gvCICEGPknjrmgbh3K8aJQ>
    <xmx:ihjjap7otES4WKR8abGBeLju3skq2x0ar98WraR-EMtqjAaiRSQFtg>
    <xmx:ihjjahwJgK3TPCmwhBJTYAbvFqsxtOIb9-aEqlxxE8GaQeg8hy4b0Q>
    <xmx:ixjjakOyHanIUAGymOhPGwCr-g9URh7SOCOgCVJ37gqA_p53tuXaf5Wi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98fb543f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:13 +0100
Subject: [PATCH v2 04/12] builtin/rerere: stop passing flags to subcommands
 that ignore them
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-pks-rerere-subcommands-v2-4-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The git-rerere(1) command has a "--[no-]rerere-autoupdate" flag. If
passed, we explicitly enable or disable recording clean merge
resolutions that are staged in the index. This flag only matters to
git-rerere(1) when not executed with any subcommand, but we also forward
the flag to `git rerere status` and `git rerere diff`.

This is mostly harmless as we would ignore those flags anyway, but it
makes subsequent refactorings harder to understand. Prepare for these
refactorings by not using the flag in those subcommands anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 83fb3783c61..405276cc94b 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -107,7 +107,7 @@ int cmd_rerere(int argc,
 		struct rerere_cache cache;
 
 		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				       flags | RERERE_READONLY) < 0)
+				       RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
@@ -128,7 +128,7 @@ int cmd_rerere(int argc,
 		struct rerere_cache cache;
 
 		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				      flags | RERERE_READONLY) < 0)
+				       RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;

-- 
2.56.0.341.g393f52fd96.dirty

