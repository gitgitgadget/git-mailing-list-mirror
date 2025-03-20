Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59F22371F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463340; cv=none; b=rh1qrUtXWuSbNHkzYA89OfgIe8GK14qACZ/T1LlcSGXv9tJwhQeH5lsUmHCD8egUHvgBW0p4LGd5o1HMcxPJ/WFVCg/BUrJpshqLsDPKcOLrAOX53Cyi5JORuctYUcs9Fc7cZ7IXxWMIVFLc8Ne+WteDYfYcUZYMNWIIMlpqg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463340; c=relaxed/simple;
	bh=0QvGEqC1CcXw7qB+3oNkUJawQaEJu+9o4Wx89q7QTk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omUX5X7+IGYpWibnyYjCm7g3zu8BYZpZnM28luvY/Gwvp136c2Qo4c9GO/Ui/n53TKyunTpWQkZtXxjc8shm4LL1KJyfoWSA2QYL5eWSuS6gXByf6HhWcjh6+WkgWDb6JBqTjvuXhUCafVnXJG/44UMRRHTGhvJ69aX0sYsM6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HcE4bCov; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rVGPtWl0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HcE4bCov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rVGPtWl0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD580254017A;
	Thu, 20 Mar 2025 05:35:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 20 Mar 2025 05:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463337;
	 x=1742549737; bh=TxAb3XKVEc3uafQcc1aYp4YdbmPnHpNoCoLGnfZwU+s=; b=
	HcE4bCovSeuDSa8FLzscwN+WWUFxAQsE7MSqIEBfo0nn2pPlKbAEeBgvbz19D2X0
	pXeFJft927z0wPnclVuJrKxLheoMFdb+6Wcv3Avd10qhf3+pLc+G/ueLpMKB2KcF
	EdTL3a5QDzAoORYjnghCU3Rw/42fcQj6k+PhyVsZJBew6z6LiD9BnnbpfZ/30dG6
	LV+Mt2PVvpWL8GwbYEEl6UICaM+no+zAE0hYa+MtwTrzx0c4Rul3s7q4ya3RmO6c
	tf0M42k+y6ELEpdBeMad1XFRHkgdUmc/7onfo29GcK8e5daWz78CzbTtL4Mk9Zep
	yt6VJRpH2qs4GB34M4JBBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463337; x=
	1742549737; bh=TxAb3XKVEc3uafQcc1aYp4YdbmPnHpNoCoLGnfZwU+s=; b=r
	VGPtWl0dtEV34rSQ/MIc0TCw9n13oDbHZH/sSRKmMQ6kGbkkpPkiyFFJr2hQ8bUC
	iGkHBZSzI3U7jOzr1fE5b/aFsU++UHT0GuFJV0SqM4h3SwRdLg5DicnH0PzA4HfW
	lqfGlG7KpXA7S+EFcd4Hfuk6cBOrmJK+7qLPnv6CbvO3cU06wU5QK4uY/cSsXZnL
	6j/E5OzrtSvlfb7wo9fdTgFYDbAQByO1nsZaIWbPd6aqbtZroe58FX6/FYqA7Xwb
	QkhUgMPlsvdv9txsKZ1XcLZJWgfVbGrVXOGhrWlU7hO1oviUf2DyfNW5tNh3WFKH
	qW8F8HJwEdNgD68nZEuKg==
X-ME-Sender: <xms:aeHbZ0bR0ViGKiozapjK8iGbNuiWJj13amtQ5fH4U2sjHMFLer79aQ>
    <xme:aeHbZ_Ya2Tt_pDI5qiNXWxG7VWBVIAF4NAeHH5Xw0BgLOyZzK_gS_Hg4kePlc7uy8
    FWF1LlK0tSuc83eKw>
X-ME-Received: <xmr:aeHbZ-_W0a_cTxrIuVtMl8JwnQh_ZDkxvi9zeZzqfW_dxVloaXWc6WLAnS1V4QRZEr-HtmvKLKGO3QWoGkYL-tz6HFZQwGc-JmmmK-dwQ_ap-m0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:aeHbZ-qpqg54vFiaaviApYKqSPe7_iPAIuxMnWZZtRJCIpkng9HyZg>
    <xmx:aeHbZ_pYTl_Hvy_qeMoYfX0EBSBhvDVAFkGMq5NsMU129J0zMxy4pQ>
    <xmx:aeHbZ8Qaq0vV5xxRiPezi8OQbre5leEjYoKobs4wEPLz04LKUw39Lw>
    <xmx:aeHbZ_oONAl27LCtxy6s5YOJsPulTDnKoz0VSQRewpIcSBYWfrxvSQ>
    <xmx:aeHbZ23LSdE2W7YMb9KagH_2QFCj63D5ojSwEkdzZd-cF50uO--gQd2e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2be7c321 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:32 +0100
Subject: [PATCH 05/20] t: adapt `test_readlink()` to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-5-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The `test_readlink()` helper function reads a symbolic link and returns
the path it is pointing to. It is thus equivalent to the readlink(1)
utility, which isn't available on all supported platforms. As such, it
is implemented using Perl so that we can use it even on platforms where
the shell utility isn't available.

While using readlink(1) is not an option, what we can do is to implement
the logic ourselves in our test-tool. Do so, which allows a bunch of
tests to pass when Perl is not available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-path-utils.c | 13 +++++++++++++
 t/test-lib-functions.sh    |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 72ac8d1b1b0..54d9ba98c0e 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -323,6 +323,19 @@ int cmd__path_utils(int argc, const char **argv)
 		return 0;
 	}
 
+	if (argc >= 2 && !strcmp(argv[1], "readlink")) {
+		struct strbuf target = STRBUF_INIT;
+		while (argc > 2) {
+			if (strbuf_readlink(&target, argv[2], 0) < 0)
+				die_errno("cannot read link at '%s'", argv[2]);
+			puts(target.buf);
+			argc--;
+			argv++;
+		}
+		strbuf_release(&target);
+		return 0;
+	}
+
 	if (argc >= 2 && !strcmp(argv[1], "absolute_path")) {
 		while (argc > 2) {
 			puts(absolute_path(argv[2]));
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c4b4d3a4c7f..bff8c4d1b41 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1979,7 +1979,7 @@ test_remote_https_urls() {
 # Print the destination of symlink(s) provided as arguments. Basically
 # the same as the readlink command, but it's not available everywhere.
 test_readlink () {
-	perl -le 'print readlink($_) for @ARGV' "$@"
+	test-tool path-utils readlink "$@"
 }
 
 # Set mtime to a fixed "magic" timestamp in mid February 2009, before we

-- 
2.49.0.472.ge94155a9ec.dirty

