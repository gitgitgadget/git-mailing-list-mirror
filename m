Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BB1C07F3
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810357; cv=none; b=VnfSQR/6Lo8xzh0lVVeHt4ZZIE0BXlOb2uPwBdHumoW4mWOvfvg5NTz5gJOfZF/BAzkcz1HP1eE2ris1aRUM+Bz7hWzDhH3TbUpTjMdBMYec08rCaW7LUh51cHMIUn1pPj7zpTmc1ouvEuT3jnIZ5KqUJRYcaFGZ3AzyfjCHyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810357; c=relaxed/simple;
	bh=nhwYgWgWulXTD3/vhTyXKxcFtvPLb7T043qiyaNMkGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSiPvHRjx2pc7h1dbqY/Dl7pTMDymQmW6dDuAk+HDGC0IXzBYk796ViHhPr0kzh1IBZlK72/bNTlX4iguQHsUxIIG+CeMiJa3NnIhA6U2ZC8TKaYAv2+2sJ8Xg9m76gfu2990kERBcLufE/T664FHx1IB8OfR2quMNYrlE+/C4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A3YhqHZO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rHb+Bxtz; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A3YhqHZO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rHb+Bxtz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A312E1140141;
	Thu, 28 Nov 2024 11:12:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 28 Nov 2024 11:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810353;
	 x=1732896753; bh=wYtxHFNc1QeXGf5peLaXbxLtdq6RdFHSNt8DtFUA2sk=; b=
	A3YhqHZO7FZtEVjbgyQ5uK0A0bv1bV2eHOhu/na4/D+6fZeUlqP0Wr+vIR+8LrqJ
	h/z7RrGm8K3cc3g2s66v3kiChUzZRgeEYNKjOcJINlfCYjOUPJD+BYDTNqN+Rmpc
	RK1aXlPai4H6GX1E1OBskpPFTHBi7gZCY2obd+QcepB/YYY3U/ze/O5d13T8Wiw/
	YTt8ApPy07oYN3L3Y15K8IzLwWw3Aatbkv2GOl1tE1OrBG6qKZ2enJm1t5uXZay6
	HYRP9TAovY6BqTgy19TvLUWqQ+LIEdDtXOmH6us3SSQlOIZSFsTcM0agCeu8e1bK
	I2XmhcXO2UfFys14yLrwKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810353; x=
	1732896753; bh=wYtxHFNc1QeXGf5peLaXbxLtdq6RdFHSNt8DtFUA2sk=; b=r
	Hb+BxtzUFtPdGpQ+fdiIsYI7eUWEe1sDCXXchccz3cRXgHlXfxgZlN75D/yIoF6b
	oZ8L4zGD734CFNJ2S5U5blNbe6GSPaIrc5jBfAUv+St4ts0FHf/E2T+lLEWmgYEu
	miEbNaaaaUQB8WRTcJmFWuca7kphbg6XARH9vUZF2a8XuXUAXlGsWtA4yGDwjQ5L
	9kAe3u9E0ur71rpHFCL7RinJercsCI9Sm4P8rF5M51gRMqTkqq6erDBPCHM4x8Hg
	9VmEI6J/Y4cfrg2SMWbbQAlESrB7HpMwLQixp+De16akTaqGwsVYENcbeJ8RMGQC
	Xp+XLqszT/pOP8UZ3AmSQ==
X-ME-Sender: <xms:cZZIZy1yqAo2gxpkON046EFTVa2xwnxw6TqP5zwDpkEGS5CXnniBZg>
    <xme:cZZIZ1Env29myO5pG3QFlhW8QxfJyIpEHlsVYYUjJz4WZZ9Ov6EK6p-WBNZK2AmpK
    p0w5ic1o4y5m3XMcg>
