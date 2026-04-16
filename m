Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1131618B
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338387; cv=none; b=kVLQpdtOYAcZvmvOG045VDkgmf8Jrj6nUmq/TsbvIXQfuCKYLJ0+GyQvP2SVOPXThVfqMIi22rRBqRQ17QH99jJPXtBc15esfEXKQYxEOrPvQZ228S19Ck7VsaNRcku9pn8MqZxAdzTCQMLnh9wwK10dn8JsnGSbpYuH48Sx9nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338387; c=relaxed/simple;
	bh=qV6eEGupNGMd6U2yofUnR2s3tmdDSx9rBLB+S7CCkOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkZyu7UZYYqq1A6KQh1Z/VfVKcBm92Jq9qu+phh32H5rTGgYKvQWS5TRh79WsDq6egzZzVHM/hxGhT7uAcBjco/pnuoKZbL14IIByOAlRmnNLHLlydRP8HY8zTdyBGFTca1vVXvplIX+Q9eN75ZsV4t8rk4jLmfm51NYrp02Jx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SZbQTpuu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Etwd7EIJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SZbQTpuu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Etwd7EIJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CDCB7A02B4;
	Thu, 16 Apr 2026 07:19:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 07:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338385;
	 x=1776424785; bh=udKANwLh2mEDENOzM7ntj3nLyIThxAX53mSdIku/7ds=; b=
	SZbQTpuuTP/+yIQNRa/qKCeEn25CLacMgE9r8ZAibf2Srulv+aXDENZtXE1dx8on
	7zgRGU6mqxK5NZXEK4ioMOm16ZWiNuqMOzgVpk2w2PK6G9rC1D7Ir/MYNLdqWjxH
	37DYb0h9opLK/Lv8RmNEDs/fHi2wIadxPA0qj4mCtyMDNUsyEL9fx9oJqTWbZTEl
	lOK+dYfMy8ZWt6cIQBl7VeUecnCEfZJRHqMQwdqvAUIxQ/HSCEBlpoPLdwo7gN1F
	HFR7Fm7UyG2l8WkOCYHiMgaFpdZmj72k+ZJaCljKeBNxHwlA8nsF5vJyDJyz4e5o
	ZvR8g7+FJ56W+8/xjfN43A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338385; x=
	1776424785; bh=udKANwLh2mEDENOzM7ntj3nLyIThxAX53mSdIku/7ds=; b=E
	twd7EIJGX3tKK6AsvyfBj+dM80Bep77GbTxvRe3B8oI2a5aw4ctx6YUv8hEpwv1A
	+WUdlezzCE1EONtTXWLBMuEbIySH7n3eObga9pfpn9b7S9YRDkSvQs9w/cP44+05
	Z0/Ome+rhFszl3Z19tqCPAUgclZ4KHy0YqWfL+EGNmhT7cQCoMprJ+LjGYN7riTW
	CjWrBVHjQEGAObGacPDP9zILR9uRpmxb84uGTRgRBO4CrcbA+WhA5SjAA2UYlOxw
	BNtqxjZpM/VK0mm7NkwsoNJFgql8e3LF98NgApjJL2GKdBAtepb5wsz+tx6c8Amg
	1m3c/tCHzPT9zIqFUZKyA==
X-ME-Sender: <xms:0cXgafimniK5v3yjZ3OHdtF3vcihjqSYdX6VKAzpOzHul-lR0ldV9A>
    <xme:0cXgaTffAfbecD8DF88XlXXa2rUcCGHNUM5nqGHWmyzn7_XaEvUXQPgCCo5TEpyWW
    9sh6ZuHvMYrMEpoit9YWLUN2iqRuU-6pt6HxcDITN26mP_MFS5kDA>
X-ME-Received: <xmr:0cXgacd8iRoOhrXc-5YPSStlx43cq8_4cw_ZViV9pDLsL3Lset00MlzTeZ2G3eRZyCr6DB7Vj45dtWZVqPRLaRPSnJFt9YrOyozylqBncQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:0cXgaV9u41SE2l7ceGPlkcqQQCY6GiGEYXRsKiTwEfuxpnF_DhCBIg>
    <xmx:0cXgaQnU9AVvn_oClS_VbzZzswQh-YmcyftBqTSQMQc9O1_6qENsJQ>
    <xmx:0cXgaf_em9B8IPj7eV_pbfFMaS7eI252HKM6Kw9tGjydNAoLHPVBwA>
    <xmx:0cXgaWkWnv9jBQfAwKzXmc_5CG892vfZtLVke0xG5_uUQV7gyQNz_A>
    <xmx:0cXgaeMGu6LlV71BCbzx3NVYmduI0EWY4zg_eMCaYuKkGy6vlG7AdxAp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:19:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 523464aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:19:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:22 +0200
Subject: [PATCH v3 05/12] t: prepare conditional test execution for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-5-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

We have some test in our test suite where we use the pattern of
`test ... && test_expect_succeess` to conditionally execute a test. The
problem is that when we decide to not execute the test, we'll indeed
skip the test, but the overall statement will also be unsuccessful. This
will become a problem once we enable `set -e`.

Prepare for this future by turning this into a proper conditional, which
is also a bit easier to read overall.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4032-diff-inter-hunk-context.sh | 12 +++++++-----
 t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index c98eb6abb2..2d216fb70f 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -40,11 +40,13 @@ t() {
 		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
 	"
 
-	test -f $expected &&
-	test_expect_success "$label: check output" "
-		git $cmd $file | grep -v '^index ' >actual &&
-		test_cmp $expected actual
-	"
+	if test -f $expected
+	then
+		test_expect_success "$label: check output" "
+			git $cmd $file | grep -v '^index ' >actual &&
+			test_cmp $expected actual
+		"
+	fi
 }
 
 cat <<EOF >expected.f1.0.1 || exit 1
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index f512eed278..8cc86522b2 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -220,17 +220,19 @@ check_dotx_symlink () {
 		)
 	'
 
-	test -n "$refuse_index" &&
-	test_expect_success "refuse to load symlinked $name into index ($type)" '
-		test_must_fail \
-			git -C $dir \
-			    -c core.protectntfs \
-			    -c core.protecthfs \
-			    read-tree $tree 2>err &&
-		grep "invalid path.*$name" err &&
-		git -C $dir ls-files -s >out &&
-		test_must_be_empty out
-	'
+	if test -n "$refuse_index"
+	then
+		test_expect_success "refuse to load symlinked $name into index ($type)" '
+			test_must_fail \
+				git -C $dir \
+				    -c core.protectntfs \
+				    -c core.protecthfs \
+				    read-tree $tree 2>err &&
+			grep "invalid path.*$name" err &&
+			git -C $dir ls-files -s >out &&
+			test_must_be_empty out
+		'
+	fi
 }
 
 check_dotx_symlink gitmodules vanilla .gitmodules

-- 
2.54.0.rc2.529.gd9106f7525.dirty

