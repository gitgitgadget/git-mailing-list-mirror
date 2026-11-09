Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218318;
	b=Y/wUELsnHX6NK7tKYbFbttsed6k1RYcv11mkv2NWVZG926NOapsaupptGyQNwOoZpDIx
	 iq+rEgODcVaXxvH36deoSLAr2sEokG0KmmF6/8R8xcCSh/m+sK+oJB1HVFBt6K8jGfFka
	 1osiNa0OqOXsViej8QplTrxrLI+ejVfG9Pulirqgsur6IRtdUKtUI6/vNJev1BNqk3yP/
	 5X/gUjK4ed0maVUPAINbIU4lsRj3nPhqc8If+J5OG3mPn8geGIhvpBQIhKYFomuCb5HR3
	 eS4RrEfZdgahP2gVZN1BqhpKNUV6EV7pydvcNnjaDHDAaFnFhKZAQnGXZtPmmzMJgaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218318;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=WE+YmzDA8VaiuSPZ9Zjt9Qjfs9bf4znbVD7eAogWO5s=;
	b=eK55FSoIoNRECCO0KM40QC8lsQE1XLFxrpz2fGLlP+NxA4ON/V2WbCVaiCIe8nflk+RU
	 YTM9uErETvswj1wHtOAVQgk/HqtXigTylavVGNznhYhXXKu5IGS1lJ/WbDqptupd7cOL/
	 /WFrfcSjPLw4LUPsO+8+IzH2LLcjVf/FcCWKEK+H07HbawQZ8+TSeImERonP2Ez/y3fkk
	 SMW6Q4tQwh2jfrV5glxIDBzpIdy67k3lBl11hbFDFCg3CTEI+iKe3AOhQhpKJ4O6Vt8tl
	 KyBQz91NNLxLH3K1cXrqTE1d0bTwnbjSXJ8sV0qT/4E8Att58XakU6k4mO703l6LkSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=jJvbrgr+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YlzGi8UQ;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F7606D807
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E51F7606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=jJvbrgr+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YlzGi8UQ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7543E7A0148
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:58:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 09 Nov 2026 04:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794218317;
	 x=1794304717; bh=WE+YmzDA8VaiuSPZ9Zjt9Qjfs9bf4znbVD7eAogWO5s=; b=
	jJvbrgr+okKqf0p4+bwDCMYtRFWQOSkE94GV4Gc3nefHyXYCwpYAnEQDx7miDfIo
	dXonWeD8gK+mY7WEMaYqJod8vnRZ81TAgDXOA6ARJR+FjR0WrCPfWcHQAijWfQQA
	fHgYrSUcjPBqgtIr7zf3LZ18hGkhcKysRH0CaM9HybaoVXyw442qgaCViNOXSAyO
	HGZYM7LCLuWNZLS5ckAY4b8DVuzQr6/HcCoaeG/+1Zh7Peea5xLRerXM9rdQqxgu
	trxv/LSbT5lHJGhFBIFB3T8nxx0NEujBQcGoSldJP36gGxxRvBZJ3wU5mS9j1iOv
	7AeNGm3iFizv1Vboq4x3Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794218317; x=
	1794304717; bh=WE+YmzDA8VaiuSPZ9Zjt9Qjfs9bf4znbVD7eAogWO5s=; b=Y
	lzGi8UQIwtU/uQzn6OnOkK3VMFzqJnOF0mkbdP13DcVp31guq+425UKgzel2C9Dc
	AAHMmZxq2zUvH2lToWsKCrdc/AN0MwCwTL1HTVL5Ct0vCiexZhbeM+MiKk5nVFSl
	CQesOcTT/n9m7j/7LbwPBGV6Lvm3PvtE3W5NZPuESag/sspMTqfQ7jgf5zsuEwLo
	WV+UO2XGiLKdN6cK2yq+E9PBu2M5wbDwWCrHnIKFZcXCXmG/Iuxe1lPgun54hIKc
	60n2ySZp/W7cA0Tifo9RkKxblLHIyOZRN0otHbNBpoX2DFPGbxi+LH8eQS7R7T5g
	OfxYTAV6R8WGB+KH26QJg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218317; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:zEJdNl3iizPSKGM2MyPDvHXTQj+lWdzZ9QCQwMnGckDN0t1
	rmrRBY10kry8rn00cleq+JxjHXDCoIcjEdGyAszmvqDDLdP5v9ujj9oOtJPNvHhL
	fJqvpooNiNjf3xJB/oYR9W6lUilgSYZls507KuO0u0cClLdPg9VBIGJWtrZXNtFk
	fkDPorgu+iwW0XYkSBmZ4H517ksZLoTfjgy2K8MItByCO+NLy1V7RYma3S7EMEQ6
	kdvrlxfHQlTurw9VNcS6NfcnsIch+T1sSuUVWOZv2xQ8RCzb82gH/cY42UlnGP9Q
	p4E4Le4XnVvgG1Z+nXiX4FnUqCWHPf0a1LzKNmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4dporsnEtTv1Op8WvkihbbPwI24Or9dfY0If673OQCg=:BK8Lu5YLmagafPOsKKP0Kk0P77paX/5fryRKkw3TPVk=;
