Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089129;
	b=RYMIRiu9GEOZBzat/zAZfe+CiAMRbUTdz5cIOBwqRl6RAFbzu7im90IzaVgIcDZDLjw/
	 +VYMs4KdOIdeJLApmQEwcFXsiQEnSrcEbrGG5lzhivT5rdFq1wuf59T+H2RGIIRi28Y6m
	 iSaZV4ilE44wSJVnTJYXJXExFjtfm+QfDan8QOCOBoYS4V8rEvcaTqWCl9d4QHLgJsXCM
	 ym/N/v+GJLGL8Ll0xEgo9nAmcZhAfD+HYmIb5tHBvYuCNfJCvYdJfEJMStluZsQP8alQg
	 fzJNQbF2bnIXcgrCtNP3JNG5fqHm8O03YGXqdTACjCPJeCp+QJVehb9Mnh4ZIyv0Y/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089129;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=UG9FahbmSMUyWIhxhLjl+wu793sz3R1WD0oKZKzWQEQ=;
	b=wlhmV4sDUgTo0ESneNum0y3dhjG0OKLlRp5yWr2HX46PnQ+3Iyrclb4bLOMU8h9cf2Xk
	 42uK5DqMpmmaBNakpr9JXGToHmr1Cd5Q5rCO0r5IeOGplxKobozKmuG+SUf/AukeMPjUs
	 r+YrzujrXm7l67zQxYAm15UpAthYK1XH6fZn37FeXMFoABaxGsYXXSSvMcEk9QfzdH5C7
	 DeYmqWLCNCdOp/lfukczlqFIMJRET19qP1yVtV00UEwZAJd7I7hBAHieEN1n/Nay+VMez
	 gvFwBOoQXtA77TlzhkU3fCUhK50/ySMBEdWXqd4iQwdWaPsNCeqD58yF/0weQiv5qBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=B1B5LILu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="e9/euuKJ";
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB764606A329
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB764606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=B1B5LILu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=e9/euuKJ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B7BF1D0008A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:18:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 04:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793089127;
	 x=1793175527; bh=UG9FahbmSMUyWIhxhLjl+wu793sz3R1WD0oKZKzWQEQ=; b=
	B1B5LILumiJJEuaN4g5qyc6QKRxqDq6JxvlPW2NeS0BSoVpyIxsLk19cbksuvl9P
	Yzy8jncWkDa348C2NC5hYSazo6Ucb9KoRKuEu4xVqyfRp98yS2kCr05bVXhd+3Pl
	xtMOgaYH5amO+Zrl3PDZydSsB1ECPg8Hqm/qPFZSx8G1DPLwNaqm0+ypXdz7kNuH
	4PoPU10CQjOWHV7JEcLS5142hYr00gmZpW64/fq6Qji0uoxXqGDc0U4xZgY4clgV
	PzYcKGNL5E8YaBifZXaZEPfDp1m6250F3umZDvH9UoryXW8/xAAkWqbs7seE5gdt
	TncNmKL6LEcQqyy6XjqKyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793089127; x=
	1793175527; bh=UG9FahbmSMUyWIhxhLjl+wu793sz3R1WD0oKZKzWQEQ=; b=e
	9/euuKJaE54iaEqIWCv9UOAOKNCMyPM1C9L6ZKDQUULodSTnAh5RoruWtRpxw+J5
	hHWVl7tZEXHwRTVWz41cnAbz+AO0nNu1CUGSs9Pg5eqvEJgZavvItRwJ5QHs43hb
	jjwm0Eza1d7OHAsm0IDxKtxpiVDP/u+cV7N1Q+h+ToIVoBPzFAh/+E/TSFvC1WHW
	4MATZX5M7//XPak3B1qoRsDuBJqk43dpso2w2Rfcb0jRKjHskenGtk5FatsSZXOD
	WBf98HpuUwWsQ+hwwkn6dQNrmhAoiH//7Wfm1BcjJ+uROig7GsrmqicHDaJ0RLL2
	enY5gGNLRHSDJSxzoK17A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793089127; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QQedx852RSle5/y1rdvk8atlBv2wdL1QxX3Ovm+ProT3m4Q
	54YgYd4eArO/4z+SfUZ6aUmYDJ5gB0b10wR6Zj7B44I5Ck2ze5V2rqx8RRgNs3kj
	OqfO8lQMgwhFbDszgHCpHzISmi6H4gMX8YZf0UQjvE4InoHBT0fOJmv18A5dwZbI
	Ynkb/lf7LPVSqIJrSwCcmVXG8Ju8WYN6lAj6hRLj6gNmTEGMTRSpun4JcZJRfOM7
	aXbJUMw2tYOq4gpvi3DfxmspnhTqcHAVYigvE4/FFLrhJ+UdQkhtBMzmWtHVQy92
	TDG7okedz9Q4N6i5NltPxvcHCkThpykT4XoEDnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0GYB/ln6qD1IGn31O3xEJYY8pRPuyy5vU2zc4PsrfqE=:VtET3VDUl1oSExBIVrq1TstIx4AwXKpwhZaTp/tMdns=;
