Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089132;
	b=x2LcH++A27T3ob3W9NoRbH1dYQFybCBYcjL9hHfpZFg6TpNcrXI/P0AQJvm9n5YBoqC4
	 LAMP++Ow+GZjbYRdzudQ1cUkM43dLZf1/FSNcJvDg6ayqChCVlxu0QBvjfMdQMhTG+htQ
	 JdWUKHOJuIK7IZ2COwTRzKy8XEvX0Lxa+xZwR6maeMsHTP5WceiD4KGmrS1uMRTz01kFG
	 ui3UlFQksvwNtFTsMyHr1xfocwKEWHJ8Dagmy5PvWZN0HtF4+KaNMLoKXz0VKWtA3ETw4
	 c1v3TEk8/dQWgkshjpmgt+UDWag4BmG4l9j1dQVIst6BUWm60ce3CDBCTS2ZM7QYTTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089132;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Ab6A/noKzP3sqXH6+MtIvUEoaEl8DddvbFcidK1JkmE=;
	b=yG4vn3QIx721Kz3480si/+mPBHIA0sG4cYJFMaPNTDw+GBIEB2759/A8pv8kN6LrvGQY
	 KnzFbRGYNwE/X0RL41JlP4oZb5ut/ZZlreqcr2YTIzy1e7ukutGWvS/e3mSCeXyLignQb
	 fcKMPsIrrYihXQDfIFvR9begFtE88UjhroH3+OFUAWmZcYnuK58XoWQWvThal6Bfc7JjG
	 zApUHCXi+e/En/vzqpCn1eapshHP0GarUEl02BOTRCs7G47MgsxOVUrZeAa4dqODq2Cxz
	 M4DlYd0S+bDN3yXdJZ+372r8d1EOT0lcrK2WrH75zufPNDyXYEvpOnyRj7ghMyUOf5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=kobvOOhK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xem93jqi;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE75606A322
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE75606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=kobvOOhK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xem93jqi
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F90C7A0101
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:18:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 04:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793089130;
	 x=1793175530; bh=Ab6A/noKzP3sqXH6+MtIvUEoaEl8DddvbFcidK1JkmE=; b=
	kobvOOhKpdzwO5YnEsdqqLHsocJVp4j4zJ1n+YtmKZE5EPdZ1+slQaTpOvMBhLSe
	kjaclx29RHXstKK2rkX7ziD2MA+np48B64IxbqsPoh0jbHMCTqb2knzz5k2ICL1P
	sJPwUm9obdaVAOPjoqti8JfZsZ+s2BLx6pqz21AYRfvFpp8ga9gKB8jO+oA6h9BT
	+8VnouTo1zpyGSgpEMoPaNX9Fq6nNVM9PA5xKW51fHp/uSEIta8IxI7Vu1IPiAce
	ZV/97vHkxft7Y8/KFCGfsIGACouxsOEkEDSvL3l2e3U6hPXtGN4vfutgQcbRmEmC
	n493XUvVVhQoGL0PLyfN2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793089130; x=
	1793175530; bh=Ab6A/noKzP3sqXH6+MtIvUEoaEl8DddvbFcidK1JkmE=; b=x
	em93jqi+RDs4EnaWruU7SHoq8R6y8aAxJWBktVRjz9/I9ZrjkADbF0X+pSJsvWL3
	5kjoW69MIAZ/dHEo9+Gm/14rtUcFrzqVxxrvr7XwQ29xzZthNKNUaG1vbhymp9+A
	ndXhezApd9FJcf5xi4hGU9Qb6QFJ8Pu0JiMu5CtMpiFXrCd1kLlpN6mC8dJhgCCG
	CIY6cDbJrjFCJuYQGhe5bAhLUa4zbBZztfTNh6syb9TSXLTgMb3umI357jDmfUxY
	LXrSVaS3ush2DXljsG9AD+nA6SeSuOMlVHs3y6Xl3XDIxhsmTbTfp5Ux+H4xAHNH
	JP1/1ac5BMmsvx3Aafbpg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793089130; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:J0pNzXGmiaI8OVIuYGZXGnRskXFKaZy83ki+5tD88H1tnn3
	fACpLZHAkbrzuCgIcpUAF3Y/9THVlxcYISHwtFikmJXQD8e7gNwagKYFVjGyEbHO
	okk9se93xKmjOl9CfH3i6wIBh5D7VNXkijS/FDobqvhgryKMOnSnLqWLN6eOI0vA
	agmPBficir9sdiCYuDq5VeK/UqhupjKEisG1sNQEm3Ww7zSgpT4HAZV3/8ugXDOg
	dvQDQ6DHC02fEuYCyvTD59CkcDDwipj9YdNUMK4j+1KwBfeFMkS2lWiKJuLNxIYX
	JzAWlCEeWppUz+U1EqmrDSF1SuMAfDst/I5E0sQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EMwshsTJuuYzbh9zh3XAlm4Cltg416lHLJVd4lFCov4=:87E19RWEpctYYONgEY0KQrR5AbD0KoN5gmRxyqI1Xus=;
