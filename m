Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FE33B6D0
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582541; cv=none; b=NZbsr6Bs0IjqHy4zy2S98cn2rzO13+WorXGk2mfEtrF4+y6sHugCRlnzACN8UkzHKnlg6/Uz5rBJXwgyy+H7RDXWGJ5oFDkK9BPDFEy/9Gl/oQZAZk/5xx0AZtUp4FiAAdZRJ8b5ObBYgnWo+M4XNGZ1/XhOGqzo4yLOFC5Fn4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582541; c=relaxed/simple;
	bh=yE5xOSK+fk0ZnYXhjeFbm9RW3agTPP5bTf18N0oPcZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koECSP0T4zh+bHZKkSHkQ5z1bOodWviWxwnOjBN4GmIclfCYq4m8PHojbrxgVNuPxJWxkDI7CU0afJBfla0vJ2Zv6uXfIO4lbqW3ichjbW5Bg9mje3sO/gmZyiW9gHW/G8W+GKbKzo377IsT3LHPFMBoVnJ/BllffzgOlB3k4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CIkO/dtU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pnpH0KBg; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CIkO/dtU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pnpH0KBg"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12F5F7A01B5;
	Fri, 20 Feb 2026 05:15:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Feb 2026 05:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771582538;
	 x=1771668938; bh=R0fQqqSLYFmqLgvqxiKErkyGbPQDBL4+z8lG/zW+BEU=; b=
	CIkO/dtUdKJ8c6BGRLUts03Q7qDJnTO6pY9+cgS/XrNoafgkmWmg8LKt5SOsstoI
	NiFc2XKY/vSingFX459gX6MRYBVzgraysyNEY7p+SaR9J4tWNnYNWiWi3LAifO7z
	YMV8NiFaR3wIEUVFoALYlNUNmFRLPmzB04x4FyZ5zBuILEp83hUI2JO+1zoaepzK
	9W3mr24y8BKAhZdXAorCeN6QUXUpHdV0Aj7T99PtRrihg709YlwE2oOzmmCkEnSV
	gQ/JMa/Cy/2Lh18rZoQrfgW1t1ihhVlJ3AEgIaDqfm6ALx/t5NQekg7+vn72HxRr
	531tntQ4m2JcqcpwX/5JBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771582538; x=
	1771668938; bh=R0fQqqSLYFmqLgvqxiKErkyGbPQDBL4+z8lG/zW+BEU=; b=p
	npH0KBgrHMHFDOQnL4ro8hiIRHZmepTGLrFD3UayK50uXhSYu2g+8Ss/PoKloYCk
	wrKq/48hJra9KxBX14GGUwV1UqCWEZ/jpbc0d1d44IsnWQ3umMqepa844OrmFwJ1
	taH2tbBlt5dAaq/CyfYAK+yQXlwrTGVcOtjYUJGrky52dO8X+KXa7lrpbZuPVx0X
	grDKhT3ApFL9PsnBn4+6ehNosFAtDcsae+/mpuniYJIUS/bvWlwnhQBluZsQjeWf
	AOLkMstK8zR4ywOGmw6YyiRXzAZvWCQ7U7m+u5lIQvuOoflX1HUFyXblu54i+TCc
	gXkg4/EVoYPIyYf1OEwlw==
X-ME-Sender: <xms:SjSYac1Vlnbr7EPelOdKzGf7qhGXS-BTeuKKKCipzzA-Oh2IAred4A>
    <xme:SjSYaeit5h-FpB98lev2jbq0jNBmhOItaKUh863LYLzEfewdCIZl-tFRDUEXYxs0i
    KWXHgdbSkW9CocvBpNk0cGuFNSpipzcLz_axENoSz783OHuHIIoPM0>
X-ME-Received: <xmr:SjSYaSSE1IvDNU3WgGsJ0hj7xvF1Cs5srieRCv85h-au7GSEzKB8RJiV5mJbVMrzLArCa-MLJGZjjn7wlgNv2O8uqBklDvIKmFzayME_L9Pn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SjSYafgeL2qtissTxjVap6aZj7kesUMm7my2cUQ1cFeynAiDebFw5Q>
    <xmx:SjSYaS575JIZ7FiEVtNeN_j4jMonVC3f3Q6Cy46cv4jlUEHVx2E5kg>
    <xmx:SjSYacBH7U6nFGw2swnRYLoorXc8hPJy2CBO8GTFOph3u63DF1amMw>
    <xmx:SjSYaZYWUdxQvFnsKcLtng_1kRTLZp61RXQFVhUjqoKL-WAwvzeMpg>
    <xmx:SjSYaYZ8HzC8_kkr2sXfy1cTDnbQe1va_wJ7cgHZBovi_ps9pHINNRfD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:15:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d623e82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:15:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 11:15:10 +0100
Subject: [PATCH 6/8] t6500: explicitly use "gc" strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-6-faeb321ad13b@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

The test in t6500 explicitly wants to exercise git-gc(1) and is thus
highly specific to the actual on-disk state of the repository and
specifically of the object database. An upcoming change modifies the
default maintenance strategy to be the "geometric" strategy though,
which breaks a couple of assumptions.

One fix would arguably be to disable auto-maintenance altogether, as we
do want to explicitly verify git-gc(1) anyway. But as the whole test
suite is about git-gc(1) in the first place it feels more sensible to
configure the default maintenance strategy to be "gc".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t6500-gc.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index bef472cb8d..ea9aaad470 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -11,6 +11,7 @@ test_expect_success 'setup' '
 	# behavior, make sure we always pack everything to one pack by
 	# default
 	git config gc.bigPackThreshold 2g &&
+	git config set --global maintenance.strategy gc &&
 	test_oid_init
 '
 

-- 
2.53.0.414.gf7e9f6c205.dirty

