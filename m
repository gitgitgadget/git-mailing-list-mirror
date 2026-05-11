Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904093BF667
	for <git@vger.kernel.org>; Mon, 11 May 2026 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492700; cv=none; b=rN5CC0eTv9JjuM8RBMvxpQX4Et0wde9LdFDTpkj9J8gV8lCbMOg+6Gl8GZqXk4icvnu+HYsuGQPgu17CurFMsjDIlqHbeywWv8wXQkXrhzyFj9dkEHPC38l9CutweV+Dw/hvF8KQyw+j1PSG3+lJU0OY7ZKU+sqf122YOn9X0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492700; c=relaxed/simple;
	bh=yT+o62yAXT/D84VrkzQ9c5MAKAq4vhT81AvBDf2HMeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g1wSg58wrEj98g8wfIBmkZH8KgEXF2d1pjolWh5PBj+wcdrPdPrkhGBPWekwWGeOMmQK4tPtJc2+ahg2Cz8UtjTHLeyVIKSp7i8D0pX2YHv5UhIvFHfD5TUWEDiU6e93PmxQgyip6WfMx9Xx308aQWD7Mi/13tGgroE3q7kyd4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6oBGTj0; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6oBGTj0"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f7020a928eso5483580eec.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778492697; x=1779097497; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=s6oBGTj0+uKNEVbrRLWuLxaeoP3ygd96lmiw15TvuU1zh+dH6CGCFqKF4oNxrPI2tj
         xcFT0DNrG/OOKPjxbgqQAtaS0Nqd36z3RC4IjvSuAQsRfxJN36N6wpSjWTCELNxhFn+q
         pS/osFZYqjblnN2bcXpkJ+2CX6oozToBd01viS3LlWlwB/PgcPoJpreglM5UwYc4PTyp
         +R/4oGg5ZGRX9V35QXMxcCmHHuSH9dDCvCWZjHmqm1lf2YxKn9jDsr5nn4vticI1sgG1
         yl62PDAuBDrS5nqJfKREc4R2duEH2BrJjLA1kS3FUJ/kOeWOESdMAqs2geVMDbCX7aQd
         +msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778492697; x=1779097497;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=bNptOoiN1dFABaM62BNPjz6TRmBNGJl0j23Q19TmVZlhbHKdYD1OMiBX98LaV/7dLz
         Cgz0m7tJqc34gD8jk0F0YP8qst8KxwZOt6fs5r9ICwEbAOfxQBbGl4XGv2iV4CIPeYPg
         dvmYPtzMq3wNySzPaI2QDTvWi4F/OJfrIRTu9Ko97EcrzQ4JmNvMlYsqCy6FaIBWFmcm
         KEliUciGZn/gakRRLlojbCK7uSF9DvEExo+0lJfHu+0/I1GqZFIOICvFXjaGhbla0teL
         Bf00YSnXll13FliF27wWaFgj4XzFd8wNaj6inT2lK9TlOuwc85EKcu0TRlulxD2n2iEj
         lyDw==
X-Gm-Message-State: AOJu0YyANyI6nnwM6/bCRBHue7wpmPgSjsDve3xQfEsRa5x3aqjOh/s/
	qPa9HkpWGJYRh3rFC/2O6ccpeKQgy2Foyo843YyS7jyTyjQEEFpcsFVv66y6fPSb
X-Gm-Gg: Acq92OEiO6FxVxTy9Vc5+Whrrr1M6VJvG95AItPClzBZvMoY0fyTS7T27QxI9e9Ytoa
	jZh+z2MinjrQt8T/Ur7rmi5ZR6Z0UfUG9f3jQ/qnSQF35GG+V5/6yS/b+LGei/cxghhapU7Kb8X
	xFiLlrGhOuRGVc7Ozq2vRkVqa8kU3Xu5iDnZN1UNPa2gNYIOaTDmfTP8HvFnb5lYodrUk2vndFU
	R49sr9PosnKxTRUPFS1spxO0PkScCnJb19oAip/ZoBD04sY/ZyNZOWwuE3DvOw/e8AG/kECFwC1
	URkMz0C5dVwQKZ09HE23w9zqBcmAJfB8MMIatZmdkKwSEA2L+uTI/xSw4pAcyOZBXHlCirZTmU8
	HTeIpcS8uba1ruOLGmhQfs3FgyRbHQPS8tD+SHo021i076e7xRZlDRn45sNPaBUmIfk3PmBY6ZQ
	BoOpwCzKRYXCcBzVifU72G4670NOysO12FpAFJNKo=
X-Received: by 2002:a05:7300:b919:b0:2dd:c066:c02 with SMTP id 5a478bee46e88-2f54a87e845mr11779073eec.22.1778492697260;
        Mon, 11 May 2026 02:44:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.217])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm12838776eec.25.2026.05.11.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:44:56 -0700 (PDT)
Message-Id: <42a2f93d4405a9c89c3bfea3cf4f4fd4b1ad1e4d.1778492691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
References: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
	<pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 09:44:48 +0000
Subject: [PATCH v6 2/5] branch: let delete_branches warn instead of error on
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add two new parameters to delete_branches() and the helper
check_branch_commit():

* warn_only switches the per-branch refusal from a hard error
  ("error: the branch 'X' is not fully merged" plus a four-line
  hint about 'git branch -D X') to a one-line warning, and
  causes the function to skip those branches without setting its
  exit code. Each refused branch is still skipped from deletion.
* n_not_merged, when non-NULL, is incremented for each branch
  refused on the not-merged path, so a bulk caller can summarize
  rather than print per-branch advice.

All existing call sites pass 0 / NULL and so are unaffected. Both
parameters are wired up so a bulk-deletion caller can suppress
the noise normally appropriate for a one-shot 'git branch -d'.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b3289a8875..1941f8a9ad 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,7 +192,8 @@ static int branch_merged(int kind, const char *name,
 
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, int force, int warn_only,
+			       int *n_not_merged)
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
@@ -200,10 +201,18 @@ static int check_branch_commit(const char *branchname, const char *refname,
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (warn_only) {
+			warning(_("the branch '%s' is not fully merged"),
+				branchname);
+		} else {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
+		if (n_not_merged)
+			(*n_not_merged)++;
 		return -1;
 	}
 	return 0;
@@ -219,7 +228,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+			   int quiet, int warn_only, int *n_not_merged)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -309,8 +318,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
-			ret = 1;
+					force, warn_only, n_not_merged)) {
+			if (!warn_only)
+				ret = 1;
 			goto next;
 		}
 
@@ -961,7 +971,8 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, delete > 1, filter.kind,
+				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
-- 
gitgitgadget

