Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7D3148D4
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996039; cv=none; b=GgbCimzABfvuQt8Y/Xj8++q0BIYarhHZZn1G5uAki0c1lXb5VndYnBORROfRydUR+WX/O2TiBgV8SJuX/e4LGS8NFGVpTfnBOn5iH5bDG+dO9M62COu3dRiJJDf0Mf0Tef2hIdru6EIDTskNLQEWwYGKSRgLrjZ1SvW+139PfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996039; c=relaxed/simple;
	bh=45uSIejfOHIAwURZy+c1G2hzK1GUmM/OmoHYzFCTziw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4HgAD1e8tCkRDWadz7eMp2+z0PRnRJeg0YhS7Gwj778GrfSB3apqn/kUO+vcYoQf2QOxcMfbXURm5EGt6Y6nx94GnBd6FEsRk/TJ2neWWpFt8U4SV5p9HWMR6meatpDijTS2f4+jsXGRe4uvaEsmXRM9hbLkU6HIgW8TSzcndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XY32ElPl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+eYZQbL; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XY32ElPl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+eYZQbL"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F41A27A0354;
	Thu,  4 Sep 2025 10:27:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 10:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996035;
	 x=1757082435; bh=mDPHnHtCh9s4equMiBrh1oWxS2XjssVRZOD6WYJpqSc=; b=
	XY32ElPlQ1+aDufy3YPVTTeYWd+5AEssZzAr+47cVGdObo8DmmWJ8uwN1kYbQWGp
	T4vTslqe0HJsZqXrVwbbHOD6NNJoVPDkMMO1yCFJxh//lo8SZbYjAtibSinDnD/7
	IBlSZ+DPet/YN1tIeAohI304PYeQU8sXMKIlPG4SdnQAFnKNwDQzjc9xgGlGlpCW
	umcwdGmtBHehMKGa66YmEy98ZXNZ5hjK02tJ2EpbSmbwkZU9ZWiQwhAET2QSETBv
	eHS0rbjzEntVhGZdIlMx2A4TcxWMFzJ3YI9XePAlTeLXyeXXJwPf8ST3pPfzOFdg
	X1skMk4gjKAIcs9U72THBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996035; x=
	1757082435; bh=mDPHnHtCh9s4equMiBrh1oWxS2XjssVRZOD6WYJpqSc=; b=X
	+eYZQbL2lYq22BIVxzTyXqoOBdudLxFOr4YzmF4mr7xlQQMGOgsjVTlF6mNWrPDJ
	Pe3UMsynoixM6JqZGmtkZs6SVn48N/2oae5WEVi35Bg+lKtGoYlQBeAT9yPUJM95
	FR3ozRlpmZjImVVCxD9Vd8t2woCqNq69oRSL48XKNLBp2h4xpoIov0Agg7PpujC9
	5D63dLYl11vtsxQhMQ1Lp7SxUV5flzcfrB204oouCcEFasoACa2C2C4ADv+1VzKP
	OeR99P5Y6uMtFESHom3e35swo2Oo8avGSLDLcITBAIX0N4snp+uDf6sVo0vcEmfb
	gO+8AMHVhdkykbTX1pzMQ==
X-ME-Sender: <xms:w6G5aGUxAjaNtWFExEbFWOM2AlHq86RyMMDTa3NS6RgMLTFReakCiA>
    <xme:w6G5aCtXJ1kuzTiGO3QrHxGuMjoItbueEQROwLtmu3pHVRH0SMXf0_D-AOk6lcAkK
    xz1s2mGeEPiYIQAvA>
X-ME-Received: <xmr:w6G5aB3U6Xokr9qO4_CERpo62CQwhhm4mxVODmZ36dcrtnu0nF0JFK9tTqQRkreU9lCicP8hkdpvN_jyLm4P83xsIr82mWynbU9m9HEtpGm7uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtoheptgholhhlih
    hnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhivghrrh
    gvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhm
X-ME-Proxy: <xmx:w6G5aD7-o8eUdvKHnxkwrm3rzz-z_5qj1A0IEsgjMdEiCmV39cniTw>
    <xmx:w6G5aIUYzpdzuQYXYkbuTT0qIiBztj9uwUkOT1BIN16TDX66-SknDw>
    <xmx:w6G5aLjzjlH1_oTIdVjHMxMIu1PSgGFfhQ-eRfmnGPDlTud9eDOS_A>
    <xmx:w6G5aIeIH5oOfgtzh3EvAFPjp9bhqEP_-F0olvvhQN_zLDxk2gnhVw>
    <xmx:w6G5aFbr5dnBtt7rTaNkgTGtuR_i3aG3HZD7GiynSFZFiuD_qwrtFlWT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f9acc7d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:26:45 +0200
Subject: [PATCH RFC 3/3] BreakingChanges: announce Rust becoming mandatory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-rust-breaking-change-v1-3-3af1d25e0be9@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Over the last couple of years the appetite for bringin Rust into the
codebase has grown significantly across the developer base. Introducing
Rust is a major change though and has ramifications for the whole
ecosystem:

  - Some platforms haven't yet been able to implement a Rust toolchain,
    even though it is possible in theory.

  - Some platforms don't have any support for Rust at all.

  - Some platforms may have to figure out how to fit Rust into their
    bootstrapping sequence.

Due to this, and given that Git is a critical piece of infrastructure
for the whole industry, we cannot just introduce such a heavyweight
dependency without doing our due diligence.

Instead, preceding commits have introduced a test balloon into our build
infrastructure that convert one tiny subsystem to use Rust. For now,
using Rust to build that subsystem is entirely optional -- if no Rust
support is available, we continue to use the C implementation. This test
balloon has the intention to give distributions time and let them ease
into our adoption of Rust.

Having multiple implementations of the same subsystem is not sustainable
though, and the plan is to eventually be able to use Rust freely all
across our codebase. As such, there is the intent to make Rust become a
mandatory part of our build process.

Add an announcement to our breaking changes that Rust will become
mandatory in Git 3.0. A (very careful and non-binding) estimate might be
that this major release might be released in the second half of next
year, which should give distributors enough time to prepare for the
change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.adoc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061..b72c4dd4a0 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,26 @@ A prerequisite for this change is that the ecosystem is ready to support the
 "reftable" format. Most importantly, alternative implementations of Git like
 JGit, libgit2 and Gitoxide need to support it.
 
+* Git will require Rust as a mandatory part of the build process. While Git
+  already started to adopt Rust in the Git 2.52, all parts written in Rust are
+  optional for the time being. This includes:
++
+  ** Subsystems that have an alternative implementation in Rust to test
+     interoperability between our C and Rust codebase.
+  ** Newly written features that are not mission critical for a fully functional
+     Git client.
++
+Meson auto-detects the availability of a Rust toolchain and, if available,
+builds the optional Rust code. This can be changed by executing `meson configure
+-Drust=(enabled|disabled|auto)`.
++
+These changes are meant as test balloons to allow distributors of Git to prepare
+for Rust becoming a mandatory part of the build process. Once Git 3.0 is out,
+Rust becomes mandatory and it will not be possible anymore to build Git without
+it. The Git project will declare the last version before Git 3.0 to be a
+long-term support release that is maintained until alternate Rust backends like
+gcc-rs are able to build Git.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).

-- 
2.51.0.417.g1ba7204a04.dirty

