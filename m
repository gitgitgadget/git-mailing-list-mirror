Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961012;
	b=1hxno5xb1gR2Sb8gvry8X1mJHV/u2Zu0PX91Hd/mYnbb504qcBAQmmROIH14MklFJBI2
	 st+zhbXJxp0j7VkYIjaIVF0B/9p7Orl16yiwU5QB8Woy4RyoZpltUH7A0pfrqzFBFwoUA
	 1ZRLBSBObjg/AHoL2P9q29zr5BbHjjGD8P+9CLJQ5M8a64w7Md8LVJHGIoYMN8x3Ut3f4
	 Z6nAoiflWpdJJdmPhSzJ42Pzl2TKWRR8TcPfDmfyddLyZlB2xpV08nynFJQ00b8HB/rQL
	 BR1xPxKD3OKo2uZ1ncz3HrmLbNOBM5rRkYEGvRaNi9B2Wit4303iTswWgzBT1uA2mtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961012;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=MRemmQ9Z6nfaGTpvLf8sBPmE1UT+pnnmfafU1GXOy4o=;
	b=gs9wA78qG3ZkRxUDSDV6byPjFxuWMR4/kSA2YBJbc0dNPv/gbkG3V1ZZExkpGqj/29NK
	 9zdaVph9tP+yKlq2KuxWO5IgklXsynLvH11ZaM62PAm7mkgunFl6YzUF3fYaHu1wGzmfS
	 JlQXa/9rrIDygdlYCwEojbvDYHHHzsgWtIJSlppwGn8Td4y5eCX3uHkrV9pyuSvYw/QjC
	 HghVuXATHCYbRQbpBAYSSppGMV/gKS2sz3Ahs4X9/cv8mFeUb52t7M6tYqN7uV6riYmjg
	 lh1F70bdwK2LgGW8AO2eVAB+cQn3m8358Jy7OfAuj6J1NhOq2x2jSrdVWLzpFVxpKQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=N3XbWwvn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="2/EQO/0A";
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DEF606A336
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1DEF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=N3XbWwvn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2/EQO/0A
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B3A71400103
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 05:30:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 05:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793961011;
	 x=1794047411; bh=MRemmQ9Z6nfaGTpvLf8sBPmE1UT+pnnmfafU1GXOy4o=; b=
	N3XbWwvnf0954WtynLSKWb0xgIZs2FwzfdPu1QBFNeKLQ5Q2ESsQuxhMS5IJm05E
	VvLR83Wg6Kv2+XCcSt6t+lwR0rmvMQ+cnSpEXvIMRbDtGTEnvvpcDgu09gZM1i65
	XwlH4ypCpuG2SRANdCTh08fSetjKR0NyeCaBzv6IBkKmy0lChyCeCzJCTKOXCVxK
	kLEZqlgsqfXBRZA8YthMpperrQUdGd28eXpD7AaLpZIUOiU6W5t8l3RZFrns7Xtb
	gzqOGwtjlL4fX4HQKPg5hJLINuwD9e3riJNoQH/3az5KHbgOgOldMq09qjJcoEu4
	x7nKV8x7vyEhqC4yDSHdAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793961011; x=
	1794047411; bh=MRemmQ9Z6nfaGTpvLf8sBPmE1UT+pnnmfafU1GXOy4o=; b=2
	/EQO/0AnrxkN5veqBd3tSYa3gCZFhs31vBN1uMuBPeqJ/xIwAH2M3bDOfaXy7nS9
	1d2pbh9XvyL4Km9YBqIfhKqHV+B9VrqyF6mhwVlFSBpjByl8xsELfPy4wE5iFfFu
	a9NI8ZdZzqsNE0TFQFgVQtZXYUP+HQ4M1ZoV1Bu14whGts0CQ3ZjwQ9yhdap8Yne
	V3QsF5gIXW2pMr1zC4zn52DEemvYm99YTq2V5//zCp3zjCjQCLetuJXJuSe5wfdd
	FQjPHxxEESsE04nFG5m/oXq70UVQg4Rb+ysni00hy01Pqxu+xNnvd9KyDlWooUsG
	YSNCb/rB9dP6ptFF9Q+Ag==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793961011; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:CrP0ghJoK5lI/LYLlq49QEI827nQEh7sckdLaZubJwpSjMR
	gP4ke5HypC2AERaV4VaC9D0+TxT2iDZatpwAC3ArYRaFWtsPEY4SYOfQuXnS3USv
	JhmKZGRr89n/Cw29ull1twPjbD7d2ZUhtnqAmrawu0cV9Sv8B4sK2g/50isAd/lr
	jecUISNdZ7KT74rgP8ZQKmZdHG3+CdH58evH+unEIKmf+XEWt18jJ/reaFw56vGP
	i7/ddRi1woD7Z5PlaAc0uUatBo3ghJtcMMK9ArFjoz960kz0sTjNFoogMx+woP3c
	E7bqSxvPKoXEM8nPxdDkPJHojuxw7A0xGprqK8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:B6x9BNNU0kVodEyc+v9ki2tDzu4qF7FXju1PL0ITOXA=:9XLjByIi40VI3XGqTF4Meb3NOrePnx0W30KQJJ1Wgd4=;
