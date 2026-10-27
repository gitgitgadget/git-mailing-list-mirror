Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089121;
	b=coUSWUGoAmgR8e2dgzEVOU47oRN7fH28H8odXArNLRDUC1n6/DqtBHdeL61IJgFGIFaZ
	 51lvl9x4A5Wawl+mlzld1THnzZ3bqLxESYX/OK9THtSRfEw33IMtcGjS2gyCA4qEbW95T
	 l79Tzkrf4Y4yaBzvnhKpIBbqoDMeOQVL8KsHT+OQyDm9QnPm4C8SWJ0V3hiNTuDy9o7LS
	 YNxmBz85vVPsqnFlkgkmHtsCLZoofqSIalNkdbDSbVjREROGlP3p1AwbYQfe64PyYav4m
	 w0Ks+O+OVFXURgMLLLWLrK4s3QwDhzk3XzGoeEwg8ppT3sFRMaElbUv/RfGQUK2zaFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089121;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=weBzNhqyNfQuZ6YvsAwgwHM7RK+pl88uZ+mmf3MwIEI=;
	b=Bc/WFflJfc/ad2vxEIFQoQbHqK1/GqX0PKJ4mUmkFiEppjyYf0g8kgyfjOl3Z7Nnkm05
	 pCbAqm0dJ/kJSZftigH/wqc6hQo5hvqkCxrzYoy5PUY6qLnzlBnCOOWKLSAtz11Nb+OQc
	 W8jPZRkClnH9EEoYB0VLztYuaeB4xBeB5ofMXkKNG2aGrG137mK5275BL78JBm8qxOetL
	 CJ1IfmH3VnfTHvJfxqfyJGLt17z1aJOiRRJAClrz3WlgZ6z5wRC7Vhe4TnNXs5XUypwUv
	 xBlDIIm8AgV9aKzaFpm9F0k2OVofVOPBXU4x+oEUS0H9bY2FXQ/aODkLpol/C9T1m3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Xm2UmaME;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lDTvpUCe;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0F60A2603
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57A0F60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Xm2UmaME;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lDTvpUCe
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 986E87A00FF
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:18:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 04:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793089120;
	 x=1793175520; bh=weBzNhqyNfQuZ6YvsAwgwHM7RK+pl88uZ+mmf3MwIEI=; b=
	Xm2UmaMEe6Qhr+bCXtvHV6fotaFeiEmaQ/lCUU8zzUxKDlsaN8T5k0iggtg39EvR
	Z7RprzyDCg1aewE1hpRGmbeB/8AnX8xjTbzEQDVt2ygel6sRv1qxNSyMPXElfM8C
	H6oNk71rOyxXVvBYzIH10KGIXgqoDF6DQqIsQcDzPExC1vZRBtOTYCRz/pcs8Zhr
	Ih64K5vA+GWdpyhVxeba91dNch0Fg8G5KvdiSY9lCqtCTeXk79EhivJ+ZPig20LI
	vm2dMy+re32iYFKh+gW1ySq2sDNMD51VA1hUR1Mpd0O+JzNmdNhOkCKXcF64FPyi
	r+tSr6FFcie/w8ZLNVlWog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793089120; x=
	1793175520; bh=weBzNhqyNfQuZ6YvsAwgwHM7RK+pl88uZ+mmf3MwIEI=; b=l
	DTvpUCeqEjMuyY2ue50K3vrUbL7pj6r/UKrVue648JVZSEFy+I1wCH/JbbU1eOIC
	eLvlLKGSwJ+bdU5s3RLVtLzCdaR+eWncg3n5AFiZfh4QHx27JRLAfrpyAGWfkgd+
	xo0iYriJNIr/xoNmtr19u9NWSuy9ChDXuVsJWJeqTJiqBO0b2WNaVKQvItyXsCsq
	DMZxqVtWDZjhhJC2b2uKLVwHPeZccJC3g3V1NImzmOOHuc0EyujWZgRhIAeTlAaw
	7uwNXtLTeE0SuJpdXLKxDyKMFdfFEdKefqmHRzMLvYUXzHLiQeXpXTVhPJDz6E9J
	/unPvtMg+AB4blti+EyKw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793089120; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iQD/UvGbbKLToVu7xP2azeBVL0+BQMYw8AcyIvCbu2CVKq6
	MNt4UbVyboejIYTvNdtk/ROxYBfVJtBIZC1l5eog9KQy9KaTWMNCQPEVixohks1u
	P7/2cwhTAdMmT5W7FqIGKXCWxg6Wh0EbnpFCSI7IaEg0cnz9nFNp9Nj8IDAsaxCV
	tNNRj2s1nMUwg7Yp7jCMFvG0loUVA+eHAvlhSdHZsG27Tp5WM1+mk796tA6l+GII
	quFjtzXWUQPxp5TbBI0j8Ktd0fcqxLZeb5wmVnxMH6nSiQAMqjblU0wtY5nUihz8
	A3nTY7rRUIxJpfQAF0wObxCXUgHG5hUcyCtzIrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:agmolw5nCgxeHXSh2VRuSTRoF5kw9hSbTpBDl7VIE7o=:95k7NZ8SljGHPdwVTX8wL+lXDJspNr06d4qVfEc8KuM=;
