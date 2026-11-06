Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961012;
	b=Zc0t9p2c/bxFdpPASuZF6j0t8xRPwqvi/PNwb+7KjF9+jGHktzlOAtTwfAVeS0G9rd6N
	 Zk4/gSxig9IwbWeuG+fXBkyx9Fpoie1ZaUD0C0z+EF4Dlq7oRW4dXOrdhrRxDU+rrbR6W
	 +gNwqRMb3vOn7LTRpMMPYTZuMIMxcAZynQp06xyZEW0IKd9EusqxbjeVQV+nzUSi/49Xl
	 J/uMcK//hgnGPfWsMLZahMOnUB2Ok1dkAv7axjRyEizzNrfXg2zf2oat6ACuyOJUj2Dmj
	 whzIxWjNW7ePuf7hCEFWItA7Bx0Iii9dPxjPgdJJQ3EAi5Dc3YAYFEOUyhpb3/vzVpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961012;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=J1xtgRa+Sp7P1aQxVifUEqraHjgvxgRrv+nRLurphtU=;
	b=2PxOZfN5bEm5XhUA5ZA2a+Gl/fzwhF38u2viIluN36hi/UnQwKd4db1FqPo/CybUbbjv
	 iEf6n4LU4TmIs8UDiWE0gBSUI/6BRSVe/k29tHzsptfnC9WCNR2kMS+GNWlvYR3oyjKxH
	 r6i/V99Wd6poTZrWl/80DC8a4azpZBf76Hv0PH3iANK71j8IpioQh1gsB07Ae8SuzlMqo
	 TqRBW6N2iR5lA2FSzb7NB1P+IrF5LMOB3lso7uK7NYkTj/eSodddzcgEYxhYgz4rIpthX
	 +WvW7GPuOP2cucNH2cjyu/2Mmx3NBbb7vtrcUe4MWPPoLBHuA9iWrKJqDzyRzPJj4YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=xdpPqJhq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="m82qX/Oz";
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A7606A32E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 162A7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=xdpPqJhq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=m82qX/Oz
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4466614000FB
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 05:30:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 05:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1793961010; x=1794047410; bh=J1xtgRa+Sp
	7P1aQxVifUEqraHjgvxgRrv+nRLurphtU=; b=xdpPqJhqDOoD/1Jl646gIM6ir2
	zDe7TMErt5ZzG1hqKVYEammRtxBHxH+aJWjmxPgR63BlB/byKK2nF9l/j8BMr+lw
	9q36LOjVyzNTfzYTqhMC4UWZOxp/aoKRldE296yV9pj6SKIAvo7OEy4jKDBn0uX9
	OT+JT8JCETec3klxlRddKXpw5+UaSujl0wz8DLqNSrpOqpWk1Cg6ZXI9mngILKXH
	KCJAqFSKcw5J8ELXOLgckPNi8PQNXNsVGfeTMpHTKSnWlUNLrI2Up7V1FlAvN5nz
	8iJWmKEw6ZG26zR7u8zYNSu8fOh58JOwXUhv9OS2frrlA/EYH4bUMG7MdEqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1793961010; x=1794047410; bh=J1xtgRa+Sp7P1aQxVifUEqraHjgv
	xgRrv+nRLurphtU=; b=m82qX/OzkCDIeKYTLPZCYN316/RNLztEObVdfMsDIVEP
	Go4fRFuuYQ/8HYv9eNdxO3z29LrOF1CdJlm4/onL1y9X4ruUvbOEx5xLotPPzr1k
	pC9hNhNyt1l1b3izUg1rm0C9e7KwU/Twq3vMTwS5d3adW4ig1zWwPs4No9z7lNwn
	vQb5zcafQukV1/F8C6yOACWD2kR5AYdRLwx31/4z8MKtQ+Cd+AWrMk+uz1DKQZwe
	1708q/sPfC9lPYxCUhtXm/aJ8DEpA+L2ofjrwdIzQJQaTcbpNlXfhNxr3k8SP0rl
	L94nbveM9jbIefCFmVM4l+h+94ulI6vsTfUjqD5qCg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793961010; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ZlnhMObBGalV6IqQU1qHn3AYcWOkNIB66nXLdyt2F6BpY5n
	WXIsvvh4xqDBuOpHppE6ZGBOT8pTliqu/TWwtKp0w4C6c754uzTjgIcBfJvpDLxo
	15E+iCvGNXaSq4+3TLpbTR4ez0xct8j3SHgefzNiPwI8fHZFLNqz+dXaFxF7n0/1
	SjeP0Z2BR9Mgg7pSMns1ZdmY4CCl20O5nIVSc0XqY7+A+5WnW2ETDkvgN2Kgt9ED
	BQndCAcSIiy5/JxAwSDXLtKZWZlmScQZvfAFnSCW79mkauftQ7VNfKRbwUfyXI2z
	ijmtHNB38y0pr+w01c9QYWMae2PoI8/MxPtbg3A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:ClS9cIQ9lJD3DGIYnysZCR3duT5aftEJCilgQZGAPKk=:P+bfbCFlHzjzSP5r7Itw3Q2IMkkfp0lhVtf8UPZo3V4=;
X-ME-Sender: <xms:MqztakTuIuzdsGslPuhQcwuSbbs_OpY6Sy1hgxu3O5KG32vbw1B0mA>
    <xme:MqztanwqNGQApBO3evtQAu9QJ5uEtJ7qVKG-z9aMIQeqnep0JI2Yqm9-i-6YhvdkS
    8MbNQFn02nES1Q-mh79V_e7r8z4EP9Em4kkbVGBz7UO_4zq7v63lXg>
