Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218315;
	b=I3zx8eqCkczYf3+GFHxNo0FacnY3j+zfPAOYDJtq9wSNy6aabP6FjIp5e3PhNn0ufVhf
	 s95qHA8T6/CC0nfo8Xe3kT5+al6+2wHlVAzjiu1XoV+ybNx6caPA5X4jxHMydSnbzJliB
	 JAngM52CelitWY9XNp4N9mu7/lmIRQU+Gaq1ExzDKnSkRUt6XIvpKySLH18ZmRXEt0+Nj
	 iRwBWKK48wF8lJe1LispRlStA8pPJ4gCkVeTAJnZ/xBYuqzzrDDYRlXs8x+HxjUBF2Ppb
	 7WhqEB9+ll7WiNlekdpAkQCRnLhybreHRUT3E9t/Wn4CC+6ihUd4vUIK8/xxcNvvloA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218315;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=7yt2meGvc6ptEze0j2NedPLppdFrI3YUPcVJTj4TAvE=;
	b=1/mUxbI314lB5c0Z/7RoVxjxzEfki44Avswn24h+qkszVzamxDyWsIEmYUtJqZdVxbo0
	 uxwB5BvgFsCszCqxisHyzGr1iqDC2VFtY+Y3eFfK2eCp+Q/Z/AAsw7JY1FwDXEj8alhuf
	 9V8IW+pylA1TxPfTzEKVJ2xD0+1ihjC9OS1vVWTP3iao63EfxGtronGu9+UZ0fvBorhsK
	 3KTQmyONwQABeQse7ehgKTZkZD9dsSr5+z1Jg2z8zkqlB26JbiC2aEe+4++tlCVPVvzQ8
	 LiUYEhRcNxSy5epQ6aNIGDRHNShbSpXSbpM9n9bA9Xoy8HwP8Op8t1J0ewVyoWAJ0EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=i25RS9Bo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AbcAQUUd;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3687606D81F
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3687606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=i25RS9Bo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AbcAQUUd
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1559A7A0025
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:58:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 04:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794218313;
	 x=1794304713; bh=7yt2meGvc6ptEze0j2NedPLppdFrI3YUPcVJTj4TAvE=; b=
	i25RS9BoeiH0ZhWE1t4NxOi+7Vx/woOmI/bDsjnbq7WQ3rUEiJ0+SHNpxrx/wLCm
	wC5D/g1LwVk/eQPKZ0jE/s4uu20HvRZGfv5uez7pUBUSwSg/xfMKFpvJw85EuLz+
	jE8f6f249XLXl79Wv4NJ7v9Gogn39RUyVtCf7xgSqucTG0yKak8GfyoTJhYKHkKj
	PHDVgEaIirR/okeBz8yqnVID1ODMi44WUxjmpBEsbYToOz7KAleEygSewK3CUKzE
	Ea4Z6e4GSLYNqeYtaLuoOadEuapfvZ6f0uvsJWI342JSytz2d+9cUU+IRK0CpIms
	6A75LLOYKTlFDqBgM/PBBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794218313; x=
	1794304713; bh=7yt2meGvc6ptEze0j2NedPLppdFrI3YUPcVJTj4TAvE=; b=A
	bcAQUUdhOF/Xb0/SB5p8Y6qYQzzc7fc9wBA8y2OW5uRizgfWdLdC+tTOuNkn93Fk
	lnNDTLgmJYPo2qoU9WoXjIUXfC2PyuH0aCgosx43Lk6kzsp4ezPe6XMdOgzgs8yi
	sim/9SxDDasSp+pDvuA3trm+Y9F/lCuMBeNiw14ATx0KFUYntv9uLfLa11LZyLAH
	EjMooAayPsIcWak/qPAxfmxaKsbcx959LQsXcZo5Xhsk+TkvU71f63xPRnCkGVLh
	NdyTLBb3XVEoi32/Bw43KxPa5pzikLyDXsBWSqAvCdenkHyLmsX0Ieu2SclzU+ct
	Z0fAjoaAa9M7XdLgq3kuw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218313; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:FzIoUFWYtseQ2eb7obi0gX15NF521bE9jYyjdBjn4VtTiEP
	JqgCnfouVuZK+4+XHUXJE5UQDhEaF49x08re8g9Uex///AdEA5uMNtHJNCPwy9s8
	e0VmC9GN3qDBCQfgmte7Lv2beF3VimSynPcSZ6aiBFXm8oZ9WmYwMiZZMiNUkdy/
	uPChYvlHBVSwJ3XstO3OwjnkrU6zPxoxL5Ngcnu8eRi8Fkw29C4a/QdUWcRvP2WL
	vyI8VmFUIZrHelhAK+/hhhqgMWBvpcrStF9Tkqlv03poYnp6GwxS81zwMTHcatl6
	XCQiH4A5FuPiMl6gTPnO2nokynethjkUbHrrfdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fDMrn4HVUMEhx9thUWHqTG9ti9BXgW9Cr2fqLFlw5JE=:MFYyZ6sU44P8uK7tkHpbR1HBiVar+8A6ETN9ztANPxQ=;
