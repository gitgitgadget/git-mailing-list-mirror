Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551EE442B15
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014000; cv=none; b=huGkhdyvxnWf+tpI/FLw63ifY9ZjyWt/rtiGjleRfMfCk8TOJJlMpdl7kkdPuVGmVUq27TwakwgcjzDwofef0qWDo1Wr4qC0h8bSE2ukrLWKZ5DBRSYpAf+Beu9fMzCZeNVfWfM3+JbOsMopW0EBaycbdyDx410IFOui8u39d/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014000; c=relaxed/simple;
	bh=PDza2154CGvWRJo9a1h/wh1FGsIzj+S76JHBEU4Senw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MClFc6zrg9RzUkzz/nTlKqlJRyE6quMlLLsN+MAJETs+YgukElEnir9C1+xZc0C4gUlfdOAuEldHo87nj4ppiY8BvVUqUW3vfNP7g3H3Q1I7mx2lY3A0dOWkWINVX1tTzShnf3Vbr1o2XpTXFTqVrSMQWMu/VX6YFudIwUsUlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUrUglyR; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUrUglyR"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-821106b5b64so16279167b3.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786013998; x=1786618798; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=axcIpIrNqCyKBV8bI7cr9I68bg6DRy2j1axWNyNC25Q=;
        b=SUrUglyR7EawEYSOykC8WcvFz4mxRPJkA09C/bes7d2D4Kxcly6gFc54M7DLmcOebz
         dj7ZoxKRVHkPxHqLEovEGoUwUtlBenlsiPbqRFchC5Zxc+GnucSmzGPBIQEtTOgIx+I0
         mrTacwc187XZju31nJInjvguXTt/YwHrTJrCAHd7U0B856gy4sWgMGSmcjS17eVAbxm8
         jvNYVF0mAl9TthnX/9TZbeLIAKRwGg1I6rpicPcZtiWcnkY7fzy5oAXQ2THvAix2NxVP
         Anm9B6fahvZJymvNZ66KmSG0c3iqO5giAvj3jLcLDKmhTwB8DoNQNZgs70LBgzQEL3HJ
         j6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013998; x=1786618798;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=axcIpIrNqCyKBV8bI7cr9I68bg6DRy2j1axWNyNC25Q=;
        b=fGTx7ze5mwKOk6tKn/51F+NYyCGp40IU2tmqQeURiN4uj27OdM33WhLq1Aniy3JN6e
         lYwXpLawMwG/7J0S6kqTvBAelYb4tIWuehKIo6gMBQ45EfV8kgbH3ryHozpCK30vfBPG
         i7EKCGpqZt4ppM8n2IWUuon4eGwh+HRiCD11xUXRsInNiOWQWmOftUJYddqVz894M+9y
         Fx3h3MQhueQoWbRSQCDhNacMtRIAmrwsfk2p7KVhm969+ftS7MjpHGR+UcUtDkRKK2H6
         KjFoKv2wBuYJ5WEMMWvdG42Tw7zQjB2PSKXzX4hLZY+o7YVsE3XRAFrW/LTsq284uXxR
         vT3Q==
X-Gm-Message-State: AOJu0YxOen0I125puCrc3153mKt7MXopEhKw6/Pn3x9QtVnadfkcE2Iv
	2jSMLk7Ja6zTcT6Hj+5eHKRRZQ7S2dQMykH+oOvz+fc2w1OaD3u5hzrzUTjgVA==
X-Gm-Gg: AR+sD12H1Cq5rnR7VhLFd6oF2fNkZo/L7FVstH0H1rjI2FLWTkEwCT+5CVLumffXFN/
	+wJPLUtzuJIcev5935Od3MppaKx2Oge2B3s1Dkr6MHnHU7RkhEe/NmPJ2jF/7+edw725IHz6ovj
	GKj5RVK3/udjB2gvBOHmj9Frp7RkjFxpvYkwSbULQzJ6RprEYr0IRTcQI7Z9DnLj7zXaqYbxjzD
	su6+ixbKbrmozGm/a3uInepaa7wwLhvc6fcT1jIb1GAz6TX/c1sHZMeIBHE9adPyvmaND81FfIO
	n52F7WrXui9e4uuvcwopMy4F00iTPEKQIskZ8HQA0CsewTr8k5nG8D43uMAj5x/TuU7NihpDMrb
	W5+JKzQmGaOst9HixCy4Ed5WieORFhidAYL3x+qVBm1cmB5mtb8h1nh2vw7QCVXboY719w2yo4+
	1wmRN0O6HVOJi/BOElqhpGQyidbtpv8lhzdgkkeYAwyk17guWt0IKrK2P/M4+dEe0=
X-Received: by 2002:a05:690c:998a:b0:81e:fc6c:452c with SMTP id 00721157ae682-8213b3bdebcmr20432747b3.9.1786013998239;
        Thu, 06 Aug 2026 03:59:58 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201323141bsm36850817b3.15.2026.08.06.03.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:59:57 -0700 (PDT)
Message-Id: <e8565ce0203e7f94f3f1ac193eb1fd703fe50463.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:35 +0000
Subject: [PATCH v7 04/10] t6099, t6600: add side-exhaustion regression tests
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
index a25f37d2f5..655c94f860 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -795,6 +795,7 @@ integration_tests = [
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