X-ME-Sender: <xms:Z17gahY6JwiDIuyiv_m3V5Q3KsvVYxQn3QMJ_295geOe_H-dSgKRow>
    <xme:Z17gavY_WrqmqTKb167_PRw-QOnuIFIhCbsCn2qeYtqf9FoMMfPdJiAmRPaDrDkkI
    dEtqN0MEOifi1U-S2MXEswHyDSuDNL_iBv5xVwB9BU6V-vcKkty1w>
X-ME-Received: <xmr:Z17gao9Nliaj2Nrus6E7X0-XxEkl49m2PDuIL_AJrOVywQ6WJ-mnHQ>
X-ME-Proxy-Cause: dmFkZTGpqKwLrmyDnTMV3CySRwOYBaRY4yQ8wre7L/HO7BruBwNlQBfvJpqbQceFCWJLw+
    cQ8TnN1syDfATAp2rFUepDEQTm2N22zn3elF6AYkSYafNaPEE08dYFKhSgjkub6i1Sh2Qt
    rYDqi49DuoW6B9WQSs02UKf1QMnEGbPKt/mIXnhZIpjkslkRkqZbjGyva48/Mgdej1LWcS
    2rsO2MhKoZwU5gn/rlVDSwEDcYWBS3iiQ2gGtvxinLKH10M2ATEI80IXAxkYBBIpeLXtNH
    Sy0Uiam1gyXz2VzUU0qEmt1j4GJFxli8zwF7ZuWxJAC2LfVtjoLlh+Hse523AD5Vhg1ApG
    7kny049gLbcpqI0o5MwophaOtjvvZMGadrDJthLDV9dPlqvkZ9pfWxMU2pcc+pdkj5Cnxs
    scWpnpy9QqeL1OvXpLlLq2d9U2rWfn+bSw4eIBachHvfeO4d2thSoPBhiJ7WORobao172u
    zun8ho7cdm3plw5KDV2uIk1G8+hga3bo2xRVZcDhGSYS8QT6ZdUuI1o1mf8p7npJ/AGxzf
    J94ZsEkA6BHMwJscvp7n92O51oMMpcMw56OhHxSSiE4gG5wKzKq3CwANftrUq9vbiZgyTj
    b3JjH/T2J9vDlyu+CMWK4TZ+3Mty7N2DrExmqt2/nFPRETHK358FIPW8ljOA
X-ME-Proxy: <xmx:Z17gauiNodJpXRMnjTmGZOFQ7wvgpkCW2a-ARLMI73RxDVtmCFb7HQ>
    <xmx:Z17gaocRaYNr-sUJvibmYqCCwL06SrXi3aKGlIGKUYYS4-H3iUq2FQ>
    <xmx:Z17galoOhuLwoYX1nqhwMSN_ms4LQ2P1nM-NUTt_Yb8drd3AkUDNdA>
    <xmx:Z17gatAL3LL3Nu9YJ4-cQwr1OFTfgnkY74r4UKkclrszWIKSdg8ZGQ>
    <xmx:Z17gaop21avhYLAfkojv2oCYJCyw9pTM-O0SAJGCm89jjcihwFsshUIW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:18:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7be9878c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 08:18:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 09:18:26 +0100
Subject: [PATCH 6/8] ci/lib: add another NO_RUST build using glibc
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
Message-Id: <20261027-b4-pks-ci-test-vars-consolidation-v1-6-f28edf79bd6c@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

With 32d5b90590 (Enable Rust by default, 2026-04-09) we have enabled
Rust by default. As part of that change we also lost test coverage of
non-Rust builds, as the only platform where we still exercise without
Rust is on Alpine Linux with musl libc.

Adapt the "linux-asan-ubsan" job to disable Rust to restore some of that
coverage. This job was chosen because we also get more bang for the buck
checking for memory safety issues in a job where we use C instead of
Rust, as Rust is supposedly memory-safe by itself already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 7f67a95cdcc..82bc169ed7a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -427,7 +427,7 @@ linux-leaks|linux-reftable-leaks)
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
 	export NO_SVN_TESTS=LetsSaveSomeTime
-	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepBecauseP4FlakesTooOften"
+	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepBecauseP4FlakesTooOften NO_RUST=Yes"
 	;;
 osx-meson)
 	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=osxkeychain"

-- 
2.56.0.341.g393f52fd96.dirty

