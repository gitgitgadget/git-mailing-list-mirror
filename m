Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1E3C661D
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776479; cv=none; b=iq21BpMNR8LAQ88HHid9UaQ0/jKV+nwyFsFBeHj4Ky21BtGsMMzxjAS9T9of9glEPbY7eQFyZoMoh5XfG9kWTnEDgVF4KlXYYppcKQzTd5sHPdlJN00Lmuf0WdKMcJMX4hXkITCqPG4IeU7dWtOFIGjdjPPu2z11N8kAier4AzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776479; c=relaxed/simple;
	bh=PklfEmxoAvJqyi8+f5+Sxu9kkV8JuWWK6WKx8fPG91M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tvxal3pehz3G9sIonF8mVQpiS3lGO/1Daj/MQk7e3S04slW8iC2+EASD3X+A1xNWEfFFR/DCWVEMeAkiOsymNLrir/1ZORGEhGTu3dTmyJ/4SvwHKebQSFu9FR84s0YmxAZoLUR7l23S/op2Q5HQlZh2T9rTpbYIJPIJ8YcIPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvsPAubE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvsPAubE"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381507c9380so1243266a91.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776478; x=1784381278; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GQFNDJPhUKauBeV38GhmTucgM5hGa2LKuNihWp1xBlk=;
        b=DvsPAubEF+T9kn8vsXYSMjZC5E8v06KJTkZ/shWs6Ro9YGwrVTT18YdU+VkXiSGIJo
         JM8RNxVlIohbGsjT1LMzOlUqjRDfHTBskxt0H5WiODDLQSbt1+6dMTQPNBuPOW6FOHNT
         5Lu1Izq3Sneif7H0mi0vlov54MJ+jtbPh2MgcME86BeRsEOaPod9ZuVNygUkPV60UDcR
         M9/qDmybcVwSnYwfzQnFiC4jGuTFArISO6IdSfq8ViuEFqb3TsUJhAyexoLV7YUdjZyC
         OWmL30nvBDUJqdSiPVHqxonazj23qe8GZz+VSlwDp54r//p7nAe9dheGjoHyYJl+srEM
         mNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776478; x=1784381278;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQFNDJPhUKauBeV38GhmTucgM5hGa2LKuNihWp1xBlk=;
        b=pUso/e0rm3O9KPV/5R763lou8zLgteTpja+IqNkpE6K0E2rIGRwvzWnUly/dfX8uFr
         jvm0bXnnf5mZoIZg9F+yHw50fZxF2c7+0blDDQ6SWMKZbPmerBeLZMxUn4GH/qqp2nxP
         iU7VAVnrlLurQantsXjQ2GPZnsV1epy9/5O1pLS6NPApWtSvhyu3wJWnBkty46z+b6bb
         EzRy4PJYzO2B+sFRENiicf9K7wvIIhfkSgwx3MDlX2m3hfvihMu/0yY3zkv5S5/vCpqv
         zTPreWhWZ5qPS6yTLBIuQV9dTqlB4KK66YdGGN9od7LCZsXepZBmaBgyN7BPtVEYIYdJ
         /goA==
X-Gm-Message-State: AOJu0Yw6EwX3/ny2q2fpZo+3R6huBL184x/dJorSB3QlFsoXOPP6yJCN
	7nPPusihL7VQ0sFY1Lmbh9nuqD8ak2Z37SyINtNKJKvvfzBMJzfFwyG5B5kkNA==
X-Gm-Gg: AfdE7cmybJ8zwUmQ5l+coU41RWH8upDO3UB6wiH+mC9PyUY6NZqriYZE7W7u0URU8+T
	E47eDezel8WZvCGqTlmAmmJuRZbkS1mLcphmn5p5ljJwqoqK3NEHJtd5VtivC2vrQIpYYmrQ4rV
	4aGfgs87Qz2w+yP35jcoEGafBsMzPgK9gKNkZKHA7txk3WsKk0SPc3UGSdbtVpejX0JSua7eRK8
	YhDb8mLzxC0iGpcZzw52cgzhxKmp4XkfLrn7Sh5sM4xjviDQOLBQCkArY6ipCMevUawKqOqEk0A
	8qFJd2XkbHKQUnigW7l5lNAor+yHaoKH7+r04ug+34TrNO9A/8N/JKpy0qHegt9Wt17zTLfJ4IL
	Z5GTfkiaNtwyIvEvmQ2zBiBhF8tPMP2xxmp32NsMbg3YXSNqBASSEF1RBPb6UV9BzwBGN7pVvnJ
	XKJtF8ezAPoOpftu0=
X-Received: by 2002:a17:90b:4a0c:b0:37f:ec5e:12d9 with SMTP id 98e67ed59e1d1-38dc75f6500mr2995041a91.16.1783776477781;
        Sat, 11 Jul 2026 06:27:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm50178734eec.18.2026.07.11.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:27:56 -0700 (PDT)
Message-Id: <d4ecf4b698dc2b3c62600375493fa4b0356a0fbe.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:39 +0000
Subject: [PATCH v6 04/10] t6099, t6600: add side-exhaustion regression tests
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
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
index 8ae6ab6c5f..1b58a49fa3 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -793,6 +793,7 @@ integration_tests = [
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

