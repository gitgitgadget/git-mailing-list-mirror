Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C81EBE
	for <git@vger.kernel.org>; Wed, 15 May 2024 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715742075; cv=none; b=bwLTLdrX14pVOcgjkmP1gVkRCJa/ccx42FxS1kH2qb03vxxP1KYgD0KCzvv5c+Rp5hRqJNHbnoa/IhbhEbZPmeeyVo6rqce77lZE23yzDEpQNYfj95Uc0BQSJqsqdkw33/c/pgn3Fc+hrFX/6NAhMMFICp8ym9r564borIU2JaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715742075; c=relaxed/simple;
	bh=59Gopue0QzWLntsY24owpuBBCHrBghb6kH5FjGAS3Uc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=N+5ZwdYmcGJu24qv9UdMYqcLCnmokDAb9L682JqL3VKgnYdR8d7UNq8GYymxjG0u/zMqIGX0Msb/SDp94s2UqicfDXyVi6FmYQUNcv2kRMzFXreV9xVjiWzBt0aQhPUBTmtl2mOg8rsSZDpyNfbq4DP4dM4rgdinJosuMkGLfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm1sP10k; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm1sP10k"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so29684505e9.3
        for <git@vger.kernel.org>; Tue, 14 May 2024 20:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715742072; x=1716346872; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E7hTUOvSAH0d9M7I5Fn39gKo5RUSKC4qJYCuyZyMZps=;
        b=Pm1sP10kUUR+hIgdA/Z1yhDFrFYy3SMPViuJ2F/8j701+Fa3zrTaXEu2DjQKZCMi0M
         1NvH+9TaJjB7fw8GrnR42Dr8qrxFNxa4sYIEJOGPgivwgLnY0AAQ+eSBBQ3lbyh8OPQp
         71bTZz/wrVXFZuEWch1boAScvJT/vJOqVZmQZoVc1LPwgotbNWuBuBCpVKGuWR3zRsVz
         w44VEr4Df6x3WFD+R6fhu/P2RSZNCoIHerKqC6Y+f5MxVa3Gnh9aSUgOvgPRImrBRB4t
         e3dbyEBsF65j4PMwWFSqPCxbbeF3nbhdHJz/43vQ2/xCAH/SYdbr/VwWzeNavuKkXVmO
         y6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715742072; x=1716346872;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7hTUOvSAH0d9M7I5Fn39gKo5RUSKC4qJYCuyZyMZps=;
        b=hf2rfUdu3e1tolByxwQxkHPo39v2Jypun8SahrWdi7hq/qI84ByVrJzZkRzaOviV6U
         fH9K6j0xPKQLiHD4B1/yGkFGETtr8rzJt6zF0mr6GwA3QmL0O8Ha492t+dbIr4yBtCKo
         qNZbo7c95kLrDx0eWq7uo3DfiE593G7LuzrLZPx61KMVMYj+PtJpItEfCIRz6LBCR/7Z
         +ErmYcXcn0vpSMe+8YX22SpNo5mVvyAGWrqD6W/BYBrNVM0Uj0bEB6Fq2+VTSBpghQ//
         PAe3tUeKGetihKZWZ0q/iK0xtVNsHNjDqL2YY+W1taEdx3omyv6H53dv31e1tLj6jX/B
         Lq/A==
X-Gm-Message-State: AOJu0YyqsjB40wbiHkINiIxpVOQwBGUuv3coUl4cYHvIaDw7cV/OyJQr
	KEXoW/oRiGE6ali7r0YHnc+d8c0WPyHjBiv3Ahx/zaU9aAlXIJDOw6xNZA==
X-Google-Smtp-Source: AGHT+IGtA9uSaxeun4Yn73TeQtIHzkqVLPVOS70H18TpF2TDL8mBMtCAsxx8ezH7eqy0cHGH2CftXw==
X-Received: by 2002:a05:600c:a45:b0:416:bc18:2a00 with SMTP id 5b1f17b1804b1-41feac5a4d9mr124304085e9.38.1715742071613;
        Tue, 14 May 2024 20:01:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013c5fa61sm109012795e9.40.2024.05.14.20.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 20:01:11 -0700 (PDT)
Message-Id: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 May 2024 03:01:09 +0000
Subject: [PATCH] bundle-uri: refresh packed_git if unbundle succeed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

When using the bundle-uri mechanism with a bundle list containing
multiple interrelated bundles, we encountered a bug where tips from
downloaded bundles were not being discovered, resulting in rather slow
clones. This was particularly problematic when employing the heuristic
`creationTokens`.

