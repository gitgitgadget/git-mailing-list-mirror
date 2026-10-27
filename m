Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089118;
	b=pELOHdEDa7v+KCrmdsuUJC68d5UpOsYjEYbVkkRptA46CN0/xYcT8jF24I5Ip74Y7uGv
	 HjYGj7JbMKPb9ZKlk91Qs2u6nTb4mJ9B60P2EUsMO0wvfph6Qflvz+0KR5zRqdf8Soo2a
	 RkUDOBm6GwuHFDhnfLODtloMCsEP2fLYcR7OB78K1fIhCa6Zc5sahmawJZ7FGNhJj8xlU
	 ghE66naK67l3QtSKnCuJA7s2jGRc8drRnaMFfw0ww7GS4eUEUotjMVxc/bM89kjGuv862
	 EPNDY6E5JA+LbGcHiEaPvcl0VO2MjGGwbHTDYGJe6XpivMG5l1vnsXeSE7xiGCbjO4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089118;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Y+8L9QDSIGBTrHZDEbB//7wJfDbELHjiiVvAqdIDTSE=;
	b=Xkcsmj4KiF8MF6S8lgnC+k7RjJn4PR5NC10vOzJ0LtxygnwoYFdZs5IGRhLh5zKlMJLb
	 Nv8pGEpB4wdaAV5x1K1VvBwXWFqu/grv8akdEzOVUPAo3hOSsOl/CRwOOVxWijW/XRcBT
	 jTYDmxL2DCDbk8GlafkQQghAk0EF+kfdnS2SLIiltPttAYeLpys+QQw7sRzskiC07uqOv
	 ir5dGGrq6LpYwvO3YYvSvoC4fzYbbl0U1sOiB2FjLR0bfKLrkPAKPKzqTk5VtY6ZqdYOg
	 g/msmgReVag90tgSHW0+YoLWzJogWi/12b3VQKK6m5wgaVFb1Oi2df/K3G1RUExdtAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JNSfJSME;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Bw8qX86R;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD0606A32F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4BD0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JNSfJSME;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Bw8qX86R
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 270CE7A010D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:18:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 04:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793089116;
	 x=1793175516; bh=Y+8L9QDSIGBTrHZDEbB//7wJfDbELHjiiVvAqdIDTSE=; b=
	JNSfJSMEwNpJgcfe2rwH5sxIQxik3N5ncQOapXRyGQaaghkySuzkPWCL4u1tuXMX
	gVDMWfD7zardW4HY+XknCTa1dmkCFnON2e6cF0CufvttKonHbKz0DjejMIceRPpk
	FnZaYOpxmHJxdiLLdzsJYfZ/Vm+aFWqWSAWsOIR1MW7jvqLD0R81QMGl5H5ZRtbu
	k5yjfKCOv0GsEy7X0pDT35gZqrQm/IX8gtEpytQ6G7srLWWPN+Bekr69Agt2Gawz
	D6CjrfshkpWvb82piYb2A8PW3rBynrapWCjSU2JfGMpdcP/HDRlJhKK7L4+4kL7S
	RIJ4NnyVdGvJ3I5Is8TLGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793089116; x=
	1793175516; bh=Y+8L9QDSIGBTrHZDEbB//7wJfDbELHjiiVvAqdIDTSE=; b=B
	w8qX86Rs+cPhG7ljzmAgK+B/vtdJshuhmw78fPsDT5wPkkZldhtUDkRJ1oTeoKzd
	h6d0/I4ZGO7upzwkfFIqleOdfpjkT6UvllZ2gaCIAXJDPQNiOPgb+6gPYMZ/Ll6S
	PXxoLoSgWVe/pX71LTUxoDWizj5GaIZULeXKMFU1jRiWZ0s1s485wovcHGmvK7i4
	Eope80mzR28Yoat6XXFXrl+Du8OqjWA022dBxu1u+NLQT8rVIHLgH77RsyuC/K34
	5CU/gCk6dyuGySxn5TQLli+7HrM3rMakxg8Lgm59z53PtIskHM0SNnzIBme8J6jQ
	7faFOBbQZm13NcbfuxLRw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793089116; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YGJAlBL61F+TOxizuLVJFljnH425OMGbSwqpxS7TaUXBrhx
	NZ8Et1um2+H4Jj9NNtpuuz9tZEqFLz9uRHmcA2aVj9EC/ai4NQEFdiM2v9B1Krqb
	cXdaQt82NPv1H3iwOyO7nuYXAKA+XcbKs043sCtCk4SC4y/c16DHagp9p3Z5E1tL
	QlQNnmQlUK/YqIP5jjTxsU+ms9qIs9Wuwj/oZCKiRLTcA6PKsbKb+t8hgWPJBUC2
	kAfMv5Qg3SQ39dvuVufYbxy3XRH8Mmy43dQ2oekpgar8+1gxAQvDDsddUEYR6fKc
	Fxsz04HQAEC9hFwGMy9PgdkabRSB8kXFE05PNuQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:12zhQaSxH9dSNms1AEJHR9KRogED22GNwBT2kvmfXuI=:GG4QL+P+jHQvXsZQ9jXdhxsiD8PBaG+ixA0bNBNU0og=;
