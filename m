Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3C384CC3
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258975; cv=none; b=LmJeRvJNtEenu6XCnOxfacVfSmJdmn/F7m/Wn0xjgW4ep9cr9sz4QCE7ihQjPav8CIMThgd5beTk3VjLzn1mJ5N5puoLF/Hi8Qae1QGp7Ejo5dnzGp8iD97Pf3HKN4NRq0iUDrm6k2AY+aRcSGZjqR9CL83iy8eTzwnT7mdVxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258975; c=relaxed/simple;
	bh=mCaIrC6ZOf4EVgbCzFrwQbDVfG42N8+ZegK63O1DK8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rS08/tLCD0MYRhTLHnySeCXGTqr6YKBNFhufW3evjg1t0+GQr0rpZs284y92oDLl9NMs1ehRApTCv0yxH81IQq5cD0rc6ULzgy75xj8wH+50HlcBpvAwq3Tlr9lhi517gvrMoVCHKECEnLLdzWv8Ox5TXn/Yx2t9Q5glNfIHfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=raSKqRlt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xnt69JiH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="raSKqRlt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xnt69JiH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7DB587A00BF;
	Thu, 24 Sep 2026 10:09:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 24 Sep 2026 10:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790258973;
	 x=1790345373; bh=1zv0p7WhNcFLi1bPzmubsW7gvbtfnbrG0AcDySqL1x8=; b=
	raSKqRltEnuphMI8kQfe+R1et0/GO+yQBxfqD4NII02TUTo/1s2ktFHG1FBDUjOo
	6pIh0zdN6HAJygcgOzelAz74+QhmTSlz/FKUroLB/QSD2G1oG29mvPtp2bdsC89t
	EVtAOoed5Ed8iuHFgQzmAzzd1ZwhVEPZlTxcACfAh06kwmvyP5LeRO2DxOoICNuJ
	4Mbm1xb5Le9qUzCVyyyopi0e6Vsmw8NHAo94MSKXb5MTpjPsPP9x9namFUjKhsDA
	1ozfLYvlCNW+n0Q5imaPNHbfI+FK8HSCOtyvtBrcT3HJ45Zve1XPwAUgjVsHmkQY
	0Ep159gIJ+qiu/RfA0fZ7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790258973; x=
	1790345373; bh=1zv0p7WhNcFLi1bPzmubsW7gvbtfnbrG0AcDySqL1x8=; b=X
	nt69JiHhG0vINszc133wQDnoy1V5dhyflfAxFCUf6+1kq5F91iUG3i6/dWTEn583
	l83Cmu8tAm0YQyz1fI2Kf81ajQaq2ikv0Drc50LnQMrKPSOqOEl1mG8PBw6104iM
	fT96WHEQfZjy54nx3Gjk53DbfXdsCcodTzsPznqv8suVtn97/Xt7JW6XTTV1nhV3
	aOhjvGGioDzS8gE6bDiibZOPxfeJWfIBYtgdnLD8MIHkxP/sk6X7O712D8KVG5nY
	NbdHgghPYVg8E4WZ8bzBxVWDMN5Ug6yGWsmskldvFn9ku4bGceUi4MA3/eSfy9lk
	4/8lK09B1Dn3nPp7Ro+XA==
X-ME-Sender: <xms:HS-1arCWJre3yY5Lk9tX3YDLzUZppfAi9-6mW1wEAInDboDABi6T7A>
    <xme:HS-1anjoowmYr9lTP9ydty2VPDiuTvL18gMZsNBSp6wAaolUYfogbgsUqtv4Z8ScQ
    z511QU3V1XYMG0pXlc47xG0Rqk6OEumeP1QIr8eJ88eDg_DRiZAnNw>
