Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D21C698
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710623798; cv=none; b=dZsBDQmBg1KkIF4fjN7+rX9RaCceAzCOewZrQRKpgXCFdTf5FrgZ2HMsYk9F7JT6W8tktNvcJaYOnWf05yt4jmSsCLseqO8J//TvSyVzN2eaDr+gmLBVV56K3jI+9Y2K9MwpqJ29vutPMJADTKzz0jcBkHeHYjNj/3SNjaGUY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710623798; c=relaxed/simple;
	bh=CLKO3JGeiyGMLOjDWDAxugm6fgT8LDBW4yQbgpgiNmE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k4zYsb7q07VyPb1nzWBOMi1cYQzuer55+czG1I0d/HxiCaIbf3BRIt2OUe2STL3hSG2VtxSPmbPqmCYt/dg92jd7C4NfT0+AYodnuI+S7oz89Geyrp71bpJdV9P9McXgc7ljf9tzvQ5REIkRneoP10GeBD738XR2TtHfLDZLI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcTEO7cW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcTEO7cW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41403889b6aso11030975e9.2
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710623793; x=1711228593; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cppMABQQaa5ObMBv5R/QetRWa3AUy1RI33wqQABBSVk=;
        b=AcTEO7cW4uz1c/Oi1u7TNLuNIZVXrwO2hI1coo3jMlWENptzh3+mcfWIygutMUKWx4
         VkbG401bwK6RKHLI2OLFT4XgO/biCI+TlRcdsJrZhmJbVxGLYpQe95Xy/vC7VPHB8Qd9
         pR37HRZeW1NSeoUzy5pZ2hObvI6bUVjR+HLsm11IJt2EoocDLV2BJB0AfyPC2648a/ck
         7tqzXyMLwmpTwWAFFUURSJuZOXdakrk1uSR8P0Xg74dLCMhKx6DmMI2zPiszoU/sOIP+
         tFS2CbW6WuN+Wcvd3cwuFSBQdKtKFqwz1p1sXOShxHm7+txiLt8djMDO8hqPJSCfHY/p
         R+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710623793; x=1711228593;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cppMABQQaa5ObMBv5R/QetRWa3AUy1RI33wqQABBSVk=;
        b=tN71VxEOawndWgqjhMGkAjGqyJDw1VxftSnjHApyl9Xni+DoHZAF54ULW7fu6qG70j
         fgy9xB4AFniVhUTAEPR0X/BjvKb1q24FHQYyd4YbPdZrPrIWRySLCnJ6YFSS09/C62EY
         ntplaxKzO+Q5hjsxgHV445W6p8S9ZtjJ7yYt9kpIbg9NXeD4Z6FzSDAPsqD9XkjL3JpC
         2dJyUd0GImXLvbbUnJXOMZZhA1rJDjYJ6Eoo/Wd/054hD9IH9cJUJaib3f7m7OU6JE2P
         8Mjr1faZ9Rt5y3fnr+FYfHUG0fIeX+ulYr41l3lj14T95L/z3iWOT4piznE2gYvxi38c
         6Tbg==
X-Gm-Message-State: AOJu0YyiXdZmIMUM+3OFz7NTC7xzgJTrOoCQi/9PQHOZF50O3SUtteyS
	ZTvq16tGFNtGsqoj0C4p3yfCLWlnWcaxQ8Xm151fkvLOi9dt3FCCIe6VMojd
X-Google-Smtp-Source: AGHT+IHOQNR/EwEBso/H6MEfpAKzvheys1ozow7pSnbI0TyqREa3cLon5+RzqFoK1SusNBXN3jzSRA==
X-Received: by 2002:a05:600c:35d4:b0:413:2308:7d94 with SMTP id r20-20020a05600c35d400b0041323087d94mr7011982wmq.20.1710623793319;
        Sat, 16 Mar 2024 14:16:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d410f000000b0033cf4e47496sm6089333wrp.51.2024.03.16.14.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 14:16:32 -0700 (PDT)
Message-ID: <6005c1e98905c7a97d061a0034a5461052947f5a.1710623790.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>
References: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
	<pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 21:16:29 +0000
Subject: [PATCH v3 1/2] sequencer: allow disabling conflict advice
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    ZheNing Hu <adlternative@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Allow disabling the advice shown when a squencer operation results in a
merge conflict through a new config 'advice.mergeConflict', which is
named generically such that it can be used by other commands eventually.

Remove that final '\n' in the first hunk in sequencer.c to avoid an
otherwise empty 'hint: ' line before the line 'hint: Disable this
message with "git config advice.mergeConflict false"' which is
automatically added by 'advise_if_enabled'.

