Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C7207A33
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508729; cv=none; b=mP8Ho52R92nq8dXp9dAYT4b4sF+m0lbgJQdMB2g0/Hyj6A4NHnOAyJSxi8Msb7Xd7qFJH98MRChfl4nP6y4aNSrRNVQnDexluwGGAfkgiDPdbsGBitnwd1/PZgOzv6aPWYvV5vKx1ImxjysY9gVAj1I72ArpaoPm2X4w10yDiSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508729; c=relaxed/simple;
	bh=JFHHEbz2oE7VVQdLzJs4YiqTPVPDUg8hU0JfVGuRSpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hh48J9P2FslU9wG7D869VqPkYceM9lBHJgnxgH05YEn6VsALJaTsmLFgqR9orDUW3/y1PreZvcxxKwbV29heccl3PQAH6wSzZnXCwXbxA/tacr2gn7GrOmYFxCn8Kh5lOXTnz3cUVzByE2NjkJ+FwQANxIHpSicqSWl07vOYzMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E9a6aHIb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sj41Pj8z; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E9a6aHIb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sj41Pj8z"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CED8D1140106;
	Fri, 10 Jan 2025 06:32:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 10 Jan 2025 06:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508726;
	 x=1736595126; bh=rjcCvr+RH/6kX9YTo9SuZQ3/JoBF3nnvWaNwFRvlZaI=; b=
	E9a6aHIbAY6vGV55lnMXQJpshz7LQozssIsiKh3G6CPs4HXVYmf1PhOUA65b4ozW
	/aonR+BrhK6qTHC/doa+3lVE59qyyvxoeTLQ13/WU3bCT5Jd1urpS+gWuQr7r03r
	LRXEDP1knZYXN+s+ccoV5i4bHAIik/TYtiFlHiYRPee/dbHthMNgzFWQLco12kiV
	Xn/TIK4HH/5w/UAbUnucHsWlUuVND0tI+6QCaMvueBHy8S+fonfHNbVW6KIqX6r9
	JEmlxO6bxWop7bqCOIUkUhWQ/Bno6OyaFgbn23soFYpelxLdr8q+g8GBrq8o14d1
	LScABUWYwaSZ85yJzOZfhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508726; x=
	1736595126; bh=rjcCvr+RH/6kX9YTo9SuZQ3/JoBF3nnvWaNwFRvlZaI=; b=S
	j41Pj8zd0kRHpUZGw1phdUGJu20oEk18SvQ7O7BXB5BjVZM5G1SyqM+ejoiy1bwn
	UroW1TUkZqB7rA+h657Y8+pSbc+WDFTKssscEWRnyLFMe3/OL7ISviteB7yIoec1
	8Gebxep1+N/5cBgMOJmhQbzbZbCN1mR8BUHe6KWWfHowjmxY2p0NVerYXGFWWvgl
	wMokMv9AmA52mivry1pyuvE/nQTMElykCnFikKlHlr4K16MEI4FDEb31Wmxi3549
	hL5bmFlEqQasNoe0pxp10RoYSZJABRmfHYnGlArxurongV4WLrqwukY3shaqP2X5
	vilXiBygPxQfjr9pmU0Zw==
X-ME-Sender: <xms:NgWBZ00jl3s-vpYOZ4TMzy3U-O7z3Ajo1eL0VimCm77YJ973CsO8sQ>
    <xme:NgWBZ_FRAwKnNNzFHo6_P5MVzGdGqMC6OQR-anZIqrimqvvGbmZtk5oXe0KiAxbLG
    BKwE11H9IP53II_cQ>
X-ME-Received: <xmr:NgWBZ87BlFYgxJxDXhDzX9Xgnc8ml2BKXscuSNn_mckd61iApokvP_4zecPHW1YMA-pG8PW04u_nY8vNOj1u9Qb8uopTZoAlIPw8HdkuybRacQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NgWBZ90EQRY9rrxfKRvunbzoEEr_8ZbKaAqjpAfP578LTvw3BsiCxA>
    <xmx:NgWBZ3FkDUKS5o6W9DePw0oNrRvSDCBOmCS6RUkwK7loz-Jru6F_ag>
    <xmx:NgWBZ2_mAz9E0s62_09BrvJpYhXej-KJ5CfzKy8C2moepJuZrUVeXw>
    <xmx:NgWBZ8loonjaAKqCMb0a9sa5cCqaUP37WeLypYdKmCJk5IgrhatnUg>
    <xmx:NgWBZ7jnAr0jzIFoERGfgUt9s7REDvQ7AYMosEGrA6nsnckTByb55pQ->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f533bbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:32:02 +0100
Subject: [PATCH v4 06/10] gitlab-ci: remove the "linux-old" job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-6-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

The "linux-old" job was historically testing against the oldest
supported LTS release of Ubuntu. But with c85bcb5de1 (gitlab-ci: switch
from Ubuntu 16.04 to 20.04, 2024-10-31) it has been converted to test
against Ubuntu 20.04, which already gets exercised in a couple of other
CI jobs. It's thus not adding any significant test coverage.

Drop the job.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9254e01583306e67dc12b6b9e0015183e1108655..00bc727865031620752771af4a9030c7de1b73df 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -36,9 +36,6 @@ test:linux:
       fi
   parallel:
     matrix:
-      - jobname: linux-old
-        image: ubuntu:20.04
-        CC: gcc
       - jobname: linux-sha256
         image: ubuntu:latest
         CC: clang

-- 
2.48.0.rc2.279.g1de40edade.dirty

