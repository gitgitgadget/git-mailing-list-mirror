Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1E36E473
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923844; cv=none; b=Y3IV4nEgdkaF/N+ea4FcLjoOvlsyCcybOMop1pVGknUqboEUaognaVAxIbHkklv7A1wYbz64BlpL7qEFAP5WxrbIpdRn+TqiOzbRbVct3DQr23QDU2crPrX4zJjoazDvIprX2hnR96RkLG6f9lZo3HoGFK4EbHRqO4vmkSU8m9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923844; c=relaxed/simple;
	bh=9Zagv7/sYzjp+QfGUVkn46k++2vVmSAN1C5lFUkjVU8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GAG2XmhV3TliTDSGADB6H+4cH9w6ur39nO4dOp/0l/ufpEXvk05Wd4XBhlOow/ycaEpbErZ0agtPcy5PfJDR+j/f3LbOCtiOJH//JKkcj1zY5plG8ZKDXXbH8lsXPE84qqUpTBkww1I1m4u1HaCsJRYSftpry89ldsF/5lK3obs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku5qTgWM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku5qTgWM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9e89fded0so7346045ad.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923842; x=1783528642; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zQkpWBAzqZxY0QUNGlqZ5Mnv3870qRbFuHpksDmWVek=;
        b=ku5qTgWM5rwFp93rFGu7q3ZfRkKbsMXMaZ7dg9lWvN4Xj99y4adjPDlnyS3TLK2pfu
         nkMKdpJSLVr54F1fgTtm+iI8gdzpPCOz/zNutCzbt91LNO4uI7FVmklSgH//G/ldeIyA
         BycaNb/WuGFtxuMTTRKm96LdZJ2w3BbPZdLAS8pqmymb3W88whVEUEUyO35304Z+pF5T
         EEWSaVsEfFxHKLoKZKFTYASLws/2/DQNkCyld+eOR/DLDOZELKVKnp2km4QE+D7Hsegj
         tLZDu5GAjUD5EDTiHJp3IgyjCIutg3xbx67Ms5IgHYlftpc31lsWTiQjr9MLF2bfyN0k
         ihig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923842; x=1783528642;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQkpWBAzqZxY0QUNGlqZ5Mnv3870qRbFuHpksDmWVek=;
        b=Dx2TuW6DmyhK3s0k+HcINbRM8CL2FX5cgQEAijTwt7tdn0sIVnO7w4cs3QH3I5I9A8
         2gH5wNKqSi0zVuiMd92XwqdjidaG3/8r+kaJ4VPpHzrd2YPbxAKhMv5sjOrKp3Bd3NLa
         ozbJeujeOZW53PfRA2TtcluBVNP7MigEv+r1ZTN3bqOxZeU7BHaZdt+pSxaJvpfaS+p0
         l3OqX6yGCvVlqAnzt8o2Ju7HscBj72Bx1SuaECNp6rzcfA0fQNxATtVWDDBqzaKoyRFI
         dlxUWW9LbdySRGV/Gxv53huRcQha8cGvdwBxFGnNgrGT8JAK4zcaKKVy/kqXh27mzSso
         qo9g==
X-Gm-Message-State: AOJu0Yxrw4SdsAP9a+jLOqx83cdf7TOQJ8eQwV2hgr6WULR0jEvEUIW4
	CW62HWcLhLZ9JG3V4KRYWszsC3am1qGhFYPv9xVGArthn2jazvDlnZ0nTlOxqA==
X-Gm-Gg: AfdE7ckxpjQmRYF8rdaFU1ITfhgGgDwiIMbn5IQ7M8o/YTKJw2D5yE8pz3qnkm4sQbd
	WEmmHvvOHPPxYLU1qKSgYjMEnrlxBCtE3hZcycnWEewIMz4APLv++Dtfj5hMUgrUj/qYhw5T9Wq
	DGSEmeH2P7+8BDgFBraCuEzNeuhz1CrhKLtP0MMMDgel2u7qNCIX+o4jbT5JLGBzw8xk9usncTU
	4hbPc9zAR0E5KpeCxSRrv4pRuEtyTQDzwVsS7qntlIFnnnUGEa8VpqCWI2ffGphEWX+mDApcL32
	kD2kUQuNNWkkVaa8bbGWoDiZbHgV3exkex5l0ZBIYZT6NLDh6Zfo+ZepCUErzdwOLa28jHJo/LZ
	n+etaNlS9Yz1+McUWu9S1U2W8DZssBUitfbT0SjazOUf+Owf0F/ElNM+g5p6bfchIEq9M+dIp8S
	YVpzbC0hKgOTKJlxQ=