And this is easy to reproduce. Suppose we have a repository with a
single branch `main` pointing to commit `A`, firstly we create a base
bundle with

  git bundle create base.bundle main

Then let's add a new commit `B` on top of `A`, so that an incremental
bundle for `main` can be created with

  git bundle create incr.bundle A..main

Now we can generate a bundle list with the following content:

  [bundle]
      version = 1
      mode = all
      heuristic = creationToken

  [bundle "base"]
      uri = base.bundle
      creationToken = 1

  [bundle "incr"]
      uri = incr.bundle
      creationToken = 2

A fresh clone with the bundle list above would give the expected
`refs/bundles/main` pointing at `B` in new repository, in other words we
already had everything locally from the bundles, but git would still
download everything from server as if we got nothing.

So why the `refs/bundles/main` is not discovered? After some digging I
found that:

1. when unbundling a downloaded bundle, a `verify_bundle` is called to
   check its prerequisites if any. The verify procedure would find oids
   so `packed_git` is initialized.

2. after unbundled all bundles, we would enter `do_fetch_pack_v2`,
   during which `mark_complete_and_common_ref` and `mark_tips` would
   find oids with `OBJECT_INFO_QUICK` flag set, so no new packs would be
   enlisted if `packed_git` has already initialized in 1.

Back to the example above, when unbunding `incr.bundle`, `base.pack` is
enlisted to `packed_git` bacause of the prerequisites to verify. Then we
can not find `B` for negotiation at a latter time bacause `B` exists in
`incr.pack` which is not enlisted in `packed_git`.

This commit fixes this by adding a `reprepare_packed_git` call for every
successfully unbundled bundle, which ensures to enlist all generated
packs from bundle uri. And a set of negotiation related tests are added.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
    bundle-uri: refresh packed_git if unbundle succeed

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2Fblanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blanet/xx/bundle-uri-bug-using-bundle-list-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1730

 bundle-uri.c                |   3 +
 t/t5558-clone-bundle-uri.sh | 129 ++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index ca32050a78f..2b9d36cfd8e 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "run-command.h"
 #include "hashmap.h"
+#include "packfile.h"
 #include "pkt-line.h"
 #include "config.h"
 #include "remote.h"
@@ -376,6 +377,8 @@ static int unbundle_from_file(struct repository *r, const char *file)
 			       VERIFY_BUNDLE_QUIET)))
 		return 1;
 
+	reprepare_packed_git(r);
+
 	/*
 	 * Convert all refs/heads/ from the bundle into refs/bundles/
 	 * in the local repository.
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 1ca5f745e73..a5b04d6f187 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -20,7 +20,10 @@ test_expect_success 'fail to clone from non-bundle file' '
 test_expect_success 'create bundle' '
 	git init clone-from &&
 	git -C clone-from checkout -b topic &&
+
 	test_commit -C clone-from A &&
+	git -C clone-from bundle create A.bundle topic &&
+
 	test_commit -C clone-from B &&
 	git -C clone-from bundle create B.bundle topic
 '
@@ -259,6 +262,132 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	! grep "refs/bundles/" refs
 '
 
+#########################################################################
+# Clone negotiation related tests begin here
+
+test_expect_success 'negotiation: bundle with part of wanted commits' '
+	test_when_finished rm -rf trace*.txt &&
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="clone-from/A.bundle" \
+		clone-from nego-bundle-part &&
+	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/topic
+	EOF
+	test_cmp expect actual &&
+	# Ensure that refs/bundles/topic are sent as "have".
+	grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle with all wanted commits' '
+	test_when_finished rm -rf trace*.txt &&
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --single-branch --branch=topic --no-tags \
+		--bundle-uri="clone-from/B.bundle" \
+		clone-from nego-bundle-all &&
+	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/topic
+	EOF
+	test_cmp expect actual &&
+	# We already have all needed commits so no "want" needed.
+	! grep "clone> want " trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list (no heuristic)' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-no-heuristic &&
+
+	git -C nego-bundle-list-no-heuristic for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	grep "clone> have $(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list (creationToken)' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-heuristic &&
+
+	git -C nego-bundle-list-heuristic for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	grep "clone> have $(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list with all wanted commits' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --single-branch --branch=left --no-tags \
+		--bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-all &&
+
+	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	# We already have all needed commits so no "want" needed.
+	! grep "clone> want " trace-packet.txt
+'
+
 #########################################################################
 # HTTP tests begin here
 

base-commit: 83f1add914c6b4682de1e944ec0d1ac043d53d78
-- 
gitgitgadget
