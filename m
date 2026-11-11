Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394086;
	b=GtRx8mf90S/UiQVwU9w0GgW0mxSAgJTDb7uJuKhw7WnJqhAXLroBXchXpdWHLJlpyaw/
	 q+aG2qngTObZJIEr9ZUMDBeO+2Gm36pTIuFE02Q+luKHJZDSysm/jktZQyxG/w45Q8PjH
	 vjT34KBEImEDiMvT2Zb2VPUgDXksNynRBR9o3JjrEWISHXnh8PpEj2yu8x1KhnsXr82yc
	 dg9ITkhDBBq/tMKYh6VWyWcUWN3a847ECR5S/h/4g/m9R26RRJuELUUSAPQkBsktEiOvJ
	 a1+VSiDyFeQsqWELWjCTam62+CKL2YrdgZ2/cO/4/ZLp5y/nPc0SFO/OJY54oXIDjbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394086;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=EZ1BZCLldTw8yvDF1VJJ97tBGdZr9GFdeT3hySqTC6M=;
	b=N5HdvbPyLPLmExi/df0XfYek8gxSWrKFC5hAcG5ms/UJaToYVxduwquKTwog4yAm/6hp
	 XU83XkYVS8lqB7G0pZIDI6JQYodSN/iWIt8cZ3cJWYzi87goye7URPfk3u+kQMYWgfqlc
	 QuGldjOfqxOmconIX8eFGB5KcTC3etshF083EZbtRKR5xfGO9LW57gM7I4ft/rPC41/km
	 ObooftfdWsqOjbcVy/p5pCFxDlU4qvWLaMjSN8aaJ5tmOGf9TfANSCv3CIZkENAjWzt81
	 GuNXsBxn0pAocwi+fApddA9daIUKBzUbDJJ45Rjmwzozd5J2S5CxTga6rz9l+Uk1O7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=fO7cRnO7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="rW04/UCT";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94549606A330
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94549606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=fO7cRnO7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rW04/UCT
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F3402EC088E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:48:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 05:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794394084;
	 x=1794480484; bh=EZ1BZCLldTw8yvDF1VJJ97tBGdZr9GFdeT3hySqTC6M=; b=
	fO7cRnO7LpAqVJYlAU0SQhyKqzuh45Wh1E66cGNnCoR2q6Yrtqs4wi/mVlr2swZo
	PXLOLhHalbvcXvob+z1DFa6t1rcgwbdqSESk2hC4m2BeGrLlfn9F7QOobRq6zszu
	H+5j3vAddGRxPAr2F7AMnyowGs83IFcS8gI+YSOAyDL3jYRz3ykf+1loEw+TtnWb
	GbuP+XJasEv1aLCFLJp/FIs7iprm44mDzzh0v+nM2K0ZN6oVISdse+2dJyVkMxj4
	JqyT+0Y9pzGRYCwGTgV4PDecfXk+mcBSQwxUgnxo8EGD6x/bnMvY4ClmbWoeU/dg
	0E4RT8ruzNoygHY4VoHH0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794394084; x=
	1794480484; bh=EZ1BZCLldTw8yvDF1VJJ97tBGdZr9GFdeT3hySqTC6M=; b=r
	W04/UCTPR63E7v03S2r63WDioPDRB8gEwU6E4n+W9hwpgZe0IDt1hyl21woKwima
	QMk4l/3FsBSUwtA8CnN8+lEfAsXW/wRLnvxV3clK6rNTXAfJt8+2JDoxhELHWLdi
	8tTyc3QkuuD2G3HI6c/bwWqSc7Yz/uUSIAm7lJf6u4MR9Hke19qqFJEkZfVG2LG7
	boF8UVTb/gsTPHiQjU1dkcBMm8tE1kedxNYFZcOX9ZaVPHwiRICE5qnge/YjF/pP
	Ivtt8dFeFnJ6jvVoGz+0gwe9OXfahj4WXUgTAK2gPBs0/CmHZLaizA1ARUiIGces
	fMc7mTsCX0V+9pC6uzKFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394084; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:YoOmu9NhcgKBJEFbuYtNo1pz7qoh0qcVdCh3ScLUfzzhA2v
	iDcZtC8lBUONH+o5JNY6vnHIrXjdk+3OvPeoo5W1b0FIDg7xAeJnQdlSoDWjPeK/
	09yvOOeEflU3CgnKuRdaFCW6XkYi5b4pzCXSZq4asXwjVALHOIz93dP0MRVQ8eOm
	GEUvXHLr/m3wDWs1HzNdlM5CBG/TOCvgUYfsVP0bYcYNRig1nAoG8D0uSSAoQgc+
	TcjX91ejyIKs/wa5bdJ/x7RGMpZN9qTLD7g4cZlWT7TdnSM8OHlXHpexdBCf2jm2
	GUT+4C1fZ9fZgRI8BiXGqvXq/5koPNTMk57WYhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EmYwttHBAdRBqGGFo5ByLsCVmHZapH6rWlgN3wR1o3Q=:u/4O+KEBA98aYYAqCvxQ5gktiQ7UFAXEGRnLZJS9NoY=;
