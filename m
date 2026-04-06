Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F7336896
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482055; cv=none; b=N6FVp5w4il3QFxXepi2adKJ3txD35/T+UH0/qzDveeRHv33kF0f/hE0ba9pCU45KpR3aIc8Q2v0/hKFSOdO9Jay+YEG2+dr5T24OtP8gXXVA8Baj4PI0+VVj76RMffoiQkIba9VJV3MeOChAGjTRSRsJtzVDxcwhcNMnN50SR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482055; c=relaxed/simple;
	bh=uMAOQo3ctuGHeMUMVoJMS21qQSKBWe+Hksg/J3FNH6k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uRZkrQ5d7YYPYzLqbfNMlpbM8aziRW65btAvSUN0+7uhdgIWmY7bpSWbovFA9BEAOurHp9a8zgkKNV26iLERirikvY0lYGvL9reh2zAtEzxm/CWbMfJEKeYD5kHrWLL5caIeLbguuQe3BnxfpeFFguj7ok/1ahJZL7kPHjwwOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRKU0QGC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRKU0QGC"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d7e7f48499so98668285a.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775482053; x=1776086853; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT44on92J9XgHODOgBD0b3AWDzHxaQFey3FoEwLYK0g=;
        b=kRKU0QGCU+mFcDwDZMjgU43JNdkYd28Cxbm3H1Mvd6bbvmBKX0vHCyg8rIwBdRkQjD
         otntxPZKgicN+YbwG1gN8N7he9s7JhZ+D1g1r+NKCKvuAYlsmq1ovQxGmFPPMTquTn7K
         Hs5swpL5/lYnkE8+ridLvfkxbbupAOaO1RURVlh3Na0pcwenYwkhcDrvXEo5x4TM0J6J
         fTcKt5m0Km60Wj2/A6KaYEpf7PACYaA7npbW0JL/PFzpIvusVx4oYTHfY1HdxIdL4t5J
         akxYvuUJijf5HnQSqaVaxm1e814XdFWJH+DjN0Sr28Sap8T0PjsE6UkMVx/3vKCD26AI
         7jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482053; x=1776086853;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TT44on92J9XgHODOgBD0b3AWDzHxaQFey3FoEwLYK0g=;
        b=T9RXAJnwo2JvJmo+SRFXcpZaGqOKYUCgzYQmDr4ACBV1WLuJilZqxKLPcX2q3p7sxa
         WhKqaek2CcQnVVXseltuLEAQMIzoYCOnrIM1hzNohOeQoFz0nEUsKOuKv/Eaet0oxQZg
         Jh6hQZerevBOYCtSVdGzk2X7XWNBEyIk1tUA4LlhYmIIMgBI6h0sbG2lLaoZDndZxM6s
         uysHqdNfzFtSg+HeyHAL4fWjiqMYLYRRmqf28iVoS7K9/dDVV5Vnj4hok8NFD4ZOfuG9
         7Nt2kCFY44a4ikrJZvHq12+FvA2vpxLDCTHsKrDyFWSd3C6dVEZqHd1wUw97NJycFKCs
         iGFQ==
X-Gm-Message-State: AOJu0YyhEeAp/Cv0QRsa/kexC8hCVXGkl3oc4Ulne0+ZFNs7SVMJPgSi
	USSpICZEHZm3P4U+nObe7WFNSooxXlXHROQiUYcBIth+xc1+fi+66MgUr9JUlWNK
X-Gm-Gg: AeBDievXqQiPbzrxAdtz9fkNcZoCoy0oHft4uj7s0e8X8VtytclYjuSasqiSrgd8oAl
	zR1nTvHQlJxvGNuf+9Ly9BAQynyRjo+irgLW+lzALgIghwLQqvsPo64U/AGLHg4dYwh1oxDJSv8
	rn9kIAo4KirDGCCFOq8faPU7AlUu8LmVvrOvjMIJ432RH7Wlnz9DdeGQBN8EDvkWNAs1WGn3BA/
	rxKevex+CXr0j3Z3WyxRPIrmFfdewQBhUJyHMWgKo2lZ8WtjSKAjS8wtRSWP748QMu/5fjxFwIT
	itOmUcVL+Ii4JLcwMGHNpkz/4Rue2q0+euyRmDcjDB5r64yZFTuRncXBVYTaISKqyH+7ZVGhNUl
	UaDcjUWACHeJzwN+15TmGz+3jN0LucYxha5Be1AcKZ9jKYBElloSIBrDJsHNpJAEWCndxEi2TdV
	0/L7IrbDyB6TLdUiayCiHSoKkEdRo=
X-Received: by 2002:a05:620a:6cc3:b0:8cf:e946:bb56 with SMTP id af79cd13be357-8d41dd404a3mr1716803585a.44.1775482052754;
        Mon, 06 Apr 2026 06:27:32 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d4b8ca0665sm721064885a.3.2026.04.06.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 06:27:31 -0700 (PDT)
Message-Id: <40722d7d13c3f19bc6984c11583ff8136dbeea81.1775482048.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2082.git.1775482048.gitgitgadget@gmail.com>
References: <pull.2082.git.1775482048.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 13:27:27 +0000
Subject: [PATCH 2/3] p6011: add perf test for rev-list --maximal-only
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
Cc: gitster@pobox.com,
    j6t@kdbg.org,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a performance test that compares 'git rev-list --maximal-only'
against 'git merge-base --independent'. These two commands are asking
essentially the same thing, but the rev-list implementation is more
generic and hence slower. These performance tests will demonstrate that
in the current state and also be used to show the equivalence in the
future.

We also add a case with '--since' to force the generic walk logic for
rev-list even when we make that future change to use the merge-base
algorithm on a simple walk.

When run on my copy of git.git, I see these results:

  Test                                      HEAD
  ----------------------------------------------
  6011.2: merge-base --independent          0.03
  6011.3: rev-list --maximal-only           0.06
  6011.4: rev-list --maximal-only --since   0.06

These numbers are low, but the --independent calculation is interesting
due to having a lot of local branches that are actually independent.

Running the same test on a fresh clone of the Linux kernel repository
shows a larger difference between the algorithms, especially because the
--independent algorithm is extremely fast when there are no independent
references selected:

  Test                                      HEAD
  ----------------------------------------------
  6011.2: merge-base --independent          0.00
  6011.3: rev-list --maximal-only           0.70
  6011.4: rev-list --maximal-only --since   0.70

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p6011-rev-list-maximal.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 t/perf/p6011-rev-list-maximal.sh

diff --git a/t/perf/p6011-rev-list-maximal.sh b/t/perf/p6011-rev-list-maximal.sh
new file mode 100755
index 0000000000..e868e83ff8
--- /dev/null
+++ b/t/perf/p6011-rev-list-maximal.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='Test --maximal-only and --independent options'
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'setup' '
+	git for-each-ref --format="%(*objecttype) %(objecttype) %(objectname)" \
+		"refs/heads/*" "refs/tags/*" |
+		sed -n -e "s/^commit commit //p" -e "s/^ commit //p" |
+		head -n 50 >commits &&
+	git commit-graph write --reachable
+'
+
+test_perf 'merge-base --independent' '
+	git merge-base --independent $(cat commits) >/dev/null
+'
+
+test_perf 'rev-list --maximal-only' '
+	git rev-list --maximal-only $(cat commits) >/dev/null
+'
+
+test_perf 'rev-list --maximal-only --since' '
+	git rev-list --maximal-only --since=2000-01-01 $(cat commits) >/dev/null
+'
+
+test_done
-- 
gitgitgadget

