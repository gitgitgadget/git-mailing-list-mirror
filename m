Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A63375CB
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836308; cv=none; b=RlrissFcdk5rhl8c7065eyBiWqrxva4QvcXuXk8bVMcJerrvdgiCr37aV/OiaMLmsYCFYhTocX6G45Il6MPRWDP86flGunCVgdrz9nVd08DjbUiRwkjym/t67KUdyDK/n2J3Mtfa8EnQyYb4WiyJXTIhIo2fYAIhwtgsv/Jo7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836308; c=relaxed/simple;
	bh=oylEVmHn32X79Zk+Ts9LX6NOyq6AHC0uhU/rWh24TvQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ryfG/S3TKi1q2+4xKTf0vy9mQYSyCp8aZRNMaBWukJu1QD9r2bCDdw3gZbVcyTHVXVm1BeSw9cM5VgyH7+qh2yadfa/XN+cWucXRYQ0s5eF6xA6eorEgl9Vc43Cbm+LtJDYh7Oge/irWd5l6DDGDX9hPvTdC8bjDw9O+FYFIl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5XThtmp; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5XThtmp"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cb3fd71badso384409285a.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836304; x=1772441104; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=szR83gd2/MjChhFri7CZCcny5Rxm0jmftFbihi8jJBM=;
        b=L5XThtmpNb3Zx0BSPE8zGpZ5XUKsn8GkvAz0Mn1uAbWziCy0trjOffPA92TCT2MtqL
         Vcp91vKJ1goLov2pVbpdgTrb1LYgBXBcqTS3CIzqqT3h3dKsev8xAvfkBqO9IL9aE1r3
         dWmGM+Tuz/XzMIi3yr+jW/bT6XaomSGphq8wbjlt67V5y9qa3wVvGpZjDO9iTwLEGitn
         xbzscNGbhlYIHIBIk+DpkYCLqUw2dEK5h/TYfCDaMNLzPFx1GhI/4sieIpdArA+X5AaZ
         gE+aJXhrBxIOr+zNU+bVgT5MrpNbVkHDSwWP6R/dW+CgBEndh4i5BfCtC4SP1FyZVtmg
         FZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836304; x=1772441104;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szR83gd2/MjChhFri7CZCcny5Rxm0jmftFbihi8jJBM=;
        b=fupB4irsA3dRne4lOYg1TYTqW8wV5kBvLu9nsukoycem84nm+HGCaGsiFe5nh2nhof
         x6hvFU7f16iRZyCQbbNiCAaghFsPYg9NpK42hRYBSOx3GVOsKcp6tQnGosYNM06DCKpS
         1LcJz2+6hDvn8lUDBDma17q/V7TZgpVMRMcly1yRjwkm1oqxTIa727Sc2fbKHBTxpB/m
         wMcZKSirjaFQwUDNOvoQxeeUBxH+iY1OifDr4aIB7QPI1aJv/LPMzApC1Sx/o2uI9qe5
         MIiypoiRLf20wM5ynkClxA/HXJWk6Jj9zfeX7wPGKJre0vJUDu+r30orviUpTW0vxztN
         gzZQ==
X-Gm-Message-State: AOJu0Yww5b61tUsbm8+jnoSSREbsj2H6g3qRBuPocip+4YigaZrh0exD
	Amef1iiUElPBFAw3tO+E4B4vIZ6OjKlDSAgdJHv5Qn8hYYT4I/t61IbXf6VvjHW1
