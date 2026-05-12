Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51ED4921BF
	for <git@vger.kernel.org>; Tue, 12 May 2026 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574240; cv=none; b=fHeeCkbk7uDGryaAJ71n0aCTWOshIvTu7SrVYHjh54rW9u4Y/wCYFY07e/nK7S4KTFdDKWlKuYOwNtnJlewFQhJdZx8tvaQzYrQJLZlTB0y8aL7om7lMxDP2YfH7BWLhxTMqAx3xMsBxJ3r087ztlKJ8w93hji0QbumvDkktjaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574240; c=relaxed/simple;
	bh=yT+o62yAXT/D84VrkzQ9c5MAKAq4vhT81AvBDf2HMeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OP5IUPtkqMCV+HsBa4v6oJgZhLJMnmAC/co4+69ziS4B+Z9drx1v2Ls7ZH0i9RU2a+C7vt5DHyu+yT4jf8psnsZxZXY6j9AZGbDNW5ESqJCUNKe57eEQYnCNMuGRNZDJ7YSAvvTuWvc0IXkP1alJV3NgPbHLzMeBU7kMniTnmtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUp7kfUG; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUp7kfUG"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-902deb2412fso570389285a.3
        for <git@vger.kernel.org>; Tue, 12 May 2026 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778574235; x=1779179035; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=QUp7kfUGI4NdT/sTk7B3WuT4pO2NRWg8xCr/qR0S8JJk9gqPyah5tf9WpuJmVNceWm
         n4XhQjSScLWGx4sRh4l8ADXxAzIOckdAeoBbVJHi4A4Wr2q1C+D/aIwVAA2q4G7g6Y16
         0uRmG/G24fxVV91Acd5LFq2fo21AcgTLUQY5Q+9A5WFD+t739eCjVOO/qFH2IqBBwy3z
         ZWaDh1gBPgTsExNADyzrCWmZYcLUA6zh1biiZrn2NWGLx0ZLL6t+al2cQfoMUdCDAVxb
         wXr++511TOjA5aZn3hnB/yc2uEWOF2ABOTYo6KC3neS0XR027fkWi0mhSA93CdfaVTfq
         jxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574235; x=1779179035;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=VxCoAVpnazzma7DBI56G0C41tXPgrKgu8d3ClpElVfbMsV019ZsFYS6fN6YIdig7pT
         jzP1XzO1yWbOtq433IJ9825ow9/Ykl1mGhhUrsL23iqZLnUS7aiSclXzNJv48hIXRMpw
         G8CIOOhEUzc7ceJmqHTdLE80k5xr36Uny4+n1E4qks/VTkUn+uu3jCQqmDrP0Mln2KqE
         fFpQVPVyk5RWu5HxVwkjYP/xlWb7i25qKnjDOtXBRwLVxewfEZZf8i2jDf0YZ4oYlhQe
         KVma9GqE3wDZ+5cAE1gE9S1SBvl2W+jUPJGgz8fOku+FF++0ShcTxS3AmgZ23Eg3Inch
         kjaQ==
X-Gm-Message-State: AOJu0YwO0FCcWqTlsiyMmjqOerArsJIWVrpNQpTTlnnou4pKNob+YBY4
	DTzrbJeJE/FEBg3Oe7vjmk0Jkv+/Lf9SUPMsDhpyt+NhA6Y9IFxOcz7CQJ2/7g==
X-Gm-Gg: Acq92OFhr3HC9wiV13sHoaAtGx2l07JH3lQvoDuCQ/+c51wxlJJF7qTlbhVDSqKAMC6
	vpUYduG2VwRFp4gfRrKqZVayFoi5h4oGhMLXueDKGZB7X+MNJhrzYhqRbYhLCigY+wkX0UKPrW/
	2RbYtYl4ka388cqpqDugxYJz1yCT3BWTA2QLSPfCGv8ZSg0jfxlKyYOA3+Da+d1JDV+EBtsQ8zZ
	kz7sdxHIHEccxX857H8rj5kcbqpI69oTcFzfYR+h/uXYzEbih3rkOckqGMiABBmT3s4b5Hcc5uC
	HWGFBd9jxr+pMBiWXbWgxbvGX/zxRdgvU7OZQ4yLETZuDC4tuGeeptLJlYh7BGj6s9B7/hRZ3QR
	9+8CmSvNXwQk+M0e3EXE833uaIsyv0gEXje/J8FuyXoswqV7TfmiUAipbRheyxDguIE4ixjPi0u
	EnlO04+9UWPETA2OlB+Ds73T2v
X-Received: by 2002:a05:620a:2949:b0:908:a0e2:289f with SMTP id af79cd13be357-9090ebc2bd7mr1893473985a.18.1778574235019;
        Tue, 12 May 2026 01:23:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04c68sm3365365785a.46.2026.05.12.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:23:54 -0700 (PDT)
Message-Id: <b443f0f3676f0382929df0ab95ba7faf0c80193a.1778574229.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
References: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
	<pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 08:23:46 +0000
Subject: [PATCH v7 2/5] branch: let delete_branches warn instead of error on
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