X-ME-Sender: <xms:SZnxatEnvaH5rbnj-Rq0qMphsXIAhxVglLwpjBrwVq40wkENqiNe-Q>
    <xme:SZnxapV6KiXIIi-aHlw0teHvTK1t6ZNc74HMPBdxYzfKaL1aVpHXqDs3cJujR_iiC
    xQjzXbtYyN0CmrgQRYRzldA2J3MkKhD_YnrYfQsy524TQ3fWm95t-o>
X-ME-Received: <xmr:SZnxakIdfqLpqiN14AEHKs-X0jA2TLYWpxogzfwAxk-gGBnPVCTRQKA523IggJngwo0xw3Y>
X-ME-Proxy-Cause: dmFkZTGEnZ/GrYg21X4aYDwM8YQoBMgPdxY4LsCbVoHBIs5iLxJsgZOitU6LtDlXgUqRKL
    dfqhBdkbI447T4IyVQ55UTxkqhZhoFHreYlG0p/cEw7bIQQiros6+KSwIXbVCzrrl0ODHf
    uH3a57yyeNPXuMFLxup/+N3Iy2cmDqIIEVFKd+kG95nvqz8a4vHDjYMkJ8+wjAf5P40sjF
    zu1y6o2fo4U0uP+/6JFy0hHKZ1Jb+jlDMPlBP6cKxLcq6sbhWrPfNqYB1zqNZeBylX8e0l
    h04fHOy6Y9i5W8Lg5XYOFywcZLeqR5z9HiQaQjf4i0vi/kmsHNRyr74GSB70htyeOwMHsx
    tE5wH210IHro9kWdxkmPfaXtIgAS2eTpVLqhVY3oR0H6+cyD3rxWrZXPzIDDqrppBbo6+d
    yMG3qEAfc2W16X4amvzex3P5vh6mT0cZJIDrqy5shM7e3MFSXvOQpoM/ZBWs1NR9zhLb2g
    19ue0IdxbDG1DTzy7reDmJNJRfDiUZk11N985WxVAFBuUJmVUOMHuFhEgy4tcSD5fNxGXX
    kWYvh4/R0emumtUKEghSfHGcwBi5UXR3oEI3lAdI9+QwMm0lzygg3q/B9bG+QloXiE/fuM
    YyG2c3Wj6HajiP/MM58TpjTGCm1/pSYfPpD9WFKrv9SEroVnF0zRiHEP+AJA
X-ME-Proxy: <xmx:SZnxah_P84uDdVWploCcXcrxSf4RlRb-EA_xAHFG4m1OhoXQ2nHTjQ>
    <xmx:SZnxavI_uiIWqCUXnjUmmMdWjTOTPqh1DCMB1C5T7la_osUSxm9qpw>
    <xmx:SZnxaunzbjyTOIdkKVnIiCKQGA-cgmNn8Pln5VY8-ikBaVDaRJIoBQ>
    <xmx:SZnxarNDGNs_5LwM9-SX3YQnL0R9kUY3L5uvwGCtSTeTjZug-plYEw>
    <xmx:SZnxaod-TZ_xjXhYli3F-K3zOdYgonWqNhrD6q_Dwj0wzbnaVRvJk1tv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:58:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id faa956e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:58:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Nov 2026 10:58:22 +0100
Subject: [PATCH v2 1/7] gitlab-ci: speed up installation of Git for Windows
 SDK
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
Message-Id: <20261109-pks-gitlab-ci-speedups-v2-1-508832602d0b@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

The "build:mingw64" job on GitLab CI downloads the minimal Git for
Windows SDK on every run and then extracts it via `Expand-Archive`,
which is expensive.

Improve this by using tar(1) instead of `Expand-Archive`. While at it,
make the script error on failures and suppress progress output.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-sdk.ps1 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ci/install-sdk.ps1 b/ci/install-sdk.ps1
index 66f24838a40..bb332c1c10f 100755
--- a/ci/install-sdk.ps1
+++ b/ci/install-sdk.ps1
@@ -3,8 +3,12 @@ param(
     [string]$url='https://github.com/git-for-windows/git-sdk-64/releases/download/ci-artifacts/git-sdk-x86_64-minimal.zip'
 )
 
+$ErrorActionPreference = 'Stop'
+$ProgressPreference = 'SilentlyContinue'
+
 Invoke-WebRequest "$url" -OutFile git-sdk.zip
-Expand-Archive -LiteralPath git-sdk.zip -DestinationPath "$directory"
+New-Item -Path $directory -ItemType Directory -Force
+tar -xf git-sdk.zip -C $directory
 Remove-Item -Path git-sdk.zip
 
 New-Item -Path .git/info -ItemType Directory -Force

-- 
2.56.0.611.g1030f0b940.dirty

