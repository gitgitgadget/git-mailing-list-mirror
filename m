Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618289;
	b=ihcg3KRa13U0hJEKCcZkQh57IScOlJEw5IMkRa9fXcP053zrCaqS1WeEbHllWU0SXeec
	 0vFqig/yB+y/0PFOhh4c3d4mp/7PJW2X6i4V7S7NCoBVmzn/0gVWmCeDE3xfk7Hq8WFpm
	 XYq5CQ/sgEBAShiTSm7UYejeCgVxpEA+Kl8drq/X27EBS5Cml/KfzN22YEaqUkuMuNfcr
	 nS2OjwL91pacLgu09+It/SfzInGzBmT4CWo4KOiUJSakRBzDSV4bo9THPf5ZpSUca1xFI
	 v2Zg93Cf1CGKwZZTzNqTeSV54J9FDX4aPSx/4a6Szgkp+Il7rGw+0ezUZFhXkOAuUMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618289;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=xuT92x34Gn47BL7a2q2Y7z29DF0qHj/87ZL+bt2tsG4=;
	b=FwiLOYBOpNPjGtSiHFJtmjUuy+dnbJAYWfAqh0xvvQgjpRgmDyRHd0KJzSKNpXbG9+ih
	 38FW3v1ljUndEBSkph8YHipWyP2v301Jz5FF1NkvQBbHpa2zspoeDagf3UBdaytimRaik
	 VllJLtqyYv7viqlb3fOpdnfVI+RsI/h7C8Whj47AAirhSpSY353T/a+C/+4FR+uU/Zv+5
	 U1u9siKIrl6dulUmiHDXAgSsk4RDtpVBHS31YKBtq2C+whzdk42UJ8FacRFYXhQYzeiB0
	 jOHNKKtlhe4WyibpfoVi0wvteO0DxRfj6M1KxNmJ8TjoF1f0QcqMElNu84gpbj1YZww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Tn21W5RU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H81VtM64;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231960A260B
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B231960A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Tn21W5RU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H81VtM64
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 15F891D00230
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:18:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 06:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618287;
	 x=1793704687; bh=xuT92x34Gn47BL7a2q2Y7z29DF0qHj/87ZL+bt2tsG4=; b=
	Tn21W5RUp2snt/+fx8tAUazLBwmi432FYq25NFTMWtkB7tuHjiNoyQMSGyj10bbh
	GM1Ikt3fCOAijPEk8JaZcqgKYi3+Y5SKQ1fAoyPB3MSuKQd3gTIxh3IPfvwqmppe
	kOHTd5Sf6uLJ4oSVZ38o5tVRVtKyZ5WsGL+baFnKGQ8Z5pe5QHKDLm7wR0BGFUk/
	Okit46/rhevhekR9giTt73vYRwm1WfXLl7ZzibixNyqroHs0eJMZLe5o8uHjB96V
	9tJjyrFupGPMxJ3OgDwhef8vv51/ydHRnon1+A/nRjixeKvCm14n7KtqUzWaqzC+
	FfHrZNnvNx7+T74uAIcf+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618287; x=
	1793704687; bh=xuT92x34Gn47BL7a2q2Y7z29DF0qHj/87ZL+bt2tsG4=; b=H
	81VtM64G2LQU/ESe+VjXjExZdnk5El25dO3HLc7eUtgkpr8CyZZE2X6dPW6E9sfU
	+4J87PX4ZEOkIMfwXOQg8r0KUicPrZsUk542IawbHQBoJ3k0ne1Nz/1YJqnK09OB
	yib1nauVAcBvZd24mavkyx844OQI21NWJF+c7SbQug7u+B+aJt7GQgFzdzDvZGuT
	RSVtyzWOQlvSi2S3GdTySDUFffVxvp4P8GwhPZb/l5h9rGPBNXwrEdOgujEeRWmT
	vQE9GgK1GdebIgi4nJGskIBdciuM3uaL0eIYtVuRtNRXv6Q26DIHISYP1F27aRwi
	RknP3Yf0cSnsNAbnS/Ftw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618287; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:e+IZ6KtBLriXYZDawDPEudA0tsR84e9QH7cQV6TdODNeYUh
	TQQM1Y/w7PwuvJvesCZ0nzgYXs2Ud3Bq/+Eu9XSX0GZKYm7AixSKA4Lrz0eOUiIf
	GqTT2BiVog8jsVJ/Bli42WWK4d/blyM2FmuG5lQQ4nms8mp3vmXDCAViSLK9nuuX
	HPuqdRh7vqwymRqmve2E6xfZByazeo5Sfhg5hC5utfNVGXRUb/Q6i/jXklKr0Zww
	lw4A4xHNoRpzdG9vBlzKQehq/icZMRq6xbc+roWJx5ap7NKcGWDLcfEE2gNJbG6g
	OwbZRaXMrwV0/EtqwFWPX2QyrVOzPb6HWHWk3vQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1rhvQKSE+SVYydPGrHmAoX19hlurLyx0ZflSaXJkaKU=:/wv4NAhVwJOhhTNwO4/w7yGkNLc5m/5+xS/G1gqIcrM=;
