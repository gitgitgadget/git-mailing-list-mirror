Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E14229611
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855783; cv=none; b=rLOjF2tjhUzpHITMJOMNbq4ShQsYQm67oiL9o/IS6b6FQYoXCRqkF/SN5PurUzrGWr8RJm9KEK+v4sh6YGuM8klfJdOFP9FFBvc3P23Qv+4IUms590EorPv3zhdHhshZ3hXdo5xr/A/zG5/xTlWp6kTnDeTTtuQXAqFdsqjLP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855783; c=relaxed/simple;
	bh=DVYLCjbCn53dNvrs6odJ8XPipiNq9HJEYlHN8wQNK3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTSMNCTQnO1XhNT3vLvrSxBdJoPOCZOD0l7E3qrrc/31Ve4/Blm0xpn9/4EcINp71J1myneLFOKiX8K8rjlB87KKEV4nW/bPghSnLmRzPmgMJwFFOTcFWQAP4fAnNMjWWqjs0MYIDIFRz9PJeJ2XxjjP2U+b4cj1WUTD2HV7nWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SRoapL4r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBwfBHPg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SRoapL4r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBwfBHPg"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 098381140169;
	Tue, 14 Jan 2025 06:56:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 14 Jan 2025 06:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855781;
	 x=1736942181; bh=pSwOC7avqCxD9R2LOJxx8WX9Xynae/2LDs9vdLOsp1w=; b=
	SRoapL4r5h2SaspHmoyaOIz/m0cawsu7LhXYkvYhTgwFUfopOTodnRApa5vPxbBq
	VQ/wmNZsicEdeV+7HHTIWCr6atBCiNXtDWFy0WjptCj37EhL7rI3LVYiPNlKw22X
	mhPjP8vtn/ZbZYMMGHws6ZTsxAwbBL0Fxqn5nOEqH09HH8xYHXoQsysIpqzT4t5j
	9is92cYFSs8ky5hlcD02lqgwHdzMzZfRJxHzaM08XXvAhGaMD68AtdKB4QQz66vi
	iRjw7S8b81lkZlQOldCasoECW81R0R8S/cQ1C8jsEtF9H9dAXRYC11arn+Xoy2lj
	1xOF+RJprAftOGkdY5LWPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855781; x=
	1736942181; bh=pSwOC7avqCxD9R2LOJxx8WX9Xynae/2LDs9vdLOsp1w=; b=X
	BwfBHPgqt3hm98JhQ3rNPJHUgQYtJseokkaa0/H4aEQlvQDVfTfZl2cfLEyZiOdd
	aqM5w1toYWwnbcqXfLz/KxSkpLKe0sR1WnOX118PcgmpHiEFP2AmLbnWV3Lb4fwJ
	DP10varhzYM52Ng4Z9HqlI1SiHnG4ObU9sZXwcUvsXfDsYe543Xc9SrkLjTzyx4c
	/e3WJCWSba4m/FVeyA24nTfm0/HrKP6xW7xDwBLt7bTvFsCA4rWiyRcXy7Cq4OwG
	4DnI2aipIsZv21Ym0ueAPnCGQWjNN9LvFqZqxGQiMb1mFD6Oyo4oRyy8hDGR8CHM
	Jl/NyxgRs16bjjSN9Mz4Q==
X-ME-Sender: <xms:5FCGZ4JZRCFwkgS0EvOyh3z5OKbadcGad7mKct_yQ2Z1g0_smkCc9Q>
    <xme:5FCGZ4IEUxoC3db-8KWGM-OSzi74mWNMy8TIad1cOPAC9kS4aVnbSVm9Rrb7gi0lo
    hwYn-gu2YHIT24Vqg>
X-ME-Received: <xmr:5FCGZ4sPnqZ3JCCwMUhdb9aMeumwZr_ZhsEA9JANju1pxfAxcvtQbrGocGbbUQ8V4t-Wwz0xkRYrLFsxBcYjmx9PLhjxJhzr-1nhDkw18JZQGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvshgthhifrg
    hrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5FCGZ1bsShaMDqmnE2s8EEN2Pe5wuiwlwXoBojztLU5hDIhuVEY14Q>
    <xmx:5FCGZ_aox307gi_F4Te1ivH9QDUEFR1fiq-73EOlD77YrpEXZ9vq1g>
    <xmx:5FCGZxCRfoeLJJlCApMzkguDAL2xjXv0AAaaHPEbuEjqwjdBisJZow>
    <xmx:5FCGZ1a1lXR5GOhldQy15jMM_8IN_-uA7m1fTmdwyneXq7v8OUYauQ>
    <xmx:5VCGZ6yNxKC1BDaEm9PM8VKxH3bDFUD83hJaCyGab55oO83T5RSVA4Xn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 94011171 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:15 +0100
Subject: [PATCH v2 05/11] meson: wire up development environments
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-5-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

The Meson build system is able to wire up development environments. The
intent is to make build artifacts of the project available. This is
typically used to export e.g. paths to linkable libraries, which isn't
all that interesting in our context given that we don't have an official
library interface.

But what we can use this mechanism for is to expose the built Git
executables as well as the build directory. This allows users to play
around with the built Git version in the devenv, and allows them to
execute our test scripts directly with the built distribution.

Wire up this feature, which can then be used via `meson devenv` in the
build directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index 4053024dadeb0aafc067784b976ed3bd96171181..ab4f229436d3070de692a24c3a196a79d214b46f 100644
--- a/meson.build
+++ b/meson.build
@@ -1939,6 +1939,14 @@ configure_file(
   configuration: build_options_config,
 )
 
+# Development environments can be used via `meson devenv -C <builddir>`. This
+# allows you to execute test scripts directly with the built Git version and
+# puts the built version of Git in your PATH.
+devenv = environment()
+devenv.set('GIT_BUILD_DIR', meson.current_build_dir())
+devenv.prepend('PATH', meson.current_build_dir() / 'bin-wrappers')
+meson.add_devenv(devenv)
+
 summary({
   'curl': curl.found(),
   'expat': expat.found(),

-- 
2.48.0.257.gd3603152ad.dirty

