Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F633C53C
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223936; cv=pass; b=bvAy5oyUz3nc95wImjJQf1eTMlMSi5xFNUB1rXjoT2WPeJpWCI3TwWkGuiHSBpn/Sj1BDzlgIS1Z9Sjm+4G8zaGQbMQxO8gh+335qEQ02UvNrTXSdpZI+WtaHYM2y8xENOzxSBCZVjtsVc/iF0a4ilyA30tTr2pN6ucHbPnrf+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223936; c=relaxed/simple;
	bh=y4boxCTgQ7EZ+/Z+s8mJ9i23FQqZGkpqBNJ21aaZ7/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zqu1iT2iobiezJRz5MU6178SxOb67K3uyxmJTSvOAI5+L5yTZkLgUyVsx0MGzJTF0iiDcPIWV6prtiJWfFqmqWo2/0gPgwMdfoRxgzcA8vlNXGmb0CaHmdCixLe+q6QFAEK430hRYNgAp1n8l+mFT4vqYp0L6A/SzzlZX35OzYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Zt6Q4ATO; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Zt6Q4ATO"
ARC-Seal: i=1; a=rsa-sha256; t=1770223914; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oKvQsRHF5CZHTbLwV3WgZFdVSGhL6VMZODIRl/lX5xlJ4vo84KEYW+4YoIHCQc+CUIGrvAm2nGHiB/nMywk7pEE9GTrJMu5TFY+pnPEs4Z1Kq+fVIIAp+N77aIB1rsX2Z0qlXImnwUxoO721OMFy4ZjqrHcSnC8zW2IdqxkvokI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770223914; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0DuQ0VOWxhXAr9S51gF3D11RqD/35QE0bTcdok9NWVU=; 
	b=QVSO2YtGaNPioKegWjG385UCcOW29aK/c92YxfqC5eVBx/nKyeAGQPEg514i/gxy7kHsOrGV8Z+SKtUCggltypRn2/S+mjovDOc6a1iF7+OGYixkkI+pSwoZLGOnJQXkdBcCIoZSC5CMmIn6AR1j2QQR8L1lOLjKS+6Hs6lX15E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770223913;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0DuQ0VOWxhXAr9S51gF3D11RqD/35QE0bTcdok9NWVU=;
	b=Zt6Q4ATOWHB7/WwR5zRW8e6DOfBf44BrFwfYsq2R7RK0iGAuPUk4NJVae1IuTL8H
	eIwEP6Sjbo6PLBoHoDElRhiff7+q2GTpb1PUtpW9aLcIJe+n13HW9lfDOXzX4hzsapa
	XMRgm1s5+6aOv3V4iFCLvRTMjwGW01kXUrAbsa5Y=
Received: by mx.zohomail.com with SMTPS id 1770223911721593.943009189652;
	Wed, 4 Feb 2026 08:51:51 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH 4/4] hook: allow out-of-repo 'git hook' invocations
Date: Wed,  4 Feb 2026 18:51:26 +0200
Message-ID: <20260204165126.1548805-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Since hooks can now be supplied via the config, and a config can be
present without a gitdir via the global and system configs, we can start
to allow 'git hook run' to occur without a gitdir. This enables us to do
things like run sendemail-validate hooks when running 'git send-email'
from a nongit directory.

It still doesn't make sense to look for hooks in the hookdir in nongit
repos, though, as there is no hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 git.c           |  2 +-
 t/t1800-hook.sh | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index c5fad56813..a9e462ee32 100644
--- a/git.c
+++ b/git.c
@@ -586,7 +586,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
-	{ "hook", cmd_hook, RUN_SETUP },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index bc4862e982..21ff6a68f0 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -102,12 +102,18 @@ test_expect_success 'git hook run -- pass arguments' '
 	test_cmp expect actual
 '
 
-test_expect_success 'git hook run -- out-of-repo runs excluded' '
-	test_hook test-hook <<-EOF &&
-	echo Test hook
-	EOF
+test_expect_success 'git hook run: out-of-repo runs execute global hooks' '
+	test_config_global hook.global-hook.event test-hook --add &&
+	test_config_global hook.global-hook.command "echo no repo no problems" --add &&
 
-	nongit test_must_fail git hook run test-hook
+	echo "global-hook" >expect &&
+	nongit git hook list test-hook >actual &&
+	test_cmp expect actual &&
+
+	echo "no repo no problems" >expect &&
+
+	nongit git hook run test-hook 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
-- 
2.52.0.732.gb351b5166d.dirty

