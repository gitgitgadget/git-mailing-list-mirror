Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618294;
	b=DOBohNbSqXOuzkV2EFYAGISaIDUDP9KFRelfNOqN2E7rm0TYBvwn7bDfpFmvHckbnX4w
	 a+sAubp2k6nk2E8T76NTMurwdkkBiwHwC103GPVsARf57o485OmRbHOv9cc3m16zH0KTK
	 OM8uGewrUhLhcM0aC80h0f+qy4dQq4PsiF7dsACIvT9b5PTkp/y0WLvG0R1ciOgNSct2F
	 VCRPqWIbu5SrEvsa1DzJNQpaXNVeSk6NUtl4IAihIo28ynAlcNpwXcfAGKL0JvrbVIfn0
	 rNcLVgmOwywiT7He+YLLZqyOlygvaPR1uNcGa95YE+fzuwItipj+tU6AHrzX2Cn9RcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618294;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=XPQBCXzsE9G1RpqywXpI6ex6DlWEt44imSXHh62jDSo=;
	b=XG9HxdiBHOQ0GNE33MgZd0NuTK/lCba1WryFo0rMNEQcjHv5urlSOTAbcNBTHuq3p9UR
	 sBwWknqtTtfBm7558iMhEtPQm+bpaE5CiF6P65ZSIV+0qPLokEaM6YUkQXA1DkBzJbCng
	 0iGS2unMdCIza5LrpnpBCqW05vVVSEahKtuOp9QDaHKTIjjsUPKUXZrbZtsdTpTDQZNti
	 woeiVv6zvrKmC6XpijT6jQ8HmElpYB3Dh5q82tupCZ48a/d/iNIE9Qmv/DebvNbg1ib8n
	 tCf2CRE3KpvFoTkxG4EoGmG1mMLiCbx3zw1OIbAYwaJBxxy9KqPj38CFO37+uDf68LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=DA+ZiaND;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ikTR8luf;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0A606A32D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3D0A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=DA+ZiaND;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ikTR8luf
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E83F1D0020A
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:18:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 02 Nov 2026 06:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618292;
	 x=1793704692; bh=XPQBCXzsE9G1RpqywXpI6ex6DlWEt44imSXHh62jDSo=; b=
	DA+ZiaND0vYyVcjeTdUkMgOuAhnjtcoeSnwgBu4TNDyiSfmK9ngCeLW7yyxYyGtJ
	RHL/6QR2gQez3jT18ICZWyXCuBRweZ+OkayKWDYjmJmn4vc/nHYiNwuqzzkUjYM8
	PBeB5pMEPmSpnCV4j6BTj8FOypZO6csGdtAfNgVBqOa9vG9G+6Dku5sUOu4IyOEU
	Jvl4wOLUNUb28Se2St2CKOzYcuiKchX4PxtUgrdf9eOyU1Oo+CrGvLkLw/TmXcu2
	zqy9EdKI+qCVaqkxXf0aeGNCEtt5njZG9zJX/FCHgNsUqKRe/7td2hIUkW/KkW1b
	XSZn74Q1gg19OcxazbGTuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618292; x=
	1793704692; bh=XPQBCXzsE9G1RpqywXpI6ex6DlWEt44imSXHh62jDSo=; b=i
	kTR8luf9BjYjg45SO+RAN4tyuUIJsI6OBXLfHSHLAQdl6UD/IkTpBKlEK/ped3QU
	A8anqo5jWEgNATGIQbhXv/KjE6FOf+t97OrmnvuR0C7viNGu2mNyL+sVkTemMGCf
	BVPHvwpbhr4pMLBDxWIgfNbI2LB2a62ZdE6PPyO9r/fOw+yEmHlFXb4xFPh5Lm05
	V4JYU7z6G2/RpqBrkLXr8Mrt3ccCgDRGpacg1T6DFVqc8zHW4RTHiEVjls8r+8eb
	wn8O0Rjiw/0SkNOfG6h5Lv08/2fRhg9HjS1j1RMzkD3VxlLb+vo49ohvfnGf9WAT
	D9GWYH5oov2+jrStjNHtQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618292; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ks3KvagsGDMXnuEvlDkPX/zGBfcNBTGAZNLYdYChuVI+t/3
	7djfyxUCf1FS0dEQ9i6VSu4+33w4j44gNHQjVW2vBpDhs8X2UhqcB2sEK5iBIJG5
	0xDJfdllWIL2aYBAL+xB6uk+H7LEpo/ZTdgE9mbyoLnXl2uPKT1Vfk0VaWGM27Qg
	C+nN6/zb9/ZSTKu/42OckR53Q6NqQYxpk3SxmJ1QiFU4ASlh6cp8X2VdKEX8tVNz
	WxvqpRFi0qavdLri9EAdXYVBsIZcxyZsUG9ey6fu3iBktDIkvcyzK+XuhVSH/h7t
	IXb4QIo9uCLLFLOFq2uYv00GW+fQB/TJHiZ3o0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FG+S3Ao/Bkehh5pegWR8zPq/BmKooc8hvQO/MK0/kKw=:DvqjAWoEVsbK4dgTy1Pl4JCUEczSCtK/EjtZKpnHBQ4=;
