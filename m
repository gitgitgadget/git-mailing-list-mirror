Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218331;
	b=IBk4eS2ziuJ1j2S0yOE1n0j1SO+uimdHvk0T9wlV/atwP9a90ctLrrhLJYy+CyW3630G
	 R+wuV4rIjutIrUZ6hl4gvWAOO08/MjJSRYIVVoMTT/wyXauG8kv0hgwVhlMlm5VTK1dCH
	 YDFcZjhWOsx/hYLAcsHxjopL0LS2hg8enTZ2VYusmONoVaooCeq88QGaJ4hBNaaR23iiH
	 HRZSYqlFhoiocNdYZZBnztsFI9yztcnAddK+CBMYkbFNl1MXUUY2CBSRqq4BRHZ/uBf+c
	 XMkXjfPzmIInJunAGUXpHZ0f9B/CjPBGk9Jx9fdEE7UjHQ1NnOiNbEvf+YlVGp0KdzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218331;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=PRrkmKV6jk2DH20dY3DwSZMtUbjf4EUOK1AS2UG4flE=;
	b=i8kyvVP3VMy8AxCol4qEdJd6kQ18Oed4p4N0qsYC4b2hCucHK5s67PPAhkjc6VAgZQQc
	 AqMUQku0uPoZfdUwsFworKiMOeGp4LeJHy8JtMHpcFQJ5egMtBafjfyabu3qFcHSzegJD
	 OsanSN5sH5UladMv3CKTOBXqBQxAEopAzo7IXcMkwCoUf27OxlGhB8g3C/1dO1FaoaxuP
	 dR/iP6lU4aodbnFlCYrvLQgAL5ztmQuwUMlMns5x9umgq3lNKAYSXRcFNS5O7LOwuw7rU
	 P93BnHn4mB8oFEjDPX/342DcaYga3kPptTHP4M6jp97uemd9OWZ287n+MDhi/2Ml1Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=orroCL9W;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lSlM6HXr;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38F606EEB1
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C38F606EEB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=orroCL9W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lSlM6HXr
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C76151D00147
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:58:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 04:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794218330;
	 x=1794304730; bh=PRrkmKV6jk2DH20dY3DwSZMtUbjf4EUOK1AS2UG4flE=; b=
	orroCL9Wa1DsAPwnkKcvaqfhdKCG5huf+l1MEGH5rRsDbXsjXx4r2IonMDOHuzRA
	vQAUKh67lX66Crhxa5ARHDQW0nqzjQbDk3+/IlvEeg/0U/JsmOfmPmlMg20xMcb1
	NQFMLrhREOV/cK+0iwE+mnfUVKIRTNlhCl3UoAcwdut+cJkrxHea6NYsPUErgbYf
	ekZjyTf8dZQLq1Pi0L8ouFR+9QngVh2XLu6rzoPreGA+q/Pxiu76LYnxRuY70XVf
	glGtVKzpVsWrHjOIm+QH+tH5e15H0HcmtGDOboM6sTueZ5AVaLuxQbIy9PGyGcUa
	NMrHZ5RAAasAOt+Kdit3mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794218330; x=
	1794304730; bh=PRrkmKV6jk2DH20dY3DwSZMtUbjf4EUOK1AS2UG4flE=; b=l
	SlM6HXr+6BMDG3OSZM4TNdArWy3vCUyXGCIOTASQquiZzcF2OJ5ZitPDiBGXUUpM
	I3uMY8kGo7IzY3E1fdNiExnRaxgFjajygxURQ89tdVUBBqKeOJzNf0D/vmPib7pw
	37FNZ7EvAXw5gNoSQ8OY/P0sZg2pgP6qmXSBKy5uX5ryJillftCCNSLaKLZzTjBd
	RvC6tfxWn+brKrGzhSDbXywfj3nmdSTPEEViYUfnMG2SBICIXJbD/Ul+9Qg/4LSj
	N5wbndZQEOVdhwg6k0dnVIDlexUPgM5Hes94yS1iVqk3U1ITIkTo45IeShcydSJu
	M3qDV7kBfbqNF+7dyEYBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218330; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:baSKXOCrfhbUGe2L3jV/L/VXrNOo4UvVIt0Mt+KyrmRsDvR
	FpdG2Ud7+EMt/7RYGxCaKep8TqB2PNMIf+DZx51AbzFwLZ2Xim5NGnRRJb6CgLQ0
	KUWGVW3o/9+FTNfC4gMnSHJo3m8k431nx7jgBNGqH2bWDE/R1K8qupiqufNXRi8+
	tl3yEBnbXPTWZknaGF6WCsnFTBnkjP+yIbYUreHbdwh7/XQK6h44MxRPq8SybppC
	lZBVcvIVspzp1ffLEHMIViLGoicaf5OS3/ylpVkHSaTQjPNo44taA4zlkiXIrr+X
	YjQybj3U0/fFAl1YqwHGQPul2pJDvb0sG0BgSvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mbVDJKaIr0+obP+FcHlO7rWRQ09oLOq1j5p5ZxnWkk8=:AcTWp/+FHNXh/cXux4Dqjyjswzl3U8ZaDjylWwViSXs=;
