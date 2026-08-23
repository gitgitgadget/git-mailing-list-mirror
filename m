Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377124DD17
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505565; cv=none; b=YCRFiILkGysURNgwwdB7zXmEXsGRpLMWad1D+DusojbjLRQZM0GmCtlNbG70wKTZDOwBXz6SNVrL7zjfeqk3H94Fjf+mDT3McvOlUD+a/isWKnotgwbQsZ/NwPUs/Or2ayDcDcYYc7T47nbTAup4+GElbG33uWtcmwY9wMSkUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505565; c=relaxed/simple;
	bh=11ZCelWp5vyZeFWN8afQu3XFiQYt1yJOnvizWFYmu5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmbNwd1S3xyThvwDLUA/qF8a4J4XxE9/kzLMrohoEt05WbRCF6ALI3yHj7MVYnS+6eXNV7+DFVeSs1wuo72QAcwZp5RoBClxSLvYxA/vAOTxwOfY41HfO0SkCjJZX6rJSgCnDOIIRGK6mntjbszo2C/bOkLC1fBIUvtpXnBcWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px2fh1/1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px2fh1/1"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc16c6dcae2so2561275a12.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505561; x=1788110361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a3JHQd/La65i81XeRoZWXBVtplWi/Y5za+A7WOEvOFM=;
        b=Px2fh1/1M6WbW42f6ougFJNhubag5v4EbZR9p2FZW0gthZBpo0fwqgipIYMGoC2k6j
         B/dtZUTZIr2dsFSimxrKU3UBjTx9MzcIVORvEptFpXR/GD3HYWlSQWkupnezypzZvY9w
         oxYiYDYymV6NZUGElHMX/pUGyzCkUN+i/XhbUPNFzVJwjsiQin/8nIr8NH2x1ZFmLw7h
         Z+CXmb+J2UwDVaEMc2vUed2NGUVonP4A+ZiNip3h+2sMGTYA//9iQcQ5NSch7c6Nk6cB
         33kxoURRk+WWt2jG3zb7l8BrIwoILJDuUq9WQqMsyDEPny4ZrvksyoP31MvtnIuOQla1
         qXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505561; x=1788110361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a3JHQd/La65i81XeRoZWXBVtplWi/Y5za+A7WOEvOFM=;
        b=RN0MZiUcpOOhrgqOrRSlxcG2DUG5NLm1VG/X2zwMdttl1D9hRljTAqvDzfOu//G1Nw
         YLdXQcz44HI9e/+K9RePqNg+wBhBWvp4EsJtZ2Nic5Upp9EV8cfiPPfd3MNA6/sWN1ZO
         1Yb0mv0xuwRHTiHHTI+Q9LzaFHOtxA2JEplMpnsGlF472gdfyh7sR6bW7UyyN1sencU8
         5weVbCoi1FrEaYvr63PasYaG4jW4IEUcP4yoVVNNqdPGnYqTjEAM5+N35HmKj2jY2Uvd
         Yn6cWvOypW/m+ZKrhIa0pUlLYdX74jbjxO75ewtz+2J3ny0YJLx/cy+leb6mY7HI8sTF
         WGiA==
X-Gm-Message-State: AFuF++lEQgHCEJMUdY6aHBmxiPkXUj++rWm3rfBujBvTU39GNJ2dftPJ
	uB5+XDCLWSiWMebSknCNTHskuLnBs0zepuPgqcSWiaqmk7J3+lQbo0wvJhBSQg==