X-ME-Received: <xmr:HS-1akPBjvASiHOmTHT8tuboyrl9dWJJCucFz5D5hSsyeTvXVzgel5A8JffmHJw3Q8Fc188>
X-ME-Proxy-Cause: dmFkZTEpca4GAxuyEQ68p4J8wQCB6r99dyEsn8LkfomchsgxCypdSPrJSPSsjyluit9TvW
    Ue0M0irS9GLhhsZWeFZjj1euA3++H1PTkRlcWnVXqc6/uXBzjyo27JHH/SoGvLmpXfrUuz
    slJXo7vM31f77zUzZuL+cvE3NdXZStzTdL7Rm/50+9ERbFwdv85XmJ9nFSxXJZnAUDbWOY
    m2B2RBApLOnFcXjYl675qsdc6uxjT9TUAx1KHDyYu/5BwuVLMwXQfsBu76+Ap4bt8vAOQc
    rybYKK53VJDT1y7qNO5U+qYTM2WjN/SYDGxv2bv5pJ/gETISbmY/T6wYzCVqvv/efuwkAO
    d2QD2Ho5FY3iFNZHu9XZzR4bJxcZMVkpl8VJ/3mwcEyO9rO8nzmwBtqg3ZAsSoXr9CpNpA
    rsLHo4jhRg+1nknYijvUqf5PcsKjbU8XEleigYltwz/vi/VtqTyTrWGaGWHOljmV1rBZpg
    XtWZhTMHrUkM2+2L1CFLAFmkAWzYynDWDdUbopumA27eHGdtPKcoAZ5FomRd0u3HLQtA/t
    IQq2CzUry/ckA/W6O+NOO9yjiqVvTbGArCKF9+knqIiJRDaEZwQUVI/qtaYctMJxzf12Uu
    +vrr98P6RVDjqxS3PC5RTvwaKYrj7Tq52j6OEC4MP8biI7kZrAhSRE55Mwng
X-ME-Proxy: <xmx:HS-1ao7ECBrtadbmDRKcrcWRzuTzWG-7Pp8GIeEAb86LXbXS2pVBAA>
    <xmx:HS-1ai3CATecDYXUfmZ-VSQqQ6o7ZVEenG2w6gjaHB8RXxpLMlbKng>
    <xmx:HS-1apYGSKUHy8RG5bHoRKru-yHD7ICDhh1sK9XfsfJl5aBJcHXH2g>
    <xmx:HS-1aqBEchcN-wXqBopxYwRCCLL35cdfcHwrfT6ymoj-VAZZeGT-YQ>
    <xmx:HS-1avmkzUFoYkltmLXAhJ4IDBBYthIQr0KvMBGUc_3hEmYzJ2TyEibB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:09:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b4e7eb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:09:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 16:09:15 +0200
Subject: [PATCH 6/7] meson: update wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-meson-improvements-v1-6-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
In-Reply-To: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Our subproject wrappers are used on platforms that do not have the
respective dependencies available. Most importantly, this can be used on
Windows to have an almost-dependency-free build of Git.

Update these wrappers via `meson wrap update`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 subprojects/curl.wrap    | 19 ++++++++++---------
 subprojects/expat.wrap   | 21 +++++++++++----------
 subprojects/openssl.wrap | 23 +++++++++++------------
 subprojects/pcre2.wrap   | 24 +++++++++++-------------
 subprojects/zlib.wrap    | 21 +++++++++++----------
 5 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/subprojects/curl.wrap b/subprojects/curl.wrap
index f7e384b85c..d73b88b75e 100644
--- a/subprojects/curl.wrap
+++ b/subprojects/curl.wrap
@@ -1,13 +1,14 @@
 [wrap-file]
-directory = curl-8.10.1
-source_url = https://github.com/curl/curl/releases/download/curl-8_10_1/curl-8.10.1.tar.xz
-source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/curl_8.10.1-1/curl-8.10.1.tar.xz
-source_filename = curl-8.10.1.tar.xz
-source_hash = 73a4b0e99596a09fa5924a4fb7e4b995a85fda0d18a2c02ab9cf134bebce04ee
-patch_filename = curl_8.10.1-1_patch.zip
-patch_url = https://wrapdb.mesonbuild.com/v2/curl_8.10.1-1/get_patch
-patch_hash = 707c28f35fc9b0e8d68c0c2800712007612f922a31da9637ce706a2159f3ddd8
-wrapdb_version = 8.10.1-1
+directory = curl-8.12.1
+source_url = https://github.com/curl/curl/releases/download/curl-8_12_1/curl-8.12.1.tar.xz
+source_fallback_url = https://wrapdb.mesonbuild.com/v2/curl_8.12.1-2/get_source/curl-8.12.1.tar.xz
+source_filename = curl-8.12.1.tar.xz
+source_hash = 0341f1ed97a26c811abaebd37d62b833956792b7607ea3f15d001613c76de202
+patch_filename = curl_8.12.1-2_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/curl_8.12.1-2/get_patch
+patch_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/curl_8.12.1-2/curl_8.12.1-2_patch.zip
+patch_hash = bfd8886cc76ccfab52b1b0472e6c682cdf5374a4c30be2427326f2f495de4eba
+wrapdb_version = 8.12.1-2
 
 [provide]
 dependency_names = libcurl