X-ME-Sender: <xms:XF7gaitgGdUfKIIsbTlVdJwPdzUybZfFrEbdU7RCSUACKMfwdPu7DQ>
    <xme:XF7gaudUB93JdfbRPFlEekJXXiSYJWcnuEFpCUJqp74hkuOWTJCzn1cRR4I3IM_cD
    gnCxwkpUccq7L18PHq8eZ3F-r81jMwcnxMkOaLJuBbQncEY_smlLA>
X-ME-Received: <xmr:XF7gaiy-RLcBP751W3REBZ2KyMArjoRAMgMbZuqzTPfs1W8wDNdIqw>
X-ME-Proxy-Cause: dmFkZTEq3SE52VReB8d5MrBc2dk3/oVr4VYU+C+Z7Rb4579P2FIDCi9/C66Wsq8CYhWQeO
    iZRwydlNdwzSpVtiO9hqxp/xDBYzF4HE2N2k28t0BJoBiB57+SZRzm1wx995BOjIOeaG5m
    LTqLPe0mwmflfV0YKYEng3lVDDNyi6OCCRvg+Fn4/6TPOIH1zuQSXOJabO04C01m88xdRy
    iylU34a9yiLe4BgG92eJWYCI0DufCfhu7+i7D7YZrLFyfT08h5k7QgmS2ZKFAgj8/M0Kaa
    fLaKn4vtf4l0DoTfzC7KR9pLdRpSHIjfZsLeaThRow10OMC9EIjhOv938W+RzkTdw4wUk7
    fLS3xQ2tvmMWq35SzpWxO6Rlen9+VDORJRmmdGxkQNMF2a7hx/ZmsNYqwz9auAddX+c/mM
    8cg6CMApON6qDsQVWKJrusCXvr2WaqOZCaIjRfvgcaGvBdFiLGah0DzZ313WqR4HJxzpe6
    Ko5e3yytbCsOEhbvA8MZOJ3h3HEWse0IVPGhYzp2G+RcCg+G4PzHd4nIljlzlIP3XF8u15
    aOhUbJ8tCvKRVIPl+pZ5TqO8cASta9cGdfXcsxXUCPDMZISDSPmwHloeidho/L06nmzEbj
    BVg8/tLicyBTkmJGsH058SUoniPC+3FaidXxE8B2EY4PxazW1jTIwRHUE60w
X-ME-Proxy: <xmx:XF7gasGO0Bw5vq2SKzs6wySoLUIVnpOXINNqMU4d7Yz6uMsJmuuOGQ>
    <xmx:XF7gauxjO0pTV14f0GANs_Ot38fdl-yiIuBlXtehezSdu_Gy9QkjuA>
    <xmx:XF7galvhNQvU4LNJzWuqdKOo9-SNt3N1TQ9Std5Ksd1oLftD4TH-kQ>
    <xmx:XF7gaj3JN2A7GGPgYZfoQMECVk5dP1mqnfLsMT5X7DHJujzp9tsOlg>
    <xmx:XF7gauvNPtPaeQbzrj8954yRbk-igo7A1_cYQK18oDgtGvWpbP09aP0t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:18:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2a1d557 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 08:18:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 09:18:21 +0100
