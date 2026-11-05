Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890938;
	b=i1HHhQEsV+xnBJmIUL1lkyUTEKeassF4a3+RkAEdoyl+L+k3SnQCiLiGAFqeE6ww4dlH
	 31NcS9glJ7RxEmcoH9F49kq1fEkANQwMw4B4/Kj5g6csatrBPIi4RPqZd3Ji2fRUXH1lz
	 XYt8WebsesYja5tLthCb3AES026xlkKnKdmY9mRtxK4FOQMbBucihkojANDV7E8J7ebJh
	 J4egYdHdYmksBJD3Z+nndFSpGopXfFWnFv91DLMLtgS4nnlZimR+8DrZVy7yjtRcuooI8
	 9UQliWbq+TuCmigof0yaMkqJ4BG/2eO90Fr9aGp2hON7G5p12h3IXYTiuobAmzeNoQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890938;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=J3ED67EmwcQmHTWF+81GqIMSxBlAOCYXIwoiToVOzJQ=;
	b=W9wNPZOmNczOZ3IXNezepQRXe7EkhXnyWweLCcybcji3i3a57s8Hhnly9fn4S5EIFn0T
	 UUxMR8lVLHC27ZZ5cuXEggfV00vRs1VI5nZVpvDQmxY6GKCNtFEbt7Y9mGVRmc6NHfl+R
	 o5KO/wltNNnag4ku+KwmDIBluUDnjBTSTe/WGKrHmfNZrGzLZn3vRWdBcL51g0zEmKOjf
	 ONuYFXXMj7Bt5iDLOfiQcJInd9O7qCYYnl9t1IjKIA0ZsivSr6dFA/fApxsiKIQeWE0Yt
	 T9Sd0ZCoaiN506yoCIZpYcTgOslWdYXKYTChDpnh9okYasbggkJJxOo9McPKSKorKrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=T5bXaq0u;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wwDovxzi;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AE606A32C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 150AE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=T5bXaq0u;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wwDovxzi
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 521F214000D8
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:02:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 10:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793890937;
	 x=1793977337; bh=J3ED67EmwcQmHTWF+81GqIMSxBlAOCYXIwoiToVOzJQ=; b=
	T5bXaq0uSc9d/xhZbSpG8D0P63uCj7cgrw2K3L5OkckibK2mcPPnoSA/JHgGu3jT
	atgkN1nyhbMUci1RSYpjdZlSekF8yF66kPAHm6CB/JzAfUqLxrQS856tbtfSXNCz
	FKVX+4H8wO2kRfxgwdvmLt4O0JWHPv83/94nl2tJ2FcceUORwrcp134HUH5GzLAq
	sqKhavT+mr5RkY+7PE9MFNcNglnH+4MiPQ6CePKkrBaWEBdDVUODb3WcAMZoUoEX
	vfn1y8Pi9RfPjAZ5CYGVpks0nYoHLtxzXesCn+nsTRV80GhD6/yTwooVrZuxEJ2q
	xLB9QCCpT3lrSHtDxD/Vag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793890937; x=
	1793977337; bh=J3ED67EmwcQmHTWF+81GqIMSxBlAOCYXIwoiToVOzJQ=; b=w
	wDovxziQS38Q3mncMUoA6BLQiDFbq7VrJERBAbfR2GXQa9or8zd3gmBVs94Mi1JY
	5LWJdlFN/BaTwDNkVfmflcriXV915BafhExwbHuG1Fe/GfZEI3KYcKPm4wQbZhKE
	yWDbfVkgRgVrdEOFiwhHgiWKzdSw3ouNYdQ294Ahhfkp0tfefTtUbRnD93VGVFd0
	zImbrLkZOauva/ttwUwDDtB1Q8Lygx+ufxsHXXtd93SCdSeRVsCrBAXrNN8OZcm/
	ueRgthQn8orj7FH6M208zCCMh3xXSytWTeMRPDPvFHpmDlGe1xTta1QzvH1EXe8K
	/CC1dsgifykzKOT6VoO7g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793890937; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:C5yj6xTVlVEWPcQ0QCZcZzxPRwLH7fLrh2Sut57WXdHXS7p
	miPx8yagK/WfhbXUCHNBsJccsKSy9j33zl4h7lDs2WwcUlOAzQ4UDo3UcueUf/p8
	JEFh2qyQY4itDpDDQuvJDtND4/NIsrY8iVrrkasIdq/TDTCBmEzEMxGuFmJxdA48
	VNnD4V49uE5O/g22gdAG3kidp8gdM7SH63idHslnMkcVbw8h86SYTKDLHkkEjUgz
	ZwNm5ga8NDcLjrW84GRJ5B6XUG5mCn3nd5BE2y0oLiAbpvKr1uQVxmbfdXTpNIVA
	3xMenBtKk6bdrWLscZaxOxfihyzWmJJjlMLAaWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:b2TkbJU4glkV3KbOyVnMtwTQN5ydZOv0QwxfC20H3r0=:R3Y+Mk/6AyX8Bg+7z86UIxvLinBn1gMaavwmlpD5Mng=;