X-Received: by 2002:a17:903:26cd:b0:2ca:3e3f:4956 with SMTP id d9443c01a7336-2ca9123c090mr12631485ad.44.1782923841679;
        Wed, 01 Jul 2026 09:37:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dae49sm890715ad.10.2026.07.01.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:20 -0700 (PDT)
Message-Id: <7f0efe6c738d3ec9e8d027b3b1d7c049080b7ee6.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:05 +0000
Subject: [PATCH v5 04/10] t6099, t6600: add side-exhaustion regression tests
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add t6099 to test the case where multiple merge-base candidates exist
and one is an ancestor of another. This exercises the side-exhaustion
optimization in paint_down_to_common together with the
remove_redundant safety net in get_merge_bases_many_0.

Add a mixed finite/INFINITY test to t6600 where one tip is outside
the commit-graph (INFINITY generation) and the other is inside.
This exercises the region transition: the walk starts in the
INFINITY region where side-exhaustion is disabled, then crosses
into the finite region where it can fire.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/meson.build                         |  1 +
 t/t6099-merge-base-side-exhaustion.sh | 82 +++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh

diff --git a/t/meson.build b/t/meson.build
index 3219264fe7..ee6ebdffb9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -786,6 +786,7 @@ integration_tests = [
   't6041-bisect-submodule.sh',
   't6050-replace.sh',
   't6060-merge-index.sh',
+  't6099-merge-base-side-exhaustion.sh',
   't6100-rev-list-in-order.sh',
   't6101-rev-parse-parents.sh',
   't6102-rev-list-unexpected-objects.sh',
diff --git a/t/t6099-merge-base-side-exhaustion.sh b/t/t6099-merge-base-side-exhaustion.sh
new file mode 100755
index 0000000000..4f1e0d50ef
--- /dev/null
+++ b/t/t6099-merge-base-side-exhaustion.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='merge-base with ancestor among merge-base candidates
+
+Test that merge-base --all correctly handles cases where
+multiple merge-base candidates exist and one is an ancestor
+of another. The side-exhaustion optimization in
+paint_down_to_common may exit before STALE propagation
+removes the ancestor, but remove_redundant catches it.
+
+Graph shape (parents are below children):
+
+   A ----------- X
+   |\           /|
+   | B---------/ |
+   | |           |
+   e2 \         f2
+   |   |         |
+   e1 d1        f1
+    \  |        /
+     \ |       /
+      \|      /
+       C
+
+A and X are the two tips.
+B and C are both reachable from A and X.
+B reaches C through d1.
+Only B should appear in merge-base --all output.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup ancestor merge-base candidate' '
+	test_commit C &&
+
+	git checkout -b d-chain HEAD &&
+	test_commit d1 &&
+	test_commit B &&
+
+	git checkout -b e-path C &&
+	test_commit e1 &&
+	test_commit e2 &&
+
+	git checkout -b f-path C &&
+	test_commit f1 &&
+	test_commit f2 &&
+
+	git checkout -b branch-A e-path &&
+	test_merge A B &&
+
+	git checkout -b branch-X f-path &&
+	test_merge X B &&
+
+	git commit-graph write --reachable
+'
+
+test_expect_success 'merge-base --all excludes ancestor candidate' '
+	git rev-parse B >expected &&
+	git merge-base --all A X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge-base (single) finds shallowest' '
+	git rev-parse B >expected &&
+	git merge-base A X >actual &&
+	test_cmp expected actual
+'
+
+# Without commit-graph: generation numbers are INFINITY,
+# side-exhaustion optimization does not fire.
+test_expect_success 'merge-base --all without commit-graph' '
+	rm -f .git/objects/info/commit-graph &&
+	git rev-parse B >expected &&
+	git merge-base --all A X >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
gitgitgadget

