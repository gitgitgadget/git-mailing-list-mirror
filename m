Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A91ACEDF
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656777; cv=none; b=NZWbrzcwjr2ZrTew3BEzx0ljQtlu5GsitxX8YOtPABnCAWtnJJzYBR1brKz87qcXIe19sTRWBVrE7sFw/45XJR2EuuRYmSZut9uB84X2tJG40g8C+VzGewfKB7vk5ouPkhNyEQJuqgx+NZRs0xfZSVHc/DtNpelKlXXzV9cbMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656777; c=relaxed/simple;
	bh=QNHPbBmbRFsRjoq95fie1sGs224vW1vH1WBrNkbHW+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPpHf05Ydm11ylDN9nTbIlad5rhJoupVwTCDwpbsAicvU7MSyaoKO6U5hBhgxAQRrMwBVfDg5Wb2HXHna3ZHhpBZq8EJcRr4dlFCOxN3QAVDDGDD6/PdHZT3F4pL6RmTacld2lwiOkXRu7T5hWX292A5t8atZJNPclzBzkkwZp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ncJEeVsG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cUbWm/r8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ncJEeVsG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUbWm/r8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A11D114019D;
	Thu,  3 Apr 2025 01:06:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 03 Apr 2025 01:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656775;
	 x=1743743175; bh=0zP3sRD6VmBqpdP+Y7HOCiDpxmxNt4mglcrsaGA1A7E=; b=
	ncJEeVsGBUe8m8P8VVFeoCKNb59lKvkDW4fmae2SGQPNvNLzT+Gu9Sinnm766VGA
	jGHBwVSs7PDiieaoCqmq2faRWki+6ddBB8Qruql+CBCxEEFrVB/hkLmoITuIlLxe
	Cu7SvGc9Ddfvf0n1+L+Hy2AEoflRmXD2NicYwxzuJim3bfxMTRkE6IZJjFOVIDUB
	Ga7V0RrcWQ7Ao3j5HXVMcuHe7yYz0nDSs8Mt4rvlfaA4hirQTe9seK+76sjq56po
	GGgtrD64O9Yiqa5VwPDTZVqyMALVsiKIiV4FcKAgYe9LpyisITOdkTsPi5IvMhuy
	s9w9M6184XtoYL14hV4tZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656775; x=
	1743743175; bh=0zP3sRD6VmBqpdP+Y7HOCiDpxmxNt4mglcrsaGA1A7E=; b=c
	UbWm/r8Rqc2iXqIzi4KmcnaLqJJnglTii0KOLTqJb69Z1+1rLeio9Zmmo75PHnSU
	ZIQsq8Kc5OkgjnJq+VQFdGV69u+vZtuzxzj4eRyBgxTMVPyvSXlCDtJd9D1uLQmo
	QfH71LQBu9gs4Ox6iVpvFq7Oi39HS2EGNydTyx/PWTjD9tdFUs4BDF1R/qyYTwxb
	tS/LcXBgCYxn80KlPqqUIqZWfmb0Uu7fA7srrZdLZVmJktct5Dy4rRXB1DIcAB9W
	TPoswEqQP+TtusJMNPs/4Ys297OrWYK6TLfGgNWgm+FFw25gPKWOTtj7ygzfjXdl
	5KgU191aF2yOiXWtVcang==
X-ME-Sender: <xms:RhfuZ7pQTSd37KLMAvVOt4kxT_oz17-zrO-JeS7W8mAB8ge6GAEotQ>
    <xme:RhfuZ1qX4DGoLGlMgof4wUt05N2sEpvYhwRyxJ2lF6wqM-a6YMaVUvFXOVIjBJNzO
    XTVsqnavyQR4dKZUw>
X-ME-Received: <xmr:RhfuZ4Ol847DSSwwuOp8ma-P13mVcqbFp6tckmej994OUV0u_asHYnl9mxLABcyxFJLJp8ccitWP_8QG4OUIT1_JgdpmKK9lWAktP7LS1B4vrc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:RhfuZ-6WGDg1JQdwrxfewvlcHGJnuny1IvMkn0w76mjjJpxRiO5ZKg>
    <xmx:RhfuZ67bvb1awyrutSYWzW5sGs_AHbiuj-z4Ag19cHeNdBuiSeKiPw>
    <xmx:RhfuZ2h5g0Z7NVx0hQB2SuSJaAftc-42OZN_fAuqt7Pbh9L0HdjC_w>
    <xmx:RhfuZ86yi7PCUF96O6FxYZV_4JQ8xZ0q7EpVOJClgJM5n4MIgY5pGw>
    <xmx:RxfuZ6f6GYeMXmKfx9NSozlFwIohq7RBZ1FSreq-aXipbPPggbTr2cBP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 493f4b26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:06:10 +0200
Subject: [PATCH v4 19/20] t5316: refactor `max_chain()` to not depend on
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-19-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
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
2.49.0.604.gff1f9ca942.dirty

