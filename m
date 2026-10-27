Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089119;
	b=SlrzxfI2t+JrPI7o6KzuN/YkXr1deW6PB478HsayxVz96WvaYviqyLI0+uEUABm+kcES
	 TLfovd+7OL8xU+m6u2VSR6r4z+0wWwmt74ER9IVV1r6Kv7KKbIkNIq+GIEvnuUxQuI6lA
	 KvZKuom1ozGmjLEOILPS2HfYAm0sR/CQRLeQQiVl2MEDqrgLQygLrfpGsU2MlwC8PYqVH
	 92cwm0z0XJ0bDdF7m0+NzeV0v09oPHakBMUyRXRkb0Tl/0IttCt6NwnqFU1fWeWf0xPRr
	 +TG4xH3JWGpNhyihVATWhZKuNJLWUGuZiM5vosHhfg6miRPK1r8Y3fgAJc6lDVjDj/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089119;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=NvO5hskVTPlvDWc9I7qN64QPaglSLnCro4XlhzRwWd4=;
	b=Rjs+hoX4U6yj4AjzHiyhJdR7srKCu6AeDNEPTbXNf46h0tnx8BpaAFm5V34fFPVJaQzO
	 +dadjHDl1RiOkTRADGEwEyd3rK/iM3+LsU4xuBvlGdc/uOX40xQBLKSS3piFbhFdhEIDb
	 C7i/qVRB8mhbKPHf0xERodgpc0mV448bSoqOuzFcq5Vuh8aw+mHx1f7W4wT/rWrvYmaoj
	 qR63cBqlm/3PbYZzMJQpUGd3SqRT0ORUJleuYUWR7IJYhrha0fPg1ZeXqwgIX48rmeiO9
	 iBoAmKGScMe7eAvFLlunPAHTfvE0PO3ZV7Wg0dWwK1T3vXC8qEi3XiLjP11CgCZrIMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=CCPPUEhH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mFO3iwAv;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE3606A33F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62CE3606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=CCPPUEhH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mFO3iwAv
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF0BA7A010D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:18:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 04:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793089118;
	 x=1793175518; bh=NvO5hskVTPlvDWc9I7qN64QPaglSLnCro4XlhzRwWd4=; b=
	CCPPUEhH1GDc2VdRzTrILooJ3p5K9jsjHER27FyZL8+cM7KmMqN46PB/wqXC7Iiw
	GsUzPJjjspxVT5ushbtffwT3MK/bjWm6NrtCtYtWTjFsd1VLscWbuAX0X3mkgCNT
	Hz0t00cdoWvmSgUmbGErmC1lh+orpp5mj0SxYnK2e2hfE0gT+ZrhNBpWs+yoz/Kz
	hijLGNbhAJ9eOmQ2k22MfHjh4eu+bZyVDfUw9f67YJA0P6CDiewbslQaLXe1BJj9
	aK+q/s2bljo4u6F6Iu2lZ4gUIgNZaAKYbZiZ38ZsUtqLtX3ulh86ZZn5gRT8BfB7
	1j8SvOgBAenpLcx+oCba5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793089118; x=
	1793175518; bh=NvO5hskVTPlvDWc9I7qN64QPaglSLnCro4XlhzRwWd4=; b=m
	FO3iwAv6LwkWDSqdlQ59ZTkctKba9s43/xOFE81UNnEMi+7zR5smHlnTqOtL8t7e
	8v4ZmpCggcmWGW4M+HpreTuUppX6u9m99heRNlcQftGoKMLi9LEAd1GjBeZ1hAHE
	G9nWuhaQ6IBF/i80heck2u63efqEAxLiWADhZxOUhzwEDwemrZje5tgfL8dFmhod
	1GkURFaSN/RMTqUvICIixSdDmNqbgzuz+as+Mckl9/km9WzLsccZzmBrz/A26g2y
	EDWOW78cGMQbkI0fSk62lCd5gKcTl/Tx2ay5i4Apqsne2pxIo72QoOIj1MqnX/sQ
	qtlpUNUqL15jrSMu58ehg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793089118; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:s7kdPGq2ueX1qF2d1z5HafZJ6H34ur4j0sWAjmByRZ9lrLU
	yyWuI0YJp3DmEn+IYT5ZiDtKAsq9ej1OYDr0Kx5yd+eHw8/T5ydDR5S3Z/jy4DYk
	SM8IvmA7ANrEQ14AgzQ0BJk48378ItVDey/WhYbg8Xt46rvb4EN0ux7PDvv6yPFs
	AYeARn0ooyojFuN/2ls14K0HwncGJZ65Jg7k+zHoef8lPJcbnYs7ZuwXD6xmpncG
	gEMRUadBVzwZdcYAC8BrDYkJTTreRoJGz8jfhYOSj1HsE8G9hZu1EJ+ONwHSm+s+
	UyAWLWUY/GMLjBw+iBS2g1tgFNx8l0T/Xwn8INw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AHv/5QQAnxew2fz+qZ/n1EcpuQzUba8r0D85HUwE5Xc=:asCaEVXKDiKtJwlQBQrtqEm1i8/4h/ChKXffdRATWUs=;