X-ME-Sender: <xms:al7gajEscn1paYoFnJ69M-FvdYuOEjEnuU9qErVp6_ve5Is_Kl3_xw>
    <xme:al7ganWXq5vw7pPZjgwKZGD489jApU0oXQCttpzBUf4v30z6asYHvgAe0KsqUkwwz
    9dbaoPJpMDMVhJEFD1c7xXeHGKCVRh21OgVMB9fzdzQ3LNtibKFDIY>
X-ME-Received: <xmr:al7gaqKo6PVj532BMb_gDhjuWOSRJfec89yPHNIGojcj06vzjB9r3Q>
X-ME-Proxy-Cause: dmFkZTGpqKwLrmyDnTMV3CySRwOYBaRY4yQ8wre7L/HO7BruBwNlQBfvJpqbQceFCWJLw+
    cQ8TnN1syDfATAp2rFUepDEQTm2N22zn3elF6AYkSYafNaPEE08dYFKhSgjkub6i1Sh2Qt
    rYDqi49DuoW6B9WQSs02UKf1QMnEGbPKt/mIXnhZIpjkslkRkqZbjGyva48/Mgdej1LWcS
    2rsO2MhKoZwU5gn/rlVDSwEDcYWBS3iiQ2gGtvxinLKH10M2ATEI80IXAxkYBBIpeLXtNH
    Sy0Uiam1gyXz2VzUU0qEmt1j4GJFxli8zwF7ZuWxJAC2LfVtjoLlh+Hse523AD5Vhg1AoZ
    hi5sCahlHytkWXxA53/psPibWOEvFHI4nWGsrM9fOoS2JEVEXyvaPpXJaXpDfLz0U/LeGl
    l+HTuUg4j9mKU+Lsmuh0d+ogoBts8vb9cmPQgLQfpClJJAlblILf68m1hhYKfZD41rkdH2
    GSr6drNRWEJ3fIKl4lQvtwy7boCv11rbXoAzMbvwPSF6kY0meSCPFvKVPFIsSeu5+v0kjY
    GAhldaxVzsyPFZmVovGph4tx8pRkYJqFrQEYMfznQ/ChGz/HstgFj/IVK/Icosckv1f18/
    S+9EQR2X4GBDblFV4U33jU4/tXtWLXk2bK2OmtOgm6b4xkz7hVExGPJeRgKg
X-ME-Proxy: <xmx:al7gav9mCYa6eMdB0Q7l59r_OUVUE1imW3QDu1b2LysGNdfJ7hQGEA>
    <xmx:al7galIq30aZDdwtj_fUgFjjWe5K2HWkyS1Omh01D7i-lj4a8Wrifg>
    <xmx:al7gasn-OBscMrS150Wij7cl3e3VsBv_C-WD_FE__fOM4Zguv75f_Q>
    <xmx:al7gahMlZINLjDsjD6F4oswpgZNwmN9GqRmYjqorhIhWeGLasPXZ5A>
    <xmx:al7gaqEwJ9MlD-5nBQDWraQ5A0DRgqV0zhiZ5ullRDEqTUUxKpzRGz65>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:18:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 11ac83d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 08:18:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 09:18:27 +0100
Subject: [PATCH 7/8] ci: don't override initial branch name in testbed job
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
Message-Id: <20261027-b4-pks-ci-test-vars-consolidation-v1-7-f28edf79bd6c@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

The testbed job overrides GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME to
"master". This is rather pointless nowadays though, as we already
configure the initial branch name to either "main" or "master" depending
on the "WITH_BREAKING_CHANGES" toggle.

Drop this override.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 82bc169ed7a..fbb13ca6c6a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -406,7 +406,6 @@ linux-feature-testbed)
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1

-- 
2.56.0.341.g393f52fd96.dirty

