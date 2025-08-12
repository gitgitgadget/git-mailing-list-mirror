Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2F27FD59
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006574; cv=none; b=b2Mtzzaj+vkRUsMrfUteDY9Vp8NNf9Z6dXjf5oaaKx6P9cWJzNNz0UjSNM3UT9rOkN4P/xljdvIeT9Y3wA/CuxG1/rjSey3cSiigjE9Wxb0HGtE/IfgVaoePutUGjNnjMtkSKoXN//LJx47lg3TgR6QTSmWpfblzaJf/BvxmcJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006574; c=relaxed/simple;
	bh=zv1Qp7WHKpWgLyeZFXJrdToWkz46Ro+JeRyyTSwMcIg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D1lvP015w/a5CLqPoUGKQ3xhMsZHNBD0bqd0Xl2G9jP3MLRfBJMbGQcxnvKBo9wgJW6h2m5FxzAZI+T1hoDns0RceqxDZmsKoHvCSfqXtxnthZnA7fF3A8uwHwCih8eavLxarELy3eSU+YGum9U4fO16JSLbsCgZXk00mub24aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtYcumxU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtYcumxU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7920354f9so4503987f8f.2
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755006571; x=1755611371; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oQc0uVpWvCny1ZGlUNwBc8xRvmihROYVwRfD68hBUA=;
        b=JtYcumxUP177QHMpKyGhfH6x/QYBH4M1qb8rh+DyBaaAQ3eUWua2YYazeOA2W6HNfK
         kMzY8J62eUCsaLrzB2SXBg4YWpw93Y9lml6ARW56NVGyBNJKnXv9kt5rwAj+Ul5aHJTL
         HUaEQAMpMd3CElv7mgr5DVqrfivYodOa83dwO5JDRfdAkFNpchcSPyyVswjWUG1fE/Dq
         AmLV3bRIRWTJ71gkdPUZHdZQjHcMfMZLb+QmmYa80YqGKi6toI16U1ZpdVHhaDax42ax
         QgjUgdE9yL/NAauoObQzJy2Y9EhO+80bNu0Wk3+Ytu+RQ5l7wTOJhwUCiwfSqe3dxY9C
         z79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006571; x=1755611371;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oQc0uVpWvCny1ZGlUNwBc8xRvmihROYVwRfD68hBUA=;
        b=Gj0WzdNIC0ANg5PIyx3F3Jr/Ok9HsHNWzW9JNynprb/19hgxeiQRnkSVkeYTtEdLoc
         CuuVcgH4uthtz9exWf0brxjvtuuJq4zFGbrgvMDmjTrvG9JzW6lXVJ21n4GrcAfh62Jt
         EVGkcGQevEORu4vLORKCa0HsSl+h/4EWfXSwYuH7nemegKe1Vu4PEA3L8KrjnE5nA5kp
         0rBdWTTLQQXj94e6xoGMO4T4QHSCSAygEmrMqJNOpH5AOlI/eCjkckYcVDQQsPdL6SpV
         B0ii9aL+yZLjWql0xzoNYf3STKoiQnENHLgUtAcEFlzbCiK3N+lmbTm5lo2dBCYxOYbP
         XhSw==
X-Gm-Message-State: AOJu0YyKfDz19ocarCqgoamVKnAfx1X7fEMNPneJe0yxa8hgkkcv5z4a
	u8/05hIwKuxYP10ikmykA9/TBa9dmojtLlovm6ZrLVzqLM7Kadj5p65h2J+wVQ==
X-Gm-Gg: ASbGncuNWz8SUhMyZmAREWeDWIjglPD/hSVUkoidNn4FCbsAbSWRfK8/pBMpZhCQUlm
	6fVtGDW6NgTJwFaJ5EjCjERYuYRb0Ib7VMWLuT42gCndPuAE6zIoLtBrSrnD8yZSXnWhQOAP55w
	sPjR8oEfWkoREdwgXsdobiTjMKbLS3GhKhPZHxpziWgS+8LVmTYiysW+UG4Cs2z+zyplfC5nITE
	ZUfQ7tx6NGc7cENlC7eVhyUePCCcynD49FmmlcwvmrawjuAmucnhPfS/7mluiyNKCS00vh25PTV
	bPcoGLj99OlAKj2kXQW2kXOcLP+a8OgisInQAMcWpusjWp3plM5VjHGhMXtbR8anHBj24lSco/3
	eJoMwflMkGFc5b/4XyRiqTxk=
X-Google-Smtp-Source: AGHT+IGQyFN8OCAPmLoPtBcDnr8wx5cQblMM6WbtF2dSaPG0t1TNbT6r2ZEx/oQvsn0MnXFU73nuew==
X-Received: by 2002:a5d:64e3:0:b0:3b8:d79a:6a7d with SMTP id ffacd0b85a97d-3b910fd984dmr3116057f8f.13.1755006570803;
        Tue, 12 Aug 2025 06:49:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abeb2sm44363129f8f.11.2025.08.12.06.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:49:30 -0700 (PDT)
Message-Id: <e7a8fbbe53c9cf5cb7b8d822e72ff4219de37e1c.1755006568.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
References: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
	<pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 13:49:24 +0000
Subject: [PATCH v7 1/5] doc: git-rebase: start with an example
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

