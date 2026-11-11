Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394088;
	b=LIJgUk5tiffiGijHrk4ROXnX7nNIdqv4VCCVTQF1JxJK72g8pVzXSgI1frK+Yu7CLrdS
	 dNbGA06QadTUjzIKZX/WjktR8Hc2euFFCQMqacCPvmrvfTjvEObGUjVjWn1vJuIIqrN3I
	 nDIeHIUEHvG3sNYXd8jMztnxHnhe27WTNS8rngB43hyOCerwJFpdhaeEZUQOXuoFjmaHM
	 XY0ZCEKAZqH3Q1YrsOIWD016X8Fw4TyBEDBjSesEY5tIjsCBp4h3wZBUaho1qIbel43it
	 HF/Lt6XOSvG7v0XhKrIGWrcG7SHj0I5uRRP2L4cHfc9fKy7zUD2SmGH4jQUb9CA7dyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394088;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=WE+YmzDA8VaiuSPZ9Zjt9Qjfs9bf4znbVD7eAogWO5s=;
	b=nc+1C95FvoWZawU5Hhtjzz9U4ExT76u/2giT2q+tg8OkIDio4C3T8XWzjqSYH73ANk6M
	 bUeFamPIkPn9WbEROyfn84rWTbA7Fi0RcXWorYXdYHRID++gXlHbPHLMl/gXL5LtOEeg1
	 sXAAhqdFAq7WoLLgHpDw4mafm0lMkQR+kT1Yeb7VumGrJOAuSUpt+Aj7af5vz2F5VVS6b
	 MEQPfO1AebMbB3DxdT+6t0EcFBPCKkCXzooeEABHZIalLBVhteL8VPGVjTkgOrZPkGIwK
	 tNykZ0NdYcjpX02nMp7KTIzJGNImAK0mhfaJ6cicrzbZN+scbndOgs1ZZIdnd7JWiWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ibDc2wkt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WyaAfbUF;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95D606A32A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F95D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ibDc2wkt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WyaAfbUF
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E7F3EC062D
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:48:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 05:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794394087;
	 x=1794480487; bh=WE+YmzDA8VaiuSPZ9Zjt9Qjfs9bf4znbVD7eAogWO5s=; b=
	ibDc2wktj11zErtZcGfkee9kLBj4MpSWPA75h2Q9ta7UhNUAzchtlOFbxEcDJjFz
	rdIFwbd4ayUI1K6syh/wDeWT8qdqNEadKVnirMRQn2hv6rL/tZydz/GmNEtTffKS
	dtaz/YLJ+Go702IWWN1h1xljLTKlsJ9d3fsIC0LSM2ZZndTG0SLHyVhjQbFfCi+W
	pJp0d6aT5+Qd0S5EX6FfuDUsORjdCeOPRTuxrdU5Uoa6C9ITvcmdQ7lZ6+8r5Nfv
	A7QuohVJ2MS+K95BJLA9z/RUTxpQ/1GVblVFfwohyb3mAERdUqNrEvJOGXFPi+Y1
	9i8kIfW87l7hXXd11+1l1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794394087; x=
	1794480487; bh=WE+YmzDA8VaiuSPZ9Zjt9Qjfs9bf4znbVD7eAogWO5s=; b=W
	yaAfbUFsLw/klTM+51Gp/2hqyd7qSdlwH5gX/DNy8DBaxZQQonDcdgLnCDDjZbpS
	ckz43f8WlRqkCZ/3ii4DQTqMfBL/TRn9Y9OUu4Fw+xocq4Co3pCVWgcG8Z3Na6VU
	8Pdl+e7GO1nc06iaMTyTboC6GOenwkqqzrUgR6jGzlQ8v7ppM+xkW7GnWhW8tySl
	sJ09ncd2O+jY8HcN13RNNyTs09eHg2hffzWTz8FTqhHf3Hj1zXXiG3G6E0Kgcvkm
	GcwwhPHPztSaLU5CY2vHlsOo41OLzLDPv7IzmUm7JjNXbnC+Emp437SWte9KPh4N
	Px3JrBK/Vhc3PUmMYmDow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394087; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:QBhh2ekrk6mPSTTtM4bKEBw9kR4e+lof1F+TufIlBos2bcN
	0TOdtE0rSmfFdPv8wdFuNx21d4GxFJa+y38JYEWM7KP3DKA+rpPudlhs+LsQ0TaD
	fnam7F7KBzhjDBCeQX4V+WDqn3CPOCbaBfilBdfIFsPkQEucL2MkXj7nMwbUcYn2
	7z9/dcxAZsafEuVOay9L75fAxT64szuWdT5kfKjMjRyVIcmzjgq+rjItA4u32qO7
	ysIJi4HWLgDhY9pMOngpk7okLiBCsCNn8UtjchXisx1oSfP1+w2gplPH7HF46CwD
	OY9Drrvj84q+3vn3dVS6yGXihOqHDTjn/hy6Umw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0wru8xKmexbpBK1AIltdK2FUH/GAP+gZbMTd6cRbYR8=:BK8Lu5YLmagafPOsKKP0Kk0P77paX/5fryRKkw3TPVk=;