X-ME-Received: <xmr:cZZIZ67bwsXtgPPwQLnIEB-NsvZI4_KC-fni4B-pGT78MKneYqkBrX8eijiaTxgg9MKvATaoQzWG0L9qxfX6eXMgNv1psQhMLPBiyWt39sTs_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtg
    hpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cZZIZz1JofIR9ECffBKYR4vxzCudZLGIbnQPpTrMvV-74-7pWM_CLw>
    <xmx:cZZIZ1HB-NxCOeozeewX2R-3z-EGTwb2QTm2OT-zM5X6CKMI6E731Q>
    <xmx:cZZIZ8-xK4ngCpoA_20F7mX6jNjelfdDwogafgfQrEcr7ZZ0foj_hQ>
    <xmx:cZZIZ6lAzIgILFOYu_Vjs-IDOed0cxB0dYywG91OOZJJKlnRsJ00vg>
    <xmx:cZZIZ0_W3Zun3sqC5X8QRj1TuYXEpDPTz43heVNW6CDqILDIzxe6SMDN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18c3d5ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:08 +0100
Subject: [PATCH v10 07/23] Makefile: consistently use PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-7-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

When injecting the Perl path into our scripts we sometimes use '@PERL@'
while we othertimes use '@PERL_PATH@'. Refactor the code use the latter
consistently, which makes it easier to reuse the same logic for multiple
scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            | 2 +-
 contrib/buildsystems/CMakeLists.txt | 2 +-
 git-instaweb.sh                     | 4 ++--
 git-request-pull.sh                 | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 1255d222c2dec9a034dee2621192bf97afe905ee..0e289d1dbcbfa48e4566fb3e6d4eedd87ae2d141 100644
--- a/Makefile
+++ b/Makefile
@@ -2554,7 +2554,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@USE_GETTEXT_SCHEME@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@GITWEBDIR@|$(gitwebdir_SQ)|g' \
-    -e 's|@PERL@|$(PERL_PATH_SQ)|g' \
+    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' \
     -e 's|@PAGER_ENV@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 865b3af9fb2c1e7bdc1e7cecd0f021ee460971dd..ecaae8965cd43d4a5a36201b8760296b52147dc2 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -846,7 +846,7 @@ foreach(script ${git_shell_scripts})
 	string(REPLACE "@NO_CURL@" "" content "${content}")
 	string(REPLACE "@USE_GETTEXT_SCHEME@" "" content "${content}")
 	string(REPLACE "# @BROKEN_PATH_FIX@" "" content "${content}")
-	string(REPLACE "@PERL@" "${PERL_PATH}" content "${content}")
+	string(REPLACE "@PERL_PATH@" "${PERL_PATH}" content "${content}")
 	string(REPLACE "@PAGER_ENV@" "LESS=FRX LV=-c" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
 endforeach()
diff --git a/git-instaweb.sh b/git-instaweb.sh
index c8efb1205a8e2a66a6aced840980978897e122bc..5ad50160bb035885d8c180bee3ebb0a8e9622abc 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2006 Eric Wong
 #
 
-PERL='@PERL@'
+PERL='@PERL_PATH@'
 OPTIONS_KEEPDASHDASH=
 OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
@@ -716,7 +716,7 @@ EOF
 
 gitweb_conf() {
 	cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
-#!@PERL@
+#!@PERL_PATH@
 our \$projectroot = "$(dirname "$fqgitdir")";
 our \$git_temp = "$fqgitdir/gitweb/tmp";
 our \$projects_list = \$projectroot;
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 10c88639e28c02650ffea3d4671afa9a9f0bb182..775ba8ea11aa0fce90ae9bfaea8eac5b8bc584a4 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -112,7 +112,7 @@ find_matching_ref='
 	}
 '
 
-set fnord $(git ls-remote "$url" | @PERL@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
+set fnord $(git ls-remote "$url" | @PERL_PATH@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
 remote_sha1=$2
 ref=$3
 

-- 
2.47.0.366.g5daf58cba8.dirty

