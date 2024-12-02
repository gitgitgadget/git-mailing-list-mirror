Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5D1F943F
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123246; cv=none; b=P5wCxg0d2430HpFsTEYTTl6l7+Eq1UpQoaOFlthJvGsg8lnO8VQyhAJxrvk/8bljPCCXw6ivCWXjeyjiFRs026AiZlU259AmZk/KsRwVnwvGCXcUmRGMMmnRJiIPWTobD/nXbL3Q0zUHFpe/AyR0aK0YLMilTgNqaE2yvmiUsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123246; c=relaxed/simple;
	bh=q5pHg1CAMSSlcajORujRpX50bk4xGtxImJ/CUbQ37W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2wPL0L1k2bUCq57wuG8PFD3od4wcFfbvszxwYuRNmFmR+ZTjx0JDqPUoFKLMxHGQrTKGbE86Du5h3k3rAvSVmyawTkA93r2W9WxjgSGWZQD1zCdYQ7CRBapajdKKd6L/opmoB7F8mYcril8ccBmNA35re2vaTNgtLCV8jwUhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OT8FvVmE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OT8FvVmE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 036C7254017A;
	Mon,  2 Dec 2024 02:07:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Dec 2024 02:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733123243; x=1733209643; bh=h
	XqiYrkoYrfR0IWFcPj6zTGvb04yVrrFgg8ZnpUdJ8M=; b=OT8FvVmEYkp1UM8gz
	MFE/UX/MaauwiDsFIuegQKs+84nfcbhX/fOflmceeTCNm/yp4LkwDyID2L426Ks4
	TecPmT0OGWydr/TyCdEmdWgBI/Z/D4EicHJvOPTZ3Nm69VM4MDqlPh7f2wrIqoL6
	0W8lw8kEtm3TEafZj1OjOZZvIBwuKJ4NIuCYlLU1pw4EqFbfLV45irvo9reXoDBb
	6HW9xw99K6B04sSAaJWUYMTjOtAjkrMu//KrMW2roLb7sNOru47l3JbfPh69Boht
	g9Vh/jyBZ34pF2ldZhy1Bh0LX9+vkfTBe+kRy5J1mNiP3t5L+1fOnT7XXhQnydT2
	2YZxA==
X-ME-Sender: <xms:q1xNZ6x72o_CXUx3OFI2irv-7O7IFnFN7EHtnzxp6VJJwlx6BLxA2Q>
    <xme:q1xNZ2RMqf3TUET_x8iOGGzKWd5W_6jfsXQQT8lGGZ6xLWFciJMUdiDk7titcexxE
    zQ6_sVXXI1NnrmBYA>
X-ME-Received: <xmr:q1xNZ8W2RzeKFxs_cF7s3Kxa-AOrh3VReveA93A3lLyBxHRNHMGvi6UzLHl9Y3F3AW0R7BeD_Tc0ROca72IsvXKwS2btilJiL2szUdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedvff
    elhfeutefgkeettdfhudelffduteelfeeiueelhfdvudeiueekhfdtvddukeenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithesjhhofihilhdruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q1xNZwg8PZCOlZWkEBjpPhmt-1jCY0lcCtz55KOt-ZhI_VJVrCTrPw>
    <xmx:q1xNZ8CDpfEAPZT4kvg7N_qbAyR44dJsmK55A4XWiMfM1NmdGd20KA>
    <xmx:q1xNZxI1vg3KFptX6ZblQnGcCZRRNIwZLPDmIQvMZW4ssFEIVt7hxw>
    <xmx:q1xNZzBW4LiLpJ6mYvBF-ULGxyQnbRGB_MavLsauGS8WGrCm1GWaBg>
    <xmx:q1xNZ_96VMQwhUenqTha1UaxdNbihSPlWJFP0E2hTgUeS4M_H8AdKXDT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:07:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: git@jowil.de,
	Jeff King <peff@peff.net>
Subject: [PATCH 4/4] tag: "git tag" refuses to use HEAD as a tagname
Date: Mon,  2 Dec 2024 16:07:14 +0900
Message-ID: <20241202070714.3028549-5-gitster@pobox.com>
X-Mailer: git-send-email 2.47.1-514-g9b43e7ecc4
In-Reply-To: <20241202070714.3028549-1-gitster@pobox.com>
References: <20241202070714.3028549-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though the plumbing level allows you to create refs/tags/HEAD
and refs/heads/HEAD, doing so makes it confusing within the context
of the UI Git Porcelain commands provides.  Just like we prevent a
branch from getting called "HEAD" at the Porcelain layer (i.e. "git
branch" command), teach "git tag" to refuse to create a tag "HEAD".

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c         | 2 +-
 t/t7004-tag.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index a24bfe3845..01ef2a3093 100644
--- a/refs.c
+++ b/refs.c
@@ -735,7 +735,7 @@ int check_branch_ref(struct strbuf *sb, const char *name)
 
 int check_tag_ref(struct strbuf *sb, const char *name)
 {
-	if (name[0] == '-')
+	if (name[0] == '-' || !strcmp(name, "HEAD"))
 		return -1;
 
 	strbuf_reset(sb);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b1316e62f4..2082ce63f7 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -91,6 +91,12 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
 	test_must_fail git reflog exists refs/tags/mytag
 '
 
+test_expect_success 'HEAD is forbidden as a tagname' '
+	test_when_finished "git tag -d HEAD || :" &&
+	test_must_fail git tag HEAD &&
+	test_must_fail git tag -a -m "useless" HEAD
+'
+
 test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	git log -1 \
 		--format="format:tag: tagging %h (%s, %cd)%n" \
-- 
2.47.1-514-g9b43e7ecc4

