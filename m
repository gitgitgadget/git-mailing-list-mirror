Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618299;
	b=Ldqj524xn1sgI7TEhRFzWJLth6ehVHBH7dGAozi55u2XeAJY7DBnpF1tVIJss/SJ31yu
	 s3P3MqLVcNhj7CcwysQxaq3dFOL0MGkYgbTAig1D9Y2uJ9lpwhsfC4GLi7s287dQrgX9Z
	 m7TTp5jps/oJb+QUzu+OvuCyl41Os7d6ju5pXjSYVgWmu9p9JLBXU2kXyO1ul1DwDXzNF
	 NQalvF/N/20bDFSiRUkBlmK8PJmoXllMiCLZOA/Wbge0M1o2HvJ1ZCGPc52Yx06L6sp5+
	 5N+IVRP47jxMwP+FtuevTYLHLwjQAc29WpmnpZnPxgK47ndNsSkNa5pVSS5R1DsM3lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618299;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=JqdCo033d5nPNzykW3ykjFK19YxctEFeXWFiCnE6Qgs=;
	b=xP9TcKTLJhR3tVcPZACdWDJwUpUgnG/Ku0sAT+NDg4IPorQsjsqOYfqQ4qvxlT1toBBQ
	 2BGFjRxBZsjK4TB51gssdtzgnzsz64ayq/l5wPEEJppIdVrmob1Bca50lKHajZvjm1dt2
	 NS5SOW4ixEs+x7oluceVWn3AYrSz/6kjQthhChMoUBdzA+ETJnjJnHUV02wyjhqOKDdU6
	 cKtLQZclisr/um5AfJnJuWUwrCsg3SqZPEVhdrSXrutMkEZZdNieGCcF8A+A5kQeAf3+g
	 ukKAhf+Hc9k1NkQ7dI62mEf5Dxvz5c8kYT28ZmlVUEr0u5eLSGMjqFSIlZN18ibXx9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=QjvvYpZO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mFd8mHmR;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A860A2633
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B9A860A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=QjvvYpZO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mFd8mHmR
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9A2B7A0106
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:18:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 06:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618298;
	 x=1793704698; bh=JqdCo033d5nPNzykW3ykjFK19YxctEFeXWFiCnE6Qgs=; b=
	QjvvYpZOEwXDH6dg1/5WSjssRDE/Bh8kzseXN9+tECExJl7Y+1Br8657Byry+df6
	Tr2pKLAVNuTOH9UL1r6pd9xqcXZ4qAr1ozKOJ8VWeP8FVK/RR7rXq0Do1Kpp3+N9
	UEcafOCOryZzgcEGj35Odc84H6uvtlpoxMWC0JIeCxXUv7Dw077dR+31vLNQg0f3
	zjPoECAuK4NvatflfIss++pWBcrSbVsKgc0MXTw3gbSKhqYpvp8WslS618VkjcAL
	ElyVTbbLxu7/cWfqkfz/ehr3whl9OrVTzuX8jirh/qH15dOWlkGY+esJmQ8O9XzG
	0naL/Iyoke68ui42TmC7DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618298; x=
	1793704698; bh=JqdCo033d5nPNzykW3ykjFK19YxctEFeXWFiCnE6Qgs=; b=m
	Fd8mHmR0bEnC18dadbQcCxFgFRN7YBMHeG6h+NKPCrN6yXbm/2a9UkPEZvqhQCum
	BEchil8ZQXKnBhRrSh/p6S1PCDnoWzSd5BsUUXvsmGbmrks0XOY6kTysZxa21YYE
	pG70KYKiKRciYWG+2CXlHOMp3EysQ+ts657Kls+CJHFqOU2zOMwEq5xB66LJZOI+
	PDRE7oZOdzVsta+0dCy5cYkIgjblYTN8Yr7RNWDnveOKyIvqEVEim/EiAVbqderQ
	yQ7H7n29a1nNsKz2B97APJ1Zue+ZGjqI3AccbDeiAsrH87bLkmhPnuxv0vbAyzWs
	K649/xkj3lzkPzZicD7Ow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618298; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WFYOYnVQdyHvDVlr5PYEx57X3k8rg+I+4/ZBeD9lQMrOaXf
	3nb2bs6xalo+t4aTHkH67dpk11wIVqIKHn8gxjYrVgWo33uK9wtaLDr5rz/yNE8d
	Y0SUlYOV5XMRs3cI7h5odAPjazQWyTZeitQqtSuhDizx+mBeseOKxtSVHH9iKPk9
	JFnTGuC8+0KnamjnXqtvx+iMZ1/pOS6Nk3zHIt7yv8weNId4Re9dWXs2C1mSzo4u
	Kctkvn3Kh2uXvIZOpikiIB6MnmI/7DBakGzj6N5QGouL88oyJCGYFtWFUKHMX+98
	gadSv6QLmChxGwvZdqhwgQy6vR65vkWpQ2DRKIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SySM9TmAPxaDGxnAmsj2NNmvGo2Iw3mSlrDud28ae4o=:20Fh0E+JU6nktv1pG2nqm+6Wc5hJITYzU7sU0NJhrBU=;