X-Gm-Gg: AZuq6aICekErIvEcYpewPdlyCE8BRwRzFj8nyeW8PX2obSZrRvBN7BrFndft8qg1CFn
	YwNBNWVAIP5gNHNwvkhlSA9QEcOXOYVleB5fJBK3ps9dvYcJK/UI1S3uzSclWRA5f70Lu/OYcNM
	Q3sN+GaKBLGSd+IBNRn2CJ0RMkQsJk1vdMWVIia/b+rSi3hmGl9iLFqWSxEcg+Jey91caJfo/HL
	hIuqjIbuqs3TWWAoPnPLc/ABWLd0gxjMDmd9DNNEG9y7R7CE3F+WSMbWIGAWS/VbIloPe6e9qg1
	EgL20jRrs/PLoLlWt9OB9UNYUBimz9mTIXPqFgWp9MzAocqL58visvx1hToV60wkGSrHnx+I9JI
	EMGLAJx09Zoda58SiXIqFvhIHKbx3bAHkjN5CSUhYwRVlw4Ksvd1W2QTAaUwIztoQh8/uae6tKe
	CpYy/yMK6HXKDRcybEWiCq9j2e
X-Received: by 2002:a05:620a:414c:b0:8c9:f9c2:118e with SMTP id af79cd13be357-8cb8ca156e3mr839448585a.32.1771836304317;
        Mon, 23 Feb 2026 00:45:04 -0800 (PST)
Received: from [127.0.0.1] ([64.236.201.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d064007sm730283085a.19.2026.02.23.00.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:45:03 -0800 (PST)
Message-Id: <pull.2051.git.1771836303147.gitgitgadget@gmail.com>
From: "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 08:45:03 +0000
Subject: [PATCH] doc: commit: document special date keywords for --date
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
Cc: Md Ferdous Alam <mdferdousalam1989@yahoo.com>,
    mdferdousalam <mdferdousalam1989@yahoo.com>

From: mdferdousalam <mdferdousalam1989@yahoo.com>

The --date option in git-commit accepts human-readable keywords
like "now", "yesterday", "noon", "midnight", "tea", and "never",
but these were not documented. Add them to the "DATE FORMATS"
section of git-commit(1), and expand the --date option description
to point readers there.

Signed-off-by: mdferdousalam <mdferdousalam1989@yahoo.com>
---
    doc: commit: document special date keywords for --date
    
    The --date option in git-commit accepts human-readable keywords like
    "now", "yesterday", "noon", "midnight", "tea", and "never", but these
    were not documented. Add them to the "DATE FORMATS" section of
    git-commit(1), and expand the --date option description to point readers
    there.
    
    This addresses https://github.com/gitgitgadget/git/issues/302
    
    Signed-off-by: mdferdousalam mdferdousalam1989@yahoo.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2051%2Fmdferdousalam%2Fdoc-commit-date-special-strings-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2051/mdferdousalam/doc-commit-date-special-strings-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2051

 Documentation/date-formats.adoc | 12 ++++++++++++
 Documentation/git-commit.adoc   |  5 ++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/date-formats.adoc b/Documentation/date-formats.adoc
index e24517c496..cbf651a8be 100644
--- a/Documentation/date-formats.adoc
+++ b/Documentation/date-formats.adoc
@@ -28,4 +28,16 @@ ifdef::git-commit[]
 In addition to recognizing all date formats above, the `--date` option
 will also try to make sense of other, more human-centric date formats,
 such as relative dates like "yesterday" or "last Friday at noon".
++
+The following special keywords are also recognized:
++
+`now`;; the current date and time.
+`yesterday`;; yesterday's date at the current time.
+`noon`;; today (or the given date) at 12:00.
+`midnight`;; today (or the given date) at 00:00.
+`tea`;; today (or the given date) at 17:00.
+`never`;; a zero timestamp (used e.g. by linkgit:git-reflog[1]).
++
+These keywords can be combined with other date constructs, for
+example `yesterday noon` or `3.days.ago`.
 endif::git-commit[]
diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 8329c1034b..840bc52096 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -181,7 +181,10 @@ See linkgit:git-rebase[1] for details.
 	the commit author is then copied from the first such commit found.
 
 `--date=<date>`::
-	Override the author date used in the commit.
+	Override the author date used in the commit.  See the
+	"DATE FORMATS" section below for accepted formats,
+	including human-readable strings like `now`, `yesterday`,
+	and `noon`.
 
 `-m <msg>`::
 `--message=<msg>`::

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
