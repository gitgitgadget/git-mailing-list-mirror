Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781534F489
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776297488; cv=none; b=U82NwWjMEXSXA9JMDCyeanveTsUq+Q4tvfwXMfgDnb+qbNxhTBrT6XFh1JqdYd2afJTOAohCvs8NofHMo/Zbta404Gl0xdL2E1RukkEC4TuBjjhDVnIe/nruwC65oZom3hFTsNJV48GG8+B7scnsS6S9hRNQauGunJo3pABW9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776297488; c=relaxed/simple;
	bh=y2nSAJBwzvhWXO4eSanZuc++vPoAZ4MkxJeJsl1Ws8g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G61J+2Zeh4Yrgph7m+N1nR1Uajc5mKdR75dRQOEbaD32YuFjJ7SMel/gcEZdzBtLlIjKllh/0xSZARc0+AxJP1qF9KQITEfKc4Oi5V+pSrqlgVjMtbDUY9Liw+14Kaion7xX/hcW5RDIkClhmfhCs/W55J6C4GBxqxxRAAbHXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K85oJhsn; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K85oJhsn"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfc5941028so1064031085a.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776297486; x=1776902286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBXK4s3NaZh5c0/TQ3XGZvFRJC+0QDlqp47dhdObDx0=;
        b=K85oJhsnAcNlUCUVRyWaiY6mMKXbD74OR4JkZmgtXiVMi0kU6Z2dsxk6/eQke0Uf0x
         4LZp1ECPHCQTAFL8/hBrY4vVQQ7FEnR8/VsS0YxwM9Jft87Kkzl8lT4KWGaWhwgKRhVq
         fRnuaQ5rJrs92YV/BgLITE0AwIM7ynLxsB88e5F2vEeP+lil1zUb1R7v5EtT9jiSeEuY
         A0gj66qhCtND3SgqjuBCL/qGbbFRm6PsoK1wB6ZSk8+MT6G91Nxg+VB8W6GiplpTS8Eb
         Pb1GXzcq7bnMeLULDv+NOqoc+eTLSrwiSM0cS7Rqo6o+dFltVB5TVsdTqRGQopKeyuUn
         7YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776297486; x=1776902286;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nBXK4s3NaZh5c0/TQ3XGZvFRJC+0QDlqp47dhdObDx0=;
        b=b7sWH15g8OuxS7gejXNqkyXSI4sfDsYAuQI9jSbWPDZd5RdNPaA62+zMwv2HwdtHw0
         j23eSMFxUkN9T52e97KSUVn+bQ7e6z+jCzrF3U+mDXI5Us0AUc3EINYsTIgqkX2DQt4j
         9vQ3KljTKtueZTLny3bDwe9WlZeCyBOMZRju7gEypzdbeFU2fQ+xi7hGWc8CJQizRvqC
         4Ax9KWtOkQsgSCuYeTWDHiiE12M+GIOEUnuZP2tMLal0l9mFF5zzje8fDDEqO3eCZ0iv
         qnSOjq9nB2/ipi/ymQGU5OdjP7tCHIhCY7rQRRLnY+w7S9Advm1ClWeVL5Nkr109DEpJ
         DkQw==
X-Gm-Message-State: AOJu0YyNRcNRiCm80ysUAd2qYuoNZKr78ZclfgQtYjAcuSwOjuHO2sY4
	Ehd0zk15XrP2ylVbiQM1FAnQ6+T71EZGpcx/aCFe87lv77Ti4pxATCDU3NXGdQ==
