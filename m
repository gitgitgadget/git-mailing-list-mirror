Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6B3AFCE8
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788087565; cv=none; b=FLNbcrA+jaJvBd/TRF7P1AWJlOUTZa1NgoGcN2zMPXUsGR+Um878NhzDHE+LfX/NL4LEaB7a/M4Wtzynazl7faMRfj9ACPwQTWQBZLYu9MisgLbfj53ZmFu+dWlzVhsrz0VOC0RF6Uk4pJSzFKHbOX8x8WG8Z0G0acwxhDKli2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788087565; c=relaxed/simple;
	bh=CfXrv1L++34nJMlcfBMHOIRXaC4xP+ZjM3seyf7+pIo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RO1Rcv2xAHOdq1jPCktLlJH1wXndw2r8VsZng8dXTkWR2qHiSog1HdZ6juaWxo01GnRAgPYBK8nXc9b4BcuqWUdfotTy4RT/n4AcvK7ZmFTmCpYCDtIEqdhBz/wg//tzUw9nvHqfzlGoRrwsxl5NZG63PPZHgBIHH6y0cDUzPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSx7Zn+d; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSx7Zn+d"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d71ae3455aso39384555ad.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2026 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788087563; x=1788692363; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x3KwigwgukVSTiElH3abPdJ9+hHKmc9al0eb5r55dI0=;
        b=aSx7Zn+dhQ9iI8cfAyY+XE44Nm4c++BigVr21LxMZVKHu2DfJrg2im/zZfwp6WC68X
         l42X9M44YRbhUwZZJIuPhcwte80/vakioLzjdKyGGXXgrMBuHLYJy6HGMqqyFpqGKIIe
         5ZXEitKLIsOrbiwhjSZJzRtYnH0lScHyvOetOorSdUClazmRSrwt5rWM4wDcDSE2YWb3
         Q6KHPnD2cooMmZg13k/ZtqC+g1+v5q4cqTywWs8WHLwPCpw1Bg1npuQLbJAns7G2xW68
         gYsqlJJI7893BpnoFlK3BbLWia9vcoks9hs82ZjDMaC4375JjNjbXH8Pwu6v2/pWWaHS
         fk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788087563; x=1788692363;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3KwigwgukVSTiElH3abPdJ9+hHKmc9al0eb5r55dI0=;
        b=LpFO62A7FHf55eUwGU55/WYf19ZhZLRq3epY5wSE85QLGH5vIuyzjk/8T+UJC7C9wp
         76KOrALmxrsjGw8oAcfnKqfskaxSrRhDhipVNT3lKooFCEXAL1QhGdA5WpfTBjXAk6dO
         P9/WvbRbzvcWzd85hIXT+mXpOLtaTO52PEAF+aajA71D0aEplAUHr9aLq7YsoCz/isan
         k1FvYdfYTKxXFyCVL/mABr/QB5PVcETV5VuAwx+l7j1uHzLQkov5+yxYQ+aD3UnIZbkR
         RWuNRYFiF6Y8eBLenWckTljKmPrWftwOP5rwYGv3YGF8txw2y4TBnErq2mH6N0aTwOhu
         2X1Q==
X-Gm-Message-State: AFuF++nH9zpBT9AvWtvObBq1UP5RQIV1/mDQuygZ4mmWKX5Hf4DPlmbO
	G1hB0Zw5BVUG1/ucO8k0u8SPH2XmtJ49uPwlvK6F5Bx6jKYIwrzgxv1pewPvVw==
X-Gm-Gg: AYBFou1FhcsrsAr5G2SYf/jn5GABpdeP2yWhdJghYHy7MIogUCBUiUrZ4+yV2KHkVWk
	T2DZxjNMw50lWpg189W6kbvg0/M06vIx/9iZzXa7Zhokt+x1pGhkiV0Z7GDxpE+Zc78XYpV8t3t
	vPLag2Kh6I2uwEMFVlQTer2ItkHLFpZnOlHhcCkRI0b+IHA8llbvNiFfscoOSACW51jnuDQj0JS
	pUqLg4O5OuEiHM+i0dAZVE5JUOjLM1sbjpmq/mZOfmDFQQzqr8pzjebcDTBqnu3RLh3JDuLnHnW
	RONpyKHTCJM+4veEPGGyZkTy5QxWxuNgsLjrN9az9z9L5wq87SZaZDmqj9HhHzDDcaKaKY212c8
	E1hBjOwoMDfRDMLXFLLhz7rJPh3qAl2NLNcRwjOgCLrrn9c7sY3FJ/g8eVGGIXa6/okIRcT2zKz
	c/K6Qg51mPbk9jQ0bySJKxZ8mpngWUiQ5ohu5ccPpSGg7+L57bya+RikE1fAKSkteUWQ==
X-Received: by 2002:a17:903:2a8b:b0:2d7:1cee:3682 with SMTP id d9443c01a7336-2d74dc21e53mr317126845ad.5.1788087563450;
        Sun, 30 Aug 2026 03:59:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.213.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e2a95sm21097423eec.23.2026.08.30.03.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 03:59:21 -0700 (PDT)