diff --git a/subprojects/expat.wrap b/subprojects/expat.wrap
index 0e9292f97b..67c4ae872f 100644
--- a/subprojects/expat.wrap
+++ b/subprojects/expat.wrap
@@ -1,13 +1,14 @@
 [wrap-file]
-directory = expat-2.7.1
-source_url = https://github.com/libexpat/libexpat/releases/download/R_2_7_1/expat-2.7.1.tar.xz
-source_filename = expat-2.7.1.tar.bz2
-source_hash = 354552544b8f99012e5062f7d570ec77f14b412a3ff5c7d8d0dae62c0d217c30
-patch_filename = expat_2.7.1-1_patch.zip
-patch_url = https://wrapdb.mesonbuild.com/v2/expat_2.7.1-1/get_patch
-patch_hash = fe28cbbc427a7c9787d08b969ad54d19f59d8dd18294b4a18651cecfc789d4ef
-source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/expat_2.7.1-1/expat-2.7.1.tar.bz2
-wrapdb_version = 2.7.1-1
+directory = expat-2.8.4
+source_url = https://github.com/libexpat/libexpat/releases/download/R_2_8_4/expat-2.8.4.tar.xz
+source_filename = expat-2.8.4.tar.xz
+source_hash = 656ae1cc8da3b4ea513bb4e254f33e6243938084c0ec6239da873376b09985a7
+source_fallback_url = https://wrapdb.mesonbuild.com/v2/expat_2.8.4-1/get_source/expat-2.8.4.tar.xz
+patch_filename = expat_2.8.4-1_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/expat_2.8.4-1/get_patch
+patch_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/expat_2.8.4-1/expat_2.8.4-1_patch.zip
+patch_hash = 221c537a6cfd8d55ea2d41600ee7f32d8c0659cf6e41511e9e7a2f294b21cb92
+wrapdb_version = 2.8.4-1
 
 [provide]
-expat = expat_dep
+dependency_names = expat
diff --git a/subprojects/openssl.wrap b/subprojects/openssl.wrap
index 873d55106e..e775bb104f 100644
--- a/subprojects/openssl.wrap
+++ b/subprojects/openssl.wrap
@@ -1,15 +1,14 @@
 [wrap-file]
-directory = openssl-3.0.8
-source_url = https://www.openssl.org/source/openssl-3.0.8.tar.gz
-source_filename = openssl-3.0.8.tar.gz
-source_hash = 6c13d2bf38fdf31eac3ce2a347073673f5d63263398f1f69d0df4a41253e4b3e
-patch_filename = openssl_3.0.8-3_patch.zip
-patch_url = https://wrapdb.mesonbuild.com/v2/openssl_3.0.8-3/get_patch
-patch_hash = 300da189e106942347d61a4a4295aa2edbcf06184f8d13b4cee0bed9fb936963
-source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/openssl_3.0.8-3/openssl-3.0.8.tar.gz
-wrapdb_version = 3.0.8-3
+directory = openssl-3.0.10
+source_url = https://www.openssl.org/source/openssl-3.0.10.tar.gz
+source_filename = openssl-3.0.10.tar.gz
+source_hash = 1761d4f5b13a1028b9b6f3d4b8e17feb0cedc9370f6afe61d7193d2cdce83323
+source_fallback_url = https://wrapdb.mesonbuild.com/v2/openssl_3.0.10-1/get_source/openssl-3.0.10.tar.gz
+patch_filename = openssl_3.0.10-1_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/openssl_3.0.10-1/get_patch
+patch_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/openssl_3.0.10-1/openssl_3.0.10-1_patch.zip
+patch_hash = 2d142b7e3b1ac092cf67cb4891594c4a2d044aa92624c617a8dcbfe4f056d907
+wrapdb_version = 3.0.10-1
 
 [provide]