X-Gm-Gg: AeBDiesytcJ4Mfs3sHI92a3n6OB9t7Jr0iAA9bBPF8Kkem9aOyKqTqrV2MQHLwvWVey
	DmHMkt0/PFmL49c8UJd1LTqBUe2MpRJKUXjNgPYqi4Wa7t+ew9kDoKF9oz4K5hkS0q41/YYTJQ4
	AeAIkKNuPP3Lt9lZ4KGQu5oBxC2qoaeTYnivQL7dIHPvYJqyp2FAtMytYptTlSnG9hcp9qRHawi
	/JGuISkBzkwItHd9awZGAOzOIZV4bnIUBDKKSKCUOOyQ2d65TPCWbfp2+dVX8sSSgdhlPFCeFW+
	29AXNl56YJT3LrjM4NMnyJoJLM+y9uIcoWDs+BlTgWmaHtL7Q132WbQ2szyl7FEHnAivqzkn0Y/
	K/l356ns5RDgwQPu/2twP0qYPS5a7dWFAHfj9WhNjBmn47NRjniZKswGGTq7F62UikHX17TXfPM
	gtdSbznevt8kipmhhYT/nOesuqYGU=
X-Received: by 2002:a05:620a:1993:b0:8cd:80f1:f473 with SMTP id af79cd13be357-8ddcddd8769mr3454946885a.23.1776297485831;
        Wed, 15 Apr 2026 16:58:05 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33b570sm286887985a.13.2026.04.15.16.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:58:05 -0700 (PDT)
Message-Id: <173831ec92ea712a72f790f3a8eea6643ef7488b.1776297482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
References: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 23:58:01 +0000
Subject: [PATCH 2/3] backfill: document acceptance of revision-range in more
 standard manner
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

302aff09223f (backfill: accept revision arguments, 2026-03-26) added
support for passing revision arguments to 'git backfill' but documented
them only with a prose sentence:

    You may also specify the commit limiting options from
    git-rev-list(1).

No other command that accepts revision arguments documents them this
way.  Commands like log, shortlog, and replay define a formal
<revision-range> entry and include rev-list-options.adoc.  Commands like
bundle, fast-export, and filter-branch, which pass arguments through to
the revision machinery without including the full options file, still
define a formal <git-rev-list-args> entry explaining what is accepted.

Add a formal <revision-range> entry in the synopsis and OPTIONS section,
following the convention used by other commands, and mention that
commit-limiting options from git-rev-list(1) are also accepted.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-backfill.adoc | 15 ++++++++++++---
 builtin/backfill.c              |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
index 246ab417c2..bf26d7694f 100644
--- a/Documentation/git-backfill.adoc
+++ b/Documentation/git-backfill.adoc
@@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
 SYNOPSIS
 --------
 [synopsis]
-git backfill [--min-batch-size=<n>] [--[no-]sparse]
+git backfill [--min-batch-size=<n>] [--[no-]sparse] [<revision-range>]
 
 DESCRIPTION
 -----------
@@ -43,7 +43,7 @@ smaller network calls than downloading the entire repository at clone
 time.
 
 By default, `git backfill` downloads all blobs reachable from the `HEAD`
-commit. This set can be restricted or expanded using various options.
+commit. This set can be restricted or expanded using various options below.
 
 THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR MAY CHANGE IN THE FUTURE.
 
@@ -63,7 +63,16 @@ OPTIONS
 	current sparse-checkout. If the sparse-checkout feature is enabled,
 	then `--sparse` is assumed and can be disabled with `--no-sparse`.
 
-You may also specify the commit limiting options from linkgit:git-rev-list[1].
+`<revision-range>`::
+	Backfill only blobs reachable from commits in the specified
+	revision range.  When no _<revision-range>_ is specified, it
+	defaults to `HEAD` (i.e. the whole history leading to the
+	current commit).  For a complete list of ways to spell
+	_<revision-range>_, see the "Specifying Ranges" section of
+	linkgit:gitrevisions[7].
++
+You may also use commit-limiting options understood by
+linkgit:git-rev-list[1] such as `--first-parent`, `--since`, or pathspecs.
 
 SEE ALSO
 --------
diff --git a/builtin/backfill.c b/builtin/backfill.c
index a9edddcb7e..e934d360fd 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -26,7 +26,7 @@
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
-	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse]"),
+	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse] [<revision-range>]"),
 	NULL
 };
 
-- 
gitgitgadget