X-ME-Sender: <xms:M6ztaqQ2qpPYPa69iRbM1RmTawj8zx8IKZrzftHnXHJhV50PEPT64g>
    <xme:M6ztalw7VDzjUdnfXvQ0zlMaij_qQQT4Qy3PCkDbFGSkBDrR6YtAlfthe-pBevHai
    EsK_JMUUj4EcK4K2APkaLLvtN-8T1Q2YSHijG9Q9iwnrv5dZOyBeug>
X-ME-Received: <xmr:M6ztalfkShIDaUEqFGKx7_7PU1sme2mSj7OH2oxZasAhCB8dJ5IUUjMPf0DUAQZI5DEWQQ>
X-ME-Proxy-Cause: dmFkZTEfnN8BTB4zWhwQchdozYyX1hGHjgfqFEHdEsw7NsIf2b6940GTAYhuEs4zwomu4B
    EpyCF5ELv95Xy39mQ+oDrBgknhHUZTmFEW9EOVykOEc0s+R0DOj0H4mcx+EnntVnVr28op
    bgWpo67+c/Zs4xn3oJrXQjDElKpk9t24LX0GHoIq2hwZyaEiDlLJdlRQQLJAeV6XaHS/tk
    oI+dX3YEIvuOsJOYHg+aovWAVThY2SNwmTumqLHhUe50g9UW3rCKkaS1F/GU42rtD27pvf
    +bQdhwjU3hoI3c8cQMdEF+ULCEHK/dGN92j9JLVRQBZ8HrtC6j6ZCUIR8C5i3euHKw6MgS
    y7Kh6zfuk0WPbfP6R6iyHPJI/3YGqGUXklY0c3aBv1rKDOrMaz2bmMb9O430c2JucQlr72
    ERKMxaM4FnaD3XuuKZLSGzFa9PKbIy992Yl2ZuJiJKk658oun1FBxoofLFU35WJvNw95Q7
    k6rmy9qxZOA/+7v/tZiXfLcpOHuaMvqz94a2T6a/4DNrCacVT6Bor3QAVPkJBCd889A4MN
    XitPtdXXT9jb2SIGhGZeWrEF/RCw3/gnvcq9u5T6agrEzHXGjYu+fQG9VkpgmaiPmyb7po
    IzZDS0NWRwK6yR8YKQB+cS9agLsZDdElDG9tPAjrCQhRaAZT/vTse8mwjvXw
