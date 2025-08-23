Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531E44C63
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909789; cv=none; b=J/Lf2AMCTHUpwVBOnb1yZAIfjL10ZMeB/O5UNC9GSVo3nhyG3BldC6yknYuzQPyvVt8tWETesrMeyLj1ngYcWJA1lRDfFMTENGcng+vcnL1wVfArfUEMiv/fHwEZAjzlBnIEhnuYSCy0qu8efnyMKFdIubN6ytFvqlNCdGXS1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909789; c=relaxed/simple;
	bh=zv1Qp7WHKpWgLyeZFXJrdToWkz46Ro+JeRyyTSwMcIg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rf61ECXIr1Vk/OCdN8kiDy69f0d48A9HFe+8YOzELoiSoYIK980cWSdIKLf1BJ/vSBhOi8/N92DNrM6/3RX7bD0tjY2OqH1pxoFmEyrMOHNK4uLcU9S6VpD1mfilSt3pBSFRVIMura30Ktz3vHfw46r4x17/UG272Nxk1gEbokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajqnx/4L; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajqnx/4L"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b55ed86b9so5136845e9.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755909786; x=1756514586; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oQc0uVpWvCny1ZGlUNwBc8xRvmihROYVwRfD68hBUA=;
        b=ajqnx/4L/wttPYj4E2+wOjYvUolwwioEjOWhfxVRiL44jnWm5UxxDGBEO3hbmOMWHW
         MnUb7iEcKhhNcpReXtuAvhJHCc/49LyAyHodDJdE2Gmjg0uoRcYSuoUpSKks+CwS9ckI
         oVQBvDByqqgOd9g2dl0xWZSM/23qTjXPdI5VUq1l7aCf7vK6FnXGMRm9KtdJVsW2g47a
         5w1bR1DdLJDXHzcHNacsuWpsNQl2FiwBJ29xWrkXPpOBkxr3zYvUAgUO3O8ZKb1BRp8a
         3x4dW6HUOGveYVozqoFGEgKLJbeACKrJezuDLBVP1HtVGS3SnpUguli6J/JXgQPnyiOm
         hstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909786; x=1756514586;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oQc0uVpWvCny1ZGlUNwBc8xRvmihROYVwRfD68hBUA=;
        b=ubq/mPmVJBsFA+uvHVKvGpiFti6pUU8p+T3XSQ7e5VaLklY+SiFoY8nNbQXI/sILRz
         H9kYr27oo4luAmjNd9kYEBsyw3X6iU3P68Jx4MVsSarlH3aNcthZJ3cpG5Xh9+vxHhs/
         f4ZsWA897kGspEyq+ZAZTSlvGu2F7vulTWANbOTUd9VFH7pgwaRwoR1leGIShpTIzNjR
         YWWWwQjgq2pdoLgaHl5WjHpf3YfZHsd63wCCjNtP0yrVosups89NzkbecAjMc26bZaLG
         PA9C0TpOcQgqd22QiUwGArFDPbe3T1V7vHEhXc1uQ7EQcEQl3ifObgKdJI8i4ITCmk/9
         GluA==
X-Gm-Message-State: AOJu0Yyj7EhB15JECJTyjCKn7xQSaUIIPjzXKPdD1uxZnWWrBQE6T5Wc
	1s/3urxuFJuGsPyROFuKAf4aZuDvwna8xyDgpuJgk3YKppbr4d+eu2MxIvi6Aw==
X-Gm-Gg: ASbGncuXhldrXHFrW1yQIXKHBBkCbJdZyu2nQbJN8vGK7OU7xV3MKajMARlPN0Xzecw
	exMQJfCAjQxCe0qhz7h8T+HfJ1rJvAKcRrCa1pb4a6nXsZZoI5t68WpoBczjOJ0m0c+6xvWHo5r
	hY/QtJl0Uz85ghwVGJirqvrgwKGv34qgoJv8o0y+9YXMICPSigV2KaHMx7scLh3y7BmiuKaMq3I
	QNho3JqSwSosib+gAeGyzTXkceKcrn2hdOczSekNkgto/1nnLJ4ZuQ+aYWGRcMo/IOhSC+3ZwG2
	KJFKA/OVdF+tGs16Ym+yaorT02oqX1nhYm58xy/TTRnkLcRwjnOWu4b2EuzTo4rdmxXroKJFs3O
	9dhMjmEfWY7Gvgx9V29G2bxReO3U=
X-Google-Smtp-Source: AGHT+IH4SkNjn/6Nj4tseFEVANco4mtmdTY4w/8asNyplBY2muV1MOiqMwO670k29MRAG1cpZ2ctzA==
X-Received: by 2002:a05:600c:3503:b0:459:dde3:1a37 with SMTP id 5b1f17b1804b1-45b593dc3d4mr941335e9.25.1755909785452;
        Fri, 22 Aug 2025 17:43:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e1ca4d4sm44415845e9.0.2025.08.22.17.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 17:43:05 -0700 (PDT)
Message-Id: <ea1438e094e950d75196fdab79e22c174251bb66.1755909782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
References: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
	<pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 00:42:58 +0000
Subject: [PATCH v9 1/5] doc: git-rebase: start with an example
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Start with an example that mirrors the example in the `git-merge` man
  page, to make it easier for folks to understand the difference between
  a rebase and a merge.
- Mention that rebase can combine or reorder commits

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 52 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a6..bb5a3ff7f828 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -16,6 +16,32 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+Transplant a series of commits onto a different starting point.
+You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
+MODE below for how to do that.
+
+For example, imagine that you have been working on the `topic` branch in this
+history, and you want to "catch up" to the work done on the `master` branch.
+
+------------
+          A---B---C topic
+         /
+    D---E---F---G master
+------------
+
+You want to transplant the commits you made on `topic` since it diverged from
+`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
+by running `git rebase master` while the `topic` branch is checked out.  If you
+want to rebase `topic` while on another branch, `git rebase master topic` is a
+shortcut for `git checkout topic && git rebase master`.
+
+------------
+                  A'--B'--C' topic
+                 /
+    D---E---F---G master
+------------
+
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -58,32 +84,6 @@ that caused the merge failure with `git rebase --skip`.  To check out the
 original `<branch>` and remove the `.git/rebase-apply` working files, use
 the command `git rebase --abort` instead.
 
-Assume the following history exists and the current branch is "topic":
-
-------------
-          A---B---C topic
-         /
-    D---E---F---G master
-------------
-
-From this point, the result of either of the following commands:
-
-
-    git rebase master
-    git rebase master topic
-
-would be:
-
-------------
-                  A'--B'--C' topic
-                 /
-    D---E---F---G master
-------------
-
-*NOTE:* The latter form is just a short-hand of `git checkout topic`
-followed by `git rebase master`. When rebase exits `topic` will
-remain the checked-out branch.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
-- 
gitgitgadget