X-ME-Sender: <xms:enHoasi7Pd8bedto2NLTg-6pdFQyBGTe_K9hHG75IQHl5Vp7MQGY9w>
    <xme:enHoauUTTPQQC3kbu12C9PWaV0_KIcni-mkVQse8q2r0RRLdnv-MVh_0kTPfQOZwx
    RymA1X8f6tLzHpKzejksh4igsBvvSJpvT61r7Mx-fsM2UbGv4gkE3U>
X-ME-Received: <xmr:enHoarUF1rHBGSRZWRRwrFvGgUdYtrxO2xtwT-cRt6JnIdwCfOBqVoJ5l8fv-O4tR3u1zg>
X-ME-Proxy-Cause: dmFkZTEATS24BxyVuB0+FbeUnBup8meosqAOJ4GjAF7LFyDgOsoC3kJI+E8c+Ujebjnm/t
    6ouWAzeScIEIhsaPmTZ9442YEpfJxqAAOsdh2bId8JD+vJhJV1upeqNtsw1SXASCI3MZRy
    Se5uVjfLVMKoz/wZRBAWwRr4RaTkWm8zvy9eJvJSVHt77E8EIlWQNzsXNiKDJ/7Qlqr2PT
    Vtz+A98cUVaKK+uEs7jORGKzRZ65EQhvP3zApwfwF/mjZq3wWJ3VVPS4zoHoIi83RSD5uO
    fQahJKzXpo1kW5hrNYfMToQo+bGhM4np787RQvG3CojOILczWsHa8kXNXTiKTC25r33FVg
    oZupdxJOgL9jo1BQ+klQxsF2ET7mwRefiKqjwAh75vC1suZf+azhtD18yzAThnJM6yLU2L
    XtvrY68VcBjbS5zVuUzLKIqIxSWiL6qK45vuQKzA9xsz99IWe+lNnJL8UT8tm5WFU5MlXn
    LgMdlx64bMPQhOfGPa+rqk0BVJcnqo6/cCESlvvtfOOJwcUtIkXDeux1gqg+RFCkI2Q4T6
    UwdDlXVZrU9W8jeFcSkQoOShBv06TGhBbqNvheDf2ae9yjNH+s7fIM3GDeUM76iMCeAo8i
    l3BVzx88wSibXFcWsDPypBEX1g1ofvVr1uL2yTugLC0MaY4DrjgjmSHVuZOA
X-ME-Proxy: <xmx:enHoaugqTcnXwYSfDWI9WTtXJbSQnREjthcNbuzHbrvb8ilLhdjv9w>
    <xmx:enHoamYrUNb44kkXL79E8Hz31Q_tmRsal6l9MRo58GoAXHHCaNT53Q>
    <xmx:enHoaroi9rt3_dPQnggQ1F1z6b4-Lv4i2Di7mPTqOZMAM3IoKM7w0w>
    <xmx:enHoajPBu2WDpFwmcutRpaQPSY1mL7_B-f6g4JkN1NcnNxoaD8Niqg>
    <xmx:enHoauPzUKQxLK_y6PyHTCJB_UMm6XmeByin6friIxxdgTo5EBvx-AMx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:18:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aa0f7469 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:18:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:17:55 +0100
Subject: [PATCH v2 7/7] ci: don't override initial branch name in testbed
 job
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
Message-Id: <20261102-b4-pks-ci-test-vars-consolidation-v2-7-a5485c437c62@pks.im>
References: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
In-Reply-To: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

The testbed job overrides GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME to
"master". This is rather pointless nowadays though, as we already
configure the initial branch name to either "main" or "master" depending
on the "WITH_BREAKING_CHANGES" toggle.

Drop this override.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 82bc169ed7a..fbb13ca6c6a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -406,7 +406,6 @@ linux-feature-testbed)
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1

-- 
2.56.0.500.g5d06dc02cd.dirty

