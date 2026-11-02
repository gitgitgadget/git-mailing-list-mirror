Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618290;
	b=J8v15v0I8yCD627qOvxE2S1K2n4xL5yE0HzXOWDbCzNfjZJ/qARufirhquahWR+p9xex
	 sBK7bHCTE1N5uHx7/RbDwsMcM9nozAA0GKOKX/O0t8I2LZbiHR6ww7ZjyzJk0sC71sh7F
	 DTYyXP4v7Iay1IEZtgScf/OrzgL+0FwHPCz5omGuU49vjH9kn25OqVx4TozcriVpoXw7n
	 +A6IUM/CYbRpVAjd2Kv7qBTtwks2Xrns4ukujvAzWcjRjBlRdD4r6QX02VBDqkQE8G8q6
	 3zs8UEHWq0BfD98ex3+mGfkX2IA3ruJDzmO8LKDFbzGbp3O9XKxbpYJTYF7sUxOMrSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618290;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=++4diej6/hGb12vA/kV84zuuOVFbQa72KBgGBRswyAw=;
	b=Z8QzELInGX3oaxh/l4IX/AJ7rR7TqxWAarKKwOs0XZO8niuKajBWsFTTlxAMQ/gG5VOi
	 +e0hpnY6AsnooSse38gXTirvv+JzXZcsGDie/7kpC3IYyy6tB5/9hjiqFleSsxH7RDxWX
	 Xg2fJoiwX0QiTw219WzNb2tNM7xlyehCPUudsn0CTufsdMUHv/zzk0OePHvb8yvVTTl0C
	 z0ZcA5cW9BhtrJrLkv8WkJ1qh5tJBsafDwXXI2CWICxLOR7ahEzEhONB3qirKM23fDua5
	 4+HiqljHk8vbac35Ny2yhOWZVCu0Muk9k3aeZI3G71xGS1J1iRiA/mpqzcAGdQTsytA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=G3CZqxbt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="PUP8Zks/";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8160A2619
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B8160A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=G3CZqxbt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PUP8Zks/
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D41F17A0165
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:18:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 06:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618289;
	 x=1793704689; bh=++4diej6/hGb12vA/kV84zuuOVFbQa72KBgGBRswyAw=; b=
	G3CZqxbts7sKON82yM4O7S2lVQQB5QsEVCJnsawOVe6kQO2P0OoQQtk8TAdjOJnT
	iA9IF9UVnkhBpE2nVytA9Fm/QptW68e7D+MjN1vDKmWFC0vczfP998G1xZ+i6VZm
	UGDymnQyV6saPz0wXDpprY5y6voqzN8vHBCrhbKndtBHKrWvzEQmg47Te4rTN4hY
	vk1HG/3ZUf1oxkG8eQ8oAq5eFtYnZtDXyEtGnS317iU1Ia8Me2RvEGosI6mqGFHW
	lr8O/t7dV+0Cy8hvdi9po95qlnZPDPTEswsuDJn9sEVKbnDCkWSYxh3JZMnLguAj
	lLEd6zWAcOeAVKTimoabAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618289; x=
	1793704689; bh=++4diej6/hGb12vA/kV84zuuOVFbQa72KBgGBRswyAw=; b=P
	UP8Zks/caejsQwOrLGZ7fRpeoas3yqthNPHxCep3qIuR2+jhjr/+kvJoLaWD06hZ
	xJ99K6s9UW2yvPpOIyaKpDafOEM7tP68iCSMmO0b+BbZbm8Y3DjTRw5rShgf1WPB
	I/L//YtMomIMQB9p5//oES3DRfu2SfJWocplHID92cp5AOtABMxGddaME+fvjNz4
	IOh/3NGbG0f76TLnSNZmCxRFqslH4kR9mSoru00/kKIPVZQHTx5FdHF2yk27nq2h
	FFOyLptQ7ajniTuQhrtVIhEVqH0z+V+rRqyhcBgUaWHNEY1Dk0wzZ1n574K0unPL
	CSIjn5oubJzNWuZ2QThNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618289; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mE9kcKkx+nynPYgeKIb45Mkd7/neM9cgmbdTe7eraiEDqYr
	/xFGoNNmk8OjhtbqJt4hsWuTeZRSo0TEHDovPCwNaig6gydJf9uF4W0OkB441HKx
	1EoKpoV+p+M1rUuubFhETJsW/AERbf8nNKKhLxyrjOx9po5E2K34SQhvXs9SUJfq
	IXsnTjGOQVxUKijEQWGvFuGbGlc/JKGy3ZvmPTTdG18JwQCs2S9BmA3VcTjiz9Gq
	QAUWWTM0/aus51Sc8uVPDiBKt6tC2vhObLLFdppQfyUgbsWAXlSuX8MsXEfmNbWM
	kVve8XJdWHwViYgw6KOW++1AlHDxmv0gywyEoZw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TwiRLYTtTjt3FCJo+GK8lfG2XLbSEd5gbwH/pL9BKXQ=:o2TReEQSUCRIIKVdTksLIoHl9a7evmeZhN5JAxqdKek=;
