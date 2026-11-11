Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394101;
	b=clSIcUwOGh9regiggzxxJJC6rZYEhu1/zK7qYYumuOOt+lRyac9V4DIlBJo5ckW6mNPy
	 gUF3fZUmu9FeSRAwqw8akyXglE6gGz0vRnEQNAdg3S9lfCQRpnFaMYlfB9RHEq77EsGvj
	 HXSqplzaF494x+TerKbtE7mEu4AMO5yPLKd6tW8iroAjY6JOfaO4lAcsxGxLF0yzDn5nt
	 wqG2LJ8kP2BkZYDFtXCRT/SmCG5V7Oy2hAxs3WF4o2cJPxGuD3uVUTqPHVuxyKDZaQpiK
	 v8Np4nm3rbnX+6A3twSls4dqOP1bUtNA8TYM2oOzboc4TNyBg+LksTj/usgkslgWEZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394101;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=PRrkmKV6jk2DH20dY3DwSZMtUbjf4EUOK1AS2UG4flE=;
	b=IE6wWSE2fYRp6IZ6L/R+251HuN9ftj02RcpS+qVJOIYRq4o9Z4szGUhJsT/aCjWO/Ygc
	 VL4Y5hBawVeC8OoDP4ZZMeDQvk19x0fQDfrNaRMs2yNVQCG4iiNOyz2vqc2HV0ZL+ZUZa
	 Xapmty6FDyATEEv3qrgb86v1wrgjBDyyQXOaSshvHQ+o+1JRijbfWh1OiDaqfSlmwMgvf
	 UM8+tHgbrKiDqC6Hem851R4uG8Cmc+/5xDjGIapSSEGK0+zJio3PpbiT6c55u9htYU5yv
	 1hndtZ0MxNIKKLKKtp/ZDWlmpCXIajdzPdQ+aUqqtNGX/cFuSVFLrnj7ra0fsAr6+og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=l0aY+4K6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YNDW4tUC;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A957606A337
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A957606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=l0aY+4K6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YNDW4tUC
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C64581400137
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:48:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 11 Nov 2026 05:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794394100;
	 x=1794480500; bh=PRrkmKV6jk2DH20dY3DwSZMtUbjf4EUOK1AS2UG4flE=; b=
	l0aY+4K61PFfi1dGktEVEnMkR8BZR/HiMHIRADxP1dW6Gi2qChjJC5mJak0Yi8gE
	8+lsf8Ov40olg0fJ8TGg/vcBUYwGsbwA0gCDR2BDNKgfD4IM2VMMvI4KtVbjslOo
	q5Hi0SGa+DVk5MyVtVnIIy+HVm/DjyZX6YgI+XEPFSPIvjDOTHiW/uscPVaZBDN3
	8QGH6fADIkvn9Mq4nAxfysU0iRexmmvjhwGTv5tfyhqG0DWmfZ4SugcezHGIwf8V
	l5QP9d2V/TvHOgB8gAdVxogpbz0Iry6UG4BQ/JB5q4b90cRnguij0YzqHHikxiZc
	Z9D27eCdaT33mDpC1a3OcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794394100; x=
	1794480500; bh=PRrkmKV6jk2DH20dY3DwSZMtUbjf4EUOK1AS2UG4flE=; b=Y
	NDW4tUCx1R8OUk4aHcbOrxnY/aZgj/D+tO8e2omWOaTq2V7kMsdT8Ng4nKU6XHPD
	NC4FpJ/Y3nRrnmhZ2ZDmIqQWG9T2GFgrRWBzgjQ1IlxcHnWVp3tv/lU3VytEJiII
	gnq7k1Ob1UgJT8VIGtReVJy2eHfLajoUrnVaEjg5/s6VdWCLpoO/ACE47+lnDfJc
	gnbdULxAWmsm3sapoSLdmehra/F7jLLw5kudEBiqhsqkepkgwdlbgEsSTuNq2XFQ
	1Q22/JoEA+WrgO5iZ3Jb3Bmt02VYc34J1ofefoCyY9Dt4XBErZW5HI+MEVCHvMy+
	71II3hwY/RYt847fWVbjw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394100; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:iBWdeWs2HiZqZRwYik2TZgYY/8xqoM3CYDxplbj5ktcG6e/
	gHTTqZl1qbAdSi8f2N05W9qXw0GFrls5S2U+lvcZuQ06S1aSTy2BGqXeCS4M+gR0
	TFWlEBMKxLgYm9AHFFgaeu9nD8+ckZfgcBJs6BLBdrB9A2M7nmVCXM/gtS1bzmvX
	aJATxABRvFywu1TRby6NwW0To7ViddB2TLuGpiFRF9V3xyiSajno3kgChtyx4DUd
	8Q8xKQvYA3IGes3FiVzcbPTKPAJjsilS4fheM9DNndLbcr0pqYr0R9igTysrFs+G
	ia/RaX4fJjAwU1j8w6MnoH662q4gGHT9lKESaAQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:viaHVqjhAGTmyvC15NTulY1gm+cz1W1ibI7GWlkXFqI=:AcTWp/+FHNXh/cXux4Dqjyjswzl3U8ZaDjylWwViSXs=;
