Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089124;
	b=gjURyG0D2tb+ij1Bvaxb41f/ZpSIOuEquEM02+L4h2WsRGV9P5RpPOZ9aoC/yuZrjc5I
	 gPEktPbpCJ8c/B7dLhLgUxnOh1c4dbt2ftLj9P/RHoHkVTBVyecCSiA/z8g5aa3NGcDyj
	 L22EWJ3Oui8+m2HZe1aNWRJqCpAx7/jWrubtbkB+R9PK/t3QLGZCdx0ELkRUNT0E5WKZZ
	 smfPT8n3ldvQuU4LXzzl0tTEFvVm3Jz3bRAiypGyF5Fq6CydTiIR71ebUVpOZyAuJbE/H
	 9uTn8gBHRiz+IBeHpqHRutYxz1eTRXLn/+Xjrp0yMTApVuzU3tEmfg3R+P3NlQFq59w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089124;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=a/Bq4oFeTYmG8Jyp/El/z0z1xvU/aXscXgCoNCEhABM=;
	b=h6EHzdR1xEj7TpLLsqaJg7GOfZRgYoHpL7O3tpYLltkx9GU5vAmXfLpbYZxI1H2n3qPN
	 Bfmb/R8n8+wJbX+ixC7k7jKbIE2GUxMznTksyjNaYfmTKktR3YYcZeCQlqcjFsWObrAOh
	 gQkPzB0BU3XP8CR7pX7ZblDnYZQ5uKwvCoQYI2sEHtNlHyP9taFC33uN82jqnE6Z0etJs
	 7UUynXOC9PO/ZkEePZ7K0pJO/LpIdaDd3s7td1BmtxmyUM4ubupW4NOLnyLGl10Kz5mc8
	 7rV7oxPoaVMU3RJW0TbOer7tcC9mi+5cI+I2566sTlqV/yazOaBsFbvyu40cFof2PvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=krKfm1ha;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H9BjF60C;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF7C60A2603
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF7C60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=krKfm1ha;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H9BjF60C
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C4247A00FF
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:18:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 04:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793089122;
	 x=1793175522; bh=a/Bq4oFeTYmG8Jyp/El/z0z1xvU/aXscXgCoNCEhABM=; b=
	krKfm1haRZy0flrRtXsdx4GFQy9mtWRlqhf58S1pvWpQA5IgHV2dw5D5i1J1sr3a
	PUBvoWlQIzLeM0xfsLFD/vYy+h43aFztK9SNaszZQi0OHTEy/zRPQ1MMku7C5LDd
	LFAn6BYkeBBGBuHlAtBQMPlcrZcmIwb1CBU3bN6R6a5cARYnSbJdpaTrKgAr9sjX
	ncX0b6Jwza555Z/lSXUD4K2o5hrz1uQHhFJAE2ot9n8xV72MMeHjh6j9y3ZAYMkx
	6CvK0JSFdpyo1Cx8FTbGrVvioEi8t59g/VZR4t/ubF6a1ZlCaMUajMCUir6Nz1EE
	GvBa3P4J4dJY6zprqrIaTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793089122; x=
	1793175522; bh=a/Bq4oFeTYmG8Jyp/El/z0z1xvU/aXscXgCoNCEhABM=; b=H
	9BjF60CgtrFM/xauPlfF7yz2NL16czv0e2ZODXNHBLZfuZ4q9Tfb2XfE46BKd6rm
	bDUiv0CXH0zYdkq2wt99Kn0nLf3rTZBgRrx9yPjnF3XgxDXU1KrGfzvGexzgZwq9
	+WmurcDa/34KmvPZSbTyXbyPnGQNQ7mrnB1kw8x5M9n6fpXv7RSTpgrmBa95hHj1
	h2zQ0EBOqYgakRJAW60r14h1wJICkV4z56zOfbwWfOUSBJD1mVVEXE8sOyRjwEa8
	XLhQ7Xl00z4NVA9slaz3mpnxe/5mqJDVciejpgx0cxhaVkBpQ+XW/rE/HVaQC2sk
	zflqCYEUGd55l2Fw6PgMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793089122; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LJSf8hASJ08jfYINhtAzx0vQyo5PWfbPkBc2gzaWst84lmQ
	kFii4A+64wv2dWtj78wm99guutBpPod5ObkGOdcT3Nxw+RU3HimbDwZcC227wt9V
	1fvpC8YNjNjZtYg+mPpmJgM6c9voSFhsxX6LsskmH3Ur8Twocoz3Pa4dKGNc9Lbw
	KrOA0D4+2z1E+UfA0vSTMQShHLER14qEw/J+jpK7ZRKIbmehjv92OtxV4cdEz1tM
	BtdtFgfznkmZO5IaiKmLOWjqwF5eUbvO1/1GanOUbJ/7mprUFZ2GpIBHsWtQgN6t
	DB6GhrYbKpyJWZfVpEccqdMR27kpUrg7vAX1GjQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HTMZ+ukR1FThf2yZcu5n4e64Fx+s9EwC3tP9dAHe4Qc=:DTPZU4Weg3Qq9WKcGY5C4gLgdsQn77HSSh3zDT+WEuI=;
X-ME-Sender: <xms:Yl7gauocyJ7-Jd7He7d8Pd5ZJ_oPv0UlE3G9s2mdJ1GYDBjsS3xRNA>
    <xme:Yl7gajpMFVyhYfrRxlHUF2WnbW6GaDW7N2JWbX9hXU1C-umt7jkdYRnTGvoPcVEl7
    rGdxiiiVS3yqQLbPK_WATwhikvy-iKujr4EuSiKxRlcRKMuj53CEFDg>
