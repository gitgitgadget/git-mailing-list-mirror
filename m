Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB843D34B8
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009045; cv=none; b=Yp4H8XRMQLpX8+i4X/YuYtq8n7nN0NlRNJxRX042Dsaak8Ec5BTWU/SP4jrUTPc1za25f7ZgzwTKsAh6OC3Qs0JO17Qe1NaEWCZjybLUBhyEC7sn++5q9TeDixk7O/OSkFaXL9KVHG2Q419Dn25eMqpumXArnrnByEw02F9HsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009045; c=relaxed/simple;
	bh=yT+o62yAXT/D84VrkzQ9c5MAKAq4vhT81AvBDf2HMeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uFW/48+Bbw8KdtLV2XhzwzCfQuVfd+thbMw9FS9elSzvdUxCD4WaPDFOm82DbyHUhrUt6WuTAglA8KQWoqbn1Ewb/zJizyjd33tQo1jVg1qUCRyoax/vfjm2twYoZ2HSdgYDKWeIcAvxH/R7D2usS3x5Z0KSWKiNiiYltTff8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY8mjhIB; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY8mjhIB"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40423dbe98bso2513597fac.2
        for <git@vger.kernel.org>; Tue, 05 May 2026 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009043; x=1778613843; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=BY8mjhIBooPGWXomxiwSu/yzp1WF8JbbRZSqpVGjaGGjV2xh37IZdIQAsfAB5LKZ0L
         BlqWBIflakUEu78L5IXh1C2TcMcKi/DOKDXqP/ANoLOedFbOPUgnpe8TjLGsFIBbsgO9
         QdpA3guAiAtYVIe7zlZtA1J6vsjI9JnTDlQcBVFVMaDK5dsyqQ8X/84SYRjOiY/rpfrs
         nl912kowhH2AjSvBAX6+aqIsro1D7F9BPvCV1ow132YifPDQMDdhytzE5d/zgTI1QtB6
         h8KyAOm+ZNXy3hscylumofPZ84jff7roUOIfM3VoaF+l8TwTgd8pXNtIDE9DFpfZL1gU
         omPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009043; x=1778613843;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=ZDGIldiI8L3Qx4BpvyeN81JiP704DQnWvQY3wcUg2JJz8jz2Brme683V+cBqf0VbRt
         7x03H1LVRiPIZ1ydsbVvWjcyQLfbe+W+7ftYyYJ1viXuHUkzYuIZRphKynuljvWFAwmR
         Uf+6uPvQ8h9/wkPhNzpJhY5vRSydxohj5J277ydsYBN5ANeXhZr4QBY9upGL8W55dJ8H
         izZD8WfgVLb2w6etS8H19yMSmINqVcKYoCLss01cQQ1wX8AgO0dKEeyjbis0KgJ11duf
         3VsyKWeF9uR0HwT+l4cMYpS6Fzf9EUzX6wTzz0fiOVcruLTLx0Fdg2tK0Q5ilxLSLIM1
         AlfQ==
X-Gm-Message-State: AOJu0YzcAk3U341PrmgOXt2wdgyQLeMfZo9ixnYcCmhc+ZTMiYAVMc+n
	MHb92S0uk5QFgxqRyjkoQUE1aNT6grTCp7V4BoA67+o8JpkBOYyesmkm7nz+sA==
X-Gm-Gg: AeBDietC2dqEc4LB2UmUPtVZbYZT4sdRsWVdrKk0V0mnbk1QxAGj7yrfhJDk6bm04Ya
	EbmYYbjrAJJlI3lL37SW2xTq43DGnJT7w7s1yLCcvLLKNsyYpVr9cVaHChAGVDYYZBCIMCQJosA
	o9Ku6z89tM17zXeA1DEvkeFW+rrpyxBu981qt8BZN5jOtnwnujSh4zBI73N38vW8N2UA517JvX/
	URzUaEXw+zi5hC+CAGXJumnJmOC6cr80SPl2L8FPwKLML4w5H7jS75npJbGRivyMuIqX7AIL/cW
	wXQcUTvScOLopVc0CLFhoeVK0hs6pWuECm2yZN/AisjZERaAKy/yxTfitP9xV780QsZ0orKhq2s
	evRhYYnF8Ptabx0J9ginRZeza7NqD5c9fuAxDO/LpX9CZGoUDLhFII2ewRDvYFjvLsCkuc489RE
	eRE5us5oyvin3QhjrsNZZOXMv78DPse/GKG6+2
X-Received: by 2002:a05:6820:883:b0:696:8ccc:5588 with SMTP id 006d021491bc7-69998d4534bmr85481eaf.42.1778009043178;
        Tue, 05 May 2026 12:24:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.108.21])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d53a55sm14444721fac.16.2026.05.05.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:24:02 -0700 (PDT)
Message-Id: <807c9f981fa05bd6e06228e54ddacb0a397a0f98.1778009038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
References: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
	<pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 19:23:54 +0000
Subject: [PATCH v4 2/6] branch: let delete_branches warn instead of error on
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