X-ME-Proxy: <xmx:M6ztahKsFy2a5T-dEm3ox90INUOFgtU22DHY7tsYxnpRAP4VCYeNRw>
    <xmx:M6ztamHtCp5glskUommpbwez_cx6XJutpWtdRHRdrVcIEil5Cohtug>
    <xmx:M6ztaroj8KxfkNoFUVuZ8JnVWcgUjbsismOAiEo4C6gxOpTzAbXt3g>
    <xmx:M6ztavQEZXn-0I2S7ozOGmP7BM_VCMrjJGHZqpjTkriPcn4mj1J36Q>
    <xmx:M6ztai168OsKeoWXxhXjZ-1kJCJneqcx3sfV_wYfwAT7MK0aReU_ucqj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 05:30:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e9cf261 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 10:30:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 11:30:01 +0100
Subject: [PATCH 1/7] gitlab-ci: speed up installation of Git for Windows
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
Message-Id: <20261106-pks-gitlab-ci-speedups-v1-1-1fa0374c7287@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

The "build:mingw64" job on GitLab CI downloads the minimal Git for
Windows SDK on every run and then extracts it via `Expand-Archive`,
which is expensive.

Improve this by caching the SDK and by using tar(1) instead of
`Expand-Archive`. Note that caching actually only gives us a win of a
couple seconds. The bigger win here is using tar(1), which speeds up
extracting the archive from 3 minutes to about 10 seconds. Regardless of
that though, caching the SDK feels like a sensible thing to do as it
removes one step that may spuriously fail.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml     |  9 ++++++++-
 ci/install-sdk.ps1 | 26 ++++++++++++++++++++------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9b7698a0037..15419a954b3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -127,9 +127,16 @@ build:mingw64:
     - saas-windows-medium-amd64
   variables:
     NO_PERL: 1
+  cache:
+    key:
+      files:
+        - ci/install-sdk.ps1
+        - ci/install-dependencies.ps1
+    paths:
+      - .dependencies
   before_script:
     - *windows_before_script
-    - ./ci/install-sdk.ps1 -directory "git-sdk"
+    - ./ci/install-sdk.ps1 -Directory "git-sdk"
     - ./ci/install-dependencies.ps1 -Mingw
   script:
     # The minimal SDK's profile resets PATH.
diff --git a/ci/install-sdk.ps1 b/ci/install-sdk.ps1
index 66f24838a40..1dbcef04a18 100755
--- a/ci/install-sdk.ps1
+++ b/ci/install-sdk.ps1
@@ -1,12 +1,26 @@
 param(
-    [string]$directory='git-sdk',
-    [string]$url='https://github.com/git-for-windows/git-sdk-64/releases/download/ci-artifacts/git-sdk-x86_64-minimal.zip'
+    [string]$Directory='git-sdk',
+    [string]$URL='https://github.com/git-for-windows/git-sdk-64/releases/download/ci-artifacts/git-sdk-x86_64-minimal.zip',
+    [string]$DownloadDirectory='.dependencies'
 )
 
-Invoke-WebRequest "$url" -OutFile git-sdk.zip
-Expand-Archive -LiteralPath git-sdk.zip -DestinationPath "$directory"
-Remove-Item -Path git-sdk.zip
+$ErrorActionPreference = 'Stop'
+$ProgressPreference = 'SilentlyContinue'
+
+New-Item -Path $DownloadDirectory -ItemType Directory -Force
+
+$archive = Join-Path $DownloadDirectory 'git-sdk.zip'
+if (-not (Test-Path $archive)) {
+    Invoke-WebRequest "$URL" -OutFile $archive -TimeoutSec 300
+}
+
+New-Item -Path $Directory -ItemType Directory -Force
+tar -xf $archive -C $Directory
+if ($LASTEXITCODE -ne 0) {
+    throw "Failed to extract $archive with exit code $LASTEXITCODE"
+}
 
 New-Item -Path .git/info -ItemType Directory -Force
 New-Item -Path .git/info/exclude -ItemType File -Force
-Add-Content -Path .git/info/exclude -Value "/$directory"
+Add-Content -Path .git/info/exclude -Value "/$Directory"
+Add-Content -Path .git/info/exclude -Value "/$DownloadDirectory"

-- 
2.56.0.500.g5d06dc02cd.dirty

