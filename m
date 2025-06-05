Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2F1DDC1A
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749118611; cv=none; b=Qo7CyTjjtC+mQ5qx2YBrJxeED5hovNSQmb9AWR7B3yc5axTczXdAKqSX0jeOfJqTLtf99IHEQVTTUffzW6GAm4Z11FZKL/19UQzV2YAy54apcegB7nxMCzlm7mWvkY78J3KdCe1SOPn1Zne9rEkjDVM4luP835UopVMlz98/Jng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749118611; c=relaxed/simple;
	bh=VtvBEgYIDLFsoPV2HA7TGj8cpMdKGAM/HVjlfT/cvB0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Z4rmX1QmSCsX/L2nJDzXn48VO1ER2mYNySzRPGEnDFjXK7c6meX8CGkr6FHR6jlbBlt8X0PdGIh7Fylgxn4jp281Ge4K/PqG2uBOXv5AWdDACKs1wKzgEivrQqI9RFKPJUN+cBXUNNRa4vOQFzbiOrPX8wCQAN6pi1lxbZRJ9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0df2oc1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0df2oc1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so8410895e9.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749118607; x=1749723407; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O3DXmB3K00TQgGlJaiuIsTuJ1Jy1l/DG5jjd0QK7QEU=;
        b=c0df2oc1VygPyK/BzCExqhmoswfe/EUrLKRI7WvQhvcuW2AyRIiMgXtgCt9Ir7ZRTQ
         GyuAzb0ARvwaD1Sp1I0ihzH1LF4P0RHWW6cychCBdlS9T3DEN+bD0weBY2DNrAK3YR17
         NfrCeTFw9F4/q0axIlEYXBzvrbD9/3LKUNsrCRLBULXPC58grHIRJCS+xzTYqv1qScWe
         J3/0P8etKcH4D3a6e9pFAhlZ43eF4dnBRWkHFpnVf5R9cblo+coxy4A7fjNx+OBcbbWZ
         n4LSLZApih2aHWn/n0oY8GodITeVSc6DN3rvl1w2ikPwey2Js6s/gRG0T3SXeQqEbEC+
         Tj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749118607; x=1749723407;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3DXmB3K00TQgGlJaiuIsTuJ1Jy1l/DG5jjd0QK7QEU=;
        b=T7eS3qX0VNbd9BjrkDHoMTa38UkiPWR4hl9P5DG4dIGEJL6Cf48+lGR1GGWAALOiJm
         x6rN/kZVVXIafCmR2z5SeUWt/B2fGiL9ZgiVSDy6D/BE2SXrBNmBLbX8wsB1/3ShIr4E
         HSuXpqAgSbc5rJvQ3Kt/LpqiAHJydknmvn6TLlJ6a4p+t7Z9I17eQxUu31Wdq1MW1G3O
         ieVL3fkNTHYuxQzi7bdIzvtFmXV1+d13IjD0l1nHYe03z2PVY+RpMVbIyQh/tkA//I5g
         oHVbgcuN97ZqebCKaXlm/QryC5VwSPNeg/bo7o2tZg7jlQmQzbe0K1yckJC/x330mU2O
         Dtgw==
X-Gm-Message-State: AOJu0Ywr49qbGpgz6QLetqrCF5nscgs3u5yr6iJYhwhss1nyQgmeNw8f
	KL1FavNc70ZN7frDXlNW1UQoWzKw6o/MgIEnO6y1QY3ErIjtz09Jxnd4DtIecA==
X-Gm-Gg: ASbGncum90aRomcI09Kdv7BW9uabTrOPn04SjZmYXkDy0i1SBgIdUS2pAhqQ+RHdajH
	qArmf3A9vF/yAtdYQ8KvgN/d41Z9lGohLCnsDdoA9R79es5i1tSTC4GbAzGyziIL2rFm72P+2jC
	djGDlwOc0OS2vlKKkB5ANtXz7LhXfZs+lsSCc9E3cVGCSyqBwuZLaE+d7U1xE+iuSiZsDe7QJAq
	/9ISG8UCF9fzNVk+6r3LHL0G/VvZPhcSWaJzZq+PoBuOaPGif7JmSyGoX4Z3PrrCtfVsQijMHwY
	GeBZvqAzq8vxhGpB/TQPnwXbLFu1SHxKXk5bjt3rMpw5qXSuRgJs
X-Google-Smtp-Source: AGHT+IGIo+NoS2UrtXc5RJlnaaAmkImjQppknxykOr9gQ7uBSs8bxU8QuAgaop/NsAWAOJ5Mi5NiQw==
X-Received: by 2002:a05:600c:1c15:b0:442:cab1:e092 with SMTP id 5b1f17b1804b1-451f0aa1786mr57906215e9.11.1749118607092;
        Thu, 05 Jun 2025 03:16:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a522ab67dbsm3645916f8f.62.2025.06.05.03.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:16:46 -0700 (PDT)