X-ME-Sender: <xms:Xl7gar59ueKaOcOGgsNeTFUXaSgazxeoeY2WKIm7BqsBUtzVMOzO-g>
    <xme:Xl7gan7-SUISTJlzsjtbqjBEy_Z4DAF__nwIzwPiXRzejGmkvgBT0WaeCfEJU3QS-
    tcfiWRPwIJs686D8flot4CFKnIlatcVAIXL_HCCIwhSNCvW2eI-_0s>
X-ME-Received: <xmr:Xl7ganedOALz9cUMo2S6X4Q3RNL-AMJN9chHbRuFmaWtH6SGfjPJRg>
X-ME-Proxy-Cause: dmFkZTFvnNThaj7W2ml+SME58w6EbW+Z6x9HaO7pyOkpaGFHapJ12h2oTgPic5xAknzFMg
    +Ga32InD3bjKh7HY+BQhDHdeByj6ugh25wsj35UtsyEcrlQGqFrLluKDskIv0iHTpC8Le7
    0+lF0/sTzTInUhHl6hmdjJxvM+ZcRxVi9E8EFoGODDdnM6v/DFLjd/qVaxh8DbgiuhWC6y
    lLCw+C8JmgjZVMKYPWVn6EgdYSoXdCLXcvir7i8Wj0fi/brRfvRQrGcHYtClgIDs4LHTug
    DynjEcscxVqVNMLrCiWF1f5JUJySdpiDsERwL15LjFK8uxInRjknLinYWhDy0PJzQ8VUHB
    wHjFF1masKCly/hetzow0lvC54apeoFTipJ5ZG/nQketIgc1A3QrdXp110EjXUJ1V4bWzV
    ngy7z4h3dkF4pPa6gbeEu3biep4+/EERcM6EFRsF8dmYmVrmdFXhZGPfn0MjPi/BMdPS+V
    b+7V+j1mXChaHed5iPWARfBgCcBOYgiQuap1aBQ+UNVUKFn44XSl2zMfqmkIXwgZfJGjgg
    RaRUrLQVTqauUvRF+eAf1/+efA6pXwr1fj7DVVkFEMTFd7Bw7WjBD34U1nCWMBWj+NiNXn
    MpYlJhvs5Ko6MxL4MS341/FzWuC/M4eDzFqeaOWQWez4/uzb+UQUDqwDRwUA
X-ME-Proxy: <xmx:Xl7garADaASjrnwbttNh07kGr1YX8LHhCKWyayrw27bYMw2MbUdULg>
    <xmx:Xl7gaq_nGgddnsv65dq2xwMtluyZG0ZTn2MF0_PQO1so389oOIQzMQ>
    <xmx:Xl7gamIthtiVJ8dSH6FhPA84mAtEgJGsb8GebG56tpxR5fHLktKlLw>
    <xmx:Xl7gajhyKhgi6wKM5EA7l2WuWoE-FS0MliU-lWbWfjW8JxVP8zTI5w>
    <xmx:Xl7galbPJ6G8xkJAh7TVTvjKttla7C0BFNxj7Znyun1p8InachGMBGxP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:18:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97ef00a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 08:18:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 09:18:22 +0100
Subject: [PATCH 2/8] ci/lib: always set GIT_TEST_USE_SET_E on Linux jobs
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
Message-Id: <20261027-b4-pks-ci-test-vars-consolidation-v1-2-f28edf79bd6c@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

The GIT_TEST_USE_SET_E test variable determines whether we run our test
suite with `set -e` enabled or not. This works on all of our supported
Linux distributions, but it doesn't work on macOS because the version of
Bash used there is rather old and thus has some differences in
behaviour.

We currently set that variable for a bunch of distros explicitly, which
is tedious to keep up-to-date. For example, our "linux32" job does not
enable the test variable even though it could. Adapt the script to
instead set it on any Linux distribution.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index d0bd8113d35..560d785f67c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -367,6 +367,12 @@ esac
 CUSTOM_PATH="${CUSTOM_PATH:-$HOME/path}"
 export PATH="$CUSTOM_PATH:$PATH"
 
+case "$CI_OS_NAME" in
+linux)
+	export GIT_TEST_USE_SET_E=yes
+	;;
+esac
+
 case "$jobname" in
 linux32)
 	CC=gcc
@@ -397,10 +403,6 @@ esac
 case "$jobname" in
 linux-musl-meson)
 	MESONFLAGS="$MESONFLAGS -Drust=disabled"
-	export GIT_TEST_USE_SET_E=yes
-	;;
-almalinux-*|debian-*|fedora-*|linux-*)
-	export GIT_TEST_USE_SET_E=yes
 	;;
 esac
 

-- 
2.56.0.341.g393f52fd96.dirty