X-ME-Sender: <xms:WpnxaoEpPXRGfL9SIyI3BYdc0rDU-VsnsJJ2cZAMppQRDQ1zHkn5-w>
    <xme:WpnxaoVSb_X4Xzj3lIQD9jEbis3s5H5Jtvn4N01cA6de5gGDwKIZDEU_YMAhrVGyg
    4laP5z0yZ-1GgJKColZJETsEUDku9qPx7Vmj3mgJ0XoonD6PqQcVPo>
X-ME-Received: <xmr:WpnxanKuD1sQhu5v1SiNpfxYX60Jr6eY2oiarN3c_2Jt5YbNizY92pJQT94ljUbf1PsbN2I>
X-ME-Proxy-Cause: dmFkZTFzuwLhDrf0CVr8gc0dDr+bb8gqTIabux6S+dRudApN6YBuRezlrKlfqz6kxCWI7T
    ylGW/HCkIrAIBV7tGdiyy5Ru8DPeoKNGEZ+WweLTwfBBeUFZVjST4veSr9SAEsFDoMbBXB
    /kfFpjunerQCjOv2RwnTjcqFinq2lKbCd8CclycE/a2rx12Wk2i429/ccROYfpqIAvzmT2
    xVWZsvmz7c0lib78AKAkTeOg3BVAnWc1MfWp0+yWYarkqP2jRnMHKf3W4hG1fZQzRE5x6o
    Hqra3h9JI/vHvDkyB5IID6Ef5k+uTd+6EmGLCDwswLacdSgb1Rc1+yJUlKA8hI31R5rJHi
    QIpZWDhIq6vTJRDfVw2EGAT9tMdGuLLk/F9BkajTWkwEGspNwQcXu2EtA0r79A8QeEgO4a
    njhbeCRCgwuhRt8bdgYy/1NSha4prUWwIYu3Z9IRXSYGqhPMoXOuNp7n/HveLPUiZ229xg
    MkGUvKxiufemaE72UFAOyVi3z4Y9psvYbGlRhkvFcSy+EjNadLvTjRCYz9uMvEpzS69CnR
    ZN9K+y2Hp7y8bdmLD8NWFe1yOnTe5eHtrrSMVW50L9zcWJ2tOl83DCgTPZ1FxqElwI5roq
    4DMNQUjPeCooX2wHgQuUjTNWi4s1CkmGaaf8fldgmRUooTORsv8mCuYHr61w
X-ME-Proxy: <xmx:Wpnxao_An2LvA5jr8TwP9EOWZWsQXz5Lih7CFaPJPP_83bFPQnPcCQ>
    <xmx:WpnxaqKsGrhvrYCYHQNcOqN2xUi-FE4NNo8asjDu51tPkLysI-5e7w>
    <xmx:WpnxatlaY0q28kAbTGwd0IrbZ_l7Ddmc7cN2hRSzRd8KFe9Ef7FyyA>
    <xmx:WpnxauO342W02TC1MxIIhH-ZO28mKHN8juvaOiPV9k4TmtpOgmKZZA>
    <xmx:WpnxarcM78MjnsJuy6mAZXTEUsqP0TymPOiAd77pFjeeOie88hX87rEf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:58:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6fdf62e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:58:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Nov 2026 10:58:28 +0100
Subject: [PATCH v2 7/7] t5551: use reftables for repositories with many
 refs
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
Message-Id: <20261109-pks-gitlab-ci-speedups-v2-7-508832602d0b@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

Some of the tests in t5551 creates almost a 100,000 references and then
verify that those can be fetched. Naturally, creating this many refs is
quite involved with the "files" backend, as it means that we have to
create this many individual loose files. This is tolerable on Linux,
where the test takes around 2 minutes in our CI. But on macOS, the same
test takes almost 20 minutes to complete. And to add insult to injury,
we execute these tests a second time via t5559.

The system under test here is the HTTP negotiation, so we don't actually
care about whether or not the ref backend handles this alright. So adapt
the test to instead create repositories with the reftable backend, which
is significantly faster in this case as we only need to write a single
table.

And sure enough, this reduces the runtime of this test on macOS by a
factor of 10, going from 20 minutes to 2 minutes. On Linux, the tests at
least speed up by a factor of two.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5551-http-fetch-smart.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 130053c57aa..34945059531 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -412,7 +412,8 @@ create_tags () {
 }
 
 test_expect_success 'create 2,000 tags in the repo' '
-	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
+	git init --bare --ref-format=reftable \
+		"$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
 	(
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
 		create_tags 1 2000
@@ -421,7 +422,8 @@ test_expect_success 'create 2,000 tags in the repo' '
 
 test_expect_success CMDLINE_LIMIT \
 	'clone the 2,000 tag repo to check OS command line overflow' '
-	run_with_limited_cmdline git clone $HTTPD_URL/smart/many-tags.git too-many-refs &&
+	run_with_limited_cmdline git clone --ref-format=reftable \
+		$HTTPD_URL/smart/many-tags.git too-many-refs &&
 	(
 		cd too-many-refs &&
 		git for-each-ref refs/tags >actual &&

-- 
2.56.0.611.g1030f0b940.dirty

