Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1425B680
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041610; cv=none; b=QHUpsNAyPvAd6d7ySPUgvF1eAg6lFXc74WkwYIMr5zSHbh8IqAs7I7QP/mUtNR3pHi8rG5rmFKdqA/rqZXQ+c23BEKHRQss7tlW4WE0H6bZps108iQmtC3920Dx7MYzLQOXNBkZyfcCgEjG2xlSuFLhfZ/UCDtYFSRfPqo3OdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041610; c=relaxed/simple;
	bh=SGwSNibErA+VnkgRLVtMVjLY3IZrRp6nSkt/o1NVXOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWpY7QOF+mUfZcto+Dygg6N8WtUV0FXw9aOf6FXHguoRSTxCmYSg2p0/BJgSg8pExNxMMsiN2cF7sE6R5pyPcBFti9kzeNbXA3TG0U6wqTcFRIx+GTxqw/BI6JVDpBPKtmtPKHshwDmVIPtexFeD/vk6Aep/4fgvNIn4KJ4unhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KPifK3n8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vwMG/rLR; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KPifK3n8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vwMG/rLR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F0CAE2540111;
	Mon, 12 May 2025 05:20:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 May 2025 05:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747041607;
	 x=1747128007; bh=Wc02gnc16A1r+sxlQFfvbtS9sKMDmK97iIYFQxA2Kso=; b=
	KPifK3n824/exf8LQyq1mmriBDL3qX80mEo/iG+FWwqGWxEI1jl/DxIbpwKhVJBy
	q86fskdyVnybdpL6Hy/GOTNNLsyPMJe+nFh1ksGPL4XEu62ADfJGgqzMUdQU1bZR
	iBMBgiOQ8XD1sMzehm9gjnqtn7dtWcQC5iExZM/7fvzvIyx5xeXbQZDh9JdtXssK
	NN/2T7R2TfeHn3n5XoZT/sfYNZxGbKSQBimNw6NN9vrXBLwEv0JeIJlZ20+5tJSc
	C8Y+CScQy5895QjH6qMHesVcCBxlo1k7OVUxZyiQpsyIJMhFKxHgPvYxEPQeADLJ
	5HPw7za3PnUZAr/g1T92PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747041607; x=
	1747128007; bh=Wc02gnc16A1r+sxlQFfvbtS9sKMDmK97iIYFQxA2Kso=; b=v
	wMG/rLR1j2n/Jf7xNdLDxl9zKj479zDUcAIDMUV3cB2NxF+v8KUCgnQsZbu4q0lw
	/OHR6mro4yl8nRBbp8qVyDIskF198brgIyZjj/tzNXYnOqpIoyrEP8CJncLpnEDH
	bj68dBtZn2B1hwEhaeaWq8+rUyP+1Zdlsf6NI5k1g3qNiVqb8QNfNE2ObJmBertX
	MG9KpFZBnm0nM9rv7XmFNQlyKzQw6+C8AL7jvOVN7oum2jXL9F2lvP3RB95GtR0c
	wHwlnaX9xFx3nToedGVt8AYyqc5a9H4Qm/iHRfHl1Pci9aIvv8sr6jy7+NS/vp4j
	xydfivSwMd7Pzv0LWtakw==
X-ME-Sender: <xms:R70haMwPgKu90rsDx9py21nvTJ_-byshE93qJY3mWztyEutf006DAg>
    <xme:R70haAQevtPLmwKqJkqgKPWrHGTiMqICQjndbv8k1ohi8Q9yZBCz5pM86Dq-FFr3E
    04NlDGRA54eTJ7n2Q>
X-ME-Received: <xmr:R70haOW3-hEw5Es-5ZQNvU4UxpCCxtwOCMT9hNhN6hN5sMkn38fRvaZ2njEImFnRzpAbY7oQ_KtSmDgYYB8iVn2mIqPeCwt_ywUljwEo6XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefgfevtdevudefudetudfghfejgfelgeehheff
    lefggeffheeigedvgfefheeugfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithesmhgrthhthhhivghu
    qdhmohihrdhfrhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    thhmiiesphhosghogidrtghomh