X-ME-Sender: <xms:cXHoaiDI54nscvg2ZN0V913mc-C97VjSfz3ts654BySaTKcVlSgsjg>
    <xme:cXHoal1l6hZQNgmB8oLEAWibpnfcceGrOA1r71jWrHTVD3ZC55nb0vT9rtkOtdlae
    IWOuL6rtZ28l3vlZK3K0HuUsUnLpsi8eT-O8yrqMr1GSwz7b9rewA0>
X-ME-Received: <xmr:cXHoas2FENecn-H6P53UlMQA2EJWF5vMgZb9zZpaDsEL99qKwWPVL3oDNebyEN-xCUMoow>
X-ME-Proxy-Cause: dmFkZTF12+2t4Z9koSmZvlQubftEYVYSTLjF6FDa/b5lzwZ/OeUtz3Mi28sLPjyep7zRIy
    kFktVOE5KllHBUEXuAS85S5C+9tayxXpnBfH3ytXghDVLuDcUUB/lgEeIKvcFG4siKnw6/
    GETiEruWZaNs3MLtAeeJAGKSCvtb6ksQD/P35ZuwrC83lcIxhr3tnfFn7olkOCyHNjh3GL
    zaVsdpd0KNNJ79WBTWlZM0PKjtrB/qPCFoowD6U+Me1GQsKSq1aXQteHuV2pGCdmZLHHkD
    E0Se4CoPDGiWpEva4s6pfOxv4i+BB3tRllln2CXfCDX9nEx9NY7URAM3b5dgTPmvpk4kas
    E8DwMVE4JD1zanVEzSVd++ZUNEj09C2BEQqoDGvbYUbKmUE9azdRiyFJGYV6BHvppuEb3L
    zU7oyJeash38BWMlNiOyjE6Q7nDG+aW5eNjIzHvKPzCSErcBBDi1x+zM4Suv54aUbzfxXO
    qyEgacZkILgfMqEN7cR5ry4lxG5ty/M4ep4aiL6a194a+SfnoNjG1vnN4KSrWcMqurrCeT
    garsLCCb/jsdk2vdVZZSIC7jV3E3pwct18wdHOFxhxtDbJySkRIGaRhABwgnLQjv38VPaL
    mYMw7CR5ce+DUJoxrZuhrlNRizPPCrutFhcOxXiLzgsH4N0CCNILBC08inYQ
X-ME-Proxy: <xmx:cXHoaiBFaxgvQsdtFmdvy8wY4qcyA1_CmzyW6sLl6suVaFfIO-nBVg>
    <xmx:cXHoaj6lT02j4nvChHXW7Iwhb6PIIZDY9r4AzGqxivFfMjSGHJoLpw>
    <xmx:cXHoarITVZGCBoYA00S-BeUxCMmzn4AXAfGJJ7Pw82qNqHFf8X3r6g>
    <xmx:cXHoassqR8CptLF1kT8oq4cXmIwZF5AR7eYf5EN0qLUgD7KHeX62zA>
    <xmx:cXHoaruarsHf3gX0XC9Vdc0jbTdN7GHrDqS2VBZsEHsAtXtoZBfeZSz8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:18:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b3645e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:18:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:17:52 +0100
Subject: [PATCH v2 4/7] ci/lib: merge switches for specific job names
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
Message-Id: <20261102-b4-pks-ci-test-vars-consolidation-v2-4-a5485c437c62@pks.im>
References: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
In-Reply-To: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
2.56.0.500.g5d06dc02cd.dirty