X-ME-Received: <xmr:Mqztavd0-m51TRTYc9zIoPaF7N1-sHOf2LkYG29wJoqI0oB4Tn5ODAIjv8K5dE2tZ6WGSA>
X-ME-Proxy-Cause: dmFkZTF8Xhv0RkxN1CaTM5ybizA/iM7WByP7Eshd4QIJoeMDqhcI0Ny5s2l1nbvkvPtFIz
    93j69I6+NR1NHRlZGx7DLrUX72OhOv0bQge4nA00XA9MnxGXaEk5OkW+mlYKD3BzsQI7R2
    osGwIJqpHxOWjuopC8yf7OCuSUFi+DJUQsFfocR7XLiHu+zivJ6NT3UdRpZN/2V+egTWwN
    s72KtYuCcizc2GUwr8APJlNBxNuomWkxga0YF9W9m+aSjkZrBg3KvUnjELq0h1muGTTw+V
    Dw86nnBiL/FYqFmOoJcPZ/i70Z2WS+r3jrj4zeBOTt6zgxiCcSokbew+9LmNARpGf+OZo8
    W5eQtKC3iG2HxbA2WIioERwA9hV1z4s1gGrrg0XSiPH+8yfxUJBlGe7rkw0SmoR0WaPIB/
    0oqVGL2lwEs1s4ck5IzAh6ICNaukBVr2aBh1lD1ccgmC2RtEdS9EGKkmxwM5NHJAqs1GW0
    FzqBiqu/7V7GzXH8znjjcBsd0OJNA73aME9m1xJcvXw0wWk9z8du7YTnVuGP/b+XU7ZjE+
    /LTxcmwfV2TWWzwjAOcDCkpjMC1vRRzo41sCvYsq95k42V3HoVmQ0HprM2CkQVAS4vVkyQ
    VxkJczz90sZiL9ieTzkq3Z0mY6EIWwdMu7ZIKYdKF7DKd25UuNaGxhGQUgcQ
X-ME-Proxy: <xmx:MqztajIASHMPs51poKrpHFLur7NxJ-FO_Yfgtl7t3aNWDJwLvNTiMQ>
    <xmx:MqztagF_sznq4G5ZO85oTmTeeW4dy-wD7a4ouLvlt9QhVKRYXaELaQ>
    <xmx:MqztatrkC2ZFlxPytx9E1KGbH9Lco_1EytuE5fJXOxyligpTBG6xEQ>
    <xmx:MqztapT_OAM_y21QK_1g0CfTlhNImO0RaDAFDI3UPoVVt1MVBhhEcg>
    <xmx:Mqztas1bYpiueyERs77bIZPVR5oO_XP7n-Vo4gWDNUWTYGqJrWK2woo4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 05:30:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d288a4c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 10:30:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] ci: some speedups for slow tests
Date: Fri, 06 Nov 2026 11:30:00 +0100
Message-Id: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJBw2gVzEuaPmFUYNNBwgJ4
 e5WXX6L9zYyJIXRpdgoYVHT95ghh4LC0I49WLtsKl1ZibiK49O41+nVeg7KFoFujsbuHI7NSeC
 lbijHMeGu6298vf1ts38gTN8b7fsHQbg1EHoAAAA=
X-Change-ID: 20261106-pks-gitlab-ci-speedups-09c3841eb178
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Hi,

I was staring at CI way more often recently, and that got me annoyed
real fast because it's just painstakingly slow. So I decided to have a
look and try do something about it, the result of which is this patch
series.

The series contains a couple of bits that are specific to GitLab, and a
couple of fixes that are generic. Some highlights:

  - Installing the Git for Windows SDK speeds up from 3 minutes to 10
    seconds by using tar(1) instead of Extract-Archive.

  - t0027 speeds up from >10 minutes to 6 minutes on Windows by avoiding
    the overhead of spawning redundant processes.

  - t5551 and t5559 both speed up by a factor of 10 on macOS, going from
    20 minutes each to 2 minutes each by using reftables in a repo with
    100k refs. "osx-meson" and "osx-clang" thus go from 29 minutes to 18
    minutes end-to-end.

  - "fedora-breaking-changes-meson" speeds up by a factor of 2, going
    from 35 minutes to 16 minutes. Turns out our SHA256 implementation
    is quite slow with "-O0".

Unfortunately, our Windows runners at GitLab are still atrociously slow
by themselves. So the critical path only improves by about ~10 minutes,
going from 60-70 minutes to 53 minutes end-to-end. But hey, at least the
other jobs now give feedback a bit faster. And I guess on GitHub it may
be a different story because Windows runners are way better there and
are typically not on the critical path.

A test run can be found at [1].

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/734

---
Patrick Steinhardt (7):
      gitlab-ci: speed up installation of Git for Windows SDK
      gitlab-ci: exclude intermediate outputs from Windows artifacts
      ci: build optimized binaries with Meson
      t0027: optimize how we reset repository state
      t0027: cache expected output files
      t1092: set up repositories from templates
      t5551: use reftables for repositories with many refs

 .gitlab-ci.yml                           | 13 ++++++++++--
 ci/install-sdk.ps1                       | 26 ++++++++++++++++++------
 ci/run-build-and-tests.sh                |  1 +
 t/t0027-auto-crlf.sh                     | 33 +++++++++++++++++--------------
 t/t1092-sparse-checkout-compatibility.sh | 34 +++++++++++++++++++-------------
 t/t5551-http-fetch-smart.sh              |  6 ++++--
 6 files changed, 74 insertions(+), 39 deletions(-)


---
base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
change-id: 20261106-pks-gitlab-ci-speedups-09c3841eb178

