Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D330F532
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399069; cv=none; b=K+oG6r1p5VNctpq2wwlBqD7FyueEMnep7GIvp2qlKBhL/ojKbhci4NAR9C1vNINI16uFt4tZF/ez2+S1xpT32/7eS3PM+KMRR0Qhb2XOo9m3wfcJbdxZu5lnhLrCafAh9tpn13eUeVFqrNB7DMAwyGxeZzxqOfrvfGF/tv9iQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399069; c=relaxed/simple;
	bh=D0CylemlDHjRPWNKeNGPSe11yTcspeWv+01h+tUT83k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=sMbQsYz8WFZsORuGg2A0tVz6Zbftw+nDPoKyW4GZRB5zZvWV14yoXPDbyq6EFtVMuulcIe8nuL1kATpMmc9k2iHDJbigswQPwIlNLooJwI5UK7p0o1/a9mE3rZ+ce/twvvMslsfeJa9Y9H6/iDhnvIryx0TdAdke1dfnhUDN8Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVtyMKP7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVtyMKP7"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee2014c228so9564061cf.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 09:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763399066; x=1764003866; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xHOUnVSarUYBmDA0w5rw5NoQ3bAcAfE8iATGO2weZhE=;
        b=KVtyMKP73aRT1LELIZbFfF03p34PDaaNyq1/25YoW/yGEwPeUXDtafrdD3K2LveWgL
         7F5HIwARabA6e7PCjagVL7pPYAXB4Kq5dVbwgJ482r0Z2x5UwoAdnCPAYFFtcdBsP1wV
         sLACvZoBAu0JmkQXbmJvGaMduh2KcCjLKAyaHAAm2ZAaI44DNDs259lukB+gWEHPFgOM
         oE1aixY918fsE0sS3Prb3tpDWv5wftRqG/WREHQbhS1JLrvrjTW9IBDJ7D8eECDSQPQO
         qxV/IgyYuUDowW6h3Ae4/8kAFwU0fCBKlve4FPveRJWjezSeBjFk6XDfNi9eIfUB0Sj1
         2qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399066; x=1764003866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHOUnVSarUYBmDA0w5rw5NoQ3bAcAfE8iATGO2weZhE=;
        b=PxpMM4f+o2wjQ3aq5fgHWOlHWntpzv/0yiIufhIESPQ6mlMDsCcYxUqJ1MqjeT/R03
         OxOfq9LSxaFXdN2Yf/TEn+ntV01PHhBKSXoHrLyUwq18PAatsp/YHS9zTXc4y8v2fl6Z
         jWuMqrLwkIFbcMKIhoi/DNxG5I6KJQLs1d8mTfEB8QZX3TD5pQVwjiZSf6DOxBUnsiR7
         eMqw/BTiEJIwqXCP6E7g7mkSBmfaWxwU1MnLTCD+6IdJ10k13byHLmbAIf4UZJSawSwj
         PCvexJxlJDtiIDeMjg6cALiPFZ3WtwbA+ECm2PkK996PVQzoGuQzCTeuJKLNqi658qHu
         um0Q==
X-Gm-Message-State: AOJu0YxPJ7m/13KR8PUsQa61ruxZansdNdtQ7OPinRZmSURL3rlLC8GO
	x6w1fMpTWPR8rHdY8S5iY704RSURNxWkeCcJ9Z9zrc0ckoJzEDkUP9TeLC4djf0C
