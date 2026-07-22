Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D7380FF1
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704246; cv=none; b=f3aT3NBPHLcqxOU1yb3XOrdJKhcP6/VgHqVWrVJNk6QbhvU6TH8rjbLqgUivs7FUcNUTbLK3txY4kZkGYz7D7aZJ3CeaX8KR3y31EoxmfLYybXk15sx6c590LxmnuvvCqkshbebghDXUJcJd4BiHxBgkcUFHsuDrHRRh5IeAGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704246; c=relaxed/simple;
	bh=w5sdqWSEAZIVQnbo46UE5UcLz/88iBb8Jnn82WM3TkM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jkOgXi8jXT6uhuSS2K/NB7gFbOsiyW6qNhKDCehkJFXfEEAMA6F3ZiwUVWjNvdT2x4aYRI6x6kyJ1blKbwQK5K4I865yYUwAEQljC0cehRuQolA5S0Hinim6gBoQnYm4gStn362CrAATLeqpS8p+QmrOqAQ0kfZiO82I7zSdDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktd8zivf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktd8zivf"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c21495722so86404181cf.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 00:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784704243; x=1785309043; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mPRt0rFK2yh/Mmw+VUwg9mLY/Js70AU8IHrpxB3N+pQ=;
        b=Ktd8zivffLh1aLLecSMNX3pe3xoyyk1ekBl8xEgIwywBPprMszzrD3xGgdWNPTVChD
         3LhlBhPnuIIxKLEELNZdJ4oMu6fCtdoI1NHJblzSKn/luImvfbB3HgHZ+Gx3WqHS+liK
         505+F2L9Q9ESk7gScDacJx/WAyB+ebnhXvOJ9auR0i6KswIm4bLOQhP+hwYDf5RC/9yD
         wzQ7Eqq/bnd1gAMPo17aOUakP+2oZG3z1k0QDiMSwglWWeYVoVsxsEriIP7Ch1GocUG8
         QOH9E486ajD2cRC7lUDPF1lYFP2w+kX07/+G1+0++kuAc3+hPrXskqfPh9g3BbWWPjV9
         /rnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704243; x=1785309043;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPRt0rFK2yh/Mmw+VUwg9mLY/Js70AU8IHrpxB3N+pQ=;
        b=HeOG6H+woTKi17ahf2fWzD70cfEPtvZDeRYfTYALY6exRtrLFvdU6EB/KBPEnTTkyD
         QPAcB7QiOAbnSKKT/Im5KwtHXvnHhefRLG92jItBsTAK/TFT7wzb5dl+MViAV9akEM4B
         7pMKJcfnK28kbo91dVpUjEfxfpPmq1l/hSPdOZ8/DgXRcHZ7URlm4HbqBBHzsEq4YA4v
         MzMR/VFbPU0ZsBeUhT8x/SrDoVn78hi1e/3jr5NZ4wp7URATbIwzO3fLfLT1bwK5mi9J
         hHuzV5o0NpW90NbCeItLkBmmH9mYg4PuW4eflvrdVAm8hlJDzCVYnxiAGvsY3belBAN/
         MQ7Q==
X-Gm-Message-State: AOJu0YzcIXoh7vTV58xEu6GidMdtXd7I6GLuhr659wzSIdAj6b8+n30H
	92c6/yfU8+A4MUoq2PQQO+Hi57Liux+5NZI5XQGpw88RKC9VWxE8jln+yJcw1A==
X-Gm-Gg: AR+sD10l2/z5ofwmAK0MYTcUquC9GZuQzpIAQgQ0WEgAs08z/wW5eV5zqK8EL4MfaLV
	9mXqI5hLV6DTPPng3O8jZhT9351Hvl3gsYx9gdKT2jx2oxCZ1SPLInRXOwrynBSugCcTjP6HNSK
	bvspRZjv+s4b8SzxhxGnKx3djmkJ/fFZlsHd8PuC3n32XCcF34uzCEN+FoY/hpwjeLPza+gLdzc
	ArQ12kLPSzQsR51GpCyRVN0TzRdurz3zMbRmMVSVOq+hQTnBy2HKOdnq0Tq4xZVzUOuXWj6y1ph
	QuygTmPW4XAKh/T+Xdf7FDEgpf4Bz7IMt4twfvvlh+eB/vWajewP1TyjIfMMeNwpvDygbyhAGWI
	QMm8e57/hVz0/9lkn06S+g8uRJDHdfN1CMv56eZTECviV/G6L4TJd/3O4HdVEhtErHsRrRGgXIA
	1ZlOm/gGfrFPE6hg==
X-Received: by 2002:ac8:5a04:0:b0:519:f420:d780 with SMTP id d75a77b69052e-5213c7e64a6mr199987111cf.30.1784704243305;
        Wed, 22 Jul 2026 00:10:43 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa0b7a0sm14640866d6.36.2026.07.22.00.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:10:42 -0700 (PDT)
Message-Id: <47c5975dc751ae0f3a9e33ad4ac28b51ea6444ca.1784704238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
References: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
	<pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 07:10:34 +0000
Subject: [PATCH v20 3/7] branch: let delete_branches skip unmerged branches on
 bulk refusal
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a skip-unmerged mode to delete_branches() and check_branch_commit()
so a bulk caller can silently skip branches that are not fully merged
and carry on, rather than erroring with the "use 'git branch -D'"
advice that the plain "git branch -d" path emits. Existing callers are
unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 09631f93f7..504117d1c3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,6 +192,7 @@ static int branch_merged(int kind, const char *name,
 enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
+	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -205,10 +206,13 @@ static int check_branch_commit(const char *branchname, const char *refname,
 	}
 	if (!(flags & DELETE_BRANCH_FORCE) &&
 	    !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (!(flags & DELETE_BRANCH_SKIP_UNMERGED)) {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -315,7 +319,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
-			ret = 1;
+			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
+				ret = 1;
 			goto next;
 		}
 
-- 
gitgitgadget

