Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618281;
	b=cupFejzO5gWz0wTaQjGP+X7A+NAKGAZGhzr64ibS+M1V5KR8wwsWPz1AbwzCirkbROaV
	 YoDTDHQnBwZ5dWlw8KvMlGCFBGSlOzD1HnjVPLRWgAK2MRze/tty63fKRtvY6RF+LfiNJ
	 dNh0OGF0nU6dRqY+6bGrYPeTtXZAkWHaSpXqRJzFgbcxql4F95BJenOQKn4tGArBzCBUz
	 yYhn9MA5kIan97Gq+jr5d6sGRJJo4pyNqfeieFpsrBAlqXtRx4/mMqUsE9LUJjbpyHilE
	 RwRfOCuBFgmhFfzY232hNEMwkdqGrnuz+aQ3KXMmJPXUXSLLX+10fS9j7pp/Sg2SQtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618281;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=g0dRA0hIsu6U8T5hE3G6pygIze3i52rBbHAFS6A9eBM=;
	b=aHaJ/z1pEWNqt45J3ucP84TRH7aouLKMN0zKCWldpBwpS3X1MhQf3nlXjK7cT+ErDP4h
	 QfU+n+6tF+FWSK7iF8yU5AK+d20tG5znpgBWNi0tgM8e4jxhRaB4j6HCepdP7qPl5Y7R1
	 5+4bVKP2LG7dAMBZto2S/do5bohRmA31zTr7pbOlt/qviXMtzCL78ijK81M7sgqjqskIW
	 8VzNnTT0WhqPyHCGv7em3gECuPb60tvJeutxPFH7NkCaRDqxGIbJS1xDF5mNPdN0cC0Gx
	 e1WKbKGaBI6qFqTrMtPy/8BWXeE9JvbI1KXvzSpg0q19W/mlvmfKyjDXdsEoTPL6P0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=l5C5nhA7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mWg8MeCg;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD460A2615
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFD460A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=l5C5nhA7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mWg8MeCg
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C92A7A012A
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:18:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 06:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618279;
	 x=1793704679; bh=g0dRA0hIsu6U8T5hE3G6pygIze3i52rBbHAFS6A9eBM=; b=
	l5C5nhA79XaJAY+KRZ2cQgsg6Oj8c/iX8NiP2JfvnXDU2DzmGHRKxNw1whlxTqsf
	3SBIy2zjLYNGy0BzEX5Kw1pg1GKySThWZ6D4YG04l2MBzLUe0RN9nBXljtplkwXl
	n/vOIuXPBnxVdI2JJ7FhgHXynQAF5gjEE80e2BHqWaBgxHczQ4LBUwDk0kQUmAtm
	AX/H532meD41nfHgFaCyYmE4xiPsJlZcMCqg0Uzz0fRv8VtHKIFB3P3GayPULaGI
	MHVpq5uj9nu9oEsMpu6QiPLvA3cTDjP+bedtkuDrMkbSkeJ/xrcBkHhwwWGOtEg2
	A5/N+Q4xLavyX0L/GWaIGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618279; x=
	1793704679; bh=g0dRA0hIsu6U8T5hE3G6pygIze3i52rBbHAFS6A9eBM=; b=m
	Wg8MeCgGd2njf5kp2ZP4g/HpSLb4M8PBuTXT/7I+m/aXeJwadDm3xnY3N7uischU
	TcXiABWvQooywxskI7Ah3JRoLT3vQnhoXWip04I3zlo00bj1/cnkv08N4IcczJK4
	s2sZyWBq7ntkCrepE1bug/ALz13v7xin4DsJTfJFeihITRK0zqZ+HHsDLyql6Y3d
	8YuU03I9pNX1UvjsYlhSwE/NGHt77IypaCdTHSSPM5FvEDjRu8R4S/uFqugoeRK4
	V/5sGks9h6txx0MnBb4uARZvB6+HOl4EZ6SoXMVMgqXnZzYSh36bpGx3H7R8VGTf
	NRs1S1KRV0dqCFsLMqjAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618279; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JfIjwaDdQDUBtoGzQ6P+kgnokM0SEkYgMOjcjFWWOtE7z9x
	JYJFrLvZOJMfjIkosA4PMC1tBEUCEhd8DU0+wqG0lon+Hu7nhGF8GHsfVstsr/1H
	seqQ6eDLHBmv0sHwDoZUGAbWZtFgKGJ3v6pRfniKdIbuwpjSwxlmSPXV4wVpQjnN
	9VYGi2OsR4qtSju/niroX8aijODphZJ+1dH2FtcJ8G+os2rt4OZtE7FWbOcbMfRV
	Zr6cim6Sf1+74zHHa0uuPhoFE56QjerjkXPH4GrqtCAyt6Kd7jaQeO8RrRVdMNE+
	WbMIKQ0LNLs5n/GaTRiMhRIP1sHAW9lyG714CVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:f0HIwEk6zwQYBjPg4CmmkVmiIEi1Fq4F6cUAS5v2Yx0=:D7BYawePkUeCkjPDM1X5UIa2qDsS48L7Zj6EERc7wmU=;
X-ME-Sender: <xms:ZnHoaqasD8OOo1Urf5kRyC8QEGBgWFofUTVDXtFFZe_TeEsJim-Xxg>
    <xme:ZnHoamsWvyOZ9EVsJdp1vdIJdnXbt736peXRybwK1ixvqQXPoIqI6FCjzFkq3Tb8r
    4eojDSiJxwaD85rLYiqtmVAGHy6P0zTzWAHpXG0MER1vbAste7owQ>