X-ME-Sender: <xms:TZnxam8no8K7-k5AOmJAVnMuVyqVqfp_AWDOhtqstdxKn9PBaDDmYg>
    <xme:TZnxattEaHRZ5pmqStyoofJaFmfJQJXYZe0B2_Rmk3VZYP5KbMEeO1aCAXr3LBlZ1
    O5CYu6wFmw-jBuvAhWwuls9ucqr648ZT4R_1PvRpGI9shJOLKZwWg>
X-ME-Received: <xmr:TZnxahAhEBDVsAV_ZpRpxNrLB2rxZD7JWt_6IcXRgfn8bzf93fcVZvrrf9ufexhoh33fk8U>
X-ME-Proxy-Cause: dmFkZTEHS3V19QIdRLRKSWjO2nNvv8zRI+iWevfOMTjXDzG7jD6FpMiqnSVyTgTUDGDL7O
    7GqzVl0ZhTwtjWpG6oJc8FvDaHIDd1niRGr311uWoTFlR6tziG9jAHB5vangbRDQ9l9o5y
    0Xud8gnegknT6zQwVrljBfr0sIbpj0JDcc6Wf6En2Rd2j73iNAkiYtuAm9dpWf2qEFlHah
    aBYwBD4VBReG6tDDEw+5nWVTKSNZP8qeGp6myRaKlRkoPbDLFnSQovmSidNlNW3devkiUp
    D6Qrq8RmMSC+IRk2dd1feHvKCKkjr08Z09fIvarRWtaPudURT5qrFbGTFaUMRw7ehQN1AK
    R0opVu/vJDpcdImRb7nQPSSbfEOj4q7LScTCY/rxIJIObZHSrN5Ov+bI8azNeFb57SyJZ3
    tpAQDH7lp3FRfz37SPjQoz44uMa0N1eV48zUpjGmpgbqo2MsyVU8hrc/Q5OmFZBs7Pgs9M
    erv0p/LSO65ECCP2bJPQ6E41ZTPmELEHMrzck/qkq7s3lUG9i0Px2mTAPRMFwV3AjupxJN
    pkkcZY4ZsbyvxKohHTyl79rUZbYQUTlTLSgw07YUzrO90zqZ+rZPDtF8tJvQ2iXySQDKrc
    fPY03kbenXEKF9wxQEoYRQdDrUeQXkbhuLe8W8MZAOm/0N6CpEIji/o9rQ+Q
X-ME-Proxy: <xmx:TZnxatWBcogI1edY7ytKb0PFfqCthXgnq55-QirJwQpKTLRbuJf5mw>
    <xmx:TZnxanDbAw1VsQhH3loPthZv_dTsCjfgWu1spZ28-uOji5xAzBc9xQ>
    <xmx:TZnxao9cobv1m9kgkS_icCiir8yOgQQA8_0tjgw2wMI0dtaaSchelQ>
    <xmx:TZnxamH2m7q1tAN8A1C3iv3295WdPpdB-3-VZdqgaMEQMXcwZn26MA>
    <xmx:TZnxanWfgCC1NrTn9b4JhcZG3FuA0AT09f9xvfDIVYeEJDDBEembXVpe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:58:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8678c043 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:58:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Nov 2026 10:58:23 +0100
Subject: [PATCH v2 2/7] gitlab-ci: exclude intermediate outputs from
 Windows artifacts
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
Message-Id: <20261109-pks-gitlab-ci-speedups-v2-2-508832602d0b@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

As running tests is very slow on Windows we shard our CI tests across 10
runners. To avoid rebuilding Git on each of those runners we have a
preliminary step which builds Git and then passes on the build artifacts
to the test jobs.

This archive contains a ton of intermediate "*.obj" build artifacts that
aren't needed by the test jobs: the artifact contains ~2300 files, out
of which ~1800 are "*.obj" files.

Exclude those files from the build artifact, which reduces the time it
takes to download and extract them from 34 seconds to 17 seconds.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9b7698a0037..3631393a8cc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -187,6 +187,8 @@ build:msvc-meson:
   artifacts:
     paths:
       - build
+    exclude:
+      - build/**/*.obj
 
 test:msvc-meson:
   extends: .msvc-meson

-- 
2.56.0.611.g1030f0b940.dirty

