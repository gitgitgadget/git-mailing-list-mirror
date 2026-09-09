Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6F3B52FF
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942340; cv=none; b=cO4PRXzQax8XRsVeuDconM7t0mS5la2vdsLdWD28zOatVSET+qhbF7FvJ+A7dEHGxV+P//2ZGRaE2KEQAscQqf0EqDGKD+58jlt/Ay+ATsElgJXL1fcUTblnGXrBLicJ32Ev7QJ0hZ+LkOtZKp+CSCHfxw3XRfV7uN3q5LSn6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942340; c=relaxed/simple;
	bh=2QDzEEjEVRNOsowAPvDdhnbjWBFMm8hNThlkz2G1dv0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GWupch7YarSXh57C+/baQF+FH0o5jSdOIINT3c9wallyBLgryqBYo9KrnMRRvzbhFbeH+ldcs9eN4sfkVkixKr2MZgjxFW4i8lvprPtCNQsSZMhmuFJpSa7WHzMnzjAWN6gA7cfzG63XQ+OHcG+PpjoKqu48Lll/9kYS2TI4seM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9uOcABB; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9uOcABB"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso8201925ad.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788942337; x=1789547137; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XtDGBZDeJ9DllpMhZfzAnHkKIDTSBMO3NJf369KCz+E=;
        b=d9uOcABBMpGytzrurd4pjGp4OSWSTcnanZ+5KENpUqjzcIKZgZAMpkhfTRrcl+sG7j
         t6Q8xW+ERa9kdmoYPj31cMgI/a5svtmq0mm+dY3Dh50oc9xFSYLes4m8eWj5l/9FrPAe
         LvFkZA91e2c4SEk7FTyCa+ItRK0iDYKmYKzQxhqtnq2MyXBtQ5KgLiA0AfnMgH3DWocI
         /0vchIZUycYTft7Ow5BxgwjNOYhab/ANjZoSfPHl51SyEI9VsFBAJqmNz7smbrS0wiT6
         8P2O67EezPC+mY6gAAEpuOv3Z3rlEzDRawLFdwS2eteEL6JDQxaNWbacjS2o4VFJtzak
         6hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788942337; x=1789547137;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XtDGBZDeJ9DllpMhZfzAnHkKIDTSBMO3NJf369KCz+E=;
        b=Mhzl5A8YB4BxgNyzHTylsEPutIJVwIidphMUuKjzwcylQBi56pIogd6aZqXwVEhFCD
         bJXmPggPFHm3ZqUcdgbwPRHxsKJF16ZeC7NTSzaY8JRXaLuzmVaTiNiJW6MDsasCZB50
         +X6FiQnkUyDL7SGLOuhFW58qOwFvevXfqOjq3Y9tkWdlLTos+JW92JT5iGfLJEfKjtJM
         Q6C41loQf7M4Iz8v5kSI8OmMbNIjvz78Po8xGBqFdT4Fvw/covpxwdzNBLT+rUrSqXPP
         aVWtwJQiH4G2G4+4gByWjB/EcNHfWyuczKlNLp0TJUx9F0+34kSOampwhIPE09jh1GST
         8m7g==
X-Gm-Message-State: AFuF++kANIhQH8lhHuceeNVfBHr53P/eor4QDkLRcNUwwOLV/0dn4K2A
	IWXhoFls+I4tUDkMF1Z9Hec0qlVxj9wwvbqNck+gm163lnHJc4P98VojVtLhiA==
X-Gm-Gg: AYBFou0W/AIQqR1ZaTsfPLw3qy8WXNonmexNgNCGUKtfa8tia03NTosnrzLO0Ff1EDX
	4DSVqqU8fIKdzUR7MdkXHyDC3vDU0PWCsf7GaJ7pR0VamvFwJPbXTkeQW/WKUMWIMRZA4MEWt5q
	2UhcSVnoWwk6fNDY3NbkISj7xbz9h/yjqIzbZR+1ZoBYGbQESH/JIKjok+3622maHvmucnH47nS
	KZ7i1wj/6iLxMyhUgmKuQ00sNJ+HjICwB3UAZUZqavOtRtZoXU1il7IWSxdzWTdWHXFUEmcb0Jg
	oAp15uKsHJza0H7XWepRgd0T2mZZ/XA3z7rzK2Ob46fYSPBE0EmZaMYmDa2rHSCWHf46Zgp1zQt
	4nUl6Iu4hPNUNFjJtXqUGjRopTlDXxaBJgpKe9fLlWJwl054dp+1khvwJIllKU97rsQV3Mcncsh
	ROcbBY2/P5pmr5Ch2fL2Ve2bcq3zVdhaZML2IQ+oowCKrIXoxlaO4dxyOz8UNleKCGr8GWPBs=
X-Received: by 2002:a17:90b:4986:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39bac34a641mr7112705a91.13.1788942336986;
        Wed, 09 Sep 2026 01:25:36 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.2.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm66416690eec.16.2026.09.09.01.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:25:36 -0700 (PDT)