X-ME-Sender: <xms:9Ef0amsExV4uUCMJBbhMTv80ZQE3EV8FIzrXYnfdruIidg6rthsn9A>
    <xme:9Ef0aifErZsyBiY-Zglvb7ze3zYMYwZRVQB54_-OvZAgoaG740cplMGpM1l6DrRQt
    Mx_Ry5kkZty3zuzXOMRR5zIkeHkZBzcN6malYPITtmXMS2WDYibFv4R>
X-ME-Received: <xmr:9Ef0amycFXtW8cg9TjCALDAaTmRMqcCLZopaa3z8T-4aGyRDXG4wdR-gcNLcxZ8HvAcSVA>
X-ME-Proxy-Cause: dmFkZTGJqxeU1zzeeHuQ2998h0fqKcOdBMk3CFBfBM05R7PvQkfvLi1nV4ZDW9KitnaLn0
    a1/a/CeWyL+Ed08AfIXRxQMcn8ohtgZ+qXEEGaEi+NfVtqqDbXKWk5UsYCJl8p47Q18PE2
    MW1dJw86qpI7bXJlt3+8d74W46ZR7ccKdzcLroMV6Wk+c/65XySdsGHwBa5h6+nhf5UuJp
    4HeOzd1Zs8CAQN7Z5FiMeay1Lo86YDgtAAdKYHQ3nu8C5TdozLRObKB3vaW/lkeQZHqkMT
    y0HW7EOlbwhbXgC8aOEyFtOgQhfp+6BD5fnpAB3cNim6CfmAekAb2gu0pCbc3uViCGYOjF
    UbAZG7EiZMtbYC/ta4Qi/HfvkSPFvQ1tG5zwRqnPPDKyuF8t3fLqghBJD2qkbCX0akW+OP
    ZGE+RxSs0FrCFHq0JJgI0i2v0vtENIpM0YjFvEi81q1FzHguXM26J3yEBl9UiHP+vfdck2
    xcHva6ob8bHKWQpanxEK2yG0jRGyqcytn28v8nNiVXu+qUXbRojGboCNMZoXU0q/xJ0/DU
    mHX/zAgIfOWWB5g6XDkV5fnOjmj5nptCna7jXq/rIJvC6afOgQUOKfLnuJcowLTAsYsONL
    KSnQ/GMTvLEKibhEBdqnC6NH7UfbXmRsj+50iQIfdycljvlec70A33BZ4sxA
X-ME-Proxy: <xmx:9Ef0agGwbIfMKJfJmWVTv_7tNCyyxGFQX0m2fUF1sqB5Jwi5UHb1og>
    <xmx:9Ef0aiwMlRtdsvy5igmu6-ATJWB38zvvonUm8vmYlKocBBOCjo37zA>
    <xmx:9Ef0apsEjFYKkO6i1lmzJPrXQPefQiapMVfixa1ICeOTb4s4qnW_OQ>
    <xmx:9Ef0an1LkNZIwDH5gn7gar_D4h6kppr29n0KP8rkW4_P19sLYhZD3A>
    <xmx:9Ef0ahFZGkLej3S2IqOE_YtUMKVhH-TVGzoyX211JIet2rU3SyOmIgYC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:48:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 32c089d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:48:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 11:47:58 +0100
Subject: [PATCH v3 7/7] t5551: use reftables for repositories with many
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
Message-Id: <20261111-pks-gitlab-ci-speedups-v3-7-d1e34117ee2e@pks.im>
References: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
In-Reply-To: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
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

