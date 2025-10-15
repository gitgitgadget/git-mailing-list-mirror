Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5232C311
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534019; cv=none; b=BsEV4mFOSxwB2oKVr4zqkp7SjP7GPg1IAxCvJrC3ai1zozH3p2ceCubJ0RrElZpiHeT6Hssv5ycQMn0krWufxAx1fS9iBz2SJ2bxNPmgXyg7oYC2VJXdDNddbHyyhyX4dddaZkZ30mrGSk7LmIJ7wGUg9/AJWWKtwMYIbnF8zRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534019; c=relaxed/simple;
	bh=tUfI9GZ6cXjXns2uw/dvBBuo5gDn920ay0GRNsVajpM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Npr72OxVpTR0TR7PF692ooeyhI2FNlwG8snv5xaKqA8PeZQuZnhWEqUgavyjyc4EEnWv4Mq8L/APKmNrxNlz45Cabj9ZGXP8pWpKw604VCVoOB01FwE98uSJBBOSR/5Q2BlykPlKuOrigBaW8gP2RCHOWGSxbomkq6+25QvXjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlKRv5Mu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlKRv5Mu"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b67684e2904so3943775a12.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760534016; x=1761138816; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnayIpombhRyaRcERqgHfVfwRRBGjPoGmvIEhsu94uk=;
        b=GlKRv5MurgV0BovexMIaYfRX1bF8+Pvy48h+V9ZPtMMd4ar4XVbi5vpOX1LEmF5miM
         /Pg1O18wMpt/tzYsbZWVWwaQTccJ8y/PTPKZ/R9br5byVwXa5/2z7VdpBKDFLy661fnv
         OjMPlxVdSkDSZvQ/z2EOp4yR+UtaHAyrEJFzEGiTlAnWPJYG/vHFTuSa+ssUF8bFDILH
         czw29wRY2eebMdxIeevveSHrMjeFTgnJIlFRl4rlS+JzBGgQU9dvPLHjsnd9B7Ja4/NV
         KTXnhs7qMQum4/sDSucpHBmgWa7eAyRMqzDSi3RkZ7JbTdCt75NXsEUvj6q4TcJCK1fS
         +Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534016; x=1761138816;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnayIpombhRyaRcERqgHfVfwRRBGjPoGmvIEhsu94uk=;
        b=fzoQNotHDxxPmsSwG4VOyYFULH+ATpl5Om+WCanhO7cTnwOM6KRdqH1efo32UWQd5N
         Si7l1eORX8PPFiGATRfQWXPojjbDPsCxff87dK/ivHbK5lX6sCqER9cO2FL7RrfyqhyU
         BNp2/vtzkM0rwjY0lEjp6rjWti8xlFnMrxTROW3erx6+baT2ITrhq0DP5H1m4ETPg5M9
         Qd7LPwzvAKBLJP/0rmPtFf0fMoaDIu4DdA6wov2MdBa/HhDU+jZNDku+gA9jQY2QouJ1
         H7+fSnFOo/LJ3quFDlGAbBtuy3pILsJybFIlEnRP0mlfLNeXRgtPCi5B9uLittfQnbme
         t7LA==
X-Gm-Message-State: AOJu0YylD8swVKI8taXDDYwUl6T7z/nbCcytS/nfkwNVDn7vptGx+aRY
	FiqQaG/yX3sdgoRUi4ubGWyUgrJQzgV361QIZbfivezoviizmt2dnNd5P6VR2cNm
X-Gm-Gg: ASbGncttcrVN2G9et/yzFBpTBO7101ljGAmaXVC93YN3bquer/tA3rCpV8kcN6GwWyI
	uPr7e+wAsSrXWwPYcbXoVtEcajawpXd3uMxoLD/knp7w5RJdanAW1EfKWNa++nuiuGiCGv2JDSw
	iJ+pvre3vN0fMS1wj84rCvbeulPknQdWqzQtQxsf2dVgL5P6pLytdjt+xOS+lv0QXBRosEKBkbi
	I/+zEZ8k/2fb99+FgdO5jUyI/vMZ3efTCA8waX4iplyIcniovXtY0S8a5k3UW9//+jmmfZ09WbB
	hLV3Ca2ah8GWQ5MuI971PDzfjqWC0Kyc4ngRmHh5AbMjS+x3I5lbihR9fZagT40jrc1xafQSL1K
	BwLHYwcuxnmJ9Gs720s5kyyE87CfgeRQ4OCyH23mJ
X-Google-Smtp-Source: AGHT+IGcY16ZWnylYCBTQGz1Rj631W+cJovfJkqemqMFRPXX/454cXYO/utk1ktJi4WIs271BKdulQ==
X-Received: by 2002:a17:903:1a2b:b0:248:a4e2:e6d6 with SMTP id d9443c01a7336-290273eef54mr354027585ad.39.1760534016185;
        Wed, 15 Oct 2025 06:13:36 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f06c82sm197800255ad.81.2025.10.15.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:13:35 -0700 (PDT)
Message-Id: <0ff00b4ff608683eafcc636a8c0c1c8b10bbe47d.1760534011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
References: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
	<pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 13:13:29 +0000
Subject: [PATCH v3 2/4] doc: git-pull: clarify options for integrating remote
 branch
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback:

- One user is confused about the current default ("I was convinced that
  the git default was still to merge on pull")
- One user is confused about why "git fetch" isn't mentioned earlier
- One user says they always forget what the arguments to `git pull` are
  and that it's not immediately obvious that `--no-rebase` means "merge"
- One user wants `--ff-only` to be mentioned

Resolve this by listing the options for integrating the the remote
branch. This should help users figure out at a glance which one they
want to do, and make it clearer that --ff-only is the default.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index a3d248dd1d..0686a9d666 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -15,17 +15,26 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Incorporates changes from a remote repository into the current branch.
-If the current branch is behind the remote, then by default it will
-fast-forward the current branch to match the remote.  If the current
-branch and the remote have diverged, the user needs to specify how to
-reconcile the divergent branches with `--rebase` or `--no-rebase` (or
-the corresponding configuration option in `pull.rebase`).
-
-More precisely, `git pull` runs `git fetch` with the given parameters
-and then depending on configuration options or command line flags,
-will call either `git rebase` or `git merge` to reconcile diverging
-branches.
+Integrate changes from a remote repository into the current branch.
+
+First, `git pull` runs `git fetch` with the same arguments
+(excluding merge options) to fetch remote branch(es).
+Then it decides which remote branch to integrate: if you run `git pull`
+with no arguments this defaults to the <<UPSTREAM-BRANCHES,upstream>>
+for the current branch.
+Then it integrates that branch into the current branch.
+
+There are 4 main options for integrating the remote branch:
+
+1. `git pull --ff-only` will only do "fast-forward" updates: it
+   fails if your local branch has diverged from the remote branch.
+   This is the default.
+2. `git pull --rebase` runs `git rebase`
+3. `git pull --no-rebase` runs `git merge`.
+4. `git pull --squash` runs `git merge --squash`
+
+You can also set the configuration options `pull.rebase`, `pull.squash`,
+or `pull.ff` with your preferred behaviour.
 
 Assume the following history exists and the current branch is
 "`master`":
-- 
gitgitgadget