Note that we use 'advise_if_enabled' for each message in the second hunk
in sequencer.c, instead of using 'if (show_hints &&
advice_enabled(...)', because the former instructs the user how to
disable the advice, which is more user-friendly.

Update the tests accordingly. Note that the body of the second test in
t3507-cherry-pick-conflict.sh is enclosed in double quotes, so we must
escape them in the added line. Note that t5520-pull.sh, which checks
that we display the advice for 'git rebase' (via 'git pull --rebase')
does not have to be updated because it only greps for a specific line in
the advice message.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/config/advice.txt |  2 ++
 advice.c                        |  1 +
 advice.h                        |  1 +
 sequencer.c                     | 33 ++++++++++++++++++---------------
 t/t3501-revert-cherry-pick.sh   |  1 +
 t/t3507-cherry-pick-conflict.sh |  2 ++
 6 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index f8334116536..0e35ae5240f 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -56,6 +56,8 @@ advice.*::
 		Shown when the user's information is guessed from the
 		system username and domain name, to tell the user how to
 		set their identity configuration.
+	mergeConflict::
+		Shown when various commands stop because of conflicts.
 	nestedTag::
 		Shown when a user attempts to recursively tag a tag object.
 	pushAlreadyExists::
diff --git a/advice.c b/advice.c
index b0e05506871..d19648b7f88 100644
--- a/advice.c
+++ b/advice.c
@@ -57,6 +57,7 @@ static struct {
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
+	[ADVICE_MERGE_CONFLICT]				= { "mergeConflict" },
 	[ADVICE_NESTED_TAG]				= { "nestedTag" },
 	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning" },
 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists" },
diff --git a/advice.h b/advice.h
index bf630ee3ac3..c8d29f97f39 100644
--- a/advice.h
+++ b/advice.h
@@ -25,6 +25,7 @@ enum advice_type {
 	ADVICE_GRAFT_FILE_DEPRECATED,
 	ADVICE_IGNORED_HOOK,
 	ADVICE_IMPLICIT_IDENTITY,
+	ADVICE_MERGE_CONFLICT,
 	ADVICE_NESTED_TAG,
 	ADVICE_OBJECT_NAME_WARNING,
 	ADVICE_PUSH_ALREADY_EXISTS,
diff --git a/sequencer.c b/sequencer.c
index ea1441e6174..019f0a0b27a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -467,7 +467,7 @@ static void print_advice(struct repository *r, int show_hint,
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
 	if (msg) {
-		advise("%s\n", msg);
+		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", msg);
 		/*
 		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
@@ -480,22 +480,25 @@ static void print_advice(struct repository *r, int show_hint,
 
 	if (show_hint) {
 		if (opts->no_commit)
-			advise(_("after resolving the conflicts, mark the corrected paths\n"
-				 "with 'git add <paths>' or 'git rm <paths>'"));
+			advise_if_enabled(ADVICE_MERGE_CONFLICT,
+					  _("after resolving the conflicts, mark the corrected paths\n"
+					    "with 'git add <paths>' or 'git rm <paths>'"));
 		else if (opts->action == REPLAY_PICK)
-			advise(_("After resolving the conflicts, mark them with\n"
-				 "\"git add/rm <pathspec>\", then run\n"
-				 "\"git cherry-pick --continue\".\n"
-				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
-				 "To abort and get back to the state before \"git cherry-pick\",\n"
-				 "run \"git cherry-pick --abort\"."));
+			advise_if_enabled(ADVICE_MERGE_CONFLICT,
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
+			advise_if_enabled(ADVICE_MERGE_CONFLICT,
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
index aeab689a98d..43c579ea53a 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -170,6 +170,7 @@ test_expect_success 'advice from failed revert' '
 	hint: You can instead skip this commit with "git revert --skip".
 	hint: To abort and get back to the state before "git revert",
 	hint: run "git revert --abort".
+	hint: Disable this message with "git config advice.mergeConflict false"
 	EOF
 	test_commit --append --no-tag "double-add dream" dream dream &&
 	test_must_fail git revert HEAD^ 2>actual &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index c88d597b126..f3947b400a3 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -60,6 +60,7 @@ test_expect_success 'advice from failed cherry-pick' '
 	hint: You can instead skip this commit with "git cherry-pick --skip".
 	hint: To abort and get back to the state before "git cherry-pick",
 	hint: run "git cherry-pick --abort".
+	hint: Disable this message with "git config advice.mergeConflict false"
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
@@ -74,6 +75,7 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	error: could not apply \$picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
 	hint: with 'git add <paths>' or 'git rm <paths>'
+	hint: Disable this message with \"git config advice.mergeConflict false\"
 	EOF
 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
 
-- 
gitgitgadget

