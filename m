Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC61D52B
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943171; cv=none; b=VMV0zrK6GxoReRx/27D2YarDj7t0LtTjknm6vYLwebVDINVFYeELi8M8QX8IKgS0b3ZzVl+Db/0ZiGsb2yU8dU5kXlSo/uA2V6PmPqra/F3alM1mtubAftOHChUMLRJqz7QOfHXSTnJx0r+ls14k+V7lc0/+2ox1TTY1UY5qBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943171; c=relaxed/simple;
	bh=Ct1lWEDeFutX2EvzRA2QqOOyYkw/EPA2THKuV3UQA9o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G41315KOcaiwvsVwL29XQE3J9FpCgSnDZ9rbBBmde1iIxGKBx4/WaKA1To+vAym6LDBfmxp5J3BHS9lKxtzckWz4FiPYOKG35Qta058fttopi5maHmf1ZKq6iLuWsfk+/yjdnlO65ljTwl2cIc7WQVAQu2mjrC7Uccjh9USr7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6/l/Fmf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6/l/Fmf"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so2854033f8f.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943168; x=1755547968; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1b/Ky8JrQdohoyz4RYSHgd+tVFiJR8QbfHManFhVPQ=;
        b=O6/l/FmfanPmciyVrDBR3CEfA+Rz3o7e9tp3KYzhHBo5p0D0OJyCLPqaFOch5R69Vk
         pCmZdY4l7UcuPdLPlK/KxuN/VmJGQ12Ub4fQzGbmOAqIX8zIu36gpt/jeTsTTnhf/tcs
         +D6cwywsN3covnmNCGjWli3fj3A2mhdt90peDYx112kqrhY8wjPdoqFlOjxL3lAh6boj
         Xih3f8NsoJnIbfkWlsdDe4JlsPacAQR0H0YpHC+hT2bGyK6pHsBg/U4tS37c6J00wDCT
         7W/isUEeMyU0TbMPiacCOsizNZcSgRWPVqq/JnkOH8yGqFbIyEI1rxVouUP/gPPHJAQ6
         SizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943168; x=1755547968;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1b/Ky8JrQdohoyz4RYSHgd+tVFiJR8QbfHManFhVPQ=;
        b=bnx835u0k+m1KnDsHsa2u2Q3iPhlxYD2HcfpXjAD91m2l6FpGiEUJ4PC6R+JyPFyV0
         3EyLW0Wm7Q5fNKBnqvUwAVjbd7n2FPz6R4DtGG9gMmVdV4GCEDhcYLOLQ3ACvsD3OzaF
         LiF8UweCGSdwnVWMFj5Q2S5VDRtk/FJfsB6RXMKVPrzU7UxWLWG1Yum2R1sDIg34Hvwm
         dsaKD0ZMsAdGjDxPgcx3Kin0vSPZTGLsiOM1SRD2RYciiXjxVLcQon1fEE5leoFglsRA
         gXQSM+UC5P7a0JBDJhZpzCHBZO+pikcJEMVYIUq8Msw3CqdmWWM2Vz7f+Jy8+EBXvUrE
         jrTg==
X-Gm-Message-State: AOJu0YyhSTQa4yAZ8/XUcRVM9CfbpRMqQgTnvWd70otIL6Bob6nGqoyq
	nWpWZC9ZxagUPt9LQ7by4EpDl/+N77Le/Uv9AF4fd5jjbO6ddU0c0IpKI2VYbQ==
X-Gm-Gg: ASbGncu8/CHvlAstsUuet3cZkPuViRh8po/tjkIXWj1/9soTDpAh62cqVcFY60T2y8E
	9YmfGZyA/6rj9n/JC/NQH7u9n+8ufjkTSgt+Ywj76fCwvRObnQ9/E6ADsNSb+wa4AhVdmBbpSZ+
	FswxyP91JeAd4qNdfKY9AXjShKGzOP4km+dO0eGPT3u+otoXc99ksAkqINX3/8Zc+seHtMoPn36
	2/1MR/jGGPxC28zgFr9GyC2QHGnAXBiOrNUe1iYUMr39FN98TluHb6zFIvNraSn8WS074djs4bM
	KYWeL5w+LGu6fcy84vxILmRSCxZBySyB/6vAjoR3lOtePwRyArsqPNTUhh8icK5SFQAJi43oddX
	Ea8x9L1GGRh/N7gU/pyoeZz0=
X-Google-Smtp-Source: AGHT+IEQ3blLcGCaedXX6iYohoLmW1/COz5BKdQAh/JD123dRuoZmCx/JNbUkrFqoe+2R6aclZfRwA==
X-Received: by 2002:a05:6000:40e0:b0:3b8:d360:337f with SMTP id ffacd0b85a97d-3b911040b5emr772633f8f.51.1754943167898;
        Mon, 11 Aug 2025 13:12:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459eff7918csm201825865e9.25.2025.08.11.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:12:47 -0700 (PDT)
Message-Id: <c2f2e05078f3be604495b53f295e9a8a75f223a7.1754943127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
References: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
	<pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:12:03 +0000
Subject: [PATCH v5 1/5] doc: git-rebase: start with an example
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
index 956d3048f5a6..03d1b74a9a09 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -16,6 +16,32 @@ SYNOPSIS
 
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
+You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
+MODE below for how to do that.
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

