Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155319F111
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702064; cv=none; b=mt0vlZjzCijqyL1HeeNNzB0/UH8uGvpDtK4SfyXGoL/pUDoI4T8o9V5q79/AivPgE+nU6udBwScl6+NbDVTKiruPF3k7nv4lV4CJxbE/5jupexXWbrlbD7FpEMGynUAKu+qseScGmUZ6TpesqgRg51vjWchlD/rFQoEIlJGxWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702064; c=relaxed/simple;
	bh=mvhoU/Oq4ps+xr3rOCL2drohKIrIyBdcrj7O9SKApXw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d9N07fI2jBJQA3WNcLczx+uItFtV/dIM0BKj7lGzYjvLCBlTk9NktOpHpwp8c457BXrFYOPWzmB3WMW/oeFHf1esj/P2ZsPMqZPdKVD6nMLcW3uNKacxbk2WAow5AXk4FX5e2lwQp0OYFW5cJCRv1gu4ldO+f2bt91SuimtB0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/BtWbgt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/BtWbgt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459d44d286eso16538015e9.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 18:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754702061; x=1755306861; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWKcy9KVeGv+Zb2OV2Hc+blOdOnNsA0nxv9pEfhsRmk=;
        b=C/BtWbgtIrR6/C+U/XgA2y012hgEic110tWCmxEsHT/zYZb/q0HX8l/UihdbxxLfHs
         OKSXVCLhMtDPXu4vfKj8+KSZ+NZYIx3Un7l0rz86PVvolXiu4l0xY8H2OagktiNjPEpj
         YjmKEDOAlegYWfsOW8iuEjG2w3f8ZGioQZwvTHsQav2MUt+LZ2+xOCdAQsc3aK0MXCIC
         naZ74mIXWBMwUqmMiJQmy0erFSO3WcrRfab8mUOIGBW1W7avylfoTuqWccl8z22IY8tw
         /Qm5yUAHTG7Arqc9MRKZW/CWOeutDhk+r2KkVIarvwf+kDUe/InaB/yYlVdlcrjHovor
         ewIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754702061; x=1755306861;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWKcy9KVeGv+Zb2OV2Hc+blOdOnNsA0nxv9pEfhsRmk=;
        b=lcVgpwwtC2qUn0QV4tZURfXcNK4R8ZZ0a/BTINzgvkj1E1q8vIp1SJ/AO/xO++vU7/
         LA89a0Cmh/or2CUCoy2F5Skz+qOvYdmXBJcVRefjgWuitD8EPaQFuFRG/vSZau5fzkye
         eO4mdtOwHdxfWyy3kWeNVSLfjiap73HIkSBMzlqSbOVRo49lBGTsqwn/X76XPIkTl2Jj
         Hf4ejUZn00a/1suFETr7nGQ+bwKpdz+dq0ClUEoCn94h3VYGsNlU0JvIwgU4e5zmbPLh
         HVD/P3o1d0WROwQG9cV4lzzjk0LfoeYJzwAnTaO63U0khim7bnp2Xy8dm3BOCOOJ6WwK
         EKng==
X-Gm-Message-State: AOJu0Yz2ltXaCKndO8KxloUI0PfjEZGC/ikvDjdk6CFcyGSbb0GREfFd
	FVhF9WQHk4pE/aDaDv6mbbi/lecpThVA/fDNhkYToLEVN89GS0tmyGzGAkCI7Q==
X-Gm-Gg: ASbGncsFpWBs/Vrfrd7WV4/kbJQNZyFoeWjvIh1+IKCTiz6aM0wJv8/F4+OXbt7hUVp
	DROVyiaS8LA5bhAz8MWi5pCcVYfpP9BIKx3gagprKrxV7S5aRQdGONp3tL+mTlkT3NrWx63iGRB
	QqD7YMYHPg6XJYNguYMDBmOYoUBRvIn4/j8fbHWFVgVlewSMyPDJEzeTZWDoLwoe7aTnTxwlvMV
	mI1pf0e/d5mZ0wZNBjh6oGuZxXNKuywryKvuXdfQoFCf/PK/MpNM4szUDW980GeXjpijnFWbXAF
	sXXNeemBiB6BWxSPrNM8vd3uhlaE0qFFVJCK1ccQAGZtltT6ABQn3AerXFdhj1Wf3PB4Xt3WQ28
	wqJ0c/4G+RzplwRRQC5v+MsA=
X-Google-Smtp-Source: AGHT+IFvX9Z+TfIi/0dmeJ/sqH+nGHLYo5bp59xy2aB/TvYm8XbRpDwg6IQP34IvHHHDejELd2Wnsg==
X-Received: by 2002:a05:600c:8887:b0:456:15be:d113 with SMTP id 5b1f17b1804b1-459ede6bfb1mr74864585e9.1.1754702060753;
        Fri, 08 Aug 2025 18:14:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b501f22dsm182499725e9.0.2025.08.08.18.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 18:14:19 -0700 (PDT)
Message-Id: <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
	<pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Aug 2025 01:14:13 +0000
Subject: [PATCH v4 1/5] doc: git-rebase: start with an example
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Start with an example that mirrors the example in the `git-merge` man
page, to make it easier for folks to understand the difference between a
rebase and a merge.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 49 ++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a6..449f01fba560 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -16,6 +16,29 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+Transplant a series of commits onto a different starting point.
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
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -58,32 +81,6 @@ that caused the merge failure with `git rebase --skip`.  To check out the
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