Message-Id: <pull.1932.git.1749118606047.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Jun 2025 10:16:45 +0000
Subject: [PATCH] t5410: avoid hangs in CI runs in the win+Meson test jobs
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

In the GitHub workflow used in Git's CI builds, the `vs test` jobs use a
subset of a specific revision of Git for Windows' SDK to run Git's test
suite. This revision is validated by another CI workflow to ensure that
said revision _can_ run Git's test suite successfully, skipping buggy
updates in Git for Windows' SDK.

The `win+Meson test` jobs do things differently, quite differently. They
use the Bash of the Git for Windows version that is installed on the
runners to run Git's test suite.

This difference has consequences.

When 68cb0b5253a0 (builtin/receive-pack: add option to skip connectivity
check, 2025-05-20) introduced a test case that uses `tee <file> | git
receive-pack` as `--receive-pack` parameter (imitating an existing
pattern in the same test script), it hit just the sweet spot to trigger
a bug in the MSYS2 runtime shipped in Git for Windows v2.49.0. This
version is the one currently installed on GitHub's runners.

The problem is that the `git receive-pack` process finishes while the
`tee` process does not need to write anything anymore and therefore does
not receive an EOF. Instead, it should receive a SIGPIPE, but the bug in
the MSYS2 runtime prevents that from working as intended. As a
consequence, the `tee` process waits for more input from the `git.exe
send-pack` process but none is coming, and the test script patiently
waits until the 6h timeout hits.

Only every once in a while, the `git receive-pack` process manages to
send an EOF to the `tee` process and no hang occurs. Therefore, the
problem can be worked around by cancelling the clearly-hanging job after
twenty or so minutes and re-running it, repeating the process about half
a dozen times, until the hang was successfully avoided.

This bug in the MSYS2 runtime has been fixed in the meantime, which is
the reason why the same test case causes no problems in the `win test`
and the `vs test` jobs.

This will continue to be the case until the Git for Windows version on
the GitHub runners is upgraded to a version that distributes a newer
MSYS2 runtime version. However, as of time of writing, this _is_ the
latest Git for Windows version, and will be for another 1.5 weeks, until
Git v2.50.0 is scheduled to appear (and shortly thereafter Git for
Windows v2.50.0). Traditionally it takes a while before the runners pick
up the new version.

We could just wait it out, six hours at a time.

Here, I opt for an alternative: Detect the buggy MSYS2 runtime and
simply skip the test case. It's not like the `receive-pack` test cases
are specific to Windows, and even then, to my chagrin the CI runs in
git-for-windows/git spend around ten hours of compute time each and
every time to run the entire test suite on all the platforms, even the
tests that cover cross-platform code, and for Windows alone we do that
three times: with GCC, with MSVC, and with MSVC via Meson. Therefore, I
deem it more than acceptable to skip this test case in one of those
matrices.

For good luck, also the preceding test case is skipped in that scenario,
as it uses the same `--receive-pack=tee <file> | git receive-pack`
pattern, even though I never observed that test case to hang in
practice.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t5410: avoid hangs in CI runs in the win+Meson test jobs
    
    I finally had a chance to look more closely at this problem. Here is my
    alternative to what Patrick proposed in
    https://lore.kernel.org/git/aD7tKfXD7YxprSZh@pks.im/.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1932%2Fdscho%2Ft5410-hangs-in-win%2BMeson-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1932/dscho/t5410-hangs-in-win+Meson-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1932

 t/t5410-receive-pack.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
index f76a22943ef..09d6bfd2a10 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -41,7 +41,19 @@ test_expect_success 'with core.alternateRefsPrefixes' '
 	test_cmp expect actual.haves
 '
 
-test_expect_success 'receive-pack missing objects fails connectivity check' '
+# The `tee.exe` shipped in Git for Windows v2.49.0 is known to hang frequently
+# when spawned from `git.exe` and piping its output to `git.exe`. This seems
+# related to MSYS2 runtime bug fixes regarding the signal handling; Let's just
+# skip the tests that need to exercise this when the faulty MSYS2 runtime is
+# detected; The test cases are exercised enough in other matrix jobs of the CI
+# runs.
+test_lazy_prereq TEE_DOES_NOT_HANG '
+	test_have_prereq !MINGW &&
+	case "$(uname -a)" in *3.5.7-463ebcdc.x86_64*) false;; esac
+'
+
+test_expect_success TEE_DOES_NOT_HANG \
+	'receive-pack missing objects fails connectivity check' '
 	test_when_finished rm -rf repo remote.git setup.git &&
 
 	git init repo &&
@@ -62,7 +74,8 @@ test_expect_success 'receive-pack missing objects fails connectivity check' '
 	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
 '
 
-test_expect_success 'receive-pack missing objects bypasses connectivity check' '
+test_expect_success TEE_DOES_NOT_HANG \
+	'receive-pack missing objects bypasses connectivity check' '
 	test_when_finished rm -rf repo remote.git setup.git &&
 
 	git init repo &&

base-commit: 0d42fbd9a1f30c63cf0359a1c5aaa77020972f72
-- 
gitgitgadget
