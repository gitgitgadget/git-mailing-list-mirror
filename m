Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0125FA31
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908485; cv=none; b=FNdNCs43y6GhLOM2yOoOWfWRQAsfmVDWhWQ38CywvZTK4n/v2brS/CcQfXEqlv+LyZ4zoHcLCdDN2fxqvkIYaeZbiKnenRckiCQei1vH6prwLomSLAsZAjZlYqb0uMTHv1SvHDAlCDMd6vkk6So0ZQn/Bmxn487wMZotYtWalns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908485; c=relaxed/simple;
	bh=VOGHVEB5DBeBsc1IOz0MKfPvuvyDiSI9QbAo+vfau2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zb/7Ylt58F9QYAoB0GtrC5acpQ3tYqNVwi13lTK0/GdOgv+iach9DZWxJn/zisMN0L5ZwemUdOMdp+500syUWLf1VakH2qahfhRwxiStinZ2JirDS+EXI/pfpqu1cnYYXrnvhPztUTmF6Zhb2kvShQR4J+Y7JL1Grjbob6R86EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QrTBSW9A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TIRMV217; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QrTBSW9A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TIRMV217"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54DAD1140275;
	Tue, 25 Mar 2025 09:14:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 09:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908483;
	 x=1742994883; bh=0JV8nY16uI93FpC8oc8O/Ba/p4JfeYQlUD8rsognpdk=; b=
	QrTBSW9AkkESv0Rp4Xqojdtny+7EOi/yQAu8sGnT8pABPgMs5/w73UAbj/7cXSke
	Lku+FSgoQADRQCO+EJrIfF8cWtojZ43j7R/XINHr2h2EJjxTPx8VB9S9zb/RzbeY
	8efyzsPtCdeSw6Y7Sk8q/LsJMH7RwqB4Ufrxx8XxMUhtjabi/kawXbVmW3SHy+Mv
	dK8vfAoz8RmFMltamXx/YMMoB8rVcxFSrywc6W/ceE9kuGxyD4zq5YsBLKo8NnAC
	Mk1ioJXsc8peYtfyojRP2VjgYpka8r3A1UP8owu98GjduiBH+TGRS4vwilFTFAG4
	Iznw6B6DqBV47+JGmSaZcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908483; x=
	1742994883; bh=0JV8nY16uI93FpC8oc8O/Ba/p4JfeYQlUD8rsognpdk=; b=T
	IRMV2176vsguj6e+EfVsFHsewSw7f6R3FUCsJWwRAbZttKZ6viinqruwFdKJze6O
	365fTH2Fr0f27vW1hV2y6vKh8+Al2tVNGgSf4m7w82Q0ZEfcoZwLFXhw9xnOQ0uT
	j94PjnOyGDBwYCronfwX81nsco+wJVpZ/Ri3ULkIFyz6LO6+xk0zsXEMWilXrkX4
	y1NH4a/6+KDCqa6QT1JPcbo7Ztf10deGU9j/K2PSKQav/uDsinMK5kVKfgAFpp6t
	G3P4Z7fLvhR3V6iXEKjgveXmj10E5N+9mCq1xoRSfHzNXNgcR5qfr/tGuVoZQs4L
	4aqcZY8PNMsnDeRorT3Xg==
X-ME-Sender: <xms:Q6ziZwdKMt5tH7pBkQyv3vkxR0fmO5pDsqtM0K1svX_Yp-5RyPxv5Q>
    <xme:Q6ziZyPrVWJIL6uyynRBY1e3n04LF_psQmzBmGNjLMP_LDOC5U2U_Z2QDzLpemI7i
    gozA1vcY2o2m6wvaw>
X-ME-Received: <xmr:Q6ziZxjoeiUN24_Zv_sQItbpb1M7kuefsUwX-49Dfa46D8uP6WK3a2RJUgHequm6YrLgYmlN4pshTVa21_ZmoiwghGJUZdXUn43rX2syIfDXgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:Q6ziZ1_O3Wyt5ZA7UEr6cEzCTeyaDXtxN62E6SZavSJK1NKiJtC8eQ>
    <xmx:Q6ziZ8v8sX8DXQ9-eG0S4P8-Uxl2jo_uEK9BijvZEMHbE1SXeIUr2w>
    <xmx:Q6ziZ8Gg8d09OzsDFo2qca9qLaUDK_VHMhUb1yK7G4k5ij0G3l22MQ>
    <xmx:Q6ziZ7Np2JhhMb_pX-r_-F35P35vOGGhL2r_B2kLAFU_5KTUER0kKw>
    <xmx:Q6ziZ2UhgfT3fAIEoyEd6BslPkLOQWsZidNpCopeJqNoqZ67XEWlq_mU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c05130c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:37 +0100
Subject: [PATCH v2 19/20] t5316: refactor `max_chain()` to not depend on
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-19-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `max_chain()` helper function is used to extract the maximum delta
chain of a packfile as printed by git-index-pack(1). The script uses
Perl to extract that data, but it can be trivially refactored to use
awk(1) instead.

Refactor the helper accordingly so that we can drop a couple of
PERL_TEST_HELPERS prerequisites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5316-pack-delta-depth.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index cd947b5a5ef..defaa06d650 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -76,18 +76,18 @@ test_expect_success 'create series of packs' '
 
 max_chain() {
 	git index-pack --verify-stat-only "$1" >output &&
-	perl -lne '
-	  BEGIN { $len = 0 }
-	  /chain length = (\d+)/ and $len = $1;
-	  END { print $len }
-	' output
+	awk '
+		BEGIN { len=0 }
+		/chain length = [0-9]+:/{ len=$4 }
+		END { print len }
+	' <output | tr -d ':'
 }
 
 # Note that this whole setup is pretty reliant on the current
 # packing heuristics. We double-check that our test case
 # actually produces a long chain. If it doesn't, it should be
 # adjusted (or scrapped if the heuristics have become too unreliable)
-test_expect_success PERL_TEST_HELPERS 'packing produces a long delta' '
+test_expect_success 'packing produces a long delta' '
 	# Use --window=0 to make sure we are seeing reused deltas,
 	# not computing a new long chain.
 	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
@@ -96,21 +96,21 @@ test_expect_success PERL_TEST_HELPERS 'packing produces a long delta' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS '--depth limits depth' '
+test_expect_success '--depth limits depth' '
 	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
 	echo 5 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS '--depth=0 disables deltas' '
+test_expect_success '--depth=0 disables deltas' '
 	pack=$(git pack-objects --all --depth=0 </dev/null pack) &&
 	echo 0 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS 'negative depth disables deltas' '
+test_expect_success 'negative depth disables deltas' '
 	pack=$(git pack-objects --all --depth=-1 </dev/null pack) &&
 	echo 0 >expect &&
 	max_chain pack-$pack.pack >actual &&

-- 
2.49.0.472.ge94155a9ec.dirty