X-ME-Sender: <xms:50f0ajdFMEPS3cuF8X-ZaV-Yq7d2g1HSvPh2tiNTtGwG4QASBkZFgA>
    <xme:50f0agOjn90ppsrcstiwVIjCX3N0kuTZ07h5rz0vKrV-DinBFJHHkFeXMLtOIvH6N
    KR7TTCHdMuT_TE-sDcndIWA3BrY-bWxqg0znue2JmS3yCfKS347Bg>
X-ME-Received: <xmr:50f0ahgoGxiDXGi9b0Djt5KtSLKKc4OGnfDMHWxODfloJptwZ1_Zw7PBSuwNNnuTOoeQbQ>
X-ME-Proxy-Cause: dmFkZTF68gyuBnIeQdRwGHfH7RpIlBB8u9KW7pV3fOGC/OlYIHC/es/K1KGMlODmxVcYNN
    GcBPQs7w3Y96F0FmpqZnu4iQb4d4EpGTBCZXw7DiRDog/gQMeooaoeiW/rahAnDOA50GUb
    c4dB14xxYQkQBdSkZ9hjjF5SnZQiniIU+NLLiwFEAgUQn4fzO4lce5M4wUPVZoO4pDq27i
    jGd15xQCLdEN/tbUSivRW8Pi5kI7yyUpOYt6zWSIhNvjWLMuDwfacf+lDI/awuiTbTbZm7
    0Vo56/7kHJh2z0p0DOTgWIM0kwI3CjQPY7ZkNFI7u3pDe4mOu42s71W4yeK21amwK8V5J9
    BEXS5I0Dd2xJ8W9zEsuSqYePZn66TmDInKVo4iu7BY2nJ6wRlkIHwkNGtd62a2nKTn+HqB
    4C9GBvn3e5N1oDBnCR+tST64wDF+icZnXcwH+pb+QA1TEstChnrVS7rCPh+PNiXHZzOCnK
    GHts37byVEgiOOD3gD6CEeQYPzSgUXMJ/x/U4nMlQmwNCTwCHiQjcBfMIktY4dRD5mtFzd
    z/IowUay0pgZ4ez9wJGOQyCHjaqT7Pyd4ia/dnj8LaRpj5MXOEcOeyAk/cjAG/rK2JUbJL
    Tlb10dTcJ9fGTjC1Zj43eXNfw2+xUcuKWn/Nm8PNtY6kOTj+U7ZcVoeWjaPw
X-ME-Proxy: <xmx:50f0aj2w1UiZ7uNYvQr4-PPCx3FcazzqDOK8ZWjGahM6UW0CWmUuIg>
    <xmx:50f0argN0ArGuEfotBPXa833GcH8ED5N4ssCCnhHD2vZv9kGG5N6iA>
    <xmx:50f0ajd1HwsSzzLDyXAbu8x3oq8o16lBFoDaTiUBQxi3fC2BSRqqeA>
    <xmx:50f0aullU0jjs6euRUoOmRYZy2vgseruSwpjG1D6jj-4UrEI-lHMnw>
    <xmx:50f0av2N2neMzH_CGUE9TnFkn0M7fK6YjJfdweLPT2dKJsyQ5BdAlo6O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:48:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86100d0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:48:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 11:47:53 +0100
Subject: [PATCH v3 2/7] gitlab-ci: exclude intermediate outputs from
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
Message-Id: <20261111-pks-gitlab-ci-speedups-v3-2-d1e34117ee2e@pks.im>
References: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
In-Reply-To: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
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