X-ME-Sender: <xms:dHHoaiTHK4ikwNPwelZh1V4VQE_w8FtfkboZlK8GqP71b5cFU_fobA>
    <xme:dHHoahGSqwBFgPp-9zbDQH-piN2DeoO9VhoCN5S7H93intIdj5fAKThH-2X2lDMxs
    keEX3Ko2y70Uqu6rJancueuXnKq9wg2UmW1Rnfz1922vJuv9K6TDnM>
X-ME-Received: <xmr:dHHoanFGajqXdqhHvJ526LDwapAhG8wunkvcJycuQXH51NW_zH32gQVaJX5IWDuOXRX_dg>
X-ME-Proxy-Cause: dmFkZTEXyuhHrrnb1gS/aM7tkRlNQcp8bibU3vAgVGavHNMWT6/jkpRLB5emEJHRPiClN3
    ME/PMR2+hmJSyTlsXe5D2PDaoBSbU1APtpz6KlKGYqDUGSLjLskiL62loOhamsPeQc5AH2
    168HRYHZluXKzaVKnNAUKQoRWJvILJ9fUmBGE1KA+IY4b8Aam9arfoWOZ73Jxak6bP3W3C
    u7CbkpDmNzxmZ3aARVN9/njbookCGclpDLcz/zoeEO+adtBUAQLPA+tk8DozF3LOUA6ZBY
    WpxueVw/5NkwbLZDrVr0wLRo5qgehigUsqQB8gnvuWyhJDBotL/qc+CstJU9OAWU+oxDjB
    EWkD5ClopOAzKmiPYCBmw/Rl882H7rT8LOguTiYfmZWDRggfwvjVeSws1RRxAWFvTaTLrl
    oJUEq4yt9ezIyeNYMNpmqCruRbG5XyfZmVLRSDfdMwJXWBOOLZuBTcbv0Y3z79WfU85jwM
    WnvIMkXdeAvpbtG1lwnXTJAi1mlX1k0sLpa/pC0BeInJhCE5I+efp2VNH1Mb7fXtjIzyYU
    rTiJvsgLdp4McCsVwhmAwdbOlYJLBD6tY+Msg7ou7VaArDcyCTPtNKPTfMW3YV5k0+pkLB
    iOZTVo+aC6ToIW84AubSAXo2W8TkD9tpE0/7PwD9z56vR8kuaSxw5foI0lEQ
X-ME-Proxy: <xmx:dHHoavSi5ddW7IEMrqEUmYc7VGoNSeO5N2i7W_Ac6lwqIKdBc8hCDg>
    <xmx:dHHoaoIQJhxuP-QdfTfJYWTi3jgSKbpMHndra672-HK4gs8HuCEQSA>
    <xmx:dHHoaqbXryGyHCCuMrsxXgU5MHS7q5-M6ylm9eyj9alaeBVO_nDHiA>
    <xmx:dHHoaq_R6f_dS7ouKwh2tOwsEPUnqBmXPZqrWV_TMwmYhEtx52mJRQ>
    <xmx:dHHoan85c6H_4Fu1g7bmq-8bMi-jsnRv5sX10pHXVoHkQJnpl1d4p7IZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:18:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef62a7a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:18:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:17:53 +0100
Subject: [PATCH v2 5/7] t: honor default ref storage format
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
Message-Id: <20261102-b4-pks-ci-test-vars-consolidation-v2-5-a5485c437c62@pks.im>
References: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
In-Reply-To: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
2.56.0.500.g5d06dc02cd.dirty

