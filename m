Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051537AA86
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769895810; cv=none; b=DJfkAGgndDjoB8LJom6g5nhtFGC6/A53IZhVJKysWomndGPaM/Xaf6U0Up+crmpeApCASW63xEMg7jr+rgEBeegqRW/LIRbFy3v3dOGVi6WN/N42ptNge47mGfxzeQTQ4ehCZVi5ZRO1d0xk1gcnJSm12ERPEY/d4iSR85lHm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769895810; c=relaxed/simple;
	bh=yeLcNkMprICpGnSDvELShbL4rev3QXko4581zxB/Fsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2BVOt7JJoE5jV/V1k3zt5beBjPCLg4eMEizBHMcXoADORR2w0ZpAErIRaxxCMrjwEg5RlGOzBQ5v3VoSWfbDRJg41IsE21gE+A2lwIhBVBL9c7iX7l8nlGx0CthzUE86BKv1GJWHS1rFEevOMD1SPxpv5hwOVaU+yT13Tcjr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2ixSudh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2ixSudh"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-502a789834fso29097261cf.2
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769895804; x=1770500604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWFUNBp81UCiOBSYciTDVrL0jGP6jkQawzBNOfS7sCU=;
        b=W2ixSudhQAy1tn0Wes1dJlYPNVRAn0HvQU3Fc8IB4AMX4f97XgwsxnanIGsIrjnEXk
         4BdrW034ZDY6Olqxq6Yqd4ZIrlw6LpJ6Kt/VlNPgZw4Esm7ejZJqXEVB+82XjKOv4xel
         kd54XuJfOt8SC/Zc6xKDHduff40Dfz674cUJIpirLyT0Ehq8OQOVmiMpL2rXiiqlcj6S
         2Kh1XbMg5p5FMTrpHY5Hhxn5FJlht05m4bhNEeA3aoJNzgCxxaWmKtvkKne04mOEBEW3
         0zXgp+NMDjiA+a8z/yTiJdOGX/yfSdcHHGgCzWVm8BA/5QTZjorHBArJSA9iqaul72HJ
         pdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769895804; x=1770500604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VWFUNBp81UCiOBSYciTDVrL0jGP6jkQawzBNOfS7sCU=;
        b=YLxkuVCkPpaBpwR9s4s1DxRo69r7hsLxpaRYhERyN5qZn4o8rAAkSIETmm/Oo05Cle
         8GBo51UBG1qPU3qaqpChiFOYKK7VLpV9JlssD8px8nsg9TRtA691StXA8S8M/tt2qIAn
         FYNEpf3fieadRnjlhEqcjf6f+CY5x3iMTa5G7oJVpbFLn68VtJLwtK2AZ8ez0OkZJdPU
         sMY1ZAUgbKDn6EGKI9DvGBpx2eNHOUFydT0hVXLoDP8v0OPHmeZkZdhcZqLBnAvbqdw1
         ka9jZ+7XBpIxzqDWMOePb+CVwZI+t53msfHv/Ak/K1JXKekpdd2eznnSGcXcVjtUufom
         mXUg==
X-Gm-Message-State: AOJu0Yw65kCUsW13L5/FlltpMrH+YDNm63F+qGc6GfW2A0mYPtqhj6D6
	bvGHnHFkkaoUIM6Kal0Qe4RzUDIlb7FkEnG0OT12sY8FXouj0HzDWIR6jirL+ned
X-Gm-Gg: AZuq6aK/+OkRqGEQXcPWfAYiGBcPfH8EpeRJA/flebQ3asTjx8h/0tT6fvGGggvAx/H
	PNkV9qMXnpd13+up8FWOWaD5ESvM7M7uFw7czFzFetKptXW54lRZbcTJX4xB4Ekt5Aiq7y6v+O7
	Ypib0QX+ChxEgbcgABSCQzpS7kA9ynC3A4pAwLbYyd1CWsktOmEWM4kU9E1HMMD32LDAv22cedK
	6C8osghI9Ehcjtdf2ZAkvmVFRWS3MXk8sUkwHN0jzIwQ6NB/MaTe6y6w4ctkfIRKHhTcDdYXENX
	9wD7Nfz6zQOELEDivuleE0Q1owIyyWSyiy/GEiVwfMLck5ki9FDwT0UNFR02ftyHxVe8kBkSF4j
	PzkmBb8Vp8ueZtGcEasWbzE0f8IP/o7uuMJZCZsOR7ZmPb8RjVEKIEaCkKjUCNHJnplERdPLTVP
	zgOKJYpHruv8ELLGvxcsZr6A==
X-Received: by 2002:ac8:5a07:0:b0:501:1795:9d52 with SMTP id d75a77b69052e-505d21a738amr102767131cf.33.1769895804156;
        Sat, 31 Jan 2026 13:43:24 -0800 (PST)
Received: from development.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b99fcbsm965368785a.18.2026.01.31.13.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 13:43:21 -0800 (PST)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: glencbz@gmail.com,
	avarab@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH 3/5] submodule: teach and plumb append-superproject behavior
Date: Sat, 31 Jan 2026 16:43:07 -0500
Message-ID: <20260131214309.1899376-4-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.53.0-rc0
In-Reply-To: <20260131214309.1899376-1-whatfield.git@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add --append-superproject flag to 'git submodule foreach' that runs the
command in the superproject after processing all submodules. This is
only executed at the top-level invocation, not during recursion.

The superproject execution sets the same environment variables as for
submodules (name, sm_path, displaypath, sha1, toplevel) so scripts
using these variables work uniformly. The '../<name>' displaypath
mirrors submodule output style and visually indicates ascent to the
parent repository.