X-ME-Sender: <xms:5Ef0ahrtH-4cULgwTcJHAxGDt9SEtbrvZ73KB9ocCINPGDYlnfUWtw>
    <xme:5Ef0aqoQxJXfRHM1KZdK6Zhk9MzWBxKlDCUzD6Gq9Ws8fRrQXn8FOMvLjEx2dyjd9
    -yYSOOWVJ1hne9Xf9lK25_cG-KgmH0MLEmGD42LM1kT9GmAJg3l9sk>
X-ME-Received: <xmr:5Ef0ajPiFSIdbQlGdA52dORd3uFhFmRa9iSMu3eX0lPiQTwu0OfFuvJpOrIZj0S2FxRo1g>
X-ME-Proxy-Cause: dmFkZTFXJZLoUzTWcNlj60KOJCFUIYFeRz/A9sP1hTJkhjZNkZRehSSxnn+Lm01Y3u977e
    nkue32PaLgS4W3h5Ei6Gga1Q6KlfSYjxWOIl+Eusqn9qvMJEj7RNpSdHjZqNBnrPUaAI/Q
    +vU6OvgodWFGek6MaCEGDV0Oc/tVFb9qDlEOsUcOjDOmzEJ+COM9SIAK+oztNjSVOaZ978
    o8C1mVQy6xjMCYwvNlYAq64EXx/tlDDCibiv7ZAeZliMU2LEbAqUCclbNKZuoWaAFq8KVp
    8b7Fiv12N1MK7B+p8fQnSM81QPYQ7TGxJNkNilAg77/6cSkqIhRNwljswNSTA+R5h685sQ
    aiOhS3Q0TamjWNbdY2hwTpqgN1yT10aqUs5B/uVAeaLzkQ1gpdRkU4iwx1XMxmulGbZKO/
    ByRJKUBk25ScU8EFdMpJAPVTEBuBfReZATrI4EsUwki3qruBV4/W5McPSsssbJCZAVlOB7
    ogz+KKVHNfXrSr9cRG+pwL84dbhFmY/p5SQXQxoOxGEhPO0guvY1Dyqj4tWENvucHZ9rAo
    N9pHc2eZXX+diebjAVI660PmnZmHzB+divJ201K8MNnRFxEmWZ0TGGqCZcEX/Fr+cb9MZp
    PRGaY3BgWUMG0MLZGo/eLahcS2RdRa1i8MNQmmgvR0YIe+IG0Jcjf1ipB3Yg
X-ME-Proxy: <xmx:5Ef0arwvr8a2ZyRMfq1XqeBLqVZNQ2Hf0w3xiXCdgcdJ3EqwduF0Eg>
    <xmx:5Ef0astwC7RUIRdL7zeubEDbYPys8D1f6QyIeCs4ybM3WUuXSNyOwA>
    <xmx:5Ef0ak6270NXlt07xU8Jngjy-RX5wnQtg4ZNLtlXx9DiHg3VMDCK5g>
    <xmx:5Ef0arTGrYaOK3Qj1MMYRLcMf91FJcl0sF9O6b4OPAKeXex44o22rA>
    <xmx:5Ef0amiPmYxvOohGmFtxIHFfrIditR-M7aBIvd8dqw9i1SHGYVEmE9iM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:48:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2e0b16f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:48:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 11:47:52 +0100
Subject: [PATCH v3 1/7] gitlab-ci: speed up installation of Git for Windows
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
Message-Id: <20261111-pks-gitlab-ci-speedups-v3-1-d1e34117ee2e@pks.im>
References: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
In-Reply-To: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

The "build:mingw64" job on GitLab CI downloads the minimal Git for
Windows SDK on every run and then extracts it via `Expand-Archive`,
which is expensive.

Improve this by using tar(1) instead of `Expand-Archive`. Note that
we're using it to extract a ZIP archive, which may seem puzzling at
first. But Windows ships bsdtar by default [1], which also supports ZIP
and 7zip files.

While at it, make the script error on failures and suppress progress
output.

[1]: https://learn.microsoft.com/en-us/windows/tar/

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