-libcrypto = libcrypto_dep
-libssl = libssl_dep
-openssl = openssl_dep
+dependency_names = libcrypto, libssl, openssl
diff --git a/subprojects/pcre2.wrap b/subprojects/pcre2.wrap
index f45c968e2f..a2ff6268dc 100644
--- a/subprojects/pcre2.wrap
+++ b/subprojects/pcre2.wrap
@@ -1,16 +1,14 @@
 [wrap-file]
-directory = pcre2-10.45
-source_url = https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.45/pcre2-10.45.tar.bz2
-source_filename = pcre2-10.45.tar.bz2
-source_hash = 21547f3516120c75597e5b30a992e27a592a31950b5140e7b8bfde3f192033c4
-patch_filename = pcre2_10.45-2_patch.zip
-patch_url = https://wrapdb.mesonbuild.com/v2/pcre2_10.45-2/get_patch
-patch_hash = 7c6f34b703708652a404f9dc2769c67658c437b6043573295fa3428a9b7a6807
-source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/pcre2_10.45-2/pcre2-10.45.tar.bz2
-wrapdb_version = 10.45-2
+directory = pcre2-10.48
+source_url = https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.48/pcre2-10.48.tar.bz2
+source_filename = pcre2-10.48.tar.bz2
+source_hash = b6c68fdf6f3ac31388b50aa89ff0fc49c00c987c16e7b5146491d12003f2c8ed
+source_fallback_url = https://wrapdb.mesonbuild.com/v2/pcre2_10.48-1/get_source/pcre2-10.48.tar.bz2
+patch_filename = pcre2_10.48-1_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/pcre2_10.48-1/get_patch
+patch_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/pcre2_10.48-1/pcre2_10.48-1_patch.zip
+patch_hash = fbcc964804a921b02ea78fc0ff1558d5999b224db8361087828e30012023525c
+wrapdb_version = 10.48-1
 
 [provide]
-libpcre2-8 = libpcre2_8
-libpcre2-16 = libpcre2_16
-libpcre2-32 = libpcre2_32
-libpcre2-posix = libpcre2_posix
+dependency_names = libpcre2-8, libpcre2-16, libpcre2-32, libpcre2-posix
diff --git a/subprojects/zlib.wrap b/subprojects/zlib.wrap
index aa14de1774..0626401ac2 100644
--- a/subprojects/zlib.wrap
+++ b/subprojects/zlib.wrap
@@ -1,13 +1,14 @@
 [wrap-file]
-directory = zlib-1.3.1
-source_url = http://zlib.net/fossils/zlib-1.3.1.tar.gz
-source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/zlib_1.3.1-1/zlib-1.3.1.tar.gz
-source_filename = zlib-1.3.1.tar.gz
-source_hash = 9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23
-patch_filename = zlib_1.3.1-1_patch.zip
-patch_url = https://wrapdb.mesonbuild.com/v2/zlib_1.3.1-1/get_patch
-patch_hash = e79b98eb24a75392009cec6f99ca5cdca9881ff20bfa174e8b8926d5c7a47095
-wrapdb_version = 1.3.1-1
+directory = zlib-1.3.2
+source_url = https://zlib.net/zlib-1.3.2.tar.xz
+source_fallback_url = https://wrapdb.mesonbuild.com/v2/zlib_1.3.2-1/get_source/zlib-1.3.2.tar.xz
+source_filename = zlib-1.3.2.tar.xz
+source_hash = d7a0654783a4da529d1bb793b7ad9c3318020af77667bcae35f95d0e42a792f3
+patch_filename = zlib_1.3.2-1_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/zlib_1.3.2-1/get_patch
+patch_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/zlib_1.3.2-1/zlib_1.3.2-1_patch.zip
+patch_hash = 5ae7a2e92f823df118cfb8c1b23d94e3117864392b3446581d669049b2fba6dd
+wrapdb_version = 1.3.2-1
 
 [provide]
-zlib = zlib_dep
+dependency_names = zlib

-- 
2.56.0.rc2.329.gd58861e689.dirty

