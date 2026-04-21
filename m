Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEA38736E
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756872; cv=none; b=Od2lmSzViNAn+/8kUVcovTrKgn2LEuuIvD8TqTaHBAAISFSdZs8/IpbVi5KqZPq/ZqvKX9sSKRTLnk4pkv9Cti6nMVfShdHe0wVUuO+lW6RMKXJZvr9pzvWS+echznvRC4f3uZ40LduM+H4B0GdMLlSqAcAqMwVkbhzFqdBqTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756872; c=relaxed/simple;
	bh=mrkbCu4w4Y5o9eY4Tiao1EerG8El0CgwX/a+e6b2jyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1vqXfm5NJtiYslsDPGTr3XooksziUQWGHKkEqn1riU0XE2zjSF27clA5ONe9cOSQr4Xh8hpqZbuA9v7o9VlPN1SPh2Ucy0/YZKua3Ck/4dGLmzwQHbR3KuqIcCJO5lYVTUuJxBrMjBW8W0GQWF3iWnL9lGwiVsTZL5/xnv4kkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D3ICkiRF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJI4fmeA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D3ICkiRF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJI4fmeA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A3ECEC01ED;
	Tue, 21 Apr 2026 03:34:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Apr 2026 03:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756870;
	 x=1776843270; bh=PkuXplusyTtleI4AStYOv66xQIZt93uyxb/3N2Hbdog=; b=
	D3ICkiRFltIZ8kcTql/Te2hrRtmmVi2cZEvTIhHhUjucCgLEp7KpVuiukn9Dz8LG
	xYtVAYk0V3A9Z7EPvmOXVz0b2ijCxFSCsJL9OORRg5a4f8WGMRC+vSYxmkiYiKiS
	tHBrvmY5Tu9W/8r7BdHP5g1fHwbD45GrDWHMQa1i5mIAMgpl2iNuCYTIYlCilfEB
	6+a0qtsvBEQYZWTpegxxfJ0vF14g+IEMoPPKhrBKX4TQeEHp9xyMPfSD4SaRciEx
	M5M7N+0poqZu53/eEzCOe4iLs7O/lF9rB8KrB3HG7bZSATrpBSAYAjcIPWp6TQhE
	/Un37LM5K/8unrNQnPyI3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756870; x=
	1776843270; bh=PkuXplusyTtleI4AStYOv66xQIZt93uyxb/3N2Hbdog=; b=a
	JI4fmeAiItEaD7L1SSaHCumgjGnQ4pmowwNnYlnDjRQYIDV9Qneqjyba/FDSkBub
	f3/X3Svn5yL2vpLvoMLye8lKraro5j1zRXZ+LorwjOK/ubEF3eKrYpYwVDIC6Sab
	6gY3BEOOg8W3WQr4AfJoQS18anOi2mhC9dzOLSv6dG36LXxRy9K4YL6Y3pFQgf7k
	dPb0PTyniBD7kp16+L+my9uQuLMryNDoC1cEBAw/nwBsijDVxbiJv0o8f1ucBtRU
	0mJ5GLGd/AGSUIbY9fAo/eALTjq5641u+xXcpTg0BwFSFUzGWQpmJVxhQRr02Nnu
	r1Fkjk6+1vMXlbdSeG/dA==
X-ME-Sender: <xms:hijnaXcFwcaela7382ZbPt7rkZB1bss7PgkRywAH49YWkSSIQFjuJw>
    <xme:hijnaUP--qm-CRx0DPIW67zUCeJ4cUewvS0JDe6qiQkvrgEOr4DdrMsJCySDpLjBs
    BMoP10uueSBya7qleenBsgZ5txDa8Y1D7KghsVff0ib0nTQzVqK>
X-ME-Received: <xmr:hijnaViC_M0IldiuqT5XEjECseuxx16owz0awirvH2_WtW0b-EpPjMurF0SLdSrqL2xa4eOOyv2YABAkHILtHNq2cLPflQ6iRvZ4_8vKLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:hijnaX2d3uP7xF_L_AD5Rl3m0MtpUv_igcav3f81QaudCuO820L7qQ>
    <xmx:hijnafiRxEmnGfBFjVvvQR5jZWrCgGrY-WadDK6KkdMnqLe0I-HK7Q>
    <xmx:hijnaXdEDfORTaajd6V2YJlFh0OhYlwdlcLCmJQzgB1qZVF1L7eJZg>
    <xmx:hijnaSkkyD-4d9YYKzausFf9RIAayYcPQwtWdXz6VO--5HkdhJrKcw>
    <xmx:hijnaZe6g7aphgEPbIwuRCR2ZRtsSkx02hMdO6BovhlNYFMqCzDI4jx2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86097319 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:17 +0200
Subject: [PATCH v6 04/12] t: prepare `git config --unset` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-4-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

We have a couple of calls to `git config --unset` that ultimately end up
as no-ops as the configuration variables aren't set (anymore) in the
first place. These calls are mostly intended to recover unconditionally
from tests that may have executed only partially, but they'll ultimately
fail during a normal test run.

This hasn't been a problem until now as we aren't running tests with
`set -e`. This is about to change though, so let's silence the case
where we cannot unset the config keys.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4032-diff-inter-hunk-context.sh | 2 +-
 t/t7508-status.sh                  | 4 ++--
 t/t9138-git-svn-authors-prog.sh    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index bada0cbd32..c98eb6abb2 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -17,7 +17,7 @@ f() {
 
 t() {
 	use_config=
-	git config --unset diff.interHunkContext
+	git config --unset diff.interHunkContext || :
 
 	case $# in
 	4) hunks=$4; cmd="diff -U$3";;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a5e21bf8bf..1167b835a4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -773,8 +773,8 @@ test_expect_success TTY 'status --porcelain ignores color.status' '
 '
 
 # recover unconditionally from color tests
-git config --unset color.status
-git config --unset color.ui
+git config --unset color.status || :
+git config --unset color.ui || :
 
 test_expect_success 'status --porcelain respects -b' '
 
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 784ec7fc2d..5bb38cb23a 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -68,8 +68,8 @@ test_expect_success 'authors-file overrode authors-prog' '
 	)
 '
 
-git --git-dir=x/.git config --unset svn.authorsfile
-git --git-dir=x/.git config --unset svn.authorsprog
+git --git-dir=x/.git config --unset svn.authorsfile || :
+git --git-dir=x/.git config --unset svn.authorsprog || :
 
 test_expect_success 'authors-prog imported user without email' '
 	svn mkdir -m gg --username gg-hermit "$svnrepo"/gg &&

-- 
2.54.0.545.g6539524ca2.dirty

