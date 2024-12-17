Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB61F6679
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447464; cv=none; b=sgucVR8tul6Wb7/ObU5FhmUFiD21WkSTdml1W5Rz2vXIZ6eRt/cpDAtMjFu8MTzNwAW//Z2AiFat1iXyNuLfxGKe6k1sCUKVXoqU6HMFXFHuY7c4yNrfE3pdGpYSOxypPhyEt8AsSlA54Bdx1qdyx0IFJqA2amPLlfMI/q5mzBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447464; c=relaxed/simple;
	bh=YRFPh1Sy5tSh51PIA5O4NBlUCPpWnYUK5WjIBWhl08c=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GEzP/BZxAEQgkAbxXAHQGvyC6Bz04KaiilA/AxQuUKL8Y0otLADH4U4SNQsAuIMeCZqDrTNLm9OrFFkR5kbz6ns6BPEJfmowhCPyhadZziOzzlAHNZAqEIC9Z+9Ph/HtLAg/gKmRm4hkBtwsFeA8bB8XyzpLg8VZ8Rw4YRxQTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjp8I0GP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjp8I0GP"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso27287585e9.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734447460; x=1735052260; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LjpvCOISvvS8395ruyZuPpNA9wpRc47N2ib/iO3gA4g=;
        b=fjp8I0GPpunH2vd/sfaZlz18iXOdbP0phV6JMJ2tiW8I86Vw38fz4FnRNyvUNnWfLS
         n/AvyEqp6MP976g4TLxagK4Z4nxUQsSnQeFqI5bCL/akjMDQyxJnqpvwCXf02EaXK72G
         W7hEJ17s5i9Jx+n3lc1j/lfxUk5YOhiShwfgC9E0C0QWp+jH2kDulxyiwOGb/IqtwK+D
         VEiIXuH/GogrBT+0fs3v6pZBCYAKO41601drdyVzIytklxbezRi/t/xpg6jVU5tbVvSY
         Gn98H3pluBRIvj4jZazFKxQeu/mEESzhYDbQgpwTKHPU/NWs1enWuWQFSFOuPW3qNefg
         pv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734447460; x=1735052260;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjpvCOISvvS8395ruyZuPpNA9wpRc47N2ib/iO3gA4g=;
        b=dDCvhf8CpOImaCbkLw0LopErBPukfRdhWEsRX+e1kMZNZcRGEioh6+IoYZK6HgS28p
         G2iA7qoWUvEfthRVtEXU5Q2db69o8vemz0iPAon/gedGc07zFwDMdWku3DbeduB8V4Uh
         R9wTRRE0CrT4bK4MeI+wvRQ9lRW9tYhk7MgET2b5Dl0Wcb54C0AwrECzYZ0zHkD8KedV
         InVQE+9TKaPmC4ZPE7oTwSIMvHQrz5mxHaA7dcH/hTxP/Lg85u5um3HBlNSTenvCFYXS
         7hSruIWen3F3L2B+vY/yPGFZTlISEZHJCi8vxGaNeXhGjHPEkptKmk+nAM/gLoznZC4e
         ljlw==
X-Gm-Message-State: AOJu0YyiFqphpjl1XKhfx376EBilndtrJ7l2KRtv1anNMfFO+6t2sAwR
	j6DbiRo1qGB6m4/o2Sv/f1eFeWKsKbGdCQDf20qMGC7VNJOsA6ff76bS2A==
X-Gm-Gg: ASbGnctcHbNk+KLx/tuUCSAn53uEIHTW2o4qdchOoc9kvyTsHDhDQbQXQ81Zcby7HlE
	aKuQdI8/E5hhgZVsg00Wv31bKe0R87BH6YU436vpGJU5TehpC68wURdP1PTs+OyV50VlPszjhGM
	iYSdxeup+gd3yy2Zr0g5mY9ood9fWMjHaVYYmztAgDqKuhgOD51TLfRjRu842rc1AUzHQ42FYER
	DRNElsu54UJaB20CaKwpLp2l7oJ3pVwB0Ueo2DwJ4aieMrsSafmwHHEpg==