X-ME-Received: <xmr:ZnHoasN8msFJHMvJRHvUh4uBH_s9XuAPw9st-hKZF8nIz9Dow9tdjgouxMN_W1muRtOOLg>
X-ME-Proxy-Cause: dmFkZTEA/aM6MQJegyUdOp6dDGs9n9cSz78rKedtxHLtmJZReKVUlAzlWy1MxHtr5FPAns
    AB2G8+7Y7QF1UIOTZvuA74vV8s4Y7lVIazAYBTFxFq5HtMy8kHv6qicCa+PYiprzT2bNiR
    M7tGOyrzuxrjibD0pl6V2Ryg9DrimMEea/RXl57pGu39vVokwFu4OzIcDrvfM+uy3w80la
    f/mymqlWMmFSpfcAV88izrZN4BO0/cnyTyAv+YAtHPlEsIP697RhuuFjypd0intJcJkS61
    vgI58QQvKbhDGypg3FrA2CoFKJYdHoKXi+GMZHY6zgTaKoxQT8lCHVgJ1vsmjCNw9zMPsi
    yt0CM2HbxxCIwAnp12SPaHVLSAURrGxConBEKVWBARBkb4IOZFcsGQk82qxBn8PpG92o/+
    QWQ3Pu/LesvVEeP3C279HMeChM2LtEKTAMWhQRGfCuE73YdYzqqAz9E0UzXaXRWI91WlBW
    AU+unIUxh3F502dkqtQdjOdV2NQ2MBeKdgLLGeERsDl6PU1SiFKr9bVV+pGMnKEA8mIcnP
    xWS3Gi8mObQRAS5BaqdT1411oubnoE/0X3zeOrb4lExa+33FcX3f2rmkpJOCh2HJswy942
    +kNHrR3HV0ebO3y1quyCed7XRRba4kGh6rbpoyiOtEDGF0CFHf2/iiCTJjwQ
X-ME-Proxy: <xmx:ZnHoat5v0ucqMAe6Wvftvl1BAskztMsA8OKOcMSfMRdqexFY88C30Q>
    <xmx:Z3HoaiSMy3fh1d9UEK0Hj1lylrJbqnW7stMVunFSz7Z2oitvYYN9vA>
    <xmx:Z3HoaqAHkUmXBJsRcbKgLbsSYLLQjWlDgo1wDwMV_yCB2hH8Ys4Vmw>
    <xmx:Z3HoaiHbXVI0hKRcWqX2sqAf9z9XTJYZ7rqZSCVOIJ_qhbGCn57i6w>
    <xmx:Z3HoauEOUYukJbTRXxoZcrsDJ58yoUZaW9jJrClj4dgT438VwkbS58XI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:17:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a16d582c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:17:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] ci: consolidate test variables
Date: Mon, 02 Nov 2026 12:17:48 +0100
Message-Id: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6CMBCFr2K6dkypWtCV9zAsSjvI+ENJpzYaw
 t0t6AFcfsl773ujYAyELI6rUQRMxOT7DGq9ErYz/QWBXGahpNKFLDQ0OxhuDJYgIkdIJmTwPfs
 7ORNzGyonrTb7rTWqEnlnCNjSa3Gc6y/zs7mijfPwnOiIow/v5UQq5tzPp8o/fKkACa2q0LXlo
 XHannJhQw9RT9P0AQnrf2rhAAAA
X-Change-ID: 20261016-b4-pks-ci-test-vars-consolidation-8d0c6a53ca28
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

Hi,

this patch series consolidates our test variables as a follow up on the
discussions in [1].

The series is built on top of 37b3475fb53 (The 9th batch, 2026-10-25).

Changes in v2:
  - Drop the last patch, as the reviewers seemed to favor an approach
    that's not compatible with my own use case for this change. We can
    still discuss this separately.
  - Link to v1: https://patch.msgid.link/20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im

Thanks!

Patrick

[1]: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>

---
Patrick Steinhardt (7):
      ci: consolidate setup of test environment
      ci/lib: always set GIT_TEST_USE_SET_E on Linux jobs
      ci/lib: deduplicate test variables by pattern matching
      ci/lib: merge switches for specific job names
      t: honor default ref storage format
      ci/lib: add another NO_RUST build using glibc
      ci: don't override initial branch name in testbed job

 .github/workflows/main.yml |  3 ---
 .gitlab-ci.yml             |  3 ---
 ci/lib.sh                  | 44 ++++++++++++++++++++++++++++++++++++++++++--
 ci/run-build-and-tests.sh  | 44 --------------------------------------------
 t/test-lib-functions.sh    |  2 +-
 t/test-lib.sh              |  4 +++-
 6 files changed, 46 insertions(+), 54 deletions(-)

Range-diff versus v1:

1:  a8727388da8 = 1:  3ba3d58ea4d ci: consolidate setup of test environment
2:  ea243343552 = 2:  52c9d8d575b ci/lib: always set GIT_TEST_USE_SET_E on Linux jobs
3:  1751b336cbd = 3:  139a855e36b ci/lib: deduplicate test variables by pattern matching
4:  b3ffcf0d81f = 4:  5c82ad5c76f ci/lib: merge switches for specific job names
5:  db5d05f0743 = 5:  8329586dbb6 t: honor default ref storage format
6:  0683eba847c = 6:  1f62c2fa8a4 ci/lib: add another NO_RUST build using glibc
7:  8c2e6754773 = 7:  2f656a16971 ci: don't override initial branch name in testbed job
8:  ea39ba888b8 < -:  ----------- t/test-lib: make feature-testbed job more accessible

---
base-commit: 37b3475fb530c14109211faca33716a173db61ed
change-id: 20261016-b4-pks-ci-test-vars-consolidation-8d0c6a53ca28