Message-Id: <pull.2369.v2.git.git.1788087560290.gitgitgadget@gmail.com>
In-Reply-To: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
References: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 30 Aug 2026 10:59:20 +0000
Subject: [PATCH v2] ci: cancel stale pull request workflow runs
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The CI workflow previously grouped all runs by commit hash using
`group: ${{ github.sha }}`.  This meant every push to a pull
request started a separate workflow run, and all workflows
triggered by the same commit shared the same concurrency group.

With this change, pull request runs are grouped by pull request
number instead of commit hash, and runs superseded by a newer
push are canceled.  The concurrency group becomes
`${{ github.workflow }}-${{ github.event.pull_request.number ||
github.sha }}` and `cancel-in-progress` is set to true for
pull request events.

For pull request events, the group is `<workflow>-<pull-request-number>`
(e.g., "main-workflow-42").  If you push a new commit to an
existing pull request before the CI working on it finishes, the
new request will be placed in the same group and cancel the
currently running run.

For non-pull-request events, the group is `${{ github.workflow }}-${{
github.sha }}` and `cancel-in-progress` defaults to false, so
there is no regression in behavior.

Note that the previous configuration used `group: ${{ github.sha }}`,
which meant all workflows sharing the same commit hash were in the
same group.  The new configuration includes the workflow name in
the group, so each workflow has its own concurrency group per
commit/PR.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    ci: cancel stale pull request workflow runs
    
    Group CI workflow runs by pull request and cancel older revisions so
    only the latest push consumes runner capacity.
    
    Changes in v2:
    
     * Explain behavior in commit message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2369%2FHaraldNordgren%2Fcancel-stale-pr-ci-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2369/HaraldNordgren/cancel-stale-pr-ci-v2
Pull-Request: https://github.com/git/git/pull/2369

Range-diff vs v1:

 1:  a0a618d8cc ! 1:  2773cc5a84 ci: cancel stale pull request workflow runs
     @@ Metadata
       ## Commit message ##
          ci: cancel stale pull request workflow runs
      
     -    The CI workflow groups runs by commit hash, so every push to a pull
     -    request starts a separate workflow run. Group pull request runs by pull
     -    request number and cancel runs superseded by a newer push, while keeping
     -    push events grouped by commit hash for the skip-if-redundant behavior.
     +    The CI workflow previously grouped all runs by commit hash using
     +    `group: ${{ github.sha }}`.  This meant every push to a pull
     +    request started a separate workflow run, and all workflows
     +    triggered by the same commit shared the same concurrency group.
     +
     +    With this change, pull request runs are grouped by pull request
     +    number instead of commit hash, and runs superseded by a newer
     +    push are canceled.  The concurrency group becomes
     +    `${{ github.workflow }}-${{ github.event.pull_request.number ||
     +    github.sha }}` and `cancel-in-progress` is set to true for
     +    pull request events.
     +
     +    For pull request events, the group is `<workflow>-<pull-request-number>`
     +    (e.g., "main-workflow-42").  If you push a new commit to an
     +    existing pull request before the CI working on it finishes, the
     +    new request will be placed in the same group and cancel the
     +    currently running run.
     +
     +    For non-pull-request events, the group is `${{ github.workflow }}-${{
     +    github.sha }}` and `cancel-in-progress` defaults to false, so
     +    there is no regression in behavior.
     +
     +    Note that the previous configuration used `group: ${{ github.sha }}`,
     +    which meant all workflows sharing the same commit hash were in the
     +    same group.  The new configuration includes the workflow name in
     +    the group, so each workflow has its own concurrency group per
     +    commit/PR.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      


 .github/workflows/main.yml | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 205325eb33..4fff344874 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -5,18 +5,20 @@ on: [push, pull_request]
 env:
   DEVELOPER: 1
 
-# If more than one workflow run is triggered for the very same commit hash
-# (which happens when multiple branches pointing to the same commit), only
-# the first one is allowed to run, the second will be kept in the "queued"
-# state. This allows a successful completion of the first run to be reused
-# in the second run via the `skip-if-redundant` logic in the `config` job.
+# For pull requests, only the latest workflow run is allowed to proceed.
+# Older runs are canceled when a new revision is pushed.
 #
-# The only caveat is that if a workflow run is triggered for the same commit
-# hash that another run is already being held, that latter run will be
-# canceled. For more details about the `concurrency` attribute, see:
+# For pushes, if more than one workflow run is triggered for the very same
+# commit hash (which happens when multiple branches point to the same commit),
+# only the first one is allowed to run. This allows a successful completion of
+# the first run to be reused in the second run via the `skip-if-redundant`
+# logic in the `config` job.
+#
+# For more details about the `concurrency` attribute, see:
 # https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency
 concurrency:
-  group: ${{ github.sha }}
+  group: ${{ github.workflow }}-${{ github.event.pull_request.number || github.sha }}
+  cancel-in-progress: ${{ github.event_name == 'pull_request' }}
 
 jobs:
   ci-config:

base-commit: c73e85354c275c9d409b26445089bc16940fc527
-- 
gitgitgadget