Subject: [PATCH 1/8] ci: consolidate setup of test environment
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
Message-Id: <20261027-b4-pks-ci-test-vars-consolidation-v1-1-f28edf79bd6c@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

The setup of our test environment is split up across "ci/lib.sh" and
"ci/run-build-and-tests.sh". It is not exactly obvious why that split
even exists, and because of the split you have to know about both of the
locations to be able to figure out the specific environment that applies
to a specific job.

Consolidate the setup into "ci/lib.sh". Note that this is a pure move
for now that results in some awkward duplication. This duplication will
be cleaned up in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh                 | 43 +++++++++++++++++++++++++++++++++++++++++++
 ci/run-build-and-tests.sh | 44 --------------------------------------------
 2 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2e63d652543..d0bd8113d35 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -394,7 +394,50 @@ osx-meson)
 	;;
 esac
 
+case "$jobname" in
+linux-musl-meson)
+	MESONFLAGS="$MESONFLAGS -Drust=disabled"
+	export GIT_TEST_USE_SET_E=yes
+	;;
+almalinux-*|debian-*|fedora-*|linux-*)
+	export GIT_TEST_USE_SET_E=yes
+	;;
+esac
+
+case "$jobname" in
+fedora-breaking-changes-meson|linux-breaking-changes)
+	export WITH_BREAKING_CHANGES=YesPlease
+	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
+	;;
+linux-feature-testbed)
+	export OPENSSL_SHA1_UNSAFE=YesPlease
+	export GIT_TEST_SPLIT_INDEX=yes
+	export GIT_TEST_FULL_IN_PACK_ARRAY=true
+	export GIT_TEST_OE_SIZE=10
+	export GIT_TEST_OE_DELTA_SIZE=5
+	export GIT_TEST_COMMIT_GRAPH=1
+	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
+	export GIT_TEST_MULTI_PACK_INDEX=1
+	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
+	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+	export GIT_TEST_NO_WRITE_REV_INDEX=1
+	export GIT_TEST_CHECKOUT_WORKERS=2
+	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
+	;;
+linux-sha256)
+	export GIT_TEST_DEFAULT_HASH=sha256
+	;;
+linux-reftable-sha256)
+	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+	export GIT_TEST_DEFAULT_HASH=sha256
+	;;
+linux-reftable-leaks|osx-reftable)
+	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+	;;
+esac
+
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+export TEST_CONTRIB_TOO=yes
 
 end_group "CI setup via $(basename $0)"
 set -x
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 68b91e31439..b81d654b561 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,50 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-export TEST_CONTRIB_TOO=yes
-
-case "$jobname" in
-linux-musl-meson)
-	MESONFLAGS="$MESONFLAGS -Drust=disabled"
-	export GIT_TEST_USE_SET_E=yes
-	;;
-almalinux-*|debian-*|fedora-*|linux-*)
-	export GIT_TEST_USE_SET_E=yes
-	;;
-esac
-
-case "$jobname" in
-fedora-breaking-changes-meson|linux-breaking-changes)
-	export WITH_BREAKING_CHANGES=YesPlease
-	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
-	;;
-linux-feature-testbed)
-	export OPENSSL_SHA1_UNSAFE=YesPlease
-	export GIT_TEST_SPLIT_INDEX=yes
-	export GIT_TEST_FULL_IN_PACK_ARRAY=true
-	export GIT_TEST_OE_SIZE=10
-	export GIT_TEST_OE_DELTA_SIZE=5
-	export GIT_TEST_COMMIT_GRAPH=1
-	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
-	export GIT_TEST_MULTI_PACK_INDEX=1
-	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
-	export GIT_TEST_NO_WRITE_REV_INDEX=1
-	export GIT_TEST_CHECKOUT_WORKERS=2
-	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
-	;;
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
-esac
-
 case "$jobname" in
 *-meson)
 	group "Configure" meson setup build . \

-- 
2.56.0.341.g393f52fd96.dirty

