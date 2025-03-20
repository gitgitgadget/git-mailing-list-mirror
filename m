Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB222371F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463343; cv=none; b=XtiwKmSER+csugEWMBSQY8ep6qyspIaJzb/b2OwWImPonpHKvcnkQLJ7/wuEgQQ97dCnjlf6oAtzWNH7XACEVlL072MUW0mSjBUIgbefox8PBa2MNaEwM5EAYPgDNZQgqM5seKf/4J+IWhdegWwAa9+B2AszklVUpjkv+Y4UGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463343; c=relaxed/simple;
	bh=SqgwrBTkrYbv5glFIrb56jno8ArmyZR/5hk9xLLHDZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGKMUu7yMWzhZ5n0ii1sRIL0tpfCggmMy0g4hhYZkInE9E2urIvPnLTyLR6ko5bOEB+rjkwgJ5uLn42wI3ghvdlUPbg9QroFfKgKDRtLgrUgYFQF01UJRYhm8aOdbWxG89EqUm9VBULwq5ji3N5dyQS3FJhtUQ+RVLqoo+S6KG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m5c5n1wJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cPxwk1vm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m5c5n1wJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cPxwk1vm"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 889DC25400E3;
	Thu, 20 Mar 2025 05:35:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 20 Mar 2025 05:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463341;
	 x=1742549741; bh=qOkz5tNStvWV5OcPZ4w3xCtLyTUs4qHhI9eqR2Q3F9M=; b=
	m5c5n1wJgK0dBpDcIIhuwWla7uqpeFWyIj1hNX5eZLehQ8p1bQjeEpMmY5iGpuR6
	Jtz3YJ+tEnNMgMD5sguX3fOgORqxbyctNXhSbuJ6lXZfVa3TaY3Gan4AR1AjmTMy
	J4LCdZlAqePE69uS/4ETcCCXKJ+OHWT2SCqiG7BkHkomUJ0kMUlP59rOyZwiHHBr
	skgAKLX9s871zEL6qo0/bY8xB+MtiNflfuf1MWzqRwcN9n3E7+xfzTwuJFtmzuXM
	tG1wSaXx3qMkau4ZNj0eDi0NVZtqpBCAeie+pn7KSytA6YKLzAFmbF7pvo6sA9/6
	3ck/nYf7PnE0hyvgKlbHYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463341; x=
	1742549741; bh=qOkz5tNStvWV5OcPZ4w3xCtLyTUs4qHhI9eqR2Q3F9M=; b=c
	Pxwk1vm37yYD06M3lMGnQ/7eCmAUjWs70okL+Z07TQJv0qUneX6ZayujLLL5LaCh
	Jw6UQncGQEYTrQ0oWo1am3GEywbSSye+sOVUq73qh7UP4YCEUrI2SyER3UHz9fAE
	4BVYjpXXraPVYHewWk0KQHClmF6OawgoAuHqescQ+OiaD+TkpdaLWIUsrwSXmCum
	8yiR4FG7DoriVMr0YY8t3mqH91NUsE1wv4F6oLNbL+KWfaHhK9VL4mwJKwJUJVeS
	kzAkZWuR4DVrdijE150tIbcyqNWXcCT7dhzaQ55I/mzYsciq9ltUGxOU7RGHjIEN
	YKTnpqSiPIHVN+RMQpsiQ==
X-ME-Sender: <xms:beHbZ3_wmr0VDUry3_wyq1o-8UQVlr1pK61e4IKYD3IVERezfu1Lmg>
    <xme:beHbZzucFA7-4aWIyE-xwkUjW5SPTLUMpH9XZ73j0gNIT_MPUDc4ePfYZsG4q1QLE
    X2R42docO9_x-7qRw>
X-ME-Received: <xmr:beHbZ1Df56qxgSsQlSHGsvjU1y9dGJD9k_c-ySddJ-xbsLIFF6wGTtgHhaNNCFeLfgJXRN3VUhS9hD51mC82BGaVK8Ekx7kAVJdhHpIISRZ7bcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:beHbZzdh_5nX8yCTdPv9kHHiSJjbVYwtBLWjcc4RWQpl0FN7TzJYMA>
    <xmx:beHbZ8OSC5AlFpEq3SF4e_OR3UtiWoqfbhpp6LjalJLAuzuaB-qwMg>
    <xmx:beHbZ1lLc6E2TcryE3Lzmf3svkIwrnbEoJR3W7s422yqEFAmweV6QA>
    <xmx:beHbZ2uccmpNn55AsA35LlXcYVfyTK9p8M2_k7SSnUzyXWyt1G6zLw>
    <xmx:beHbZ1YVn9FZAiHms2luiHXV-dYC7c_8__7-M_bHgSjNpj5ZYahWr-q1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a380ac9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:35 +0100
Subject: [PATCH 08/20] meson: stop requiring Perl when tests are enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-8-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The Perl interpreter used to be a strict dependency for running our test
suite. This requirement is explicit in the Meson build system, where we
require Perl to be present unless tests have been disabled.

With the preceding commits we have loosened this restriction so that it
is now possible to run tests when Perl is unavailable. Loosen the above
requirement accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9db..d6e27b236fa 100644
--- a/meson.build
+++ b/meson.build
@@ -772,7 +772,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
+if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
   perl_required = true
 endif
 

-- 
2.49.0.472.ge94155a9ec.dirty