X-Gm-Gg: AR+sD13qWtr0DnhADQuMUWcdXpOFMmaa085LbPCmYCOvdSUntd/CsLHcNeH3QQjlX04
	Ca+w/tC80sffHS/t49qqzsYY886mqMj48Exj8Xr+/7kpRCbB6a3iO/mLPHJLv9ODHNlm7RTpl5Y
	Io05wnwcowVu/+8dzHQwc/EW4Yz1qiQFi7GR3XM1uODf2j13V11P/xh63+Xztmb4MSvvhBdDK0S
	1mE2xJsq3+lXmKnNe1fV0vMCkOBZFq/lgjVdRn8tARpJEmyMfIPimLsoGxbT1/qqBzEVjSRaiK0
	PvQ76+E6jo+Vye7HKjC8EUDLe/2PQPUpGZ3/pKAt8e9U+/yrCu6ap9kfvQBvnuQRduXM1Q9bL/m
	P0eMJ/sOCaFZN+GKYrtJp8oiN8iDrDtEp3/+k1acyd51zOJhpKoP+NILXYHZAL+P5mNWFkGb+0U
	tXxZnHuoBp7YhDpcLn1i+OzGQd8Uxa5/sKcBforktj6fMAJ9gGGFJRuSvSyA4hoRqWZmh3zRgkR
	9X3OLh4SS4lI3R2ZVsLjsMx63mvKlYXHn2VcyLq3W1FJAxZFu2aUpujmwD8bWQkqFU0Z6uxmz3a
	nB0U71HXA6Z0IyqqlOlXDsRTBaRITHeR0DAGu1Oqdgo7Fw==
X-Received: by 2002:a17:90b:3985:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-395c357d3a3mr34526471a91.15.1787505561173;
        Sun, 23 Aug 2026 10:19:21 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90cb8e3sm23998212eec.12.2026.08.23.10.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:20 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 03/14] organize: add status --exit-code
Date: Sun, 23 Aug 2026 10:18:47 -0700
Message-ID: <20260823171915.2662373-4-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git organize status reports and always returns zero. A project that keeps
its tree reconciled needs status to fail when the tree drifts, so a check
can gate on the result.

Add --exit-code. status returns 1 when a file is out of place or a recorded
path no longer exists, and 0 otherwise. A standing backlog alone does not
fail it: a backlog file matches no rule, so it is not out of place.
--exit-code changes no output.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/git-organize.adoc | 15 ++++++++++++---
 builtin/organize.c              | 12 +++++++-----
 t/t0096-organize.sh             | 20 +++++++++++++++-----
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-organize.adoc b/Documentation/git-organize.adoc
index 8b216146b6..37ada38234 100644
--- a/Documentation/git-organize.adoc
+++ b/Documentation/git-organize.adoc
@@ -9,7 +9,7 @@ git-organize - Reconcile a source tree against a declared layout
 SYNOPSIS
 --------
 [verse]
-'git organize status'
+'git organize status' [--exit-code]
 'git organize apply'
 'git organize apply' --labels-only [--reseed]
 
@@ -44,7 +44,9 @@ is not in yet.
 `git organize status` reads `[labels]` and reports the out-of-place files,
 the backlog, a file in scope that `[labels]` does not record, and a
 recorded path that no longer exists. status runs no
-configured command and changes nothing.
+configured command and changes nothing. With `--exit-code` it exits
+non-zero when a file is out of place, a file in scope is unrecorded, or a
+recorded path is missing; a standing backlog alone does not fail it.
 
 `git organize apply` reconciles the tree. It moves each out-of-place file
 into its directory. A move that git organize makes on its own is a
@@ -72,7 +74,9 @@ status::
 	in (the moves), the backlog (recorded files with no matching
 	rule), a file in scope that `[labels]` does not record, and a recorded
 	path that no longer exists. Runs no configured
-	command and changes nothing.
+	command and changes nothing. With `--exit-code`, exit non-zero when a
+	file is out of place, a file in scope is unrecorded, or a recorded path
+	is missing.
 
 apply::
 	Move each out-of-place file into its directory as a content-identical
@@ -92,6 +96,11 @@ never do.
 OPTIONS
 -------
 
+--exit-code::
+	Exit non-zero from status when a file is out of place, a file in scope
+	is unrecorded, or a recorded path is missing. A standing backlog alone
+	does not fail it. Changes no output.
+
 --labels-only::
 	With apply, run the labeler and record the labels; move no file. A
 	recorded file keeps its line; the labeler only seeds a file that has no
diff --git a/builtin/organize.c b/builtin/organize.c
index 354ba2151f..35247c5aef 100644
--- a/builtin/organize.c
+++ b/builtin/organize.c
@@ -15,13 +15,13 @@
 #include "repository.h"
 
 static const char *const organize_usage[] = {
-	"git organize status",
+	"git organize status [--exit-code]",
 	"git organize apply",
 	"git organize apply --labels-only [--reseed]",
 	NULL
 };
 
