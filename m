Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E643CED9
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193099; cv=none; b=nytd62FrkBlwvpzA0nQrxDgveFWYpuw7mfh/PweLhi0Ht9C9V+arc76TQGx+FZBkPfv29Gaeh4pjK7/fuC1iegjbRZsZQlwgbuJLezZgjScyy+IA0B6BcbC71vJ7QBeLHh+P59JDv2tUrqX1Wp4LdN3GVCrcO6mn9bEO36sG3qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193099; c=relaxed/simple;
	bh=FRoZsjgpEgb3jwFgfxa1delFnjoqKJVCcAdiiBBEmPI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LxO8xihD1R7pUSs9kcgRREvUtBaFLYzVzRkagR/M4CNJq/k7AWJ1+XW30voHZ98euRcEuoJ/nkyUgimHFqndL4MjYt586lGZtZx2ypGk6IS585Ta9shtBMnwBg8wq4cjcGBA3VPON4asxDnn/jI5wSjH6SOtY3cbwp96yDw0NcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYApPLn3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYApPLn3"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-85339ed040aso3194133b3a.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788193097; x=1788797897; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a6Mspa4EBvc4TjO/GiQQObW/o5+kpC5Furr7oPpE1Nc=;
        b=cYApPLn3QgDc/0seHNpyeXRehnc1JpyYoUATbIFxFTiz45YelIJK8N17TByd2MwEm5
         K2YmRtcgP30QmrfyQSKPpRslrtdnJ0H4g6tzEe7QN8RkchXhGsfwpSZXfDmD2NY2mLqX
         Nljr0F3fnNYRkvhteaMlAfAa7qvWjiJy5/cFqcciuQfuyGtYpEVu/tGNQbVgsLjnnSrV
         oofdYUBLShLRtGLBNymZKcR9yUeXitTfAkVLg7FIYbvafot1bLJMOIMbZVWjY6MkNf3r
         hDoX8/QaZnAKjxGtQEYdRUnSalBDJLEfkM5mGpdWOZgCXFc5DhTrnYhWjkh7x5BWCA3X
         3TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788193097; x=1788797897;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a6Mspa4EBvc4TjO/GiQQObW/o5+kpC5Furr7oPpE1Nc=;
        b=oC3FaiFvlL5dXFHZJtIN2KaFt+ikOUWBSUX70Uw0r2uLUTO3iHjyt2oEGzsUVcSxiO
         48ijTKZGtXQOD/piJXXCxQkVEyl/pyU6yqRa0fyNy7CpxZLc2LcCJ6nERMExXJs6jJiP
         0fw4a89kGPJBcih7i5ey26mK/k3ZohkEMHyDjNdiHMbaH0UKCu2O3ffKcg2cWUM6OoDY
         LFMARPmmIoozjNshMAEUfo3lxgEKdEITLloCWguAYgj+zjRWz1vMgq6l00k/h64Gp4rN
         saro7NgGh5b3LD7zZvNEQl2wnkZWrLS4rkwsVCJK2W3ygOuJg0+fYpNHQnh2JAuo04TO
         oDbg==
X-Gm-Message-State: AFuF++nZjRFHAl5FMPMdc3nyEjvES76iH0JCqofFfMUflytHNdGgHhig
	I0273IvdoO8TFYultFjJotzcWyxA8AlAcEhouW+YjgLULJxLvkHquXG3GHiQmw==
X-Gm-Gg: AR+sD12mnyhuIP8jj+e9ZfzIGaQ+HavMOqeC3Mqr463xaAv5iFsUdyNqCiRuIvXwtfj
	WOKVxSjgE40xRN0H2yIpEcHNnW2gauHtFLjfZxLJKoDnmXlA0+dB62965SjQCZzbUaD981lLYK4
	0IC3R9X6Vlk+7q3oPehFvHXx1ygL2urAd9r3KhUr55sR06q4jb4blgFHlUg0Uw5q382a0+9gCR3
	W8K1CgB0fR6csbGSNCSUW7fVk2Z/cPj+Lc0c9lWQ/0407B91r/HyDZ6eGqa12Nlo9lk/fmolFS4
	jd8dr9cj5YKL0uOiSlmq4hl15408Nat0yezrVOOirw+amrRvZA9yTh9zCNkYLyhYKyQu9f60ySL
	N+L1zXiWy0l8eLOcpmTHPtKiH2H/ziE11yzPzmlqUZa+Yc0p/YRFojt21AfqHgiWNEcrNvS5qDj
	0w6JAeSj1NLRUxq3hdDiECTEW1ROugDfhdwD2yATdNhU2XKB7nCaGUWw+0az8niniBuQ==
X-Received: by 2002:a05:6a00:ad06:b0:848:3fe2:c88b with SMTP id d2e1a72fcca58-85b59c69450mr3402507b3a.6.1788193097210;
        Mon, 31 Aug 2026 09:18:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569ff701d5sm3943645b3a.25.2026.08.31.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:18:16 -0700 (PDT)
Message-Id: <pull.2369.v3.git.git.1788193095825.gitgitgadget@gmail.com>
In-Reply-To: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
References: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 16:18:15 +0000
Subject: [PATCH v3] ci: cancel stale pull request workflow runs
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

The CI workflow groups all runs by commit hash using
`group: ${{ github.sha }}`.  This means every push to a pull
request starts a separate workflow run, and all workflows
triggered by the same commit share the same concurrency group.

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
    
    Changes in v3:
    
     * Status quo in present tense in commit message.
    
    Changes in v2:
    
     * Explain behavior in commit message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2369%2FHaraldNordgren%2Fcancel-stale-pr-ci-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2369/HaraldNordgren/cancel-stale-pr-ci-v3
Pull-Request: https://github.com/git/git/pull/2369

Range-diff vs v2:

 1:  2773cc5a84 ! 1:  61fb54612d ci: cancel stale pull request workflow runs
     @@ Metadata
       ## Commit message ##
          ci: cancel stale pull request workflow runs
      
     -    The CI workflow previously grouped all runs by commit hash using
     -    `group: ${{ github.sha }}`.  This meant every push to a pull
     -    request started a separate workflow run, and all workflows
     -    triggered by the same commit shared the same concurrency group.
     +    The CI workflow groups all runs by commit hash using
     +    `group: ${{ github.sha }}`.  This means every push to a pull
     +    request starts a separate workflow run, and all workflows
     +    triggered by the same commit share the same concurrency group.
      
          With this change, pull request runs are grouped by pull request
          number instead of commit hash, and runs superseded by a newer


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