X-ME-Sender: <xms:b3HoavKJQo9TolC1aafo3VuMfk0yEP5mSBIl5VC4QQKWAZwKRX65tQ>
    <xme:b3HoaseXSbI2_PQT37FlfZbKylaQfbJz9fcEJewi2UdfZJ7awPAWLGDC7CY1xPZw8
    XNxs6Yqlw6h6BaqMRK7gqo0PVcguhr2yU39kJkOJ_q4PNUhBjxe-O4>
X-ME-Received: <xmr:b3Hoau84nOsBNOXZSx1tbCrXeu29Xbw3oFUUyKfAjbdhjc2DARkCXZm1wFEycIvjK8IKQQ>
X-ME-Proxy-Cause: dmFkZTF12+2t4Z9koSmZvlQubftEYVYSTLjF6FDa/b5lzwZ/OeUtz3Mi28sLPjyep7zRIy
    kFktVOE5KllHBUEXuAS85S5C+9tayxXpnBfH3ytXghDVLuDcUUB/lgEeIKvcFG4siKnw6/
    GETiEruWZaNs3MLtAeeJAGKSCvtb6ksQD/P35ZuwrC83lcIxhr3tnfFn7olkOCyHNjh3GL
    zaVsdpd0KNNJ79WBTWlZM0PKjtrB/qPCFoowD6U+Me1GQsKSq1aXQteHuV2pGCdmZLHHkD
    E0Se4CoPDGiWpEva4s6pfOxv4i+BB3tRllln2CXfCDX9nEx9NY7URAM3b5dgTPmvpk4keF
    yv3SDeVx8Gu01trh0ZBKPpLwbhuHkFWwlL8K9Ls+7gjNQ2XkEwSgY6TAsLTedjPaCdN9fR
    ehyPwL7H4qstniuOR5I6lFL6pr6Ligg21botzOB3cNN/GM6hjHnUdG9W3aVI9z2aTzGUZU
    lBe2hmqVkpUz9SUcE20UqN6FtqswBtf5SO/MdTfP00Bdav9ojkCjhT/pEMIA2GPFeflWwT
    ypzXHGTrkZuo+v7ptTWQ+JH9J68rdHy9EhzFExSBPVE7K7yQyE5IrP13PRoJchR6XvmgrE
    vMUNP1E8/bNbyzwXyaeIAzR0ueiePkJDzvQOprJzwmGVS7WHFQBA6wsYKQNw
X-ME-Proxy: <xmx:b3HoapoWL_qpVkc43suKBhQSicGOlRXeBQh7ukS4Hwp6-T0Ec6Q7VQ>
    <xmx:b3HoajByW0TUfd7WnkxMZ5Rxq_a9BELBa1tj_RmpGukQP-8X8VRLsA>
    <xmx:b3HoarzClCY81GLt30tRG7qkEbfLLhLfL87XyeUaLDigSd8tDnqv9A>
    <xmx:b3Hoag2u34xjTmUPLkHJ5gDns9yE5lT3sm3bwZ9ep02829V6maJy5A>
    <xmx:b3Hoam3HYCvtfIqZl6BOg2-0gD0k5y9V0GA5iHK4NhbJhdPbfQUtkkuZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:18:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47beef9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:18:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:17:51 +0100
Subject: [PATCH v2 3/7] ci/lib: deduplicate test variables by pattern
 matching
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
Message-Id: <20261102-b4-pks-ci-test-vars-consolidation-v2-3-a5485c437c62@pks.im>
References: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
In-Reply-To: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

We have a couple of test variables that we set in multiple different
jobs. These jobs always have specific identifiers in their names and can
thus easily be told apart from the other jobs.

Use this fact to deduplicate the setup of those test variables by
pattern matching for those identifiers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 560d785f67c..de4b94d4d33 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -373,6 +373,25 @@ linux)
 	;;
 esac
 
+case "$jobname" in
+*breaking-changes*)
+	export WITH_BREAKING_CHANGES=YesPlease
+	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
+	;;
+esac
+
+case "$jobname" in
+*reftable*)
+	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+	;;
+esac
+
+case "$jobname" in
+*sha256*)
+	export GIT_TEST_DEFAULT_HASH=sha256
+	;;
+esac
+
 case "$jobname" in
 linux32)
 	CC=gcc
@@ -407,10 +426,6 @@ linux-musl-meson)
 esac
 
 case "$jobname" in
-fedora-breaking-changes-meson|linux-breaking-changes)
-	export WITH_BREAKING_CHANGES=YesPlease
-	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
-	;;
 linux-feature-testbed)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
 	export GIT_TEST_SPLIT_INDEX=yes
@@ -426,16 +441,6 @@ linux-feature-testbed)
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
 	;;
-linux-sha256)
-	export GIT_TEST_DEFAULT_HASH=sha256
-	;;
-linux-reftable-sha256)
-	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
-	export GIT_TEST_DEFAULT_HASH=sha256
-	;;
-linux-reftable-leaks|osx-reftable)
-	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
-	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"

-- 
2.56.0.500.g5d06dc02cd.dirty

