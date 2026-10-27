Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089127;
	b=mBiWVlHFGMXeFr50fvEJTGwQnYrL1uo+8cpOF0F/+2ui4PysvRxIrifMXkvShPC7nJR6
	 XpCllxAkmBvZSSSinW491irRLuXFSGlhCXTvQPLwHP1K4ShcdBmMreUTnMx1lw+LWHVGg
	 kkcM3SyKS+8fmQVs572Dm4+f15pdsl4XCk12fWECxh+nMBabH4kMGeP1jCOrmHuoBP+Y7
	 yWUkyq/aL42GwbmvZFVCCviRXPn+75LR3/Jq+axPrDJit5Kg0TQtse1Fl2CzkDvdIiwkK
	 nmvqLsRJDoqpIQJQVn26FDIvHV/zGKKSKvQN4/tcSrrW5o2aHk1sssiK7UDwkokSvmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089127;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=GWGUeRkYJcuRbuBa7JSMXKrqnCtrAlBuCBGKPkAzJUA=;
	b=AzAtLnOXQspdPnltAkIBZEytdIqy1mj2vr/zWdFEbBLwnCUVMddxO9GOKXBkQMfJehaF
	 aczzAjZygpb6X/pgmwhb/RMBDOmgLcnovwnWBaTOAMEyGqfFRtiIDeNgQQjsyklhlOcFA
	 YPnPhUqH28AogLV/lpiq/MBO7SmYz9r5wp1Of8I+G3zxZ6A6T+fuSpdJFfrJUTDVMm9VJ
	 98j0YzYr44DHxJLbHCR/OgrFWHC5oTNk64kkMc3ePBXIMB9CZUHCu9kzQQF7Unb46Xi7Q
	 mMkwIH3lPteFwln42avT7ZH3o3DDaBy6ltSqlevxsLjG1vFQGcqUwBCydelRK0f+sxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gKvvD1my;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XjEZn3wP;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEAF606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BEAF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gKvvD1my;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XjEZn3wP
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B84521D0011E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:18:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 04:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793089126;
	 x=1793175526; bh=GWGUeRkYJcuRbuBa7JSMXKrqnCtrAlBuCBGKPkAzJUA=; b=
	gKvvD1my0kYkQbyiTyo5TBvV4ARVDTWz0El1XeOn4DX/tQ2RZm6m+Y1slEcEzSy+
	T36BZC9aZ4o2spoKFktzlZHHyVZubx7q7gfOTaggX5YloEPvsRCORCeQxIloGrbv
	5l+vGZU0rIdtyy9ipTfDahqjxcIhpupvtPyw2WBykkYAO4gWXLmJYOzz83D0zm/F
	ZHC4ImMIZqAfSvNpkTwLR3Fm3YkDGT1M5UfQY9hpuEtAHP66SVzUVtdaceZAxNi0
	lif0I/4jwefdI/GnbmXEvd2/pqIjJJ4Rvt/C6a4M4fWhdyaSx72+uaHLZyUnHszD
	hPbDzXpbyyqjPYc1alEC/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793089126; x=
	1793175526; bh=GWGUeRkYJcuRbuBa7JSMXKrqnCtrAlBuCBGKPkAzJUA=; b=X
	jEZn3wPGhkTHCbXixD3m0RYeutg1H050KfvbE3RQD6cD/amds19dT4mKjErmSd16
	rK5712JnidwUqFsl6nnSkpzMT8/5S0cnEr0LJ7JtntduQ2ahNu2rgGpDc/qj88KV
	Mmuio/6dqULgLi5BA/tWHplVqg6oj+yCg8zgKR6CC2L2YzKHfdoPfQ7MMoZfEFO4
	sVJ8z/kL8v7DC/k5j31XT/3tWmOghNRJXqieQS9xdHuBQ4IpOzZfrDUaW+LFehEY
	SZYxgUSwPUHrF4sR6TvzY30lfKA2BFSopTbNXWNtGcYGf+8X1cO/BdDF0DlPRI+Y
	Gq8+wPltHR20ct2IpPxlw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793089126; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pzpQ56iOBlSStWiJTxUZWW7QuZU4cv49W4X74Vi0GJ9XNmT
	aawd8BdPJ0LRF8JrJvvTkD2tuyNnykv4OW5jt5LvVhm1NOGk5yy9332g0Tc6z4e+
	64wK3dN1oZPoVuxqfUtAAaTaTYaO8RbaFDZOm1WG0EiaI8ITNxzBleqGcY+NFA5l
	5zubAWxQnU4choYRdEFcBdAgG05/eocslRCOrQQNyvrsB/GtR0E5DjG2kIUdoyzq
	vgXOE9NBNotcFfc5cBK+jmTm8DPVUIp42DwznkLS+8H4i/UM4bYimIISPgBT42QC
	sEv7IisUhNJk+BdHkz0DrYium5tu5/nb5sfmI/A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8H0NisEXXHHzJ1Djo0V6xJlng3HvOBqus+zP02Cce+4=:UAFCnhWZffnzg7kcFAMAs3VXBiSWW187kV7rUx0eVCY=;
X-ME-Sender: <xms:Zl7gaoe7ioa6sJrdSXGIoMhqB-Py1e7nCDV-0PBpPdZkkrcSDsFCOA>
    <xme:Zl7gahPjL0OZBau8DX2DnBkvhJtD9vR4AptypNnNs02mYjb98qPcOr5u-7CZnwK3R
    91ZynrqYrWWOU_uxc9t0FSyyFkQ4p3ZNN4DVjchL4Su_abb9GWNm0k6>
