Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7793D6695
	for <git@vger.kernel.org>; Tue,  5 May 2026 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965754; cv=none; b=NMHug0DrURcDy8AOk24OYGHhhRgTYlkNJC0czQPRwvMAAaBywhQVqdD9Z1C5q+paarX3v4yBfClxTEY3H1yQ+qYQ+801Qy2fCOCFSVVzlUI5h748ixUfHldQa+Bol1SYK9wYEMvhimFsu2eS5Bp7oNLdYlYUQLDDwc9p8SKLMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965754; c=relaxed/simple;
	bh=yT+o62yAXT/D84VrkzQ9c5MAKAq4vhT81AvBDf2HMeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=h94A/t1Hcb0O0fwThs7ZehFVNkJixOpxlkZs2mKiNmkvxqDq5R/f6gWMrj5rJjbP4oWgk+8x5DUeg0MsFqkPzcNZOpv4eSRVuI9+QqfvY4HbqzlQK64BjlqoEfQhEjrPv1QQADZviwiqYpH7y+C5JZL+dDZiDa/KPdHwfaG0+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly9Lptd6; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly9Lptd6"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso51432266d6.3
        for <git@vger.kernel.org>; Tue, 05 May 2026 00:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965751; x=1778570551; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=ly9Lptd6e+l4vCG3YJcGfTiqMatBe2Ea5g7CRQCzyr708rnVWMQGr0eueq3268Drpn
         fANgoptt2sH7J2JKv837paWjWPCIp966/VBFLokSejWhc8JARpqw+TIhHjNjlkSnse38
         NcdWoyGjGsFrlvtyMFDEomEdLNTerTXEUMxOH+RTcoJR2VV7b7GK3C7Oma9MptZo6kFT
         fns7MmNbGBXLaBYqj2+1kWTDSvDzZ0CWcCCQ8ASzUfowqrOAGRgCK2AZwYZxiGworZ48
         GbvQUzMHF/MMthZplyN75tnZFYLQczJlDQzbir/8g9o6FwNLBEkbBAtMy1L8iJf2TAen
         lfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965751; x=1778570551;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=FdstCpsXc8XyXlCyANSHlznU/MhSYsELaafGywgoQKQYkw+A0iVYmOjKK5l4U3jDmF
         KLdCnhxtszb6pfJfBpC638UDTyZueHDYce4zr9BBur3ic2EIBexdUPVt2dptYxSTzc4z
         0vZO6Chp6c/OPqYifyPvOzjrqqRfDCEAe+cNZW4ZSX0ZZbDddGNdVe4jnBR3lax5b1v6
         qHCr62gNqnjvokJCo6ThKU4B90sHXrjV5YcDp38x6/DzQ1QpUVaew+JXO30NZzZnFNQr
         GLKvoN/OeWDi8KuUOUsRZSqeghjzkWt0k+vvuJfWajZVxpduassAN2p6J/hVMLSWr0SA
         oHhg==
X-Gm-Message-State: AOJu0Yz7rx+mhqbAke/OZt7j3nCnPo8+xNsoyZorX6KVUhnJJTXw377U
	JLq9EkiZguDycLASCBc3k1+fUKHOnMw2Cr43Zm+ygqIkujWpzS9QaYBc4tkuAg==
X-Gm-Gg: AeBDievlr3n2mIbqs5UYQP3B0sSbjiG1KTm482R2JPnAACN45GrTh3GuR2jjblN5qoa
	Th4TNO5ahLUfDnvTSDdLazQ4lit2wXcSsCyDWHbdxwMwcqxa319jaSjC4cA08YQRcC2fuAvqdAD
	zbsXEXTndazJTlTDgJpnr1ZZq23qqC4U0hyp+2HjQixXI+sjteWAPKxIcnUBsrlCsEgIHl450jC
	FprfUy9MFnQX/c5Grw+vntnUqFaPqOQpKrilxwxA9czcnarFrYnlAzXCngRPhQ5V+xJj3ILOlY7
	hlPidPX/yIKVNvCXP+oRKeQxUFbAATfhhxfAo4Re8cx/rHS3ou53KlPnc7oNLVlczGXd+D5G2Ig
	pCV1xvun7csuJ8dmnrsg97M9cTV0K5NNMHkkwa1/B7hNBvV1tz/FLMrMliiaIheC+dVUlvHYl6p
	94hdkoKUvz/XUa42BP/e3Vm3PApSrvxR5/KjZ4
X-Received: by 2002:a05:6214:3d85:b0:8ac:a57e:ec1f with SMTP id 6a1803df08f44-8b6682578c9mr223015296d6.29.1777965751485;
        Tue, 05 May 2026 00:22:31 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e6d72sm158848216d6.26.2026.05.05.00.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:22:30 -0700 (PDT)
Message-Id: <807c9f981fa05bd6e06228e54ddacb0a397a0f98.1777965747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
References: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
	<pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 07:22:23 +0000
Subject: [PATCH v3 2/6] branch: let delete_branches warn instead of error on
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