Message-Id: <b7b97262f27782f3271369115496c67f9774b8b2.1788942331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 08:25:30 +0000
Subject: [PATCH v4 2/3] rebase, cherry-pick, revert: run auto maintenance when
 done
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

"git cherry-pick", "git revert" and the merge backend of "git rebase"
create their commits in process, so auto maintenance runs only when
they spawn a command that runs it, like the "git commit" for a
resolved conflict. A sequence thus runs it in the middle, after each
resolution, or never.

Run it once when the sequence is done, like the apply backend does.

The sequencer has no single place where every sequence ends: a
sequence of several commits ends in pick_commits(), a single pick
returns as soon as its commit is made, and "--continue" and "--skip"
have entry points of their own. Run it from the two builtins that
start or continue a sequence instead: run_specific_rebase() once the
sequencer has returned and removed its state directory, and
run_sequencer() after a successful pick, "--continue" or "--skip".

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/rebase.c                | 13 ++++++++++---
 builtin/revert.c                | 19 ++++++++++++-------
 t/t3418-rebase-continue.sh      | 12 ++++++++++++
 t/t3510-cherry-pick-sequence.sh | 23 +++++++++++++++++++++++
 4 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 10a306310c..535db60181 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -762,9 +762,16 @@ static int run_specific_rebase(struct rebase_options *opts)
 
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
-	else if (opts->type == REBASE_MERGE)
-		; /* merge backend cleans up after itself */
-	else if (status == 0) {
+	else if (opts->type == REBASE_MERGE) {
+		int quiet = !(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE));
+
+		/*
+		 * The sequencer cleans up after itself. Its state directory
+		 * is gone once it is done, and stays while it is stopped.
+		 */
+		if (status == 0 && !is_directory(opts->state_dir))
+			run_auto_maintenance(the_repository, quiet);
+	} else if (status == 0) {
 		if (!file_exists(state_dir_path("stopped-sha", opts)))
 			finish_rebase(opts);
 	} else if (status == 2) {
diff --git a/builtin/revert.c b/builtin/revert.c
index bedc40f368..52100a20cb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "revision.h"
 #include "rerere.h"
+#include "run-command.h"
 #include "sequencer.h"
 #include "branch.h"
 
@@ -116,7 +117,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char *strategy = &sentinel_value;
 	const char *gpg_sign = &sentinel_value;
 	enum empty_action empty_opt = EMPTY_COMMIT_UNSPECIFIED;
-	int cmd = 0;
+	int cmd = 0, ret;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
@@ -264,18 +265,22 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	free(options);
 
 	if (cmd == 'q') {
-		int ret = sequencer_remove_state(opts);
+		ret = sequencer_remove_state(opts);
 		if (!ret)
 			remove_branch_state(the_repository, 0);
 		return ret;
 	}
-	if (cmd == 'c')
-		return sequencer_continue(the_repository, opts);
 	if (cmd == 'a')
 		return sequencer_rollback(the_repository, opts);
-	if (cmd == 's')
-		return sequencer_skip(the_repository, opts);
-	return sequencer_pick_revisions(the_repository, opts);
+	if (cmd == 'c')
+		ret = sequencer_continue(the_repository, opts);
+	else if (cmd == 's')
+		ret = sequencer_skip(the_repository, opts);
+	else
+		ret = sequencer_pick_revisions(the_repository, opts);
+	if (!ret)
+		run_auto_maintenance(the_repository, opts->quiet);
+	return ret;
 }
 
 int cmd_revert(int argc,
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index cb5c3a1cb5..025787b5f2 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -395,4 +395,16 @@ test_orig_head () {
 test_orig_head --apply
 test_orig_head --merge
 
+test_expect_success 'rebase runs auto maintenance once it is done' '
+	git checkout -b auto-maintenance topic &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
+		git rebase -x false main &&
+	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
+	echo resolved >F2 &&
+	git add F2 &&
+	test_must_fail git rebase --continue &&
+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
+	test_subcommand_flex git maintenance run --auto <end.txt
+'
+
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 5777dff496..2bea55c3b6 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -721,4 +721,27 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_line_count = 4 commits
 '
 
+test_expect_success 'cherry-pick runs auto maintenance once it is done' '
+	pristine_detach base &&
+	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
+	test_subcommand_flex git maintenance run --auto <single.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
+		git cherry-pick anotherpick yetanotherpick &&
+	test_subcommand_flex git maintenance run --auto <sequence.txt &&
+	grep "\"child_start\".*\"maintenance\"" sequence.txt >maintenance &&
+	test_line_count = 1 maintenance
+'
+
+test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence is done' '
+	pristine_detach initial &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
+		git cherry-pick base..anotherpick &&
+	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail git cherry-pick --continue &&
+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --skip &&
+	test_subcommand_flex git maintenance run --auto <end.txt
+'
+
 test_done
-- 
gitgitgadget