When combined with --recursive and --reverse-traversal, this enables
full post-order traversal from deepest submodules up to the
superproject.

Implementation:
 - Add append_superproject field to struct foreach_cb
 - Parse --append-superproject in module_foreach() and git-submodule.sh
 - Add superproject execution block after submodule traversal
 - Only run at top-level (when super_prefix is not set)

Signed-off-by: William Hatfield <whatfield.git@gmail.com>
---
 builtin/submodule--helper.c    | 31 ++++++++++++++++++++++++++++++-
 git-submodule.sh               |  4 ++++
 t/t7425-submodule-reversion.sh | 29 +++++++----------------------
 3 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b1e202399e..f6cba87a05 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -286,6 +286,7 @@ struct foreach_cb {
 	int quiet;
 	int recursive;
 	int reverse_traversal;
+	int append_superproject;
 };
 #define FOREACH_CB_INIT { 0 }
 
@@ -438,10 +439,12 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 			 N_("recurse into nested submodules")),
 		OPT_BOOL(0, "reverse-traversal", &info.reverse_traversal,
 			 N_("traverse submodules in reverse order (post-order)")),
+		OPT_BOOL(0, "append-superproject", &info.append_superproject,
+			 N_("also run command in superproject after submodules")),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--append-superproject] [--] <command>"),
 		NULL
 	};
 	int ret = 1;
@@ -459,6 +462,32 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info,
 				  info.reverse_traversal);
 
+	/*
+	 * Run command in superproject after all submodules, but only at the
+	 * top-level invocation (not during recursion into nested submodules).
+	 */
+	if (info.append_superproject && !info.super_prefix) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		char *toplevel = xgetcwd();
+		const char *slash = find_last_dir_sep(toplevel);
+		const char *super_name = slash ? slash + 1 : toplevel;
+		char *displaypath = xstrfmt("../%s", super_name);
+
+		cp.use_shell = 1;
+		cp.dir = toplevel;
+		strvec_pushf(&cp.env, "displaypath=%s", displaypath);
+		strvec_pushv(&cp.args, info.argv);
+
+		if (!info.quiet)
+			printf(_("Entering '%s'\n"), displaypath);
+
+		if (run_command(&cp))
+			die(_("command failed in superproject\n"));
+
+		free(displaypath);
+		free(toplevel);
+	}
+
 	ret = 0;
 cleanup:
 	module_list_release(&list);
diff --git a/git-submodule.sh b/git-submodule.sh
index 49e9541a3d..58682a287d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -176,6 +176,9 @@ cmd_foreach()
 		--reverse-traversal)
 			reverse_traversal=$1
 			;;
+		--append-superproject)
+			append_superproject=$1
+			;;
 		-*)
 			usage
 			;;
@@ -190,6 +193,7 @@ cmd_foreach()
 		$quiet \
 		$recursive \
 		$reverse_traversal \
+		$append_superproject \
 		-- \
 		"$@"
 }
diff --git a/t/t7425-submodule-reversion.sh b/t/t7425-submodule-reversion.sh
index c6733234aa..7a6a54de15 100755
--- a/t/t7425-submodule-reversion.sh
+++ b/t/t7425-submodule-reversion.sh
@@ -168,14 +168,14 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure '--recursive and --append-superproject parses' '
+test_expect_success '--recursive and --append-superproject parses' '
 	(
 		cd reversive/top &&
 		git submodule foreach --recursive --append-superproject "true"
 	)
 '
 
-test_expect_failure '--recursive and --append-superproject runs' '
+test_expect_success '--recursive and --append-superproject runs' '
 	(
 		cd reversive/top &&
 		git submodule --quiet foreach --recursive \
@@ -199,7 +199,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure '--reverse-traversal and --append-superproject parses' '
+test_expect_success '--reverse-traversal and --append-superproject parses' '
 	(
 		cd reversive/top &&
 		git submodule foreach \
@@ -207,7 +207,7 @@ test_expect_failure '--reverse-traversal and --append-superproject parses' '
 	)
 '
 
-test_expect_failure '--reverse-traversal and --append-superproject runs' '
+test_expect_success '--reverse-traversal and --append-superproject runs' '
 	(
 		cd reversive/top &&
 		git submodule --quiet foreach --recursive \
@@ -270,7 +270,7 @@ test_expect_failure '--reversive stops on command failure' '
 	)
 '
 
-test_expect_failure '--append-superproject with no submodules runs only superproject' '
+test_expect_success '--append-superproject with no submodules runs only superproject' '
 	test_create_repo empty_repo &&
 	(
 		cd empty_repo &&
@@ -285,22 +285,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure '--append-superproject sets all expected variables' '
-	(
-		cd reversive/top &&
-		git submodule --quiet foreach --append-superproject \
-			"echo name=\$name path=\$path displaypath=\$displaypath" |
-			tail -n 1
-	) >actual &&
-
-	cat >expect <<-\EOF &&
-name=top path=../top displaypath=../top
-EOF
-
-	test_cmp expect actual
-'
-
-test_expect_failure '--append-superproject from nested submodule appends correct superproject' '
+test_expect_success '--append-superproject from nested submodule appends correct superproject' '
 	(
 		cd reversive/top/sub6 &&
 		git submodule --quiet foreach --recursive --append-superproject \
@@ -317,7 +302,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure '--quiet suppresses Entering message for superproject' '
+test_expect_success '--quiet suppresses Entering message for superproject' '
 	(
 		cd reversive/top &&
 		git submodule foreach --quiet --append-superproject "true"
-- 
2.53.0-rc0