X-ME-Received: <xmr:Yl7gaoOe71Y6gaY7wGcDd2Go3PjewsYwRPGqXwEC1xP6ve-iokn49w>
X-ME-Proxy-Cause: dmFkZTEq3SE52VReB8d5MrBc2dk3/oVr4VYU+C+Z7Rb4579P2FIDCi9/C66Wsq8CYhWQeO
    iZRwydlNdwzSpVtiO9hqxp/xDBYzF4HE2N2k28t0BJoBiB57+SZRzm1wx995BOjIOeaG5m
    LTqLPe0mwmflfV0YKYEng3lVDDNyi6OCCRvg+Fn4/6TPOIH1zuQSXOJabO04C01m88xdRy
    iylU34a9yiLe4BgG92eJWYCI0DufCfhu7+i7D7YZrLFyfT08h5k7QgmS2ZKFAgj8/M0Kaa
    fLaKn4vtf4l0DoTfzC7KR9pLdRpSHIjfZsLeaThRow10OMC9EIjhOv938W+RzkTdw4wUPc
    0LujMB9JzRuulfViqD3BQq3drJbSvnF8mTsPCsAHG4uLKETLQ5mVAKGHMQiE6mHks5iRCm
    c90DfaiG5hFBaLRzLNOyc+jLxdA+hiXjGgv7aC6duGDlaTc0JZalZdubxDHnhFf7jNKuse
    qXCPVoI1r+zyCsXTb1bci1UeYvWAHne+SyK8pcGPzUzyUeJTJW27C1QgHZsegqZkHV5DPI
    sW7ch1hPordM+v6HGQb94nX6eIInVInyBblDHyS6+qojNSW7CAf2BjIa0OKf2rzVZ1PTml
    ildY1lM00TARySP252LFJAOPKI106xS3U0WLolxqH4h7iFcQOAFhVtWufs1A
X-ME-Proxy: <xmx:Yl7gasw9VOBJqODL_mKlKAhKxO0UCBlNV0-gbK5RQcOSLnukf2U7Yw>
    <xmx:Yl7gapvNtMA3HWsYSRi_QZ1Jfarh3w_xiTASYpyUUKKFxnKehdDtaA>
    <xmx:Yl7gat4aL8FbXYebL__V-T3PQQ_XAMy-mhwusg3QEnWFi0KDmfLlUQ>
    <xmx:Yl7gagT4xGNvYLr56e2UExq3l-NRvS3JSkm0X-G804XT0gwO3tpO7Q>
    <xmx:Yl7gauKMfqpGtjl7Ymw6oFJX-XEBHbBlw6Q13BgshkLRMZWMvFOMJp64>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:18:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21676adb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 08:18:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 09:18:24 +0100
Subject: [PATCH 4/8] ci/lib: merge switches for specific job names
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
Message-Id: <20261027-b4-pks-ci-test-vars-consolidation-v1-4-f28edf79bd6c@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

With the preceding consolidations of test variables we now pointlessly
have three switches over "$jobname". Merge them into a single switch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index de4b94d4d33..7f67a95cdcc 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -396,11 +396,26 @@ case "$jobname" in
 linux32)
 	CC=gcc
 	;;
+linux-feature-testbed)
+	export OPENSSL_SHA1_UNSAFE=YesPlease
+	export GIT_TEST_SPLIT_INDEX=yes
+	export GIT_TEST_FULL_IN_PACK_ARRAY=true
+	export GIT_TEST_OE_SIZE=10
+	export GIT_TEST_OE_DELTA_SIZE=5
+	export GIT_TEST_COMMIT_GRAPH=1
+	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
+	export GIT_TEST_MULTI_PACK_INDEX=1
+	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
+	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+	export GIT_TEST_NO_WRITE_REV_INDEX=1
+	export GIT_TEST_CHECKOUT_WORKERS=2
+	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
+	;;
 linux-meson)
 	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=libsecret,netrc"
 	;;
 linux-musl-meson)
-	MESONFLAGS="$MESONFLAGS -Dtest_utf8_locale=C.UTF-8"
+	MESONFLAGS="$MESONFLAGS -Dtest_utf8_locale=C.UTF-8 -Drust=disabled"
 	;;
 linux-leaks|linux-reftable-leaks)
 	export SANITIZE=leak
@@ -419,30 +434,6 @@ osx-meson)
 	;;
 esac
 
-case "$jobname" in
-linux-musl-meson)
-	MESONFLAGS="$MESONFLAGS -Drust=disabled"
-	;;
-esac
-
-case "$jobname" in
-linux-feature-testbed)
-	export OPENSSL_SHA1_UNSAFE=YesPlease
-	export GIT_TEST_SPLIT_INDEX=yes
-	export GIT_TEST_FULL_IN_PACK_ARRAY=true
-	export GIT_TEST_OE_SIZE=10
-	export GIT_TEST_OE_DELTA_SIZE=5
-	export GIT_TEST_COMMIT_GRAPH=1
-	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
-	export GIT_TEST_MULTI_PACK_INDEX=1
-	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
-	export GIT_TEST_NO_WRITE_REV_INDEX=1
-	export GIT_TEST_CHECKOUT_WORKERS=2
-	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
-	;;
-esac
-
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
 export TEST_CONTRIB_TOO=yes
 

-- 
2.56.0.341.g393f52fd96.dirty