X-ME-Received: <xmr:Zl7gaujO1N4Mf7NiU65ooChh7TEVyoobOlW-sDun1zuOZyPtCNRklg>
X-ME-Proxy-Cause: dmFkZTGpqKwLrmyDnTMV3CySRwOYBaRY4yQ8wre7L/HO7BruBwNlQBfvJpqbQceFCWJLw+
    cQ8TnN1syDfATAp2rFUepDEQTm2N22zn3elF6AYkSYafNaPEE08dYFKhSgjkub6i1Sh2Qt
    rYDqi49DuoW6B9WQSs02UKf1QMnEGbPKt/mIXnhZIpjkslkRkqZbjGyva48/Mgdej1LWcS
    2rsO2MhKoZwU5gn/rlVDSwEDcYWBS3iiQ2gGtvxinLKH10M2ATEI80IXAxkYBBIpeLXtNH
    Sy0Uiam1gyXz2VzUU0qEmt1j4GJFxli8zwF7ZuWxJAC2LfVtjoLlh+Hse523AD5Vhg1AVS
    aD0uu1oGIT5G4KLbqTWQ1mIIGLcavtKVZubdwqyvpjatmyBY9xKoh3Qd9UNodn4FjCBFPI
    OiylAGDbmdUnqUXfhCwIni9L/fBx5fs+ornSkKwDFRf80buBZetxkMWqDQN+XlQn9xu1BR
    v+zytzWXl1DY4u+U0ZxkWw7j4FYztgClm+o1yHz2gJ+Tay5HaK3+3Ne7Lk2CH2r2P5y27l
    t9G2HNBxUHs7AvQ39Lupd92iL+8SfE0JOWmcwvje+Uj/faaLHbcUIV9Of2s2PPVs57RCid
    U1IRdrU20495y6LZ9lTNbppc+qp1X+wpeyFgEbJawhYlegO9X6JaabiWVrTQ
X-ME-Proxy: <xmx:Zl7gas2WgNkl--yy1-0Eq0YcLQPYuxWScblObvwkv8CLxUMiO04kTQ>
    <xmx:Zl7gagiZeZsCkBROwGrwjf0TggS8YkCSpuvG_JRXoAftY9Zg_oW4hg>
    <xmx:Zl7gakemOcRftzTe4VNHpfIR5wvLKdKmq7NpO9LnFgtT831XgT9iww>
    <xmx:Zl7garmpTrtJbB2DjRveluCXUkkv4BrBXwDPlumuxsglXvZsRwpxlQ>
    <xmx:Zl7gaifd8Dywv6RJQ9nZGzrPNVunO184EXqN-tDSQtHcBqhSbnyFoO9i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:18:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7492696d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 08:18:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 09:18:25 +0100
Subject: [PATCH 5/8] t: honor default ref storage format
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
Message-Id: <20261027-b4-pks-ci-test-vars-consolidation-v1-5-f28edf79bd6c@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

When running with breaking changes enabled then we will also run tests
with the SHA256 object hash by default, unless explicitly overridden.
But we don't do the same for ref storage format and will continue to run
tests with the "files" backend even though "reftables" are going to be
the default backend there.

Adapt the logic to also use the compiled-in default ref storage backend
for running our tests. Like this we'll now exercise the "reftable"
backend when breaking changes are enabled.

This of course also applies to our CI jobs, where jobs exercising
breaking changes will run now with both SHA256 and reftables. This
renders the explicit "linux-reftable-sha256" job obsolete. Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 3 ---
 .gitlab-ci.yml             | 3 ---
 t/test-lib-functions.sh    | 2 +-
 t/test-lib.sh              | 4 +++-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fe8155772ab..4353af2354e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -405,9 +405,6 @@ jobs:
         - jobname: linux-sha256
           image: ubuntu:rolling
           cc: clang
-        - jobname: linux-reftable-sha256
-          image: ubuntu:rolling
-          cc: clang
         - jobname: linux-feature-testbed
           image: ubuntu:latest
         - jobname: linux-breaking-changes
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9b7698a0037..52c26f72671 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,9 +39,6 @@ test:linux:
       - jobname: linux-sha256
         image: ubuntu:rolling
         CC: clang
-      - jobname: linux-reftable-sha256
-        image: ubuntu:rolling
-        CC: clang
       - jobname: linux-feature-testbed
         image: ubuntu:latest
       - jobname: linux-breaking-changes
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 09a41d51adc..6f319cd54ba 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1737,7 +1737,7 @@ test_detect_hash () {
 
 # Detect the ref format in use.
 test_detect_ref_format () {
-	echo "${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
+	echo "${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-$GIT_TEST_BUILTIN_REF_STORAGE_FORMAT}"
 }
 
 # Load common hash metadata and common placeholder object IDs for use with
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a893963f86c..de566309861 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -576,7 +576,9 @@ export EDITOR
 GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
-GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
+
+GIT_TEST_BUILTIN_REF_STORAGE_FORMAT=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-ref-storage-format: //p')
+GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-$GIT_TEST_BUILTIN_REF_STORAGE_FORMAT}"
 export GIT_DEFAULT_REF_STORAGE_FORMAT
 
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output

-- 
2.56.0.341.g393f52fd96.dirty

