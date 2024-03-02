Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7121B5B7
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396299; cv=none; b=WXi/10Ef0tauHF/Fqf7xaLSUk8Zmg/fo0zNSsKlqrMtKIr7mJqFHB916YFt/KEXQJYgwAOLaDjZHie4/x8pbIjj5wutg1/HxXEAd7orlCl9oXKqiOt8ur0SHBYfElPXrR7/VwVmOIjJPsKMhdjn8qe/7etBFujvlM9K9spTbB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396299; c=relaxed/simple;
	bh=1sSu0m6T5AgOiTic/jzxkxz4ILScrXL9kcM4am1dBkk=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HDTgR5oM9sMvLv6RMLgXOzOvihghUBtDPgk8qztoEY1ptmkzNbiV31lCMPR2gCwnzGVrHFA76IyU4+LEzEOitjeX2G/iB6fErxCtm9z2JosLp9fWRV2iyt5T0tXcj0YdnzqVF8PYV/C97NMN7qrzaPXEeE7gwmYqSfAwDMZAJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzyWjZmB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzyWjZmB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412d6849658so2674345e9.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709396293; x=1710001093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HRJWD5SUQcvN3m5kzwLVND0l/xngotsYIaKnUnm5ILA=;
        b=RzyWjZmBgtBQ1NfQiDAiTQ7H2X3lijJyFntNiDdS6m7LqCAVCIA2D7sQ9HRRfaEWZn
         Z4/ax+68hY9rjDISP/3WkocGgKmx79sSIeYT9buBhN3LIc7jQgLm86FBVD7txi7iJ1Fb
         R2V4BNPOBUUk140dSP1dpATHnoqTIjtLQ+GMxJHfW8PpUTfP8CyMo7jYlTCarUUMLuri
         0mUMUjYJs8yOAiQ93VNXD2+4TIsDGo/lw+MpnV4gHYzksMRe7nDyGB7pfW7K9W5sxjWp
         LSWE8wXzaEis+NJI5ZZQE2vN4ilvBAyadn2mbOn4lQgy9yvLz+3lYD8Cthzhwy9kjSIV
         xjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709396293; x=1710001093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRJWD5SUQcvN3m5kzwLVND0l/xngotsYIaKnUnm5ILA=;
        b=oZUSNVPkKpL4WqK4jo3yP/HM8Hz2EJJngYMUq7BrxD9dPFcamvuliDAk51Jhn4iE8m
         GhsQFWgyqPlVA4eR+ZaPLlormwrOqFAq4+e2nxNDTJd65LsfdM43XIcEgXROj3wregzn
         xSMIDx+QfGGnreAWUUKU9qjnFO5J4CUsZDwt+m+Y7hjg94bFyUrWT3fQs4jwRxpRENq5
         hJB0PNiL1SUY0/Kboi6VZWXKh3Tm6lqi24BW6Jiegyk3olO15Z09Bom8HFvEZs32gQi+
         QeVBix3AGJdVdW3gVBh7f25RuXDkQeOdFC/PQ1MK1uxN6WB0mB97xiwHpbG4tiRBur6Z
         rfHQ==
X-Gm-Message-State: AOJu0Yw98+fi+jShi6tBsYHf48gB72HiHHhtcSrwC4v+TbQ7orShIye/
	+AwJM85OSC37h/HecAMzyM65PxnlRe9qNbz6NTHhEBcg8Py3gn4wcD92FPjA
X-Google-Smtp-Source: AGHT+IEVq1+i4aqFPSjoRhs6g+TjkWDoeX4wqPYB8wPe9dNidlEjTIa2laYrfkHfmR0xXTDpYVpu7w==
X-Received: by 2002:a05:600c:a0f:b0:412:d644:3369 with SMTP id z15-20020a05600c0a0f00b00412d6443369mr1217199wmp.7.1709396292573;
        Sat, 02 Mar 2024 08:18:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c470e00b004129ed6f9cbsm9103422wmo.4.2024.03.02.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:18:12 -0800 (PST)
Message-ID: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 Mar 2024 16:18:11 +0000
Subject: [PATCH] sequencer: allow disabling conflict advice
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Allow disabling the advice shown when a squencer operation results in a
merge conflict through a new config 'advice.sequencerConflict'.

Update the tests accordingly. Note that the body of the second test in
t3507-cherry-pick-conflict.sh is enclosed in double quotes, so we must
escape them in the added line.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    sequencer: allow disabling conflict advice
    
    CC: Elijah Newren newren@gmail.com CC: Phillip Wood
    phillip.wood@dunelm.org.uk CC: Johannes Schindelin
    Johannes.Schindelin@gmx.de CC: ZheNing Hu adlternative@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1682%2Fphil-blain%2Fsequencer-conflict-advice-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1682/phil-blain/sequencer-conflict-advice-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1682

 Documentation/config/advice.txt |  3 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 sequencer.c                     | 33 ++++++++++++++++++---------------
 t/t3501-revert-cherry-pick.sh   |  1 +
 t/t3507-cherry-pick-conflict.sh |  2 ++
 6 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c7ea70f2e2e..736b88407a4 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -104,6 +104,9 @@ advice.*::
 	rmHints::
 		In case of failure in the output of linkgit:git-rm[1],
 		show directions on how to proceed from the current state.