-static int organize_status(struct repository *repo)
+static int organize_status(struct repository *repo, int exit_code)
 {
 	struct organize_plan plan = ORGANIZE_PLAN_INIT;
 	int to_move, backlog, unrecorded, orphans;
@@ -67,7 +67,7 @@ static int organize_status(struct repository *repo)
 	}
 
 	organize_plan_release(&plan);
-	return 0;
+	return exit_code && (to_move || unrecorded || orphans) ? 1 : 0;
 }
 
 static int organize_apply(struct repository *repo)
@@ -106,8 +106,10 @@ int cmd_organize(int argc,
 		 const char *prefix,
 		 struct repository *repo)
 {
-	int labels_only = 0, reseed = 0;
+	int exit_code = 0, labels_only = 0, reseed = 0;
 	struct option options[] = {
+		OPT_BOOL(0, "exit-code", &exit_code,
+			 N_("exit non-zero from status when a file is out of place")),
 		OPT_BOOL(0, "labels-only", &labels_only,
 			 N_("with apply, run the labeler and record the labels")),
 		OPT_BOOL(0, "reseed", &reseed,
@@ -126,7 +128,7 @@ int cmd_organize(int argc,
 	if (!strcmp(subcmd, "status")) {
 		if (labels_only)
 			die(_("git organize: --labels-only is an apply option"));
-		ret = organize_status(repo);
+		ret = organize_status(repo, exit_code);
 	} else if (!strcmp(subcmd, "apply")) {
 		if (labels_only) {
 			organize_run_labeler(repo, reseed);
diff --git a/t/t0096-organize.sh b/t/t0096-organize.sh
index c2e6539ef2..d8de3c7e90 100755
--- a/t/t0096-organize.sh
+++ b/t/t0096-organize.sh
@@ -156,6 +156,10 @@ test_expect_success 'status reports the files to move' '
 	test_grep "2 file(s) would move" actual
 '
 
+test_expect_success 'status --exit-code fails when a file is out of place' '
+	test_expect_code 1 git organize status --exit-code
+'
+
 test_expect_success 'apply moves files as content-identical renames and repoints [labels]' '
 	git organize apply &&
 	git diff --cached -M --name-status >actual &&
@@ -169,6 +173,7 @@ test_expect_success 'apply moves files as content-identical renames and repoints
 	git diff --cached --name-only >staged &&
 	test_grep "^.gitorganize$" staged &&
 	git commit -m reconciled &&
+	git organize status --exit-code &&
 	git organize status >actual &&
 	test_grep "nothing to move" actual &&
 	test_grep "^odb/blob.c component=odb" .gitorganize &&
@@ -435,7 +440,8 @@ test_expect_success 'a basename shared across directories does not collide' '
 		test_path_is_file odb/dup.c &&
 		test_path_is_file sub/dup.c &&
 		test_path_is_missing dup.c &&
-		git commit -m reconciled
+		git commit -m reconciled &&
+		git organize status --exit-code
 	)
 '
 
@@ -484,17 +490,20 @@ test_expect_success 'a file in scope with no recorded label is unrecorded' '
 		git commit -m declare &&
 		git organize apply --labels-only &&
 		git commit -m labels &&
-		# a.c is recorded but matches no rule: backlog
+		# a.c is recorded but matches no rule, so it is backlog; a
+		# standing backlog alone does not fail --exit-code
 		git organize status >actual &&
 		test_grep "backlog:" actual &&
 		test_grep "^  a.c$" actual &&
-		# a source in scope that [labels] never recorded is unrecorded
+		git organize status --exit-code &&
+		# a source in scope that [labels] never recorded is unrecorded drift
 		echo b >b.c &&
 		git add b.c &&
 		git commit -m add-b &&
 		git organize status >actual &&
 		test_grep "in scope but unrecorded:" actual &&
-		test_grep "^  b.c$" actual
+		test_grep "^  b.c$" actual &&
+		test_expect_code 1 git organize status --exit-code
 	)
 '
 
@@ -519,7 +528,8 @@ test_expect_success 'status reports a recorded path that no longer exists' '
 		git commit -m drop-b &&
 		git organize status >actual &&
 		test_grep "declared but missing" actual &&
-		test_grep "  b.c" actual
+		test_grep "  b.c" actual &&
+		test_expect_code 1 git organize status --exit-code
 	)
 '
 
-- 
2.54.0