X-ME-Proxy: <xmx:R70haKh290rLOqh1B4Bi7zb1jIy0sxFWEZiqBuFmNZtFzU5Ru_fpvA>
    <xmx:R70haOA5HI_6ozDR9WInK1ihtT13rYcvlDdrRQ4eInJgz9COBthgow>
    <xmx:R70haLKAamZsKU4WqYPvtABK8kMpTy3Qza3MMDyWz8Unx8AruVgP2w>
    <xmx:R70haFBJrr0RyRl0JyVHM8-Yeqm6lz2eoHcPhSnaRKmYfAfa-aqvbw>
    <xmx:R70haIwJUjBY7lKrdZHi9ybn97ZoHLKPUm_OXwMSUs3PGV5avwwhYSDr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:20:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef33a35a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 09:20:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 May 2025 11:19:53 +0200
Subject: [PATCH v3 03/11] contrib: remove remote-helper stubs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-pks-contrib-spring-cleanup-v3-3-32e151b0bfb0@pks.im>
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>, Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

The "remote-helpers" directory contains two remote helper scripts for
Mercurial and Bazaar. These scripts have since been converted into stubs
in b2c851a8e67 (Revert "Merge branch 'jc/graduate-remote-hg-bzr' (early
part)", 2014-05-20) as the helpers have been moved into their own
upstream projects [1][2].

Given that these stubs have been created more than a decade ago it is
very unlikely that anybody still tries to use them. Remove them.

[1]: https://github.com/felipec/git-remote-bzr
[1]: https://github.com/felipec/git-remote-hg

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/remote-helpers/README         | 15 ---------------
 contrib/remote-helpers/git-remote-bzr | 11 -----------
 contrib/remote-helpers/git-remote-hg  | 11 -----------
 3 files changed, 37 deletions(-)

diff --git a/contrib/remote-helpers/README b/contrib/remote-helpers/README
deleted file mode 100644
index ac72332517a..00000000000
--- a/contrib/remote-helpers/README
+++ /dev/null
@@ -1,15 +0,0 @@
-The remote-helper bridges to access data stored in Mercurial and
-Bazaar are maintained outside the git.git tree in the repositories
-of their primary author:
-
-    https://github.com/felipec/git-remote-hg (for Mercurial)
-    https://github.com/felipec/git-remote-bzr (for Bazaar)
-
-You can pick a directory on your $PATH and download them from these
-repositories, e.g.:
-
-  $ wget -O $HOME/bin/git-remote-hg \
-    https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
-  $ wget -O $HOME/bin/git-remote-bzr \
-    https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
-  $ chmod +x $HOME/bin/git-remote-hg $HOME/bin/git-remote-bzr
diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
deleted file mode 100755
index 1c3d87f8619..00000000000
--- a/contrib/remote-helpers/git-remote-bzr
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-
-cat >&2 <<'EOT'
-WARNING: git-remote-bzr is now maintained independently.
-WARNING: For more information visit https://github.com/felipec/git-remote-bzr
-WARNING:
-WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-bzr \
-WARNING:     https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
-WARNING:   $ chmod +x $HOME/bin/git-remote-bzr
-EOT
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
deleted file mode 100755
index 8e9188364c6..00000000000
--- a/contrib/remote-helpers/git-remote-hg
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-
-cat >&2 <<'EOT'
-WARNING: git-remote-hg is now maintained independently.
-WARNING: For more information visit https://github.com/felipec/git-remote-hg
-WARNING:
-WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-hg \
-WARNING:     https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
-WARNING:   $ chmod +x $HOME/bin/git-remote-hg
-EOT

-- 
2.49.0.1101.gccaa498523.dirty