X-Gm-Gg: ASbGncudLZVM+pppqszX1W8nQSGtxjyoA1EhHT1cWKvOOVh/FuIYBfbBBoCTkys4FCM
	eNMABmtuDgExhRWLxt0jMdcN/woUQcqKTDILSeQCHyWcMFQ+Yu4weBvicd2xvW2h8lNH9HRLIdV
	NTzP0tImkbbE176PGWEfXmKixAJsHbFhRM7Ou7Zv9Usv7bybYMJKAoMdw+3z48pAY7e1ahfA2Dm
	BR4aRkI9Q71nOHWMG4ZiZu5bVFNkVd4nZRnd7fn3miEYlWw4X0qzHVMskCC8MjuxyugsCwQXnM9
	Ps/2KWLFLpFqZb2NUuqr6H0mz1eI81vVm0irfBzxMNNKigLH7Ly8P9G2yxERdVFQGtfNJrv4kPA
	tfPfYmKQ+iXhM6AVME6H5rKYZGT4Sq2hwDMNRFvAb05OyZoZrgNxFfjdG8ZZ+PVfj93lWBoux+S
	6zu4TNxuPxJd4h
X-Google-Smtp-Source: AGHT+IEySxt9seFxRvySyXsBUVCMDBju+4vhDqszpv6KOkaDSSjrrmu0mtAsXKnOYktUkPZsXsP6sg==
X-Received: by 2002:a05:622a:54e:b0:4ed:5f45:42c0 with SMTP id d75a77b69052e-4edf214845cmr170218211cf.62.1763399066114;
        Mon, 17 Nov 2025 09:04:26 -0800 (PST)
Received: from [127.0.0.1] ([20.109.87.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286577cbesm96708786d6.46.2025.11.17.09.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:04:25 -0800 (PST)
Message-Id: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 17:04:24 +0000
Subject: [PATCH] ci(dockerized): do show the result of failing tests again
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The quality of tests/test suites does not show as much when there are no
breakages as in the amount of time required after bugs trigger test
failures before the bugs can be identified, analyzed and resolved.

As such, it is an unfortunate side effect of 2a21098b98a (github: adapt
containerized jobs to be rootless, 2025-01-10) that the output of failed
test cases, which was shown before that change directly in the build
logs, is now no longer shown at all.

The reason is a side effect of trying to run the build and the tests
with permissions other than the `root` user, but without providing the
prerequisite permissions to signal what tests failed and whose output
hence needs to be included in the logs.

The way this signaling works is for the workflow to write into
special-purpose files whose path is specific to the current workflow
step and which can be accessed via the `$GITHUB_ENV` environment
variable, which differs between workflow steps. It is this file that is
missing write permission for the `builder` user that was introduced in
above-mentioned commit.

The solution is simple: make the file world-writable.

Technically, this write permission should be removed after the step has
completed, if proper security practices were to be upheld, but since
nothing uses that file again, it does not matter, and the fix is more
succinct this way.

This commit is best viewed with `--color-words`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(dockerized): do show the result of failing tests again
    
    It has become quite hard to debug CI failures when they happen in one of
    the Dockerized jobs, as the actual test failures are now hidden. This
    was most likely an oversight when 2a21098b98a (github: adapt
    containerized jobs to be rootless, 2025-01-10) was merged in 2bf3c7fab19
    (Merge branch 'ps/ci-misc-updates', 2025-02-06), v2.49.0-rc0~55, and I
    had reported this as a regression in
    https://lore.kernel.org/git/e45b9487-b3ae-ed85-fd07-c92cfbf47cbb@gmx.de/.
    Seeing no movement on my report, and having the pressure of
    newly-failing tests during the v2.52.0-rc0 rebase of Git for Windows, I
    was kind of forced into fixing this in Git for Windows. Here I upstream
    the fix.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2003%2Fdscho%2Ffix-failure-reporting-in-dockerized-ci-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2003/dscho/fix-failure-reporting-in-dockerized-ci-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2003

 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 816d5a34c4..ca7cc2984f 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -433,7 +433,7 @@ jobs:
     - run: ci/install-dependencies.sh
     - run: useradd builder --create-home
     - run: chown -R builder .
-    - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
+    - run: chmod o+w $GITHUB_ENV && sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       run: sudo --preserve-env --set-home --user=builder ci/print-test-failures.sh

base-commit: 621415c8b5371a4734315232a780dd8282f6fe4f
-- 
gitgitgadget