X-Google-Smtp-Source: AGHT+IGEG8HKT/n9m8ez5CG4tY/dDtIN4Yk2VFDWBJWE8smw8Q4dwIX+qSlMBcm2f1j9r4EWeElFJg==
X-Received: by 2002:a05:600c:1c07:b0:434:ff25:1988 with SMTP id 5b1f17b1804b1-4362aaa9632mr134134055e9.32.1734447460153;
        Tue, 17 Dec 2024 06:57:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360147desm120147635e9.9.2024.12.17.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:57:39 -0800 (PST)
Message-Id: <pull.1841.git.1734447458896.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 14:57:38 +0000
Subject: [PATCH] GitHub ci(windows): speed up initializing Git for Windows'
 minimal SDK again
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It used to be the case that initializing the minimal SDK (i.e. a
radically slimmed-down subset of Git for Windows' development
environment intended to perform the CI builds and little else) took
a bit over one minute, would then be cached, and subsequent jobs would
take at most half a dozen seconds to initialize said minimal SDK.

It is important that this step is fast because we have to run the test
suite in parallel, in a set of matrix jobs, to offset the slowness of
the shell-based test suite, and each and every job has to initialize the
very same minimal SDK.

While it may sound as if parallelizing the jobs might only waste the
generously-provided build minutes but at least the _wallclock_ time
would pass quick, in reality it matters a lot: Frequently Git for
Windows' or GitGitGadget PRs get stuck waiting for quite a while before
CI builds start because other PRs' builds still spend substantial
amounts of time to run, blocking due to the concurrency limit being
reached.

Since 91839a88277 (ci: create script to set up Git for Windows SDK,
2024-10-09), the situation has worsened: every job that requires the
minimal Git for Windows SDK spends roughly two-and-a-half minutes doing
so.

With the switch away from the GitHub Action `setup-git-for-windows-sdk`,
we incurred more downsides:

- It is no longer possible for said Action to fix problems independently
  from the Git repository, e.g. when new rules about GitHub Actions
  require changes in the way the minimal SDK is initialized.

- The minimal SDK was installed specifically outside of the worktree so
  as not to clutter it nor incur an additional cost to verify that the
  worktree is clean.

Therefore, even if it would be nice to have a shared process between
GitHub and GitLab based CI builds, let's switch the GitHub-based CI back
to the tried-and-tested `setup-git-for-windows-sdk` Action.

This commit partially reverts 91839a88277 (ci: create script to set up
Git for Windows SDK, 2024-10-09).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Speed up the Git for Windows SDK initialization again
    
    While waiting for way too many builds in
    https://github.com/gitgitgadget/git/actions to finish, I noticed that
    the minimal Git for Windows SDK initialization now takes a whopping 2.5
    minutes. That's way too much. It used to take a little over a minute
    when uncached, and 2-5 seconds when cached.
    
    Let's fix this regression by reverting to using the
    setup-git-for-windows-sdk GitHub Action (also because that Action will
    soon see another dramatic speed-up, see
    https://github.com/git-for-windows/setup-git-for-windows-sdk/pull/965).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1841%2Fdscho%2Fci-windows-jobs-speedup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1841/dscho/ci-windows-jobs-speedup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1841

 .github/workflows/main.yml | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9301a1edd6d..916a64b6736 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -113,15 +113,13 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v4
-    - name: setup SDK
-      shell: powershell
-      run: ci/install-sdk.ps1
+    - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: build
-      shell: powershell
+      shell: bash
       env:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
-      run: git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
+      run: . /etc/profile && ci/make-test-artifacts.sh artifacts
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
@@ -149,12 +147,10 @@ jobs:
     - name: extract tracked files and build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
-    - name: setup SDK
-      shell: powershell
-      run: ci/install-sdk.ps1
+    - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: test
-      shell: powershell
-      run: git-sdk/usr/bin/bash.exe -l -c 'ci/run-test-slice.sh ${{matrix.nr}} 10'
+      shell: bash
+      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       shell: bash

base-commit: 631ddbbcbd912530e1b78e5d782e72879f7f1fb2
-- 
gitgitgadget