X-ME-Sender: <xms:X17gakSnPHETHMelvBoLK5km7DOSAUl5VV_HIkxsaIxxE56z6JUUFQ>
    <xme:X17gaowQ-UKAqicRUHbQJ09y9opkTIneM2oGk2bvqRe2rMel8tRDa0UlfTOF6nmqc
    eyAZfCAD51C30bbz8VCSiXV52eAIyeiOF5T1MchtsSWfeK0PP7gXA>
X-ME-Received: <xmr:X17gam3h418U5Lz9vRnsaNTJN-sQWp46AsKM3s_5uAI9zMT-xCL4PA>
X-ME-Proxy-Cause: dmFkZTEq3SE52VReB8d5MrBc2dk3/oVr4VYU+C+Z7Rb4579P2FIDCi9/C66Wsq8CYhWQeO
    iZRwydlNdwzSpVtiO9hqxp/xDBYzF4HE2N2k28t0BJoBiB57+SZRzm1wx995BOjIOeaG5m
    LTqLPe0mwmflfV0YKYEng3lVDDNyi6OCCRvg+Fn4/6TPOIH1zuQSXOJabO04C01m88xdRy
    iylU34a9yiLe4BgG92eJWYCI0DufCfhu7+i7D7YZrLFyfT08h5k7QgmS2ZKFAgj8/M0Kaa
    fLaKn4vtf4l0DoTfzC7KR9pLdRpSHIjfZsLeaThRow10OMC9EIjhOv938W+RzkTdw4wUCU
    nMB6J5yw+E5gDUN1IkkofN932HLQtKpIYVKoSCDB4gYDTq/KsO4GePDaUaZx+YAV7ycfxd
    nKl9jkpAlaFixuQjCfN9TzpMLIteg7aIHO2LeQSrarVVbv94IQ3Z4BAGHketo9X28WAs6J
    Luva4fd025h2JZVrqmBkRDXgkk7X423owIHwtah1dX8EaWu3r+wFooQA8DTVIB3kNubhQ1
    tKeHoDVXiH0hsZJkhqAwTzVYfo/m1M5DFXvFudAVjo2FcpBt4pNEhB703K2GY9zZVMLX14
    I5n/l6be5e7RhN3KIMD/dY5oqtDLdEJPZ8U5FbepLR56ApBnzaGL2aP1AuYw
X-ME-Proxy: <xmx:X17gam73KsAuV9bf1FBZ_DomaGI7SgxAdHBeDn-0-QDZDTSy28dU-Q>
    <xmx:YF7gapVjQZdB3mk8qGqOCLpaMfQmuqJ75F7hV-KIP4ZaRfClXiKS-A>
    <xmx:YF7galCSQXi0rdIHl2YwowPfsf5qyVpzq54hFJMltMcrh85jAbX-ZQ>
    <xmx:YF7gao4_CudZRjAP0jgOQtzSOLj5QilupeavoGWdu6GonXRh6OnbUQ>
    <xmx:YF7gaowbtKl88plw8tJ90Qnb4cfo5mw2UNddQcHaiGhHcGmTrxeaCS3C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:18:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ccc571ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 08:18:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 09:18:23 +0100
Subject: [PATCH 3/8] ci/lib: deduplicate test variables by pattern matching
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
Message-Id: <20261027-b4-pks-ci-test-vars-consolidation-v1-3-f28edf79bd6c@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

We have a couple of test variables that we set in multiple different
jobs. These jobs always have specific identifiers in their names and can
thus easily be told apart from the other jobs.

Use this fact to deduplicate the setup of those test variables by
pattern matching for those identifiers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 560d785f67c..de4b94d4d33 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -373,6 +373,25 @@ linux)
 	;;
 esac
 
+case "$jobname" in
+*breaking-changes*)
+	export WITH_BREAKING_CHANGES=YesPlease
+	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
+	;;
+esac
+
+case "$jobname" in
+*reftable*)
+	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+	;;
+esac
+
+case "$jobname" in
+*sha256*)
+	export GIT_TEST_DEFAULT_HASH=sha256
+	;;
+esac
+
 case "$jobname" in
 linux32)
 	CC=gcc
@@ -407,10 +426,6 @@ linux-musl-meson)
 esac
 
 case "$jobname" in
-fedora-breaking-changes-meson|linux-breaking-changes)
-	export WITH_BREAKING_CHANGES=YesPlease
-	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
-	;;
 linux-feature-testbed)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
 	export GIT_TEST_SPLIT_INDEX=yes
@@ -426,16 +441,6 @@ linux-feature-testbed)
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
 	;;
-linux-sha256)
-	export GIT_TEST_DEFAULT_HASH=sha256
-	;;
-linux-reftable-sha256)
-	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
-	export GIT_TEST_DEFAULT_HASH=sha256
-	;;
-linux-reftable-leaks|osx-reftable)
-	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
-	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"

-- 
2.56.0.341.g393f52fd96.dirty