+	sequencerConflict::
+		Advice shown when a sequencer operation stops because
+		of conflicts.
 	sequencerInUse::
 		Advice shown when a sequencer command is already in progress.
 	skippedCherryPicks::
diff --git a/advice.c b/advice.c
index 6e9098ff089..23e48194e74 100644
--- a/advice.c
+++ b/advice.c
@@ -71,6 +71,7 @@ static struct {
 	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
 	[ADVICE_RM_HINTS]				= { "rmHints" },
+	[ADVICE_SEQUENCER_CONFLICT]                     = { "sequencerConflict" },
 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
diff --git a/advice.h b/advice.h
index 9d4f49ae38b..98966f8991d 100644
--- a/advice.h
+++ b/advice.h
@@ -40,6 +40,7 @@ enum advice_type {
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
 	ADVICE_SEQUENCER_IN_USE,
+	ADVICE_SEQUENCER_CONFLICT,
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
diff --git a/sequencer.c b/sequencer.c
index f49a871ac06..3e2f028ce2d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -467,7 +467,7 @@ static void print_advice(struct repository *r, int show_hint,
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
 	if (msg) {
-		advise("%s\n", msg);
+		advise_if_enabled(ADVICE_SEQUENCER_CONFLICT, "%s\n", msg);
 		/*
 		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
@@ -480,22 +480,25 @@ static void print_advice(struct repository *r, int show_hint,
 
 	if (show_hint) {
 		if (opts->no_commit)
-			advise(_("after resolving the conflicts, mark the corrected paths\n"
-				 "with 'git add <paths>' or 'git rm <paths>'"));
+			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
+					  _("after resolving the conflicts, mark the corrected paths\n"
+					    "with 'git add <paths>' or 'git rm <paths>'"));
 		else if (opts->action == REPLAY_PICK)
-			advise(_("After resolving the conflicts, mark them with\n"
-				 "\"git add/rm <pathspec>\", then run\n"
-				 "\"git cherry-pick --continue\".\n"
-				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
-				 "To abort and get back to the state before \"git cherry-pick\",\n"
-				 "run \"git cherry-pick --abort\"."));
+			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
+					  _("After resolving the conflicts, mark them with\n"
+					    "\"git add/rm <pathspec>\", then run\n"
+					    "\"git cherry-pick --continue\".\n"
+					    "You can instead skip this commit with \"git cherry-pick --skip\".\n"
+					    "To abort and get back to the state before \"git cherry-pick\",\n"
+					    "run \"git cherry-pick --abort\"."));
 		else if (opts->action == REPLAY_REVERT)
-			advise(_("After resolving the conflicts, mark them with\n"
-				 "\"git add/rm <pathspec>\", then run\n"
-				 "\"git revert --continue\".\n"
-				 "You can instead skip this commit with \"git revert --skip\".\n"
-				 "To abort and get back to the state before \"git revert\",\n"
-				 "run \"git revert --abort\"."));
+			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
+					  _("After resolving the conflicts, mark them with\n"
+					    "\"git add/rm <pathspec>\", then run\n"
+					    "\"git revert --continue\".\n"
+					    "You can instead skip this commit with \"git revert --skip\".\n"
+					    "To abort and get back to the state before \"git revert\",\n"
+					    "run \"git revert --abort\"."));
 		else
 			BUG("unexpected pick action in print_advice()");
 	}
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index aeab689a98d..bc7c878b236 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -170,6 +170,7 @@ test_expect_success 'advice from failed revert' '
 	hint: You can instead skip this commit with "git revert --skip".
 	hint: To abort and get back to the state before "git revert",
 	hint: run "git revert --abort".
+	hint: Disable this message with "git config advice.sequencerConflict false"
 	EOF
 	test_commit --append --no-tag "double-add dream" dream dream &&
 	test_must_fail git revert HEAD^ 2>actual &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index c88d597b126..a643893dcbd 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -60,6 +60,7 @@ test_expect_success 'advice from failed cherry-pick' '
 	hint: You can instead skip this commit with "git cherry-pick --skip".
 	hint: To abort and get back to the state before "git cherry-pick",
 	hint: run "git cherry-pick --abort".
+	hint: Disable this message with "git config advice.sequencerConflict false"
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
@@ -74,6 +75,7 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	error: could not apply \$picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
 	hint: with 'git add <paths>' or 'git rm <paths>'
+	hint: Disable this message with \"git config advice.sequencerConflict false\"
 	EOF
 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
 

base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
-- 
gitgitgadget