X-ME-Sender: <xms:eZrsam95SAfK9rTHt9e8-Ty4tLpiW_gN3pqNSN3d-uqU8iG7j2bVXA>
    <xme:eZrsatqC6REQSIkH_WX-hR42ALKh9TuwbGk29F4sqD-V_JtlWc8cvJuZPQq-wuRtq
    ki6NgyAePhoKRbtGBTtgfzG8km8qX1BDNXqh_5rHM7B9HMpmDJPqw>
X-ME-Received: <xmr:eZrsahr-FpUNx28gdBKCN7y0Q3spD7qT4dRUo4eVQKWmRQEfX6XUrw>
X-ME-Proxy-Cause: dmFkZTEUbqPTI49n/bUVPjinhHOVN+V8R1Es+rD/tRRUudSJi2rgPx06l/EoMogj2DSg68
    M6heWbla/OJUvEQHNSnSWEvNQcKoY9DuDlTRTi4WRNcH/p5OzkE+WrxWbj7b/dJacXeA35
    g2TpfJ4uROJQ3lK3zCXS/jG+8R5b4akgeklSy/XVVieOLrkB99hBKBUKa1PWHkIZTmQG13
    LkN2U231ppJeTB53WcLJnXJkpZsDxy5DHaTSyNpXRbmnJ9b3aOoH1o75qbgfU87pCqBRIV
    1jcHiL5OoKr39xTAgg6p6TXFY+7ca96fXssfFBWxIZmxgdxBndt5nT5Bx8vhoAVhg0oWbO
    P0EZ4SXhfgEB2KMJyIuAA9e9gwXSeShPPcNWOYYLYGVKMY5OK+COlprd/rC5GlvEOv5AE4
    R3LxVi2zBScGNSmHWSWWRXBjrTsGcb+5/rLufJLzkwDu1e5vOTxasYvPp1fhu6Lm3aE7sh
    fc2+jIATdVffYASRakbAg0dv32HKQ9dMt2q7QK659ppBTC4WsXVazH+zmkaXh3sEQ358P+
    2jhp9BsbbMgZ07WGPoV8gikdoFTvzwJ6kiWD1xw61yo7r1G6ai5frZEutRxugwrWnHzi3L
    iiMP6qXa3it4MK6YWOdHv+xojTpGQyYlP3h/p6zCcykfXchIpQ+kVYmU3fYQ
X-ME-Proxy: <xmx:eZrsajkOg1dPMlNurs8aSlpUL423DoWsuuL7qBVyvtLb8G93sSMhPA>
    <xmx:eZrsarE5RS2RP_9XUBUqtM98094E3yAXp9UeB6qRO5SJDMLKtwCMOw>
    <xmx:eZrsakqDJecXEfyYbtZTHniriXhjdoOR_G9pdKZ3V7d2y3tEA1uBaA>
    <xmx:eZrsav5rJGIpv8YtjLObIr9yeCiiyJXhvmrVOKr5e7yTWbBW2XOIAg>
    <xmx:eZrsautdK3IxnDhjnesfk-RF-b1oKjFDHjjNAuu4JztfWLq5nV4hYDnn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Nov 2026 10:02:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf0e1752 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Nov 2026 15:02:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Nov 2026 16:02:05 +0100
Subject: [PATCH 4/5] builtin/rev-parse: print payload for the ref storage
 format
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
Message-Id: <20261105-pks-storage-format-improvements-v1-4-870bb4212518@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
In-Reply-To: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

While we print both the object storage format and its payload for the
"--show-object-storage-format" switch, we only print the ref storage
format with "--show-ref-storage-format". Adapt the latter to also show
the payload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c  | 6 +++++-
 t/t1500-rev-parse.sh | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d2154eac8d2..fbc5ef87276 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1136,7 +1136,11 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--show-ref-format") || !strcmp(arg, "--show-ref-storage-format")) {
-				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
+				const char *format = ref_storage_format_to_name(the_repository->ref_storage_format);
+				if (the_repository->ref_storage_payload)
+					printf("%s://%s\n", format, the_repository->ref_storage_payload);
+				else
+					puts(format);
 				continue;
 			}
 			if (!strcmp(arg, "--show-object-storage-format")) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 30bf8a4d0a0..c4e6bc1dd89 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -209,6 +209,7 @@ test_expect_success 'rev-parse --show-object-format in repo' '
 
 
 test_expect_success RUST 'rev-parse --show-object-format in repo with compat mode' '
+	test_when_finished "rm -rf repo" &&
 	mkdir repo &&
 	(
 		sane_unset GIT_DEFAULT_HASH &&
@@ -247,6 +248,14 @@ test_expect_success 'rev-parse --show-ref-storage-format' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-parse --show-ref-storage-format with payload' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --ref-storage-format="files://$(pwd)/refdir" &&
+	git -C repo rev-parse --show-ref-storage-format >actual &&
+	echo "files://$(pwd)/refdir" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rev-parse --show-ref-storage-format with invalid storage' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&

-- 
2.56.0.500.g5d06dc02cd.dirty

